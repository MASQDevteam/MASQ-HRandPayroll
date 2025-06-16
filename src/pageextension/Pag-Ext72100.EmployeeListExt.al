pageextension 72100 "Employee List Ext" extends "Employee List"
{
    layout
    {
        modify("Job Title")
        {
           Visible=false;
        }
        modify("First Name")
        {
            Style=Strong;
        }
        modify("Last Name")
        {
            Style=Strong;
        }
        addafter(FullName)
        {
            field("Basic Salary"; Rec."Basic Salary")
            {
                ApplicationArea = All;
            }

            field("Seniority Date"; Rec."Seniority date")
            {
                ApplicationArea = All;
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
            field("Position"; Rec."Position")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Position field.';
                Style=Strong;
            }
            field("Seniority Date Text"; Rec."Seniority Date Text")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Seniority Date Text field.';
            }
            field("Birth Date Text"; Rec."Birth Date Text")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Birth Date Text field.';
            }
        }
        
    } 
    actions
    {
        addlast(navigation)
        {
            action(RequestWorkerReassignment)
            {
                Caption = 'Request Worker Reassignment';
                ApplicationArea = All;
                ToolTip = 'Request a reassignment for the selected worker.';
                Image = Add;
                Promoted = true;
                PromotedCategory = Process;
                Visible= ShowempActions;
                RunObject=page "Request Worker Reassignment"; 
                RunPageLink="Request Type"=filter(WorkerReassignment);
                // trigger onAction()
                // var
                // HRRequest: Record "HR Request";
                // RequestWorkerReassignment: Page "Request Worker Reassignment"; 
                // EmployeeList: Page "Employee List";
                // Employee: Record Employee;
                // begin
                //     CurrPage.SetSelectionFilter(Rec);
                //  if Rec.FindFirst() then begin
                //  HRRequest.SetFilter("Employee No.",Rec."No.");
                //  RequestWorkerReassignment.SetTableView(HRRequest);
                //   RequestWorkerReassignment.Run();
                //  end;
                // end;
            }

            action(RequestTermination)
            {
                Caption = 'Request Termination';
                ApplicationArea = All;
                ToolTip = 'Request termination for the selected worker.';
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                Visible= ShowempActions;
                RunObject=page "Request Termination"; 
            //  trigger OnAction()
            //     var
            //     HRRequest: Record "HR Request";
            //     RequestTermination: Page "Request Termination"; 
            //     EmployeeList: Page "Employee List";
            //     Employee: Record Employee;
            //     begin
            //         CurrPage.SetSelectionFilter(Rec);
            //      if Rec.FindFirst() then begin
            //      HRRequest.SetRange("Employee No.",Rec."No.");
            //      RequestTermination.SetTableView(HRRequest);
            //       RequestTermination.Run();
            //      end;
            //     end;
            }

            action(RequestCompensationChange)
            {
                Caption = 'Request Compensation Change';
                ApplicationArea = All;
                ToolTip = 'Request a change in compensation for the selected worker.';
                Image = Change;
                Promoted = true;
                PromotedCategory = Process;
                Visible= ShowempActions;
                RunObject=page "Request Compensation Change"; 
            //  trigger OnAction()
            //     var
            //     HRRequest: Record "HR Request";
            //     RequestCompensationChange: Page "Request Compensation Change"; 
            //     EmployeeList: Page "Employee List";
            //     Employee: Record Employee;
            //     begin
            //         CurrPage.SetSelectionFilter(Rec);
            //      if Rec.FindFirst() then begin
            //      HRRequest.SetRange("Employee No.",Rec."No.");
            //      RequestCompensationChange.SetTableView(HRRequest);
            //       RequestCompensationChange.Run();
            //      end; 
            //     end;
            }

            action(RequestTimeOff)
            {
                Caption = 'Request Time Off';
                ApplicationArea = All;
                ToolTip = 'Request time off for the selected worker.';
                Image = Calendar;
                Promoted = true;
                PromotedCategory = Process;
                Visible= ShowempActions;
                RunObject=page "Request Time Off"; 
                // trigger OnAction()
                // var
                // RequestTimeOff: Record "Request Time Off";
                // RequestTimeOffPage: Page "Request Time Off"; 
                // EmployeeList: Page "Employee List";
                // Employee: Record Employee;
                // begin
                //  RequestTimeOff.SetFilter("Employee No.",Rec."No.");
                //  RequestTimeOffPage.SetTableView(RequestTimeOff);
                //   RequestTimeOffPage.Run();
             
                // end;
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
        UserSetup.Get(UserId);
        ShowempActions:=UserSetup."Show Emp Actions";
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
    end; 
    var
      UserSetup: Record "User Setup"; 
      ShowempActions:Boolean;
}
 
