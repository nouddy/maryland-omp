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
 *  @Date           25th January 2025
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           gates.pwn
 *  @Module         gates
 */

#include <ysilib\YSI_Coding\y_hooks>

// Constants
#define MAX_GATES           100
#define GATE_RANGE         5.0
#define INVALID_GATE_ID    -1

// Gate types
enum {
    GATE_TYPE_PUBLIC = 1,    // Anyone can open
    GATE_TYPE_PRIVATE,       // Only owner can open
    GATE_TYPE_FACTION,       // Only faction members can open
    GATE_TYPE_POLICE,        // Only police members can open
    GATE_TYPE_ADMIN         // Only admins can open
}

// Gate data structure
enum E_GATE_DATA {
    gateID,
    gateModel,
    Float:gateClosedX,
    Float:gateClosedY,
    Float:gateClosedZ,
    Float:gateClosedRX,
    Float:gateClosedRY,
    Float:gateClosedRZ,
    Float:gateOpenX,
    Float:gateOpenY,
    Float:gateOpenZ,
    Float:gateOpenRX,
    Float:gateOpenRY,
    Float:gateOpenRZ,
    gateObject,
    gateType,
    gateOwnerID,         // Player ID that owns the gate (if private)
    gateFactionID,       // Faction ID that owns the gate (if faction type)
    gatePoliceDivision,  // Police division ID (if police type)
    gateCloseTime,       // Time in seconds before auto-close
    bool:gateIsOpen,
    Timer:gateTimer
}

// Variables
new Iterator:Gates<MAX_GATES>;
new GateData[MAX_GATES][E_GATE_DATA];
new gEditingGate[MAX_PLAYERS] = {INVALID_GATE_ID, ...};
new gEditingGateStep[MAX_PLAYERS];

// Forward declarations
forward OnGateEdited(playerid, gateid);
forward OnGateDeleted(gateid);
forward Timer_CloseGate(gateid);
forward OnGateInserted(playerid, gateid);

// Helper function for distance calculation
Float:GetDistanceBetweenPoints(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2)
{
    return floatsqroot(floatpower(floatabs(x1 - x2), 2) + floatpower(floatabs(y1 - y2), 2) + floatpower(floatabs(z1 - z2), 2));
}

// Initialization
hook OnGameModeInit() {
    print("gates.pwn loaded");
    LoadGates();
    return 1;
}

hook OnGameModeExit() {
    SaveGates();
    return 1;
}

// Load gates from database
LoadGates() {
    new query[128];
    mysql_format(SQL, query, sizeof(query), "SELECT * FROM gates");
    mysql_tquery(SQL, query, "OnGatesLoad");
}

forward OnGatesLoad();
public OnGatesLoad() {
    new rows = cache_num_rows();
    
    for(new i = 0; i < rows; i++) {
        new gateid = Iter_Free(Gates);
        if(gateid == INVALID_GATE_ID) continue;
        
        Iter_Add(Gates, gateid);
        
        cache_get_value_name_int(i, "id", GateData[gateid][gateID]);
        cache_get_value_name_int(i, "model", GateData[gateid][gateModel]);
        cache_get_value_name_float(i, "closed_x", GateData[gateid][gateClosedX]);
        cache_get_value_name_float(i, "closed_y", GateData[gateid][gateClosedY]);
        cache_get_value_name_float(i, "closed_z", GateData[gateid][gateClosedZ]);
        cache_get_value_name_float(i, "closed_rx", GateData[gateid][gateClosedRX]);
        cache_get_value_name_float(i, "closed_ry", GateData[gateid][gateClosedRY]);
        cache_get_value_name_float(i, "closed_rz", GateData[gateid][gateClosedRZ]);
        cache_get_value_name_float(i, "open_x", GateData[gateid][gateOpenX]);
        cache_get_value_name_float(i, "open_y", GateData[gateid][gateOpenY]);
        cache_get_value_name_float(i, "open_z", GateData[gateid][gateOpenZ]);
        cache_get_value_name_float(i, "open_rx", GateData[gateid][gateOpenRX]);
        cache_get_value_name_float(i, "open_ry", GateData[gateid][gateOpenRY]);
        cache_get_value_name_float(i, "open_rz", GateData[gateid][gateOpenRZ]);
        cache_get_value_name_int(i, "type", GateData[gateid][gateType]);
        cache_get_value_name_int(i, "owner_id", GateData[gateid][gateOwnerID]);
        cache_get_value_name_int(i, "faction_id", GateData[gateid][gateFactionID]);
        cache_get_value_name_int(i, "close_time", GateData[gateid][gateCloseTime]);
        cache_get_value_name_int(i, "police_division", GateData[gateid][gatePoliceDivision]);
        
        // Create gate object
        GateData[gateid][gateObject] = CreateDynamicObject(
            GateData[gateid][gateModel],
            GateData[gateid][gateClosedX],
            GateData[gateid][gateClosedY],
            GateData[gateid][gateClosedZ],
            GateData[gateid][gateClosedRX],
            GateData[gateid][gateClosedRY],
            GateData[gateid][gateClosedRZ]
        );
        
        GateData[gateid][gateIsOpen] = false;
        GateData[gateid][gateTimer] = Timer:-1;
    }
    
    printf("[GATES] Loaded %d gates", rows);
}

// Save gates to database
SaveGates() {
    new query[1024];
    
    foreach(new gateid : Gates) {
        mysql_format(SQL, query, sizeof(query), 
            "INSERT INTO gates (id, model, closed_x, closed_y, closed_z, closed_rx, closed_ry, closed_rz, \
            open_x, open_y, open_z, open_rx, open_ry, open_rz, type, owner_id, faction_id, police_division, close_time) VALUES \
            (%d, %d, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f, %d, %d, %d, %d, %d) \
            ON DUPLICATE KEY UPDATE model=%d, closed_x=%.4f, closed_y=%.4f, closed_z=%.4f, \
            closed_rx=%.4f, closed_ry=%.4f, closed_rz=%.4f, open_x=%.4f, open_y=%.4f, open_z=%.4f, \
            open_rx=%.4f, open_ry=%.4f, open_rz=%.4f, type=%d, owner_id=%d, faction_id=%d, police_division=%d, close_time=%d",
            GateData[gateid][gateID], GateData[gateid][gateModel],
            GateData[gateid][gateClosedX], GateData[gateid][gateClosedY], GateData[gateid][gateClosedZ],
            GateData[gateid][gateClosedRX], GateData[gateid][gateClosedRY], GateData[gateid][gateClosedRZ],
            GateData[gateid][gateOpenX], GateData[gateid][gateOpenY], GateData[gateid][gateOpenZ],
            GateData[gateid][gateOpenRX], GateData[gateid][gateOpenRY], GateData[gateid][gateOpenRZ],
            GateData[gateid][gateType], GateData[gateid][gateOwnerID], GateData[gateid][gateFactionID], GateData[gateid][gatePoliceDivision], GateData[gateid][gateCloseTime],
            GateData[gateid][gateModel],
            GateData[gateid][gateClosedX], GateData[gateid][gateClosedY], GateData[gateid][gateClosedZ],
            GateData[gateid][gateClosedRX], GateData[gateid][gateClosedRY], GateData[gateid][gateClosedRZ],
            GateData[gateid][gateOpenX], GateData[gateid][gateOpenY], GateData[gateid][gateOpenZ],
            GateData[gateid][gateOpenRX], GateData[gateid][gateOpenRY], GateData[gateid][gateOpenRZ],
            GateData[gateid][gateType], GateData[gateid][gateOwnerID], GateData[gateid][gateFactionID], GateData[gateid][gatePoliceDivision], GateData[gateid][gateCloseTime]
        );
        mysql_tquery(SQL, query);
    }
}

// Gate creation command
YCMD:creategate(playerid, params[], help) {
    if(help) {
        SendClientMessage(playerid, -1, "USAGE: /creategate [model]");
        return 1;
    }
    
    if(GetPlayerStaffLevel(playerid) < e_STAFF) 
        return SendClientMessage(playerid, -1, "Nemate dozvolu za koriscenje ove komande!");
        
    new model;
    if(sscanf(params, "i", model))
        return SendClientMessage(playerid, -1, "USAGE: /creategate [model]");
        
    new gateid = Iter_Free(Gates);
    if(gateid == INVALID_GATE_ID)
        return SendClientMessage(playerid, -1, "Dostignut je maksimalan broj kapija!");
        
    gEditingGate[playerid] = gateid;
    gEditingGateStep[playerid] = 1;
    
    GateData[gateid][gateModel] = model;
    
    SendClientMessage(playerid, -1, "Postavite kapiju u zatvorenu poziciju i pritisnite save kada zavrsite.");
    
    // Create temporary object for editing
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    
    GateData[gateid][gateObject] = CreateDynamicObject(model, x, y, z, 0.0, 0.0, 0.0);
    EditDynamicObject(playerid, GateData[gateid][gateObject]);
    
    // Finalize gate creation
    Iter_Add(Gates, gateid);
    GateData[gateid][gateIsOpen] = false;
    GateData[gateid][gateTimer] = Timer:-1;
    
    // Save to database
    new query[128];
    mysql_format(SQL, query, sizeof(query), "INSERT INTO gates (model) VALUES (%d)", GateData[gateid][gateModel]);
    mysql_tquery(SQL, query, "OnGateInserted", "dd", playerid, gateid);
    
    return 1;
}

// Gate editing
hook OnPlayerEditDynamicObject(playerid, STREAMER_TAG_OBJECT:objectid, EDIT_RESPONSE:response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz) {
    new gateid = gEditingGate[playerid];
    if(gateid == INVALID_GATE_ID) return 1;
    
    if(response == EDIT_RESPONSE_FINAL) {
        switch(gEditingGateStep[playerid]) {
            case 1: { // Closed position
                GateData[gateid][gateClosedX] = x;
                GateData[gateid][gateClosedY] = y;
                GateData[gateid][gateClosedZ] = z;
                GateData[gateid][gateClosedRX] = rx;
                GateData[gateid][gateClosedRY] = ry;
                GateData[gateid][gateClosedRZ] = rz;
                
                SendClientMessage(playerid, -1, "Now place the gate in its open position and press save when done.");
                gEditingGateStep[playerid] = 2;
                EditDynamicObject(playerid, GateData[gateid][gateObject]);
            }
            case 2: { // Open position
                GateData[gateid][gateOpenX] = x;
                GateData[gateid][gateOpenY] = y;
                GateData[gateid][gateOpenZ] = z;
                GateData[gateid][gateOpenRX] = rx;
                GateData[gateid][gateOpenRY] = ry;
                GateData[gateid][gateOpenRZ] = rz;
                
                ShowGateTypeDialog(playerid);
            }
        }
    }
    return 1;
}

ShowGateTypeDialog(playerid) {
    new string[256];
    strcat(string, "Public Gate (Anyone can open)\n");
    strcat(string, "Private Gate (Owner only)\n");
    strcat(string, "Faction Gate (Faction members only)\n");
    strcat(string, "Police Gate (Police members only)\n");
    strcat(string, "Admin Gate (Admins only)");
    
    Dialog_Show(playerid, "dialog_GateType", DIALOG_STYLE_LIST, "Select Gate Type", string, "Select", "Cancel");
}

Dialog:dialog_GateType(playerid, response, listitem, inputtext[]) {
    if(!response) {
        CancelGateCreation(playerid);
        return 1;
    }
    
    new gateid = gEditingGate[playerid];
    if(gateid == INVALID_GATE_ID) return 1;
    
    GateData[gateid][gateType] = listitem + 1;
    
    switch(listitem) {
        case 1: ShowGateOwnerDialog(playerid); // Private gate
        case 2: { // Faction gate
            SendClientMessage(playerid, -1, "Faction gates are temporarily disabled.");
            ShowGateTypeDialog(playerid);
            return 1;
        }
        case 3: { // Police gate
            SendClientMessage(playerid, -1, "Police gates are temporarily disabled.");
            ShowGateTypeDialog(playerid);
            return 1;
        }
        default: ShowGateCloseTimeDialog(playerid);
    }
    
    return 1;
}

ShowGateOwnerDialog(playerid) {
    new gateid = gEditingGate[playerid];
    if(gateid == INVALID_GATE_ID) return 1;
    
    if(GateData[gateid][gateType] == GATE_TYPE_PRIVATE) {
        Dialog_Show(playerid, "dialog_GateOwner", DIALOG_STYLE_INPUT, "Unesi vlasnika kapije", 
            "Unesi ID igraca ili ime karaktera koji ce biti vlasnik ove kapije:", "Potvrdi", "Nazad");
    }
    else if(GateData[gateid][gateType] == GATE_TYPE_FACTION) {
        SendClientMessage(playerid, -1, "Faction gates are temporarily disabled.");
        ShowGateTypeDialog(playerid);
        return 1;
    }
    else if(GateData[gateid][gateType] == GATE_TYPE_POLICE) {
        SendClientMessage(playerid, -1, "Police gates are temporarily disabled.");
        ShowGateTypeDialog(playerid);
        return 1;
    }
    return 1;
}

Dialog:dialog_GateOwner(playerid, response, listitem, inputtext[]) {
    if(!response) {
        ShowGateTypeDialog(playerid);
        return 1;
    }
    
    new gateid = gEditingGate[playerid];
    if(gateid == INVALID_GATE_ID) return 1;
    
    new targetid = INVALID_PLAYER_ID;
    
    // Prvo probamo da li je unet ID
    if(IsNumeric(inputtext)) {
        targetid = strval(inputtext);
        if(!IsPlayerConnected(targetid)) {
            SendClientMessage(playerid, -1, "Izabrani igrac nije konektovan!");
            ShowGateOwnerDialog(playerid);
            return 1;
        }
    }
    // Ako nije ID, tražimo po imenu
    else {
        foreach(new i : Player) {
            if(!strcmp(ReturnPlayerName(i), inputtext, true)) {
                targetid = i;
                break;
            }
        }
        
        if(targetid == INVALID_PLAYER_ID) {
            SendClientMessage(playerid, -1, "Igrac sa tim imenom nije pronadjen!");
            ShowGateOwnerDialog(playerid);
            return 1;
        }
    }
    
    // Sa?uvaj character ID vlasnika
    GateData[gateid][gateOwnerID] = GetCharacterSQLID(targetid);
    ShowGateCloseTimeDialog(playerid);
    
    return 1;
}

Dialog:dialog_GateFaction(playerid, response, listitem, inputtext[]) {
    if(!response) {
        ShowGateTypeDialog(playerid);
        return 1;
    }
    
    new gateid = gEditingGate[playerid];
    if(gateid == INVALID_GATE_ID) return 1;
    
    new factionid;
    if(sscanf(inputtext, "p<(>s[64]p<:>i", factionid)) {
        SendClientMessage(playerid, -1, "Invalid faction selected!");
        ShowGateOwnerDialog(playerid);
        return 1;
    }
    
    GateData[gateid][gateOwnerID] = 0; // Reset owner ID since it's faction gate
    GateData[gateid][gateFactionID] = factionid;
    ShowGateCloseTimeDialog(playerid);
    
    return 1;
}

ShowGateCloseTimeDialog(playerid) {
    Dialog_Show(playerid, "dialog_GateCloseTime", DIALOG_STYLE_INPUT, "Gate Close Time", 
        "Enter the time (in seconds) after which the gate should automatically close:", "Done", "Back");
}

Dialog:dialog_GateCloseTime(playerid, response, listitem, inputtext[]) {
    if(!response) {
        if(GateData[gEditingGate[playerid]][gateType] == GATE_TYPE_PRIVATE || 
           GateData[gEditingGate[playerid]][gateType] == GATE_TYPE_FACTION) {
            ShowGateOwnerDialog(playerid);
        } else {
            ShowGateTypeDialog(playerid);
        }
        return 1;
    }
    
    new gateid = gEditingGate[playerid];
    if(gateid == INVALID_GATE_ID) return 1;
    
    new time = strval(inputtext);
    if(time < 1 || time > 60) {
        SendClientMessage(playerid, -1, "Close time must be between 1 and 60 seconds!");
        ShowGateCloseTimeDialog(playerid);
        return 1;
    }
    
    GateData[gateid][gateCloseTime] = time;
    
    // Finalize gate creation
    Iter_Add(Gates, gateid);
    GateData[gateid][gateIsOpen] = false;
    GateData[gateid][gateTimer] = Timer:-1;
    
    SendClientMessage(playerid, -1, "Gate created successfully!");
    
    // Reset editing state
    gEditingGate[playerid] = INVALID_GATE_ID;
    gEditingGateStep[playerid] = 0;
    
    // Save to database
    SaveGates();
    
    return 1;
}

CancelGateCreation(playerid) {
    new gateid = gEditingGate[playerid];
    if(gateid != INVALID_GATE_ID) {
        DestroyDynamicObject(GateData[gateid][gateObject]);
        gEditingGate[playerid] = INVALID_GATE_ID;
        gEditingGateStep[playerid] = 0;
    }
    SendClientMessage(playerid, -1, "Gate creation cancelled.");
}

// Gate operation
OperateGate(gateid, playerid, bool:open) {
    if(!Iter_Contains(Gates, gateid)) return 0;
    
    if(open && !GateData[gateid][gateIsOpen]) {
        MoveDynamicObject(GateData[gateid][gateObject], 
            GateData[gateid][gateOpenX], 
            GateData[gateid][gateOpenY], 
            GateData[gateid][gateOpenZ],
            3.0,
            GateData[gateid][gateOpenRX],
            GateData[gateid][gateOpenRY],
            GateData[gateid][gateOpenRZ]
        );
        GateData[gateid][gateIsOpen] = true;
        
        // Proxy message for opening
        new message[128];
        format(message, sizeof(message), "* %s otvara kapiju, automatski ce se zatvoriti za %d sekundi.", 
            ReturnPlayerName(playerid), GateData[gateid][gateCloseTime]);
        ProxDetector(playerid, 30.0, x_purple, message);
        
        // Start close timer
        if(GateData[gateid][gateTimer] != Timer:-1) {
            stop GateData[gateid][gateTimer];
        }
        GateData[gateid][gateTimer] = defer Timer_CloseGate[GateData[gateid][gateCloseTime] * 1000](gateid);
    }
    else if(!open && GateData[gateid][gateIsOpen]) {
        MoveDynamicObject(GateData[gateid][gateObject], 
            GateData[gateid][gateClosedX], 
            GateData[gateid][gateClosedY], 
            GateData[gateid][gateClosedZ],
            3.0,
            GateData[gateid][gateClosedRX],
            GateData[gateid][gateClosedRY],
            GateData[gateid][gateClosedRZ]
        );
        GateData[gateid][gateIsOpen] = false;
        
        // Proxy message for closing
        new message[128];
        format(message, sizeof(message), "* Kapija se automatski zatvara.");
        ProxDetector(playerid, 30.0, x_purple, message);
        
        if(GateData[gateid][gateTimer] != Timer:-1) {
            stop GateData[gateid][gateTimer];
            GateData[gateid][gateTimer] = Timer:-1;
        }
    }
    return 1;
}

timer Timer_CloseGate[1000](gateid) {
    // Find a nearby player to attribute the closing message to
    new Float:gateX = GateData[gateid][gateClosedX];
    new Float:gateY = GateData[gateid][gateClosedY];
    new Float:gateZ = GateData[gateid][gateClosedZ];
    new playerid = INVALID_PLAYER_ID;
    
    foreach(new i : Player) {
        if(GetPlayerDistanceFromPoint(i, gateX, gateY, gateZ) < GATE_RANGE) {
            playerid = i;
            break;
        }
    }
    
    if(playerid == INVALID_PLAYER_ID) {
        // If no player is nearby, use any valid player for the message
        foreach(new i : Player) {
            playerid = i;
            break;
        }
    }
    
    OperateGate(gateid, playerid, false);
}

// Key bindings for gate operation
hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys) {
    if(newkeys & KEY_CROUCH && !(oldkeys & KEY_CROUCH)) { // C on foot, H in vehicle
        // Find nearest gate
        new Float:px, Float:py, Float:pz;
        GetPlayerPos(playerid, px, py, pz);
        
        new Float:nearest_dist = 999999.0;
        new nearest_gate = INVALID_GATE_ID;
        
        foreach(new gateid : Gates) {
            new Float:dist = GetDistanceBetweenPoints(px, py, pz,
                GateData[gateid][gateClosedX],
                GateData[gateid][gateClosedY],
                GateData[gateid][gateClosedZ]
            );
            
            if(dist < GATE_RANGE && dist < nearest_dist) {
                nearest_dist = dist;
                nearest_gate = gateid;
            }
        }
        
        if(nearest_gate != INVALID_GATE_ID) {
            new bool:can_operate = false;
            
            switch(GateData[nearest_gate][gateType]) {
                case GATE_TYPE_PUBLIC: {
                    can_operate = true;
                }
                case GATE_TYPE_PRIVATE: {
                    if(GetCharacterSQLID(playerid) == GateData[nearest_gate][gateOwnerID] || 
                       GetPlayerStaffLevel(playerid) >= e_STAFF) {
                        can_operate = true;
                    }
                }
                case GATE_TYPE_FACTION: {
                    SendClientMessage(playerid, -1, "Faction gates are temporarily disabled.");
                    return 1;
                }
                case GATE_TYPE_POLICE: {
                    SendClientMessage(playerid, -1, "Police gates are temporarily disabled.");
                    return 1;
                }
                case GATE_TYPE_ADMIN: {
                    if(GetPlayerStaffLevel(playerid) >= e_STAFF) {
                        can_operate = true;
                    }
                }
            }
            
            if(can_operate) {
                OperateGate(nearest_gate, playerid, !GateData[nearest_gate][gateIsOpen]);
            } else {
                SendClientMessage(playerid, -1, "Nemate dozvolu za koriscenje ove kapije!");
            }
        }
    }
    return 1;
}

// Gate deletion command
YCMD:deletegate(playerid, params[], help) {
    if(help) {
        SendClientMessage(playerid, -1, "USAGE: /deletegate - Delete the nearest gate");
        return 1;
    }
    
    if(GetPlayerStaffLevel(playerid) < e_STAFF) 
        return SendClientMessage(playerid, -1, "Nemate dozvolu za koriscenje ove komande!");
    
    // Find nearest gate
    new Float:px, Float:py, Float:pz;
    GetPlayerPos(playerid, px, py, pz);
    
    new Float:nearest_dist = 999999.0;
    new nearest_gate = INVALID_GATE_ID;
    
    foreach(new gateid : Gates) {
        new Float:dist = GetDistanceBetweenPoints(px, py, pz,
            GateData[gateid][gateClosedX],
            GateData[gateid][gateClosedY],
            GateData[gateid][gateClosedZ]
        );
        
        if(dist < GATE_RANGE && dist < nearest_dist) {
            nearest_dist = dist;
            nearest_gate = gateid;
        }
    }
    
    if(nearest_gate == INVALID_GATE_ID)
        return SendClientMessage(playerid, -1, "Niste blizu nijedne kapije!");
    
    // Delete gate
    DestroyDynamicObject(GateData[nearest_gate][gateObject]);
    if(GateData[nearest_gate][gateTimer] != Timer:-1) {
        stop GateData[nearest_gate][gateTimer];
    }
    
    // Delete from database
    new query[64];
    mysql_format(SQL, query, sizeof(query), "DELETE FROM gates WHERE id = %d", GateData[nearest_gate][gateID]);
    mysql_tquery(SQL, query);
    
    Iter_Remove(Gates, nearest_gate);
    
    SendClientMessage(playerid, -1, "Kapija je uspesno obrisana!");
    
    return 1;
}

// Gate editing command
YCMD:editgate(playerid, params[], help) {
    if(help) {
        SendClientMessage(playerid, -1, "USAGE: /editgate - Edit the nearest gate");
        return 1;
    }
    
    if(GetPlayerStaffLevel(playerid) < e_STAFF) 
        return SendClientMessage(playerid, -1, "You don't have permission to use this command!");
    
    // Find nearest gate
    new Float:px, Float:py, Float:pz;
    GetPlayerPos(playerid, px, py, pz);
    
    new Float:nearest_dist = 999999.0;
    new nearest_gate = INVALID_GATE_ID;
    
    foreach(new gateid : Gates) {
        new Float:dist = GetDistanceBetweenPoints(px, py, pz,
            GateData[gateid][gateClosedX],
            GateData[gateid][gateClosedY],
            GateData[gateid][gateClosedZ]
        );
        
        if(dist < GATE_RANGE && dist < nearest_dist) {
            nearest_dist = dist;
            nearest_gate = gateid;
        }
    }
    
    if(nearest_gate == INVALID_GATE_ID)
        return SendClientMessage(playerid, -1, "You're not near any gate!");
        
    gEditingGate[playerid] = nearest_gate;
    gEditingGateStep[playerid] = 1;
    
    SendClientMessage(playerid, -1, "Edit the gate's closed position and press save when done.");
    EditDynamicObject(playerid, GateData[nearest_gate][gateObject]);
    
    return 1;
}

forward OnGateInserted(playerid, gateid);
public OnGateInserted(playerid, gateid) {
    GateData[gateid][gateID] = cache_insert_id();
    SendClientMessage(playerid, -1, "Gate created successfully!");
}