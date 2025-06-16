page 72159 "HR Summary Cue Page"
{
    Caption = 'HR Summary Cue Page';
    PageType = CardPart;
    SourceTable = "HR Summary Cue";
    RefreshOnActivate = true;
    ShowFilter = false;
    ApplicationArea = All;
    layout
    {
        area(Content)
        {
            cuegroup(Summary)
            {
                ShowCaption = false;
                field("Recently Hired Workers"; Rec."Recently Hired Workers")
                {
                    Image = Calendar;
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        Worker: Record Worker;
                        WorkersList: Page "Workers List";
                    begin
                        Worker.SetRange("Employed Status", Worker."Employed Status"::Hired);
                        WorkersList.SetTableView(Worker);
                        WorkersList.Run();
                    end;
                }
                field("Pending Workers"; Rec."Pending Workers")
                {
                    Image = People;
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        Worker: Record Worker;
                        WorkersList: Page "Workers List";
                    begin
                        Worker.SetRange("Employed Status", Worker."Employed Status"::Pending);
                        WorkersList.SetTableView(Worker);
                        WorkersList.Run();
                    end;
                }
                field("Exiting Workers"; Rec."Exiting Workers")
                {
                    Image = People;
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        Worker: Record Worker;
                        WorkersList: Page "Workers List";
                    begin
                        Worker.SetRange("Employed Status", Worker."Employed Status"::Exiting);
                        WorkersList.SetTableView(Worker);
                        WorkersList.Run();
                    end;
                }
                field("Work Items Assigned to me"; Rec."Work Items Assigned to me")
                {
                    Image = Info;
                    ApplicationArea = All;
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
                field(Employees; Rec.Employees)
                {

                    Image = People;
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        Employee: Record Employee;
                        EmployeeList: Page "Employee List";
                    begin
                        Employee.SetRange(Status, Employee.Status::Active);
                        EmployeeList.SetTableView(Employee);
                        EmployeeList.Run();
                    end;
                }

                field("Open Positions"; Rec."Open Positions")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Open Positions-Ext Reports";
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        AssignedWorkItems: Record "Assigned Work Items";
        CueRec: Record "HR Summary Cue";
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
            Commit();
        end;
        UserSetup.Get(UserId);
        Clear(AssignedWorkItems);
        AssignedWorkItems.SetRange("Employee No.", UserSetup."Employee No.");
        CueRec."Work items assigned to me" := AssignedWorkItems.Count;

        CueRec.Modify();
    end;

    var
        UserSetup: Record "User Setup";
}
