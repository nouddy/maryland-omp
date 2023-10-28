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
 *  @Author         Silent & Nodi
 *  @Github         (github.com/reals1lent) & (github.com/DinoWETT)
 *  @Date           19th Sep 2023
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           maryland.core
 *  @Module         main
 */



 /* 
		? TO DO LIST FOR REWORK:
		! Srediti login/reg do kraja i izmeniti ostatak funckija na engleski i dialoge, takodje izbaciti visak dialoga jer postoji...
		! Bazu koju sam ja pushao dodati u nju sta fali (business, re_centar itd jer nisi pushao bazu zadnju kalega.)

		* Markerplus inc reworkati prebaciti objekte u dynamic objekte i dodati priliko stocka u custom_marker.asset da se moze setup vw i int.
		* Kreiranja prebaciti u spanel itd (Misli se na createhouse itd)
		* Srediti help komand za svaku komandu koja ima dodatne parametre.
		* Pregledati kod izbaciti nepotrebne stvari i uraditi ponegde bolje ukoliko je moguce
		* Dodati provere za death i uraditi custom dmg.
		* I proveriti dialoge da li svaki ima proveru koju treba da ima (ISNumeric)
		* Rename sve funkcije i variable u skripti sa srpskog na engleski.


 */

#define YSI_NO_HEAP_MALLOC

#define CGEN_MEMORY 80000

#include <open.mp>
#include <a_mysql>
#include <ysilib\YSI_Coding\y_hooks>
#include <ysilib\YSI_Core\y_utils>
#include <ysilib\YSI_Coding\y_timers>
#include <ysilib\YSI_Visual\y_commands>
#include <ysilib\YSI_Data\y_foreach>
#include <ysilib\YSI_Data\y_iterate>
#include <ysilib\YSI_Coding\y_va>
#include <streamer>
#include <sscanf2>
#include <easyDialog>
#include <distance>
#include <zones>
#include <notify>
#include <markerplus>
#include <animated-textdraw>
#include <crashdetect>
#include <colandreas>
#include <marylandFix>
#include <progress2>
#include <walking_styles>
#include <colors>
#include <macroes>


main()
{
    print("-                                     -");
	print(" Founder : Ogy");
	print(" Version : 1.0 - Maryland");
	print(" Developer : Silent & Nodi");
	print(" Credits : daddyDOT");
	print("-                                     -");
	print("> Gamemode Sreturn Y_HOOKS_CONTINUE_RETURN_1();tarting...");
	print(">> Maryland Gamemode Started");
    print("-                                     -");
}


public OnGameModeInit()
{
	mysql_log(ALL);
	
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

	SnowMap_Init();

	return 1;
}

public OnGameModeExit()
{
	return 1;
}

/*
      ___
     / __|___ _ __  _ __  ___ _ _
    | (__/ _ \ '  \| '  \/ _ \ ' \
     \___\___/_|_|_|_|_|_\___/_||_|

*/

public OnPlayerConnect(playerid)
{

	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{

	return 1;
}

public OnPlayerSpawn(playerid)
{
	return (true);
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	return 0;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}


public OnPlayerStateChange(playerid, PLAYER_STATE:newstate, PLAYER_STATE:oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerGiveDamageActor(playerid, damaged_actorid, Float:amount, weaponid, bodypart)
{
	return 1;
}

public OnActorStreamIn(actorid, forplayerid)
{
	return 1;
}

public OnActorStreamOut(actorid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

public OnPlayerEnterGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerLeaveGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerEnterPlayerGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerLeavePlayerGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerClickGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerClickPlayerGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnClientCheckResponse(playerid, actionid, memaddr, retndata)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerFinishedDownloading(playerid, virtualworld)
{
	return 1;
}

public OnPlayerRequestDownload(playerid, DOWNLOAD_REQUEST:type, crc)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 0;
}

public OnPlayerSelectObject(playerid, SELECT_OBJECT:type, objectid, modelid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

public OnPlayerEditObject(playerid, playerobject, objectid, EDIT_RESPONSE:response, Float:fX, Float:fY, Float:fZ, Float:rotationX, Float:rotationY, Float:rotationZ)
{
	return 1;
}

public OnPlayerEditAttachedObject(playerid, EDIT_RESPONSE:response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:rotationX, Float:rotationY, Float:rotationZ, Float:scaleX, Float:scaleY, Float:scaleZ)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnPlayerPickUpPlayerPickup(playerid, pickupid)
{
	return 1;
}

public OnPickupStreamIn(pickupid, playerid)
{
	return 1;
}

public OnPickupStreamOut(pickupid, playerid)
{
	return 1;
}

public OnPlayerPickupStreamIn(pickupid, playerid)
{
	return 1;
}

public OnPlayerPickupStreamOut(pickupid, playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, CLICK_SOURCE:source)
{
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, BULLET_HIT_TYPE:hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

public OnScriptCash(playerid, amount, source)
{
	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

public OnIncomingConnection(playerid, ip_address[], port)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
 {
 	return 1;
 }

public OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
{
	return 1;
}

public OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
{
	return 1;
}

public OnTrailerUpdate(playerid, vehicleid)
{
	return 1;
}

public OnVehicleSirenStateChange(playerid, vehicleid, newstate)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, component)
{
	return 1;
}

public OnEnterExitModShop(playerid, enterexit, interiorid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjob)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, colour1, colour2)
{
	return 1;
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	return 1;
}

public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
	return 1;
}

//-------------------------------------------------------------------------------------------------------- Includes List

//* Bitno jako da bude medju prvima
#include "backend/database/db-config.script" 
#include "backend/assets/globalstuff.asset"


//-------------------------------------------------------------------------------------------------------- Assets
#include "backend/assets/proxdetect.asset" 						//* ProxDetector
#include "backend/assets/anims.asset"							//* Anim preload

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/assets/end/do-not-look.temp" 

//-------------------------------------------------------------------------------------------------------- Main
#include "backend/main/main.core"								//* Log/Reg

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/main/end/do-not-look.temp"

//-------------------------------------------------------------------------------------------------------- Documentation
#include "backend/documentation/playerdocuments.script"			//* Dokumenta

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/documentation/end/do-not-look.temp"

//-------------------------------------------------------------------------------------------------------- Vehicle
#include "backend/vehicle/fuel.script"								//* Fuel script
#include "backend/vehicle/veh_ownership.script"						//* Vehicle ownership
#include "backend/vehicle/vehicle.script"							//* Vozila paljenje gasenje itd
#include "backend/vehicle/servis.script"							//* -- prebacen u sql (ceka se mapa i da se doda probne table tehnicki i te finese)
#include "backend/vehicle/speedometer.script"						//* Brzinomer
#include "backend/vehicle/car_dealership.script"					//* Vozila paljenje gasenje itd
#include "backend/vehicle/driving_school.script"						//* Polaganje za dozvole.

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/vehicle/end/do-not-look.temp"

//-------------------------------------------------------------------------------------------------------- Crypto
#include "backend/crypto/crypto_ogy.script"						//* Crypto

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/crypto/end/do-not-look.temp"

//-------------------------------------------------------------------------------------------------------- Finances
//#include "backend/finance/bank_old.script"							//* Bankarstvo
//#include "backend/finance/bank_ogy.script"							//* Bankarstvo

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/finance/end/do-not-look.temp"

//-------------------------------------------------------------------------------------------------------- Property
#include "backend/property/houses.script"							//* Imovina

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/property/end/do-not-look.temp"

//-------------------------------------------------------------------------------------------------------- Business
#include "backend/property/pproperty.script"
#include "backend/real_estate/re_centar.script"						//* Business Centar
#include "backend/real_estate/re_business.script"					//* Bizovi

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

//-------------------------------------------------------------------------------------------------------- Illegal Factions
#include "backend/factions/illegal/bunker.script"					//* Bunker

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/factions/end/do-not-look.temp"

//-------------------------------------------------------------------------------------------------------- Safe Zone
#include "backend/safezone/safezone.script"
//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/safezone/end/do-not-look.temp"

//-------------------------------------------------------------------------------------------------------- Messages

#include "backend/messages/chat.script"								//* Chat
#include "backend/messages/random_messages.script"					//* Random poruke
#include "backend/messages/custom_tags.script"						//* Custom tags iznad glave bez health bara i armora

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/messages/end/do-not-look.temp"

//-------------------------------------------------------------------------------------------------------- All NPCs, Actors
#include "backend/npcs/actor.script"								//* Aktori bebo
//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/npcs/end/do-not-look.temp"

//-------------------------------------------------------------------------------------------------------- Tehnomedia
#include "backend/tehnomedia/tehnomedia.script"						//* Tehnomedia prodavnica
#include "backend/tehnomedia/drone.script"							//* Drone
#include "backend/tehnomedia/navigation.script"						//* Navigacija
#include "backend/tehnomedia/playerlocation.script"					//* Lokacija
//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/tehnomedia/end/do-not-look.temp"


//-------------------------------------------------------------------------------------------------------- Metros

#include "backend/metros/metros.script"								//* Metro System

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/metros/end/do-not-look.temp"

//-------------------------------------------------------------------------------------------------------- Trashs

#include "backend/trash/trash.script"								//* Kontejner system

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/trash/end/do-not-look.temp"

//-------------------------------------------------------------------------------------------------------- Assets Continue
#include "backend/assets/labels.asset"								//* Labeli
#include "backend/assets/custom_markers.asset"						//* Markeri
//-------------------------------------------------------------------------------------------------------- Frontend

//-------------------------------------------------------------------------------------------------------- Textdraws
#include "frontend/textdraws/main.tde"								//* Glavni tdovi
#include "frontend/textdraws/login.tde"								//* Login tdovi
#include "frontend/textdraws/register.tde"							//* Register tdovi
#include "frontend/textdraws/choose_skin.tde"						//* Izborskina tdovi na registeru
#include "frontend/textdraws/crypto.tde"							//* Crypto Textdraws

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
#include "frontend/interior/cityhall_int.map"						//* Opstina int map (interior 5)
#include "frontend/interior/spawn-int.map"							//* Spawn Int Mapa (interior 6)
#include "frontend/interior/hotel-int.map"							//* Hotel interior (virtual world 7)
#include "frontend/exterior/polygon-as.map"							//* Auto Skola Poligon Mapa (virtual world 8)
#include "frontend/interior/bizcent-lux-int.map"					//* Business Center Luxurious Interior (interior 9);
#include "frontend/interior/harbor_int.map"							//* Main Maryland Bank Interior (interior 10);
#include "frontend/interior/flecca-bank.map"						//* Flecca bank map
#include "frontend/interior/login_map.map"							//* Login Soba Mapa


//--------------------------------------------------------------------------------------------------------- Temp
#include "frontend/end/do-not-look.temp"

//-------------------------------------------------------------------------------------------------------- Jobs
//#include "backend/jobs/job_main.job" 								//* Dinamicni poslovi - Credits : job-framework

//-------------------------------------------------------------------------------------------------------- XMAS
#include "backend/xmas/winter.script"
#include "backend/xmas/snowballing.script"

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/jobs/end/do-not-look.temp"

//--------------------------------------------------------------------------------------------------------Important for all systems
#include "backend/staff/staff.script"								//* Staff script
#include "backend/staff/spanel.script"								//* Staff Panel Dynamic Stuff

//-------------------------------------------------------------------------------------------------------- Stocks
#include "backend/stocks/chat.stock"								//* Chat Stock
#include "backend/stocks/db.stock"									//* Database Stock Cuvanja
#include "backend/stocks/variable.stock"							//* Variable stock rest
#include "backend/stocks/textdraw.stock"							//* TextDraw Stocks
//-------------------------------------------------------------------------------------------------------- Temp
#include "temp/end/do-not-look.temp"