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
 *  @Date           27th Dec 2024
 *  @Weburl         weburl
 *  @Project        maryland_project
 *
 *  @File           lastpos.pwn
 *  @Module         modules
 */

#include <ysilib\YSI_Coding\y_hooks>

hook OnGameModeInit()
{
	print("misc/lastpos.pwn loaded");


    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnCharacterLoaded(playerid)
{
    if(IsPlayerJailed(playerid) == 0)
    {
        new query[256];
        mysql_format(SQL, query, sizeof(query), "SELECT cLastX, cLastY, cLastZ FROM `characters` WHERE `character_id` = '%d'", GetCharacterSQLID(playerid));
        mysql_tquery(SQL, query, "OnCharacterPositionLoaded", "i", playerid);
    }
}

forward OnCharacterPositionLoaded(playerid);
public OnCharacterPositionLoaded(playerid)
{
    new rows = cache_num_rows();

    if(!rows) return (true);

    cache_get_value_name_float(0, "cLastX", CharacterInfo[playerid][lastPos][0]);
    cache_get_value_name_float(0, "cLastY", CharacterInfo[playerid][lastPos][1]);
    cache_get_value_name_float(0, "cLastZ", CharacterInfo[playerid][lastPos][2]);

    SetPlayerPos(playerid, CharacterInfo[playerid][lastPos][0], CharacterInfo[playerid][lastPos][1], CharacterInfo[playerid][lastPos][2]);

    SendClientMessage(playerid, x_server, "maryland \187; "c_white"Vracen si na poziciju sa koje si izasao.");

    return (true);
}

hook OnPlayerDisconnect(playerid, reason)
{
    if(IsPlayerJailed(playerid) == 0)
    {
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);

        new query[456];
        mysql_format(SQL, query, sizeof(query),
            "UPDATE `characters` SET `cLastX` = '%f', `cLastY` = '%f', `cLastZ` = '%f' WHERE `character_id` = '%d'", x, y, z, GetCharacterSQLID(playerid));
        mysql_tquery(SQL, query);
        printf("DEBUG: Pozicija igra?a %d uspešno sa?uvana (%f, %f, %f)", GetCharacterSQLID(playerid), x, y, z);
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}
