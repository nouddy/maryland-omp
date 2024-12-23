#include <ysilib\YSI_Coding\y_hooks>

enum eTransfersInfo {
    Float: ammount,
    fromAccount[24],
    toAccount[24],
    transferDescription[128],
    transferDate[24]//Should be timestamp
}
new TransfersDummyData[6][eTransfersInfo] = {
    {-480.0, "0000_0000_0000", "1111_1111_1111", "Uplata_za_namirenje_dugova_elektro_potrosnje.", "12_/_05_/_2023"},
    {-80.0, "0000_0000_0000", "1111_1111_1111", "Prihod_na_osnovu_radnog_staza.", "12_/_05_/_2023"},
    {-420.0, "0000_0000_0000", "1111_1111_1111", "Dnevna_doza_od_najboljeg_dilera.", "12_/_05_/_2023"},
    {480.0, "0000_0000_0000", "1111_1111_1111", "Uplata_za_namirenje_dugova_elektro_potrosnje.", "12_/_05_/_2023"},
    {-480.0, "0000_0000_0000", "1111_1111_1111", "Uplata_za_namirenje_dugova_elektro_potrosnje.", "12_/_05_/_2023"},
    {30.0, "0000_0000_0000", "1111_1111_1111", "Uplata_za_namirenje_dugova_elektro_potrosnje.", "12_/_05_/_2023"}
};

stock ShowBankMyAccountPage(playerid)
{
    HideBankMyAccountPage(playerid);

    BankMyAccountPageTDs[playerid][16] = CreatePlayerTextDraw(playerid, 468.666625, 96.666656, "Account_Informations");
    PlayerTextDrawLetterSize(playerid, BankMyAccountPageTDs[playerid][16], 0.133999, 0.720592);
    PlayerTextDrawAlignment(playerid, BankMyAccountPageTDs[playerid][16], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyAccountPageTDs[playerid][16], -1);
    PlayerTextDrawSetShadow(playerid, BankMyAccountPageTDs[playerid][16], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyAccountPageTDs[playerid][16], 255);
    PlayerTextDrawFont(playerid, BankMyAccountPageTDs[playerid][16], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankMyAccountPageTDs[playerid][16], true);

    BankMyAccountPageTDs[playerid][17] = CreatePlayerTextDraw(playerid, 468.666534, 106.466667, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankMyAccountPageTDs[playerid][17], 45.000000, 0.400000);
    PlayerTextDrawAlignment(playerid, BankMyAccountPageTDs[playerid][17], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyAccountPageTDs[playerid][17], -106);
    PlayerTextDrawSetShadow(playerid, BankMyAccountPageTDs[playerid][17], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyAccountPageTDs[playerid][17], 255);
    PlayerTextDrawFont(playerid, BankMyAccountPageTDs[playerid][17], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankMyAccountPageTDs[playerid][17], false);

    BankMyAccountPageTDs[playerid][18] = CreatePlayerTextDraw(playerid, 469.866638, 100.385169, "/");
    PlayerTextDrawLetterSize(playerid, BankMyAccountPageTDs[playerid][18], -0.362998, 0.807703);
    PlayerTextDrawAlignment(playerid, BankMyAccountPageTDs[playerid][18], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyAccountPageTDs[playerid][18], -156);
    PlayerTextDrawSetShadow(playerid, BankMyAccountPageTDs[playerid][18], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyAccountPageTDs[playerid][18], 255);
    PlayerTextDrawFont(playerid, BankMyAccountPageTDs[playerid][18], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, BankMyAccountPageTDs[playerid][18], true);

    BankMyAccountPageTDs[playerid][19] = CreatePlayerTextDraw(playerid, 200.999969, 128.037002, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankMyAccountPageTDs[playerid][19], 318.000000, 179.000000);
    PlayerTextDrawAlignment(playerid, BankMyAccountPageTDs[playerid][19], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyAccountPageTDs[playerid][19], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankMyAccountPageTDs[playerid][19], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyAccountPageTDs[playerid][19], 255);
    PlayerTextDrawFont(playerid, BankMyAccountPageTDs[playerid][19], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankMyAccountPageTDs[playerid][19], false);

    BankMyAccountPageTDs[playerid][20] = CreatePlayerTextDraw(playerid, 196.200012, 125.592422, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, BankMyAccountPageTDs[playerid][20], 12.000000, 14.000000);
    PlayerTextDrawAlignment(playerid, BankMyAccountPageTDs[playerid][20], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyAccountPageTDs[playerid][20], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankMyAccountPageTDs[playerid][20], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyAccountPageTDs[playerid][20], 255);
    PlayerTextDrawFont(playerid, BankMyAccountPageTDs[playerid][20], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankMyAccountPageTDs[playerid][20], false);

    BankMyAccountPageTDs[playerid][21] = CreatePlayerTextDraw(playerid, 195.800155, 295.551818, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, BankMyAccountPageTDs[playerid][21], 12.000000, 14.000000);
    PlayerTextDrawAlignment(playerid, BankMyAccountPageTDs[playerid][21], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyAccountPageTDs[playerid][21], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankMyAccountPageTDs[playerid][21], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyAccountPageTDs[playerid][21], 255);
    PlayerTextDrawFont(playerid, BankMyAccountPageTDs[playerid][21], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankMyAccountPageTDs[playerid][21], false);

    BankMyAccountPageTDs[playerid][22] = CreatePlayerTextDraw(playerid, 512.000122, 125.577629, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, BankMyAccountPageTDs[playerid][22], 12.000000, 14.000000);
    PlayerTextDrawAlignment(playerid, BankMyAccountPageTDs[playerid][22], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyAccountPageTDs[playerid][22], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankMyAccountPageTDs[playerid][22], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyAccountPageTDs[playerid][22], 255);
    PlayerTextDrawFont(playerid, BankMyAccountPageTDs[playerid][22], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankMyAccountPageTDs[playerid][22], false);

    BankMyAccountPageTDs[playerid][23] = CreatePlayerTextDraw(playerid, 511.500152, 295.643920, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, BankMyAccountPageTDs[playerid][23], 12.000000, 14.000000);
    PlayerTextDrawAlignment(playerid, BankMyAccountPageTDs[playerid][23], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyAccountPageTDs[playerid][23], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankMyAccountPageTDs[playerid][23], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyAccountPageTDs[playerid][23], 255);
    PlayerTextDrawFont(playerid, BankMyAccountPageTDs[playerid][23], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankMyAccountPageTDs[playerid][23], false);

    BankMyAccountPageTDs[playerid][24] = CreatePlayerTextDraw(playerid, 198.099853, 132.185134, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankMyAccountPageTDs[playerid][24], 323.750732, 170.000000);
    PlayerTextDrawAlignment(playerid, BankMyAccountPageTDs[playerid][24], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyAccountPageTDs[playerid][24], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankMyAccountPageTDs[playerid][24], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyAccountPageTDs[playerid][24], 255);
    PlayerTextDrawFont(playerid, BankMyAccountPageTDs[playerid][24], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankMyAccountPageTDs[playerid][24], false);

    BankMyAccountPageTDs[playerid][25] = CreatePlayerTextDraw(playerid, 222.333221, 119.896286, "TRANSACTIONS");
    PlayerTextDrawLetterSize(playerid, BankMyAccountPageTDs[playerid][25], 0.135997, 0.479999);
    PlayerTextDrawAlignment(playerid, BankMyAccountPageTDs[playerid][25], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankMyAccountPageTDs[playerid][25], -1);
    PlayerTextDrawSetShadow(playerid, BankMyAccountPageTDs[playerid][25], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyAccountPageTDs[playerid][25], 255);
    PlayerTextDrawFont(playerid, BankMyAccountPageTDs[playerid][25], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankMyAccountPageTDs[playerid][25], true);

    BankMyAccountPageTDs[playerid][26] = CreatePlayerTextDraw(playerid, 199.666702, 138.407394, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankMyAccountPageTDs[playerid][26], 321.000000, 23.000000);
    PlayerTextDrawAlignment(playerid, BankMyAccountPageTDs[playerid][26], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyAccountPageTDs[playerid][26], 539506175);
    PlayerTextDrawSetShadow(playerid, BankMyAccountPageTDs[playerid][26], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyAccountPageTDs[playerid][26], 255);
    PlayerTextDrawFont(playerid, BankMyAccountPageTDs[playerid][26], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankMyAccountPageTDs[playerid][26], false);

    BankMyAccountPageTDs[playerid][27] = CreatePlayerTextDraw(playerid, 199.666702, 164.540756, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankMyAccountPageTDs[playerid][27], 321.000000, 23.000000);
    PlayerTextDrawAlignment(playerid, BankMyAccountPageTDs[playerid][27], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyAccountPageTDs[playerid][27], 539506175);
    PlayerTextDrawSetShadow(playerid, BankMyAccountPageTDs[playerid][27], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyAccountPageTDs[playerid][27], 255);
    PlayerTextDrawFont(playerid, BankMyAccountPageTDs[playerid][27], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankMyAccountPageTDs[playerid][27], false);

    BankMyAccountPageTDs[playerid][28] = CreatePlayerTextDraw(playerid, 199.666702, 190.259323, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankMyAccountPageTDs[playerid][28], 321.000000, 23.000000);
    PlayerTextDrawAlignment(playerid, BankMyAccountPageTDs[playerid][28], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyAccountPageTDs[playerid][28], 539506175);
    PlayerTextDrawSetShadow(playerid, BankMyAccountPageTDs[playerid][28], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyAccountPageTDs[playerid][28], 255);
    PlayerTextDrawFont(playerid, BankMyAccountPageTDs[playerid][28], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankMyAccountPageTDs[playerid][28], false);

    BankMyAccountPageTDs[playerid][29] = CreatePlayerTextDraw(playerid, 199.666702, 215.977828, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankMyAccountPageTDs[playerid][29], 321.000000, 23.000000);
    PlayerTextDrawAlignment(playerid, BankMyAccountPageTDs[playerid][29], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyAccountPageTDs[playerid][29], 539506175);
    PlayerTextDrawSetShadow(playerid, BankMyAccountPageTDs[playerid][29], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyAccountPageTDs[playerid][29], 255);
    PlayerTextDrawFont(playerid, BankMyAccountPageTDs[playerid][29], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankMyAccountPageTDs[playerid][29], false);

    BankMyAccountPageTDs[playerid][30] = CreatePlayerTextDraw(playerid, 199.666702, 241.281570, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankMyAccountPageTDs[playerid][30], 321.000000, 23.000000);
    PlayerTextDrawAlignment(playerid, BankMyAccountPageTDs[playerid][30], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyAccountPageTDs[playerid][30], 539506175);
    PlayerTextDrawSetShadow(playerid, BankMyAccountPageTDs[playerid][30], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyAccountPageTDs[playerid][30], 255);
    PlayerTextDrawFont(playerid, BankMyAccountPageTDs[playerid][30], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankMyAccountPageTDs[playerid][30], false);

    BankMyAccountPageTDs[playerid][31] = CreatePlayerTextDraw(playerid, 199.666702, 267.000030, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankMyAccountPageTDs[playerid][31], 321.000000, 23.000000);
    PlayerTextDrawAlignment(playerid, BankMyAccountPageTDs[playerid][31], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyAccountPageTDs[playerid][31], 539506175);
    PlayerTextDrawSetShadow(playerid, BankMyAccountPageTDs[playerid][31], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyAccountPageTDs[playerid][31], 255);
    PlayerTextDrawFont(playerid, BankMyAccountPageTDs[playerid][31], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankMyAccountPageTDs[playerid][31], false);

    BankMyAccountPageTDs[playerid][32] = CreatePlayerTextDraw(playerid, 240.333282, 118.651916, "/");
    PlayerTextDrawLetterSize(playerid, BankMyAccountPageTDs[playerid][32], 0.141664, 0.637628);
    PlayerTextDrawAlignment(playerid, BankMyAccountPageTDs[playerid][32], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyAccountPageTDs[playerid][32], -1);
    PlayerTextDrawSetShadow(playerid, BankMyAccountPageTDs[playerid][32], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyAccountPageTDs[playerid][32], 255);
    PlayerTextDrawFont(playerid, BankMyAccountPageTDs[playerid][32], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankMyAccountPageTDs[playerid][32], true);

    //Y+26.00 is next item
    // for(new i = 0; i < sizeof(TransfersDummyData); i++)
    // {
    //     new tmpStr[128];
    //     format(tmpStr, sizeof(tmpStr), "%f.2", TransfersDummyData[i][ammount]);
    //     BankMyAccountPageTDs[playerid][37] = CreatePlayerTextDraw(playerid, 202.333435, 146.029708 + (i*26), tmpStr);

    //     PlayerTextDrawLetterSize(playerid, BankMyAccountPageTDs[playerid][37], 0.132666, 0.616886);
    //     PlayerTextDrawAlignment(playerid, BankMyAccountPageTDs[playerid][37], TEXT_DRAW_ALIGN_LEFT);
    //     PlayerTextDrawColour(playerid, BankMyAccountPageTDs[playerid][37], (TransfersDummyData[i][ammount] > 0) ? 16711935 : -216792833 );
    //     PlayerTextDrawSetShadow(playerid, BankMyAccountPageTDs[playerid][37], false);
    //     PlayerTextDrawBackgroundColour(playerid, BankMyAccountPageTDs[playerid][37], 255);
    //     PlayerTextDrawFont(playerid, BankMyAccountPageTDs[playerid][37], TEXT_DRAW_FONT_1);
    //     PlayerTextDrawSetProportional(playerid, BankMyAccountPageTDs[playerid][37], true);
        


    //     format(tmpStr, sizeof(tmpStr), "FROM_(%s)_TO_(%s)", TransfersDummyData[i][fromAccount], TransfersDummyData[i][toAccount]);
    //     BankMyAccountPageTDs[playerid][33] = CreatePlayerTextDraw(playerid, 347.000091, 141.466751 + (i*26), tmpStr);

    //     PlayerTextDrawLetterSize(playerid, BankMyAccountPageTDs[playerid][33], 0.113333, 0.475849);
    //     PlayerTextDrawAlignment(playerid, BankMyAccountPageTDs[playerid][33], TEXT_DRAW_ALIGN_CENTRE);
    //     PlayerTextDrawColour(playerid, BankMyAccountPageTDs[playerid][33], -1);
    //     PlayerTextDrawSetShadow(playerid, BankMyAccountPageTDs[playerid][33], false);
    //     PlayerTextDrawBackgroundColour(playerid, BankMyAccountPageTDs[playerid][33], 255);
    //     PlayerTextDrawFont(playerid, BankMyAccountPageTDs[playerid][33], TEXT_DRAW_FONT_1);
    //     PlayerTextDrawSetProportional(playerid, BankMyAccountPageTDs[playerid][33], true);

    //     BankMyAccountPageTDs[playerid][36] = CreatePlayerTextDraw(playerid, 346.999938, 150.177856 + (i*26), TransfersDummyData[i][transferDescription]);
    //     PlayerTextDrawLetterSize(playerid, BankMyAccountPageTDs[playerid][36], 0.113333, 0.475849);
    //     PlayerTextDrawAlignment(playerid, BankMyAccountPageTDs[playerid][36], TEXT_DRAW_ALIGN_CENTRE);
    //     PlayerTextDrawColour(playerid, BankMyAccountPageTDs[playerid][36], -1);
    //     PlayerTextDrawSetShadow(playerid, BankMyAccountPageTDs[playerid][36], false);
    //     PlayerTextDrawBackgroundColour(playerid, BankMyAccountPageTDs[playerid][36], 255);
    //     PlayerTextDrawFont(playerid, BankMyAccountPageTDs[playerid][36], TEXT_DRAW_FONT_1);
    //     PlayerTextDrawSetProportional(playerid, BankMyAccountPageTDs[playerid][36], true);

    //     BankMyAccountPageTDs[playerid][34] = CreatePlayerTextDraw(playerid, 518.333312, 146.029708 + (i*26), TransfersDummyData[i][transferDate]);
    //     PlayerTextDrawLetterSize(playerid, BankMyAccountPageTDs[playerid][34], 0.132666, 0.616886);
    //     PlayerTextDrawAlignment(playerid, BankMyAccountPageTDs[playerid][34], TEXT_DRAW_ALIGN_RIGHT);
    //     PlayerTextDrawColour(playerid, BankMyAccountPageTDs[playerid][34], -1);
    //     PlayerTextDrawSetShadow(playerid, BankMyAccountPageTDs[playerid][34], false);
    //     PlayerTextDrawBackgroundColour(playerid, BankMyAccountPageTDs[playerid][34], 255);
    //     PlayerTextDrawFont(playerid, BankMyAccountPageTDs[playerid][34], TEXT_DRAW_FONT_1);
    //     PlayerTextDrawSetProportional(playerid, BankMyAccountPageTDs[playerid][34], true);

    //     PlayerTextDrawShow(playerid, BankMyAccountPageTDs[playerid][33]);
    //     PlayerTextDrawShow(playerid, BankMyAccountPageTDs[playerid][36]);
    //     PlayerTextDrawShow(playerid, BankMyAccountPageTDs[playerid][34]);
    //     PlayerTextDrawShow(playerid, BankMyAccountPageTDs[playerid][37]);

    //     BankMyAccountPageTDs[playerid][33] = INVALID_PLAYER_TEXT_DRAW;
    //     BankMyAccountPageTDs[playerid][36] = INVALID_PLAYER_TEXT_DRAW;
    //     BankMyAccountPageTDs[playerid][34] = INVALID_PLAYER_TEXT_DRAW;
    //     BankMyAccountPageTDs[playerid][37] = INVALID_PLAYER_TEXT_DRAW;
    // }

    BankMyAccountPageTDs[playerid][41] = CreatePlayerTextDraw(playerid, 333.666809, 294.377777, "ld_beat:left");
    PlayerTextDrawTextSize(playerid, BankMyAccountPageTDs[playerid][41], 7.000000, 9.000000);
    PlayerTextDrawAlignment(playerid, BankMyAccountPageTDs[playerid][41], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyAccountPageTDs[playerid][41], -141);
    PlayerTextDrawSetShadow(playerid, BankMyAccountPageTDs[playerid][41], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyAccountPageTDs[playerid][41], 255);
    PlayerTextDrawFont(playerid, BankMyAccountPageTDs[playerid][41], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankMyAccountPageTDs[playerid][41], false);
    PlayerTextDrawSetSelectable(playerid, BankMyAccountPageTDs[playerid][41], true);

    BankMyAccountPageTDs[playerid][42] = CreatePlayerTextDraw(playerid, 372.333709, 294.377777, "ld_beat:right");
    PlayerTextDrawTextSize(playerid, BankMyAccountPageTDs[playerid][42], 7.000000, 9.000000);
    PlayerTextDrawAlignment(playerid, BankMyAccountPageTDs[playerid][42], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyAccountPageTDs[playerid][42], -141);
    PlayerTextDrawSetShadow(playerid, BankMyAccountPageTDs[playerid][42], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyAccountPageTDs[playerid][42], 255);
    PlayerTextDrawFont(playerid, BankMyAccountPageTDs[playerid][42], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankMyAccountPageTDs[playerid][42], false);
    PlayerTextDrawSetSelectable(playerid, BankMyAccountPageTDs[playerid][42], true);

    for(new i = 0; i < sizeof(BankMyAccountPageTDs[]); i++)
    {
        if(BankMyAccountPageTDs[playerid][i] == INVALID_PLAYER_TEXT_DRAW) continue;

        PlayerTextDrawShow(playerid, BankMyAccountPageTDs[playerid][i]);
    }

    return 1;
}

stock HideBankMyAccountPage(playerid)
{
    for(new i = 0; i < sizeof(BankMyAccountPageTDs[]); i++)
    {
        if(BankMyAccountPageTDs[playerid][i] == INVALID_PLAYER_TEXT_DRAW) continue;
        PlayerTextDrawDestroy(playerid, BankMyAccountPageTDs[playerid][i]);
        BankMyAccountPageTDs[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
    }
    return 1;
}