table 72105 "Leave Request Line"
{
    Caption = 'Leave Request Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Request No."; Code[20])
        {
            Caption = 'Request No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Request Date"; Date)
        {
            Caption = 'Request Date';
        }
        field(4; "Leave Type"; Code[20])
        {
            Caption = 'Leave Type';
            TableRelation = "Type Lookup".Code where("Leave Request Type" = filter("Leave Request Type"::"Leave Type"));
        }
        field(5; Description; Text[1000])
        {
            Caption = 'Description';
        }

        field(9; Day; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Requested Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; Balance; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Request No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
