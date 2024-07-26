#include <ysilib\YSI_Coding\y_hooks>

enum CardType {
    CARD_TYPE_MASTER_CARD,
    CARD_TYPE_VISA,
    CARD_TYPE_TELDA
}

/*
    @TODO: Credit card pages offsets and other data

*/

stock ShowBankMyCardsPage(playerid)
{
    HideBankMyCardsPageCards(playerid);


    BankMyCardsPageTDs[playerid][1] = CreatePlayerTextDraw(playerid, 477.999969, 96.666656, "Credit_Cards");
    PlayerTextDrawLetterSize(playerid, BankMyCardsPageTDs[playerid][1], 0.133999, 0.720592);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageTDs[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyCardsPageTDs[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageTDs[playerid][1], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageTDs[playerid][1], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageTDs[playerid][1], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageTDs[playerid][1], true);

    BankMyCardsPageTDs[playerid][2] = CreatePlayerTextDraw(playerid, 468.666534, 106.466667, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankMyCardsPageTDs[playerid][2], 45.000000, 0.400000);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageTDs[playerid][2], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyCardsPageTDs[playerid][2], -106);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageTDs[playerid][2], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageTDs[playerid][2], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageTDs[playerid][2], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageTDs[playerid][2], false);

    BankMyCardsPageTDs[playerid][3] = CreatePlayerTextDraw(playerid, 469.866638, 100.385169, "/");
    PlayerTextDrawLetterSize(playerid, BankMyCardsPageTDs[playerid][3], -0.362998, 0.807703);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageTDs[playerid][3], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyCardsPageTDs[playerid][3], -156);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageTDs[playerid][3], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageTDs[playerid][3], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageTDs[playerid][3], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageTDs[playerid][3], true);

    BankMyCardsPageTDs[playerid][4] = CreatePlayerTextDraw(playerid, 335.666748, 155.414794, "ld_beat:right");
    PlayerTextDrawTextSize(playerid, BankMyCardsPageTDs[playerid][4], 7.000000, 11.000000);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageTDs[playerid][4], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyCardsPageTDs[playerid][4], 1048963071);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageTDs[playerid][4], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageTDs[playerid][4], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageTDs[playerid][4], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageTDs[playerid][4], false);
    PlayerTextDrawSetSelectable(playerid, BankMyCardsPageTDs[playerid][4], true);

    BankMyCardsPageTDs[playerid][5] = CreatePlayerTextDraw(playerid, 335.666748, 238.792587, "ld_beat:right");
    PlayerTextDrawTextSize(playerid, BankMyCardsPageTDs[playerid][5], 7.000000, 11.000000);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageTDs[playerid][5], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyCardsPageTDs[playerid][5], -141);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageTDs[playerid][5], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageTDs[playerid][5], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageTDs[playerid][5], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageTDs[playerid][5], false);
    PlayerTextDrawSetSelectable(playerid, BankMyCardsPageTDs[playerid][5], true);

    BankMyCardsPageTDs[playerid][6] = CreatePlayerTextDraw(playerid, 335.666748, 322.170349, "ld_beat:right");
    PlayerTextDrawTextSize(playerid, BankMyCardsPageTDs[playerid][6], 7.000000, 11.000000);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageTDs[playerid][6], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyCardsPageTDs[playerid][6], -141);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageTDs[playerid][6], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageTDs[playerid][6], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageTDs[playerid][6], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageTDs[playerid][6], false);
    PlayerTextDrawSetSelectable(playerid, BankMyCardsPageTDs[playerid][6], true);

    BankMyCardsPageTDs[playerid][7] = CreatePlayerTextDraw(playerid, 332.966674, 114.348121, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankMyCardsPageTDs[playerid][7], 5.000000, 267.000000);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageTDs[playerid][7], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyCardsPageTDs[playerid][7], 539506175);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageTDs[playerid][7], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageTDs[playerid][7], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageTDs[playerid][7], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageTDs[playerid][7], false);

    BankMyCardsPageTDs[playerid][8] = CreatePlayerTextDraw(playerid, 433.333251, 179.214874, "INFORMACIJE");
    PlayerTextDrawLetterSize(playerid, BankMyCardsPageTDs[playerid][8], 0.195666, 0.728887);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageTDs[playerid][8], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankMyCardsPageTDs[playerid][8], -1);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageTDs[playerid][8], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageTDs[playerid][8], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageTDs[playerid][8], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageTDs[playerid][8], true);

    BankMyCardsPageTDs[playerid][9] = CreatePlayerTextDraw(playerid, 432.999908, 192.074142, "BROJ_RACUNA:_(3389_2311_4431_1233)");
    PlayerTextDrawLetterSize(playerid, BankMyCardsPageTDs[playerid][9], 0.113664, 0.521480);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageTDs[playerid][9], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankMyCardsPageTDs[playerid][9], -1);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageTDs[playerid][9], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageTDs[playerid][9], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageTDs[playerid][9], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageTDs[playerid][9], true);

    BankMyCardsPageTDs[playerid][10] = CreatePlayerTextDraw(playerid, 432.999908, 199.955627, "STANJE:_(874817418_dollars)");
    PlayerTextDrawLetterSize(playerid, BankMyCardsPageTDs[playerid][10], 0.113664, 0.521480);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageTDs[playerid][10], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankMyCardsPageTDs[playerid][10], -1);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageTDs[playerid][10], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageTDs[playerid][10], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageTDs[playerid][10], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageTDs[playerid][10], true);

    BankMyCardsPageTDs[playerid][11] = CreatePlayerTextDraw(playerid, 432.999908, 207.422332, "EXPIRE_DATE:_VALID");
    PlayerTextDrawLetterSize(playerid, BankMyCardsPageTDs[playerid][11], 0.113664, 0.521480);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageTDs[playerid][11], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankMyCardsPageTDs[playerid][11], -1);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageTDs[playerid][11], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageTDs[playerid][11], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageTDs[playerid][11], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageTDs[playerid][11], true);

    BankMyCardsPageTDs[playerid][12] = CreatePlayerTextDraw(playerid, 282.999938, 215.148162, "");
    PlayerTextDrawTextSize(playerid, BankMyCardsPageTDs[playerid][12], 141.000000, 32.000000);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageTDs[playerid][12], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyCardsPageTDs[playerid][12], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageTDs[playerid][12], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageTDs[playerid][12], -256);
    PlayerTextDrawFont(playerid, BankMyCardsPageTDs[playerid][12], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageTDs[playerid][12], false);
    PlayerTextDrawSetPreviewModel(playerid, BankMyCardsPageTDs[playerid][12], 1317);
    PlayerTextDrawSetPreviewRot(playerid, BankMyCardsPageTDs[playerid][12], 0.000000, 270.000000, 0.000000, 1.000000);

    BankMyCardsPageTDs[playerid][13] = CreatePlayerTextDraw(playerid, 449.000152, 215.148162, "");
    PlayerTextDrawTextSize(playerid, BankMyCardsPageTDs[playerid][13], 141.000000, 32.000000);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageTDs[playerid][13], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyCardsPageTDs[playerid][13], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageTDs[playerid][13], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageTDs[playerid][13], -256);
    PlayerTextDrawFont(playerid, BankMyCardsPageTDs[playerid][13], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageTDs[playerid][13], false);
    PlayerTextDrawSetPreviewModel(playerid, BankMyCardsPageTDs[playerid][13], 1317);
    PlayerTextDrawSetPreviewRot(playerid, BankMyCardsPageTDs[playerid][13], 0.000000, 90.000000, 0.000000, 1.000000);

    BankMyCardsPageTDs[playerid][14] = CreatePlayerTextDraw(playerid, 386.666595, 236.044525, "EXTEND_DATE");
    PlayerTextDrawTextSize(playerid, BankMyCardsPageTDs[playerid][14], 8.000000, 48.000000);
    PlayerTextDrawLetterSize(playerid, BankMyCardsPageTDs[playerid][14], 0.195666, 0.728887);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageTDs[playerid][14], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankMyCardsPageTDs[playerid][14], -141);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageTDs[playerid][14], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageTDs[playerid][14], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageTDs[playerid][14], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageTDs[playerid][14], true);
    PlayerTextDrawSetSelectable(playerid, BankMyCardsPageTDs[playerid][14], true);

    BankMyCardsPageTDs[playerid][15] = CreatePlayerTextDraw(playerid, 487.000000, 236.044525, "DELETE_CARD");
    PlayerTextDrawTextSize(playerid, BankMyCardsPageTDs[playerid][15], 8.000000, 48.000000);
    PlayerTextDrawLetterSize(playerid, BankMyCardsPageTDs[playerid][15], 0.195666, 0.728887);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageTDs[playerid][15], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankMyCardsPageTDs[playerid][15], -141);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageTDs[playerid][15], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageTDs[playerid][15], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageTDs[playerid][15], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageTDs[playerid][15], true);
    PlayerTextDrawSetSelectable(playerid, BankMyCardsPageTDs[playerid][15], true);

    BankMyCardsPageTDs[playerid][16] = CreatePlayerTextDraw(playerid, 436.666595, 288.725982, "GET_CARD");
    PlayerTextDrawTextSize(playerid, BankMyCardsPageTDs[playerid][16], 8.000000, 48.000000);
    PlayerTextDrawLetterSize(playerid, BankMyCardsPageTDs[playerid][16], 0.195666, 0.728887);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageTDs[playerid][16], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankMyCardsPageTDs[playerid][16], -141);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageTDs[playerid][16], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageTDs[playerid][16], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageTDs[playerid][16], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageTDs[playerid][16], true);
    PlayerTextDrawSetSelectable(playerid, BankMyCardsPageTDs[playerid][16], true);

    BankMyCardsPageTDs[playerid][17] = CreatePlayerTextDraw(playerid, 413.800079, 298.399871, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankMyCardsPageTDs[playerid][17], 43.000000, -0.800000);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageTDs[playerid][17], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyCardsPageTDs[playerid][17], -156);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageTDs[playerid][17], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageTDs[playerid][17], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageTDs[playerid][17], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageTDs[playerid][17], false);

    BankMyCardsPageTDs[playerid][18] = CreatePlayerTextDraw(playerid, 413.800079, 286.785034, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankMyCardsPageTDs[playerid][18], 43.000000, -0.800000);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageTDs[playerid][18], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyCardsPageTDs[playerid][18], -156);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageTDs[playerid][18], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageTDs[playerid][18], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageTDs[playerid][18], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageTDs[playerid][18], false);

    BankMyCardsPageTDs[playerid][19] = CreatePlayerTextDraw(playerid, 410.133239, 284.162963, "/");
    PlayerTextDrawLetterSize(playerid, BankMyCardsPageTDs[playerid][19], 0.284000, 0.969479);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageTDs[playerid][19], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyCardsPageTDs[playerid][19], -156);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageTDs[playerid][19], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageTDs[playerid][19], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageTDs[playerid][19], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageTDs[playerid][19], true);

    BankMyCardsPageTDs[playerid][20] = CreatePlayerTextDraw(playerid, 455.899963, 290.285156, "/");
    PlayerTextDrawLetterSize(playerid, BankMyCardsPageTDs[playerid][20], 0.284000, 0.969479);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageTDs[playerid][20], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyCardsPageTDs[playerid][20], -156);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageTDs[playerid][20], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageTDs[playerid][20], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageTDs[playerid][20], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid,BankMyCardsPageTDs[playerid][20], true);



    for(new i = 0; i < sizeof(BankMyCardsPageTDs[]); i++)
    {
        PlayerTextDrawShow(playerid, BankMyCardsPageTDs[playerid][i]);
    }

    ShowBankMyCardsPageCard(playerid, 0, 0.0, 0.0, CARD_TYPE_TELDA, "Frosty_Saints", "8050_5283_2030_3012", "05_/_28");
    ShowBankMyCardsPageCard(playerid, 1, 0.0, 81.0, CARD_TYPE_MASTER_CARD, "Joy_Silence", "8050_5283_2030_3012", "05_/_28");
    ShowBankMyCardsPageCard(playerid, 2, 0.0, 162.0, CARD_TYPE_VISA, "Nakito_Miyashi", "8050_5283_2030_3012", "05_/_28");
    return 1;
}

stock ShowBankMyCardsPageCard(playerid, slotIndex, Float:posX, Float:posY, CardType:cardType=CARD_TYPE_MASTER_CARD, const cardHolder[], const cardNumber[], const cardValidThru[])
{
    HideBankMyCardsPageCard(playerid, slotIndex);

    new Float:baseX = posX,
        Float:baseY = posY;

    BankMyCardsPageCard[playerid][slotIndex][0] = CreatePlayerTextDraw(playerid, baseX + 207.333389, baseY + 124.718467, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankMyCardsPageCard[playerid][slotIndex][0], 119.000000, 77.000000);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageCard[playerid][slotIndex][0], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyCardsPageCard[playerid][slotIndex][0], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageCard[playerid][slotIndex][0], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageCard[playerid][slotIndex][0], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageCard[playerid][slotIndex][0], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageCard[playerid][slotIndex][0], false);

    BankMyCardsPageCard[playerid][slotIndex][1] = CreatePlayerTextDraw(playerid, baseX + 200.400024, baseY + 122.285247, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, BankMyCardsPageCard[playerid][slotIndex][1], 14.000000, 14.000000);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageCard[playerid][slotIndex][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyCardsPageCard[playerid][slotIndex][1], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageCard[playerid][slotIndex][1], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageCard[playerid][slotIndex][1], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageCard[playerid][slotIndex][1], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageCard[playerid][slotIndex][1], false);

    BankMyCardsPageCard[playerid][slotIndex][2] = CreatePlayerTextDraw(playerid, baseX + 200.400024, baseY + 190.314895, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, BankMyCardsPageCard[playerid][slotIndex][2], 14.000000, 14.000000);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageCard[playerid][slotIndex][2], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyCardsPageCard[playerid][slotIndex][2], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageCard[playerid][slotIndex][2], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageCard[playerid][slotIndex][2], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageCard[playerid][slotIndex][2], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageCard[playerid][slotIndex][2], false);

    BankMyCardsPageCard[playerid][slotIndex][3] = CreatePlayerTextDraw(playerid, baseX + 319.733428, baseY + 122.285247, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, BankMyCardsPageCard[playerid][slotIndex][3], 14.000000, 14.000000);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageCard[playerid][slotIndex][3], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyCardsPageCard[playerid][slotIndex][3], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageCard[playerid][slotIndex][3], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageCard[playerid][slotIndex][3], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageCard[playerid][slotIndex][3], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageCard[playerid][slotIndex][3], false);

    BankMyCardsPageCard[playerid][slotIndex][4] = CreatePlayerTextDraw(playerid, baseX + 319.733428, baseY + 190.314849, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, BankMyCardsPageCard[playerid][slotIndex][4], 14.000000, 14.000000);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageCard[playerid][slotIndex][4], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyCardsPageCard[playerid][slotIndex][4], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageCard[playerid][slotIndex][4], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageCard[playerid][slotIndex][4], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageCard[playerid][slotIndex][4], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageCard[playerid][slotIndex][4], false);

    BankMyCardsPageCard[playerid][slotIndex][5] = CreatePlayerTextDraw(playerid, baseX + 202.666717, baseY + 129.696228, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankMyCardsPageCard[playerid][slotIndex][5], 128.710159, 67.360076);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageCard[playerid][slotIndex][5], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyCardsPageCard[playerid][slotIndex][5], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageCard[playerid][slotIndex][5], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageCard[playerid][slotIndex][5], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageCard[playerid][slotIndex][5], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageCard[playerid][slotIndex][5], false);


    new cardBGstring[24];
    switch(cardType) {
        case CARD_TYPE_MASTER_CARD: cardBGstring = "loadsc13:loadsc13";
        case CARD_TYPE_VISA: cardBGstring = "splash2:splash2";
        case CARD_TYPE_TELDA: cardBGstring = "splash1:splash1";
    }

    BankMyCardsPageCard[playerid][slotIndex][6] = CreatePlayerTextDraw(playerid, baseX + 205.333312, baseY + 126.377723, cardBGstring);
    PlayerTextDrawTextSize(playerid, BankMyCardsPageCard[playerid][slotIndex][6], 123.000000, 73.000000);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageCard[playerid][slotIndex][6], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyCardsPageCard[playerid][slotIndex][6], -216);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageCard[playerid][slotIndex][6], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageCard[playerid][slotIndex][6], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageCard[playerid][slotIndex][6], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageCard[playerid][slotIndex][6], false);


    //------------------------------------------------------------------------------------------------------------------------------------------------------
    //------------------------------------------------------------------------------------------------------------------------------------------------------

    switch(cardType) {
        case CARD_TYPE_MASTER_CARD: {
            BankMyCardsPageCard[playerid][slotIndex][7] = CreatePlayerTextDraw(playerid, baseX + 212.733474, baseY + 128.092559, "ld_beat:chit");
            PlayerTextDrawTextSize(playerid, BankMyCardsPageCard[playerid][slotIndex][7], 14.000000, 14.000000);
            PlayerTextDrawAlignment(playerid, BankMyCardsPageCard[playerid][slotIndex][7], TEXT_DRAW_ALIGN_LEFT);
            PlayerTextDrawColour(playerid, BankMyCardsPageCard[playerid][slotIndex][7], -21351937);
            PlayerTextDrawSetShadow(playerid, BankMyCardsPageCard[playerid][slotIndex][7], false);
            PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageCard[playerid][slotIndex][7], 255);
            PlayerTextDrawFont(playerid, BankMyCardsPageCard[playerid][slotIndex][7], TEXT_DRAW_FONT_SPRITE_DRAW);
            PlayerTextDrawSetProportional(playerid, BankMyCardsPageCard[playerid][slotIndex][7], false);

            BankMyCardsPageCard[playerid][slotIndex][8] = CreatePlayerTextDraw(playerid, baseX + 206.066787, baseY + 128.092559, "ld_beat:chit");
            PlayerTextDrawTextSize(playerid, BankMyCardsPageCard[playerid][slotIndex][8], 14.000000, 14.000000);
            PlayerTextDrawAlignment(playerid, BankMyCardsPageCard[playerid][slotIndex][8], TEXT_DRAW_ALIGN_LEFT);
            PlayerTextDrawColour(playerid, BankMyCardsPageCard[playerid][slotIndex][8], -27961857);
            PlayerTextDrawSetShadow(playerid, BankMyCardsPageCard[playerid][slotIndex][8], false);
            PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageCard[playerid][slotIndex][8], 255);
            PlayerTextDrawFont(playerid, BankMyCardsPageCard[playerid][slotIndex][8], TEXT_DRAW_FONT_SPRITE_DRAW);
            PlayerTextDrawSetProportional(playerid, BankMyCardsPageCard[playerid][slotIndex][8], false);

            BankMyCardsPageCard[playerid][slotIndex][9] = CreatePlayerTextDraw(playerid, baseX + 226.666687, baseY + 132.340759, "Master_Card");
            PlayerTextDrawLetterSize(playerid, BankMyCardsPageCard[playerid][slotIndex][9], 0.117333, 0.583702);
            PlayerTextDrawAlignment(playerid, BankMyCardsPageCard[playerid][slotIndex][9], TEXT_DRAW_ALIGN_LEFT);
            PlayerTextDrawColour(playerid, BankMyCardsPageCard[playerid][slotIndex][9], -1);
            PlayerTextDrawSetShadow(playerid, BankMyCardsPageCard[playerid][slotIndex][9], false);
            PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageCard[playerid][slotIndex][9], 255);
            PlayerTextDrawFont(playerid, BankMyCardsPageCard[playerid][slotIndex][9], TEXT_DRAW_FONT_1);
            PlayerTextDrawSetProportional(playerid, BankMyCardsPageCard[playerid][slotIndex][9], true);            
        }
        case CARD_TYPE_VISA: {
            BankMyCardsPageCard[playerid][slotIndex][7] = CreatePlayerTextDraw(playerid, baseX + 209.000000, baseY + 130.681655, "VISA");
            PlayerTextDrawLetterSize(playerid, BankMyCardsPageCard[playerid][slotIndex][7], 0.188666, 0.874073);
            PlayerTextDrawAlignment(playerid, BankMyCardsPageCard[playerid][slotIndex][7], TEXT_DRAW_ALIGN_LEFT);
            PlayerTextDrawColour(playerid, BankMyCardsPageCard[playerid][slotIndex][7], -1);
            PlayerTextDrawSetShadow(playerid, BankMyCardsPageCard[playerid][slotIndex][7], false);
            PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageCard[playerid][slotIndex][7], 255);
            PlayerTextDrawFont(playerid, BankMyCardsPageCard[playerid][slotIndex][7], TEXT_DRAW_FONT_1);
            PlayerTextDrawSetProportional(playerid, BankMyCardsPageCard[playerid][slotIndex][7], true);

            BankMyCardsPageCard[playerid][slotIndex][8] = CreatePlayerTextDraw(playerid, baseX + 208.100051, baseY + 130.655471, "LD_SPAC:white");
            PlayerTextDrawTextSize(playerid, BankMyCardsPageCard[playerid][slotIndex][8], 16.000000, 0.600000);
            PlayerTextDrawAlignment(playerid, BankMyCardsPageCard[playerid][slotIndex][8], TEXT_DRAW_ALIGN_LEFT);
            PlayerTextDrawColour(playerid, BankMyCardsPageCard[playerid][slotIndex][8], 1620246527);
            PlayerTextDrawSetShadow(playerid, BankMyCardsPageCard[playerid][slotIndex][8], false);
            PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageCard[playerid][slotIndex][8], 255);
            PlayerTextDrawFont(playerid, BankMyCardsPageCard[playerid][slotIndex][8], TEXT_DRAW_FONT_SPRITE_DRAW);
            PlayerTextDrawSetProportional(playerid, BankMyCardsPageCard[playerid][slotIndex][8], false);

            BankMyCardsPageCard[playerid][slotIndex][9] = CreatePlayerTextDraw(playerid, baseX + 208.100051, baseY + 138.937042, "LD_SPAC:white");
            PlayerTextDrawTextSize(playerid, BankMyCardsPageCard[playerid][slotIndex][9], 16.000000, 0.600000);
            PlayerTextDrawAlignment(playerid, BankMyCardsPageCard[playerid][slotIndex][9], TEXT_DRAW_ALIGN_LEFT);
            PlayerTextDrawColour(playerid, BankMyCardsPageCard[playerid][slotIndex][9], -102940417);
            PlayerTextDrawSetShadow(playerid, BankMyCardsPageCard[playerid][slotIndex][9], false);
            PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageCard[playerid][slotIndex][9], 255);
            PlayerTextDrawFont(playerid, BankMyCardsPageCard[playerid][slotIndex][9], TEXT_DRAW_FONT_SPRITE_DRAW);
            PlayerTextDrawSetProportional(playerid, BankMyCardsPageCard[playerid][slotIndex][9], false);
        }
        case CARD_TYPE_TELDA: {
            BankMyCardsPageCard[playerid][slotIndex][7] = CreatePlayerTextDraw(playerid, baseX + 314.733428, baseY + 185.055572, "ld_beat:chit");
            PlayerTextDrawTextSize(playerid, BankMyCardsPageCard[playerid][slotIndex][7], 14.000000, 14.000000);
            PlayerTextDrawAlignment(playerid, BankMyCardsPageCard[playerid][slotIndex][7], TEXT_DRAW_ALIGN_LEFT);
            PlayerTextDrawColour(playerid, BankMyCardsPageCard[playerid][slotIndex][7], -21351937);
            PlayerTextDrawSetShadow(playerid, BankMyCardsPageCard[playerid][slotIndex][7], false);
            PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageCard[playerid][slotIndex][7], 255);
            PlayerTextDrawFont(playerid, BankMyCardsPageCard[playerid][slotIndex][7], TEXT_DRAW_FONT_SPRITE_DRAW);
            PlayerTextDrawSetProportional(playerid, BankMyCardsPageCard[playerid][slotIndex][7], false);

            BankMyCardsPageCard[playerid][slotIndex][8] = CreatePlayerTextDraw(playerid, baseX + 308.733245, baseY + 185.170349, "ld_beat:chit");
            PlayerTextDrawTextSize(playerid, BankMyCardsPageCard[playerid][slotIndex][8], 14.000000, 14.000000);
            PlayerTextDrawAlignment(playerid, BankMyCardsPageCard[playerid][slotIndex][8], TEXT_DRAW_ALIGN_LEFT);
            PlayerTextDrawColour(playerid, BankMyCardsPageCard[playerid][slotIndex][8], -27961857);
            PlayerTextDrawSetShadow(playerid, BankMyCardsPageCard[playerid][slotIndex][8], false);
            PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageCard[playerid][slotIndex][8], 255);
            PlayerTextDrawFont(playerid, BankMyCardsPageCard[playerid][slotIndex][8], TEXT_DRAW_FONT_SPRITE_DRAW);
            PlayerTextDrawSetProportional(playerid, BankMyCardsPageCard[playerid][slotIndex][8], false);

            BankMyCardsPageCard[playerid][slotIndex][9] = CreatePlayerTextDraw(playerid, baseX + 209.000000, baseY + 130.266677, "telda");
            PlayerTextDrawLetterSize(playerid, BankMyCardsPageCard[playerid][slotIndex][9], 0.188666, 0.874073);
            PlayerTextDrawAlignment(playerid, BankMyCardsPageCard[playerid][slotIndex][9], TEXT_DRAW_ALIGN_LEFT);
            PlayerTextDrawColour(playerid, BankMyCardsPageCard[playerid][slotIndex][9], -1);
            PlayerTextDrawSetShadow(playerid, BankMyCardsPageCard[playerid][slotIndex][9], false);
            PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageCard[playerid][slotIndex][9], 255);
            PlayerTextDrawFont(playerid, BankMyCardsPageCard[playerid][slotIndex][9], TEXT_DRAW_FONT_1);
            PlayerTextDrawSetProportional(playerid, BankMyCardsPageCard[playerid][slotIndex][9], true);
        }
    }

    BankMyCardsPageCard[playerid][slotIndex][10] = CreatePlayerTextDraw(playerid, baseX + 208.000030, baseY + 160.962997, "Card_Number");
    PlayerTextDrawLetterSize(playerid, BankMyCardsPageCard[playerid][slotIndex][10], 0.117333, 0.583702);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageCard[playerid][slotIndex][10], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyCardsPageCard[playerid][slotIndex][10], -156);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageCard[playerid][slotIndex][10], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageCard[playerid][slotIndex][10], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageCard[playerid][slotIndex][10], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageCard[playerid][slotIndex][10], true);

    BankMyCardsPageCard[playerid][slotIndex][11] = CreatePlayerTextDraw(playerid, baseX + 208.000030, baseY + 168.014846, cardNumber);
    PlayerTextDrawLetterSize(playerid, BankMyCardsPageCard[playerid][slotIndex][11], 0.117333, 0.583702);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageCard[playerid][slotIndex][11], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyCardsPageCard[playerid][slotIndex][11], -1);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageCard[playerid][slotIndex][11], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageCard[playerid][slotIndex][11], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageCard[playerid][slotIndex][11], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageCard[playerid][slotIndex][11], true);

    BankMyCardsPageCard[playerid][slotIndex][12] = CreatePlayerTextDraw(playerid, baseX + 208.000030, baseY + 183.777801, "Card_Holder");
    PlayerTextDrawLetterSize(playerid, BankMyCardsPageCard[playerid][slotIndex][12], 0.117333, 0.583702);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageCard[playerid][slotIndex][12], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyCardsPageCard[playerid][slotIndex][12], -156);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageCard[playerid][slotIndex][12], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageCard[playerid][slotIndex][12], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageCard[playerid][slotIndex][12], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageCard[playerid][slotIndex][12], true);

    BankMyCardsPageCard[playerid][slotIndex][13] = CreatePlayerTextDraw(playerid, baseX + 208.000030, baseY + 189.585235, cardHolder);
    PlayerTextDrawLetterSize(playerid, BankMyCardsPageCard[playerid][slotIndex][13], 0.117333, 0.583702);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageCard[playerid][slotIndex][13], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyCardsPageCard[playerid][slotIndex][13], -1);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageCard[playerid][slotIndex][13], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageCard[playerid][slotIndex][13], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageCard[playerid][slotIndex][13], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageCard[playerid][slotIndex][13], true);


    if(cardType == CARD_TYPE_TELDA)
        BankMyCardsPageCard[playerid][slotIndex][14] = CreatePlayerTextDraw(playerid, baseX + 283.000152, baseY + 183.777801, "Valid_Thru");
    else
        BankMyCardsPageCard[playerid][slotIndex][14] = CreatePlayerTextDraw(playerid, baseX + 306.333374, baseY + 183.777801, "Valid_Thru");

    PlayerTextDrawLetterSize(playerid, BankMyCardsPageCard[playerid][slotIndex][14], 0.117333, 0.583702);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageCard[playerid][slotIndex][14], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankMyCardsPageCard[playerid][slotIndex][14], -156);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageCard[playerid][slotIndex][14], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageCard[playerid][slotIndex][14], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageCard[playerid][slotIndex][14], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageCard[playerid][slotIndex][14], true);

    if(cardType == CARD_TYPE_TELDA)
        BankMyCardsPageCard[playerid][slotIndex][15] = CreatePlayerTextDraw(playerid, baseX + 292.666717, baseY + 189.585235, cardValidThru);
    else
        BankMyCardsPageCard[playerid][slotIndex][15] = CreatePlayerTextDraw(playerid, baseX + 315.999938, baseY + 189.585235, cardValidThru);
    
    PlayerTextDrawLetterSize(playerid, BankMyCardsPageCard[playerid][slotIndex][15], 0.117333, 0.583702);
    PlayerTextDrawAlignment(playerid, BankMyCardsPageCard[playerid][slotIndex][15], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankMyCardsPageCard[playerid][slotIndex][15], -1);
    PlayerTextDrawSetShadow(playerid, BankMyCardsPageCard[playerid][slotIndex][15], false);
    PlayerTextDrawBackgroundColour(playerid, BankMyCardsPageCard[playerid][slotIndex][15], 255);
    PlayerTextDrawFont(playerid, BankMyCardsPageCard[playerid][slotIndex][15], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankMyCardsPageCard[playerid][slotIndex][15], true);


    for(new i = 0; i < sizeof(BankMyCardsPageCard[][]); i++)
    {
        if(BankMyCardsPageCard[playerid][slotIndex][i] == INVALID_PLAYER_TEXT_DRAW) continue;
        PlayerTextDrawShow(playerid, BankMyCardsPageCard[playerid][slotIndex][i]);
    }
    return 1;
}

stock BankHideMyCardsPage(playerid)
{
    for(new i = 0; i < sizeof(BankMyCardsPageTDs[]); i++)
    {
        if(BankMyCardsPageTDs[playerid][i] == INVALID_PLAYER_TEXT_DRAW) continue;

        PlayerTextDrawDestroy(playerid, BankMyCardsPageTDs[playerid][i]);
        BankMyCardsPageTDs[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
    }

    HideBankMyCardsPageCards(playerid);
    return 1;
}

stock HideBankMyCardsPageCards(playerid)
{
    for(new i = 0; i < sizeof(BankMyCardsPageCard[]); i++)
    {
        HideBankMyCardsPageCard(playerid, i);
    }
    return 1;
}

stock HideBankMyCardsPageCard(playerid, indexSlot)
{
    if(indexSlot < 0 || indexSlot >= sizeof(BankMyCardsPageCard[])) return 0;

    for(new i = 0; i < sizeof(BankMyCardsPageCard[][]); i++)
    {
        if(BankMyCardsPageCard[playerid][indexSlot][i] == INVALID_PLAYER_TEXT_DRAW) continue;

        PlayerTextDrawDestroy(playerid, BankMyCardsPageCard[playerid][indexSlot][i]);
        BankMyCardsPageCard[playerid][indexSlot][i] = INVALID_PLAYER_TEXT_DRAW;
    }
    return 1;
}