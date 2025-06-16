page 72101 "MASQ HRand Payroll Role Center"
{
    ApplicationArea = All;
    Caption = 'HR and Payroll';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(MASQHeadline; "MASQ Headline")
            {
                ApplicationArea = Basic, Suite;
            }
            group("My Team")
            {
                part(MASQActivities; "MASQ Activities Cue Page")
                {
                    Caption = 'My Team';
                    AccessByPermission = TableData "MASQ Activities Cue" = I;
                    ApplicationArea = Basic, Suite;
                }
            }

            group("MASQ_My Information")
            {
                part(MyInfoCue; "My Info Cue")
                {
                    Caption = 'My Information';
                    AccessByPermission = TableData "My Info Cue" = I;
                    ApplicationArea = Basic, Suite;
                }
            }
            group("MASQ_Summary")
            {
                part("Summary Cue"; "Summary Cue")
                {
                    Caption = 'Summary';
                    AccessByPermission = TableData "Summary Cue" = I;
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Compensation Summary")
            {
                part("Compensation Management Cue"; "Compensation Management Cue")
                {
                    Caption = 'Compensation Summary';
                    AccessByPermission = TableData "Compensation Management Cue" = I;
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
    actions
    {
        area(Embedding)
        {
            action(Summary)
            {
                ApplicationArea = Basic, Suite;
                RunObject = page "MASQ HRand Payroll Role Center";
            }
            action("My Team (Position)")
            {
                ApplicationArea = Basic, Suite;
                RunObject = page "Employee List";
            }
            action("Employee Compensation")
            {
                ApplicationArea = Basic, Suite;
                RunObject = page "Emp Compensation List";
            }
            action("Performance goals")
            {
                ApplicationArea = Basic, Suite;
                RunObject = page "Team Performance Goals";
            }
            action(Reviews)
            {
                ApplicationArea = Basic, Suite;
                RunObject = page "Team performance reviews";
            }
            action("My Information")
            {
                ApplicationArea = Basic, Suite;
                RunObject = page MASQEmployees;
            }
            action("My Career Information")
            {
                ApplicationArea = Basic, Suite;
                RunObject = page "My Career Info";
            }
            action("Leave Request")
            {
                ApplicationArea = Basic, Suite;
                RunObject = page "Leave Request List";
            }
            action("Learning")
            {
                ApplicationArea = Basic, Suite;
                RunObject = page Courses;
            }
        }
    }
}
