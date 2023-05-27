/*
	*TODO:

	--SendPlayerNotify(playerid, "naslov teksta", "kurac teksta", SIMBOLI IMAS ISPISANE);
*/
#define YSI_YES_HEAP_MALLOC

#define CGEN_MEMORY 60000

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
#define OD_METHOD 0
#include <optidraw>
#include <easyDialog>
#include <formatex>
#include <distance>
#include <zones>
#include <discord-connector>
#include <notify>
#include <markerplus>
#include <animated-textdraw>

#define     c_server        "{86f5a7}"
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

#define     x_server     0x86F5A7AA
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


//* Bitno jako da bude medju define
#include "backend/db-config.script" 
#include "assets/globalvariable.asset"

//? Ucitavanje accounta

forward SQL_AccountLoad(playerid);
public SQL_AccountLoad(playerid)
{

}

//? Sitna provera

forward PlayerRegistered(playerid);
public PlayerRegistered(playerid)
{
	return true;
}

//
main()
{
    print("-                                     -");
	print(" Founder : Poppy");
	print(" Version : 1.0 - Maryland");
	print(" Developer : Vostic & Ogy_ ");
	print(" Credits : Muay, daddyDOT, Golubovic, realnaith");
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
	SetNameTagDrawDistance(20.0);
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

//-
//-
#include "assets/proxdetect.asset" 
#include "assets/anims.asset"
//-
#include "assets/end/do-not-look.end" 

//-
#include "backend/main.script"
#include "backend/brzinomer.script"
#include "backend/vehicle.script"
#include "backend/chat.script"
#include "backend/attach.script"
#include "backend/klupe_ogy.script"
#include "backend/crypto_ogy.script"
//-
#include "backend/end/do-not-look.end"

//-
#include "all-in-one/discconnect.aio"
#include "all-in-one/playerdocuments.aio"
#include "all-in-one/bank.aio"
//#include "all-in-one/servis.aio"// -- prebacen u sql (ceka se mapa i da se doda probne table tehnicki i te finese)
#include "all-in-one/labels.aio"
#include "all-in-one/playerlocation.aio"
#include "all-in-one/bunker.aio"
//#include "all-in-one/actor.aio" // -- prebaciti u sql
#include "all-in-one/houses.aio"
#include "all-in-one/custom_markers.aio"
#include "all-in-one/random_poruke.aio"
#include "all-in-one/notifikacije.aio"
#include "backend/vehicle_ownership.script"
//-
#include "all-in-one/end/do-not-look.end"

//-
#include "crossover/DynamicArea.csso"
//-
#include "crossover/end/do-not-look.end"

//- Frontend
#include "frontend/main.tde"
#include "frontend/login.tde"
#include "frontend/starbucks.map"
#include "frontend/opstina.map"
#include "frontend/opstina-int.map"
#include "frontend/gigatron.map"
#include "frontend/flecca-bank.map"
#include "frontend/glavnaulica.map"
#include "frontend/crnotrziste.map"
#include "frontend/garaza.map"
#include "frontend/apartman.map"
#include "frontend/izborskina.map"
#include "frontend/kanalizacija.map"
#include "frontend/astoyota.map"
#include "frontend/mafiaint.map"
#include "frontend/spawn.map"
#include "frontend/spawn-int.map"
#include "frontend/granice.map"
#include "frontend/metro-ext-ent.map"
//-
#include "frontend/end/do-not-look.end"

//- Jobs
// #include "jobs/job_main.job"
// #include "jobs/transport_novca.job"

//-
#include "jobs/end/do-not-look.end"

//-Important for all systems
#include "backend/staff.script"
//-
#include "temp/end/do-not-look.end"

#include "stocks/chat.stock"
#include "stocks/db.stock"
#include "stocks/vehicle.stock"
#include "stocks/variable.stock"