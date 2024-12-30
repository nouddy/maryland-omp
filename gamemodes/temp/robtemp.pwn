/***
 *    Robbery System with roles
 *    Author: Vostic
 *    Description: Handles bank robberies, roles, and rewards
 */

// ========================================================================
// Includes
// ========================================================================
#include <YSI_Coding\y_hooks>

// ========================================================================
// Constants & Enums
// ========================================================================

// General
#define MAX_ROBBERIES         5
#define MAX_ROBBERY_MEMBERS   4
#define ROBBERY_COOLDOWN      3600    // 1 hour in seconds
#define MASK_PRICE           1000
#define CAMERA_DETECTION_RANGE 15.0

// Colors
#define x_red      0xFF0000FF
#define x_green    0x33CC33FF
#define x_yellow   0xFFFF00FF
#define x_blue     0x0000FFFF
#define x_orange   0xFFA500FF
#define x_grey     0x808080FF

// Enums
enum E_ROBBERY_ROLES {
    ROLE_HACKER,
    ROLE_EXPLOSIVES,
    ROLE_GUARD,
    ROLE_CARRIER
}

enum E_ROBBERY_STATUS {
    STATUS_NONE,
    STATUS_PLANNING,
    STATUS_IN_PROGRESS,
    STATUS_ESCAPING
}

enum E_ROBBERY_RANKS {
    RANK_NOVICE,      // 0-2 successful robberies
    RANK_PROFESSIONAL,// 3-7 successful robberies
    RANK_MASTERMIND   // 8+ successful robberies
}

// ========================================================================
// Structures
// ========================================================================

enum E_ROBBERY_DATA {
    robberyID,
    robberyLeader,
    robberyStatus,
    robberyStartTime,
    robberyMembers[MAX_ROBBERY_MEMBERS],
    robberyRoles[MAX_ROBBERY_MEMBERS],
    robberyMoney,
    robberyLocation,
    bool:robberyAlarm,
    robberyTimer,
    robberyInvitedPlayer,
    robberyRoleTarget
}

enum E_PLAYER_ROBBERY {
    bool:pInRobbery,
    pRobberyID,
    pRobberyRole,
    pHackProgress,
    pBagMoney,
    pRobberyTimer
}

enum E_PLAYER_ROBBERY_STATS {
    pRobberyRank,
    pSuccessfulRobberies,
    pFailedRobberies,
    pTotalMoneyStolen,
    bool:pWearingMask,
    pLastRobberyTime
}

// ========================================================================
// Variables
// ========================================================================

new 
    Iterator:Robberies<MAX_ROBBERIES>,
    gRobberyData[MAX_ROBBERIES][E_ROBBERY_DATA],
    gPlayerRobbery[MAX_PLAYERS][E_PLAYER_ROBBERY],
    gPlayerRobberyStats[MAX_PLAYERS][E_PLAYER_ROBBERY_STATS];

// Location Arrays
new Float:gBankLocations[][] = {
    {1234.5, 2345.6, 10.5, 90.0}, // X, Y, Z, Rotation
    {2345.6, 3456.7, 10.5, 180.0},
    {3456.7, 4567.8, 10.5, 270.0}
};

new Float:gBankCameras[][] = {
    {1234.5, 2345.6, 10.5}, // Replace with actual camera coordinates
    {2345.6, 3456.7, 10.5},
    {3456.7, 4567.8, 10.5}
};

// ========================================================================
// Helper Functions
// ========================================================================

IsPlayerInRobbery(playerid) {
    return gPlayerRobbery[playerid][pInRobbery];
}

IsRobberyLeader(playerid) {
    if(!IsPlayerInRobbery(playerid)) return 0;
    new robberyid = gPlayerRobbery[playerid][pRobberyID];
    return (gRobberyData[robberyid][robberyLeader] == playerid);
}

GetRobberyMemberCount(robberyid) {
    new count = 0;
    for(new i = 0; i < MAX_ROBBERY_MEMBERS; i++) {
        if(gRobberyData[robberyid][robberyMembers][i] != INVALID_PLAYER_ID) {
            count++;
        }
    }
    return count;
}

SendRobberyMessage(robberyid, color, const message[]) {
    if(!Iter_Contains(Robberies, robberyid)) return 0;
    
    for(new i = 0; i < MAX_ROBBERY_MEMBERS; i++) {
        new playerid = gRobberyData[robberyid][robberyMembers][i];
        if(playerid != INVALID_PLAYER_ID) {
            SendClientMessage(playerid, color, message);
        }
    }
    return 1;
}

IsPlayerInRangeOfBank(playerid) {
    if(!IsPlayerConnected(playerid)) return 0;
    
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    
    for(new i = 0; i < sizeof(gBankLocations); i++) {
        if(IsPlayerInRangeOfPoint(playerid, 3.0,
            gBankLocations[i][0],
            gBankLocations[i][1],
            gBankLocations[i][2])) {
            return 1;
        }
    }
    return 0;
}

GetNearestBankID(playerid) {
    new Float:x, Float:y, Float:z, Float:dist, Float:closest = 999999.9, closestid = -1;
    GetPlayerPos(playerid, x, y, z);
    
    for(new i = 0; i < sizeof(gBankLocations); i++) {
        dist = GetPlayerDistanceFromPoint(playerid,
            gBankLocations[i][0],
            gBankLocations[i][1],
            gBankLocations[i][2]);
            
        if(dist < closest) {
            closest = dist;
            closestid = i;
        }
    }
    return closestid;
}

// ========================================================================
// Core Functions
// ========================================================================

StartRobbery(playerid, locationid) {
    if(!IsPlayerConnected(playerid)) return 0;
    if(gPlayerRobbery[playerid][pInRobbery]) 
        return SendClientMessage(playerid, x_red, "Vec ucestvujes u pljacki!");

    // Check cooldown
    if(gettime() - gPlayerRobberyStats[playerid][pLastRobberyTime] < ROBBERY_COOLDOWN)
        return SendClientMessage(playerid, x_red, "Moras sacekati pre sledece pljacke!");

    new robberyid = Iter_Free(Robberies);
    if(robberyid == ITER_NONE)
        return SendClientMessage(playerid, x_red, "Previse aktivnih pljacki!");

    // Initialize robbery data
    gRobberyData[robberyid][robberyLeader] = playerid;
    gRobberyData[robberyid][robberyStatus] = STATUS_PLANNING;
    gRobberyData[robberyid][robberyLocation] = locationid;
    gRobberyData[robberyid][robberyAlarm] = false;
    gRobberyData[robberyid][robberyMoney] = 0;
    gRobberyData[robberyid][robberyStartTime] = gettime();
    
    // Add leader to members
    gRobberyData[robberyid][robberyMembers][0] = playerid;
    gRobberyData[robberyid][robberyRoles][0] = ROLE_HACKER;
    
    // Update player data
    gPlayerRobbery[playerid][pInRobbery] = true;
    gPlayerRobbery[playerid][pRobberyID] = robberyid;
    gPlayerRobbery[playerid][pRobberyRole] = ROLE_HACKER;
    gPlayerRobbery[playerid][pHackProgress] = 0;
    gPlayerRobbery[playerid][pBagMoney] = 0;
    
    Iter_Add(Robberies, robberyid);
    
    ShowRobberyPlanningDialog(playerid);
    return 1;
}

StartRobberyHeist(robberyid) {
    if(!Iter_Contains(Robberies, robberyid)) return 0;
    
    // Check if all roles are assigned
    new bool:hasHacker = false, bool:hasExplosives = false;
    
    for(new i = 0; i < MAX_ROBBERY_MEMBERS; i++) {
        if(gRobberyData[robberyid][robberyMembers][i] != INVALID_PLAYER_ID) {
            switch(gRobberyData[robberyid][robberyRoles][i]) {
                case ROLE_HACKER: hasHacker = true;
                case ROLE_EXPLOSIVES: hasExplosives = true;
            }
        }
    }
    
    if(!hasHacker || !hasExplosives) {
        SendRobberyMessage(robberyid, x_red, "Potreban je minimum jedan haker i jedan eksplozivac!");
        return 0;
    }
    
    // Start the heist
    gRobberyData[robberyid][robberyStatus] = STATUS_IN_PROGRESS;
    gRobberyData[robberyid][robberyStartTime] = gettime();
    
    // Notify all members
    SendRobberyMessage(robberyid, x_yellow, "* Pljacka je zapocela! Haker mora prvo da hakuje sistem!");
    
    // Start robbery timer (20 minutes)
    gRobberyData[robberyid][robberyTimer] = SetTimerEx("OnRobberyTimeout", 1200000, false, "i", robberyid);
    
    return 1;
}

EndRobbery(robberyid, bool:success) {
    if(!Iter_Contains(Robberies, robberyid)) return 0;
    
    // Update all members' stats
    for(new i = 0; i < MAX_ROBBERY_MEMBERS; i++) {
        new playerid = gRobberyData[robberyid][robberyMembers][i];
        if(playerid != INVALID_PLAYER_ID) {
            if(success) {
                gPlayerRobberyStats[playerid][pSuccessfulRobberies]++;
                gPlayerRobberyStats[playerid][pTotalMoneyStolen] += gPlayerRobbery[playerid][pBagMoney];
                UpdatePlayerRobberyRank(playerid);
            } else {
                gPlayerRobberyStats[playerid][pFailedRobberies]++;
            }
            gPlayerRobberyStats[playerid][pLastRobberyTime] = gettime();
            SavePlayerRobberyStats(playerid);
        }
    }
    
    // Save to database if successful
    if(success) {
        SaveRobberyToDatabase(robberyid);
        DistributeRobberyMoney(robberyid);
    }
    
    // Reset all members
    for(new i = 0; i < MAX_ROBBERY_MEMBERS; i++) {
        new memberid = gRobberyData[robberyid][robberyMembers][i];
        if(memberid != INVALID_PLAYER_ID) {
            ResetPlayerRobberyData(memberid);
        }
    }
    
    // Clear robbery data
    ResetRobberyData(robberyid);
    Iter_Remove(Robberies, robberyid);
    return 1;
}

// ========================================================================
// Role Functions
// ========================================================================

StartHacking(playerid) {
    if(!IsPlayerInRobbery(playerid)) return 0;
    if(gPlayerRobbery[playerid][pRobberyRole] != ROLE_HACKER)
        return SendClientMessage(playerid, x_red, "Nisi haker!");
        
    new robberyid = gPlayerRobbery[playerid][pRobberyID];
    if(gRobberyData[robberyid][robberyStatus] != STATUS_IN_PROGRESS)
        return SendClientMessage(playerid, x_red, "Pljacka jos nije pocela!");

    ShowHackingMinigame(playerid);
    return 1;
}

StartExplosion(playerid) {
    if(!IsPlayerInRobbery(playerid)) return 0;
    if(gPlayerRobbery[playerid][pRobberyRole] != ROLE_EXPLOSIVES)
        return SendClientMessage(playerid, x_red, "Nisi eksplozivac!");
        
    new robberyid = gPlayerRobbery[playerid][pRobberyID];
    if(gRobberyData[robberyid][robberyStatus] != STATUS_IN_PROGRESS)
        return SendClientMessage(playerid, x_red, "Pljacka jos nije pocela!");

    // Check if hacking is complete
    if(gPlayerRobbery[playerid][pHackProgress] < 100)
        return SendClientMessage(playerid, x_red, "Haker mora prvo da zavrsi posao!");

    gPlayerRobbery[playerid][pRobberyTimer] = SetTimerEx("OnExplosionComplete", 
        10000, false, "i", playerid);
    
    ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0);
    SendClientMessage(playerid, x_yellow, "Postavljas eksploziv...");
    return 1;
}

forward OnExplosionComplete(playerid);
public OnExplosionComplete(playerid) {
    if(!IsPlayerConnected(playerid)) return 0;
    if(!IsPlayerInRobbery(playerid)) return 0;
    
    new robberyid = gPlayerRobbery[playerid][pRobberyID];
    
    // Create explosion effect
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    CreateExplosion(x, y, z, 2, 10.0);
    
    SendRobberyMessage(robberyid, x_yellow, "* Eksplozija je otvorila sef!");
    
    // Update robbery status and trigger alarm
    gRobberyData[robberyid][robberyStatus] = STATUS_IN_PROGRESS;
    TriggerAlarm(robberyid);
    
    // Enable money collection for carriers
    EnableMoneyCollection(robberyid);
    return 1;
}

EnableMoneyCollection(robberyid) {
    for(new i = 0; i < MAX_ROBBERY_MEMBERS; i++) {
        new playerid = gRobberyData[robberyid][robberyMembers][i];
        if(playerid != INVALID_PLAYER_ID && gRobberyData[robberyid][robberyRoles][i] == ROLE_CARRIER) {
            SendClientMessage(playerid, x_green, "* Mozete poceti sa skupljanjem novca! (/pokupipare)");
        }
    }
    return 1;
}

forward OnRobberyTimeout(robberyid);
public OnRobberyTimeout(robberyid) {
    if(!Iter_Contains(Robberies, robberyid)) return 0;
    
    SendRobberyMessage(robberyid, x_red, "* Vreme za pljacku je isteklo!");
    EndRobbery(robberyid, false);
    return 1;
}

// ========================================================================
// Commands
// ========================================================================

YCMD:pljacka(playerid, params[], help) {
    if(help) {
        SendClientMessage(playerid, x_green, "Koristi /pljacka da zapocnes pljacku banke.");
        return 1;
    }

    if(!IsPlayerInRangeOfBank(playerid))
        return SendClientMessage(playerid, x_red, "Nisi blizu banke!");
        
    new locationid = GetNearestBankID(playerid);
    StartRobbery(playerid, locationid);
    return 1;
}

YCMD:pozovi(playerid, params[], help) {
    if(!IsRobberyLeader(playerid))
        return SendClientMessage(playerid, x_red, "Nisi vodja pljacke!");
        
    new targetid;
    if(sscanf(params, "u", targetid))
        return SendClientMessage(playerid, x_red, "Koristi: /pozovi [ID/Ime]");
        
    InviteToRobbery(playerid, targetid);
    return 1;
}

YCMD:maska(playerid, params[], help) {
    if(help) {
        SendClientMessage(playerid, x_green, "Koristi /maska da stavis/skines masku.");
        return 1;
    }
    
    if(!HasMaskItem(playerid)) 
        return SendClientMessage(playerid, x_red, "Nemas masku! Kupi je u prodavnici.");
        
    gPlayerRobberyStats[playerid][pWearingMask] = !gPlayerRobberyStats[playerid][pWearingMask];
    
    if(gPlayerRobberyStats[playerid][pWearingMask]) {
        SendClientMessage(playerid, x_green, "* Stavio si masku.");
        SetPlayerAttachedObject(playerid, 1, 19036, 2, 0.1, 0.05, 0.0, 0.0, 90.0, 90.0);
    } else {
        SendClientMessage(playerid, x_green, "* Skinuo si masku.");
        RemovePlayerAttachedObject(playerid, 1);
    }
    return 1;
}

YCMD:hakuj(playerid, params[], help) {
    if(!IsPlayerInRobbery(playerid)) 
        return SendClientMessage(playerid, x_red, "Nisi u pljacki!");
        
    StartHacking(playerid);
    return 1;
}

YCMD:eksploziv(playerid, params[], help) {
    if(!IsPlayerInRobbery(playerid)) 
        return SendClientMessage(playerid, x_red, "Nisi u pljacki!");
        
    StartExplosion(playerid);
    return 1;
}

YCMD:pokupipare(playerid, params[], help) {
    if(!IsPlayerInRobbery(playerid)) 
        return SendClientMessage(playerid, x_red, "Nisi u pljacki!");
    
    if(gPlayerRobbery[playerid][pRobberyRole] != ROLE_CARRIER)
        return SendClientMessage(playerid, x_red, "Nisi nosac!");
        
    CollectMoney(playerid);
    return 1;
}

// ========================================================================
// Dialogs
// ========================================================================

ShowRobberyPlanningDialog(playerid) {
    new string[256];
    format(string, sizeof(string),
        "Zapocni pljacku\n\
        Pozovi clana\n\
        Dodeli uloge\n\
        Status pljacke");
        
    Dialog_Show(playerid, ROBBERY_PLANNING, DIALOG_STYLE_LIST,
        "Planiranje Pljacke",
        string,
        "Izaberi", "Izadji");
}

Dialog:ROBBERY_PLANNING(playerid, response, listitem, string: inputtext[]) {
    if(!response) return 1;
    
    new robberyid = gPlayerRobbery[playerid][pRobberyID];
    
    switch(listitem) {
        case 0: { // Start robbery
            if(GetRobberyMemberCount(robberyid) < 2)
                return SendClientMessage(playerid, x_red, "Potrebno je minimum 2 igraca!");
                
            StartRobberyHeist(robberyid);
        }
        case 1: { // Invite member
            Dialog_Show(playerid, ROBBERY_INVITE, DIALOG_STYLE_INPUT,
                "Pozovi clana",
                "Unesi ID igraca kojeg zelis pozvati:",
                "Pozovi", "Nazad");
        }
        case 2: { // Assign roles
            ShowRoleAssignmentDialog(playerid);
        }
        case 3: { // Status
            ShowRobberyStatus(playerid);
        }
    }
    return 1;
}

Dialog:ROBBERY_INVITE(playerid, response, listitem, string: inputtext[]) {
    if(!response) return ShowRobberyPlanningDialog(playerid);
    
    new targetid = strval(inputtext);
    InviteToRobbery(playerid, targetid);
    return 1;
}

Dialog:ROBBERY_INVITE_RESPONSE(playerid, response, listitem, string: inputtext[]) {
    new robberyid = INVALID_ROBBERY_ID;
    foreach(new i : Robberies) {
        if(gRobberyData[i][robberyInvitedPlayer] == playerid) {
            robberyid = i;
            break;
        }
    }
    
    if(robberyid == INVALID_ROBBERY_ID) return 1;
    
    new inviterid = gRobberyData[robberyid][robberyLeader];
    gRobberyData[robberyid][robberyInvitedPlayer] = INVALID_PLAYER_ID;
    
    if(!response) {
        SendClientMessage(inviterid, x_red, "* %s je odbio poziv za pljacku.", ReturnPlayerName(playerid));
        return 1;
    }
    
    AddPlayerToRobbery(playerid, robberyid);
    return 1;
}

ShowRoleAssignmentDialog(playerid) {
    new robberyid = gPlayerRobbery[playerid][pRobberyID];
    new string[512], name[MAX_PLAYER_NAME];
    
    for(new i = 0; i < MAX_ROBBERY_MEMBERS; i++) {
        new memberid = gRobberyData[robberyid][robberyMembers][i];
        if(memberid != INVALID_PLAYER_ID) {
            new role[32];
            switch(gRobberyData[robberyid][robberyRoles][i]) {
                case ROLE_HACKER: role = "Haker";
                case ROLE_EXPLOSIVES: role = "Eksplozivac";
                case ROLE_GUARD: role = "Cuvar";
                case ROLE_CARRIER: role = "Nosac";
                default: role = "Nije dodeljena";
            }
            format(string, sizeof(string), "%s%s (%s)\n", string, ReturnPlayerName(memberid), role);
        }
    }
    
    Dialog_Show(playerid, ROBBERY_ROLES, DIALOG_STYLE_LIST,
        "Dodela Uloga",
        string,
        "Izaberi", "Nazad");
}

Dialog:ROBBERY_ROLES(playerid, response, listitem, string: inputtext[]) {
    if(!response) return ShowRobberyPlanningDialog(playerid);
    
    new robberyid = gPlayerRobbery[playerid][pRobberyID];
    new targetid = gRobberyData[robberyid][robberyMembers][listitem];
    
    gRobberyData[robberyid][robberyRoleTarget] = targetid;
    
    Dialog_Show(playerid, ROBBERY_ROLES_ASSIGN, DIALOG_STYLE_LIST,
        "Izaberi ulogu",
        "Haker\n\
        Eksplozivac\n\
        Cuvar\n\
        Nosac",
        "Izaberi", "Nazad");
    return 1;
}

Dialog:ROBBERY_ROLES_ASSIGN(playerid, response, listitem, string: inputtext[]) {
    if(!response) return ShowRoleAssignmentDialog(playerid);
    
    new robberyid = gPlayerRobbery[playerid][pRobberyID];
    new targetid = gRobberyData[robberyid][robberyRoleTarget];
    gRobberyData[robberyid][robberyRoleTarget] = INVALID_PLAYER_ID;
    
    AssignRobberyRole(targetid, robberyid, listitem);
    ShowRoleAssignmentDialog(playerid);
    return 1;
}

// ========================================================================
// SQL Functions
// ========================================================================

LoadPlayerRobberyStats(playerid) {
    new query[128];
    mysql_format(SQL, query, sizeof(query), 
        "SELECT * FROM player_robbery_stats WHERE player_id = %d", 
        GetPlayerAccountID(playerid)
    );
    mysql_tquery(SQL, query, "OnPlayerRobberyStatsLoad", "i", playerid);
}

forward OnPlayerRobberyStatsLoad(playerid);
public OnPlayerRobberyStatsLoad(playerid) {
    if(!IsPlayerConnected(playerid)) return 0;
    
    if(cache_num_rows() > 0) {
        gPlayerRobberyStats[playerid][pSuccessfulRobberies] = cache_get_field_content_int(0, "successful_robberies");
        gPlayerRobberyStats[playerid][pFailedRobberies] = cache_get_field_content_int(0, "failed_robberies");
        gPlayerRobberyStats[playerid][pTotalMoneyStolen] = cache_get_field_content_int(0, "total_money_stolen");
        UpdatePlayerRobberyRank(playerid);
    } else {
        // Create new record
        new query[128];
        mysql_format(SQL, query, sizeof(query), 
            "INSERT INTO player_robbery_stats (player_id) VALUES (%d)",
            GetPlayerAccountID(playerid)
        );
        mysql_tquery(SQL, query);
    }
    return 1;
}

SavePlayerRobberyStats(playerid) {
    new query[256];
    mysql_format(SQL, query, sizeof(query), 
        "UPDATE player_robbery_stats SET successful_robberies = %d, failed_robberies = %d, \
        total_money_stolen = %d WHERE player_id = %d",
        gPlayerRobberyStats[playerid][pSuccessfulRobberies],
        gPlayerRobberyStats[playerid][pFailedRobberies],
        gPlayerRobberyStats[playerid][pTotalMoneyStolen],
        GetPlayerAccountID(playerid)
    );
    mysql_tquery(SQL, query);
}

SaveRobberyToDatabase(robberyid) {
    new query[512], members[128], money;
    
    // Get members string
    GetRobberyMembersString(robberyid, members, sizeof(members));
    
    // Calculate total money stolen
    for(new i = 0; i < MAX_ROBBERY_MEMBERS; i++) {
        new playerid = gRobberyData[robberyid][robberyMembers][i];
        if(playerid != INVALID_PLAYER_ID) {
            money += gPlayerRobbery[playerid][pBagMoney];
        }
    }
    
    mysql_format(SQL, query, sizeof(query), 
        "INSERT INTO robbery_history (location_id, leader_id, members, total_money, date) \
        VALUES (%d, %d, '%e', %d, NOW())",
        gRobberyData[robberyid][robberyLocation],
        gRobberyData[robberyid][robberyLeader],
        members,
        money
    );
    mysql_tquery(SQL, query);
}

LoadRobberyHistory() {
    mysql_tquery(SQL, "SELECT * FROM robbery_history ORDER BY date DESC LIMIT 10", "OnRobberyHistoryLoad");
}

forward OnRobberyHistoryLoad();
public OnRobberyHistoryLoad() {
    // You can implement this to show recent robberies on a board or something
    return 1;
}

// ========================================================================
// Reset Functions
// ========================================================================

ResetPlayerRobberyData(playerid) {
    gPlayerRobbery[playerid][pInRobbery] = false;
    gPlayerRobbery[playerid][pRobberyID] = INVALID_ROBBERY_ID;
    gPlayerRobbery[playerid][pRobberyRole] = -1;
    gPlayerRobbery[playerid][pHackProgress] = 0;
    gPlayerRobbery[playerid][pBagMoney] = 0;
    KillTimer(gPlayerRobbery[playerid][pRobberyTimer]);
}

ResetRobberyData(robberyid) {
    gRobberyData[robberyid][robberyLeader] = INVALID_PLAYER_ID;
    gRobberyData[robberyid][robberyStatus] = STATUS_NONE;
    gRobberyData[robberyid][robberyStartTime] = 0;
    gRobberyData[robberyid][robberyMoney] = 0;
    gRobberyData[robberyid][robberyLocation] = -1;
    gRobberyData[robberyid][robberyAlarm] = false;
    gRobberyData[robberyid][robberyInvitedPlayer] = INVALID_PLAYER_ID;
    gRobberyData[robberyid][robberyRoleTarget] = INVALID_PLAYER_ID;
    
    for(new i = 0; i < MAX_ROBBERY_MEMBERS; i++) {
        gRobberyData[robberyid][robberyMembers][i] = INVALID_PLAYER_ID;
        gRobberyData[robberyid][robberyRoles][i] = -1;
    }
    
    KillTimer(gRobberyData[robberyid][robberyTimer]);
}

// ========================================================================
// Hooks
// ========================================================================

hook OnGameModeInit() {
    print("[Robbery] System initializing...");
    
    // Create required tables if they don't exist
    mysql_tquery(SQL, "CREATE TABLE IF NOT EXISTS player_robbery_stats (\
        player_id INT PRIMARY KEY,\
        successful_robberies INT DEFAULT 0,\
        failed_robberies INT DEFAULT 0,\
        total_money_stolen INT DEFAULT 0,\
        FOREIGN KEY (player_id) REFERENCES players(id)\
    )");
    
    mysql_tquery(SQL, "CREATE TABLE IF NOT EXISTS robbery_history (\
        id INT AUTO_INCREMENT PRIMARY KEY,\
        location_id INT,\
        leader_id INT,\
        members VARCHAR(128),\
        total_money INT,\
        date DATETIME,\
        FOREIGN KEY (leader_id) REFERENCES players(id)\
    )");
    
    LoadRobberyHistory();
    return 1;
}

hook OnPlayerConnect(playerid) {
    ResetPlayerRobberyData(playerid);
    LoadPlayerRobberyStats(playerid);
    return 1;
}

hook OnPlayerDisconnect(playerid, reason) {
    if(gPlayerRobbery[playerid][pInRobbery]) {
        new robberyid = gPlayerRobbery[playerid][pRobberyID];
        RemoveFromRobbery(playerid, robberyid);
    }
    SavePlayerRobberyStats(playerid);
    return 1;
}

hook OnPlayerDeath(playerid, killerid, reason) {
    if(gPlayerRobbery[playerid][pInRobbery]) {
        new robberyid = gPlayerRobbery[playerid][pRobberyID];
        RemoveFromRobbery(playerid, robberyid);
        
        if(gPlayerRobbery[playerid][pBagMoney] > 0) {
            CreateMoneyBag(playerid, gPlayerRobbery[playerid][pBagMoney]);
            gPlayerRobbery[playerid][pBagMoney] = 0;
        }
    }
    return 1;
}

// ========================================================================
// Camera Detection System
// ========================================================================

CheckCameraDetection(playerid) {
    if(!IsPlayerInRobbery(playerid)) return 0;
    if(gPlayerRobberyStats[playerid][pWearingMask]) return 0; // Can't be detected with mask
    
    new Float:px, Float:py, Float:pz;
    GetPlayerPos(playerid, px, py, pz);
    
    for(new i = 0; i < sizeof(gBankCameras); i++) {
        if(GetPlayerDistanceFromPoint(playerid, 
            gBankCameras[i][0], 
            gBankCameras[i][1], 
            gBankCameras[i][2]) < CAMERA_DETECTION_RANGE) {
            
            // Alert police
            foreach(new cop : Player) {
                if(IsPlayerCop(cop)) {
                    SendClientMessage(cop, x_blue, "DISPATCH: Kamera je identifikovala %s u pljacki banke!", ReturnPlayerName(playerid));
                }
            }
            return 1;
        }
    }
    return 0;
}
