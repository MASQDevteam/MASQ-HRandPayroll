table 72107 "My Info Cue"
{
    Caption = 'My Information';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Questionnaires"; Integer)
        {
            Caption = 'Questionnaires';
        }
        field(4; Courses; integer)
        {
        }
        field(5; "Work items assigned to me"; Integer)
        {
        }

        field(7; "Team Absence Calendar"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Leave Request Header" where(Status = filter(Approved)));
        }
        field(8; "Open Jobs"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Open Job" where("Is Active" = filter(true)));
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
