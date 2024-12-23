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
new bool:normaldeath[MAX_PLAYERS];

new const Float:sz_BedLocations[][] = {

    { 1165.6396, -1293.8749, 1020.1516 },
    { 1165.4473, -1289.7844, 1020.1516 },
    { 1165.5208, -1287.0660, 1020.1516 },
    { 1165.7898, -1283.0889, 1020.1516 },
    { 1173.6965, -1289.7904, 1020.1516 }

};

timer medicCooldown[1000](playerid) 
{

    if(medic_Time[playerid] > 0) {

        medic_Time[playerid]--;
        GameTextForPlayer(playerid, "~w~PREOSTALO VRIJEME : ~r~%d ~w~SEKUNDI", 1000, 3, medic_Time[playerid]);
        ApplyAnimation(playerid, !"CRACK", !"crckidle1", 4.0, false, true, true, true, 0);
        defer medicCooldown(playerid);
        return ~1;
    }

    if(medic_Time[playerid] < 1) {

        if(!HasLifeInsurance(playerid)) {

            SendClientMessage(playerid, x_server, "maryland \187; "c_white"Platili ste "c_server"500$"c_white" ljecenje!");
            GivePlayerMoney(playerid, -500);
        }
        
        ClearAnimations(playerid);
        TogglePlayerControllable(playerid, true);
        return ~1;
    }

    return (true);
}

hook OnGameModeInit() {

    Create3DTextLabel(""c_server" \187; "c_grey"MD | Vehicles "c_server"\171; \n \187; "c_white" [ N ] "c_server" \171; ", -1, 2011.6052,-1411.2238,16.9922, 4.50, 0);
    CreateDynamic3DTextLabel(""c_server" \187; "c_grey"MD | Treatment "c_server"\171; \n \187; "c_white" [ N ] "c_server" \171; ", -1, 1152.7070,-1304.9401,1019.4139, 4.50, INVALID_VEHICLE_ID, INVALID_PLAYER_ID, 0, -1, -1);
    return (true);  
}

hook OnPlayerConnect(playerid) {

    medic_Time[playerid] = 0;
    normaldeath[playerid] = false;

    return (true);
}

hook OnPlayerDeath(playerid, killerid, reason) {

    medic_Time[playerid] = 30;
    normaldeath[playerid] = true;

    return (true);
}

hook OnPlayerSpawn(playerid)
{
    if(normaldeath[playerid])
    {   
        SetTimerEx("DelayedMedInt", 250, false, "d", playerid);
    }
    return (true);
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys) {

    if(PRESSED(KEY_NO)) {

        if(IsPlayerInRangeOfPoint(playerid, 3.50, 1152.7070,-1304.9401,1019.4139) && GetPlayerInterior(playerid) == 23) {

            new Float:HP;
            GetPlayerHealth(playerid, HP);
            if(HP >= 80.00) return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Nije vam potrebno ljecenje!");

            SetPlayerHealth(playerid, 100.00);
            GivePlayerMoney(playerid, -900);
            return (true);
        }
    }

    return (true);
}

forward DelayedMedInt(playerid);
public DelayedMedInt(playerid)
{   
    new xRand = random(5);
    SetPlayerCompensatedPos(playerid, sz_BedLocations[xRand][0], sz_BedLocations[xRand][1], sz_BedLocations[xRand][2], -1, 23, 7000);
    SetPlayerInterior(playerid, 23);   
    ApplyAnimation(playerid, !"CRACK", !"crckidle1", 4.0, false, false, false, false, 0);
    defer medicCooldown(playerid);

    return (true);
}
