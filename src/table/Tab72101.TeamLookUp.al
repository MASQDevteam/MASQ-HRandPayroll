table 72101 "Team LookUp"
{
    Caption = 'Team LookUp';
    DataClassification = ToBeClassified;
    LookupPageId = "Employee Tasks Lookup";
    fields
    {
        field(1; "Primary Key"; Integer)
        {
            AutoIncrement = true;
        }
        field(8; "Team Type"; enum "Team Lookup")
        {
            Caption = 'Team Type';
            DataClassification = ToBeClassified;
        }

        // Team skills assessment
        field(2; "Skill ID"; Code[20])
        {
            Caption = 'Skill ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(200; "Skill Code"; Code[20])
        {
            Caption = 'Skill Code';
            DataClassification = ToBeClassified;
            TableRelation = "Data Lookup".Code where(Type = filter("Skills assesment"));
            trigger OnValidate()
            var
                DataLookup: Record "Data Lookup";
            begin
                if Rec."Skill Code" <> '' then begin
                    DataLookup.SetRange(Code, Rec."Skill Code");
                    if DataLookup.FindFirst() then begin
                        Rec."Skill Name" := DataLookup.Description;
                    end;
                end
                else
                    Rec."Skill Name" := '';
            end;
        }
        field(3; "Skill Name"; Text[100])
        {
            Caption = 'Skill Name';
            DataClassification = ToBeClassified;
        }
        field(4; "Skill Level"; Option)
        {
            Caption = 'Skill Level';
            OptionMembers = Beginner,Intermediate,Advanced,Expert;
            DataClassification = ToBeClassified;
        }
        field(5; "Skill Assessment Date"; Date)
        {
            Caption = 'Skill Assessment Date';
            DataClassification = ToBeClassified;
        }
        field(6; "Assessed By"; Code[20])
        {
            Caption = 'Assessed By';
            DataClassification = ToBeClassified;
            TableRelation = "Employee"."First Name";
            ValidateTableRelation = false;
        }
        field(7; "Skill Comments"; Text[250])
        {
            Caption = 'Skill Comments';
            DataClassification = ToBeClassified;
        }


        // Team performance reviews
        field(10; "Team Performance ID"; Code[20])
        {
            Caption = 'Team Performance ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Performance Score"; Option)
        {
            Caption = 'Performance Score';
            DataClassification = ToBeClassified;
            OptionMembers = "1","2","3","4","5","6","7","8","9","10";
        }
        field(12; "Performance Comments"; Text[250])
        {
            Caption = 'Performance Comments';
            DataClassification = ToBeClassified;
        }
        field(13; "Review Date"; Date)
        {
            Caption = 'Review Date';
            DataClassification = ToBeClassified;
        }
        field(14; "Reviewer"; Code[20])
        {
            Caption = 'Reviewer';
            DataClassification = ToBeClassified;
            TableRelation = "Employee"."First Name";
            ValidateTableRelation = false;
        }
        field(15; "Improvement Plan"; Text[250])
        {
            Caption = 'Improvement Plan';
            DataClassification = ToBeClassified;
        }
        field(16; "Review Status"; Option)
        {
            Caption = 'Review Status';
            OptionMembers = Draft,InProgress,Completed;
            DataClassification = ToBeClassified;
        }


        // Team performance journals
        field(20; "Journal ID"; Code[20])
        {
            Caption = 'Journal ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "Journal Date"; Date)
        {
            Caption = 'Journal Date';
            DataClassification = ToBeClassified;
        }
        field(22; "Journal Description"; Text[250])
        {
            Caption = 'Journal Description';
            DataClassification = ToBeClassified;
        }
        field(23; "Journal Entered By"; Code[20])
        {
            Caption = 'Journal Entered By';
            DataClassification = ToBeClassified;
            TableRelation = "Employee"."First Name";
            ValidateTableRelation = false;
        }
        field(24; "Journal Comments"; Text[250])
        {
            Caption = 'Journal Comments';
            DataClassification = ToBeClassified;
        }
        field(25; "Journal Status"; Option)
        {
            Caption = 'Journal Status';
            OptionMembers = Draft,Submitted,Approved,Rejected;
            DataClassification = ToBeClassified;
        }
        field(26; "Approval Date"; Date)
        {
            Caption = 'Approval Date';
            DataClassification = ToBeClassified;
        }

        // Team performance goals
        field(37; "Goal Category"; Option)
        {
            Caption = 'Goal Category';
            OptionMembers = Individual,Team,Department,Organization;
            DataClassification = ToBeClassified;
        }
        field(38; "Goal Priority"; Option)
        {
            Caption = 'Goal Priority';
            OptionMembers = Low,Medium,High,Critical;
            DataClassification = ToBeClassified;
        }
        field(39; "Goal Progress"; Decimal)
        {
            Caption = 'Goal Progress (%)';
            DataClassification = ToBeClassified;
        }
        field(40; "Goal Last Updated"; Date)
        {
            Caption = 'Goal Last Updated';
            DataClassification = ToBeClassified;
        }
        field(30; "Goal ID"; Code[20])
        {
            Caption = 'Goal ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(31; "Goal Description"; Text[250])
        {
            Caption = 'Goal Description';
            DataClassification = ToBeClassified;
        }
        field(32; "Goal Start Date"; Date)
        {
            Caption = 'Goal Start Date';
            DataClassification = ToBeClassified;
        }
        field(33; "Goal End Date"; Date)
        {
            Caption = 'Goal End Date';
            DataClassification = ToBeClassified;
        }
        field(34; "Goal Assigned By"; Code[20])
        {
            Caption = 'Goal Assigned By';
            DataClassification = ToBeClassified;
            TableRelation = "Employee"."First Name";
            ValidateTableRelation = false;
        }
        field(35; "Goal Status"; Option)
        {
            Caption = 'Goal Status';
            OptionMembers = NotStarted,InProgress,Completed,OnHold;
            DataClassification = ToBeClassified;
        }
        field(36; "Goal Comments"; Text[250])
        {
            Caption = 'Goal Comments';
            DataClassification = ToBeClassified;
        }

        // Skill gap analysis
        field(50; "Gap ID"; Code[20])
        {
            Caption = 'Gap ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51; "Skill Required"; Text[100])
        {
            Caption = 'Skill Required';
            DataClassification = ToBeClassified;
        }
        field(52; "Current Skill Level"; Option)
        {
            Caption = 'Current Skill Level';
            OptionMembers = Beginner,Intermediate,Advanced,Expert;
            DataClassification = ToBeClassified;
        }
        field(53; "Required Skill Level"; Option)
        {
            Caption = 'Required Skill Level';
            OptionMembers = Beginner,Intermediate,Advanced,Expert;
            DataClassification = ToBeClassified;
        }
        field(54; "Gap Assessment Date"; Date)
        {
            Caption = 'Gap Assessment Date';
            DataClassification = ToBeClassified;
        }
        field(55; "Gap Assessed By"; Code[20])
        {
            Caption = 'Assessed By';
            DataClassification = ToBeClassified;
            TableRelation = "Employee"."First Name";
            ValidateTableRelation = false;
        }
        field(56; "Gap Comments"; Text[250])
        {
            Caption = 'Gap Comments';
            DataClassification = ToBeClassified;
        }
        // Certificates expiring for my attachment
        field(60; "Certificate ID"; Code[20])
        {
            Caption = 'Certificate ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(61; "Certificate Name"; Text[100])
        {
            Caption = 'Certificate Name';
            DataClassification = ToBeClassified;
        }
        field(62; "Employee ID"; Code[20])
        {
            Caption = 'Employee No';
            DataClassification = ToBeClassified;
            TableRelation = "Employee"."No.";
            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if Employee.Get("Employee ID") then begin
                    if Rec."Employee ID" <> '' then
                        Rec."Employee Name" := Employee."First Name";
                end
                else
                    Rec."Employee Name" := '';
            end;
        }
        field(63; "Expiry Date"; Date)
        {
            Caption = 'Expiry Date';
            DataClassification = ToBeClassified;
        }
        field(64; "Attachment"; Blob)
        {
            Caption = 'Attachment';
            DataClassification = ToBeClassified;
            SubType = Memo;
        }
        field(65; "Uploaded By"; Code[20])
        {
            Caption = 'Uploaded By';
            DataClassification = ToBeClassified;
            TableRelation = "Employee"."First Name";
            ValidateTableRelation = false;
        }
        field(66; "Upload Date"; DateTime)
        {
            Caption = 'Upload Date';
            DataClassification = ToBeClassified;
        }
        field(67; "Certificate Comments"; Text[250])
        {
            Caption = 'Certificate Comments';
            DataClassification = ToBeClassified;
        }
        field(68; "Attachment ID"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(69; "Document Attachment ID"; Integer)
        {

        }
        field(70; "Document Attachment Table ID"; Integer)
        {

        }
        field(71; "Document Attachment No."; Code[20])
        {

        }
        field(72; "Document Attachment Doc. Type"; Enum "Attachment Document Type")
        {

        }
        field(73; "Document Attachment Line No."; Integer)
        {
        }
        field(74; "Primary Key as Code"; Code[20])
        {
            DataClassification = SystemMetadata;
        }

        // Employee tasks
        field(80; "Task ID"; Code[20])
        {
            Caption = 'Task ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(81; "Task Description"; Text[250])
        {
            Caption = 'Task Description';
            DataClassification = ToBeClassified;
        }
        field(82; "Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(83; "Task Start Date"; Date)
        {
            Caption = 'Task Start Date';
            DataClassification = ToBeClassified;
        }
        field(88; "Task End Date"; Date)
        {
            Caption = 'Task End Date';
            DataClassification = ToBeClassified;
        }
        field(89; "Task Start Time"; Time)
        {
            Caption = 'Task Start Time';
            DataClassification = ToBeClassified;
        }
        field(122; "Task End Time"; Time)
        {
            Caption = 'Task End Time';
            DataClassification = ToBeClassified;
        }
        field(84; "Task Due Date"; Date)
        {
            Caption = 'Task Due Date';
            DataClassification = ToBeClassified;
        }
        field(85; "Task Status"; Option)
        {
            Caption = 'Task Status';
            OptionMembers = NotStarted,InProgress,Completed,OnHold;
            DataClassification = ToBeClassified;
        }
        field(86; "Task Priority"; Option)
        {
            Caption = 'Task Priority';
            OptionMembers = Low,Medium,High,Critical;
            DataClassification = ToBeClassified;
        }
        field(87; "Task Comments"; Text[250])
        {
            Caption = 'Task Comments';
            DataClassification = ToBeClassified;
        }

        // Next Registered Courses
        field(90; "Course ID"; Code[20])
        {
            Caption = 'Course ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(91; "Course Name"; Text[100])
        {
            Caption = 'Course Name';
            DataClassification = ToBeClassified;
        }
        field(92; "Course Start Date"; Date)
        {
            Caption = 'Course Start Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                GetCourseStatus();
            end;
        }
        field(93; "Course End Date"; Date)
        {
            Caption = 'Course End Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                GetCourseStatus();
            end;
        }
        field(94; "Course Status"; Option)
        {
            Caption = 'Course Status';
            OptionMembers = "Required(NotStarted)","Registered(Started)",InProgress,Completed,Cancelled;
            DataClassification = ToBeClassified;
        }
        field(95; "Course Comments"; Text[250])
        {
            Caption = 'Course Comments';
            DataClassification = ToBeClassified;
        }
        field(96; "Course Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "In-Person","Virtual";

        }
        field(97; "Is Cancelled"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Is Cancelled" = true then
                    Rec."Course Status" := Rec."Course Status"::Cancelled
                else
                    GetCourseStatus();
            end;
        }
        field(121; "Course Fees"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        // Apply Resignation
        field(100; "Resignation ID"; Code[20])
        {
            Caption = 'Resignation ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(102; "Resignation Date"; Date)
        {
            Caption = 'Resignation Date';
            DataClassification = ToBeClassified;
        }
        field(103; "Last Working Day"; Date)
        {
            Caption = 'Last Working Day';
            DataClassification = ToBeClassified;
        }
        field(104; "Reason for Resignation"; Text[250])
        {
            Caption = 'Reason for Resignation';
            DataClassification = ToBeClassified;
            TableRelation = "Data Lookup".Code where(Type = filter("Resignation Reason"));
        }
        field(105; "Resignation Status"; Option)
        {
            Caption = 'Resignation Status';
            OptionMembers = Draft,Submitted,Approved,Rejected;
            DataClassification = ToBeClassified;
        }
        field(106; "Approved By"; Code[20])
        {
            Caption = 'Approved By';
            DataClassification = ToBeClassified;
            TableRelation = "Employee"."First Name";
            ValidateTableRelation = false;
        }
        field(107; "Resignation Approval Date"; Date)
        {
            Caption = 'Approval Date';
            DataClassification = ToBeClassified;
        }
        field(108; "Resignation Comments"; Text[250])
        {
            Caption = 'Resignation Comments';
            DataClassification = ToBeClassified;
        }
        // Additional Expenses
        field(110; "Expense ID"; Code[20])
        {
            Caption = 'Expense ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(111; "Expense Type"; Text[100])
        {
            Caption = 'Expense Type';
            DataClassification = ToBeClassified;
            TableRelation = "Data Lookup".Code where(Type = filter("Expense Type"));
        }
        field(112; "Expense Amount"; Decimal)
        {
            Caption = 'Expense Amount';
            DataClassification = ToBeClassified;
        }
        field(113; "Expense Date"; Date)
        {
            Caption = 'Expense Date';
            DataClassification = ToBeClassified;
        }
        field(114; "Expense Description"; Text[250])
        {
            Caption = 'Expense Description';
            DataClassification = ToBeClassified;
        }
        field(115; "Expense Status"; Option)
        {
            Caption = 'Expense Status';
            OptionMembers = Draft,Submitted,Approved,Rejected;
            DataClassification = ToBeClassified;
        }
        field(116; "Expense Approved By"; Code[20])
        {
            Caption = 'Approved By';
            DataClassification = ToBeClassified;
            TableRelation = "Employee"."First Name";
            ValidateTableRelation = false;
        }
        field(117; "Expense Approval Date"; Date)
        {
            Caption = 'Approval Date';
            DataClassification = ToBeClassified;
        }
        field(118; "Expense Comments"; Text[250])
        {
            Caption = 'Expense Comments';
            DataClassification = ToBeClassified;
        }
        field(120; "Currency Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency.Code;
        }
        field(119; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

    }

    keys
    {
        key(PK; "Team Type", "Primary Key")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Task ID", "Task Description", "Task Due Date", "Task Status") { }
    }
    trigger OnInsert()
    var
        NoSeries: Codeunit "No. Series";
        IsHandled: Boolean;
        HumanResourcesSetup: Record "Human Resources Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        TeamLookUp: Record "Team LookUp";
    begin
        Clear(TeamLookUp);
        if "Team Type" = Rec."Team Type"::"Expiring Certificates" then begin
            HumanResourcesSetup.Get();
            HumanResourcesSetup.TestField("Certificates Expiring Nos");
            NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(HumanResourcesSetup."Certificates Expiring Nos", xRec."No. Series", 0D, Rec."Certificate ID", Rec."No. Series", IsHandled);
            //  if not IsHandled then begin
            if NoSeries.AreRelated(HumanResourcesSetup."Certificates Expiring Nos", xRec."No. Series") then
                Rec."No. Series" := xRec."No. Series"
            else
                Rec."No. Series" := HumanResourcesSetup."Certificates Expiring Nos";

            Rec."Certificate ID" := NoSeries.GetNextNo(Rec."No. Series");
            TeamLookUp.ReadIsolation(IsolationLevel::ReadUncommitted);
            TeamLookUp.SetLoadFields("Certificate ID");
            while TeamLookUp.Get(Rec."Primary Key") do
                Rec."Certificate ID" := NoSeries.GetNextNo(Rec."No. Series");
            NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(Rec."No. Series", HumanResourcesSetup."Certificates Expiring Nos", 0D, Rec."Certificate ID");
        end;

        if "Team Type" = Rec."Team Type"::"Team Skills Assessment" then begin
            HumanResourcesSetup.Get();
            HumanResourcesSetup.TestField("Skill Nos");
            NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(HumanResourcesSetup."Skill Nos", xRec."No. Series", 0D, Rec."Skill ID", Rec."No. Series", IsHandled);
            //  if not IsHandled then begin
            if NoSeries.AreRelated(HumanResourcesSetup."Skill Nos", xRec."No. Series") then
                Rec."No. Series" := xRec."No. Series"
            else
                Rec."No. Series" := HumanResourcesSetup."Skill Nos";

            Rec."Skill ID" := NoSeries.GetNextNo(Rec."No. Series");
            TeamLookUp.ReadIsolation(IsolationLevel::ReadUncommitted);
            TeamLookUp.SetLoadFields("Skill ID");
            while TeamLookUp.Get(Rec."Primary Key") do
                Rec."Skill ID" := NoSeries.GetNextNo(Rec."No. Series");
            NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(Rec."No. Series", HumanResourcesSetup."Skill Nos", 0D, Rec."Skill ID");
        end;

        if "Team Type" = Rec."Team Type"::"Team Performance Journal" then begin
            HumanResourcesSetup.Get();
            HumanResourcesSetup.TestField("Journal ID Nos");
            NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(HumanResourcesSetup."Journal ID Nos", xRec."No. Series", 0D, Rec."Journal ID", Rec."No. Series", IsHandled);
            //  if not IsHandled then begin
            if NoSeries.AreRelated(HumanResourcesSetup."Journal ID Nos", xRec."No. Series") then
                Rec."No. Series" := xRec."No. Series"
            else
                Rec."No. Series" := HumanResourcesSetup."Journal ID Nos";

            Rec."Journal ID" := NoSeries.GetNextNo(Rec."No. Series");
            TeamLookUp.ReadIsolation(IsolationLevel::ReadUncommitted);
            TeamLookUp.SetLoadFields("Journal ID");
            while TeamLookUp.Get(Rec."Primary Key") do
                Rec."Journal ID" := NoSeries.GetNextNo(Rec."No. Series");
            NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(Rec."No. Series", HumanResourcesSetup."Journal ID Nos", 0D, Rec."Journal ID");
        end;
        if "Team Type" = Rec."Team Type"::"Skill gap analysis" then begin
            HumanResourcesSetup.Get();
            HumanResourcesSetup.TestField("Gap ID Nos");
            NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(HumanResourcesSetup."Gap ID Nos", xRec."No. Series", 0D, Rec."Gap ID", Rec."No. Series", IsHandled);
            //  if not IsHandled then begin
            if NoSeries.AreRelated(HumanResourcesSetup."Gap ID Nos", xRec."No. Series") then
                Rec."No. Series" := xRec."No. Series"
            else
                Rec."No. Series" := HumanResourcesSetup."Gap ID Nos";

            Rec."Gap ID" := NoSeries.GetNextNo(Rec."No. Series");
            TeamLookUp.ReadIsolation(IsolationLevel::ReadUncommitted);
            TeamLookUp.SetLoadFields("Gap ID");
            while TeamLookUp.Get(Rec."Primary Key") do
                Rec."Gap ID" := NoSeries.GetNextNo(Rec."No. Series");
            NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(Rec."No. Series", HumanResourcesSetup."Gap ID Nos", 0D, Rec."Gap ID");
        end;
        if "Team Type" = Rec."Team Type"::"Team performance goals" then begin
            HumanResourcesSetup.Get();
            HumanResourcesSetup.TestField("Goal ID Nos");
            NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(HumanResourcesSetup."Goal ID Nos", xRec."No. Series", 0D, Rec."Goal ID", Rec."No. Series", IsHandled);
            //  if not IsHandled then begin
            if NoSeries.AreRelated(HumanResourcesSetup."Goal ID Nos", xRec."No. Series") then
                Rec."No. Series" := xRec."No. Series"
            else
                Rec."No. Series" := HumanResourcesSetup."Goal ID Nos";

            Rec."Goal ID" := NoSeries.GetNextNo(Rec."No. Series");
            TeamLookUp.ReadIsolation(IsolationLevel::ReadUncommitted);
            TeamLookUp.SetLoadFields("Goal ID");
            while TeamLookUp.Get(Rec."Primary Key") do
                Rec."Goal ID" := NoSeries.GetNextNo(Rec."No. Series");
            NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(Rec."No. Series", HumanResourcesSetup."Goal ID Nos", 0D, Rec."Goal ID");
        end;
        if "Team Type" = Rec."Team Type"::"Team performance reviews" then begin
            HumanResourcesSetup.Get();
            HumanResourcesSetup.TestField("Team Performance ID Nos");
            NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(HumanResourcesSetup."Team Performance ID Nos", xRec."No. Series", 0D, Rec."Team Performance ID", Rec."No. Series", IsHandled);
            //  if not IsHandled then begin
            if NoSeries.AreRelated(HumanResourcesSetup."Team Performance ID Nos", xRec."No. Series") then
                Rec."No. Series" := xRec."No. Series"
            else
                Rec."No. Series" := HumanResourcesSetup."Team Performance ID Nos";

            Rec."Team Performance ID" := NoSeries.GetNextNo(Rec."No. Series");
            TeamLookUp.ReadIsolation(IsolationLevel::ReadUncommitted);
            TeamLookUp.SetLoadFields("Team Performance ID");
            while TeamLookUp.Get(Rec."Primary Key") do
                Rec."Team Performance ID" := NoSeries.GetNextNo(Rec."No. Series");
            NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(Rec."No. Series", HumanResourcesSetup."Team Performance ID Nos", 0D, Rec."Team Performance ID");
        end;
        if "Team Type" = Rec."Team Type"::"Next Registered Courses" then begin
            HumanResourcesSetup.Get();
            HumanResourcesSetup.TestField("Courses ID Nos");
            NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(HumanResourcesSetup."Courses ID Nos", xRec."No. Series", 0D, Rec."Course ID", Rec."No. Series", IsHandled);
            //  if not IsHandled then begin
            if NoSeries.AreRelated(HumanResourcesSetup."Courses ID Nos", xRec."No. Series") then
                Rec."No. Series" := xRec."No. Series"
            else
                Rec."No. Series" := HumanResourcesSetup."Courses ID Nos";

            Rec."Course ID" := NoSeries.GetNextNo(Rec."No. Series");
            TeamLookUp.ReadIsolation(IsolationLevel::ReadUncommitted);
            TeamLookUp.SetLoadFields("Course ID");
            while TeamLookUp.Get(Rec."Primary Key") do
                Rec."Course ID" := NoSeries.GetNextNo(Rec."No. Series");
            NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(Rec."No. Series", HumanResourcesSetup."Courses ID Nos", 0D, Rec."Course ID");
        end;

        if "Team Type" = Rec."Team Type"::Tasks then begin
            HumanResourcesSetup.Get();
            HumanResourcesSetup.TestField("Task ID Nos");
            NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(HumanResourcesSetup."Task ID Nos", xRec."No. Series", 0D, Rec."Task ID", Rec."No. Series", IsHandled);
            //  if not IsHandled then begin
            if NoSeries.AreRelated(HumanResourcesSetup."Task ID Nos", xRec."No. Series") then
                Rec."No. Series" := xRec."No. Series"
            else
                Rec."No. Series" := HumanResourcesSetup."Task ID Nos";

            Rec."Task ID" := NoSeries.GetNextNo(Rec."No. Series");
            TeamLookUp.ReadIsolation(IsolationLevel::ReadUncommitted);
            TeamLookUp.SetLoadFields("Task ID");
            while TeamLookUp.Get(Rec."Primary Key") do
                Rec."Task ID" := NoSeries.GetNextNo(Rec."No. Series");
            NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(Rec."No. Series", HumanResourcesSetup."Task ID Nos", 0D, Rec."Task ID");
        end;

        if "Team Type" = Rec."Team Type"::"Apply Resignation" then begin
            HumanResourcesSetup.Get();
            HumanResourcesSetup.TestField("Resignation ID Nos");
            NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(HumanResourcesSetup."Resignation ID Nos", xRec."No. Series", 0D, Rec."Resignation ID", Rec."No. Series", IsHandled);
            //  if not IsHandled then begin
            if NoSeries.AreRelated(HumanResourcesSetup."Resignation ID Nos", xRec."No. Series") then
                Rec."No. Series" := xRec."No. Series"
            else
                Rec."No. Series" := HumanResourcesSetup."Resignation ID Nos";

            Rec."Resignation ID" := NoSeries.GetNextNo(Rec."No. Series");
            TeamLookUp.ReadIsolation(IsolationLevel::ReadUncommitted);
            TeamLookUp.SetLoadFields("Resignation ID");
            while TeamLookUp.Get(Rec."Primary Key") do
                Rec."Resignation ID" := NoSeries.GetNextNo(Rec."No. Series");
            NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(Rec."No. Series", HumanResourcesSetup."Resignation ID Nos", 0D, Rec."Resignation ID");
        end;

        if "Team Type" = Rec."Team Type"::Expenses then begin
            HumanResourcesSetup.Get();
            HumanResourcesSetup.TestField("Expense ID Nos");
            NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(HumanResourcesSetup."Expense ID Nos", xRec."No. Series", 0D, Rec."Expense ID", Rec."No. Series", IsHandled);
            //  if not IsHandled then begin
            if NoSeries.AreRelated(HumanResourcesSetup."Expense ID Nos", xRec."No. Series") then
                Rec."No. Series" := xRec."No. Series"
            else
                Rec."No. Series" := HumanResourcesSetup."Expense ID Nos";

            Rec."Expense ID" := NoSeries.GetNextNo(Rec."No. Series");
            TeamLookUp.ReadIsolation(IsolationLevel::ReadUncommitted);
            TeamLookUp.SetLoadFields("Expense ID");
            while TeamLookUp.Get(Rec."Primary Key") do
                Rec."Expense ID" := NoSeries.GetNextNo(Rec."No. Series");
            NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(Rec."No. Series", HumanResourcesSetup."Expense ID Nos", 0D, Rec."Expense ID");
        end;
    end;

    procedure GetCourseStatus()

    begin
        if Rec."Is Cancelled" = true then
            Rec."Course Status" := Rec."Course Status"::Cancelled;

        if (Rec."Course Start Date" = 0D) and (Rec."Is Cancelled" = false) then
            Rec."Course Status" := Rec."Course Status"::"Required(NotStarted)";

        if (Rec."Course Start Date" > Today) and (Rec."Is Cancelled" = false) then
            Rec."Course Status" := Rec."Course Status"::"Registered(Started)";

        if (Rec."Is Cancelled" = false) and (Rec."Course Start Date" <= Today) and ((Rec."Course End Date" = 0D) or (Rec."Course End Date" >= Today)) then
            Rec."Course Status" := Rec."Course Status"::InProgress;

        if (Rec."Course End Date" < Today) and (Rec."Is Cancelled" = false) then
            Rec."Course Status" := Rec."Course Status"::Completed;
    end;
}
