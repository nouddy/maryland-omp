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
 *  @Author         Author
 *  @Date           27th May 2023
 *  @Weburl         weburl
 *  @Project        maryland_project
 *
 *  @File           .pwn
 *  @Module         modules
 */

#include <ysilib\YSI_Coding\y_hooks>

// Konstante za vremenske uslove
#define WEATHER_SUNNY      0
#define WEATHER_RAINY      8
#define WEATHER_FOGGY      9
#define WEATHER_STORMY     16

// Globalne varijable
static 
    g_CurrentWeather,
    g_WeatherTimer,
    g_TimeTimer,
    g_CurrentHour;

// Weather messages
static const WeatherMessages[][] = {
    {"[METEOROLOG] Ocekuje se suncano vreme sa temperaturom do %d°C."},
    {"[METEOROLOG] Meteorolozi najavljuju kisu! Ponesite kisobrane sa sobom."},
    {"[METEOROLOG] Upozorenje: Gusta magla smanjuje vidljivost na putevima!"},
    {"[METEOROLOG] UPOZORENJE: Priblizava se olujni sistem! Ocekuju se grmljavina i jako nevreme!"}
};

hook OnGameModeInit()
{
    print("[Weather] Sistem vremenskih uslova je ucitan");
    
    g_CurrentWeather = WEATHER_SUNNY;
    g_CurrentHour = 12;
    
    // Tajmeri
    g_WeatherTimer = SetTimer("UpdateWeather", 1800000, true);
    g_TimeTimer = SetTimer("UpdateTime", 60000, true);
    
    return 1;
}

hook OnGameModeExit()
{
    KillTimer(g_WeatherTimer);
    KillTimer(g_TimeTimer);
    return 1;
}

hook OnPlayerConnect(playerid)
{
    if(GetPlayerInterior(playerid) == 0 && GetPlayerVirtualWorld(playerid) == 0) {
        SetPlayerWeather(playerid, g_CurrentWeather);
        SetPlayerTime(playerid, g_CurrentHour, 0);
    }
    return 1;
}

// Funkcija za azuriranje vremena
forward UpdateWeather();
public UpdateWeather()
{
    new weather = random(4);
    new oldWeather = g_CurrentWeather;
    
    switch(weather)
    {
        case 0: g_CurrentWeather = WEATHER_SUNNY;
        case 1: g_CurrentWeather = WEATHER_RAINY;
        case 2: g_CurrentWeather = WEATHER_FOGGY;
        case 3: g_CurrentWeather = WEATHER_STORMY;
    }
    
    if(oldWeather != g_CurrentWeather) {
        new temp = random(15) + 10; // Temperatura izmedju 10-25°C
        new string[128];
        format(string, sizeof(string), WeatherMessages[weather], temp);
        SendClientMessageToAll(0xFFFF00AA, string);
    }
    
    // Primena novog vremena samo na igrace u exterior-u
    foreach(new i : Player) {
        if(GetPlayerInterior(i) == 0 && GetPlayerVirtualWorld(i) == 0) {
            SetPlayerWeather(i, g_CurrentWeather);
        }
    }
    
    return 1;
}

// Funkcija za azuriranje vremena u danu
forward UpdateTime();
public UpdateTime()
{
    g_CurrentHour++;
    if(g_CurrentHour >= 24) g_CurrentHour = 0;
    
    new string[128];
    
    // Posebne poruke za odredjena doba dana, uzimajuci u obzir trenutno vreme
    switch(g_CurrentHour)
    {
        case 6: {
            switch(g_CurrentWeather) {
                case WEATHER_SUNNY: format(string, sizeof(string), "[METEOROLOG] Svice novi dan! Ocekuje se vedro jutro.");
                case WEATHER_RAINY: format(string, sizeof(string), "[METEOROLOG] Kisno jutro pred nama! Ponesite kisobrane.");
                case WEATHER_FOGGY: format(string, sizeof(string), "[METEOROLOG] Maglovito jutro! Vozaci, upalite maglenke.");
                case WEATHER_STORMY: format(string, sizeof(string), "[METEOROLOG] UPOZORENJE: Olujno jutro! Ocekuje se jak vetar i grmljavina.");
            }
        }
        case 12: {
            switch(g_CurrentWeather) {
                case WEATHER_SUNNY: format(string, sizeof(string), "[METEOROLOG] Podne! UV index je povisen, zastitite se od sunca.");
                case WEATHER_RAINY: format(string, sizeof(string), "[METEOROLOG] Podne donosi jake pljuskove! Budite oprezni.");
                case WEATHER_FOGGY: format(string, sizeof(string), "[METEOROLOG] Neuobicajeno - magla se zadrzava i tokom podneva.");
                case WEATHER_STORMY: format(string, sizeof(string), "[METEOROLOG] UPOZORENJE: Oluja dostize vrhunac! Ostanite u zatvorenom.");
            }
        }
        case 20: {
            switch(g_CurrentWeather) {
                case WEATHER_SUNNY: format(string, sizeof(string), "[METEOROLOG] Vece donosi prijatnije temperature i vedro nebo.");
                case WEATHER_RAINY: format(string, sizeof(string), "[METEOROLOG] Kisovito vece pred nama. Ocekuje se zahladjenje.");
                case WEATHER_FOGGY: format(string, sizeof(string), "[METEOROLOG] Magla se zgusnjava! Smanjena vidljivost u vecernjim satima.");
                case WEATHER_STORMY: format(string, sizeof(string), "[METEOROLOG] UPOZORENJE: Olujno nevreme se nastavlja kroz noc!");
            }
        }
        case 0: {
            switch(g_CurrentWeather) {
                case WEATHER_SUNNY: format(string, sizeof(string), "[METEOROLOG] Ponoc je! Ocekuje se vedra noc sa zvezdanim nebom.");
                case WEATHER_RAINY: format(string, sizeof(string), "[METEOROLOG] Kisovita noc pred nama. Vozaci, prilagodite brzinu.");
                case WEATHER_FOGGY: format(string, sizeof(string), "[METEOROLOG] Gusta magla otezava nocnu vidljivost! Budite oprezni.");
                case WEATHER_STORMY: format(string, sizeof(string), "[METEOROLOG] UPOZORENJE: Oluja se pojacava u nocnim satima!");
            }
        }
    }
    
    if(string[0]) SendClientMessageToAll(0xFFFF00AA, string);
    
    // Update time for all players in exterior
    foreach(new i : Player) {
        if(GetPlayerInterior(i) == 0 && GetPlayerVirtualWorld(i) == 0) {
            SetPlayerTime(i, g_CurrentHour, 0);
        }
    }
    
    return 1;
}
