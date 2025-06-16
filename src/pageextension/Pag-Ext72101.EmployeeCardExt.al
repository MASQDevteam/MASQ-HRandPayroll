pageextension 72101 "Employee Card Ext" extends "Employee Card"
{
    layout
    {
        modify("Job Title")
        {
            Visible = false;
        }
        modify("Birth Date")
        {
            trigger OnAfterValidate()
            var
                PositionVariation: Record "Position Variation";
            begin
                Clear(PositionVariation);
                PositionVariation.SetRange("Employee No", Rec."No.");
                if PositionVariation.FindFirst() then begin
                    Rec."Birth Date Text" := 'BD: ' + Format(Rec."Birth Date", 0, 0);
                    Rec.Modify();
                end;
            end;
        }
        addafter("Birth Date")
        {
            field("Position"; Rec."Position")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Position field.';

                trigger OnValidate()
                var
                    PositionVariation: Record "Position Variation";
                    nbofpreviousPos: Integer;
                begin
                    Clear(PositionVariation);
                    PositionVariation.Init();
                    PositionVariation."Employee No" := Rec."No.";
                    PositionVariation."Old Position" := xRec.Position;
                    PositionVariation."New Position" := Rec."Position";
                    PositionVariation."Created By" := UserId;
                    PositionVariation.Insert(true);

                    Clear(PositionVariation);
                    PositionVariation.SetRange("Employee No", Rec."No.");
                    if PositionVariation.FindFirst() then begin
                        nbofpreviousPos := PositionVariation.Count() - 1;
                    end;
                    Rec."Nb of Previous positions" := 'Nb of Previous Positions: ' + Format(nbofpreviousPos);
                    Rec.Modify();
                end;
            }
            field("Years in Position"; Rec."Years in Position")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Years in Position field.';
            }
            field("Nb of Previous Positions"; Rec."Nb of Previous positions")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Nb of Previous Positions field.';
            }
            field("Reports To"; Rec."Reports To")
            {
                ApplicationArea = All;
            }
            field("Compensation Code"; Rec."Compensation Code")
            {
                ApplicationArea = All;
            }
            field("Compensation Type"; Rec."Compensation Type")
            {
                ApplicationArea = All;
            }
            field(Grade; Rec.Grade)
            {
                ApplicationArea = All;
            }
            field("Last Increase Amount"; Rec."Last Increase Amount")
            {
                ApplicationArea = All;
                MultiLine = true;
            }
            field("Last Increase percent"; Rec."Last Increase percent")
            {
                ApplicationArea = All;
                MultiLine = true;
            }
        }

        addbefore("Attached Documents List")
        {
            part("Position Variation"; "Position Variation")
            {
                ApplicationArea = All;
                SubPageLink = "Employee No" = field("No.");

            }
            part("Salary Variation"; "Salary Variation")
            {
                ApplicationArea = All;
                SubPageLink = "Employee No" = field("No.");
            }
        }
        addafter("Birth Date")
        {
            field("Birthday Date"; Rec."Birthday Date")
            {
                ApplicationArea = All;
            }
            field("Basic Salary"; Rec."Basic Salary")
            {
                ApplicationArea = All;
            }
            field("Seniority Date"; Rec."Seniority date")
            {
                ApplicationArea = All;
                trigger OnValidate()
                var
                    PositionVariation: Record "Position Variation";
                begin
                    Clear(PositionVariation);
                    PositionVariation.SetRange("Employee No", Rec."No.");
                    if PositionVariation.FindFirst() then begin
                        Rec."Seniority Date Text" := 'SD: ' + Format(Rec."Seniority date", 0, 0);
                        Rec.Modify();
                    end;
                end;
            }
            field("Passport No. 1"; Rec."Passport No. 1")
            {
                ApplicationArea = All;
            }
            field("Passport No. 2"; Rec."Passport No. 2")
            {
                ApplicationArea = All;
            }
            field("Preferred Language"; Rec."Preferred Language")
            {
                ApplicationArea = All;
            }

        }
        addafter("Salespers./Purch. Code")
        {
            field(Agreements; Rec.Agreements)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Agreements field.', Comment = '%';
            }
        }
    }
    actions
    {
        addlast(navigation)
        {
            action("RequestNewEmployee")
            {
                Caption = 'Request New Employee';
                ApplicationArea = All;
                ToolTip = 'Create a request for a new employee.';
                Image = Add;
                Visible = ShowempActions;
                RunObject = page "Employee Card";
                RunPageMode = Create;
            }
            action("RequestNewPosition")
            {
                Caption = 'Request New Position';
                ApplicationArea = All;
                ToolTip = 'Create a request for a new position.';
                Image = Add;
                Visible = ShowempActions;
                RunObject = page "Request New Position";
                // trigger OnAction()
                // var
                //     HRRequest: Record "HR Request";
                //     RequestNewPosition: Page "Request New Position";
                //     EmployeeList: Page "Employee List";
                //     Employee: Record Employee;
                // begin
                //     CurrPage.SetSelectionFilter(Rec);
                //     if Rec.FindFirst() then begin
                //         HRRequest.SetRange("Employee No.", Rec."No.");
                //         RequestNewPosition.SetTableView(HRRequest);
                //         RequestNewPosition.Run();
                //     end;
                // end;
            }
        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        LastPositionDate: Date;
        PositionVariation: Record "Position Variation";
    begin
        Clear(PositionVariation);
        PositionVariation.SetRange("Employee No", Rec."No.");
        if PositionVariation.FindLast() then begin
            LastPositionDate := DT2Date(PositionVariation.SystemCreatedAt);
            if LastPositionDate = 0D then begin
                Rec."Years in Position" := 'Years in position: 0';
            end else
                Rec."Years in Position" := 'Years in position: ' + Format(Date2DMY(Today, 3) - Date2DMY(LastPositionDate, 3));
            //Rec."Years in Position" := 'Years in position: ' + Format(Date2DMY(CalcDate('<+1Y>', Today), 3) - Date2DMY(LastPositionDate, 3));
            Rec.Modify();
        end;
    end;

    trigger OnAfterGetRecord()
    var
        LastPositionDate: Date;
        PositionVariation: Record "Position Variation";
    begin
        Clear(PositionVariation);
        PositionVariation.SetRange("Employee No", Rec."No.");
        if PositionVariation.FindLast() then begin
            LastPositionDate := DT2Date(PositionVariation.SystemCreatedAt);
            if LastPositionDate = 0D then begin
                Rec."Years in Position" := 'Years in position: 0';
            end else
                Rec."Years in Position" := 'Years in position: ' + Format(Date2DMY(Today, 3) - Date2DMY(LastPositionDate, 3));
            //Rec."Years in Position" := 'Years in position: ' + Format(Date2DMY(CalcDate('<+1Y>', Today), 3) - Date2DMY(LastPositionDate, 3));
            Rec.Modify();
        end;
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        UserSetup.Get(UserId);
        ShowempActions := UserSetup."Show Emp Actions";
    end;

    var
        UserSetup: Record "User Setup";
        ShowempActions: Boolean;
}
