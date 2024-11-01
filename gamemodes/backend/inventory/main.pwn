/*

*  _____  ______ _      _____          _   _ _______   _____  _____   ____       _ ______ _____ _______ 
* |  __ \|  ____| |    |_   _|   /\   | \ | |__   __| |  __ \|  __ \ / __ \     | |  ____/ ____|__   __|
* | |__) | |__  | |      | |    /  \  |  \| |  | |    | |__) | |__) | |  | |    | | |__ | |       | |   
* |  _  /|  __| | |      | |   / /\ \ | . ` |  | |    |  ___/|  _  /| |  | |_   | |  __|| |       | |   
* | | \ \| |____| |____ _| |_ / ____ \| |\  |  | |    | |    | | \ \| |__| | |__| | |___| |____   | |   
* |_|  \_\______|______|_____/_/    \_\_| \_|  |_|    |_|    |_|  \_\\____/ \____/|______\_____|  |_|   
*

*   @Author : Noddy
*   @Date : 7.13.2024

*/

#include <ysilib\YSI_Coding\y_hooks>

//*     >> [ ITEM TYPES ] <<

#define MAX_INVENTORY_ITEMS     (35) //* Igrac ce moci posjedovati najvise 35 stvari u inventory-u

#define MAX_AMMO_QUANTITY       (90) //* Igrac ce moci shraniti 90 metaka u inventory za svaku pusku.

enum {

    INVENTORY_INVALID_ITEM_TYPE = -1,

    INVENTORY_ITEM_TYPE_DRUG = 1,
    INVENTORY_ITEM_TYPE_WEAPON,
    INVENTORY_ITEM_TYPE_NORMAL,
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
    INVENTORY_ITEM_MARIJUANA,
    INVENTORY_ITEM_KOKAIN,
    INVENTORY_ITEM_MDMA
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

new InventoryInfo[MAX_PLAYERS][MAX_INVENTORY_ITEMS][e_INVENTORY_INFO];
new Iterator:iter_Items[MAX_PLAYERS]< MAX_INVENTORY_ITEMS >;

//* Odredjivanje maksimalne kolicine jednog itema u rancu, npr. 5 sokica mozete shraniti u inventar.

new const sz_quantityInfo[][e_QUANTITY_DATA] = {

    { INVENTORY_ITEM_BREAD,             10 },
    { INVENTORY_ITEM_JUICE,             5 },
    { INVENTORY_ITEM_MEDKIT,            1 },
    { INVENTORY_ITEM_MILK,              4 },
    { INVENTORY_ITEM_CIGARETTES,        2 },
    { INVENTORY_ITEM_LIGHTER,           2 },
    { INVENTORY_ITEM_BEER,              5 },
    { INVENTORY_ITEM_CHICKEN_BURGER,    3 },
    { INVENTORY_ITEM_MARIJUANA,         100},
    { INVENTORY_ITEM_KOKAIN,            50},
    { INVENTORY_ITEM_MDMA,              75}
};

new const sz_itemType[][e_ITEM_TYPE_DATA] = {

    { INVENTORY_ITEM_BREAD,             INVENTORY_ITEM_TYPE_NORMAL },
    { INVENTORY_ITEM_JUICE,             INVENTORY_ITEM_TYPE_NORMAL },
    { INVENTORY_ITEM_MEDKIT,            INVENTORY_ITEM_TYPE_NORMAL },
    { INVENTORY_ITEM_MILK,              INVENTORY_ITEM_TYPE_NORMAL },
    { INVENTORY_ITEM_CIGARETTES,        INVENTORY_ITEM_TYPE_NORMAL },
    { INVENTORY_ITEM_LIGHTER,           INVENTORY_ITEM_TYPE_NORMAL },
    { INVENTORY_ITEM_BEER,              INVENTORY_ITEM_TYPE_NORMAL },
    { INVENTORY_ITEM_CHICKEN_BURGER,    INVENTORY_ITEM_TYPE_NORMAL },
    { INVENTORY_ITEM_MARIJUANA,         INVENTORY_ITEM_TYPE_DRUG},
    { INVENTORY_ITEM_KOKAIN,         INVENTORY_ITEM_TYPE_DRUG},
    { INVENTORY_ITEM_MDMA,         INVENTORY_ITEM_TYPE_DRUG}

};

forward mysql_CheckPlayerInventory(character);
public mysql_CheckPlayerInventory(character) {

    new rows = cache_num_rows();

    if(!rows) return true;

    else {

        for(new i = 0; i < rows; i++) {

            cache_get_value_name_int(i, "PlayerID", InventoryInfo[character][i][PlayerID]);
            cache_get_value_name_int(i, "ItemID", InventoryInfo[character][i][ItemID]);
            cache_get_value_name_int(i, "ItemQuantity", InventoryInfo[character][i][ItemQuantity]);
            cache_get_value_name_int(i, "ItemType", InventoryInfo[character][i][ItemType]);

            Iter_Add(iter_Items[character], i);
        }
    }

    return (true);
}

forward mysql_AddInventoryItem(playerid, item, quantity);
public mysql_AddInventoryItem(playerid, item, quantity) {

    new rows = cache_num_rows();
    if(!rows) {

        new q[240];
        mysql_format(SQL, q, sizeof q, "INSERT INTO `inventory` (`PlayerID`, `ItemID`, `ItemQuantity`, `ItemType`) \
                                        VALUES (%d, %d, %d, %d)",
                                        GetCharacterSQLID(playerid), item,
                                        quantity, sz_itemType[item-50][itemType]);
        mysql_tquery(SQL, q);

        new nextID = Iter_Free(iter_Items[playerid]);
        
        InventoryInfo[playerid][nextID][PlayerID] = GetCharacterSQLID(playerid);
        InventoryInfo[playerid][nextID][ItemID] = item;
        InventoryInfo[playerid][nextID][ItemQuantity] = quantity;
        InventoryInfo[playerid][nextID][ItemType] = sz_itemType[item-50][itemType];

        Iter_Add(iter_Items[playerid], nextID);

        printf("PlayerID - %d, ItemID - %d, ItemQuantity - %d, ItemType - %s", playerid, item, quantity, Inventory_ReturnItemName(item) );
        printf("Array ID - %d", nextID);

        SendClientMessage(playerid, 0xdaa520ff, "> Postavljen vam je item : %s, kolicina %d", Inventory_ReturnItemName(item), quantity);

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
    }

    return (true);
}

forward mysql_LoadPlayerInventory(playerid);
public mysql_LoadPlayerInventory(playerid) {

    new rows = cache_num_rows();

    if(!rows) return SendClientMessage(playerid, 0xdaa520ff, "> Nemate ni jednog itema...");

    else {

        new _dialogStr[1945];
        new stringicc[256];

        for(new i = 0; i < rows; i++) {
    
            new xItem, xQuantity;

            cache_get_value_name_int(i, "ItemID", xItem);
            cache_get_value_name_int(i, "ItemQuantity", xQuantity);

            format(stringicc, sizeof stringicc, "%s -> Kolicina : %d/%d\n", Inventory_ReturnItemName(xItem), xQuantity, sz_quantityInfo[xItem-50][maxQuantity]);
            strcat(_dialogStr, stringicc);

        }

        Dialog_Show(playerid, "inventoryDialog", DIALOG_STYLE_LIST, "{daa520}DEBUG:", _dialogStr, "Ok", "");
    }

    return (true);
}

hook OnCharacterLoaded(playerid) {

    new q[124];
    mysql_format(MySQL:SQL, q, sizeof q, "SELECT * FROM `inventory` WHERE `PlayerID` = %d LIMIT 35", GetCharacterSQLID(playerid));
    mysql_tquery(MySQL:SQL, q, "mysql_CheckPlayerInventory", "d", GetCharacterSQLID(playerid));

    return (true);
}

//* test command

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

YCMD:inv(playerid, params[], help) {

    new q[246];
    mysql_format(SQL, q, sizeof q, "SELECT * FROM `inventory` WHERE `PlayerID` = %d", GetCharacterSQLID(playerid));
    mysql_tquery(SQL, q, "mysql_LoadPlayerInventory", "d", playerid);

    return (true);
}

Dialog:inventoryDialog(const playerid, response, listitem, string: inputtext[]) {
    if (!response) return true;

    new id = Iter_Index(iter_Items[playerid], listitem);
    new q[256];


    mysql_format(MySQL:SQL, q, sizeof(q), "DELETE FROM `inventory` WHERE `PlayerID` = %d AND `ItemID` = %d", GetCharacterSQLID(playerid), InventoryInfo[playerid][id][ItemID]);
    mysql_tquery(SQL, q); 

    InventoryInfo[playerid][id][ItemID] = INVALID_INVENTORY_ITEM; 
    InventoryInfo[playerid][id][ItemQuantity] = 0;
    InventoryInfo[playerid][id][ItemType] = INVENTORY_INVALID_ITEM_TYPE;

    Iter_Remove(iter_Items[playerid], id);

    printf("* Removed item from inventory array at index '%d'", id);

    SendClientMessage(playerid, 0x00FF00FF, "Item successfully removed.");

    new qw[246];
    mysql_format(SQL, qw, sizeof qw, "SELECT * FROM `inventory` WHERE `PlayerID` = %d", GetCharacterSQLID(playerid));
    mysql_tquery(SQL, qw, "mysql_LoadPlayerInventory", "d", playerid);


    return true;
}
