/*
 *
TEST GM
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
//#include <SKY>  													 // Ne radi trenutno na open.mp
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
#include <formatex>
#include <distance>
#include <zones>
#include <notify>
#include <markerplus>
#include <animated-textdraw>
#include <DialogCenter>
#include <crashdetect>
#include <marylandFix>


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
#define 	c_ogyColour		"{EB8C6C}"

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
#define 	x_ogyColour	 0xEB8C6CFF

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
	ShowNameTags(false);												//? Gasi Imena Health Bar i to iznad igraca
	//SetNameTagDrawDistance(20.0);									//? Ovo se pali samo ako je show name tags na enable
	LimitGlobalChatRadius(20.0);
	AllowInteriorWeapons(true);
	EnableVehicleFriendlyFire();
	EnableStuntBonusForAll(false);	

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

public OnPlayerRequestClass(playerid, classid)
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

public OnPlayerText(playerid, text[])
{
	return (false);
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
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


//- rcon preinclude

YCMD:restart(playerid, const string: params[], help)
{
	SendRconCommand("gmx");

    return 1;
}