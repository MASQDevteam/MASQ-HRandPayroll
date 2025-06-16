tableextension 72100 "Employee Ext" extends Employee
{
    fields
    {
        modify("Birth Date")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                if Rec."Birth Date" <> 0D then
                    Rec."Birthday Date" := GetBirthdayDate();
            end;
        }
        field(72100; "Basic Salary"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Monthly Salary';
            trigger OnValidate()
            var
                SalaryVariation: Record "Salary Variation";
                CompensationStructure: Record "Compensation Structure";
            begin
                if (Rec."Basic Salary" <> 0) and (xRec."Basic Salary" > Rec."Basic Salary") then
                    Error('Can''t decrease the salary!');

                // CompensationStructure.Get(Rec."Compensation Code");

                // if CompensationStructure.Active = true then
                //     if (Rec."Basic Salary" <> 0) and ((Rec."Basic Salary" < CompensationStructure."Min Salary") or (Rec."Basic Salary" > CompensationStructure."Max Salary")) then begin
                //         Error('Please give salary based on employee grades!');
                //     end;

                Clear(SalaryVariation);
                SalaryVariation.Init();
                SalaryVariation."Employee No" := Rec."No.";
                SalaryVariation."Old Salary" := xRec."Basic Salary";
                SalaryVariation.Validate("New Salary", Rec."Basic Salary");
                SalaryVariation."Created By" := UserId;
                SalaryVariation.Insert(true);

                Clear(SalaryVariation);
                if SalaryVariation.FindLast() then begin
                    Rec."Last Increase Amount" := 'Last increase amount\' + Format(SalaryVariation."Last Increase Amount");
                    Rec."Last Increase percent" := 'Last increase percent\' + Format(SalaryVariation."Last Increase percent");
                end;
            end;
        }
        field(72101; "Seniority date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(72102; "Years in Position"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(72103; "Nb of Previous positions"; Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(72104; "Position"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Position Lookup"."Code";
        }
        field(72105; "Seniority Date Text"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(72106; "Birth Date Text"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(72108; "Reports To"; Code[50])
        {
            Caption = 'Reports To';
            DataClassification = CustomerContent;
            TableRelation = Employee;
        }
        field(72109; "Compensation Code"; Code[20])
        {
            TableRelation = "Compensation Structure";
        }
        field(72110; "Grade"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Compensation Structure"."Job Grade" where("Compensation Code" = field("Compensation Code")));
        }
        field(72111; "Last Increase Amount"; Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(72112; "Compensation Type"; Option)
        {
            Editable = false;
            OptionMembers = "Fixed","Variable";
            FieldClass = FlowField;
            CalcFormula = lookup("Compensation Structure"."Compensation Type" where("Compensation Code" = field("Compensation Code")));
        }

        field(72113; "Birthday Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(72114; "Last Increase percent"; Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(72115; "Passport No. 1"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(72116; "Passport No. 2"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(72117; "Preferred Language"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Language.Name;
            ValidateTableRelation = false;
        }
        field(72118; "Agreements"; Integer)
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = count("HR Employee Agreements" where("Employee No." = field("No.")));
            // trigger OnLookup()
            // var
            //     HREmployeeAgreements: Record "HR Employee Agreements";
            // begin
            //     Clear(HREmployeeAgreements);
            //     HREmployeeAgreements.SetRange("Employee No.", Rec."No.");
            //     Page.Run(page::"HR Employee Agreement", HREmployeeAgreements);
            // end;
        }
    }
    fieldgroups
    {
        addlast(Brick; Position, "Years in Position", "Seniority Date Text", "Birth Date Text", "Nb of Previous positions", "Compensation Code", "Basic Salary", "Last Increase Amount", "Last Increase percent") { }
    }
    procedure GetBirthdayDate(): Date
    var
        BirthDate: Date;
        CurrentYear: Integer;
        BirthMonth: Integer;
        BirthDay: Integer;
    begin
        BirthDate := Rec."Birth Date";
        if BirthDate = 0D then
            exit(0D);

        CurrentYear := Date2DMY(Today, 3);
        BirthMonth := Date2DMY(BirthDate, 2);
        BirthDay := Date2DMY(BirthDate, 1);

        // Handle leap year case for Feb 29
        if (BirthMonth = 2) and (BirthDay = 29) and not IsLeapYear(CurrentYear) then
            exit(DMY2Date(28, 2, CurrentYear));

        exit(DMY2Date(BirthDay, BirthMonth, CurrentYear));
    end;

    // Optional helper function
    local procedure IsLeapYear(Year: Integer): Boolean
    begin
        exit((Year mod 4 = 0) and ((Year mod 100 <> 0) or (Year mod 400 = 0)));
    end;
}
