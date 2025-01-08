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
 *  @Author         Vostic
 *  @Date           22th Dec 2024
 *  @Weburl         weburl
 *  @Project        maryland_project
 *
 *  @File           hunger.pwn
 *  @Module         modules
 */

#include <ysilib\YSI_Coding\y_hooks>

#define MAX_HUNGER         100.0
#define MAX_THIRST         100.0
#define HUNGER_RATE        0.5
#define THIRST_RATE        0.8

enum E_PLAYER_HUNGER {
    Float:playerHunger,
    Float:playerThirst
}
new ht_PlayerHunger[MAX_PLAYERS][E_PLAYER_HUNGER];

new PlayerText:ht_Interface[MAX_PLAYERS][8];

hook OnGameModeInit()
{
	print("misc/hunger.pwn loaded");
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerConnect(playerid)
{
	ht_PlayerHunger[playerid][playerHunger] = MAX_HUNGER;
	ht_PlayerHunger[playerid][playerThirst] = MAX_THIRST;

	ResetSurvivalInterface(playerid);

	return Y_HOOKS_CONTINUE_RETURN_1;
}

ptask OnPlayerHungerUpdate[60000](playerid)
{
	RemovePlayerHunger(playerid, HUNGER_RATE);
	RemovePlayerThirst(playerid, THIRST_RATE);
	
	UpdatePlayerSurvivalStatus(playerid); 
}

stock RemovePlayerHunger(playerid, Float:amount)
{
	ht_PlayerHunger[playerid][playerHunger] -= amount;
	
	if(ht_PlayerHunger[playerid][playerHunger] <= 0.0)
	{
		ht_PlayerHunger[playerid][playerHunger] = 0.0;
		DamagePlayer(playerid, 3.0);
		SendClientMessage(playerid, x_red, "Umires od gladi! Pronadji nešto da pojedes!");
	}
	return (true);
}

stock RemovePlayerThirst(playerid, Float:amount)
{
	ht_PlayerHunger[playerid][playerThirst] -= amount;
	
	if(ht_PlayerHunger[playerid][playerThirst] <= 0.0)
	{
		ht_PlayerHunger[playerid][playerThirst] = 0.0;
		DamagePlayer(playerid, 5.0);
		SendClientMessage(playerid, x_red, "Dehidriraces! Pronadji nesto da pijes!");
	}
	return (true);
}

stock AddPlayerHunger(playerid, Float:amount)
{
	ht_PlayerHunger[playerid][playerHunger] += amount;
	
	if(ht_PlayerHunger[playerid][playerHunger] > MAX_HUNGER)
		ht_PlayerHunger[playerid][playerHunger] = MAX_HUNGER;
		
	UpdatePlayerSurvivalStatus(playerid); 
	return (true);
}

stock Float:GetPlayerHunger(playerid)
{
	return ht_PlayerHunger[playerid][playerHunger];
}

stock Float:GetPlayerThirst(playerid)
{
	return ht_PlayerHunger[playerid][playerThirst];
}

stock ResetSurvivalInterface(playerid) {

	for(new i = 0; i < sizeof ht_Interface[]; i++) {

		PlayerTextDrawDestroy(playerid, ht_Interface[playerid][i]);
		ht_Interface[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}

	return (true);
}

stock CreateSurvivalInterface(playerid) {

	ResetSurvivalInterface(playerid);

	ht_Interface[playerid][0] = CreatePlayerTextDraw(playerid, 543.999938, 400.570343, "");
	PlayerTextDrawTextSize(playerid, ht_Interface[playerid][0], 47.000000, 55.000000);
	PlayerTextDrawAlignment(playerid, ht_Interface[playerid][0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColor(playerid, ht_Interface[playerid][0], 200);
	PlayerTextDrawSetShadow(playerid, ht_Interface[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, ht_Interface[playerid][0], 0xFFFFFF00);
	PlayerTextDrawFont(playerid, ht_Interface[playerid][0], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetProportional(playerid, ht_Interface[playerid][0], false);
	PlayerTextDrawSetPreviewModel(playerid, ht_Interface[playerid][0], 2729);
	PlayerTextDrawSetPreviewRot(playerid, ht_Interface[playerid][0], 0.000000, 0.000000, 23.000000, 1.000000);

	ht_Interface[playerid][1] = CreatePlayerTextDraw(playerid, 594.666809, 400.570343, "");
	PlayerTextDrawTextSize(playerid, ht_Interface[playerid][1], 47.000000, 55.000000);
	PlayerTextDrawAlignment(playerid, ht_Interface[playerid][1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColor(playerid, ht_Interface[playerid][1], 200);
	PlayerTextDrawSetShadow(playerid, ht_Interface[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, ht_Interface[playerid][1], 0xFFFFFF00);
	PlayerTextDrawFont(playerid, ht_Interface[playerid][1], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetProportional(playerid, ht_Interface[playerid][1], false);
	PlayerTextDrawSetPreviewModel(playerid, ht_Interface[playerid][1], 2729);
	PlayerTextDrawSetPreviewRot(playerid, ht_Interface[playerid][1], 0.000000, 0.000000, -23.000000, 1.000000);

	ht_Interface[playerid][2] = CreatePlayerTextDraw(playerid, 562.333251, 417.992645, "hud:radar_burgerShot");
	PlayerTextDrawTextSize(playerid, ht_Interface[playerid][2], 8.000000, 9.000000);
	PlayerTextDrawAlignment(playerid, ht_Interface[playerid][2], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColor(playerid, ht_Interface[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, ht_Interface[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, ht_Interface[playerid][2], 255);
	PlayerTextDrawFont(playerid, ht_Interface[playerid][2], TEXT_DRAW_FONT_SPRITE_DRAW);
	PlayerTextDrawSetProportional(playerid, ht_Interface[playerid][2], false);

	ht_Interface[playerid][3] = CreatePlayerTextDraw(playerid, 615.666748, 418.407440, "hud:radar_dateDrink");
	PlayerTextDrawTextSize(playerid, ht_Interface[playerid][3], 7.000000, 9.000000);
	PlayerTextDrawAlignment(playerid, ht_Interface[playerid][3], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColor(playerid, ht_Interface[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, ht_Interface[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, ht_Interface[playerid][3], 255);
	PlayerTextDrawFont(playerid, ht_Interface[playerid][3], TEXT_DRAW_FONT_SPRITE_DRAW);
	PlayerTextDrawSetProportional(playerid, ht_Interface[playerid][3], false);

	ht_Interface[playerid][4] = CreatePlayerTextDraw(playerid, 567.000000, 429.763000, "100%");
	PlayerTextDrawLetterSize(playerid, ht_Interface[playerid][4], 0.178999, 0.687407);
	PlayerTextDrawAlignment(playerid, ht_Interface[playerid][4], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColor(playerid, ht_Interface[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, ht_Interface[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, ht_Interface[playerid][4], 255);
	PlayerTextDrawFont(playerid, ht_Interface[playerid][4], TEXT_DRAW_FONT_3);
	PlayerTextDrawSetProportional(playerid, ht_Interface[playerid][4], true);

	ht_Interface[playerid][5] = CreatePlayerTextDraw(playerid, 620.666687, 429.763000, "100%");
	PlayerTextDrawLetterSize(playerid, ht_Interface[playerid][5], 0.178999, 0.687407);
	PlayerTextDrawAlignment(playerid, ht_Interface[playerid][5], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColor(playerid, ht_Interface[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, ht_Interface[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, ht_Interface[playerid][5], 255);
	PlayerTextDrawFont(playerid, ht_Interface[playerid][5], TEXT_DRAW_FONT_3);
	PlayerTextDrawSetProportional(playerid, ht_Interface[playerid][5], true);

	ht_Interface[playerid][6] = CreatePlayerTextDraw(playerid, 580.333312, 403.059387, "");
	PlayerTextDrawTextSize(playerid, ht_Interface[playerid][6], 23.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, ht_Interface[playerid][6], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColor(playerid, ht_Interface[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, ht_Interface[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, ht_Interface[playerid][6], 0xFFFFFF00);
	PlayerTextDrawFont(playerid, ht_Interface[playerid][6], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetProportional(playerid, ht_Interface[playerid][6], false);
	PlayerTextDrawSetPreviewModel(playerid, ht_Interface[playerid][6], 19177);
	PlayerTextDrawSetPreviewRot(playerid, ht_Interface[playerid][6], 0.000000, 0.000000, 0.000000, 1.000000);

	ht_Interface[playerid][7] = CreatePlayerTextDraw(playerid, 580.466613, 407.507415, "");
	PlayerTextDrawTextSize(playerid, ht_Interface[playerid][7], 23.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, ht_Interface[playerid][7], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColor(playerid, ht_Interface[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, ht_Interface[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, ht_Interface[playerid][7], 0xFFFFFF00);
	PlayerTextDrawFont(playerid, ht_Interface[playerid][7], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetProportional(playerid, ht_Interface[playerid][7], false);
	PlayerTextDrawSetPreviewModel(playerid, ht_Interface[playerid][7], 19177);
	PlayerTextDrawSetPreviewRot(playerid, ht_Interface[playerid][7], 0.000000, 180.000000, 0.000000, 1.000000);

	for(new i = 0; i < sizeof ht_Interface[]; i++) {

		PlayerTextDrawShow(playerid, ht_Interface[playerid][i]);
	}

	PlayerTextDrawSetString(playerid, ht_Interface[playerid][4], "%.2f", GetPlayerHunger(playerid));
	PlayerTextDrawSetString(playerid, ht_Interface[playerid][5], "%.2f", GetPlayerThirst(playerid));

	return (true);
}


stock UpdatePlayerSurvivalStatus(playerid) {

	PlayerTextDrawSetString(playerid, ht_Interface[playerid][4], "%.2f", GetPlayerHunger(playerid));
	PlayerTextDrawSetString(playerid, ht_Interface[playerid][5], "%.2f", GetPlayerThirst(playerid));

	return (true);
}

stock AddPlayerThirst(playerid, Float:amount)
{
	ht_PlayerHunger[playerid][playerThirst] += amount;
	
	if(ht_PlayerHunger[playerid][playerThirst] > MAX_THIRST)
		ht_PlayerHunger[playerid][playerThirst] = MAX_THIRST;
    
	UpdatePlayerSurvivalStatus(playerid);
	return (true);
}

stock DamagePlayer(playerid, Float:amount)
{
	new Float:health;
	GetPlayerHealth(playerid, health);
	SetPlayerHealth(playerid, health - amount);

	return (true);
}
