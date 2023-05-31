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
 *  @Date           29th May 2023
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           coloredmoney.inc
 *  @Module         include
*/


// | ----------------------- Includes ----------------------- |
#include <ysilib\YSI_Coding\y_hooks>
// | ----------------------- Defines ----------------------- |
#if !defined MONEY_BAR_COLOR
	#define MONEY_BAR_COLOR 0x8DC9F3FF
#endif

#define MoneyControl::										MnyCTD_

// | ----------------------- Variables ----------------------- |
static PlayerText:playerMoney[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};

// | ----------------------- Functions ----------------------- |
MoneyControl::Update(playerid)
{
		if(GetPlayerMoney(playerid) >= 0) 
		{
			if(playerMoney[playerid] == PlayerText:INVALID_TEXT_DRAW)
			{
				playerMoney[playerid] = CreatePlayerTextDraw(playerid, 498.999938, 77.617019, "$00000000");
				PlayerTextDrawLetterSize(playerid, playerMoney[playerid], 0.548624, 2.083333);
				PlayerTextDrawAlignment(playerid, playerMoney[playerid], 1);
				PlayerTextDrawColor(playerid, playerMoney[playerid], MONEY_BAR_COLOR);
				PlayerTextDrawSetShadow(playerid, playerMoney[playerid], 0);
				PlayerTextDrawSetOutline(playerid, playerMoney[playerid], 2);
				PlayerTextDrawBackgroundColor(playerid, playerMoney[playerid], 255);
				PlayerTextDrawFont(playerid, playerMoney[playerid], 3);
				PlayerTextDrawSetProportional(playerid, playerMoney[playerid], 1);
				PlayerTextDrawSetShadow(playerid, playerMoney[playerid], 0);
			}
			new moneyString[16];
			format(moneyString, sizeof(moneyString), "$%08d", GetPlayerMoney(playerid));
			PlayerTextDrawSetString(playerid, playerMoney[playerid], moneyString);
			PlayerTextDrawShow(playerid, playerMoney[playerid]);
		}
		else MoneyControl::Hide(playerid);
}

MoneyControl::Hide(playerid) {
	if(playerMoney[playerid] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawDestroy(playerid, playerMoney[playerid]);
		playerMoney[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
}

//-------------------------------------------------------------//

hook OnPlayerSpawn(playerid)
{
	MoneyControl::Update(playerid);
	return (true);
}

hook OnPlayerDisconnect(playerid, reason)
{
	MoneyControl::Hide(playerid);
	return (true);
}

hook OnPlayerUpdate(playerid)
{
	MoneyControl::Update(playerid);
	return (true);
}
