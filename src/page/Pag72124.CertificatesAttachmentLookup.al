page 72124 "CertificatesAttachment Lookup"
{
    ApplicationArea = All;
    Caption = 'CertificatesAttachment ';
    PageType = List;
    SourceTable = "Team LookUp";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Certificate ID"; Rec."Certificate ID")
                {
                    ToolTip = 'Specifies the value of the Certificate ID field.', Comment = '%';
                }
                field("Certificate Name"; Rec."Certificate Name")
                {
                    ToolTip = 'Specifies the value of the Certificate Name field.', Comment = '%';
                }

                field("Expiry Date"; Rec."Expiry Date")
                {
                    ToolTip = 'Specifies the value of the Expiry Date field.', Comment = '%';
                }
                field(Attachment; Rec.Attachment)
                {
                    ToolTip = 'Specifies the value of the Attachment field.', Comment = '%';
                }
                field("Uploaded By"; Rec."Uploaded By")
                {
                    ToolTip = 'Specifies the value of the Uploaded By field.', Comment = '%';
                }
                field("Upload Date"; Rec."Upload Date")
                {
                    ToolTip = 'Specifies the value of the Upload Date field.', Comment = '%';
                }
                field("Certificate Comments"; Rec."Certificate Comments")
                {
                    ToolTip = 'Specifies the value of the Certificate Comments field.', Comment = '%';
                }
                field("Employee ID"; Rec."Employee ID")
                {
                    ToolTip = 'Specifies the value of the Employee ID field.', Comment = '%';
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
