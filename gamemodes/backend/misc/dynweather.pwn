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
#define WEATHER_SUNNY      0  // Clear weather
#define WEATHER_RAINY      8
#define WEATHER_FOGGY      9

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
    {"[METEOROLOG] Upozorenje: Gusta magla smanjuje vidljivost na putevima!"}
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
    else {
        SetPlayerWeather(playerid, WEATHER_SUNNY); // Clear weather u interioru
    }
    return 1;
}

// Funkcija za azuriranje vremena
forward UpdateWeather();
public UpdateWeather()
{
    new oldWeather = g_CurrentWeather;
    
    // Generisanje random broja od 0-100 za verovatnocu
    new chance = random(100);
    
    // 70% sansa za suncano, 15% za kisu, 15% za maglu
    if(chance < 70) {
        g_CurrentWeather = WEATHER_SUNNY;
    }
    else if(chance < 85) {
        g_CurrentWeather = WEATHER_RAINY;
    }
    else {
        g_CurrentWeather = WEATHER_FOGGY;
    }
    
    if(oldWeather != g_CurrentWeather) {
        new string[256];
        
        if(g_CurrentWeather == WEATHER_SUNNY) {
            new temp = random(15) + 10; // Temperatura izmedju 10-25°C
            format(string, sizeof(string), WeatherMessages[0], temp);
        }
        else if(g_CurrentWeather == WEATHER_RAINY) {
            format(string, sizeof(string), WeatherMessages[1]);
        }
        else {
            format(string, sizeof(string), WeatherMessages[2]);
        }
        
        SendClientMessageToAll(0xFFFF00AA, string);
    }
    
    // Primena novog vremena samo na igrace u exterior-u
    foreach(new i : Player) {
        if(GetPlayerInterior(i) == 0 && GetPlayerVirtualWorld(i) == 0) {
            SetPlayerWeather(i, g_CurrentWeather);
        }
        else {
            SetPlayerWeather(i, WEATHER_SUNNY); // Clear weather u interioru
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
    
    new string[255];
    
    // Posebne poruke za odredjena doba dana, uzimajuci u obzir trenutno vreme
    switch(g_CurrentHour)
    {
        case 6: {
            switch(g_CurrentWeather) {
                case WEATHER_SUNNY: format(string, sizeof(string), "[METEOROLOG] Svice novi dan! Ocekuje se vedro jutro.");
                case WEATHER_RAINY: format(string, sizeof(string), "[METEOROLOG] Kisno jutro pred nama! Ponesite kisobrane.");
                case WEATHER_FOGGY: format(string, sizeof(string), "[METEOROLOG] Maglovito jutro! Vozaci, upalite maglenke.");
            }
        }
        case 12: {
            switch(g_CurrentWeather) {
                case WEATHER_SUNNY: format(string, sizeof(string), "[METEOROLOG] Podne! UV index je povisen, zastitite se od sunca.");
                case WEATHER_RAINY: format(string, sizeof(string), "[METEOROLOG] Podne donosi jake pljuskove! Budite oprezni.");
                case WEATHER_FOGGY: format(string, sizeof(string), "[METEOROLOG] Neuobicajeno - magla se zadrzava i tokom podneva.");
            }
        }
        case 20: {
            switch(g_CurrentWeather) {
                case WEATHER_SUNNY: format(string, sizeof(string), "[METEOROLOG] Vece donosi prijatnije temperature i vedro nebo.");
                case WEATHER_RAINY: format(string, sizeof(string), "[METEOROLOG] Kisovito vece pred nama. Ocekuje se zahladjenje.");
                case WEATHER_FOGGY: format(string, sizeof(string), "[METEOROLOG] Magla se zgusnjava! Smanjena vidljivost u vecernjim satima.");
            }
        }
        case 0: {
            switch(g_CurrentWeather) {
                case WEATHER_SUNNY: format(string, sizeof(string), "[METEOROLOG] Ponoc je! Ocekuje se vedra noc sa zvezdanim nebom.");
                case WEATHER_RAINY: format(string, sizeof(string), "[METEOROLOG] Kisovita noc pred nama. Vozaci, prilagodite brzinu.");
                case WEATHER_FOGGY: format(string, sizeof(string), "[METEOROLOG] Gusta magla otezava nocnu vidljivost! Budite oprezni.");
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
