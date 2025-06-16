page 72120 "Leave Request FactBox"
{
    ApplicationArea = All;
    Caption = 'Leave Request FactBox';
    PageType = ListPart;
    SourceTable = "Leave Request Header";
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Leave Type"; Rec."Leave Type")
                {
                    ToolTip = 'Specifies the value of the Leave Type field.', Comment = '%';
                }
                field("Balance";Rec."Balance")
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
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(New)
            {
                ApplicationArea = All;
                Enabled = true;
                Caption = 'New';
                Image = New;
                trigger OnAction()
                var
                    LeaveRequestHeader: Record "Leave Request Header";
                    LeaveRequestList: Page "Leave Request List Lookup";
                begin
                    LeaveRequestHeader.SetRange("Employee ID", Rec."Employee ID");
                    LeaveRequestList.SetTableView(LeaveRequestHeader);
                    LeaveRequestList.Run();
                end;
            }
        }
    }
}
