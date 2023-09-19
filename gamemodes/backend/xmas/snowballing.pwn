
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
 *  @Author         Ferid Olsun
 *  @Date           11th Sep 2023
 *  @Weburl         weburl
 *  @Project        maryland_project
 *
 *  @File           snowballing.script
 *  @Module         xmas
 */

#include <ysilib\YSI_Coding\y_hooks>

static bool:snowball_inHand[MAX_PLAYERS];
static snowObject;


hook OnGameModeInit() {

    print("xmas/snowballing.script loaded");

    return (true);
}

timer snowball_Make[3000](playerid) 
{   
    RemovePlayerAttachedObject(playerid, 1);
    SetPlayerAttachedObject(playerid, 0, 3003, 6, 0.068999, 0.037999, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
    snowball_inHand[playerid] = true;
    return 1;
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys) {

    if(PRESSED(KEY_CROUCH)) {

        if(snowball_inHand[playerid])
            return SendClientMessage(playerid, 0x737BE1FF, ""c_server"xmas � "c_white"Vec imas grudvu u ruci!");

        ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 2.67, false, true, true, true, 3000);
        defer snowball_Make(playerid);
    }

    if(PRESSED(KEY_FIRE)) {

        if(snowball_inHand[playerid]) {
            
            new Float:pPos[3];
            GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);

            snowball_inHand[playerid] = false;

            snowObject = CreateDynamicObject(3003, pPos[0], pPos[1], pPos[2], 0.0, 0.0, 0.0, -1,  -1, -1);

            MoveDynamicObject(snowObject, pPos[0]-4.0, pPos[1], pPos[2]+0.450, 2.0, -1000.0, -1000.0, -1000.0);
            RemovePlayerAttachedObject(playerid, 0);

            ApplyAnimation(playerid, "GRENADE", "WEAPON_throw", 0.87, false, true, true, true, 3000);

        }
    }

    return (true);
}

hook OnDynamicObjectMoved(objectid) {

    if(objectid == snowObject) {

        DestroyDynamicObject(snowObject);
    }

    return (true);
}