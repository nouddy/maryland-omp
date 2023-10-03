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
 *  @Author         Ogy
 *  @Date           27th May 2023
 *  @Weburl         weburl
 *  @Project        maryland_project
 *
 *  @File           pizzeria.map
 *  @Module         modules
 */

#include <ysilib\YSI_Coding\y_hooks>

hook OnGameModeInit() {

    static pizzeria_MAP;
    pizzeria_MAP = CreateDynamicObject(5418, 2112.939941, -1797.089965, 19.335899, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 14569, "traidman", "darkgrey_carpet_256", 0x00000000);
    SetDynamicObjectMaterial(pizzeria_MAP, 4, 10356, "groundbit_sfs", "ws_hextile", 0xFFFFFFFF);
    SetDynamicObjectMaterial(pizzeria_MAP, 6, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
    SetDynamicObjectMaterial(pizzeria_MAP, 8, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
    SetDynamicObjectMaterial(pizzeria_MAP, 9, 10765, "airportgnd_sfse", "ws_runwaytarmac", 0x00000000);
    SetDynamicObjectMaterial(pizzeria_MAP, 10, 6487, "councl_law2", "rodeo3sjm", 0x00000000);
    SetDynamicObjectMaterial(pizzeria_MAP, 11, 19655, "mattubes", "reddirt1", 0x00000000);
    SetDynamicObjectMaterial(pizzeria_MAP, 12, 19480, "signsurf", "sign", 0x00000000);
    SetDynamicObjectMaterial(pizzeria_MAP, 13, 4593, "buildblk55", "sl_plazatile01", 0x00000000);
    pizzeria_MAP = CreateDynamicObject(770, 2095.718017, -1827.054321, 12.468244, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, -1, "none", "none", 0xFFFFFFFF);
    pizzeria_MAP = CreateDynamicObject(770, 2097.269042, -1780.464843, 12.468244, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, -1, "none", "none", 0xFFFFFFFF);
    pizzeria_MAP = CreateDynamicObject(1408, 2101.210693, -1786.158447, 13.121594, 0.000000, 0.000000, -180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
    pizzeria_MAP = CreateDynamicObject(1408, 2099.860107, -1799.420043, 13.101594, 0.000000, 0.000000, -89.999992, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
    pizzeria_MAP = CreateDynamicObject(1408, 2102.651611, -1791.328491, 13.101594, 0.000000, 0.000000, -180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
    pizzeria_MAP = CreateDynamicObject(1408, 2102.601562, -1822.230224, 13.101594, 0.000000, -0.000001, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
    pizzeria_MAP = CreateDynamicObject(1408, 2099.860107, -1819.510986, 13.101594, 0.000001, 0.000000, -89.999992, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
    pizzeria_MAP = CreateDynamicObject(1408, 2095.418457, -1802.470214, 13.101594, 0.000000, 0.000000, 0.000007, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
    pizzeria_MAP = CreateDynamicObject(1408, 2099.860107, -1814.051025, 13.101594, 0.000001, 0.000000, -89.999992, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
    pizzeria_MAP = CreateDynamicObject(1408, 2098.650878, -1783.455322, 13.101594, 0.000000, 0.000000, 441.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
    pizzeria_MAP = CreateDynamicObject(1408, 2099.501220, -1778.081909, 13.101594, 0.000000, 0.000000, 441.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
    pizzeria_MAP = CreateDynamicObject(1408, 2099.860107, -1793.989135, 13.101594, 0.000000, 0.000000, -89.999992, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
    pizzeria_MAP = CreateDynamicObject(1408, 2095.418457, -1811.420776, 13.101594, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
    pizzeria_MAP = CreateDynamicObject(19089, 2105.410644, -1791.047241, 15.764652, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
    pizzeria_MAP = CreateDynamicObject(19089, 2105.410644, -1822.310058, 15.764652, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
    pizzeria_MAP = CreateDynamicObject(19604, 2107.341796, -1796.109863, 15.760933, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 14561, "triad_neon", "kbneon", 0x00000000);
    pizzeria_MAP = CreateDynamicObject(19604, 2107.341796, -1806.768432, 15.760933, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 14561, "triad_neon", "kbneon", 0x00000000);
    pizzeria_MAP = CreateDynamicObject(19604, 2107.341796, -1817.229003, 15.760933, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 14561, "triad_neon", "kbneon", 0x00000000);
    pizzeria_MAP = CreateDynamicObject(1408, 2100.356689, -1772.689819, 13.101594, 0.000000, 0.000000, 441.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
    pizzeria_MAP = CreateDynamicObject(1408, 2106.358398, -1766.598388, 13.101594, 0.000000, 0.000000, 20.500009, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
    pizzeria_MAP = CreateDynamicObject(1408, 2107.504150, -1762.376708, 13.121594, 0.000000, 0.000000, -179.999984, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
    pizzeria_MAP = CreateDynamicObject(1408, 2102.691406, -1762.386718, 13.121594, 0.000000, 0.000000, -179.999984, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
    pizzeria_MAP = CreateDynamicObject(1408, 2098.968505, -1766.673095, 13.121594, 0.000000, 0.000000, -104.700065, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
    pizzeria_MAP = CreateDynamicObject(1408, 2097.583251, -1771.944702, 13.121594, 0.000000, 0.000000, -104.700065, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
    pizzeria_MAP = CreateDynamicObject(1408, 2096.197509, -1777.224853, 13.121594, 0.000000, 0.000000, -104.700065, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
    pizzeria_MAP = CreateDynamicObject(1408, 2094.810302, -1782.506103, 13.121594, 0.000000, 0.000000, -104.700065, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
    pizzeria_MAP = CreateDynamicObject(1408, 2093.427001, -1787.777099, 13.121594, 0.000000, 0.000000, -104.700065, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
    pizzeria_MAP = CreateDynamicObject(1408, 2095.568603, -1790.910400, 13.101594, 0.000000, 0.000000, 0.000007, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
    pizzeria_MAP = CreateDynamicObject(1408, 2095.418457, -1822.471313, 13.101594, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
    pizzeria_MAP = CreateDynamicObject(1408, 2091.738769, -1825.331176, 13.101594, 0.000001, 0.000000, -89.999992, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
    pizzeria_MAP = CreateDynamicObject(1408, 2091.748779, -1828.961425, 13.101594, 0.000001, 0.000000, -89.999992, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
    pizzeria_MAP = CreateDynamicObject(770, 2115.890136, -1830.055786, 12.468244, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, -1, "none", "none", 0xFFFFFFFF);
    pizzeria_MAP = CreateDynamicObject(19604, 2099.781005, -1794.655273, 8.502763, -90.000000, 195.259506, -74.740493, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
    pizzeria_MAP = CreateDynamicObject(19379, 2099.872314, -1796.790649, 8.248886, 0.000000, -0.000001, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 19655, "mattubes", "reddirt1", 0x00000000);
    pizzeria_MAP = CreateDynamicObject(19360, 2099.852294, -1796.560424, 11.768883, 0.000000, -0.000001, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
    pizzeria_MAP = CreateDynamicObject(19604, 2099.781005, -1798.984985, 8.502763, -90.000000, 195.259506, -74.740493, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
    pizzeria_MAP = CreateDynamicObject(19360, 2099.852294, -1796.860717, 11.768883, 0.000000, -0.000001, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
    pizzeria_MAP = CreateDynamicObject(19483, 2099.730712, -1796.716430, 12.972772, 0.000000, 0.000001, -179.999984, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
    SetDynamicObjectMaterialText(pizzeria_MAP, 0, "PARKING", 130, "Courier New", 140, 1, 0xFFFFFFFF, 0x00000000, 1);
    pizzeria_MAP = CreateDynamicObject(19604, 2099.781005, -1814.674316, 8.502763, -90.000000, 30.004867, 120.004852, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
    pizzeria_MAP = CreateDynamicObject(19379, 2099.872314, -1816.809692, 8.248886, 0.000000, -0.000004, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 19655, "mattubes", "reddirt1", 0x00000000);
    pizzeria_MAP = CreateDynamicObject(19360, 2099.852294, -1816.579467, 11.768883, 0.000000, -0.000004, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
    pizzeria_MAP = CreateDynamicObject(19604, 2099.781005, -1819.004028, 8.502763, -90.000000, 30.004867, 120.004852, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
    pizzeria_MAP = CreateDynamicObject(19360, 2099.852294, -1816.879760, 11.768883, 0.000000, -0.000004, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
    pizzeria_MAP = CreateDynamicObject(19483, 2099.730712, -1816.735473, 12.972772, 0.000000, 0.000004, -179.999984, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(pizzeria_MAP, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
    SetDynamicObjectMaterialText(pizzeria_MAP, 0, "PARKING", 130, "Courier New", 140, 1, 0xFFFFFFFF, 0x00000000, 1);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    return 1;
}

hook OnPlayerConnect(playerid) {

    RemoveBuildingForPlayer(playerid, 5418, 2112.939, -1797.089, 19.335, 0.250);
    RemoveBuildingForPlayer(playerid, 5530, 2112.939, -1797.089, 19.335, 0.250);
    RemoveBuildingForPlayer(playerid, 1408, 2099.860, -1799.420, 13.101, 0.250);
    RemoveBuildingForPlayer(playerid, 1408, 2099.850, -1793.979, 13.101, 0.250);
    RemoveBuildingForPlayer(playerid, 1408, 2102.659, -1791.329, 13.101, 0.250);
    RemoveBuildingForPlayer(playerid, 1408, 2099.850, -1813.910, 13.101, 0.250);
    RemoveBuildingForPlayer(playerid, 1408, 2099.860, -1819.359, 13.101, 0.250);
    RemoveBuildingForPlayer(playerid, 1408, 2102.600, -1822.079, 13.117, 0.250);
    RemoveBuildingForPlayer(playerid, 1226, 2114.719, -1785.180, 16.398, 0.250);

    return 1;
}