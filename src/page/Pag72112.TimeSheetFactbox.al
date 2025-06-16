page 72112 TimeSheetFactbox
{
    ApplicationArea = All;
    Caption = 'TimeSheetFactbox';
    PageType = ListPart;
    SourceTable = "Time Sheet Header";
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Resource No."; Rec."Resource No.")
                {
                    ApplicationArea = All;
                }
                field("Resource Name"; Rec."Resource Name")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.';
                }

                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                }

                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;

                }

                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = All;

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
                ApplicationArea = Jobs;
                Caption = 'New';
                Image = NewTimesheet;
                // RunObject = Report "Create Time Sheets";
                ToolTip = 'Create new time sheets for resources.';
                trigger OnAction()
                var
                    Resource: Record Resource;
                begin
                    Resource.SetRange("No.", Rec."Resource No.");
                    Report.RunModal(Report::"Create Time Sheets", true, true, Resource);
                end;
            }
        }
    }
}
