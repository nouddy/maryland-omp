#include <ysilib\YSI_Coding\y_hooks>

enum MONEY_TYPE {
    MONEY_TYPE_UNKNOWN,
    MONEY_TYPE_DOLLAR,
    MONEY_TYPE_EURO,
    MONEY_TYPE_POUND
}
new Float:pMoney[MAX_PLAYERS][MONEY_TYPE];


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

stock Float:SetPlayerMoney2(playerid, Float:ammount, const MONEY_TYPE:type = MONEY_TYPE_DOLLAR)
{   
    if(!IsPlayerConnected(playerid)) return 0;
    if(!(MONEY_TYPE:0 < type < MONEY_TYPE)) return 0;

    pMoney[playerid][type]=ammount;    

    if(type == MONEY_TYPE_DOLLAR)
    {
        ResetPlayerMoney(playerid);
        GivePlayerMoney(playerid, floatround(Float:pMoney[playerid][type]));
    }

    return pMoney[playerid][type];
}
#define SetPlayerMoney(%0) SetPlayerMoney2(%0)

stock Float:GetPlayerMoney2(playerid, MONEY_TYPE:type = MONEY_TYPE_DOLLAR)
{
    if(!IsPlayerConnected(playerid)) return 0;
    if(!(MONEY_TYPE:0 < type < MONEY_TYPE)) return 0;

    return pMoney[playerid][type];
}
#define acc_GetPlayerMoney(%0) GetPlayerMoney2(%0)

stock Float:GivePlayerMoney2(playerid, Float:ammount, MONEY_TYPE:type = MONEY_TYPE_DOLLAR)
{
    if(!IsPlayerConnected(playerid)) return 0;
    if(!(MONEY_TYPE:0 < type < MONEY_TYPE)) return 0;

    pMoney[playerid][type]+=ammount;    

    if(type == MONEY_TYPE_DOLLAR)
    {
        ResetPlayerMoney(playerid);
        GivePlayerMoney(playerid,floatround(Float:pMoney[playerid][type]));
    }

    return pMoney[playerid][type];
}
#define acc_GivePlayerMoney(%0) GivePlayerMoney2(%0)

stock Float:TakePlayerMoney(playerid, MONEY_TYPE:type, Float:ammount, bool:allowNegative = false)
{
    if(!IsPlayerConnected(playerid)) return 0;
    if(!(MONEY_TYPE:0 < type < MONEY_TYPE)) return 0;

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

    new playerid, Float:ammount, moneyType;
    if(sscanf(params, "ufD("#MONEY_TYPE_DOLLAR")", playerid, ammount, moneyType)) return SendClientMessage(playerid, x_yellow, "USAGE: /setplayermoney [PlayerID/Name][Ammount](Type - 1,2,3)");

    new Float:iReturn = SetPlayerMoney(playerid, ammount, MONEY_TYPE:moneyType);
    SendClientMessage(playerid, x_green, "DEBUG: SetPlayerMoney returned %f", iReturn);
    return 1;
}

YCMD:giveplayercash(adminid, params[], help) = giveplayermoney;
YCMD:giveplayermoney(adminid, params[], help)
{
    if(!GetPlayerStaffLevel(adminid)) return 0;

    new playerid, Float:ammount, moneyType;
    if(sscanf(params, "ufD("#MONEY_TYPE_DOLLAR")", playerid, ammount, moneyType)) return SendClientMessage(playerid, x_yellow, "USAGE: /giveplayermoney [PlayerID/Name][Ammount](Type - 1,2,3)");

    new Float:iReturn = GivePlayerMoney(playerid, ammount, MONEY_TYPE:moneyType);
    SendClientMessage(playerid, x_green, "DEBUG: GivePlayerMoney returned %f", iReturn);
    return 1;
}

YCMD:getplayercash(adminid, params[], help) = getplayermoney;
YCMD:getplayermoney(adminid, params[], help)
{
    if(!GetPlayerStaffLevel(adminid)) return 0;

    new playerid, moneyType;
    if(sscanf(params, "uD("#MONEY_TYPE_DOLLAR")", playerid, moneyType)) return SendClientMessage(playerid, x_yellow, "USAGE: /getplayermoney [PlayerID/Name](Type - 1,2,3)");

    new Float:money = GetPlayerMoney(playerid, MONEY_TYPE:moneyType);

    SendClientMessage(playerid, x_yellow, "INFO: Player %s(%d) has %f %s", ReturnPlayerName(playerid), playerid, money, GetMoneyTypeString(MONEY_TYPE:moneyType));
    return 1;
}