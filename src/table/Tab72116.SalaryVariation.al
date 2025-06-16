table 72116 "Salary Variation"
{
    Caption = 'Salary Variation';
    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(2; "Employee No"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
        }
        field(3; "Old Salary"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "New Salary"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Rec."Last Increase Amount" := Rec."New Salary" - Rec."Old Salary";
                if Rec."New Salary" <> 0 then
                    Rec."Last Increase percent" := Round(Rec."Last Increase Amount" / Rec."New Salary") * 100;
            end;
        }
        field(5; "Created By"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Last Increase Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Last Increase percent"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}