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
 *  @Author         Nodi & Vostic
 *  @Date           28 December 2024
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           anticheat.pwn
 *  @Module         anti-cheat
*/

#include <ysilib\YSI_Coding\y_hooks>

#define MAX_LINES                       10
new bool:ALTPoruke[MAX_PLAYERS];
new PlayerText:AltChatTD_Player[MAX_LINES],
	AltChatTD_Text[MAX_PLAYERS][MAX_LINES][128];	

#define SFKA_EXPLOIT_LOG_COOLDOWN 					(5000)

const SFKA_RPC_GIVETAKEDAMAGE = 115;

static g_sNextExploitAttemptLogTick[MAX_PLAYERS] = { 0, ... };


//* Raknet custom
// Packet/RPC IDs:
const ID_DRIVER_SYNC = (200);
const ID_RCON_COMMAND = (201);
const ID_ONFOOT_SYNC = (207);
const ID_PASSENGER_SYNC = (211);
const ID_AIM_SYNC = (203);
const ID_UNOCCUPIED_SYNC = (209);

const RPC_GIVETAKEDAMAGE = (115);

// Lengths of the packets:
const DRIVER_SYNC_BITS = (512);
const RCON_COMMAND_BITS = (512);
const ONFOOT_SYNC_BITS = (552);
const PASSENGER_SYNC_BITS = (200);
const AIM_SYNC_BITS = (256);
const UNOCCUPIED_SYNC_BITS = (544);

const GIVETAKEDAMAGE_BITS = (113);

stock BS_IsDataLengthValid(BitStream:bs, packetid) {
    new numberOfBits;

    BS_GetNumberOfBitsUsed(bs, numberOfBits);

    switch(packetid) {
    case ID_DRIVER_SYNC: return (numberOfBits == DRIVER_SYNC_BITS);
    case ID_RCON_COMMAND: return (48 <= numberOfBits <= 2088);
    case ID_ONFOOT_SYNC: return (numberOfBits == ONFOOT_SYNC_BITS);
    case ID_PASSENGER_SYNC: return (numberOfBits == PASSENGER_SYNC_BITS);
    case ID_AIM_SYNC: return (numberOfBits == AIM_SYNC_BITS);
    case ID_UNOCCUPIED_SYNC: return (numberOfBits == UNOCCUPIED_SYNC_BITS);
    }
    return 1;
}
//

IRPC:SFKA_RPC_GIVETAKEDAMAGE(playerid, BitStream:bs) {
	if (!BS_IsDataLengthValid(bs, SFKA_RPC_GIVETAKEDAMAGE)) {
		return 0;
	}

	static bool:giveOrTake, rpcPlayer, Float:damageAmount, weaponid, bodyPart;

	BS_ReadValue(bs,
		PR_BOOL, giveOrTake,
		PR_UINT16, rpcPlayer,
		PR_FLOAT, damageAmount,
		PR_UINT32, weaponid,
		PR_UINT32, bodyPart
	);

	if (!giveOrTake && (damageAmount == 0.0 || damageAmount == 1833.331542) && weaponid == 4 && bodyPart == 3) {
		new tick = GetTickCount();

		if (tick > g_sNextExploitAttemptLogTick[playerid]) {
			static string[144];

			format(string, sizeof string, "~b~[ML] ~w~ %s[%d] ~w~pokusava ~b~KILL-ALL EXPLOIT", ReturnPlayerName(playerid), playerid);
			p_sendboxmessage(string);

			g_sNextExploitAttemptLogTick[playerid] = tick + SFKA_EXPLOIT_LOG_COOLDOWN;
		}
		return 0;
	}
	return 1;
}


forward delayed_Kick(playerid);
public delayed_Kick(playerid) {
    return Kick(playerid);
}

stock Altchat_Control(playerid) {


	new Float: AltChat_posY = 209.573348,
        Float: AltChat_YSpacing = 240.026733 - 229.573348;

    for (new i = 0; i < MAX_LINES; i++) {
        AltChatTD_Player[i] = CreatePlayerTextDraw(playerid, 35.599971, AltChat_posY, " ");
        PlayerTextDrawLetterSize(playerid, AltChatTD_Player[i], 0.21, 0.9);
        PlayerTextDrawAlignment(playerid, AltChatTD_Player[i], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, AltChatTD_Player[i], -1);
        PlayerTextDrawSetShadow(playerid, AltChatTD_Player[i], 0);
        PlayerTextDrawSetOutline(playerid, AltChatTD_Player[i], 1);
        PlayerTextDrawBackgroundColour(playerid, AltChatTD_Player[i], 255);
        PlayerTextDrawFont(playerid, AltChatTD_Player[i], TEXT_DRAW_FONT_1);
        PlayerTextDrawSetProportional(playerid, AltChatTD_Player[i], true);
        PlayerTextDrawSetShadow(playerid, AltChatTD_Player[i], 0);
        strmid(AltChatTD_Text[playerid][i], " ", 0, 1);
        AltChat_posY += AltChat_YSpacing;
    }

	return (true);
}

SendAltChatMessage(playerid, const message[])
{
	for(new i = 0; i < MAX_LINES; i ++) 
	{
	    if (i == MAX_LINES - 1) 
		{
	        strmid(AltChatTD_Text[playerid][i], message, 0, strlen(message));
	        break;
	    }
		strmid(AltChatTD_Text[playerid][i], AltChatTD_Text[playerid][i + 1], 0, strlen(AltChatTD_Text[playerid][i + 1]));
	}

	for(new i = 0; i < MAX_LINES; i ++) 
	{
	    PlayerTextDrawSetString(playerid, AltChatTD_Player[i], AltChatTD_Text[playerid][i]);
	    PlayerTextDrawShow(playerid,AltChatTD_Player[i]);
	}
	return 1;
}
	
p_sendboxmessage(const msg[]) 
{
	foreach(new i : Player) 
	{
	    if ( (GetPlayerStaffLevel(i) > 0 ) && ALTPoruke[ i ] == true ) 
		{
 			SendAltChatMessage(i, msg);
	    }
	}
}

stock ACKick(playerid, const code[])
{

   	if(playerid == INVALID_PLAYER_ID) return false;

	new tmp_str[288];
	format(tmp_str, sizeof tmp_str, "~b~[ML:AC]_~w~Igrac_~b~%s[%d]_~w~je_kickovan_sa_servera__~b~[%s]", ReturnPlayerName(playerid), playerid, code);
	p_sendboxmessage(tmp_str);

	SendClientMessage(playerid, x_server, "|MARYLAND| ~ "c_white"Kikovani ste sa servera!");
	SendClientMessage(playerid, x_server, "|MARYLAND| ~ "c_white"Razlog : "c_server"%s!", code);
	SendClientMessage(playerid, x_server, "|MARYLAND| ~ "c_white"Ukoliko mislite da je doslo do greske, obratite se na nasem forumu : "c_server"forum.maryland-ogc.com");
	SendClientMessage(playerid, x_server, "|MARYLAND| ~ "c_white"Kick Type : "c_server"AntiCheat Detection");

	SetTimerEx("delayed_Kick", 150, false, "d", playerid);

    return (true);
}

stock ACWarning(playerid, const code[]) {

	new tmp_str[288];
	format(tmp_str, sizeof tmp_str, "~b~[ML:AC]_~w~Igrac_~b~%s[%d]_~w~mozda_koristi__~b~[%s]", ReturnPlayerName(playerid), playerid, code);
	p_sendboxmessage(tmp_str);

	return (true);
}

hook OnGameModeInit() {

    print("anti-cheat/anticheat.pwn loaded"); 

    return true;
}

hook OnPlayerConnect(playerid) {

	Altchat_Control(playerid);

	return 1;
}

forward OnCheatDetected(playerid, const ip_address[], type, code);
public OnCheatDetected(playerid, const ip_address[], type, code) {

    // switch(code)
    // {
		// case 0: if(!IsPlayerPaused(playerid) && GetPlayerStaffLevel(playerid) < 4) ACKick(playerid, "[0] AirBreak (on foot)");//bio warning //#0 AirBreak (on foot)
		// case 1: if(!IsPlayerPaused(playerid) && GetPlayerStaffLevel(playerid) < 4) ACKick(playerid, "[1] AirBreak (in vehicle)");//bio warning //#1 AirBreak (in vehicle)
		// case 2: if(!IsPlayerPaused(playerid) &&  GetPlayerStaffLevel(playerid) < 1) ACWarning(playerid, "[2] Teleport Hack (on foot)"); // dodaj  && PlayerInfo[playerid][pSupporter] < 1 && PlayerInfo[playerid][pVip] < 1 ako bude warning //#2 Teleport Hack (on foot)
		// case 3: if(!IsPlayerPaused(playerid) ) ACWarning(playerid, "[3] Teleport Hack (in vehicle)");//!! #3 Teleport Hack (in vehicle)
		// case 4: if(GetPlayerStaffLevel(playerid) < 1) ACWarning(playerid, "[4] Teleport Hack (between vehicle)"); //ANTICHEAT MSG bilo iskljuceno - casey ukljucio
		// case 5: ACWarning(playerid, "[5] Moguce bacanje vozila"); //ANTICHEAT MSG bilo iskljuceno - casey ukljucio // #5 Moguce bacanje vozila
		// case 6: ACWarning(playerid, "[6] Teleport Hack (pickups)"); //ANTICHEAT MSG bilo iskljuceno - casey ukljucio //#6 Teleport Hack (pickups)
		// case 7: if(!IsPlayerPaused(playerid) && GetPlayerStaffLevel(playerid) < 3) ACWarning(playerid, "[7] Fly Hack (on foot)"); //#7 Fly Hack (on foot)
		// case 8: if(!IsPlayerPaused(playerid)) ACWarning(playerid, "[8] Fly Hack (in vehicle)"); //#8 Fly Hack (in vehicle)
		// case 9: if(GetPlayerStaffLevel(playerid) < 4) ACKick(playerid, "[9] Speed Hack (on foot)"); //#9 Speed Hack (on foot)
		// case 10: if(!IsPlayerPaused(playerid)) ACWarning(playerid, "[10] Speed Hack (in vehicle)"); //#10 Speed Hack (in vehicle)
		// case 11: ACWarning(playerid, "[11] Health Hack (in vehicle)"); //#11 Health Hack (in vehicle)
		// case 18: ACKick(playerid, "[18] Special Action hack"); // #18 Special Action hack
		// case 20: ACWarning(playerid, "[20] God mode (in vehicle)"); // #20 God mode (in vehicle)
		// case 21: ACWarning(playerid, "[21] Invisible hack"); //#21 Invisible hack
		// case 22: ACWarning(playerid, "[22] Lag comp spoof"); //#22 Lag comp spoof
		// case 24: ACWarning(playerid, "[24] Parkour / WheelWalk"); //#24 Parkour mod
		// case 25: ACWarning(playerid, "[25] Quick turn"); //#25 Quick turn
		// case 26: ACWarning(playerid, "[26] Rapid fire"); //#26 Rapid fire
		// case 27: ACWarning(playerid, "[27] Fake spawn");//#27 Fake spawn
		// case 28: ACKick(playerid, "[28] Fake kill"); //#28 Fake kill
		// case 29: ACWarning(playerid, "[29] Pro Aim");//#29 Pro Aim
		// case 30: ACWarning(playerid, "[30] CJ run");//#30 CJ run
		// case 31: ACKick(playerid, "[31] Car shot");//#31 Car shot
		// case 32: ACWarning(playerid, "[32] Car jack"); //ANTICHEAT MSG bilo iskljuceno - casey ukljucio //#32 Car jack
		// case 34: ACKick(playerid, "[34] AFK Ghost");//#34 AFK Ghost
		// case 35: ACWarning(playerid, "[35] Full Aiming");//#35 Full Aiming
		// case 43: ACKick(playerid, "[43] Tuning Crasher");//#43 Tuning Crasher
		// case 44: ACWarning(playerid, "[44] Invalid seat crasher");//#44 Invalid seat crasher
		// case 46: ACKick(playerid, "[46] Attached object crasher");//#46 Attached object crasher
		// case 47: ACKick(playerid, "[47] Weapon crasher");//#47 Weapon crasher
		// case 49: if(type != 400 && type != 450) ACKick(playerid, "[49] Callback Flood");//#49 Callback Flood
		// case 50: ACKick(playerid, "[50] Seat Flood");//#50 Seat Flood // dodati proveru za cuffed


    // }

	new acReasons[][] = {
        "AirBreak (onfoot)",
        "AirBreak (in vehicle)",
        "teleport hack (onfoot)",
        "teleport hack (in vehicle)",
        "teleport hack (into/between vehicles)",
        "teleport hack (vehicle to player)",
        "teleport hack (pickups)",
        "FlyHack (onfoot)",
        "FlyHack (in vehicle)",
        "SpeedHack (onfoot)",
        "SpeedHack (in vehicle)",
        "Health hack (in vehicle)",
        "Health hack (onfoot)",
        "Armour hack",
        "Money hack",
        "Weapon hack",
        "Ammo hack (add)",
        "Ammo hack (infinite)",
        "Special actions hack",
        "GodMode from bullets (onfoot)",
        "GodMode from bullets (in vehicle)",
        "Invisible hack",
        "lagcomp-spoof",
        "Tuning hack",
        "Parkour mod",
        "Quick turn",
        "Rapid fire",
        "FakeSpawn",
        "FakeKill",
        "Pro Aim",
        "CJ run",
        "CarShot",
        "CarJack",
        "UnFreeze",
        "AFK Ghost",
        "Full Aiming",
        "Fake NPC",
        "Reconnect",
        "High ping",
        "Dialog hack",
        "Protection from sandbox",
        "Protection from invalid version",
        "Rcon hack",
        "Tuning crasher",
        "Invalid seat crasher",
        "Dialog crasher",
        "Attached object crasher",
        "Weapon Crasher",
        "Protection from connection flood in one slot",
        "Anti-callback functions flood",
        "Anti-flood by seat changing",
        "Anti-DoS",
        "Anti-NOPs"
    };
    SendClientMessageToAll(0xFF0056FF, "Player %s(%d) is suspected for %s (Code %d | Type %d)", ReturnPlayerName(playerid), playerid, acReasons[code], code, type);

    return 1;
}

YCMD:altchat(playerid, params[], help)
{
	if( GetPlayerStaffLevel(playerid) < 1 ) return (true);
	if( ALTPoruke[ playerid ] )
	{
		ALTPoruke[ playerid ] = false;
		for (new i = 0; i < MAX_LINES; i ++)
		{
			strmid(AltChatTD_Text[playerid][i], " ", 0, 1);
		}
		for (new i = 0; i < MAX_LINES; i ++) 
		{
			PlayerTextDrawSetString(playerid, AltChatTD_Player[i], AltChatTD_Text[playerid][i]);
			PlayerTextDrawShow(playerid,AltChatTD_Player[i]);
		}
		SendClientMessage(playerid, 0xFF0056FF, "#ANTI-CHEAT : "c_white"Ugasili ste ALT CHAT");
	}
	else if( !ALTPoruke[ playerid ] )
	{
		ALTPoruke[ playerid ] = true;
		SendClientMessage(playerid, 0xFF0056FF, "#ANTI-CHEAT : "c_white"Upalili ste ALT CHAT");
	}
	return 1;
}