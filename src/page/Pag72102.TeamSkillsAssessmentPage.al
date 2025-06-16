page 72102 "Team Skills Assessment Page"
{
    ApplicationArea = All;
    Caption = 'Team Skills Assessment Page';
    PageType = List;
    SourceTable = "Team LookUp";
    UsageCategory = Lists;
    SourceTableView = WHERE("Team Type" = filter("Team Lookup"::"Team Skills Assessment"));
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
                field("Skill ID"; Rec."Skill ID")
                {
                    ToolTip = 'Specifies the value of the Skill ID field.', Comment = '%';
                }
                field("Skill Code"; Rec."Skill Code") { }
                field("Skill Name"; Rec."Skill Name")
                {
                    ToolTip = 'Specifies the value of the Skill Name field.', Comment = '%';
                }
                field("Skill Level"; Rec."Skill Level")
                {
                    ToolTip = 'Specifies the value of the Skill Level field.', Comment = '%';
                }
                field("Skill Assessment Date"; Rec."Skill Assessment Date")
                {
                    ToolTip = 'Specifies the value of the Skill Assessment Date field.', Comment = '%';
                }
                field("Assessed By"; Rec."Assessed By")
                {
                    ToolTip = 'Specifies the value of the Assessed By field.', Comment = '%';
                }
                field("Skill Comments"; Rec."Skill Comments")
                {
                    ToolTip = 'Specifies the value of the Skill Comments field.', Comment = '%';
                }
            }
        }
    }
}
