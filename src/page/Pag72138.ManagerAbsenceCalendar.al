page 72138 "Manager Absence Calendar"
{
    ApplicationArea = All;
    Caption = 'Manager Absence Calendar';
    PageType = List;
    SourceTable = "Leave Request Header";
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Employee ID"; Rec."Employee ID")
                {
                    ToolTip = 'Specifies the value of the Employee ID field.', Comment = '%';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.', Comment = '%';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.', Comment = '%';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.', Comment = '%';
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ToolTip = 'Specifies the value of the Leave Type field.', Comment = '%';
                }
                field(Reason; Rec.Reason)
                {
                    ToolTip = 'Specifies the value of the Reason field.', Comment = '%';
                }
                field("Balance"; Rec."Balance")
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

    trigger OnOpenPage()
    var
        Employee: Record "Employee";
        FilterString: Text;
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        Rec.FilterGroup(2);
        Rec.SetFilter("Status", '=%1', Rec.Status::Approved);
        Employee.SetRange("No.", UserSetup."Employee No.");
        if Employee.FindSet() then begin
            repeat
                if FilterString = '' then
                    FilterString := Employee."Reports To"
                else
                    FilterString += '|' + Employee."Reports To";
            until Employee.Next() = 0;

            if FilterString <> '' then
                Rec.SetFilter("Employee ID", FilterString);
        end;
    end;
}
