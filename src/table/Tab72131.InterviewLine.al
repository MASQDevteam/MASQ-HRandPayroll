table 72131 "Interview Line"
{
    Caption = 'Interview Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Interview No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(3; "Interview Type"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Data Lookup".Code where(Type = filter("Interview Type"));
        }

        field(4; "Description"; Text[100])
        {
            DataClassification = CustomerContent;
        }

        field(5; "Score"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "1","2","3","4","5","6","7","8","9","10";
        }

        field(6; "Comment"; Text[250])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Interview No.", "Line No.") { Clustered = true; }
    }
}
