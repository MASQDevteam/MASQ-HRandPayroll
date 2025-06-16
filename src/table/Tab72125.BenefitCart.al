table 72125 "Benefit Cart"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = SystemMetadata;
            Editable = false;
        }

        field(2; "Plan"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Benefit Plan";
            // ValidateTableRelation = false;

        }

        field(3; "Coverage Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Data Lookup".Code where(Type = filter("Coverage Type"));
            ValidateTableRelation = false;
        }

        field(4; "Coverage Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Employee Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Status"; Option)
        {
            OptionMembers = Selected,Removed;
            DataClassification = ToBeClassified;
        }
        field(7; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(8; "Attachment ID"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Document Attachment ID"; Integer)
        {

        }
        field(10; "Document Attachment Table ID"; Integer)
        {

        }
        field(11; "Document Attachment No."; Code[20])
        {

        }
        field(12; "Document Attachment Doc. Type"; Enum "Attachment Document Type")
        {

        }
        field(13; "Document Attachment Line No."; Integer)
        {
        }
        field(14; "Plan Type"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Benefit Plan"."Plan Type" where("Plan No." = field(Plan)));
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
        BenefitCart: Record "Benefit Cart";
    begin
        HumanResourcesSetup.Get();
        HumanResourcesSetup.TestField("Benefits Cart");
        NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(HumanResourcesSetup."Benefits Cart", xRec."No. Series", 0D, Rec."Code", Rec."No. Series", IsHandled);
        //  if not IsHandled then begin
        if NoSeries.AreRelated(HumanResourcesSetup."Benefits Cart", xRec."No. Series") then
            Rec."No. Series" := xRec."No. Series"
        else
            Rec."No. Series" := HumanResourcesSetup."Benefits Cart";

        Rec."Code" := NoSeries.GetNextNo(Rec."No. Series");
        BenefitCart.ReadIsolation(IsolationLevel::ReadUncommitted);
        BenefitCart.SetLoadFields("Code");
        while BenefitCart.Get(Rec."Code") do
            Rec."Code" := NoSeries.GetNextNo(Rec."No. Series");
        NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(Rec."No. Series", HumanResourcesSetup."Benefits Cart", 0D, Rec."Code");
    end;
}
