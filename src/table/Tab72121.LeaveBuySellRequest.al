table 72121 "Leave Buy Sell Request"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Request ID"; Code[20])
        {
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(2; "Employee No."; Code[20])
        {
            DataClassification = CustomerContent;
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
        field(3; "Employee Name"; Text[100])
        {
            Editable = false;
        }
        field(4; "Request Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Buy,Sell;
        }
        field(5; "Number of Days"; Decimal)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                LeaveRequestHeader: Record "Leave Request Header";
            begin
                if "Request Type" = "Request Type"::Sell then begin
                    LeaveRequestHeader.Reset();
                    LeaveRequestHeader.SetRange("Employee ID", "Employee No.");
                    LeaveRequestHeader.SetRange("Leave Type", "Leave Type");
                    if LeaveRequestHeader.FindFirst() then
                        if "Number of Days" > LeaveRequestHeader."Remaining Balance" then
                            Error('Cannot sell more days than remaining balance.');
                end;
            end;

        }
        field(6; "Leave Type"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Type Lookup".Code where("Leave Request Type" = filter("Leave Request Type"::"Leave Type"));
        }
        field(7; "Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Pending,Approved,Rejected,Cancelled;
        }
        field(8; "Request Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(9; "Approver ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(11; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "Request ID")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        NoSeries: Codeunit "No. Series";
        NoSeriesCode: Code[20];
        IsHandled: Boolean;
        HumanResourcesSetup: Record "Human Resources Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        LeaveBuySellRequest: Record "Leave Buy Sell Request";
    begin
        HumanResourcesSetup.Get();
        HumanResourcesSetup.TestField("Request Buy/Sell LR Nos");
        NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(HumanResourcesSetup."Request Buy/Sell LR Nos", xRec."No. Series", 0D, Rec."Request ID", Rec."No. Series", IsHandled);
        if NoSeries.AreRelated(HumanResourcesSetup."Request Buy/Sell LR Nos", xRec."No. Series") then
            Rec."No. Series" := xRec."No. Series"
        else
            Rec."No. Series" := HumanResourcesSetup."Request Buy/Sell LR Nos";

        Rec."Request ID" := NoSeries.GetNextNo(Rec."No. Series");
        LeaveBuySellRequest.ReadIsolation(IsolationLevel::ReadUncommitted);
        LeaveBuySellRequest.SetLoadFields("Request ID");
        while LeaveBuySellRequest.Get(Rec."Request ID") do
            Rec."Request ID" := NoSeries.GetNextNo(Rec."No. Series");
        NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(Rec."No. Series", HumanResourcesSetup."Request Buy/Sell LR Nos", 0D, Rec."Request ID");
    end;
}
