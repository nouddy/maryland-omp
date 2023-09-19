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
 *  @Author         Vostic & Ogy_
 *  @Date           05th May 2023
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           vehicle_ownership.script
 *  @Module         vehicle
 */

#include <ysilib\YSI_Coding\y_hooks>

#define MAX_DYNAMIC_CARS (1500)
#define MAX_IMPOUND_LOTS (20)
#define MAX_BACKPACKS (2000)
#define MAX_CAR_STORAGE (5)
#define MAX_OWNABLE_CARS (5)

enum carData {
	carID,
	carExists,
	carModel,
	carOwner,
	Float:carPos[4],
	carColor1,
	carColor2,
	carPaintjob,
	carLocked,
	carMods[14],
	carImpounded,
	carImpoundPrice,
	carFaction,
	carWeapons[5],
	carAmmo[5],
	carVehicle
};
new CarData[MAX_DYNAMIC_CARS][carData];


enum impoundData {
	impoundID,
	impoundExists,
	Float:impoundLot[3],
	Float:impoundRelease[4],
	Text3D:impoundText3D,
	impoundPickup
};
new ImpoundData[MAX_IMPOUND_LOTS][impoundData];




new ListedVehicles[MAX_PLAYERS][MAX_OWNABLE_CARS];

stock SetVehicleColor(vehicleid, color1, color2)
{
    new id = Car_GetID(vehicleid);

	if (id != -1)
	{
	    CarData[id][carColor1] = color1;
	    CarData[id][carColor2] = color2;
	    Car_Save(id);
	}
	return ChangeVehicleColor(vehicleid, color1, color2);
}
FormatNumber(number, const prefix[] = "$")
{
	static
		value[32],
		length;

	format(value, sizeof(value), "%d", (number < 0) ? (-number) : (number));

	if ((length = strlen(value)) > 3)
	{
		for (new i = length, l = 0; --i >= 0; l ++) {
		    if ((l > 0) && (l % 3 == 0)) strins(value, ",", i + 1);
		}
	}
	if (prefix[0] != 0)
	    strins(value, prefix, 0);

	if (number < 0)
		strins(value, "-", 0);

	return value;
}
stock GetImpoundByID(sqlid)
{
	for (new i = 0; i < MAX_IMPOUND_LOTS; i ++) if (ImpoundData[i][impoundExists] && ImpoundData[i][impoundID] == sqlid) {
	    return i;
	}
	return -1;
}
hook OnGameModeInit()
{
	mysql_tquery(SQL, "SELECT * FROM `cars`", "Car_Load", "");
	return 1;
}
stock SetVehiclePaintjob(vehicleid, paintjobid)
{
	new id = Car_GetID(vehicleid);

	if (id != -1)
	{
		CarData[id][carPaintjob] = paintjobid;
		Car_Save(id);
	}
	return ChangeVehiclePaintjob(vehicleid, paintjobid);
}

stock RemoveComponent(vehicleid, componentid)
{
	if (!IsValidVehicle(vehicleid) || (componentid < 1000 || componentid > 1193))
	    return 0;

	new
		id = Car_GetID(vehicleid);

	if (id != -1)
	{
	    CarData[id][carMods][GetVehicleComponentType(componentid)] = 0;
	    Car_Save(id);
	}
	return RemoveVehicleComponent(vehicleid, componentid);
}

stock AddComponent(vehicleid, componentid)
{
	if (!IsValidVehicle(vehicleid) || (componentid < 1000 || componentid > 1193))
	    return 0;

	new
		id = Car_GetID(vehicleid);

	if (id != -1)
	{
	    CarData[id][carMods][GetVehicleComponentType(componentid)] = componentid;
	    Car_Save(id);
	}
	return AddVehicleComponent(vehicleid, componentid);
}

stock IsVehicleImpounded(vehicleid)
{
	new id = Car_GetID(vehicleid);

	if (id != -1 && CarData[id][carImpounded] != -1 && CarData[id][carImpoundPrice] > 0)
		return 1;

	return 0;
}
stock Impound_Nearest(playerid)
{
	for (new i = 0; i < MAX_IMPOUND_LOTS; i ++) if (ImpoundData[i][impoundExists] && IsPlayerInRangeOfPoint(playerid, 20.0, ImpoundData[i][impoundLot][0], ImpoundData[i][impoundLot][1], ImpoundData[i][impoundLot][2])) {
	    return i;
	}
	return -1;
}

stock Impound_Delete(impoundid)
{
    if (impoundid != -1 && ImpoundData[impoundid][impoundExists])
	{
	    new
	        query[64];

		format(query, sizeof(query), "DELETE FROM `impoundlots` WHERE `impoundID` = '%d'", ImpoundData[impoundid][impoundID]);
		mysql_tquery(SQL, query);

        if (IsValidDynamic3DTextLabel(ImpoundData[impoundid][impoundText3D]))
		    DestroyDynamic3DTextLabel(ImpoundData[impoundid][impoundText3D]);

	    if (IsValidDynamicPickup(ImpoundData[impoundid][impoundPickup]))
		    DestroyDynamicPickup(ImpoundData[impoundid][impoundPickup]);

		for (new i = 0; i < MAX_DYNAMIC_CARS; i ++) if (CarData[i][carExists] && CarData[i][carImpounded] == ImpoundData[impoundid][impoundID]) {
		    CarData[i][carImpounded] = 0;
		    CarData[i][carImpoundPrice] = 0;
		    Car_Save(i);
		}
        ImpoundData[impoundid][impoundExists] = false;
        ImpoundData[impoundid][impoundID] = 0;
	}
	return 1;
}

stock GetVehicleBackpack(carid)
{
	for (new i = 0; i != MAX_BACKPACKS; i ++) if (BackpackData[i][backpackExists] && BackpackData[i][backpackVehicle] == CarData[carid][carID]) {
	    return i;
	}
	return -1;
}
stock Car_GetRealID(carid)
{
	if (carid == -1 || !CarData[carid][carExists] || CarData[carid][carVehicle] == INVALID_VEHICLE_ID)
	    return INVALID_VEHICLE_ID;

	return CarData[carid][carVehicle];
}

stock Car_GetID(vehicleid)
{
	for (new i = 0; i != MAX_DYNAMIC_CARS; i ++) if (CarData[i][carExists] && CarData[i][carVehicle] == vehicleid) {
	    return i;
	}
	return -1;
}

stock Car_Spawn(carid)
{
	if (carid != -1 && CarData[carid][carExists])
	{
		if (IsValidVehicle(CarData[carid][carVehicle]))
		    DestroyVehicle(CarData[carid][carVehicle]);

		if (CarData[carid][carColor1] == -1)
		    CarData[carid][carColor1] = random(127);

		if (CarData[carid][carColor2] == -1)
		    CarData[carid][carColor2] = random(127);

        CarData[carid][carVehicle] = AddStaticVehicleEx(CarData[carid][carModel], CarData[carid][carPos][0], CarData[carid][carPos][1], CarData[carid][carPos][2], CarData[carid][carPos][3], CarData[carid][carColor1], CarData[carid][carColor2], (CarData[carid][carOwner] != 0) ? (-1) : (1200000));

        if (CarData[carid][carVehicle] != INVALID_VEHICLE_ID)
        {
            if (CarData[carid][carPaintjob] != -1)
            {
                ChangeVehiclePaintjob(CarData[carid][carVehicle], CarData[carid][carPaintjob]);
			}
			if (CarData[carid][carLocked])
			{
			    new
					bool:engine, bool:lights, bool:alarm, bool:doors, bool:bonnet, bool:boot, bool:objective;

				GetVehicleParamsEx(CarData[carid][carVehicle], engine, lights, alarm, doors, bonnet, boot, objective);
			    SetVehicleParamsEx(CarData[carid][carVehicle], engine, lights, alarm, true, bonnet, boot, objective);
			}
			for (new i = 0; i < 14; i ++)
			{
			    if (CarData[carid][carMods][i]) AddVehicleComponent(CarData[carid][carVehicle], CarData[carid][carMods][i]);
			}
			return 1;
		}
	}
	return 0;
}

forward Car_Load();
public Car_Load()
{
	static
	    rows,
		str[128];

	cache_get_row_count(rows);

	for (new i = 0; i < rows; i ++) if (i < MAX_DYNAMIC_CARS)
	{
	    CarData[i][carExists] = true;
	    cache_get_value_name_int(i, "carID", CarData[i][carID]);
	    cache_get_value_name_int(i, "carModel", CarData[i][carModel]);
	    cache_get_value_name_int(i, "carOwner", CarData[i][carOwner]);
	    cache_get_value_name_float(i, "carPosX", CarData[i][carPos][0]);
	    cache_get_value_name_float(i, "carPosY", CarData[i][carPos][1]);
	    cache_get_value_name_float(i, "carPosZ", CarData[i][carPos][2]);
	    cache_get_value_name_float(i, "carPosR", CarData[i][carPos][3]);
	    cache_get_value_name_int(i, "carColor1", CarData[i][carColor1]);
	    cache_get_value_name_int(i, "carColor2", CarData[i][carColor2]);
	    cache_get_value_name_int(i, "carPaintjob", CarData[i][carPaintjob]);
	    cache_get_value_name_int(i, "carLocked", CarData[i][carLocked]);
	    cache_get_value_name_int(i, "carImpounded", CarData[i][carImpounded]);
	    cache_get_value_name_int(i, "carImpoundPrice", CarData[i][carImpoundPrice]);
        cache_get_value_name_int(i, "carFaction", CarData[i][carFaction]);

		for (new j = 0; j < 14; j ++)
		{
		    if (j < 5)
		    {
		        format(str, sizeof(str), "carWeapon%d", j + 1);
		        cache_get_value_name_int(i, str, CarData[i][carWeapons][j]);

		        format(str, sizeof(str), "carAmmo%d", j + 1);
		        cache_get_value_name_int(i, str, CarData[i][carAmmo][j]);
	        }
	        format(str, sizeof(str), "carMod%d", j + 1);
	        cache_get_value_name_int(i, str, CarData[i][carMods][j]);
	    }
	    Car_Spawn(i);
	}
	printf("[server_side]: %d Vozila ucitano.",rows);
	return 1;
}
Car_GetCount(playerid)
{
	new
		count = 0;

	for (new i = 0; i != MAX_DYNAMIC_CARS; i ++)
	{
		if (CarData[i][carExists] && CarData[i][carOwner] == PlayerInfo[playerid][SQLID])
   		{
   		    count++;
		}
	}
	return count;
}
Car_Inside(playerid)
{
	new carid;

	if (IsPlayerInAnyVehicle(playerid) && (carid = Car_GetID(GetPlayerVehicleID(playerid))) != -1)
	    return carid;

	return -1;
}

Car_IsOwner(playerid, carid)
{
	if (!IgracUlogovan[playerid] || PlayerInfo[playerid][SQLID] == -1)
	    return 0;

    if ((CarData[carid][carExists] && CarData[carid][carOwner] != 0) && CarData[carid][carOwner] == PlayerInfo[playerid][SQLID])
		return 1;

	return 0;
}

Car_Delete(carid)
{
    if (carid != -1 && CarData[carid][carExists])
	{
	    new
	        string[64];

		format(string, sizeof(string), "DELETE FROM `cars` WHERE `carID` = '%d'", CarData[carid][carID]);
		mysql_tquery(SQL, string);

		if (IsValidVehicle(CarData[carid][carVehicle]))
			DestroyVehicle(CarData[carid][carVehicle]);


        CarData[carid][carExists] = false;
	    CarData[carid][carID] = 0;
	    CarData[carid][carOwner] = 0;
	    CarData[carid][carVehicle] = 0;
	}
	return 1;
}

Car_Save(carid)
{
	static
	    query[900];

	if (CarData[carid][carVehicle] != INVALID_VEHICLE_ID)
	{
	    for (new i = 0; i < 14; i ++) {
			CarData[carid][carMods][i] = GetVehicleComponentInSlot(CarData[carid][carVehicle], CARMODTYPE:i);
	    }
	}
	format(query, sizeof(query), "UPDATE `cars` SET `carModel` = '%d', `carOwner` = '%d', `carPosX` = '%.4f', `carPosY` = '%.4f', `carPosZ` = '%.4f', `carPosR` = '%.4f', `carColor1` = '%d', `carColor2` = '%d', `carPaintjob` = '%d', `carLocked` = '%d'",
        CarData[carid][carModel],
        CarData[carid][carOwner],
        CarData[carid][carPos][0],
        CarData[carid][carPos][1],
        CarData[carid][carPos][2],
        CarData[carid][carPos][3],
        CarData[carid][carColor1],
        CarData[carid][carColor2],
        CarData[carid][carPaintjob],
        CarData[carid][carLocked]
	);
	format(query, sizeof(query), "%s, `carMod1` = '%d', `carMod2` = '%d', `carMod3` = '%d', `carMod4` = '%d', `carMod5` = '%d', `carMod6` = '%d', `carMod7` = '%d', `carMod8` = '%d', `carMod9` = '%d', `carMod10` = '%d', `carMod11` = '%d', `carMod12` = '%d', `carMod13` = '%d', `carMod14` = '%d'",
		query,
		CarData[carid][carMods][0],
		CarData[carid][carMods][1],
		CarData[carid][carMods][2],
		CarData[carid][carMods][3],
		CarData[carid][carMods][4],
		CarData[carid][carMods][5],
		CarData[carid][carMods][6],
		CarData[carid][carMods][7],
		CarData[carid][carMods][8],
		CarData[carid][carMods][9],
		CarData[carid][carMods][10],
		CarData[carid][carMods][11],
		CarData[carid][carMods][12],
		CarData[carid][carMods][13]
	);
	format(query, sizeof(query), "%s, `carImpounded` = '%d', `carImpoundPrice` = '%d', `carFaction` = '%d', `carWeapon1` = '%d', `carWeapon2` = '%d', `carWeapon3` = '%d', `carWeapon4` = '%d', `carWeapon5` = '%d', `carAmmo1` = '%d', `carAmmo2` = '%d', `carAmmo3` = '%d', `carAmmo4` = '%d', `carAmmo5` = '%d' WHERE `carID` = '%d'",
		query,
		CarData[carid][carImpounded],
		CarData[carid][carImpoundPrice],
		CarData[carid][carFaction],
		CarData[carid][carWeapons][0],
		CarData[carid][carWeapons][1],
		CarData[carid][carWeapons][2],
		CarData[carid][carWeapons][3],
		CarData[carid][carWeapons][4],
		CarData[carid][carAmmo][0],
		CarData[carid][carAmmo][1],
		CarData[carid][carAmmo][2],
		CarData[carid][carAmmo][3],
		CarData[carid][carAmmo][4],
		CarData[carid][carID]
	);
	return mysql_tquery(SQL, query);
}

Car_Nearest(playerid)
{
	static
	    Float:fX,
	    Float:fY,
	    Float:fZ;

	for (new i = 0; i != MAX_DYNAMIC_CARS; i ++) if (CarData[i][carExists]) {
		GetVehiclePos(CarData[i][carVehicle], fX, fY, fZ);

		if (IsPlayerInRangeOfPoint(playerid, 3.0, fX, fY, fZ)) {
		    return i;
		}
	}
	return -1;
}
forward OnCarCreated(carid);
public OnCarCreated(carid)
{
	if (carid == -1 || !CarData[carid][carExists])
	    return 0;

	CarData[carid][carID] = cache_insert_id();
	Car_Save(carid);

	return 1;
}

hook OnVehicleMod(playerid, vehicleid, componentid)
{
	new
		id = Car_GetID(vehicleid),
		slot = GetVehicleComponentType(componentid);

	if (id != -1)
	{
	    CarData[id][carMods][slot] = componentid;
	    Car_Save(id);
	}
	return 1;
}


hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if (IsPlayerNPC(playerid))
	    return 1;

	if (GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED || GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CARRY) {
	    ClearAnimations(playerid);

	    return 0;
	}
	new id = Car_GetID(vehicleid);

	if (!ispassenger && id != -1 && CarData[id][carFaction] > 0) // dodati samo proveru za ovaj ako je getfactiontype od igraca = factionu vozila
	{
	    ClearAnimations(playerid);

	    return SendClientMessage(playerid,0x3DC23BFF, "Nemate kljuceve od ovog vozila.");
	}
	return 1;
}

hook OnPlayerStateChange(playerid, PLAYER_STATE:newstate, PLAYER_STATE:oldstate)
{
    if (IsPlayerNPC(playerid))
	    return 1;

	new vehicleid = GetPlayerVehicleID(playerid);

	if (newstate == PLAYER_STATE_DRIVER)
	{
	    new id = Car_GetID(vehicleid);

		if (id != -1 && CarData[id][carFaction] > 0)  //  && GetFactionType(playerid) != CarData[id][carFaction]
		{
		    RemovePlayerFromVehicle(playerid);

	    	return SendClientMessage(playerid,0x3DC23BFF, "Nemate kljuceve od ovog vozila.");
		}
		
	    if (IsVehicleImpounded(vehicleid))
	    {
	        RemovePlayerFromVehicle(playerid);
	        SendErrorMessage(playerid, "Ovo vozilo je inpoundovano.");
	    }
	}
	return 1;
}

Dialog:ReleaseCar(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new
			carid = ListedVehicles[playerid][listitem],
			id = GetImpoundByID(CarData[carid][carImpounded]);

	    if (carid != -1 && id != -1 && CarData[carid][carExists] && CarData[carid][carImpounded] != -1)
	    {
	        if (GetPlayerMoney(playerid) < CarData[carid][carImpoundPrice])
	            return SendErrorMessage(playerid, "You can't afford to release this vehicle.");

            VosticGiveMoney(playerid, -CarData[carid][carImpoundPrice]);

            CarData[carid][carPos][0] = ImpoundData[id][impoundRelease][0];
            CarData[carid][carPos][1] = ImpoundData[id][impoundRelease][1];
            CarData[carid][carPos][2] = ImpoundData[id][impoundRelease][2];
            CarData[carid][carPos][3] = ImpoundData[id][impoundRelease][3];

			SetVehiclePos(CarData[carid][carVehicle], CarData[carid][carPos][0], CarData[carid][carPos][1], CarData[carid][carPos][2]);
			SetVehicleZAngle(CarData[carid][carVehicle], CarData[carid][carPos][3]);

			//SendInfoMessage(playerid, "You have released your %s for %s.", ReturnVehicleModelName(CarData[carid][carModel]), FormatNumber(CarData[carid][carImpoundPrice]));

            CarData[carid][carImpounded] = -1;
            CarData[carid][carImpoundPrice] = 0;

            Car_Save(carid);
	    }
	}
	return 1;
}

YCMD:abandon(playerid, params[], help)
{
 	static
	    id = -1;

	if ((id = Car_Inside(playerid)) != -1 && Car_IsOwner(playerid, id))
	{
	    if (isnull(params) || (!isnull(params) && strcmp(params, "confirm", true) != 0))
	    {
	        //SendInfoMessage(playerid, "/abandon [confirm]");
	        SendClientMessage(playerid, x_purple, "[WARNING]:{FFFFFF} You are about to abandon your vehicle with no refund.");
		}
		else if (CarData[id][carImpounded] != -1)
    		return 1;//SendErrorMessage(playerid, "This vehicle is impounded and you can't use it.");

		else if (!strcmp(params, "confirm", true))
		{
			new
			    model = CarData[id][carModel];

			Car_Delete(id);

			va_SendClientMessage(playerid,-1,"You have abandoned your %s.", ReturnVehicleModelName(model));
			//Log_Write("logs/car_log.txt", "[%s] %s has abandoned their %s.", ReturnDate(), ReturnName(playerid), ReturnVehicleModelName(model));
		}
	}
	return 1;
}

YCMD:lock(playerid, params[], help)
{
	static
	    id = -1;

	if ((id = Car_Nearest(playerid)) != -1)
	{
	    static
	        bool:engine,
	        bool:lights,
	        bool:alarm,
	        bool:doors,
	        bool:bonnet,
	        bool:boot,
	        bool:objective;

	    GetVehicleParamsEx(CarData[id][carVehicle], engine, lights, alarm, doors, bonnet, boot, objective);

	    if (Car_IsOwner(playerid, id))
	    {
			if (!CarData[id][carLocked])
			{
				CarData[id][carLocked] = true;
				Car_Save(id);

				//ShowPlayerFooter(playerid, "You have ~r~locked~w~ the vehicle!");
				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);

				SetVehicleParamsEx(CarData[id][carVehicle], engine, lights, alarm, true, bonnet, boot, objective);
			}
			else
			{
				CarData[id][carLocked] = false;
				Car_Save(id);

				//ShowPlayerFooter(playerid, "You have ~g~unlocked~w~ the vehicle!");
				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);

				SetVehicleParamsEx(CarData[id][carVehicle], engine, lights, alarm, false, bonnet, boot, objective);
			}
		}
	}
	else SendErrorMessage(playerid, "You are not in range of anything you can lock.");
	return 1;
}

YCMD:sell(playerid, params[], help)
{
	static
	    targetid,
	    type[24],
	    string[128];

	if (sscanf(params, "us[24]S()[128]", targetid, type, string))
	{
	    SendClientMessage(playerid,-1, "/sell [playerid/name] [name]");
	    SendClientMessage(playerid, x_yellow, "[NAMES]:{FFFFFF} vehicle");
	    return 1;
	}
	if (targetid == INVALID_PLAYER_ID)
	{
		SendClientMessage(playerid,-1, "The player is disconnected or not near you.");
		return 1;
	}
	if (targetid == playerid)
	{
		SendClientMessage(playerid,-1, "You cannot sell to yourself.");
		return 1;
	}
	if (!strcmp(type, "vehicle", true))
	{
		static
		    price,
			carid = -1;

 		if (sscanf(string, "d", price))
 			return SendClientMessage(playerid,-1, "/sell [playerid/name] [veh] [price]");

 		if (price < 1)
 		    return SendClientMessage(playerid,-1, "The price you've entered cannot below the value of $1.");

 		if ((carid = Car_Inside(playerid)) != -1 && Car_IsOwner(playerid, carid)) {
 			//PlayerData[targetid][pCarSeller] = playerid;
 			//PlayerData[targetid][pCarOffered] = carid;
 			//PlayerData[targetid][pCarValue] = price;

 		    va_SendClientMessage(playerid,-1, "You have requested %s to purchase your %s (%s).", ReturnPlayerName(targetid), ReturnVehicleModelName(CarData[carid][carModel]), FormatNumber(price));
            va_SendClientMessage(targetid,-1, "%s has offered you their %s for %s (type \"/approve car\" to accept).", ReturnPlayerName(playerid), ReturnVehicleModelName(CarData[carid][carModel]), FormatNumber(price));
 		}
 		else SendClientMessage(playerid,-1, "You are not inside any of your vehicles.");
 	}
 	return 1;
}

// YCMD:approve(playerid, params[], help)
// {
// 	if (isnull(params))
//  	{
// 	 	SendInfoMessage(playerid, "/approve [name]");
// 		SendClientMessage(playerid, x_yellow, "[NAMES]:{FFFFFF} car");
// 		return 1;
// 	}
// 	if (!strcmp(params, "car", true) && PlayerData[playerid][pCarSeller] != INVALID_PLAYER_ID)
// 	{
// 	    new
// 	        sellerid = PlayerData[playerid][pCarSeller],
// 	        carid = PlayerData[playerid][pCarOffered],
// 	        price = PlayerData[playerid][pCarValue];

// 		if (!IsPlayerNearPlayer(playerid, sellerid, 6.0))
// 		    return SendErrorMessage(playerid, "You are not near that player.");

// 		if (GetMoney(playerid) < price)
// 		    return SendErrorMessage(playerid, "You have insufficient funds to purchase this vehicle.");

// 		if (Car_Nearest(playerid) != carid)
// 		    return SendErrorMessage(playerid, "You must be near the vehicle to purchase it.");

// 		if (!Car_IsOwner(sellerid, carid))
// 		    return SendErrorMessage(playerid, "This vehicle offer is no longer valid.");

// 		SendInfoMessage(playerid, "You have successfully purchased %s's %s for %s.", ReturnName(sellerid, 0), ReturnVehicleModelName(CarData[carid][carModel]), FormatNumber(price));
// 		SendInfoMessage(sellerid, "%s has successfully purchased your %s for %s.", ReturnName(playerid, 0), ReturnVehicleModelName(CarData[carid][carModel]), FormatNumber(price));

// 		CarData[carid][carOwner] = GetPlayerSQLID(playerid);
// 		Car_Save(carid);

// 		GiveMoney(playerid, -price);
// 		GiveMoney(playerid, price);

// 		Log_Write("logs/offer_log.txt", "[%s] %s (%s) has sold a %s to %s (%s) for %s.", ReturnDate(), ReturnName(playerid, 0), PlayerData[playerid][pIP], ReturnVehicleModelName(CarData[carid][carModel]), ReturnName(sellerid, 0), PlayerData[sellerid][pIP], FormatNumber(price));

// 		PlayerData[playerid][pCarSeller] = INVALID_PLAYER_ID;
// 		PlayerData[playerid][pCarOffered] = -1;
// 		PlayerData[playerid][pCarValue] = 0;
// 	}
// 	return 1;
// }

// YCMD:park(playerid, params[], help)
// {
// 	new
// 	    carid = GetPlayerVehicleID(playerid);

// 	if (!carid)
// 	    return SendErrorMessage(playerid, "You must be inside your vehicle.");

//     if (IsVehicleImpounded(carid))
//     	return SendErrorMessage(playerid, "This vehicle is impounded and you can't use it.");

// 	if ((carid = Car_GetID(carid)) != -1 && Car_IsOwner(playerid, carid))
// 	{
// 	    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
// 	        return SendErrorMessage(playerid, "You must be the driver!");

// 	    static
// 			g_arrSeatData[10] = {INVALID_PLAYER_ID, ...},
// 			g_arrDamage[4],
// 			Float:health,
// 			seatid;

//         for (new i = 0; i < 14; i ++) {
// 			CarData[carid][carMods][i] = GetVehicleComponentInSlot(CarData[carid][carVehicle], i);
// 	    }
// 		GetVehicleDamageStatus(CarData[carid][carVehicle], g_arrDamage[0], g_arrDamage[1], g_arrDamage[2], g_arrDamage[3]);
// 		GetVehicleHealth(CarData[carid][carVehicle], health);

// 		foreach (new i : Player) if (IsPlayerInVehicle(i, CarData[carid][carVehicle])) {
// 		    seatid = GetPlayerVehicleSeat(i);

// 		    g_arrSeatData[seatid] = i;
// 		}
// 		GetVehiclePos(CarData[carid][carVehicle], CarData[carid][carPos][0], CarData[carid][carPos][1], CarData[carid][carPos][2]);
// 		GetVehicleZAngle(CarData[carid][carVehicle], CarData[carid][carPos][3]);

// 		Car_Spawn(carid);
// 		Car_Save(carid);

// 		SendInfoMessage(playerid, "You have successfully parked your %s.", ReturnVehicleName(CarData[carid][carVehicle]));

//         UpdateVehicleDamageStatus(CarData[carid][carVehicle], g_arrDamage[0], g_arrDamage[1], g_arrDamage[2], g_arrDamage[3]);
// 		SetVehicleHealth(CarData[carid][carVehicle], health);

// 		for (new i = 0; i < sizeof(g_arrSeatData); i ++) if (g_arrSeatData[i] != INVALID_PLAYER_ID) {
// 		    PutPlayerInVehicle(g_arrSeatData[i], CarData[carid][carVehicle], i);

// 		    g_arrSeatData[i] = INVALID_PLAYER_ID;
// 		}
// 	}
// 	else SendErrorMessage(playerid, "You are not inside anything you can park.");
// 	return 1;
// }


YCMD:listcars(playerid, params[], help)
{
	new
	    Float:fX,
	    Float:fY,
	    Float:fZ,
		userid,
		count;

	if (sscanf(params, "u", userid))
	{
		SendClientMessage(playerid, x_greey, "-----------------------------------------------------------");

		for (new i = 0; i < MAX_DYNAMIC_CARS; i ++) if (Car_IsOwner(playerid, i)) {
	    	GetVehiclePos(CarData[i][carVehicle], fX, fY, fZ);

			SendClientMessageEx(playerid, x_white, "** ID: %d | Model: %s | Location: %s", CarData[i][carVehicle], ReturnVehicleModelName(CarData[i][carModel])/*, Get(fX, fY, fZ)*/);
		    count++;
		}
		if (!count)
		    SendClientMessage(playerid, x_white, "You don't own any vehicles.");

 		SendClientMessage(playerid, x_greey, "-----------------------------------------------------------");
 	}
 	else if (PlayerInfo[playerid][Staff] >= 3)
 	{
		if (userid == INVALID_PLAYER_ID)
	    	return SendErrorMessage(playerid, "You have specified an invalid player.");

 		SendClientMessage(playerid, x_greey, "-----------------------------------------------------------");
   		SendClientMessageEx(playerid, x_yellow, "Vehicles registered to %s (ID: %d):", ReturnPlayerName(userid), userid);

 		for (new i = 0; i < MAX_DYNAMIC_CARS; i ++) if (Car_IsOwner(userid, i)) {
   			GetVehiclePos(CarData[i][carVehicle], fX, fY, fZ);

 			SendClientMessageEx(playerid, x_white, "** ID: %d | Model: %s | Location: %s", CarData[i][carVehicle], ReturnVehicleModelName(CarData[i][carModel])/*, GetLocation(fX, fY, fZ)*/);
 			count++;
 		}
 		if (!count)
 		    SendClientMessage(playerid, x_white, "That player doesn't own any vehicles.");

 		SendClientMessage(playerid, x_greey, "-----------------------------------------------------------"); 	}
 	return 1;
 }

// YCMD:editcar(playerid, params[], help)
// {
// 	static
// 	    id,
// 	    type[24],
// 	    string[128];

// 	if (PlayerInfo[playerid][Staff] < 5)
// 	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

// 	if (sscanf(params, "ds[24]S()[128]", id, type, string))
//  	{
// 	 	SendInfoMessage(playerid, "/editcar [id] [name]");
// 	    SendClientMessage(playerid, x_yellow, "[NAMES]:{FFFFFF} location, faction, color1, color2");
// 		return 1;
// 	}
// 	if (!IsValidVehicle(id) || Car_GetID(id) == -1)
// 	    return SendErrorMessage(playerid, "You have specified an invalid vehicle ID.");

// 	id = Car_GetID(id);

// 	if (!strcmp(type, "location", true))
// 	{
//  		GetPlayerPos(playerid, CarData[id][carPos][0], CarData[id][carPos][1], CarData[id][carPos][2]);
// 		GetPlayerFacingAngle(playerid, CarData[id][carPos][3]);

// 		Car_Save(id);
// 		Car_Spawn(id);

// 		SetPlayerPosEx(playerid, CarData[id][carPos][0], CarData[id][carPos][1], CarData[id][carPos][2] + 2.0, 1000);
// 	}
// 	else if (!strcmp(type, "faction", true))
// 	{
// 	    new typeint;

// 	    if (sscanf(string, "d", typeint))
//      	{
//      	    SendInfoMessage(playerid, "/editcar [id] [faction] [type]");
// 		 	SendClientMessage(playerid, x_yellow, "[TYPES]:{FFFFFF} 1: Police | 2: News | 3: Medical | 4: Government");
// 		 	return 1;
// 		}
// 		if (typeint < 0 || typeint > 4)
// 		    return SendErrorMessage(playerid, "The specified type can't be below 0 or above 4.");

// 		CarData[id][carFaction] = typeint;

// 		Car_Save(id);
// 	}
//     else if (!strcmp(type, "color1", true))
// 	{
// 	    new color1;

// 	    if (sscanf(string, "d", color1))
// 			return SendInfoMessage(playerid, "/editcar [id] [color1] [color 1]");

// 		if (color1 < 0 || color1 > 255)
// 		    return SendErrorMessage(playerid, "The specified color can't be below 0 or above 255.");

// 		CarData[id][carColor1] = color1;
// 		ChangeVehicleColor(CarData[id][carVehicle], CarData[id][carColor1], CarData[id][carColor2]);

// 		Car_Save(id);
// 	}
//     else if (!strcmp(type, "color2", true))
// 	{
// 	    new color2;

// 	    if (sscanf(string, "d", color2))
// 			return SendInfoMessage(playerid, "/editcar [id] [color2] [color 2]");

// 		if (color2 < 0 || color2 > 255)
// 		    return SendErrorMessage(playerid, "The specified color can't be below 0 or above 255.");

// 		CarData[id][carColor2] = color2;
// 		ChangeVehicleColor(CarData[id][carVehicle], CarData[id][carColor1], CarData[id][carColor2]);

// 		Car_Save(id);
// 	}
// 	return 1;
// }

YCMD:givecar(playerid, params[], help)
{
	static
		userid,
	    model[32];

    if (PlayerInfo[playerid][Staff] < 4)
	    return SendClientMessage(playerid,-1, "You don't have permission to use this command.");

	if (sscanf(params, "us[32]", userid, model))
	    return SendClientMessage(playerid,-1, "/givecar [playerid/name] [modelid/name]");

	if (Car_GetCount(userid) >= MAX_OWNABLE_CARS)
	    return SendClientMessage(playerid,-1, "This player already owns the maximum amount of cars.");

    if ((model[0] = GetVehicleModelByName(model)) == 0)
	    return SendClientMessage(playerid,-1, "Invalid model ID.");

	static
	    Float:x,
		Float:y,
		Float:z,
		Float:angle,
		id = -1;

    GetPlayerPos(userid, x, y, z);
	GetPlayerFacingAngle(userid, angle);

	id = Car_Create(PlayerInfo[userid][SQLID], model[0], x, y + 2, z + 1, angle, random(127), random(127), 0);

	if (id == -1)
	    return SendClientMessage(playerid,-1, "The server has reached the limit for dynamic vehicles.");

	va_SendClientMessage(playerid,-1, "You have created vehicle ID: %d for %s.", CarData[id][carVehicle], ReturnPlayerName(userid));
	return 1;
}



GetVehicleModelByName(const name[])
{
	if (IsNumeric(name) && (strval(name) >= 400 && strval(name) <= 611))
	    return strval(name);

	for (new i = 0; i < sizeof(g_arrVehicleNames); i ++)
	{
	    if (strfind(g_arrVehicleNames[i], name, true) != -1)
	    {
	        return i + 400;
		}
	}
	return 0;
}
Car_Create(ownerid, modelid, Float:x, Float:y, Float:z, Float:angle, color1, color2, type = 0)
{
    for (new i = 0; i != MAX_DYNAMIC_CARS; i ++)
	{
		if (!CarData[i][carExists])
   		{
   		    if (color1 == -1)
   		        color1 = random(127);

			if (color2 == -1)
			    color2 = random(127);

   		    CarData[i][carExists] = true;
            CarData[i][carModel] = modelid;
            CarData[i][carOwner] = ownerid;

            CarData[i][carPos][0] = x;
            CarData[i][carPos][1] = y;
            CarData[i][carPos][2] = z;
            CarData[i][carPos][3] = angle;

            CarData[i][carColor1] = color1;
            CarData[i][carColor2] = color2;
            CarData[i][carPaintjob] = -1;
            CarData[i][carLocked] = false;
            CarData[i][carImpounded] = -1;
            CarData[i][carImpoundPrice] = 0;
            CarData[i][carFaction] = type;

            for (new j = 0; j < 14; j ++)
			{
                if (j < 5)
				{
                    CarData[i][carWeapons][j] = 0;
                    CarData[i][carAmmo][j] = 0;
                }
                CarData[i][carMods][j] = 0;
            }
            CarData[i][carVehicle] = AddStaticVehicleEx(modelid, x, y, z, angle, color1, color2, -1);

            mysql_tquery(SQL, "INSERT INTO `cars` (`carModel`) VALUES(0)", "OnCarCreated", "d", i);

            return i;
		}
	}
	return -1;
}

YCMD:createcar(playerid, params[], help)
{
	new
		model,
		color1,
		color2,
		type = 0;
		
	static 	id = -1;

    if (PlayerInfo[playerid][Staff] < 4)
	    return SendClientMessage(playerid, 0xFF1100AA, "[error] > {ffffff}Niste ovlasceni za upotrebu ove komande.");

	if (sscanf(params, "iI(-1)I(-1)I(0)", model, color1, color2, type))
 	{
	 	SendClientMessage(playerid,0x3DC23BFF, "/createcar [modelid] [boja 1] [boja 2] <faction>");
	 	return 1;
	}
	new
	    Float:xPozicija,
		Float:yPozicija,
		Float:zPozicija,
		Float:angle;

    GetPlayerPos(playerid, xPozicija, yPozicija, zPozicija);
	GetPlayerFacingAngle(playerid, angle);

	id = Car_Create(0, model, xPozicija, yPozicija, zPozicija, angle, color1, color2, type);

	if (id == -1)
	    return SendClientMessage(playerid,0x3DC23BFF, "Server je dostigao limit dinamicnih vozila.");

	SetPlayerPos(playerid, xPozicija, yPozicija, zPozicija + 2);
	va_SendClientMessage(playerid,0x3DC23BFF,"[server_side] > {ffffff}Uspesno ste kreirali vozilo VoziloID: %d.", CarData[id][carVehicle]);
	return 1;
}