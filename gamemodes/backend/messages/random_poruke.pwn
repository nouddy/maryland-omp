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
 *  @Author         Ogy_
 *  @Date           25th May 2023
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           random_poruke.script
 *  @Module         messages
 */
#include <ysilib\YSI_Coding\y_hooks>

new RandomSPoruke[4][128] =
{
	"~w~Poseti nas discord � https://discord.gg/JbYWfNDgcj .",
	"~w~Backend � Vostic & Ogy_",
	"~w~Ako si nov � /pitaj",
	"~w~vosta i ogy su kraljevi"

};

hook OnGameModeInit()
{
    print("messages/random_poruke.script loaded");

    return 1;
}

ptask RandomPorukice[7000](playerid)
{
	CreateTextdrawAnimation(playerid, Player_TDs[playerid][6], 55, "~w~", RandomSPoruke[ random( sizeof( RandomSPoruke ) ) ] );
	
	return 1;
}