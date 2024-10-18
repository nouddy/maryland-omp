/*
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
 *  @Date           13th Oct 2024
 *  @Weburl         weburl
 *  @Project        maryland_project
 *
 *  @File           jewlery.pwn
 *  @Module         script
 *  @Todo:          Make jewlery system.
 */

 #include <ysilib\YSI_Coding\y_hooks>

enum E_JEWLERY {
    
    e_Gold
}

new CharacterJewlery[MAX_PLAYERS][E_JEWLERY];

 hook OnGameModeInit() {

    print("finance/jewlery.pwn loaded");

    CreateCustomMarker(""c_server"[ Sergio's Jewlery ]\n"c_server"» "c_white"'Za ulaz pritisnite 'F'", 1722.1115,-1635.9326,20.2128,  0, 0, 50.0); //ulaz
    CreateCustomMarker(""c_server"[ Sergio's Jewlery ]\n"c_server"» "c_white"'Za izlaz pritisnite 'F'", 1369.3322,1943.2694,-16.1860,  21, 0, 50.0); //izlaz

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnCharacterLoaded(playerid)
{   
    new q[267];
    mysql_format(SQL, q, sizeof(q), "SELECT * FROM player_jewlery WHERE character_id = '%d'", GetCharacterSQLID(playerid));
    mysql_tquery(SQL, q, "SQL_JewleryLoad", "i", playerid);

	return 1;
}

forward SQL_JewleryLoad(playerid);
public SQL_JewleryLoad(playerid)
{
    static rows;
    cache_get_row_count(rows);
    if(!rows) 
    {
        new q[300];
        mysql_format(SQL, q, sizeof(q), 
           "INSERT INTO `player_jewlery` (character_id, Gold) \ 
            VALUES('%d', '0')", GetCharacterSQLID(playerid));
        mysql_tquery(SQL, q);
    }
    else 
    {
        cache_get_value_name_int(0, "Gold", CharacterJewlery[playerid][e_Gold]);
    }
}


hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys) {

    if(newkeys & KEY_SECONDARY_ATTACK) {

        if(IsPlayerInRangeOfPoint(playerid, 3.50, 1722.1115,-1635.9326,20.2128) && GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0) {

            SetPlayerPos(playerid, 1369.3322,1943.2694,-16.1860);
            SetPlayerInterior(playerid, 21);
            SetCameraBehindPlayer(playerid);
        }
        else if(IsPlayerInRangeOfPoint(playerid, 3.50, 1369.3322,1943.2694,-16.1860) && GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 21) {

            SetPlayerPos(playerid, 1722.1115,-1635.9326,20.2128);
            SetPlayerInterior(playerid, 0);
            SetPlayerVirtualWorld(playerid, 0);
            SetCameraBehindPlayer(playerid);
        }
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}


//* Jewlery save
stock SaveCharacterJewlery(playerid)
{
    if(pConnectState[playerid] == PLAYER_CONNECT_STATE_SPAWNED)
    {
        new query[500];
        mysql_format(SQL,query,sizeof(query),"UPDATE `player_jewlery` SET `Gold` = '%d' WHERE `character_id` = '%d'",
            CharacterJewlery[playerid][e_Gold],
            GetCharacterSQLID(playerid));
        mysql_tquery(SQL,query);      
    }

    return true;
}