page 72155 "Request Compensation Change"
{
    ApplicationArea = All;
    Caption = 'Request Compensation Change';
    PageType = List;
    SourceTable = "HR Request";
    SourceTableView = where("Request Type" = filter(CompensationChange));
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.', Comment = '%';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.', Comment = '%';
                }
                field("Old Compensation"; Rec."Old Compensation")
                {
                    ToolTip = 'Specifies the value of the Old Compensation field.', Comment = '%';
                }
                field("New Compensation"; Rec."New Compensation")
                {
                    ToolTip = 'Specifies the value of the New Compensation field.', Comment = '%';
                }
                field(Status; Rec.Status)
                { }
                field("Effective Date"; Rec."Effective Date")
                {
                    ToolTip = 'Specifies the value of the Effective Date field.', Comment = '%';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.', Comment = '%';
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        myInt: Integer;
    begin
        Rec."Request Type" := Rec."Request Type"::CompensationChange;
    end;
}
