pageextension 72104 "User Setup Ext" extends "User Setup"
{
    layout
    {
        addlast(Control1)
        {
            field("Employee No."; Rec."Employee No.")
            {
                ApplicationArea = All;
            }
            field("Show Emp Actions"; Rec."Show Emp Actions")
            {
                ApplicationArea = all;
            }

        }
    }
}
