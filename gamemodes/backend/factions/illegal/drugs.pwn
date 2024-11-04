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
 *  @Author         Vostic & Nodi
 *  @Github         (github.com/vosticdev) & (github.com/nouddy)
 *  @Date           01 Nov 2024
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           drugs.pwn
 *  @Module         illegal
 */


#include <ysilib\YSI_Coding\y_hooks>

//*==============================================================================
//?--->>> Begining
//*==============================================================================

#define MAX_PLANTS      (MAX_PLAYERS * 10)  // * Every player on server can have up to 10 plants (at once)
#define PLANT_DISPLACEMENT      0.128       //* Fuck this shit I stole it

//Cocaine
#define MAX_HERBS 20
#define INVALID_HERB_ID -1

new HerbObject[MAX_HERBS],
    HerbArea[MAX_HERBS],
    HerbTimer[MAX_HERBS],
    Text3D:HerbLabel[MAX_HERBS];


//* Inventory item ID's

enum {

    DRUG_TYPE_HASH = 58,
    DRUG_TYPE_COCAINE,
    DRUG_TYPE_MDMA
}

//* Plant Data

enum e_PLANT_DATA {

    plantID,
    plantOwner,
    plantGrowTime,
    plantRothTime,
    Float:plantPos[3]

}

//* Vars :|

new PlantInfo[MAX_PLANTS][e_PLANT_DATA],
    Iterator:iter_Plants<MAX_PLANTS>,
    plantObject[MAX_PLANTS],
    Text3D:plantLabel[MAX_PLANTS];

new RothTimer[MAX_PLANTS],
    GrowTimer[MAX_PLANTS],
    plantIcons[MAX_PLAYERS][10],
    bool:weedHarvesting[MAX_PLAYERS];

new weed_zone;


//Cocaine

enum HerbData{
    Float:HerbX,
    Float:HerbY,
    Float:HerbZ,
    HerbModel,
    Float:HerbRotX,
    Float:HerbRotY,
    Float:HerbRotZ,
}

//x,y,z,modelid,rx,ry,rz
new HerbPositions[MAX_HERBS][HerbData] = {
    {978.038391, 184.931762, 34.524505, 2249, 0.0, 0.0, 0.0},
    {1134.495117, 482.813110, 24.820110, 811, 0.0, 0.0, -107.2},
    {1015.625244, -82.297264, 1.082602, 2345, 0.0, 0.0, 10.2},
    {1587.888305, -83.889030, -3.048310, 855, 0.0, 0.0, 0.0},
    {585.466674, -371.482696, 29.196155, 3532, 0.0, 0.0, 112.8},
    {382.171386, 11.290806, 6.290235, 811, 0.0, 0.0, -45.0},
    {-818.230224, 48.439861, 37.409496, 815, 0.0, 0.0, 0.0},
    {2589.792724, -653.552917, 134.046432, 809, 0.0, 0.0, 0.0},
    {2351.034912, -683.781372, 132.316131, 859, 0.0, 0.0, 0.0},
    {802.445373, -181.449096, 10.689357, 2247, 0.0, 0.0, 0.0},
    {2121.213378, -85.999298, 0.860602, 806, 0.0, 0.0, 0.0},
    {2864.915039, -409.177612, 6.740871, 815, 0.0, 0.0, -147.0},
    {162.623947, -392.340789, 1.514611, 806, 0.0, 0.0, 0.0},
    {139.909622, -1105.504272, 41.364116, 2249, 0.0, 0.0, 73.7},
    {855.514892, -10.931550, 62.032058, 864, 0.0, 0.0, -82.6},
    {1038.925781, 67.669708, 63.399932, 864, 0.0, 0.0, 0.0},
    {783.839843, 100.555610, 67.050361, 864, 0.0, 0.0, 0.0},
    {493.360504, -244.988159, 0.451016, 806, 0.0, 0.0, 0.0},
    {470.220306, -516.334472, 42.727748, 811, 0.0, 0.0, 0.0},
    {220.390792, -664.897155, 45.957477, 811, 0.0, 0.0, 0.0}
};
//*==============================================================================
//?--->>> Querys & Funcs
//*==============================================================================

forward mysql_InsertPlantID(idx);
public mysql_InsertPlantID(idx) {

    PlantInfo[idx][plantID] = cache_insert_id();
    Iter_Add(iter_Plants, idx);

    new id = PlantInfo[idx][plantID];

    plantObject[id] = CreateDynamicObject(19473, PlantInfo[idx][plantPos][0], PlantInfo[idx][plantPos][1], PlantInfo[idx][plantPos][2]-2.04, 
                                                 0.00, 0.00, 0.00, 0, 0);

    GrowTimer[id] = SetTimerEx("plant_CheckTime", 120 * 1000, false, "d", id);

    new str[128];
    format(str, sizeof str, ""c_server"(( Vrjeme do izrasta : %s ))", convertTime(PlantInfo[idx][plantGrowTime] - gettime()));

    plantLabel[id] = Create3DTextLabel(str, -1, PlantInfo[idx][plantPos][0], PlantInfo[idx][plantPos][1], PlantInfo[idx][plantPos][2], 3.50, 0);

    return (true);
}

forward plant_RothTime(id); 
public plant_RothTime(id) {

    foreach(new i : iter_Plants) {

        if(id == PlantInfo[i][plantID]) {

            if(PlantInfo[i][plantRothTime] > gettime()) {

                new str[128];
                format(str, sizeof str, ""c_server"(( Vrjeme do truljenja : %s ))", convertTime( PlantInfo[i][plantRothTime] - gettime()));
                Update3DTextLabelText(plantLabel[id], x_green, str);
                RothTimer[id] = SetTimerEx("plant_RothTime", 2500, false, "d", id);
            }

            else {

                KillTimer(RothTimer[id]);
                DestroyObject(plantObject[id]);
                
                new q[240];
                mysql_format(SQL, q, sizeof q, "DELETE FROM `player_plants` WHERE `CharacterID` = '%d' AND `ID` = '%d'",
                                                PlantInfo[i][plantOwner], PlantInfo[i][plantID]);
                mysql_tquery(SQL, q);

                Delete3DTextLabel(plantLabel[id]);
                DestroyDynamicObject(plantObject[id]);
            }
        }
    }

    return true;
}

forward plant_CheckTime(id); 
public plant_CheckTime(id) {

    foreach(new i : iter_Plants) {

        if(id == PlantInfo[i][plantID]) {

            if(PlantInfo[i][plantGrowTime] > gettime()) {

                new Float:x, Float:y, Float:z;
                GetDynamicObjectPos(plantObject[id], x, y, z);
                MoveDynamicObject(plantObject[id], x, y, z+PLANT_DISPLACEMENT, PLANT_DISPLACEMENT);

                new str[128];
                format(str, sizeof str, ""c_server"(( Vrjeme do izrasta : %s ))", convertTime(PlantInfo[i][plantGrowTime] - gettime()));
                Update3DTextLabelText(plantLabel[id], x_green, str);
                GrowTimer[id] = SetTimerEx("plant_CheckTime", 3000, false, "d", id);
            }

            else {
                KillTimer(GrowTimer[id]);
                PlantInfo[i][plantRothTime] = gettime() + 500;
                RothTimer[id] = SetTimerEx("plant_RothTime", 2500, false, "d", id);
            }
            break;
        }
    }

    return (true);
}

forward Weed_RefreshPlayer(playerid);
public Weed_RefreshPlayer(playerid) {

    TogglePlayerControllable(playerid, true);

    return true;
}

forward mysql_LoadPlantData();
public mysql_LoadPlantData() {

    new rows = cache_num_rows();

    if(rows) {

        for(new i = 0; i < rows; i++) {

            cache_get_value_name_int(i, "PlantID", PlantInfo[i][plantID]);
            cache_get_value_name_int(i, "CharacterID", PlantInfo[i][plantOwner]);
            cache_get_value_name_int(i, "GrowTime", PlantInfo[i][plantGrowTime]);
            cache_get_value_name_int(i, "RothTime", PlantInfo[i][plantRothTime]);

            cache_get_value_name_float(i, "posX", PlantInfo[i][plantPos][0]);
            cache_get_value_name_float(i, "posY", PlantInfo[i][plantPos][1]);
            cache_get_value_name_float(i, "posZ", PlantInfo[i][plantPos][2]);

            plantObject[i] = CreateDynamicObject(19473, PlantInfo[i][plantPos][0], PlantInfo[i][plantPos][1], PlantInfo[i][plantPos][2],
                                                        0.00, 0.00, 0.00, 0, 0);

            if(PlantInfo[i][plantPos][0] == 0.00 && PlantInfo[i][plantPos][1] == 0.00 && PlantInfo[i][plantPos][2] == 0.00) {

                Log(mainLog, DEBUG, "Desila se greska pri ucitavanju stabljike ID [%d] | Brisanje!");
                new q[128];
                mysql_format(SQL, q, sizeof q, "DELETE FROM `player_plants` WHERE `PlantID` = '%d'", PlantInfo[i][plantID]);
            }

            Iter_Add(iter_Plants, i);
        }   
    }

    return (true);
}


stock Weed_GetPlantedPlants(playerid) {

    new count;

    foreach(new i : iter_Plants) {

        if(GetCharacterSQLID(playerid) == PlantInfo[i][plantOwner]) {

            count++;
        }
    }
    return count;
}

//Cocaine
stock HerbIsNearPlayer(playerid)
{
    new Float:tmpPos[3];

    for(new i = 0; i < MAX_HERBS; i++)
    {
        GetDynamicObjectPos(HerbObject[i], tmpPos[0], tmpPos[1], tmpPos[2]);

        if(IsPlayerInDynamicArea(playerid, HerbArea[i]) && IsPlayerInRangeOfPoint(playerid, 5.0, tmpPos[0], tmpPos[1], tmpPos[2]) && IsValidDynamicObject(HerbObject[i])) return i;
    }
    return INVALID_HERB_ID;
}

stock CreateAllHerbs()
{
    new count = 0;
    for(new i = 0; i < MAX_HERBS; i++)
    {
        new Float:hx = HerbPositions[i][HerbX],
            Float:hy = HerbPositions[i][HerbY],
            Float:hz = HerbPositions[i][HerbZ],
            herbModel = HerbPositions[i][HerbModel],
            Float:hrx = HerbPositions[i][HerbRotX],
            Float:hry = HerbPositions[i][HerbRotY],
            Float:hrz = HerbPositions[i][HerbRotZ];

        HerbObject[i] = CreateDynamicObject(herbModel, hx, hy, hz, hrx, hry, hrz, -1, -1, -1);
        HerbArea[i] = CreateDynamicCircle(hx, hy, 5.0);
        HerbLabel[i] = Create3DTextLabel(""c_server"(( Retka biljka : 'N' ))", -1, hx, hy, hz, 3.50, 0);

        count ++;
    }
    printf("Cocaine system > Kreiranje biljaka uspesno zavrseno, broj kreiranih biljaka %d", count);
}

forward RespawnHerb(HerbID);
public RespawnHerb(HerbID)
{
    new Float:hx = HerbPositions[HerbID][HerbX],
    Float:hy = HerbPositions[HerbID][HerbY],
    Float:hz = HerbPositions[HerbID][HerbZ],
    herbModel = HerbPositions[HerbID][HerbModel],
    Float:hrx = HerbPositions[HerbID][HerbRotX],
    Float:hry = HerbPositions[HerbID][HerbRotY],
    Float:hrz = HerbPositions[HerbID][HerbRotZ];

    HerbObject[HerbID] = CreateDynamicObject(herbModel, hx, hy, hz, hrx, hry, hrz, -1, -1, -1);
    HerbLabel[HerbID] = Create3DTextLabel(""c_server"(( Retka biljka : 'N' ))", -1, hx, hy, hz, 3.50, 0);
    KillTimer(HerbTimer[HerbID]);
    
    return true;
}

//*==============================================================================
//?--->>> Hooks
//*==============================================================================

hook OnGameModeInit() {

    print("factions/drugs.pwn > Drugs loaded.");

    weed_zone = CreateDynamicRectangle(1889, 183.5, 2042, 242.5, 0, 0);

    Create3DTextLabel(""c_server"\187; "c_white"Black Market "c_server"\171;\n"c_white"[ N ]", -1, -396.7119,1275.0776,8.0296, 4.50, 0);

    mysql_tquery(SQL, "SELECT * FROM `player_plants`", "mysql_LoadPlantData");

    CreateAllHerbs();

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerConnect(playerid) {

    for(new i = 0; i < sizeof plantIcons[]; i++) {

        DestroyDynamicMapIcon(plantIcons[playerid][i]);
    }

    weedHarvesting[playerid] = false;

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys) {

    if(PRESSED(KEY_NO)) {

        if(IsPlayerInRangeOfPoint(playerid, 3.50, -396.7119,1275.0776,8.0296)) {

            Dialog_Show(playerid, "dialog_BlackMarket", DIALOG_STYLE_TABLIST_HEADERS, "Black {737be1}Market", "Item\tCijena\n\
                                                                                        {FFFFFF}Sjeme Trave\t {598752}100$\n\
                                                                                        {FFFFFF}Pajser\t {598752}80$\n\
                                                                                        {FFFFFF}Dinamit\t {598752}1500$\n\
                                                                                        {FFFFFF}Ometac\t {598752}4500$",
                                                        "Kupi", "Odustani");
        }

        if(weedHarvesting[playerid]) {

            foreach(new i : iter_Plants) {

                if(GetCharacterSQLID(playerid) == PlantInfo[i][plantOwner]) {

                    if(IsPlayerInRangeOfPoint(playerid, 2.50, PlantInfo[i][plantPos][0], PlantInfo[i][plantPos][1], PlantInfo[i][plantPos][2])) {
                        
                        new id = PlantInfo[i][plantID];

                        Delete3DTextLabel(plantLabel[id]);
                        DestroyDynamicObject(plantObject[id]);

                        if(IsValidDynamicMapIcon(plantIcons[playerid][id]))
                            DestroyDynamicMapIcon(plantIcons[playerid][id]);


                        PlantInfo[i][plantOwner] = -1;
                        PlantInfo[i][plantGrowTime] = -1;
                        PlantInfo[i][plantRothTime] = -1;
                        PlantInfo[i][plantPos][0] = 0.00;
                        PlantInfo[i][plantPos][1] = 0.00;
                        PlantInfo[i][plantPos][2] = 0.00;

                        Iter_Remove(iter_Plants, id);


                        new q[240];
                        mysql_format(SQL, q, sizeof q, "DELETE FROM `player_plants` WHERE `CharacterID` = '%d' AND `ID` = '%d'",
                                                        GetCharacterSQLID(playerid), PlantInfo[i][plantID]);
                        mysql_tquery(SQL, q);

                        new xRand = RandomMinMax(1, 8);

                        Inventory_AddItem(playerid, INVENTORY_ITEM_HASH, xRand);
                        ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.0, false, false, false, false, false);
                        SetTimerEx("Weed_RefreshPlayer", 5000, false, "d", playerid);      
                        
                        new tmp_str[488];
                        format(tmp_str, sizeof tmp_str, "Uspjesno ste uzbrali jednu stabljiku trave~n~\
                                                         Za svaku stabljiku trave, dobijete ~g~%dg ~w~trave", xRand);

                        Notify_SendNotification(playerid, tmp_str, "BERBA TRAVE", 19473);

                        break;
                    }
                }
            }
        }
        // Cocaine
        new HerbID = HerbIsNearPlayer(playerid);
        if(HerbID == INVALID_HERB_ID) return false;
        if(Inventory_GetItemQuantity(playerid, INVENTORY_ITEM_HERBS) >= 15)
                return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Vec posjedujete maksimalnu kolicinu retkih biljaka!");

        DestroyDynamicObject(HerbObject[HerbID]);
        Delete3DTextLabel(HerbLabel[HerbID]);
            
        HerbTimer[HerbID] = SetTimerEx("RespawnHerb", 240 * 1000, false, "d", HerbID);

        Inventory_AddItem(playerid, INVENTORY_ITEM_HERBS, 1);
        ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.0, false, false, false, false, false);
        SendClientMessage(playerid, x_server, "maryland \187; "c_white"Ubrao si retku biljku sa poda");
        
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid) {

    if(areaid == weed_zone) {

        Notify_SendNotification(playerid, "Usli ste u polje za posadjivanje trave~n~\
                                           Kako biste posadili travu koristite ~b~/posadi", 
                                           "PLANTAZA TRAVE", 
        19473);
    }

    //Cocaine
    for (new i = 0; i < MAX_HERBS; i++)
    {
        if(areaid == HerbArea[i])
        {
            if(IsValidDynamicObject(HerbObject[i]))
            {
                Notify_SendNotification(playerid, "U zoni ste retke biljke~n~\
                               Kako biste ubrali biljku ~b~[ N ]", 
                               "RARE HERBS", 
                    19473);
                break;
            }
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

//*==============================================================================
//?--->>> Commands
//*==============================================================================

YCMD:checkgrowth(playerid, params[], help) {

    new xBiljka;
    if(sscanf(params, "d", xBiljka)) return SendClientMessage(playerid, 0xFF0055FF, "/checkgrowth [ID Biljke]");

    foreach(new i : iter_Plants) {

        if(xBiljka == PlantInfo[i][plantID]) {

            if(PlantInfo[i][plantGrowTime] > gettime()) 
                SendClientMessage(playerid, 0xFF0056FF, "Grow time : "c_white"%s", convertTime(PlantInfo[i][plantGrowTime] - gettime()));
            if(PlantInfo[i][plantRothTime] > gettime())
                SendClientMessage(playerid, 0xFF0056FF, "Rott time : "c_white"%s", convertTime(PlantInfo[i][plantRothTime] - gettime()));
            break;
        }
    }

    return (true);
}

YCMD:posadi(playerid, params[], help) 
{
    if(Faction_PlayerGroupType(playerid) != FACTION_TYPE_FRIENDS || Faction_PlayerGroupType(playerid) != FACTION_TYPE_GANG)
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Morate biti clan bande ili ulicne grupe!");

    if(!IsPlayerInDynamicArea(playerid, weed_zone))
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Ne nalazite se kod plantaze za posadjivanje!");

    if(Inventory_GetItemQuantity(playerid, INVENTORY_ITEM_SEED) < 1)
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Nemate ni jedno sjeme za posadjivanje!");

    if(Weed_GetPlantedPlants(playerid) == 10)
        return Notify_SendNotification(playerid, "Presli ste maksimalan limit za stabljike~n~\
                                           Maksimalan limit stabljika za posaditi je ~b~10", 
                                           "~g~STABLJIKE", 
                19473);

    foreach(new i : iter_Plants) {

        if(IsPlayerInRangeOfPoint(playerid, 3.50, PlantInfo[i][plantPos][0], PlantInfo[i][plantPos][1], PlantInfo[i][plantPos][2])) 
            return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Blizu vas se nalazi stabljika, odmaknite se!");
    }

    Inventory_Remove(playerid, INVENTORY_ITEM_SEED, 1);
    ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.0, false, false, false, false, false);

    SendClientMessage(playerid, x_server, "maryland "c_white"Posadili ste sjeme trave, priblizno vrjeme rasta je 20 minuta.");
    SendClientMessage(playerid, x_server, "maryland "c_white"Kada stabljika naraste, necete biti obavjesteni!");

    new idx = Iter_Free(iter_Plants);
    
    PlantInfo[idx][plantOwner] = GetCharacterSQLID(playerid);
    PlantInfo[idx][plantGrowTime] = gettime() + 1200;
    PlantInfo[idx][plantRothTime] = -1;

    new Float:pPos[3];

    GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);

    PlantInfo[idx][plantPos][0] = pPos[0];
    PlantInfo[idx][plantPos][1] = pPos[1];
    PlantInfo[idx][plantPos][2] = pPos[2];

    new q[420];
    mysql_format(SQL, q, sizeof q, "INSERT INTO `player_plants` (`CharacterID`, `GrowTime`, `RothTime`, `posX`, `posY`, `posZ`)\
                      VALUES ('%d', '%d', '%d', '%f', '%f', '%f')", 
                      PlantInfo[idx][plantOwner], PlantInfo[idx][plantGrowTime],
                      PlantInfo[idx][plantRothTime], PlantInfo[idx][plantPos][0],
                      PlantInfo[idx][plantPos][1], PlantInfo[idx][plantPos][2]);
    mysql_tquery(SQL, q, "mysql_InsertPlantID", "d", idx);


    return 1;
}

YCMD:fml(playerid, params[], help) 
{   
    foreach(new i : iter_Plants) {

        if(IsPlayerInRangeOfPoint(playerid, 3.50, PlantInfo[i][plantPos][0], PlantInfo[i][plantPos][1], PlantInfo[i][plantPos][2])) 
            return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Blizu vas se nalazi stabljika, odmaknite se!");
    }
    return 1;
}

YCMD:uberi(playerid, params[], help) 
{

    new bool:foundPlant;

    foreach(new i : iter_Plants) {

        if(GetCharacterSQLID(playerid) == PlantInfo[i][plantOwner]) {

            if(PlantInfo[i][plantGrowTime] < gettime()) {
                foundPlant = true;
                if(!IsValidDynamicMapIcon(plantIcons[playerid][PlantInfo[i][plantID]]))
                    plantIcons[playerid][PlantInfo[i][plantID]] = CreateDynamicMapIcon(PlantInfo[i][plantPos][0], PlantInfo[i][plantPos][1], PlantInfo[i][plantPos][2], 0, x_green, 0, 0, playerid);
            }
        }
    }

    if(foundPlant) {
        if(weedHarvesting[playerid]) return (true);

        Notify_SendNotification(playerid, "Vase zrele biljke su trenutno oznace na mapi zelenom bojom~n~\
                                           Da uzberete biljku pritisnite tipku ~b~N", 
                                           "PLANTAZA TRAVE", 
        19473);

        weedHarvesting[playerid] = true;
    }

    return 1;
}
//*==============================================================================
//?--->>> Dialogs
//*==============================================================================
Dialog:dialog_BlackMarket(playerid, response, listitem, string:inputtext[]) {

    if(response) {

        switch(listitem) {

            case 0: {

                if(GetPlayerMoney(playerid) < 100)
                    return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Za jedno sjeme trave potrebno vam je 100$!");

                if(Inventory_GetItemQuantity(playerid, INVENTORY_ITEM_SEED) >= 10)
                    return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Vec posjedujete maksimalnu kolicinu sjemena za travu!");

                GivePlayerMoney(playerid, -100);
                Inventory_AddItem(playerid, INVENTORY_ITEM_SEED, 1);
                SendClientMessage(playerid, x_server, "maryland \187; "c_white"Uspjesno ste kupili jedno sjeme trave za 100$");
            }
        }
    }
    return (true);
}
