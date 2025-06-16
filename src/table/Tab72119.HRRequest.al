table 72119 "HR Request"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20]) { Editable = false; }
        field(2; "Employee No."; Code[20])
        {
            TableRelation = Employee."No.";
            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if Employee.Get("Employee No.") then begin
                    if Rec."Employee No." <> '' then
                        Rec.Validate("Employee Name", Employee."First Name");
                end
                else
                    Rec.Validate("Employee Name", '');
            end;
        }
        field(3; "Request Type"; Option)
        {
            OptionMembers = NewPosition,WorkerReassignment,Termination,CompensationChange;
            OptionCaption = 'New Position,Worker Reassignment,Termination,Compensation Change';
        }
        field(4; "Request Date"; Date) { Editable = false; }
        field(5; "Requested By"; Code[50]) { Editable = false; }
        field(6; "Status"; Option)
        {
            OptionMembers = Requested,Approved,Rejected,Cancelled;
        }
        field(7; "Comment"; Text[250]) { }

        // Specific to request types
        field(20; "New Department"; Code[20]) { TableRelation = "Dimension Value".Code where("Dimension Code" = const('DEPARTMENT')); }
        field(21; "Position Title"; Text[100]) { TableRelation = "Position Lookup"; }
        field(22; "Effective Date"; Date) { }
        field(23; "From Department"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DEPARTMENT'));
            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
            begin
                if ("From Department" <> '') then begin
                    if ("From Department" = "To Department") then
                        Error('Can''t choose same department!');
                end;
            end;
        }
        field(24; "To Department"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DEPARTMENT'));
            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
            begin
                if ("To Department" <> '') then begin
                    if ("From Department" = "To Department") then
                        Error('Can''t choose same department!');
                end;
            end;
        }
        field(25; "Termination Reason"; Text[100])
        {
            TableRelation = "Data Lookup".Code where(Type = filter("Termination Reason"));
        }

        field(26; "Old Compensation"; Code[20])
        {
            TableRelation = "Compensation Structure";
            trigger OnValidate()
            begin
                if ("Old Compensation" <> '') then begin
                    if ("Old Compensation" = "New Compensation") then
                        Error('Can''t choose same compensation!');
                end;
            end;
        }
        field(27; "New Compensation"; Code[20])
        {
            TableRelation = "Compensation Structure";
            trigger OnValidate()
            begin
                if ("New Compensation" <> '') then begin
                    if ("Old Compensation" = "New Compensation") then
                        Error('Can''t choose same compensation!');
                end;
            end;
        }
        field(28; "Employee Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(30; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

    }

    keys
    {
        key(PK; Code) { Clustered = true; }
    }

    trigger OnInsert()
    var
        NoSeries: Codeunit "No. Series";
        NoSeriesCode: Code[20];
        IsHandled: Boolean;
        HumanResourcesSetup: Record "Human Resources Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        HRRequest: Record "HR Request";
    begin
        HumanResourcesSetup.Get();
        HumanResourcesSetup.TestField("HR Requests Nos");
        NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(HumanResourcesSetup."HR Requests Nos", xRec."No. Series", 0D, Rec."Code", Rec."No. Series", IsHandled);
        //  if not IsHandled then begin
        if NoSeries.AreRelated(HumanResourcesSetup."HR Requests Nos", xRec."No. Series") then
            Rec."No. Series" := xRec."No. Series"
        else
            Rec."No. Series" := HumanResourcesSetup."HR Requests Nos";

        Rec."Code" := NoSeries.GetNextNo(Rec."No. Series");
        HRRequest.ReadIsolation(IsolationLevel::ReadUncommitted);
        HRRequest.SetLoadFields("Code");
        while HRRequest.Get(Rec."Code") do
            Rec."Code" := NoSeries.GetNextNo(Rec."No. Series");
        NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(Rec."No. Series", HumanResourcesSetup."HR Requests Nos", 0D, Rec."Code");

        "Request Date" := Today;
        "Requested By" := UserId;
        Status := Status::Requested;
    end;
}
