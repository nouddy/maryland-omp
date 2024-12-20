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
    if(!IsPlayerJailed(playerid))
    {
        new query[256];
        mysql_format(SQL, query, sizeof(query), "SELECT cLastX, cLastY, cLastZ, cVW, cInt FROM `characters` WHERE `character_id` = '%d'", GetCharacterSQLID(playerid));
        mysql_tquery(SQL, query, "OnCharacterPositionLoaded", "i", playerid);
    }
}

forward OnCharacterPositionLoaded(playerid);
public OnCharacterPositionLoaded(playerid)
{
    new rows = cache_num_rows();
    new cVW, cInt;

    if(!rows) return (true);

    cache_get_value_name_float(0, "cLastX", CharacterInfo[playerid][lastPos][0]);
    cache_get_value_name_float(0, "cLastY", CharacterInfo[playerid][lastPos][1]);
    cache_get_value_name_float(0, "cLastZ", CharacterInfo[playerid][lastPos][2]);
    cache_get_value_name_int(0, "cVW", cVW);
    cache_get_value_name_int(0, "cInt", cInt);

    SetPlayerCompensatedPos(playerid, CharacterInfo[playerid][lastPos][0], CharacterInfo[playerid][lastPos][1], CharacterInfo[playerid][lastPos][2], cVW, cInt);

    FreezePlayerForMapLoading(playerid);

    SendClientMessage(playerid, x_server, "maryland \187; "c_white"Vracen si na poziciju sa koje si izasao.");

    return (true);
}

stock FreezePlayerForMapLoading(playerid)
{
    TogglePlayerControllable(playerid, false);

    notification.Show(playerid, "Info", "Ucitavanje objekata molim vas sacekajte.", "?", BOXCOLOR_BLUE);

    SetTimerEx("UnfreezePlayer", 4500, false, "i", playerid);
}

forward UnfreezePlayer(playerid);
public UnfreezePlayer(playerid)
{
    TogglePlayerControllable(playerid, true); 
    notification.Show(playerid, "Success", "Uspesno ocitana mapa!", "!", BOXCOLOR_GREEN);
}
