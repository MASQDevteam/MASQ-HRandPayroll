table 72108 "Questionnaire"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        // field(2; "QType"; Option)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Questionnaire Type';
        //     OptionMembers = "Single Choice","Multiple Choice","Text","Rating";
        // }

        field(3; "Description"; Text[250])
        {
            DataClassification = CustomerContent;
        }

        field(4; "Created Date"; Date)
        {
            DataClassification = SystemMetadata;
            Editable = false;
        }

        field(5; "Status"; Enum "Questionnaire Status")
        {
            DataClassification = SystemMetadata;
        }
        field(6; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
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
        field(7; "Employee Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(68; "Attachment ID"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(69; "Document Attachment ID"; Integer)
        {

        }
        field(70; "Document Attachment Table ID"; Integer)
        {

        }
        field(71; "Document Attachment No."; Code[20])
        {

        }
        field(72; "Document Attachment Doc. Type"; Enum "Attachment Document Type")
        {

        }
        field(73; "Document Attachment Line No."; Integer)
        {
        }
        field(8; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(10; "Department"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DEPARTMENT'));
            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
            begin
                if Department <> '' then begin
                    DimensionValue.SetRange(Code, Rec.Department);
                    if DimensionValue.FindFirst() then begin
                        "Department Name" := DimensionValue.Name;
                    end;
                end
                else
                    "Department Name" := '';
            end;
        }
        field(11; "Department Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; Code)
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
        Questionnaire: Record Questionnaire;
    begin
        HumanResourcesSetup.Get();
        HumanResourcesSetup.TestField("Questionnaire No. Series");
        NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(HumanResourcesSetup."Questionnaire No. Series", xRec."No. Series", 0D, Rec.Code, Rec."No. Series", IsHandled);
        //  if not IsHandled then begin
        if NoSeries.AreRelated(HumanResourcesSetup."Questionnaire No. Series", xRec."No. Series") then
            Rec."No. Series" := xRec."No. Series"
        else
            Rec."No. Series" := HumanResourcesSetup."Questionnaire No. Series";

        Rec.Code := NoSeries.GetNextNo(Rec."No. Series");
        Questionnaire.ReadIsolation(IsolationLevel::ReadUncommitted);
        Questionnaire.SetLoadFields(Code);
        while Questionnaire.Get(Rec.Code) do
            Rec.Code := NoSeries.GetNextNo(Rec."No. Series");
        NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(Rec."No. Series", HumanResourcesSetup."Questionnaire No. Series", 0D, Rec.Code);
        //   end;
        //  end;
        "Created Date" := Today;
    end;
}

