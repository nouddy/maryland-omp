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
 *  @Author         Noddy_
 *  @Date           11th December 2024
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           ls_customs.pwn
 *  @Module         jobs


 *      >> [ NOTES ] << 

 * Player sided job, gdje igrac placa aktora da mu odradi posao ili, da plati aktivnog mehanicara kako bi mu on prefarbo ili da sam pokusa prefarbati
 * OnVehicleRespray(playerid, vehicleid, color1, color2) - uz pomoc ovog callback-a odraditi da igrac moze zajebat 
 *  1107.7605,-1185.3486,18.3704 - Painjob komanda



*/

#include <ysilib\YSI_Coding\y_hooks>

hook OnGameModeInit() {

    return Y_HOOKS_CONTINUE_RETURN_1;
}

YCMD:paintjob(playerid, params[], help) {

    if(playerJob[playerid] == INVALID_JOB_ID && IsPlayerInAnyVehicle(playerid)) {

        //* -> Ovdje ide da igrac trazi od mehanicara ili da sam farba znaci ono dialog i to.
    }

    return (true);
}