page 72134 "Summary Cue"
{
    Caption = 'Summary Cue';
    PageType = CardPart;
    SourceTable = "Summary Cue";
    RefreshOnActivate = true;
    ShowFilter = false;
    ApplicationArea = All;
    layout
    {
        area(Content)
        {
            cuegroup(General)
            {
                ShowCaption = false;
                field("ID Numbers Expiring"; Rec."ID Numbers Expiring")
                {
                    ApplicationArea = All;
                    ShowCaption = true;
                    trigger OnDrillDown()
                    var
                        IDCardTracking: Record IDCardTracking;
                        IDCardsExpiringLookup: Page "ID Cards Expiring Lookup";
                    begin
                        IDCardsExpiringLookup.SetTableView(IDCardTracking);
                        IDCardsExpiringLookup.Run();
                    end;

                }

                field("Pending Time Off Requests"; Rec."Pending Time Off Requests")
                {
                    ApplicationArea = All;
                    ShowCaption = true;
                    trigger OnDrillDown()
                    var
                        RequestTimeOff: Record "Request Time Off";
                        RequestTimeOffPage: Page "Request Time Off";
                    begin
                        RequestTimeOff.SetRange(Status, RequestTimeOff.Status::Pending);
                        RequestTimeOffPage.SetTableView(RequestTimeOff);
                        RequestTimeOffPage.Run();
                    end;
                }
                field("Pending Leave of Absence Requests"; Rec."Pending Leave of Absence Requests")
                {
                    ApplicationArea = All;
                    ShowCaption = true;
                    trigger OnDrillDown()
                    var
                        LeaveRequestHeader: Record "Leave Request Header";
                        LeaveRequestList: Page "Leave Request List";
                    begin
                        LeaveRequestHeader.SetRange(Status, LeaveRequestHeader.Status::Pending);
                        LeaveRequestList.SetTableView(LeaveRequestHeader);
                        LeaveRequestList.Run();
                    end;
                }
                field("Pending Buy and Sell Leave Requests"; Rec."Pending Buy and Sell Leave Requests")
                {
                    ApplicationArea = All;
                    ShowCaption = true;
                    trigger OnDrillDown()
                    var
                        LeaveBuySellRequest: Record "Leave Buy Sell Request";
                        LeaveBuySellRequestsPage: Page "Leave Buy Sell Requests";
                    begin
                        LeaveBuySellRequest.SetRange(Status, LeaveBuySellRequest.Status::Pending);
                        LeaveBuySellRequestsPage.SetTableView(LeaveBuySellRequest);
                        LeaveBuySellRequestsPage.Run();
                    end;
                }
                field("Manager Absence Calendar"; Rec."Manager Absence Calendar")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Manager Absence Calendar";
                }
            }

        }
    }
    trigger OnOpenPage()
    var
        CueRec: Record "Summary Cue";
        LeaveRequestHeader: Record "Leave Request Header";
        Employee: Record Employee;
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
            Commit();
        end;
        CueRec."Manager Absence Calendar" := 0;
        UserSetup.Get(UserId);
        Clear(Employee);
        Clear(LeaveRequestHeader);
        Employee.SetRange("No.", UserSetup."Employee No.");
        if Employee.FindFirst() then begin
            CueRec.Get(Rec."Primary Key");
            LeaveRequestHeader.SetRange(Status, LeaveRequestHeader.Status::Approved);
            LeaveRequestHeader.SetFilter("Employee ID", Employee."Reports To");
            CueRec."Manager Absence Calendar" := LeaveRequestHeader.Count;
            CueRec.Modify();
        end;
    end;

    var
        UserSetup: Record "User Setup";
}
