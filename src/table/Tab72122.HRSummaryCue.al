table 72122 "HR Summary Cue"
{
    Caption = 'HR Summary Cue';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Recently Hired Workers"; Integer)
        {
            Caption = 'Recently Hired Workers';
            FieldClass = FlowField;
            CalcFormula = Count(Worker WHERE("Employed Status" = FILTER(Hired)));
        }
        field(3; "Pending Workers"; Integer)
        {
            Caption = 'Pending Workers';
            FieldClass = FlowField;
            CalcFormula = Count(Worker WHERE("Employed Status" = FILTER(Pending)));
        }
        field(4; "Exiting Workers"; Integer)
        {
            Caption = 'Exiting Workers';
            FieldClass = FlowField;
            CalcFormula = Count(Worker WHERE("Employed Status" = FILTER(Exiting)));
        }
        field(5; "Work Items Assigned to me"; Integer)
        {
            Caption = 'Work Items Assigned to me';
        }
        field(6; "Employees"; Integer)
        {
            Caption = 'Employees';
            FieldClass = FlowField;
            CalcFormula = Count(Employee where(Status = filter(Active)));
        }
        field(7; "Open Positions"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Open Position" where("Is Open" = filter(true)));
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
