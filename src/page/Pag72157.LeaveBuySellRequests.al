page 72157 "Leave Buy Sell Requests"
{
    PageType = List;
    SourceTable = "Leave Buy Sell Request";
    ApplicationArea = All;
    Caption = 'Buy/Sell Leave Requests';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request ID"; Rec."Request ID") { ApplicationArea = All; }
                field("Employee No."; Rec."Employee No.") { ApplicationArea = All; }
                field("Employee Name"; Rec."Employee Name") { ApplicationArea = All; }
                field("Request Type"; Rec."Request Type") { ApplicationArea = All; }
                field("Leave Type"; Rec."Leave Type") { ApplicationArea = All; }
                field("Number of Days"; Rec."Number of Days") { ApplicationArea = All; }
                field("Status"; Rec."Status") { ApplicationArea = All; }
                field("Request Date"; Rec."Request Date") { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Approve)
            {
                Caption = 'Approve';
                ApplicationArea = All;
                Image = Approve;
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Approved;
                    Rec.Modify(true);
                end;
            }
            action(Reject)
            {
                Caption = 'Reject';
                ApplicationArea = All;
                Image = Cancel;
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Rejected;
                    Rec.Modify(true);
                end;
            }
        }
    }
}
