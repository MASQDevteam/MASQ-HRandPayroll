table 72109 "Summary Cue"
{
    Caption = 'Summary';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "ID Numbers Expiring"; Integer)
        {
            Caption = 'Identifications Numbers Expiring for My Team';
            FieldClass = FlowField;
            CalcFormula = Count(IDCardTracking);
        }
        field(4; "Pending Time Off Requests"; Integer)
        {
            Caption = 'Pending Time Off Requests from My Team';
            FieldClass = FlowField;
            CalcFormula = Count("Request Time Off" where(Status = filter(Pending)));
        }
        field(5; "Pending Leave of Absence Requests"; Integer)
        {
            Caption = 'Pending Leave of Absence Requests from My Team';
            FieldClass = FlowField;
            CalcFormula = Count("Leave Request Header" where(Status = filter(Pending)));
        }
        field(6; "Pending Buy and Sell Leave Requests"; Integer)
        {
            Caption = 'Pending Buy and Sell Leave Requests from My Team';
            FieldClass = FlowField;
            CalcFormula = Count("Leave Buy Sell Request" where(Status = filter(Pending)));
        }
       
        field(8; "Manager Absence Calendar"; Integer)
        {

        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

}
