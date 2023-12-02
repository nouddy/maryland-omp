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
 *  @Author         Vostic & Ogy_
 *  @Date           05th May 2023
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           main.script
 *  @Module         main
 */



/*
	@TODO: 	Regex for mail and roleplay name
			Handle already existing RolePlay name.
			Move temporary variables to pVar's
			Check variables reseting
			OnPlayerLoad hook or something similar
			Autologin option?
			Developers and testers ability to save custom spawn pos
*/


#include ".\backend\assets\UpdatePlayerKeys.pwn"
#include ".\backend\assets\Slider.pwn"
#include ".\backend\assets\3DMenu.pwn"

#include <ysilib\YSI_Coding\y_hooks>
#include <ysilib\YSI_Coding\y_inline>

#define CAM_START_POS		-1629.9329,1051.5292,53.7
#define CAM_START_LOOKAT	-1641.0522,1054.5549,54.1

#define CAM_START_POS2		-1629.9329,1051.5292,53.7
#define CAM_START_LOOKAT2	-1637.9705,1043.2223,54.1

#define CHAR_WALK_STYLE_POS -1637.5802,1045.2665,54.1497
#define CHAR_WALK_STYLE_ROT	315.4695

#define boxtextcolor 		0xFFC0C0C0
#define boxtextbg 			0x00000000

//Old color was 910778367
#define TD_HOVER_COLOR		0x36495FFF

const MAX_PASSWORD_LENGTH = 64;
const MIN_PASSWORD_LENGTH = 6;

const MAX_LOGIN_ATTEMPTS = 	3;
new pLoginAttempts[MAX_PLAYERS];

new pRegisterMail[MAX_PLAYERS][128];
new pRegisterPassword[MAX_PLAYERS][128];

new p3DMenu[MAX_PLAYERS] = -1;


new pCharacterIDX[MAX_PLAYERS];

//Temporary stuff (probably best to use pVars...)
new pTmpSkinIDX[MAX_PLAYERS],
	tmpCharID[MAX_PLAYERS][3],
	tmpCharName[MAX_PLAYERS][3][24],
	tmpCharSkin[MAX_PLAYERS][3],
	eGender:tmpCharGender[MAX_PLAYERS][3],
	tmpCharAge[MAX_PLAYERS][3],
	tmpCharJob[MAX_PLAYERS][3],
	tmpCharState[MAX_PLAYERS][3],
	tmpCharLastLogin[MAX_PLAYERS][3];

//==============================================================================
enum ePLAYER_CONNECT_STATE {
	PLAYER_CONNECT_STATE_UNKNOWN,
	PLAYER_CONNECT_STATE_CONNECTED,
	PLAYER_CONNECT_STATE_LOGIN,
	PLAYER_CONNECT_STATE_REGISTER,
	PLAYER_CONNECT_STATE_CHOSE_CHARACTER,
	PLAYER_CONNECT_STATE_CREATE_CHARACTER,	
	PLAYER_CONNECT_STATE_SPAWNED,
}
new ePLAYER_CONNECT_STATE:pConnectState[MAX_PLAYERS];


enum ePLAYER_SELECTION {
	INVALID_PLAYER_SELECTION,
	PLAYER_SELECTION_CHARACTER_SETUP,
	PLAYER_SELECTION_GENDER,
	PLAYER_SELECTION_SKIN,//Slider
	PLAYER_SELECTION_AGE,//Slider
	PLAYER_SELECTION_STATE,
	PLAYER_SELECTION_WALKING_STYLE
}
new ePLAYER_SELECTION:pSelectionType[MAX_PLAYERS];

enum eGender
{
    GENDER_MALE,
    GENDER_FEMALE
}

new GenderString[eGender][8] = {
    "Musko",
    "Zensko"
};

stock GetGenderString(eGender:gender)
{
    return GenderString[gender];
}

enum eCharacterCreateButton {
	PlayerText:BUTTON_CREATE_CHARACTER,
	PlayerText:BUTTON_CHOSE_CHARACTER,
	PlayerText:BUTTON_DELETE_CHARACTER
}

static const NameAnimations[][] =
{
    "WALK_player",
    "WALK_civi",
    "WALK_gang1",
    "WALK_gang2",
    "WALK_old",
    "WALK_fatold",
    "WALK_fat",
    "WOMAN_walkold",
    "WOMAN_walkfatold",
    "WALK_shuffle",
    "WOMAN_walknorm",
    "WOMAN_walkbusy",
    "WOMAN_walkpro",
    "WOMAN_walksexy",
    "WALK_drunk",
    "WALK_Wuzi"
};


static const CharacterDefaultSkins[2][3] = {
	{22,26,60},
	{12,93,193}
};

enum PlayerInformation
{
	SQLID,
	Username[MAX_PLAYER_NAME],
	Password[144],
	Staff,
	LastLogin,
	RegisterDate[50],
	Email[50],
}
new PlayerInfo[MAX_PLAYERS][PlayerInformation];

new Float:RandomSpawnCords[ 3 ][ 4 ] = {

    { 1401.7791,1591.3466,12.0481,0.0},
    { 1401.7791,1591.3466,12.0481,0.0},
    { 1401.7791,1591.3466,12.0481,0.0}
};


enum e_CHARACTER_DATA {
	SQLID,
	Name[MAX_PLAYER_NAME],
	eGender:Gender,
	Skin,
	Age,
	WalkStyle,
	State,
	Money,
	Level,
	Job,
	Float:lastPos[3]
}
new CharacterInfo[MAX_PLAYERS][e_CHARACTER_DATA];


hook OnPlayerConnect(playerid)
{	
	ResetPlayerRegLogVars(playerid);

	ResetPlayerRegisterTextDraw(playerid);
	ResetPlayerLoginTextDraw(playerid);

	new query[120];
	mysql_format(SQL, query, sizeof(query), "SELECT * FROM `accounts` WHERE `Username` = '%e'  LIMIT 1", ReturnPlayerName(playerid));
	mysql_tquery(SQL, query, "SQL_AccountCheck", "i", playerid);
	return Y_HOOKS_CONTINUE_RETURN_1;
}


hook OnPlayerDisconnect(playerid, reason)
{
	Destroy3DMenu(p3DMenu[playerid]);
	p3DMenu[playerid] = INVALID_3D_MENU;

	new q[120];
	mysql_format(SQL, q, sizeof q, "UPDATE `characters` SET `cMoney` = '%f' WHERE `character_id` = '%d'", GetPlayerMoney(playerid), CharacterInfo[playerid][SQLID]);
	mysql_tquery(SQL, q);

	ResetPlayerRegLogVars(playerid);

	pConnectState[playerid] = PLAYER_CONNECT_STATE_UNKNOWN;
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerRequestClass(playerid, classid)
{
	TogglePlayerSpectating(playerid, true);
	return Y_HOOKS_CONTINUE_RETURN_1;
}

forward SQL_AccountCheck(playerid);
public SQL_AccountCheck(playerid)
{
    static rows;
	cache_get_row_count(rows);
	if(!rows)
	{
		pConnectState[playerid] = PLAYER_CONNECT_STATE_REGISTER;

		CreatePlayerRegisterTextDraw(playerid);
		ShowPlayerRegisterTextDraw(playerid);
		SelectTextDraw(playerid, TD_HOVER_COLOR);
	}
	else
	{
		cache_get_value_name_int(0, "ID", PlayerInfo[playerid][SQLID]);
		cache_get_value_name(0, "Password", PlayerInfo[playerid][Password]);
		cache_get_value_name_int(0, "Staff", PlayerInfo[playerid][Staff]);

		pConnectState[playerid] = PLAYER_CONNECT_STATE_LOGIN;

		CreatePlayerLoginTextDraws(playerid);
		ShowPlayerLoginDialog(playerid);
	}
}

stock ShowPlayerLoginDialog(playerid)
{
	SetPlayerInterior(playerid, 1);
	SetPlayerVirtualWorld( playerid, MAX_PLAYERS+1);

	SetPlayerPos(playerid,633.7927,-1765.8979,19.4339);
	SetPlayerFacingAngle(playerid,176.0717);

	InterpolateCameraPos(playerid, CAM_START_POS, CAM_START_POS2, 1000);
	InterpolateCameraLookAt(playerid, CAM_START_LOOKAT, CAM_START_LOOKAT, 1000);

	ShowPlayerLoginTextDraw(playerid);

	new sDStrg[ 560 ],ip[50];
	GetPlayerIp(playerid, ip, sizeof(ip));
	format( sDStrg, sizeof( sDStrg ), "{ffffff}Dobro nam dosli nazad na "c_server"Mary"c_server2"Land Community.\n \n\
			\t\t{ffffff}Ime: "c_server"%s\n\
			\t\t{ffffff}IP: "c_server2"%s \n \n\
			{ffffff}Molimo vas da unesete vasu lozinku.\n\
			{ffffff}kako biste se uspesno prijavili na  server\n\
			{ffffff}Imate 3 pokusaja da unesete tacnu lozinku i 60 sekundi.\n\
			\n\
			Uzivajte igrajuci na nasem serveru!\n\
			",ReturnPlayerName(playerid),ip);


	Dialog_Show(playerid, "PlayerLoginDialog", DIALOG_STYLE_PASSWORD,
			"Login Dialog",
			sDStrg,
			"Potvrdi", "Izlaz"
	);

	return 1;
}

Dialog: PlayerLoginDialog(const playerid, response, listitem, string: inputtext[])
{
	if (!response)
		return Kick(playerid);

	if(response)
	{

		if(strcmp(inputtext, PlayerInfo[playerid][Password]) == 0 && strlen(inputtext) == strlen(PlayerInfo[playerid][Password]))
		{
		
			new q[128];
			mysql_format(MySQL:SQL, q, sizeof q, "SELECT * FROM `characters` WHERE `account_id` = '%d' LIMIT 3", GetPlayerSQLID(playerid));
			mysql_tquery(MySQL:SQL, q, "SqlGetPlayerCharacters", "d", playerid);
			return 1;
		}
		else
		{
			if (pLoginAttempts[playerid] == MAX_LOGIN_ATTEMPTS)
				return Kick(playerid);

			pLoginAttempts[playerid]++;

			new sDStrg[ 560 ],ip[50];
			GetPlayerIp(playerid, ip, sizeof(ip));
			format( sDStrg, sizeof( sDStrg ), "{ffffff}Dobro nam dosli nazad na "c_server"Mary"c_server2"Land Community.\n \n\
					\t\t{ffffff}Ime: "c_server"%s\n\
					\t\t{ffffff}IP: "c_server2"%s \n \n\
					{ffffff}Molimo vas da unesete vasu lozinku.\n\
					{ffffff}kako biste se uspesno prijavili na  server\n\
					{ffffff}Imate 3 pokusaja da unesete tacnu lozinku i 60 sekundi.\n\
					\n\
					Uzivajte igrajuci na nasem serveru!\n\
					",ReturnPlayerName(playerid),ip);

			
			Dialog_Show(playerid, "PlayerLoginDialog", DIALOG_STYLE_PASSWORD,
					"Login Dialog",
					sDStrg,
					"Potvrdi", "Izlaz"
			);

			SendClientMessage(playerid, 0xFF0064FF, "[Login Podatci]: {ffffff}Pogresili ste lozinku [%d/"#MAX_LOGIN_ATTEMPTS"]", pLoginAttempts[playerid]);
			return 1;
		}
	}
	return 1;
}

forward SqlGetPlayerCharacters(playerid);
public SqlGetPlayerCharacters(playerid) {

	pConnectState[playerid] = PLAYER_CONNECT_STATE_CHOSE_CHARACTER;
	new rows = cache_num_rows();
	DestroyPlayerLoginTextDraws(playerid);
	CreatePlayerChoseCharacterMainTextDraw(playerid);

	new tmpStateStr[4][24] = {
		"Unknown",
		"Maryland",
		"Egypt",
		"Little Italy"
	};

	for(new i = 0; i < rows; i++) {
		cache_get_value_name_int(i, "character_id", tmpCharID[playerid][i]);
		cache_get_value_name(i, "cName", tmpCharName[playerid][i], 24);
		cache_get_value_name_int(i, "cSkin", tmpCharSkin[playerid][i]);
		cache_get_value_name_int(i, "cGender", _:tmpCharGender[playerid][i]);
		cache_get_value_name_int(i, "cAge", tmpCharAge[playerid][i]);
		cache_get_value_name_int(i, "cJob", tmpCharJob[playerid][i]);
		cache_get_value_name_int(i, "cState", tmpCharState[playerid][i]);
		cache_get_value_name_int(i, "cLastLogin", tmpCharLastLogin[playerid][i]);

		CreatePlayerChoseCharacterTextDraw(playerid, i, tmpCharSkin[playerid][i], tmpCharName[playerid][i], tmpCharGender[playerid][i], tmpCharAge[playerid][i], "Dvorska Luda", tmpStateStr[tmpCharState[playerid][i]], tmpCharLastLogin[playerid][i]);
	}

	for(new i = rows; i < 3; i++)
	{
		CreatePlayerChoseCharacterTextDraw(playerid, i);
	}
	ShowPlayerChoseCharacterTextDraw(playerid);
	SelectTextDraw(playerid, TD_HOVER_COLOR);
	return true;
}

hook OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if(pConnectState[playerid] != PLAYER_CONNECT_STATE_REGISTER) return Y_HOOKS_CONTINUE_RETURN_1;

	if(IsPlayerRegisterTDMail(playerid, playertextid))
	{
		Dialog_Show(playerid, "PlayerRegisterMail", DIALOG_STYLE_INPUT,
				"Register - Mail",
				"Unesite vas eMail:",
				"Potvrdi", "Izlaz"
		);
	}

	if(IsPlayerRegisterTDPassword(playerid, playertextid))
	{
		Dialog_Show(playerid, "PlayerRegisterPassword", DIALOG_STYLE_PASSWORD,
				"Register - Password",
				"Unesite vasu novu lozinku:",
				"Potvrdi", "Izlaz"
		);
	}

	if(IsPlayerRegisterTDConfirm(playerid, playertextid))
	{
		if(strlen(pRegisterMail[playerid]) == 0)
			return SendClientMessage(playerid, -1, "Greska: Niste uneli eMail");

		if(strlen(pRegisterPassword[playerid]) == 0)
			return SendClientMessage(playerid, -1, "Greska: Niste uneli password");

		DestroyPlayerRegisterTextDraw(playerid);
		
		new query[120];
		mysql_format(SQL, query, sizeof(query), "INSERT INTO `accounts` SET `Username` = '%e', `Password` = '%e', `Email` = '%e'", ReturnPlayerName(playerid), pRegisterPassword[playerid], pRegisterMail[playerid]);
		mysql_tquery(SQL, query, "SQL_InsertAccount", "i", playerid);
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

forward SQL_InsertAccount(playerid);
public SQL_InsertAccount(playerid)
{
	PlayerInfo[playerid][SQLID] = cache_insert_id();
	if(PlayerInfo[playerid][SQLID] == -1)
	{
		SendClientMessage(playerid, -1, "Desila se greska prilikom kreiranja naloga. Reconnect i pokusajte ponovo.");		
		SendClientMessage(playerid, -1, "Ukoliko se problem ponovi, kontaktirajte admine.");
		Kick(playerid);
		return 1;
	}

	CreatePlayerChoseCharacterMainTextDraw(playerid);
	for(new i = 0; i < 3; i++)
	{
		CreatePlayerChoseCharacterTextDraw(playerid, i);
	}
	ShowPlayerChoseCharacterTextDraw(playerid);
	SelectTextDraw(playerid, TD_HOVER_COLOR);
	return 1;
}

Dialog:PlayerRegisterMail(const playerid, response, listitem, string: inputtext[])
{
	if(response == 0 || strlen(inputtext) == 0)
	{
		Dialog_Show(playerid, "PlayerRegisterMail", DIALOG_STYLE_INPUT,
				"Register - Mail",
				"Greska:eMail ne moze biti prazan.\nUnesite vas eMail:",
				"Potvrdi", "Izlaz"
		);
		pRegisterMail[playerid][0] = '\0';
		return 1;
	}

	if(strfind(inputtext, "@", true) == -1)
	{
		Dialog_Show(playerid, "PlayerRegisterMail", DIALOG_STYLE_INPUT,
				"Register - Mail",
				"Greska:eMail nije u validnom formatu.\nUnesite vas eMail:",
				"Potvrdi", "Izlaz"
		);
		pRegisterMail[playerid][0] = '\0';
		return 1;
	}


	new query[128];
	mysql_format(SQL, query, sizeof(query), "SELECT `Email` FROM `accounts` WHERE `Email` = '%e'", inputtext);
	mysql_tquery(SQL, query, "SQL_CheckEMail", "is", playerid, inputtext);
	return 1;
}

forward SQL_CheckEMail(playerid, string:email[]);
public SQL_CheckEMail(playerid, string:email[])
{
	if(cache_num_rows())
	{
		Dialog_Show(playerid, "PlayerRegisterMail", DIALOG_STYLE_INPUT,
				"Register - Mail",
				"Greska: Taj eMail se vec koristi.\nUnesite vas eMail:",
				"Potvrdi", "Izlaz"
		);
		pRegisterMail[playerid][0] = '\0';
		return 0;
	}

	format(pRegisterMail[playerid], sizeof(pRegisterMail[]), "%s", email);
	SelectTextDraw(playerid, TD_HOVER_COLOR);
	return 1;
}

Dialog: PlayerRegisterPassword(const playerid, response, listitem, string: inputtext[])
{
	if(strlen(inputtext) < MIN_PASSWORD_LENGTH || strlen(inputtext) > MAX_PASSWORD_LENGTH)
	{
		Dialog_Show(playerid, "PlayerRegisterPassword", DIALOG_STYLE_PASSWORD,
				"Register - Password",
				"Greska: Password ne moze biti kraci od "#MIN_PASSWORD_LENGTH" karaktera ili duzi od "#MAX_PASSWORD_LENGTH".\nUnesite vas novi Password:",
				"Potvrdi", "Izlaz"
		);		
		return 1;
	}

	format(pRegisterPassword[playerid], sizeof(pRegisterPassword[]), "%s", inputtext);
	SelectTextDraw(playerid, TD_HOVER_COLOR);
	return 1;
}


forward OnPlayerClickCharacterSelectTextDraw(playerid, characterid, eCharacterCreateButton:button);
public OnPlayerClickCharacterSelectTextDraw(playerid, characterid, eCharacterCreateButton:button)
{
	pCharacterIDX[playerid] = characterid;
	if(button == BUTTON_CREATE_CHARACTER)
	{
		DestroyPlayerChoseCharacterTextDraws(playerid);

		TogglePlayerSpectating(playerid, false);
		TogglePlayerControllable(playerid, false);

		SetSpawnInfo(playerid, NO_TEAM, CharacterDefaultSkins[CharacterInfo[playerid][Gender]][pTmpSkinIDX[playerid]], -1634.7615,1055.0187,53.2197,176.6615, WEAPON_FIST, 0, WEAPON_FIST, 0, WEAPON_FIST, 0);
		SpawnPlayer(playerid);

		SetPlayerInterior(playerid, 1);
		SetPlayerVirtualWorld(playerid, playerid+1);

		SetTimerEx("PrepareCharacterCreate", 10, false, "d", playerid);
		CancelSelectTextDraw(playerid);

		Dialog_Show(playerid, "PlayerCreateCharacterName", DIALOG_STYLE_INPUT, "Create Character - Name", "Unesite roleplay ime i prezime vaseg novog karaktera:", "Potvrdi", "");
	}


	if(button == BUTTON_DELETE_CHARACTER)
	{
		Dialog_Show(playerid, "DialogPlayerCharacterDelete", DIALOG_STYLE_MSGBOX, "Character - Delete", "Da li ste sigurni da zelite izbrisati karaktera?\nUpozorenje: Ova radnja se ne moze ponistiti!", "Izbrisi", "Nazad");
	}

	if(button == BUTTON_CHOSE_CHARACTER)
	{
		CharacterInfo[playerid][SQLID] = tmpCharID[playerid][characterid];
		new query[128];
		mysql_format(SQL, query, sizeof(query), "SELECT * FROM `characters` WHERE `character_id` = %d LIMIT 1", CharacterInfo[playerid][SQLID]);
		mysql_tquery(SQL, query, "SQL_PlayerChoseCharacter", "dd", playerid, characterid);
	}
	return 1;
}

forward SQL_PlayerChoseCharacter(playerid, characteridx);
public SQL_PlayerChoseCharacter(playerid, characteridx)
{
	new rows = cache_num_rows();

	for(new i = 0; i < rows; i++) {
		cache_get_value_name(i, "cName", CharacterInfo[playerid][Skin], MAX_PLAYER_NAME);
		cache_get_value_name_int(i, "cSkin", CharacterInfo[playerid][Skin]);
		cache_get_value_name_int(i, "cGender",CharacterInfo[playerid][Gender]);
		cache_get_value_name_int(i, "cAge", CharacterInfo[playerid][Age]);
		cache_get_value_name_int(i, "cJob", CharacterInfo[playerid][Job]);
		cache_get_value_name_int(i, "cState", CharacterInfo[playerid][State]);
		cache_get_value_name_int(i, "cMoney", CharacterInfo[playerid][Money]);
		cache_get_value_name_float(i, "cLastX", CharacterInfo[playerid][lastPos][0]);
		cache_get_value_name_float(i, "cLastY", CharacterInfo[playerid][lastPos][1]);
		cache_get_value_name_float(i, "cLastZ", CharacterInfo[playerid][lastPos][2]);
	}

	DestroyPlayerChoseCharacterTextDraws(playerid);
	
	Destroy3DMenu(p3DMenu[playerid]);
	p3DMenu[playerid] = INVALID_3D_MENU;

	CancelSelectTextDraw(playerid);

	TogglePlayerSpectating(playerid, false);
	TogglePlayerControllable(playerid, true);
					
	SetPlayerVirtualWorld(playerid, 6);
	SetPlayerInterior(playerid, 6);
					
	SetPlayerMoney2(playerid, CharacterInfo[playerid][Money]);
	
	SetSpawnInfo(playerid, NO_TEAM, CharacterInfo[playerid][Skin], CharacterInfo[playerid][lastPos][0], CharacterInfo[playerid][lastPos][1], CharacterInfo[playerid][lastPos][2], 0.0);
	pConnectState[playerid] = PLAYER_CONNECT_STATE_SPAWNED;


	TogglePlayerTextDraw(playerid, true);
	SpawnPlayer(playerid);
	return 1;
}

Dialog:DialogPlayerCharacterDelete(const playerid, response, listitem, string: inputtext[])
{
	if(response)
	{
		new query[128];
		mysql_format(SQL, query, sizeof(query), "DELETE FROM `characters` WHERE `character_id` = %d", tmpCharID[playerid][pCharacterIDX[playerid]]);
		mysql_tquery(SQL, query, "SQL_PlayerDeleteCharacter", "ii", playerid, pCharacterIDX[playerid]);
	}
	return 1;	
}

forward SQL_PlayerDeleteCharacter(playerid, characteridx);
public SQL_PlayerDeleteCharacter(playerid, characteridx)
{
	if(cache_affected_rows() == -1 || cache_affected_rows() == 0)
	{
		SendClientMessage(playerid, -1, "Greska: Desila se greska pri brisanju karaktera. Pokusajte ponovo, ukoliko se greska ponovi kontaktirajte admina.");
		return 1;
	}

	DestroyPlayerChoseCharacterTextDraw(playerid, characteridx);
	CreatePlayerChoseCharacterTextDraw(playerid, characteridx);
	return 1;
}

Dialog: PlayerCreateCharacterName(const playerid, response, listitem, string: inputtext[])
{
	if(!response)
	{
		Dialog_Show(playerid, "PlayerCreateCharacterName", DIALOG_STYLE_INPUT, "Create Character - Name", "Unesite roleplay ime i prezime vaseg novog karaktera:", "Potvrdi", "");
		return 1;
	}		

	if(strlen(inputtext) < 6)
	{
		Dialog_Show(playerid, "PlayerCreateCharacterName", DIALOG_STYLE_INPUT,
				"Create Character - Name",
				"Greska:Ime je previse kratko da bude validno.\nUnesite roleplay ime i prezime vaseg novog karaktera:",
				"Potvrdi", ""
		);
		return 1;
	}

	if(strfind(inputtext, "_", true) == -1)
	{
		Dialog_Show(playerid, "PlayerCreateCharacterName", DIALOG_STYLE_INPUT,
				"Create Character - Name",
				"Greska:Ime i prezime ne moze biti krace od 6 slova.\nUnesite roleplay ime i prezime vaseg novog karaktera:",
				"Potvrdi", ""
		);		
		return 1;
	}

	new query[128];
	mysql_format(SQL, query, sizeof(query), "SELECT `cName` FROM `characters` WHERE `cName` = '%e'", inputtext);
	mysql_tquery(SQL, query, "SQL_CheckRolePlayName", "is", playerid, inputtext);
	return 1;
}
forward SQL_CheckRolePlayName(playerid, string:rpname[]);
public SQL_CheckRolePlayName(playerid, string:rpname[])
{
	if(cache_num_rows())
	{
		Dialog_Show(playerid, "PlayerCreateCharacterName", DIALOG_STYLE_INPUT,
				"Create Character - Name",
				"Greska:Karakter sa tim imenom vec postoji.\nUnesite roleplay ime i prezime vaseg novog karaktera:",
				"Potvrdi", ""
		);
		return 0;
	}

	format(CharacterInfo[playerid][Name], MAX_PLAYER_NAME, "%s", rpname);
	CancelSelectTextDraw(playerid);
	Dialog_Close(playerid);
	return 1;
}

CMD:testanim(playerid, string:params[])
{
	// bool:ApplyAnimation(playerid, const animationLibrary[], const animationName[], Float:delta, bool:loop, bool:lockX, bool:lockY, bool:freeze, time, FORCE_SYNC:forceSync = SYNC_NONE)
	ApplyAnimation(playerid, "INT_HOUSE", "LOU_Loop", 4.1, false, true, true, true, 0);
	return 1;
}

CMD:stopanim(playerid, string:params[])
{
	ClearAnimations(playerid);
	return 1;
}

forward PrepareCharacterCreate(playerid);
public PrepareCharacterCreate(playerid)
{
	TogglePlayerControllable(playerid, false);	
		
	CreateCharacterSetupMenu(playerid);

	SendClientMessage(playerid, x_server, "maryland \187; "c_white"Dobro dosli %s na kreaciju vaseg karaktera.", ReturnPlayerName(playerid));
	SendClientMessage(playerid, x_server, "maryland \187; "c_white"Izabrane opcije se cuvaju i nece se moci mijenjati, izuzetak je skin.");

	SendClientMessage(playerid, x_server, "maryland \187; "c_white"Koristite strelice Gore/Dole/Lijevo/Desno (ili W/A/S/D) za navigaciju.");
	SendClientMessage(playerid, x_server, "maryland \187; "c_white"Da odaberete oznacenu mogucnost pritsnite F ili Enter");

	return 1;

}

stock CreateCharacterSetupMenu(playerid)
{
	//-1640.8479,1053.9279,54.1497,270.5175
	new CHSMenuID = Create3DMenu(-1640.8479,1053.9279,55.0, 90.00, 6, playerid);
	SetBoxText(CHSMenuID, 0, "Gender", OBJECT_MATERIAL_SIZE_128x32, "Arial", 22, 1, boxtextcolor, boxtextbg, 0);
	SetBoxText(CHSMenuID, 1, "Skin", OBJECT_MATERIAL_SIZE_128x32, "Arial", 22, 1, boxtextcolor, boxtextbg, 0);
	SetBoxText(CHSMenuID, 2, "Walking Style", OBJECT_MATERIAL_SIZE_128x32, "Arial", 22, 1, boxtextcolor, boxtextbg, 0);
	SetBoxText(CHSMenuID, 3, "State", OBJECT_MATERIAL_SIZE_128x32, "Arial", 22, 1, boxtextcolor, boxtextbg, 0);
	SetBoxText(CHSMenuID, 4, "Attachment", OBJECT_MATERIAL_SIZE_128x32, "Arial", 22, 1, boxtextcolor, boxtextbg, 0);
	SetBoxText(CHSMenuID, 5, "Create", OBJECT_MATERIAL_SIZE_128x32, "Arial", 22, 1, boxtextcolor, boxtextbg, 0);

	StartPlayerKeysUpdate(playerid);
	Select3DMenu(playerid,CHSMenuID, 0);

	pSelectionType[playerid] = PLAYER_SELECTION_CHARACTER_SETUP;
	p3DMenu[playerid] = CHSMenuID;

	TogglePlayerControllable(playerid, false);
	SetPlayerPos(playerid, -1634.7615,1055.0187,53.200);
	SetPlayerFacingAngle(playerid, 176.6615);
	ApplyAnimation(playerid, "INT_HOUSE", "LOU_Loop", 4.1, false, true, true, true, 0);

	InterpolateCameraPos(playerid, CAM_START_POS, CAM_START_POS2, 3500);
	InterpolateCameraLookAt(playerid, CAM_START_LOOKAT2, CAM_START_LOOKAT, 3500);
	return CHSMenuID;
}

//==============================================================================
//--->>> 3D Menu
//==============================================================================
public OnPlayerSelect3DMenuBox(playerid,MenuID,selected)
{	
	if(MenuID != p3DMenu[playerid]) return Y_HOOKS_CONTINUE_RETURN_1;

	//==============================================================================
	if(pSelectionType[playerid] == PLAYER_SELECTION_GENDER)
	{
		switch(selected)
		{
			case 0: CharacterInfo[playerid][Gender] = GENDER_MALE;
			case 1: CharacterInfo[playerid][Gender] = GENDER_FEMALE;
		}
		CharacterInfo[playerid][Skin] = CharacterDefaultSkins[CharacterInfo[playerid][Gender]][pTmpSkinIDX[playerid]];

		SetPlayerSkin(playerid, CharacterInfo[playerid][Skin]);

		printf("(OnPlayerSelect3DMenuBox) - Selection type : GENDER");
		printf("(OnPlayerSelect3DMenuBox) - Selected Gender : %d", CharacterInfo[playerid][Gender]);

		Destroy3DMenuDelayed(MenuID);
		CreateCharacterSetupMenu(playerid);
		return Y_HOOKS_BREAK_RETURN_1;
	}
	//==============================================================================
	if(pSelectionType[playerid] == PLAYER_SELECTION_STATE)
	{
		CharacterInfo[playerid][State] = selected;

		Destroy3DMenuDelayed(MenuID);
		CreateCharacterSetupMenu(playerid);
		return Y_HOOKS_BREAK_RETURN_1;
	}
	//==============================================================================
	if(pSelectionType[playerid] == PLAYER_SELECTION_CHARACTER_SETUP)
	{
		switch(selected)
		{
			//Gender selection
			case 0:
			{			
				// SendClientMessage(playerid, -1, "Selected Gender");
				pSelectionType[playerid] = PLAYER_SELECTION_GENDER;

				Destroy3DMenuDelayed(MenuID);
				p3DMenu[playerid] = Create3DMenu(-1635.7273,1043.8788,54.1497,177.9148, 2, playerid);
				SetBoxText(p3DMenu[playerid], 0, "Male", OBJECT_MATERIAL_SIZE_128x32, "Arial", 22, 1, boxtextcolor, boxtextbg, 0);
				SetBoxText(p3DMenu[playerid], 1, "Female", OBJECT_MATERIAL_SIZE_128x32, "Arial", 22, 1, boxtextcolor, boxtextbg, 0);
				Select3DMenu(playerid, p3DMenu[playerid]);

				InterpolateCameraPos(playerid, CAM_START_POS, CAM_START_POS2, 3500);
				InterpolateCameraLookAt(playerid, CAM_START_LOOKAT, CAM_START_LOOKAT2, 3500);
			}
			//Skin selection
			case 1:
			{
				// SendClientMessage(playerid, -1, "Selected Skin");
				pSelectionType[playerid] = PLAYER_SELECTION_SKIN;

				Destroy3DMenuDelayed(MenuID);
				CreatePlayerSlider(playerid, -1635.7273,1043.8788,54.1497,177.9148, "Skin", OBJECT_MATERIAL_SIZE_128x32);
				
				SetPlayerPos(playerid, CHAR_WALK_STYLE_POS);
				SetPlayerFacingAngle(playerid, CHAR_WALK_STYLE_ROT);

				ClearAnimations(playerid);

				InterpolateCameraPos(playerid, CAM_START_POS, CAM_START_POS2, 3500);
				InterpolateCameraLookAt(playerid, CAM_START_LOOKAT, CAM_START_LOOKAT2, 3500);
			}
			//Walking Style selection
			case 2:
			{
				// SendClientMessage(playerid, -1, "Selected Walking Style");
				pSelectionType[playerid] = PLAYER_SELECTION_WALKING_STYLE;

				Destroy3DMenuDelayed(MenuID);
				CreatePlayerSlider(playerid, -1635.7273,1043.8788,54.1497,177.9148, "Walk Style", OBJECT_MATERIAL_SIZE_128x32);

				SetPlayerPos(playerid, CHAR_WALK_STYLE_POS);
				SetPlayerFacingAngle(playerid, CHAR_WALK_STYLE_ROT);

				ApplyAnimation(playerid,"PED",NameAnimations[CharacterInfo[playerid][WalkStyle]],4.1,true,true,true,true,1);

				InterpolateCameraPos(playerid, CAM_START_POS, CAM_START_POS2, 3500);
				InterpolateCameraLookAt(playerid, CAM_START_LOOKAT, CAM_START_LOOKAT2, 3500);
			}
			//State selection
			case 3:
			{
				// SendClientMessage(playerid, -1, "Selected State");
				pSelectionType[playerid] = PLAYER_SELECTION_STATE;

				Destroy3DMenuDelayed(MenuID);
				p3DMenu[playerid] = Create3DMenu(-1635.7273,1043.8788,54.1497,177.9148, 3, playerid);
				SetBoxText(p3DMenu[playerid], 0, "Maryland", OBJECT_MATERIAL_SIZE_128x32, "Arial", 22, 1, boxtextcolor, boxtextbg, 0);
				SetBoxText(p3DMenu[playerid], 1, "Egypt", OBJECT_MATERIAL_SIZE_128x32, "Arial", 22, 1, boxtextcolor, boxtextbg, 0);
				SetBoxText(p3DMenu[playerid], 2, "Little Italy", OBJECT_MATERIAL_SIZE_128x32, "Arial", 22, 1, boxtextcolor, boxtextbg, 0);
				Select3DMenu(playerid, p3DMenu[playerid]);

				InterpolateCameraPos(playerid, CAM_START_POS, CAM_START_POS2, 3500);
				InterpolateCameraLookAt(playerid, CAM_START_LOOKAT, CAM_START_LOOKAT2, 3500);		
			}
			//Attachment selection
			case 4:
			{
				SendClientMessage(playerid, -1, "Selected Attachment @TODO");
			}
			//Create selection
			case 5:
			{
				// SendClientMessage(playerid, -1, "Selected Create");
				pSelectionType[playerid] = INVALID_PLAYER_SELECTION;
				StopPlayerKeysUpdate(playerid);

				Destroy3DMenu(p3DMenu[playerid]);

				new rand = random(sizeof(RandomSpawnCords));
				SetSpawnInfo(playerid, NO_TEAM, CharacterInfo[playerid][Skin], RandomSpawnCords[rand][0], RandomSpawnCords[rand][1], RandomSpawnCords[rand][2], RandomSpawnCords[rand][3]);

				new query[512];
				mysql_format(SQL, query, sizeof(query), "INSERT INTO 	`characters` SET `account_id` = %d,\
																		`cName` = '%e',\
																		`cSkin` = %d,\
																		`cGender` = %d,\
																		`cAge` = %d,\
																		`cState` = %d,\
																		`cLastLogin` = %d,\
																		cLastX = %f,\
																		cLastY = %f,\
																		cLastZ = %f", 
																		PlayerInfo[playerid][SQLID],
																		CharacterInfo[playerid][Name],
																		CharacterInfo[playerid][Skin],
																		CharacterInfo[playerid][Gender],
																		CharacterInfo[playerid][Age],
																		CharacterInfo[playerid][State],
																		gettime(),
																		RandomSpawnCords[rand][0], RandomSpawnCords[rand][1], RandomSpawnCords[rand][2]);																		
				mysql_tquery(SQL, query, "SQL_InsertPlayerCharacter", "ii", playerid, pCharacterIDX[playerid]);
			}
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

forward SQL_InsertPlayerCharacter(playerid, characteridx);
public SQL_InsertPlayerCharacter(playerid, characteridx)
{
	CharacterInfo[playerid][SQLID] = cache_insert_id();
	if(CharacterInfo[playerid][SQLID] == -1)
	{
		SendClientMessage(playerid, -1, "Desila se greska prilikom kreiranja karaktera u databazi. Reconnect i pokusajte ponovo.");		
		SendClientMessage(playerid, -1, "Ukoliko se problem ponovi, kontaktirajte admine.");
		Kick(playerid);
		return;
	}

	TogglePlayerSpectating(playerid, false);
	TogglePlayerControllable(playerid, true);
					
	SetPlayerVirtualWorld(playerid, 6);
	SetPlayerInterior(playerid, 6);
					
	pConnectState[playerid] = PLAYER_CONNECT_STATE_SPAWNED;
	Logo_ShowTextDraw(playerid, true);
	TogglePlayerTextDraw(playerid, true);
	TogglePlayerTextDraw(playerid, true);

	SpawnPlayer(playerid);
	return;
}

/*
hook OnPlayerSpawned(playerid)
{
	if(pConnectState[playerid] == PLAYER_CONNECT_STATE_SPAWNED)
		TogglePlayerTextDraw(playerid, true);
	
	return Y_HOOKS_CONTINUE_RETURN_1;
}
*/
hook OnPlayerSlectedSlider(playerid, KEY:leftright, bool:selected)
{
	if(pSelectionType[playerid] == PLAYER_SELECTION_SKIN) 
	{
		if(selected)
		{
			DestroyPlayerSlider(playerid);
			CreateCharacterSetupMenu(playerid);

			CharacterInfo[playerid][Skin] = CharacterDefaultSkins[CharacterInfo[playerid][Gender]][pTmpSkinIDX[playerid]];

			return Y_HOOKS_BREAK_RETURN_1;
		}

		if(leftright == KEY_LEFT)
		{
			pTmpSkinIDX[playerid]--;
			if(pTmpSkinIDX[playerid] < 0) pTmpSkinIDX[playerid] = (sizeof(CharacterDefaultSkins[]));
		}

		if(leftright == KEY_RIGHT)
		{
			pTmpSkinIDX[playerid]++;
			if(pTmpSkinIDX[playerid] >= sizeof(CharacterDefaultSkins[])) pTmpSkinIDX[playerid] = 0;
		}

		SetPlayerSkin(playerid, CharacterDefaultSkins[CharacterInfo[playerid][Gender]][pTmpSkinIDX[playerid]]);
		return Y_HOOKS_BREAK_RETURN_1;
	}

	if(pSelectionType[playerid] == PLAYER_SELECTION_WALKING_STYLE)
	{
		if(selected)
		{
			DestroyPlayerSlider(playerid);
			CreateCharacterSetupMenu(playerid);
			return Y_HOOKS_BREAK_RETURN_1;
		}


		if(leftright == KEY_LEFT)
		{
			CharacterInfo[playerid][WalkStyle]--;
			if(CharacterInfo[playerid][WalkStyle] < 0) 
				CharacterInfo[playerid][WalkStyle] = (sizeof(NameAnimations)-1);
		}

		if(leftright == KEY_RIGHT)
		{
			CharacterInfo[playerid][WalkStyle]++;
			if(CharacterInfo[playerid][WalkStyle] >= sizeof(NameAnimations))
				CharacterInfo[playerid][WalkStyle] = 0;
		}

		ApplyAnimation(playerid,"PED",NameAnimations[CharacterInfo[playerid][WalkStyle]],4.1,true,true,true,true,1);
		Player_SetWalkingStyle(playerid, WALKING_STYLES: CharacterInfo[playerid][WalkStyle]);
		return Y_HOOKS_BREAK_RETURN_1;
	}
	return Y_HOOKS_BREAK_RETURN_1;
}

ResetPlayerRegLogVars(playerid)
{
	pLoginAttempts[playerid] = 0;
	pRegisterMail[playerid][0] = '\0';
	pRegisterPassword[playerid][0] = '\0';
	p3DMenu[playerid] = INVALID_3D_MENU;

	pCharacterIDX[playerid] = 0;
	pSelectionType[playerid] = INVALID_PLAYER_SELECTION;
	pConnectState[playerid] = PLAYER_CONNECT_STATE_CONNECTED;

	CharacterInfo[playerid][Skin] = 22;

	CharacterInfo[playerid][SQLID] = 0;
	CharacterInfo[playerid][Name][0] = '\0';
	CharacterInfo[playerid][Gender] = GENDER_MALE;
	CharacterInfo[playerid][Skin] = 0;
	CharacterInfo[playerid][Age] = 0;
	CharacterInfo[playerid][WalkStyle] = 0;
	CharacterInfo[playerid][State] = 0;
	CharacterInfo[playerid][Money] = 0;
	CharacterInfo[playerid][Level] = 0;
	CharacterInfo[playerid][Job] = 0;
	CharacterInfo[playerid][lastPos][0] = 0.0;
	CharacterInfo[playerid][lastPos][1] = 0.0;
	CharacterInfo[playerid][lastPos][2] = 0.0;
}