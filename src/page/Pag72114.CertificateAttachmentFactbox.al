page 72114 "Certificate Attachment Factbox"
{
    ApplicationArea = All;
    Caption = 'Certificate Attachment Factbox';
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
                field("Attachment ID"; Rec."Attachment ID")
                {
                    ToolTip = 'Specifies the value of the Attachment ID field.', Comment = '%';
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
                    CertificatesAttachment: Page "CertificatesAttachment Lookup";
                begin
                    TeamLookUp.SetFilter("Team Type", '=%1', TeamLookUp."Team Type"::"Expiring Certificates");
                    TeamLookUp.SetFilter("Employee ID", '=%1', Rec."Employee ID");
                    CertificatesAttachment.SetTableView(TeamLookUp);
                    CertificatesAttachment.Run();
                end;
            }
        }
    }
}
