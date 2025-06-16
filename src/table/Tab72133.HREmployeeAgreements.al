table 72133 "HR Employee Agreements"
{
    Caption = 'HR Employee Agreements';
    LookupPageId = "HR Employee Agreement";
    DrillDownPageId = "HR Employee Agreement";

    fields
    {
        field(1; "ID"; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(2; "Employee No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Agreement Type"; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = "Data Lookup".Code where(Type = filter("Agreement Type"));
            // Editable = false;
        }
        field(4; "Agreement Structure"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Agreements".Structure WHERE("Agreement Type" = field("Agreement Type"));

        }
        field(7; "Status"; Option)
        {
            OptionMembers = Open,Active,Closed,Cancelled;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "ID")
        {
            Clustered = true;
        }
        key(EmployeeNo; "Employee No.", "Agreement Type", "Agreement Structure")
        {
        }
    }
}