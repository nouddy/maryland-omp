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
 *  @Author         Nodi
 *  @Github         (github.com/vosticdev) & (github.com/nouddy)
 *  @Date           01 Nov 2024
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           gun-game.pwn
 *  @Module         events

*/


#include <ysilib\YSI_Coding\y_hooks>

//*==============================================================================
//?--->>> Begining
//*==============================================================================

//*     -> Start : 34(SNIPER)   -> End 22(COLT45)

enum E_GUNGAME_PLAYER_DATA {

    ggWeapon,
    ggKills
}

new GunGame[MAX_PLAYERS][E_GUNGAME_PLAYER_DATA],
    Iterator:iter_GunGamePlayers<MAX_PLAYERS>,
    bool:playerGunGame[MAX_PLAYERS],
    bool:playerGunGameDeath[MAX_PLAYERS];

//*==============================================================================
//?--->>> hooks
//*==============================================================================

hook OnPlayerConnect(playerid) {

    playerGunGame[playerid] = false;

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerDeath(playerid, killerid, reason) {

    if(playerGunGame[playerid]) 
        playerGunGameDeath[playerid] = true;

    return Y_HOOKS_CONTINUE_RETURN_1;
}