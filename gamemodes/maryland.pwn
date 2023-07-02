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
 *  @Author         Vostic & Ogy_
 *  @Date           05th May 2023
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           maryland.pwn
 *  @Module         main
 */

#define YSI_YES_HEAP_MALLOC

#define CGEN_MEMORY 80000

#include <a_samp>
#include <a_mysql>
#include <SKY>
#include <weapon-config>
#include <a_actor>
#include <a_objects>
#include <a_players>
#include <a_vehicles>
#include <ysilib\YSI_Coding\y_hooks>
#include <ysilib\YSI_Core\y_utils>
#include <ysilib\YSI_Coding\y_timers>
#include <ysilib\YSI_Visual\y_commands>
#include <ysilib\YSI_Data\y_foreach>
#include <ysilib\YSI_Data\y_iterate>
#include <ysilib\YSI_Coding\y_va>
#include <streamer>
#include <sscanf2>
#include <modelsizes>
#define OD_METHOD METHOD_BOX
#include <optidraw>
#include <easyDialog>
#include <formatex>
#include <distance>
#include <zones>
#include <notify>
#include <markerplus>
#include <animated-textdraw>
#include <DialogCenter>


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
#define 	c_ogycolor		"{EB8C6C}"

#define     x_server     0x8DC9F3FF
#define     x_server2    0xC092DEFF
#define     x_red        0xFF1100AA //error/important color
#define     x_blue       0x0099CCAA //help color
#define     x_white      0xffffffAA
#define     x_yellow     0xf2ff00AA //info color
#define     x_green      0x009933AA
#define     x_pink       0xff00bbAA
#define     x_ltblue     0x00f2ffAA
#define     x_orange     0xffa200AA
#define     x_greey      0x787878AA
#define     x_purple     0xC2A2DAAA // me/do chat
#define 	x_ogycolor	 0xEB8C6CFF


//
main()
{
    print("-                                     -");
	print(" Founder : Ogy & Lasee");
	print(" Version : 1.0 - Maryland");
	print(" Developer : Vostic & Ogy_ ");
	print(" Credits : daddyDOT, realnaith");
	print("-                                     -");
	print("> Gamemode Starting...");
	print(">> Maryland Gamemode Started");
    print("-                                     -");
}

#define PRESSED(%0) \
    (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

public OnGameModeInit()
{
	//!Streamer za ucitavanje mapa

	Streamer_SetVisibleItems(STREAMER_TYPE_OBJECT, 550);
	Streamer_ToggleChunkStream(true);
	Streamer_SetChunkSize(STREAMER_TYPE_OBJECT, 250);
	Streamer_VisibleItems(STREAMER_TYPE_OBJECT, 975);
	Streamer_SetTickRate(25);
	
	DisableInteriorEnterExits();
	ManualVehicleEngineAndLights();
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_OFF);
	ShowNameTags(0);												//? Gasi Imena Health Bar i to iznad igraca
	//SetNameTagDrawDistance(20.0);									//? Ovo se pali samo ako je show name tags na enable
	LimitGlobalChatRadius(20.0);
	AllowInteriorWeapons(1);
	EnableVehicleFriendlyFire();
	EnableStuntBonusForAll(0);

	//! Weapon Config
    SetVehiclePassengerDamage(true);
    SetDisableSyncBugs(true);	

	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	TogglePlayerSpectating(playerid, 0);
	SetPlayerColor(playerid, x_white);

	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerTeam(playerid, NO_TEAM);

	//

	//
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnPlayerDamage(&playerid, &Float:amount, &issuerid, &WEAPON:weapon, &bodypart)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
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

public OnPlayerStateChange(playerid, newstate, oldstate)
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

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
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

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
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

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
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

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}
public OnPlayerEnterMarker(playerid, markerid) {

	return 1;
}

public OnPlayerLeaveMarker(playerid, markerid) {

	return 1;
}
/*
public OnPlayerEnterDynamicArea(playerid, areaid) 
{
	return 1;
}

public OnPlayerLeaveDynamicArea(playerid, areaid) 
{
	return 1;
}
*/

//- Includes List

//* Bitno jako da bude medju prvima
#include "backend/database/db-config.script" 
#include "backend/assets/globalstuff.asset"


//- Assets
#include "backend/assets/proxdetect.asset" 						//* ProxDetector
#include "backend/assets/anims.asset"							//* Anim preload
//-
#include "backend/assets/end/do-not-look.end" 

//- Main
#include "backend/main/main.script"								//* Log/Reg
//-
#include "backend/main/end/do-not-look.end"

//- Documentation
#include "backend/documentation/playerdocuments.script"			//* Dokumenta
//-
#include "backend/documentation/end/do-not-look.end"

//- Vehicle
#include "backend/vehicle/brzinomer.script"						//* Brzinomer
#include "backend/vehicle/vehicle.script"						//* Vozila paljenje gasenje itd
#include "backend/vehicle/veh_ownership.script"					//* Vehicle ownership
#include "backend/vehicle/servis.script"						//* -- prebacen u sql (ceka se mapa i da se doda probne table tehnicki i te finese)
//-
#include "backend/vehicle/end/do-not-look.end"

//- Crypto
#include "backend/crypto/crypto_ogy.script"						//* Crypto
//-
#include "backend/crypto/end/do-not-look.end"

//- Finances
#include "backend/finance/bank_old.script"						//* Bankarstvo
#include "backend/finance/bank_ogy.script"						//* Bankarstvo
//-
#include "backend/finance/end/do-not-look.end"

//- Property
#include "backend/property/houses.script"						//* Imovina
//-
#include "backend/property/end/do-not-look.end"

//- Business
#include "backend/business/biz.script"							//* Firme tek zapocete soo
//-
#include "backend/business/end/do-not-look.end"

//- Benches
#include "backend/benches/klupe_ogy.script"						//* Klupe
//-
#include "backend/benches/end/do-not-look.end"

//- Attachments
#include "backend/attachments/attach.script"					//* Attach
//-
#include "backend/attachments/end/do-not-look.end"

//- Factions

//- State Factions
#include "backend/factions/state/faction_police.script"			//* Faction police zapocet (treba dodati novu kategoriju factions i tu dodati player_faction u kom ce se cuvati da li je clan factiona)

//- Illegal Factions
#include "backend/factions/illegal/bunker.script"				//* Bunker

//-
#include "backend/factions/end/do-not-look.end"

//- Safe Zone
#include "backend/safezone/safezone.script"
//-
#include "backend/safezone/end/do-not-look.end"

//- Messages

#include "backend/messages/chat.script"							//* Chat
#include "backend/messages/random_poruke.script"				//* Random poruke
#include "backend/messages/notifikacije.script"					//* Notifikacije
#include "backend/messages/custom_tags.script"					//* Custom tags iznad glave bez health bara i armora
//-
#include "backend/messages/end/do-not-look.end"

//- All NPCs, Actors
#include "backend/npcs/actor.script"							//* Aktori bebo
//-
#include "backend/npcs/end/do-not-look.end"

//- Tehnomedia
#include "backend/tehnomedia/tehnomedia.script"					//* Tehnomedia prodavnica
#include "backend/tehnomedia/drone.script"						//* Drone
#include "backend/tehnomedia/navigation.script"					//* Navigacija
#include "backend/tehnomedia/playerlocation.script"				//* Lokacija
//-
#include "backend/tehnomedia/end/do-not-look.end"

//- Assets Continue
#include "backend/assets/labels.asset"							//* Labeli
#include "backend/assets/custom_markers.asset"					//* Markeri

//- Crossover > Koristi se kad je 31 characters hook truncated
#include "backend/crossover/DynamicArea.csso"					//* Dynamic Area Crossover
//-
#include "backend/crossover/end/do-not-look.end"

//- Frontend

//- Textdraws
#include "frontend/textdraws/main.tde"							//* Glavni tdovi
#include "frontend/textdraws/login.tde"							//* Login tdovi
#include "frontend/textdraws/register.tde"						//* Register tdovi
#include "frontend/textdraws/izborskina.tde"					//* Izborskina tdovi na registeru

//- Exteriors
#include "frontend/exterior/starbucks.map"						//* Starbucks map 
#include "frontend/exterior/opstina.map"						//* Opstina map
#include "frontend/exterior/glavnaulica.map"					//* Glavna ulica map
#include "frontend/exterior/crnotrziste.map"					//* Crno trziste map
#include "frontend/exterior/tehnomedia.map"						//* Tehnomedia map Ogy
#include "frontend/exterior/spawn.map"							//* Spawn Mapa
#include "frontend/exterior/izborskina.map"						//* Izbor skina mapa
#include "frontend/exterior/glenpark.map"						//* Glen park map
#include "frontend/exterior/maryland-pd.map"					//* MLPD Mapa Ext
#include "frontend/exterior/bolnica-ext.map"					//* Bolnica ext Mapa
#include "frontend/exterior/hotel-ext.map"						//* Hotel Mapa
#include "frontend/exterior/customs.map"						//* Customs Mapa
#include "frontend/exterior/shopping-center.map"				//* Shopping Center Mapa
#include "frontend/exterior/bizcent-ext.map"					//* Shopping Center Mapa
#include "frontend/exterior/centar_park.map"					//* Center Park Mapa
#include "frontend/exterior/binance_ext.map"					//* Binance Exterior Mapa

//- Interiors
#include "frontend/interior/opstina-int.map"					//* Opstina int map
#include "frontend/interior/flecca-bank.map"					//* Flecca bank map
#include "frontend/interior/garaza.map"							//* Garaza mapa
#include "frontend/interior/apartman.map"						//* Apartman map
#include "frontend/interior/kanalizacija.map"					//* Kanalizacija map
#include "frontend/interior/spawn-int.map"						//* Spawn Int Mapa
#include "frontend/interior/login_map.map"						//* Login Soba Mapa
#include "frontend/interior/bizcent-int.map"					//* Login Soba Mapa
#include "frontend/interior/hotel-int.map"						//* Login Soba Mapa

//-
#include "frontend/end/do-not-look.end"

//- Jobs
// #include "backend/jobs/job_main.job"
// #include "backend/jobs/transport_novca.job"

//-
#include "backend/jobs/end/do-not-look.end"

//-Important for all systems
#include "backend/staff/staff.script"							//* Staff script
#include "backend/staff/spanel.script"							//* Staff Panel Dynamic Stuff

//- Stocks
#include "backend/stocks/chat.stock"							//* Chat Stock
#include "backend/stocks/db.stock"								//* Database Stock Cuvanja
#include "backend/stocks/vehicle.stock"							//* Vehicle Stock Provere
#include "backend/stocks/variable.stock"						//* Variable stock rest

//- Assets Continue
#include "backend/assets/clickplayertd.asset"					//* OnPlayerClickPlayerTextdraw

//- Temp
#include "temp/end/do-not-look.end"