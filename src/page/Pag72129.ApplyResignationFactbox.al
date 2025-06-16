page 72129 "Apply Resignation Factbox"
{
    ApplicationArea = All;
    Caption = 'Apply Resignation Factbox';
    PageType = ListPart;
    SourceTable = "Team LookUp";
    InsertAllowed = false;
    DeleteAllowed = true;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Resignation ID"; Rec."Resignation ID")
                {
                    ToolTip = 'Specifies the value of the Resignation ID field.', Comment = '%';
                }
                field("Resignation Date"; Rec."Resignation Date")
                {
                    ToolTip = 'Specifies the value of the Resignation Date field.', Comment = '%';
                }
                field("Last Working Day"; Rec."Last Working Day")
                {
                    ToolTip = 'Specifies the value of the Last Working Day field.', Comment = '%';
                }
                field("Reason for Resignation"; Rec."Reason for Resignation")
                {
                    ToolTip = 'Specifies the value of the Reason for Resignation field.', Comment = '%';
                }
                field("Resignation Status"; Rec."Resignation Status")
                {
                    ToolTip = 'Specifies the value of the Resignation Status field.', Comment = '%';
                }
                field("Approved By"; Rec."Approved By")
                {
                    ToolTip = 'Specifies the value of the Approved By field.', Comment = '%';
                }
                field("Resignation Approval Date"; Rec."Resignation Approval Date")
                {
                    ToolTip = 'Specifies the value of the Approval Date field.', Comment = '%';
                }
                field("Resignation Comments"; Rec."Resignation Comments")
                {
                    ToolTip = 'Specifies the value of the Resignation Comments field.', Comment = '%';
                }
                field("Employee ID"; Rec."Employee ID")
                {
                    ToolTip = 'Specifies the value of the Employee ID field.', Comment = '%';
                    Editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(New)
            {
                ApplicationArea = All;
                Enabled = true;
                Caption = 'New';
                Image = New;
                trigger OnAction()
                var
                    TeamLookUp: Record "Team LookUp";
                    ApplyResignationLookup: Page "Apply Resignation Lookup";
                begin
                    TeamLookUp.SetFilter("Team Type", '=%1', TeamLookUp."Team Type"::"Apply Resignation");
                    TeamLookUp.SetFilter("Employee ID", '=%1', Rec."Employee ID");
                    ApplyResignationLookup.SetTableView(TeamLookUp);
                    ApplyResignationLookup.Run();
                end;
            }
        }
    }
}
