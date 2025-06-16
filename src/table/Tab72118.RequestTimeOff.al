table 72118 "Request Time Off"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Request Time Off Code"; Code[20])
        {
            DataClassification = SystemMetadata;
            Editable = false;
        }

        field(2; "Employee No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Employee."No.";
            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if Employee.Get("Employee No.") then begin
                    if Rec."Employee No." <> '' then
                        Rec.Validate("Employee Name", Employee."First Name");
                end
                else
                    Rec.Validate("Employee Name", '');
            end;
        }

        field(3; "Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(4; "Start Time"; Time)
        {
            DataClassification = CustomerContent;
        }

        field(5; "End Time"; Time)
        {
            DataClassification = CustomerContent;
        }

        field(6; "Reason"; Text[100])
        {
            DataClassification = CustomerContent;
            TableRelation = "Type Lookup".Code where("Leave Request Type" = filter("Leave Request Type"::"Reason Code"));
        }

        field(7; Status; Option)
        {
            OptionMembers = Pending,Approved,Rejected,Cancelled;
            OptionCaption = 'Pending,Approved,Rejected,Cancelled';
            DataClassification = CustomerContent;
        }

        field(8; "Request Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(9; "Created By"; Code[50])
        {
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(10; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Employee Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

    }

    keys
    {
        key(PK; "Request Time Off Code") { Clustered = true; }
    }

    trigger OnInsert()
    var
        NoSeries: Codeunit "No. Series";
        NoSeriesCode: Code[20];
        IsHandled: Boolean;
        HumanResourcesSetup: Record "Human Resources Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        RequestTimeOff: Record "Request Time Off";
    begin
        HumanResourcesSetup.Get();
        HumanResourcesSetup.TestField("Request Time Off Nos");
        NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(HumanResourcesSetup."Request Time Off Nos", xRec."No. Series", 0D, Rec."Request Time Off Code", Rec."No. Series", IsHandled);
        if NoSeries.AreRelated(HumanResourcesSetup."Request Time Off Nos", xRec."No. Series") then
            Rec."No. Series" := xRec."No. Series"
        else
            Rec."No. Series" := HumanResourcesSetup."Request Time Off Nos";

        Rec."Request Time Off Code" := NoSeries.GetNextNo(Rec."No. Series");
        RequestTimeOff.ReadIsolation(IsolationLevel::ReadUncommitted);
        RequestTimeOff.SetLoadFields("Request Time Off Code");
        while RequestTimeOff.Get(Rec."Request Time Off Code") do
            Rec."Request Time Off Code" := NoSeries.GetNextNo(Rec."No. Series");
        NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(Rec."No. Series", HumanResourcesSetup."Request Time Off Nos", 0D, Rec."Request Time Off Code");

        "Created By" := UserId;
        Status := Status::Pending;
    end;



}
