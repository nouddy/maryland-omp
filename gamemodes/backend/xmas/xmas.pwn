
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
 *  @Author         Silent
 *  @Date           11th Sep 2023
 *  @Weburl         weburl
 *  @Project        maryland_project
 *
 *  @File           xmas.script
 *  @Module         xmas
 */

#include <ysilib\YSI_Coding\y_hooks>

#define MAX_SNOW_OBJECTS    	3
#define SNOW_UPDATE_INTERVAL    1000

static
	bool:SpawnedOnce[MAX_PLAYERS],
	bool:snowOn[MAX_PLAYERS],
	snowObject[MAX_PLAYERS][MAX_SNOW_OBJECTS],
	updateSnow[MAX_PLAYERS];

hook OnGameModeInit()
{
	print("xmas/xmas.script loaded");

	foreach(new i : Player)
	{
		DeleteSnow(i);
		StopAudioStreamForPlayer(i);
			
        SpawnedOnce[i] = true;
        CreateSnow(i);
	}

    return (true);
}

hook OnGameModeExit()
{
    foreach(new i : Player)
	{
        DeleteSnow(i);
		StopAudioStreamForPlayer(i);
	    if(IsPlayerAttachedObjectSlotUsed(i, 1))
			RemovePlayerAttachedObject(i, 1);
	}
	return (true);
}

hook OnPlayerConnect(playerid)
{
	SpawnedOnce[playerid] = false;

	return (true);
}

hook OnPlayerSpawn(playerid)
{
	switch(SpawnedOnce[playerid])
	{
	    case false:
	    {
	        SpawnedOnce[playerid] = true;
	        CreateSnow(playerid);
	    }
	}
	return (true);
}

hook OnPlayerDisconnect(playerid, reason)
{
	Snow_OnDisconnect(playerid);
	return (true);
}

forward UpdateSnow(playerid);
public UpdateSnow(playerid)
{
	if(!snowOn[playerid]) return 0;
	new Float:pPos[3];
	GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
	for(new i = 0; i < MAX_SNOW_OBJECTS; i++)
		SetPlayerObjectPos(playerid, snowObject[playerid][i], pPos[0] + random(25), pPos[1] + random(25), pPos[2] - 5 + random(10));
	return (true);
}

YCMD:snow(playerid, params[], help)
{
	if(snowOn[playerid])
	{
	    DeleteSnow(playerid);
	    SendClientMessage(playerid, -1, ""c_server"xmas » "c_white"Ugasio si sneg.");
	}
	else
	{
	    CreateSnow(playerid);
	    SendClientMessage(playerid, -1, ""c_server"xmas » "c_white"Let it snow, let it snow, let it snow!");
	}
	return (true);
}

YCMD:xmasmusic(playerid, params[], help)
{
	PlayRandomXmasSong(playerid);
    SendClientMessage(playerid, -1, ""c_server"xmas » "c_white"Pustio si pesmu!");
	return (true);
}

YCMD:stopmusic(playerid, params[], help)
{
	StopAudioStreamForPlayer(playerid);
    SendClientMessage(playerid, -1, ""c_server"xmas » "c_white"Ugasio si muziku!");
	return (true);
}

Snow_OnDisconnect(playerid)
{
	if(snowOn[playerid])
	{
	    for(new i = 0; i < MAX_SNOW_OBJECTS; i++)
			DestroyPlayerObject(playerid, snowObject[playerid][i]);
		snowOn[playerid] = false;
		KillTimer(updateSnow[playerid]);
	}
	return (true);
}

PlayRandomXmasSong(playerid)
{
	new i = random(4);
	switch(i)
	{
	    case 0:
	    {
	        PlayAudioStreamForPlayer(playerid, "http://mp3.ecsmedia.pl/track/music/00/00/04/40/65351932/1/6_30.mp3");
	    }
	    case 1:
	    {
            PlayAudioStreamForPlayer(playerid, "http://a.tumblr.com/tumblr_lvt3rdshTe1r7b27vo1.mp3");
	    }
	    case 2:
	    {
            PlayAudioStreamForPlayer(playerid, "http://www.panicstream.com/streams/temp/xmas/ultimate/1-02%20-%20Jingle%20Bell%20Rock.mp3");
	    }
	    case 3:
	    {
            PlayAudioStreamForPlayer(playerid, "http://www.turnbacktogod.com/wp-content/uploads/2008/12/rockin-around-the-christmas-tree.mp3");
	    }
	}
	return (true);
}

CreateSnow(playerid)
{
	if(snowOn[playerid]) return 0;
	new Float:pPos[3];
	GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
	for(new i = 0; i < MAX_SNOW_OBJECTS; i++)
		snowObject[playerid][i] = CreatePlayerObject(playerid, 18864, pPos[0] + random(25), pPos[1] + random (25), pPos[2] - 5 + random(10), random(280), random(280), 0);
	snowOn[playerid] = true;
	updateSnow[playerid] = SetTimerEx("UpdateSnow", SNOW_UPDATE_INTERVAL, true, "i", playerid);
	return (true);
}

DeleteSnow(playerid)
{
	if(!snowOn[playerid]) return 0;
	for(new i = 0; i < MAX_SNOW_OBJECTS; i++)
		DestroyPlayerObject(playerid, snowObject[playerid][i]);
	KillTimer(updateSnow[playerid]);
	snowOn[playerid] = false;
	return (true);
}