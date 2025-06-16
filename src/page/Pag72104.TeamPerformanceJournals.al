page 72104 "Team Performance Journals"
{
    ApplicationArea = All;
    Caption = 'Team Performance Journals';
    PageType = List;
    SourceTable = "Team LookUp";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Employee ID"; Rec."Employee ID")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Journal ID"; Rec."Journal ID")
                {
                    ToolTip = 'Specifies the value of the Journal ID field.', Comment = '%';
                }
                field("Journal Date"; Rec."Journal Date")
                {
                    ToolTip = 'Specifies the value of the Journal Date field.', Comment = '%';
                }
                field("Journal Description"; Rec."Journal Description")
                {
                    ToolTip = 'Specifies the value of the Journal Description field.', Comment = '%';
                }
                field("Journal Entered By"; Rec."Journal Entered By")
                {
                    ToolTip = 'Specifies the value of the Journal Entered By field.', Comment = '%';
                }
                field("Journal Comments"; Rec."Journal Comments")
                {
                    ToolTip = 'Specifies the value of the Journal Comments field.', Comment = '%';
                }
                field("Journal Status"; Rec."Journal Status")
                {
                    ToolTip = 'Specifies the value of the Journal Status field.', Comment = '%';
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ToolTip = 'Specifies the value of the Approval Date field.', Comment = '%';
                }
            }
        }
    }
}
