table 72117 "Compensation Management Cue"
{
    Caption = 'Compensation Management Cue';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }

        field(3; "Fixed Compensation Plans"; Integer)
        {
            Caption = 'Fixed Compensation Plans';
            FieldClass = FlowField;
            CalcFormula = count("Compensation Structure" where("Compensation Type" = filter(Fixed)));
        }
        field(4; "Variable Compensation Plans"; Integer)
        {
            Caption = 'Variable Compensation Plans';
            FieldClass = FlowField;
            CalcFormula = count("Compensation Structure" where("Compensation Type" = filter(Variable)));
        }
        field(5; "Employees without fixed comp"; Integer)
        {
            Caption = 'Employees without fixed compensation';
            FieldClass = FlowField;
            CalcFormula = count(Employee where("Compensation Type" = filter(Variable)));
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
