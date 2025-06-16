page 72116 "Leave Request List"
{
    ApplicationArea = All;
    Caption = 'Leave Request';
    PageType = List;
    SourceTable = "Leave Request Header";
    CardPageId = "Leave Request Card";
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Caption = 'General';

                field("Request No."; Rec."Request No.")
                {
                    ToolTip = 'Specifies the value of the Request ID field.', Comment = '%';
                }
                field("Employee ID"; Rec."Employee ID")
                {
                    ToolTip = 'Specifies the value of the Employee ID field.', Comment = '%';
                }
                field("Employee Name"; Rec."Employee Name")
                {

                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ToolTip = 'Specifies the value of the Leave Type field.', Comment = '%';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.', Comment = '%';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field(Reason; Rec.Reason)
                {
                    ToolTip = 'Specifies the value of the Reason field.', Comment = '%';
                }
            }
        }
    }
}
