table 72104 "Leave Request Header"
{
    Caption = 'Leave Request Header ';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Request No."; Code[20])
        {
            Caption = 'Request ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Employee ID"; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if Employee.Get("Employee ID") then begin
                    if Rec."Employee ID" <> '' then begin
                        Rec."Employee Name" := Employee."First Name";
                        Rec."Reports To" := Employee."Reports To";
                        UpdateOrigBalanceAmount("Employee ID");
                        Rec.Balance := Rec."Original Balance";
                        UpdateBalance();
                    end;
                end
                else begin
                    Rec."Employee Name" := '';
                    Rec."Reports To" := '';
                    Rec."Original Balance" := 0;
                    Rec.Balance := 0;
                end;
            end;
        }

        field(3; "Leave Type"; Code[50])
        {
            Caption = 'Leave Type';
            DataClassification = ToBeClassified;
            TableRelation = "Type Lookup".Code where("Leave Request Type" = filter("Leave Request Type"::"Leave Type"));
        }
        field(4; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "End Date" <> 0D then
                    if "End Date" < "Start Date" then
                        Error('End Date cannot be earlier than Start Date.');
                ValidateLeaveOverlap();
                if Rec."End Date" <> 0D then
                    GenerateLeaveLines("Employee ID");
            end;
        }
        field(5; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "End Date" <> 0D then
                    if "End Date" < "Start Date" then
                        Error('End Date cannot be earlier than Start Date.');
                ValidateLeaveOverlap();
                if Rec."Start Date" <> 0D then
                    GenerateLeaveLines("Employee ID")
                else
                    Error('Please fill Start Date');
            end;
        }
        field(6; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = Pending,Approved,Rejected;
            DataClassification = ToBeClassified;
        }
        field(7; "Reason"; Text[250])
        {
            Caption = 'Reason';
            DataClassification = ToBeClassified;
            TableRelation = "Type Lookup".Code where("Leave Request Type" = filter("Leave Request Type"::"Reason Code"));
        }
        field(8; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(9; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            DataClassification = ToBeClassified;
        }
        field(10; "Original Balance"; Decimal)
        {
            Caption = 'Original Balance';
            Editable = false;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Rec."Remaining Balance" := Rec.Balance - Rec."Requested Amount";
            end;
        }
        field(11; "Requested Amount"; Decimal)
        {
            Caption = 'Requested Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Leave Request Line"."Requested Amount" where("Request No." = field("Request No.")));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Rec."Remaining Balance" := Rec.Balance - Rec."Requested Amount";
            end;
        }
        field(12; "Remaining Balance"; Decimal)
        {
            Caption = 'Remaining Balance';
            Editable = false;
        }
        field(13; "Reports To"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
            Editable = false;
        }
        field(14; "Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Request No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        NoSeries: Codeunit "No. Series";
        NoSeriesCode: Code[20];
        IsHandled: Boolean;
        HumanResourcesSetup: Record "Human Resources Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        LeaveRequestHeader: Record "Leave Request Header";
    begin
        //    if "Number" = '' then begin
        HumanResourcesSetup.Get();
        HumanResourcesSetup.TestField("Leave Request No. Series");
        NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(HumanResourcesSetup."Leave Request No. Series", xRec."No. Series", 0D, Rec."Request No.", Rec."No. Series", IsHandled);
        //  if not IsHandled then begin
        if NoSeries.AreRelated(HumanResourcesSetup."Leave Request No. Series", xRec."No. Series") then
            Rec."No. Series" := xRec."No. Series"
        else
            Rec."No. Series" := HumanResourcesSetup."Leave Request No. Series";

        Rec."Request No." := NoSeries.GetNextNo(Rec."No. Series");
        LeaveRequestHeader.ReadIsolation(IsolationLevel::ReadUncommitted);
        LeaveRequestHeader.SetLoadFields("Request No.");
        while LeaveRequestHeader.Get(Rec."Request No.") do
            Rec."Request No." := NoSeries.GetNextNo(Rec."No. Series");
        NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(Rec."No. Series", HumanResourcesSetup."Leave Request No. Series", 0D, Rec."Request No.");
        //   end;
        //  end;
    end;

    procedure GenerateLeaveLines(EmployeeNo: Code[20])
    var

        DayDate: Date;

        SkipLine: Boolean;
        RequestedAmount: Decimal;
        EmployeeWorkdayAgreement: Record "HR Employee Agreements";
        WorkdayAgreement: Record "HR Agreements";
        LeaveLine: Record "Leave Request Line";
        LineNo: Integer;
    begin
        bal := Rec.Balance;
        RequestedAmount := 0;
        SkipLine := false;
        TestField("Leave Type");
        // Delete existing lines first
        Clear(LeaveLine);
        LeaveLine.SetRange("Request No.", Rec."Request No.");
        LeaveLine.DeleteAll();

        // Initialize values
        DayDate := Rec."Start Date";


        Clear(EmployeeWorkdayAgreement);
        EmployeeWorkdayAgreement.SetRange("Employee No.", EmployeeNo);
        EmployeeWorkdayAgreement.SetRange(Status, EmployeeWorkdayAgreement.Status::Active);
        EmployeeWorkdayAgreement.SetRange("Agreement Type", 'WORKDAYS');

        IF EmployeeWorkdayAgreement.FindFirst() then begin

            Clear(WorkdayAgreement);
            WorkdayAgreement.Get('WORKDAYS', EmployeeWorkdayAgreement."Agreement Structure");
            while DayDate <= Rec."End Date" do begin
                // Skip if the day is Friday (Friday = 5)
                //   if Date2DWY(DayDate, 1) <> 5 then begin
                SkipLine := false;
                IF (WorkdayAgreement.Monday = WorkdayAgreement.Monday::OFF) AND (GetDayName(DayDate) = 'Monday') then
                    SkipLine := true;

                IF (WorkdayAgreement.Tuesday = WorkdayAgreement.Tuesday::OFF) AND (GetDayName(DayDate) = 'Tuesday') then
                    SkipLine := true;

                IF (WorkdayAgreement.Wednesday = WorkdayAgreement.Wednesday::OFF) AND (GetDayName(DayDate) = 'Wednesday') then
                    SkipLine := true;

                IF (WorkdayAgreement.Thursday = WorkdayAgreement.Thursday::OFF) AND (GetDayName(DayDate) = 'Thursday') then
                    SkipLine := true;

                IF (WorkdayAgreement.Friday = WorkdayAgreement.Friday::OFF) AND (GetDayName(DayDate) = 'Friday') then
                    SkipLine := true;

                IF (WorkdayAgreement.Saturday = WorkdayAgreement.Saturday::OFF) AND (GetDayName(DayDate) = 'Saturday') then
                    SkipLine := true;

                IF (WorkdayAgreement.Sunday = WorkdayAgreement.Sunday::OFF) AND (GetDayName(DayDate) = 'Sunday') then
                    SkipLine := true;

                IF NOT SkipLine then begin
                    LeaveLine.Reset();
                    LeaveLine.Init();
                    LeaveLine."Request No." := Rec."Request No.";
                    LeaveLine."Line No." := LineNo * 10000;
                    LeaveLine."Request Date" := DayDate;
                    LeaveLine.Day := GetDayName(DayDate);
                    LeaveLine."Leave Type" := Rec."Leave Type";

                    //full day work
                    IF ((WorkdayAgreement.Monday = WorkdayAgreement.Monday::WORK) OR (WorkdayAgreement.Monday = WorkdayAgreement.Monday::WFH)) AND (GetDayName(DayDate) = 'Monday') then
                        LeaveLine."Requested Amount" := 1.00;

                    IF ((WorkdayAgreement.Tuesday = WorkdayAgreement.Tuesday::WORK) OR (WorkdayAgreement.Tuesday = WorkdayAgreement.Tuesday::WFH)) AND (GetDayName(DayDate) = 'Tuesday') then
                        LeaveLine."Requested Amount" := 1.00;

                    IF ((WorkdayAgreement.Wednesday = WorkdayAgreement.Wednesday::WORK) OR (WorkdayAgreement.Wednesday = WorkdayAgreement.Wednesday::WFH)) AND (GetDayName(DayDate) = 'Wednesday') then
                        LeaveLine."Requested Amount" := 1.00;

                    IF ((WorkdayAgreement.Thursday = WorkdayAgreement.Thursday::WORK) OR (WorkdayAgreement.Thursday = WorkdayAgreement.Thursday::WFH)) AND (GetDayName(DayDate) = 'Thursday') then
                        LeaveLine."Requested Amount" := 1.00;

                    IF ((WorkdayAgreement.Friday = WorkdayAgreement.Friday::WORK) OR (WorkdayAgreement.Friday = WorkdayAgreement.Friday::WFH)) AND (GetDayName(DayDate) = 'Friday') then
                        LeaveLine."Requested Amount" := 1.00;

                    IF ((WorkdayAgreement.Saturday = WorkdayAgreement.Saturday::WORK) OR (WorkdayAgreement.Saturday = WorkdayAgreement.Saturday::WFH)) AND (GetDayName(DayDate) = 'Saturday') then
                        LeaveLine."Requested Amount" := 1.00;

                    IF ((WorkdayAgreement.Sunday = WorkdayAgreement.Sunday::WORK) OR (WorkdayAgreement.Sunday = WorkdayAgreement.Sunday::WFH)) AND (GetDayName(DayDate) = 'Sunday') then
                        LeaveLine."Requested Amount" := 1.00;

                    //half day work
                    IF ((WorkdayAgreement.Monday = WorkdayAgreement.Monday::HALFDAYWORK) OR (WorkdayAgreement.Monday = WorkdayAgreement.Monday::WFHP)) AND (GetDayName(DayDate) = 'Monday') then
                        LeaveLine."Requested Amount" := 0.50;

                    IF ((WorkdayAgreement.Tuesday = WorkdayAgreement.Tuesday::HALFDAYWORK) OR (WorkdayAgreement.Tuesday = WorkdayAgreement.Tuesday::WFHP)) AND (GetDayName(DayDate) = 'Tuesday') then
                        LeaveLine."Requested Amount" := 0.50;

                    IF ((WorkdayAgreement.Wednesday = WorkdayAgreement.Wednesday::HALFDAYWORK) OR (WorkdayAgreement.Wednesday = WorkdayAgreement.Wednesday::WFHP)) AND (GetDayName(DayDate) = 'Wednesday') then
                        LeaveLine."Requested Amount" := 0.05;

                    IF ((WorkdayAgreement.Thursday = WorkdayAgreement.Thursday::HALFDAYWORK) OR (WorkdayAgreement.Thursday = WorkdayAgreement.Thursday::WFHP)) AND (GetDayName(DayDate) = 'Thursday') then
                        LeaveLine."Requested Amount" := 0.50;

                    IF ((WorkdayAgreement.Friday = WorkdayAgreement.Friday::HALFDAYWORK) OR (WorkdayAgreement.Friday = WorkdayAgreement.Friday::WFHP)) AND (GetDayName(DayDate) = 'Friday') then
                        LeaveLine."Requested Amount" := 0.50;

                    IF ((WorkdayAgreement.Saturday = WorkdayAgreement.Saturday::HALFDAYWORK) OR (WorkdayAgreement.Saturday = WorkdayAgreement.Saturday::WFHP)) AND (GetDayName(DayDate) = 'Saturday') then
                        LeaveLine."Requested Amount" := 0.50;

                    IF ((WorkdayAgreement.Sunday = WorkdayAgreement.Sunday::HALFDAYWORK) OR (WorkdayAgreement.Sunday = WorkdayAgreement.Sunday::WFHP)) AND (GetDayName(DayDate) = 'Sunday') then
                        LeaveLine."Requested Amount" := 0.50;
                    bal := bal - LeaveLine."Requested Amount";
                    LeaveLine.Balance := bal;
                    LeaveLine.Insert();
                    LineNo += 1;
                    //
                    //    end;

                    //LeaveLine."Requested Amount" += 1;

                end;
                DayDate := DayDate + 1;

            end;
        end;

        Clear(LeaveLine);
        LeaveLine.SetRange("Request No.", Rec."Request No.");
        LeaveLine.CalcSums("Requested Amount");
        Rec.Validate("Requested Amount", LeaveLine."Requested Amount");
        Rec.Modify();

    end;



    procedure GetDayName(D: Date): Text[20]
    var
        DayOfWeek: Integer;
    begin
        // Returns: 1 = Monday, ..., 7 = Sunday
        DayOfWeek := Date2DWY(D, 1);

        case DayOfWeek of
            1:
                exit('Monday');
            2:
                exit('Tuesday');
            3:
                exit('Wednesday');
            4:
                exit('Thursday');
            5:
                exit('Friday');
            6:
                exit('Saturday');
            7:
                exit('Sunday');
            else
                exit('Unknown');
        end;
    end;



    local procedure UpdateOrigBalanceAmount(EmployeeNo: Code[20])
    var
        EmployeeRec: Record Employee;
        EmployeeleaveAgreement: Record "HR Employee Agreements";
        YearsBetween: Decimal;
        leaveAgreement: Record "HR Agreements";
    begin
        Clear(EmployeeleaveAgreement);
        EmployeeleaveAgreement.SetRange("Employee No.", EmployeeNo);
        EmployeeleaveAgreement.SetRange(Status, EmployeeleaveAgreement.Status::Active);
        EmployeeleaveAgreement.SetRange("Agreement Type", 'AGREED LEAVE');

        IF EmployeeleaveAgreement.FindFirst() then begin

            Clear(leaveAgreement);
            leaveAgreement.Get('AGREED LEAVE', EmployeeleaveAgreement."Agreement Structure");

            Clear(EmployeeRec);
            EmployeeRec.Get(EmployeeNo);
            EmployeeRec.TestField("Employment Date");
            IF EmployeeRec."Employment Date" > Today then
                Error('Employement Date is in the future');

            YearsBetween := DATE2DMY(Today, 3) - DATE2DMY(EmployeeRec."Employment Date", 3);
            if YearsBetween < 3 then
                Rec."Original Balance" := leaveAgreement."from 1-3 years" else
                if YearsBetween in [3 .. 6] then
                    Rec."Original Balance" := leaveAgreement."from 3-6"
                else
                    IF YearsBetween > 6 then
                        Rec."Original Balance" := leaveAgreement."Above 6"
                    else
                        Rec."Original Balance" := 0;
        end;
    end;

    local procedure UpdateBalance()
    var
        LeaveRequestHeader: Record "Leave Request Header";
    begin
        bal := 0;
        LeaveRequestHeader.SetFilter("Request No.", '<>%1', Rec."Request No.");
        LeaveRequestHeader.SetRange("Employee ID", Rec."Employee ID");
        LeaveRequestHeader.SetRange(Status, LeaveRequestHeader.Status::Approved);
        if LeaveRequestHeader.FindLast() then begin
            Rec.Balance := LeaveRequestHeader."Remaining Balance";
            Rec.Modify();
        end;
    end;

    procedure ValidateLeaveOverlap()
    var
        LeaveRequestRec: Record "Leave Request Header";
    begin
        LeaveRequestRec.Reset();
        LeaveRequestRec.SetRange("Employee ID", Rec."Employee ID");
        LeaveRequestRec.SetRange(Status, LeaveRequestRec.Status::Approved);
        if LeaveRequestRec.FindSet() then begin
            repeat
                if ("Start Date" <= LeaveRequestRec."End Date") and
                   ("End Date" >= LeaveRequestRec."Start Date") then
                    Error(
                        'You already have an approved leave request from %1 to %2.',
                        LeaveRequestRec."Start Date", LeaveRequestRec."End Date");
            until LeaveRequestRec.Next() = 0;
        end;
    end;

    var
        bal: Decimal;
}
