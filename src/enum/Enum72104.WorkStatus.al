enum 72104 WorkStatus
{
    Extensible = true;
    Caption = 'Work Status';


    value(0; WORK)
    {
        Caption = 'Work';
    }

    value(1; OFF) { Caption = 'Off'; }
    value(2; HALFDAYWORK) { Caption = 'Half-Day Work'; }
    value(3; WFH) { Caption = 'Work From Home'; }
    value(4; WFHP) { Caption = 'Work From Home (Partial)'; }

}
