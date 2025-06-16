page 72142 "Grades Lookup"
{
    ApplicationArea = All;
    Caption = 'Grades Lookup';
    PageType = List;
    SourceTable = "Grades Lookup";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Group Code"; Rec."Group Code")
                {
                    ToolTip = 'Specifies the value of the Group Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
        }
    }
}
