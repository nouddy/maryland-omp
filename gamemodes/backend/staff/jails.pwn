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
 *  @Author         Vostic & Nodi
 *  @Date           05th May 2023
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           spanel.script
 *  @Module         staff
 */

 #include <ysilib\YSI_Coding\y_hooks>

//*==============================================================================
//*--->>> vars
//*==============================================================================

enum  {

    JAIL_TYPE_UNKNOWN,
    JAIL_TYPE_ALCATRAZ,
    JAIL_TYPE_COMMUNITY_SERVICE
}

enum {

    PUNISHMENT_NONE,
    PUNISHMENT_LTA
}

enum e_PLAYER_JAIL_DATA {

    characterID,
    jType,
    jTime,
    jBy[MAX_PLAYER_NAME],
    jDate[64]
}

new PlayerJail[MAX_PLAYERS][e_PLAYER_JAIL_DATA];

//*==============================================================================
//*--->>> timers
//*==============================================================================

forward jail_UpdatePlayerTime(playerid);
public jail_UpdatePlayerTime(playerid) {

    if(IsPlayerJailed(playerid)) {

        if(PlayerJail[playerid][jTime] > 1) {

            PlayerJail[playerid][jTime]--;
            GameTextForPlayer(playerid, "~w~PRESTALO VRIJEME : ~y~%d ~w~MINUTA", 60*1000, 3);
            SetTimerEx("jail_UpdatePlayerTime", 60 * 1000, false, "d", playerid);
            return (true);
        }

        if(PlayerJail[playerid][jTime] <= 0) {
            
            PlayerJail[playerid][jTime] = 0;
            PlayerJail[playerid][jType] = JAIL_TYPE_UNKNOWN;

            new q[128];
            mysql_format(SQL, q, sizeof q, "DELETE FROM `player_jails` WHERE `character_id` = '%d'", GetCharacterSQLID(playerid));
            mysql_tquery(SQL, q);

            static log_str[144];
            format(log_str, sizeof log_str, "JAIL | %s je pusten iz jaila! | ODSLUZENA KAZNA", ReturnPlayerName(playerid));
            mysql_write_log(log_str, LOG_TYPE_ANTICHEAT);

            SetPlayerPos(playerid, 1799.1263,-1577.9620,14.0765);
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);

            return (true);
        }
    }

    return (true);
}

//*==============================================================================
//*--->>> functions
//*==============================================================================

forward mysql_LoadPlayerJail(playerid);
public mysql_LoadPlayerJail(playerid) {

    new rows = cache_num_rows();

    if(!rows) return (true);

    cache_get_value_name_int(0, "jailType", PlayerJail[playerid][jType]);
    cache_get_value_name_int(0, "jailTime", PlayerJail[playerid][jTime]);

    cache_get_value_name(0, "jailedBy", PlayerJail[playerid][jBy], MAX_PLAYER_NAME);
    cache_get_value_name(0, "jailDate", PlayerJail[playerid][jDate], MAX_PLAYER_NAME);

    SendClientMessage(playerid, x_red, "jail \187; "c_white"Vraceni ste u zatvor!");
    SendClientMessage(playerid, x_red, "jail \187; "c_white"Preostalo minuta : "c_server"%d", PlayerJail[playerid][jTime]);
    SendClientMessage(playerid, x_red, "jail \187; "c_white"Datum zatvaranja : "c_server"%s", PlayerJail[playerid][jDate]);
    SendClientMessage(playerid, x_red, "jail \187; "c_white"Zatvoren od strane : "c_server"%s", PlayerJail[playerid][jBy]);

    SetTimerEx("jail_UpdatePlayerTime", 60 * 1000, false, "d", playerid);

    return (true);
}

stock IsPlayerJailed(playerid) {

    if(PlayerJail[playerid][jTime] != 0)
        return (true);

    return false;
}

//*==============================================================================
//*--->>> hooks
//*==============================================================================

hook OnCharacterLoaded(playerid) {

    new q[128];
    mysql_format(SQL, q, sizeof q, "SELECT * FROM `player_jails` WHERE `character_id` = '%d'", GetCharacterSQLID(playerid));
    mysql_tquery(SQL, q, "mysql_LoadPlayerJail", "d", playerid);

    return Y_HOOKS_CONTINUE_RETURN_1;
}

//*==============================================================================
//*--->>> commands
//*==============================================================================

//*Jebem ti mikrovalnu, jebem ti dnevni boravak, gle sad ovo ono pajsad

YCMD:jail(playerid, params[], help) 
{

    if (GetPlayerStaffLevel(playerid)< e_HEAD_MANAGER)
		return notification.Show(playerid, "Greska", "Samo staff moze ovo!", "!", BOXCOLOR_RED);

	new targetid, type, time;

	if(sscanf(params, "udd", targetid, type, time)) return notification.Show(playerid, "KORISCENJE", "/jail [id] [type] [time]", "?", BOXCOLOR_BLUE);

	if(targetid == INVALID_PLAYER_ID) return notification.Show(playerid, "GRESKA", "Taj igrac nije na serveru", "!", BOXCOLOR_RED);
    
    if(type != JAIL_TYPE_ALCATRAZ) return (true);

    new q[288];
    mysql_format(SQL, q, sizeof q, "INSERT INTO `player_jails` (`character_id`, `jailTime`, `jailType`, `jailedBy`, `jailDate`) VALUES \
                                    ('%d', '%d', '%d', '%e', NOW())", GetCharacterSQLID(targetid), time, type, ReturnPlayerName(playerid) );
    mysql_tquery(SQL, q);

    PlayerJail[playerid][jTime] = time;
    PlayerJail[playerid][jType] = type;

    SendClientMessage(playerid, -1, "DEBUG: Aj z!");

    return 1;
}