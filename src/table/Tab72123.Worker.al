table 72123 "Worker"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Worker No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
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
            ExtendedDatatype = Email;

        }

        field(5; "Phone No."; Text[30])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }

        field(6; "Position Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Position Lookup";
        }

        field(7; "Employment Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(8; "Termination Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(9; "Employed Status"; Option)
        {
            OptionMembers = Pending,Hired,Exiting,Terminated;
            DataClassification = CustomerContent;
        }
        field(10; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "Worker No.")
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
        Worker: Record Worker;
    begin
        HumanResourcesSetup.Get();
        HumanResourcesSetup.TestField("Worker Nos");
        NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(HumanResourcesSetup."Worker Nos", xRec."No. Series", 0D, Rec."Worker No.", Rec."No. Series", IsHandled);
        //  if not IsHandled then begin
        if NoSeries.AreRelated(HumanResourcesSetup."Worker Nos", xRec."No. Series") then
            Rec."No. Series" := xRec."No. Series"
        else
            Rec."No. Series" := HumanResourcesSetup."Worker Nos";

        Rec."Worker No." := NoSeries.GetNextNo(Rec."No. Series");
        Worker.ReadIsolation(IsolationLevel::ReadUncommitted);
        Worker.SetLoadFields("Worker No.");
        while Worker.Get(Rec."Worker No.") do
            Rec."Worker No." := NoSeries.GetNextNo(Rec."No. Series");
        NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(Rec."No. Series", HumanResourcesSetup."Worker Nos", 0D, Rec."Worker No.");

        UpdateEmployedStatus();
    end;




    trigger OnModify()
    begin
        UpdateEmployedStatus();
    end;

    local procedure UpdateEmployedStatus()
    begin
        if "Termination Date" <> 0D then begin
            if "Termination Date" < Today then
                "Employed Status" := "Employed Status"::Terminated
            else
                "Employed Status" := "Employed Status"::Exiting;
        end else begin
            if "Employment Date" > Today then
                "Employed Status" := "Employed Status"::Pending
            else
                "Employed Status" := "Employed Status"::Hired;
        end;
    end;
}
