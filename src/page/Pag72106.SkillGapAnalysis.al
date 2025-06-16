page 72106 "Skill Gap Analysis"
{
    ApplicationArea = All;
    Caption = 'Skill Gap Analysis';
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
                field("Gap ID"; Rec."Gap ID")
                {
                    ToolTip = 'Specifies the value of the Gap ID field.', Comment = '%';
                }
                field("Skill Required"; Rec."Skill Required")
                {
                    ToolTip = 'Specifies the value of the Skill Required field.', Comment = '%';
                }
                field("Current Skill Level"; Rec."Current Skill Level")
                {
                    ToolTip = 'Specifies the value of the Current Skill Level field.', Comment = '%';
                }
                field("Required Skill Level"; Rec."Required Skill Level")
                {
                    ToolTip = 'Specifies the value of the Required Skill Level field.', Comment = '%';
                }
                field("Gap Assessment Date"; Rec."Gap Assessment Date")
                {
                    ToolTip = 'Specifies the value of the Gap Assessment Date field.', Comment = '%';
                }
                field("Gap Assessed By"; Rec."Gap Assessed By")
                {
                    ToolTip = 'Specifies the value of the Assessed By field.', Comment = '%';
                }
                field("Gap Comments"; Rec."Gap Comments")
                {
                    ToolTip = 'Specifies the value of the Gap Comments field.', Comment = '%';
                }
            }
        }
    }
}
