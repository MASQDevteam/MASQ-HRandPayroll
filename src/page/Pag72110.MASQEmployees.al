page 72110 MASQEmployees
{
    ApplicationArea = BasicHR;
    Caption = 'MASQ Employee';
    CardPageID = "Employee Card";
    Editable = false;
    PageType = List;
    SourceTable = Employee;
    layout
    {
        area(Content)
        {
            field(UserName; UserName)
            {
                ApplicationArea = BasicHR;
                ShowCaption = false;
                ToolTip = 'Specifies the user name of the employee.';
                Editable = false;
                Style = Strong;
            }
            repeater(General)
            {
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the employee''s first name.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ToolTip = 'Specifies the employee''s middle name.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the employee''s last name.';
                }
                field("Search Name"; Rec."Search Name")
                {
                    ToolTip = 'Specifies an alternate name that you can use to search for the record in question when you cannot remember the value in the Name field.';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the city of the address.';
                }
                field("Birth Date"; Rec."Birth Date")
                {
                    ToolTip = 'Specifies the employee''s date of birth.';
                }
                field("Basic Salary"; Rec."Basic Salary")
                {
                    ToolTip = 'Specifies the value of the Basic Salary field.', Comment = '%';
                }
                field("Seniority date"; Rec."Seniority date")
                {
                    ToolTip = 'Specifies the value of the Seniority date field.', Comment = '%';
                }
                field("Years in Position"; Rec."Years in Position")
                {
                    ToolTip = 'Specifies the value of the Years in Position field.';
                }
                field("Nb of Previous positions"; Rec."Nb of Previous positions")
                {
                    ToolTip = 'Specifies the value of the Nb of Previous Positions field.';
                }
                field(Position; Rec.Position)
                {
                    ToolTip = 'Specifies the value of the Position field.';
                }
                field("Seniority Date Text"; Rec."Seniority Date Text")
                {
                    ToolTip = 'Specifies the value of the Seniority Date Text field.';
                }
                field("Birth Date Text"; Rec."Birth Date Text")
                {
                    ToolTip = 'Specifies the value of the Birth Date Text field.';
                }
            }
        }
        area(FactBoxes)
        {
            part(TimeSheet; TimeSheetFactbox)
            {
                ApplicationArea = BasicHR;
                Caption = 'TimeSheet';
                SubPageLink = "Resource No." = FIELD("Resource No.");
            }

            part(PerformanceGoal; "PerformanceGoalFactbox ")
            {
                ApplicationArea = BasicHR;
                Caption = 'Performance Goal';
                SubPageLink = "Employee ID" = FIELD("No."), "Team Type" = filter("Team performance goals");
            }

            part(CertificatesAttachments; "Certificate Attachment Factbox")
            {
                ApplicationArea = BasicHR;
                Caption = 'Certificates Attachments';
                SubPageLink = "Employee ID" = FIELD("No."), "Team Type" = filter("Expiring Certificates");
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        LastPositionDate: Date;
        PositionVariation: Record "Position Variation";
    begin
        if Rec."Birth Date" <> 0D then
            Rec."Birthday Date" := Rec.GetBirthdayDate();
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
        LastPositionDate: Date;
        PositionVariation: Record "Position Variation";
    begin
        UserName := 'Welcome ' + UserId + ' !';
        Clear(PositionVariation);
        PositionVariation.SetRange("Employee No", Rec."No.");
        if PositionVariation.FindLast() then begin
            LastPositionDate := DT2Date(PositionVariation.SystemCreatedAt);
            if LastPositionDate = 0D then begin
                Rec."Years in Position" := 'Years in position: 0';
            end else
                Rec."Years in Position" := 'Years in position: ' + Format(Date2DMY(Today, 3) - Date2DMY(LastPositionDate, 3));
            // Rec."Years in Position" := 'Years in position: ' + Format(Date2DMY(CalcDate('<+1Y>', Today), 3) - Date2DMY(LastPositionDate, 3));
            Rec.Modify();
        end;
        UserSetup.Get(UserId);
        Rec.FilterGroup(2);
        Rec.SetFilter("No.", UserSetup."Employee No.");
    end;

    var
        UserName: Text;
        UserSetup: Record "User Setup";
}
