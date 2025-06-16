page 72156 "Data Lookup Page"
{
    ApplicationArea = All;
    Caption = 'Data Lookup Page';
    PageType = List;
    SourceTable = "Data Lookup";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                // field("Type"; Rec."Type")
                // {
                //     ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                // }
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
        }
    }
}
