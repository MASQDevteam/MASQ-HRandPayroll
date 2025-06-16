page 72145 "Emp Compensation List"
{
    ApplicationArea = All;
    Caption = 'Emp Compensation List';
    PageType = List;
    SourceTable = Employee;
    CardPageID = "Employee Card";
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the employee''s first name.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the employee''s last name.';
                }
                field(Position; Rec.Position)
                {
                    ToolTip = 'Specifies the value of the Position field.';
                }
                field("Basic Salary"; Rec."Basic Salary")
                {
                    ToolTip = 'Specifies the value of the Basic Salary field.', Comment = '%';
                }
                field("Last Increase Amount"; Rec."Last Increase Amount")
                {
                    ToolTip = 'Specifies the value of the Last Increase Amount field.', Comment = '%';
                    MultiLine = true;
                }
                field("Last Increase percent"; Rec."Last Increase percent")
                {
                    MultiLine = true;
                }
                field(Image; Rec.Image)
                {
                    ToolTip = 'Specifies the picture of the employee.';
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        if Rec."Birth Date" <> 0D then
            Rec."Birthday Date" := Rec.GetBirthdayDate();
    end;
}
