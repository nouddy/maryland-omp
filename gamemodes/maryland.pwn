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
 *  @Author         Vostic & Ogy_ & Ferid Olsun
 *  @Date           19th Sep 2023
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           maryland.pwn
 *  @Module         main
 */



 /*
 * Kad se seti OGY imas sledeci zadatak.
 ? Da fixas ulaz i izlaz iz kuca jer si s ovim script za entrance kuce pojebao.
 ? Firme da zavrsis do kraja jer nisu zavrsene ne rade kako treba i da vratis ikonice za firme koje su bile.
 ? Da zavrsis vehicle ownership salone i ono sto sam ti pricao da treba da zavrsis.
 ? Bank system da dovrsis koji si ostavio na pola jer nemam predstavu sta si hteo da radis.
 */

#define YSI_YES_HEAP_MALLOC

#define CGEN_MEMORY 80000

#include <open.mp>
#include <a_mysql>
//#include <weapon-config>  										// Ne radi trenutno na open.mp
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
#include <DialogCenter>
#include <crashdetect>
#include <colandreas>
#include <marylandFix>
#include <walking_styles>


#define     c_server        "{8dc9f3}"
#define     c_server2       "{c092de}"
#define     c_red           "{ff1100}"
#define     c_blue          "{0099cc}"
#define     c_white         "{ffffff}"
#define     c_yellow        "{f2ff00}"
#define     c_green         "{009933}"
#define     c_pink          "{ff00bb}"
#define     c_ltblue        "{00f2ff}"
#define     c_orange        "{ffa200}"
#define     c_greey         "{787878}"
#define     c_purple        "{C2A2DA}"
#define 	c_ltorange		"{EB8C6C}"

#define     x_server     0x8DC9F3FF
#define     x_server2    0xC092DEFF
#define     x_red        0xFF1100AA 
#define     x_blue       0x0099CCAA 
#define     x_white      0xffffffAA
#define     x_yellow     0xf2ff00AA
#define     x_green      0x009933AA
#define     x_pink       0xff00bbAA
#define     x_ltblue     0x00f2ffAA
#define     x_orange     0xffa200AA
#define     x_greey      0x787878AA
#define     x_purple     0xC2A2DAAA 
#define 	x_ltorange	 0xEB8C6CFF


main()
{
    print("-                                     -");
	print(" Founder : Ogy");
	print(" Version : 1.0 - Maryland");
	print(" Developer : Vostic & Ogy_ & Ferid Olsun ");
	print(" Credits : daddyDOT, realnaith");
	print("-                                     -");
	print("> Gamemode Starting...");
	print(">> Maryland Gamemode Started");
    print("-                                     -");
}

#define PRESSED(%0) \
    (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

#define randomEx(%0,%1) random((%1 - %0 + 1)) + %0

#define HOLDING(%0) \
	((newkeys & (%0)) == (%0))

#define RELEASED(%0) \
	(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

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
	//SetNameTagDrawDistance(20.0);									//? Ovo se pali samo ako je show name tags na enable
	LimitGlobalChatRadius(20.0);
	AllowInteriorWeapons(true);
	EnableVehicleFriendlyFire();
	EnableStuntBonusForAll(false);	

	SnowMap_Init();

	new vehicle = CreateVehicle(562, 1282.8285,1566.7600,100.9567, 90.0, 3, 3, 1500);
	SetVehicleVirtualWorld(vehicle, 1);

	printf("VEHICLE VW - %d", GetVehicleVirtualWorld(vehicle));

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

/*

hook function SetPlayerInterior(playerid, interiorid) {

	printf("DEVLOG - %d INT", interiorid);

	return continue(playerid, interiorid);
}

hook function SetPlayerVirtualWorld(playerid, worldid) {

	printf("DEVLOG - %d VW", worldid);

	return continue(playerid, worldid);
}

*/

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

// public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
// {
// 	return 1;
// }

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
#include "backend/database/db-config.pwn" 
#include "backend/assets/globalstuff.pwn"


//-------------------------------------------------------------------------------------------------------- Assets
#include "backend/assets/proxdetect.pwn" 						//* ProxDetector
#include "backend/assets/anims.pwn"							//* Anim preload

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/assets/end/do-not-look.pwn" 

//-------------------------------------------------------------------------------------------------------- Main
#include "backend/main/main.pwn"								//* Log/Reg

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/main/end/do-not-look.pwn"

//-------------------------------------------------------------------------------------------------------- Documentation
#include "backend/documentation/playerdocuments.pwn"			//* Dokumenta

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/documentation/end/do-not-look.pwn"

//-------------------------------------------------------------------------------------------------------- Vehicle
#include "backend/vehicle/vehicle.pwn"							//* Vozila paljenje gasenje itd
#include "backend/vehicle/veh_ownership.pwn"					//* Vehicle ownership
#include "backend/vehicle/servis.pwn"							//* -- prebacen u sql (ceka se mapa i da se doda probne table tehnicki i te finese)
#include "backend/vehicle/brzinomer.pwn"						//* Brzinomer

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/vehicle/end/do-not-look.pwn"

//-------------------------------------------------------------------------------------------------------- Crypto
#include "backend/crypto/crypto_ogy.pwn"						//* Crypto

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/crypto/end/do-not-look.pwn"

//-------------------------------------------------------------------------------------------------------- Finances
#include "backend/finance/bank_old.pwn"							//* Bankarstvo
#include "backend/finance/bank_ogy.pwn"							//* Bankarstvo

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/finance/end/do-not-look.pwn"

//-------------------------------------------------------------------------------------------------------- Property
#include "backend/property/houses.pwn"							//* Imovina

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/property/end/do-not-look.pwn"

//-------------------------------------------------------------------------------------------------------- Business
#include "backend/business/biz.pwn"								//* Firme tek zapocete soo

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/business/end/do-not-look.pwn"

//-------------------------------------------------------------------------------------------------------- Benches
#include "backend/benches/klupe_ogy.pwn"						//* Klupe

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/benches/end/do-not-look.pwn"

//-------------------------------------------------------------------------------------------------------- Attachments
#include "backend/attachments/attach.pwn"						//* Attach

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/attachments/end/do-not-look.pwn"

//-------------------------------------------------------------------------------------------------------- Factions Section

//-------------------------------------------------------------------------------------------------------- State Factions
#include "backend/factions/state/faction_police.pwn"			//* Faction police zapocet (treba dodati novu kategoriju factions i tu dodati player_faction u kom ce se cuvati da li je clan factiona)

//-------------------------------------------------------------------------------------------------------- Illegal Factions
#include "backend/factions/illegal/bunker.pwn"					//* Bunker

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/factions/end/do-not-look.pwn"

//-------------------------------------------------------------------------------------------------------- Safe Zone
#include "backend/safezone/safezone.pwn"
//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/safezone/end/do-not-look.pwn"

//-------------------------------------------------------------------------------------------------------- Messages

#include "backend/messages/chat.pwn"							//* Chat
#include "backend/messages/random_poruke.pwn"					//* Random poruke
#include "backend/messages/notifikacije.pwn"					//* Notifikacije
#include "backend/messages/custom_tags.pwn"						//* Custom tags iznad glave bez health bara i armora

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/messages/end/do-not-look.pwn"

//-------------------------------------------------------------------------------------------------------- All NPCs, Actors
#include "backend/npcs/actor.pwn"								//* Aktori bebo
//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/npcs/end/do-not-look.pwn"

//-------------------------------------------------------------------------------------------------------- Tehnomedia
#include "backend/tehnomedia/tehnomedia.pwn"					//* Tehnomedia prodavnica
#include "backend/tehnomedia/drone.pwn"							//* Drone
#include "backend/tehnomedia/navigation.pwn"					//* Navigacija
#include "backend/tehnomedia/playerlocation.pwn"				//* Lokacija
//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/tehnomedia/end/do-not-look.pwn"


//-------------------------------------------------------------------------------------------------------- Metros

#include "backend/metros/metros.pwn"							//* Metro System

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/metros/end/do-not-look.pwn"

//-------------------------------------------------------------------------------------------------------- Trashs

#include "backend/trash/trash.pwn"							//* Kontejner system

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/trash/end/do-not-look.pwn"

//-------------------------------------------------------------------------------------------------------- Assets Continue
#include "backend/assets/labels.pwn"							//* Labeli
#include "backend/assets/custom_markers.pwn"					//* Markeri

//-------------------------------------------------------------------------------------------------------- Crossover > Koristi se kad je 31 characters hook truncated
#include "backend/crossover/DynamicArea.pwn"					//* Dynamic Area Crossover
//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/crossover/end/do-not-look.pwn"

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/entrance/end/do-not-look.pwn"

//-------------------------------------------------------------------------------------------------------- Frontend

//-------------------------------------------------------------------------------------------------------- Textdraws
#include "frontend/textdraws/main.pwn"							//* Glavni tdovi
#include "frontend/textdraws/login.pwn"							//* Login tdovi
#include "frontend/textdraws/register.pwn"						//* Register tdovi
#include "frontend/textdraws/izborskina.pwn"					//* Izborskina tdovi na registeru

//-------------------------------------------------------------------------------------------------------- Exteriors
#include "frontend/exterior/starbucks.pwn"						//* Starbucks map 
#include "frontend/exterior/opstina.pwn"						//* Opstina map
#include "frontend/exterior/glavnaulica.pwn"					//* Glavna ulica map
#include "frontend/exterior/crnotrziste.pwn"					//* Crno trziste map
#include "frontend/exterior/tehnomedia.pwn"						//* Tehnomedia map Ogy
#include "frontend/exterior/spawn.pwn"							//* Spawn Mapa
#include "frontend/exterior/izborskina.pwn"						//* Izbor skina mapa
#include "frontend/exterior/glenpark.pwn"						//* Glen park map
#include "frontend/exterior/maryland-pd.pwn"					//* MLPD Mapa Ext
#include "frontend/exterior/bolnica-ext.pwn"					//* Bolnica ext Mapa
#include "frontend/exterior/hotel-ext.pwn"						//* Hotel Mapa
#include "frontend/exterior/customs.pwn"						//* Customs Mapa
#include "frontend/exterior/shopping-center.pwn"				//* Shopping Center Mapa
#include "frontend/exterior/bizcent-ext.pwn"					//* Shopping Center Mapa
#include "frontend/exterior/centar_park.pwn"					//* Center Park Mapa
#include "frontend/exterior/binance_ext.pwn"					//* Binance Exterior Mapa
#include "frontend/exterior/poligon-as.pwn"						//* Auto Skola Poligon Mapa (vw > 1 | interior -1)
#include "frontend/exterior/croswellas.pwn"						//* Auto Salon Croswell
#include "frontend/exterior/birorada.pwn"						//* Biro Rada
#include "frontend/exterior/italy-granica.pwn"					//* Granica Maryland-Italy
#include "frontend/exterior/ml-gym.pwn"							//* ML Gym Map
#include "frontend/exterior/ls-ukrasi.pwn"						//* ML Ukrasi po gradu
#include "frontend/exterior/ml-busvozac.pwn"					//* ML Bus Station
#include "frontend/exterior/ml-zlatara.pwn"						//* ML Zlatara
#include "frontend/exterior/gov_ext.pwn"						//* Goverment
#include "frontend/exterior/plaza_map.pwn"						//* Plaza
#include "frontend/exterior/pizzeria.pwn"						//* Pizzeria
#include "frontend/exterior/driving_school.pwn"					//* Driving_School
#include "frontend/exterior/vinewood_map.pwn"					//* VineWood
#include "frontend/exterior/bank_ml.pwn"						//* Banka Maryland

//-------------------------------------------------------------------------------------------------------- Italy Exteriors
#include "frontend/exterior/italy_zicara.pwn"					//* Zicara u Italy (SF)

//-------------------------------------------------------------------------------------------------------- Egypt Exteriors

#include "frontend/exterior/zeleznicka-egypt.pwn"				//* Zeleznicka u Egypt (LV)
#include "frontend/exterior/egypt_centar.pwn"					//* Egypt Centar (PD - OPSTINA)
#include "frontend/exterior/egypt_hotel.pwn"					//* Egypt Hotel
#include "frontend/exterior/egypt_ulica.pwn"					//* Egypt Glavna Ulica
#include "frontend/exterior/egypt_ukrasi.pwn"					//* Egypt Ukrasi
#include "frontend/exterior/egypt_pumpa.pwn"					//* Egypt Pumpa

//------------------------------------------------------------------------------------------------------------------- Interiors
#include "frontend/interior/opstina-int.pwn"					//* Opstina int map (vw > 5 | interior 5)
#include "frontend/interior/flecca-bank.pwn"					//* Flecca bank map
#include "frontend/interior/garaza.pwn"							//* Garaza mapa (vw > 2 | interior 2)
#include "frontend/interior/kanalizacija.pwn"					//* Kanalizacija map (vw > 3 | interior 3)
#include "frontend/interior/spawn-int.pwn"						//* Spawn Int Mapa (vw > 6 | interior 6)
#include "frontend/interior/login_map.pwn"						//* Login Soba Mapa
#include "frontend/interior/bizcent-int.pwn"					//* Biz centar interior (vw > 4 | interior 4)
#include "frontend/interior/hotel-int.pwn"						//* Hotel interior (vw > 7 | interior 7)
#include "frontend/interior/login-new.pwn"						//* Login interior novi Ogy (vw > 8 | interior 8)

//--------------------------------------------------------------------------------------------------------- Temp
#include "frontend/end/do-not-look.pwn"

//-------------------------------------------------------------------------------------------------------- Jobs
#include "backend/jobs/job_main.pwn" 							//* Dinamicni poslovi - Credits : job-framework

//-------------------------------------------------------------------------------------------------------- XMAS
#include "backend/xmas/winter.pwn"
#include "backend/xmas/snowballing.pwn"

//-------------------------------------------------------------------------------------------------------- Temp
#include "backend/jobs/end/do-not-look.pwn"

//--------------------------------------------------------------------------------------------------------Important for all systems
#include "backend/staff/staff.pwn"								//* Staff script
#include "backend/staff/spanel.pwn"								//* Staff Panel Dynamic Stuff

//-------------------------------------------------------------------------------------------------------- Stocks
#include "backend/stocks/chat.pwn"								//* Chat Stock
#include "backend/stocks/db.pwn"								//* Database Stock Cuvanja
#include "backend/stocks/vehicle.pwn"							//* Vehicle Stock Provere
#include "backend/stocks/variable.pwn"							//* Variable stock rest

//-------------------------------------------------------------------------------------------------------- Assets Continue
#include "backend/assets/clickplayertd.pwn"						//* OnPlayerClickPlayerTextdraw

//-------------------------------------------------------------------------------------------------------- Temp
#include "temp/end/do-not-look.pwn"