table 72100 "MASQ Activities Cue"
{
    Caption = 'MASQ Activities Cue';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Expiring Certificates"; Integer)
        {
            Caption = 'Certficates expiring for my team';
            FieldClass = FlowField;
            CalcFormula = Count("Team LookUp" WHERE("Team Type" = FILTER("Expiring Certificates")));
        }
        field(3; "Team skills assessment"; Integer)
        {
            Caption = 'Team skills assessment';
            FieldClass = FlowField;
            CalcFormula = Count("Team LookUp" WHERE("Team Type" = FILTER("Team Skills Assessment")));
        }
        field(4; "Team performance journal"; Integer)
        {
            Caption = 'Team performance journal';
            FieldClass = FlowField;
            CalcFormula = Count("Team LookUp" WHERE("Team Type" = FILTER("Team Performance Journal")));
        }
        field(5; "Skill gap analysis"; Integer)
        {
            Caption = 'Skill gap analysis';
            FieldClass = FlowField;
            CalcFormula = Count("Team LookUp" WHERE("Team Type" = FILTER("Skill gap analysis")));
        }
        field(6; "Team performance goals"; Integer)
        {
            Caption = 'Team performance goals';
            FieldClass = FlowField;
            CalcFormula = Count("Team LookUp" WHERE("Team Type" = FILTER("Team performance goals")));
        }
        field(7; "Team performance review"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Team LookUp" WHERE("Team Type" = FILTER("Team performance reviews")));
        }
        field(8; "Open Positions-Ext Reports"; Integer)
        {
            Caption = 'Open Positions - Extended Reports';
            FieldClass = FlowField;
            CalcFormula = count("Open Position" where("Is Open" = filter(true)));
        }
        field(10; "Open Positions-Direct Reports"; Integer)
        {
            Caption = 'Open Positions - Direct Reports';
        }
        field(11; "Birthdays"; Integer)
        {
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
