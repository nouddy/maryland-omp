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
    strcat(string, "• 20% bonus na payday\n");
    strcat(string, "• 10% popust na rentanje vozila\n");
    strcat(string, "• VIP Chat\n\n");

    strcat(string, "SILVER VIP PAKET ($10/mesec)\n");
    strcat(string, "• Sve iz Bronze paketa\n");
    strcat(string, "• Spawn sa 50 armora\n");
    strcat(string, "• Custom tablice\n");
    strcat(string, "• VIP Garaza\n");
    strcat(string, "• 50% bonus na payday\n\n");

    strcat(string, "GOLD VIP PAKET ($15/mesec)\n");
    strcat(string, "• Sve iz Silver paketa\n");
    strcat(string, "• Kontrola vremena\n");
    strcat(string, "• Kontrola vremenske prognoze\n");
    strcat(string, "• 100% bonus na payday\n\n");

    strcat(string, "PLATINUM VIP PAKET ($20/mesec)\n");
    strcat(string, "• Sve iz Gold paketa\n");
    strcat(string, "• 150% bonus na payday\n");
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

YCMD:vipchat(playerid, params[], help)
{
    if(help)
    {
        notification.Show(playerid, "HELP", "VIP Chat za VIP clanove", "+", BOXCOLOR_BLUE);
        return 1;
    }

    if(PlayerVIPLevel[playerid] < VIP_BRONZE)
        return notification.Show(playerid, "GRESKA", "Niste VIP clan!", "!", BOXCOLOR_RED);

    if(isnull(params))
        return notification.Show(playerid, "KORISCENJE", "/v [text]", "?", BOXCOLOR_BLUE);

    new vipRank[32];
    switch(PlayerVIPLevel[playerid])
    {
        case VIP_BRONZE: vipRank = "BRONZE";
        case VIP_SILVER: vipRank = "SILVER";
        case VIP_GOLD: vipRank = "GOLD";
        case VIP_PLATINUM: vipRank = "PLATINUM";
    }

    new stringicvip[144];
    format(stringicvip, sizeof(stringicvip), "[VIP Chat] %s %s: %s", vipRank, ReturnPlayerName(playerid), params);
    
    foreach(new i : Player)
    {
        if(PlayerVIPLevel[i] >= VIP_BRONZE)
        {
            SendClientMessage(i, -1, stringicvip);
        }
    }
    return 1;
}

// Hook for VIP features
hook OnPlayerSpawn(playerid)
{
    if(PlayerVIPLevel[playerid] >= VIP_BRONZE)
    {
        SetPlayerHealth(playerid, 100.0);
    }
    if(PlayerVIPLevel[playerid] >= VIP_SILVER)
    {
        SetPlayerArmour(playerid, 50.0);
    }
    return 1;
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
            PRIMARY KEY (character_id),\
            FOREIGN KEY (character_id) REFERENCES characters(id)\
        )"
    );

    // Start the VIP expiry timer
    gVIPExpiryTimer = repeat CheckVIPExpiry();

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
        
        new stringicvip[144];
        format(stringicvip, sizeof(stringicvip), "VIP » Dobrodosli nazad! Vas %s VIP status je aktivan jos %d dana.", 
            vipRank, days_remaining);
        SendClientMessage(playerid, x_server, stringicvip);
    }
    return 1;
}

// Function to set player's VIP level (call this when processing donations)
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