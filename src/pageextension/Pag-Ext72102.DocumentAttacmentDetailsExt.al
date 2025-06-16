pageextension 72102 "Document Attacment Details Ext" extends "Document Attachment Details"
{

    trigger OnAfterGetCurrRecord()
    var
        TeamLookUp: Record "Team LookUp";
        RecNoInt: Integer;
        Questionnaire: Record Questionnaire;
        BenefitCart: Record "Benefit Cart";
        InterviewHeader: Record "Interview Header";
    begin
        IF (Rec."Table ID" = Database::"Team LookUp") then begin
            Clear(TeamLookUp);
            TeamLookUp.SetRange("Primary Key as Code", Rec."No.");
            TeamLookUp.FindFirst();
            TeamLookUp."Attachment ID" := '';

            TeamLookUp."Document Attachment Table ID" := 0;
            TeamLookUp."Document Attachment No." := '';
            TeamLookUp."Document Attachment Doc. Type" := Rec."Document Type"::Order;
            TeamLookUp."Document Attachment Line No." := 0;
            TeamLookUp."Document Attachment ID" := 0;
            TeamLookUp.Modify();
            IF (NOT Rec.HasContent()) AND (Rec."to be removed") then begin

                TeamLookUp."Attachment ID" := Rec."Attachment ID";

                TeamLookUp."Document Attachment Table ID" := Rec."Table ID";
                TeamLookUp."Document Attachment No." := Rec."No.";
                TeamLookUp."Document Attachment Doc. Type" := Rec."Document Type";
                TeamLookUp."Document Attachment Line No." := Rec."Line No.";
                TeamLookUp."Document Attachment ID" := REc.ID;
                TeamLookUp.Modify();
            end
        end;

        IF (Rec."Table ID" = Database::Questionnaire) then begin
            Clear(Questionnaire);
            Questionnaire.SetRange(Code, Rec."No.");
            Questionnaire.FindFirst();
            Questionnaire."Attachment ID" := '';

            Questionnaire."Document Attachment Table ID" := 0;
            Questionnaire."Document Attachment No." := '';
            Questionnaire."Document Attachment Doc. Type" := Rec."Document Type"::Order;
            Questionnaire."Document Attachment Line No." := 0;
            Questionnaire."Document Attachment ID" := 0;
            Questionnaire.Modify();
            IF (NOT Rec.HasContent()) AND (Rec."to be removed") then begin

                Questionnaire."Attachment ID" := Rec."Attachment ID";

                Questionnaire."Document Attachment Table ID" := Rec."Table ID";
                Questionnaire."Document Attachment No." := Rec."No.";
                Questionnaire."Document Attachment Doc. Type" := Rec."Document Type";
                Questionnaire."Document Attachment Line No." := Rec."Line No.";
                Questionnaire."Document Attachment ID" := REc.ID;
                Questionnaire.Modify();
            end
        end;

        IF (Rec."Table ID" = Database::"Benefit Cart") then begin
            Clear(BenefitCart);
            BenefitCart.SetRange(Code, Rec."No.");
            BenefitCart.FindFirst();
            BenefitCart."Attachment ID" := '';

            BenefitCart."Document Attachment Table ID" := 0;
            BenefitCart."Document Attachment No." := '';
            BenefitCart."Document Attachment Doc. Type" := Rec."Document Type"::Order;
            BenefitCart."Document Attachment Line No." := 0;
            BenefitCart."Document Attachment ID" := 0;
            BenefitCart.Modify();
            IF (NOT Rec.HasContent()) AND (Rec."to be removed") then begin

                BenefitCart."Attachment ID" := Rec."Attachment ID";

                BenefitCart."Document Attachment Table ID" := Rec."Table ID";
                BenefitCart."Document Attachment No." := Rec."No.";
                BenefitCart."Document Attachment Doc. Type" := Rec."Document Type";
                BenefitCart."Document Attachment Line No." := Rec."Line No.";
                BenefitCart."Document Attachment ID" := REc.ID;
                BenefitCart.Modify();
            end
        end;
        IF (Rec."Table ID" = Database::"Interview Header") then begin
            Clear(InterviewHeader);
            InterviewHeader.SetRange("Interview No.", Rec."No.");
            InterviewHeader.FindFirst();
            InterviewHeader."Attachment ID" := '';

            InterviewHeader."Document Attachment Table ID" := 0;
            InterviewHeader."Document Attachment No." := '';
            InterviewHeader."Document Attachment Doc. Type" := Rec."Document Type"::Order;
            InterviewHeader."Document Attachment Line No." := 0;
            InterviewHeader."Document Attachment ID" := 0;
            InterviewHeader.Modify();
            IF (NOT Rec.HasContent()) AND (Rec."to be removed") then begin

                InterviewHeader."Attachment ID" := Rec."Attachment ID";

                InterviewHeader."Document Attachment Table ID" := Rec."Table ID";
                InterviewHeader."Document Attachment No." := Rec."No.";
                InterviewHeader."Document Attachment Doc. Type" := Rec."Document Type";
                InterviewHeader."Document Attachment Line No." := Rec."Line No.";
                InterviewHeader."Document Attachment ID" := REc.ID;
                InterviewHeader.Modify();
            end
        end;
    end;
}
