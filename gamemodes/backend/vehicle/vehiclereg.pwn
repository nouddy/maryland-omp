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
 *  @Github         (github.com/vosticdev)
 *  @Date           28th Jan 2025
 *  @Project        maryland_project
 *
 *  @File           vehiclereg.pwn
 *  @Module         vehicle

*/

#include <ysilib\YSI_Coding\y_hooks>

// Konstante
#define TECH_CHECK_PRICE         300
#define BRIBE_PRICE             500
#define CUSTOM_PLATE_PRICE      300
#define TECH_CHECK_TIME         180 // 3 minute u sekundama

// Dodajemo enum za status tehnickog
enum {
    TECH_STATUS_NONE,
    TECH_STATUS_FAILED,    // Pao tehnicki (<500 health)
    TECH_STATUS_BRIBEABLE, // Moze podmititi (500-700 health)
    TECH_STATUS_PASSED     // Prosao tehnicki (>700 health)
}

// Areas
static tech_Area1;
static tech_Area2;
static bribe_Area;
static plate_Area;

// Varijable za pra?enje procesa
static bool:IsOnTechnical[MAX_VEHICLES];
static TechnicalTimer[MAX_VEHICLES];
static TechnicalStage[MAX_VEHICLES];
static Float:VehicleOriginalPos[MAX_VEHICLES][4];

// Varijabla za pra?enje statusa tehnickog po vozilu
static TechnicalStatus[MAX_VEHICLES];
static TechnicalVehicleID[MAX_PLAYERS]; // Pamtimo koje vozilo igrac trenutno registruje

hook OnGameModeInit() {
    // Kreiranje dynamic areas
    tech_Area1 = CreateDynamicCircle(1104.6829, -1248.7837, 3.0);
    tech_Area2 = CreateDynamicCircle(1090.0742, -1248.4940, 3.0);
    bribe_Area = CreateDynamicCircle(1086.3099, -1187.0845, 3.0);
    plate_Area = CreateDynamicCircle(1085.2911, -1184.3188, 3.0);
    return 1;
}

Dialog:dialog_techCheck(playerid, response, listitem, string:inputtext[]) {
    if(!response) return 1;
    if(!IsPlayerInAnyVehicle(playerid)) return 1;
    
    new vehicleid = GetPlayerVehicleID(playerid);
    
    // Skidanje novca
    GivePlayerMoney(playerid, -TECH_CHECK_PRICE);
    
    // Cuvanje originalne pozicije
    GetVehiclePos(vehicleid, VehicleOriginalPos[vehicleid][0], VehicleOriginalPos[vehicleid][1], VehicleOriginalPos[vehicleid][2]);
    GetVehicleZAngle(vehicleid, VehicleOriginalPos[vehicleid][3]);
    
    // Zapocinjanje tehnickog
    IsOnTechnical[vehicleid] = true;
    TechnicalStage[vehicleid] = 0;
    
    // Izbacivanje igraca i otvaranje haube
    RemovePlayerFromVehicle(playerid);
    SetVehicleParamsEx(vehicleid, 0, 0, 0, 0, 1, 0, 0); // HOOD = 1 otvara haubu
    
    SendClientMessage(playerid, x_server, "TEHNICKI: "c_white"Tehnicki pregled je zapoceo, molimo sacekajte...");
    
    // Pokretanje timera za tehnicki
    TechnicalTimer[vehicleid] = SetTimerEx("OnTechnicalUpdate", 1000, true, "ii", vehicleid, playerid);
    
    return 1;
}

forward OnTechnicalUpdate(vehicleid, playerid);
public OnTechnicalUpdate(vehicleid, playerid) {
    static stage = 0;
    stage++;
    
    // Random efekti tokom pregleda
    switch(random(5)) {
        case 0: SetVehicleParamsEx(vehicleid, 1, 0, 0, 0, 1, 0, 0); // engine on, hood open
        case 1: SetVehicleParamsEx(vehicleid, 0, 0, 0, 0, 1, 0, 0); // engine off, hood open
        case 2: SetVehicleParamsEx(vehicleid, 0, 0, 0, 1, 1, 0, 0); // lights on, hood open
        case 3: SetVehicleParamsEx(vehicleid, 0, 0, 0, 0, 1, 1, 0); // alarm on, hood open
        case 4: SetVehicleParamsEx(vehicleid, 0, 0, 0, 0, 1, 0, 0); // sve off, hood open
    }
    
    // Nakon 3 minute
    if(stage >= TECH_CHECK_TIME) {
        KillTimer(TechnicalTimer[vehicleid]);
        IsOnTechnical[vehicleid] = false;
        SetVehicleParamsEx(vehicleid, 0, 0, 0, 0, 0, 0, 0); // Zatvaranje haube i reset svih parametara
        
        new Float:vHealth;
        GetVehicleHealth(vehicleid, vHealth);
        
        if(vHealth < 500.0) {
            TechnicalStatus[vehicleid] = TECH_STATUS_FAILED;
            SendClientMessage(playerid, x_red, "TEHNICKI: "c_white"Vase vozilo nije proslo tehnicki pregled! (Previse oste?eno)");
        }
        else if(vHealth < 700.0) {
            TechnicalStatus[vehicleid] = TECH_STATUS_BRIBEABLE;
            TechnicalVehicleID[playerid] = vehicleid;
            SendClientMessage(playerid, x_yellow, "TEHNICKI: "c_white"Vase vozilo je na granici. Mozete podmititi sekretaricu ($%d).", BRIBE_PRICE);
            SendClientMessage(playerid, x_yellow, "TEHNICKI: "c_white"Idite do oznacene lokacije da podmitite sekretaricu.");
        }
        else {
            TechnicalStatus[vehicleid] = TECH_STATUS_PASSED;
            TechnicalVehicleID[playerid] = vehicleid;
            SendClientMessage(playerid, x_green, "TEHNICKI: "c_white"Vase vozilo je proslo tehnicki pregled!");
            SendClientMessage(playerid, x_green, "TEHNICKI: "c_white"Idite do saltera za registraciju da zavrsite proces.");
        }
        
        stage = 0;
    }
    return 1;
}

Dialog:dialog_bribe(playerid, response, listitem, string:inputtext[]) {
    if(!response) return 1;
    
    new vehicleid = TechnicalVehicleID[playerid];
    if(vehicleid == 0) 
        return SendClientMessage(playerid, x_red, "GRESKA: "c_white"Prvo morate obaviti tehnicki pregled vozila!");
    
    if(TechnicalStatus[vehicleid] != TECH_STATUS_BRIBEABLE)
        return SendClientMessage(playerid, x_red, "GRESKA: "c_white"Vase vozilo ne ispunjava uslove za podmi?ivanje!");
    
    if(!IsPlayerInBribeArea(playerid))
        return SendClientMessage(playerid, x_red, "GRESKA: "c_white"Niste na lokaciji za podmi?ivanje!");
        
    if(GetPlayerMoney(playerid) < BRIBE_PRICE)
        return SendClientMessage(playerid, x_red, "GRESKA: "c_white"Nemate dovoljno novca za mito! (Potrebno: $%d)", BRIBE_PRICE);

    GivePlayerMoney(playerid, -BRIBE_PRICE);
    TechnicalStatus[vehicleid] = TECH_STATUS_PASSED; // Postavlja status na prosao
    
    SendClientMessage(playerid, x_green, "TEHNICKI: "c_white"Uspjesno ste podmitili sekretaricu!");
    SendClientMessage(playerid, x_green, "TEHNICKI: "c_white"Idite do saltera za registraciju da zavrsite proces.");
    
    return 1;
}

Dialog:dialog_registration(playerid, response, listitem, string:inputtext[]) {
    new vehicleid = TechnicalVehicleID[playerid];
    if(vehicleid == 0) 
        return SendClientMessage(playerid, x_red, "GRESKA: "c_white"Prvo morate obaviti tehnicki pregled vozila!");
    
    if(TechnicalStatus[vehicleid] != TECH_STATUS_PASSED)
        return SendClientMessage(playerid, x_red, "GRESKA: "c_white"Vozilo nije proslo tehnicki pregled!");
    
    new veh_id;
    foreach(new i : iter_Vehicles) {
        if(pvVehicle[i] == vehicleid) {
            veh_id = eVehicle[i][vID];
            break;
        }
    }
    
    if(response) { // Custom tablice
        if(GetPlayerMoney(playerid) < CUSTOM_PLATE_PRICE)
            return SendClientMessage(playerid, x_red, "GRESKA: "c_white"Nemate dovoljno novca za custom tablice! (Potrebno: $%d)", CUSTOM_PLATE_PRICE);
        
        Dialog_Show(playerid, "dialog_customPlate", DIALOG_STYLE_INPUT,
            ""c_server"Custom Tablice",
            ""c_white"Unesite zeljeni tekst za vase tablice:\n\
            Maksimalno 8 karaktera\n\
            Dozvoljeni karakteri: A-Z, 0-9",
            "Potvrdi", "Nazad"
        );
    }
    else { // Standardne tablice
        new plate[16];
        format(plate, sizeof(plate), "MD-%04d", veh_id);
        
        new query[512];
        mysql_format(SQL, query, sizeof(query),
            "UPDATE vehicles SET vPlate = '%e', vRegDate = DATE_ADD(NOW(), INTERVAL 30 DAY) WHERE vID = %d",
            plate, veh_id
        );
        mysql_tquery(SQL, query);
        
        SendClientMessage(playerid, x_green, "REGISTRACIJA: "c_white"Uspjesno ste registrovali vozilo!");
        SendClientMessage(playerid, x_green, "REGISTRACIJA: "c_white"Vase tablice: %s", plate);
        ResetTechnicalStatus(playerid);
    }
    return 1;
}

Dialog:dialog_customPlate(playerid, response, listitem, string:inputtext[]) {
    if(!response) return Dialog_Show(playerid, "dialog_registration", DIALOG_STYLE_MSGBOX,
        ""c_server"Registracija Vozila",
        ""c_white"Zelite li registrovati vozilo?\n\n\
        1. Standardne tablice - "c_green"Besplatno\n\
        "c_white"2. Custom tablice - "c_green"$%d\n\n\
        "c_white"Registracija traje 30 dana.",
        "Custom", "Standard",
        CUSTOM_PLATE_PRICE
    );
    
    new vehicleid = TechnicalVehicleID[playerid];
    if(vehicleid == 0) 
        return SendClientMessage(playerid, x_red, "GRESKA: "c_white"Prvo morate obaviti tehnicki pregled vozila!");
    
    if(TechnicalStatus[vehicleid] != TECH_STATUS_PASSED)
        return SendClientMessage(playerid, x_red, "GRESKA: "c_white"Vozilo nije proslo tehnicki pregled!");
    
    if(strlen(inputtext) > 8)
        return SendClientMessage(playerid, x_red, "GRESKA: "c_white"Maksimalna duzina tablica je 8 karaktera!");
        
    if(!IsValidPlateText(inputtext))
        return SendClientMessage(playerid, x_red, "GRESKA: "c_white"Tablice mogu sadrzavati samo slova (A-Z) i brojeve (0-9)!");
    
    new veh_id;
    foreach(new i : iter_Vehicles) {
        if(pvVehicle[i] == vehicleid) {
            veh_id = eVehicle[i][vID];
            break;
        }
    }
    
    GivePlayerMoney(playerid, -CUSTOM_PLATE_PRICE);
    
    new query[512];
    mysql_format(SQL, query, sizeof(query),
        "UPDATE vehicles SET vPlate = '%e', vRegDate = DATE_ADD(NOW(), INTERVAL 30 DAY) WHERE vID = %d",
        inputtext, veh_id
    );
    mysql_tquery(SQL, query);
    
    SendClientMessage(playerid, x_green, "REGISTRACIJA: "c_white"Uspjesno ste registrovali vozilo!");
    SendClientMessage(playerid, x_green, "REGISTRACIJA: "c_white"Vase custom tablice: %s", inputtext);
    ResetTechnicalStatus(playerid);
    
    return 1;
}

// Pomo?na funkcija za proveru teksta tablica
stock IsValidPlateText(const text[]) {
    for(new i = 0; text[i] != '\0'; i++) {
        if(!('A' <= text[i] <= 'Z' || '0' <= text[i] <= '9'))
            return 0;
    }
    return 1;
}

// Dodajemo reset varijabli nakon zavrsetka registracije
stock ResetTechnicalStatus(playerid) {
    new vehicleid = TechnicalVehicleID[playerid];
    if(vehicleid != 0) {
        TechnicalStatus[vehicleid] = TECH_STATUS_NONE;
        TechnicalVehicleID[playerid] = 0;
    }
}

YCMD:tinspect(playerid, params[], help) {
    if(!IsPlayerInAnyVehicle(playerid)) 
        return SendClientMessage(playerid, x_red, "GRESKA: "c_white"Morate biti u vozilu!");
        
    new vehicleid = GetPlayerVehicleID(playerid);
    
    // Provera da li je vozilo vec registrovano
    new veh_id;
    foreach(new i : iter_Vehicles) {
        if(pvVehicle[i] == vehicleid) {
            veh_id = eVehicle[i][vID];
            break;
        }
    }
    
    // Provera registracije u bazi
    new query[512];
    mysql_format(SQL, query, sizeof(query), 
        "SELECT vRegDate > NOW() as isValid FROM vehicles WHERE vID = %d", 
        veh_id
    );
    mysql_tquery(SQL, query, "OnCheckRegistration", "ii", playerid, vehicleid);
    return 1;
}

// Dodajemo novi callback za proveru registracije
forward OnCheckRegistration(playerid, vehicleid);
public OnCheckRegistration(playerid, vehicleid) {
    // Ako je pronadjen red i registracija je validna
    if(cache_num_rows() > 0) {
        new isValid;
        cache_get_value_name_int(0, "isValid", isValid);
        
        if(isValid) {
            return SendClientMessage(playerid, x_red, "GRESKA: "c_white"Ovo vozilo je ve? registrovano i registracija nije istekla!");
        }
    }
    
    // Nastavljamo sa proverama ako registracija nije validna
    if(!IsVehicleInTechnicalArea(vehicleid))
        return SendClientMessage(playerid, x_red, "GRESKA: "c_white"Niste na tehnickom pregledu!");
        
    if(IsVehicleBicycle(GetVehicleModel(vehicleid))) 
        return SendClientMessage(playerid, x_red, "GRESKA: "c_white"Ne mozete registrovati bicikl!");
        
    if(!IsPlayerVehicleOwner(playerid, vehicleid))
        return SendClientMessage(playerid, x_red, "GRESKA: "c_white"Ovo nije vase vozilo!");
        
    if(GetPlayerMoney(playerid) < TECH_CHECK_PRICE)
        return SendClientMessage(playerid, x_red, "GRESKA: "c_white"Nemate dovoljno novca! (Potrebno: $%d)", TECH_CHECK_PRICE);
        
    if(IsOnTechnical[vehicleid])
        return SendClientMessage(playerid, x_red, "GRESKA: "c_white"Vozilo je ve? na tehnickom pregledu!");

    Dialog_Show(playerid, "dialog_techCheck", DIALOG_STYLE_MSGBOX,
        ""c_server"Tehnicki Pregled",
        ""c_white"Zelite li zapoceti tehnicki pregled vozila?\nCijena: $"c_green"%d",
        "Zapocni", "Odustani",
        TECH_CHECK_PRICE
    );
    
    return 1;
}

// Pomo?na funkcija za proveru da li je vozilo u tehnickoj zoni
stock IsVehicleInTechnicalArea(vehicleid) {
    new Float:x, Float:y, Float:z;
    GetVehiclePos(vehicleid, x, y, z);
    
    // Provera za prvu tehnicku zonu
    if(IsPointInDynamicArea(tech_Area1, x, y, z)) return 1;
    
    // Provera za drugu tehnicku zonu
    if(IsPointInDynamicArea(tech_Area2, x, y, z)) return 1;
    
    return 0;
}

// Pomo?na funkcija za proveru da li je vozilo u tehnickoj zoni
stock IsPlayerInBribeArea(playerid) {
    
    if(IsPlayerInDynamicArea(playerid, bribe_Area)) return true;
    
    return 0;
}

stock IsPlayerInRegPlateArea(playerid) {
    
    if(IsPlayerInDynamicArea(playerid, plate_Area)) return true;
    
    return 0;
}

YCMD:registrationend(playerid, params[], help) {
    new vehicleid = TechnicalVehicleID[playerid];
    
    if(vehicleid == 0)
        return SendClientMessage(playerid, x_red, "GRESKA: "c_white"Niste obavili tehnicki pregled!");
        
    if(TechnicalStatus[vehicleid] != TECH_STATUS_PASSED)
        return SendClientMessage(playerid, x_red, "GRESKA: "c_white"Vase vozilo nije proslo tehnicki pregled!");

    if(!IsPlayerInRegPlateArea(playerid))
        return SendClientMessage(playerid, x_red, "GRESKA: "c_white"Niste na salteru za registraciju!");

    Dialog_Show(playerid, "dialog_registration", DIALOG_STYLE_MSGBOX,
        ""c_server"Registracija Vozila",
        ""c_white"Zelite li registrovati vozilo?\n\n\
        1. Standardne tablice - "c_green"Besplatno\n\
        "c_white"2. Custom tablice - "c_green"$%d\n\n\
        "c_white"Registracija traje 30 dana.",
        "Custom", "Standard",
        CUSTOM_PLATE_PRICE
    );
    
    return 1;
}

YCMD:bribe(playerid, params[], help) {
    new vehicleid = TechnicalVehicleID[playerid];
    
    if(vehicleid == 0)
        return SendClientMessage(playerid, x_red, "GRESKA: "c_white"Niste obavili tehnicki pregled!");
        
    if(TechnicalStatus[vehicleid] != TECH_STATUS_BRIBEABLE)
        return SendClientMessage(playerid, x_red, "GRESKA: "c_white"Vase vozilo ne ispunjava uslove za podmi?ivanje!");
        
    if(!IsPlayerInBribeArea(playerid))
        return SendClientMessage(playerid, x_red, "GRESKA: "c_white"Niste na lokaciji za podmi?ivanje!");
        
    if(GetPlayerMoney(playerid) < BRIBE_PRICE)
        return SendClientMessage(playerid, x_red, "GRESKA: "c_white"Nemate dovoljno novca za mito! (Potrebno: $%d)", BRIBE_PRICE);

    Dialog_Show(playerid, "dialog_bribe", DIALOG_STYLE_MSGBOX,
        ""c_server"Podmi?ivanje",
        ""c_white"Zelite li podmititi sekretaricu da propusti vase vozilo na tehnickom?\nCijena: $"c_green"%d",
        "Podmiti", "Odustani",
        BRIBE_PRICE
    );
    
    return 1;
}

