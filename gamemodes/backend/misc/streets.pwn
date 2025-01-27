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
 *  @Date           27th May 2023
 *  @Weburl         weburl
 *  @Project        maryland_project
 *
 *  @File           streets.pwn
 *  @Module         misc
 */

#include <ysilib\YSI_Coding\y_hooks>

// Konstante
#define MAX_STREETS         1000
#define STREET_PRICE       50000.0  // Osnovna cena ulice
#define STREET_LABEL_DRAW   75.0  // Razdaljina sa koje se vidi label

// Enumerator za podatke o ulici
enum E_STREET_DATA
{
    street_ID,
    street_Name[64],
    street_OwnerID,
    Float:street_Price,
    Float:street_X,
    Float:street_Y,
    Float:street_Z,
    Text3D:street_Label,
    bool:street_Exists
}

// Varijable
new StreetInfo[MAX_STREETS][E_STREET_DATA];
new Iterator:Streets<MAX_STREETS>;

// Funkcija za u?itavanje ulica
LoadStreets()
{
    mysql_tquery(SQL, "SELECT * FROM streets", "OnStreetsLoad");
}

forward OnStreetsLoad();
public OnStreetsLoad()
{
    new rows = cache_num_rows();
    if(!rows) return 1;

    new streetid;
    for(new i; i < rows; i++)
    {
        streetid = Iter_Free(Streets);
        if(streetid == ITER_NONE) break;

        cache_get_value_name_int(i, "street_id", StreetInfo[streetid][street_ID]);
        cache_get_value_name(i, "name", StreetInfo[streetid][street_Name], 64);
        cache_get_value_name_int(i, "owner_id", StreetInfo[streetid][street_OwnerID]);
        cache_get_value_name_float(i, "price", StreetInfo[streetid][street_Price]);
        cache_get_value_name_float(i, "pos_x", StreetInfo[streetid][street_X]);
        cache_get_value_name_float(i, "pos_y", StreetInfo[streetid][street_Y]);
        cache_get_value_name_float(i, "pos_z", StreetInfo[streetid][street_Z]);

        UpdateStreetLabel(streetid);
        StreetInfo[streetid][street_Exists] = true;
        Iter_Add(Streets, streetid);
    }
    return 1;
}

// Funkcija za ažuriranje labela ulice
stock UpdateStreetLabel(streetid)
{
    if(StreetInfo[streetid][street_Label] != Text3D:INVALID_3DTEXT_ID)
    {
        Delete3DTextLabel(StreetInfo[streetid][street_Label]);
        StreetInfo[streetid][street_Label] = Text3D:INVALID_3DTEXT_ID;
    }

    new string[256];
    format(string, sizeof(string), "{FFFFFF}Ulica: {87CEEB}%s\n", StreetInfo[streetid][street_Name]);
    
    if(StreetInfo[streetid][street_OwnerID] == 0)
    {
        format(string, sizeof(string), "%s{FFFFFF}Vlasnik: {A9A9A9}Drzava\n{87CEEB}/buystreet {FFFFFF}(%d)", 
            string, StreetInfo[streetid][street_Price]);
    }
    else
    {
        format(string, sizeof(string), "%s{FFFFFF}Vlasnik: {87CEEB}%s", 
            string, ReturnCharacterName(StreetInfo[streetid][street_OwnerID]));
    }

    StreetInfo[streetid][street_Label] = Create3DTextLabel(string, -1, 
        StreetInfo[streetid][street_X],
        StreetInfo[streetid][street_Y],
        StreetInfo[streetid][street_Z] + 0.5,
        STREET_LABEL_DRAW, 0, true);
    
    return 1;
}

// Komanda za kreiranje ulice (Staff)
YCMD:createstreet(playerid, params[], help)
{
    if(help)
    {
        notification.Show(playerid, "HELP", "Kreira novu ulicu", "+", BOXCOLOR_BLUE);
        return 1;
    }

    if(GetPlayerStaffLevel(playerid) < 4)
        return notification.Show(playerid, "GRESKA", "Niste ovlasceni!", "!", BOXCOLOR_RED);

    new name[64], prices;
    if(sscanf(params, "s[64]D(50000)", name, prices))
    {
        SendClientMessage(playerid, x_server, "KORISCENJE: /createstreet [ime] [cena]");
        return 1;
    }

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    new query[256];
    mysql_format(SQL, query, sizeof(query), 
        "INSERT INTO streets (name, price, pos_x, pos_y, pos_z, owner_id) VALUES ('%e', %d, %f, %f, %f, 0)",
        name, prices, x, y, z);
    mysql_tquery(SQL, query, "OnStreetCreated", "dfffsd", playerid, x, y, z, name, prices);

    return 1;
}

// Komanda za kupovinu ulice
YCMD:buystreet(playerid, params[], help)
{
    if(help)
    {
        notification.Show(playerid, "HELP", "Kupuje ulicu", "+", BOXCOLOR_BLUE);
        return 1;
    }

    new streetid = -1;
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    foreach(new i : Streets)
    {
        if(IsPlayerInRangeOfPoint(playerid, 3.0, StreetInfo[i][street_X], StreetInfo[i][street_Y], StreetInfo[i][street_Z]))
        {
            streetid = i;
            break;
        }
    }

    if(streetid == -1)
        return notification.Show(playerid, "GRESKA", "Niste blizu nijedne ulice!", "!", BOXCOLOR_RED);

    if(StreetInfo[streetid][street_OwnerID] != 0)
        return notification.Show(playerid, "GRESKA", "Ova ulica vec ima vlasnika!", "!", BOXCOLOR_RED);

    if(GetPlayerMoney(playerid) < StreetInfo[streetid][street_Price])
        return notification.Show(playerid, "GRESKA", "Nemate dovoljno novca!", "!", BOXCOLOR_RED);

    GivePlayerMoney(playerid, -StreetInfo[streetid][street_Price]);
    StreetInfo[streetid][street_OwnerID] = GetCharacterSQLID(playerid);

    new query[128];
    mysql_format(SQL, query, sizeof(query), 
        "UPDATE streets SET owner_id = %d WHERE street_id = %d",
        GetCharacterSQLID(playerid), StreetInfo[streetid][street_ID]);
    mysql_tquery(SQL, query);

    UpdateStreetLabel(streetid);
    
    notification.Show(playerid, "USPESNO", "Kupili ste ulicu!", "!", BOXCOLOR_GREEN);
    return 1;
}

// Komanda za prodaju ulice
YCMD:sellstreet(playerid, params[], help)
{
    if(help)
    {
        notification.Show(playerid, "HELP", "Prodaje ulicu drzavi", "+", BOXCOLOR_BLUE);
        return 1;
    }

    new streetid = -1;
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    foreach(new i : Streets)
    {
        if(IsPlayerInRangeOfPoint(playerid, 3.0, StreetInfo[i][street_X], StreetInfo[i][street_Y], StreetInfo[i][street_Z]))
        {
            streetid = i;
            break;
        }
    }

    if(streetid == -1)
        return notification.Show(playerid, "GRESKA", "Niste blizu nijedne ulice!", "!", BOXCOLOR_RED);

    if(StreetInfo[streetid][street_OwnerID] != GetCharacterSQLID(playerid))
        return notification.Show(playerid, "GRESKA", "Niste vlasnik ove ulice!", "!", BOXCOLOR_RED);

    new Float:sellPrice = StreetInfo[streetid][street_Price] / 2; // 50% od originalne cene
    GivePlayerMoney(playerid, sellPrice);
    StreetInfo[streetid][street_OwnerID] = 0;

    new query[128];
    mysql_format(SQL, query, sizeof(query), 
        "UPDATE streets SET owner_id = 0 WHERE street_id = %d",
        StreetInfo[streetid][street_ID]);
    mysql_tquery(SQL, query);

    UpdateStreetLabel(streetid);
    
    notification.Show(playerid, "USPESNO", "Prodali ste ulicu drzavi!", "!", BOXCOLOR_GREEN);
    return 1;
}

// Komanda za promenu imena ulice
YCMD:streetname(playerid, params[], help)
{
    if(help)
    {
        notification.Show(playerid, "HELP", "Menja ime ulice", "+", BOXCOLOR_BLUE);
        return 1;
    }

    new streetid = -1;
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    foreach(new i : Streets)
    {
        if(IsPlayerInRangeOfPoint(playerid, 3.0, StreetInfo[i][street_X], StreetInfo[i][street_Y], StreetInfo[i][street_Z]))
        {
            streetid = i;
            break;
        }
    }

    if(streetid == -1)
        return notification.Show(playerid, "GRESKA", "Niste blizu nijedne ulice!", "!", BOXCOLOR_RED);

    if(StreetInfo[streetid][street_OwnerID] != GetCharacterSQLID(playerid))
        return notification.Show(playerid, "GRESKA", "Niste vlasnik ove ulice!", "!", BOXCOLOR_RED);

    new name[64];
    if(sscanf(params, "s[64]", name))
    {
        SendClientMessage(playerid, x_server, "KORISCENJE: /streetname [novo_ime]");
        return 1;
    }

    format(StreetInfo[streetid][street_Name], 64, name);

    new query[128];
    mysql_format(SQL, query, sizeof(query), 
        "UPDATE streets SET name = '%e' WHERE street_id = %d",
        name, StreetInfo[streetid][street_ID]);
    mysql_tquery(SQL, query);

    UpdateStreetLabel(streetid);
    
    notification.Show(playerid, "USPESNO", "Promenili ste ime ulice!", "!", BOXCOLOR_GREEN);
    return 1;
}

// Callback za kreiranje ulice
forward OnStreetCreated(playerid, Float:x, Float:y, Float:z, name[], prices);
public OnStreetCreated(playerid, Float:x, Float:y, Float:z, name[], prices)
{
    new streetid = Iter_Free(Streets);
    if(streetid == ITER_NONE)
        return notification.Show(playerid, "GRESKA", "Dostignut maksimalan broj ulica!", "!", BOXCOLOR_RED);

    // Uzmi ID ulice iz baze
    StreetInfo[streetid][street_ID] = cache_insert_id();
    format(StreetInfo[streetid][street_Name], 64, name);
    StreetInfo[streetid][street_OwnerID] = 0;
    StreetInfo[streetid][street_Price] = prices;
    StreetInfo[streetid][street_X] = x;
    StreetInfo[streetid][street_Y] = y;
    StreetInfo[streetid][street_Z] = z;
    StreetInfo[streetid][street_Exists] = true;

    UpdateStreetLabel(streetid);
    Iter_Add(Streets, streetid);

    notification.Show(playerid, "USPESNO", "Kreirali ste novu ulicu!", "!", BOXCOLOR_GREEN);

    // Log akcije
    static log_str[256];
    format(log_str, sizeof log_str, "STAFF: %s je kreirao ulicu %s (ID: %d, Cena: %d)", 
        ReturnCharacterName(playerid), name, StreetInfo[streetid][street_ID], prices);
    mysql_write_log(log_str, LOG_TYPE_STAFF);

    return 1;
}

YCMD:deletestreet(playerid, params[], help)
{
    if(help)
    {
        notification.Show(playerid, "HELP", "Brise ulicu", "+", BOXCOLOR_BLUE);
        return 1;
    }

    if(GetPlayerStaffLevel(playerid) < 4)
        return notification.Show(playerid, "GRESKA", "Niste ovlasceni!", "!", BOXCOLOR_RED);

    new streetid = -1;
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    foreach(new i : Streets)
    {
        if(IsPlayerInRangeOfPoint(playerid, 3.0, StreetInfo[i][street_X], StreetInfo[i][street_Y], StreetInfo[i][street_Z]))
        {
            streetid = i;
            break;
        }
    }

    if(streetid == -1)
        return notification.Show(playerid, "GRESKA", "Niste blizu nijedne ulice!", "!", BOXCOLOR_RED);

    // Sa?uvaj ime za log
    new streetName[64];
    format(streetName, sizeof(streetName), "%s", StreetInfo[streetid][street_Name]);

    // Obriši iz baze
    new query[128];
    mysql_format(SQL, query, sizeof(query), 
        "DELETE FROM streets WHERE street_id = %d",
        StreetInfo[streetid][street_ID]);
    mysql_tquery(SQL, query);

    // Obriši label
    if(StreetInfo[streetid][street_Label] != Text3D:INVALID_3DTEXT_ID)
    {
        Delete3DTextLabel(StreetInfo[streetid][street_Label]);
        StreetInfo[streetid][street_Label] = Text3D:INVALID_3DTEXT_ID;
    }

    // Resetuj podatke i ukloni iz iteratora
    StreetInfo[streetid][street_Exists] = false;
    Iter_Remove(Streets, streetid);

    // Obavesti staffa
    notification.Show(playerid, "USPESNO", "Obrisali ste ulicu!", "!", BOXCOLOR_GREEN);

    // Log akcije
    static log_str[256];
    format(log_str, sizeof log_str, "STAFF: %s je obrisao ulicu %s (ID: %d)", 
        ReturnCharacterName(playerid), streetName, StreetInfo[streetid][street_ID]);
    mysql_write_log(log_str, LOG_TYPE_STAFF);

    // Obavesti ostale staffove
    foreach(new i : Player)
    {
        if(PlayerInfo[i][Staff] && IsStaffChatEnabled())
        {
            SendClientMessage(i, x_purple, "#DELETESTREET: "c_white"Staff %s je obrisao ulicu %s", 
                ReturnCharacterName(playerid), streetName);
        }
    }

    return 1;
}

YCMD:editstreet(playerid, params[], help)
{
    if(help)
    {
        notification.Show(playerid, "HELP", "Edituje ulicu", "+", BOXCOLOR_BLUE);
        return 1;
    }

    if(GetPlayerStaffLevel(playerid) < 4)
        return notification.Show(playerid, "GRESKA", "Niste ovlasceni!", "!", BOXCOLOR_RED);

    new streetid = -1;
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    foreach(new i : Streets)
    {
        if(IsPlayerInRangeOfPoint(playerid, 3.0, StreetInfo[i][street_X], StreetInfo[i][street_Y], StreetInfo[i][street_Z]))
        {
            streetid = i;
            break;
        }
    }

    if(streetid == -1)
        return notification.Show(playerid, "GRESKA", "Niste blizu nijedne ulice!", "!", BOXCOLOR_RED);

    new option[16], value[64];
    if(sscanf(params, "s[16]s[64]", option, value))
    {
        SendClientMessage(playerid, x_server, "KORISCENJE: /editstreet [opcija] [vrednost]");
        SendClientMessage(playerid, x_server, "Opcije: price, name, owner");
        return 1;
    }

    new query[256];
    if(!strcmp(option, "price", true))
    {
        if(!IsNumeric(value))
            return notification.Show(playerid, "GRESKA", "Cena mora biti broj!", "!", BOXCOLOR_RED);

        new prices = strval(value);
        
        if(prices < 1 || prices > 1000000) // Granice za cenu
            return notification.Show(playerid, "GRESKA", "Cena mora biti izmedju $1 i $1,000,000!", "!", BOXCOLOR_RED);

        mysql_format(SQL, query, sizeof(query), 
            "UPDATE streets SET price = %d WHERE street_id = %d",
            prices, StreetInfo[streetid][street_ID]);
        mysql_tquery(SQL, query);

        StreetInfo[streetid][street_Price] = prices;
        
        format(query, sizeof(query), "Promenili ste cenu ulice %s na: $%s", 
            StreetInfo[streetid][street_Name], FormatNumber(prices));
        notification.Show(playerid, "USPESNO", query, "!", BOXCOLOR_GREEN);
    }
    else if(!strcmp(option, "name", true))
    {
        if(strlen(value) < 3 || strlen(value) > 32)
            return notification.Show(playerid, "GRESKA", "Ime ulice mora biti izmedju 3 i 32 karaktera!", "!", BOXCOLOR_RED);

        mysql_format(SQL, query, sizeof(query), 
            "UPDATE streets SET name = '%e' WHERE street_id = %d",
            value, StreetInfo[streetid][street_ID]);
        mysql_tquery(SQL, query);

        format(StreetInfo[streetid][street_Name], 64, value);
        
        format(query, sizeof(query), "Promenili ste ime ulice u: %s", value);
        notification.Show(playerid, "USPESNO", query, "!", BOXCOLOR_GREEN);
    }
    else if(!strcmp(option, "owner", true))
    {
        if(!IsNumeric(value))
            return notification.Show(playerid, "GRESKA", "ID vlasnika mora biti broj!", "!", BOXCOLOR_RED);

        new ownerid = strval(value);
        
        // Provera da li character postoji u bazi
        mysql_format(SQL, query, sizeof(query), 
            "SELECT character_id FROM characters WHERE character_id = %d LIMIT 1",
            ownerid);
        mysql_tquery(SQL, query, "OnStreetOwnerCheck", "ddd", playerid, streetid, ownerid);
        return 1;
    }
    else
    {
        SendClientMessage(playerid, x_server, "KORISCENJE: /editstreet [opcija] [vrednost]");
        SendClientMessage(playerid, x_server, "Opcije: price, name, owner");
        return 1;
    }

    // Log akcije
    static log_str[256];
    format(log_str, sizeof log_str, "STAFF: %s je editovao ulicu %s (%s: %s)", 
        ReturnCharacterName(playerid), StreetInfo[streetid][street_Name], option, value);
    mysql_write_log(log_str, LOG_TYPE_STAFF);

    // Update label nakon svake promene
    UpdateStreetLabel(streetid);

    return 1;
}

// Callback za proveru vlasnika
forward OnStreetOwnerCheck(playerid, streetid, ownerid);
public OnStreetOwnerCheck(playerid, streetid, ownerid)
{
    if(cache_num_rows() == 0)
        return notification.Show(playerid, "GRESKA", "Character sa tim ID-om ne postoji!", "!", BOXCOLOR_RED);

    new query[128];
    mysql_format(SQL, query, sizeof(query), 
        "UPDATE streets SET owner_id = %d WHERE street_id = %d",
        ownerid, StreetInfo[streetid][street_ID]);
    mysql_tquery(SQL, query);

    StreetInfo[streetid][street_OwnerID] = ownerid;
    
    format(query, sizeof(query), "Promenili ste vlasnika ulice %s na ID: %d", 
        StreetInfo[streetid][street_Name], ownerid);
    notification.Show(playerid, "USPESNO", query, "!", BOXCOLOR_GREEN);

    // Log akcije
    static log_str[256];
    format(log_str, sizeof log_str, "STAFF: %s je promenio vlasnika ulice %s na ID: %d", 
        ReturnCharacterName(playerid), StreetInfo[streetid][street_Name], ownerid);
    mysql_write_log(log_str, LOG_TYPE_STAFF);

    UpdateStreetLabel(streetid);
    return 1;
}

hook OnGameModeInit()
{
    LoadStreets();
    printf("Streets loaded: %d", Iter_Count(Streets));
    
    return 1;
}

hook OnGameModeExit()
{
    // O?isti sve labele ulica
    foreach(new i : Streets)
    {
        if(StreetInfo[i][street_Label] != Text3D:INVALID_3DTEXT_ID)
        {
            Delete3DTextLabel(StreetInfo[i][street_Label]);
            StreetInfo[i][street_Label] = Text3D:INVALID_3DTEXT_ID;
        }
    }
    return 1;
}
