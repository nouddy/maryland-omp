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
    v_FACTION_TYPE:fvFactionType
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


forward mysql_LoadFactionVehicles();
public mysql_LoadFactionVehicles() {

    new iRows = cache_num_rows();
    if(!iRows) return (true);

    for(new i = 0; i < rows; i++) {

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

        FVehicle[i] = CreateVehicle(FactionVehicle[i][fvModel], FactionVehicle[i][fvSpawn][0], FactionVehicle[i][fvSpawn][1], FactionVehicle[i][fvSpawn][2]. FactionVehicle[i][fvSpawn][3], 
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

        if(IsValidVehicle(FVehicle[i])) {

            if(FactionMember[playerid][factionID] != FactionVehicle[i][factionID]) {

                ClearAnimations(playerid);
                return Y_HOOKS_BREAK_RETURN_1;
            }
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}