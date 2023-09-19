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
 *  @File           ml-busvozac.map
 *  @Module         modules
 */

#include <ysilib\YSI_Coding\y_hooks>

hook OnGameModeInit()
{
	print("exterior/ml-busvozac.map loaded");

    static mapBusVozac;
    mapBusVozac = Maryland_CreateDynamicObject(4821, 1745.199951, -1882.849975, 26.140600, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 5, 4992, "airportdetail", "hedge2", 0x00000000);
    SetDynamicObjectMaterial(mapBusVozac, 6, 4992, "airportdetail", "hedge2", 0xFFFFFFFF);
    SetDynamicObjectMaterial(mapBusVozac, 7, 14569, "traidman", "darkgrey_carpet_256", 0x00000000);
    SetDynamicObjectMaterial(mapBusVozac, 10, 3979, "civic01_lan", "sl_laoffblok2wall1", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(5033, 1745.199951, -1882.849975, 26.140600, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(mapBusVozac, 2, 14488, "dogsgym", "AH_bgmartiles", 0x00000000);
    SetDynamicObjectMaterial(mapBusVozac, 3, 9582, "fort_sfw", "club_roofwin_sfw", 0x00000000);
    SetDynamicObjectMaterial(mapBusVozac, 5, 14488, "dogsgym", "AH_bgmartiles", 0x00000000);
    SetDynamicObjectMaterial(mapBusVozac, 8, 9582, "fort_sfw", "club_roofwin_sfw", 0x00000000);
    SetDynamicObjectMaterial(mapBusVozac, 9, 3646, "ganghouse1_lax", "comptroof4", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19447, 1804.901123, -1916.470458, 12.318696, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 10778, "airportcpark_sfse", "ws_carpark3", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(673, 1800.723510, -1938.728027, 12.507350, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, -1, "none", "none", 0xFFFFFFFF);
    mapBusVozac = Maryland_CreateDynamicObject(639, 1774.380371, -1924.618408, 21.526849, 0.000000, 0.000001, -179.999984, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, -1, "none", "none", 0xFFFFFFFF);
    mapBusVozac = Maryland_CreateDynamicObject(1256, 1770.298706, -1917.647338, 13.210403, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, -1, "none", "none", 0xFFFFFFFF);
    mapBusVozac = Maryland_CreateDynamicObject(4642, 1810.082519, -1883.639648, 14.079989, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 8618, "ceasersign", "ceaserspillar01_128", 0x00000000);
    SetDynamicObjectMaterial(mapBusVozac, 3, 18029, "genintintsmallrest", "GB_restaursmll10", 0xFFFFFFFF);
    SetDynamicObjectMaterial(mapBusVozac, 4, 18029, "genintintsmallrest", "GB_restaursmll12", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19695, 1763.673950, -1929.855346, 27.667238, 0.000014, 180.000000, -90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 3646, "ganghouse1_lax", "comptroof4", 0xFFFFFFFF);
    mapBusVozac = Maryland_CreateDynamicObject(19700, 1757.422119, -1929.852661, 27.792333, 0.000000, -0.000012, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 3646, "ganghouse1_lax", "comptroof4", 0xFFFFFFFF);
    mapBusVozac = Maryland_CreateDynamicObject(19695, 1763.673950, -1917.354370, 27.667238, 0.000017, 180.000000, -90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 3646, "ganghouse1_lax", "comptroof4", 0xFFFFFFFF);
    mapBusVozac = Maryland_CreateDynamicObject(19700, 1757.422119, -1917.351684, 27.792333, -0.000001, -0.000012, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 3646, "ganghouse1_lax", "comptroof4", 0xFFFFFFFF);
    mapBusVozac = Maryland_CreateDynamicObject(19695, 1763.673950, -1904.864135, 27.667238, 0.000017, 180.000000, -90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 3646, "ganghouse1_lax", "comptroof4", 0xFFFFFFFF);
    mapBusVozac = Maryland_CreateDynamicObject(19700, 1757.422119, -1904.861450, 27.792333, -0.000001, -0.000012, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 3646, "ganghouse1_lax", "comptroof4", 0xFFFFFFFF);
    mapBusVozac = Maryland_CreateDynamicObject(19695, 1763.673950, -1892.363159, 27.667238, 0.000019, 180.000000, -90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 3646, "ganghouse1_lax", "comptroof4", 0xFFFFFFFF);
    mapBusVozac = Maryland_CreateDynamicObject(19700, 1757.422119, -1892.360473, 27.792333, -0.000004, -0.000012, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 3646, "ganghouse1_lax", "comptroof4", 0xFFFFFFFF);
    mapBusVozac = Maryland_CreateDynamicObject(19695, 1763.673950, -1879.894042, 27.667238, 0.000022, 180.000000, -90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 3646, "ganghouse1_lax", "comptroof4", 0xFFFFFFFF);
    mapBusVozac = Maryland_CreateDynamicObject(19700, 1757.422119, -1879.891357, 27.792333, -0.000007, -0.000012, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 3646, "ganghouse1_lax", "comptroof4", 0xFFFFFFFF);
    mapBusVozac = Maryland_CreateDynamicObject(639, 1774.380371, -1906.118041, 21.526849, 0.000000, 0.000001, -179.999984, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, -1, "none", "none", 0xFFFFFFFF);
    mapBusVozac = Maryland_CreateDynamicObject(1256, 1770.298706, -1932.246459, 13.210403, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, -1, "none", "none", 0xFFFFFFFF);
    mapBusVozac = Maryland_CreateDynamicObject(19447, 1780.431640, -1886.320556, 12.318696, 0.000000, 90.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 10778, "airportcpark_sfse", "ws_carpark3", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19447, 1776.111450, -1911.752807, 12.318696, 0.000000, 90.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 10778, "airportcpark_sfse", "ws_carpark3", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19447, 1795.542236, -1886.320556, 12.318696, 0.000000, 90.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 10778, "airportcpark_sfse", "ws_carpark3", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19447, 1776.111450, -1926.212768, 12.318696, 0.000000, 90.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 10778, "airportcpark_sfse", "ws_carpark3", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19447, 1790.842407, -1920.674438, 12.418698, 0.000000, 90.000000, -179.999984, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 3979, "civic01_lan", "sl_laoffblok2wall1", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19447, 1792.822265, -1933.801879, 12.318696, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 10778, "airportcpark_sfse", "ws_carpark3", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(639, 1774.380371, -1889.797607, 21.526849, 0.000000, 0.000000, -179.999984, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, -1, "none", "none", 0xFFFFFFFF);
    mapBusVozac = Maryland_CreateDynamicObject(673, 1794.223510, -1883.499145, 12.507349, 0.000000, -0.000009, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, -1, "none", "none", 0xFFFFFFFF);
    mapBusVozac = Maryland_CreateDynamicObject(673, 1802.852172, -1883.499145, 12.507350, 0.000000, -0.000009, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, -1, "none", "none", 0xFFFFFFFF);
    mapBusVozac = Maryland_CreateDynamicObject(19758, 1774.413696, -1935.310180, 5.992256, 270.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 3646, "ganghouse1_lax", "comptroof4", 0xFFFFFFFF);
    mapBusVozac = Maryland_CreateDynamicObject(19758, 1774.413696, -1906.859985, 5.992256, 270.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 3646, "ganghouse1_lax", "comptroof4", 0xFFFFFFFF);
    mapBusVozac = Maryland_CreateDynamicObject(19758, 1774.413696, -1884.178710, 5.992256, 270.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 3646, "ganghouse1_lax", "comptroof4", 0xFFFFFFFF);
    mapBusVozac = Maryland_CreateDynamicObject(19789, 1811.473388, -1930.501831, 13.725092, 0.000000, -0.000022, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 2028, "cj_games", "CJ_speaker4", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19789, 1811.473388, -1928.281494, 13.725092, 0.000000, -0.000022, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 2028, "cj_games", "CJ_speaker4", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19479, 1778.319091, -1883.089843, 24.263916, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 14498, "imm_rooms", "venetian_blind", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19479, 1763.519409, -1883.089843, 24.263916, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 14498, "imm_rooms", "venetian_blind", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19479, 1748.720092, -1883.089843, 24.263916, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 14498, "imm_rooms", "venetian_blind", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19479, 1778.319091, -1868.322753, 24.263916, -0.000001, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 14498, "imm_rooms", "venetian_blind", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19479, 1763.519409, -1868.322753, 24.263916, -0.000001, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 14498, "imm_rooms", "venetian_blind", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19479, 1748.720092, -1868.322753, 24.263916, -0.000001, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 14498, "imm_rooms", "venetian_blind", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(638, 1772.374633, -1918.780273, 12.922918, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFFFFFFFF);
    SetDynamicObjectMaterial(mapBusVozac, 1, 801, "gta_proc_ferns", "veg_bush2", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(673, 1808.973999, -1904.007568, 12.507349, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, -1, "none", "none", 0xFFFFFFFF);
    mapBusVozac = Maryland_CreateDynamicObject(673, 1808.973999, -1928.736694, 12.507349, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, -1, "none", "none", 0xFFFFFFFF);
    mapBusVozac = Maryland_CreateDynamicObject(673, 1781.062988, -1938.728027, 12.507349, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, -1, "none", "none", 0xFFFFFFFF);
    mapBusVozac = Maryland_CreateDynamicObject(19447, 1792.522216, -1920.674438, 10.738704, 0.000000, 180.000000, -179.999984, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19447, 1789.171752, -1920.674438, 10.738704, 0.000000, 180.000000, -179.999984, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19447, 1790.842407, -1925.405151, 7.668694, 90.000000, 0.000029, 90.000007, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19447, 1790.842407, -1911.053466, 12.418698, 0.000000, 90.000000, -179.999984, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 3979, "civic01_lan", "sl_laoffblok2wall1", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19447, 1792.522216, -1911.053466, 10.738704, 0.000000, 180.000000, -179.999984, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19447, 1789.171752, -1911.053466, 10.738704, 0.000000, 180.000000, -179.999984, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19447, 1790.842407, -1901.452026, 12.418698, 0.000000, 90.000000, -179.999984, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 3979, "civic01_lan", "sl_laoffblok2wall1", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19447, 1792.522216, -1901.452026, 10.738704, 0.000000, 180.000000, -179.999984, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19447, 1789.171752, -1901.452026, 10.738704, 0.000000, 180.000000, -179.999984, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19447, 1790.842407, -1896.704345, 7.668694, 90.000000, 0.000029, 90.000007, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(673, 1790.913940, -1922.467529, 12.507349, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, -1, "none", "none", 0xFFFFFFFF);
    mapBusVozac = Maryland_CreateDynamicObject(673, 1790.913940, -1900.046630, 12.507349, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, -1, "none", "none", 0xFFFFFFFF);
    mapBusVozac = Maryland_CreateDynamicObject(673, 1790.913940, -1910.857055, 12.507349, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, -1, "none", "none", 0xFFFFFFFF);
    mapBusVozac = Maryland_CreateDynamicObject(638, 1790.854980, -1916.659912, 12.922918, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFFFFFFFF);
    SetDynamicObjectMaterial(mapBusVozac, 1, 801, "gta_proc_ferns", "veg_bush2", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(638, 1790.854980, -1905.069213, 12.922918, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFFFFFFFF);
    SetDynamicObjectMaterial(mapBusVozac, 1, 801, "gta_proc_ferns", "veg_bush2", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19447, 1794.360351, -1911.209838, 12.318696, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 10778, "airportcpark_sfse", "ws_carpark3", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19447, 1787.310058, -1911.209838, 12.318696, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 10778, "airportcpark_sfse", "ws_carpark3", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(1256, 1786.040283, -1940.946411, 13.210403, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, -1, "none", "none", 0xFFFFFFFF);
    mapBusVozac = Maryland_CreateDynamicObject(1256, 1802.690063, -1940.946411, 13.210403, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, -1, "none", "none", 0xFFFFFFFF);
    mapBusVozac = Maryland_CreateDynamicObject(1256, 1810.100830, -1924.755615, 13.210403, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, -1, "none", "none", 0xFFFFFFFF);
    mapBusVozac = Maryland_CreateDynamicObject(19789, 1811.473388, -1922.520874, 13.725092, 0.000000, -0.000025, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 2028, "cj_games", "CJ_speaker4", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19789, 1811.473388, -1926.061401, 13.725092, 0.000000, -0.000025, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 2028, "cj_games", "CJ_speaker4", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19789, 1811.473388, -1920.300537, 13.725092, 0.000000, -0.000025, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 2028, "cj_games", "CJ_speaker4", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19789, 1811.473388, -1918.080444, 13.725092, 0.000000, -0.000027, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 2028, "cj_games", "CJ_speaker4", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19789, 1811.473388, -1915.791625, 13.725092, 0.000000, -0.000027, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 2028, "cj_games", "CJ_speaker4", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19789, 1811.473388, -1913.571289, 13.725092, 0.000000, -0.000027, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 2028, "cj_games", "CJ_speaker4", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(19789, 1811.473388, -1911.351196, 13.725092, 0.000000, -0.000030, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 2028, "cj_games", "CJ_speaker4", 0x00000000);
    mapBusVozac = Maryland_CreateDynamicObject(7666, 1811.982299, -1930.494018, 14.214801, 60.495578, -89.999984, -89.999938, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterialText(mapBusVozac, 0, "B", 140, "Georgia", 120, 1, 0xFFFFFFFF, 0x00000000, 1);
    mapBusVozac = Maryland_CreateDynamicObject(7666, 1811.982299, -1928.282836, 14.214801, 60.495578, -89.999984, -89.999938, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterialText(mapBusVozac, 0, "U", 140, "Georgia", 120, 1, 0xFFFFFFFF, 0x00000000, 1);
    mapBusVozac = Maryland_CreateDynamicObject(7666, 1811.982299, -1926.073120, 14.214801, 60.495578, -89.999984, -89.999938, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterialText(mapBusVozac, 0, "S", 140, "Georgia", 120, 1, 0xFFFFFFFF, 0x00000000, 1);
    mapBusVozac = Maryland_CreateDynamicObject(7666, 1811.982299, -1922.502807, 14.214801, 60.495578, -89.999984, -89.999938, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterialText(mapBusVozac, 0, "S", 140, "Georgia", 120, 1, 0xFFFFFFFF, 0x00000000, 1);
    mapBusVozac = Maryland_CreateDynamicObject(7666, 1811.982299, -1920.292480, 14.214801, 60.495578, -89.999984, -89.999938, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterialText(mapBusVozac, 0, "T", 140, "Georgia", 120, 1, 0xFFFFFFFF, 0x00000000, 1);
    mapBusVozac = Maryland_CreateDynamicObject(7666, 1811.982299, -1918.101684, 14.214801, 60.495578, -89.999984, -89.999938, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterialText(mapBusVozac, 0, "A", 140, "Georgia", 120, 1, 0xFFFFFFFF, 0x00000000, 1);
    mapBusVozac = Maryland_CreateDynamicObject(7666, 1811.982299, -1913.560424, 14.214801, 60.495578, -89.999984, -89.999938, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterialText(mapBusVozac, 0, "I", 140, "Georgia", 120, 1, 0xFFFFFFFF, 0x00000000, 1);
    mapBusVozac = Maryland_CreateDynamicObject(7666, 1811.982299, -1915.811889, 14.214801, 60.495578, -89.999984, -89.999938, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterialText(mapBusVozac, 0, "T", 140, "Georgia", 120, 1, 0xFFFFFFFF, 0x00000000, 1);
    mapBusVozac = Maryland_CreateDynamicObject(7666, 1811.982299, -1911.359497, 14.214801, 60.495578, -89.999984, -89.999938, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterialText(mapBusVozac, 0, "O", 140, "Georgia", 120, 1, 0xFFFFFFFF, 0x00000000, 1);
    mapBusVozac = Maryland_CreateDynamicObject(7666, 1811.982299, -1909.128417, 14.214801, 60.495578, -89.999984, -89.999938, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterialText(mapBusVozac, 0, "N", 140, "Georgia", 120, 1, 0xFFFFFFFF, 0x00000000, 1);
    mapBusVozac = Maryland_CreateDynamicObject(19789, 1811.473388, -1909.130126, 13.725092, 0.000000, -0.000032, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(mapBusVozac, 0, 2028, "cj_games", "CJ_speaker4", 0x00000000);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    mapBusVozac = Maryland_CreateDynamicObject(1415, 1770.043457, -1909.485229, 12.611849, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(1359, 1770.542724, -1921.940917, 13.248176, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1774.269653, -1901.023071, 12.141988, -0.000009, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(1291, 1767.576660, -1889.445678, 13.062996, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1774.269653, -1892.571166, 12.141988, -0.000004, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1774.269653, -1887.889526, 12.141988, -0.000004, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1774.269653, -1906.122924, 12.141988, -0.000009, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1774.269653, -1920.394165, 12.141988, -0.000012, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1782.318603, -1935.638671, 12.141988, -0.000009, 0.000007, -179.999984, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1774.269653, -1934.931518, 12.141988, -0.000014, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1777.636962, -1935.638671, 12.141988, -0.000009, 0.000007, -179.999984, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1787.226562, -1935.638671, 12.141988, -0.000012, 0.000007, -179.999984, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1801.537597, -1935.638671, 12.141988, -0.000012, 0.000007, -179.999984, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1806.445556, -1935.638671, 12.141988, -0.000014, 0.000007, -179.999984, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1757.606567, -1942.320556, 12.612000, -0.000009, 0.000009, -179.999984, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1806.820190, -1910.804565, 12.141988, -0.000012, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1767.196166, -1942.320556, 12.612000, -0.000012, 0.000009, -179.999984, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1762.514526, -1942.320556, 12.612000, -0.000012, 0.000009, -179.999984, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1776.825561, -1942.320556, 12.612000, -0.000012, 0.000009, -179.999984, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1772.143920, -1942.320556, 12.612000, -0.000012, 0.000009, -179.999984, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1781.733520, -1942.320556, 12.612000, -0.000014, 0.000009, -179.999984, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1806.820190, -1906.122924, 12.141988, -0.000012, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1806.820190, -1930.023559, 12.141988, -0.000014, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1806.820190, -1925.341918, 12.141988, -0.000014, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1806.820190, -1934.931518, 12.141988, -0.000017, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1806.820190, -1900.183227, 12.141988, -0.000012, 0.000000, 75.500022, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1808.591674, -1895.907226, 12.141988, -0.000009, -0.000001, 22.099998, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(1346, 1809.811767, -1900.628540, 13.914361, 0.000001, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(1234, 1810.353393, -1900.031982, 15.038947, 0.000001, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(1363, 1770.340698, -1904.831542, 13.378957, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(1216, 1796.901977, -1941.273925, 13.188798, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(1342, 1761.583862, -1889.251098, 13.596854, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(1340, 1765.404541, -1904.283935, 13.606127, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(1291, 1766.706176, -1889.445678, 13.062996, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(2671, 1770.728271, -1910.782836, 12.592889, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(2674, 1766.585083, -1903.417114, 12.630791, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(955, 1759.444091, -1906.725463, 12.967403, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(956, 1758.254150, -1906.725463, 12.967403, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(648, 1805.994628, -1946.944702, 11.991602, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(648, 1805.133300, -1945.914062, 11.991602, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(648, 1805.133300, -1945.963867, 11.991602, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1792.540161, -1899.923095, 12.141987, -0.000012, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1792.540161, -1904.163330, 12.141987, -0.000012, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1792.540161, -1908.414428, 12.141987, -0.000014, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1792.540161, -1912.804809, 12.141987, -0.000014, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1792.540161, -1917.077026, 12.141987, -0.000017, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1792.540161, -1921.286987, 12.141987, -0.000017, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1792.540161, -1925.466796, 12.141987, -0.000017, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1789.148803, -1899.923095, 12.141987, -0.000014, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1789.148803, -1904.163330, 12.141987, -0.000014, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1789.148803, -1908.414428, 12.141987, -0.000017, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1789.148803, -1912.804809, 12.141987, -0.000017, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1789.148803, -1917.077026, 12.141987, -0.000018, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1789.148803, -1921.286987, 12.141987, -0.000018, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1789.148803, -1925.466796, 12.141987, -0.000018, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1792.439575, -1925.396728, 12.141987, -0.000018, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1792.439575, -1896.726074, 12.141991, -0.000018, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(1415, 1810.383666, -1939.306152, 12.551848, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(1257, 1792.315917, -1936.655151, 13.794631, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(1257, 1807.658081, -1916.464355, 13.794631, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(1257, 1773.396362, -1911.793579, 13.794631, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(1257, 1773.396362, -1926.164306, 13.794631, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(1346, 1809.811767, -1902.529052, 13.914361, 0.000004, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(1234, 1810.353393, -1901.932495, 15.038947, 0.000004, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(966, 1811.663940, -1885.919189, 12.407305, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1811.639526, -1881.477783, 12.141986, -0.000018, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1811.699584, -1881.477783, 12.141986, -0.000018, 0.000000, 540.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1811.649536, -1893.046142, 12.141986, -0.000018, 0.000000, 630.000000, -1, -1, -1, 300.00, 300.00); 
    mapBusVozac = Maryland_CreateDynamicObject(997, 1811.649536, -1896.305908, 12.141986, -0.000018, 0.000000, 630.000000, -1, -1, -1, 300.00, 300.00);

    return 1;
}

hook OnPlayerConnect(playerid)
{
    RemoveBuildingForPlayer(playerid, 4821, 1745.199, -1882.849, 26.140, 0.250);
    RemoveBuildingForPlayer(playerid, 4961, 1745.199, -1882.849, 26.140, 0.250);
    RemoveBuildingForPlayer(playerid, 5033, 1745.199, -1882.849, 26.140, 0.250);
    RemoveBuildingForPlayer(playerid, 5055, 1745.199, -1882.849, 26.140, 0.250);

	return 1;
}