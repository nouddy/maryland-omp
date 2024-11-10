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
 *  @File           main.pwn
 *  @Module         inventory
 */

#include <ysilib\YSI_Coding\y_hooks>

//* Useful as fuck

//PlayerTextDrawSetProportional\((.*),(.*), 1\);
//PlayerTextDrawSetProportional($1, $2, true);

stock Weapon_IsValid(weaponid)
{
	return (weaponid >= 1 && weaponid <= 18 || weaponid >= 21 && weaponid <= 46);
}

//*==============================================================================
//*--->>> Begining
//*==============================================================================

new PlayerText:Inventory_UI[MAX_PLAYERS][16],
    bool:inventoryShown[MAX_PLAYERS];

//*     >> [ ITEM TYPES ] <<

#define MAX_INVENTORY_ITEMS     (12) //* Igrac ce moci posjedovati najvise 35 stvari u inventory-u

#define MAX_AMMO_QUANTITY       (90) //* Igrac ce moci shraniti 90 metaka u inventory za svaku pusku.

#define MAX_P_CONTAINERS      (1000)

#define INVALID_PROPERTY_ID     (0)
#define INVALID_CONTAINER_ID   (-1)

enum e_CONTAINER_TYPE {

    CONTAINER_TYPE_INVALID = 0,
    CONTAINER_TYPE_TRUNK = 1,
    CONTAINER_TYPE_WARDROBE,
    CONTAINER_TYPE_FLOOR
}

enum e_CONTAINER_INFO {

    containerID,
    containerPropID,
    e_CONTAINER_TYPE:containerType,
    containerItem,
    containerItemType,
    containerItemQuantity,
    containerModel,

    Float:containerPos[3] // * Only used for dropped items
}

new ContainerData[MAX_P_CONTAINERS][e_CONTAINER_INFO],
    Iterator:iter_Containers<MAX_P_CONTAINERS>,
    Text3D:containerLabel[MAX_P_CONTAINERS],
    containerObject[MAX_P_CONTAINERS];

enum {

    INVENTORY_INVALID_ITEM_TYPE = -1,

    INVENTORY_ITEM_TYPE_DRUG = 1,
    INVENTORY_ITEM_TYPE_FOOD,
    INVENTORY_ITEM_TYPE_WEAPON,
    INVENTORY_ITEM_TYPE_NORMAL,
    INVENTORY_ITEM_TYPE_DRUG_PREP
}

//*     >> [ INVENTORY ITEMS ] <<
//* ID-evi krecu od 50 (zbog oruzja);

enum {

    INVALID_INVENTORY_ITEM = -1,

    INVENTORY_ITEM_BREAD = 50,
    INVENTORY_ITEM_JUICE,
    INVENTORY_ITEM_MEDKIT,
    INVENTORY_ITEM_MILK,
    INVENTORY_ITEM_CIGARETTES,
    INVENTORY_ITEM_LIGHTER,
    INVENTORY_ITEM_BEER,
    INVENTORY_ITEM_CHICKEN_BURGER,
    INVENTORY_ITEM_HASH,        // 58
    INVENTORY_ITEM_COCAINE,     // 59
    INVENTORY_ITEM_MDMA,       // 60

    //*     >> [ DRUG PREP ITEMS ] <<

    INVENTORY_ITEM_SEED,            //* Samo za travu
    INVENTORY_ITEM_HERBS,           //* Za Cocaine
    INVENTORY_ITEM_GASOLINE,        //* Za Cocaine
    INVENTORY_ITEM_DISTILLED_WATER, //* Za MDMU i Cocaine
    INVENTORY_ITEM_ALCOHOL,         //* Za MDMU
    INVENTORY_ITEM_OMEPRAZOLE       //* Za MDMU
}

enum e_QUANTITY_DATA {

    itemID,
    maxQuantity
}

enum e_ITEM_TYPE_DATA {

    itemID,
    itemType
}

enum e_INVENTORY_INFO {

    PlayerID,
    ItemID,
    ItemQuantity,
    ItemType,
}

//*==============================================================================
//?--->>> Vars
//*==============================================================================

new InventoryInfo[MAX_PLAYERS][MAX_INVENTORY_ITEMS][e_INVENTORY_INFO];
new Iterator:iter_Items[MAX_PLAYERS]< MAX_INVENTORY_ITEMS >;
static inventory_ChosenItem[MAX_PLAYERS];

new PlayerText:item_bg[MAX_PLAYERS][ 12 ],
            PlayerText:item_title[MAX_PLAYERS][ 12 ],
            PlayerText:item_model[MAX_PLAYERS][ 12 ],
            PlayerText:item_quantity[MAX_PLAYERS][ 12 ],
            PlayerText:container_item_bg[MAX_PLAYERS][ 12 ],
            PlayerText:container_item_title[MAX_PLAYERS][ 12 ],
            PlayerText:container_item_model[MAX_PLAYERS][ 12 ],
            PlayerText:container_item_quantity[MAX_PLAYERS][ 12 ];

//* Odredjivanje maksimalne kolicine jednog itema u rancu, npr. 5 sokica mozete shraniti u inventar.

// * Prop Items tmp.

new tmp_propItem[MAX_PLAYERS][12],
    tmp_propItemType[MAX_PLAYERS][12],
    tmp_propItemQuantity[MAX_PLAYERS][12];

new const sz_quantityInfo[][e_QUANTITY_DATA] = {

    { INVENTORY_ITEM_BREAD,             10 },
    { INVENTORY_ITEM_JUICE,             5 },
    { INVENTORY_ITEM_MEDKIT,            1 },
    { INVENTORY_ITEM_MILK,              4 },
    { INVENTORY_ITEM_CIGARETTES,        2 },
    { INVENTORY_ITEM_LIGHTER,           2 },
    { INVENTORY_ITEM_BEER,              5 },
    { INVENTORY_ITEM_CHICKEN_BURGER,    3 },
    { INVENTORY_ITEM_HASH,              100},
    { INVENTORY_ITEM_COCAINE,            50},
    { INVENTORY_ITEM_MDMA,               75},
    { INVENTORY_ITEM_SEED,               10},
    { INVENTORY_ITEM_HERBS,              15},
    { INVENTORY_ITEM_GASOLINE,            3},
    { INVENTORY_ITEM_DISTILLED_WATER,     2},
    { INVENTORY_ITEM_ALCOHOL,             1},
    { INVENTORY_ITEM_OMEPRAZOLE,         50}
};

new const sz_itemType[][e_ITEM_TYPE_DATA] = {

    { INVENTORY_ITEM_BREAD,             INVENTORY_ITEM_TYPE_FOOD },
    { INVENTORY_ITEM_JUICE,             INVENTORY_ITEM_TYPE_FOOD },
    { INVENTORY_ITEM_MEDKIT,            INVENTORY_ITEM_TYPE_NORMAL },
    { INVENTORY_ITEM_MILK,              INVENTORY_ITEM_TYPE_FOOD },
    { INVENTORY_ITEM_CIGARETTES,        INVENTORY_ITEM_TYPE_NORMAL },
    { INVENTORY_ITEM_LIGHTER,           INVENTORY_ITEM_TYPE_NORMAL },
    { INVENTORY_ITEM_BEER,              INVENTORY_ITEM_TYPE_FOOD },
    { INVENTORY_ITEM_CHICKEN_BURGER,    INVENTORY_ITEM_TYPE_FOOD },
    { INVENTORY_ITEM_HASH,              INVENTORY_ITEM_TYPE_DRUG },
    { INVENTORY_ITEM_COCAINE,           INVENTORY_ITEM_TYPE_DRUG },
    { INVENTORY_ITEM_MDMA,              INVENTORY_ITEM_TYPE_DRUG },
    { INVENTORY_ITEM_SEED,              INVENTORY_ITEM_TYPE_DRUG_PREP },
    { INVENTORY_ITEM_HERBS,             INVENTORY_ITEM_TYPE_DRUG_PREP },
    { INVENTORY_ITEM_GASOLINE,          INVENTORY_ITEM_TYPE_DRUG_PREP },
    { INVENTORY_ITEM_DISTILLED_WATER,   INVENTORY_ITEM_TYPE_DRUG_PREP },
    { INVENTORY_ITEM_ALCOHOL,           INVENTORY_ITEM_TYPE_DRUG_PREP },
    { INVENTORY_ITEM_OMEPRAZOLE,        INVENTORY_ITEM_TYPE_DRUG_PREP }

};

enum e_ITEM_MODEL_DATA {

    itemID,
    itemModel
}

new const sz_ItemModels[][e_ITEM_MODEL_DATA] = {

    { INVENTORY_ITEM_BREAD,             19579 },
    { INVENTORY_ITEM_JUICE,             19564 },
    { INVENTORY_ITEM_MEDKIT,            11736 },
    { INVENTORY_ITEM_MILK,              19570 },
    { INVENTORY_ITEM_CIGARETTES,        19897 },
    { INVENTORY_ITEM_LIGHTER,           19998 },
    { INVENTORY_ITEM_BEER,              1544 },
    { INVENTORY_ITEM_CHICKEN_BURGER,    19811 },
    { INVENTORY_ITEM_HASH,              1279 },
    { INVENTORY_ITEM_COCAINE,           1575 },
    { INVENTORY_ITEM_MDMA,              1580 },
    { INVENTORY_ITEM_SEED,              19573 },
    { INVENTORY_ITEM_HERBS,             2972 },
    { INVENTORY_ITEM_GASOLINE,          1650 },
    { INVENTORY_ITEM_DISTILLED_WATER,   19570 },
    { INVENTORY_ITEM_ALCOHOL,           19570 },
    { INVENTORY_ITEM_OMEPRAZOLE,        1241 }
};

//*==============================================================================
//?--->>> MySQL Querys
//*==============================================================================

forward mysql_LoadContainerData();
public mysql_LoadContainerData() {

    new rows = cache_num_rows();

    if(!rows) return print("No containers loaded.");

    for(new i = 0; i < rows; i++) {

        cache_get_value_name_int(i, "ID", ContainerData[i][containerID]);
        cache_get_value_name_int(i, "propID", ContainerData[i][containerPropID]);
        cache_get_value_name_int(i, "Type", ContainerData[i][containerType]);
        cache_get_value_name_int(i, "Item", ContainerData[i][containerItem]);
        cache_get_value_name_int(i, "ItemType", ContainerData[i][containerItemType]);
        cache_get_value_name_int(i, "Quantity", ContainerData[i][containerItemQuantity]);
        cache_get_value_name_int(i, "Model", ContainerData[i][containerModel]);

        cache_get_value_name_float(i, "posX", ContainerData[i][containerPos][0]);
        cache_get_value_name_float(i, "posY", ContainerData[i][containerPos][1]);
        cache_get_value_name_float(i, "posZ", ContainerData[i][containerPos][2]);

        Iter_Add(iter_Containers, i);

        if(ContainerData[i][containerPos][0] != 0.00) {
            
            new tmp_str[128];
            format(tmp_str, sizeof tmp_str, ""c_server"\187; "c_white"%s "c_server"\171;\n"c_server"\187; "c_white"[ N ]"c_server" \171;", Inventory_ReturnItemName( ContainerData[i][containerItem]));

            containerLabel[i] = Create3DTextLabel(tmp_str, -1, ContainerData[i][containerPos][0], ContainerData[i][containerPos][1], ContainerData[i][containerPos][2], 
                                                          4.50, 0);
            containerObject[i] = CreateObject(ContainerData[i][containerModel], ContainerData[i][containerPos][0], ContainerData[i][containerPos][1], ContainerData[i][containerPos][2], 
                                              0.00, 0.00, 0.00, 45.00);
        }
    }

    return true;
}

forward mysql_CheckPlayerInventory(character);
public mysql_CheckPlayerInventory(character) {

    new rows = cache_num_rows();

    if(!rows) return SendClientMessage(character, -1, "DEBUG: Inventory for CharacterSQLID : %d is empty!", GetCharacterSQLID(character));


    for(new i = 0; i < rows; i++) {

        cache_get_value_name_int(i, "PlayerID", InventoryInfo[character][i][PlayerID]);
        cache_get_value_name_int(i, "ItemID", InventoryInfo[character][i][ItemID]);
        cache_get_value_name_int(i, "ItemQuantity", InventoryInfo[character][i][ItemQuantity]);
        cache_get_value_name_int(i, "ItemType", InventoryInfo[character][i][ItemType]);

        Iter_Add(iter_Items[character], i);
    }

    return (true);
}

// LoadWardrobeItemsForPlayer

forward LoadWardrobeItemsForPlayer(playerid);
public LoadWardrobeItemsForPlayer(playerid) {

    new rows = cache_num_rows();

    if(!rows) return true;

    for(new i = 0; i < rows; i++) {

        cache_get_value_name_int(i, "Item", tmp_propItem[playerid][i]);
        cache_get_value_name_int(i, "ItemType", tmp_propItemType[playerid][i]);
        cache_get_value_name_int(i, "Quantity",tmp_propItemQuantity[playerid][i]);

    }

    return (true);
}

forward mysql_CreateContainer(cID);
public mysql_CreateContainer(cID) {

    ContainerData[cID][containerID] = cache_insert_id();

    Iter_Add(iter_Containers, cID);

    new tmp_str[128];
    format(tmp_str, sizeof tmp_str, ""c_server"\187; "c_white"%s "c_server"\171;\n"c_server"\187; "c_white"[ N ]"c_server" \171;", Inventory_ReturnItemName( ContainerData[cID][containerItem]));

    containerLabel[cID] = Create3DTextLabel(tmp_str, -1, ContainerData[cID][containerPos][0], ContainerData[cID][containerPos][1], ContainerData[cID][containerPos][2], 
                                                          4.50, 0);
    containerObject[cID] = CreateObject(ContainerData[cID][containerModel], ContainerData[cID][containerPos][0], ContainerData[cID][containerPos][1], ContainerData[cID][containerPos][2], 
                                              0.00, 0.00, 0.00, 45.00);

    return true;
}

forward mysql_CheckRemoveItem(playerid, item, quantity);
public mysql_CheckRemoveItem(playerid, item, quantity) {

    new rows = cache_num_rows();

    if(rows) {

        foreach(new idx : iter_Items[playerid]) {

            if(InventoryInfo[playerid][idx][ItemID] == item) {

                if( ( InventoryInfo[playerid][idx][ItemQuantity] - quantity ) <= 0 ) {

                    new q[128];
                    mysql_format(SQL, q, sizeof q, "DELETE FROM `inventory` WHERE `ItemID` = '%d' AND `PlayerID` = '%d'", InventoryInfo[playerid][idx][ItemID], GetCharacterSQLID(playerid));
                    mysql_tquery(SQL, q);
                    return (true);
                }

                InventoryInfo[playerid][idx][ItemQuantity]--;

                new _q[128];
                mysql_format(SQL, _q, sizeof _q, "UPDATE `inventory` SET `ItemQuantity` = '%d' WHERE `ItemID` = '%d' AND `PlayerID` = '%d'", InventoryInfo[playerid][idx][ItemQuantity], InventoryInfo[playerid][idx][ItemID], GetCharacterSQLID(playerid));
                mysql_tquery(SQL, _q);

                break;
            }
        }
    }

    return (true);
}

forward mysql_AddInventoryItem(playerid, item, quantity);
public mysql_AddInventoryItem(playerid, item, quantity) {

    new rows = cache_num_rows();
    if(!rows) {

        new xType;

        if(Weapon_IsValid(item))
            xType = INVENTORY_ITEM_TYPE_WEAPON;
        else    
            xType = sz_itemType[item-50][itemType];

        new q[240];
        mysql_format(SQL, q, sizeof q, "INSERT INTO `inventory` (`PlayerID`, `ItemID`, `ItemQuantity`, `ItemType`) \
                                        VALUES (%d, %d, %d, %d)",
                                        GetCharacterSQLID(playerid), item,
                                        quantity, xType);
        mysql_tquery(SQL, q);

        new nextID = Iter_Free(iter_Items[playerid]);
        
        InventoryInfo[playerid][nextID][PlayerID] = GetCharacterSQLID(playerid);
        InventoryInfo[playerid][nextID][ItemID] = item;
        InventoryInfo[playerid][nextID][ItemQuantity] = quantity;
        InventoryInfo[playerid][nextID][ItemType] = xType;

        Iter_Add(iter_Items[playerid], nextID);

        //Inventory_InterfaceControl(playerid, true);

        // printf("PlayerID - %d, ItemID - %d, ItemQuantity - %d, ItemType - %s", playerid, item, quantity, Inventory_ReturnItemName(item) );
        // printf("Array ID - %d", nextID);

        // SendClientMessage(playerid, 0xdaa520ff, "> Postavljen vam je item : %s, kolicina %d", Inventory_ReturnItemName(item), quantity);

    }

    else {

        new xQuantity, xItem;
        cache_get_value_name_int(0, "ItemID", xItem);
        cache_get_value_name_int(0, "ItemQuantity", xQuantity);

        foreach(new idx : iter_Items[playerid]) {

            if(InventoryInfo[playerid][idx][ItemID] == item) {

                if( ( xQuantity + quantity ) > sz_quantityInfo[xItem-50][maxQuantity] ) {

                    InventoryInfo[playerid][idx][ItemQuantity] = sz_quantityInfo[xItem-50][maxQuantity];
                }

                else {

                    InventoryInfo[playerid][idx][ItemQuantity] += quantity;
                }

                new q[360];
                mysql_format(SQL, q, sizeof q, "UPDATE `inventory` SET `ItemQuantity` = '%d' WHERE `PlayerID` = '%d'", InventoryInfo[playerid][idx][ItemQuantity], GetCharacterSQLID(playerid) );
                mysql_tquery(SQL, q);
            }
        }

        // Inventory_InterfaceControl(playerid, true);
    }

    return (true);
}


//*==============================================================================
//?--->>> Hooks
//*==============================================================================

hook OnGameModeInit() {

    mysql_tquery(SQL, "SELECT * FROM `inv_containers`", "mysql_LoadContainerData");

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnCharacterLoaded(playerid) {

    new q[124];
    mysql_format(MySQL:SQL, q, sizeof q, "SELECT * FROM `inventory` WHERE `PlayerID` = %d LIMIT 12", GetCharacterSQLID(playerid));
    mysql_tquery(MySQL:SQL, q, "mysql_CheckPlayerInventory", "d", playerid);

    // mysql_format(SQL, q, sizeof q, "SELECT * FROM `inv_containers` WHERE 'propID' = '%d' LIMIT 12", GetCharacterHouse(playerid));
    // mysql_tquery(SQL, q, "LoadWardrobeItemsForPlayer", "d", playerid);

    Inventory_ResetInterface(playerid);

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerDisconnect(playerid, reason) {

    Inventory_ResetInterface(playerid);

    return Y_HOOKS_CONTINUE_RETURN_1;
}

//*==============================================================================
//?--->>> Commands
//*==============================================================================

YCMD:inventory(playerid, params[], help) {

    if(!Inventory_IsInterfaceActive(playerid)) {

        TogglePlayerTextDraw(playerid, false);
        ToggleGlobalTextDraw(playerid, false);
        Inventory_InterfaceControl(playerid, true);
        return Y_HOOKS_CONTINUE_RETURN_1;
    }

    else {

        Inventory_InterfaceControl(playerid, false);
        TogglePlayerTextDraw(playerid, true);
        ToggleGlobalTextDraw(playerid, true);
        PlayerTextDraw_UpdateModel(playerid, Player_TDs[playerid][1], GetPlayerSkin(playerid));
    }

    return 1;
}

YCMD:giveitem(playerid, params[], help) 
{
    
    if(help) {

        SendClientMessage(playerid, 0xdaa520ff, "> 50. Bread  |  51. Juice  | 52. Medkit");
    }
    new item, quantity;
    if(sscanf(params, "dd", item, quantity)) return SendClientMessage(playerid, 0xdaa520ff, "> /giveitem [ItemID] [Kolicina].");

    new q[120];
    mysql_format(SQL, q, sizeof q, "SELECT * FROM `inventory` WHERE `PlayerID` = %d AND `ItemID` = %d", GetCharacterSQLID(playerid), item);
    mysql_tquery(MySQL:SQL, q, "mysql_AddInventoryItem", "ddd", playerid, item, quantity);

    return (true);
}


YCMD:itemlist(playerid, params[], help) {

    if(GetPlayerStaffLevel(playerid) < 1)
        return true;

    new _dialogStr[1945];
    new stringicc[256];

    for(new i = 0; i < sizeof sz_quantityInfo; i++) {

        format(stringicc, sizeof stringicc, ""c_server"\187; "c_white"%s [%d]       Max Quantity : %d\n", Inventory_ReturnItemName(sz_quantityInfo[i][itemID]), sz_quantityInfo[i][itemID], sz_quantityInfo[i][maxQuantity] );
        strcat(_dialogStr, stringicc);
    }

    Dialog_Show(playerid, "_noreturn", DIALOG_STYLE_MSGBOX, "Inventory Items", _dialogStr, "Ok", "");

    return (true);
}

YCMD:putgun(playerid, params[], help) 
{
    
    new ammo;

    if(sscanf(params, "d", ammo)) 
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"/putgun [Kolicina]");

    if(GetPlayerWeapon(playerid) == WEAPON_FIST) 
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Oruzje vam mora biti u ruci!");

    if(!Weapon_IsValid( GetPlayerWeapon(playerid) )) 
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Ovo oruzje ne mozete shraniti u inventar!");

    if(ammo < 0 || ammo > GetPlayerAmmo(playerid))
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Kolicina municije ne moze biti manja od nula ili veca od postojece!");

    //* Posto mi je matematika ravna nuli (kad su govorili uci dino sad se jebi)
    //* Ukoliko igrac hoce da ostavi 80 metaka, a puska vec ima 67, maksimalni limit je 90, onda ce mu se nadodati na to samo 23 ( 67 + 23 ) == 90 
    //* To znaci da, ce mu ostati 57 ( 80 - 23 ) == 57, sto znaci da je formula za ovo sranje
    //* MAX_INVENTORY_AMMO (90) - currentAmmo (67) == 23, newAmmo = inputAmmo(80) - 23 = 57.
    //* Bolje bi mi bilo da sam kanale kopo 

    new xWeapon = GetPlayerWeapon(playerid);

    new wpn[32+1];
    GetWeaponName(GetPlayerWeapon(playerid), wpn, sizeof wpn);

    new bool:weaponFound = false;

    foreach(new i : iter_Items[playerid]) {

        if(InventoryInfo[playerid][i][ItemID] == xWeapon) {
            
            weaponFound = true;

            if(InventoryInfo[playerid][i][ItemQuantity] >= MAX_AMMO_QUANTITY)
                return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Vec posjedujete maksimalnu kolicinu municije za ovo oruzje!");

            if( ( ammo + InventoryInfo[playerid][i][ItemQuantity] >= MAX_AMMO_QUANTITY ) ) {

                new oldAmmo = ( MAX_AMMO_QUANTITY - InventoryInfo[playerid][i][ItemQuantity] );

                SetPlayerAmmo(playerid, GetPlayerWeapon(playerid), 0);
                GivePlayerWeapon(playerid, WEAPON:xWeapon, ( ammo - oldAmmo )); //* El Fatiha
                SendClientMessage(playerid, x_server, "maryland \187; "c_white"Preostalo vam je %d municije za %s", ( ammo - oldAmmo ), wpn );

                InventoryInfo[playerid][i][ItemQuantity] = MAX_AMMO_QUANTITY;

                printf("DEBUG: Player has %s weapon with %d ammo", wpn, GetPlayerAmmo(playerid));
                printf("DEBUG: New ammo quantity is %d", InventoryInfo[playerid][i][ItemQuantity]);

                new q[128];
                mysql_format(MySQL:SQL, q, sizeof q, "UPDATE `inventory` SET `ItemQuantity` = '%d' WHERE `PlayerID` = '%d' AND `ItemID` = '%d'", 
                                                    InventoryInfo[playerid][i][ItemQuantity],  GetCharacterSQLID(playerid), InventoryInfo[playerid][i][ItemID]);
                mysql_tquery(SQL, q);
                return 1;
            }

            else {


                InventoryInfo[playerid][i][ItemQuantity] += ammo;
                SetPlayerAmmo(playerid, GetPlayerWeapon(playerid), ( GetPlayerAmmo(playerid) - ammo) );

                SendClientMessage(playerid, x_server, "maryland \187; "c_white"Uspjesno ste ostavili %d municije za %s", ammo, wpn );

                new q[128];
                mysql_format(MySQL:SQL, q, sizeof q, "UPDATE `inventory` SET `ItemQuantity` = '%d' WHERE `PlayerID` = '%d' AND `ItemID` = '%d'", 
                                                    InventoryInfo[playerid][i][ItemQuantity],  GetCharacterSQLID(playerid), InventoryInfo[playerid][i][ItemID]);
                mysql_tquery(SQL, q);
                return 1;

            }
        }
    }

    if(!weaponFound) 
    {
        SetPlayerAmmo(playerid, GetPlayerWeapon(playerid), ( GetPlayerAmmo(playerid) - ammo) );

        new q[120];
        mysql_format(SQL, q, sizeof q, "SELECT * FROM `inventory` WHERE `PlayerID` = %d AND `ItemID` = %d",  GetCharacterSQLID(playerid), xWeapon);
        mysql_tquery(MySQL:SQL, q, "mysql_AddInventoryItem", "ddd", playerid, xWeapon, ammo);
        return 1;
    }

    return 1;
}

//*==============================================================================
//?--->>> Dialogs
//*==============================================================================

// Dialog:inventoryDialog(const playerid, response, listitem, string: inputtext[]) {
//     if (!response) return true;

//     inventory_ChosenItem[playerid] = Iter_Index(iter_Items[playerid], listitem);

//     Dialog_Show(playerid, "inventoryItemOption", DIALOG_STYLE_LIST, "{ff006f}INVENTORY", "Iskoristi\nBaci\nDaj Igracu", "Odaberi", "Odustani");
//     return true;
// }


Dialog:inventoryItemOption(const playerid, response, listitem, string: inputtext[]) {
    if (!response) {

        inventory_ChosenItem[playerid] = INVALID_INVENTORY_ITEM;

        return true;
    }

    switch(listitem) {

        case 0: {

            new tmp_id = inventory_ChosenItem[playerid];

            if(InventoryInfo[playerid][tmp_id][ItemType] == INVENTORY_ITEM_TYPE_FOOD) {

                if(InventoryInfo[playerid][tmp_id][ItemQuantity] == 1) {

                    new Float:Health;
                    GetPlayerHealth(playerid, Health);
                    
                    if(Health == 100.00) 
                        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Ne mozete iskoristiti ovaj item, health vam je pun.");

                    else if( ( Health + 25.00 )  > 100.00)
                        SetPlayerHealth(playerid, 100.00);
                    
                    else {

                        SetPlayerHealth(playerid, ( Health + 25.00 ) );
                        SendClientMessage(playerid, x_server, "maryland \187; "c_white"%s vam je regenerirao helth za 25.00 vise.", Inventory_ReturnItemName(InventoryInfo[playerid][tmp_id][ItemID]));
                    }

                    InventoryInfo[playerid][tmp_id][ItemQuantity]--;

                    new q[128];
                    mysql_format(SQL, q, sizeof q, "DELETE FROM `inventory` WHERE `ItemID` = '%d' AND `PlayerID` = '%d'", 
                                                    InventoryInfo[playerid][tmp_id][ItemID],  GetCharacterSQLID(playerid));
                    mysql_tquery(SQL, q);

                    Iter_Remove(iter_Items[playerid], tmp_id);

                    InventoryInfo[playerid][tmp_id][ItemID] = INVALID_INVENTORY_ITEM; 
                    InventoryInfo[playerid][tmp_id][ItemQuantity] = 0;
                    InventoryInfo[playerid][tmp_id][ItemType] = INVENTORY_INVALID_ITEM_TYPE;

                    Inventory_InterfaceControl(playerid, true);

                    inventory_ChosenItem[playerid] = INVALID_INVENTORY_ITEM;

                    return (true);
                }

                new Float:xHealth;
                GetPlayerHealth(playerid, xHealth);
                
                if( ( xHealth + 25.00 ) > 100.00)
                    SetPlayerHealth(playerid, 100.00);
                
                else {

                    SetPlayerHealth(playerid, ( xHealth + 25.00 ) );
                    SendClientMessage(playerid, x_server, "maryland \187; "c_white"%s vam je regenerirao helth za 25.00 vise.", Inventory_ReturnItemName(InventoryInfo[playerid][tmp_id][ItemID]));
                }

                InventoryInfo[playerid][tmp_id][ItemQuantity]--;

                new q[128];
                mysql_format(SQL, q, sizeof q, "UPDATE `inventory` SET `ItemQuantity` = '%d' WHERE `ItemID` = '%d' AND `PlayerID` = '%d'", 
                                                InventoryInfo[playerid][tmp_id][ItemQuantity], InventoryInfo[playerid][tmp_id][ItemID],  GetCharacterSQLID(playerid));
                mysql_tquery(SQL, q);

                Inventory_InterfaceControl(playerid, true);
            }

            else if(InventoryInfo[playerid][tmp_id][ItemType] == INVENTORY_ITEM_TYPE_WEAPON) 
                Dialog_Show(playerid, "inventoryTakeGun", DIALOG_STYLE_INPUT, "{ff006f}TakeGun", "Unesite zeljenu kolicinu metaka za %s\n Trenutna kolicina : {ff006f}%d/%d", "Unesi", "Odustani", 
                                      Inventory_ReturnItemName(InventoryInfo[playerid][tmp_id][ItemID]),
                                      InventoryInfo[playerid][tmp_id][ItemQuantity], MAX_AMMO_QUANTITY
                );
        }

        case 1: {

            new tmp_id = inventory_ChosenItem[playerid];

            new q[246];

            SendClientMessage(playerid, x_server, "maryland \187; "c_white"Uspjesno si bacio %s.", Inventory_ReturnItemName(InventoryInfo[playerid][tmp_id][ItemID]));

            mysql_format(MySQL:SQL, q, sizeof(q), "DELETE FROM `inventory` WHERE `PlayerID` = %d AND `ItemID` = %d",  GetCharacterSQLID(playerid), InventoryInfo[playerid][tmp_id][ItemID]);
            mysql_tquery(SQL, q); 

            Inventory_InterfaceControl(playerid, true);

            new cID = Iter_Free(iter_Containers);

            ContainerData[cID][containerPropID] = INVALID_PROPERTY_ID;
            ContainerData[cID][containerType] = CONTAINER_TYPE_FLOOR;
            ContainerData[cID][containerItem] = InventoryInfo[playerid][tmp_id][ItemID];
            ContainerData[cID][containerItemType] = InventoryInfo[playerid][tmp_id][ItemType];
            ContainerData[cID][containerItemQuantity] = InventoryInfo[playerid][tmp_id][ItemQuantity];
            ContainerData[cID][containerModel] = Inventory_ReturnItemModel(playerid, InventoryInfo[playerid][tmp_id][ItemID]);

            new Float:pPos[3];
            GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);

            ContainerData[cID][containerPos][0] = pPos[0];
            ContainerData[cID][containerPos][1] = pPos[1];
            ContainerData[cID][containerPos][2] = pPos[2]-1.1;

            mysql_format(SQL, q, sizeof q, "INSERT INTO `inv_containers` (`Type`, `Item`, `ItemType`, `Quantity`, `Model`, `posX`, `posY`, `posZ`) \
                                            VALUES ('%d', '%d', '%d', '%d', '%d', '%f', '%f', '%f')",
                                            ContainerData[cID][containerType], ContainerData[cID][containerItem], 
                                            ContainerData[cID][containerItemType], ContainerData[cID][containerItemQuantity],
                                            ContainerData[cID][containerModel], ContainerData[cID][containerPos][0],
                                            ContainerData[cID][containerPos][1], ContainerData[cID][containerPos][2]);
            mysql_tquery(SQL, q, "mysql_CreateContainer", "d", cID);


            InventoryInfo[playerid][tmp_id][ItemID] = INVALID_INVENTORY_ITEM; 
            InventoryInfo[playerid][tmp_id][ItemQuantity] = 0;
            InventoryInfo[playerid][tmp_id][ItemType] = INVENTORY_INVALID_ITEM_TYPE;

            inventory_ChosenItem[playerid] = INVALID_INVENTORY_ITEM;

            Iter_Remove(iter_Items[playerid], tmp_id);

            Inventory_InterfaceControl(playerid, true);

        }

        case 2: {
            
            //* Trade igracu

            return (true);
        }
    }

    return true;
}

Dialog:inventoryTakeGun(const playerid, response, listitem, string: inputtext[]) {
    if (!response) { 

        inventory_ChosenItem[playerid] = INVALID_INVENTORY_ITEM;

        return true;
    }

    new tmp_id = inventory_ChosenItem[playerid], ammo;

    if(sscanf(inputtext, "d", ammo)) return  Dialog_Show(playerid, "inventoryTakeGun", DIALOG_STYLE_INPUT, "{ff006f}Takegun", "Unesite zeljenu kolicinu metaka za %s\n Trenutna kolicina : {ff006f}%d/%d", "Unesi", "Odustani", 
                                                                    Inventory_ReturnItemName(InventoryInfo[playerid][tmp_id][ItemID]),
                                                                    InventoryInfo[playerid][tmp_id][ItemQuantity], MAX_AMMO_QUANTITY
                                            );

    if(ammo < 0 || ammo > InventoryInfo[playerid][tmp_id][ItemQuantity]) return Dialog_Show(playerid, "inventoryTakeGun", DIALOG_STYLE_INPUT, "{ff006f}TakeGun", "Unesite zeljenu kolicinu metaka za %s\n Trenutna kolicina : {ff006f}%d/%d", "Unesi", "Odustani", 
                                                                                                        Inventory_ReturnItemName(InventoryInfo[playerid][tmp_id][ItemID]),
                                                                                                        InventoryInfo[playerid][tmp_id][ItemQuantity], MAX_AMMO_QUANTITY
                                                                                );

    if(InventoryInfo[playerid][tmp_id][ItemQuantity] == ammo) {

        GivePlayerWeapon(playerid, WEAPON:InventoryInfo[playerid][tmp_id][ItemID], ammo);
        SendClientMessage(playerid, x_server, "maryland \187; "c_white"Uzeli ste %s sa %d municije.", Inventory_ReturnItemName(InventoryInfo[playerid][tmp_id][ItemID]), ammo);

        new q[128];
        mysql_format(SQL, q, sizeof q, "DELETE FROM `inventory` WHERE `ItemID` = '%d' AND `PlayerID` = '%d'", 
                                        InventoryInfo[playerid][tmp_id][ItemID],  GetCharacterSQLID(playerid));
        mysql_tquery(SQL, q);

        Iter_Remove(iter_Items[playerid], tmp_id);

        InventoryInfo[playerid][tmp_id][ItemID] = INVALID_INVENTORY_ITEM; 
        InventoryInfo[playerid][tmp_id][ItemQuantity] = 0;
        InventoryInfo[playerid][tmp_id][ItemType] = INVENTORY_INVALID_ITEM_TYPE;

        Inventory_InterfaceControl(playerid, true);

        inventory_ChosenItem[playerid] = INVALID_INVENTORY_ITEM;
        return (true);
    }

    InventoryInfo[playerid][tmp_id][ItemQuantity]-= ammo;

    GivePlayerWeapon(playerid, WEAPON:InventoryInfo[playerid][tmp_id][ItemID], ammo);
    SendClientMessage(playerid, x_server, "maryland \187; "c_white"Uzeli ste %s sa %d municije.", Inventory_ReturnItemName(InventoryInfo[playerid][tmp_id][ItemID]), ammo);

    new q[240];

    mysql_format(SQL, q, sizeof q, "UPDATE `inventory` SET `ItemQuantity` = '%d' WHERE `ItemID` = '%d' AND `PlayerID` = '%d'", 
                                    InventoryInfo[playerid][tmp_id][ItemQuantity], InventoryInfo[playerid][tmp_id][ItemID],
                                     GetCharacterSQLID(playerid));
    mysql_tquery(SQL, q);

    return true;
}

hook OnPlayerClickTextDraw(playerid, Text:clickedid) {

    if(!Inventory_IsInterfaceActive(playerid)) 
        return Y_HOOKS_CONTINUE_RETURN_1;

    if(clickedid == INVALID_TEXT_DRAW) {

        Inventory_ResetInterface(playerid);
        Inventory_InterfaceControl(playerid, false);
        TogglePlayerTextDraw(playerid, true);
        ToggleGlobalTextDraw(playerid, true);
        return Y_HOOKS_BREAK_RETURN_1;
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys) {

    if(PRESSED(KEY_NO)) {

        new cID[12];
        new containerCount = Container_GeatNearestToPlayer(playerid, cID);
        if(containerCount == 0) return Y_HOOKS_CONTINUE_RETURN_1;

        new tmp_item = ContainerData[cID[0]][containerItem];

        new tmp_sum = Inventory_GetItemQuantity(playerid, tmp_item) + tmp_item;

        if(ContainerData[cID[0]][containerItemType] != INVENTORY_ITEM_TYPE_WEAPON) {

            if( tmp_sum >= sz_quantityInfo[ tmp_item - 50 ][maxQuantity]) {

                new tmp_quantity = sz_quantityInfo[ tmp_item - 50 ][maxQuantity] - Inventory_GetItemQuantity(playerid, tmp_item);

                Inventory_AddItem(playerid, ContainerData[cID[0]][containerItem], tmp_quantity);
                ContainerData[cID[0]][containerItemQuantity] -= tmp_quantity;

                new q[248];
                mysql_format(SQL, q, sizeof q, "UPDATE `inv_containers` SET `Quantity` = '%d' WHERE `Item` = '%d' AND `ID` = '%d'",
                                                ContainerData[tmp_item][containerItemQuantity], ContainerData[cID[0]][containerItem], ContainerData[cID[0]][containerID]);
                mysql_tquery(SQL, q);

                if(ContainerData[cID[0]][containerItemQuantity] == 0) {

                    mysql_format(SQL, q, sizeof q, "DELETE FROM `inv_containers` WHERE `Item` = '%d' AND `ID` = '%d'",
                                        ContainerData[cID[0]][containerItem], ContainerData[cID[0]][containerID]);
                    mysql_tquery(SQL, q);
                }

                return Y_HOOKS_BREAK_RETURN_1;
            }

            if(Inventory_GetItemQuantity(playerid, tmp_item) >= sz_quantityInfo[ tmp_item - 50 ][maxQuantity])
                    return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Ne mozete pokupiti ovaj item, vec imate maksimalnu kolicinu istog!");

        }

        Inventory_AddItem(playerid, ContainerData[cID[0]][containerItem], ContainerData[cID[0]][containerItemQuantity]);
        SendClientMessage(playerid, x_server, "maryland \187; "c_white"Pokupili ste %s sa poda", Inventory_ReturnItemName(ContainerData[cID[0]][containerItem]));

        new q[248];
        mysql_format(SQL, q, sizeof q, "DELETE FROM `inv_containers` WHERE `Item` = '%d' AND `ID` = '%d'",
                                        ContainerData[cID[0]][containerItem], ContainerData[cID[0]][containerID]);
        mysql_tquery(SQL, q);

        DestroyObject(containerObject[cID[0]]);
        Delete3DTextLabel(containerLabel[cID[0]]);

        ContainerData[cID[0]][containerType] = CONTAINER_TYPE_INVALID;
        ContainerData[cID[0]][containerItem] = INVALID_INVENTORY_ITEM;
        ContainerData[cID[0]][containerItemType] = INVENTORY_INVALID_ITEM_TYPE;
        ContainerData[cID[0]][containerItemQuantity] = 0;
        ContainerData[cID[0]][containerModel] = 0;
        ContainerData[cID[0]][containerPos][0] = 0.00;
        ContainerData[cID[0]][containerPos][1] = 0.00;
        ContainerData[cID[0]][containerPos][2] = 0.00;

        Iter_Remove(iter_Containers, cID[0]);
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid) {

    if(!Inventory_IsInterfaceActive(playerid)) 
        return Y_HOOKS_CONTINUE_RETURN_1;

    for(new i = 0; i < 12; i++) {

        if(playertextid == item_model[playerid][i]) {

            inventory_ChosenItem[playerid] = Iter_Index(iter_Items[playerid], i);

            new tmp_str[64];
            format(tmp_str, sizeof tmp_str, "{737be1}INVENTORY \187; {FFFFFF}%s", Inventory_ReturnItemName(InventoryInfo[playerid][inventory_ChosenItem[playerid]][ItemID]));
            Dialog_Show(playerid, "inventoryItemOption", DIALOG_STYLE_LIST, tmp_str, "Iskoristi\nBaci\nDaj Igracu", "Odaberi", "Odustani");

            return Y_HOOKS_BREAK_RETURN_1;
        }

        if(playertextid == container_item_model[playerid][i]) {

            //* Tmp fix for wardrobe - cleanup later...
            if(GetPlayerInterior(playerid) != 0) {

                foreach(new j : iHouse) {

                    if(player_House[playerid] == house_ID[j]) {

                        if(IsPlayerInRangeOfPoint(playerid, 3.50, house_Wardrobe[j][0], house_Wardrobe[j][1], house_Wardrobe[j][2])) {

                            foreach(new k : iter_Containers) {
                                
                                if(ContainerData[k][containerPropID] != player_House[playerid]) continue;

                                new tdModel = PlayerTextDrawGetPreviewModel(playerid, container_item_model[playerid][i]);

                                if(sz_ItemModels[ ContainerData[k][containerItem] - 50 ][itemModel] == tdModel) {
                                    
                                    new tmp_item = ContainerData[k][containerItem];

                                    new tmp_sum = Inventory_GetItemQuantity(playerid, tmp_item) + ContainerData[k][containerItemQuantity];

                                    if(ContainerData[k][containerItemType] != INVENTORY_ITEM_TYPE_WEAPON) {

                                        if( tmp_sum >= sz_quantityInfo[ tmp_item - 50 ][maxQuantity]) {

                                            new tmp_quantity = sz_quantityInfo[ tmp_item - 50 ][maxQuantity] - Inventory_GetItemQuantity(playerid, tmp_item);

                                            Inventory_AddItem(playerid, ContainerData[k][containerItem], tmp_quantity);
                                            ContainerData[k][containerItemQuantity] -= tmp_quantity;

                                            new q[248];
                                            mysql_format(SQL, q, sizeof q, "UPDATE `inv_containers` SET `Quantity` = '%d' WHERE `Item` = '%d' AND `ID` = '%d'",
                                                                            ContainerData[k][containerItemQuantity], ContainerData[k][containerItem], ContainerData[k][containerID]);
                                            mysql_tquery(SQL, q);

                                            if(ContainerData[k][containerItemQuantity] == 0) {

                                                mysql_format(SQL, q, sizeof q, "DELETE FROM `inv_containers` WHERE `ID` = '%d'",
                                                                    ContainerData[k][containerID]);
                                                mysql_tquery(SQL, q);

                                                DestroyObject(containerObject[k]);
                                                Delete3DTextLabel(containerLabel[k]);

                                                ContainerData[k][containerType] = CONTAINER_TYPE_INVALID;
                                                ContainerData[k][containerItem] = INVALID_INVENTORY_ITEM;
                                                ContainerData[k][containerItemType] = INVENTORY_INVALID_ITEM_TYPE;
                                                ContainerData[k][containerItemQuantity] = 0;
                                                ContainerData[k][containerModel] = 0;
                                                ContainerData[k][containerPos][0] = 0.00;
                                                ContainerData[k][containerPos][1] = 0.00;
                                                ContainerData[k][containerPos][2] = 0.00;

                                                Iter_Remove(iter_Containers, k);
                                            }

                                            Inventory_InterfaceControl(playerid, true);
                                            return Y_HOOKS_BREAK_RETURN_1;
                                        }

                                        if(Inventory_GetItemQuantity(playerid, tmp_item) >= sz_quantityInfo[ tmp_item - 50 ][maxQuantity])
                                            return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Ne mozete uzeti ovaj item, vec imate maksimalnu kolicinu istog!");
                                    }

                                    Inventory_AddItem(playerid, ContainerData[k][containerItem], ContainerData[k][containerItemQuantity]);
                                    SendClientMessage(playerid, x_server, "maryland \187; "c_white"Uezli ste %s iz ormana", Inventory_ReturnItemName(ContainerData[k][containerItem]));

                                    new q[248];
                                    mysql_format(SQL, q, sizeof q, "DELETE FROM `inv_containers` WHERE `ID` = '%d'",
                                                                    ContainerData[k][containerID]);
                                    mysql_tquery(SQL, q);

                                    ContainerData[k][containerType] = CONTAINER_TYPE_INVALID;
                                    ContainerData[k][containerItem] = INVALID_INVENTORY_ITEM;
                                    ContainerData[k][containerItemType] = INVENTORY_INVALID_ITEM_TYPE;
                                    ContainerData[k][containerItemQuantity] = 0;
                                    ContainerData[k][containerModel] = 0;
                                    ContainerData[k][containerPos][0] = 0.00;
                                    ContainerData[k][containerPos][1] = 0.00;
                                    ContainerData[k][containerPos][2] = 0.00;
                                    Inventory_InterfaceControl(playerid, true);
                                    Iter_Remove(iter_Containers, k);
                                    break;
                                }
                            }
                        }
                        break;
                    }
                }

                return Y_HOOKS_BREAK_RETURN_1;
            }

            new chosen_ContainerItem = Iter_Index(iter_Containers, i);

            new tmp_item = ContainerData[chosen_ContainerItem][containerItem];

            new tmp_sum = Inventory_GetItemQuantity(playerid, tmp_item) + ContainerData[chosen_ContainerItem][containerItemQuantity];

            if(ContainerData[chosen_ContainerItem][containerItemType] != INVENTORY_ITEM_TYPE_WEAPON) {


                if( tmp_sum >= sz_quantityInfo[ tmp_item - 50 ][maxQuantity]) {

                    new tmp_quantity = sz_quantityInfo[ tmp_item - 50 ][maxQuantity] - Inventory_GetItemQuantity(playerid, tmp_item);

                    Inventory_AddItem(playerid, ContainerData[chosen_ContainerItem][containerItem], tmp_quantity);
                    ContainerData[chosen_ContainerItem][containerItemQuantity] -= tmp_quantity;

                    new q[248];
                    mysql_format(SQL, q, sizeof q, "UPDATE `inv_containers` SET `Quantity` = '%d' WHERE `Item` = '%d' AND `ID` = '%d'",
                                                    ContainerData[chosen_ContainerItem][containerItemQuantity], ContainerData[chosen_ContainerItem][containerItem], ContainerData[chosen_ContainerItem][containerID]);
                    mysql_tquery(SQL, q);

                    if(ContainerData[chosen_ContainerItem][containerItemQuantity] == 0) {


                        mysql_format(SQL, q, sizeof q, "DELETE FROM `inv_containers` WHERE `Item` = '%d' AND `ID` = '%d'",
                                            ContainerData[chosen_ContainerItem][containerItem], ContainerData[chosen_ContainerItem][containerID]);
                        mysql_tquery(SQL, q);
                    }
                    return Y_HOOKS_BREAK_RETURN_1;
                }

                if(Inventory_GetItemQuantity(playerid, tmp_item) >= sz_quantityInfo[ tmp_item - 50 ][maxQuantity])
                    return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Ne mozete pokupiti ovaj item, vec imate maksimalnu kolicinu istog!");
            }

            Inventory_AddItem(playerid, ContainerData[chosen_ContainerItem][containerItem], ContainerData[chosen_ContainerItem][containerItemQuantity]);
            SendClientMessage(playerid, x_server, "maryland \187; "c_white"Pokupili ste %s sa poda", Inventory_ReturnItemName(ContainerData[chosen_ContainerItem][containerItem]));

            new q[248];
            mysql_format(SQL, q, sizeof q, "DELETE FROM `inv_containers` WHERE `Item` = '%d' AND `ID` = '%d'",
                                            ContainerData[chosen_ContainerItem][containerItem], ContainerData[chosen_ContainerItem][containerID]);
            mysql_tquery(SQL, q);

            DestroyObject(containerObject[chosen_ContainerItem]);
            Delete3DTextLabel(containerLabel[chosen_ContainerItem]);

            ContainerData[chosen_ContainerItem][containerType] = CONTAINER_TYPE_INVALID;
            ContainerData[chosen_ContainerItem][containerItem] = INVALID_INVENTORY_ITEM;
            ContainerData[chosen_ContainerItem][containerItemType] = INVENTORY_INVALID_ITEM_TYPE;
            ContainerData[chosen_ContainerItem][containerItemQuantity] = 0;
            ContainerData[chosen_ContainerItem][containerModel] = 0;
            ContainerData[chosen_ContainerItem][containerPos][0] = 0.00;
            ContainerData[chosen_ContainerItem][containerPos][1] = 0.00;
            ContainerData[chosen_ContainerItem][containerPos][2] = 0.00;

            Iter_Remove(iter_Containers, chosen_ContainerItem);

            return Y_HOOKS_BREAK_RETURN_1;
            
        }
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}