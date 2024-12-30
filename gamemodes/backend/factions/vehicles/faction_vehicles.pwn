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
 *  @Author         Nodi
 *  @Github         (github.com/vosticdev) & (github.com/nouddy)
 *  @Date           01 Nov 2024
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           faction_vehicles.pwn
 *  @Module         factions/vehicles
*/


#include <ysilib\YSI_Coding\y_hooks>

//*==============================================================================
//?--->>> Begining
//*==============================================================================

const MAX_FACTION_VEHICLES  = 500;

enum v_FACTION_TYPE {

    FACTION_TYPE_INVALID,
    FACTION_TYPE_ILLEGAL,
    FACTION_TYPE_STATE
}

enum e_FACTION_VEHICLES {

    fvID,
    fvFaction,
    v_FACTION_TYPE:fvFactionType,
    fvModel,
    Float:fvSpawn[4],
    fvColor[2]
}

new FactionVehicle[MAX_FACTION_VEHICLES][e_FACTION_VEHICLES],
    Iterator:iter_FVehicles<MAX_FACTION_VEHICLES>,
    FVehicle[MAX_FACTION_VEHICLES];

//*==============================================================================
//?--->>> Querys n funcs
//*==============================================================================

forward Faction_CreateVehicle(id);
public Faction_CreateVehicle(id) {

    FactionVehicle[id][fvID] = cache_insert_id();

    FVehicle[id] = CreateVehicle(FactionVehicle[id][fvModel], FactionVehicle[id][fvSpawn][0], FactionVehicle[id][fvSpawn][1], FactionVehicle[id][fvSpawn][2], FactionVehicle[id][fvSpawn][3], 
                      FactionVehicle[id][fvColor][0], FactionVehicle[id][fvColor][1], 15000);

    Iter_Add(iter_FVehicles, id);

    return (true);
}

forward mysql_LoadFactionVehicles();
public mysql_LoadFactionVehicles() {

    new iRows = cache_num_rows();
    if(!iRows) return (true);

    for(new i = 0; i < iRows; i++) {

        cache_get_value_name_int(i, "ID", FactionVehicle[i][fvID]);
        cache_get_value_name_int(i, "factionID", FactionVehicle[i][fvFaction]);
        cache_get_value_name_int(i, "factionType", FactionVehicle[i][fvFactionType]);
        cache_get_value_name_int(i, "fvModel", FactionVehicle[i][fvModel]);

        cache_get_value_name_float(i, "X", FactionVehicle[i][fvSpawn][0]);
        cache_get_value_name_float(i, "Y", FactionVehicle[i][fvSpawn][1]);
        cache_get_value_name_float(i, "Z", FactionVehicle[i][fvSpawn][2]);
        cache_get_value_name_float(i, "A", FactionVehicle[i][fvSpawn][3]);

        cache_get_value_name_int(i, "fvColor1", FactionVehicle[i][fvColor][0]);
        cache_get_value_name_int(i, "fvColor2", FactionVehicle[i][fvColor][1]);

        FVehicle[i] = CreateVehicle(FactionVehicle[i][fvModel], FactionVehicle[i][fvSpawn][0], FactionVehicle[i][fvSpawn][1], FactionVehicle[i][fvSpawn][2], FactionVehicle[i][fvSpawn][3], 
                      FactionVehicle[i][fvColor][0], FactionVehicle[i][fvColor][1], 15000);

        Iter_Add(iter_FVehicles, i);
    }

    printf("[SQL]  :  Ucitano %d organizacijskih vozila", Iter_Count(iter_FVehicles));
    return (true);

}

//*==============================================================================
//?--->>> Hooks
//*==============================================================================

hook OnGameModeInit() {

    mysql_tquery(SQL, "SELECT * FROM `faction_vehicles`", "mysql_LoadFactionVehicles");

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger) {

    for(new i = 0; i < sizeof FVehicle; i++) {

        if(vehicleid == FVehicle[i]) {
            
            if(FactionVehicle[i][fvFactionType] == FACTION_TYPE_ILLEGAL) {
                
                if(FactionMember[playerid][factionID] != FactionVehicle[i][fvFaction]) {

                    ClearAnimations(playerid);
                    return Y_HOOKS_BREAK_RETURN_1;
                }
            }

            if(FactionVehicle[i][fvFactionType] == FACTION_TYPE_STATE) {

                if(PoliceMember[playerid][policeID] != FactionVehicle[i][fvFaction]) {

                    ClearAnimations(playerid);
                    return Y_HOOKS_BREAK_RETURN_1;
                }
            }
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

YCMD:createfv(playerid, params[], help) {

    if(!IsPlayerAdmin(playerid))
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Samo RCON Admini!");

    new fID, model, color, v_FACTION_TYPE:ftype;
    
    if(sscanf(params, "dddd", fID, model, color, ftype))
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"/createfv <Faction> <Model> <Color> <Faction Type>");

    new bool:factionFound = false;

    if(ftype == FACTION_TYPE_ILLEGAL) {

        foreach(new i : iter_Factions) {

            if(FactionInfo[i][factionID] == fID)
            {
                factionFound = true; break;
            }
        }
    }

    else {

        foreach(new j : iter_Police) {

            if(fPoliceInfo[j][fPoliceID] == fID)
            {
                factionFound = true; break;
            }
        }
    }

    if(!factionFound)
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Ta organizacija ne postoji!");

    if(400 > model > 611)
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Pogresan model vozila!");

    new xID = Iter_Free(iter_FVehicles);

    new Float:pPos[4];
    GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
    GetPlayerFacingAngle(playerid, pPos[3]);

    FactionVehicle[xID][fvFaction] = fID;
    FactionVehicle[xID][fvModel] = model;

    FactionVehicle[xID][fvSpawn][0] = pPos[0];
    FactionVehicle[xID][fvSpawn][1] = pPos[1];
    FactionVehicle[xID][fvSpawn][2] = pPos[2];
    FactionVehicle[xID][fvSpawn][3] = pPos[3];
    
    FactionVehicle[xID][fvColor][0] = color;
    FactionVehicle[xID][fvColor][1] = color;

    FactionVehicle[xID][fvFactionType] = ftype;
    
    new q[428];
    mysql_format(SQL, q, sizeof q, "INSERT INTO `faction_vehicles` (`factionID`, `factionType`, `fvModel`, `X`, `Y`, `Z`, `A`, `fvColor1`, `fvColor2`) \
                                   VALUES ('%d', '%d', '%d', '%f', '%f', '%f', '%f', '%d', '%d')", 
                                   fID, ftype, model, pPos[0], pPos[1], pPos[2], pPos[3], color, color);
    mysql_tquery(SQL, q, "Faction_CreateVehicle", "d", xID);

    return (true);
}

/*

*        cache_get_value_name_int(i, "ID", FactionVehicle[i][fvID]);
*        cache_get_value_name_int(i, "factionID", FactionVehicle[i][fvFaction]);
*        cache_get_value_name_int(i, "factionType", FactionVehicle[i][fvFactionType]);
*        cache_get_value_name_int(i, "fvModel", FactionVehicle[i][fvModel]);
*
*        cache_get_value_name_float(i, "X", FactionVehicle[i][fvSpawn][0]);
*        cache_get_value_name_float(i, "Y", FactionVehicle[i][fvSpawn][1]);
*        cache_get_value_name_float(i, "Z", FactionVehicle[i][fvSpawn][2]);
*        cache_get_value_name_float(i, "A", FactionVehicle[i][fvSpawn][3]);
*
*        cache_get_value_name_int(i, "fvColor1", FactionVehicle[i][fvColor][0]);
*        cache_get_value_name_int(i, "fvColor2", FactionVehicle[i][fvColor][1]);

*/