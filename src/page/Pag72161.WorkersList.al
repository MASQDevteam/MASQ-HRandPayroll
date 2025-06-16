page 72161 "Workers List"
{
    ApplicationArea = All;
    Caption = 'Workers List';
    PageType = List;
    SourceTable = Worker;
    UsageCategory = Lists;
    CardPageId = "Worker Card";
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Worker No."; Rec."Worker No.")
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
                field("Position Code"; Rec."Position Code")
                {
                    ToolTip = 'Specifies the value of the Position Code field.', Comment = '%';
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ToolTip = 'Specifies the value of the Employment Date field.', Comment = '%';
                }
                field("Termination Date"; Rec."Termination Date")
                {
                    ToolTip = 'Specifies the value of the Termination Date field.', Comment = '%';
                }
                field("Employed Status"; Rec."Employed Status")
                {
                    ToolTip = 'Specifies the value of the Employed Status field.', Comment = '%';
                }
            }
        }
    }
}
