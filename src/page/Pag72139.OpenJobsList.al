page 72139 "Open Jobs List"
{
    PageType = List;
    SourceTable = "Open Job";
    ApplicationArea = All;
    Caption = 'Open Jobs';
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job ID"; Rec."Job ID") { ApplicationArea = All; }
                field("Job Title"; Rec."Job Title") { ApplicationArea = All; }
                field("Posting Date"; Rec."Posting Date") { ApplicationArea = All; }
                field("Closing Date"; Rec."Closing Date") { ApplicationArea = All; }
                field("Is Active"; Rec."Is Active") { ApplicationArea = All; }
                field("Linked Position ID"; Rec."Linked Position ID") { ApplicationArea = All; }
            }
        }
    }
    trigger OnOpenPage()
    var
        Emp: Record "Employee";
        FilterStr: Text;
    begin
        Rec.FilterGroup(2);
        Rec.SetFilter("Is Active", '=%1', true);
    end;
}
