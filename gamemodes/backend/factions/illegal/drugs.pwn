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

// * MDMA

#define MAX_TEMP_Y_2      (340.00)

new temperatureCount[MAX_PLAYERS];
new bool:cookingMdma[MAX_PLAYERS];
new cookingMdma_Warnings[MAX_PLAYERS];
new bool:cookingDecrease[MAX_PLAYERS];
new MdmaCookTimer[MAX_PLAYERS];

new PlayerText:temperatureProgress[MAX_PLAYERS];
new PlayerText:TemperatureCheck[MAX_PLAYERS][4];

new Float:temperatureValue[MAX_PLAYERS];

//*==============================================================================
//?--->>> Querys & Funcs
//*==============================================================================

forward updatebar(playerid);
public updatebar(playerid) {
    if (cookingDecrease[playerid]) {
        temperatureValue[playerid] -= 0.7; 
        if (temperatureValue[playerid] < 0.0) {
            temperatureValue[playerid] = 0.0; 
        }
    }
    
    UpdateTemperatureTextDraw(playerid, -1, temperatureValue[playerid]);
}

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

stock MDMA_ReturnPlayerIngridients(playerid) {

    /*

    * --> INVENTORY_ITEM_DISTILLED_WATER, 
    * --> INVENTORY_ITEM_ALCOHOL,         
    * --> INVENTORY_ITEM_OMEPRAZOLE

    * --> 2L of Distiled Water | 1L of Rubbing Alcohol | 5g of Omeprazole

    */

    if(Inventory_GetItemQuantity(playerid, INVENTORY_ITEM_DISTILLED_WATER) >= 2 &&
       Inventory_GetItemQuantity(playerid, INVENTORY_ITEM_ALCOHOL) >= 1 &&
       Inventory_GetItemQuantity(playerid, INVENTORY_ITEM_OMEPRAZOLE) >= 5)
        return true;

    return false;
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

stock UpdateTemperatureTextDraw(playerid, count, Float:value) {

    new temp[48];
    format(temp, sizeof temp, "Temperature: %.2f", temperatureValue[playerid]);
    PlayerTextDrawSetString(playerid, TemperatureCheck[playerid][2], temp); // Update the text draw string

    new Float:tempPos[2];
    new Float:mtyX;
    PlayerTextDrawGetPos(playerid, TemperatureCheck[playerid][0], mtyX, tempPos[0]);
    PlayerTextDrawGetPos(playerid, TemperatureCheck[playerid][1], mtyX, tempPos[1]);

    if(count == 15) {

        PlayerTextDrawSetPos(playerid, TemperatureCheck[playerid][0], 97.999977 + 30, tempPos[0] + 1.00);
        PlayerTextDrawSetPos(playerid, TemperatureCheck[playerid][1], 97.999977 + 30, tempPos[1] - 1.00);

        PlayerTextDrawShow(playerid,  TemperatureCheck[playerid][0]);
        PlayerTextDrawShow(playerid,  TemperatureCheck[playerid][1]);

        new Float:tmpX, Float:tmpY;

        PlayerTextDrawGetPos(playerid, TemperatureCheck[playerid][0], mtyX, tmpX);
        PlayerTextDrawGetPos(playerid, TemperatureCheck[playerid][1], mtyX, tmpY);

        new Float:prog[2];
        PlayerTextDrawGetTextSize(playerid, temperatureProgress[playerid], prog[0], prog[1]);

        new Float:absVal = floatabs(prog[1]);

        if( ( absVal + 315.00 ) > tmpY) {   
            
            cookingMdma_Warnings[playerid]++;

            if(cookingMdma_Warnings[playerid] >= 4) {
                
                SendClientMessage(playerid, x_server, "maryland \187; "c_white"Kuvanje MDME vam je propalo.");

                ResetMdmaCooking(playerid);

                return Y_HOOKS_CONTINUE_RETURN_1;
            }

            SendClientMessage(playerid, x_server, "maryland \187; "c_white"Pripazi na temperaturu - %d/3", cookingMdma_Warnings[playerid]);
        }

        if(  tmpX == tmpY ) {
            
            // *            | --> Finish Cooking <-- |

            new xDivider = 1;

            if(cookingMdma_Warnings[playerid] > 0)
                xDivider = cookingMdma_Warnings[playerid] + 1;

            new quantity = RandomMinMax(4, 10);
            quantity =  floatround( (quantity / xDivider), floatround_ceil );

            // Inventory_AddItem(playerid, INVENTORY_ITEM_MDMA, quantity);
            MDMA_Interface(playerid, false);

            new header[228];
            format(header, sizeof header, "Uspjesno ste zavrsili kuvanje MDME ~n~\
                                           Za uspjesno kuvanje ste dobili ~r~%dg ~w~mdme", quantity);

            Notify_SendNotification(playerid, header, 
                                              "MDMA", 1241);
            ResetMdmaCooking(playerid);

            return Y_HOOKS_BREAK_RETURN_1;
        }

        temperatureCount[playerid] = 0;

    }

    PlayerTextDrawTextSize(playerid, temperatureProgress[playerid], 5.000000, -value);
    PlayerTextDrawShow(playerid,  temperatureProgress[playerid]);

    return true;

}

stock ResetMdmaCooking(playerid) 
{
    cookingMdma[playerid] = false;
    cookingMdma_Warnings[playerid] = 0;
    temperatureCount[playerid] = 0;
    cookingDecrease[playerid] = false;
    KillTimer(MdmaCookTimer[playerid]);
    MDMA_Interface(playerid, false);

    return true;
}

stock MDMA_Interface(playerid, bool:show) {
    if (show) {
        for (new i = 0; i < sizeof TemperatureCheck[]; i++) {
            PlayerTextDrawHide(playerid, TemperatureCheck[playerid][i]);
            PlayerTextDrawDestroy(playerid, TemperatureCheck[playerid][i]);
            TemperatureCheck[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
        }

        new Float:lineYPosition = 306.00; // 
        new Float:lineYPosition2 = 380.0; //
        
        temperatureProgress[playerid] = CreatePlayerTextDraw(playerid, 124.532798, 373.551055, "ld_spac:white");
        PlayerTextDrawTextSize(playerid, temperatureProgress[playerid], 8.000000, 0.00);
        PlayerTextDrawAlignment(playerid, temperatureProgress[playerid], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, temperatureProgress[playerid], -1);
        PlayerTextDrawSetShadow(playerid, temperatureProgress[playerid], 0);
        PlayerTextDrawBackgroundColour(playerid, temperatureProgress[playerid], 255);
        PlayerTextDrawFont(playerid, temperatureProgress[playerid], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, temperatureProgress[playerid], false);

        TemperatureCheck[playerid][0] = CreatePlayerTextDraw(playerid, 97.999977 + 30.00, lineYPosition, "-------"); // * Current temp
        PlayerTextDrawLetterSize(playerid, TemperatureCheck[playerid][0], 0.400000, 1.600000);
        PlayerTextDrawAlignment(playerid, TemperatureCheck[playerid][0], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, TemperatureCheck[playerid][0], -16776961);
        PlayerTextDrawSetShadow(playerid, TemperatureCheck[playerid][0], 0);
        PlayerTextDrawBackgroundColour(playerid, TemperatureCheck[playerid][0], 255);
        PlayerTextDrawFont(playerid, TemperatureCheck[playerid][0], TEXT_DRAW_FONT_1);
        PlayerTextDrawSetProportional(playerid, TemperatureCheck[playerid][0], true);

        // Create second line
        TemperatureCheck[playerid][1] = CreatePlayerTextDraw(playerid, 97.999977 + 30.00, lineYPosition2, "-------"); // Max Temp
        PlayerTextDrawLetterSize(playerid, TemperatureCheck[playerid][1], 0.400000, 1.600000);
        PlayerTextDrawAlignment(playerid, TemperatureCheck[playerid][1], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, TemperatureCheck[playerid][1], 65535);
        PlayerTextDrawSetShadow(playerid, TemperatureCheck[playerid][1], 0);
        PlayerTextDrawBackgroundColour(playerid, TemperatureCheck[playerid][1], 255);
        PlayerTextDrawFont(playerid, TemperatureCheck[playerid][1], TEXT_DRAW_FONT_1);
        PlayerTextDrawSetProportional(playerid, TemperatureCheck[playerid][1], true);
        
        // Create temperature display
        new temp[48];
        format(temp, sizeof temp, "Temperature: %.2f", temperatureValue[playerid]);
        TemperatureCheck[playerid][2] = CreatePlayerTextDraw(playerid, 97.999977 + 30.00, 404.459259, temp);
        PlayerTextDrawLetterSize(playerid, TemperatureCheck[playerid][2], 0.122666, 0.708147);
        PlayerTextDrawAlignment(playerid, TemperatureCheck[playerid][2], TEXT_DRAW_ALIGN_CENTER);
        PlayerTextDrawColour(playerid, TemperatureCheck[playerid][2], -1);
        PlayerTextDrawSetShadow(playerid, TemperatureCheck[playerid][2], 0);
        PlayerTextDrawBackgroundColour(playerid, TemperatureCheck[playerid][2], 255);
        PlayerTextDrawFont(playerid, TemperatureCheck[playerid][2], TEXT_DRAW_FONT_1);
        PlayerTextDrawSetProportional(playerid, TemperatureCheck[playerid][2], true);

        for (new i = 0; i < sizeof TemperatureCheck[]; i++) {
            PlayerTextDrawShow(playerid, TemperatureCheck[playerid][i]);
        }
    } else {
        for (new i = 0; i < sizeof TemperatureCheck[]; i++) {
            PlayerTextDrawHide(playerid, TemperatureCheck[playerid][i]);
            PlayerTextDrawDestroy(playerid, TemperatureCheck[playerid][i]);
            TemperatureCheck[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
        }
    }
}

//*==============================================================================
//?--->>> Hooks
//*==============================================================================

hook OnGameModeInit() {

    print("factions/drugs.pwn > Drugs loaded.");

    weed_zone = CreateDynamicRectangle(1889, 183.5, 2042, 242.5, 0, 0);

    Create3DTextLabel(""c_server"\187; "c_white"Black Market "c_server"\171;\n"c_white"[ N ]", -1, -396.7119,1275.0776,8.0296, 4.50, 0);

    mysql_tquery(SQL, "SELECT * FROM `player_plants`", "mysql_LoadPlantData");

    // CreateAllHerbs();

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerConnect(playerid) {

    for(new i = 0; i < sizeof plantIcons[]; i++) {

        DestroyDynamicMapIcon(plantIcons[playerid][i]);
    }

    weedHarvesting[playerid] = false;

    ResetMdmaCooking(playerid);

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
                        ApplyAnimation(playerid, !"BOMBER", !"BOM_Plant_Loop", 4.0, false, false, false, false, false, SYNC_NONE);
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
        //* -> MDMA
        if(cookingMdma[playerid])
        {
            temperatureValue[playerid] += 1.5;
            if (temperatureValue[playerid] > 100.0) { 
                temperatureValue[playerid] = 100.0; 
            }
            if(temperatureCount[playerid] < 15) {
                temperatureCount[playerid]++;
                UpdateTemperatureTextDraw(playerid, temperatureCount[playerid], temperatureValue[playerid]);
                return Y_HOOKS_CONTINUE_RETURN_1;
            }

            else if(temperatureCount[playerid] > 15) {
                
                temperatureCount[playerid] = 0;
                UpdateTemperatureTextDraw(playerid, temperatureCount[playerid], temperatureValue[playerid]);
                return Y_HOOKS_CONTINUE_RETURN_1;
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
        ApplyAnimation(playerid, !"BOMBER", !"BOM_Plant_Loop", 4.0, false, false, false, false, false, SYNC_NONE);
        SendClientMessage(playerid, x_server, "maryland \187; "c_white"Ubrao si retku biljku sa poda");

    }

    if(RELEASED(KEY_NO))
    {
        if(cookingMdma[playerid]) { cookingDecrease[playerid] = true; }
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

// YCMD:cookmdma(playerid, params[], help) {

//     if(!MDMA_ReturnPlayerIngridients(playerid))
//         return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Nemate sastojke za pripremu mdme");

//     if(cookingMdma[playerid]) 
//         return SendClientMessage(playerid, -1, "DEBUG: He cookin already");

//     // Notify_SendNotification(playerid, "Zapoceli ste proces kuvanja MDME ~n~ \
//     //                                   Kako bi povecali temperaturu pritisnite gumb ~b~ [ N ]",
//     //                                   "MDMA", 
//     // 1241);

//     MDMA_Interface(playerid, true);
//     MdmaCookTimer[playerid] = SetTimerEx("updatebar", 100, true, "d", playerid);

//     cookingMdma[playerid] = true;

//     return 1;
// }

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
    if(Faction_PlayerGroupType(playerid) != FACTION_TYPE_GANG)
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Morate biti clan bande!");

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
    ApplyAnimation(playerid, !"BOMBER", !"BOM_Plant_Loop", 4.0, false, false, false, false, false, SYNC_NONE);

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

            case 3: {

                if(GetPlayerMoney(playerid) < 450.55)
                    return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Za jedno sjeme trave potrebno vam je 450.55$!");

                if(Inventory_GetItemQuantity(playerid, INVENTORY_ITEM_JAMMER) == 1)
                    return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Vec posjedujete ometac signala!");

                GivePlayerMoney(playerid, -450.55);
                Inventory_AddItem(playerid, INVENTORY_ITEM_JAMMER, 1);
                SendClientMessage(playerid, x_server, "maryland \187; "c_white"Uspjesno ste kupili ometac za 450.55$");

            }
        }
    }
    return (true);
}
