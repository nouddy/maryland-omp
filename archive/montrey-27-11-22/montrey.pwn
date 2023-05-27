/**
TODO:
 */

#define YSI_YES_HEAP_MALLOC

#define CGEN_MEMORY 60000

#include <a_samp>
#include <a_actor>
#include <a_objects>
#include <a_players>
#include <a_vehicles>
#include <ysilib\YSI_Coding\y_hooks>
#include <ysilib\YSI_Core\y_utils.inc>
#include <ysilib\YSI_Storage\y_ini>
#include <ysilib\YSI_Coding\y_timers>
#include <ysilib\YSI_Visual\y_commands>
#include <ysilib\YSI_Data\y_foreach>
#include <ysilib\YSI_Data\y_iterate>
#include <sscanf2>
#include <streamer>
#include <mapfix>
#include <easyDialog>
#include <formatex>
#include <distance>
//#include <discord-connector>

#define     c_server        "{0099ff}"
#define     c_red           "{ff1100}"
#define     c_blue          "{0099cc}"
#define     c_white         "{ffffff}"
#define     c_yellow        "{f2ff00}"
#define     c_green         "{009933}"
#define     c_pink          "{ff00bb}"
#define     c_ltblue        "{00f2ff}"
#define     c_orange        "{ffa200}"
#define     c_greey         "{787878}"

#define     x_server     0x0099FFAA
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

static stock const USER_PATH[64] = "/Users/%s.ini";
//static stock const IMOVINA_PATH = "/Imovina/imovina_%d.ini";

forward Account_Load(const playerid, const string: name[], const string: value[]);
public Account_Load(const playerid, const string: name[], const string: value[])
{
	return 1;
}

main()
{
    print("-                                     -");
	print(" Founder : Vostic");
	print(" Version : 1.0 - Montrey");
	print(" Credits :  ");
	print(" Backend : Vostic, realnaith, Trifun ");
	print(" Frontend : Vostic, cristal, Muay, Strax, Kendy, Golubovic,");
    print(" - Sajugs, Kazano, D4NCH1, sleek ");
	print("-                                     -");
	print("> Gamemode Starting...");
	print(">> Montrey Gamemode Started");
    print("-                                     -");
}

#define PRESSED(%0) \
    ( newkeys & %0 == %0 && oldkeys & %0 != %0 )

public OnGameModeInit()
{
	DisableInteriorEnterExits();
	ManualVehicleEngineAndLights();
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_OFF);
	SetNameTagDrawDistance(20.0);
	LimitGlobalChatRadius(20.0);
	AllowInteriorWeapons(1);
	EnableVehicleFriendlyFire();
	EnableStuntBonusForAll(0);

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

stock Account_Path(const playerid)
{
	new tmp_fmt[64];
	format(tmp_fmt, sizeof(tmp_fmt), USER_PATH, ReturnPlayerName(playerid));

	return tmp_fmt;
}

stock IsVehicleBicycle(m)
{
    if (m == 481 || m == 509 || m == 510) return true;
    
    return false;
}

stock IsVehicleDrone(m)
{
    if (m == 465) return true;
    
    return false;
}

stock GetVehicleSpeed(vehicleid)
{
	new Float:xPos[3];

	GetVehicleVelocity(vehicleid, xPos[0], xPos[1], xPos[2]);

	return floatround(floatsqroot(xPos[0] * xPos[0] + xPos[1] * xPos[1] + xPos[2] * xPos[2]) * 170.00);
}

stock SendClientMessageEx(playerid, color, const str[], {Float,_}:...) 
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;

	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if(args > 12)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 12); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string
		#emit PUSH.C args
		#emit SYSREQ.C format

		SendClientMessage(playerid, color, string);

		#emit LCTRL 5
		#emit SCTRL 4
		#emit RETN
	}
	return SendClientMessage(playerid, color, str);
}

YCMD:help(playerid, params[], help)
{
	if (help)
	{
		SendClientMessage(playerid, -1, "Use `/help <command>` to get information about the command.");
	}
	else if (IsNull(params))
	{
		SendClientMessage(playerid, -1, "Please enter a command.");
	}
	else
	{
		Command_ReProcess(playerid, params, true);
	}
	return 1;
}

//-
#include "assets/proxdetect.asset" 
#include "assets/anims.asset" 
//-
#include "assets/end/do-not-look.end" 

//-
#include "backend/main.script"
#include "backend/staff.script"
#include "backend/vehicle.script"
#include "backend/payday.script"
#include "backend/drone.script" // 100%
#include "backend/bettercam.script" // 100%
#include "backend/chat.script"
#include "backend/attach.script"
#include "backend/engine.script"
#include "backend/wallet.script"
//-
#include "backend/end/do-not-look.end"

//-
#include "all-in-one/brzinomer.aio"
//#include "all-in-one/winter.aio"
#include "all-in-one/playerdocuments.aio"
#include "all-in-one/bank.aio"
#include "all-in-one/servis.aio"
#include "all-in-one/labels.aio" // -- pratiti(ulaze/izlaze raspodeliti)
#include "all-in-one/actor.aio" // -- pratiti(ulaze/izlaze raspodeliti)
#include "all-in-one/playerlocation.aio"
#include "all-in-one/bunker.aio"
//-
#include "all-in-one/end/do-not-look.end"

//-
#include "crossover/DynamicArea.csso"
//-
#include "crossover/end/do-not-look.end"

//-
#include "frontend/main.tde"
#include "frontend/island-small.map"
#include "frontend/island.map"
#include "frontend/construction.map"
#include "frontend/montreyspawn.map"
#include "frontend/bank.map"
#include "frontend/bank-garage.map"
#include "frontend/customs.map"
#include "frontend/izborskina.map"
#include "frontend/vinewood.map"
#include "frontend/starbucks.map"
#include "frontend/police.map"
#include "frontend/opstina.map"
#include "frontend/flecca-bank.map"
//-
#include "frontend/end/do-not-look.end"

//-
#include "temp/bussines.aio"
#include "temp/imovina.aio"

//-
#include "temp/end/do-not-look.end"
