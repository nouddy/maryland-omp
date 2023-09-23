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
 *  @Author         Vostic & Ogy_
 *  @Date           29th May 2023
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           biz.script
 *  @Module         business
*/

 //? Takodje oni imaju kul stvar za druge firme pogledaj car dealership, ako je biz type 5 ucitava firmu iz druge sql tabele, rasterecuje enum i pregledniji je sql.
 //? Primer na liniji u scrp (6709)

 /* if (BusinessData[i][bizType] == 5) {
			format(str, sizeof(str), "SELECT * FROM `dealervehicles` WHERE `ID` = '%d'", BusinessData[i][bizID]);

			mysql_tquery(SQL, str, "Business_LoadCars", "d", i);
		}
*/

//============================================================ Includes
#include <ysilib\YSI_Coding\y_hooks>

//============================================================ Defines
#define MAX_BUSINESS (500)

//============================================================ Enums

enum businessData {
    bizID,
    bizExists,
    bizName[32],
    bizMessage[128],
    bizOwner,
    bizType,
    bizPrice,
    Float:bizPos[4],
    Float:bizInt[4],
    Float:bizSpawn[4],
    Float:bizDeliver[3],
    bizInterior,
    bizExterior,
    bizExteriorVW,
    bizLocked,
    bizVault,
    bizProducts,
    bizPickup,
    bizShipment,
    bizPrices[20],
    Text3D:bizText3D,
    Text3D:bizDeliverText3D,
    bizDeliverPickup
};
new BusinessData[MAX_BUSINESS][businessData];

//============================================================ Boze Pomozi

hook OnGameModeInit()
{
    print("business/biz.script loaded");

    mysql_tquery(SQL, "SELECT * FROM `businesses`", "Business_Load", "");
}

forward Business_Load();
public Business_Load()
{
    if(!cache_num_rows())
        return print("\n[Business]: 0 business loaded.\n");

    static
        rows,
        str[64];

    cache_get_row_count(rows);

    for (new i = 0; i < rows; i ++) if (i < MAX_BUSINESS)
    {
        BusinessData[i][bizExists] = true;
        cache_get_value_name_int(i, "bizID",BusinessData[i][bizID]);

        cache_get_value_name(i, "bizName", BusinessData[i][bizName], 32);
        cache_get_value_name(i, "bizMessage", BusinessData[i][bizMessage], 128);

        cache_get_value_name_int(i, "bizOwner",BusinessData[i][bizOwner]);
        cache_get_value_name_int(i, "bizType",BusinessData[i][bizType]);
        cache_get_value_name_int(i, "bizPrice",BusinessData[i][bizPrice]);
        cache_get_value_name_float(i, "bizPosX",BusinessData[i][bizPos][0]);
        cache_get_value_name_float(i, "bizPosY",BusinessData[i][bizPos][1]);
        cache_get_value_name_float(i, "bizPosZ",BusinessData[i][bizPos][2]);
        cache_get_value_name_float(i, "bizPosA",BusinessData[i][bizPos][3]);
        cache_get_value_name_float(i, "bizIntX",BusinessData[i][bizInt][0]);
        cache_get_value_name_float(i, "bizIntY",BusinessData[i][bizInt][1]);
        cache_get_value_name_float(i, "bizIntZ",BusinessData[i][bizInt][2]);
        cache_get_value_name_float(i, "bizIntA",BusinessData[i][bizInt][3]);
        cache_get_value_name_float(i, "bizSpawnX",BusinessData[i][bizSpawn][0]);
        cache_get_value_name_float(i, "bizSpawnY",BusinessData[i][bizSpawn][1]);
        cache_get_value_name_float(i, "bizSpawnZ",BusinessData[i][bizSpawn][2]);
        cache_get_value_name_float(i, "bizSpawnA",BusinessData[i][bizSpawn][3]);
        cache_get_value_name_float(i, "bizDeliverX",BusinessData[i][bizDeliver][0]);
        cache_get_value_name_float(i, "bizDeliverY",BusinessData[i][bizDeliver][1]);
        cache_get_value_name_float(i, "bizDeliverZ",BusinessData[i][bizDeliver][2] );
        cache_get_value_name_int(i, "bizShipment",BusinessData[i][bizShipment]);
        cache_get_value_name_int(i, "bizInterior",BusinessData[i][bizInterior]);
        cache_get_value_name_int(i, "bizExterior",BusinessData[i][bizExterior]);
        cache_get_value_name_int(i, "bizExteriorVW",BusinessData[i][bizExteriorVW]);
        cache_get_value_name_int(i, "bizLocked",BusinessData[i][bizLocked]);
        cache_get_value_name_int(i, "bizVault",BusinessData[i][bizVault]);
        cache_get_value_name_int(i, "bizProducts",BusinessData[i][bizProducts]);

        for (new j = 0; j < 20; j ++)
        {
            format(str, 32, "bizPrice%d", j + 1);
            cache_get_value_name_int(i, str,BusinessData[i][bizPrices][j]);
        }
        Business_Refresh(i);
    }
    return 1;
}

//============================================================ Stocks
stock GetClosestBusiness(playerid, type)
{
    new
        Float:fDistance[2] = {99999.0, 0.0},
        iIndex = -1
    ;
    for (new i = 0; i < MAX_BUSINESS; i ++) if (BusinessData[i][bizExists] && BusinessData[i][bizType] == type && GetPlayerInterior(playerid) == BusinessData[i][bizExterior] && GetPlayerVirtualWorld(playerid) == BusinessData[i][bizExteriorVW])
    {
        fDistance[1] = GetPlayerDistanceFromPoint(playerid, BusinessData[i][bizPos][0], BusinessData[i][bizPos][1], BusinessData[i][bizPos][2]);

        if (fDistance[1] < fDistance[0])
        {
            fDistance[0] = fDistance[1];
            iIndex = i;
        }
    }
    return iIndex;
}
Business_GetCount(playerid)
{
    new
        count = 0;

    for (new i = 0; i != MAX_BUSINESS; i ++)
    {
        if (BusinessData[i][bizExists] && Business_IsOwner(playerid, i))
        {
            count++;
        }
    }
    return count;
}
Business_ProductMenu(playerid, bizid)
{
    if (bizid == -1 || !BusinessData[bizid][bizExists])
        return 0;

    static
        string[512];

    switch (BusinessData[bizid][bizType])
    {
        case 1, 6:
        {
            format(string, sizeof(string), "Mobile Phone - %s\nGPS System - %s\nSpray Paint - %s\nBackpack - %s\nWater Bottle - %s\nSoda Bottle - %s\nLottery Ticket - %s\nPortable Radio - %s\nCan of Fuel - %s\nCrowbar - %s\nBoombox - %s\nMask - %s\nFirst Aid Kit - %s\nRepair Kit - %s\nNOS Canister - %s\nBaseball Bat - %s\nFrozen Pizza - %s\nFrozen Burger - %s",
                FormatNumber(BusinessData[bizid][bizPrices][0]),
                FormatNumber(BusinessData[bizid][bizPrices][1]),
                FormatNumber(BusinessData[bizid][bizPrices][2]),
                FormatNumber(BusinessData[bizid][bizPrices][3]),
                FormatNumber(BusinessData[bizid][bizPrices][4]),
                FormatNumber(BusinessData[bizid][bizPrices][5]),
                FormatNumber(BusinessData[bizid][bizPrices][6]),
                FormatNumber(BusinessData[bizid][bizPrices][7]),
                FormatNumber(BusinessData[bizid][bizPrices][8]),
                FormatNumber(BusinessData[bizid][bizPrices][9]),
                FormatNumber(BusinessData[bizid][bizPrices][10]),
                FormatNumber(BusinessData[bizid][bizPrices][11]),
                FormatNumber(BusinessData[bizid][bizPrices][12]),
                FormatNumber(BusinessData[bizid][bizPrices][13]),
                FormatNumber(BusinessData[bizid][bizPrices][14]),
                FormatNumber(BusinessData[bizid][bizPrices][15]),
                FormatNumber(BusinessData[bizid][bizPrices][16]),
                FormatNumber(BusinessData[bizid][bizPrices][17])
            );
            Dialog_Show(playerid, EditProduct, DIALOG_STYLE_LIST, "Business: Modify Item", string, "Modify", "Cancel");
        }
        case 2:
        {
            format(string, sizeof(string), "Magazine - %s\nAmmo Cartridge - %s\nArmored Vest - %s\nDesert Eagle - %s\nRemington 870 - %s\nM14 Rifle - %s",
                FormatNumber(BusinessData[bizid][bizPrices][0]),
                FormatNumber(BusinessData[bizid][bizPrices][1]),
                FormatNumber(BusinessData[bizid][bizPrices][2]),
                FormatNumber(BusinessData[bizid][bizPrices][3]),
                FormatNumber(BusinessData[bizid][bizPrices][4]),
                FormatNumber(BusinessData[bizid][bizPrices][5])
            );
            Dialog_Show(playerid, EditProduct, DIALOG_STYLE_LIST, "Business: Modify Item", string, "Modify", "Cancel");
        }
        case 3:
        {
            format(string, sizeof(string), "Clothes - %s\nGlasses - %s\nHats - %s\nBandana - %s",
                FormatNumber(BusinessData[bizid][bizPrices][0]),
                FormatNumber(BusinessData[bizid][bizPrices][1]),
                FormatNumber(BusinessData[bizid][bizPrices][2]),
                FormatNumber(BusinessData[bizid][bizPrices][3])
            );
            Dialog_Show(playerid, EditProduct, DIALOG_STYLE_LIST, "Business: Modify Item", string, "Modify", "Cancel");
        }
        case 4:
        {
            format(string, sizeof(string), "Water - %s\nSoda - %s\nFrench Fries - %s\nCheeseburger - %s\nChicken Burger - %s\nChicken Nuggets - %s\nSalad - %s",
                FormatNumber(BusinessData[bizid][bizPrices][0]),
                FormatNumber(BusinessData[bizid][bizPrices][1]),
                FormatNumber(BusinessData[bizid][bizPrices][2]),
                FormatNumber(BusinessData[bizid][bizPrices][3]),
                FormatNumber(BusinessData[bizid][bizPrices][4]),
                FormatNumber(BusinessData[bizid][bizPrices][5]),
                FormatNumber(BusinessData[bizid][bizPrices][6])
            );
            Dialog_Show(playerid, EditProduct, DIALOG_STYLE_LIST, "Business: Modify Item", string, "Modify", "Cancel");
        }
        case 7:
        {
        }
    }
    return 1;
}

Business_PurchaseMenu(playerid, bizid)
{
    if (bizid == -1 || !BusinessData[bizid][bizExists])
        return 0;

    static
        string[512];

    switch (BusinessData[bizid][bizType])
    {
        case 1, 6:
        {
            format(string, sizeof(string), "Mobile Phone - %s\nGPS System - %s\nSpray Paint - %s\nBackpack - %s\nWater Bottle - %s\nSoda Bottle - %s\nLottery Ticket - %s\nPortable Radio - %s\nCan of Fuel - %s\nCrowbar - %s\nBoombox - %s\nMask - %s\nFirst Aid Kit - %s\nRepair Kit - %s\nNOS Canister - %s\nBaseball Bat - %s\nFrozen Pizza - %s\nFrozen Burger - %s",
                FormatNumber(BusinessData[bizid][bizPrices][0]),
                FormatNumber(BusinessData[bizid][bizPrices][1]),
                FormatNumber(BusinessData[bizid][bizPrices][2]),
                FormatNumber(BusinessData[bizid][bizPrices][3]),
                FormatNumber(BusinessData[bizid][bizPrices][4]),
                FormatNumber(BusinessData[bizid][bizPrices][5]),
                FormatNumber(BusinessData[bizid][bizPrices][6]),
                FormatNumber(BusinessData[bizid][bizPrices][7]),
                FormatNumber(BusinessData[bizid][bizPrices][8]),
                FormatNumber(BusinessData[bizid][bizPrices][9]),
                FormatNumber(BusinessData[bizid][bizPrices][10]),
                FormatNumber(BusinessData[bizid][bizPrices][11]),
                FormatNumber(BusinessData[bizid][bizPrices][12]),
                FormatNumber(BusinessData[bizid][bizPrices][13]),
                FormatNumber(BusinessData[bizid][bizPrices][14]),
                FormatNumber(BusinessData[bizid][bizPrices][15]),
                FormatNumber(BusinessData[bizid][bizPrices][16]),
                FormatNumber(BusinessData[bizid][bizPrices][17])
            );
            Dialog_Show(playerid, BusinessBuy, DIALOG_STYLE_LIST, BusinessData[bizid][bizName], string, "Purchase", "Cancel");
        }
        case 2:
        {
            format(string, sizeof(string), "Magazine - %s\nAmmo Cartridge - %s\nArmored Vest - %s\nDesert Eagle - %s\nRemington 870 - %s\nM14 Rifle - %s",
                FormatNumber(BusinessData[bizid][bizPrices][0]),
                FormatNumber(BusinessData[bizid][bizPrices][1]),
                FormatNumber(BusinessData[bizid][bizPrices][2]),
                FormatNumber(BusinessData[bizid][bizPrices][3]),
                FormatNumber(BusinessData[bizid][bizPrices][4]),
                FormatNumber(BusinessData[bizid][bizPrices][5])
            );
            Dialog_Show(playerid, BusinessBuy, DIALOG_STYLE_LIST, BusinessData[bizid][bizName], string, "Purchase", "Cancel");
        }
        case 3:
        {
            format(string, sizeof(string), "Clothes - %s\nGlasses - %s\nHats - %s\nBandana - %s",
                FormatNumber(BusinessData[bizid][bizPrices][0]),
                FormatNumber(BusinessData[bizid][bizPrices][1]),
                FormatNumber(BusinessData[bizid][bizPrices][2]),
                FormatNumber(BusinessData[bizid][bizPrices][3])
            );
            Dialog_Show(playerid, BusinessBuy, DIALOG_STYLE_LIST, BusinessData[bizid][bizName], string, "Purchase", "Cancel");
        }
        case 4:
        {
            format(string, sizeof(string), "Water - %s\nSoda - %s\nFrench Fries - %s\nCheeseburger - %s\nChicken Burger - %s\nChicken Nuggets - %s\nSalad - %s",
                FormatNumber(BusinessData[bizid][bizPrices][0]),
                FormatNumber(BusinessData[bizid][bizPrices][1]),
                FormatNumber(BusinessData[bizid][bizPrices][2]),
                FormatNumber(BusinessData[bizid][bizPrices][3]),
                FormatNumber(BusinessData[bizid][bizPrices][4]),
                FormatNumber(BusinessData[bizid][bizPrices][5]),
                FormatNumber(BusinessData[bizid][bizPrices][6])
            );
            Dialog_Show(playerid, BusinessBuy, DIALOG_STYLE_LIST, BusinessData[bizid][bizName], string, "Purchase", "Cancel");
        }
        case 7:
        {
        }
    }
    return 1;
}

Business_Save(bizid)
{
    static
        query[2048];

    format(query, sizeof(query), "UPDATE `businesses` SET `bizName` = '%s', `bizMessage` = '%s', `bizOwner` = '%d', `bizType` = '%d', `bizPrice` = '%d', `bizPosX` = '%.4f', `bizPosY` = '%.4f', `bizPosZ` = '%.4f', `bizPosA` = '%.4f', `bizIntX` = '%.4f', `bizIntY` = '%.4f', `bizIntZ` = '%.4f', `bizIntA` = '%.4f', `bizInterior` = '%d', `bizExterior` = '%d', `bizExteriorVW` = '%d', `bizLocked` = '%d', `bizVault` = '%d', `bizProducts` = '%d'",
        BusinessData[bizid][bizName],
        BusinessData[bizid][bizMessage],
        BusinessData[bizid][bizOwner],
        BusinessData[bizid][bizType],
        BusinessData[bizid][bizPrice],
        BusinessData[bizid][bizPos][0],
        BusinessData[bizid][bizPos][1],
        BusinessData[bizid][bizPos][2],
        BusinessData[bizid][bizPos][3],
        BusinessData[bizid][bizInt][0],
        BusinessData[bizid][bizInt][1],
        BusinessData[bizid][bizInt][2],
        BusinessData[bizid][bizInt][3],
        BusinessData[bizid][bizInterior],
        BusinessData[bizid][bizExterior],
        BusinessData[bizid][bizExteriorVW],
        BusinessData[bizid][bizLocked],
        BusinessData[bizid][bizVault],
        BusinessData[bizid][bizProducts]
    );
    for (new i = 0; i < 20; i ++) {
        format(query, sizeof(query), "%s, `bizPrice%d` = '%d'", query, i + 1, BusinessData[bizid][bizPrices][i]);
    }
    format(query, sizeof(query), "%s, `bizSpawnX` = '%.4f', `bizSpawnY` = '%.4f', `bizSpawnZ` = '%.4f', `bizSpawnA` = '%.4f', `bizDeliverX` = '%.4f', `bizDeliverY` = '%.4f', `bizDeliverZ` = '%.4f', `bizShipment` = '%d' WHERE `bizID` = '%d'",
        query,
        BusinessData[bizid][bizSpawn][0],
        BusinessData[bizid][bizSpawn][1],
        BusinessData[bizid][bizSpawn][2],
        BusinessData[bizid][bizSpawn][3],
        BusinessData[bizid][bizDeliver][0],
        BusinessData[bizid][bizDeliver][1],
        BusinessData[bizid][bizDeliver][2],
        BusinessData[bizid][bizShipment],
        BusinessData[bizid][bizID]
    );
    return mysql_tquery(SQL, query);
}

Business_Nearest(playerid, Float:radius = 2.5)
{
    for (new i = 0; i != MAX_BUSINESS; i ++) if (BusinessData[i][bizExists] && IsPlayerInRangeOfPoint(playerid, radius, BusinessData[i][bizPos][0], BusinessData[i][bizPos][1], BusinessData[i][bizPos][2]))
    {
        if (GetPlayerInterior(playerid) == BusinessData[i][bizExterior] && GetPlayerVirtualWorld(playerid) == BusinessData[i][bizExteriorVW])
            return i;
    }
    return -1;
}
Business_Refresh(bizid)
{
    if (bizid != -1 && BusinessData[bizid][bizExists])
    {
        if (IsValidDynamic3DTextLabel(BusinessData[bizid][bizText3D]))
            DestroyDynamic3DTextLabel(BusinessData[bizid][bizText3D]);

        if (IsValidDynamic3DTextLabel(BusinessData[bizid][bizDeliverText3D]))
            DestroyDynamic3DTextLabel(BusinessData[bizid][bizDeliverText3D]);

        if (IsValidDynamicPickup(BusinessData[bizid][bizPickup]))
            DestroyDynamicPickup(BusinessData[bizid][bizPickup]);

        if (IsValidDynamicPickup(BusinessData[bizid][bizDeliverPickup]))
            DestroyDynamicPickup(BusinessData[bizid][bizDeliverPickup]);

        static
            string[150],
            pickup;

        if (!BusinessData[bizid][bizOwner]) {
            format(string, sizeof(string), "» Biznis("c_white"%d"c_server")\n» Cena biznisa: "c_white"%s\n"c_server"» Opis biznisa: "c_white"%s\n"c_server"» Kupovina: "c_white"/kupibiznis",bizid, FormatNumber(BusinessData[bizid][bizPrice]), BusinessData[bizid][bizName]);
            BusinessData[bizid][bizText3D] = CreateDynamic3DTextLabel(string, x_server, BusinessData[bizid][bizPos][0], BusinessData[bizid][bizPos][1], BusinessData[bizid][bizPos][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, BusinessData[bizid][bizExteriorVW], BusinessData[bizid][bizExterior]);
        }
        else
        {
            if (BusinessData[bizid][bizLocked]) {
                format(string, sizeof(string), "%s (closed)", BusinessData[bizid][bizName]);
            }
            else {
                format(string, sizeof(string), "%s", BusinessData[bizid][bizName]);
            }
            BusinessData[bizid][bizText3D] = CreateDynamic3DTextLabel(string, (BusinessData[bizid][bizLocked]) ? (x_red) : (x_white), BusinessData[bizid][bizPos][0], BusinessData[bizid][bizPos][1], BusinessData[bizid][bizPos][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, BusinessData[bizid][bizExteriorVW], BusinessData[bizid][bizExterior]);
        }
        switch (BusinessData[bizid][bizType]) {
            case 1: pickup = 19132;
            case 2: pickup = 19132;
            case 3: pickup = 19132;
            case 4: pickup = 19132;
            case 5: pickup = 19132;
            case 6: pickup = 19132;
            case 7: pickup = 19132;
        }
        if (BusinessData[bizid][bizType] == 6) {
            BusinessData[bizid][bizPickup] = CreateDynamicPickup(pickup, 23, BusinessData[bizid][bizPos][0], BusinessData[bizid][bizPos][1], BusinessData[bizid][bizPos][2] + 0.3, BusinessData[bizid][bizExteriorVW], BusinessData[bizid][bizExterior]);
        }
        else if (BusinessData[bizid][bizType] == 7) {
            BusinessData[bizid][bizPickup] = CreateDynamicPickup(pickup, 23, BusinessData[bizid][bizPos][0], BusinessData[bizid][bizPos][1], BusinessData[bizid][bizPos][2] - 0.6, BusinessData[bizid][bizExteriorVW], BusinessData[bizid][bizExterior]);
        }
        else {
            BusinessData[bizid][bizPickup] = CreateDynamicPickup(pickup, 23, BusinessData[bizid][bizPos][0], BusinessData[bizid][bizPos][1], BusinessData[bizid][bizPos][2], BusinessData[bizid][bizExteriorVW], BusinessData[bizid][bizExterior]);
        }
        if (BusinessData[bizid][bizDeliver][0] != 0.0 && BusinessData[bizid][bizDeliver][0] != 0.0 && BusinessData[bizid][bizDeliver][0] != 0.0)
        {
            format(string, sizeof(string), "%s\n\nDelivery Point", BusinessData[bizid][bizName]);

            BusinessData[bizid][bizPickup] = CreateDynamicPickup(1239, 23, BusinessData[bizid][bizDeliver][0], BusinessData[bizid][bizDeliver][1], BusinessData[bizid][bizDeliver][2]);
            BusinessData[bizid][bizDeliverText3D] = CreateDynamic3DTextLabel(string, x_server2, BusinessData[bizid][bizDeliver][0], BusinessData[bizid][bizDeliver][1], BusinessData[bizid][bizDeliver][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0);
        }
    }
    return 1;
}

stock Business_Create(playerid, type, price)
{
    static
        Float:x,
        Float:y,
        Float:z,
        Float:angle;

    if (GetPlayerPos(playerid, x, y, z) && GetPlayerFacingAngle(playerid, angle))
    {
        for (new i = 0; i != MAX_BUSINESS; i ++)
        {
            if (!BusinessData[i][bizExists])
            {
                BusinessData[i][bizExists] = true;
                BusinessData[i][bizOwner] = 0;
                BusinessData[i][bizPrice] = price;
                BusinessData[i][bizType] = type;

                format(BusinessData[i][bizName], 32, "Unnamed Business");

                BusinessData[i][bizPos][0] = x;
                BusinessData[i][bizPos][1] = y;
                BusinessData[i][bizPos][2] = z;
                BusinessData[i][bizPos][3] = angle;

                BusinessData[i][bizSpawn][0] = x;
                BusinessData[i][bizSpawn][1] = y;
                BusinessData[i][bizSpawn][2] = z;
                BusinessData[i][bizSpawn][3] = angle;

                BusinessData[i][bizDeliver][0] = 0.0;
                BusinessData[i][bizDeliver][1] = 0.0;
                BusinessData[i][bizDeliver][2] = 0.0;

                if (type == 1) {
                    BusinessData[i][bizInt][0] = -27.3074;
                    BusinessData[i][bizInt][1] = -30.8741;
                    BusinessData[i][bizInt][2] = 1003.5573;
                    BusinessData[i][bizInt][3] = 0.0000;
                    BusinessData[i][bizInterior] = 4;

                    BusinessData[i][bizPrices][0] = 75;
                    BusinessData[i][bizPrices][1] = 125;
                    BusinessData[i][bizPrices][2] = 15;
                    BusinessData[i][bizPrices][3] = 100;
                    BusinessData[i][bizPrices][4] = 3;
                    BusinessData[i][bizPrices][5] = 2;
                    BusinessData[i][bizPrices][6] = 10;
                    BusinessData[i][bizPrices][7] = 100;
                    BusinessData[i][bizPrices][8] = 20;
                    BusinessData[i][bizPrices][9] = 10;
                    BusinessData[i][bizPrices][10] = 150;
                    BusinessData[i][bizPrices][11] = 200;
                    BusinessData[i][bizPrices][12] = 160;
                    BusinessData[i][bizPrices][13] = 60;
                    BusinessData[i][bizPrices][14] = 50;
                    BusinessData[i][bizPrices][15] = 5;
                    BusinessData[i][bizPrices][16] = 10;
                    BusinessData[i][bizPrices][17] = 5;
                }
                else if (type == 2) {
                    BusinessData[i][bizInt][0] = 316.3963;
                    BusinessData[i][bizInt][1] = -169.8375;
                    BusinessData[i][bizInt][2] = 999.6010;
                    BusinessData[i][bizInt][3] = 0.0000;
                    BusinessData[i][bizInterior] = 6;

                    BusinessData[i][bizPrices][0] = 50;
                    BusinessData[i][bizPrices][1] = 100;
                    BusinessData[i][bizPrices][2] = 200;
                    BusinessData[i][bizPrices][3] = 400;
                    BusinessData[i][bizPrices][4] = 600;
                    BusinessData[i][bizPrices][5] = 800;
                }
                else if (type == 3) {
                    BusinessData[i][bizInt][0] = 161.4801;
                    BusinessData[i][bizInt][1] = -96.5368;
                    BusinessData[i][bizInt][2] = 1001.8047;
                    BusinessData[i][bizInt][3] = 0.0000;
                    BusinessData[i][bizInterior] = 18;

                    BusinessData[i][bizPrices][0] = 25;
                    BusinessData[i][bizPrices][1] = 15;
                    BusinessData[i][bizPrices][2] = 10;
                    BusinessData[i][bizPrices][3] = 10;
                }
                else if (type == 4) {
                    BusinessData[i][bizInt][0] = 363.3402;
                    BusinessData[i][bizInt][1] = -74.6679;
                    BusinessData[i][bizInt][2] = 1001.5078;
                    BusinessData[i][bizInt][3] = 315.0000;
                    BusinessData[i][bizInterior] = 10;

                    BusinessData[i][bizPrices][0] = 2;
                    BusinessData[i][bizPrices][1] = 5;
                    BusinessData[i][bizPrices][2] = 5;
                    BusinessData[i][bizPrices][3] = 10;
                    BusinessData[i][bizPrices][4] = 10;
                    BusinessData[i][bizPrices][5] = 15;
                    BusinessData[i][bizPrices][6] = 10;
                }
                else if (type == 5) {
                    BusinessData[i][bizInt][0] = 1494.5612;
                    BusinessData[i][bizInt][1] = 1304.2061;
                    BusinessData[i][bizInt][2] = 1093.2891;
                    BusinessData[i][bizInt][3] = 0.0000;
                    BusinessData[i][bizInterior] = 3;
                }
                else if (type == 6) {
                    BusinessData[i][bizInt][0] = -27.3383;
                    BusinessData[i][bizInt][1] = -57.6909;
                    BusinessData[i][bizInt][2] = 1003.5469;
                    BusinessData[i][bizInt][3] = 0.0000;
                    BusinessData[i][bizInterior] = 6;

                    BusinessData[i][bizPrices][0] = 75;
                    BusinessData[i][bizPrices][1] = 115;
                    BusinessData[i][bizPrices][2] = 15;
                    BusinessData[i][bizPrices][3] = 90;
                    BusinessData[i][bizPrices][4] = 3;
                    BusinessData[i][bizPrices][5] = 2;
                    BusinessData[i][bizPrices][6] = 10;
                    BusinessData[i][bizPrices][7] = 90;
                    BusinessData[i][bizPrices][8] = 20;
                    BusinessData[i][bizPrices][9] = 10;
                    BusinessData[i][bizPrices][10] = 140;
                    BusinessData[i][bizPrices][11] = 150;
                    BusinessData[i][bizPrices][12] = 50;
                    BusinessData[i][bizPrices][13] = 40;
                    BusinessData[i][bizPrices][14] = 5;
                    BusinessData[i][bizPrices][15] = 10;
                    BusinessData[i][bizPrices][16] = 5;
                }
                else if (type == 7) {
                    BusinessData[i][bizInt][0] = -2240.4954;
                    BusinessData[i][bizInt][1] = 128.3774;
                    BusinessData[i][bizInt][2] = 1035.4210;
                    BusinessData[i][bizInt][3] = 270.0000;
                    BusinessData[i][bizInterior] = 6;

                    BusinessData[i][bizPrices][0] = 75;
                    BusinessData[i][bizPrices][1] = 115;
                    BusinessData[i][bizPrices][2] = 15;
                    BusinessData[i][bizPrices][3] = 95;
                    BusinessData[i][bizPrices][4] = 3;
                    BusinessData[i][bizPrices][5] = 2;
                    BusinessData[i][bizPrices][6] = 10;
                    BusinessData[i][bizPrices][7] = 100;
                    BusinessData[i][bizPrices][8] = 20;
                    BusinessData[i][bizPrices][9] = 10;
                    BusinessData[i][bizPrices][10] = 140;
                    BusinessData[i][bizPrices][11] = 190;
                    BusinessData[i][bizPrices][12] = 150;
                    BusinessData[i][bizPrices][13] = 60;
                    BusinessData[i][bizPrices][14] = 50;
                    BusinessData[i][bizPrices][15] = 5;
                    BusinessData[i][bizPrices][16] = 10;
                    BusinessData[i][bizPrices][17] = 5;
                }
                BusinessData[i][bizExterior] = GetPlayerInterior(playerid);
                BusinessData[i][bizExteriorVW] = GetPlayerVirtualWorld(playerid);

                BusinessData[i][bizLocked] = false;
                BusinessData[i][bizVault] = 0;
                BusinessData[i][bizProducts] = 100;
                BusinessData[i][bizShipment] = 0;

                Business_Refresh(i);
                mysql_tquery(SQL, "INSERT INTO `businesses` (`bizOwner`) VALUES(0)", "OnBusinessCreated", "d", i);
                return i;
            }
        }
    }
    return -1;
}
stock Business_Delete(bizid)
{
    if (bizid != -1 && BusinessData[bizid][bizExists])
    {
        new
            string[82];

        format(string, sizeof(string), "DELETE FROM `businesses` WHERE `bizID` = '%d'", BusinessData[bizid][bizID]);
        mysql_tquery(SQL, string);

        if (IsValidDynamic3DTextLabel(BusinessData[bizid][bizText3D]))
            DestroyDynamic3DTextLabel(BusinessData[bizid][bizText3D]);

        if (IsValidDynamicPickup(BusinessData[bizid][bizPickup]))
            DestroyDynamicPickup(BusinessData[bizid][bizPickup]);


        BusinessData[bizid][bizExists] = false;
        BusinessData[bizid][bizOwner] = 0;
        BusinessData[bizid][bizID] = 0;
    }
    return 1;
}

Business_IsOwner(playerid, bizid)
{
    if (PlayerInfo[playerid][SQLID] == -1)
        return 0;

    if (BusinessData[bizid][bizExists] && BusinessData[bizid][bizOwner] == 99999999 && PlayerInfo[playerid][Staff] > 0)
        return 1;

    if ((BusinessData[bizid][bizExists] && BusinessData[bizid][bizOwner] != 0) && BusinessData[bizid][bizOwner] == PlayerInfo[playerid][SQLID])
        return 1;

    return 0;
}
Business_Inside(playerid)
{
    if (PlayerInfo[playerid][pBiznisID] != -1)
    {
        for (new i = 0; i != MAX_BUSINESS; i ++) if (BusinessData[i][bizExists] && BusinessData[i][bizID] == PlayerInfo[playerid][pBiznisID] && GetPlayerInterior(playerid) == BusinessData[i][bizInterior] && GetPlayerVirtualWorld(playerid) > 0) {
            return i;
        }
    }
    return -1;
}
Business_Dialog(playerid)
{
    Dialog_Show(playerid, dialog_biznis, DIALOG_STYLE_LIST, "Biznis Opcije", "Informacije o biznisu\nOtkljucan/Zakljucaj biznis\nPromeni cenu produkata\nPromeni biznis poruku\nPromeni ime biznisa", "Dalje", "Izlaz");
    return 1;
}

//===========================================================

Dialog:dialog_biznis(const playerid, response, listitem, string:inputtext[])
{
    if(!response)
        return 1;
    if(response)
    {
        switch(listitem)
        {                
            case 0:
            {
                static
                    id = -1;

                if ((id = (Business_Inside(playerid) == -1) ? (Business_Nearest(playerid)) : (Business_Inside(playerid))) != -1 && Business_IsOwner(playerid, id)) {
                    va_SendClientMessage(playerid, x_ltorange,"ID: %d | Business: %s | Products: %d | Vault: %s", id, BusinessData[id][bizName], BusinessData[id][bizProducts], FormatNumber(BusinessData[id][bizVault]));
                }
                else SendClientMessage(playerid, x_ltorange,"You are not in range of your business.");
            }
            case 1:
            {
                static
                    id = -1;
                if (!IsPlayerInAnyVehicle(playerid) && (id = (Business_Inside(playerid) == -1) ? (Business_Nearest(playerid)) : (Business_Inside(playerid))) != -1)
                {
                    if (Business_IsOwner(playerid, id))
                    {
                        if (!BusinessData[id][bizLocked])
                        {
                            BusinessData[id][bizLocked] = true;

                            Business_Refresh(id);
                            Business_Save(id);

                            SendClientMessage(playerid, x_ltorange, "> Zakljucali ste biznis.");
                            PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
                        }
                        else
                        {
                            BusinessData[id][bizLocked] = false;

                            Business_Refresh(id);
                            Business_Save(id);

                            SendClientMessage(playerid, x_ltorange, "> Otkljucali ste biznis.");
                            PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
                        }
                    }
                }
            }
            case 2:
            {
                static
                    id = -1;
                if ((id = Business_Inside(playerid)) != -1 && Business_IsOwner(playerid, id)) {
                    Business_ProductMenu(playerid, id);
                }
                else SendClientMessage(playerid, x_ltorange,"Niste u enterijeru biznisa.");
            }
            case 3:
            {
                static
                    id = -1;

                if ((id = (Business_Inside(playerid) == -1) ? (Business_Nearest(playerid)) : (Business_Inside(playerid))) != -1 && Business_IsOwner(playerid, id))
                {
                    Dialog_Show(playerid, dialog_biznismsg, DIALOG_STYLE_INPUT, "Biznis Poruka:", "Upisite poruku koju zelite da igrac primi kada udjes u vas biznis\n** Upisite 'None' ukoliko zelite da ugasite ovo", "Dallje", "Izlaz");
                }
            }
            case 4:
            {
                static
                    id = -1;

                if ((id = (Business_Inside(playerid) == -1) ? (Business_Nearest(playerid)) : (Business_Inside(playerid))) != -1 && Business_IsOwner(playerid, id))
                {
                    Dialog_Show(playerid, dialog_biznisname, DIALOG_STYLE_INPUT, "Biznis Ime:", "Upisite ime biznisa koje zelite da koristite.", "Dallje", "Izlaz");
                }
            }
        }
    }
    return 1;
}
Dialog:dialog_biznisname(const playerid, response, listitem, string: inputtext[])
{
    if(!response)
        return 1;

    if(response)
    {
        static
            id = -1;

        if ((id = (Business_Inside(playerid) == -1) ? (Business_Nearest(playerid)) : (Business_Inside(playerid))) != -1 && Business_IsOwner(playerid, id))
        {
            if (isnull(inputtext))
                return Dialog_Show(playerid, dialog_biznisname, DIALOG_STYLE_INPUT, "Biznis Ime:", "Upisite ime biznisa koje zelite da koristite.", "Dallje", "Izlaz");

            if (strlen(inputtext) > 32)
                return Dialog_Show(playerid, dialog_biznisname, DIALOG_STYLE_INPUT, "Biznis Ime:", "Upisite ime biznisa koje zelite da koristite\n** NE MOZE VISE OD 32 KARAKTERA.", "Dallje", "Izlaz");

            format(BusinessData[id][bizName], 32, inputtext);

            Business_Refresh(id);
            Business_Save(id);

            va_SendClientMessage(playerid, x_ltorange,"> Business name set to: \"%s\".", inputtext);
        }
    }
    return (true);
}
Dialog:dialog_biznismsg(const playerid, response, listitem, string:inputtext[])
{
    if(!response)
        return 1;
    if(response)
    {
        static
            id = -1;

        if ((id = (Business_Inside(playerid) == -1) ? (Business_Nearest(playerid)) : (Business_Inside(playerid))) != -1 && Business_IsOwner(playerid, id))
        {
            if (isnull(inputtext))
                return Dialog_Show(playerid, dialog_biznismsg, DIALOG_STYLE_INPUT, "Biznis Poruka:", "Upisite poruku koju zelite da igrac primi kada udjes u vas biznis\n** Upisite 'None' ukoliko zelite da ugasite ovo", "Dallje", "Izlaz");

            if (!strcmp(inputtext, "none", true))
            {
                BusinessData[id][bizMessage][0] = '\0';

                Business_Save(id);
                SendClientMessage(playerid, x_ltorange,"> You have removed the business message.");
            }
            else
            {
                format(BusinessData[id][bizMessage], 128, inputtext);

                Business_Save(id);
                va_SendClientMessage(playerid, x_ltorange,"> Business message set to: \"%s\".", inputtext);
            }
        }
    }
    return (true);
}
//===========================================================
stock GetBusinessByID(sqlid)
{
    for (new i = 0; i != MAX_BUSINESSES; i ++) if (BusinessData[i][bizExists] && BusinessData[i][bizID] == sqlid)
        return i;

    return -1;
}
forward OnBusinessCreated(bizid);
public OnBusinessCreated(bizid)
{
    if (bizid == -1 || !BusinessData[bizid][bizExists])
        return 0;

    BusinessData[bizid][bizID] = cache_insert_id();
    Business_Save(bizid);

    return 1;
}
YCMD:kupibiznis(const playerid, params[], help)
{
    new id = Business_Nearest(playerid);

    if(id == -1)
        return SendClientMessage(playerid, x_red,"Pored vas nema ni jedan biznis.");

    if (Business_GetCount(playerid) >= 1)
        return SendClientMessage(playerid, x_red,"Vi mozete posedovati samo 1 biznis.");

    if (BusinessData[id][bizOwner] != 0)
        return SendClientMessage(playerid, x_red,"Ovaj biznis vec ima vlasnika.");

    if (BusinessData[id][bizPrice] > PlayerInfo[playerid][Novac])
        return SendClientMessage(playerid, x_red,"Nemate dovoljno novca.");

    BusinessData[id][bizOwner] = GetPlayerSQLID(playerid);

    Business_Refresh(id);
    Business_Save(id);

    VosticGiveMoney(playerid, -BusinessData[id][bizPrice]);
    va_SendClientMessage(playerid, x_ltorange,"You have purchased \"%s\" for %s!", BusinessData[id][bizName], FormatNumber(BusinessData[id][bizPrice]));

    //ShowPlayerFooter(playerid, "You have ~g~purchased~w~ a business!");
    return (true);
}
YCMD:kupi(const playerid, params[], help)
{
    new id = Business_Inside(playerid);
    if(id == -1)
        return SendClientMessage(playerid, x_red,"Niste unutar biznisa.");


    if (BusinessData[id][bizLocked] != 0 || !BusinessData[id][bizOwner])
            return SendErrorMessage(playerid, "This business is closed!");

    if (BusinessData[id][bizType] == 5) {
        SendClientMessage(playerid, x_red, "Ovde je za auto salon.");
    } else {
        Business_PurchaseMenu(playerid, id);
    }

    return (true);
}
YCMD:biznis(const playerid, params[], help)
{
    static
        biznis = -1;

    if ((biznis = Business_Inside(playerid)) != -1 && Business_IsOwner(playerid, biznis)) {
        Business_Dialog(playerid);
    }
    else SendClientMessage(playerid, x_red,"Niste unutar svog biznisa.");

    return (true);
}