page 72171 "Interview Subform"
{
    ApplicationArea = All;
    Caption = 'Interview Subform';
    PageType = ListPart;
    SourceTable = "Interview Line";
    AutoSplitKey = true;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Interview Type"; Rec."Interview Type")
                {
                    ToolTip = 'Specifies the value of the Interview Type field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Score; Rec.Score)
                {
                    ToolTip = 'Specifies the value of the Score field.', Comment = '%';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.', Comment = '%';
                }
            }
        }
    }
}
