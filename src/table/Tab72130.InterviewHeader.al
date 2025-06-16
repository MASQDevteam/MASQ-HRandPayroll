table 72130 "Interview Header"
{
    Caption = 'Interview Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Interview No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(2; "Candidate Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }

        field(3; "Position Applied"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Position Lookup".Code;
        }

        field(4; "Interview Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(5; "Interviewer"; Code[250])
        {
            DataClassification = CustomerContent;
            TableRelation = Employee."Search Name";
            ValidateTableRelation = false;
        }

        field(6; "Interview Status"; Option)
        {
            OptionMembers = Scheduled,Completed,Cancelled,Rescheduled;
            DataClassification = CustomerContent;
        }

        field(7; "Comments"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(8; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(9; "Attachment ID"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Document Attachment ID"; Integer)
        {

        }
        field(11; "Document Attachment Table ID"; Integer)
        {

        }
        field(12; "Document Attachment No."; Code[20])
        {

        }
        field(13; "Document Attachment Doc. Type"; Enum "Attachment Document Type")
        {

        }
        field(14; "Document Attachment Line No."; Integer)
        {
        }
    }

    keys
    {
        key(PK; "Interview No.") { Clustered = true; }
    }
    trigger OnInsert()
    var
        NoSeries: Codeunit "No. Series";
        NoSeriesCode: Code[20];
        IsHandled: Boolean;
        HumanResourcesSetup: Record "Human Resources Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        InterviewHeader: Record "Interview Header";
    begin
        HumanResourcesSetup.Get();
        HumanResourcesSetup.TestField("Interview Nos");
        NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(HumanResourcesSetup."Interview Nos", xRec."No. Series", 0D, Rec."Interview No.", Rec."No. Series", IsHandled);
        //  if not IsHandled then begin
        if NoSeries.AreRelated(HumanResourcesSetup."Interview Nos", xRec."No. Series") then
            Rec."No. Series" := xRec."No. Series"
        else
            Rec."No. Series" := HumanResourcesSetup."Interview Nos";

        Rec."Interview No." := NoSeries.GetNextNo(Rec."No. Series");
        InterviewHeader.ReadIsolation(IsolationLevel::ReadUncommitted);
        InterviewHeader.SetLoadFields("Interview No.");
        while InterviewHeader.Get(Rec."Interview No.") do
            Rec."Interview No." := NoSeries.GetNextNo(Rec."No. Series");
        NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(Rec."No. Series", HumanResourcesSetup."Interview Nos", 0D, Rec."Interview No.");
    end;
}
