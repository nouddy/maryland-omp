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
 *  @Author         Noddy
 *  @Github         (github.com/vosticdev) & (github.com/nouddy)
 *  @Date           01 Nov 2024
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           drugs.pwn
 *  @Module         illegal
 */


#include <ysilib\YSI_Coding\y_hooks>

#define MAX_TURFS            10
#define GANG_TURF_BONUS      2300
#define GANG_TURF_CAPTURED_COLOR     "FF0055"
#define GANG_TURF_FREE_COLOR         "FFFFFF"

enum E_GANG_TURF_PERK {

    GANG_TURF_PERK_UNKNOWN,
    GANG_TURF_PERK_MATERIALS,
    GANG_TURF_PERK_MONEY,
    GANG_TURF_PERK_DRUGS
}

static TurfPerks[E_GANG_TURF_PERK][32] = {

    "Unknown",
    "Materials",
    "Money",
    "Drugs"
};



enum E_GANG_TURF_INFO {

    gtID,
    gtLeadership, //* Samo fakcije mogu zauzimati zone (SQLID Fakcije!)
    bool:gtCaptureStatus,
    gtCaptureProgress,  //* Capture - Slicno overwatchu, prije samog zvanicnog zauzimanja mora se odraditi capture koji traje 2.30m (pokusaj zauzimanja)
    bool:gtActive,         //* Zona je aktivna i zauzima se (uspjesan capture)
    E_GANG_TURF_PERK:gtPerkType,

    Float:gtPosition[4],
    Float:gtCapturePos[3],
    gtColour[32]

}

new GangTurf[MAX_TURFS][E_GANG_TURF_INFO],
    Iterator:iter_Turfs<MAX_TURFS>,
    GangTurfZone[MAX_TURFS],  //* Visual presentation of turf [on map]
    GangTurfPickup[MAX_TURFS],
    Text3D:GangTurfLabel[MAX_TURFS],
    GangTurfCooldown[MAX_TURFS],
    GangTurfOccupier[MAX_TURFS];

static Float:gt_temp_min_x;
static Float:gt_temp_max_x;
static Float:gt_temp_min_y;
static Float:gt_temp_max_y;

static Float:g_SZFirstPos[MAX_PLAYERS][2];
static bool:g_PlayerCreatingTurf[MAX_PLAYERS];
static g_TurfProgress[MAX_PLAYERS];

static Timer_GangTurfCapture[MAX_TURFS];
static Timer_GangTurfOccupier[MAX_PLAYERS];

static GangTurfOccupier_Counter[MAX_PLAYERS];

forward mysql_LoadGangTurfs();
public mysql_LoadGangTurfs() {

    new rows = cache_num_rows();
    if(!rows) return (true);

    for(new i = 0; i < rows; i++) {

        cache_get_value_name_int(i, "turf_id", GangTurf[i][gtID]);
        cache_get_value_name_int(i, "turf_faction", GangTurf[i][gtLeadership]);
        cache_get_value_name_int(i, "turf_perk", _:GangTurf[i][gtPerkType]);

        cache_get_value_name_float(i, "turf_minX", GangTurf[i][gtPosition][0]);
        cache_get_value_name_float(i, "turf_minY", GangTurf[i][gtPosition][1]);
        cache_get_value_name_float(i, "turf_maxX", GangTurf[i][gtPosition][2]);
        cache_get_value_name_float(i, "turf_maxY", GangTurf[i][gtPosition][3]);

        cache_get_value_name_float(i, "turf_captureX", GangTurf[i][gtCapturePos][0]);
        cache_get_value_name_float(i, "turf_captureY", GangTurf[i][gtCapturePos][1]);
        cache_get_value_name_float(i, "turf_captureZ", GangTurf[i][gtCapturePos][2]);

        SanitizeGangZoneCoords(GangTurf[i][gtPosition][0], GangTurf[i][gtPosition][1], GangTurf[i][gtPosition][2], GangTurf[i][gtPosition][3]);

        cache_get_value_name(i, "turf_color", GangTurf[i][gtColour], 32);

        Iter_Add(iter_Turfs, i);

        static gt_col[32];
        format( gt_col, sizeof gt_col, "0x%sFF", GangTurf[i][gtColour] );

        GangTurfPickup[i] = CreateDynamicPickup(2035, 1, GangTurf[i][gtCapturePos][0], GangTurf[i][gtCapturePos][1], GangTurf[i][gtCapturePos][2]);
        GangTurfZone[i] = GangZone_Create(GangTurf[i][gtPosition][0], GangTurf[i][gtPosition][1], GangTurf[i][gtPosition][2], GangTurf[i][gtPosition][3], GangTurf[i][gtID]);
        GangZone_ShowForAll(GangTurfZone[i], HexToInt(gt_col));
        
        static tmp_str[458];
        format(tmp_str, sizeof tmp_str, ""c_server"\187; "c_white"Gang Turf[%d] "c_server"\171;\n\187; "c_white"In Possession : %s "c_server"\171; \n\
                                        \187; "c_white"Perk : "c_server"%s \171; \n\
                                        /capture", GangTurf[i][gtID], GangTurf_FormatLeadershipName(i), TurfPerks[ GangTurf[i][gtPerkType] ]);
        GangTurfLabel[i] = Create3DTextLabel(tmp_str, -1, GangTurf[i][gtCapturePos][0], GangTurf[i][gtCapturePos][1], GangTurf[i][gtCapturePos][2], 3.50, 0);
        KillTimer(Timer_GangTurfCapture[i]);
        GangTurfOccupier[i] = INVALID_PLAYER_ID;
    }

    printf("GANG-TURF: Ucitano %d zoni!", Iter_Count(iter_Turfs));    

    return (true);
}

forward mysql_CreateGangTurf(turf_idx);
public mysql_CreateGangTurf(turf_idx) {

    GangTurf[turf_idx][gtID] = cache_insert_id();
    Iter_Add(iter_Turfs, turf_idx);

    static gt_col[32];
    format( gt_col, sizeof gt_col, "0x%sFF", GangTurf[turf_idx][gtColour] );

    GangTurfZone[turf_idx] = GangZone_Create(GangTurf[turf_idx][gtPosition][0], GangTurf[turf_idx][gtPosition][1], GangTurf[turf_idx][gtPosition][2], GangTurf[turf_idx][gtPosition][3], GangTurf[turf_idx][gtID]);
    GangZone_ShowForAll(GangTurfZone[turf_idx], HexToInt(gt_col));

    static tmp_str[458];
    format(tmp_str, sizeof tmp_str, ""c_server"\187; "c_white"Gang Turf[%d] "c_server"\171;\n\187; "c_white"In Possession : %s "c_server"\171; \n\
                                    \187; "c_white"Perk : "c_server"%s \171; \n\
                                    /capture", GangTurf[turf_idx][gtID], GangTurf_FormatLeadershipName(turf_idx), TurfPerks[ GangTurf[turf_idx][gtPerkType] ]);
    GangTurfLabel[turf_idx] = Create3DTextLabel(tmp_str, -1, GangTurf[turf_idx][gtCapturePos][0], GangTurf[turf_idx][gtCapturePos][1], GangTurf[turf_idx][gtCapturePos][2], 3.50, 0);

    GangTurfPickup[turf_idx] = CreateDynamicPickup(2035, 1, GangTurf[turf_idx][gtCapturePos][0], GangTurf[turf_idx][gtCapturePos][1], GangTurf[turf_idx][gtCapturePos][2]);
    
    return (true);
}

forward GangTurf_UpdateOccupierProgress(playerid);
public GangTurf_UpdateOccupierProgress(playerid) {

    if(GangTurfOccupier_Counter[playerid] > 0) {

        KillTimer(Timer_GangTurfOccupier[ playerid ]);
        GangTurfOccupier_Counter[playerid]--;
        Timer_GangTurfOccupier[ playerid ] = SetTimerEx("GangTurf_UpdateOccupierProgress", 1000, false, "d", playerid);
        GameTextForPlayer(playerid, "CAPTURE TIME : %d", 1000, 3, GangTurfOccupier_Counter[playerid]);
        return ~1;
    }

    else if(GangTurfOccupier_Counter[playerid] <= 0) {

        KillTimer(Timer_GangTurfOccupier[playerid]);
        GameTextForPlayer(playerid, "~g~GANG TURF CAPTURED", 3000, 3);

        foreach(new j : Player) {

            if(FactionMember[j][factionID] == FactionMember[playerid][factionID]) {

                SendClientMessage(j, x_grey, "GANG-TURF: %s[%d] je uspjesno zauzeo gang turf!", ReturnCharacterName(playerid), playerid);
            }
        }

        foreach(new i : iter_Turfs) {

            if(GangTurfOccupier[i] == playerid) {
                
                foreach(new x : Player) {

                    if(FactionMember[x][factionID] == GangTurf[i][gtLeadership] && FactionMember[x][factionID] != 0 ) {
                        
                        SendClientMessage(x, x_grey, "GANG-TURF: "c_white"Suprotnicka banda vam je zauzela Gang Turf [%d]", GangTurf[i][gtID]);

                        break;
                    }
                }

                GangTurf[i][gtActive] = false;
                GangTurf[i][gtCaptureStatus] = false;
                GangTurf[i][gtLeadership] = FactionMember[playerid][factionID];
                GangTurfOccupier[i] = INVALID_PLAYER_ID;
                GangTurfCooldown[i] = gettime() + 300; //* 5 minutos
                GangZone_StopFlashForAll(GangTurfZone[i]);
                GangZone_ShowForAll(GangTurfZone[i], 0xFF0055FF);
                break;
            }
         }

        return ~1;
    }

    return (true);
}

forward GangTurf_UpdateCaptureStatus(turf_id);
public GangTurf_UpdateCaptureStatus(turf_id) {
    
    if(GangTurf[turf_id][gtCaptureProgress] > 0) {

        KillTimer(Timer_GangTurfCapture[turf_id]);
        GangTurf[turf_id][gtCaptureProgress]--;
        Timer_GangTurfCapture[turf_id] = SetTimerEx("GangTurf_UpdateCaptureStatus", 1000, false, "d", turf_id);
        return ~1;
    }

    else if(GangTurf[turf_id][gtCaptureProgress] <= 0) {

        KillTimer(Timer_GangTurfCapture[turf_id]);
        GangTurf[turf_id][gtCaptureProgress] = 0;
        GangTurf[turf_id][gtCaptureStatus] = false;
        GangTurf[turf_id][gtActive] = true;

        foreach(new i : Player) {

            if(FactionMember[i][factionID] == FactionMember[GangTurfOccupier[turf_id]][factionID]) {

                SendClientMessage(i, x_grey, "GANG-TURF: "c_white"Zona %d je uspjesno capture-ovana.", GangTurf[turf_id][gtID]);
                SendClientMessage(i, x_grey, "GANG-TURF: "c_white"Napadac zone mora ostati ziv 5 minuta kako biste uspjesno preuzeli turf.");
            }
        }

        GangTurfOccupier_Counter[ GangTurfOccupier[turf_id] ] = 300;
        Timer_GangTurfOccupier[ GangTurfOccupier[turf_id] ] = SetTimerEx("GangTurf_UpdateOccupierProgress", 1000, false, "d", GangTurfOccupier[turf_id]);

        return ~1;
    }


    return (true);
}

stock Turf_IsPlayerNearCapturePoint(playerid) {

    foreach(new i : iter_Turfs) {

        if(IsPlayerInRangeOfPoint(playerid, 3.0, GangTurf[i][gtCapturePos][0], GangTurf[i][gtCapturePos][1], GangTurf[i][gtCapturePos][2] ))
            return i;
    }

    return -1;
}

hook OnGameModeInit() {

    mysql_tquery(SQL, "SELECT * FROM `turfs`","mysql_LoadGangTurfs");

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerConnect(playerid) {

    g_PlayerCreatingTurf[playerid] = false;
    g_SZFirstPos[playerid][0] = 0.0;
    g_SZFirstPos[playerid][1] = 0.0;
    g_TurfProgress[playerid] = 0;

    KillTimer(Timer_GangTurfOccupier[playerid]);

    foreach(new i : iter_Turfs) {
        
        static gt_col[32];
        format(gt_col, sizeof gt_col, "0x%sFF", GangTurf[i][gtColour]);
        GangZoneShowForPlayer(playerid, GangTurfZone[i], HexToInt(gt_col));
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
    if((newkeys & KEY_YES) && g_PlayerCreatingTurf[playerid]) // Y key
    {
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        
        if(g_SZFirstPos[playerid][0] == 0.0) // Prvi klik
        {
            g_SZFirstPos[playerid][0] = x;
            g_SZFirstPos[playerid][1] = y;
            g_TurfProgress[playerid] = 1;
            SendServerMessage(playerid, "Sacuvali ste prvu poziciju, idite do druge i pritisnite 'Y'");
            return Y_HOOKS_CONTINUE_RETURN_1;
        }
        if(g_TurfProgress[playerid] == 1) // Drugi klik
        {

            
            // Sortiraj koordinate
            gt_temp_min_x = floatmin(g_SZFirstPos[playerid][0], x);
            gt_temp_max_x = floatmax(g_SZFirstPos[playerid][0], x);
            gt_temp_min_y = floatmin(g_SZFirstPos[playerid][1], y);
            gt_temp_max_y = floatmax(g_SZFirstPos[playerid][1], y);
            
            g_TurfProgress[playerid] = 2;
            
            SendServerMessage(playerid, "Otidjite do zeljene pozicije kako biste postavili "c_server"Capture Pickup!");
            return Y_HOOKS_CONTINUE_RETURN_1;
        }

        if(g_TurfProgress[playerid] == 2) {


            Dialog_Show(playerid, "dialog_TurfPerk", DIALOG_STYLE_LIST, "Gang Turfs", "\187; Materials\n\187; Money \n\187; Drugs", "Chose", "Delete");

        }

    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerLeaveGangZone(playerid, zoneid) {

    foreach(new i : iter_Turfs) {

        if(GangTurfZone[i] == zoneid) {

            if(GangTurfOccupier[i] == playerid && GangTurf[i][gtActive]) {

                KillTimer(Timer_GangTurfCapture[i]);
                KillTimer(Timer_GangTurfOccupier[playerid]);
                GangZone_StopFlashForAll(GangTurfZone[i]);

                GangTurf[i][gtActive] = false;
                GangTurf[i][gtCaptureProgress] = -1;
                GangTurf[i][gtCaptureStatus] = false;
                GangTurfOccupier[i] = INVALID_PLAYER_ID;
                GangTurfCooldown[i] = gettime() + 180;
                foreach(new j : Player) {

                    if(FactionMember[playerid][factionID] == FactionMember[j][factionID]) {

                        SendClientMessage(j, x_grey, "GANG-TURF: "c_white"Napadac %s[%d] je napusio zonu, te je zauzimanje propalo!");
                    }
                }

                foreach(new x : Player) {

                    if(FactionMember[x][factionID] == GangTurf[i][gtLeadership] && FactionMember[x][factionID] != 0 ) {
                        
                        SendClientMessage(x, x_grey, "GANG-TURF: "c_white"Suprotnicka banda nije uspjela zauzeti Gang Turf [%d] | "c_ltorange"NAPUSTANJE TURF-A", GangTurf[i][gtID]);

                        break;
                    }
                }

                return Y_HOOKS_BREAK_RETURN_1;
            }

            else if(GangTurfOccupier[i] == playerid && GangTurf[i][gtCaptureStatus]) {

                KillTimer(Timer_GangTurfCapture[i]);
                GangZone_StopFlashForAll(GangTurfZone[i]);

                GangTurf[i][gtCaptureStatus] = false;
                GangTurf[i][gtCaptureProgress] = -1;
                GangTurfCooldown[i] = gettime() + 180;
                foreach(new x : Player) {

                    if(FactionMember[x][factionID] == GangTurf[i][gtLeadership] && FactionMember[x][factionID] != 0 ) {
                        
                        SendClientMessage(x, x_grey, "GANG-TURF: "c_white"Suprotnicka banda nije uspjela capture-ovati Gang Turf [%d] | "c_ltorange"NAPUSTANJE TURF-A", GangTurf[i][gtID]);

                        break;
                    }
                }

                return Y_HOOKS_BREAK_RETURN_1;
            }
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerDeath(playerid, killerid, reason)
{

    foreach(new i : iter_Turfs) {

        if(GangTurfOccupier[i] == playerid && GangTurf[i][gtActive]) {

            KillTimer(Timer_GangTurfCapture[i]);
            KillTimer(Timer_GangTurfOccupier[playerid]);
            GangZone_StopFlashForAll(GangTurfZone[i]);

            GangTurf[i][gtActive] = false;
            GangTurf[i][gtCaptureProgress] = -1;
            GangTurf[i][gtCaptureStatus] = false;
            GangTurfOccupier[i] = INVALID_PLAYER_ID;
            GangTurfCooldown[i] = gettime() + 180;
            foreach(new j : Player) {

                if(FactionMember[playerid][factionID] == FactionMember[j][factionID]) {

                    SendClientMessage(j, x_grey, "GANG-TURF: "c_white"Napadac %s[%d] je poginuo, te je zauzimanje propalo!");
                }
            }

            foreach(new x : Player) {

                if(FactionMember[x][factionID] == GangTurf[i][gtLeadership] && FactionMember[x][factionID] != 0 ) {
                    
                    SendClientMessage(x, x_grey, "GANG-TURF: "c_white"Suprotnicka banda nije uspjela zauzeti Gang Turf [%d] | "c_ltorange"NAPADAC UBIJEN", GangTurf[i][gtID]);

                    break;
                }
            }

            return Y_HOOKS_BREAK_RETURN_1;
        }

        else if(GangTurfOccupier[i] == playerid && GangTurf[i][gtCaptureStatus]) {

            KillTimer(Timer_GangTurfCapture[i]);
            GangZone_StopFlashForAll(GangTurfZone[i]);

            GangTurf[i][gtCaptureStatus] = false;
            GangTurf[i][gtCaptureProgress] = -1;
            GangTurfCooldown[i] = gettime() + 180;
            foreach(new x : Player) {

                if(FactionMember[x][factionID] == GangTurf[i][gtLeadership] && FactionMember[x][factionID] != 0 ) {
                    
                    SendClientMessage(x, x_grey, "GANG-TURF: "c_white"Suprotnicka banda nije uspjela capture-ovati Gang Turf [%d] | "c_ltorange"NAPDAC UBIJEN", GangTurf[i][gtID]);
                    break;
                }
            }

            return Y_HOOKS_BREAK_RETURN_1;
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;

}

YCMD:createturf(playerid, params[], help) {

    if(!IsPlayerAdmin(playerid))
        return SendServerMessage(playerid, "Samo RCON Admin moze ovo!");

    if(g_PlayerCreatingTurf[playerid])
        return SendServerMessage(playerid, "Vec pravite gang turf!");

    SendServerMessage(playerid, "Zapoceli ste kreiranje gang turf-a (zone). Otidjite do zeljene pozicije i pritsinite 'Y'");
    g_PlayerCreatingTurf[playerid] = true;
    return (true);
}

YCMD:gotozona(playerid, params[], help) = gototurf;
YCMD:gototurf(playerid, params[], help) 
{
    
    if(GetPlayerStaffLevel(playerid) < 2)
        return SendServerMessage(playerid, "Niste u mogucnosti koristiti ovu komandu!");

    new zoneID;
    if(sscanf(params, "d", zoneID))
        return SendServerMessage(playerid, "/gototurf <zona>");

    static bool:foundZone = false;
    new tmp_zone_idx;

    foreach(new i : iter_Turfs) {

        if(GangTurf[i][gtID] == zoneID)
        {
            foundZone = true;
            tmp_zone_idx = i;
            break;
        }
    }

    if(!foundZone)
        return SendServerMessage(playerid, "Unijeli ste krivi ID zone!");

    SetPlayerCompensatedPos(playerid, GangTurf[tmp_zone_idx][gtCapturePos][0], GangTurf[tmp_zone_idx][gtCapturePos][1], GangTurf[tmp_zone_idx][gtCapturePos][2], 0, 0);
    return 1;
}

YCMD:capture(playerid, params[], help) {

    new turf_id = Turf_IsPlayerNearCapturePoint(playerid);

    if(turf_id == -1)
        return SendServerMessage(playerid, "Ne nalazite se blizu capture pointa!");

    if(FactionMember[playerid][factionID] == 0)
        return SendServerMessage(playerid, "Ne mozete zapoceti zauzimanje zone, niste clan fakcije!");

    if( GangTurf[turf_id][gtCaptureStatus] )
        return SendServerMessage(playerid, "Ova teritorija je vec pod capture-om!");

    if( GangTurf[turf_id][gtActive] )
        return SendServerMessage(playerid, "Ovaj turf je pod napadom!");

    if( GangTurfCooldown[turf_id] > gettime() )
        return SendServerMessage(playerid, "Ova teritorija se moze zauzimati za %s", convertTime(GangTurfCooldown[turf_id] - gettime()));

    if( GangTurf[turf_id][gtLeadership] == FactionMember[playerid][factionID] )
        return SendServerMessage(playerid, "Ne mozete zapoceti zauziamnje zone koja je u vlasnistvu vase fakcije!");

    static faction_members = 0;

    foreach(new i : Player) {

        if(FactionMember[i][factionID] == FactionMember[playerid][factionID]) 
            faction_members++;
    }

    if(faction_members < 2)
        return SendServerMessage(playerid, "Za zauzimanje gang turf-a morate imati bar 3 aktivna clana iz fakcije!");

    if(GangTurf[turf_id][gtLeadership] != 0) {

        foreach(new j : Player) {

            if(GangTurf[turf_id][gtLeadership] == FactionMember[j][factionID]) 
                SendClientMessage(j, x_grey, "GANG-TURF: "c_white"Clan suportnicke fakcije je zapoceo capture gang turf-a [%d]", GangTurf[turf_id][gtID]);
        }
    }

    GangTurf[turf_id][gtCaptureStatus] = true;
    GangTurf[turf_id][gtCaptureProgress] = 120;

    foreach(new k : Player) {

        if(FactionMember[k][factionID] == FactionMember[playerid][factionID]) {

            SendServerMessage(k, "%s[%d] je zapoceo capture zone [%d]", ReturnCharacterName(playerid), playerid, GangTurf[turf_id][gtID]);
            SendServerMessage(k, "Ukoliko %s[%d] napusti zonu, capture propada.", ReturnCharacterName(playerid), playerid);
        }
    }


    GangZone_FlashForAll(GangTurfZone[turf_id], 0xFF0055FF);
    printf("DEBUG: Trying to flash gang zone %d", GangTurfZone[turf_id]);
    Timer_GangTurfCapture[turf_id] = SetTimerEx("GangTurf_UpdateCaptureStatus", 1000, false, "d", turf_id);

    GangTurfOccupier[turf_id] = playerid;

    return (true);
}

Dialog:dialog_TurfPerk(playerid, response, listitem, string:inputtext[]) {

    if(response) {


        new turf_idx = Iter_Free(iter_Turfs);
        new E_GANG_TURF_PERK:turf_perk = E_GANG_TURF_PERK:( listitem + 1 );

        new Float:pPos[3];
        GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);

        strmid(GangTurf[turf_idx][gtColour], "FFFFFF", 0, 32);

        new query[568];

        mysql_format(SQL, query, sizeof query, 
            "INSERT INTO `turfs` (`turf_faction`, `turf_perk`, `turf_minX`, `turf_minY`, `turf_maxX`, `turf_maxY`, `turf_captureX`, `turf_captureY`, `turf_captureZ`, `turf_color`) VALUES ('0', '%d', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%e')",
            _:turf_perk, gt_temp_min_x, gt_temp_min_y, gt_temp_max_x, gt_temp_max_y, pPos[0], pPos[1], pPos[2], GangTurf[turf_idx][gtColour]
        );

        mysql_tquery(SQL, query, "mysql_CreateGangTurf", "d", turf_idx);

        GangTurf[turf_idx][gtLeadership] = 0;
        GangTurf[turf_idx][gtCaptureStatus] = false;
        GangTurf[turf_idx][gtCaptureProgress] = 0;
        GangTurf[turf_idx][gtActive] = false;
        GangTurf[turf_idx][gtPerkType] = turf_perk;

        GangTurf[turf_idx][gtPosition][0] = gt_temp_min_x;
        GangTurf[turf_idx][gtPosition][1] = gt_temp_min_y;
        GangTurf[turf_idx][gtPosition][2] = gt_temp_max_x;
        GangTurf[turf_idx][gtPosition][3] = gt_temp_max_y;

        GangTurf[turf_idx][gtCapturePos][0] = pPos[0];
        GangTurf[turf_idx][gtCapturePos][1] = pPos[1];
        GangTurf[turf_idx][gtCapturePos][2] = pPos[2];
        
        g_PlayerCreatingTurf[playerid] = false;
        g_SZFirstPos[playerid][0] = 0.0;
        g_SZFirstPos[playerid][1] = 0.0;
        g_TurfProgress[playerid] = 0;
    }
}

//* Jes jes
stock HexToInt(const string[]) // By DracoBlue
{
  	if (string[0]==0) return 0;
 	new i;
  	new cur=1;
  	new res=0;
  	for (i=strlen(string);i>0;i--) {
  	  	if (string[i-1]<58) res=res+cur*(string[i-1]-48); else res=res+cur*(string[i-1]-65+10);
    	cur=cur*16;
  	}
  	return res;
}

stock GangTurf_FormatLeadershipName(turf_id) {

    static str[64];

    if (GangTurf[turf_id][gtLeadership] == 0) {
        format(str, sizeof str, "N/A [SLOBODNA]");
    } 
    
    else {
        format(str, sizeof str, "%s", Faction_ReturnNameBySQLID(GangTurf[turf_id][gtLeadership]));
    }

    return str; // Return the static string
}
