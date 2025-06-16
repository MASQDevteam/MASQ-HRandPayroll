page 72113 "PerformanceGoalFactbox "
{
    ApplicationArea = All;
    Caption = 'PerformanceGoalFactbox ';
    PageType = ListPart;
    SourceTable = "Team LookUp";
    InsertAllowed = false;
    DeleteAllowed = true;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Goal ID"; Rec."Goal ID")
                {
                    ToolTip = 'Specifies the value of the Goal ID field.', Comment = '%';
                }
                field("Goal Description"; Rec."Goal Description")
                {
                    ToolTip = 'Specifies the value of the Goal Description field.', Comment = '%';
                }
                field("Goal Start Date"; Rec."Goal Start Date")
                {
                    ToolTip = 'Specifies the value of the Goal Start Date field.', Comment = '%';
                }
                field("Goal End Date"; Rec."Goal End Date")
                {
                    ToolTip = 'Specifies the value of the Goal End Date field.', Comment = '%';
                }
                field("Goal Assigned By"; Rec."Goal Assigned By")
                {
                    ToolTip = 'Specifies the value of the Goal Assigned By field.', Comment = '%';
                }
                field("Goal Status"; Rec."Goal Status")
                {
                    ToolTip = 'Specifies the value of the Goal Status field.', Comment = '%';
                }
                field("Goal Comments"; Rec."Goal Comments")
                {
                    ToolTip = 'Specifies the value of the Goal Comments field.', Comment = '%';
                }
                field("Goal Category"; Rec."Goal Category")
                {
                    ToolTip = 'Specifies the value of the Goal Category field.', Comment = '%';
                }
                field("Goal Priority"; Rec."Goal Priority")
                {
                    ToolTip = 'Specifies the value of the Goal Priority field.', Comment = '%';
                }
                field("Goal Progress"; Rec."Goal Progress")
                {
                    ToolTip = 'Specifies the value of the Goal Progress (%) field.', Comment = '%';
                }
                field("Goal Last Updated"; Rec."Goal Last Updated")
                {
                    ToolTip = 'Specifies the value of the Goal Last Updated field.', Comment = '%';
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
                    TeamPerformanceGoals: Page "Team Performance Goals LookUp";
                begin
                    TeamLookUp.SetFilter("Team Type", '=%1', TeamLookUp."Team Type"::"Team performance goals");
                    TeamLookUp.SetFilter("Employee ID", '=%1', Rec."Employee ID");
                    TeamPerformanceGoals.SetTableView(TeamLookUp);
                    TeamPerformanceGoals.Run();
                end;
            }
        }
    }
}
