page 72136 "ID Cards Expiring Lookup"
{
    ApplicationArea = All;
    Caption = 'ID Cards Expiring Lookup';
    PageType = List;
    SourceTable = IDCardTracking;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("ID Type"; Rec."ID Type")
                {
                    ToolTip = 'Specifies the value of the ID Type field.', Comment = '%';
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ToolTip = 'Specifies the value of the Expiry Date field.', Comment = '%';
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        Rec."ID Status" := CalcStatus();
                    end;
                }
                field("ID Status"; Rec."ID Status")
                {
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.', Comment = '%';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.', Comment = '%';
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        Employee: Record Employee;
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        Employee.SetRange("No.", UserSetup."Employee No.");
        if Employee.FindFirst() then begin
            Rec.Validate("Employee No.", Employee."No.");
        end;
    end;

    local procedure CalcStatus(): Text
    var
        DaysLeft: Integer;
    begin
        DaysLeft := Rec."Expiry Date" - Today;

        if DaysLeft < 0 then
            exit('Expired')
        else if DaysLeft <= 30 then
            exit('Expiring Soon')
        else
            exit('Valid');
    end;
}
