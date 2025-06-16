page 72122 "Employee Tasks FactBox"
{
    ApplicationArea = All;
    Caption = 'ETasks';
    PageType = ListPart;
    SourceTable = "Team LookUp";
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Team Type"; Rec."Team Type")
                {
                    ToolTip = 'Specifies the value of the Team Type field.', Comment = '%';
                    StyleExpr = PrioStyle;
                }
                field("Employee ID"; Rec."Employee ID")
                {
                    ToolTip = 'Specifies the value of the Employee ID field.', Comment = '%';
                    StyleExpr = PrioStyle;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.', Comment = '%';
                    StyleExpr = PrioStyle;
                }
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
                        myInt: Integer;
                    begin
                        GetPriorityStyle();
                    end;
                }
                field("Task Comments"; Rec."Task Comments")
                {
                    ToolTip = 'Specifies the value of the Task Comments field.', Comment = '%';
                    StyleExpr = PrioStyle;
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
                    TeamLookUp: Record "Team LookUp";
                    EmployeeTasks: Page "Employee Tasks Lookup";
                begin
                    TeamLookUp.SetFilter("Team Type", '=%1', TeamLookUp."Team Type"::Tasks);
                    TeamLookUp.SetFilter("Employee ID", '=%1', Rec."Employee ID");
                    EmployeeTasks.SetTableView(TeamLookUp);
                    EmployeeTasks.Run();
                end;
            }
        }
    }
    local procedure GetPriorityStyle(): Text

    begin
        if Rec."Task Priority" = Rec."Task Priority"::Critical then
            PrioStyle := 'Unfavorable'
        else // Red
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
