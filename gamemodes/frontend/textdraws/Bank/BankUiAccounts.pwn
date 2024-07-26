#include <ysilib\YSI_Coding\y_hooks>


new static PlayerText:BankAccountsPageTDs[MAX_PLAYERS][24];
new static PlayerText:BankAccountsPageListTDs[MAX_PLAYERS][10];

enum Currency {
    Dollar,
    Euro,
    Pound
}
new stock CurrencyString[Currency][8] = {
    "Dollar",
    "Euro",
    "Pound"
};


enum eBankAccountsList {
    IBAN[24],
    OwnerName[MAX_PLAYER_NAME],
    Float:Currencies[Currency],
}

//All kind of buttons
stock bool:IsBankAccountCreateNewButton(playerid, PlayerText:playertextid)
{
    if(playertextid == BankAccountsPageTDs[playerid][15] )
        return true;

    return false;
}

stock bool:IsBankAccountDeleteButton(playerid, PlayerText:playertextid)
{
    if(playertextid == BankAccountsPageTDs[playerid][16] )
        return true;

    return false;
}

stock bool:IsBankAccountTransferOwnershipButton(playerid, PlayerText:playertextid)
{
    if(playertextid == BankAccountsPageTDs[playerid][17] )
        return true;

    return false;
}

stock bool:IsBankAccountSwitchAccountButton(playerid, PlayerText:playertextid)
{
    if(playertextid == BankAccountsPageTDs[playerid][22] )
        return true;

    return false;
}


stock ShowBankAccountsPage(playerid)
{
    HideBankAccountsPage(playerid);

    //Page TitlePlayerTextDrawColor
    BankAccountsPageTDs[playerid][0] = CreatePlayerTextDraw(playerid, 470.333251, 96.666656, "Account_Managment");
    PlayerTextDrawLetterSize(playerid, BankAccountsPageTDs[playerid][0], 0.133999, 0.720592);
    PlayerTextDrawAlignment(playerid, BankAccountsPageTDs[playerid][0], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankAccountsPageTDs[playerid][0], -1);
    PlayerTextDrawSetShadow(playerid, BankAccountsPageTDs[playerid][0], false);
    PlayerTextDrawBackgroundColour(playerid, BankAccountsPageTDs[playerid][0], 255);
    PlayerTextDrawFont(playerid, BankAccountsPageTDs[playerid][0], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankAccountsPageTDs[playerid][0], true);

    BankAccountsPageTDs[playerid][1] = CreatePlayerTextDraw(playerid, 468.666534, 106.466667, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankAccountsPageTDs[playerid][1], 45.000000, 0.400000);
    PlayerTextDrawAlignment(playerid, BankAccountsPageTDs[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankAccountsPageTDs[playerid][1], -106);
    PlayerTextDrawSetShadow(playerid, BankAccountsPageTDs[playerid][1], false);
    PlayerTextDrawBackgroundColour(playerid, BankAccountsPageTDs[playerid][1], 255);
    PlayerTextDrawFont(playerid, BankAccountsPageTDs[playerid][1], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankAccountsPageTDs[playerid][1], false);

    BankAccountsPageTDs[playerid][2] = CreatePlayerTextDraw(playerid, 469.866638, 100.385169, "/");
    PlayerTextDrawLetterSize(playerid, BankAccountsPageTDs[playerid][2], -0.362998, 0.807703);
    PlayerTextDrawAlignment(playerid, BankAccountsPageTDs[playerid][2], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankAccountsPageTDs[playerid][2], -156);
    PlayerTextDrawSetShadow(playerid, BankAccountsPageTDs[playerid][2], false);
    PlayerTextDrawBackgroundColour(playerid, BankAccountsPageTDs[playerid][2], 255);
    PlayerTextDrawFont(playerid, BankAccountsPageTDs[playerid][2], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, BankAccountsPageTDs[playerid][2], true);



    //Pagination
    BankAccountsPageTDs[playerid][3] = CreatePlayerTextDraw(playerid, 504.000091, 369.200103, "PAGE_1_/_?");
    PlayerTextDrawLetterSize(playerid, BankAccountsPageTDs[playerid][3], 0.125330, 0.621034);
    PlayerTextDrawAlignment(playerid, BankAccountsPageTDs[playerid][3], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankAccountsPageTDs[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, BankAccountsPageTDs[playerid][3], false);
    PlayerTextDrawBackgroundColour(playerid, BankAccountsPageTDs[playerid][3], 255);
    PlayerTextDrawFont(playerid, BankAccountsPageTDs[playerid][3], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankAccountsPageTDs[playerid][3], true);

    BankAccountsPageTDs[playerid][4] = CreatePlayerTextDraw(playerid, 505.333343, 359.089080, "ld_beat:right");
    PlayerTextDrawTextSize(playerid, BankAccountsPageTDs[playerid][4], 6.000000, 9.000000);
    PlayerTextDrawAlignment(playerid, BankAccountsPageTDs[playerid][4], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankAccountsPageTDs[playerid][4], -141);
    PlayerTextDrawSetShadow(playerid, BankAccountsPageTDs[playerid][4], false);
    PlayerTextDrawBackgroundColour(playerid, BankAccountsPageTDs[playerid][4], 255);
    PlayerTextDrawFont(playerid, BankAccountsPageTDs[playerid][4], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankAccountsPageTDs[playerid][4], false);
    PlayerTextDrawSetSelectable(playerid, BankAccountsPageTDs[playerid][4], true);

    BankAccountsPageTDs[playerid][5] = CreatePlayerTextDraw(playerid, 496.666595, 359.089080, "ld_beat:left");
    PlayerTextDrawTextSize(playerid, BankAccountsPageTDs[playerid][5], 6.000000, 9.000000);
    PlayerTextDrawAlignment(playerid, BankAccountsPageTDs[playerid][5], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankAccountsPageTDs[playerid][5], -141);
    PlayerTextDrawSetShadow(playerid, BankAccountsPageTDs[playerid][5], false);
    PlayerTextDrawBackgroundColour(playerid, BankAccountsPageTDs[playerid][5], 255);
    PlayerTextDrawFont(playerid, BankAccountsPageTDs[playerid][5], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankAccountsPageTDs[playerid][5], false);
    PlayerTextDrawSetSelectable(playerid, BankAccountsPageTDs[playerid][5], true);

    BankAccountsPageTDs[playerid][6] = CreatePlayerTextDraw(playerid, 500.766387, 359.088928, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankAccountsPageTDs[playerid][6], 6.219982, 9.000000);
    PlayerTextDrawAlignment(playerid, BankAccountsPageTDs[playerid][6], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankAccountsPageTDs[playerid][6], 539506175);
    PlayerTextDrawSetShadow(playerid, BankAccountsPageTDs[playerid][6], false);
    PlayerTextDrawBackgroundColour(playerid, BankAccountsPageTDs[playerid][6], 255);
    PlayerTextDrawFont(playerid, BankAccountsPageTDs[playerid][6], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankAccountsPageTDs[playerid][6], false);


    //Table Header
    BankAccountsPageTDs[playerid][7] = CreatePlayerTextDraw(playerid, 196.333496, 121.555603, "ID__OWNER____DOLLARS_VALUE____EUROS_VALUE____POUNDS_VALUE");
    PlayerTextDrawLetterSize(playerid, BankAccountsPageTDs[playerid][7], 0.277332, 0.944589);
    PlayerTextDrawAlignment(playerid, BankAccountsPageTDs[playerid][7], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankAccountsPageTDs[playerid][7], -141);
    PlayerTextDrawSetShadow(playerid, BankAccountsPageTDs[playerid][7], false);
    PlayerTextDrawBackgroundColour(playerid, BankAccountsPageTDs[playerid][7], 255);
    PlayerTextDrawFont(playerid, BankAccountsPageTDs[playerid][7], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankAccountsPageTDs[playerid][7], true);

    BankAccountsPageTDs[playerid][8] = CreatePlayerTextDraw(playerid, 196.333908, 261.607208, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankAccountsPageTDs[playerid][8], 305.000000, 1.000000);
    PlayerTextDrawAlignment(playerid, BankAccountsPageTDs[playerid][8], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankAccountsPageTDs[playerid][8], -226);
    PlayerTextDrawSetShadow(playerid, BankAccountsPageTDs[playerid][8], false);
    PlayerTextDrawBackgroundColour(playerid, BankAccountsPageTDs[playerid][8], 255);
    PlayerTextDrawFont(playerid, BankAccountsPageTDs[playerid][8], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankAccountsPageTDs[playerid][8], false);

    /*
    for(new i = 0; i < 10; i++)
    {
        ShowPlayerBankAccountInfo(playerid, i, iBAN, OwnerName Float:Money[MONEY_TYPE]);
    }
    */

    //Footer with buttons and stuff
    BankAccountsPageTDs[playerid][9] = CreatePlayerTextDraw(playerid, 196.667221, 135.088806, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankAccountsPageTDs[playerid][9], 301.000000, 1.000000);
    PlayerTextDrawAlignment(playerid, BankAccountsPageTDs[playerid][9], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankAccountsPageTDs[playerid][9], -226);
    PlayerTextDrawSetShadow(playerid, BankAccountsPageTDs[playerid][9], false);
    PlayerTextDrawBackgroundColour(playerid, BankAccountsPageTDs[playerid][9], 255);
    PlayerTextDrawFont(playerid, BankAccountsPageTDs[playerid][9], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankAccountsPageTDs[playerid][9], false);

    BankAccountsPageTDs[playerid][10] = CreatePlayerTextDraw(playerid, 314.667358, 289.399749, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankAccountsPageTDs[playerid][10], 68.000000, 1.000000);
    PlayerTextDrawAlignment(playerid, BankAccountsPageTDs[playerid][10], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankAccountsPageTDs[playerid][10], -226);
    PlayerTextDrawSetShadow(playerid, BankAccountsPageTDs[playerid][10], false);
    PlayerTextDrawBackgroundColour(playerid, BankAccountsPageTDs[playerid][10], 255);
    PlayerTextDrawFont(playerid, BankAccountsPageTDs[playerid][10], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankAccountsPageTDs[playerid][10], false);

    BankAccountsPageTDs[playerid][11] = CreatePlayerTextDraw(playerid, 347.666748, 280.429656, "ACTIONS");
    PlayerTextDrawLetterSize(playerid, BankAccountsPageTDs[playerid][11], 0.172000, 0.637628);
    PlayerTextDrawAlignment(playerid, BankAccountsPageTDs[playerid][11], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankAccountsPageTDs[playerid][11], -1);
    PlayerTextDrawSetShadow(playerid, BankAccountsPageTDs[playerid][11], false);
    PlayerTextDrawBackgroundColour(playerid, BankAccountsPageTDs[playerid][11], 255);
    PlayerTextDrawFont(playerid, BankAccountsPageTDs[playerid][11], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankAccountsPageTDs[playerid][11], true);

    BankAccountsPageTDs[playerid][12] = CreatePlayerTextDraw(playerid, 162.999969, 310.140747, "");
    PlayerTextDrawTextSize(playerid, BankAccountsPageTDs[playerid][12], 107.000000, 24.000000);
    PlayerTextDrawAlignment(playerid, BankAccountsPageTDs[playerid][12], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankAccountsPageTDs[playerid][12], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankAccountsPageTDs[playerid][12], false);
    PlayerTextDrawBackgroundColour(playerid, BankAccountsPageTDs[playerid][12], -256);
    PlayerTextDrawFont(playerid, BankAccountsPageTDs[playerid][12], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid, BankAccountsPageTDs[playerid][12], false);
    PlayerTextDrawSetPreviewModel(playerid, BankAccountsPageTDs[playerid][12], 1317);
    PlayerTextDrawSetPreviewRot(playerid, BankAccountsPageTDs[playerid][12], 0.000000, 270.000000, 0.000000, 1.000000);

    BankAccountsPageTDs[playerid][13] = CreatePlayerTextDraw(playerid, 267.999969, 310.140747, "");
    PlayerTextDrawTextSize(playerid, BankAccountsPageTDs[playerid][13], 107.000000, 24.000000);
    PlayerTextDrawAlignment(playerid, BankAccountsPageTDs[playerid][13], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankAccountsPageTDs[playerid][13], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankAccountsPageTDs[playerid][13], false);
    PlayerTextDrawBackgroundColour(playerid, BankAccountsPageTDs[playerid][13], -256);
    PlayerTextDrawFont(playerid, BankAccountsPageTDs[playerid][13], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid, BankAccountsPageTDs[playerid][13], false);
    PlayerTextDrawSetPreviewModel(playerid, BankAccountsPageTDs[playerid][13], 1317);
    PlayerTextDrawSetPreviewRot(playerid, BankAccountsPageTDs[playerid][13], 0.000000, 270.000000, 0.000000, 1.000000);

    BankAccountsPageTDs[playerid][14] = CreatePlayerTextDraw(playerid, 388.666687, 310.140747, "");
    PlayerTextDrawTextSize(playerid, BankAccountsPageTDs[playerid][14], 107.000000, 24.000000);
    PlayerTextDrawAlignment(playerid, BankAccountsPageTDs[playerid][14], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankAccountsPageTDs[playerid][14], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankAccountsPageTDs[playerid][14], false);
    PlayerTextDrawBackgroundColour(playerid, BankAccountsPageTDs[playerid][14], -256);
    PlayerTextDrawFont(playerid, BankAccountsPageTDs[playerid][14], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid, BankAccountsPageTDs[playerid][14], false);
    PlayerTextDrawSetPreviewModel(playerid, BankAccountsPageTDs[playerid][14], 1317);
    PlayerTextDrawSetPreviewRot(playerid, BankAccountsPageTDs[playerid][14], 0.000000, 270.000000, 0.000000, 1.000000);

    BankAccountsPageTDs[playerid][15] = CreatePlayerTextDraw(playerid, 348.366760, 325.144378, "CREATE");
    PlayerTextDrawTextSize(playerid, BankAccountsPageTDs[playerid][15], 8.000000, 48.000000);
    PlayerTextDrawLetterSize(playerid, BankAccountsPageTDs[playerid][15], 0.172000, 0.637628);
    PlayerTextDrawAlignment(playerid, BankAccountsPageTDs[playerid][15], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankAccountsPageTDs[playerid][15], -141);
    PlayerTextDrawSetShadow(playerid, BankAccountsPageTDs[playerid][15], false);
    PlayerTextDrawBackgroundColour(playerid, BankAccountsPageTDs[playerid][15], 255);
    PlayerTextDrawFont(playerid, BankAccountsPageTDs[playerid][15], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankAccountsPageTDs[playerid][15], true);
    PlayerTextDrawSetSelectable(playerid, BankAccountsPageTDs[playerid][15], true);

    BankAccountsPageTDs[playerid][16] = CreatePlayerTextDraw(playerid, 242.033477, 325.144378, "DELETE");
    PlayerTextDrawTextSize(playerid, BankAccountsPageTDs[playerid][16], 8.000000, 48.000000);
    PlayerTextDrawLetterSize(playerid, BankAccountsPageTDs[playerid][16], 0.172000, 0.637628);
    PlayerTextDrawAlignment(playerid, BankAccountsPageTDs[playerid][16], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankAccountsPageTDs[playerid][16], -141);
    PlayerTextDrawSetShadow(playerid, BankAccountsPageTDs[playerid][16], false);
    PlayerTextDrawBackgroundColour(playerid, BankAccountsPageTDs[playerid][16], 255);
    PlayerTextDrawFont(playerid, BankAccountsPageTDs[playerid][16], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankAccountsPageTDs[playerid][16], true);
    PlayerTextDrawSetSelectable(playerid, BankAccountsPageTDs[playerid][16], true);

    BankAccountsPageTDs[playerid][17] = CreatePlayerTextDraw(playerid, 469.033508, 325.144378, "OWNERSHIP");
    PlayerTextDrawTextSize(playerid, BankAccountsPageTDs[playerid][17], 8.000000, 48.000000);
    PlayerTextDrawLetterSize(playerid, BankAccountsPageTDs[playerid][17], 0.172000, 0.637628);
    PlayerTextDrawAlignment(playerid, BankAccountsPageTDs[playerid][17], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankAccountsPageTDs[playerid][17], -141);
    PlayerTextDrawSetShadow(playerid, BankAccountsPageTDs[playerid][17], false);
    PlayerTextDrawBackgroundColour(playerid, BankAccountsPageTDs[playerid][17], 255);
    PlayerTextDrawFont(playerid, BankAccountsPageTDs[playerid][17], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankAccountsPageTDs[playerid][17], true);
    PlayerTextDrawSetSelectable(playerid, BankAccountsPageTDs[playerid][17], true);

    BankAccountsPageTDs[playerid][18] = CreatePlayerTextDraw(playerid, 242.700149, 311.455535, "mogucnost_brisanja_naloga");
    PlayerTextDrawLetterSize(playerid, BankAccountsPageTDs[playerid][18], 0.172000, 0.637628);
    PlayerTextDrawAlignment(playerid, BankAccountsPageTDs[playerid][18], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankAccountsPageTDs[playerid][18], -1);
    PlayerTextDrawSetShadow(playerid, BankAccountsPageTDs[playerid][18], false);
    PlayerTextDrawBackgroundColour(playerid, BankAccountsPageTDs[playerid][18], 255);
    PlayerTextDrawFont(playerid, BankAccountsPageTDs[playerid][18], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankAccountsPageTDs[playerid][18], true);

    BankAccountsPageTDs[playerid][19] = CreatePlayerTextDraw(playerid, 347.366851, 311.455535, "kreiranje_naloga");
    PlayerTextDrawLetterSize(playerid, BankAccountsPageTDs[playerid][19], 0.172000, 0.637628);
    PlayerTextDrawAlignment(playerid, BankAccountsPageTDs[playerid][19], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankAccountsPageTDs[playerid][19], -1);
    PlayerTextDrawSetShadow(playerid, BankAccountsPageTDs[playerid][19], false);
    PlayerTextDrawBackgroundColour(playerid, BankAccountsPageTDs[playerid][19], 255);
    PlayerTextDrawFont(playerid, BankAccountsPageTDs[playerid][19], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankAccountsPageTDs[playerid][19], true);

    BankAccountsPageTDs[playerid][20] = CreatePlayerTextDraw(playerid, 468.033477, 311.455535, "promena_vlasnika");
    PlayerTextDrawLetterSize(playerid, BankAccountsPageTDs[playerid][20], 0.172000, 0.637628);
    PlayerTextDrawAlignment(playerid, BankAccountsPageTDs[playerid][20], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankAccountsPageTDs[playerid][20], -1);
    PlayerTextDrawSetShadow(playerid, BankAccountsPageTDs[playerid][20], false);
    PlayerTextDrawBackgroundColour(playerid, BankAccountsPageTDs[playerid][20], 255);
    PlayerTextDrawFont(playerid, BankAccountsPageTDs[playerid][20], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankAccountsPageTDs[playerid][20], true);

    BankAccountsPageTDs[playerid][21] = CreatePlayerTextDraw(playerid, 267.999969, 347.059387, "");
    PlayerTextDrawTextSize(playerid, BankAccountsPageTDs[playerid][21], 107.000000, 24.000000);
    PlayerTextDrawAlignment(playerid, BankAccountsPageTDs[playerid][21], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankAccountsPageTDs[playerid][21], 1095325951);
    PlayerTextDrawSetShadow(playerid, BankAccountsPageTDs[playerid][21], false);
    PlayerTextDrawBackgroundColour(playerid, BankAccountsPageTDs[playerid][21], -256);
    PlayerTextDrawFont(playerid, BankAccountsPageTDs[playerid][21], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid, BankAccountsPageTDs[playerid][21], false);
    PlayerTextDrawSetPreviewModel(playerid, BankAccountsPageTDs[playerid][21], 1317);
    PlayerTextDrawSetPreviewRot(playerid, BankAccountsPageTDs[playerid][21], 0.000000, 270.000000, 0.000000, 1.000000);

    BankAccountsPageTDs[playerid][22] = CreatePlayerTextDraw(playerid, 348.366760, 362.477905, "SWITCH");
    PlayerTextDrawTextSize(playerid, BankAccountsPageTDs[playerid][22], 8.000000, 48.000000);
    PlayerTextDrawLetterSize(playerid, BankAccountsPageTDs[playerid][22], 0.172000, 0.637628);
    PlayerTextDrawAlignment(playerid, BankAccountsPageTDs[playerid][22], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankAccountsPageTDs[playerid][22], -141);
    PlayerTextDrawSetShadow(playerid, BankAccountsPageTDs[playerid][22], false);
    PlayerTextDrawBackgroundColour(playerid, BankAccountsPageTDs[playerid][22], 255);
    PlayerTextDrawFont(playerid, BankAccountsPageTDs[playerid][22], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankAccountsPageTDs[playerid][22], true);
    PlayerTextDrawSetSelectable(playerid, BankAccountsPageTDs[playerid][22], true);

    BankAccountsPageTDs[playerid][23] = CreatePlayerTextDraw(playerid, 347.366912, 348.788940, "logovanje_na_drugi_nalog");
    PlayerTextDrawLetterSize(playerid, BankAccountsPageTDs[playerid][23], 0.172000, 0.637628);
    PlayerTextDrawAlignment(playerid, BankAccountsPageTDs[playerid][23], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankAccountsPageTDs[playerid][23], -1);
    PlayerTextDrawSetShadow(playerid, BankAccountsPageTDs[playerid][23], false);
    PlayerTextDrawBackgroundColour(playerid, BankAccountsPageTDs[playerid][23], 255);
    PlayerTextDrawFont(playerid, BankAccountsPageTDs[playerid][23], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankAccountsPageTDs[playerid][23], true);

    for(new i = 0; i < sizeof(BankAccountsPageTDs[]); i++)
    {
        PlayerTextDrawShow(playerid, BankAccountsPageTDs[playerid][i]);
    }
    return 1;
}

stock HideBankAccountsPage(playerid)
{
    for(new i = 0; i < sizeof(BankAccountsPageTDs[]); i++)
    {
        if(BankAccountsPageTDs[playerid][i] == INVALID_PLAYER_TEXT_DRAW) continue;

        PlayerTextDrawDestroy(playerid, BankAccountsPageTDs[playerid][i]);
        BankAccountsPageTDs[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
    }

    for(new i = 0; i < 10; i++)
    {
        if(BankAccountsPageListTDs[playerid][i] == INVALID_PLAYER_TEXT_DRAW) continue;

        PlayerTextDrawDestroy(playerid, BankAccountsPageListTDs[playerid][i]);
        BankAccountsPageListTDs[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
    }
    return 1;
}

stock BankAccountsPageResetVars(playerid)
{    
    for(new i = 0; i < sizeof(BankAccountsPageListTDs[]); i++)
    {
        BankAccountsPageListTDs[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
    }

    for(new i = 0; i < sizeof(BankAccountsPageTDs[]); i++)
    {
        BankAccountsPageTDs[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
    }    
}

stock ShowPlayerBankAccountInfo(playerid, index, iBAN, AccountOwnerName[], Float:AccountMoney[MONEY_TYPE])
{
    new tmpStr[128];
    format(tmpStr, sizeof(tmpStr), "(%012d)_._%s__.__%.2f_%s__.__%.2f_%s__.__%.2f_%s", iBAN, AccountOwnerName, AccountMoney[MONEY_TYPE_DOLLAR], MoneyTypeString[MONEY_TYPE_DOLLAR], AccountMoney[MONEY_TYPE_EURO], MoneyTypeString[MONEY_TYPE_EURO], AccountMoney[MONEY_TYPE_POUND], MoneyTypeString[MONEY_TYPE_POUND]);

    BankAccountsPageListTDs[playerid][index] = CreatePlayerTextDraw(playerid, 196.333496, 153.081497 + (index*10), tmpStr);
    PlayerTextDrawLetterSize(playerid, BankAccountsPageListTDs[playerid][index], 0.140666, 0.737184);
    PlayerTextDrawAlignment(playerid, BankAccountsPageListTDs[playerid][index], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankAccountsPageListTDs[playerid][index], -141);
    PlayerTextDrawSetShadow(playerid, BankAccountsPageListTDs[playerid][index], false);
    PlayerTextDrawBackgroundColour(playerid, BankAccountsPageListTDs[playerid][index], 255);
    PlayerTextDrawFont(playerid, BankAccountsPageListTDs[playerid][index], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankAccountsPageListTDs[playerid][index], true);
    PlayerTextDrawTextSize(playerid, BankAccountsPageListTDs[playerid][index], 498.000000, 6.9);
    PlayerTextDrawSetSelectable(playerid, BankAccountsPageListTDs[playerid][index], true);

    
    //TMP Just to demonstrate active item
    if(index == 0)
    {
        PlayerTextDrawColour(playerid, BankAccountsPageListTDs[playerid][index], -1);
        PlayerTextDrawSetSelectable(playerid, BankAccountsPageListTDs[playerid][index], false);
    }

    PlayerTextDrawShow(playerid, BankAccountsPageListTDs[playerid][index]); 
}