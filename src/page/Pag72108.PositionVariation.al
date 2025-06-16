page 72108 "Position Variation"
{
    ApplicationArea = All;
    Caption = 'Position Variation';
    PageType = ListPart;
    SourceTable = "Position Variation";
    
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
                field("Old Position"; Rec."Old Position")
                {
                    ToolTip = 'Specifies the value of the Old Position field.', Comment = '%';
                }
                field("New Position"; Rec."New Position")
                {
                    ToolTip = 'Specifies the value of the New Position field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
            }
        }
    }
}
