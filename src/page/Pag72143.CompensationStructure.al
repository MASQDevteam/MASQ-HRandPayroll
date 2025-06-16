page 72143 "Compensation Structure"
{
    ApplicationArea = All;
    Caption = 'Compensation Structure';
    PageType = List;
    SourceTable = "Compensation Structure";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Compensation Code"; Rec."Compensation Code")
                {
                    ToolTip = 'Specifies the value of the Compensation Code field.', Comment = '%';
                }
                field(Title; Rec.Title)
                {
                    ToolTip = 'Specifies the value of the Title field.', Comment = '%';
                }
                field("Job Grade"; Rec."Job Grade")
                {
                    ToolTip = 'Specifies the value of the Job Grade field.', Comment = '%';
                }
                field("Min Salary"; Rec."Min Salary")
                {
                    ToolTip = 'Specifies the value of the Min Salary field.', Comment = '%';
                }
                field("Max Salary"; Rec."Max Salary")
                {
                    ToolTip = 'Specifies the value of the Max Salary field.', Comment = '%';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.', Comment = '%';
                }
                field(Active; Rec.Active)
                {
                    ToolTip = 'Specifies the value of the Active field.', Comment = '%';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.', Comment = '%';
                }
                field("Compensation Type"; Rec."Compensation Type")
                {
                    ToolTip = 'Specifies the value of the Compensation Type field.', Comment = '%';
                }
                field("No. of Employees"; Rec."No. of Employees")
                {
                    ToolTip = 'Specifies the value of the No. of Employees field.', Comment = '%';
                }
            }
        }
    }
}
