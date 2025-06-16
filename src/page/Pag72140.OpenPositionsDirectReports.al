page 72140 "Open Positions-Direct Reports"
{
    PageType = List;
    SourceTable = "Open Position";
    ApplicationArea = All;
    Caption = 'Open Positions - Direct Reports';
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
    begin
        UserSetup.Get(UserId);
        Rec.FilterGroup(2);
        Rec.SetFilter("Reports To", UserSetup."Employee No.");
        Rec.SetFilter("Is Open", '=%1', true);
    end;

    var
        UserSetup: Record "User Setup";
}
