table 72111 IDCardTracking
{
    DataClassification = ToBeClassified;
    Caption = 'ID Card Tracking';

    fields
    {
        field(1; "Code"; Code[20])
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
        field(3; "Employee Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; "ID Type"; Code[20])
        {
            TableRelation = "Data Lookup".Code where(Type = filter("ID Cards"));
            DataClassification = CustomerContent;
        }
        field(5; "Expiry Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(6; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(8; "ID Status"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; Code) { Clustered = true; }
    }
    trigger OnInsert()
    var


        NoSeries: Codeunit "No. Series";
        NoSeriesCode: Code[20];
        IsHandled: Boolean;
        HumanResourcesSetup: Record "Human Resources Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        AssignedWorkItems: Record "Assigned Work Items";
    begin
        //    if "Number" = '' then begin
        HumanResourcesSetup.Get();
        HumanResourcesSetup.TestField("ID Cards Expiring");
        NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(HumanResourcesSetup."ID Cards Expiring", xRec."No. Series", 0D, Rec.Code, Rec."No. Series", IsHandled);
        //  if not IsHandled then begin
        if NoSeries.AreRelated(HumanResourcesSetup."ID Cards Expiring", xRec."No. Series") then
            Rec."No. Series" := xRec."No. Series"
        else
            Rec."No. Series" := HumanResourcesSetup."ID Cards Expiring";

        Rec.Code := NoSeries.GetNextNo(Rec."No. Series");
        AssignedWorkItems.ReadIsolation(IsolationLevel::ReadUncommitted);
        AssignedWorkItems.SetLoadFields(Code);
        while AssignedWorkItems.Get(Rec.Code) do
            Rec.Code := NoSeries.GetNextNo(Rec."No. Series");
        NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(Rec."No. Series", HumanResourcesSetup."ID Cards Expiring", 0D, Rec.Code);
        //   end;
        //  end;
    end;



}
