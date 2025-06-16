page 72103 "Team performance reviews"
{
    ApplicationArea = All;
    Caption = 'Team performance reviews';
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
                field("Team Performance ID"; Rec."Team Performance ID")
                {
                    ToolTip = 'Specifies the value of the Team Performance ID field.', Comment = '%';
                }
                field("Performance Score"; Rec."Performance Score")
                {
                    ToolTip = 'Specifies the value of the Performance Score field.', Comment = '%';
                }
                field("Performance Comments"; Rec."Performance Comments")
                {
                    ToolTip = 'Specifies the value of the Performance Comments field.', Comment = '%';
                }
                field("Review Date"; Rec."Review Date")
                {
                    ToolTip = 'Specifies the value of the Review Date field.', Comment = '%';
                }
                field(Reviewer; Rec.Reviewer)
                {
                    ToolTip = 'Specifies the value of the Reviewer field.', Comment = '%';
                }
                field("Improvement Plan"; Rec."Improvement Plan")
                {
                    ToolTip = 'Specifies the value of the Improvement Plan field.', Comment = '%';
                }
                field("Review Status"; Rec."Review Status")
                {
                    ToolTip = 'Specifies the value of the Review Status field.', Comment = '%';
                }
            }
        }
    }
}
