table 72112 "Open Position"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Open Positions-Ext Reports";
    fields
    {
        field(1; "Position ID"; Code[20]) { Editable = false; }
        field(2; "Title"; Text[100]) { }
        field(3; "Department"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DEPARTMENT'));
            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
            begin
                if Department <> '' then begin
                    DimensionValue.SetRange(Code, Rec.Department);
                    if DimensionValue.FindFirst() then begin
                        "Department Name" := DimensionValue.Name;
                    end;
                end
                else
                    "Department Name" := '';
            end;
        }
        field(4; "Reports To"; Code[20])
        {
            TableRelation = Employee;
        }
        field(5; "Is Open"; Boolean) { }
        field(6; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(7; "Department Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Position ID") { Clustered = true; }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Position ID", Title, "Department Name", "Reports To") { }
    }
    trigger OnInsert()
    var
        NoSeries: Codeunit "No. Series";
        NoSeriesCode: Code[20];
        IsHandled: Boolean;
        HumanResourcesSetup: Record "Human Resources Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        OpenPosition: Record "Open Position";
    begin
        HumanResourcesSetup.Get();
        HumanResourcesSetup.TestField("Open Position Nos");
        NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(HumanResourcesSetup."Open Position Nos", xRec."No. Series", 0D, Rec."Position ID", Rec."No. Series", IsHandled);
        //  if not IsHandled then begin
        if NoSeries.AreRelated(HumanResourcesSetup."Open Position Nos", xRec."No. Series") then
            Rec."No. Series" := xRec."No. Series"
        else
            Rec."No. Series" := HumanResourcesSetup."Open Position Nos";

        Rec."Position ID" := NoSeries.GetNextNo(Rec."No. Series");
        OpenPosition.ReadIsolation(IsolationLevel::ReadUncommitted);
        OpenPosition.SetLoadFields("Position ID");
        while OpenPosition.Get(Rec."Position ID") do
            Rec."Position ID" := NoSeries.GetNextNo(Rec."No. Series");
        NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(Rec."No. Series", HumanResourcesSetup."Open Position Nos", 0D, Rec."Position ID");
    end;
}
