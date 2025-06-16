table 72129 Application
{
    Caption = 'Application';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Application No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(2; "Applicant No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Applicant No.';
            TableRelation = "Applicants"."Applicant No.";
            trigger OnValidate()
            var
                Applicants: Record Applicants;
            begin
                if Applicants.Get(Rec."Applicant No.") then begin
                    if Rec."Applicant No." <> '' then
                        Rec."Applicant Name" := Applicants."First Name" + ' ' + Applicants."Last Name";
                end
                else
                    Rec."Applicant Name" := '';
            end;

        }

        field(3; "Position Applied For"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Position Lookup";
        }

        field(4; "Application Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(5; "Status"; Option)
        {
            OptionMembers = Started,Applied,Posted,Closed;
            DataClassification = CustomerContent;
        }

        field(6; "Applicant Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Deadline Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(8; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "Application No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        NoSeries: Codeunit "No. Series";
        NoSeriesCode: Code[20];
        IsHandled: Boolean;
        HumanResourcesSetup: Record "Human Resources Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        Application: Record Application;
    begin
        HumanResourcesSetup.Get();
        HumanResourcesSetup.TestField("Application Nos");
        NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(HumanResourcesSetup."Application Nos", xRec."No. Series", 0D, Rec."Application No.", Rec."No. Series", IsHandled);
        //  if not IsHandled then begin
        if NoSeries.AreRelated(HumanResourcesSetup."Application Nos", xRec."No. Series") then
            Rec."No. Series" := xRec."No. Series"
        else
            Rec."No. Series" := HumanResourcesSetup."Application Nos";

        Rec."Application No." := NoSeries.GetNextNo(Rec."No. Series");
        Application.ReadIsolation(IsolationLevel::ReadUncommitted);
        Application.SetLoadFields("Application No.");
        while Application.Get(Rec."Application No.") do
            Rec."Application No." := NoSeries.GetNextNo(Rec."No. Series");
        NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(Rec."No. Series", HumanResourcesSetup."Application Nos", 0D, Rec."Application No.");
    end;
}