#include <ysilib\YSI_Coding\y_hooks>

enum eCurrency {
    CURRENCY_UNKNOWN,
    CURRENCY_DOLLAR,
    CURRENCY_EURO,
    CURRENCY_POUND
}
new Float:pMoney[MAX_PLAYERS][eCurrency];


new CurrencyString[eCurrency][24] = {
    "Unknown",
    "Dollar",
    "Euro",
    "Egyptian Pound"
};

/*
    @TODO: Create visual representation for EURO and POUND (TextDraw ???)
           Update visual representation of money when it changes. 
*/

stock Float:GetPlayerMoney2(playerid, eCurrency:type = CURRENCY_DOLLAR)
{
    if(!IsPlayerConnected(playerid)) return 0;
    if(!(eCurrency:0 < type < eCurrency)) return 0;

    return pMoney[playerid][type];
}

#undef GetPlayerMoney
#define GetPlayerMoney(%0) GetPlayerMoney2(%0)

stock Float:SetPlayerMoney2(playerid, Float:ammount, const eCurrency:type = CURRENCY_DOLLAR)
{   
    if(!IsPlayerConnected(playerid)) return 0;
    if(!(eCurrency:0 < type < eCurrency)) return 0;

    pMoney[playerid][type]=ammount;    

    if(type == CURRENCY_DOLLAR)
    {
        ResetPlayerMoney(playerid);
        GivePlayerMoney(playerid, floatround(Float:pMoney[playerid][type]));
        new q[128];
        mysql_format(SQL, q, sizeof q, "UPDATE `characters` SET `cDollars` = '%f' WHERE `character_id` = '%d'", GetPlayerMoney(playerid), GetCharacterSQLID(playerid));
        mysql_tquery(SQL, q);
    }

    if(type == CURRENCY_EURO) {

        ResetPlayerMoney(playerid);
        GivePlayerMoney(playerid, floatround(Float:pMoney[playerid][type]));
        new q[128];
        mysql_format(SQL, q, sizeof q, "UPDATE `characters` SET `cEuro` = '%f' WHERE `character_id` = '%d'", GetPlayerMoney(playerid, CURRENCY_EURO), GetCharacterSQLID(playerid));
        mysql_tquery(SQL, q);
    }

    if(type == CURRENCY_POUND) {

        ResetPlayerMoney(playerid);
        GivePlayerMoney(playerid, floatround(Float:pMoney[playerid][type]));
        new q[128];
        mysql_format(SQL, q, sizeof q, "UPDATE `characters` SET `cEGPound` = '%f' WHERE `character_id` = '%d'", GetPlayerMoney(playerid, CURRENCY_POUND), GetCharacterSQLID(playerid));
        mysql_tquery(SQL, q);
    }
    Hud_ShowInterface(playerid);
    UpdateMoneyTD(playerid);
    return pMoney[playerid][type];
}
#define SetPlayerMoney(%0) SetPlayerMoney2(%0)

stock Float:GivePlayerMoney2(playerid, Float:ammount, eCurrency:type = CURRENCY_DOLLAR)
{
    if(!IsPlayerConnected(playerid)) return 0;
    if(!(eCurrency:0 < type < eCurrency)) return 0;

    pMoney[playerid][type]+=ammount;    

    if(type == CURRENCY_DOLLAR)
    {
        ResetPlayerMoney(playerid);
        GivePlayerMoney(playerid,floatround(Float:pMoney[playerid][type]));
    }

    if(type == CURRENCY_EURO) {

        ResetPlayerMoney(playerid);
        GivePlayerMoney(playerid, floatround(Float:pMoney[playerid][type]));
    }

    if(type == CURRENCY_POUND) {

        ResetPlayerMoney(playerid);
        GivePlayerMoney(playerid, floatround(Float:pMoney[playerid][type]));
    }
    Hud_ShowInterface(playerid);
    UpdateMoneyTD(playerid);
    return pMoney[playerid][type];
}
#undef GivePlayerMoney
#define GivePlayerMoney(%0) GivePlayerMoney2(%0)

stock Float:TakePlayerMoney(playerid, eCurrency:type, Float:ammount, bool:allowNegative = false)
{
    if(!IsPlayerConnected(playerid)) return 0;
    if(!(eCurrency:0 < type < eCurrency)) return 0;

    if(ammount > pMoney[playerid][type] && allowNegative == false) return 0;

    pMoney[playerid][type]-=ammount;

    SetPlayerMoney(playerid, pMoney[playerid][type], type);

    return pMoney[playerid][type];
}

stock GetCurrencyString(eCurrency:type)
{
    if(!(eCurrency:-1 < type < eCurrency)) return CurrencyString[CURRENCY_UNKNOWN];
    return CurrencyString[type];
}


YCMD:setplayercash(adminid, params[], help) = setplayermoney;
YCMD:setplayermoney(adminid, params[], help)
{
    if(!GetPlayerStaffLevel(adminid)) return 0;

    new playerid, Float:ammount, moneyType;
    if(sscanf(params, "ufD("#CURRENCY_DOLLAR")", playerid, ammount, moneyType)) return SendClientMessage(playerid, x_yellow, "USAGE: /setplayermoney [PlayerID/Name][Ammount](Type - 1,2,3)");

    new Float:iReturn = SetPlayerMoney(playerid, ammount, eCurrency:moneyType);
    SendClientMessage(playerid, x_green, "DEBUG: SetPlayerMoney returned %f", iReturn);
    return 1;
}

YCMD:giveplayercash(adminid, params[], help) = giveplayermoney;
YCMD:giveplayermoney(adminid, params[], help)
{
    if(!GetPlayerStaffLevel(adminid)) return 0;

    new playerid, Float:ammount, moneyType;
    if(sscanf(params, "ufD("#CURRENCY_DOLLAR")", playerid, ammount, moneyType)) return SendClientMessage(playerid, x_yellow, "USAGE: /giveplayermoney [PlayerID/Name][Ammount](Type - 1,2,3)");

    new Float:iReturn = GivePlayerMoney(playerid, ammount, eCurrency:moneyType);
    SendClientMessage(playerid, x_green, "DEBUG: GivePlayerMoney returned %f", iReturn);
    return 1;
}

YCMD:getplayercash(adminid, params[], help) = getplayermoney;
YCMD:getplayermoney(adminid, params[], help)
{
    if(!GetPlayerStaffLevel(adminid)) return 0;

    new playerid, moneyType;
    if(sscanf(params, "uD("#CURRENCY_DOLLAR")", playerid, moneyType)) return SendClientMessage(playerid, x_yellow, "USAGE: /getplayermoney [PlayerID/Name](Type - 1,2,3)");

    new Float:money = GetPlayerMoney(playerid, eCurrency:moneyType);

    SendClientMessage(playerid, x_yellow, "INFO: Player %s(%d) has %f %s", ReturnPlayerName(playerid), playerid, money, GetCurrencyString(eCurrency:moneyType));
    return 1;
}