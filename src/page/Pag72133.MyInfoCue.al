page 72133 "My Info Cue"
{
    Caption = 'My Info Cue';
    PageType = CardPart;
    SourceTable = "My Info Cue";
    RefreshOnActivate = true;
    ShowFilter = false;
    ApplicationArea = All;
    layout
    {
        area(Content)
        {
            group("Emp ID")
            {
                ShowCaption = false;
                field(textuserID; textuserID)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    ShowCaption = false;
                    MultiLine = true;
                }
            }
            cuegroup(General)
            {
                ShowCaption = false;
                field(Questionnaires; Rec.Questionnaires)
                {
                    ToolTip = 'Specifies the value of the Questionnaires field.', Comment = '%';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        Questionnaire: Record Questionnaire;
                        QuestionnairesPage: Page Questionnaires;
                    begin
                        Questionnaire.SetRange("Employee No.", UserSetup."Employee No.");
                        QuestionnairesPage.SetTableView(Questionnaire);
                        QuestionnairesPage.Run();
                    end;
                }
                field(Courses; Rec.Courses)
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        TeamLookUp: Record "Team LookUp";
                        NextRegisteredCoursesLookup: Page "Next Registered Courses Lookup";
                    begin
                        TeamLookUp.SetRange("Team Type", TeamLookUp."Team Type"::"Next Registered Courses");
                        TeamLookUp.SetRange("Course Status", TeamLookUp."Course Status"::"Registered(Started)");
                        TeamLookUp.SetRange("Employee ID", UserSetup."Employee No.");
                        NextRegisteredCoursesLookup.SetTableView(TeamLookUp);
                        NextRegisteredCoursesLookup.Run();
                    end;
                }
                field("Work items assigned to me"; Rec."Work items assigned to me")
                {
                    trigger OnDrillDown()
                    var
                        AssignedWorkItems: Record "Assigned Work Items";
                        WorkItemsAssignedtoMe: Page "Work Items Assigned to Me lkup";
                    begin
                        AssignedWorkItems.SetRange("Employee No.", UserSetup."Employee No.");
                        WorkItemsAssignedtoMe.SetTableView(AssignedWorkItems);
                        WorkItemsAssignedtoMe.Run();
                    end;
                }
                field("Team Absence Calendar"; Rec."Team Absence Calendar")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Team Absence Calendar";
                }
                field("Open Jobs"; Rec."Open Jobs")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Open Jobs List";
                }
            }

        }
    }
    trigger OnOpenPage()
    var
        CueRec: Record "My Info Cue";
        Questionnaire: Record Questionnaire;
        TeamLookUp: Record "Team LookUp";
        AssignedWorkItems: Record "Assigned Work Items";
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
            Commit();
        end;
        textuserID := 'Employee ID\' + UserId;
        UserSetup.Get(UserId);

        Clear(Questionnaire);
        CueRec.Get(Rec."Primary Key");
        Questionnaire.SetRange("Employee No.", UserSetup."Employee No.");
        CueRec.Questionnaires := Questionnaire.Count;

        Clear(TeamLookUp);
        TeamLookUp.SetRange("Team Type", TeamLookUp."Team Type"::"Next Registered Courses");
        TeamLookUp.SetRange("Course Status", TeamLookUp."Course Status"::"Registered(Started)");
        TeamLookUp.SetRange("Employee ID", UserSetup."Employee No.");
        CueRec.Courses := TeamLookUp.Count;

        Clear(AssignedWorkItems);
        AssignedWorkItems.SetRange("Employee No.", UserSetup."Employee No.");
        CueRec."Work items assigned to me" := AssignedWorkItems.Count;

        CueRec.Modify();
    end;

    var
        textuserID: Text[50];
        UserSetup: Record "User Setup";
}
