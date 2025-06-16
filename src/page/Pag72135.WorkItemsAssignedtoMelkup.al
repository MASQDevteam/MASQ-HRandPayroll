page 72135 "Work Items Assigned to Me lkup"
{
    ApplicationArea = All;
    Caption = 'Work Items Assigned to Me Lookup';
    PageType = List;
    SourceTable = "Assigned Work Items";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.', Comment = '%';
                    Editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.', Comment = '%';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies the value of the Due Date field.', Comment = '%';
                }
                field("Task Type"; Rec."Task Type")
                {
                    ToolTip = 'Specifies the value of the Task Type field.', Comment = '%';
                }
                field("Task Description"; Rec."Task Description")
                {
                    ToolTip = 'Specifies the value of the Task Description field.', Comment = '%';
                }
                field("Start Date"; Rec."Start Date")
                {

                }
                field("End Date"; Rec."End Date")
                { }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field(Priority; Rec.Priority)
                {
                    ToolTip = 'Specifies the value of the Priority field.', Comment = '%';
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
            Rec.Validate("Employee No.", Employee."No.");
        end;
    end;
}
