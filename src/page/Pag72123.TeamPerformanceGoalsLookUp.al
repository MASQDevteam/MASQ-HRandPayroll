page 72123 "Team Performance Goals LookUp"
{
    ApplicationArea = All;
    Caption = 'Team Performance Goals';
    PageType = List;
    SourceTable = "Team LookUp";
    UsageCategory = Lists;

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
                field("Employee ID"; Rec."Employee ID")
                {
                    ToolTip = 'Specifies the value of the Employee ID field.', Comment = '%';
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
        end;

    end;
}
