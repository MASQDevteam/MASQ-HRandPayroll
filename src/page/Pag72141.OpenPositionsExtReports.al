page 72141 "Open Positions-Ext Reports"
{
    PageType = List;
    SourceTable = "Open Position";
    ApplicationArea = All;
    Caption = 'Open Positions - Extended Reports';
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Position ID"; Rec."Position ID") { ApplicationArea = All; }
                field("Title"; Rec.Title) { ApplicationArea = All; }
                field(Department; Rec.Department) { ApplicationArea = All; }
                field("Department Name"; Rec."Department Name") { ApplicationArea = All; }
                field("Reports To"; Rec."Reports To") { ApplicationArea = All; }
                field("Is Open"; Rec."Is Open") { ApplicationArea = All; }
            }
        }
    }

    trigger OnOpenPage()
    var
        Emp: Record "Employee";
        FilterStr: Text;
    begin
        Rec.FilterGroup(2);
        Rec.SetFilter("Is Open", '=%1', true);
    end;
}
