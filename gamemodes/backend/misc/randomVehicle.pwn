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
 *  @Date           27th May 2023
 *  @Weburl         weburl
 *  @Project        maryland_project
 *
 *  @File           randomVehicles.pwn
 *  @Module         modules

 */

enum eRandomVehicle {

    rvModel,
    Float:rvPosition[4],
    bool:rvSpawned
}

new RandomVehicleData[eRandomVehicle],
    v_RandomVehicle;

new bool:vehicleFound[MAX_PLAYERS];

static const Float:sz_RandomVehicleSpawn[][] = {

    { 346.4683,-338.6846,10.4244,300.5579} ,
    { 758.4517,-619.5740,14.9497,87.1160},
    { 149.7803,-1958.8735,3.4785,233.1050}, 
    { 488.3723,-1739.4794,10.8591,352.2579}, 
    { 1727.5913,-2249.2397,-3.0618,269.8584}, 
    { 1386.5701,-1986.5951,46.6939,47.9688 }
};

static const sz_RandomVehicleModels[] = {

    411, 401, 402, 415, 445, 475, 480, 491

};

task RandomVehicle_StreamIn[3600000]() 
{
    if(RandomVehicleData[rvSpawned])
        return (true);

    new idx = random(sizeof sz_RandomVehicleSpawn);
    new randModel = random(sizeof sz_RandomVehicleModels);
    new randomColor = RandomMinMax(1, 230);

    v_RandomVehicle = CreateVehicle(sz_RandomVehicleModels[randModel], sz_RandomVehicleSpawn[idx][0], sz_RandomVehicleSpawn[idx][1], sz_RandomVehicleSpawn[idx][2], sz_RandomVehicleSpawn[idx][3], randomColor, randomColor, 1500);

    RandomVehicleData[rvModel] = sz_RandomVehicleModels[randModel];
    RandomVehicleData[rvPosition][0] = sz_RandomVehicleSpawn[idx][0]; 
    RandomVehicleData[rvPosition][1] = sz_RandomVehicleSpawn[idx][1]; 
    RandomVehicleData[rvPosition][2] = sz_RandomVehicleSpawn[idx][2]; 
    RandomVehicleData[rvPosition][3] = sz_RandomVehicleSpawn[idx][3];
    RandomVehicleData[rvSpawned] = true;

    SendClientMessageToAll(x_ltorange, "RANDOM-VEHICLE: Vozilo modela %s je nasumicno spawn-ovano u okrugu Maryland-a.", ReturnVehicleModelName( RandomVehicleData[rvModel] ));
    SendClientMessageToAll(x_ltorange, "RANDOM-VEHICLE: Pronadjite ga prije ostalih, i zaradite novac!");

    return (true);
}

hook OnPlayerConnect(playerid) {

    vehicleFound[playerid] = false;

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger) {

    if(vehicleid == v_RandomVehicle) {

        if(IsVehicleOccupied(vehicleid))
            return Y_HOOKS_BREAK_RETURN_1;

        if(!vehicleFound[playerid])
        {    
            SendClientMessage(playerid, x_ltorange, "RANDOM-VEHICLE: Pronasli ste nasumicno vozilo, odvezite ga na lokaciju koja vam je oznacena na mapi!");
            DisablePlayerCheckpoint(playerid);
            SetPlayerCheckpoint(playerid, 1104.8135,-1248.3745,15.5708, 2.50);
            vehicleFound[playerid] = true;
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerEnterCheckpoint(playerid) {

    if(vehicleFound[playerid]) {

        if(IsPlayerInRangeOfPoint(playerid, 3.0, 1104.8135,-1248.3745,15.5708)) {

            if(!IsPlayerInVehicle(playerid, v_RandomVehicle))
                return SendClientMessage(playerid, x_ltorange, "RANDOM-VEHICLE: Morate biti u vozilu kako biste ga dostavili!");

            SendClientMessageToAll(x_ltorange, "RANDOM-VEHICLE: Nasumicno vozilo je dostavljeno na lokaciju od strane : %s", ReturnCharacterName(playerid));

            vehicleFound[playerid] = false;
            RemovePlayerFromVehicle(playerid);
            DestroyVehicle(v_RandomVehicle);

            RandomVehicleData[rvModel] = 0;

            RandomVehicleData[rvPosition][0] = 0.00;
            RandomVehicleData[rvPosition][1] = 0.00;
            RandomVehicleData[rvPosition][2] = 0.00;
            RandomVehicleData[rvPosition][3] = 0.00;

            RandomVehicleData[rvSpawned] = false;

            DisablePlayerCheckpoint(playerid);
            GivePlayerMoney(playerid, 723.45);

            PlayerPlaySound(playerid, 1149, 0.00, 0.00, 0.00);

            return Y_HOOKS_BREAK_RETURN_1;
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

YCMD:pinrandomvehicle(playerid, params[], help) {

    SetPlayerCompensatedPos(playerid, RandomVehicleData[rvPosition][0], RandomVehicleData[rvPosition][1], RandomVehicleData[rvPosition][2]);

    return (true);
}