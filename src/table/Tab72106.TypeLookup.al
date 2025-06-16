table 72106 "Type Lookup"
{
    Caption = 'Type Lookup';
    DataClassification = ToBeClassified;
    LookupPageId = "Leave Request Type Lookup";
    fields
    {
        field(1; "Leave Request Type"; Enum "Leave Request Type")
        {
            Caption = 'Leave Request Type';
        }
        field(2; "Code"; Code[50])
        {
            Caption = 'Code';
        }
        field(3; Description; Text[500])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; "Leave Request Type", "Code")
        {
            Clustered = true;
        }
    }
}
