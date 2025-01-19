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

enum E_PUNISHMENT_TYPE {

    PUNISHMENT_LTA,
    PUNISHMENT_SK,
    PUNISHMENT_RK,
    PUNISHMENT_DB,
    PUNISHMENT_NRPG,
    PUNISHMENT_TK,
    PUNISHMENT_RPS,
    PUNISHMENT_DTA,
    PUNISHMENT_BA,
    PUNISHMENT_DM
}

enum e_PLAYER_JAIL_DATA {

    characterID,
    jType,
    jTime,
    jBy[MAX_PLAYER_NAME],
    jDate[64]
}

new PlayerJail[MAX_PLAYERS][e_PLAYER_JAIL_DATA];

new Timer_UpdatePlayerJail[MAX_PLAYERS];

static PunishmentStrings[E_PUNISHMENT_TYPE][32] = {

    "Loging To Avoid",
    "Spawn Kill",
    "Revenge Kill",
    "Drive By",
    "Non RP(G)",
    "Team Kill",
    "Role Play Superman",
    "Death To Avoid",
    "Bug Abuse",
    "Deathmatch"
};

static const Float:RandomAlcatrazPositions[8][4] = {

    
    { -836.5029,2582.9778,3698.4119,268.3828 },
    { -834.6179,2576.5906,3698.4119,273.6678 },
    { -835.0894,2573.3840,3698.4119,271.8294 },
    { -835.4661,2564.1104,3698.4119,268.5471 },
    { -835.6248,2576.6118,3694.9370,266.4791 },
    { -835.3762,2573.4814,3694.9370,268.4818 },
    { -834.7186,2567.0630,3694.9370,268.6465 },
    { -836.2507,2563.3994,3694.9370,266.2832 }
};

//*==============================================================================
//*--->>> timers
//*==============================================================================


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

    SendClientMessage(playerid, x_ltorange, "#JAIL: "c_white"Vraceni ste u zatvor!");
    SendClientMessage(playerid, x_ltorange, "#JAIL: "c_white"Preostalo minuta : "c_server"%d", PlayerJail[playerid][jTime]);
    SendClientMessage(playerid, x_ltorange, "#JAIL: "c_white"Datum zatvaranja : "c_server"%s", PlayerJail[playerid][jDate]);
    SendClientMessage(playerid, x_ltorange, "#JAIL: "c_white"Zatvoren od strane : "c_server"%s", PlayerJail[playerid][jBy]);

    Timer_UpdatePlayerJail[playerid] = SetTimerEx("Alcatraz_UpdatePlayerTime", 1000 * 60, false, "d", playerid);

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

forward Alcatraz_UpdatePlayerTime(playerid);
public Alcatraz_UpdatePlayerTime(playerid) {

    if(PlayerJail[playerid][jTime] > 0) {

        PlayerJail[playerid][jTime]--;

        if(PlayerJail[playerid][jTime] == 0) {

            KillTimer(Timer_UpdatePlayerJail[playerid]);
            SetPlayerCompensatedPos(playerid, 1800.2910,-1577.4293,14.0625, 0, 0);
            SetCameraBehindPlayer(playerid);
            SendClientMessage(playerid, x_ltorange, "#JAIL: "c_white"Pusteni ste na slobodu, nastojite biti bolji gradjanin!");
            PlayerJail[playerid][jTime] = 0;
            PlayerJail[playerid][jType] = JAIL_TYPE_UNKNOWN;

            new q[128];
            mysql_format(SQL, q, sizeof q, "DELETE FROM `player_jails` WHERE `character_id` = '%d'", GetCharacterSQLID(playerid));
            mysql_tquery(SQL, q);

            static log_str[144];
            format(log_str, sizeof log_str, "JAIL | %s je pusten iz alcatraza! | ODSLUZENA KAZNA", ReturnPlayerName(playerid));
            mysql_write_log(log_str, LOG_TYPE_ANTICHEAT);
            return ~1;
        }

        KillTimer(Timer_UpdatePlayerJail[playerid]);
        GameTextForPlayer(playerid, "~g~PRESTOALO JOS : %d MINUTA", 1000, 3, PlayerJail[playerid][jTime]);
        Timer_UpdatePlayerJail[playerid] = SetTimerEx("Alcatraz_UpdatePlayerTime", 1000 * 60, false, "d", playerid);
        return ~1;
    }

    return (true);
}


YCMD:jail(playerid, params[], help) 
{

    if (GetPlayerStaffLevel(playerid)< e_HEAD_MANAGER)
		return notification.Show(playerid, "Greska", "Samo staff moze ovo!", "!", BOXCOLOR_RED);

	new targetid, type, time;

	if(sscanf(params, "udd", targetid, type, time)) return notification.Show(playerid, "KORISCENJE", "/jail [id] [type] [time]", "?", BOXCOLOR_BLUE);

	if(targetid == INVALID_PLAYER_ID) return notification.Show(playerid, "GRESKA", "Taj igrac nije na serveru", "!", BOXCOLOR_RED);
    
    if(!IsPlayerConnected(targetid))
        return SendServerMessage(playerid, "Taj igrac nije konektovan na server!");
    
    if(playerid == targetid)
        return SendServerMessage(playerid, "Ne mozes jail-at samog sebe!");

    if(PlayerJail[playerid][jTime] != 0)
        return SendServerMessage(playerid, "Taj igrac je vec zatvoren!");

    if(GetPlayerStaffLevel(targetid) > 0 )
        return SendServerMessage(playerid, "Ne mozete zatvorit igraca koji je dio staff team-a!");

    if(type != JAIL_TYPE_ALCATRAZ) return (true);

    new q[288];
    mysql_format(SQL, q, sizeof q, "INSERT INTO `player_jails` (`character_id`, `jailTime`, `jailType`, `jailedBy`, `jailDate`) VALUES \
                                    ('%d', '%d', '%d', '%e', NOW())", GetCharacterSQLID(targetid), time, type, ReturnPlayerName(playerid) );
    mysql_tquery(SQL, q);

    PlayerJail[targetid][jTime] = time;
    PlayerJail[targetid][jType] = type;

    new randPos = random( sizeof RandomAlcatrazPositions );

    SetPlayerCompensatedPos(targetid, RandomAlcatrazPositions[randPos][0], RandomAlcatrazPositions[randPos][1], RandomAlcatrazPositions[randPos][2], 0, 29);
    SetPlayerFacingAngle(targetid, RandomAlcatrazPositions[randPos][3]);

    SendClientMessageToAll(x_ltorange, "#JAIL: "c_white"Staff %s[%d] je zatvorio igraca %s[%d] na %d minuta.", ReturnCharacterName(playerid), playerid, ReturnCharacterName(targetid), targetid, time);
    SendClientMessage(targetid, x_ltorange, "#JAIL: "c_white"Staff %s[%d] vas je zatvorio na %d minuta!", ReturnCharacterName(playerid), playerid, time);

    Timer_UpdatePlayerJail[targetid] = SetTimerEx("Alcatraz_UpdatePlayerTime", 1000 * 60, false, "d", targetid);

    return 1;
}

YCMD:punishments(playerid, params[], help) 
{

    if (GetPlayerStaffLevel(playerid) < 2)
		return notification.Show(playerid, "Greska", "Samo staff moze ovo!", "!", BOXCOLOR_RED);

    static dlgStr[2248], sstr[248];

    for(new i = 0; i < sizeof PunishmentStrings; i++) {

        format(sstr, sizeof sstr, ""c_server"#%d \187; "c_white"%s", i+1, PunishmentStrings[  E_PUNISHMENT_TYPE:i ]);
        strcat(dlgStr, sstr);
    }

    Dialog_Show(playerid, "_noReturn", DIALOG_STYLE_MSGBOX, "Punishments", dlgStr, "Ok", "");

    return 1;
}

YCMD:punish(playerid, params[], help) {

    if (GetPlayerStaffLevel(playerid) < 2)
		return notification.Show(playerid, "Greska", "Samo staff moze ovo!", "!", BOXCOLOR_RED);

	new targetid, E_PUNISHMENT_TYPE:type, time;
	if(sscanf(params, "udd", targetid, _:type, time)) return notification.Show(playerid, "KORISCENJE", "/punish [id] [type]", "?", BOXCOLOR_BLUE);



    return 1;
}