page 72107 "CertificatesAttachment"
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
                field("Employee ID"; Rec."Employee ID")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
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

}
