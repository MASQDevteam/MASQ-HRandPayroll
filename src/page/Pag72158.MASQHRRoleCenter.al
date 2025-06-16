page 72158 "MASQ HR Role Center"
{
    ApplicationArea = All;
    Caption = 'HR Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(MASQHeadline; "MASQ Headline")
            {
                ApplicationArea = Basic, Suite;
            }
            group("HR Summary")
            {
                part("HR Summary Cue Page"; "HR Summary Cue Page")
                {
                    Caption = 'Summary';
                    AccessByPermission = TableData "HR Summary Cue" = I;
                    ApplicationArea = Basic, Suite;
                }
            }

            group("Benefits")
            {
                part("Benefits Cue Page"; "Benefits Cue Page")
                {
                    Caption = 'Benefits';
                    AccessByPermission = TableData "Benefits Cue" = I;
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Recruitment Management")
            {
                part("Recruitment Cue Page"; "Recruitment Cue Page")
                {
                    Caption = 'Recruitment Management';
                    AccessByPermission = TableData "Recruitment Cue" = I;
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
    actions
    {
        area(Embedding)
        {
            action("Interview List")
            {
                ApplicationArea = Basic, Suite;
                RunObject = page "Interview List";
            }
            action("New Recruitment Interviews")
            {
                ApplicationArea = Basic, Suite;
                RunObject = page "Interview Card";
                RunPageMode = Create;
                RunPageLink = "Interview No." = CONST('');
            }
            action("New Applicant")
            {
                ApplicationArea = Basic, Suite;
                RunObject = page "Applicants Card";
                RunPageMode = Create;
                RunPageLink = "Applicant No." = CONST('');
            }
            action("New Application")
            {
                ApplicationArea = Basic, Suite;
                RunObject = page "Application Card";
                RunPageMode = Create;
                RunPageLink = "Application No." = CONST('');
            }
        }
    }
}
