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
 *  @Github         (github.com/vosticdev) & (github.com/DinoWETT)
 *  @Date           19th Sep 2023
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *  
 *  @File           vipsys.pwn
 *  @Module         misc

*/

#include <ysilib\YSI_Coding\y_hooks>

// VIP Levels

enum {
    VIP_NONE,
    VIP_BRONZE,
    VIP_SILVER,
    VIP_GOLD,
    VIP_PLATINUM
}

// VIP Features per level
enum E_VIP_FEATURES {
    bool:vip_NameTag,        // Colored nametag
    bool:vip_ChatTag,        // VIP chat tag
    bool:vip_SpawnHealth,    // Spawn with more HP
    bool:vip_SpawnArmor,     // Spawn with armor
    bool:vip_PaydayBonus,    // Extra money on payday
    bool:vip_RentDiscount,   // Discount on vehicle rentals
    bool:vip_CustomPlates,   // Custom vehicle plates
    bool:vip_WeatherControl, // Can change weather
    bool:vip_TimeControl,    // Can change time
    bool:vip_VIPGarage,      // Access to VIP garage
    bool:vip_VIPChat,        // Access to VIP chat
    Float:vip_PayBonus      // Payday bonus multiplier
}

new const VIPFeatures[][E_VIP_FEATURES] = {
    // VIP_NONE
    {
        false, false, false, false, false, false, false, false, false, false, false, 1.0
    },
    // VIP_BRONZE
    {
        true, true, true, false, true, true, false, false, false, false, true, 1.2
    },
    // VIP_SILVER
    {
        true, true, true, true, true, true, true, false, false, true, true, 1.5
    },
    // VIP_GOLD
    {
        true, true, true, true, true, true, true, true, true, true, true, 2.0
    },
    // VIP_PLATINUM
    {
        true, true, true, true, true, true, true, true, true, true, true, 2.5
    }
};

new PlayerVIPLevel[MAX_PLAYERS];
new PlayerVIPExpiry[MAX_PLAYERS];

#define MAX_VIP_VEHICLES        35

enum e_VIP_VEHICLES {

    vip_vID,
    vip_vModel,
    Float:vip_vPos[4]
}

new VipVehicleData[MAX_VIP_VEHICLES][e_VIP_VEHICLES];
new vipVehicle[MAX_VIP_VEHICLES];
new Iterator:iter_VIPVehicles<MAX_VIP_VEHICLES>;


enum VIP_COMMAND_COOLDOWNS {

    VIP_COMMAND_GOTO,
    VIP_COMMAND_GETHERE,
    VIP_COMMAND_FV,
    VIP_COMMAND_PORT,
    VIP_COMMAND_GOTOMARK,
    VIP_COMMAND_RAC,
    VIP_COMMAND_GETVEH,
    VIP_COMMAND_FILL,
    VIP_COMMAND_MENU,
    VIP_COMMAND_PM

}

new gVipCooldowns[MAX_PLAYERS][VIP_COMMAND_COOLDOWNS];
new gVipTeleportOffered[MAX_PLAYERS];

new ms_VIPMenu = mS_INVALID_LISTID;

forward mysql_LoadVipVehicles();    
public  mysql_LoadVipVehicles() {

    new rows = cache_num_rows();

    if(!rows) return (true);

    for(new i = 0; i < rows; i++) {

        cache_get_value_name_int(i, "vip_vID", VipVehicleData[i][vip_vID]);
        cache_get_value_name_int(i, "vip_vModel", VipVehicleData[i][vip_vModel]);

        cache_get_value_name_float(i, "vip_vPosX", VipVehicleData[i][vip_vPos][0]);
        cache_get_value_name_float(i, "vip_vPosY", VipVehicleData[i][vip_vPos][1]);
        cache_get_value_name_float(i, "vip_vPosZ", VipVehicleData[i][vip_vPos][2]);
        cache_get_value_name_float(i, "vip_vPosA", VipVehicleData[i][vip_vPos][3]);
    
        vipVehicle[i] = CreateVehicle(VipVehicleData[i][vip_vModel], VipVehicleData[i][vip_vPos][0], VipVehicleData[i][vip_vPos][1], VipVehicleData[i][vip_vPos][2], VipVehicleData[i][vip_vPos][3], 3, 3, 1500);

        Iter_Add(iter_VIPVehicles, i);

    }

    return (true);
}

forward mysql_CreateVipVehicle(vip_idx);
public mysql_CreateVipVehicle(vip_idx) {

    VipVehicleData[vip_idx][vip_vID] = cache_insert_id();
    Iter_Add(iter_VIPVehicles, vip_idx);
    vipVehicle[vip_idx] = CreateVehicle(VipVehicleData[vip_idx][vip_vModel], VipVehicleData[vip_idx][vip_vPos][0], VipVehicleData[vip_idx][vip_vPos][1], VipVehicleData[vip_idx][vip_vPos][2], VipVehicleData[vip_idx][vip_vPos][3], 3, 3, 1500);

    return (true);
}

// VIP Commands
YCMD:vipinfo(playerid, params[], help)
{
    if(help)
    {
        notification.Show(playerid, "HELP", "Prikazuje informacije o VIP nivoima", "+", BOXCOLOR_BLUE);
        return 1;
    }

    new string[1024];
    strcat(string, "BRONZE VIP PAKET ($5/mesec)\n");
    strcat(string, "• Obojen nametag\n");
    strcat(string, "• VIP Chat tag\n");
    strcat(string, "• Spawn sa 100 HP\n");
    strcat(string, "• 20%% bonus na payday\n");
    strcat(string, "• 10%% popust na rentanje vozila\n");
    strcat(string, "• VIP Chat\n\n");

    strcat(string, "SILVER VIP PAKET ($10/mesec)\n");
    strcat(string, "• Sve iz Bronze paketa\n");
    strcat(string, "• Spawn sa 50 armora\n");
    strcat(string, "• Custom tablice\n");
    strcat(string, "• VIP Garaza\n");
    strcat(string, "• 50%% bonus na payday\n\n");

    strcat(string, "GOLD VIP PAKET ($15/mesec)\n");
    strcat(string, "• Sve iz Silver paketa\n");
    strcat(string, "• Kontrola vremena\n");
    strcat(string, "• Kontrola vremenske prognoze\n");
    strcat(string, "• 100%% bonus na payday\n\n");

    strcat(string, "PLATINUM VIP PAKET ($20/mesec)\n");
    strcat(string, "• Sve iz Gold paketa\n");
    strcat(string, "• 150%% bonus na payday\n");
    strcat(string, "• Ekskluzivni VIP eventi\n");
    strcat(string, "• Prioritet na serveru\n\n");

    strcat(string, "Za kupovinu VIP-a posetite: www.maryland-ogc.com/donate\n");
    strcat(string, "Za vise informacija kontaktirajte Head+ staff.");
    
    Dialog_Show(playerid, "DIALOG_VIP_INFO", DIALOG_STYLE_MSGBOX, 
        "Maryland VIP Paketi", 
        string, 
        "Zatvori", ""
    );
    return 1;
}

YCMD:g(playerid, params[], help) = vipchat;
YCMD:vipchat(playerid, params[], help)
{
    if(help)
    {
        notification.Show(playerid, "HELP", "VIP Chat za VIP clanove", "+", BOXCOLOR_BLUE);
        return 1;
    }

    if(PlayerVIPLevel[playerid] < VIP_BRONZE || GetPlayerStaffLevel(playerid) < 1 )
        return notification.Show(playerid, "GRESKA", "Niste u mogucnosti koristiti ovu komandu", "!", BOXCOLOR_RED);

    if(isnull(params))
        return notification.Show(playerid, "KORISCENJE", "/v [text]", "?", BOXCOLOR_BLUE);

    if(!playerSettings[playerid][gVIPChat])
        return SendServerMessage(playerid, "Islkljucen vam je vip chat, "c_ltorange"/tog");

    if(!IsVIPChatEnabled())
        return SendServerMessage(playerid, "Administrator je iskljucio vip chat!");

    new vipRank[32];
    
    if(PlayerVIPLevel[playerid] >= VIP_BRONZE) {

        switch(PlayerVIPLevel[playerid])
        {
            case VIP_BRONZE: vipRank = "BRONZE";
            case VIP_SILVER: vipRank = "SILVER";
            case VIP_GOLD: vipRank = "GOLD";
            case VIP_PLATINUM: vipRank = "PLATINUM";
        }
    }

    if(GetPlayerStaffLevel(playerid) > 0) {

        switch(GetPlayerStaffLevel(playerid)) {

            case 1: { vipRank = "Asisstant"; }
            case 2: { vipRank = "Staff"; }
            case 3: { vipRank = "Director"; }
            case 4: { vipRank = "Head Staff"; }
            case 5: { vipRank = "Owner"; }
        }
    }

    new stringicvip[144];
    format(stringicvip, sizeof(stringicvip), "[VIP Chat] %s %s: %s", vipRank, ReturnPlayerName(playerid), params);
    
    foreach(new i : Player)
    {
        if(PlayerVIPLevel[i] >= VIP_BRONZE && playerSettings[playerid][gVIPChat] && IsVIPChatEnabled() )
        {
            SendClientMessage(i, -1, stringicvip);
        }
    }
    return 1;
}

YCMD:vtod(playerid, params[], help) 
{
    
    if(!VIPFeatures[GetPlayerVIPLevel(playerid)][vip_TimeControl])
        return SendServerMessage(playerid, "Niste u mogucnosti koristiti ovu komandu!");

    if(help) return SendClientMessage(playerid, x_blue, "maryland // "c_white"/vtod [ vreme (0-23) ]");

	new time;
	if(sscanf(params, "i", time)) return SendClientMessage(playerid, x_blue, "maryland // "c_white"/vtod [ vreme (0-23) ]");

	SetPlayerTime(playerid, time, 0);
	SendClientMessageToAll(x_blue, "maryland \187; "c_white"VIP vrijeme je trenutno postavljeno na %d sati.", time);

    return 1;
}

YCMD:vweather(playerid, params[], help) = vipweather;
YCMD:vipweather(playerid, params[], help) 
{
    if(!VIPFeatures[GetPlayerVIPLevel(playerid)][vip_TimeControl])
        return SendServerMessage(playerid, "Niste u mogucnosti koristiti ovu komandu!");

    if(help) return SendClientMessage(playerid, x_blue, "maryland // "c_white"/vtod [ vreme (0-23) ]");

	new time;
	if(sscanf(params, "i", time)) return SendClientMessage(playerid, x_blue, "maryland // "c_white"/vtod [ vreme (0-23) ]");

    if(time < 0 || time > 22)
        return SendServerMessage(playerid, "maryland // "c_white"Vrijeme ne moze biti vece od 22 ili manje od 0.");

    SetPlayerWeather(playerid, time);
    SendServerMessage(playerid, "maryland // "c_white"VIP weahter je postavljen na %d", time);
    return 1;
}

YCMD:vtp(playerid, params[], help) {

    if(GetPlayerVIPLevel(playerid) < VIP_SILVER)
        return SendServerMessage(playerid, "Samo VIP moze ovo!");

    new targetid;
    if(sscanf(params, "u", targetid))
        return SendServerMessage(playerid, "/vtp <ID/Ime Igraca>");

    if(gVipCooldowns[playerid][VIP_COMMAND_GOTO] > gettime())
        return SendServerMessage(playerid, "Ovu komandu mozete iskoristiti za %s", convertTime( gVipCooldowns[playerid][VIP_COMMAND_GOTO] - gettime( ) ) );

    if(targetid == playerid)
        return SendServerMessage(playerid, "Ne mozete se teleportovati do samog sebe!");

    if(!IsPlayerConnected(targetid))
        return SendServerMessage(playerid, "Taj igrac nije konektovan na server!");

    if(GetPlayerStaffLevel(targetid) > 0)
        return SendServerMessage(playerid, "Ne mozete se teleportovati do igraca koji je dio staff team-a!");

    if(targetid == INVALID_PLAYER_ID)
        return SendServerMessage(playerid, "Doslo je do greske, prijavite administraciji!");

    if(gVipTeleportOffered[targetid] != INVALID_PLAYER_ID)
        return SendServerMessage(playerid, "Neko je vec ponudio zahtjev za teleport ovom igracu!");

    if(gVipTeleportOffered[targetid] == playerid)
        return SendServerMessage(playerid, "Vec ste ponudili zahtjev za teleport ovom igracu!");

    gVipTeleportOffered[targetid] = playerid;

    SendClientMessage(playerid, x_ltorange, "#VIP \187; "c_white"Ponudili ste igracu %s[%d] zahtjev za teleport do njega.", ReturnCharacterName(playerid), playerid);

    Dialog_Show(targetid, "dialog_vipOffer", DIALOG_STYLE_MSGBOX, "Maryland - VIP Teleport", 
                           "Igrac "c_ltorange"%s[%d] "c_white"vam je ponudio zahtjev za teleport.\n\
                           Ukoliko zelite da se igrac teleportuje do vas, pritisnite gumb "c_ltorange"'PRIHVATI'\n\
                           "c_ltorange"SVAKI VID ISKORITAVANJA OVOG ZAHTJEVA SA SMATRA KAZNJIVIM.", ""c_ltorange"PRIHVATI", "ODBIJ");

    switch(GetPlayerVIPLevel(playerid)) {

        case VIP_SILVER: { gVipCooldowns[playerid][VIP_COMMAND_GOTO] = gettime() + 60; }
        case VIP_GOLD: { gVipCooldowns[playerid][VIP_COMMAND_GOTO] = gettime() + 30; }
        case VIP_PLATINUM: { gVipCooldowns[playerid][VIP_COMMAND_GOTO] = gettime() + 15; }
    }

    return (true);
}

YCMD:vgetveh(playerid, params[], help) 
{

    if(GetPlayerVIPLevel(playerid) < VIP_GOLD)
        return SendServerMessage(playerid, "Samo VIP Gold ili Silver moze ovo!");

    if(!CharacterHasVehicle(playerid))
        return SendServerMessage(playerid, "Ne posjedujete personalno vozilo!");

    if(gVipCooldowns[playerid][VIP_COMMAND_GETVEH] > gettime())
        return SendServerMessage(playerid, "Ovu komandu mozete iskoristiti za %s", convertTime(gVipCooldowns[playerid][VIP_COMMAND_GETVEH] - gettime() ));

    new evID = GetVehicleSQLID(playerid);

    if(GetPlayerInterior(playerid) != 0 && GetPlayerVirtualWorld(playerid) != 0)
        return SendServerMessage(playerid, "Ne mozete teleportovati vozilo do sebe ukoliko ste u interijeru!");

    switch(GetPlayerVIPLevel(playerid)) {

        case VIP_GOLD: { gVipCooldowns[playerid][VIP_COMMAND_GETVEH] = gettime() + (60 * 5); }
        case VIP_PLATINUM: { gVipCooldowns[playerid][VIP_COMMAND_GETVEH] = gettime() + 30; }
    }

    foreach(new i : iter_Vehicles) {

        if(eVehicle[i][vID] == evID) {

            new Float:pPos[3];
            GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
            SetVehiclePos(pvVehicle[i], pPos[0], pPos[1], pPos[2]);
            PutPlayerInVehicle(playerid, pvVehicle[i], 0);
            break;
        }
    }

    return 1;
}

YCMD:vfv(playerid, params[], help) 
{
    
    if(GetPlayerVIPLevel(playerid) < VIP_BRONZE)
        return SendServerMessage(playerid, "Samo VIP moze ovo!");

    if(gVipCooldowns[playerid][VIP_COMMAND_FV] > gettime())
        return SendServerMessage(playerid, "Ovu komandu mozete iskoristiti za %s", convertTime(gVipCooldowns[playerid][VIP_COMMAND_FV] - gettime()));

    if(!IsPlayerInAnyVehicle(playerid))
        return SendServerMessage(playerid, "Ne nalazite se u vozilu!");

    switch(GetPlayerVIPLevel(playerid)) {

        case VIP_BRONZE: { gVipCooldowns[playerid][VIP_COMMAND_FV] = gettime() + (60 * 3); }
        case VIP_SILVER: { gVipCooldowns[playerid][VIP_COMMAND_FV] = gettime() + (60 * 2); }
        case VIP_GOLD: { gVipCooldowns[playerid][VIP_COMMAND_FV] = gettime() + (60 * 1); }
        case VIP_PLATINUM: { gVipCooldowns[playerid][VIP_COMMAND_FV] = gettime() + 30; }
    }

    new tmp_veh = GetPlayerVehicleID(playerid);

    SetVehicleHealth(tmp_veh, 900.00);
    RepairVehicle(tmp_veh);

    SendClientMessage(playerid, x_ltorange, "#VIP \187; "c_white"Uspjesno ste popravili vozilo!");

    return 1;
}

YCMD:vippm(playerid, params[], help) = vpm;
YCMD:vpm(playerid, params[], help) {

    if(GetPlayerVIPLevel(playerid) < VIP_BRONZE)
        return SendServerMessage(playerid, "Samo VIP moze ovo!");

    if(gVipCooldowns[playerid][VIP_COMMAND_PM] > gettime())
        return SendServerMessage(playerid, "Ovu komandu mozete iskoristiti za %s", convertTime(gVipCooldowns[playerid][VIP_COMMAND_FV] - gettime()));

    new targetid, pm_message[128];

    if(sscanf(params, "us[128]", targetid, pm_message))
        return SendServerMessage(playerid, "/vpm <ID/Ime> <Message>");

    if(targetid == playerid)
        return SendServerMessage(playerid, "Ne mozete se poslati VIP PM samom sebi!");

    if(!IsPlayerConnected(targetid))
        return SendServerMessage(playerid, "Taj igrac nije konektovan na server!");

    if(GetPlayerStaffLevel(targetid) > 0)
        return SendServerMessage(playerid, "Ne mozete poslati VIP PM igracu koji je dio staff team-a!");

    if(targetid == INVALID_PLAYER_ID)
        return SendServerMessage(playerid, "Doslo je do greske, prijavite administraciji!");

    
    SendClientMessage(targetid, x_ltorange, "#VIP \187; %s[%d] : "c_white"%s", ReturnCharacterName(playerid), playerid, pm_message);
    SendClientMessage(playerid, x_ltorange, "#VIP \187; %s[%d] -> %s[%d] : "c_white"%s", ReturnCharacterName(playerid), playerid, ReturnCharacterName(targetid), targetid, pm_message);

    gVipCooldowns[playerid][VIP_COMMAND_PM] = gettime() + 10;

    return 1;
}

YCMD:vipskin(playerid, params[], help) 
{
    
    if(GetPlayerVIPLevel(playerid) < VIP_PLATINUM)
        return SendServerMessage(playerid, "Samo VIP Platinum moze ovo!");

    ShowModelSelectionMenu(playerid, ms_VIPMenu, "VIP Skins");
    return 1;
}

YCMD:createvipveh(playerid, params[], help) {

    if(!IsPlayerAdmin(playerid))
        return SendServerMessage(playerid, "Samo RCON Admin moze ovo!");

    new vip_model;
    if(sscanf(params, "d", vip_model)) return SendServerMessage(playerid, "/createvipveh [modelid]");

    if(vip_model < 400 || vip_model > 611)
        return SendServerMessage(playerid, "Unijeli ste krivi model id vozila!");

    new Float:pPos[4];
    GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
    GetPlayerFacingAngle(playerid, pPos[3]);

    new vip_idx = Iter_Free(iter_VIPVehicles);

    VipVehicleData[vip_idx][vip_vModel] = vip_model;
    VipVehicleData[vip_idx][vip_vPos][0] = pPos[0];
    VipVehicleData[vip_idx][vip_vPos][1] = pPos[1];
    VipVehicleData[vip_idx][vip_vPos][2] = pPos[2];
    VipVehicleData[vip_idx][vip_vPos][3] = pPos[3];

    new q[488];
    mysql_format(SQL, q, sizeof q, "INSERT INTO `vip_vehicles` (`vip_vModel`, `vip_vPosX`, `vip_vPosY`, `vip_vPosZ`, `vip_vPosA`) VALUES ('%d', '%f', '%f', '%f', '%f')",
                                    vip_model, pPos[0], pPos[1], pPos[2], pPos[3]);
    mysql_tquery(SQL, q, "mysql_CreateVipVehicle", "d", vip_idx);

    SetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]+3);

    return 1;
}

hook OnPlayerConnect(playerid) {

    gVipTeleportOffered[playerid] = INVALID_PLAYER_ID;

    return Y_HOOKS_CONTINUE_RETURN_1;
}

// At the top with other variables
new Timer:gVIPExpiryTimer;

hook OnGameModeInit()
{
    mysql_tquery(SQL, 
        "CREATE TABLE IF NOT EXISTS character_vip (\
            character_id INT NOT NULL,\
            vip_level INT DEFAULT 0,\
            vip_expiry DATETIME DEFAULT NULL,\
            PRIMARY KEY (character_id)\
        );"
    );

    // Start the VIP expiry timer
    gVIPExpiryTimer = repeat CheckVIPExpiry();

    mysql_tquery(SQL, "SELECT * FROM `vip_vehicles`", "mysql_LoadVipVehicles");

    ms_VIPMenu = LoadModelSelectionMenu("vip_skins.txt");

    return 1;   
}

hook OnGameModeExit()
{
    // Stop the timer when gamemode exits
    if(gVIPExpiryTimer)
    {
        stop gVIPExpiryTimer;
    }
    return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger) {

    foreach( new i : iter_VIPVehicles ) {

        if(vehicleid == vipVehicle[i]) {

            if(GetPlayerVIPLevel(playerid) < VIP_BRONZE || GetPlayerStaffLevel(playerid) < 1)
            {
                ClearAnimations(playerid);
                SendServerMessage(playerid, "Samo VIP clanovi mogu ovo.");
                return Y_HOOKS_BREAK_RETURN_1;
            }
        }
    }


    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerModelSelection( playerid, response, listid, modelid) {
    
    if(listid == ms_VIPMenu) {
        if( response ) {
            SetPlayerSkin(playerid, modelid);
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;

}

timer CheckVIPExpiry[3600000]() // Check every hour
{
    foreach(new i : Player)
    {
        if(!IsPlayerConnected(i)) continue;
        if(PlayerVIPLevel[i] == VIP_NONE) continue;

        new query[256];
        mysql_format(SQL, query, sizeof(query), 
            "SELECT CASE \
                WHEN vip_expiry < NOW() THEN 1 \
                ELSE 0 \
            END as is_expired \
            FROM character_vip WHERE character_id = %d AND vip_level > 0", 
            GetCharacterSQLID(i)
        );
        mysql_tquery(SQL, query, "OnVIPExpiryCheck", "i", i);
    }
    return 1; // Important for timer
}

forward OnVIPExpiryCheck(playerid);
public OnVIPExpiryCheck(playerid)
{
    new is_expired;
    if(cache_num_rows() && cache_get_value_name_int(0, "is_expired", is_expired) && is_expired)
    {
        PlayerVIPLevel[playerid] = VIP_NONE;
        
        new query[128];
        mysql_format(SQL, query, sizeof(query), 
            "UPDATE character_vip SET vip_level = 0, vip_expiry = NULL WHERE character_id = %d",
            GetCharacterSQLID(playerid)
        );
        mysql_tquery(SQL, query);
        
        SendClientMessage(playerid, x_server, "VIP » "c_white"Vas VIP status je istekao. Posetite "c_server"www.maryland-ogc.com/donate "c_white"za obnovu.");
    }
}

// Load VIP data when character loads
forward LoadCharacterVIP(playerid);
public LoadCharacterVIP(playerid)
{
    new query[256];
    mysql_format(SQL, query, sizeof(query), 
        "SELECT vip_level, \
        CASE \
            WHEN vip_expiry IS NULL OR vip_expiry < NOW() THEN 0 \
            ELSE vip_level \
        END as current_vip_level, \
        DATEDIFF(vip_expiry, NOW()) as days_remaining \
        FROM character_vip WHERE character_id = %d", 
        GetCharacterSQLID(playerid)
    );
    mysql_tquery(SQL, query, "OnVIPDataLoad", "i", playerid);
}

forward OnVIPDataLoad(playerid);
public OnVIPDataLoad(playerid)
{
    if(!cache_num_rows())
    {
        // No VIP data found, create new entry
        new query[128];
        mysql_format(SQL, query, sizeof(query), 
            "INSERT INTO character_vip (character_id, vip_level, vip_expiry) VALUES (%d, 0, NULL)",
            GetCharacterSQLID(playerid)
        );
        mysql_tquery(SQL, query);
        
        PlayerVIPLevel[playerid] = VIP_NONE;
        PlayerVIPExpiry[playerid] = 0;
        return 1;
    }

    new current_vip_level, days_remaining;
    cache_get_value_name_int(0, "current_vip_level", current_vip_level);
    cache_get_value_name_int(0, "days_remaining", days_remaining);

    PlayerVIPLevel[playerid] = current_vip_level;
    PlayerVIPExpiry[playerid] = days_remaining;

    if(current_vip_level == 0 && days_remaining <= 0)
    {
        // VIP has expired
        new query[128];
        mysql_format(SQL, query, sizeof(query), 
            "UPDATE character_vip SET vip_level = 0, vip_expiry = NULL WHERE character_id = %d",
            GetCharacterSQLID(playerid)
        );
        mysql_tquery(SQL, query);
        
        SendClientMessage(playerid, x_server, "VIP » Vas VIP status je istekao. Posetite www.maryland-ogc.com/donate za obnovu.");
    }
    else if(current_vip_level > VIP_NONE)
    {
        // Show welcome message for active VIP
        new vipRank[32];
        switch(current_vip_level)
        {
            case VIP_BRONZE: vipRank = "BRONZE";
            case VIP_SILVER: vipRank = "SILVER";
            case VIP_GOLD: vipRank = "GOLD";
            case VIP_PLATINUM: vipRank = "PLATINUM";
        }
        
        if(PlayerVIPLevel[playerid] == VIP_SILVER)
        {

            SetPlayerArmour(playerid, 25.00);

        }

        if(PlayerVIPLevel[playerid] == VIP_GOLD) 
        {
        
            SetPlayerArmour(playerid, 45.00);

        }

        if(PlayerVIPLevel[playerid] == VIP_PLATINUM) {

            SetPlayerArmour(playerid, 100.00);
        }

        new stringicvip[144];
        format(stringicvip, sizeof(stringicvip), "VIP » Dobrodosli nazad! Vas %s VIP status je aktivan jos %d dana.", 
            vipRank, days_remaining);
        SendClientMessage(playerid, x_server, stringicvip);
    }
    return 1;
}

stock GetPlayerVIPLevel(playerid)
    return PlayerVIPLevel[playerid];

stock SetPlayerVIP(playerid, level, days)
{
    if(!IsPlayerConnected(playerid))
        return 0;

    PlayerVIPLevel[playerid] = level;
    PlayerVIPExpiry[playerid] = days;

    // Update in database using MySQL date functions
    new query[256];
    mysql_format(SQL, query, sizeof(query), 
        "UPDATE character_vip SET vip_level = %d, vip_expiry = DATE_ADD(NOW(), INTERVAL %d DAY) \
        WHERE character_id = %d",
        level, days, GetCharacterSQLID(playerid)
    );
    mysql_tquery(SQL, query);

    // Notify player
    new vipRank[32];
    switch(level)
    {
        case VIP_BRONZE: vipRank = "BRONZE";
        case VIP_SILVER: vipRank = "SILVER";
        case VIP_GOLD: vipRank = "GOLD";
        case VIP_PLATINUM: vipRank = "PLATINUM";
    }

    new stringicvip[144];
    format(stringicvip, sizeof(stringicvip), "VIP » Cestitamo! Aktiviran vam je %s VIP status na %d dana!", vipRank, days);
    SendClientMessage(playerid, x_server, stringicvip);

    return 1;
}

hook OnCharacterLoaded(playerid)
{
    LoadCharacterVIP(playerid);
    return 1;
}

YCMD:setvip(playerid, params[], help)
{
    if(help)
    {
        notification.Show(playerid, "HELP", "Komanda za dodeljivanje VIP statusa", "+", BOXCOLOR_BLUE);
        return 1;
    }

    if(GetPlayerStaffLevel(playerid) < e_HEAD_MANAGER)
        return notification.Show(playerid, "GRESKA", "Niste ovlasceni!", "!", BOXCOLOR_RED);

    new targetid, level, days;
    if(sscanf(params, "uii", targetid, level, days))
    {
        SendClientMessage(playerid, x_server, "KORISCENJE: /setvip [Ime_Prezime/ID] [Level] [Dana]");
        SendClientMessage(playerid, x_server, "LEVELI: 1 - Bronze | 2 - Silver | 3 - Gold | 4 - Platinum");
        return 1;
    }

    if(!IsPlayerConnected(targetid))
        return notification.Show(playerid, "GRESKA", "Igrac nije na serveru!", "!", BOXCOLOR_RED);

    if(level < VIP_BRONZE || level > VIP_PLATINUM)
        return notification.Show(playerid, "GRESKA", "Nevazeci VIP level (1-4)!", "!", BOXCOLOR_RED);

    if(days < 1 || days > 365)
        return notification.Show(playerid, "GRESKA", "Dani moraju biti izmedju 1-365!", "!", BOXCOLOR_RED);

    SetPlayerVIP(targetid, level, days);

    // Log
    new log_str[128];
    format(log_str, sizeof log_str, "STAFF: %s je dodelio %s VIP nivo %d na %d dana", 
        ReturnPlayerName(playerid), ReturnPlayerName(targetid), level, days);
    mysql_write_log(log_str, LOG_TYPE_STAFF);

    // Staff notification
    new stringicvip[128];
    format(stringicvip, sizeof(stringicvip), "Dodelili ste VIP status igracu %s (Level: %d, Dana: %d)", 
        ReturnPlayerName(targetid), level, days);
    notification.Show(playerid, "USPESNO", stringicvip, "!", BOXCOLOR_GREEN);

    return 1;
}

YCMD:removevip(playerid, params[], help)
{
    if(help)
    {
        notification.Show(playerid, "HELP", "Komanda za uklanjanje VIP statusa", "+", BOXCOLOR_BLUE);
        return 1;
    }

    if(GetPlayerStaffLevel(playerid) < e_HEAD_MANAGER)
        return notification.Show(playerid, "GRESKA", "Niste ovlasceni!", "!", BOXCOLOR_RED);

    new targetid;
    if(sscanf(params, "u", targetid))
        return notification.Show(playerid, "KORISCENJE", "/removevip [Ime_Prezime/ID]", "?", BOXCOLOR_BLUE);

    if(!IsPlayerConnected(targetid))
        return notification.Show(playerid, "GRESKA", "Igrac nije na serveru!", "!", BOXCOLOR_RED);

    if(PlayerVIPLevel[targetid] == VIP_NONE)
        return notification.Show(playerid, "GRESKA", "Taj igrac nema VIP status!", "!", BOXCOLOR_RED);

    // Remove VIP
    PlayerVIPLevel[targetid] = VIP_NONE;
    PlayerVIPExpiry[targetid] = 0;

    new query[128];
    mysql_format(SQL, query, sizeof(query), 
        "UPDATE character_vip SET vip_level = 0, vip_expiry = NULL WHERE character_id = %d",
        GetCharacterSQLID(targetid)
    );
    mysql_tquery(SQL, query);

    // Notify target
    SendClientMessage(targetid, x_server, "VIP » Vas VIP status je uklonjen od strane staff-a.");

    // Log
    new log_str[128];
    format(log_str, sizeof log_str, "STAFF: %s je uklonio VIP status igracu %s", 
        ReturnPlayerName(playerid), ReturnPlayerName(targetid));
    mysql_write_log(log_str, LOG_TYPE_STAFF);

    // Staff notification
    new stringicvip[128];
    format(stringicvip, sizeof(stringicvip), "Uklonili ste VIP status igracu %s", ReturnPlayerName(targetid));
    notification.Show(playerid, "USPESNO", stringicvip, "!", BOXCOLOR_GREEN);

    return 1;
}

YCMD:checkvip(playerid, params[], help)
{
    if(help)
    {
        notification.Show(playerid, "HELP", "Komanda za proveru VIP statusa", "+", BOXCOLOR_BLUE);
        return 1;
    }

    if(GetPlayerStaffLevel(playerid) < e_STAFF)
        return notification.Show(playerid, "GRESKA", "Niste ovlasceni!", "!", BOXCOLOR_RED);

    new targetid;
    if(sscanf(params, "u", targetid))
        return notification.Show(playerid, "KORISCENJE", "/checkvip [Ime_Prezime/ID]", "?", BOXCOLOR_BLUE);

    if(!IsPlayerConnected(targetid))
        return notification.Show(playerid, "GRESKA", "Igrac nije na serveru!", "!", BOXCOLOR_RED);

    new query[256];
    mysql_format(SQL, query, sizeof(query), 
        "SELECT vip_level, \
        CASE \
            WHEN vip_expiry IS NULL OR vip_expiry < NOW() THEN 0 \
            ELSE vip_level \
        END as current_vip_level, \
        DATEDIFF(vip_expiry, NOW()) as days_remaining, \
        DATE_FORMAT(vip_expiry, '%%d/%%m/%%Y %%H:%%i') as expiry_date \
        FROM character_vip WHERE character_id = %d", 
        GetCharacterSQLID(targetid)
    );
    mysql_tquery(SQL, query, "OnCheckVIP", "ii", playerid, targetid);

    return 1;
}

forward OnCheckVIP(playerid, targetid);
public OnCheckVIP(playerid, targetid)
{
    new current_vip_level, days_remaining, expiry_date[32];
    cache_get_value_name_int(0, "current_vip_level", current_vip_level);
    cache_get_value_name_int(0, "days_remaining", days_remaining);
    cache_get_value_name(0, "expiry_date", expiry_date, sizeof(expiry_date));

    new vipRank[32];
    switch(current_vip_level)
    {
        case VIP_NONE: vipRank = "Nema VIP";
        case VIP_BRONZE: vipRank = "BRONZE";
        case VIP_SILVER: vipRank = "SILVER";
        case VIP_GOLD: vipRank = "GOLD";
        case VIP_PLATINUM: vipRank = "PLATINUM";
    }

    new stringicvip[256];
    format(stringicvip, sizeof(stringicvip), "VIP Status: %s\nPreostalo dana: %d\nIstice: %s", 
        vipRank, days_remaining, (current_vip_level > VIP_NONE) ? expiry_date : "N/A");

    Dialog_Show(playerid, "DIALOG_VIP_CHECK", DIALOG_STYLE_MSGBOX, 
        ReturnPlayerName(targetid), stringicvip, "Zatvori", "");

    return 1;
}

Dialog:dialog_vipOffer(playerid, response, listitem, string: inputtext[]) {

    if(response) {

        if(gVipTeleportOffered[playerid] == INVALID_PLAYER_ID)
            return SendServerMessage(playerid, "Doslo je do greske, molimo vas da prijavite administraciji.");
        
        new targetid = gVipTeleportOffered[playerid];

        new Float:pPos[3];
        GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
        SetPlayerCompensatedPos(targetid, pPos[0], pPos[1], pPos[2], GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));

        gVipTeleportOffered[playerid] = INVALID_PLAYER_ID;
    }

    if(!response) {

        SendServerMessage(gVipTeleportOffered[playerid], "Igrac %s[%d] je odbio vas zahtjev za teleport.");
        gVipTeleportOffered[playerid] = INVALID_PLAYER_ID;
    }

    return (true);

}