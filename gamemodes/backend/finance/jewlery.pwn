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
 *  @Author         Vostic
 *  @Date           13th Oct 2024
 *  @Weburl         weburl
 *  @Project        maryland_project
 *
 *  @File           jewlery.pwn
 *  @Module         script
 *  @Todo:          Make jewlery system.
 */

 #include <ysilib\YSI_Coding\y_hooks>

 hook OnGameModeInit() {

    print("finance/jewlery.pwn loaded");

    CreateCustomMarker(""c_server"[ Sergio's Jewlery ]\n"c_server"» "c_white"'Za ulaz pritisnite 'F'", 1722.1115,-1635.9326,20.2128,  0, 0, 50.0); //ulaz
    CreateCustomMarker(""c_server"[ Sergio's Jewlery ]\n"c_server"» "c_white"'Za izlaz pritisnite 'F'", 1369.3322,1943.2694,-16.1860,  21, 0, 50.0); //izlaz

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys) {

    if(newkeys & KEY_SECONDARY_ATTACK) {

        if(IsPlayerInRangeOfPoint(playerid, 3.50, 1722.1115,-1635.9326,20.2128) && GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0) {

            SetPlayerPos(playerid, 1369.3322,1943.2694,-16.1860);
            SetPlayerInterior(playerid, 21);
            SetCameraBehindPlayer(playerid);
        }
        else if(IsPlayerInRangeOfPoint(playerid, 3.50, 1369.3322,1943.2694,-16.1860) && GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 21) {

            SetPlayerPos(playerid, 1722.1115,-1635.9326,20.2128);
            SetPlayerInterior(playerid, 0);
            SetPlayerVirtualWorld(playerid, 0);
            SetCameraBehindPlayer(playerid);
        }
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}
