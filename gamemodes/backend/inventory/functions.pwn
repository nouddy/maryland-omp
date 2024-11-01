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

? TODO > Dodati funkcije za getanje droge itd da se mogu koristiti u ostalim modulima.

*/

#include <ysilib\YSI_Coding\y_hooks>


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
        case INVENTORY_ITEM_MARIJUANA: { string = "Marihuana"; }
        case INVENTORY_ITEM_KOKAIN: { string = "Kokain"; }
        case INVENTORY_ITEM_MDMA: { string = "MDMA"; }

        default: { string = "[Undefined]:"; }
    }

    return string;
}
