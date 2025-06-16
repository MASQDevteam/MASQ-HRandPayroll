page 72148 "Courses"
{
    ApplicationArea = All;
    Caption = 'Next Registered Courses Lookup';
    PageType = List;
    SourceTable = "Team LookUp";
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Course Type"; Rec."Course Type")
                {
                    ApplicationArea = All;
                }
                field("Course ID"; Rec."Course ID")
                {
                    ToolTip = 'Specifies the value of the Course ID field.', Comment = '%';
                }
                field("Course Name"; Rec."Course Name")
                {
                    ToolTip = 'Specifies the value of the Course Name field.', Comment = '%';
                }
                field("Course Start Date"; Rec."Course Start Date")
                {
                    ToolTip = 'Specifies the value of the Course Start Date field.', Comment = '%';

                }
                field("Course End Date"; Rec."Course End Date")
                {
                    ToolTip = 'Specifies the value of the Course End Date field.', Comment = '%';

                }
                field("Course Status"; Rec."Course Status")
                {
                    ToolTip = 'Specifies the value of the Course Status field.', Comment = '%';
                }
                field("Course Fees"; Rec."Course Fees") { }
                field("Is Cancelled"; Rec."Is Cancelled")
                {
                    ApplicationArea = All;
                }
                field("Course Comments"; Rec."Course Comments")
                {
                    ToolTip = 'Specifies the value of the Course Comments field.', Comment = '%';
                }
                field("Employee ID"; Rec."Employee ID")
                {
                    ToolTip = 'Specifies the value of the Employee ID field.', Comment = '%';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.', Comment = '%';
                }
            }
        }
    }
}
