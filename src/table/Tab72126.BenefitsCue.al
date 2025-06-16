table 72126 "Benefits Cue"
{
    Caption = 'Benefits Cue';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Dental"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Benefit Cart" WHERE("Plan Type" = const('DENTAL')));
        }
        field(3; "FSA"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Benefit Cart" WHERE("Plan Type" = const('FSA')));
        }
        field(4; "Life"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Benefit Cart" WHERE("Plan Type" = const('LIFE')));
        }
        field(5; "Medical"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Benefit Cart" WHERE("Plan Type" = const('MEDICAL')));
        }
        field(6; "Savings"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Benefit Cart" WHERE("Plan Type" = const('SAVINGS')));
        }
        field(7; "Vision"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Benefit Cart" WHERE("Plan Type" = const('VISION')));
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
