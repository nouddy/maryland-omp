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
 *  @Github         (github.com/vosticdev) & (github.com/nouddy)
 *  @Date           03 Nov 2024
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           functions.pwn
 *  @Module         inventory
*/

#include <ysilib\YSI_Coding\y_hooks>

//*==============================================================================
//*--->>> Functions
//*==============================================================================

new const inv_WeaponModels[47] = {
	0,331,333,
	334,335,336,
	337,338,339,
	341,321,321,
	323,324,325,
	326,342,343,
	344,
	18631,
	18631,
	18631
	,346,347,
	348,349,350,
	351,352,353,
	355,356,372,
	357,358,359,
	360,361,362,
	363,364,365,
	366,367,368,
	369,371	
};

stock Inventory_ReturnItemName(id) {

    new string[50];

    switch(id) {

        case 22..34: { 
            
            new wpn[64+1];
            GetWeaponName(WEAPON:id, wpn, sizeof wpn);
            format(string, sizeof string, "%s", wpn);
        }
        
        case INVENTORY_ITEM_BREAD: { string = "Kruh"; }
        case INVENTORY_ITEM_JUICE: { string = "Sok"; }
        case INVENTORY_ITEM_MEDKIT: { string = "Prva pomoc"; }
        case INVENTORY_ITEM_MILK: { string = "Mlijeko"; }
        case INVENTORY_ITEM_CIGARETTES: { string = "Cigarete"; }
        case INVENTORY_ITEM_LIGHTER: { string = "Upaljac"; }
        case INVENTORY_ITEM_BEER: { string = "Piva"; }
        case INVENTORY_ITEM_CHICKEN_BURGER: { string = "Pileci hamburger"; }
        case INVENTORY_ITEM_HASH: { string = "Marihuana"; }
        case INVENTORY_ITEM_COCAINE: { string = "Kokain"; }
        case INVENTORY_ITEM_MDMA: { string = "MDMA"; }
        case INVENTORY_ITEM_SEED: { string = "Sjeme Trave"; }       
        case INVENTORY_ITEM_HERBS: { string = "Rjetke biljke"; }         
        case INVENTORY_ITEM_GASOLINE: { string = "Benzin"; }  
        case INVENTORY_ITEM_DISTILLED_WATER: { string = "Destilovana voda"; }
        case INVENTORY_ITEM_ALCOHOL: { string = "Alkohol"; }
        case INVENTORY_ITEM_OMEPRAZOLE: { string = "Omerpazol"; }

        default: { string = "Nema"; }
    }

    return string;
}

stock Inventory_GetDrugQuantity(playerid, drug_type = INVENTORY_ITEM_HASH) {

    foreach(new idx : iter_Items[playerid] ) {

        if(InventoryInfo[playerid][idx][ItemID] == drug_type && InventoryInfo[playerid][idx][ItemQuantity] > 0) 
            return InventoryInfo[playerid][idx][ItemQuantity];
    }
    return 0;
}

stock Inventory_GetItemQuantity(playerid, item) {

    foreach(new idx : iter_Items[playerid] ) {

        if(InventoryInfo[playerid][idx][ItemID] == item && InventoryInfo[playerid][idx][ItemQuantity] > 0) {
            return InventoryInfo[playerid][idx][ItemQuantity];
        }
    }
    return 0;
}

stock Inventory_AddItem(playerid, item, quantity) {

    new q[120];
    mysql_format(SQL, q, sizeof q, "SELECT * FROM `inventory` WHERE `PlayerID` = %d AND `ItemID` = %d", GetCharacterSQLID(playerid), item);
    mysql_tquery(MySQL:SQL, q, "mysql_AddInventoryItem", "ddd", playerid, item, quantity);

    return (true);
}

stock Inventory_Remove(playerid, item, quantity) {

    foreach(new idx : iter_Items[playerid]) {

        if(InventoryInfo[playerid][idx][ItemID] == item) {

            new q[360];
            mysql_format(SQL, q, sizeof q, "SELECT * FROM `inventory` WHERE `ItemID` = '%d' AND `PlayerID` = '%d'", InventoryInfo[playerid][idx][ItemID], GetCharacterSQLID(playerid) );
            mysql_tquery(SQL, q, "mysql_CheckRemoveItem", "ddd", playerid, item, quantity);

            break;
        }
    }

    return (true);
}

stock Inventory_IsValidItem(playerid, item) {

    foreach(new idx : iter_Items[playerid]) {

        if(item == InventoryInfo[playerid][idx][ItemID])
            return true;
    }
    return false;
}

stock Inventory_ReturnItemModel(playerid, item) {

    foreach(new idx : iter_Items[playerid]) {

        if(item == InventoryInfo[playerid][idx][ItemID])
        {   
            if(item > INVENTORY_ITEM_BREAD || InventoryInfo[playerid][idx][ItemType] != INVENTORY_ITEM_TYPE_WEAPON)
                return sz_ItemModels[item-50][itemModel];
            else if(InventoryInfo[playerid][idx][ItemType] == INVENTORY_ITEM_TYPE_WEAPON)
                return inv_WeaponModels[item];
        }
    }
    return 18631;
}

stock Container_IsValidItem(item) {

    foreach(new idx : iter_Containers) {

        if(item == ContainerData[idx][containerItem])
            return true;
    }
    return false;
}

stock Container_ReturnItemModel(item) {

    foreach(new idx : iter_Containers) {

        if(item == ContainerData[idx][containerItem])
        {   
            if(item > INVENTORY_ITEM_BREAD || ContainerData[idx][containerItemType] != INVENTORY_ITEM_TYPE_WEAPON)
                return sz_ItemModels[item-50][itemModel];
            else if(ContainerData[idx][containerItemType] == INVENTORY_ITEM_TYPE_WEAPON)
                return inv_WeaponModels[item];
        }
    }
    return 18631;
}

stock Inventory_IsInterfaceActive(playerid) {

    return inventoryShown[playerid];
}

stock Inventory_ResetInterface(playerid) {

    for(new i = 0; i < sizeof Inventory_UI[]; i++) {

        if(Inventory_UI[playerid][i] == INVALID_PLAYER_TEXT_DRAW) continue;

        PlayerTextDrawDestroy(playerid, Inventory_UI[playerid][i]);
        Inventory_UI[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
    }

    for(new i = 0; i < 12; i++) {

        PlayerTextDrawDestroy(playerid, container_item_bg[playerid][i]);
        PlayerTextDrawDestroy(playerid, container_item_title[playerid][i]);
        PlayerTextDrawDestroy(playerid, container_item_model[playerid][i]);
        PlayerTextDrawDestroy(playerid, container_item_quantity[playerid][i]);

        container_item_bg[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
        container_item_title[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
        container_item_model[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
        container_item_quantity[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
    }

    for(new i = 0; i < 12; i++) {
        
        PlayerTextDrawDestroy(playerid, item_bg[playerid][i]);
        PlayerTextDrawDestroy(playerid, item_title[playerid][i]);
        PlayerTextDrawDestroy(playerid, item_model[playerid][i]);
        PlayerTextDrawDestroy(playerid, item_quantity[playerid][i]);

        item_bg[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
        item_title[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
        item_model[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
        item_quantity[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
    }

    inventoryShown[playerid] = false;
    // CancelSelectTextDraw(playerid);
}


stock Inventory_InterfaceControl(playerid, bool:show) {

    if(show) {

        Inventory_ResetInterface(playerid);

        inventoryShown[playerid] = show;

        Inventory_UI[playerid][0] = CreatePlayerTextDraw(playerid, -226.333251, -24.200023, "particle:lamp_shad_64");
        PlayerTextDrawTextSize(playerid, Inventory_UI[playerid][0], 1187.000000, 526.000000);
        PlayerTextDrawAlignment(playerid, Inventory_UI[playerid][0], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Inventory_UI[playerid][0], -2035881985);
        PlayerTextDrawSetShadow(playerid, Inventory_UI[playerid][0], 0);
        PlayerTextDrawBackgroundColour(playerid, Inventory_UI[playerid][0], 255);
        PlayerTextDrawFont(playerid, Inventory_UI[playerid][0], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Inventory_UI[playerid][0], false);

        Inventory_UI[playerid][1] = CreatePlayerTextDraw(playerid, -254.333267, 381.488891, "particle:lamp_shad_64");
        PlayerTextDrawTextSize(playerid, Inventory_UI[playerid][1], 1218.000000, -534.000000);
        PlayerTextDrawAlignment(playerid, Inventory_UI[playerid][1], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Inventory_UI[playerid][1], -2035881985);
        PlayerTextDrawSetShadow(playerid, Inventory_UI[playerid][1], 0);
        PlayerTextDrawBackgroundColour(playerid, Inventory_UI[playerid][1], 255);
        PlayerTextDrawFont(playerid, Inventory_UI[playerid][1], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Inventory_UI[playerid][1], false);


        Inventory_UI[playerid][2] = CreatePlayerTextDraw(playerid, 303.333343, 197.725875, ""); //* Torba
        PlayerTextDrawTextSize(playerid, Inventory_UI[playerid][2], 36.000000, 32.000000);
        PlayerTextDrawAlignment(playerid, Inventory_UI[playerid][2], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Inventory_UI[playerid][2], 141);
        PlayerTextDrawSetShadow(playerid, Inventory_UI[playerid][2], 0);
        PlayerTextDrawBackgroundColour(playerid, Inventory_UI[playerid][2], -256);
        PlayerTextDrawFont(playerid, Inventory_UI[playerid][2], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, Inventory_UI[playerid][2], false);
        PlayerTextDrawSetPreviewModel(playerid, Inventory_UI[playerid][2], 371);
        PlayerTextDrawSetPreviewRot(playerid, Inventory_UI[playerid][2], 0.000000, 0.000000, 0.000000, 0.855057);

        Inventory_UI[playerid][3] = CreatePlayerTextDraw(playerid, 321.333343, 185.437042, "CAPACITY");
        PlayerTextDrawLetterSize(playerid, Inventory_UI[playerid][3], 0.143333, 0.625184);
        PlayerTextDrawAlignment(playerid, Inventory_UI[playerid][3], TEXT_DRAW_ALIGN_CENTRE);
        PlayerTextDrawColour(playerid, Inventory_UI[playerid][3], -1);
        PlayerTextDrawSetShadow(playerid, Inventory_UI[playerid][3], 0);
        PlayerTextDrawBackgroundColour(playerid, Inventory_UI[playerid][3], 255);
        PlayerTextDrawFont(playerid, Inventory_UI[playerid][3], TEXT_DRAW_FONT_1);
        PlayerTextDrawSetProportional(playerid, Inventory_UI[playerid][3], true);

        Inventory_UI[playerid][4] = CreatePlayerTextDraw(playerid, 321.333343, 233.555557, "16_/_100kg");
        PlayerTextDrawLetterSize(playerid, Inventory_UI[playerid][4], 0.143333, 0.625184);
        PlayerTextDrawAlignment(playerid, Inventory_UI[playerid][4], TEXT_DRAW_ALIGN_CENTRE);
        PlayerTextDrawColour(playerid, Inventory_UI[playerid][4], -1);
        PlayerTextDrawSetShadow(playerid, Inventory_UI[playerid][4], 0);
        PlayerTextDrawBackgroundColour(playerid, Inventory_UI[playerid][4], 255);
        PlayerTextDrawFont(playerid, Inventory_UI[playerid][4], TEXT_DRAW_FONT_1);
        PlayerTextDrawSetProportional(playerid, Inventory_UI[playerid][4], true);

        Inventory_UI[playerid][5] = CreatePlayerTextDraw(playerid, 301.666595, 172.422210, "LD_SPAC:white");
        PlayerTextDrawTextSize(playerid, Inventory_UI[playerid][5], 11.000000, 4.000000);
        PlayerTextDrawAlignment(playerid, Inventory_UI[playerid][5], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Inventory_UI[playerid][5], -1);
        PlayerTextDrawSetShadow(playerid, Inventory_UI[playerid][5], 0);
        PlayerTextDrawBackgroundColour(playerid, Inventory_UI[playerid][5], 255);
        PlayerTextDrawFont(playerid, Inventory_UI[playerid][5], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Inventory_UI[playerid][5], false);

        Inventory_UI[playerid][6] = CreatePlayerTextDraw(playerid, 315.333251, 172.422210, "LD_SPAC:white");
        PlayerTextDrawTextSize(playerid, Inventory_UI[playerid][6], 11.000000, 4.000000);
        PlayerTextDrawAlignment(playerid, Inventory_UI[playerid][6], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Inventory_UI[playerid][6], -135);
        PlayerTextDrawSetShadow(playerid, Inventory_UI[playerid][6], 0);
        PlayerTextDrawBackgroundColour(playerid, Inventory_UI[playerid][6], 255);
        PlayerTextDrawFont(playerid, Inventory_UI[playerid][6], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Inventory_UI[playerid][6], false);

        Inventory_UI[playerid][7] = CreatePlayerTextDraw(playerid, 329.333251, 172.422210, "LD_SPAC:white");
        PlayerTextDrawTextSize(playerid, Inventory_UI[playerid][7], 11.000000, 4.000000);
        PlayerTextDrawAlignment(playerid, Inventory_UI[playerid][7], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Inventory_UI[playerid][7], -135);
        PlayerTextDrawSetShadow(playerid, Inventory_UI[playerid][7], 0);
        PlayerTextDrawBackgroundColour(playerid, Inventory_UI[playerid][7], 255);
        PlayerTextDrawFont(playerid, Inventory_UI[playerid][7], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Inventory_UI[playerid][7], false);

        Inventory_UI[playerid][8] = CreatePlayerTextDraw(playerid, 52.666694, 340.007202, "");
        PlayerTextDrawTextSize(playerid, Inventory_UI[playerid][8], 18.000000, 19.000000);
        PlayerTextDrawAlignment(playerid, Inventory_UI[playerid][8], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Inventory_UI[playerid][8], 91);
        PlayerTextDrawSetShadow(playerid, Inventory_UI[playerid][8], 0);
        PlayerTextDrawBackgroundColour(playerid, Inventory_UI[playerid][8], -256);
        PlayerTextDrawFont(playerid, Inventory_UI[playerid][8], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, Inventory_UI[playerid][8], false);
        PlayerTextDrawSetPreviewModel(playerid, Inventory_UI[playerid][8], 1316);
        PlayerTextDrawSetPreviewRot(playerid, Inventory_UI[playerid][8], 90.000000, 0.000000, 0.000000, 1.000000);

        Inventory_UI[playerid][9] = CreatePlayerTextDraw(playerid, 59.766696, 342.236907, "i");
        PlayerTextDrawLetterSize(playerid, Inventory_UI[playerid][9], 0.353999, 1.346963);
        PlayerTextDrawAlignment(playerid, Inventory_UI[playerid][9], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Inventory_UI[playerid][9], -1);
        PlayerTextDrawSetShadow(playerid, Inventory_UI[playerid][9], 0);
        PlayerTextDrawBackgroundColour(playerid, Inventory_UI[playerid][9], 255);
        PlayerTextDrawFont(playerid, Inventory_UI[playerid][9], TEXT_DRAW_FONT_0);
        PlayerTextDrawSetProportional(playerid, Inventory_UI[playerid][9], true);

        Inventory_UI[playerid][10] = CreatePlayerTextDraw(playerid, 71.666656, 345.555603, "Distilled_Water");
        PlayerTextDrawLetterSize(playerid, Inventory_UI[playerid][10], 0.146333, 0.849185);
        PlayerTextDrawAlignment(playerid, Inventory_UI[playerid][10], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Inventory_UI[playerid][10], -1);
        PlayerTextDrawSetShadow(playerid, Inventory_UI[playerid][10], 0);
        PlayerTextDrawBackgroundColour(playerid, Inventory_UI[playerid][10], 255);
        PlayerTextDrawFont(playerid, Inventory_UI[playerid][10], TEXT_DRAW_FONT_1);
        PlayerTextDrawSetProportional(playerid, Inventory_UI[playerid][10], true);

        Inventory_UI[playerid][11] = CreatePlayerTextDraw(playerid, 53.333324, 366.711303, "Description:_Clean_water");
        PlayerTextDrawLetterSize(playerid, Inventory_UI[playerid][11], 0.146333, 0.849185);
        PlayerTextDrawAlignment(playerid, Inventory_UI[playerid][11], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Inventory_UI[playerid][11], -1);
        PlayerTextDrawSetShadow(playerid, Inventory_UI[playerid][11], 0);
        PlayerTextDrawBackgroundColour(playerid, Inventory_UI[playerid][11], 255);
        PlayerTextDrawFont(playerid, Inventory_UI[playerid][11], TEXT_DRAW_FONT_1);
        PlayerTextDrawSetProportional(playerid, Inventory_UI[playerid][11], true);

        Inventory_UI[playerid][12] = CreatePlayerTextDraw(playerid, 53.333324, 377.911346, "Usual_price:_2$");
        PlayerTextDrawLetterSize(playerid, Inventory_UI[playerid][12], 0.146333, 0.849185);
        PlayerTextDrawAlignment(playerid, Inventory_UI[playerid][12], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Inventory_UI[playerid][12], -1);
        PlayerTextDrawSetShadow(playerid, Inventory_UI[playerid][12], 0);
        PlayerTextDrawBackgroundColour(playerid, Inventory_UI[playerid][12], 255);
        PlayerTextDrawFont(playerid, Inventory_UI[playerid][12], TEXT_DRAW_FONT_1);
        PlayerTextDrawSetProportional(playerid, Inventory_UI[playerid][12], true);

        Inventory_UI[playerid][13] = CreatePlayerTextDraw(playerid, 318.666748, 432.252227, "MARYLAND_INVENTORY_FOR_PLAYER");
        PlayerTextDrawLetterSize(playerid, Inventory_UI[playerid][13], 0.124666, 0.633481);
        PlayerTextDrawAlignment(playerid, Inventory_UI[playerid][13], TEXT_DRAW_ALIGN_CENTRE);
        PlayerTextDrawColour(playerid, Inventory_UI[playerid][13], -146);
        PlayerTextDrawSetShadow(playerid, Inventory_UI[playerid][13], 0);
        PlayerTextDrawBackgroundColour(playerid, Inventory_UI[playerid][13], 255);
        PlayerTextDrawFont(playerid, Inventory_UI[playerid][13], TEXT_DRAW_FONT_1);
        PlayerTextDrawSetProportional(playerid, Inventory_UI[playerid][13], true);

        Inventory_UI[playerid][14] = CreatePlayerTextDraw(playerid, 584.333007, 81.318496, "STORAGE");
        PlayerTextDrawLetterSize(playerid, Inventory_UI[playerid][14], 0.229666, 1.077333);
        PlayerTextDrawAlignment(playerid, Inventory_UI[playerid][14], TEXT_DRAW_ALIGN_RIGHT);
        PlayerTextDrawColour(playerid, Inventory_UI[playerid][14], -1);
        PlayerTextDrawSetShadow(playerid, Inventory_UI[playerid][14], 0);
        PlayerTextDrawBackgroundColour(playerid, Inventory_UI[playerid][14], 255);
        PlayerTextDrawFont(playerid, Inventory_UI[playerid][14], TEXT_DRAW_FONT_1);
        PlayerTextDrawSetProportional(playerid, Inventory_UI[playerid][14], true);

        Inventory_UI[playerid][15] = CreatePlayerTextDraw(playerid, 56.666332, 81.318496, "INVENTORY");
        PlayerTextDrawLetterSize(playerid, Inventory_UI[playerid][15], 0.229666, 1.077333);
        PlayerTextDrawAlignment(playerid, Inventory_UI[playerid][15], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Inventory_UI[playerid][15], -1);
        PlayerTextDrawSetShadow(playerid, Inventory_UI[playerid][15], 0);
        PlayerTextDrawBackgroundColour(playerid, Inventory_UI[playerid][15], 255);
        PlayerTextDrawFont(playerid, Inventory_UI[playerid][15], TEXT_DRAW_FONT_1);
        PlayerTextDrawSetProportional(playerid, Inventory_UI[playerid][15], true);


//*--> Items
        for(new i = 0; i < 12; i++) {
            

            new tmp_idx = i;
            new Float:offX = ((i%4)*59.333);
            new Float:offY = floatround(((i/4)*79.229), floatround_floor);

            item_bg[playerid][ tmp_idx ] = CreatePlayerTextDraw(playerid, 39.333267 + offX , 83.237045 + offY, ""); //* 1st item bg
            PlayerTextDrawTextSize(playerid, item_bg[playerid][tmp_idx], 78.000000, 105.000000);
            PlayerTextDrawAlignment(playerid, item_bg[playerid][tmp_idx], TEXT_DRAW_ALIGN_LEFT);
            PlayerTextDrawColour(playerid, item_bg[playerid][tmp_idx], 148);
            PlayerTextDrawSetShadow(playerid, item_bg[playerid][tmp_idx], 0);
            PlayerTextDrawBackgroundColour(playerid, item_bg[playerid][tmp_idx], -256);
            PlayerTextDrawFont(playerid, item_bg[playerid][tmp_idx], TEXT_DRAW_FONT_MODEL_PREVIEW);
            PlayerTextDrawSetProportional(playerid, item_bg[playerid][tmp_idx], false);
            PlayerTextDrawSetPreviewModel(playerid, item_bg[playerid][tmp_idx], 2731);
            PlayerTextDrawSetPreviewRot(playerid, item_bg[playerid][tmp_idx], 0.000000, 0.000000, 0.000000, 1.000000);

            new index = InventoryInfo[playerid][tmp_idx][ItemID];

            new tmp_str[64];

            item_title[playerid][tmp_idx] = CreatePlayerTextDraw(playerid, 78.666656 + offX, 105.792587 + offY, Inventory_ReturnItemName(index)); //* 1ST ITEM TITLE
            PlayerTextDrawLetterSize(playerid, item_title[playerid][tmp_idx], 0.114999, 0.608592);
            PlayerTextDrawAlignment(playerid, item_title[playerid][tmp_idx], TEXT_DRAW_ALIGN_CENTRE);
            PlayerTextDrawColour(playerid, item_title[playerid][tmp_idx], -1);
            PlayerTextDrawSetShadow(playerid, item_title[playerid][tmp_idx], 0);
            PlayerTextDrawBackgroundColour(playerid, item_title[playerid][tmp_idx], 255);
            PlayerTextDrawFont(playerid, item_title[playerid][tmp_idx], TEXT_DRAW_FONT_1);
            PlayerTextDrawSetProportional(playerid, item_title[playerid][tmp_idx], true);

            item_model[playerid][tmp_idx] = CreatePlayerTextDraw(playerid, 64.666671 + offX, 118.911109 + offY, ""); //* 1st item model
            PlayerTextDrawTextSize(playerid, item_model[playerid][tmp_idx], 30.000000, 33.000000);
            PlayerTextDrawAlignment(playerid, item_model[playerid][tmp_idx], TEXT_DRAW_ALIGN_LEFT);
            PlayerTextDrawColour(playerid, item_model[playerid][tmp_idx], -1);
            PlayerTextDrawSetShadow(playerid, item_model[playerid][tmp_idx], 0);
            PlayerTextDrawBackgroundColour(playerid, item_model[playerid][tmp_idx], -256);
            PlayerTextDrawFont(playerid, item_model[playerid][tmp_idx], TEXT_DRAW_FONT_MODEL_PREVIEW);
            PlayerTextDrawSetProportional(playerid, item_model[playerid][tmp_idx], false);
            PlayerTextDrawSetPreviewModel(playerid, item_model[playerid][tmp_idx], Inventory_ReturnItemModel(playerid, index));
            PlayerTextDrawSetPreviewRot(playerid, item_model[playerid][tmp_idx], 0.000000, 0.000000, 0.000000, 1.000000);
            PlayerTextDrawSetSelectable(playerid, item_model[playerid][tmp_idx], bool:Inventory_IsValidItem(playerid, index));

            format(tmp_str, sizeof tmp_str, "%d", InventoryInfo[playerid][tmp_idx][ItemQuantity]);

            item_quantity[playerid][tmp_idx] = CreatePlayerTextDraw(playerid, 98.333358 + offX , 154.325942 + offY, tmp_str); // * 1ST Item quantity
            PlayerTextDrawLetterSize(playerid, item_quantity[playerid][tmp_idx], 0.199666, 1.110518);
            PlayerTextDrawAlignment(playerid, item_quantity[playerid][tmp_idx], TEXT_DRAW_ALIGN_RIGHT);
            PlayerTextDrawColour(playerid, item_quantity[playerid][tmp_idx], -1);
            PlayerTextDrawSetShadow(playerid, item_quantity[playerid][tmp_idx], 0);
            PlayerTextDrawBackgroundColour(playerid, item_quantity[playerid][tmp_idx], 255);
            PlayerTextDrawFont(playerid, item_quantity[playerid][tmp_idx], TEXT_DRAW_FONT_1);
            PlayerTextDrawSetProportional(playerid, item_quantity[playerid][tmp_idx], true);

            PlayerTextDrawShow(playerid, item_bg[playerid][ tmp_idx ]);
            PlayerTextDrawShow(playerid, item_title[playerid][ tmp_idx ]);
            PlayerTextDrawShow(playerid, item_model[playerid][ tmp_idx ]);
            PlayerTextDrawShow(playerid, item_quantity[playerid][ tmp_idx ]);
        }

        Container_CreateInterface(playerid);

        SelectTextDraw(playerid, x_server);


        for(new i = 0; i < sizeof Inventory_UI[]; i++) {

            if(Inventory_UI[playerid][i] == INVALID_PLAYER_TEXT_DRAW) continue;
            PlayerTextDrawShow(playerid, Inventory_UI[playerid][i]);
        }
    }


    else {

        Inventory_ResetInterface(playerid);
        CancelSelectTextDraw(playerid);
    }
}

stock Container_CreateInterface(playerid) {

    new cID[12];
    // Container_GeatNearestToPlayer(playerid, cID);
    if(GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)
        Container_GeatNearestToPlayer(playerid, cID);
    else  
        Container_GetItems(playerid, cID);

    new floorItems[12];

    for(new i = 0; i < 12; i++) {

        if(cID[i] == INVALID_CONTAINER_ID) continue;

        floorItems[i] = INVENTORY_INVALID_ITEM_TYPE;

        new tmp_idx = i;
        new Float:offX = ((i%4)*59.333) + 308.334;
        new Float:offY = floatround(((i/4)*79.229), floatround_floor);
        new tmp_str[64];

        new index = ContainerData[cID[i]][containerItem];
    
        if(floorItems[i] == index) continue;

        floorItems[i] = index;

        container_item_bg[playerid][ tmp_idx ] = CreatePlayerTextDraw(playerid, 39.333267 + offX , 83.237045 + offY, ""); //* 1st item bg
        PlayerTextDrawTextSize(playerid, container_item_bg[playerid][tmp_idx], 78.000000, 105.000000);
        PlayerTextDrawAlignment(playerid, container_item_bg[playerid][tmp_idx], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, container_item_bg[playerid][tmp_idx], 148);
        PlayerTextDrawSetShadow(playerid, container_item_bg[playerid][tmp_idx], 0);
        PlayerTextDrawBackgroundColour(playerid, container_item_bg[playerid][tmp_idx], -256);
        PlayerTextDrawFont(playerid, container_item_bg[playerid][tmp_idx], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, container_item_bg[playerid][tmp_idx], false);
        PlayerTextDrawSetPreviewModel(playerid, container_item_bg[playerid][tmp_idx], 2731);
        PlayerTextDrawSetPreviewRot(playerid, container_item_bg[playerid][tmp_idx], 0.000000, 0.000000, 0.000000, 1.000000);

        container_item_title[playerid][tmp_idx] = CreatePlayerTextDraw(playerid, 78.666656 + offX, 105.792587 + offY, Inventory_ReturnItemName(index)); //* 1ST ITEM TITLE
        PlayerTextDrawLetterSize(playerid, container_item_title[playerid][tmp_idx], 0.114999, 0.608592);
        PlayerTextDrawAlignment(playerid, container_item_title[playerid][tmp_idx], TEXT_DRAW_ALIGN_CENTRE);
        PlayerTextDrawColour(playerid, container_item_title[playerid][tmp_idx], -1);
        PlayerTextDrawSetShadow(playerid, container_item_title[playerid][tmp_idx], 0);
        PlayerTextDrawBackgroundColour(playerid, container_item_title[playerid][tmp_idx], 255);
        PlayerTextDrawFont(playerid, container_item_title[playerid][tmp_idx], TEXT_DRAW_FONT_1);
        PlayerTextDrawSetProportional(playerid, container_item_title[playerid][tmp_idx], true);

        container_item_model[playerid][tmp_idx] = CreatePlayerTextDraw(playerid, 64.666671 + offX, 118.911109 + offY, ""); //* 1st item model
        PlayerTextDrawTextSize(playerid, container_item_model[playerid][tmp_idx], 30.000000, 33.000000);
        PlayerTextDrawAlignment(playerid, container_item_model[playerid][tmp_idx], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, container_item_model[playerid][tmp_idx], -1);
        PlayerTextDrawSetShadow(playerid, container_item_model[playerid][tmp_idx], 0);
        PlayerTextDrawBackgroundColour(playerid, container_item_model[playerid][tmp_idx], -256);
        PlayerTextDrawFont(playerid, container_item_model[playerid][tmp_idx], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, container_item_model[playerid][tmp_idx], false);
        PlayerTextDrawSetPreviewModel(playerid, container_item_model[playerid][tmp_idx], Container_ReturnItemModel(index));
        PlayerTextDrawSetPreviewRot(playerid, container_item_model[playerid][tmp_idx], 0.000000, 0.000000, 0.000000, 1.000000);
        PlayerTextDrawSetSelectable(playerid, container_item_model[playerid][tmp_idx], bool:Container_IsValidItem(index));

        format(tmp_str, sizeof tmp_str, "%d", ContainerData[cID[i]][containerItemQuantity]);

        container_item_quantity[playerid][tmp_idx] = CreatePlayerTextDraw(playerid, 98.333358 + offX , 154.325942 + offY,  tmp_str); // * 1ST Item quantity
        PlayerTextDrawLetterSize(playerid, container_item_quantity[playerid][tmp_idx], 0.199666, 1.110518);
        PlayerTextDrawAlignment(playerid, container_item_quantity[playerid][tmp_idx], TEXT_DRAW_ALIGN_RIGHT);
        PlayerTextDrawColour(playerid, container_item_quantity[playerid][tmp_idx], -1);
        PlayerTextDrawSetShadow(playerid, container_item_quantity[playerid][tmp_idx], 0);
        PlayerTextDrawBackgroundColour(playerid, container_item_quantity[playerid][tmp_idx], 255);
        PlayerTextDrawFont(playerid, container_item_quantity[playerid][tmp_idx], TEXT_DRAW_FONT_1);
        PlayerTextDrawSetProportional(playerid, container_item_quantity[playerid][tmp_idx], true);

        PlayerTextDrawShow(playerid, container_item_bg[playerid][ tmp_idx ]);
        PlayerTextDrawShow(playerid, container_item_title[playerid][ tmp_idx ]);
        PlayerTextDrawShow(playerid, container_item_model[playerid][ tmp_idx ]);
        PlayerTextDrawShow(playerid, container_item_quantity[playerid][ tmp_idx ]);
    }
}

stock Container_GeatNearestToPlayer(playerid, containers[], containers_size = sizeof containers) {

    new count = 0;

    for(new i = 0; i < containers_size; i++) {

        containers[i] = INVALID_CONTAINER_ID;
    }

    foreach(new i : iter_Containers) {
        //* INVALID_PROPERTY_ID - because dropped objects does not have an owner so SQL ID does not exists.
        if(ContainerData[i][containerPropID] == INVALID_PROPERTY_ID && ContainerData[i][containerType] == CONTAINER_TYPE_FLOOR) {

            if(IsPlayerInRangeOfPoint(playerid, 3.50, ContainerData[i][containerPos][0], ContainerData[i][containerPos][1], ContainerData[i][containerPos][2]))
            {
                if(count >= containers_size)
                    break;

                containers[count] = i;
                count++;
            }
        }
    }

    return count;
}

stock Container_GetItems(playerid, containers[], containers_size = sizeof containers) {

    new count = 0;

    for(new i = 0; i < containers_size; i++) {

        containers[i] = INVALID_CONTAINER_ID;
    }

    foreach(new i : iter_Containers) {
        //* INVALID_PROPERTY_ID - because dropped objects does not have an owner so SQL ID does not exists.
        if(ContainerData[i][containerPropID] != INVALID_PROPERTY_ID && ContainerData[i][containerType] != CONTAINER_TYPE_FLOOR) {

            new Float:pPos[3];

            if(ContainerData[i][containerType] == CONTAINER_TYPE_WARDROBE) {

                foreach(new j : iHouse) {

                    if(player_House[playerid] == house_ID[j]) {

                        pPos[0] = house_Wardrobe[j][0];
                        pPos[1] = house_Wardrobe[j][1];
                        pPos[2] = house_Wardrobe[j][2];
                        break;
                    }
                }
            }

            if(IsPlayerInRangeOfPoint(playerid, 3.50, pPos[0], pPos[1], pPos[2]) && ContainerData[i][containerPropID] == GetPlayerVirtualWorld(playerid))
            {
                if(count >= containers_size)
                    break;

                containers[count] = i;
                count++;
            }
        }
    }

    return count;
}

/*

* if(count >= containers_size)
*     break;
* 
* containers[count] = i;
* count++;

*/