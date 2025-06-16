page 72166 Applicants
{
    ApplicationArea = All;
    Caption = 'Applicants';
    PageType = List;
    SourceTable = Applicants;
    UsageCategory = Lists;
    CardPageId = "Applicants Card";
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Applicant No."; Rec."Applicant No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the value of the First Name field.', Comment = '%';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field.', Comment = '%';
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.', Comment = '%';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the Phone No. field.', Comment = '%';
                }
                field("No. of Applications"; Rec."No. of Applications") { DrillDownPageId = Applications; }
            }
        }
    }
}
