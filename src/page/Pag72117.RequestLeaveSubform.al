page 72117 "Request Leave Subform"
{
    ApplicationArea = All;
    Caption = 'Request Leave Subform';
    PageType = ListPart;
    SourceTable = "Leave Request Line";
    AutoSplitKey = true;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Request No."; Rec."Request No.")
                {
                    ToolTip = 'Specifies the value of the Request No. field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Day; Rec.Day)
                {
                    ToolTip = 'Specifies the value of the Day field.', Comment = '%';
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ToolTip = 'Specifies the value of the Requested Amount field.', Comment = '%';
                }
                field(Balance; Rec.Balance) { }
                field("Request Date"; Rec."Request Date")
                {
                    ToolTip = 'Specifies the value of the Request Date field.', Comment = '%';
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ToolTip = 'Specifies the value of the Leave Type field.', Comment = '%';
                }
            }
        }
    }
}
