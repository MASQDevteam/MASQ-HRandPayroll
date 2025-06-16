page 72127 "Next Reg Courses FactBox"
{
    ApplicationArea = All;
    Caption = 'Next Reg Courses FactBox';
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
                    NextRegisteredCoursesLookup: Page "Next Registered Courses Lookup";
                    UserSetup: Record "User Setup";
                begin
                    UserSetup.Get(UserId);
                    TeamLookUp.SetFilter("Team Type", '=%1', TeamLookUp."Team Type"::"Next Registered Courses");
                    TeamLookUp.SetRange("Employee ID", UserSetup."Employee No.");
                    NextRegisteredCoursesLookup.SetTableView(TeamLookUp);
                    NextRegisteredCoursesLookup.Run();
                end;
            }
        }
    }
}
