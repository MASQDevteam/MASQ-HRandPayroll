page 72128 "Apply Resignation Lookup"
{
    ApplicationArea = All;
    Caption = 'Apply Resignation Lookup';
    PageType = List;
    SourceTable = "Team LookUp";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Resignation ID"; Rec."Resignation ID")
                {
                    ToolTip = 'Specifies the value of the Resignation ID field.', Comment = '%';
                }
                field("Resignation Date"; Rec."Resignation Date")
                {
                    ToolTip = 'Specifies the value of the Resignation Date field.', Comment = '%';
                }
                field("Last Working Day"; Rec."Last Working Day")
                {
                    ToolTip = 'Specifies the value of the Last Working Day field.', Comment = '%';
                }
                field("Reason for Resignation"; Rec."Reason for Resignation")
                {
                    ToolTip = 'Specifies the value of the Reason for Resignation field.', Comment = '%';
                }
                field("Resignation Status"; Rec."Resignation Status")
                {
                    ToolTip = 'Specifies the value of the Resignation Status field.', Comment = '%';
                }
                field("Approved By"; Rec."Approved By")
                {
                    ToolTip = 'Specifies the value of the Approved By field.', Comment = '%';
                }
                field("Resignation Approval Date"; Rec."Resignation Approval Date")
                {
                    ToolTip = 'Specifies the value of the Approval Date field.', Comment = '%';
                }
                field("Resignation Comments"; Rec."Resignation Comments")
                {
                    ToolTip = 'Specifies the value of the Resignation Comments field.', Comment = '%';
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
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Team LookUp"),
                              "No." = field("Primary Key as Code");

            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
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
