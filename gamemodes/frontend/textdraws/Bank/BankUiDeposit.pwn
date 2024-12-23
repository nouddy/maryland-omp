#include <ysilib\YSI_Coding\y_hooks>


stock ShowBankDepositPage(playerid)
{
    HideBankDepositPage(playerid);

/*    
    BankDepositPageTDs[playerid][0] = CreatePlayerTextDraw(playerid, 99.333328, 174.911071, "");
    PlayerTextDrawTextSize(playerid, BankDepositPageTDs[playerid][0], 35.000000, 36.000000);
    PlayerTextDrawAlignment(playerid, BankDepositPageTDs[playerid][0], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankDepositPageTDs[playerid][0], -1);
    PlayerTextDrawSetShadow(playerid, BankDepositPageTDs[playerid][0], false);
    PlayerTextDrawBackgroundColour(playerid, BankDepositPageTDs[playerid][0], -256);
    PlayerTextDrawFont(playerid, BankDepositPageTDs[playerid][0], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid, BankDepositPageTDs[playerid][0], false);
    PlayerTextDrawSetPreviewModel(playerid, BankDepositPageTDs[playerid][0], 19177);
    PlayerTextDrawSetPreviewRot(playerid, BankDepositPageTDs[playerid][0], 0.000000, 270.000000, 0.000000, 1.000000);
*/


    BankDepositPageTDs[playerid][1] = CreatePlayerTextDraw(playerid, 482.999969, 96.666656, "Deposit");
    PlayerTextDrawLetterSize(playerid, BankDepositPageTDs[playerid][1], 0.133999, 0.720592);
    PlayerTextDrawAlignment(playerid, BankDepositPageTDs[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankDepositPageTDs[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, BankDepositPageTDs[playerid][1], false);
    PlayerTextDrawBackgroundColour(playerid, BankDepositPageTDs[playerid][1], 255);
    PlayerTextDrawFont(playerid, BankDepositPageTDs[playerid][1], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankDepositPageTDs[playerid][1], true);

    BankDepositPageTDs[playerid][2] = CreatePlayerTextDraw(playerid, 468.666534, 106.466667, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankDepositPageTDs[playerid][2], 45.000000, 0.400000);
    PlayerTextDrawAlignment(playerid, BankDepositPageTDs[playerid][2], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankDepositPageTDs[playerid][2], -106);
    PlayerTextDrawSetShadow(playerid, BankDepositPageTDs[playerid][2], false);
    PlayerTextDrawBackgroundColour(playerid, BankDepositPageTDs[playerid][2], 255);
    PlayerTextDrawFont(playerid, BankDepositPageTDs[playerid][2], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankDepositPageTDs[playerid][2], false);

    BankDepositPageTDs[playerid][3] = CreatePlayerTextDraw(playerid, 469.866638, 100.385169, "/");
    PlayerTextDrawLetterSize(playerid, BankDepositPageTDs[playerid][3], -0.362998, 0.807703);
    PlayerTextDrawAlignment(playerid, BankDepositPageTDs[playerid][3], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankDepositPageTDs[playerid][3], -156);
    PlayerTextDrawSetShadow(playerid, BankDepositPageTDs[playerid][3], false);
    PlayerTextDrawBackgroundColour(playerid, BankDepositPageTDs[playerid][3], 255);
    PlayerTextDrawFont(playerid, BankDepositPageTDs[playerid][3], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, BankDepositPageTDs[playerid][3], true);

    BankDepositPageTDs[playerid][4] = CreatePlayerTextDraw(playerid, 397.000030, 145.459228, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankDepositPageTDs[playerid][4], 107.000000, 188.000000);
    PlayerTextDrawAlignment(playerid, BankDepositPageTDs[playerid][4], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankDepositPageTDs[playerid][4], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankDepositPageTDs[playerid][4], false);
    PlayerTextDrawBackgroundColour(playerid, BankDepositPageTDs[playerid][4], 255);
    PlayerTextDrawFont(playerid, BankDepositPageTDs[playerid][4], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankDepositPageTDs[playerid][4], false);

    BankDepositPageTDs[playerid][5] = CreatePlayerTextDraw(playerid, 389.733367, 321.855560, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, BankDepositPageTDs[playerid][5], 14.000000, 14.000000);
    PlayerTextDrawAlignment(playerid, BankDepositPageTDs[playerid][5], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankDepositPageTDs[playerid][5], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankDepositPageTDs[playerid][5], false);
    PlayerTextDrawBackgroundColour(playerid, BankDepositPageTDs[playerid][5], 255);
    PlayerTextDrawFont(playerid, BankDepositPageTDs[playerid][5], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankDepositPageTDs[playerid][5], false);

    BankDepositPageTDs[playerid][6] = CreatePlayerTextDraw(playerid, 389.733367, 143.025985, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, BankDepositPageTDs[playerid][6], 14.000000, 14.000000);
    PlayerTextDrawAlignment(playerid, BankDepositPageTDs[playerid][6], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankDepositPageTDs[playerid][6], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankDepositPageTDs[playerid][6], false);
    PlayerTextDrawBackgroundColour(playerid, BankDepositPageTDs[playerid][6], 255);
    PlayerTextDrawFont(playerid, BankDepositPageTDs[playerid][6], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankDepositPageTDs[playerid][6], false);

    BankDepositPageTDs[playerid][7] = CreatePlayerTextDraw(playerid, 497.066650, 143.025985, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, BankDepositPageTDs[playerid][7], 14.000000, 14.000000);
    PlayerTextDrawAlignment(playerid, BankDepositPageTDs[playerid][7], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankDepositPageTDs[playerid][7], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankDepositPageTDs[playerid][7], false);
    PlayerTextDrawBackgroundColour(playerid, BankDepositPageTDs[playerid][7], 255);
    PlayerTextDrawFont(playerid, BankDepositPageTDs[playerid][7], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankDepositPageTDs[playerid][7], false);

    BankDepositPageTDs[playerid][8] = CreatePlayerTextDraw(playerid, 497.066650, 321.925964, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, BankDepositPageTDs[playerid][8], 14.000000, 14.000000);
    PlayerTextDrawAlignment(playerid, BankDepositPageTDs[playerid][8], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankDepositPageTDs[playerid][8], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankDepositPageTDs[playerid][8], false);
    PlayerTextDrawBackgroundColour(playerid, BankDepositPageTDs[playerid][8], 255);
    PlayerTextDrawFont(playerid, BankDepositPageTDs[playerid][8], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankDepositPageTDs[playerid][8], false);

    BankDepositPageTDs[playerid][9] = CreatePlayerTextDraw(playerid, 391.966766, 149.910919, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankDepositPageTDs[playerid][9], 116.879974, 178.379791);
    PlayerTextDrawAlignment(playerid, BankDepositPageTDs[playerid][9], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankDepositPageTDs[playerid][9], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankDepositPageTDs[playerid][9], false);
    PlayerTextDrawBackgroundColour(playerid, BankDepositPageTDs[playerid][9], 255);
    PlayerTextDrawFont(playerid, BankDepositPageTDs[playerid][9], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankDepositPageTDs[playerid][9], false);

    BankDepositPageTDs[playerid][10] = CreatePlayerTextDraw(playerid, 104.333236, 154.170410, "");
    PlayerTextDrawTextSize(playerid, BankDepositPageTDs[playerid][10], 183.000000, 24.000000);
    PlayerTextDrawAlignment(playerid, BankDepositPageTDs[playerid][10], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankDepositPageTDs[playerid][10], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankDepositPageTDs[playerid][10], false);
    PlayerTextDrawBackgroundColour(playerid, BankDepositPageTDs[playerid][10], -256);
    PlayerTextDrawFont(playerid, BankDepositPageTDs[playerid][10], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid, BankDepositPageTDs[playerid][10], false);
    PlayerTextDrawSetPreviewModel(playerid, BankDepositPageTDs[playerid][10], 1317);
    PlayerTextDrawSetPreviewRot(playerid, BankDepositPageTDs[playerid][10], 0.000000, 270.000000, 0.000000, 1.000000);

    BankDepositPageTDs[playerid][11] = CreatePlayerTextDraw(playerid, 104.333236, 187.770385, "");
    PlayerTextDrawTextSize(playerid, BankDepositPageTDs[playerid][11], 183.000000, 24.000000);
    PlayerTextDrawAlignment(playerid, BankDepositPageTDs[playerid][11], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankDepositPageTDs[playerid][11], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankDepositPageTDs[playerid][11], false);
    PlayerTextDrawBackgroundColour(playerid, BankDepositPageTDs[playerid][11], -256);
    PlayerTextDrawFont(playerid, BankDepositPageTDs[playerid][11], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid, BankDepositPageTDs[playerid][11], false);
    PlayerTextDrawSetPreviewModel(playerid, BankDepositPageTDs[playerid][11], 1317);
    PlayerTextDrawSetPreviewRot(playerid, BankDepositPageTDs[playerid][11], 0.000000, 270.000000, 0.000000, 1.000000);

    BankDepositPageTDs[playerid][12] = CreatePlayerTextDraw(playerid, 104.333236, 246.674118, "");
    PlayerTextDrawTextSize(playerid, BankDepositPageTDs[playerid][12], 183.000000, 24.000000);
    PlayerTextDrawAlignment(playerid, BankDepositPageTDs[playerid][12], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankDepositPageTDs[playerid][12], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankDepositPageTDs[playerid][12], false);
    PlayerTextDrawBackgroundColour(playerid, BankDepositPageTDs[playerid][12], -256);
    PlayerTextDrawFont(playerid, BankDepositPageTDs[playerid][12], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid, BankDepositPageTDs[playerid][12], false);
    PlayerTextDrawSetPreviewModel(playerid, BankDepositPageTDs[playerid][12], 1317);
    PlayerTextDrawSetPreviewRot(playerid, BankDepositPageTDs[playerid][12], 0.000000, 270.000000, 0.000000, 1.000000);

    BankDepositPageTDs[playerid][13] = CreatePlayerTextDraw(playerid, 240.000000, 168.429611, "CURRENCY");
    PlayerTextDrawTextSize(playerid, BankDepositPageTDs[playerid][13], 8.000000, 48.000000);
    PlayerTextDrawLetterSize(playerid, BankDepositPageTDs[playerid][13], 0.195666, 0.716444);
    PlayerTextDrawAlignment(playerid, BankDepositPageTDs[playerid][13], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankDepositPageTDs[playerid][13], -141);
    PlayerTextDrawSetShadow(playerid, BankDepositPageTDs[playerid][13], false);
    PlayerTextDrawBackgroundColour(playerid, BankDepositPageTDs[playerid][13], 255);
    PlayerTextDrawFont(playerid, BankDepositPageTDs[playerid][13], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankDepositPageTDs[playerid][13], true);
    PlayerTextDrawSetSelectable(playerid, BankDepositPageTDs[playerid][13], true);

    BankDepositPageTDs[playerid][14] = CreatePlayerTextDraw(playerid, 240.000000, 202.444427, "VALUE");
    PlayerTextDrawTextSize(playerid, BankDepositPageTDs[playerid][14], 8.000000, 48.000000);
    PlayerTextDrawLetterSize(playerid, BankDepositPageTDs[playerid][14], 0.195666, 0.716444);
    PlayerTextDrawAlignment(playerid, BankDepositPageTDs[playerid][14], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankDepositPageTDs[playerid][14], -141);
    PlayerTextDrawSetShadow(playerid, BankDepositPageTDs[playerid][14], false);
    PlayerTextDrawBackgroundColour(playerid, BankDepositPageTDs[playerid][14], 255);
    PlayerTextDrawFont(playerid, BankDepositPageTDs[playerid][14], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankDepositPageTDs[playerid][14], true);
    PlayerTextDrawSetSelectable(playerid, BankDepositPageTDs[playerid][14], true);

    BankDepositPageTDs[playerid][15] = CreatePlayerTextDraw(playerid, 240.000000, 261.763000, "NEW_VALUE");
    PlayerTextDrawLetterSize(playerid, BankDepositPageTDs[playerid][15], 0.195666, 0.716444);
    PlayerTextDrawAlignment(playerid, BankDepositPageTDs[playerid][15], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankDepositPageTDs[playerid][15], -1);
    PlayerTextDrawSetShadow(playerid, BankDepositPageTDs[playerid][15], false);
    PlayerTextDrawBackgroundColour(playerid, BankDepositPageTDs[playerid][15], 255);
    PlayerTextDrawFont(playerid, BankDepositPageTDs[playerid][15], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankDepositPageTDs[playerid][15], true);

    BankDepositPageTDs[playerid][16] = CreatePlayerTextDraw(playerid, 241.000030, 156.814834, "ODABERITE_VALUTU_ZA_DEPOSIT");
    PlayerTextDrawLetterSize(playerid, BankDepositPageTDs[playerid][16], 0.133999, 0.558812);
    PlayerTextDrawAlignment(playerid, BankDepositPageTDs[playerid][16], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankDepositPageTDs[playerid][16], -181);
    PlayerTextDrawSetShadow(playerid, BankDepositPageTDs[playerid][16], false);
    PlayerTextDrawBackgroundColour(playerid, BankDepositPageTDs[playerid][16], 255);
    PlayerTextDrawFont(playerid, BankDepositPageTDs[playerid][16], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankDepositPageTDs[playerid][16], true);

    BankDepositPageTDs[playerid][17] = CreatePlayerTextDraw(playerid, 241.000030, 192.488922, "UNESITE_VREDNOST_KOJU_DEPOZITUJETE");
    PlayerTextDrawLetterSize(playerid, BankDepositPageTDs[playerid][17], 0.133999, 0.558812);
    PlayerTextDrawAlignment(playerid, BankDepositPageTDs[playerid][17], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankDepositPageTDs[playerid][17], -181);
    PlayerTextDrawSetShadow(playerid, BankDepositPageTDs[playerid][17], false);
    PlayerTextDrawBackgroundColour(playerid, BankDepositPageTDs[playerid][17], 255);
    PlayerTextDrawFont(playerid, BankDepositPageTDs[playerid][17], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankDepositPageTDs[playerid][17], true);

    BankDepositPageTDs[playerid][18] = CreatePlayerTextDraw(playerid, 241.000030, 250.977828, "NOVA_VREDNOST_NA_RACUNU");
    PlayerTextDrawLetterSize(playerid, BankDepositPageTDs[playerid][18], 0.133999, 0.558812);
    PlayerTextDrawAlignment(playerid, BankDepositPageTDs[playerid][18], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankDepositPageTDs[playerid][18], -181);
    PlayerTextDrawSetShadow(playerid, BankDepositPageTDs[playerid][18], false);
    PlayerTextDrawBackgroundColour(playerid, BankDepositPageTDs[playerid][18], 255);
    PlayerTextDrawFont(playerid, BankDepositPageTDs[playerid][18], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankDepositPageTDs[playerid][18], true);

    static iban_str[122];
    format(iban_str, sizeof iban_str, "IBAN_(%s)", FormatIBANString(PlayerBankAccounts[playerid][ ActivePlayerBankAccount[playerid] ][IBAN]));

    BankDepositPageTDs[playerid][19] = CreatePlayerTextDraw(playerid, 450.666717, 158.888931, iban_str);
    PlayerTextDrawLetterSize(playerid, BankDepositPageTDs[playerid][19], 0.195666, 0.716444);
    PlayerTextDrawAlignment(playerid, BankDepositPageTDs[playerid][19], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankDepositPageTDs[playerid][19], -1);
    PlayerTextDrawSetShadow(playerid, BankDepositPageTDs[playerid][19], false);
    PlayerTextDrawBackgroundColour(playerid, BankDepositPageTDs[playerid][19], 255);
    PlayerTextDrawFont(playerid, BankDepositPageTDs[playerid][19], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankDepositPageTDs[playerid][19], true);

    
    BankDepositPageTDs[playerid][20] = CreatePlayerTextDraw(playerid, 396.666748, 185.851928, "CURRENT:_CHOOSE_CURNNECY");
    PlayerTextDrawLetterSize(playerid, BankDepositPageTDs[playerid][20], 0.123332, 0.492444);
    PlayerTextDrawAlignment(playerid, BankDepositPageTDs[playerid][20], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankDepositPageTDs[playerid][20], -1);
    PlayerTextDrawSetShadow(playerid, BankDepositPageTDs[playerid][20], false);
    PlayerTextDrawBackgroundColour(playerid, BankDepositPageTDs[playerid][20], 255);
    PlayerTextDrawFont(playerid, BankDepositPageTDs[playerid][20], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankDepositPageTDs[playerid][20], true);

    BankDepositPageTDs[playerid][21] = CreatePlayerTextDraw(playerid, 396.666748, 202.859283, "NEW:_NOVO_STANJE_BI_BILO");
    PlayerTextDrawLetterSize(playerid, BankDepositPageTDs[playerid][21], 0.123332, 0.492444);
    PlayerTextDrawAlignment(playerid, BankDepositPageTDs[playerid][21], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankDepositPageTDs[playerid][21], -1);
    PlayerTextDrawSetShadow(playerid, BankDepositPageTDs[playerid][21], false);
    PlayerTextDrawBackgroundColour(playerid, BankDepositPageTDs[playerid][21], 255);
    PlayerTextDrawFont(playerid, BankDepositPageTDs[playerid][21], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankDepositPageTDs[playerid][21], true);

    BankDepositPageTDs[playerid][22] = CreatePlayerTextDraw(playerid, 452.000091, 291.629760, "DEPOSIT");
    PlayerTextDrawTextSize(playerid, BankDepositPageTDs[playerid][22], 8.000000, 48.000000);
    PlayerTextDrawLetterSize(playerid, BankDepositPageTDs[playerid][22], 0.249666, 0.936294);
    PlayerTextDrawAlignment(playerid, BankDepositPageTDs[playerid][22], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankDepositPageTDs[playerid][22], -141);
    PlayerTextDrawSetShadow(playerid, BankDepositPageTDs[playerid][22], false);
    PlayerTextDrawBackgroundColour(playerid, BankDepositPageTDs[playerid][22], 255);
    PlayerTextDrawFont(playerid, BankDepositPageTDs[playerid][22], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankDepositPageTDs[playerid][22], true);
    PlayerTextDrawSetSelectable(playerid, BankDepositPageTDs[playerid][22], true);

    BankDepositPageTDs[playerid][23] = CreatePlayerTextDraw(playerid, 428.633544, 289.288665, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankDepositPageTDs[playerid][23], 45.000000, 0.469998);
    PlayerTextDrawAlignment(playerid, BankDepositPageTDs[playerid][23], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankDepositPageTDs[playerid][23], -121);
    PlayerTextDrawSetShadow(playerid, BankDepositPageTDs[playerid][23], false);
    PlayerTextDrawBackgroundColour(playerid, BankDepositPageTDs[playerid][23], 255);
    PlayerTextDrawFont(playerid, BankDepositPageTDs[playerid][23], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankDepositPageTDs[playerid][23], false);

    BankDepositPageTDs[playerid][24] = CreatePlayerTextDraw(playerid, 428.633544, 303.392425, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankDepositPageTDs[playerid][24], 45.000000, 0.469998);
    PlayerTextDrawAlignment(playerid, BankDepositPageTDs[playerid][24], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankDepositPageTDs[playerid][24], -121);
    PlayerTextDrawSetShadow(playerid, BankDepositPageTDs[playerid][24], false);
    PlayerTextDrawBackgroundColour(playerid, BankDepositPageTDs[playerid][24], 255);
    PlayerTextDrawFont(playerid, BankDepositPageTDs[playerid][24], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankDepositPageTDs[playerid][24], false);

    BankDepositPageTDs[playerid][25] = CreatePlayerTextDraw(playerid, 472.333404, 292.577606, "/");
    PlayerTextDrawLetterSize(playerid, BankDepositPageTDs[playerid][25], 0.335000, 1.450664);
    PlayerTextDrawAlignment(playerid, BankDepositPageTDs[playerid][25], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankDepositPageTDs[playerid][25], -156);
    PlayerTextDrawSetShadow(playerid, BankDepositPageTDs[playerid][25], false);
    PlayerTextDrawBackgroundColour(playerid, BankDepositPageTDs[playerid][25], 255);
    PlayerTextDrawFont(playerid, BankDepositPageTDs[playerid][25], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, BankDepositPageTDs[playerid][25], true);

    BankDepositPageTDs[playerid][26] = CreatePlayerTextDraw(playerid, 424.100097, 285.955444, "/");
    PlayerTextDrawLetterSize(playerid, BankDepositPageTDs[playerid][26], 0.335000, 1.450664);
    PlayerTextDrawAlignment(playerid, BankDepositPageTDs[playerid][26], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankDepositPageTDs[playerid][26], -156);
    PlayerTextDrawSetShadow(playerid, BankDepositPageTDs[playerid][26], false);
    PlayerTextDrawBackgroundColour(playerid, BankDepositPageTDs[playerid][26], 255);
    PlayerTextDrawFont(playerid, BankDepositPageTDs[playerid][26], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, BankDepositPageTDs[playerid][26], true);

    for(new i = 0; i < sizeof(BankDepositPageTDs[]); i++)
    {
        PlayerTextDrawShow(playerid, BankDepositPageTDs[playerid][i]);
    }
    return 1;
}

stock HideBankDepositPage(playerid)
{
    for(new i = 0; i < sizeof(BankDepositPageTDs[]); i++)
    {
        if(BankDepositPageTDs[playerid][i] == INVALID_PLAYER_TEXT_DRAW) continue;

        PlayerTextDrawDestroy(playerid, BankDepositPageTDs[playerid][i]);
        BankDepositPageTDs[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
    }
    return 1;
}

stock bool:IsBankDepositCurrencyButton(playerid, PlayerText:playertextid) {

    if( playertextid == BankDepositPageTDs[playerid][13] )
        return true;
    
    return false;
}

stock bool:IsBankDepositValueButton(playerid, PlayerText:playertextid) {

    if( playertextid == BankDepositPageTDs[playerid][14] )
        return true;
    
    return false;
}


stock bool:IsBankDepositConfirmButton(playerid, PlayerText:playertextid) {

    if( playertextid == BankDepositPageTDs[playerid][22] )
        return true;
    
    return false;
}