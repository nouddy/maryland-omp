#include <ysilib\YSI_Coding\y_hooks>

/*
    //@TODO: Fix pagination for accounts (its in accounts global TDs array)
    //       Fix Bank Accounts actions, they are in global TDs array just like pagination
    //@NOTE: Make sure to fix pagination to be reusable, no need to waste checks and arrays if its always 4 TD's
*/ 


#define MAX_BANK_UI_TDS     100


/*
	@TODO:  Bank UI, unify function names and stuff.
            Paging navigation

*/


enum BankMenuButton {
    BankMenuHome,
    BankMenuAccounts,
    BankMenuDeposit,
    BankMenuWithdraw,
    // BankMenuTransfer,
    // BankMenuMyCards,
    // BankMenuMyAccount,
    BankMenuLogOut,
    BankMenuUnknown,
}

new BankMenuButtonStrings[BankMenuButton][16] = {
    "Home",
    "Accounts",
    "Deposit",
    "Withdraw",
    // "Transfer",
    // "My Cards",
    // "My Account",
    "Log out",
    "Unknown"
};
new PlayerText: BankUiTDs[MAX_PLAYERS][24];
new PlayerText: BankUiMenuTDs[MAX_PLAYERS][BankMenuButton];
new PlayerText: bankUiMenuActiveItemTD[MAX_PLAYERS];



//@TODO: Connection to buttons? One and the same???
new BankMenuButton:BankShownPageForPlayer[MAX_PLAYERS];


//Pages
new PlayerText:BankHomePageTDs[MAX_PLAYERS][8];

new PlayerText:BankDepositPageTDs[MAX_PLAYERS][27];
new PlayerText:BankWithdrawPageTDs[MAX_PLAYERS][27];
// new PlayerText:BankWithdrawPageTDs[MAX_PLAYERS][27];
// new PlayerText:BankTransferPageTDs[MAX_PLAYERS][27];

new PlayerText:BankMyCardsPageTDs[MAX_PLAYERS][21];
new PlayerText:BankMyCardsPageCard[MAX_PLAYERS][3][20];

new PlayerText:BankMyAccountPageTDs[MAX_PLAYERS][43];

new PlayerText:BankPaginationTDs[MAX_PLAYERS][4];

#include "./frontend/textdraws/Bank/BankUiHome.pwn"
#include "./frontend/textdraws/Bank/BankUiAccounts.pwn"
#include "./frontend/textdraws/Bank/BankUiDeposit.pwn"
#include "./frontend/textdraws/Bank/BankUiMyCards.pwn"
#include "./frontend/textdraws/Bank/BankUiMyAccount.pwn"
#include "./frontend/textdraws/Bank/BankUiWithdraw.pwn"

//===========================================================================================
//--->>> Hooks
//===========================================================================================

hook OnPlayerConnect(playerid)
{
    for(new i = 0; i < sizeof(BankUiTDs[]); i++)
    {
        BankUiTDs[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
    }
    for(new BankMenuButton:i = BankMenuButton:0; i < BankMenuButton; i++)
    {
        BankUiMenuTDs[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
    }
    bankUiMenuActiveItemTD[playerid] = INVALID_PLAYER_TEXT_DRAW;

    for(new i = 0; i < 8; i++)
    {
        BankHomePageTDs[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
    }
    
    BankAccountsPageResetVars(playerid);

    for(new i = 0; i < sizeof(BankDepositPageTDs[]); i++)
    {
        BankDepositPageTDs[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
    }  

    for(new i = 0; i < sizeof(BankPaginationTDs[]); i++)
    {
        BankPaginationTDs[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
    }



    for(new i = 0; i < sizeof(BankMyCardsPageTDs[]); i++)
    {
        BankMyCardsPageTDs[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
    }

    for(new i = 0; i < sizeof(BankMyCardsPageCard[]); i++)
    {
        for(new x = 0; x < sizeof(BankMyCardsPageCard[][]); x++)
        {
            BankMyCardsPageCard[playerid][i][x] = INVALID_PLAYER_TEXT_DRAW;
        }  
    }


    for(new i = 0; i < sizeof(BankMyAccountPageTDs[]); i++)
    {
        BankMyAccountPageTDs[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
    }

    BankShownPageForPlayer[playerid] = BankMenuUnknown;

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if(BankShownPageForPlayer[playerid] == BankMenuUnknown) return Y_HOOKS_CONTINUE_RETURN_1;

    //Handale ESC button (Note: OnPlayerClickPlayerTextDraw is not called when ESC is pressed)
    if(clickedid == INVALID_TEXT_DRAW)
    {
        BankDestroyMainUI(playerid);
        CancelSelectTextDraw(playerid);
        ActivePlayerBankAccount[playerid] = -1;

        WithdrawCurrency[playerid] = 0;
        ActiveWithdrawAmmount[playerid] = 0.00;

        ActiveChosenCurrency[playerid] = 0;
        ActiveDepositAmmount[playerid] = 0.00;

        return Y_HOOKS_BREAK_RETURN_1;
    }
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    // SendClientMessage(playerid, -1, "OnPlayerClickPlayerTextDraw textid %d", playertextid);

    if(BankShownPageForPlayer[playerid] == BankMenuUnknown) return Y_HOOKS_CONTINUE_RETURN_1;
    // SendClientMessage(playerid, -1, "OnPlayerClickPlayerTextDraw BankShownPageForPlayer %s(%d)", BankMenuButtonStrings[BankShownPageForPlayer[playerid]], _:BankShownPageForPlayer[playerid]);


    for(new BankMenuButton:i = BankMenuButton:0; i < BankMenuButton; i++)
    {
        if(BankUiMenuTDs[playerid][i] == playertextid)
        {
            CallLocalFunction( "OnPlayerSelectBankMenuNavItem", "dd", playerid,  _:i);
            return Y_HOOKS_BREAK_RETURN_1;
        }
    }


    if(BankShownPageForPlayer[playerid] == BankMenuAccounts)
    {
        if(IsBankAccountCreateNewButton(playerid, playertextid))
        {
            SendClientMessage(playerid, -1, "Clicked create new account button");
            // CreateBankAccount(3, OWNER_TYPE_PLAYER);
            
            Dialog_Show(playerid, "dialog_CreateBankAccount", DIALOG_STYLE_LIST, ""c_ltorange"H4RBOR Bank \187; "c_white"Create Account", 
                                                                                 ""c_white"#1 \187; "c_ltorange"Privatni Racun\n\
                                                                                 "c_white"#2 \187; "c_ltorange"Racun za firmu\n\
                                                                                 "c_white"#3 \187; "c_ltorange"Fakcijski Racun", "Odaberi", "Odustani");

        }

        if(IsBankAccountDeleteButton(playerid, playertextid))
        {
            // PlayerBankAccounts

            if(ActivePlayerBankAccount[playerid] == -1)
                return (true);

            new tmp_idx = ActivePlayerBankAccount[playerid];

            // PlayerBankAccounts[playerid][tmp_idx][IBAN]

            static dlgStr[367];
            format(dlgStr, sizeof dlgStr, "Da li ste sigurni da zelite obrisati bankovni racun : IBAN %s\n\
                                          Euro : %f\n\
                                          Dollar : %f\n\
                                          Pound : %f", FormatIBANString(PlayerBankAccounts[playerid][tmp_idx][IBAN]),
                                                       PlayerBankAccounts[playerid][tmp_idx][Currencies][CURRENCY_EURO],
                                                       PlayerBankAccounts[playerid][tmp_idx][Currencies][CURRENCY_DOLLAR],
                                                       PlayerBankAccounts[playerid][tmp_idx][Currencies][CURRENCY_POUND]);
            
            Dialog_Show(playerid, "dialog_deleteBankAccount", DIALOG_STYLE_MSGBOX, ""c_ltorange"H4RBOR Bank \187; "c_white"Delete Account", 
                                                                                    dlgStr, ""c_lred"DELETE", "DENY");

            //-> Koji acc da delete
        }

        if(IsBankAccountTransferOwnershipButton(playerid, playertextid))
        {
            SendClientMessage(playerid, -1, "Clicked transfer account button");
            //-> Koji acc da transfer i kome (sa firme na firmu, igraca na igraca, fakcije na fakciju)
        }

        if(IsBankAccountSwitchAccountButton(playerid, playertextid))
        {
            SendClientMessage(playerid, -1, "Clicked switch account button");
        }

        for(new i = 0; i < sizeof BankAccountsPageListTDs[]; i++) {
            if(BankAccountsPageListTDs[playerid][i] == INVALID_PLAYER_TEXT_DRAW) continue;
            if(BankAccountsPageListTDs[playerid][i] != playertextid) continue;
            SendClientMessage(playerid, -1, "Chosed an account on textdraw index(%d)", i);
            // BankAccountsPageListTDs[playerid][i]
            SetPlayerActiveBankAccount(playerid, i);
            break;
        }
    }

    if(BankShownPageForPlayer[playerid] == BankMenuDeposit) {

        if(IsBankDepositConfirmButton(playerid, playertextid)) {

            // SendClientMessage(playerid, -1, "Clicked deposit confirm button");

            if( ActiveDepositAmmount[playerid] == 0.00 )
                return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Niste unijeli kolicinu novca koju zelite staviti na bankovni racun!");

            if( ActiveChosenCurrency[playerid] == 0 )
                return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Niste izabrali zeljenu valutu za deposit!");

            new tmp_idx = ActivePlayerBankAccount[playerid];

            PlayerBankAccounts[playerid][tmp_idx][Currencies][ eCurrency:ActiveChosenCurrency[playerid] ] += ActiveDepositAmmount[playerid];

            new q[128];
            mysql_format(SQL, q, sizeof q, "UPDATE `bankaccounts` SET `%e` = '%f' WHERE `AccountID` = '%d'", GetCurrencyString(eCurrency: ( ActiveChosenCurrency[playerid] )), PlayerBankAccounts[playerid][tmp_idx][Currencies][ eCurrency: (ActiveChosenCurrency[playerid]) ], PlayerBankAccounts[playerid][tmp_idx][IBAN]);
            mysql_tquery(SQL, q);

            GivePlayerMoney(playerid, -ActiveDepositAmmount[playerid], eCurrency:ActiveChosenCurrency[playerid]);
            
            static current_val[122];
            format(current_val, sizeof current_val, "CURRENT:_%.2f", PlayerBankAccounts[playerid][ tmp_idx ][Currencies][ eCurrency:ActiveChosenCurrency[playerid] ] );
            PlayerTextDrawSetString(playerid, BankDepositPageTDs[playerid][20], current_val);

            ActiveDepositAmmount[playerid] = 0.00;
            ActiveChosenCurrency[playerid] = 0;
        }

        if(IsBankDepositCurrencyButton(playerid, playertextid)) {

            // SendClientMessage(playerid, -1, "Clicked deposit currency button");
            Dialog_Show(playerid, "dialog_depositChoseCurrency", DIALOG_STYLE_LIST, ""c_ltorange"H4RBOR BANK \187; "c_white"Deposit Currency", 
                                                                                                "#1 \187; Dollar\n\
                                                                                                 #2 \187; Euro\n\
                                                                                                 #3 \187; Pound", "CHOOSE", "DENY");
        }

        if(IsBankDepositValueButton(playerid, playertextid)) {

            Dialog_Show(playerid, "dialog_depositValue", DIALOG_STYLE_INPUT, ""c_ltorange"H4RBOR BANK \187; "c_white"Deposit Value",
                                                                             "Unesite zeljenu kolicinu novca za deposit.", "INPUT", "DENY");
        }
    }

    if(BankShownPageForPlayer[playerid] == BankMenuWithdraw) {

        if(IsBankWithdrawConfirmButton(playerid, playertextid)) {

            if( ActiveWithdrawAmmount[playerid] == 0.00 )
                return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Niste unijeli kolicinu novca koju zelite staviti na bankovni racun!");

            if( WithdrawCurrency[playerid] == 0 )
                return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Niste izabrali zeljenu valutu za deposit!");

            new tmp_idx = ActivePlayerBankAccount[playerid];

            PlayerBankAccounts[playerid][tmp_idx][Currencies][ eCurrency:WithdrawCurrency[playerid] ] -= ActiveWithdrawAmmount[playerid];

            new q[128];
            mysql_format(SQL, q, sizeof q, "UPDATE `bankaccounts` SET `%e` = '%f' WHERE `AccountID` = '%d'", GetCurrencyString(eCurrency: ( WithdrawCurrency[playerid] )), PlayerBankAccounts[playerid][tmp_idx][Currencies][ eCurrency: (WithdrawCurrency[playerid]) ], PlayerBankAccounts[playerid][tmp_idx][IBAN]);
            mysql_tquery(SQL, q);

            GivePlayerMoney(playerid, ActiveWithdrawAmmount[playerid], eCurrency:WithdrawCurrency[playerid]);
            
            static current_val[122];
            format(current_val, sizeof current_val, "CURRENT:_%.2f", PlayerBankAccounts[playerid][ tmp_idx ][Currencies][ eCurrency:WithdrawCurrency[playerid] ] );
            PlayerTextDrawSetString(playerid, BankWithdrawPageTDs[playerid][20], current_val);

            ActiveWithdrawAmmount[playerid] = 0.00;
            WithdrawCurrency[playerid] = 0;

        }

        if(IsBankWithdrawCurrencyButton(playerid, playertextid)) {

            Dialog_Show(playerid, "dialog_withdrawChoseCurrency", DIALOG_STYLE_LIST, ""c_ltorange"H4RBOR BANK \187; "c_white"Deposit Currency", 
                                                                                                "#1 \187; Dollar\n\
                                                                                                 #2 \187; Euro\n\
                                                                                                 #3 \187; Pound", "CHOOSE", "DENY");
        }

        if(IsBankWithdrawValueButton(playerid, playertextid)) {

            Dialog_Show(playerid, "dialog_withdrawValue", DIALOG_STYLE_INPUT, ""c_ltorange"H4RBOR BANK \187; "c_white"Withdraw Value",
                                                                             "Unesite zeljenu kolicinu novca koju zelite podignuti za racuna.", "INPUT", "DENY");

        }
    }

	return Y_HOOKS_CONTINUE_RETURN_1;
}


forward OnPlayerSelectBankMenuNavItem(playerid, BankMenuButton:button);
public OnPlayerSelectBankMenuNavItem(playerid, BankMenuButton:button)
{
    SendClientMessage(playerid, -1, "Selected bank ui menu item: %s", BankMenuButtonStrings[button]);

    HideBankHomePage(playerid);
    HideBankAccountsPage(playerid);
    HideBankDepositPage(playerid);
    BankHideMyCardsPage(playerid);
    HideBankWithdrawPage(playerid);
    HideBankMyAccountPage(playerid);


    SetBankMenuActiveButton(playerid, button);

    switch(button)
    {
        case BankMenuHome:
        {
            
        }

        case BankMenuAccounts: {


        }

        case BankMenuDeposit: {


        }

        case BankMenuWithdraw: {


        }


        case BankMenuLogOut:
        {
            BankDestroyMainUI(playerid);
            CancelSelectTextDraw(playerid);
            ActivePlayerBankAccount[playerid] = -1;
            WithdrawCurrency[playerid] = 0;
            ActiveWithdrawAmmount[playerid] = 0.00;

            ActiveChosenCurrency[playerid] = 0;
            ActiveDepositAmmount[playerid] = 0.00;
        }

        case BankMenuUnknown: {

            
        }
    }
    return 1;
}


stock BankDestroyMainUI(playerid)
{
    HideBankHomePage(playerid);
    HideBankAccountsPage(playerid);
    HideBankDepositPage(playerid);
    BankHideMyCardsPage(playerid);
    HideBankWithdrawPage(playerid);

    HideBankMyAccountPage(playerid);



    for(new i = 0; i < sizeof(BankUiTDs[]); i++)
    {
        if(BankUiTDs[playerid][i] == INVALID_PLAYER_TEXT_DRAW) continue;
        PlayerTextDrawDestroy(playerid, BankUiTDs[playerid][i]);
        BankUiTDs[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
    }
    for(new BankMenuButton:i = BankMenuButton:0; i < BankMenuButton; i++)
    {
        if(BankUiMenuTDs[playerid][i] == INVALID_PLAYER_TEXT_DRAW) continue;
        PlayerTextDrawDestroy(playerid, BankUiMenuTDs[playerid][i]);
        BankUiMenuTDs[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
    }

    if(bankUiMenuActiveItemTD[playerid] != INVALID_PLAYER_TEXT_DRAW)
    {
        PlayerTextDrawDestroy(playerid, bankUiMenuActiveItemTD[playerid]);
        bankUiMenuActiveItemTD[playerid] = INVALID_PLAYER_TEXT_DRAW;
    }

    BankShownPageForPlayer[playerid] = BankMenuUnknown;

}

stock BankCreateMainUI(playerid, BankMenuButton:setActive = BankMenuHome)
{
    BankUiTDs[playerid][0] = CreatePlayerTextDraw(playerid, 115.666702, 88.214782, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankUiTDs[playerid][0], 403.000000, 293.000000);
    PlayerTextDrawAlignment(playerid, BankUiTDs[playerid][0], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankUiTDs[playerid][0], 539506175);
    PlayerTextDrawSetShadow(playerid, BankUiTDs[playerid][0], false);
    PlayerTextDrawBackgroundColour(playerid, BankUiTDs[playerid][0], 255);
    PlayerTextDrawFont(playerid, BankUiTDs[playerid][0], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankUiTDs[playerid][0], false);

    BankUiTDs[playerid][1] = CreatePlayerTextDraw(playerid, 502.333465, 352.210937, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, BankUiTDs[playerid][1], 31.000000, 35.000000);
    PlayerTextDrawAlignment(playerid, BankUiTDs[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankUiTDs[playerid][1], 539506175);
    PlayerTextDrawSetShadow(playerid, BankUiTDs[playerid][1], false);
    PlayerTextDrawBackgroundColour(playerid, BankUiTDs[playerid][1], 255);
    PlayerTextDrawFont(playerid, BankUiTDs[playerid][1], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankUiTDs[playerid][1], false);

    BankUiTDs[playerid][2] = CreatePlayerTextDraw(playerid, 502.333465, 82.166496, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, BankUiTDs[playerid][2], 31.000000, 35.000000);
    PlayerTextDrawAlignment(playerid, BankUiTDs[playerid][2], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankUiTDs[playerid][2], 539506175);
    PlayerTextDrawSetShadow(playerid, BankUiTDs[playerid][2], false);
    PlayerTextDrawBackgroundColour(playerid, BankUiTDs[playerid][2], 255);
    PlayerTextDrawFont(playerid, BankUiTDs[playerid][2], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankUiTDs[playerid][2], false);

    BankUiTDs[playerid][3] = CreatePlayerTextDraw(playerid, 101.666786, 82.166496, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, BankUiTDs[playerid][3], 31.000000, 35.000000);
    PlayerTextDrawAlignment(playerid, BankUiTDs[playerid][3], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankUiTDs[playerid][3], 539506175);
    PlayerTextDrawSetShadow(playerid, BankUiTDs[playerid][3], false);
    PlayerTextDrawBackgroundColour(playerid, BankUiTDs[playerid][3], 255);
    PlayerTextDrawFont(playerid, BankUiTDs[playerid][3], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankUiTDs[playerid][3], false);

    BankUiTDs[playerid][4] = CreatePlayerTextDraw(playerid, 101.666786, 352.010925, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, BankUiTDs[playerid][4], 31.000000, 35.000000);
    PlayerTextDrawAlignment(playerid, BankUiTDs[playerid][4], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankUiTDs[playerid][4], 539506175);
    PlayerTextDrawSetShadow(playerid, BankUiTDs[playerid][4], false);
    PlayerTextDrawBackgroundColour(playerid, BankUiTDs[playerid][4], 255);
    PlayerTextDrawFont(playerid, BankUiTDs[playerid][4], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankUiTDs[playerid][4], false);

    BankUiTDs[playerid][5] = CreatePlayerTextDraw(playerid, 106.666679, 99.414779, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankUiTDs[playerid][5], 421.230224, 269.000000);
    PlayerTextDrawAlignment(playerid, BankUiTDs[playerid][5], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankUiTDs[playerid][5], 539506175);
    PlayerTextDrawSetShadow(playerid, BankUiTDs[playerid][5], false);
    PlayerTextDrawBackgroundColour(playerid, BankUiTDs[playerid][5], 255);
    PlayerTextDrawFont(playerid, BankUiTDs[playerid][5], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankUiTDs[playerid][5], false);

    BankUiTDs[playerid][6] = CreatePlayerTextDraw(playerid, 190.999984, 106.881446, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BankUiTDs[playerid][6], -0.730000, 257.629638);
    PlayerTextDrawAlignment(playerid, BankUiTDs[playerid][6], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, BankUiTDs[playerid][6], -226);
    PlayerTextDrawSetShadow(playerid, BankUiTDs[playerid][6], false);
    PlayerTextDrawBackgroundColour(playerid, BankUiTDs[playerid][6], 255);
    PlayerTextDrawFont(playerid, BankUiTDs[playerid][6], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, BankUiTDs[playerid][6], false);

    BankUiTDs[playerid][7] = CreatePlayerTextDraw(playerid, 149.333450, 97.911064, "THE_H4RBOR_BANK");
    PlayerTextDrawLetterSize(playerid, BankUiTDs[playerid][7], 0.150000, 0.658370);
    PlayerTextDrawAlignment(playerid, BankUiTDs[playerid][7], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, BankUiTDs[playerid][7], -1);
    PlayerTextDrawSetShadow(playerid, BankUiTDs[playerid][7], false);
    PlayerTextDrawBackgroundColour(playerid, BankUiTDs[playerid][7], 255);
    PlayerTextDrawFont(playerid, BankUiTDs[playerid][7], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, BankUiTDs[playerid][7], true);


    
    for(new BankMenuButton:i = BankMenuButton:0; i < BankMenuButton-BankMenuButton:1; i++)
    {
            BankUiMenuTDs[playerid][i] = CreatePlayerTextDraw(playerid, 126.666732, 139.392745 + (_:i * 25), BankMenuButtonStrings[i]);
            PlayerTextDrawLetterSize(playerid, BankUiMenuTDs[playerid][i], 0.175666, 0.662518);
            PlayerTextDrawAlignment(playerid, BankUiMenuTDs[playerid][i], TEXT_DRAW_ALIGN_LEFT);
            PlayerTextDrawColour(playerid, BankUiMenuTDs[playerid][i], -156);
            PlayerTextDrawSetShadow(playerid, BankUiMenuTDs[playerid][i], false);
            PlayerTextDrawBackgroundColour(playerid, BankUiMenuTDs[playerid][i], 255);
            PlayerTextDrawFont(playerid, BankUiMenuTDs[playerid][i], TEXT_DRAW_FONT_1);
            PlayerTextDrawSetProportional(playerid, BankUiMenuTDs[playerid][i], true);
            //Box size
            PlayerTextDrawTextSize(playerid, BankUiMenuTDs[playerid][i], 160, 5);

            PlayerTextDrawShow(playerid, BankUiMenuTDs[playerid][i]);
    }
    
    for(new i = 0; i < 8; i++)
    {
        PlayerTextDrawShow(playerid, BankUiTDs[playerid][i]);
    }

    SetBankMenuActiveButton(playerid, setActive);

    return 1;
}

stock SetBankMenuActiveButton(playerid, BankMenuButton:button)
{
    //@TODO:
    //      No need to check if TD is valid, server can handle that. (Or add it?)
    for(new BankMenuButton:i = BankMenuButton:0; i < BankMenuButton; i++)
    {
        if(BankUiMenuTDs[playerid][i] == INVALID_PLAYER_TEXT_DRAW) continue;

        PlayerTextDrawColour(playerid, BankUiMenuTDs[playerid][i], -156);
        PlayerTextDrawSetSelectable(playerid, BankUiMenuTDs[playerid][i], true);
        PlayerTextDrawShow(playerid, BankUiMenuTDs[playerid][i]);
    }


    // if(BankUiTDs[playerid][i] != INVALID_PLAYER_TEXT_DRAW) continue;
    //Active item, change Colour and disable selectable.
    
    PlayerTextDrawColour(playerid, BankUiMenuTDs[playerid][button], -1);
    PlayerTextDrawSetSelectable(playerid, BankUiMenuTDs[playerid][button], false);
    PlayerTextDrawShow(playerid, BankUiMenuTDs[playerid][button]);


    //Destroy old arrow td that shows active item
    if(bankUiMenuActiveItemTD[playerid] != INVALID_PLAYER_TEXT_DRAW)
        PlayerTextDrawDestroy(playerid, bankUiMenuActiveItemTD[playerid]);

    //Create new arrow td that shows active item
    bankUiMenuActiveItemTD[playerid] = CreatePlayerTextDraw(playerid, 99.333328, 124.303688 + (_:button * 25), "");
    PlayerTextDrawTextSize(playerid, bankUiMenuActiveItemTD[playerid], 35.000000, 36.000000);
    PlayerTextDrawAlignment(playerid, bankUiMenuActiveItemTD[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, bankUiMenuActiveItemTD[playerid], -1);
    PlayerTextDrawSetShadow(playerid, bankUiMenuActiveItemTD[playerid], false);
    PlayerTextDrawBackgroundColour(playerid, bankUiMenuActiveItemTD[playerid], -256);
    PlayerTextDrawFont(playerid, bankUiMenuActiveItemTD[playerid], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid, bankUiMenuActiveItemTD[playerid], false);
    PlayerTextDrawSetPreviewModel(playerid, bankUiMenuActiveItemTD[playerid], 19177);
    PlayerTextDrawSetPreviewRot(playerid, bankUiMenuActiveItemTD[playerid], 0.000000, 270.000000, 0.000000, 1.000000);
    PlayerTextDrawShow(playerid, bankUiMenuActiveItemTD[playerid]);


    //===============================================================
    BankShownPageForPlayer[playerid] = button;

    if(button == BankMenuHome)
    {
        ShowBankHomePage(playerid);
    }    
    if(button == BankMenuAccounts)
    {
        ShowBankAccountsForPlayer(playerid);
        ShowBankAccountsPage(playerid);
    }
    if(button == BankMenuDeposit)
    {
        ShowBankDepositPage(playerid);
    }

    if(button == BankMenuWithdraw) {

        ShowBankWithdrawPage(playerid);
    }

    // if(button == BankMenuMyCards)
    // {
    //     ShowBankMyCardsPage(playerid);
    // }
    // if(button == BankMenuMyAccount)
    // {   
    //     ShowBankMyAccountPage(playerid);
    // }   
    return 1;
}
