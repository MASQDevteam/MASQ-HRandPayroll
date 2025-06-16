page 72173 "HR Agreements List"
{
    PageType = List;
    SourceTable = "HR Agreements";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Structure; Rec.Structure)
                {
                    ToolTip = 'Specifies the value of the Structure field.', Comment = '%';
                }
                field("Agreement Name"; Rec."Agreement Name")
                {
                    ToolTip = 'Specifies the value of the Agreement Name field.', Comment = '%';
                }
                field("Agreement Type"; Rec."Agreement Type")
                {
                    ToolTip = 'Specifies the value of the Agreement Type field.', Comment = '%';
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field(Monday; Rec.Monday)
                {
                    ToolTip = 'Specifies the value of the Monday field.', Comment = '%';
                    //   Visible = (Rec."Agreement Type" = 'WORKDAYS');
                    Visible = WORKDAYS;
                }
                field(Tuesday; Rec.Tuesday)
                {
                    ToolTip = 'Specifies the value of the Tuesday field.', Comment = '%';
                    //  Visible = (Rec."Agreement Type" = 'WORKDAYS');   \
                    Visible = WORKDAYS;
                }
                field(Wednesday; Rec.Wednesday)
                {
                    ToolTip = 'Specifies the value of the Wednesday field.', Comment = '%';
                    //   Visible = (Rec."Agreement Type" = 'WORKDAYS');   
                    Visible = WORKDAYS;
                }
                field(Thursday; Rec.Thursday)
                {
                    ToolTip = 'Specifies the value of the Thursday field.', Comment = '%';
                    //  Visible = (Rec."Agreement Type" = 'WORKDAYS');
                    Visible = WORKDAYS;
                }
                field(Friday; Rec.Friday)
                {
                    ToolTip = 'Specifies the value of the Friday field.', Comment = '%';
                    //  Visible = (Rec."Agreement Type" = 'WORKDAYS');
                    Visible = WORKDAYS;
                }
                field(Saturday; Rec.Saturday)
                {
                    ToolTip = 'Specifies the value of the Saturday field.', Comment = '%';
                    //  Visible = (Rec."Agreement Type" = 'WORKDAYS');
                    Visible = WORKDAYS;
                }
                field(Sunday; Rec.Sunday)
                {
                    ToolTip = 'Specifies the value of the Sunday field.', Comment = '%';
                    //  Visible = (Rec."Agreement Type" = 'WORKDAYS');
                    Visible = WORKDAYS;
                }
                field("from 1-3 years"; Rec."from 1-3 years")
                {
                    ToolTip = 'Specifies the value of the from 1-3 years field.', Comment = '%';
                    //  Visible = (Rec."Agreement Type" = 'AGREED LEAVE');
                    Visible = AGREEDLEAVE;
                }
                field("from 3-6"; Rec."from 3-6")
                {
                    ToolTip = 'Specifies the value of the from 3-6 field.', Comment = '%';
                    //  Visible = (Rec."Agreement Type" = 'AGREED LEAVE');
                    Visible = AGREEDLEAVE;
                }
                field("Above 6"; Rec."Above 6")
                {
                    ToolTip = 'Specifies the value of the Above 6 field.', Comment = '%';
                    //  Visible = (Rec."Agreement Type" = 'AGREED LEAVE');
                    Visible = AGREEDLEAVE;
                }

                // Add more fields as needed
            }
        }
    }

    actions
    {
        area(processing)
        {
            // Add actions if needed
        }
    }


    trigger OnOpenPage()
    var
    begin
        IF Rec.GetFilter("Agreement Type") = 'AGREED LEAVE' then
            AGREEDLEAVE := true;

        IF rec.GetFilter("Agreement Type") = 'WORKDAYS' then
            WORKDAYS := true;
    end;

    var
        AGREEDLEAVE: Boolean;
        WORKDAYS: Boolean;

}