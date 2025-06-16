table 72128 Applicants
{
    Caption = 'Applicants';
    LookupPageId = Applicants;
    fields
    {
        field(1; "Applicant No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(2; "First Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Last Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Email"; Text[100])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }

        field(5; "Phone No."; Text[30])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }

        field(6; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "No. of Applications"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Application where("Applicant No." = field("Applicant No.")));
        }
    }

    keys
    {
        key(PK; "Applicant No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Applicant No.", "First Name", "Last Name", "Phone No.", Email) { }
    }
    trigger OnInsert()
    var
        NoSeries: Codeunit "No. Series";
        NoSeriesCode: Code[20];
        IsHandled: Boolean;
        HumanResourcesSetup: Record "Human Resources Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        Applicants: Record Applicants;
    begin
        HumanResourcesSetup.Get();
        HumanResourcesSetup.TestField("Applicants Nos");
        NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(HumanResourcesSetup."Applicants Nos", xRec."No. Series", 0D, Rec."Applicant No.", Rec."No. Series", IsHandled);
        //  if not IsHandled then begin
        if NoSeries.AreRelated(HumanResourcesSetup."Applicants Nos", xRec."No. Series") then
            Rec."No. Series" := xRec."No. Series"
        else
            Rec."No. Series" := HumanResourcesSetup."Applicants Nos";

        Rec."Applicant No." := NoSeries.GetNextNo(Rec."No. Series");
        Applicants.ReadIsolation(IsolationLevel::ReadUncommitted);
        Applicants.SetLoadFields("Applicant No.");
        while Applicants.Get(Rec."Applicant No.") do
            Rec."Applicant No." := NoSeries.GetNextNo(Rec."No. Series");
        NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(Rec."No. Series", HumanResourcesSetup."Applicants Nos", 0D, Rec."Applicant No.");
    end;
}
