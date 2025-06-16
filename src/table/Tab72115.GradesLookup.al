table 72115 "Grades Lookup"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Grades Lookup";
    fields
    {
        field(1; "Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Group Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Group Code", "Description") { }
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