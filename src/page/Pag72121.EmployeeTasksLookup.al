page 72121 "Employee Tasks Lookup"
{
    ApplicationArea = All;
    Caption = 'Employee Tasks Lookup';
    PageType = List;
    SourceTable = "Team LookUp";
    UsageCategory = Lists;
    ;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Task ID"; Rec."Task ID")
                {
                    ToolTip = 'Specifies the value of the Task ID field.', Comment = '%';
                    StyleExpr = PrioStyle;
                }
                field("Task Description"; Rec."Task Description")
                {
                    ToolTip = 'Specifies the value of the Task Description field.', Comment = '%';
                    StyleExpr = PrioStyle;
                }
                field("Task Start Date"; Rec."Task Start Date")
                {
                    ToolTip = 'Specifies the value of the Task Start Date field.', Comment = '%';
                    StyleExpr = PrioStyle;
                }
                field("Task End Date"; Rec."Task End Date") { StyleExpr = PrioStyle; }
                field("Task Start Time"; Rec."Task Start Time") { StyleExpr = PrioStyle; }
                field("Task End Time"; Rec."Task End Time") { StyleExpr = PrioStyle; }
                field("Task Due Date"; Rec."Task Due Date")
                {
                    ToolTip = 'Specifies the value of the Task Due Date field.', Comment = '%';
                    StyleExpr = PrioStyle;
                }
                field("Task Status"; Rec."Task Status")
                {
                    ToolTip = 'Specifies the value of the Task Status field.', Comment = '%';
                    StyleExpr = PrioStyle;
                }
                field("Task Priority"; Rec."Task Priority")
                {
                    ToolTip = 'Specifies the value of the Task Priority field.', Comment = '%';
                    StyleExpr = PrioStyle;
                    trigger OnValidate()
                    var
                    begin
                        GetPriorityStyle();
                    end;
                }
                field("Task Comments"; Rec."Task Comments")
                {
                    ToolTip = 'Specifies the value of the Task Comments field.', Comment = '%';
                    StyleExpr = PrioStyle;
                }
                field("Team Type"; Rec."Team Type")
                {
                    ToolTip = 'Specifies the value of the Team Type field.', Comment = '%';
                    StyleExpr = PrioStyle;
                }
                field("Employee ID"; Rec."Employee ID")
                {
                    ToolTip = 'Specifies the value of the Employee ID field.', Comment = '%';
                    Editable = false;
                    StyleExpr = PrioStyle;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.', Comment = '%';
                    StyleExpr = PrioStyle;
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
        end;

    end;

    local procedure GetPriorityStyle(): Text

    begin
        if Rec."Task Priority" = Rec."Task Priority"::Critical then
            PrioStyle := 'Unfavorable' // Red
        else
            if Rec."Task Priority" = Rec."Task Priority"::High then
                PrioStyle := 'Subordinate'// Grey
            else
                PrioStyle := 'Standard';
    end;

    trigger OnAfterGetRecord()
    var
    begin
        GetPriorityStyle();
    end;


    var
        PrioStyle: Text;
}
