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
 *  @Date           27th Dec 2024
 *  @Weburl         weburl
 *  @Project        maryland_project
 *
 *  @File           player-spawn.pwn
 *  @Module         misc

*/

#include <ysilib\YSI_Coding\y_hooks>

enum eSpawnType {

    SPAWN_TYPE_UNKNOWN,
    SPAWN_TYPE_MARKET_STATION,
    SPAWN_TYPE_LASTPOS,
    SPAWN_TYPE_HOUSE,
    SPAWN_TYPE_HOTEL,
    SPAWN_TYPE_FACTION,
    SPAWN_TYPE_APARTMENT
}

static const sz_SpawnNames[][32] = {

    "Unknown",
    "Market Station",
    "Zadnja Pozicija",
    "Kuca",
    "Hotelska Soba",
    "Organizacija",
    "Stan / Apartman"
};

new eSpawnType:PlayerSpawn[MAX_PLAYERS];

forward mysql_LoadSpawnType(playerid);
public mysql_LoadSpawnType(playerid) {

    new iRows = cache_num_rows();

    if(!iRows) {

        PlayerSpawn[playerid] = SPAWN_TYPE_LASTPOS;

        new q[128];
        mysql_format(SQL, q, sizeof q, "INSERT INTO `character_spawns` (`character_id`) VALUES ('%d')", GetCharacterSQLID(playerid));
        mysql_tquery(SQL, q);

        return (true);
    }

    cache_get_value_name_int(0, "spawnType", PlayerSpawn[playerid]);

    if(!IsPlayerJailed(playerid))
    {   
        if(PlayerSpawn[playerid] == SPAWN_TYPE_LASTPOS) {

            new query[256];
            mysql_format(SQL, query, sizeof(query), "SELECT cLastX, cLastY, cLastZ, cVW, cInt FROM `characters` WHERE `character_id` = '%d'", GetCharacterSQLID(playerid));
            mysql_tquery(SQL, query, "OnCharacterPositionLoaded", "i", playerid);
        }

        if(PlayerSpawn[playerid] == SPAWN_TYPE_MARKET_STATION) {

            SetPlayerCompensatedPos(playerid, 1401.7791,1591.3466,12.0481, 6, 6);
        }

        if(PlayerSpawn[playerid] == SPAWN_TYPE_HOUSE) {

            foreach(new i : iHouse) {

                if(player_House[playerid] == house_ID[i]) {

                    SetPlayerCompensatedPos(playerid, house_Exit[i][0], house_Exit[i][1], house_Exit[i][2], house_ID[i], house_Int[i]);
                    break;
                }
            }
        }
        if(PlayerSpawn[playerid] == SPAWN_TYPE_HOTEL) {

            SetPlayerCompensatedPos(playerid, 1802.7803,-1300.5082,54.9062, 7, 0);
        }
    }

    return (true);
}

hook OnCharacterLoaded(playerid)
{

    new q[128];
    mysql_format(SQL, q, sizeof q, "SELECT * FROM `character_spawns` WHERE `character_id` = '%d'", GetCharacterSQLID(playerid));
    mysql_tquery(SQL, q, "mysql_LoadSpawnType", "d", playerid);

    return Y_HOOKS_CONTINUE_RETURN_1;
}

YCMD:changespawn(playerid, params[], help) {

    Dialog_Show(playerid, "dialog_changeSpawn", DIALOG_STYLE_LIST, 
        c_server"Maryland \187; "c_white"Change Spawn", 
        c_server"#1 \187; "c_white"Market Station\n"\
        c_server"#2 \187; "c_white"Zadnja Pozicija\n"\
        c_server"#3 \187; "c_white"Kuca\n"\
        c_server"#4 \187; "c_white"Hotel",
        "Odaberi", "Odustani");

    return 1;
}

Dialog:dialog_changeSpawn(const playerid, response, listitem, string:inputtext[]) {


    new eSpawnType:idx = eSpawnType:( listitem + 1 );
    
    if(idx == SPAWN_TYPE_HOUSE) {

        if(player_House[playerid] == -1)
            return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Ne posjedujete kucu!");
    }
    

    if(idx == SPAWN_TYPE_HOTEL) {

        if(PlayerProperty[playerid][HotelRoom] == 0.00)
            return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Ne iznajmljivate hotelsku sobu!");
    }

    PlayerSpawn[playerid] = idx;

    new q[128];
    mysql_format(SQL, q, sizeof q, "UPDATE `character_spawns` SET `spawnType` = '%d' WHERE `character_id` = '%d'", PlayerSpawn[playerid], GetCharacterSQLID(playerid));
    mysql_tquery(SQL, q);

    SendClientMessage(playerid, x_server, "maryland \187; "c_white"Promjenili ste spawn  "c_server"[ %s ]", sz_SpawnNames[ ( _:idx ) ]);
    return (true);
}