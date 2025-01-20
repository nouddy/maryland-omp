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
 *  @File           maryland.core
 *  @Module         main

*/

#define YSI_NO_HEAP_MALLOC
#define MIXED_SPELLINGS

#define MAX_Y_HOOKS (256)
#define CGEN_MEMORY 140000

#pragma dynamic 200000

#include <open.mp>
#include <a_mysql>
#include <streamer>
#include <sscanf2>
#include <Pawn.RakNet>
#include <Pawn.Regex>
#include <log-plugin>		
#include <nex-ac>

#include <ysilib\YSI_Coding\y_va>
#include <ysilib\YSI_Coding\y_hooks>

#include <easyDialog>
#include <callbacks>	

#include <ysilib\YSI_Core\y_utils>
#include <ysilib\YSI_Coding\y_timers>
#include <ysilib\YSI_Visual\y_commands>
#include <ysilib\YSI_Data\y_foreach>
#include <ysilib\YSI_Data\y_iterate>
#include <distance>
#include <zones>
#include <notify>
#include <timestamp>
#include <animated-textdraw>
#include <crashdetect>
#include <colandreas>
#include <marylandFix>
#include <progress2>
#include <walking_styles>
#include <colors>
#include <macroes>
#include <maryland-tp>
#include <mSelection>

stock SanitizeGangZoneCoords(&Float:x, &Float:y, &Float:x2, &Float:y2) {    
    if(x > x2) {
        new Float:tmpX = x;
        x = x2;
        x2 = tmpX;
    }

    if(y > y2) {
        new Float:tmpY = y;
        y = y2;
        y2 = tmpY;
    }
}


// #if defined _ALS_GangZoneCreate
//     #undef GangZoneCreate
// #else
//     #define _ALS_GangZoneCreate
// #endif
// #define GangZoneCreate GangZoneCreate2
// // #define GangZoneCreate GangZoneCreate2

#include <gangzone>

#define SendServerMessage(%0,%1) \
	SendClientMessage(%0, -1, ""c_server"maryland \187; {FFFFFF} "%1)


main()
{
    print("-                                     -");
	print(" Founder : Vostic");
	print(" Version : 1.0 - Maryland");
	print(" Developer : Vostic & Nodi");
	print(" Credits : daddyDOT, Ogy, Frosty");
	print("-                                     -");
	print("> Gamemode Starting...");
	print(">> Maryland Gamemode Started");
    print("-                                     -");
}

new Logger:mainLog;

public OnGameModeInit()
{
	mysql_log(ALL);
	mainLog = CreateLog("main_log");
	
	//!Streamer za ucitavanje mapa

	Streamer_SetVisibleItems(STREAMER_TYPE_OBJECT, 550);
	Streamer_ToggleChunkStream(true);
	Streamer_SetChunkSize(STREAMER_TYPE_OBJECT, 250);
	Streamer_VisibleItems(STREAMER_TYPE_OBJECT, 975);
	Streamer_SetTickRate(25);
	
	CA_Init();

	DisableInteriorEnterExits();
	ManualVehicleEngineAndLights();
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_OFF);
	ShowNameTags(false);												//? Gasi Imena Health Bar i to iznad igraca
	
	LimitGlobalChatRadius(20.0);
	AllowInteriorWeapons(true);
	EnableVehicleFriendlyFire();
	EnableStuntBonusForAll(false);	

	EnableAllAnimations(true);

	SnowMap_Init();

	return 1;
}

/*
*       ___
*      / __|___ _ __  _ __  ___ _ _
*     | (__/ _ \ '  \| '  \/ _ \ ' \
*     \___\___/_|_|_|_|_|_\___/_||_|
*
*/

public e_COMMAND_ERRORS:OnPlayerCommandReceived(playerid, cmdtext[], e_COMMAND_ERRORS:success) {

    if(success != COMMAND_OK)
    {
        SendClientMessage(playerid, x_server, "maryland \187; "c_white"Komanda "c_server"%s"c_white" nije pronadjena, iskoristite /komande", cmdtext); 
        return COMMAND_OK;
    }
    return COMMAND_OK;
}


//-------------------------------------------------------------------------------------------------------- Includes List


//* Bitno jako da bude medju prvima
#include "backend/database/db-config.script" 
#include "backend/assets/globalstuff.asset"
#include "backend/assets/custommarkers.inc"							//* Custom markers
#include "backend/finance/currency.pwn"								//* Currency
#include "backend/assets/ml_notify.pwn"
#include "backend/stocks/float.stock"								//* Float Stocks
#include "backend/logs/log.pwn"

#include "backend/misc/quests.pwn"
#include "backend/misc/randomVehicle.pwn"
#include "backend/misc/shell-minigame.pwn"
#include "backend/misc/chat_settings.pwn"									//* Hospital
#include "backend/misc/drop_gun.pwn"

//-------------------------------------------------------------------------------------------------------- Assets
#include "backend/assets/proxdetect.asset" 							//* ProxDetector
#include "backend/assets/anims.asset"								//* Anim preload

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/assets/end/do-not-look.temp" 

//-------------------------------------------------------------------------------------------------------- Main
#include "backend/reg-log/main.pwn"									//* Register and login
#include "frontend/textdraws/register.tde"							//* Register tdovi
#include "frontend/textdraws/login.tde"								//* Login tdovi
#include "frontend/textdraws/chose-character.tde"					//* Create or chose character TextDraws

// * AntiCheat
#include "backend/anti-cheat/anticheat.pwn"	
//-------------------------------------------------------------------------------------------------------- Assets Continue
#include "backend/assets/custom_markers.asset"						//* Markeri
#include "backend/assets/time.asset"								//* Time calculation
//-------------------------------------------------------------------------------------------------------- Documentation
#include "backend/documentation/playerdocuments.script"				//* Dokumenta

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/documentation/end/do-not-look.temp"

//-------------------------------------------------------------------------------------------------------- Vehicle
#include "backend/vehicle/veh_ownership.script"						//* Vehicle ownership
#include "backend/vehicle/vehicle.script"							//* Vozila paljenje gasenje itd
#include "backend/vehicle/servis.script"							//* -- prebacen u sql (ceka se mapa i da se doda probne table tehnicki i te finese)
#include "backend/vehicle/speedometer.script"						//* Brzinomer
#include "backend/vehicle/fuel.pwn"									//* Brzinomer
#include "backend/vehicle/car_dealership.script"					//* Vozila paljenje gasenje itd
#include "backend/vehicle/driving_school.script"					//* Dok se ne fixa ne paliti sjebe mape skroz.

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/vehicle/end/do-not-look.temp"

//-------------------------------------------------------------------------------------------------------- Inventory

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/finance/end/do-not-look.temp"

//-------------------------------------------------------------------------------------------------------- Property
#include "backend/property/houses.script"							//* Imovina
#include "backend/property/pproperty.script"

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/property/end/do-not-look.temp"

#include "backend/misc/hunger.pwn"

//-------------------------------------------------------------------------------------------------------- Business 'n inventory
#include "backend/inventory/inventory.pwn"

#include "backend/real_estate/re_centar.script"						//* Business Centar
#include "backend/real_estate/re_business.script"					//* Bizovi
#include "backend/real_estate/re_hotel.script"						//* Hotel

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/real_estate/end/do-not-look.temp"

//-------------------------------------------------------------------------------------------------------- Benches
#include "backend/benches/benches.script"							//* Klupe

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/benches/end/do-not-look.temp"

//-------------------------------------------------------------------------------------------------------- Attachments
#include "backend/attachments/attach.script"						//* Attach

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/attachments/end/do-not-look.temp"

//-------------------------------------------------------------------------------------------------------- Factions Section

//-------------------------------------------------------------------------------------------------------- State Factions
#include "backend/factions/state/faction_police.script"				//* Faction police zapocet (treba dodati novu kategoriju factions i tu dodati player_faction u kom ce se cuvati da li je clan factiona)
#include "backend/factions/state/prison_cells.script"

//-------------------------------------------------------------------------------------------------------- Illegal Factions
#include "backend/factions/illegal/bunker.script"					//* Bunker
#include "backend/factions/illegal/faction.pwn"					    //* Core
#include "backend/factions/illegal/drugs.pwn"						//* Drugs
#include "backend/factions/illegal/gang_turfs.pwn"

#include "backend/factions/vehicles/faction_vehicles.pwn"

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/factions/end/do-not-look.temp"

//-------------------------------------------------------------------------------------------------------- Finances
#include "frontend/textdraws/Bank/BankUI.pwn"
#include "backend/finance/Accounts.pwn"
#include "backend/finance/jewlery.pwn"

//-------------------------------------------------------------------------------------------------------- Robbery
#include "backend/robbery/cash-register.pwn"
#include "backend/robbery/house-burglary.pwn"
#include "backend/robbery/bank-robbery.pwn"

//-------------------------------------------------------------------------------------------------------- Safe Zone
#include "backend/safezone/safezone.script"

//-------------------------------------------------------------------------------------------------------- Misc1
#include "backend/misc/medical.pwn"									//* Hospital
#include "backend/misc/life-insurance.pwn"									//* Hospital
#include "backend/misc/player-spawn.pwn"							//* Biranje spawna

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/safezone/end/do-not-look.temp"

//-------------------------------------------------------------------------------------------------------- Messages
#include "backend/messages/random_messages.script"					//* Random poruke
#include "backend/messages/custom_tags.script"						//* Custom tags iznad glave bez health bara i armora

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/messages/end/do-not-look.temp"

//-------------------------------------------------------------------------------------------------------- All NPCs, Actors
#include "backend/npcs/actor.script"								//* Aktori bebo
//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/npcs/end/do-not-look.temp"

//-------------------------------------------------------------------------------------------------------- Crypto Wallets
#include "backend/crypto/crypto.pwn"

//-------------------------------------------------------------------------------------------------------- Tehnomedia
#include "backend/tehnomedia/tehnomedia.script"						//* Tehnomedia prodavnica
#include "backend/tehnomedia/drone.script"							//* Drone
#include "backend/tehnomedia/navigation.script"						//* Navigacija
#include "backend/tehnomedia/playerlocation.script"					//* Lokacija
//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/tehnomedia/end/do-not-look.temp"


//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/metros/end/do-not-look.temp"

//-------------------------------------------------------------------------------------------------------- Trashs

#include "backend/trash/trash.script"								//* Kontejner system

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/trash/end/do-not-look.temp"

//-------------------------------------------------------------------------------------------------------- Frontend

//-------------------------------------------------------------------------------------------------------- Textdraws
#include "frontend/textdraws/main.tde"								//* Glavni tdovi

//-------------------------------------------------------------------------------------------------------- Exteriors
#include "frontend/exterior/starbucks.map"							//* Starbucks map 
#include "frontend/exterior/cityhall.map"							//* Opstina map
#include "frontend/exterior/main_street.map"						//* Glavna ulica map
#include "frontend/exterior/blackmarket.map"						//* Crno trziste map
#include "frontend/exterior/tehnomedia.map"							//* Tehnomedia map Ogy
#include "frontend/exterior/spawn.map"								//* Spawn Mapa
#include "frontend/exterior/choose_skin.map"						//* Izbor skina mapa
#include "frontend/exterior/glenpark.map"							//* Glen park map
#include "frontend/exterior/maryland-pd.map"						//* MLPD Mapa Ext
#include "frontend/exterior/hospital-ext.map"						//* Bolnica ext Mapa
#include "frontend/exterior/hotel-ext.map"							//* Hotel Mapa
#include "frontend/exterior/customs.map"							//* Customs Mapa
#include "frontend/exterior/shopping-center.map"					//* Shopping Center Mapa
#include "frontend/exterior/bizcent-ext.map"						//* Shopping Center Mapa
#include "frontend/exterior/centar_park.map"						//* Center Park Mapa
#include "frontend/exterior/binance_ext.map"						//* Binance Exterior Mapa
#include "frontend/exterior/croswellas.map"							//* Auto Salon Croswell
#include "frontend/exterior/employment_office.map"					//* Biro Rada
#include "frontend/exterior/italy-border.map"						//* Granica Maryland-Italy
#include "frontend/exterior/ml-gym.map"								//* ML Gym Map
#include "frontend/exterior/ls-decorations.map"						//* ML Ukrasi po gradu
#include "frontend/exterior/ml_bus_driver.map"						//* ML Bus Station
#include "frontend/exterior/ml_jewelry.map"							//* ML Zlatara
#include "frontend/exterior/gov_ext.map"							//* Goverment
#include "frontend/exterior/beach.map"								//* Plaza
#include "frontend/exterior/pizzeria.map"							//* Pizzeria
#include "frontend/exterior/driving_school.map"						//* Driving_School
#include "frontend/exterior/vinewood_map.map"						//* VineWood
#include "frontend/exterior/bank_ml.map"							//* Banka Maryland
#include "frontend/exterior/vinewood_mall.map"					    //* VineWood Mall
#include "frontend/exterior/rp-hood.map"					        //* Rp Hood

//-------------------------------------------------------------------------------------------------------- Italy Exteriors
#include "frontend/exterior/italy_zipline.map"						//* Zicara u Italy (SF)

//-------------------------------------------------------------------------------------------------------- Egypt Exteriors

#include "frontend/exterior/trainstation_egypt.map"					//* Zeleznicka u Egypt (LV)
#include "frontend/exterior/egypt_centar.map"						//* Egypt Centar (PD - OPSTINA)
#include "frontend/exterior/egypt_hotel.map"						//* Egypt Hotel
#include "frontend/exterior/egypt_street.map"						//* Egypt Glavna Ulica
#include "frontend/exterior/egypt_decorations.map"					//* Egypt Ukrasi
#include "frontend/exterior/egypt_pump.map"							//* Egypt Pumpa

//------------------------------------------------------------------------------------------------------------------- Interiors
#include "frontend/interior/login-new.map"							//* Login interior novi Ogy (interior 1)
#include "frontend/interior/garage.map"								//* Garaza mapa (interior 2)
#include "frontend/interior/sewers.map"								//* Kanalizacija map (interior 3)
#include "frontend/interior/bizcent-int.map"						//* Biz centar interior (interior 4)
#include "frontend/interior/city_hall.map"						//* Opstina int map (interior 5)
#include "frontend/interior/spawn-int.map"							//* Spawn Int Mapa (interior 6)
#include "frontend/interior/hotel-int.map"							//* Hotel interior (virtual world 7)
#include "frontend/exterior/polygon-as.map"							//* Auto Skola Poligon Mapa (virtual world 8)
#include "frontend/interior/bizcent-lux-int.map"					//* Business Center Luxurious Interior (interior 9);
#include "frontend/interior/harbor_int.map"							//* Main Maryland Bank Interior (interior 10);
#include "frontend/interior/flecca-bank.map"						//* Flecca bank map (11)

#include "frontend/interior/levis-int.map"							//* Levis (0) -> Becasuse of default Ds interior
//#include "frontend/interior/eg-hotel-int.map"						//* Egypt Hotel (13)
#include "frontend/exterior/train_tut.map"						    //* Train Tut (14)
#include "frontend/interior/house-int.map"						    //* House Int (15)
#include "frontend/interior/driving-school-int.map"					//* Driving_School (16)
#include "frontend/interior/mob_int.map"						    //* Mob Int (17)
#include "frontend/interior/7eleven_int.map"						//* Market 7/Eleven Int (18)
#include "frontend/interior/train-int.map"						    //* Train Interior (19)
#include "frontend/interior/bcenter-garage.map"						//* Business Centre Garage (20)
#include "frontend/interior/jewlery_int.map"						//* Jewlery Int (21)
#include "frontend/interior/reception_int.map"						//* Recpetion Int (22)
#include "frontend/interior/hospital-int.map"						//* Hospital Int (23)
#include "frontend/interior/police_int.map"							//* Police Int (24)
#include "frontend/exterior/alcatraz_int.map"						//* Police Int (-1)
#include "frontend/interior/carpentry_int.map"						//* Stolarija Int (25) znaci boze
#include "frontend/interior/drug_lab.map"							//* Druglab Int (28) Neki tripovi
#include "frontend/interior/advertisement_int.map"				    //* Flecca bank map (0)
#include "frontend/interior/alcatraz_int.map"    				    //* Alcatraz/Jail (30)



//--------------------------------------------------------------------------------------------------------- Temp
#include "frontend/end/do-not-look.temp"

//-------------------------------------------------------------------------------------------------------- Jobs
#include "backend/jobs/jobs.pwn"
#include "backend/jobs/bus-driver.job"
#include "backend/jobs/carpentry.job"
#include "backend/jobs/mower-job.pwn"
#include "backend/jobs/ls_customs.pwn"
#include "backend/jobs/bus-stations.pwn"

//-------------------------------------------------------------------------------------------------------- XMAS
#include "backend/xmas/winter.script"

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/jobs/end/do-not-look.temp"

//--------------------------------------------------------------------------------------------------------Important for all systems
#include "backend/staff/staff.script"								//* Staff script
#include "backend/misc/vipsys.pwn"								//* VIP System
#include "backend/ports/ports.pwn"								//* Port sys
#include "backend/staff/spanel.script"								//* Staff Panel Dynamic Stuff
//-------------------------------------------------------------------------------------------------------- Temp
#include "temp/end/do-not-look.temp"
#include "backend/inventory/functions.pwn"
#include "backend/messages/chat.script"								//* Chat

#include "backend/misc/commands.pwn"							   //* Cmds
#include "backend/misc/experience.pwn"							   //* Cmds
#include "backend/misc/quiz.pwn"									//* Quiz
#include "backend/misc/reaction.pwn"								//* Reaction
#include "backend/misc/hj_hh.pwn"								//* Happy Jobs and Happy Hours

#include "backend/vehicle/rent_vehicle.pwn"						//* Rent
#include "backend/misc/lastpos.pwn"								//* Last position saved

#include "backend/metros/metros.script"								//* Metro System
#include "backend/misc/dynweather.pwn"								//* Dynamic Weather
#include "backend/events/gun-game.pwn"								//* Dynamic Weather
//-------------------------------------------------------------------------------------------------------- Stocks
#include "backend/stocks/chat.stock"								//* Chat Stock
#include "backend/stocks/db.stock"									//* Database Stock Cuvanja
#include "backend/stocks/textdraw.stock"							//* TextDraw Stocks

//-------------------------------------------------------------------------------------------------------- Ports

#include "backend/factions/illegal/custom_drugs.pwn"				//* Ozbiljnooo


/*

* TODO:

	- Odraditi attach objekta koji se ne cuva nigdje(za karaktera!)
	- Odraditi redesign databaze za sve stvari.
	- Za open verziju zakljucati ljude unutar Marylanda sa custom streamer zonama.
	! Srediti login/reg do kraja i izmeniti ostatak funckija na engleski i dialoge, takodje izbaciti visak dialoga jer postoji...
	* I proveriti dialoge da li svaki ima proveru koju treba da ima (ISNumeric)
	* Dodati proveru za warn i ban na login da ne moze uci na srv ako je banned
	* napraviti player_jewrely tabelu posto imamo bank accounts za valute i player crypto za kripto ovo ce biti za (silver,gold)
	
	?XMAX?
	*Ledene površine
	Opis: Odre?ene površine postaju klizave, pa vozila i igra?i proklizavaju.

	*Dinami?ke ledenice
	Opis: Ledenice padaju sa zgrada i mogu oštetiti igra?e ili vozila ispod.


*/