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
 *  @File           navigation.script
 *  @Module         tehnomedia
 */

//* Dodati sve u sql da se prave dinamicne gps lokacije po sql idu i da mogu da se izmene i obrisu
#include <ysilib\YSI_Coding\y_hooks>

new 
	strelica[MAX_PLAYERS],
	pNavState[MAX_PLAYERS],
	pNavID[MAX_PLAYERS],
	pNavTimer[MAX_PLAYERS]
;

enum Navigacija {
    NAV_NAME[32],
    Float:NAV_X,
    Float:NAV_Y,
    Float:NAV_Z
};

new const NavData[][Navigacija] = {
	{"Maryland Opstina", 1533.0863,-1682.4469,13.3828}, // {"Ime Lokacije", X, Y, Z}
	{"Tehnomedia", 1685.7739,-1628.6365,13.3828},
	{"Maryland Park", 1871.1927,-1168.0505,23.6607}
};

hook OnGameModeInit()
{
    print("tehnomedia/navigation.script loaded");

	return (true);
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(pNavState[playerid])
	{
		KillTimer(pNavTimer[playerid]);
		DestroyObject(strelica[playerid]);
		DisablePlayerCheckpoint(playerid);
		pNavState[playerid] = 0;
	}
	return (true);
}

YCMD:gps(playerid, params[], help)
{
    if(PlayerElectronic[playerid][eNavigacijaItem] == 0) return SendClientMessage(playerid, x_red, "Navigacija » "c_white"Nemas navigaciju svrati do tehnomedie da je kupis!");
	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, x_red, "Navigacija » "c_white"Moras biti u vozilu da koristis navigaciju!");
	static string[sizeof(NavData) * 64];

	if (string[0] == EOS) 
	{
		for (new i; i < sizeof(NavData); i++) 
		{
			format(string, sizeof string, "%s"c_server"» "c_white"%s\n", string, NavData[i][NAV_NAME]);
		}
	} 
	Dialog_Show(playerid, "dialog_navigacija", DIALOG_STYLE_LIST, "Navigacija » Lokacije", string, "Odaberi", "Izlaz");
	return (true);
}

YCMD:gpsoff(playerid, params[], help)
{
	if(pNavState[playerid])
	{
		KillTimer(pNavTimer[playerid]);
		DestroyObject(strelica[playerid]);
		PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
		DisablePlayerCheckpoint(playerid);
		pNavState[playerid] = 0;
		SendClientMessage(playerid, x_red, "Navigacija » "c_white" Navigacija otkazana!");
	} else SendClientMessage(playerid, x_red, "Navigacija » "c_white" Navigacija je vec iskljucena!");
	return (true);
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(pNavState[playerid])
	{
		KillTimer(pNavTimer[playerid]);
		DestroyObject(strelica[playerid]);	
		PlayerPlaySound(playerid,1150,0.0,0.0,0.0);
		DisablePlayerCheckpoint(playerid);
		pNavState[playerid] = 0;
		SendClientMessage(playerid, x_red, "Navigacija » "c_white" Navigacija je otkazana jer si napustio vozilo!");
	}
	return (true);
}

Dialog: dialog_navigacija(const playerid, response, listitem, string: inputtext[])
{
	if(response)
	{
		if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, x_red, "Navigacija » "c_white" Moras biti u vozilu da koristis navigaciju!");
		pNavID[playerid] = listitem;
		new str[128];
		SetPlayerCheckpoint(playerid, NavData[pNavID[playerid]][NAV_X], NavData[pNavID[playerid]][NAV_Y], NavData[pNavID[playerid]][NAV_Z], 3.0);
		format(str, 128, "Navigacija » "c_white" Destinacija postavljena na "c_server2"%s", NavData[pNavID[playerid]][NAV_NAME]);
		SendClientMessage(playerid, x_server, str);
		SendClientMessage(playerid, x_server, "Navigacija » "c_white" Mozes kucati "c_server2"/gpsoff "c_white"da ugasis navigaciju.");
		if(IsValidObject(strelica[playerid])) DestroyObject(strelica[playerid]);
		strelica[playerid] = CreateObject(19134, 0, 0, 0, 0, 0, 0);
		Refresh(playerid);
		KillTimer(pNavTimer[playerid]);
		pNavTimer[playerid] = SetTimerEx("Refresh", 100, true, "d", playerid);
		PlayerPlaySound(playerid,1139,0.0,0.0,0.0);
		pNavState[playerid] = 1;
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

stock Float:PointAngle(playerid, Float:xa, Float:ya, Float:xb, Float:yb) // Don't know the owner.
{
	new Float:carangle;
	new Float:xc, Float:yc;
	new Float:angle;
	xc = floatabs(floatsub(xa,xb));
	yc = floatabs(floatsub(ya,yb));
	if (yc == 0.0 || xc == 0.0)
	{
		if(yc == 0 && xc > 0) angle = 0.0;
		else if(yc == 0 && xc < 0) angle = 180.0;
		else if(yc > 0 && xc == 0) angle = 90.0;
		else if(yc < 0 && xc == 0) angle = 270.0;
		else if(yc == 0 && xc == 0) angle = 0.0;
	}
	else
	{
		angle = atan(xc/yc);
		if(xb > xa && yb <= ya) angle += 90.0;
		else if(xb <= xa && yb < ya) angle = floatsub(90.0, angle);
		else if(xb < xa && yb >= ya) angle -= 90.0;
		else if(xb >= xa && yb > ya) angle = floatsub(270.0, angle);
	}
	GetVehicleZAngle(GetPlayerVehicleID(playerid), carangle);
	return floatadd(angle, -carangle);
}

forward Refresh(playerid);
public Refresh(playerid)
{
	new Float:pos[3], Float:pPos[3];
	pPos[0] = NavData[pNavID[playerid]][NAV_X];
	pPos[1] = NavData[pNavID[playerid]][NAV_Y];
	pPos[2] = NavData[pNavID[playerid]][NAV_Z];
	GetVehiclePos(GetPlayerVehicleID(playerid), pos[0], pos[1], pos[2]);
	new Float:rot = PointAngle(playerid, pos[0], pos[1], pPos[0], pPos[1]);
	AttachObjectToVehicle(strelica[playerid], GetPlayerVehicleID(playerid), 0.000000, 0.000000, 1.399998, 0.000000, 90.0, rot + 180);
	if(IsPlayerInRangeOfPoint(playerid, 10.0, pPos[0], pPos[1], pPos[2]))
	{
		KillTimer(pNavTimer[playerid]);
		DestroyObject(strelica[playerid]);
		DisablePlayerCheckpoint(playerid);
		PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
		pNavState[playerid] = 0;
		SendClientMessage(playerid, x_server, "Navigacija » "c_white" Stigao si na lokaciju!");
	}
	return (true);
}