page 72132 Questionnaires
{
    ApplicationArea = All;
    Caption = 'Questionnaires';
    PageType = List;
    SourceTable = Questionnaire;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Department; Rec.Department)
                { }
                field("Department Name"; Rec."Department Name")
                { }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Created Date"; Rec."Created Date")
                {
                    ToolTip = 'Specifies the value of the Created Date field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::Questionnaire),
                              "No." = field(Code);

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
            Rec.Validate("Employee No.", Employee."No.");
        end;
    end;
}
