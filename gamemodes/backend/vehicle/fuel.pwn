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
 *  @Author         Vostic & Ogy_
 *  @Date           05th May 2023
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           fuel.script
 *  @Module         vehicle
 */

#include <ysilib\YSI_Coding\y_hooks>

// * 73 - Skin ID for petrol guy

new bool:fuel_IsActive[MAX_PLAYERS],
    fuel_Timer[MAX_PLAYERS],
    fuel_Counter[MAX_PLAYERS],
    fuelingVehicle[MAX_PLAYERS],
    nearestPump[MAX_PLAYERS];


#define MAX_FUEL_PUMPS          (60)

enum {

    PUMP_FUEL_TYPE_DIESEL = 1,
    PUMP_FUEL_TYPE_PETROL = 2,
    PUMP_FUEL_TYPE_ELECTRIC = 3,
    PUMP_FUEL_TYPE_METANE
}

enum E_FUEL_PUMP_DATA {

    pumpID,
    pumpBusinessID,
    pumpFuel,
    pumpFuelType,

    Float:pumpLocation[3]
}

new ePumpInfo[MAX_FUEL_PUMPS][E_FUEL_PUMP_DATA],
    Iterator:pumpIterator<MAX_FUEL_PUMPS>,
    Text3D:pumpLabel[MAX_FUEL_PUMPS],
    pumpPickup[MAX_FUEL_PUMPS];

new PlayerText:Fuel_UI[MAX_PLAYERS][4];

stock GetNearestPump(playerid) {

    foreach(new j : pumpIterator) {

        if(IsPlayerInRangeOfPoint(playerid, 3.0, ePumpInfo[j][pumpLocation][0], ePumpInfo[j][pumpLocation][1], ePumpInfo[j][pumpLocation][2])) return j;
    }

    return (-1);
}

stock GetFuelPumpType(id) {

    new type[24];

    switch(id) {

        case PUMP_FUEL_TYPE_DIESEL: { type = "Dizel"; }
        case PUMP_FUEL_TYPE_PETROL: { type = "Benzin"; }
        case PUMP_FUEL_TYPE_ELECTRIC: { type = "Punjac"; }
        case PUMP_FUEL_TYPE_METANE: { type = "Metan"; }
        default: { type = "Undefined";}
    }

    return type;
}

forward Pump_LoadData();
public Pump_LoadData() {

    new rows = cache_num_rows();

    if(!rows) return print("PUMPS > Nema kreiranih pumpi.");

    else {

        for(new j = 0; j < rows; j++) {

            cache_get_value_name_int(j, "pumpID", ePumpInfo[j][pumpID]);
            cache_get_value_name_int(j, "pumpBusinessID", ePumpInfo[j][pumpBusinessID]);
            cache_get_value_name_int(j, "pumpFuel", ePumpInfo[j][pumpFuel]);
            cache_get_value_name_int(j, "pumpFuelType", ePumpInfo[j][pumpFuelType]);

            cache_get_value_name_float(j, "pump_X", ePumpInfo[j][pumpLocation][0]);
            cache_get_value_name_float(j, "pump_Y", ePumpInfo[j][pumpLocation][1]);
            cache_get_value_name_float(j, "pump_Z", ePumpInfo[j][pumpLocation][2]);

            new pumpString[290]; 
            format(pumpString, sizeof pumpString, ""c_server"\187; "c_white"Pumpa [%d] "c_server"\171; \n \187; "c_white"Tip : %s"c_server"\171; \n \187; "c_white"Za tankanje /fuel "c_server"\171;", ePumpInfo[j][pumpID], GetFuelPumpType(ePumpInfo[j][pumpFuelType]));

            pumpPickup[j] = CreatePickup(1650, 1, ePumpInfo[j][pumpLocation][0], ePumpInfo[j][pumpLocation][1], ePumpInfo[j][pumpLocation][2]);
            pumpLabel[j] = Create3DTextLabel(pumpString, -1, ePumpInfo[j][pumpLocation][0], ePumpInfo[j][pumpLocation][1], ePumpInfo[j][pumpLocation][2], 3.50, 0);

            Iter_Add(pumpIterator, j);
        }
    }

    return (true);
}

forward Pump_InsertData(id);
public Pump_InsertData(id) {

    ePumpInfo[id][pumpID] = cache_insert_id();

    new pumpString[290]; 
    format(pumpString, sizeof pumpString, ""c_server"\187; "c_white"Pumpa [%d] "c_server"\171; \n \187; "c_white"Tip : %s"c_server"\171; \n \187; "c_white"Za tankanje /fuel "c_server"\171;", ePumpInfo[id][pumpID], GetFuelPumpType(ePumpInfo[id][pumpFuelType]));

    pumpPickup[id] = CreatePickup(1650, 1, ePumpInfo[id][pumpLocation][0], ePumpInfo[id][pumpLocation][1], ePumpInfo[id][pumpLocation][2]);
    pumpLabel[id] = Create3DTextLabel(pumpString, -1, ePumpInfo[id][pumpLocation][0], ePumpInfo[id][pumpLocation][1], ePumpInfo[id][pumpLocation][2], 3.50, 0);

    Iter_Add(pumpIterator, id);

    return (true);
}


forward fuel_StartFueling(playerid);
public fuel_StartFueling(playerid) {


    if( (GetPlayerMoney(playerid) - 3) == 0) {

        KillTimer(fuel_Timer[playerid]);   
        Fuel_ShowInterface(playerid, false);
        SendClientMessage(playerid, x_server, "FUEL > "c_white"Nemate vise novca, napunjeno %dL", GetVehicleFuel(fuelingVehicle[playerid]));
        
        fuel_Counter[playerid] = 0;
        KillTimer(fuel_Timer[playerid]);
        fuelingVehicle[playerid] = INVALID_VEHICLE_ID;

        return ~1;
    }

    if(GetVehicleFuel(fuelingVehicle[playerid]) == 100 ) {

        KillTimer(fuel_Timer[playerid]);   
        Fuel_ShowInterface(playerid, false);
        vehicleFuel[fuelingVehicle[playerid]] = 100;
        SendClientMessage(playerid, x_server, "FUEL > "c_white"Napunjeno 100L");
        fuelingVehicle[playerid] = INVALID_VEHICLE_ID;
        return ~1;
    }
    else {

        ePumpInfo[nearestPump[playerid]][pumpFuel]--;

        fuel_Counter[playerid]++;
        vehicleFuel[fuelingVehicle[playerid]]++;
        PlayerTextDrawTextSize(playerid, Fuel_UI[playerid][0], 5.000000, fuel_Counter[playerid]);
        PlayerTextDrawShow(playerid,  Fuel_UI[playerid][0]);

        GivePlayerMoney2(playerid, -3);

        new sipano = fuel_Counter[playerid];
        PlayerTextDrawSetString(playerid, Fuel_UI[playerid][3], "sipano:_%dL", sipano);

    }

    return (false);
}

stock Fuel_ShowInterface(playerid, const bool:option) {

    if(option) {

        for(new i = 0; i < sizeof Fuel_UI[]; i++) {

            if(Fuel_UI[playerid][i] == INVALID_PLAYER_TEXT_DRAW) continue;

            PlayerTextDrawDestroy(playerid,Fuel_UI[playerid][i]);
            Fuel_UI[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
        }

        Fuel_UI[playerid][0] = CreatePlayerTextDraw(playerid, 114.532798, 373.551055, "LD_SPAC:white");
        PlayerTextDrawTextSize(playerid, Fuel_UI[playerid][0], 5.000000, 0.000000);
        PlayerTextDrawAlignment(playerid, Fuel_UI[playerid][0], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Fuel_UI[playerid][0], -1);
        PlayerTextDrawSetShadow(playerid, Fuel_UI[playerid][0], 0);
        PlayerTextDrawBackgroundColour(playerid, Fuel_UI[playerid][0], 255);
        PlayerTextDrawFont(playerid, Fuel_UI[playerid][0], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Fuel_UI[playerid][0], false);

        Fuel_UI[playerid][1] = CreatePlayerTextDraw(playerid, 122.333381, 422.711212, "trenutno_sipas_gorivo..");
        PlayerTextDrawLetterSize(playerid, Fuel_UI[playerid][1], 0.115666, 0.517333);
        PlayerTextDrawAlignment(playerid, Fuel_UI[playerid][1], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Fuel_UI[playerid][1], -1);
        PlayerTextDrawSetShadow(playerid, Fuel_UI[playerid][1], 0);
        PlayerTextDrawBackgroundColour(playerid, Fuel_UI[playerid][1], 255);
        PlayerTextDrawFont(playerid, Fuel_UI[playerid][1], TEXT_DRAW_FONT_2);
        PlayerTextDrawSetProportional(playerid, Fuel_UI[playerid][1], true);

        Fuel_UI[playerid][2] = CreatePlayerTextDraw(playerid, 123.000053, 415.244537, "cena:_3$");
        PlayerTextDrawLetterSize(playerid, Fuel_UI[playerid][2], 0.115666, 0.517333);
        PlayerTextDrawAlignment(playerid, Fuel_UI[playerid][2], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Fuel_UI[playerid][2], -1);
        PlayerTextDrawSetShadow(playerid, Fuel_UI[playerid][2], 0);
        PlayerTextDrawBackgroundColour(playerid, Fuel_UI[playerid][2], 255);
        PlayerTextDrawFont(playerid, Fuel_UI[playerid][2], TEXT_DRAW_FONT_2);
        PlayerTextDrawSetProportional(playerid, Fuel_UI[playerid][2], true);

        Fuel_UI[playerid][3] = CreatePlayerTextDraw(playerid, 123.000053, 407.844085, "sipano:_0L");
        PlayerTextDrawLetterSize(playerid, Fuel_UI[playerid][3], 0.115666, 0.517333);
        PlayerTextDrawAlignment(playerid, Fuel_UI[playerid][3], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Fuel_UI[playerid][3], -1);
        PlayerTextDrawSetShadow(playerid, Fuel_UI[playerid][3], 0);
        PlayerTextDrawBackgroundColour(playerid, Fuel_UI[playerid][3], 255);
        PlayerTextDrawFont(playerid, Fuel_UI[playerid][3], TEXT_DRAW_FONT_2);
        PlayerTextDrawSetProportional(playerid, Fuel_UI[playerid][3], true);

        for(new i = 0; i < sizeof Fuel_UI[]; i++) {

            PlayerTextDrawShow(playerid, Fuel_UI[playerid][i]);
        }
    }

    else {

        for(new i = 0; i < sizeof Fuel_UI[]; i++) {

            if(Fuel_UI[playerid][i] == INVALID_PLAYER_TEXT_DRAW) continue;

            PlayerTextDrawDestroy(playerid,Fuel_UI[playerid][i]);
            Fuel_UI[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
        }
    }
    return (true);
}

hook OnGameModeInit()
{
    print("backend/vehicle/fuel.pwn loaded");

    mysql_tquery(SQL, "SELECT * FROM `pumps`", "Pump_LoadData");

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnGameModeExit() {

    foreach(new j : pumpIterator) {

        Iter_Remove(pumpIterator, j);
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerConnect(playerid) {

    nearestPump[playerid] = -1;

    return Y_HOOKS_CONTINUE_RETURN_1;
}

YCMD:fuel(playerid, params[], help) {

    nearestPump[playerid] = GetNearestPump(playerid);

    if(nearestPump[playerid] == -1) return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Ne nalazite se blizu pumpe!");

    if(fuel_IsActive[playerid]) {

        Fuel_ShowInterface(playerid, false); 
        SendClientMessage(playerid, x_server, "maryland \187; "c_white"Trenutna kolicina goriva u vozilu iznosi "c_server"%dL", GetVehicleFuel(fuelingVehicle[playerid]));
        fuel_Counter[playerid] = 0;
        KillTimer(fuel_Timer[playerid]);
        fuel_IsActive[playerid] = false;
        fuelingVehicle[playerid] = INVALID_VEHICLE_ID;
    }

    Fuel_ShowInterface(playerid, true);

    new vehicle = GetPlayerVehicleID(playerid);

    if(GetVehicleFuel(vehicle) == 100) return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Vozilo je puno gorivom!");

    fuel_Timer[playerid] = SetTimerEx("fuel_StartFueling", 150, true, "d", playerid);
    fuel_Counter[playerid] = 0;
    fuelingVehicle[playerid] = vehicle;
    fuel_IsActive[playerid] = true;

    return 1;
}

YCMD:createpump(playerid, params[], help) 
{
    
    if(help) {

        SendClientMessage(playerid, x_server, "maryland \187; "c_white"1 | Benzin   2 | Dizel   3 | Metan   4 | Punjac ");
        return 1;
    }

    new type, businessID, temp_id = Iter_Free(pumpIterator), Float:pPos[3];

    if(sscanf(params, "dd", type, businessID)) return SendClientMessage(playerid, x_server, "maryland \187; "c_white"/createpump [tip] [business id]");
    if(type < PUMP_FUEL_TYPE_DIESEL || type > PUMP_FUEL_TYPE_METANE) return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Unijeli ste nevazeci tip pumpe!");

    GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);

    ePumpInfo[temp_id][pumpFuel] = 4000;
    ePumpInfo[temp_id][pumpFuelType] = type;
    ePumpInfo[temp_id][pumpBusinessID] = businessID;

    ePumpInfo[temp_id][pumpLocation][0] = pPos[0];
    ePumpInfo[temp_id][pumpLocation][1] = pPos[1];
    ePumpInfo[temp_id][pumpLocation][2] = pPos[2];

    new q[240];

    mysql_format(MySQL:SQL, q, sizeof q, "INSERT INTO `pumps` (`pumpBusinessID`, `pumpFuel`, `pumpFuelType`, `pump_X`, `pump_Y`, `pump_Z`) VALUES ('%d', '4000', '%d', '%f', '%f', '%f')", 
                                          ePumpInfo[temp_id][pumpBusinessID], ePumpInfo[temp_id][pumpFuelType], ePumpInfo[temp_id][pumpLocation][0], ePumpInfo[temp_id][pumpLocation][1], ePumpInfo[temp_id][pumpLocation][2]);
    mysql_tquery(MySQL:SQL, q, "Pump_InsertData", "d", temp_id);

    return 1;
}

YCMD:vehiclefuel(playerid, params[], help) 
{   
    new vehicle = GetPlayerVehicleID(playerid);
    SendClientMessage(playerid, x_server, "FUEL > "c_white"%dL", GetVehicleFuel(vehicle));

    return 1;
}