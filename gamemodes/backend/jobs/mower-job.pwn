/*

*       Auhtor : s1lent

*       Date :  14.12.2023 

*       Path : modules/mower-job.pwn

*       Copyright Balkan Emirates (C)

*       Contact : vostic.business@gmail.com
 
    Doraditi dialog za daljnju kosnju i updateat label.

*/

#include <ysilib\YSI_Coding\y_hooks>

//*         >> [ SYNTAX ] <<

#define mower.      Mower_

//*         >> [ VARIABLES & CONSTANTS] <<

#define STORAGE_MAX_CAPACITY        (15000)
#define MAX_MOWER_GRASS_PLANTS      (15)

#define JOB_TYPE_NONE               (0)
#define JOB_TYPE_MOWING             (1)
#define JOB_TYPE_TRANSPORT          (2)
#define JOB_TYPE_TRANSPORTING       (3)

new storageValue;

new Text3D:storageLabel,
       storagePickup;

new bool:player_IsMowing[MAX_PLAYERS],
       player_MowingJob[MAX_PLAYERS],
       player_MowingProgress[MAX_PLAYERS],
       player_MowingObject[MAX_PLAYERS],
       player_MowingMarker[MAX_PLAYERS];

new player_MowingTimer[MAX_PLAYERS];

new mowerVehicle[MAX_PLAYERS];

enum e_MOWER_DATA {

    Float:grass_Pos[3],
    Float:grass_Radius
}

new MowerInfo[MAX_MOWER_GRASS_PLANTS][e_MOWER_DATA] = {

    { { 1218.3284, -2382.9917, 10.3693 }, 3.50 },
    { { 1234.3231, -2398.2056, 10.3510 }, 3.50 },
    { { 1254.9979, -2390.6743, 10.3521 }, 3.50 },
    { { 1251.9969, -2368.9998, 10.3528 }, 3.50 },
    { { 1241.8512, -2355.9783, 10.3630 }, 3.50 },
    { { 1237.6091, -2367.3269, 10.3556 }, 3.50 },
    { { 1237.6797, -2381.1213, 10.3551 }, 3.50 },
    { { 1218.6206, -2380.7368, 10.3418 }, 3.50 },
    { { 1203.4111, -2376.1736, 10.3216 }, 3.50 },
    { { 1205.1892, -2389.8792, 10.3524 }, 3.50 },
    { { 1209.7615, -2397.4888, 10.3609 }, 3.50 },
    { { 1230.5094, -2411.1829, 10.3518 }, 3.50 },
    { { 1221.2358, -2364.6262, 10.3613 }, 3.50 },
    { { 1260.1304, -2390.0613, 10.3568 }, 3.50 },
    { { 1264.3180, -2385.8347, 10.3709 }, 2.50 }

};

//*         >> [ FUNCTIONS ] <<

stock Mower_IsPlayerJobActive(playerid) {

    if(player_IsMowing[playerid])
        return (true);

    return (false);
}


//*         >> [ CALLBACKS ] <<

private Mower_LoadData() {

    new xRows = cache_num_rows();

    if(!xRows) {

        new q[420];

        mysql_format(MySQL:SQL, q, sizeof q, "INSERT INTO `mowerdata` (`storageCapacity`) VALUES ('0')");
        mysql_tquery(SQL, q);

        print("[KOSAC TRAVE] >> Svi podaci su se uspesno kreirali");
    }

    else {

        cache_get_value_name_int(0, "storageCapacity", storageValue);

        new storage_label[128];
        format(storage_label, sizeof storage_label, "[ Mower ] \n' Stanje : {FFFFFF}%d/15.000'", storageValue);
        CreateCustomMarker(storage_label, 1215.3478,-2369.3628,10.7937, -1, -1, 50.0);
        print("[KOSAC TRAVE] >> Uspesno ucitano iz databaze!");
    }

    return (true);
}

private Mowing_CheckNearestGrass(playerid) {

    new Float:oPos[3];

    GetPlayerObjectPos(playerid, player_MowingObject[playerid], oPos[0], oPos[1], oPos[2]);

    if(IsPlayerInRangeOfPoint(playerid, 2.50, oPos[0], oPos[1], oPos[2])) {

        player_MowingProgress[playerid]++;
        DestroyPlayerObject(playerid, player_MowingObject[playerid]);

        new grassID = random(15);

        player_MowingObject[playerid] = CreatePlayerObject(playerid, 855, MowerInfo[grassID][grass_Pos][0], MowerInfo[grassID][grass_Pos][1], MowerInfo[grassID][grass_Pos][2], 0.00, 0.00, 0.00, 250.0);

        player_MowingTimer[playerid] = SetTimerEx("Mowing_CheckNearestGrass", 500, true, "d", playerid);

        if(player_MowingProgress[playerid] == 15) {

            Dialog_Show(playerid, "dialog_mowerContniue", DIALOG_STYLE_MSGBOX, ">> Kosac Trave", "Da li zelite nastaviti sa daljnjom kosnjom trave?", ">> Da", "Ne <<");

        }
    }

    return (true);
}
//*         >> [ HOOKS ] <<

hook OnGameModeInit() {
    
    mysql_tquery(MySQL:SQL, "SELECT * FROM `mowerdata`", "Mower_LoadData");

    CreateCustomMarker("[ Mower ]\n{737be1}/mowervehicle", 1220.2867,-2397.0332,10.8593, -1, -1, 50.0);
    CreateCustomMarker("[ Mower Deponija ]\n{DAA520}[ N ]", 1041.0739,-1935.3699,12.7120, -1, -1, 50.0);

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnScriptExit() {

    Delete3DTextLabel(storageLabel);
    DestroyPickup(storagePickup);

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerConnect(playerid) {

    player_MowingJob[playerid] = JOB_TYPE_NONE;

    return Y_HOOKS_CONTINUE_RETURN_1;
}

YCMD:mower(playerid, paramsp[], help) {

    if(player_IsMowing[playerid]) return SendClientMessage(playerid, -1, "Zavrsite zapoceti posao.");
    ShowPlayerDialog(playerid, DIALOG_MOWER_TAKEJOB, DIALOG_STYLE_MSGBOX, ">> Kosac Trave", "Odaberite posao kojeg zelite raditi", "Transport", "Kosnja");

    return 1;
}

CMD:mowervehicle(playerid) {

    if(!mower.IsPlayerJobActive(playerid)) return Error(playerid, "Niste u mogucnosti koristiti ovu komandu!");

    if(IsValidVehicle(mowerVehicle[playerid])) return DestroyVehicle(mowerVehicle[playerid]);

    if(player_MowingJob[playerid] == JOB_TYPE_MOWING) {

        new Float:pPos[3];
        GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);

        mowerVehicle[playerid] = CreateVehicle(572, pPos[0], pPos[1], pPos[2], 0.120, 3, 1, 1500);
        PutPlayerInVehicle(playerid, mowerVehicle[playerid], 0);

        new grassID = random(15);

        player_MowingObject[playerid] = CreatePlayerObject(playerid, 855, MowerInfo[grassID][grass_Pos][0], MowerInfo[grassID][grass_Pos][1], MowerInfo[grassID][grass_Pos][2], 0.00, 0.00, 0.00, 250.0);

        player_MowingTimer[playerid] = SetTimerEx("Mowing_CheckNearestGrass", 500, true, "d", playerid);

    }

    else {

        new Float:pPos[3];
        GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);

        mowerVehicle[playerid] = CreateVehicle(609, pPos[0], pPos[1], pPos[2], 0.120, 3, 1, 1500);
        PutPlayerInVehicle(playerid, mowerVehicle[playerid], 0);

        player_MowingProgress[playerid] = 101;
        SetPlayerCheckpoint(playerid,1041.0739,-1935.3699,12.7120, 3.50);

    }

    return (true);
}

Dialog:DIALOG_MOWER_TAKEJOB(playerid, dialogid, response, listitem, inputtext[]) {

    if(response) {

        if(storageValue < 300) return SendClientMessage(playerid, 0xDAA520FF, "MOWER JOB: {ffffff}Nema dovoljno pokosene trave u skladistu!");

        else {

            player_IsMowing[playerid] = true;
            player_MowingJob[playerid] = JOB_TYPE_TRANSPORT;

            m_SJM(playerid, "Izaberite auto za prevoz transporta, nalazi se pored ograde kod skladista.");


        }
    }
    
    if(!response) {

        player_IsMowing[playerid] = true;
        player_MowingJob[playerid] = JOB_TYPE_MOWING;

        m_SJM(playerid, "Izaberite auto za kosnju trave, nalazi se pored ograde kod skladista.");

    }
    return 1;
}

Dialog:dialog_mowerContniue(playerid, dialogid, response, listitem, inputtext[]) {


    if(response) {
        
        new xMowerPay = RandomMinMax(200, 500);

        player_MowingProgress[playerid] = 0;

        SendClientMessage(playerid, 0x737BE1FF, ">> Uspjesno ste pokosili sve travke.");
        SendClientMessage(playerid, -1, ">> Plata u iznosu $%d vam je legla na racun.", xMowerPay );

        GivePlayerMoney(playerid, xMowerPay);

        new randomGrass = randomEx(100, 300);

        storageValue+= randomGrass;

        new q[120];
        mysql_format(SQL, q, sizeof q, "UPDATE `mowerdata` SET `storageCapacity` = '%d'", storageValue);
        mysql_tquery(SQL, q);

        DestroyPlayerObject(playerid, player_MowingObject[playerid]);
        KillTimer(player_MowingTimer[playerid]);

        new grassID = random(15);

        player_MowingObject[playerid] = CreatePlayerObject(playerid, 855, MowerInfo[grassID][grass_Pos][0], MowerInfo[grassID][grass_Pos][1], MowerInfo[grassID][grass_Pos][2], 0.00, 0.00, 0.00, 250.0);

        player_MowingTimer[playerid] = SetTimerEx("Mowing_CheckNearestGrass", 500, true, "d", playerid);

        new storage_label[128];

        format(storage_label, sizeof storage_label, ">> SKLADISTE << \n{DAA520}>> Stanje : {FFFFFF}%d/15.000", storageValue);

        Update3DTextLabelText(storageLabel, -1, storage_label);

    }
    
    else if(!response) {
        
        new xMowerPay = RandomMinMax(200, 500);

        player_MowingProgress[playerid] = 0;
        RemovePlayerFromVehicle(playerid);
        DestroyVehicle(mowerVehicle[playerid]);

        SendClientMessage(playerid, 0x737BE1FF, ">> Uspjesno ste pokosili sve travke.");
        SendClientMessage(playerid, -1, ">> Plata u iznosu $%d vam je legla na racun.", xMowerPay );

        GivePlayerMoney(playerid, xMowerPay);

        new randomGrass = randomEx(100, 300);

        storageValue+= randomGrass;

        new q[120];
        mysql_format(SQL, q, sizeof q, "UPDATE `mowerdata` SET `storageCapacity` = '%d'", storageValue);
        mysql_tquery(SQL, q);

        DestroyPlayerObject(playerid, player_MowingObject[playerid]);
        KillTimer(player_MowingTimer[playerid]);


        player_IsMowing[playerid] = false;

    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}


hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys) {

    if(PRESSED(KEY_NO)) {

        if(player_MowingJob[playerid] == JOB_TYPE_TRANSPORT) {

            if(player_MowingProgress[playerid] == 101) {
        
                new xMowerPay = RandomMinMax(200, 500);

                storageValue-=300;
                SendClientMessage(playerid, 0x884400FF, ">> Uspesno ste istovarili travu na deponiju!");
                SendClientMessage(playerid, -1, ">> Plata u iznosu $%d vam je legla na racun.", xMowerPay );

                GivePlayerMoney(playerid, xMowerPay);

                player_MowingProgress[playerid] = 0;
                RemovePlayerFromVehicle(playerid);
                DestroyVehicle(mowerVehicle[playerid]);
                new q[120];
                mysql_format(SQL, q, sizeof q, "UPDATE `mowerdata` SET `storageCapacity` = '%d'", storageValue);
                mysql_tquery(SQL, q);

                player_MowingJob[playerid] = JOB_TYPE_NONE;
                player_IsMowing[playerid] = false;
            }
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerEnterCheckpoint(playerid) {

    if(player_MowingJob[playerid] == JOB_TYPE_TRANSPORT) {

        if(player_MowingProgress[playerid] == 101) {

            DisablePlayerCheckpoint(playerid);
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}