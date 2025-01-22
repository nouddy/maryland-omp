// Bank Heist System
// Roles and responsibilities for each team member

enum E_HEIST_ROLES {
    ROLE_LEADER,
    ROLE_HACKER, 
    ROLE_DRIVER,
    ROLE_DEMOLITIONS,
    ROLE_INFILTRATOR,
    ROLE_ENFORCER
}

enum E_HEIST_PHASES {
    PHASE_PLANNING,
    PHASE_EXECUTION,
    PHASE_ESCAPE
}

static HeistRole[MAX_PLAYERS];
static HeistPhase = PHASE_PLANNING;
static bool:HeistActive = false;
static HeistLeader = INVALID_PLAYER_ID;

// Bank layout coordinates
static Float:BankPositions[][] = {
    {1457.3, -1011.8, 26.8}, // Lobby
    {1458.7, -1009.2, 26.8}, // Vault
    {1456.1, -1013.4, 26.8}, // Security Room
    {1459.9, -1008.1, 26.8}  // Manager's Office
};

forward StartBankHeist(playerid);
public StartBankHeist(playerid) {
    if(HeistActive) return SendClientMessage(playerid, x_server, "maryland \187; "c_white"A heist is already in progress!");
    
    HeistActive = true;
    HeistLeader = playerid;
    HeistPhase = PHASE_PLANNING;
    HeistRole[playerid] = ROLE_LEADER;
    
    SendClientMessage(playerid, x_server, "maryland \187; "c_white"You have initiated a bank heist! Use /assignrole to set up your team.");
}

forward AssignHeistRole(playerid, targetid, role);
public AssignHeistRole(playerid, targetid, role) {
    if(!HeistActive) return SendClientMessage(playerid, x_server, "maryland \187; "c_white"No heist is currently active!");
    if(playerid != HeistLeader) return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Only the heist leader can assign roles!");
    
    HeistRole[targetid] = role;
    
    new roleStr[32];
    switch(role) {
        case ROLE_HACKER: roleStr = "Hacker";
        case ROLE_DRIVER: roleStr = "Driver";
        case ROLE_DEMOLITIONS: roleStr = "Demolitions Expert";
        case ROLE_INFILTRATOR: roleStr = "Infiltrator";
        case ROLE_ENFORCER: roleStr = "Enforcer";
    }
    
    SendClientMessage(targetid, x_server, "maryland \187; "c_white"You have been assigned the role of %s", roleStr);
}

forward StartHeistPhase(phase);
public StartHeistPhase(phase) {
    HeistPhase = phase;
    
    switch(phase) {
        case PHASE_PLANNING: {
            // Send briefing messages to all participants
            foreach(new i : Player) {
                if(HeistRole[i] != INVALID_PLAYER_ID) {
                    SendClientMessage(i, x_server, "maryland \187; "c_white"Planning phase has begun. Study the bank layout and prepare your equipment.");
                }
            }
        }
        case PHASE_EXECUTION: {
            // Start the actual heist
            SetTimer("MonitorHeistProgress", 1000, true);
            foreach(new i : Player) {
                if(HeistRole[i] != INVALID_PLAYER_ID) {
                    SendClientMessage(i, x_server, "maryland \187; "c_white"Execution phase has begun. Move into position!");
                }
            }
        }
        case PHASE_ESCAPE: {
            // Trigger escape sequence
            foreach(new i : Player) {
                if(HeistRole[i] != INVALID_PLAYER_ID) {
                    SendClientMessage(i, x_server, "maryland \187; "c_white"Escape phase initiated! Get to the escape vehicle!");
                }
            }
        }
    }
}

forward MonitorHeistProgress();
public MonitorHeistProgress() {
    if(!HeistActive) return 0;
    
    // Check for police presence
    new policeCount = 0;
    foreach(new i : Player) {
        if(IsPlayerPoliceMember(i)) {
            policeCount++;
        }
    }
    
    // Trigger random events based on roles
    switch(random(5)) {
        case 0: { // Security system malfunction
            if(HeistPhase == PHASE_EXECUTION) {
                foreach(new i : Player) {
                    if(HeistRole[i] == ROLE_HACKER) {
                        SendClientMessage(i, x_server, "maryland \187; "c_white"Alert: Security system detected anomaly! Quick, bypass it!");
                    }
                }
            }
        }
        case 1: { // Unexpected guard patrol
            if(HeistPhase == PHASE_EXECUTION) {
                foreach(new i : Player) {
                    if(HeistRole[i] == ROLE_INFILTRATOR) {
                        SendClientMessage(i, x_server, "maryland \187; "c_white"Warning: Guard patrol approaching! Find cover!");
                    }
                }
            }
        }
    }
    
    return 1;
}