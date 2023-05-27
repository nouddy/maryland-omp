/*
? --
?Staff Level
? --
* Staff 1 - //! Support
* Staff 2 - //! Admin
* Staff 3 - //! Head Admin
* Staff 4 - //! Vlasnik
? ==
*/
#include <a_samp>
#include <ysilib\YSI_Storage\y_ini>
#include <ysilib\YSI_Coding\y_timers>
#include <ysilib\YSI_Visual\y_commands>
#include <ysilib\YSI_Coding\y_hooks>
#include <ysilib\YSI_Data\y_foreach>
#include <sscanf\sscanf2>
#include <easy-dialog>

static stock const USER_PATH[64] = "/Korisnici/%s.ini";

new stfveh[MAX_PLAYERS] = { INVALID_VEHICLE_ID, ... };

static
	iStaff[MAX_PLAYERS],
	iSkin[MAX_PLAYERS];

new bool:StaffDuty[MAX_PLAYERS];

hook Account_Load(const playerid, const string: name[], const string: value[]);
hook Account_Load(const playerid, const string: name[], const string: value[])
{
	INI_Int("Staff", iStaff[playerid]);

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerConnect(playerid)
{
	stfveh[playerid] = INVALID_VEHICLE_ID;

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	new INI:File = INI_Open(Korisnici(playerid));
    INI_SetTag(File,"data");
    INI_WriteInt(File, "Staff", iStaff[playerid]);
    INI_Close(File);

	DestroyVehicle(stfveh[playerid]);
	stfveh[playerid] = INVALID_PLAYER_ID;
	StaffDuty[ playerid ] = false;

    return Y_HOOKS_CONTINUE_RETURN_1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(iStaff[playerid] >= 1)
	{
		SetPlayerPosFindZ(playerid, fX, fY, fZ);
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerSpawn(playerid)
{
    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnVehicleDeath(vehicleid, killerid)
{
	DestroyVehicle(stfveh[vehicleid]);
	stfveh[vehicleid] = INVALID_PLAYER_ID;

    return Y_HOOKS_CONTINUE_RETURN_1;
}

//?============================= Hellper Commands (Staff 1) =============================//

YCMD:sduty(playerid, params[], help)
{
	if(!iStaff[playerid])
		return SendClientMessage(playerid, col_red, "GRESKA >> "c_white"Niste clan staffa!");

	static string[128];
	if(StaffDuty[playerid] == false )
 	{
		SetPlayerHealth( playerid, 100);
		SetPlayerArmour( playerid, 99);
		
		StaffDuty[ playerid ] = true;
		format(string, sizeof(string), "Staff %s je sada na duznosti /report", ReturnPlayerName(playerid));
	  	SendClientMessageToAll(-1, string);	
	}
	else if(StaffDuty[playerid] == true)
	{
	 	StaffDuty[playerid] = false;
		format(string, sizeof(string), "Staff %s vise nije na duznosti", ReturnPlayerName(playerid));
	 	SendClientMessageToAll(-1, string);
	}
	new INI:File = INI_Open(Korisnici(playerid));
	INI_SetTag( File, "data" );

	INI_Close( File );

    return true;
}
//!============== Staff Chat ==============//
YCMD:sc(playerid, const string: params[], help)
{
	if(!iStaff[playerid])
		return SendClientMessage(playerid, col_red, "M >> "c_white"Samo staff moze ovo!");
	if(StaffDuty[playerid] == false)
		return SendClientMessage(playerid, col_red, "M >> "c_white"Morate biti admin na duznosti!");

	if (isnull(params))
		return SendClientMessage(playerid, col_yellow, "KORISCENJE >> "c_white"/sc [text]");

	static tmp_str[128];
	format(tmp_str, sizeof(tmp_str), "Staff - %s(%d): "c_white"%s", ReturnPlayerName(playerid), playerid, params);

	foreach (new i: Player)
		if (iStaff[i])
			SendClientMessage(i, col_ltblue, tmp_str);
	
    return Y_HOOKS_CONTINUE_RETURN_1;
}
//!============== Staff Commands ==============//
YCMD:staffcmd(playerid, const string: params[], help)
{
	if(!iStaff[playerid])
		return SendClientMessage(playerid, col_red, "M >> "c_white"Samo staff moze ovo!");

	Dialog_Show(playerid, "dialog_staffcmd", DIALOG_STYLE_MSGBOX,
	""c_server"M >> "c_white"Staff Commands",
	""c_white"%s, Vi ste deo naseg "c_server"staff "c_white"tima!\n\
	"c_server"SLVL1 >> "c_white"/sduty\n\
	"c_server"SLVL1 >> "c_white"/sc\n\
	"c_server"SLVL1 >> "c_white"/staffcmd\n\
	"c_server"SLVL1 >> "c_white"/sveh\n\
	"c_server"SLVL1 >> "c_white"/goto\n\
	"c_server"SLVL1 >> "c_white"/cc\n\
	"c_server"SLVL1 >> "c_white"/fv\n\
	"c_server"SLVL2 >> "c_white"/gethere\n\
	"c_server"SLVL3 >> "c_white"/nitro\n\
	"c_server"SLVL4 >> "c_white"/jetpack\n\
	"c_server"SLVL4 >> "c_white"/setskin\n\
	"c_server"SLVL4 >> "c_white"/xgoto\n\
	"c_server"SLVL4 >> "c_white"/spanel\n\
	"c_server"SLVL4 >> "c_white"/setstaff",
	"U redu", "", ReturnPlayerName(playerid)
	);

    return Y_HOOKS_CONTINUE_RETURN_1;
}
//!============== Staff Vehicles ==============//
YCMD:sveh(playerid, params[], help)
{
	if(!iStaff[playerid])
		return SendClientMessage(playerid, col_red, "M >> "c_white"Samo staff moze ovo!");
	if(StaffDuty[playerid] == false)
		return SendClientMessage(playerid, col_red, "M >> "c_white"Morate biti admin na duznosti!");

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	if (stfveh[playerid] == INVALID_VEHICLE_ID) 
	{
		if (isnull(params))
			return SendClientMessage(playerid, col_yellow, "KORISCENJE >> "c_white"/sveh [Model ID]");

		new modelid = strval(params);

		if (400 > modelid > 611)
			return SendClientMessage(playerid, col_yellow, "KORISCENJE >> "c_white"* Validni modeli su od 400 do 611.");

		new vehicleid = stfveh[playerid] = CreateVehicle(modelid, x, y, z, 0.0, 1, 0, -1);
		SetVehicleNumberPlate(vehicleid, "STAFF");
		PutPlayerInVehicle(playerid, vehicleid, 0);

		SendClientMessage(playerid, col_blue, "M >> "c_white"Stvorili ste vozilo, da ga unistite kucajte '/sveh'.");
	}
	else 
	{
		DestroyVehicle(stfveh[playerid]);
		stfveh[playerid] = INVALID_PLAYER_ID;

		SendClientMessage(playerid, col_blue, "M >> "c_white"Unistili ste vozilo, da ga stvorite kucajte '/veh [Model ID]'.");
	}
	
    return Y_HOOKS_CONTINUE_RETURN_1;
}

//!============== Staff Go to Player ==============//
YCMD:goto(playerid, params[],help)
{
	if(!iStaff[playerid])
		return SendClientMessage(playerid, col_red, "M >> "c_white"Samo staff moze ovo!");
	if(StaffDuty[playerid] == false)
		return SendClientMessage(playerid, col_red, "M >> "c_white"Morate biti admin na duznosti!");

	new giveplayerid, giveplayer[MAX_PLAYER_NAME];
	new Float:plx,Float:ply,Float:plz;
	GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
	if(!sscanf(params, "u", giveplayerid))
	{	
		GetPlayerPos(giveplayerid, plx, ply, plz);
			
		if (GetPlayerState(playerid) == 2)
		{
			new tmpcar = GetPlayerVehicleID(playerid);
			SetVehiclePos(tmpcar, plx, ply+4, plz);
		}
		else
		{
			SetPlayerPos(playerid,plx,ply+2, plz);
		}
		SetPlayerInterior(playerid, GetPlayerInterior(giveplayerid));
	}

    return Y_HOOKS_CONTINUE_RETURN_1;
}
//!============== Staff Clear Chat ==============//
YCMD:cc(playerid, params[], help)
{
	if(!iStaff[playerid])
		return SendClientMessage(playerid, col_red, "M >> "c_white"Samo staff moze ovo!");

	static string[72];
	for(new cc; cc < 110; cc++)
	{
		SendClientMessageToAll(-1, "");
	}
	if(iStaff[playerid] == 1)
	{
		format(string, sizeof(string), "M >> "c_white"Supporter %s, je ocistio chat.", ReturnPlayerName(playerid));
		SendClientMessageToAll(-1, string);
	}
	if(iStaff[playerid] == 2)
	{
		format(string, sizeof(string), "M >> "c_white"Administrator %s, je ocistio chat.", ReturnPlayerName(playerid));
		SendClientMessageToAll(-1, string);
	}
	if(iStaff[playerid] == 3)
	{
		format(string, sizeof(string), "M >> "c_white"Administrator %s, je ocistio chat.", ReturnPlayerName(playerid));
		SendClientMessageToAll(-1, string);
	}
	if(iStaff[playerid] == 4)
	{
		format(string, sizeof(string), "M >> "c_white"Vlasnik %s, je ocistio chat.", ReturnPlayerName(playerid));
		SendClientMessageToAll(-1, string);
	}
    return Y_HOOKS_CONTINUE_RETURN_1;
}
//!============== Staff Popravi Vozilo ==============//
YCMD:fv(playerid, params[], help)
{
	if(!iStaff[playerid])
		return SendClientMessage(playerid, col_red, "M >> "c_white"Samo staff moze ovo!");
	if(StaffDuty[playerid] == false)
		return SendClientMessage(playerid, col_red, "M >> "c_white"Morate biti admin na duznosti!");
	new vehicleid = GetPlayerVehicleID(playerid);
	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, col_red, "M >> "c_white"Niste u vozilu!");
	RepairVehicle(vehicleid);
	SetVehicleHealth(vehicleid, 999.0);
	return Y_HOOKS_CONTINUE_RETURN_1;

}
//?============================= Silver Staff Commands (Staff 2) =============================//
//!============== Staff Get Player do svoje Pozicije ==============//
YCMD:gethere(playerid, const params[], help)
{
	if (iStaff[playerid] < 2)
		return SendClientMessage(playerid, col_red, "M >> "c_white"Samo staff moze ovo!");
	if(StaffDuty[playerid] == false)
		return SendClientMessage(playerid, col_red, "M >> "c_white"Morate biti admin na duznosti!");
		
	new targetid = INVALID_PLAYER_ID;
	if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, col_yellow, "KORISCENJE >> "c_white"/gethere [id]");
	if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, col_red, "GRESKA >> "c_white"Taj ID nije konektovan.");

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	SetPlayerPos(targetid, x+1, y, z+1);
	SetPlayerInterior(targetid, GetPlayerInterior(playerid));
	SetPlayerVirtualWorld(targetid, GetPlayerVirtualWorld(playerid));

	new name[MAX_PLAYER_NAME];
	GetPlayerName(targetid, name, sizeof(name));

	new str[60];
	format(str, sizeof(str), "M >> Teleportovali ste igraca %s do sebe.", name);
	SendClientMessage(playerid, -1, str);

	GetPlayerName(playerid, name, sizeof(name));

	format(str, sizeof(str), "M >> Admin %s vas je teleportovao do sebe.", name);
	SendClientMessage(targetid, -1, str);

    return Y_HOOKS_CONTINUE_RETURN_1;
}

//?============================= Gold Staff Commands (Staff 3) =============================//
//!============== Staff Nitro ==============//
YCMD:nitro(playerid, params[], help)
{
	if (iStaff[playerid] < 3)
		return SendClientMessage(playerid, col_red, "M >> "c_white"Samo staff moze ovo!");

	AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
	SendClientMessage(playerid,-1,"Ugradili ste nitro u vase vozilo.");

	return Y_HOOKS_CONTINUE_RETURN_1;
}


//?============================= Diamond Staff Commands (Staff 4) =============================//
//!============== Staff Jetpack ==============//
YCMD:jetpack(playerid, params[], help)
{
	if (iStaff[playerid] < 4)
		return SendClientMessage(playerid, col_red, "M >> "c_white"Samo staff moze ovo!");

	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);

	return Y_HOOKS_CONTINUE_RETURN_1;
}


//?============================= Head Staff Commands (Staff 5) =============================//
//!============== Staff Set Skin ==============//
YCMD:setskin(playerid, const string: params[], help)
{
	if (iStaff[playerid] < 4)
		return SendClientMessage(playerid, col_red, "M >> "c_white"Samo staff moze ovo!");
	if(StaffDuty[playerid] == false)
		return SendClientMessage(playerid, col_red, "M >> "c_white"Morate biti admin na duznosti!");

	static
		targetid,
		skinid;

	if (sscanf(params, "ri", targetid, skinid))
		return SendClientMessage(playerid, col_yellow, "KORISCENJE >> "c_white"/setskin [targetid] [skinid]");

	if (!(1 <= skinid <= 311))
		return SendClientMessage(playerid, col_red, "GRESKA >> "c_white"Pogresan ID skina!");

	if (GetPlayerSkin(targetid) == skinid)
		return SendClientMessage(playerid, col_red, "GRESKA >> "c_white"Taj igrac vec ima taj skin!");

	SetPlayerSkin(targetid, skinid);

	iSkin[targetid] = skinid;

    new INI:File = INI_Open(Korisnici(playerid));
	INI_SetTag( File, "data" );
    INI_WriteInt(File, "Skin", GetPlayerSkin(playerid));

	INI_Close( File );

    return Y_HOOKS_CONTINUE_RETURN_1;
}
//?============================= Direktor Commands (Staff 6) =============================//
//!============== Staff Go to Koordinate ==============//
YCMD:xgoto(playerid, params[], help)
{
	if (iStaff[playerid] < 4)
		return SendClientMessage(playerid, col_red, "M >> "c_white"Samo staff moze ovo!");
	if(StaffDuty[playerid] == false)
		return SendClientMessage(playerid, col_red, "M >> "c_white"Morate biti admin na duznosti!");
	new Float:x, Float:y, Float:z;
	new string[100];
	if (sscanf(params, "fff", x, y, z)) SendClientMessage(playerid, col_yellow, "KORISCENJE >> "c_white"xgoto <X Float> <Y Float> <Z Float>");
	else
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
		    SetVehiclePos(GetPlayerVehicleID(playerid), x,y,z);
		}
		else
		{
		    SetPlayerPos(playerid, x, y, z);
		}
		format(string, sizeof(string), "M >> "c_white"Postavili ste koordinate na %f, %f, %f", x, y, z);
		SendClientMessage(playerid, col_ltblue, string);
	}
 	return Y_HOOKS_CONTINUE_RETURN_1;
}

//?============================= Vlasnik Commands (Staff 7) =============================//

//!============== Staff Owner Panel ==============//
YCMD:spanel(playerid, params[], help)
{
	if(!IsPlayerAdmin(playerid))
		return SendClientMessage(playerid, col_red, "M >> "c_white"Samo RCON administrator!");
	if (iStaff[playerid] < 4)
		return SendClientMessage(playerid, col_red, "M >> "c_white"Nisi Vlasnik sinovac!");
	
	Dialog_Show(playerid, "dialog_spanel", DIALOG_STYLE_LIST,
		""c_server"M >> "c_white"Owner Panel",
		"Podesavanja\nAdmini\nVreme\nNapravi\nIzmeni\nIzbrisi",
		"Odaberi", "Izlaz"
	);

	return Y_HOOKS_CONTINUE_RETURN_1;
}

Dialog: dialog_spanel(const playerid, response, listitem, string: inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				SendClientMessage(playerid, col_server, "M >> "c_white"Trenuto offline!" );
			}
			case 1:
			{
				SendClientMessage(playerid, col_server, "M >> "c_white"Trenuto offline!" );
			}
			case 2:
			{
				Dialog_Show(playerid, "dialog_vreme", DIALOG_STYLE_LIST,
					""c_server"M >> "c_white"Vreme Panel",
					"Noc\nDan",
					"Odaberi", "Izlaz");
			}
			case 3:
			{
				Dialog_Show(playerid, "dialog_napravi", DIALOG_STYLE_LIST,
					""c_server"M >> "c_white"Napravi Funkcije",
					"Offline",
					"Odaberi", "Izlaz");
			}
			case 4:
			{
				Dialog_Show(playerid, "dialog_izmeni", DIALOG_STYLE_LIST,
					""c_server"M >> "c_white"Izmeni Funkcije",
					"Offline",
					"Odaberi", "Izlaz");
			}
			case 5:
			{
				Dialog_Show(playerid, "dialog_izbrisi", DIALOG_STYLE_LIST,
					""c_server"M >> "c_white"Izbrisi Funkcije",
					"Offline",
					"Odaberi", "Izlaz");
			}
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

Dialog: dialog_vreme(const playerid, response, listitem, string: inputtext[])
{	
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				SetWorldTime(2);
				SendClientMessage(playerid, col_server, "M >> "c_white"Postavili ste vreme na noc!" );
			}
			case 1:
			{
				SetWorldTime(14);
				SendClientMessage(playerid, col_server, "M >> "c_white"Postavili ste vreme na dan!" );
			}
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

Dialog: dialog_napravi(const playerid, response, listitem, string: inputtext[])
{	
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				return SendClientMessage(playerid, col_red, "M >> "c_white"Nema ponudjenih stvari!");
			}
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

Dialog: dialog_izmeni(const playerid, response, listitem, string: inputtext[])
{	
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				return SendClientMessage(playerid, col_red, "M >> "c_white"Nema ponudjenih stvari!");
			}
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}
Dialog: dialog_izbrisi(const playerid, response, listitem, string: inputtext[])
{	
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				return SendClientMessage(playerid, col_red, "M >> "c_white"Nema ponudjenih stvari!");
			}
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}
//!============== Staff Postavi Staff ==============//
YCMD:setstaff(playerid, const string: params[], help)
{
	if (!IsPlayerAdmin(playerid))
		return SendClientMessage(playerid, col_red, "M >> "c_white"Samo RCON administrator!");
	if (iStaff[playerid] < 4)
		return SendClientMessage(playerid, col_red, "M >> "c_white"Nisi Vlasnik sinovac!");

	static
		targetid,
		level;

	if (sscanf(params, "ri", targetid, level))
		return SendClientMessage(playerid, col_yellow, "KORISCENJE >> "c_white"/setstaff [targetid] [0/1]");

	if (!level && !iStaff[targetid])
		return SendClientMessage(playerid, col_red, "M >> "c_white"Taj igrac nije u staff-u.");

	if (level == iStaff[targetid])
		return SendClientMessage(playerid, col_red, "M >> "c_white"Taj igrac je vec u staff-u.");

	iStaff[targetid] = level;
	
	if (!level)
	{
		static fmt_str[64];
		format(fmt_str, sizeof(fmt_str), ""c_yellow"INFO >> "c_white"%s Vas je izbacio iz staff-a.", ReturnPlayerName(playerid));
		SendClientMessage(targetid, -1, fmt_str);
		format(fmt_str, sizeof(fmt_str), ""c_yellow"INFO >> "c_white"Izbacili ste %s iz staff-a.", ReturnPlayerName(targetid));
		SendClientMessage(playerid, -1, fmt_str);
	}
	else
	{
		static fmt_str[64];
		format(fmt_str, sizeof(fmt_str), ""c_yellow"INFO >> "c_white"%s Vas je ubacio u staff.", ReturnPlayerName(playerid));
		SendClientMessage(targetid, -1, fmt_str);
		format(fmt_str, sizeof(fmt_str), ""c_yellow"INFO >> "c_white"Ubacili ste %s u staff.", ReturnPlayerName(targetid));
		SendClientMessage(playerid, -1, fmt_str);
	}

    new INI:File = INI_Open(Korisnici(playerid));
	INI_SetTag( File, "data" );
    INI_WriteInt(File, "Staff", iStaff[playerid]);

	INI_Close( File );

    return Y_HOOKS_CONTINUE_RETURN_1;
}
//!============== Staff Kes za Test ==============//
YCMD:vosticbiznis(playerid, params[],help)
{
	if(iStaff[playerid] < 4)
		return SendClientMessage(playerid, col_red, "M >> "c_white"Samo vlasnik moze ovo!");

    GivePlayerMoney(playerid, 10000);
	
	new INI:File = INI_Open(Korisnici(playerid));
	INI_SetTag( File, "data" );
    INI_WriteInt(File, "Novac", GetPlayerMoney(playerid));

	INI_Close( File );

	return Y_HOOKS_CONTINUE_RETURN_1;
}