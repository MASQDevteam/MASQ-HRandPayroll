page 72111 "MASQ Headline"
{
    Caption = 'Headline';
    PageType = HeadlinePart;
    RefreshOnActivate = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                Visible = UserGreetingVisible;
                field(GreetingText; RCHeadlinesPageCommon.GetGreetingText())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Greeting headline';
                    Editable = false;
                }
            }

        }
    }

    trigger OnOpenPage()
    begin
        RCHeadlinesPageCommon.HeadlineOnOpenPage(Page::"MASQ Headline");
        DefaultFieldsVisible := RCHeadlinesPageCommon.AreDefaultFieldsVisible();
        UserGreetingVisible := RCHeadlinesPageCommon.IsUserGreetingVisible();
    end;

    var
        RCHeadlinesPageCommon: Codeunit "RC Headlines Page Common";

        DefaultFieldsVisible: Boolean;
        UserGreetingVisible: Boolean;
}

