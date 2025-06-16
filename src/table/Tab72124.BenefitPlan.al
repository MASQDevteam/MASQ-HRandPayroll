table 72124 "Benefit Plan"
{
    DataClassification = CustomerContent;
    LookupPageId = "Benefit Plans";
    DrillDownPageId = "Benefit Plans";

    fields
    {
        field(1; "Plan No."; Code[20])
        {

            Editable = false;

        }

        field(2; "Plan Type"; Code[50])
        {

            TableRelation = "Data Lookup".Code where(Type = filter("Plan Type"));
            ValidateTableRelation = false;
        }

        field(3; "Coverage Code"; Code[50])
        {

            TableRelation = "Data Lookup".Code where(Type = filter("Coverage Type"));
            ValidateTableRelation = false;
        }

        field(4; "Employee Amount"; Decimal)
        {

        }

        field(5; "Coverage Amount"; Decimal)
        {

        }
        field(6; "No. Series"; Code[20])
        {

            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; "Plan No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Plan No.", "Plan Type", "Coverage Code", "Coverage Amount", "Employee Amount")
        {

        }
        fieldgroup(Brick; "Plan No.", "Plan Type", "Coverage Code", "Coverage Amount", "Employee Amount")
        {
        }
    }

    trigger OnInsert()
    var
        NoSeries: Codeunit "No. Series";
        NoSeriesCode: Code[20];
        IsHandled: Boolean;
        HumanResourcesSetup: Record "Human Resources Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        BenefitPlan: Record "Benefit Plan";
    begin
        HumanResourcesSetup.Get();
        HumanResourcesSetup.TestField("Benefits Plan");
        NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(HumanResourcesSetup."Benefits Plan", xRec."No. Series", 0D, Rec."Plan No.", Rec."No. Series", IsHandled);
        //  if not IsHandled then begin
        if NoSeries.AreRelated(HumanResourcesSetup."Benefits Plan", xRec."No. Series") then
            Rec."No. Series" := xRec."No. Series"
        else
            Rec."No. Series" := HumanResourcesSetup."Benefits Plan";

        Rec."Plan No." := NoSeries.GetNextNo(Rec."No. Series");
        BenefitPlan.ReadIsolation(IsolationLevel::ReadUncommitted);
        BenefitPlan.SetLoadFields("Plan No.");
        while BenefitPlan.Get(Rec."Plan No.") do
            Rec."Plan No." := NoSeries.GetNextNo(Rec."No. Series");
        NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(Rec."No. Series", HumanResourcesSetup."Benefits Plan", 0D, Rec."Plan No.");
    end;
}
