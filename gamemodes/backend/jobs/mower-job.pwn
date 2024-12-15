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

forward Mower_LoadData();
public Mower_LoadData() {

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
        format(storage_label, sizeof storage_label, "[ Mower ] \n' Stanje : %d/{737BE1}15.000'", storageValue);
        CreateMarker(1215.3478,-2369.3628,10.7937, 50.0);
        storageLabel = Create3DTextLabel(storage_label, x_white, 1215.3478,-2369.3628,10.7937, 3.50, 0);
        print("[KOSAC TRAVE] >> Uspesno ucitano iz databaze!");
    }

    return (true);
}

forward Mowing_CheckNearestGrass(playerid);
public Mowing_CheckNearestGrass(playerid) {

    new Float:oPos[3];

    GetPlayerObjectPos(playerid, player_MowingObject[playerid], oPos[0], oPos[1], oPos[2]);

    if(IsPlayerInRangeOfPoint(playerid, 2.50, oPos[0], oPos[1], oPos[2])) {

        player_MowingProgress[playerid]++;
        DestroyPlayerObject(playerid, player_MowingObject[playerid]);

        new grassID = random(15);

        player_MowingObject[playerid] = CreatePlayerObject(playerid, 811, MowerInfo[grassID][grass_Pos][0], MowerInfo[grassID][grass_Pos][1], MowerInfo[grassID][grass_Pos][2], 0.00, 0.00, 0.00, 250.0);

        player_MowingTimer[playerid] = SetTimerEx("Mowing_CheckNearestGrass", 500, true, "d", playerid);

        if(player_MowingProgress[playerid] == 15) {

            Dialog_Show(playerid, "dialog_mowerContniue", DIALOG_STYLE_MSGBOX, ">> Kosac Trave", "Da li zelite nastaviti sa daljnjom kosnjom trave?", ">> Da", "Ne <<");

        }
    }

    return (true);
}
//*         >> [ HOOKS ] <<

hook OnGameModeInit() {
    
    //* KOSAC TRAVE MAPA

    static kosactrave;
	kosactrave = CreateDynamicObjectEx(18981, 1245.198974, -2358.841552, 9.293660, 0.000000, 90.000000, 3.299999, 150.000,150.000);
	SetDynamicObjectMaterial(kosactrave, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
	kosactrave = CreateDynamicObjectEx(18981, 1223.891723, -2361.920410, 9.293660, 0.000000, 90.000000, 15.779999, 150.000,150.000);
	SetDynamicObjectMaterial(kosactrave, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
	kosactrave = CreateDynamicObjectEx(18981, 1212.926269, -2373.775146, 9.293660, 0.000000, 90.000000, 68.820007, 150.000,150.000);
	SetDynamicObjectMaterial(kosactrave, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
	kosactrave = CreateDynamicObjectEx(18981, 1212.466186, -2391.659912, 9.293660, 0.000000, 90.000000, 89.940002, 150.000,150.000);
	SetDynamicObjectMaterial(kosactrave, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
	kosactrave = CreateDynamicObjectEx(18981, 1227.333862, -2401.554931, 9.293660, 0.000000, 90.000000, 65.879997, 150.000,150.000);
	SetDynamicObjectMaterial(kosactrave, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
	kosactrave = CreateDynamicObjectEx(18981, 1244.700927, -2403.562744, 9.293660, 0.000000, 90.000000, 11.279999, 150.000,150.000);
	SetDynamicObjectMaterial(kosactrave, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
	kosactrave = CreateDynamicObjectEx(18981, 1260.315673, -2395.574707, 9.293660, 0.000000, 90.000000, 37.380001, 150.000,150.000);
	SetDynamicObjectMaterial(kosactrave, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
	kosactrave = CreateDynamicObjectEx(18981, 1271.482666, -2384.397949, 9.293660, 0.000000, 90.000000, 4.560009, 150.000,150.000);
	SetDynamicObjectMaterial(kosactrave, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
	kosactrave = CreateDynamicObjectEx(18981, 1250.110717, -2377.619873, 9.293660, 0.000000, 90.000000, 4.560009, 150.000,150.000);
	SetDynamicObjectMaterial(kosactrave, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
	kosactrave = CreateDynamicObjectEx(18981, 1234.474731, -2381.530273, 9.293660, 0.000000, 90.000000, 4.560009, 150.000,150.000);
	SetDynamicObjectMaterial(kosactrave, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
	kosactrave = CreateDynamicObjectEx(18981, 1263.434326, -2365.225585, 9.293660, 0.000000, 90.000000, 31.320009, 150.000,150.000);
	SetDynamicObjectMaterial(kosactrave, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
	kosactrave = CreateDynamicObjectEx(12921, 1245.949707, -2415.163574, 13.319508, 0.000000, 0.000000, 7.980000, 150.000,150.000);
	SetDynamicObjectMaterial(kosactrave, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	kosactrave = CreateDynamicObjectEx(18766, 1225.324951, -2404.346191, 9.359302, 90.000000, 180.000000, -56.800003, 150.000,150.000);
	SetDynamicObjectMaterial(kosactrave, 0, 19597, "lsbeachside", "carpet19-128x128", 0x00000000);
	kosactrave = CreateDynamicObjectEx(18766, 1220.243530, -2396.581542, 9.359302, 90.000000, 180.000000, -56.800003, 150.000,150.000);
	SetDynamicObjectMaterial(kosactrave, 0, 19597, "lsbeachside", "carpet19-128x128", 0x00000000);
	kosactrave = CreateDynamicObjectEx(18766, 1214.970214, -2388.523681, 9.359302, 90.000000, 180.000000, -56.800003, 150.000,150.000);
	SetDynamicObjectMaterial(kosactrave, 0, 19597, "lsbeachside", "carpet19-128x128", 0x00000000);
	kosactrave = CreateDynamicObjectEx(18766, 1222.979858, -2405.815429, 9.359302, 90.000000, 180.000000, -44.300014, 150.000,150.000);
	SetDynamicObjectMaterial(kosactrave, 0, 19597, "lsbeachside", "carpet19-128x128", 0x00000000);
	kosactrave = CreateDynamicObjectEx(18766, 1216.416992, -2399.410888, 9.359302, 90.000000, 180.000000, -44.300014, 150.000,150.000);
	SetDynamicObjectMaterial(kosactrave, 0, 19597, "lsbeachside", "carpet19-128x128", 0x00000000);
	kosactrave = CreateDynamicObjectEx(18766, 1214.477539, -2397.518554, 9.359302, 90.000000, 180.000000, -44.300014, 150.000,150.000);
	SetDynamicObjectMaterial(kosactrave, 0, 19597, "lsbeachside", "carpet19-128x128", 0x00000000);
	kosactrave = CreateDynamicObjectEx(18766, 1213.589965, -2393.952636, 9.359302, 90.000000, 180.000000, -56.800010, 150.000,150.000);
	SetDynamicObjectMaterial(kosactrave, 0, 19597, "lsbeachside", "carpet19-128x128", 0x00000000);
	kosactrave = CreateDynamicObjectEx(18766, 1211.149536, -2390.366210, 9.359302, 90.000000, 180.000000, -89.199996, 150.000,150.000);
	SetDynamicObjectMaterial(kosactrave, 0, 19597, "lsbeachside", "carpet19-128x128", 0x00000000);
	kosactrave = CreateDynamicObjectEx(18766, 1211.134521, -2389.295166, 9.359302, 90.000000, 180.000000, -89.199996, 150.000,150.000);
	SetDynamicObjectMaterial(kosactrave, 0, 19597, "lsbeachside", "carpet19-128x128", 0x00000000);
	//==========================================================================/////////////////////////////////////
	//==========================================================================/////////////////////////////////////
	//==========================================================================/////////////////////////////////////
	kosactrave = CreateDynamicObjectEx(17060, 1264.355346, -2361.296386, 9.553919, 0.000000, 0.000000, -58.079990, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(17060, 1260.660034, -2361.750000, 9.553919, 0.000000, 0.000000, -58.079990, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(17060, 1255.534790, -2362.828613, 9.553919, 0.000000, 0.000000, -58.079990, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(17060, 1271.013061, -2377.042724, 9.553919, 0.000000, 0.000000, -69.899986, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(17060, 1267.263427, -2377.429199, 9.553919, 0.000000, 0.000000, -69.899986, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(17060, 1263.000488, -2377.503417, 9.553919, 0.000000, 0.000000, -69.899986, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(17060, 1270.294799, -2392.204345, 9.553919, 0.000000, 0.000000, -110.999977, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(17060, 1264.015502, -2390.379638, 9.553919, 0.000000, 0.000000, -110.999977, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(776, 1285.181762, -2391.624023, 11.540769, 0.000000, 0.000000, 0.000000, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(776, 1278.727294, -2403.201171, 11.540769, 0.000000, 0.000000, 0.000000, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(776, 1271.475463, -2410.410400, 11.540769, 0.000000, 0.000000, 0.000000, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(776, 1261.454711, -2414.471191, 11.540769, 0.000000, 0.000000, 0.000000, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(776, 1230.700317, -2417.828125, 9.260768, 0.000000, 0.000000, 0.000000, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(776, 1220.871337, -2412.610595, 9.050767, 0.000000, 0.000000, 0.000000, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(776, 1210.911621, -2406.451416, 9.530769, 0.000000, 0.000000, 0.000000, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(776, 1202.241943, -2398.871826, 9.970767, 0.000000, 0.000000, 0.000000, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(776, 1196.238037, -2389.537841, 10.320767, 0.000000, 0.000000, 0.000000, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(776, 1195.139404, -2379.130615, 10.690769, 0.000000, 0.000000, 0.000000, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(776, 1196.676147, -2368.508056, 11.540769, 0.000000, 0.000000, 0.000000, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(776, 1203.987915, -2355.249023, 11.030670, 0.000000, 0.000000, 0.000000, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(776, 1216.516113, -2348.925048, 11.030670, 0.000000, 0.000000, 0.000000, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(776, 1227.677856, -2345.599853, 11.030670, 0.000000, 0.000000, 0.000000, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(776, 1239.232177, -2345.223388, 11.030670, 0.000000, 0.000000, 0.000000, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(3359, 1213.687011, -2370.186035, 9.367589, 0.000000, 0.000000, 63.179988, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(3374, 1210.417846, -2372.068115, 11.004400, 0.000000, 0.000000, -20.100009, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(3374, 1214.257934, -2374.011718, 11.004400, 0.000000, 0.000000, -25.380010, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(10829, 1225.269653, -2358.262207, 9.618129, 0.000000, 0.000000, 17.940000, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(1457, 1233.963867, -2359.297851, 11.274709, 0.000000, 0.000000, 4.980000, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(2007, 1234.578979, -2358.053955, 9.790889, 0.000000, 0.000000, 0.479999, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(2007, 1233.480468, -2358.118164, 9.790889, 0.000000, 0.000000, 8.159999, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(2007, 1233.110229, -2359.030761, 9.790889, 0.000000, 0.000000, 96.839996, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(2007, 1234.779785, -2359.005126, 9.790889, 0.000000, 0.000000, -74.939987, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(2007, 1233.270263, -2360.159423, 9.790889, 0.000000, 0.000000, 96.839996, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(2007, 1234.939697, -2360.295410, 9.790889, 0.000000, 0.000000, -81.060043, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(19865, 1237.223999, -2349.329589, 9.570269, 0.000000, 0.000000, 3.240000, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(19865, 1237.505004, -2354.011230, 9.570269, 0.000000, 0.000000, 3.240000, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(19865, 1237.773803, -2358.631591, 9.570269, 0.000000, 0.000000, 3.240000, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(19865, 1237.932006, -2361.864990, 9.570269, 0.000000, 0.000000, 3.240000, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(19865, 1235.668334, -2364.563720, 9.570269, 0.000000, 0.000000, -83.220001, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(19865, 1227.133666, -2367.063964, 9.570269, 0.000000, 0.000000, -68.280006, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(19865, 1223.667236, -2365.835693, 9.570269, 0.000000, 0.000000, -151.379959, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(19865, 1221.394531, -2361.593750, 9.570269, 0.000000, 0.000000, -151.379959, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(19865, 1219.146240, -2357.467041, 9.570269, 0.000000, 0.000000, -151.379959, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(19865, 1217.479858, -2354.425537, 9.570269, 0.000000, 0.000000, -151.379959, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(19865, 1216.750732, -2353.035888, 9.570269, 0.000000, 0.000000, -151.379959, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(1408, 1210.708862, -2384.733154, 9.980779, 0.000000, 0.000000, -162.000045, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(1408, 1208.490722, -2388.042724, 9.980779, 0.000000, 0.000000, -84.900047, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(1408, 1209.465576, -2393.154296, 9.980779, 0.000000, 0.000000, -72.900047, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(1408, 1212.018432, -2397.602539, 9.980779, 0.000000, 0.000000, -45.600059, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(1408, 1215.702636, -2401.374755, 9.980779, 0.000000, 0.000000, -45.600059, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(1408, 1219.343017, -2405.150390, 9.980779, 0.000000, 0.000000, -45.600059, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(1408, 1223.352294, -2408.465332, 9.980779, 0.000000, 0.000000, -34.380058, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(1408, 1227.655639, -2408.563720, 9.980779, 0.000000, 0.000000, 32.759941, 150.000,150.000);
	kosactrave = CreateDynamicObjectEx(5836, 1237.697021, -2389.369628, 13.222743, 0.000000, 0.000000, -52.800003, 150.000,150.000);

    mysql_tquery(MySQL:SQL, "SELECT * FROM `mowerdata`", "Mower_LoadData");

    CreateCustomMarker("[ Mower Vehicle]\n{737be1}[ N ]", 1220.2867,-2397.0332,10.8593, -1, -1, 50.0);
    CreateCustomMarker("[ Mower Deponija ]\n{737be1}[ N ]", 1041.0739,-1935.3699,12.7120, -1, -1, 50.0);

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

YCMD:mower(playerid, params[], help) {

    if(playerJob[playerid] != JOB_MOWER) return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Niste zaposleni kao kosac trave.");
    if(player_IsMowing[playerid]) return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Zavrsite zapoceti posao.");
    
    Dialog_Show(playerid, "dialog_moweroption", DIALOG_STYLE_MSGBOX, ""c_server"Maryland \187; "c_white"Mower", "Odaberite posao kojeg zelite raditi", "Transport", "Kosnja");
    return 1;
}



Dialog:dialog_moweroption(const playerid, response, listitem, string: inputtext[]) {

    if(response) {

        if(storageValue < 300) return SendClientMessage(playerid, 0xFF0055FF, "Mower \187; "c_white"Nema dovoljno pokosene trave u skladistu!");

        else {

            player_IsMowing[playerid] = true;
            player_MowingJob[playerid] = JOB_TYPE_TRANSPORT;

            SendClientMessage(playerid, 0xFF0055FF, "Mower \187; "c_white"Izaberite auto za prevoz transporta, nalazi se pored ograde kod skladista.");
            return (true);
        }
    }

    if(!response) {

        player_IsMowing[playerid] = true;
        player_MowingJob[playerid] = JOB_TYPE_MOWING;
        SendClientMessage(playerid, 0xFF0055FF, "Mower \187; "c_white"Izaberite auto za kosnju trave, nalazi se pored ograde kod skladista.");
        return (true);

    }
    return 1;
}

Dialog:dialog_mowerContniue(playerid, response, listitem, inputtext[]) {


    if(response) {
        
        new xMowerPay = RandomMinMax(200, 500);

        player_MowingProgress[playerid] = 0;

        SendClientMessage(playerid, 0xFF0055FF, "Mower \187; "c_white"Uspjesno ste pokosili sve travke.");
        SendClientMessage(playerid, 0xFF0055FF, "Mower \187; "c_white"Plata u iznosu $%d vam je legla na racun.", xMowerPay );

        GivePlayerMoney(playerid, xMowerPay);

        new randomGrass = randomEx(100, 300);

        storageValue+= randomGrass;

        new q[120];
        mysql_format(SQL, q, sizeof q, "UPDATE `mowerdata` SET `storageCapacity` = '%d'", storageValue);
        mysql_tquery(SQL, q);

        DestroyPlayerObject(playerid, player_MowingObject[playerid]);
        KillTimer(player_MowingTimer[playerid]);

        new grassID = random(15);

        player_MowingObject[playerid] = CreatePlayerObject(playerid, 811, MowerInfo[grassID][grass_Pos][0], MowerInfo[grassID][grass_Pos][1], MowerInfo[grassID][grass_Pos][2], 0.00, 0.00, 0.00, 250.0);

        player_MowingTimer[playerid] = SetTimerEx("Mowing_CheckNearestGrass", 500, true, "d", playerid);

        new storage_label[128];
        format(storage_label, sizeof storage_label, "[ Mower ] \n' Stanje : %d/{737BE1}15.000'", storageValue);
        Update3DTextLabelText(storageLabel, -1, storage_label);
    }
    
    else if(!response) {
        
        new xMowerPay = RandomMinMax(200, 500);

        player_MowingProgress[playerid] = 0;
        RemovePlayerFromVehicle(playerid);
        DestroyVehicle(mowerVehicle[playerid]);

        SendClientMessage(playerid, 0xFF0055FF, "Mower \187; "c_white"Uspjesno ste pokosili sve travke.");
        SendClientMessage(playerid, 0xFF0055FF, "Mower \187; "c_white"Plata u iznosu $%d vam je legla na racun.", xMowerPay );

        GivePlayerMoney(playerid, xMowerPay);

        new randomGrass = randomEx(100, 300);

        storageValue+= randomGrass;

        new q[120];
        mysql_format(SQL, q, sizeof q, "UPDATE `mowerdata` SET `storageCapacity` = '%d'", storageValue);
        mysql_tquery(SQL, q);

        DestroyPlayerObject(playerid, player_MowingObject[playerid]);
        KillTimer(player_MowingTimer[playerid]);
        player_IsMowing[playerid] = false;

        new storage_label[128];
        format(storage_label, sizeof storage_label, "[ Mower ] \n' Stanje : %d/{737BE1}15.000'", storageValue);
        Update3DTextLabelText(storageLabel, -1, storage_label);

    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}


hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys) {

    if(PRESSED(KEY_NO)) {

        if(IsPlayerInRangeOfPoint(playerid, 1.70, 1220.2867,-2397.0332,10.8593)) {

            if(!mower.IsPlayerJobActive(playerid)) return SendClientMessage(playerid, 0xFF0055FF, "Mower \187; "c_white"Niste u mogucnosti koristiti ovu komandu!");

            if(IsValidVehicle(mowerVehicle[playerid])) return DestroyVehicle(mowerVehicle[playerid]);

            if(player_MowingJob[playerid] == JOB_TYPE_MOWING) {

                new Float:pPos[3];
                GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);

                mowerVehicle[playerid] = CreateVehicle(572, pPos[0], pPos[1], pPos[2], 0.120, 3, 1, 1500);
                PutPlayerInVehicle(playerid, mowerVehicle[playerid], 0);

                new grassID = random(15);

                player_MowingObject[playerid] = CreatePlayerObject(playerid, 811, MowerInfo[grassID][grass_Pos][0], MowerInfo[grassID][grass_Pos][1], MowerInfo[grassID][grass_Pos][2], 0.00, 0.00, 0.00, 250.0);

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
        }

        if(player_MowingJob[playerid] == JOB_TYPE_TRANSPORT) {

            if(player_MowingProgress[playerid] == 101) {
        
                new xMowerPay = RandomMinMax(200, 500);

                storageValue-=300;
                SendClientMessage(playerid, 0xFF0055FF, "Mower \187; "c_white"Uspesno ste istovarili travu na deponiju!");
                SendClientMessage(playerid, 0xFF0055FF, "Mower \187; "c_white"Plata u iznosu $%d vam je legla na racun.", xMowerPay );

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