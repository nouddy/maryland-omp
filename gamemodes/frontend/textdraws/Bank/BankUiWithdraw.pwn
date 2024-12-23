#include <ysilib\YSI_Coding\y_hooks>


stock ShowBankWithdrawPage(playerid)
{

    for(new i = 0; i < sizeof(BankWithdrawPageTDs[]); i++)
    {
        if(BankWithdrawPageTDs[playerid][i] == INVALID_PLAYER_TEXT_DRAW) continue;

        PlayerTextDrawDestroy(playerid, BankWithdrawPageTDs[playerid][i]);
        BankWithdrawPageTDs[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
    }

/*    
    BankWithdrawPageTDs[playerid][0] = CreatePlayerTextDraw(playerid, 99.333328, 174.911071, "");
    PlayerTextDrawTextSize(playerid, BankWithdrawPageTDs[playerid][0], 35.000000, 36.000000);
    PlayerTextDrawAlignment(playerid, BankWithdrawPageTDs[playerid][0], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankWithdrawPageTDs[playerid][0], -1);
    PlayerTextDrawSetShadow(playerid, BankWithdrawPageTDs[playerid][0], false);
    PlayerTextDrawBackgroundColour(playerid, BankWithdrawPageTDs[playerid][0], -256);
    PlayerTextDrawFont(playerid, BankWithdrawPageTDs[playerid][0], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid, BankWithdrawPageTDs[playerid][0], false);
    PlayerTextDrawSetPreviewModel(playerid, BankWithdrawPageTDs[playerid][0], 19177);
    PlayerTextDrawSetPreviewRot(playerid, BankWithdrawPageTDs[playerid][0], 0.000000, 270.000000, 0.000000, 1.000000);
*/


    BankWithdrawPageTDs[playerid][1] = CreatePlayerTextDraw(playerid, 482.999969, 96.666656, "Withdraw");
    PlayerTextDrawLetterSize(playerid, BankWithdrawPageTDs[playerid][1], 0.133999, 0.720592);
    PlayerTextDrawAlignment(playerid, BankWithdrawPageTDs[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankWithdrawPageTDs[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, BankWithdrawPageTDs[playerid][1], false);
    PlayerTextDrawBackgroundColour(playerid, BankWithdrawPageTDs[playerid][1], 255);
    PlayerTextDrawFont(playerid, BankWithdrawPageTDs[playerid][1], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankWithdrawPageTDs[playerid][1], true);

    BankWithdrawPageTDs[playerid][2] = CreatePlayerTextDraw(playerid, 468.666534, 106.466667, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankWithdrawPageTDs[playerid][2], 45.000000, 0.400000);
    PlayerTextDrawAlignment(playerid, BankWithdrawPageTDs[playerid][2], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankWithdrawPageTDs[playerid][2], -106);
    PlayerTextDrawSetShadow(playerid, BankWithdrawPageTDs[playerid][2], false);
    PlayerTextDrawBackgroundColour(playerid, BankWithdrawPageTDs[playerid][2], 255);
    PlayerTextDrawFont(playerid, BankWithdrawPageTDs[playerid][2], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankWithdrawPageTDs[playerid][2], false);

    BankWithdrawPageTDs[playerid][3] = CreatePlayerTextDraw(playerid, 469.866638, 100.385169, "/");
    PlayerTextDrawLetterSize(playerid, BankWithdrawPageTDs[playerid][3], -0.362998, 0.807703);
    PlayerTextDrawAlignment(playerid, BankWithdrawPageTDs[playerid][3], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankWithdrawPageTDs[playerid][3], -156);
    PlayerTextDrawSetShadow(playerid, BankWithdrawPageTDs[playerid][3], false);
    PlayerTextDrawBackgroundColour(playerid, BankWithdrawPageTDs[playerid][3], 255);
    PlayerTextDrawFont(playerid, BankWithdrawPageTDs[playerid][3], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, BankWithdrawPageTDs[playerid][3], true);

    BankWithdrawPageTDs[playerid][4] = CreatePlayerTextDraw(playerid, 397.000030, 145.459228, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankWithdrawPageTDs[playerid][4], 107.000000, 188.000000);
    PlayerTextDrawAlignment(playerid, BankWithdrawPageTDs[playerid][4], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankWithdrawPageTDs[playerid][4], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankWithdrawPageTDs[playerid][4], false);
    PlayerTextDrawBackgroundColour(playerid, BankWithdrawPageTDs[playerid][4], 255);
    PlayerTextDrawFont(playerid, BankWithdrawPageTDs[playerid][4], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankWithdrawPageTDs[playerid][4], false);

    BankWithdrawPageTDs[playerid][5] = CreatePlayerTextDraw(playerid, 389.733367, 321.855560, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, BankWithdrawPageTDs[playerid][5], 14.000000, 14.000000);
    PlayerTextDrawAlignment(playerid, BankWithdrawPageTDs[playerid][5], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankWithdrawPageTDs[playerid][5], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankWithdrawPageTDs[playerid][5], false);
    PlayerTextDrawBackgroundColour(playerid, BankWithdrawPageTDs[playerid][5], 255);
    PlayerTextDrawFont(playerid, BankWithdrawPageTDs[playerid][5], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankWithdrawPageTDs[playerid][5], false);

    BankWithdrawPageTDs[playerid][6] = CreatePlayerTextDraw(playerid, 389.733367, 143.025985, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, BankWithdrawPageTDs[playerid][6], 14.000000, 14.000000);
    PlayerTextDrawAlignment(playerid, BankWithdrawPageTDs[playerid][6], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankWithdrawPageTDs[playerid][6], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankWithdrawPageTDs[playerid][6], false);
    PlayerTextDrawBackgroundColour(playerid, BankWithdrawPageTDs[playerid][6], 255);
    PlayerTextDrawFont(playerid, BankWithdrawPageTDs[playerid][6], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankWithdrawPageTDs[playerid][6], false);

    BankWithdrawPageTDs[playerid][7] = CreatePlayerTextDraw(playerid, 497.066650, 143.025985, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, BankWithdrawPageTDs[playerid][7], 14.000000, 14.000000);
    PlayerTextDrawAlignment(playerid, BankWithdrawPageTDs[playerid][7], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankWithdrawPageTDs[playerid][7], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankWithdrawPageTDs[playerid][7], false);
    PlayerTextDrawBackgroundColour(playerid, BankWithdrawPageTDs[playerid][7], 255);
    PlayerTextDrawFont(playerid, BankWithdrawPageTDs[playerid][7], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankWithdrawPageTDs[playerid][7], false);

    BankWithdrawPageTDs[playerid][8] = CreatePlayerTextDraw(playerid, 497.066650, 321.925964, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, BankWithdrawPageTDs[playerid][8], 14.000000, 14.000000);
    PlayerTextDrawAlignment(playerid, BankWithdrawPageTDs[playerid][8], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankWithdrawPageTDs[playerid][8], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankWithdrawPageTDs[playerid][8], false);
    PlayerTextDrawBackgroundColour(playerid, BankWithdrawPageTDs[playerid][8], 255);
    PlayerTextDrawFont(playerid, BankWithdrawPageTDs[playerid][8], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankWithdrawPageTDs[playerid][8], false);

    BankWithdrawPageTDs[playerid][9] = CreatePlayerTextDraw(playerid, 391.966766, 149.910919, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankWithdrawPageTDs[playerid][9], 116.879974, 178.379791);
    PlayerTextDrawAlignment(playerid, BankWithdrawPageTDs[playerid][9], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankWithdrawPageTDs[playerid][9], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankWithdrawPageTDs[playerid][9], false);
    PlayerTextDrawBackgroundColour(playerid, BankWithdrawPageTDs[playerid][9], 255);
    PlayerTextDrawFont(playerid, BankWithdrawPageTDs[playerid][9], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankWithdrawPageTDs[playerid][9], false);

    BankWithdrawPageTDs[playerid][10] = CreatePlayerTextDraw(playerid, 104.333236, 154.170410, "");
    PlayerTextDrawTextSize(playerid, BankWithdrawPageTDs[playerid][10], 183.000000, 24.000000);
    PlayerTextDrawAlignment(playerid, BankWithdrawPageTDs[playerid][10], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankWithdrawPageTDs[playerid][10], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankWithdrawPageTDs[playerid][10], false);
    PlayerTextDrawBackgroundColour(playerid, BankWithdrawPageTDs[playerid][10], -256);
    PlayerTextDrawFont(playerid, BankWithdrawPageTDs[playerid][10], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid, BankWithdrawPageTDs[playerid][10], false);
    PlayerTextDrawSetPreviewModel(playerid, BankWithdrawPageTDs[playerid][10], 1317);
    PlayerTextDrawSetPreviewRot(playerid, BankWithdrawPageTDs[playerid][10], 0.000000, 270.000000, 0.000000, 1.000000);

    BankWithdrawPageTDs[playerid][11] = CreatePlayerTextDraw(playerid, 104.333236, 187.770385, "");
    PlayerTextDrawTextSize(playerid, BankWithdrawPageTDs[playerid][11], 183.000000, 24.000000);
    PlayerTextDrawAlignment(playerid, BankWithdrawPageTDs[playerid][11], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankWithdrawPageTDs[playerid][11], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankWithdrawPageTDs[playerid][11], false);
    PlayerTextDrawBackgroundColour(playerid, BankWithdrawPageTDs[playerid][11], -256);
    PlayerTextDrawFont(playerid, BankWithdrawPageTDs[playerid][11], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid, BankWithdrawPageTDs[playerid][11], false);
    PlayerTextDrawSetPreviewModel(playerid, BankWithdrawPageTDs[playerid][11], 1317);
    PlayerTextDrawSetPreviewRot(playerid, BankWithdrawPageTDs[playerid][11], 0.000000, 270.000000, 0.000000, 1.000000);

    BankWithdrawPageTDs[playerid][12] = CreatePlayerTextDraw(playerid, 104.333236, 246.674118, "");
    PlayerTextDrawTextSize(playerid, BankWithdrawPageTDs[playerid][12], 183.000000, 24.000000);
    PlayerTextDrawAlignment(playerid, BankWithdrawPageTDs[playerid][12], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankWithdrawPageTDs[playerid][12], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankWithdrawPageTDs[playerid][12], false);
    PlayerTextDrawBackgroundColour(playerid, BankWithdrawPageTDs[playerid][12], -256);
    PlayerTextDrawFont(playerid, BankWithdrawPageTDs[playerid][12], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid, BankWithdrawPageTDs[playerid][12], false);
    PlayerTextDrawSetPreviewModel(playerid, BankWithdrawPageTDs[playerid][12], 1317);
    PlayerTextDrawSetPreviewRot(playerid, BankWithdrawPageTDs[playerid][12], 0.000000, 270.000000, 0.000000, 1.000000);

    BankWithdrawPageTDs[playerid][13] = CreatePlayerTextDraw(playerid, 240.000000, 168.429611, "CURRENCY");
    PlayerTextDrawTextSize(playerid, BankWithdrawPageTDs[playerid][13], 8.000000, 48.000000);
    PlayerTextDrawLetterSize(playerid, BankWithdrawPageTDs[playerid][13], 0.195666, 0.716444);
    PlayerTextDrawAlignment(playerid, BankWithdrawPageTDs[playerid][13], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankWithdrawPageTDs[playerid][13], -141);
    PlayerTextDrawSetShadow(playerid, BankWithdrawPageTDs[playerid][13], false);
    PlayerTextDrawBackgroundColour(playerid, BankWithdrawPageTDs[playerid][13], 255);
    PlayerTextDrawFont(playerid, BankWithdrawPageTDs[playerid][13], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankWithdrawPageTDs[playerid][13], true);
    PlayerTextDrawSetSelectable(playerid, BankWithdrawPageTDs[playerid][13], true);

    BankWithdrawPageTDs[playerid][14] = CreatePlayerTextDraw(playerid, 240.000000, 202.444427, "VALUE");
    PlayerTextDrawTextSize(playerid, BankWithdrawPageTDs[playerid][14], 8.000000, 48.000000);
    PlayerTextDrawLetterSize(playerid, BankWithdrawPageTDs[playerid][14], 0.195666, 0.716444);
    PlayerTextDrawAlignment(playerid, BankWithdrawPageTDs[playerid][14], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankWithdrawPageTDs[playerid][14], -141);
    PlayerTextDrawSetShadow(playerid, BankWithdrawPageTDs[playerid][14], false);
    PlayerTextDrawBackgroundColour(playerid, BankWithdrawPageTDs[playerid][14], 255);
    PlayerTextDrawFont(playerid, BankWithdrawPageTDs[playerid][14], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankWithdrawPageTDs[playerid][14], true);
    PlayerTextDrawSetSelectable(playerid, BankWithdrawPageTDs[playerid][14], true);

    BankWithdrawPageTDs[playerid][15] = CreatePlayerTextDraw(playerid, 240.000000, 261.763000, "NEW_VALUE");
    PlayerTextDrawLetterSize(playerid, BankWithdrawPageTDs[playerid][15], 0.195666, 0.716444);
    PlayerTextDrawAlignment(playerid, BankWithdrawPageTDs[playerid][15], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankWithdrawPageTDs[playerid][15], -1);
    PlayerTextDrawSetShadow(playerid, BankWithdrawPageTDs[playerid][15], false);
    PlayerTextDrawBackgroundColour(playerid, BankWithdrawPageTDs[playerid][15], 255);
    PlayerTextDrawFont(playerid, BankWithdrawPageTDs[playerid][15], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankWithdrawPageTDs[playerid][15], true);

    BankWithdrawPageTDs[playerid][16] = CreatePlayerTextDraw(playerid, 241.000030, 156.814834, "ODABERITE_VALUTU_ZA_DEPOSIT");
    PlayerTextDrawLetterSize(playerid, BankWithdrawPageTDs[playerid][16], 0.133999, 0.558812);
    PlayerTextDrawAlignment(playerid, BankWithdrawPageTDs[playerid][16], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankWithdrawPageTDs[playerid][16], -181);
    PlayerTextDrawSetShadow(playerid, BankWithdrawPageTDs[playerid][16], false);
    PlayerTextDrawBackgroundColour(playerid, BankWithdrawPageTDs[playerid][16], 255);
    PlayerTextDrawFont(playerid, BankWithdrawPageTDs[playerid][16], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankWithdrawPageTDs[playerid][16], true);

    BankWithdrawPageTDs[playerid][17] = CreatePlayerTextDraw(playerid, 241.000030, 192.488922, "UNESITE_VREDNOST_KOJU_DEPOZITUJETE");
    PlayerTextDrawLetterSize(playerid, BankWithdrawPageTDs[playerid][17], 0.133999, 0.558812);
    PlayerTextDrawAlignment(playerid, BankWithdrawPageTDs[playerid][17], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankWithdrawPageTDs[playerid][17], -181);
    PlayerTextDrawSetShadow(playerid, BankWithdrawPageTDs[playerid][17], false);
    PlayerTextDrawBackgroundColour(playerid, BankWithdrawPageTDs[playerid][17], 255);
    PlayerTextDrawFont(playerid, BankWithdrawPageTDs[playerid][17], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankWithdrawPageTDs[playerid][17], true);

    BankWithdrawPageTDs[playerid][18] = CreatePlayerTextDraw(playerid, 241.000030, 250.977828, "NOVA_VREDNOST_NA_RACUNU");
    PlayerTextDrawLetterSize(playerid, BankWithdrawPageTDs[playerid][18], 0.133999, 0.558812);
    PlayerTextDrawAlignment(playerid, BankWithdrawPageTDs[playerid][18], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankWithdrawPageTDs[playerid][18], -181);
    PlayerTextDrawSetShadow(playerid, BankWithdrawPageTDs[playerid][18], false);
    PlayerTextDrawBackgroundColour(playerid, BankWithdrawPageTDs[playerid][18], 255);
    PlayerTextDrawFont(playerid, BankWithdrawPageTDs[playerid][18], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankWithdrawPageTDs[playerid][18], true);

    static iban_str[122];
    format(iban_str, sizeof iban_str, "IBAN_(%s)", FormatIBANString(PlayerBankAccounts[playerid][ ActivePlayerBankAccount[playerid] ][IBAN]));

    BankWithdrawPageTDs[playerid][19] = CreatePlayerTextDraw(playerid, 450.666717, 158.888931, iban_str);
    PlayerTextDrawLetterSize(playerid, BankWithdrawPageTDs[playerid][19], 0.195666, 0.716444);
    PlayerTextDrawAlignment(playerid, BankWithdrawPageTDs[playerid][19], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankWithdrawPageTDs[playerid][19], -1);
    PlayerTextDrawSetShadow(playerid, BankWithdrawPageTDs[playerid][19], false);
    PlayerTextDrawBackgroundColour(playerid, BankWithdrawPageTDs[playerid][19], 255);
    PlayerTextDrawFont(playerid, BankWithdrawPageTDs[playerid][19], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankWithdrawPageTDs[playerid][19], true);

    
    BankWithdrawPageTDs[playerid][20] = CreatePlayerTextDraw(playerid, 396.666748, 185.851928, "CURRENT:_CHOOSE_CURNNECY");
    PlayerTextDrawLetterSize(playerid, BankWithdrawPageTDs[playerid][20], 0.123332, 0.492444);
    PlayerTextDrawAlignment(playerid, BankWithdrawPageTDs[playerid][20], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankWithdrawPageTDs[playerid][20], -1);
    PlayerTextDrawSetShadow(playerid, BankWithdrawPageTDs[playerid][20], false);
    PlayerTextDrawBackgroundColour(playerid, BankWithdrawPageTDs[playerid][20], 255);
    PlayerTextDrawFont(playerid, BankWithdrawPageTDs[playerid][20], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankWithdrawPageTDs[playerid][20], true);

    BankWithdrawPageTDs[playerid][21] = CreatePlayerTextDraw(playerid, 396.666748, 202.859283, "NEW:_NOVO_STANJE_BI_BILO");
    PlayerTextDrawLetterSize(playerid, BankWithdrawPageTDs[playerid][21], 0.123332, 0.492444);
    PlayerTextDrawAlignment(playerid, BankWithdrawPageTDs[playerid][21], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankWithdrawPageTDs[playerid][21], -1);
    PlayerTextDrawSetShadow(playerid, BankWithdrawPageTDs[playerid][21], false);
    PlayerTextDrawBackgroundColour(playerid, BankWithdrawPageTDs[playerid][21], 255);
    PlayerTextDrawFont(playerid, BankWithdrawPageTDs[playerid][21], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankWithdrawPageTDs[playerid][21], true);

    BankWithdrawPageTDs[playerid][22] = CreatePlayerTextDraw(playerid, 452.000091, 291.629760, "WITHDRAW");
    PlayerTextDrawTextSize(playerid, BankWithdrawPageTDs[playerid][22], 8.000000, 48.000000);
    PlayerTextDrawLetterSize(playerid, BankWithdrawPageTDs[playerid][22], 0.249666, 0.936294);
    PlayerTextDrawAlignment(playerid, BankWithdrawPageTDs[playerid][22], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankWithdrawPageTDs[playerid][22], -141);
    PlayerTextDrawSetShadow(playerid, BankWithdrawPageTDs[playerid][22], false);
    PlayerTextDrawBackgroundColour(playerid, BankWithdrawPageTDs[playerid][22], 255);
    PlayerTextDrawFont(playerid, BankWithdrawPageTDs[playerid][22], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankWithdrawPageTDs[playerid][22], true);
    PlayerTextDrawSetSelectable(playerid, BankWithdrawPageTDs[playerid][22], true);

    BankWithdrawPageTDs[playerid][23] = CreatePlayerTextDraw(playerid, 428.633544, 289.288665, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankWithdrawPageTDs[playerid][23], 45.000000, 0.469998);
    PlayerTextDrawAlignment(playerid, BankWithdrawPageTDs[playerid][23], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankWithdrawPageTDs[playerid][23], -121);
    PlayerTextDrawSetShadow(playerid, BankWithdrawPageTDs[playerid][23], false);
    PlayerTextDrawBackgroundColour(playerid, BankWithdrawPageTDs[playerid][23], 255);
    PlayerTextDrawFont(playerid, BankWithdrawPageTDs[playerid][23], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankWithdrawPageTDs[playerid][23], false);

    BankWithdrawPageTDs[playerid][24] = CreatePlayerTextDraw(playerid, 428.633544, 303.392425, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankWithdrawPageTDs[playerid][24], 45.000000, 0.469998);
    PlayerTextDrawAlignment(playerid, BankWithdrawPageTDs[playerid][24], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankWithdrawPageTDs[playerid][24], -121);
    PlayerTextDrawSetShadow(playerid, BankWithdrawPageTDs[playerid][24], false);
    PlayerTextDrawBackgroundColour(playerid, BankWithdrawPageTDs[playerid][24], 255);
    PlayerTextDrawFont(playerid, BankWithdrawPageTDs[playerid][24], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankWithdrawPageTDs[playerid][24], false);

    BankWithdrawPageTDs[playerid][25] = CreatePlayerTextDraw(playerid, 472.333404, 292.577606, "/");
    PlayerTextDrawLetterSize(playerid, BankWithdrawPageTDs[playerid][25], 0.335000, 1.450664);
    PlayerTextDrawAlignment(playerid, BankWithdrawPageTDs[playerid][25], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankWithdrawPageTDs[playerid][25], -156);
    PlayerTextDrawSetShadow(playerid, BankWithdrawPageTDs[playerid][25], false);
    PlayerTextDrawBackgroundColour(playerid, BankWithdrawPageTDs[playerid][25], 255);
    PlayerTextDrawFont(playerid, BankWithdrawPageTDs[playerid][25], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, BankWithdrawPageTDs[playerid][25], true);

    BankWithdrawPageTDs[playerid][26] = CreatePlayerTextDraw(playerid, 424.100097, 285.955444, "/");
    PlayerTextDrawLetterSize(playerid, BankWithdrawPageTDs[playerid][26], 0.335000, 1.450664);
    PlayerTextDrawAlignment(playerid, BankWithdrawPageTDs[playerid][26], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankWithdrawPageTDs[playerid][26], -156);
    PlayerTextDrawSetShadow(playerid, BankWithdrawPageTDs[playerid][26], false);
    PlayerTextDrawBackgroundColour(playerid, BankWithdrawPageTDs[playerid][26], 255);
    PlayerTextDrawFont(playerid, BankWithdrawPageTDs[playerid][26], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, BankWithdrawPageTDs[playerid][26], true);

    for(new i = 0; i < sizeof(BankWithdrawPageTDs[]); i++)
    {
        PlayerTextDrawShow(playerid, BankWithdrawPageTDs[playerid][i]);
    }
    return 1;
}

stock HideBankWithdrawPage(playerid)
{
    for(new i = 0; i < sizeof(BankWithdrawPageTDs[]); i++)
    {
        if(BankWithdrawPageTDs[playerid][i] == INVALID_PLAYER_TEXT_DRAW) continue;

        PlayerTextDrawDestroy(playerid, BankWithdrawPageTDs[playerid][i]);
        BankWithdrawPageTDs[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
    }
    return 1;
}

stock bool:IsBankWithdrawCurrencyButton(playerid, PlayerText:playertextid) {

    if( playertextid == BankWithdrawPageTDs[playerid][13] )
        return true;
    
    return false;
}

stock bool:IsBankWithdrawValueButton(playerid, PlayerText:playertextid) {

    if( playertextid == BankWithdrawPageTDs[playerid][14] )
        return true;
    
    return false;
}


stock bool:IsBankWithdrawConfirmButton(playerid, PlayerText:playertextid) {

    if( playertextid == BankWithdrawPageTDs[playerid][22] )
        return true;
    
    return false;
}