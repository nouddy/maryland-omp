

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
