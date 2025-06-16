page 72168 "Application Card"
{
    ApplicationArea = All;
    Caption = 'Application Card';
    PageType = Card;
    SourceTable = Application;
    InsertAllowed = true;
    DeleteAllowed = true;
    ModifyAllowed = true;
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Application No."; Rec."Application No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Applicant No."; Rec."Applicant No.")
                {
                    ToolTip = 'Specifies the value of the Applicant No. field.', Comment = '%';
                }
                field("Position Applied For"; Rec."Position Applied For")
                {
                    ToolTip = 'Specifies the value of the Position Applied For field.', Comment = '%';
                }
                field("Application Date"; Rec."Application Date")
                {
                    ToolTip = 'Specifies the value of the Application Date field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Applicant Name"; Rec."Applicant Name")
                {
                    ToolTip = 'Specifies the value of the Applicant Name field.', Comment = '%';
                }
                field("Deadline Date"; Rec."Deadline Date")
                {
                    ToolTip = 'Specifies the value of the Deadline Date field.', Comment = '%';
                }
            }

        }
        area(factboxes)
        {
            systempart(Control1000000005; Links)
            {
                Visible = true;
                ApplicationArea = RecordLinks;
            }

            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }
}
