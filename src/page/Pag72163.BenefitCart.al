page 72163 "Benefit Cart"
{
    ApplicationArea = All;
    Caption = 'Benefit Cart';
    PageType = List;
    SourceTable = "Benefit Cart";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Plan"; Rec."Plan")
                {
                    ToolTip = 'Specifies the value of the Plan No. field.', Comment = '%';
                }
                field("Plan Type"; Rec."Plan Type") { }
                field("Coverage Code"; Rec."Coverage Code")
                {
                    ToolTip = 'Specifies the value of the Coverage Code field.', Comment = '%';
                }
                field("Coverage Amount"; Rec."Coverage Amount")
                {
                    ToolTip = 'Specifies the value of the Coverage Amount field.', Comment = '%';
                }
                field("Employee Amount"; Rec."Employee Amount")
                {
                    ToolTip = 'Specifies the value of the Employee Amount field.', Comment = '%';
                }
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Benefit Cart"),
                              "No." = field(Code);

            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }
}
