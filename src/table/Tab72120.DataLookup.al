table 72120 "Data Lookup"
{
    Caption = 'Data Lookup';
    DataClassification = ToBeClassified;
    LookupPageId = "Data Lookup Page";
    fields
    {
        field(1; "Type"; Enum "Data Lookup")
        {
            Caption = 'Type';
        }
        field(2; "Code"; Code[50])
        {
            Caption = 'Code';
        }
        field(3; Description; Text[150])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; "Type", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {

    }
}
