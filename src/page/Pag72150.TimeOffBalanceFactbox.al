page 72150 "Time Off Balance Factbox"
{
    ApplicationArea = All;
    Caption = 'Time Off Balance Factbox';
    PageType = ListPart;
    SourceTable = "Request Time Off";
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Request Time Off Code"; Rec."Request Time Off Code")
                {
                    ToolTip = 'Specifies the value of the Request Time Off Code field.', Comment = '%';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.', Comment = '%';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Start Time"; Rec."Start Time")
                {
                    ToolTip = 'Specifies the value of the Start Time field.', Comment = '%';
                }
                field("End Time"; Rec."End Time")
                {
                    ToolTip = 'Specifies the value of the End Time field.', Comment = '%';
                }
                field(Reason; Rec.Reason)
                {
                    ToolTip = 'Specifies the value of the Reason field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Request Date"; Rec."Request Date")
                {
                    ToolTip = 'Specifies the value of the Request Date field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
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
                    RequestTimeOff: Record "Request Time Off";
                    RequestTimeOffPage: Page "Request Time Off Lookup";
                begin
                    RequestTimeOff.SetRange("Employee No.", Rec."Employee No.");
                    RequestTimeOffPage.SetTableView(RequestTimeOff);
                    RequestTimeOffPage.Run();
                end;
            }
        }
    }
}
