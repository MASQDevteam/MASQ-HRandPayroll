codeunit 72100 "HR and Payroll"
{
    [EventSubscriber(ObjectType::Page, 1174, 'OnBeforeDrillDown', '', false, false)]
    local procedure OnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        TeamLookUp: Record "Team LookUp";
        Questionnaire: Record Questionnaire;
        BenefitCart: Record "Benefit Cart";
        InterviewHeader: Record "Interview Header";
    begin
        case DocumentAttachment."Table ID" of
            DATABASE::"Team LookUp":
                begin
                    RecRef.Open(DATABASE::"Team LookUp");
                    TeamLookUp.SetRange("Primary Key as Code", DocumentAttachment."No.");
                    if TeamLookUp.FindFirst() then
                        RecRef.GetTable(TeamLookUp);
                end;

            DATABASE::Questionnaire:
                begin
                    RecRef.Open(DATABASE::Questionnaire);
                    if Questionnaire.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(Questionnaire);
                end;
            DATABASE::"Benefit Cart":
                begin
                    RecRef.Open(DATABASE::"Benefit Cart");
                    if BenefitCart.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(BenefitCart);
                end;
            DATABASE::"Interview Header":
                begin
                    RecRef.Open(DATABASE::"Interview Header");
                    if InterviewHeader.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(InterviewHeader);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 1173, 'OnAfterInitFieldsFromRecRef', '', false, false)]
    local procedure OnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of
            DATABASE::"Team LookUp":
                begin
                    FieldRef := RecRef.Field(74);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;

            DATABASE::Questionnaire:
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
            DATABASE::"Benefit Cart":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
            DATABASE::"Interview Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, 1173, 'OnAfterOpenForRecRef', '', false, false)]
    local procedure OnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
        LineNo: Integer;
    begin
        case RecRef.Number of
            DATABASE::"Team LookUp":
                begin
                    FieldRef := RecRef.Field(74);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                    FlowFieldsEditable := false;
                end;
            DATABASE::Questionnaire:
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                    FlowFieldsEditable := false;
                end;
            DATABASE::"Benefit Cart":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                    FlowFieldsEditable := false;
                end;
            DATABASE::"Interview Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                    FlowFieldsEditable := false;
                end;
        end

    end;

    Local procedure GETLastDocumentAttchamentTeamLookup(TeamLookUp: Record "Team LookUp"): Integer
    var
        DocumentAttchament: Record "Document Attachment";
    begin

        Clear(DocumentAttchament);
        DocumentAttchament.SetRange("Table ID", Database::"Team LookUp");
        DocumentAttchament.SetRange("No.", TeamLookUp."Primary Key as Code");
        IF DocumentAttchament.FindLast() then
            exit(DocumentAttchament.ID);
    end;

    Local procedure GETLastDocumentAttchamentQues(Questionnaire: Record Questionnaire): Integer
    var
        DocumentAttchament: Record "Document Attachment";
    begin

        Clear(DocumentAttchament);
        DocumentAttchament.SetRange("Table ID", Database::Questionnaire);
        DocumentAttchament.SetRange("No.", Questionnaire.Code);
        IF DocumentAttchament.FindLast() then
            exit(DocumentAttchament.ID);
    end;

    Local procedure GETLastDocumentAttchamentBenefitCart(BenefitCart: Record "Benefit Cart"): Integer
    var
        DocumentAttchament: Record "Document Attachment";
    begin

        Clear(DocumentAttchament);
        DocumentAttchament.SetRange("Table ID", Database::"Benefit Cart");
        DocumentAttchament.SetRange("No.", BenefitCart.Code);
        IF DocumentAttchament.FindLast() then
            exit(DocumentAttchament.ID);
    end;

    Local procedure GETLastDocumentAttchamentInterviewHeader(InterviewHeader: Record "Interview Header"): Integer
    var
        DocumentAttchament: Record "Document Attachment";
    begin

        Clear(DocumentAttchament);
        DocumentAttchament.SetRange("Table ID", Database::"Interview Header");
        DocumentAttchament.SetRange("No.", InterviewHeader."Interview No.");
        IF DocumentAttchament.FindLast() then
            exit(DocumentAttchament.ID);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Team LookUp", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertEventTeamLookup(var Rec: Record "Team LookUp")
    var
        DocumentAttchament: Record "Document Attachment";
        LastDocumentAttchamentID: Integer;
        AttachmentID: array[10] of Text[50];
        I: Integer;
        Employee: Record Employee;
    begin
        Rec."Primary Key as Code" := Format(Rec."Primary Key");
        Rec.Modify(true);

        if (Rec."Team Type" = Rec."Team Type"::"Expiring Certificates") then begin
            AttachmentID[1] := 'Certificate';

            LastDocumentAttchamentID := GETLastDocumentAttchamentTeamLookup(Rec);

            for I := 1 to 1 do begin
                DocumentAttchament.Init();
                DocumentAttchament.Validate("Table ID", Database::"Team LookUp");
                DocumentAttchament.Validate("No.", Rec."Primary Key as Code");
                DocumentAttchament.Validate("Document Type", DocumentAttchament."Document Type"::Order);
                DocumentAttchament.Validate("Line No.", LastDocumentAttchamentID + I);
                DocumentAttchament.Validate(ID, LastDocumentAttchamentID + I);
                DocumentAttchament."Attachment ID" := AttachmentID[I];
                DocumentAttchament."to be removed" := true;
                // DocumentAttchament.Validate("File Name", AttachmentID[I]);
                DocumentAttchament.Insert();
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Interview Header", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertEventInterviewHeader(var Rec: Record "Interview Header")
    var
        DocumentAttchament: Record "Document Attachment";
        LastDocumentAttchamentID: Integer;
        AttachmentID: array[10] of Text[50];
        I: Integer;
        Employee: Record Employee;
    begin
        AttachmentID[1] := 'Resume';
        AttachmentID[2] := 'HR Assessment';
        AttachmentID[3] := 'Assessment (Line Manager)';

        LastDocumentAttchamentID := GETLastDocumentAttchamentInterviewHeader(Rec);

        for I := 1 to 3 do begin
            DocumentAttchament.Init();
            DocumentAttchament.Validate("Table ID", Database::"Interview Header");
            DocumentAttchament.Validate("No.", Rec."Interview No.");
            DocumentAttchament.Validate("Document Type", DocumentAttchament."Document Type"::Order);
            DocumentAttchament.Validate("Line No.", LastDocumentAttchamentID + I);
            DocumentAttchament.Validate(ID, LastDocumentAttchamentID + I);
            DocumentAttchament."Attachment ID" := AttachmentID[I];
            DocumentAttchament."to be removed" := true;
            // DocumentAttchament.Validate("File Name", AttachmentID[I]);
            DocumentAttchament.Insert();
        end;
    end;

    [EventSubscriber(ObjectType::Table, database::"Document Attachment", 'OnBeforeInsertAttachment', '', false, false)]
    local procedure OnBeforeInsertAttachment(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        TeamLookUp: Record "Team LookUp";
        DocumentAttachmentTemp: Record "Document Attachment";
        Questionnaire: Record Questionnaire;
        BenefitCart: Record "Benefit Cart";
        InterviewHeader: Record "Interview Header";
    begin
        IF DocumentAttachment."Table ID" = Database::"Team LookUp" then begin
            Clear(TeamLookUp);
            TeamLookUp.SetRange("Primary Key as Code", DocumentAttachment."No.");
            if TeamLookUp.FindFirst() then begin
                // if TeamLookUp.Get(Format(DocumentAttachment."No.")) then begin
                IF TeamLookUp."Attachment ID" <> '' then begin
                    DocumentAttachment."Attachment ID" := TeamLookUp."Attachment ID";
                    DocumentAttachment."Attachment Mandatory" := true;
                    Clear(DocumentAttachmentTemp);
                    DocumentAttachmentTemp.Get(TeamLookUp."Document Attachment Table ID", TeamLookUp."Document Attachment No.", TeamLookUp."Document Attachment Doc. Type", TeamLookUp."Document Attachment Line No.", TeamLookUp."Document Attachment ID");
                    DocumentAttachmentTemp.Delete();

                end;
            end;
        end;
        IF DocumentAttachment."Table ID" = Database::Questionnaire then begin
            Clear(Questionnaire);
            Questionnaire.SetRange(Code, DocumentAttachment."No.");
            if Questionnaire.FindFirst() then begin
                // if TeamLookUp.Get(Format(DocumentAttachment."No.")) then begin
                IF Questionnaire."Attachment ID" <> '' then begin
                    DocumentAttachment."Attachment ID" := Questionnaire."Attachment ID";
                    DocumentAttachment."Attachment Mandatory" := true;
                    Clear(DocumentAttachmentTemp);
                    DocumentAttachmentTemp.Get(Questionnaire."Document Attachment Table ID", Questionnaire."Document Attachment No.", Questionnaire."Document Attachment Doc. Type", Questionnaire."Document Attachment Line No.", Questionnaire."Document Attachment ID");
                    DocumentAttachmentTemp.Delete();

                end;
            end;
        end;

        IF DocumentAttachment."Table ID" = Database::"Benefit Cart" then begin
            Clear(BenefitCart);
            BenefitCart.SetRange(Code, DocumentAttachment."No.");
            if BenefitCart.FindFirst() then begin
                IF BenefitCart."Attachment ID" <> '' then begin
                    DocumentAttachment."Attachment ID" := BenefitCart."Attachment ID";
                    DocumentAttachment."Attachment Mandatory" := true;
                    Clear(DocumentAttachmentTemp);
                    DocumentAttachmentTemp.Get(BenefitCart."Document Attachment Table ID", BenefitCart."Document Attachment No.", BenefitCart."Document Attachment Doc. Type", BenefitCart."Document Attachment Line No.", BenefitCart."Document Attachment ID");
                    DocumentAttachmentTemp.Delete();

                end;
            end;
        end;

        IF DocumentAttachment."Table ID" = Database::"Interview Header" then begin
            Clear(InterviewHeader);
            InterviewHeader.SetRange("Interview No.", DocumentAttachment."No.");
            if InterviewHeader.FindFirst() then begin
                IF InterviewHeader."Attachment ID" <> '' then begin
                    DocumentAttachment."Attachment ID" := InterviewHeader."Attachment ID";
                    DocumentAttachment."Attachment Mandatory" := true;
                    Clear(DocumentAttachmentTemp);
                    DocumentAttachmentTemp.Get(InterviewHeader."Document Attachment Table ID", InterviewHeader."Document Attachment No.", InterviewHeader."Document Attachment Doc. Type", InterviewHeader."Document Attachment Line No.", InterviewHeader."Document Attachment ID");
                    DocumentAttachmentTemp.Delete();

                end;
            end;
        end;
    end;

}
