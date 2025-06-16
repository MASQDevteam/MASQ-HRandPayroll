table 72110 "Assigned Work Items"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Task Type"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Team LookUp"."Task Description" where("Team Type" = filter(Tasks), "Employee ID" = field("Employee No."));
            ValidateTableRelation = false;
        }
        field(3; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
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

        field(5; "Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Task Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Status"; Option)
        {
            OptionMembers = Pending,InProgress,Completed,Cancelled;
            DataClassification = ToBeClassified;
        }
        field(9; "Priority"; Option)
        {
            OptionMembers = Low,Medium,High,Critical;
            DataClassification = ToBeClassified;
        }
        field(10; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(11; "Start Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "End Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Code")
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
        AssignedWorkItems: Record "Assigned Work Items";
    begin
        //    if "Number" = '' then begin
        HumanResourcesSetup.Get();
        HumanResourcesSetup.TestField("Assigned Work No. Series");
        NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(HumanResourcesSetup."Assigned Work No. Series", xRec."No. Series", 0D, Rec.Code, Rec."No. Series", IsHandled);
        //  if not IsHandled then begin
        if NoSeries.AreRelated(HumanResourcesSetup."Assigned Work No. Series", xRec."No. Series") then
            Rec."No. Series" := xRec."No. Series"
        else
            Rec."No. Series" := HumanResourcesSetup."Assigned Work No. Series";

        Rec.Code := NoSeries.GetNextNo(Rec."No. Series");
        AssignedWorkItems.ReadIsolation(IsolationLevel::ReadUncommitted);
        AssignedWorkItems.SetLoadFields(Code);
        while AssignedWorkItems.Get(Rec.Code) do
            Rec.Code := NoSeries.GetNextNo(Rec."No. Series");
        NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(Rec."No. Series", HumanResourcesSetup."Assigned Work No. Series", 0D, Rec.Code);
        //   end;
        //  end;
    end;
}