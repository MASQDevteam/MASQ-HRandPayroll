page 72164 "Benefits Cue Page"
{
    Caption = 'Benefits Cue Page';
    PageType = CardPart;
    SourceTable = "Benefits Cue";
    RefreshOnActivate = true;
    ShowFilter = false;
    ApplicationArea = All;
    layout
    {
        area(Content)
        {
            cuegroup(Benefits)
            {
                //CueGroupLayout = Wide;
                ShowCaption = false;
                field(Dental; Rec.Dental)
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        BenefitCart: Record "Benefit Cart";
                        BenifitCartPage: Page "Benefit Cart";
                    begin
                        BenefitCart.SetRange("Plan Type", 'DENTAL');
                        BenifitCartPage.SetTableView(BenefitCart);
                        BenifitCartPage.Run();
                    end;
                }
                field(FSA; Rec.FSA)
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        BenefitCart: Record "Benefit Cart";
                        BenifitCartPage: Page "Benefit Cart";
                    begin
                        BenefitCart.SetRange("Plan Type", 'FSA');
                        BenifitCartPage.SetTableView(BenefitCart);
                        BenifitCartPage.Run();
                    end;
                }
                field(Life; Rec.Life)
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        BenefitCart: Record "Benefit Cart";
                        BenifitCartPage: Page "Benefit Cart";
                    begin
                        BenefitCart.SetRange("Plan Type", 'LIFE');
                        BenifitCartPage.SetTableView(BenefitCart);
                        BenifitCartPage.Run();
                    end;
                }
                field(Medical; Rec.Medical)
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        BenefitCart: Record "Benefit Cart";
                        BenifitCartPage: Page "Benefit Cart";
                    begin
                        BenefitCart.SetRange("Plan Type", 'MEDICAL');
                        BenifitCartPage.SetTableView(BenefitCart);
                        BenifitCartPage.Run();
                    end;

                }
                field(Savings; Rec.Savings)
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        BenefitCart: Record "Benefit Cart";
                        BenifitCartPage: Page "Benefit Cart";
                    begin
                        BenefitCart.SetRange("Plan Type", 'SAVINGS');
                        BenifitCartPage.SetTableView(BenefitCart);
                        BenifitCartPage.Run();
                    end;
                }

                field(Vision; Rec.Vision)
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        BenefitCart: Record "Benefit Cart";
                        BenifitCartPage: Page "Benefit Cart";
                    begin
                        BenefitCart.SetRange("Plan Type", 'VISION');
                        BenifitCartPage.SetTableView(BenefitCart);
                        BenifitCartPage.Run();
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
