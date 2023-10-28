#include <ysilib\YSI_Coding\y_hooks>

enum MONEY_TYPE {
    MONEY_TYPE_UNKNOWN,
    MONEY_TYPE_DOLLAR,
    MONEY_TYPE_EURO,
    MONEY_TYPE_POUND
}
new pMoney[MAX_PLAYERS][MONEY_TYPE];


new MoneyTypeString[MONEY_TYPE][24] = {
    "Unknown",
    "Dollar",
    "Euro",
    "Egyptian Pound"
};

/*
    @TODO: Create visual representation for EURO and POUND (TextDraw ???)
           Update visual representation of money when it changes. 
*/

stock GetPlayerMoney2(playerid, MONEY_TYPE:type = MONEY_TYPE_DOLLAR)
{
    if(!IsPlayerConnected(playerid)) return 0;
    if(!(MONEY_TYPE:-1 < type < MONEY_TYPE)) return 0;

    return pMoney[playerid][type];
}
#define GetPlayerMoney(%0) GetPlayerMoney2(%0)

stock SetPlayerMoney2(playerid, ammount, const MONEY_TYPE:type = MONEY_TYPE_DOLLAR)
{   
    if(!IsPlayerConnected(playerid)) return 0;
    if(!(MONEY_TYPE:-1 < type < MONEY_TYPE)) return 0;

    pMoney[playerid][type]=ammount;    

    if(type == MONEY_TYPE_DOLLAR)
    {
        ResetPlayerMoney(playerid);
        GivePlayerMoney(playerid, pMoney[playerid][type]);
    }

    return pMoney[playerid][type];
}
#define SetPlayerMoney(%0) SetPlayerMoney2(%0)

stock GivePlayerMoney2(playerid, ammount, MONEY_TYPE:type = MONEY_TYPE_DOLLAR)
{
    if(!IsPlayerConnected(playerid)) return 0;
    if(!(MONEY_TYPE:-1 < type < MONEY_TYPE)) return 0;

    pMoney[playerid][type]+=ammount;    

    if(type == MONEY_TYPE_DOLLAR)
    {
        ResetPlayerMoney(playerid);
        GivePlayerMoney(playerid, pMoney[playerid][type]);
    }

    return pMoney[playerid][type];
}
#define GivePlayerMoney(%0) GivePlayerMoney2(%0)

stock TakePlayerMoney(playerid, MONEY_TYPE:type, ammount, bool:allowNegative = false)
{
    if(!IsPlayerConnected(playerid)) return 0;
    if(!(MONEY_TYPE:-1 < type < MONEY_TYPE)) return 0;

    if(ammount > pMoney[playerid][type] && allowNegative == false) return 0;

    pMoney[playerid][type]-=ammount;

    SetPlayerMoney(playerid, pMoney[playerid][type], type);

    return pMoney[playerid][type];
}

stock GetMoneyTypeString(MONEY_TYPE:type)
{
    if(!(MONEY_TYPE:-1 < type < MONEY_TYPE)) return MoneyTypeString[MONEY_TYPE_UNKNOWN];
    return MoneyTypeString[type];
}


YCMD:setplayercash(adminid, params[], help) = setplayermoney;
YCMD:setplayermoney(adminid, params[], help)
{
    if(!GetPlayerStaffLevel(adminid)) return 0;

    new playerid, ammount, moneyType;
    if(sscanf(params, "udD("#MONEY_TYPE_DOLLAR")", playerid, ammount, moneyType)) return SendClientMessage(playerid, x_yellow, "USAGE: /setplayermoney [PlayerID/Name][Ammount](Type - 0,1,2)");

    new iReturn = SetPlayerMoney(playerid, ammount, MONEY_TYPE:moneyType);
    SendClientMessage(playerid, x_green, "DEBUG: SetPlayerMoney returned %d", iReturn);
    return 1;
}

YCMD:giveplayercash(adminid, params[], help) = giveplayermoney;
YCMD:giveplayermoney(adminid, params[], help)
{
    if(!GetPlayerStaffLevel(adminid)) return 0;

    new playerid, ammount, moneyType;
    if(sscanf(params, "udD("#MONEY_TYPE_DOLLAR")", playerid, ammount, moneyType)) return SendClientMessage(playerid, x_yellow, "USAGE: /giveplayermoney [PlayerID/Name][Ammount](Type - 0,1,2)");

    new iReturn = GivePlayerMoney(playerid, ammount, MONEY_TYPE:moneyType);
    SendClientMessage(playerid, x_green, "DEBUG: GivePlayerMoney returned %d", iReturn);
    return 1;
}

YCMD:getplayercash(adminid, params[], help) = getplayermoney;
YCMD:getplayermoney(adminid, params[], help)
{
    if(!GetPlayerStaffLevel(adminid)) return 0;

    new playerid, moneyType;
    if(sscanf(params, "uD("#MONEY_TYPE_DOLLAR")", playerid, moneyType)) return SendClientMessage(playerid, x_yellow, "USAGE: /getplayermoney [PlayerID/Name](Type - 0,1,2)");

    new money = GetPlayerMoney(playerid, MONEY_TYPE:moneyType);

    SendClientMessage(playerid, x_yellow, "INFO: Player %s(%d) has %d %s", ReturnPlayerName(playerid), playerid, money, GetMoneyTypeString(MONEY_TYPE:moneyType));
    return 1;
}
