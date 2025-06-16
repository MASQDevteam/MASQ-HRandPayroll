table 72114 "Compensation Structure"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Compensation Structure";
    fields
    {
        field(1; "Compensation Code"; Code[20]) { Editable = false; }
        field(2; "Title"; Text[100]) { }
        field(3; "Job Grade"; Code[20]) { TableRelation = "Grades Lookup"; }
        field(4; "Min Salary"; Decimal) { }
        field(5; "Max Salary"; Decimal) { }
        field(6; "Currency Code"; Code[10])
        {
            TableRelation = Currency."Code";
        }
        field(7; "Active"; Boolean)
        {
            trigger OnValidate()
            var
                CompensationStructure: Record "Compensation Structure";
            begin
                if Rec.Active = true then begin
                    CompensationStructure.SetRange("Job Grade", Rec."Job Grade");
                    CompensationStructure.SetRange("Compensation Type", Rec."Compensation Type");
                    CompensationStructure.SetRange(Active, true);
                    if CompensationStructure.FindFirst() then
                        repeat
                            Error('Can''t activate same grades, please remove activation from another grade first!');
                        until CompensationStructure.Next() = 0;
                end;
            end;
        }
        field(8; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Compensation Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Fixed","Variable";
        }
        field(10; "No. of Employees"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Employee where("Compensation Code" = field("Compensation Code")));
        }
    }

    keys
    {
        key(PK; "Compensation Code") { Clustered = true; }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Compensation Code", Title, "Job Grade", "No. of Employees", "Compensation Type") { }
        fieldgroup(Brick; "Compensation Code", Title, "Job Grade", "No. of Employees", "Compensation Type") { }
    }
    trigger OnInsert()
    var
        NoSeries: Codeunit "No. Series";
        NoSeriesCode: Code[20];
        IsHandled: Boolean;
        HumanResourcesSetup: Record "Human Resources Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        CompensationStructure: Record "Compensation Structure";
    begin
        HumanResourcesSetup.Get();
        HumanResourcesSetup.TestField("Compensation Nos");
        NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(HumanResourcesSetup."Compensation Nos", xRec."No. Series", 0D, Rec."Compensation Code", Rec."No. Series", IsHandled);
        //  if not IsHandled then begin
        if NoSeries.AreRelated(HumanResourcesSetup."Compensation Nos", xRec."No. Series") then
            Rec."No. Series" := xRec."No. Series"
        else
            Rec."No. Series" := HumanResourcesSetup."Compensation Nos";

        Rec."Compensation Code" := NoSeries.GetNextNo(Rec."No. Series");
        CompensationStructure.ReadIsolation(IsolationLevel::ReadUncommitted);
        CompensationStructure.SetLoadFields("Compensation Code");
        while CompensationStructure.Get(Rec."Compensation Code") do
            Rec."Compensation Code" := NoSeries.GetNextNo(Rec."No. Series");
        NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(Rec."No. Series", HumanResourcesSetup."Compensation Nos", 0D, Rec."Compensation Code");
    end;
}
