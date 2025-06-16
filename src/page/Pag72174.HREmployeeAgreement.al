page 72174 "HR Employee Agreement"
{
    PageType = List;
    SourceTable = "HR Employee Agreements";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Agreement Type"; Rec."Agreement Type")
                {
                    ApplicationArea = All;
                }
                field("Agreement Structure"; Rec."Agreement Structure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Agreement Structure field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }

                // Add more fields as needed
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
    begin
        Rec."Employee No." := Rec.GetFilter("Employee No.");
    end;
}