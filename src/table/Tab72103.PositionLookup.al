table 72103 "Position Lookup"
{
    Caption = 'Position Lookup';
    DataClassification = ToBeClassified;
    LookupPageId = "Position Lookup";
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[150])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
