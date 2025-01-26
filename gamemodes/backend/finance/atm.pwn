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
 *  @File           atm.pwn
 *  @Module         script
 *  @Todo:          Make atm system.
 */

#include <ysilib\YSI_Coding\y_hooks>

// Constants
#define MAX_ATMS            100
#define INVALID_ATM_ID      -1
#define ATM_RANGE           3.0
#define ATM_DEFAULT_MODEL   19324 // Promeni na željeni model bankomata

// ATM Data Structure
enum E_ATM_DATA {
    atmID,
    atmModel,
    Float:atmX,
    Float:atmY,
    Float:atmZ,
    Float:atmRX,
    Float:atmRY,
    Float:atmRZ,
    atmObject,
    Text3D:atmLabel
}

// Variables
new ATMData[MAX_ATMS][E_ATM_DATA];
new Iterator:ATMs<MAX_ATMS>;
new gEditingATM[MAX_PLAYERS] = {INVALID_ATM_ID, ...};

// Forward declarations
forward OnATMInserted(playerid, atmid);

// Load ATMs from database
LoadATMs() {
    mysql_tquery(SQL, "SELECT * FROM atms", "OnATMsLoad");
}

forward OnATMsLoad();
public OnATMsLoad() {
    new rows = cache_num_rows();
    
    for(new i = 0; i < rows; i++) {
        new atmid = Iter_Free(ATMs);
        if(atmid == INVALID_ATM_ID) continue;
        
        Iter_Add(ATMs, atmid);
        
        cache_get_value_name_int(i, "id", ATMData[atmid][atmID]);
        cache_get_value_name_int(i, "model", ATMData[atmid][atmModel]);
        cache_get_value_name_float(i, "pos_x", ATMData[atmid][atmX]);
        cache_get_value_name_float(i, "pos_y", ATMData[atmid][atmY]);
        cache_get_value_name_float(i, "pos_z", ATMData[atmid][atmZ]);
        cache_get_value_name_float(i, "rot_x", ATMData[atmid][atmRX]);
        cache_get_value_name_float(i, "rot_y", ATMData[atmid][atmRY]);
        cache_get_value_name_float(i, "rot_z", ATMData[atmid][atmRZ]);
        
        ATMData[atmid][atmObject] = CreateDynamicObject(ATMData[atmid][atmModel], 
            ATMData[atmid][atmX], ATMData[atmid][atmY], ATMData[atmid][atmZ],
            ATMData[atmid][atmRX], ATMData[atmid][atmRY], ATMData[atmid][atmRZ]);
            
        ATMData[atmid][atmLabel] = CreateDynamic3DTextLabel("Bankomat\nPritisni N za koriscenje", 
            x_white, 
            ATMData[atmid][atmX], ATMData[atmid][atmY], ATMData[atmid][atmZ] + 1.0,
            10.0);
    }
    
    printf("[ATMs] Loaded %d ATMs", rows);
}

// Commands
YCMD:createatm(playerid, params[], help) {
    if(help) {
        SendClientMessage(playerid, -1, "USAGE: /createatm [model]");
        return 1;
    }
    
    if(GetPlayerStaffLevel(playerid) < e_STAFF) 
        return SendClientMessage(playerid, -1, "Nemate dozvolu za koriscenje ove komande!");
    
    new model;
    if(sscanf(params, "i", model)) {
        model = ATM_DEFAULT_MODEL;
    }
    
    new atmid = Iter_Free(ATMs);
    if(atmid == INVALID_ATM_ID)
        return SendClientMessage(playerid, -1, "Dostignut je maksimalan broj bankomata!");
    
    new Float:x, Float:y, Float:z, Float:angle;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, angle);
    
    // Postavi bankomat 2 jedinice ispred igra?a
    x += (2.0 * floatsin(-angle, degrees));
    y += (2.0 * floatcos(-angle, degrees));
    
    ATMData[atmid][atmModel] = model;
    ATMData[atmid][atmX] = x;
    ATMData[atmid][atmY] = y;
    ATMData[atmid][atmZ] = z;
    ATMData[atmid][atmRX] = 0.0;
    ATMData[atmid][atmRY] = 0.0;
    ATMData[atmid][atmRZ] = angle;
    
    ATMData[atmid][atmObject] = CreateDynamicObject(model, x, y, z, 0.0, 0.0, angle);
    ATMData[atmid][atmLabel] = CreateDynamic3DTextLabel("Bankomat\nPritisni N za koriscenje", 
        x_white, x, y, z + 1.0, 10.0);
    
    Iter_Add(ATMs, atmid);
    
    // Prvo sa?uvaj u bazu
    new query[512];
    mysql_format(SQL, query, sizeof(query), 
        "INSERT INTO atms (model, pos_x, pos_y, pos_z, rot_x, rot_y, rot_z) VALUES (%d, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f)",
        model, x, y, z, 0.0, 0.0, angle
    );
    mysql_tquery(SQL, query, "OnATMInserted", "dd", playerid, atmid);
    
    // Zatim omogu?i editovanje
    gEditingATM[playerid] = atmid;
    EditDynamicObject(playerid, ATMData[atmid][atmObject]);
    
    SendClientMessage(playerid, -1, "Bankomat je kreiran. Postavite ga na zeljenu poziciju i pritisnite save kada zavrsite.");
    return 1;
}

YCMD:editatm(playerid, params[], help) {
    if(help) {
        SendClientMessage(playerid, -1, "USAGE: /editatm - Edit the nearest ATM");
        return 1;
    }
    
    if(GetPlayerStaffLevel(playerid) < e_STAFF) 
        return SendClientMessage(playerid, -1, "Nemate dozvolu za koriscenje ove komande!");
    
    new nearest_atm = GetNearestATM(playerid);
    if(nearest_atm == INVALID_ATM_ID)
        return SendClientMessage(playerid, -1, "Niste blizu nijednog bankomata!");
        
    gEditingATM[playerid] = nearest_atm;
    EditDynamicObject(playerid, ATMData[nearest_atm][atmObject]);
    
    SendClientMessage(playerid, -1, "Postavite bankomat na novu poziciju i pritisnite save kada zavrsite.");
    return 1;
}

YCMD:deleteatm(playerid, params[], help) {
    if(help) {
        SendClientMessage(playerid, -1, "USAGE: /deleteatm - Delete the nearest ATM");
        return 1;
    }
    
    if(GetPlayerStaffLevel(playerid) < e_STAFF) 
        return SendClientMessage(playerid, -1, "Nemate dozvolu za koriscenje ove komande!");
    
    new nearest_atm = GetNearestATM(playerid);
    if(nearest_atm == INVALID_ATM_ID)
        return SendClientMessage(playerid, -1, "Niste blizu nijednog bankomata!");
    
    // Delete ATM
    DestroyDynamicObject(ATMData[nearest_atm][atmObject]);
    DestroyDynamic3DTextLabel(ATMData[nearest_atm][atmLabel]);
    
    // Delete from database
    new query[64];
    mysql_format(SQL, query, sizeof(query), "DELETE FROM atms WHERE id = %d", ATMData[nearest_atm][atmID]);
    mysql_tquery(SQL, query);
    
    Iter_Remove(ATMs, nearest_atm);
    
    SendClientMessage(playerid, -1, "Bankomat je uspesno obrisan!");
    return 1;
}

// Callbacks
public OnATMInserted(playerid, atmid) {
    ATMData[atmid][atmID] = cache_insert_id();
    //printf("[ATM Debug] ATM created - ID: %d", ATMData[atmid][atmID]);
    return 1;
}

// Function to get nearest ATM ID or INVALID_ATM_ID if none nearby
stock GetNearestATM(playerid) {
    new Float:px, Float:py, Float:pz;
    GetPlayerPos(playerid, px, py, pz);
    
    new Float:nearest_dist = 999999.0;
    new nearest_atm = INVALID_ATM_ID;
    
    foreach(new atmid : ATMs) {
        new Float:dist = GetPlayerDistanceToPoint3D(playerid,
            ATMData[atmid][atmX],
            ATMData[atmid][atmY],
            ATMData[atmid][atmZ]
        );
        
        if(dist < ATM_RANGE && dist < nearest_dist) {
            nearest_dist = dist;
            nearest_atm = atmid;
        }
    }
    
    return nearest_atm;
}

// Object editing callback
hook OnPlayerEditDynamicObject(playerid, STREAMER_TAG_OBJECT:objectid, EDIT_RESPONSE:response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz) {
    //printf("[ATM Debug] Edit callback started - Player: %d, Object: %d", playerid, _:objectid);
    
    new atmid = gEditingATM[playerid];
    if(atmid == INVALID_ATM_ID) {
       // printf("[ATM Debug] Invalid ATM ID");
        return 1;
    }
    
    //printf("[ATM Debug] Editing ATM ID: %d, SQL ID: %d", atmid, ATMData[atmid][atmID]);
    
    if(response == EDIT_RESPONSE_FINAL) {
        //printf("[ATM Debug] Edit confirmed - New pos: %.4f, %.4f, %.4f", x, y, z);
        
        // Update object position
        ATMData[atmid][atmX] = x;
        ATMData[atmid][atmY] = y;
        ATMData[atmid][atmZ] = z;
        ATMData[atmid][atmRX] = rx;
        ATMData[atmid][atmRY] = ry;
        ATMData[atmid][atmRZ] = rz;
        
        // Update label position
        if(IsValidDynamic3DTextLabel(ATMData[atmid][atmLabel])) {
            DestroyDynamic3DTextLabel(ATMData[atmid][atmLabel]);
        }
        ATMData[atmid][atmLabel] = CreateDynamic3DTextLabel("Bankomat\nPritisni N za koriscenje", 
            x_white, x, y, z + 1.0, 10.0);
        
        // Update position in database
        new query[512];
        mysql_format(SQL, query, sizeof(query), 
            "UPDATE atms SET pos_x=%.4f, pos_y=%.4f, pos_z=%.4f, rot_x=%.4f, rot_y=%.4f, rot_z=%.4f WHERE id=%d",
            x, y, z, rx, ry, rz, ATMData[atmid][atmID]
        );
        //printf("[ATM Debug] Update Query: %s", query);
        mysql_tquery(SQL, query, "OnATMEdited", "dd", playerid, atmid);
        
        // Update object position again to ensure it's set
        SetDynamicObjectPos(ATMData[atmid][atmObject], x, y, z);
        SetDynamicObjectRot(ATMData[atmid][atmObject], rx, ry, rz);
        
        SendClientMessage(playerid, -1, "Pozicija bankomata je uspesno azurirana!");
        gEditingATM[playerid] = INVALID_ATM_ID;
    }
    else if(response == EDIT_RESPONSE_CANCEL) {
        //printf("[ATM Debug] Edit cancelled - Returning to original pos");
        
        // Return to original position
        SetDynamicObjectPos(ATMData[atmid][atmObject], 
            ATMData[atmid][atmX], 
            ATMData[atmid][atmY], 
            ATMData[atmid][atmZ]
        );
        SetDynamicObjectRot(ATMData[atmid][atmObject], 
            ATMData[atmid][atmRX], 
            ATMData[atmid][atmRY], 
            ATMData[atmid][atmRZ]
        );
        SendClientMessage(playerid, -1, "Editovanje bankomata je otkazano!");
        gEditingATM[playerid] = INVALID_ATM_ID;
    }
    
    printf("[ATM Debug] Edit callback finished");
    return 1;
}

// Callback for ATM edit
forward OnATMEdited(playerid, atmid);
public OnATMEdited(playerid, atmid) {
    printf("[ATM Debug] OnATMEdited called - Player: %d, ATM: %d, SQL ID: %d, Rows affected: %d", 
        playerid, atmid, ATMData[atmid][atmID], cache_affected_rows());
    return 1;
}

hook OnGameModeInit() {
    LoadATMs();
    print("[ATMs] ATM system initialized.");
    return 1;
}


