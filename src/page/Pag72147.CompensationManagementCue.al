page 72147 "Compensation Management Cue"
{
    ApplicationArea = All;
    Caption = 'Compensation Management Cue';
    PageType = CardPart;
    SourceTable = "Compensation Management Cue";

    layout
    {
        area(Content)
        {
            cuegroup(General)
            {
                Caption = 'Summary';

                field("Fixed Compensation Plans"; Rec."Fixed Compensation Plans")
                {
                    ToolTip = 'Specifies the value of the Fixed Compensation Plans field.', Comment = '%';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        CompensationStructure: Record "Compensation Structure";
                        CompensationStructurePage: Page "Compensation Structure";
                    begin
                        CompensationStructure.SetRange("Compensation Type", CompensationStructure."Compensation Type"::Fixed);
                        CompensationStructurePage.SetTableView(CompensationStructure);
                        CompensationStructurePage.Run();
                    end;
                }
                field("Variable Compensation Plans"; Rec."Variable Compensation Plans")
                {
                    ToolTip = 'Specifies the value of the Variable Compensation Plans field.', Comment = '%';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        CompensationStructure: Record "Compensation Structure";
                        CompensationStructurePage: Page "Compensation Structure";
                    begin
                        CompensationStructure.SetRange("Compensation Type", CompensationStructure."Compensation Type"::Variable);
                        CompensationStructurePage.SetTableView(CompensationStructure);
                        CompensationStructurePage.Run();
                    end;
                }
                field("Employees without fixed comp"; Rec."Employees without fixed comp")
                {
                    ToolTip = 'Specifies the value of the Variable Compensation Plans field.', Comment = '%';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        Employee: Record Employee;
                        EmpCompensationList: Page "Emp Compensation List";
                    begin
                        Employee.SetRange("Compensation Type", Employee."Compensation Type"::Variable);
                        EmpCompensationList.SetTableView(Employee);
                        EmpCompensationList.Run();
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
            Commit();
        end;

    end;
}
