table 72113 "Open Job"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Job ID"; Code[20]) { Editable = false; }
        field(2; "Job Title"; Text[100]) { }
        field(3; "Posting Date"; Date) { }
        field(4; "Closing Date"; Date) { }
        field(5; "Is Active"; Boolean) { }
        field(6; "Linked Position ID"; Code[20])
        {
            Caption = 'Linked Open Position';
            TableRelation = "Open Position"."Position ID";
        }
        field(7; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "Job ID") { Clustered = true; }
    }
    trigger OnInsert()
    var
        NoSeries: Codeunit "No. Series";
        NoSeriesCode: Code[20];
        IsHandled: Boolean;
        HumanResourcesSetup: Record "Human Resources Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        OpenJob: Record "Open Job";
    begin
        HumanResourcesSetup.Get();
        HumanResourcesSetup.TestField("Open Jobs Nos");
        NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(HumanResourcesSetup."Open Jobs Nos", xRec."No. Series", 0D, Rec."Job ID", Rec."No. Series", IsHandled);
        //  if not IsHandled then begin
        if NoSeries.AreRelated(HumanResourcesSetup."Open Jobs Nos", xRec."No. Series") then
            Rec."No. Series" := xRec."No. Series"
        else
            Rec."No. Series" := HumanResourcesSetup."Open Jobs Nos";

        Rec."Job ID" := NoSeries.GetNextNo(Rec."No. Series");
        OpenJob.ReadIsolation(IsolationLevel::ReadUncommitted);
        OpenJob.SetLoadFields("Job ID");
        while OpenJob.Get(Rec."Job ID") do
            Rec."Job ID" := NoSeries.GetNextNo(Rec."No. Series");
        NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(Rec."No. Series", HumanResourcesSetup."Open Jobs Nos", 0D, Rec."Job ID");
    end;
}
