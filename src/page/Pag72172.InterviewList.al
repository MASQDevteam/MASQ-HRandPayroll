page 72172 "Interview List"
{
    ApplicationArea = All;
    Caption = 'Interview List';
    PageType = List;
    SourceTable = "Interview Header";
    UsageCategory = Lists;
    CardPageId = "Interview Card";
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Interview No."; Rec."Interview No.")
                {
                    ToolTip = 'Specifies the value of the Interview No. field.', Comment = '%';
                }
                field("Candidate Name"; Rec."Candidate Name")
                {
                    ToolTip = 'Specifies the value of the Candidate Name field.', Comment = '%';
                }
                field("Position Applied"; Rec."Position Applied")
                {
                    ToolTip = 'Specifies the value of the Position Applied field.', Comment = '%';
                }
                field("Interview Date"; Rec."Interview Date")
                {
                    ToolTip = 'Specifies the value of the Interview Date field.', Comment = '%';
                }
                field(Interviewer; Rec.Interviewer)
                {
                    ToolTip = 'Specifies the value of the Interviewer field.', Comment = '%';
                }
                field("Interview Status"; Rec."Interview Status")
                {
                    ToolTip = 'Specifies the value of the Interview Status field.', Comment = '%';
                }
                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Specifies the value of the Comments field.', Comment = '%';
                }
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Interview Header"),
                              "No." = field("Interview No.");

            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }
}
