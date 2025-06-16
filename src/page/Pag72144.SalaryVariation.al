page 72144 "Salary Variation"
{
    ApplicationArea = All;
    Caption = 'Salary Variation';
    PageType = ListPart;
    SourceTable = "Salary Variation";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field.', Comment = '%';
                }
                field("Old Salary"; Rec."Old Salary")
                {
                    ToolTip = 'Specifies the value of the Old Salary field.', Comment = '%';
                }
                field("New Salary"; Rec."New Salary")
                {
                    ToolTip = 'Specifies the value of the New Salary field.', Comment = '%';
                }
                field("Last Increase Amount"; Rec."Last Increase Amount")
                {
                    ToolTip = 'Specifies the value of the Last Increase Amount field.', Comment = '%';
                }
                field("Last Increase percent"; Rec."Last Increase percent")
                {

                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
            }
        }
    }
}
