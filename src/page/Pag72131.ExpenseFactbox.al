page 72131 "Expense Factbox"
{
    ApplicationArea = All;
    Caption = 'Expense Factbox';
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
                field("Expense ID"; Rec."Expense ID")
                {
                    ToolTip = 'Specifies the value of the Expense ID field.', Comment = '%';
                }
                field("Expense Type"; Rec."Expense Type")
                {
                    ToolTip = 'Specifies the value of the Expense Type field.', Comment = '%';
                }
                field("Expense Amount"; Rec."Expense Amount")
                {
                    ToolTip = 'Specifies the value of the Expense Amount field.', Comment = '%';
                }
                field("Currency Code"; Rec."Currency Code")
                { }
                field("Expense Date"; Rec."Expense Date")
                {
                    ToolTip = 'Specifies the value of the Expense Date field.', Comment = '%';
                }
                field("Expense Description"; Rec."Expense Description")
                {
                    ToolTip = 'Specifies the value of the Expense Description field.', Comment = '%';
                }
                field("Expense Status"; Rec."Expense Status")
                {
                    ToolTip = 'Specifies the value of the Expense Status field.', Comment = '%';
                }
                field("Expense Approved By"; Rec."Expense Approved By")
                {
                    ToolTip = 'Specifies the value of the Approved By field.', Comment = '%';
                }
                field("Expense Approval Date"; Rec."Expense Approval Date")
                {
                    ToolTip = 'Specifies the value of the Approval Date field.', Comment = '%';
                }
                field("Expense Comments"; Rec."Expense Comments")
                {
                    ToolTip = 'Specifies the value of the Expense Comments field.', Comment = '%';
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
                    ExpensesLookup: Page "Expenses Lookup";
                begin
                    TeamLookUp.SetFilter("Team Type", '=%1', TeamLookUp."Team Type"::Expenses);
                    TeamLookUp.SetFilter("Employee ID", '=%1', Rec."Employee ID");
                    ExpensesLookup.SetTableView(TeamLookUp);
                    ExpensesLookup.Run();
                end;
            }
        }
    }
}
