table 72132 "HR Agreements"
{
    DataClassification = ToBeClassified;
    LookupPageId = "HR Agreements List";
    DrillDownPageId = "HR Agreements List";

    fields
    {
        field(1; "ID"; Integer)
        {
            DataClassification = SystemMetadata;
        }
        field(2; "Agreement Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Structure"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Agreement Type"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Data Lookup".Code where(Type = filter("Agreement Type"));
        }
        field(7; Monday; Enum WorkStatus) { Caption = 'Monday'; }
        field(8; Tuesday; Enum WorkStatus) { Caption = 'Tuesday'; }
        field(9; Wednesday; Enum WorkStatus) { Caption = 'Wednesday'; }
        field(10; Thursday; Enum WorkStatus) { Caption = 'Thursday'; }
        field(11; Friday; Enum WorkStatus) { Caption = 'Friday'; }
        field(12; Saturday; Enum WorkStatus) { Caption = 'Saturday'; }
        field(13; Sunday; Enum WorkStatus) { Caption = 'Sunday'; }
        field(14; "from 1-3 years"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "from 3-6"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Above 6"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }




    keys
    {
        key(PK; "Agreement Type", Structure)
        {
            Clustered = true;
        }
    }
}