page 72130 "Expenses Lookup"
{
    ApplicationArea = All;
    Caption = 'Expenses Lookup';
    PageType = List;
    SourceTable = "Team LookUp";
    UsageCategory = Lists;

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
                field("Employee ID"; Rec."Employee ID")
                {
                    ToolTip = 'Specifies the value of the Employee ID field.', Comment = '%';
                    Editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.', Comment = '%';
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        Employee: Record Employee;
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        Employee.SetRange("No.", UserSetup."Employee No.");
        if Employee.FindFirst() then begin
            Rec.Validate("Employee ID", Employee."No.");
        end;
    end;
}
