page 72162 "Benefit Plans"
{
    ApplicationArea = All;
    Caption = 'Benefit Plans';
    PageType = List;
    SourceTable = "Benefit Plan";
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Plan No."; Rec."Plan No.")
                {
                    ToolTip = 'Specifies the value of the Plan No. field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Plan Type"; Rec."Plan Type")
                {
                    ToolTip = 'Specifies the value of the Plan Type field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Coverage Code"; Rec."Coverage Code")
                {
                    ToolTip = 'Specifies the value of the Coverage Code field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Employee Amount"; Rec."Employee Amount")
                {
                    ToolTip = 'Specifies the value of the Employee Amount field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Coverage Amount"; Rec."Coverage Amount")
                {
                    ToolTip = 'Specifies the value of the Coverage Amount field.', Comment = '%';
                    ApplicationArea = All;
                }
            }
        }
    }
}
