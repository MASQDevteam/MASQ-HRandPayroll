page 72100 "MASQ Activities Cue Page"
{
    Caption = 'MASQ Activities Cue Page';
    PageType = CardPart;
    SourceTable = "MASQ Activities Cue";
    RefreshOnActivate = true;
    ShowFilter = false;
    ApplicationArea = All;
    layout
    {
        area(Content)
        {
            cuegroup(Summary)
            {
                //CueGroupLayout = Wide;
                Caption = 'Summary';

                field("Expiring Certificates"; Rec."Expiring Certificates")
                {
                    ToolTip = 'Specifies the value of the Certficates expiring for my team field.', Comment = '%';
                    Image = Calendar;
                    DrillDownPageId = "CertificatesAttachment";
                    ApplicationArea = All;
                }
                field("Team skills assessment"; Rec."Team skills assessment")
                {
                    ToolTip = 'Specifies the value of the Team skills assessment field.', Comment = '%';
                    Image = People;
                    DrillDownPageId = "Team Skills Assessment Page";
                    ApplicationArea = All;
                }
                field("Team performance journal"; Rec."Team performance journal")
                {
                    ToolTip = 'Specifies the value of the Team performance journal field.', Comment = '%';
                    Image = People;
                    DrillDownPageId = "Team Performance Journals";
                    ApplicationArea = All;
                }
                field("Skill gap analysis"; Rec."Skill gap analysis")
                {
                    ToolTip = 'Specifies the value of the Skill gap analysis field.', Comment = '%';
                    Image = Receipt;
                    DrillDownPageId = "Skill Gap Analysis";
                    ApplicationArea = All;

                }
                field("Team performance goals"; Rec."Team performance goals")
                {
                    ToolTip = 'Specifies the value of the Team performance goals field.', Comment = '%';
                    Image = People;
                    DrillDownPageId = "Team Performance Goals";
                    ApplicationArea = All;
                }
                field("Team performance review"; Rec."Team performance review")
                {
                    ToolTip = 'Specifies the value of the Team performance review field.', Comment = '%';
                    Image = People;
                    DrillDownPageId = "Team performance reviews";
                    ApplicationArea = All;
                }
                field("Open Positions-Ext Reports"; Rec."Open Positions-Ext Reports")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Open Positions-Ext Reports";
                }
                field("Open Positions-Direct Reports"; Rec."Open Positions-Direct Reports")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Open Positions-Direct Reports";
                }
                field(Birthdays; Rec.Birthdays)
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        Employee: Record Employee;
                        EmployeeList: Page "Employee List";
                    begin
                        Employee.SetRange("Birthday Date", Today);
                        EmployeeList.SetTableView(Employee);
                        EmployeeList.Run();
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        OpenPosition: Record "Open Position";
        CueRec: Record "MASQ Activities Cue";
        Employee: Record Employee;

    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
            Commit();
        end;
        UserSetup.Get(UserId);
        CueRec.Get(Rec."Primary Key");
        Clear(OpenPosition);
        OpenPosition.SetRange("Is Open", true);
        OpenPosition.SetRange("Reports To", UserSetup."Employee No.");
        CueRec."Open Positions-Direct Reports" := OpenPosition.Count;

        Clear(Employee);
        Employee.SetRange("Birthday Date", Today);
        CueRec.Birthdays := Employee.Count;
        CueRec.Modify();
    end;

    var
        UserSetup: Record "User Setup";
}
