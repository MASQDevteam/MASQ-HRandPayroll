tableextension 72103 "User Setup Ext" extends "User Setup"
{
    fields
    {
        field(72100; "Show Emp Actions"; Boolean)
        {
            Caption = 'Show Emp Actions';
            DataClassification = ToBeClassified;
        }
        field(72101; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
    }
}
