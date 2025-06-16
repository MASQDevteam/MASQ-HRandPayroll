page 72119 "Leave Request Type Lookup"
{
    ApplicationArea = All;
    Caption = 'Leave Request Type Lookup';
    PageType = List;
    SourceTable = "Type Lookup";
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Leave Request Type"; Rec."Leave Request Type")
                {
                    ToolTip = 'Specifies the value of the Leave Request Type field.', Comment = '%';
                }
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
        }
    }
}
