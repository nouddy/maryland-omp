#include <a_samp>
#include <a_actor>
#include <a_objects>
#include <a_players>
#include <a_vehicles>
#include <ysilib\YSI_Coding\y_hooks>
#include <ysilib\YSI_Storage\y_ini>
#include <ysilib\YSI_Coding\y_timers>
#include <ysilib\YSI_Visual\y_commands>
#include <ysilib\YSI_Data\y_foreach>
#include <ysilib\YSI_Data\y_iterate>
#include <sscanf2>
#include <streamer>
#include <easyDialog>
#include <formatex>
#include <distance>
#include <crashdetect>

#include "external/server/color.pwn"

new PlayerText:p_BarTextdraw[MAX_PLAYERS][2];
new PlayerText:p_LocationTextdraw[MAX_PLAYERS][2];
new PlayerText:p_DirectionTextdraw[MAX_PLAYERS];

new bool:p_Direction[MAX_PLAYERS];
new p_TextDirection[8][MAX_PLAYERS];

forward ServerTextdraw(playerid);
public ServerTextdraw(playerid) 
{
	p_BarTextdraw[playerid][0] = CreatePlayerTextDraw(playerid, 124.666679, 419.652221, "mdl-12000:bar");
	PlayerTextDrawTextSize(playerid, p_BarTextdraw[playerid][0], 3.000000, 23.000000);
	PlayerTextDrawAlignment(playerid, p_BarTextdraw[playerid][0], 1);
	PlayerTextDrawColor(playerid, p_BarTextdraw[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, p_BarTextdraw[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, p_BarTextdraw[playerid][0], 255);
	PlayerTextDrawFont(playerid, p_BarTextdraw[playerid][0], 4);
	PlayerTextDrawSetProportional(playerid, p_BarTextdraw[playerid][0], 0);

	p_BarTextdraw[playerid][1] = CreatePlayerTextDraw(playerid, 97.666702, 419.652038, "mdl-12000:bar");
	PlayerTextDrawTextSize(playerid, p_BarTextdraw[playerid][1], 3.000000, 23.000000);
	PlayerTextDrawAlignment(playerid, p_BarTextdraw[playerid][1], 1);
	PlayerTextDrawColor(playerid, p_BarTextdraw[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, p_BarTextdraw[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, p_BarTextdraw[playerid][1], 255);
	PlayerTextDrawFont(playerid, p_BarTextdraw[playerid][1], 4);
	PlayerTextDrawSetProportional(playerid, p_BarTextdraw[playerid][1], 0);
	PlayerTextDrawSetSelectable(playerid, p_BarTextdraw[playerid][1], true);

	p_LocationTextdraw[playerid][0] = CreatePlayerTextDraw(playerid, 129.449325, 418.700775, "lastparty");
	PlayerTextDrawLetterSize(playerid, p_LocationTextdraw[playerid][0], 0.211654, 1.185832);
	PlayerTextDrawAlignment(playerid, p_LocationTextdraw[playerid][0], 2);
	PlayerTextDrawColor(playerid, p_LocationTextdraw[playerid][0], 10092543);
	PlayerTextDrawSetShadow(playerid, p_LocationTextdraw[playerid][0], 1);
	PlayerTextDrawBackgroundColor(playerid, p_LocationTextdraw[playerid][0], 255);
	PlayerTextDrawFont(playerid, p_LocationTextdraw[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, p_LocationTextdraw[playerid][0], 1);

	p_DirectionTextdraw[playerid] = CreatePlayerTextDraw(playerid, 128.343750, 428.600616, "N");
	PlayerTextDrawLetterSize(playerid, p_DirectionTextdraw[playerid], 0.211654, 1.185832);
	PlayerTextDrawAlignment(playerid, p_DirectionTextdraw[playerid], 2);
	PlayerTextDrawColor(playerid, p_DirectionTextdraw[playerid], -1);
	PlayerTextDrawSetShadow(playerid, p_DirectionTextdraw[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, p_DirectionTextdraw[playerid], 255);
	PlayerTextDrawFont(playerid, p_DirectionTextdraw[playerid], 1);
	PlayerTextDrawSetProportional(playerid, p_DirectionTextdraw[playerid], 1);

	for(new i = 0; i < 2; i++) {
		PlayerTextDrawShow(playerid, p_BarTextdraw[playerid][i]);
	}

	for(new i = 0; i < 2; i++) {
		PlayerTextDrawShow(playerid, p_LocationTextdraw[playerid][i]);
	}

	p_Direction[playerid] = true;

	return 1;
}

hook OnGameModeInit()
{
    for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++) 
	{
		if (IsPlayerConnected(i)) 
		{
			ServerTextdraw(i);
		}
	}
    return 1;
}

hook OnPlayerSpawn(playerid)
{
	ServerTextdraw(playerid);
	PlayerTextDrawShow(playerid, p_DirectionTextdraw[playerid]);

	return 1;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
	PlayerTextDrawHide(playerid, p_DirectionTextdraw[playerid]);

	return 1;
}

hook OnPlayerUpdate(playerid)
{
	if(p_Direction[playerid] == false) 
		return 1;

	new Float:rz;
	new p_PreviousDirection[8];

	strcat((p_PreviousDirection[0] = EOS, p_PreviousDirection), p_TextDirection[playerid]);

	if(IsPlayerInAnyVehicle(playerid)) 
	{
		GetVehicleZAngle(GetPlayerVehicleID(playerid), rz);
	}
	else 
	{
		GetPlayerFacingAngle(playerid, rz);
	}

	new angle;

	if(angle >= 355.0 || angle <= 5.0) PlayerTextDrawSetString(playerid, p_DirectionTextdraw[playerid], "N");
	else if(angle >= 265.0 && angle <= 275.0) PlayerTextDrawSetString(playerid, p_DirectionTextdraw[playerid], "E");
	else if(angle >= 175.0 && angle <= 185.0) PlayerTextDrawSetString(playerid, p_DirectionTextdraw[playerid], "S");
	else if(angle >= 85.0 && angle <= 95.0) PlayerTextDrawSetString(playerid, p_DirectionTextdraw[playerid], "W");

	if(rz >= 348.75 || rz < 11.25) p_TextDirection[playerid] = "N";
	else if(rz >= 326.25 && rz < 348.75) p_TextDirection[playerid] = "NNE";
	else if(rz >= 303.75 && rz < 326.25) p_TextDirection[playerid] = "NE";
	else if(rz >= 281.25 && rz < 303.75) p_TextDirection[playerid] = "ENE";
	else if(rz >= 258.75 && rz < 281.25) p_TextDirection[playerid] = "E";
	else if(rz >= 236.25 && rz < 258.75) p_TextDirection[playerid] = "ESE";
	else if(rz >= 213.75 && rz < 236.25) p_TextDirection[playerid] = "SE";
	else if(rz >= 191.25 && rz < 213.75) p_TextDirection[playerid] = "SSE";
	else if(rz >= 168.75 && rz < 191.25) p_TextDirection[playerid] = "S";
	else if(rz >= 146.25 && rz < 168.75) p_TextDirection[playerid] = "SSW";
	else if(rz >= 123.25 && rz < 146.25) p_TextDirection[playerid] = "SW";
	else if(rz >= 101.25 && rz < 123.25) p_TextDirection[playerid] = "WSW";
	else if(rz >= 78.75 && rz < 101.25) p_TextDirection[playerid] = "W";
	else if(rz >= 56.25 && rz < 78.75) p_TextDirection[playerid] = "WNW";
	else if(rz >= 33.75 && rz < 56.25) p_TextDirection[playerid] = "NW";
	else if(rz >= 11.5 && rz < 33.75) p_TextDirection[playerid] = "NNW";

	if(strcmp(p_PreviousDirection, p_TextDirection[playerid]))
		return 1;

	PlayerTextDrawSetString(playerid, p_DirectionTextdraw[playerid], p_TextDirection[playerid]);

	return 1;
}