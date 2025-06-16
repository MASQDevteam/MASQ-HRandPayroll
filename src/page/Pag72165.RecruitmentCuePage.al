page 72165 "Recruitment Cue Page"
{
    Caption = 'Recruitment Cue Page';
    PageType = CardPart;
    SourceTable = "Recruitment Cue";
    RefreshOnActivate = true;
    ShowFilter = false;
    ApplicationArea = All;
    layout
    {
        area(Content)
        {
            cuegroup(Recruitment)
            {
                ShowCaption = false;
                field("Application Deadline appr"; Rec."Application Deadline appr")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        Application: Record "Application";
                        Applications: Page Applications;

                    begin
                        Application.SetFilter("Deadline Date", '>= %1 & <=%2', Today, DeadlineDate);
                        Applications.SetTableView(Application);
                        Applications.Run();
                    end;
                }
                field("Application Inbox"; Rec."Application Inbox")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        Application: Record "Application";
                        Applications: Page Applications;

                    begin
                        Application.SetRange(Status, Application.Status::Applied);
                        Applications.SetTableView(Application);
                        Applications.Run();
                    end;
                }
                field("All Applicants"; Rec."All Applicants")
                {
                    ApplicationArea = All;
                    DrillDownPageId = Applicants;
                }
                field("All Applications"; Rec."All Applications")
                {
                    ApplicationArea = All;
                    DrillDownPageId = Applications;

                }
            }
        }
    }
    trigger OnOpenPage()
    var
        ApplicationRec: Record "Application";
        CueRec: Record "Recruitment Cue";

    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
            Commit();
        end;

        CueRec.Get(Rec."Primary Key");
        DeadlineDate := Today + 7;
        ApplicationRec.SetFilter("Deadline Date", '>= %1 & <=%2', Today, DeadlineDate);
        CueRec."Application Deadline appr" := ApplicationRec.Count;
        CueRec.Modify();
    end;

    var
        DeadlineDate: Date;
}
