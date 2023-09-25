/***
 *
 *  ##     ##    ###    ########  ##    ## ##          ###    ##    ## ########  
 *  ###   ###   ## ##   ##     ##  ##  ##  ##         ## ##   ###   ## ##     ## 
 *  #### ####  ##   ##  ##     ##   ####   ##        ##   ##  ####  ## ##     ## 
 *  ## ### ## ##     ## ########     ##    ##       ##     ## ## ## ## ##     ## 
 *  ##     ## ######### ##   ##      ##    ##       ######### ##  #### ##     ## 
 *  ##     ## ##     ## ##    ##     ##    ##       ##     ## ##   ### ##     ## 
 *  ##     ## ##     ## ##     ##    ##    ######## ##     ## ##    ## ########   
 *
 *  @Author         Vostic
 *  @Date           05th May 2023
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           playerdocuments.script
 *  @Module         documentation
 */

#include <ysilib\YSI_Coding\y_hooks>

hook OnGameModeInit()
{
    print("documentation/playerdocuments.script loaded");

    return Y_HOOKS_CONTINUE_RETURN_1;
}


//>>
enum PlayerDocumentsz
{
    pNationalID,
    pPassport,
    pDriveLicence,
    pMotoLicence,
    pBoatLicence,
    pGunLicence,
    pZivotnoOsiguranje
}
new PlayerDocuments[MAX_PLAYERS][PlayerDocumentsz];

hook OnPlayerLoaded(playerid)
{   
    new q[120];
    mysql_format(SQL, q, sizeof(q), "SELECT * FROM player_documents WHERE player_id = '%d' LIMIT 1", PlayerInfo[playerid][SQLID]);
    mysql_tquery(SQL, q, "SQL_AccountDocumentsLoad", "i", playerid);

	return 1;
}

//
YCMD:izvadilicnu(playerid, params[], help)
{

    if(IsPlayerInRangeOfPoint(playerid, 3.0, -2334.3879,1244.1754,-31.6301))
    {
        if(PlayerDocuments[playerid][pNationalID] == 1) return notification.Show(playerid, "GRESKA", "Vec imate licnu kartu", "!", BOXCOLOR_RED);
        if(GetPlayerMoney(playerid) < 200) return notification.Show(playerid, "GRESKA", "Nemate dovoljno novca", "!", BOXCOLOR_RED);

        PlayerDocuments[playerid][pNationalID] = 1;
        VosticGiveMoney(playerid, -200);
        ApplyAnimation(playerid, "DEALER", "shop_pay", 4.1, false, false, false, false, 0);
        notification.Show(playerid, "OPSTINA", "Uspesno si izvadio licnu kartu!", "!", BOXCOLOR_GREEN);

        SaveDocuments(playerid);
    }
    else notification.Show(playerid, "GRESKA", "Morate biti na salteru u opstini", "!", BOXCOLOR_RED);

    return Y_HOOKS_CONTINUE_RETURN_1;

}

YCMD:izvadipasos(playerid, params[], help)
{
    if(IsPlayerInRangeOfPoint(playerid, 3.0, -2334.7085,1255.7548,-31.6301))
    {
        if(PlayerDocuments[playerid][pPassport] == 1) return notification.Show(playerid, "GRESKA", "Vec imate pasos", "!", BOXCOLOR_RED);
        if(GetPlayerMoney(playerid) < 200) return notification.Show(playerid, "GRESKA", "Nemate dovoljno novca", "!", BOXCOLOR_RED);

        PlayerDocuments[playerid][pPassport] = 1;
        VosticGiveMoney(playerid, -200);
        ApplyAnimation(playerid, "DEALER", "shop_pay", 4.1, false, false, false, false, 0);
        notification.Show(playerid, "OPSTINA", "Uspesno si izvadio pasos!", "!", BOXCOLOR_GREEN);

        SaveDocuments(playerid);
    }
    else notification.Show(playerid, "GRESKA", "Morate biti na salteru u opstini", "!", BOXCOLOR_RED);

    return Y_HOOKS_CONTINUE_RETURN_1;

}

YCMD:izvadiosiguranje(playerid, params[], help)
{
    if(IsPlayerInRangeOfPoint(playerid, 3.0, -2334.7085,1255.7548,-31.6301))
    {
        if(PlayerDocuments[playerid][pZivotnoOsiguranje] != -1) return notification.Show(playerid, "GRESKA", "Vec imate zivotno osiguranje", "!", BOXCOLOR_RED);
        if(GetPlayerMoney(playerid) < 200) return notification.Show(playerid, "GRESKA", "Nemate dovoljno novca", "!", BOXCOLOR_RED);

        PlayerDocuments[playerid][pZivotnoOsiguranje] = 1;
        VosticGiveMoney(playerid, -200);
        ApplyAnimation(playerid, "DEALER", "shop_pay", 4.1, false, false, false, false, 0);
        notification.Show(playerid, "OPSTINA", "Uspesno si izvadio zivotno osiguranje!", "!", BOXCOLOR_GREEN);

        SaveDocuments(playerid);
    }
    else notification.Show(playerid, "GRESKA", "Morate biti na salteru u opstini", "!", BOXCOLOR_RED);

    return Y_HOOKS_CONTINUE_RETURN_1;

}
/*
    * Funkcije:
*/
forward SQL_AccountDocumentsLoad(playerid);
public SQL_AccountDocumentsLoad(playerid)
{
    static rows;
    cache_get_row_count(rows);
    if(!rows) 
    {
        new q[300];
        mysql_format(SQL, q, sizeof(q), 
           "INSERT INTO `player_documents` (player_id, NationalID, Passport, VoziloLicence, MotoLicence, BrodLicence, OruzjeLicence, ZivotnoOsiguranje) \ 
            VALUES('%d', '0', '0', '0', '0', '0', '0', '-1')", PlayerInfo[playerid][SQLID]);
        mysql_tquery(SQL, q);
    }
    else 
    {
        cache_get_value_name_int(0, "NationalID", PlayerDocuments[playerid][pNationalID]);
        cache_get_value_name_int(0, "Passport", PlayerDocuments[playerid][pPassport]);
        cache_get_value_name_int(0, "VoziloLicence", PlayerDocuments[playerid][pDriveLicence]);
        cache_get_value_name_int(0, "MotoLicence", PlayerDocuments[playerid][pMotoLicence]);
        cache_get_value_name_int(0, "BrodLicence", PlayerDocuments[playerid][pBoatLicence]);
        cache_get_value_name_int(0, "OruzjeLicence", PlayerDocuments[playerid][pGunLicence]);
        cache_get_value_name_int(0, "ZivotnoOsiguranje", PlayerDocuments[playerid][pZivotnoOsiguranje]);
    }
}

forward ProveraOsiguranja(playerid);
public ProveraOsiguranja(playerid)
{
    new diff;
    cache_get_value_int(0, 0, diff);
    if(diff <= 0)
    {
        ImaZivotnoOsiguranje[playerid] = false;
        PlayerDocuments[playerid][pZivotnoOsiguranje] = -1;
        SendClientMessage(playerid, 0x32a88dFF, "[ZIVOTNO-OSIGURANJE] {ffffff}Vase zivotno osiguranje je isteklo.");
    }
    else
    {
        new date[24];
        cache_get_value_name(0, "ZivotnoTraje", date, 24);
        va_SendClientMessage(playerid, 0x32a88dFF, "[ZIVOTNO-OSIGURANJE] {ffffff}Vase zivotno osiguranje traje do datuma: %s.",date);
        ImaZivotnoOsiguranje[playerid] = true;
    }
    return 1;
}