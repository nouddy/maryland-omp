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
*  @Date           1st November 2024
*  @Weburl         weburl
*  @Project        maryland_project
*
*  @File           medical.pwn
*  @Module         misc
*/

#include <ysilib\YSI_Coding\y_hooks>

new medic_Time[MAX_PLAYERS];

new const Float:sz_BedLocations[][] = {

    { 1165.6396, -1293.8749, 1020.1516 },
    { 1165.4473, -1289.7844, 1020.1516 },
    { 1165.5208, -1287.0660, 1020.1516 },
    { 1165.7898, -1283.0889, 1020.1516 },
    { 1173.6965, -1289.7904, 1020.1516 }

};

timer medicCooldown[1000](playerid) 
{

    if(medic_Time[playerid] > 1) {

        medic_Time[playerid]--;
        GameTextForPlayer(playerid, "~w~PREOSTALO VRIJEME : ~r~%d ~w~SEKUNDI", 1000, 3, medic_Time[playerid]);
        defer medicCooldown(playerid);
    }

    if(medic_Time[playerid] < 1) {

        TogglePlayerControllable(playerid, true);
        ClearAnimations(playerid);
        GivePlayerMoney(playerid, -500);
    }

    return (true);
}

// timer md_Refresh[150](playerid, idx) 
// {
//     SpawnPlayer(playerid);
//     SetPlayerInterior(playerid, 23);
//     SetPlayerCompensatedPosEx(playerid, sz_BedLocations[idx][0], sz_BedLocations[idx][1], sz_BedLocations[idx][2], -1, 23, 5000);

//     PreloadAnimations(playerid);
//     ApplyAnimation(playerid, "CRACK", "crckdeth3", 4.1, true, true, true, true, 2);
//     return (true);
// }

hook OnPlayerConnect(playerid) {

    medic_Time[playerid] = 0;

    return (true);
}

hook OnPlayerDeath(playerid, killerid, reason) {

    medic_Time[playerid] = 30;

    new xRand = random(5);

    SetPlayerCompensatedPosEx(playerid, sz_BedLocations[xRand][0], sz_BedLocations[xRand][1], sz_BedLocations[xRand][2], -1, 23, 5000);
    SpawnPlayer(playerid);
    PreloadAnimations(playerid);
    ApplyAnimation(playerid, "CRACK", "crckdeth3", 4.1, true, true, true, true, 2);
    SetPlayerInterior(playerid, 23);
    defer medicCooldown(playerid);

    return (true);
}

