stock ShowBankHomePage(playerid)
{
    HideBankHomePage(playerid);

    BankHomePageTDs[playerid][0] = CreatePlayerTextDraw(playerid, 310.999877, 101.229652, "WELCOME_TO_H4RBOR_BANK");
    PlayerTextDrawLetterSize(playerid, BankHomePageTDs[playerid][0], 0.148000, 0.633481);
    PlayerTextDrawAlignment(playerid, BankHomePageTDs[playerid][0], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankHomePageTDs[playerid][0], -1);
    PlayerTextDrawSetShadow(playerid, BankHomePageTDs[playerid][0], false);
    PlayerTextDrawBackgroundColour(playerid, BankHomePageTDs[playerid][0], 255);
    PlayerTextDrawFont(playerid, BankHomePageTDs[playerid][0], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankHomePageTDs[playerid][0], true);

    BankHomePageTDs[playerid][1] = CreatePlayerTextDraw(playerid, 250.666549, 110.355567, "LEVO_OD_VAS_U_PADAJUCEM_MENIJU_ODABERITE_STAVKU_KOJA_VAM_JE_POTREBNA");
    PlayerTextDrawLetterSize(playerid, BankHomePageTDs[playerid][1], 0.148000, 0.633481);
    PlayerTextDrawAlignment(playerid, BankHomePageTDs[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankHomePageTDs[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, BankHomePageTDs[playerid][1], false);
    PlayerTextDrawBackgroundColour(playerid, BankHomePageTDs[playerid][1], 255);
    PlayerTextDrawFont(playerid, BankHomePageTDs[playerid][1], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankHomePageTDs[playerid][1], true);

    BankHomePageTDs[playerid][2] = CreatePlayerTextDraw(playerid, 199.666549, 163.866653, "ACCOUNTS_-_SLUZI_ZA_UPRAVLJANJE_VASIH_NALOGA(OTVARANJE,_ZATVARANJE...)");
    PlayerTextDrawLetterSize(playerid, BankHomePageTDs[playerid][2], 0.148000, 0.633481);
    PlayerTextDrawAlignment(playerid, BankHomePageTDs[playerid][2], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankHomePageTDs[playerid][2], -1);
    PlayerTextDrawSetShadow(playerid, BankHomePageTDs[playerid][2], false);
    PlayerTextDrawBackgroundColour(playerid, BankHomePageTDs[playerid][2], 255);
    PlayerTextDrawFont(playerid, BankHomePageTDs[playerid][2], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankHomePageTDs[playerid][2], true);

    BankHomePageTDs[playerid][3] = CreatePlayerTextDraw(playerid, 200.333251, 190.414810, "DEPOSIT_-_NA_DATOJ_STRANICI_MOZETE_OSTAVITI_NOVAC_NA_SVOJ_RACUN");
    PlayerTextDrawLetterSize(playerid, BankHomePageTDs[playerid][3], 0.148000, 0.633481);
    PlayerTextDrawAlignment(playerid, BankHomePageTDs[playerid][3], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankHomePageTDs[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, BankHomePageTDs[playerid][3], false);
    PlayerTextDrawBackgroundColour(playerid, BankHomePageTDs[playerid][3], 255);
    PlayerTextDrawFont(playerid, BankHomePageTDs[playerid][3], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankHomePageTDs[playerid][3], true);

    BankHomePageTDs[playerid][4] = CreatePlayerTextDraw(playerid, 199.999923, 217.377792, "TRANSFER_-_OMOGUCAVA_VAM_TRANSFER_VASEG_NOVCA");
    PlayerTextDrawLetterSize(playerid, BankHomePageTDs[playerid][4], 0.148000, 0.633481);
    PlayerTextDrawAlignment(playerid, BankHomePageTDs[playerid][4], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankHomePageTDs[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, BankHomePageTDs[playerid][4], false);
    PlayerTextDrawBackgroundColour(playerid, BankHomePageTDs[playerid][4], 255);
    PlayerTextDrawFont(playerid, BankHomePageTDs[playerid][4], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankHomePageTDs[playerid][4], true);

    BankHomePageTDs[playerid][5] = CreatePlayerTextDraw(playerid, 199.999923, 245.170394, "MY_CARDS_-_POKAZUJE_VASE_KARTICE_KOJE_POSEDUJETE");
    PlayerTextDrawLetterSize(playerid, BankHomePageTDs[playerid][5], 0.148000, 0.633481);
    PlayerTextDrawAlignment(playerid, BankHomePageTDs[playerid][5], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankHomePageTDs[playerid][5], -1);
    PlayerTextDrawSetShadow(playerid, BankHomePageTDs[playerid][5], false);
    PlayerTextDrawBackgroundColour(playerid, BankHomePageTDs[playerid][5], 255);
    PlayerTextDrawFont(playerid, BankHomePageTDs[playerid][5], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankHomePageTDs[playerid][5], true);

    BankHomePageTDs[playerid][6] = CreatePlayerTextDraw(playerid, 199.666595, 275.866760, "MY_ACCOUNT_-_DETALJAN_PREGLED_VASEG_NALOGA_KAO_I_UPRAVLJANJE_NJIME");
    PlayerTextDrawLetterSize(playerid, BankHomePageTDs[playerid][6], 0.148000, 0.633481);
    PlayerTextDrawAlignment(playerid, BankHomePageTDs[playerid][6], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankHomePageTDs[playerid][6], -1);
    PlayerTextDrawSetShadow(playerid, BankHomePageTDs[playerid][6], false);
    PlayerTextDrawBackgroundColour(playerid, BankHomePageTDs[playerid][6], 255);
    PlayerTextDrawFont(playerid, BankHomePageTDs[playerid][6], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankHomePageTDs[playerid][6], true);

    BankHomePageTDs[playerid][7] = CreatePlayerTextDraw(playerid, 200.000030, 352.192810, "DRAGO_NAM_JE_STO_STE_NAS_KORISNIK~n~SRDACNO_VAS_H4RBOR_BANK.");
    PlayerTextDrawLetterSize(playerid, BankHomePageTDs[playerid][7], 0.148000, 0.633481);
    PlayerTextDrawAlignment(playerid, BankHomePageTDs[playerid][7], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankHomePageTDs[playerid][7], -1);
    PlayerTextDrawSetShadow(playerid, BankHomePageTDs[playerid][7], false);
    PlayerTextDrawBackgroundColour(playerid, BankHomePageTDs[playerid][7], 255);
    PlayerTextDrawFont(playerid, BankHomePageTDs[playerid][7], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankHomePageTDs[playerid][7], true);


    for(new i = 0; i < sizeof(BankHomePageTDs[]); i++)
    {
        PlayerTextDrawShow(playerid, BankHomePageTDs[playerid][i]);
    }

}

stock HideBankHomePage(playerid)
{
    for(new i = 0; i < sizeof(BankHomePageTDs[]); i++)
    {
        if(BankHomePageTDs[playerid][i] == INVALID_PLAYER_TEXT_DRAW) continue;

        PlayerTextDrawDestroy(playerid, BankHomePageTDs[playerid][i]);
        BankHomePageTDs[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
    }
}