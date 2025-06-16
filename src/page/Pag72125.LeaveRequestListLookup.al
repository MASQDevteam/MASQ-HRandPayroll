page 72125 "Leave Request List Lookup"
{
    ApplicationArea = All;
    Caption = 'Leave Request';
    PageType = List;
    SourceTable = "Leave Request Header";
    CardPageId = "Leave Request Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Caption = 'General';


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
                field("Employee ID"; Rec."Employee ID")
                {
                    ToolTip = 'Specifies the value of the Employee ID field.', Comment = '%';
                    Editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        Employee: Record Employee;
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        Employee.SetRange("No.", UserSetup."Employee No.");
        if Employee.FindFirst() then begin
            Rec.Validate("Employee ID", Employee."No.");
            //Rec.Modify();
        end;

    end;
}
