page 72118 "Leave Request Card"
{
    ApplicationArea = All;
    Caption = 'Leave Request Header';
    PageType = Document;
    SourceTable = "Leave Request Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Request No."; Rec."Request No.")
                {
                    ToolTip = 'Specifies the value of the Request ID field.', Comment = '%';
                }
                field("Employee ID"; Rec."Employee ID")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.', Comment = '%';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.', Comment = '%';
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
                field("Original Balance"; Rec."Original Balance")
                {
                    ToolTip = 'Specifies the value of the original Balance field.', Comment = '%';
                }
                field(Balance; Rec.Balance)
                {
                    ToolTip = 'Specifies the value of the Balance field.', Comment = '%';
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ToolTip = 'Specifies the value of the Requested Amount field.', Comment = '%';
                }
                field("Remaining Balance"; Rec."Remaining Balance")
                {
                    ToolTip = 'Specifies the value of the Remaining Balance field.', Comment = '%';
                }
                field("Reports To"; Rec."Reports To")
                {
                    ApplicationArea = All;
                }
            }
            part(LeaveRequestSubform; "Request Leave Subform")
            {
                ApplicationArea = BasicHR;
                Caption = 'Request Leave Subform';
                SubPageLink = "Request No." = field("Request No.");
            }
        }
    }
}
