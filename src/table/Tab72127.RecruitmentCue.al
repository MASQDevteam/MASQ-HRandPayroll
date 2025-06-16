table 72127 "Recruitment Cue"
{
    Caption = 'Recruitment Cue';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Application Deadline appr"; Integer)
        {
            Caption = 'Application Deadline approaching';
        }
        field(3; "Application Inbox"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Application WHERE(Status = const(Applied)));
        }
        field(4; "All Applicants"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Applicants);
        }
        field(5; "All Applications"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Application);
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
