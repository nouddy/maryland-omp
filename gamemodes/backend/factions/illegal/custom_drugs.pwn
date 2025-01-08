/***
 *    Custom Drug System
 *    Author: Your Name
 *    Description: Handles drug production, effects, and related functionality
 */

#include <ysilib\YSI_Coding\y_hooks>

// ========================================================================
// Constants
// ========================================================================

// Effect durations (in milliseconds)
#define SPEED_EFFECT_TIME     120000  // 2 minutes
#define MUSHROOM_EFFECT_TIME  180000  // 3 minutes
#define COCAINE_EFFECT_TIME   180000  // 3 minutes
#define PRODUCTION_TIME       180000  // 5 minutes
#define COCA_GROWTH_TIME      600000  // 10 minutes

// ========================================================================
// Enums & Structures
// ========================================================================

// Available drug types
enum E_DRUG_TYPES {
    DRUG_SPEED,
    DRUG_MUSHROOMS,
    DRUG_COCAINE
}

// Required ingredients for production
enum E_DRUG_INGREDIENTS {
    ING_PSEUDOEPHEDRINE,    // For Speed
    ING_CHEMICALS,          // For Speed
    ING_LAB_EQUIPMENT,      // For Speed
    ING_MUSHROOMS,          // For Mushrooms
    ING_COCA_LEAVES,        // For Cocaine
    ING_GASOLINE,          // For Cocaine
    ING_OMEPRAZOL          // For Cocaine
}

// Player-specific drug data
enum E_PLAYER_DRUG_DATA {
    bool:pIsProducingDrugs,
    pDrugProductionTimer,
    pDrugEffectTimer,
    Float:pOriginalRunSpeed,
    bool:pUnderInfluence,
    pPlantedCoca[3]        // Max 3 coca plants per player
}

// ========================================================================
// Variables
// ========================================================================

new gPlayerDrugData[MAX_PLAYERS][E_PLAYER_DRUG_DATA];
// ========================================================================
// Player Speed Functions
// ========================================================================

Float:GetPlayerRunSpeed(playerid) {
    if(!IsPlayerConnected(playerid)) return 1.0;
    return gPlayerDrugData[playerid][pOriginalRunSpeed];
}

SetPlayerRunSpeed(playerid, Float:speed) {
    if(!IsPlayerConnected(playerid)) return 0;
    
    gPlayerDrugData[playerid][pOriginalRunSpeed] = speed;
    return 1;
}

// ========================================================================
// Dialog Handlers
// ========================================================================

Dialog:DRUGS_MAIN(playerid, response, listitem, string: inputtext[]) {
    if(!response) return 1;
    
    switch(listitem) {
        case 0: ShowSpeedProductionDialog(playerid);
        case 1: ShowMushroomProductionDialog(playerid);
        case 2: ShowCocaineProductionDialog(playerid);
    }
    return 1;
}

Dialog:DRUGS_SPEED(playerid, response, listitem, string: inputtext[]) {
    if(!response) return ShowMainDrugDialog(playerid);
    
    if(!IsPlayerInDrugZone(playerid, DRUG_SPEED))
        return SendClientMessage(playerid, x_red, "Nisi na odgovarajucoj lokaciji!");
    
    StartDrugProduction(playerid, _:DRUG_SPEED);
    return 1;
}

Dialog:DRUGS_MUSHROOMS(playerid, response, listitem, string: inputtext[]) {
    if(!response) return ShowMainDrugDialog(playerid);
    
    if(!IsPlayerInDrugZone(playerid, DRUG_MUSHROOMS))
        return SendClientMessage(playerid, x_red, "Nisi na odgovarajucoj lokaciji!");
    
    StartDrugProduction(playerid, _:DRUG_MUSHROOMS);
    return 1;
}

Dialog:DRUGS_COCAINE(playerid, response, listitem, string: inputtext[]) {
    if(!response) return ShowMainDrugDialog(playerid);
    
    if(!IsPlayerInDrugZone(playerid, DRUG_COCAINE))
        return SendClientMessage(playerid, x_red, "Nisi na odgovarajucoj lokaciji!");
    
    StartDrugProduction(playerid, _:DRUG_COCAINE);
    return 1;
}

// ========================================================================
// Helper Functions
// ========================================================================

ShowMainDrugDialog(playerid) {
    return Dialog_Show(playerid, DRUGS_MAIN, DIALOG_STYLE_LIST,
        "Proizvodnja droge",
        "Speed\nPecurke\nKokain",
        "Izaberi", "Izadji");
}

ShowSpeedProductionDialog(playerid) {
    return Dialog_Show(playerid, DRUGS_SPEED, DIALOG_STYLE_MSGBOX,
        "Proizvodnja Speed-a",
        "Da li zelis da zapocnes proizvodnju Speed-a?\n\n\
        Potrebni sastojci:\n\
        - Pseudoefedrin\n\
        - Hemikalije\n\
        - Laboratorijska oprema\n\n\
        Vreme proizvodnje: 5 minuta",
        "Start", "Nazad");
}

ShowMushroomProductionDialog(playerid) {
    return Dialog_Show(playerid, DRUGS_MUSHROOMS, DIALOG_STYLE_MSGBOX,
        "Susenje pecuraka",
        "Da li zelis da zapocnes susenje pecuraka?\n\n\
        Potrebni sastojci:\n\
        - Sveze pecurke\n\n\
        Vreme susenja: 5 minuta",
        "Start", "Nazad");
}

ShowCocaineProductionDialog(playerid) {
    return Dialog_Show(playerid, DRUGS_COCAINE, DIALOG_STYLE_MSGBOX,
        "Proizvodnja kokaina",
        "Da li zelis da zapocnes proizvodnju kokaina?\n\n\
        Potrebni sastojci:\n\
        - Koka listovi\n\
        - Benzin\n\
        - Omeprazol\n\n\
        Vreme proizvodnje: 5 minuta",
        "Start", "Nazad");
}

Drugs_CheckValidPreparation(playerid, drugType) {

    switch(E_DRUG_TYPES:drugType) {

        // Kemikalije - 5  Alkohol - 1  Destilovana Voda - 2 --> Spidara

        case DRUG_SPEED: {

            if(Inventory_GetItemQuantity(playerid, INVENTORY_ITEM_CHEMICALS) != 5 && Inventory_GetItemQuantity(playerid, INVENTORY_ITEM_ALCOHOL) != 1 \
              && Inventory_GetItemQuantity(playerid, INVENTORY_ITEM_DISTILLED_WATER) != 2)
            {
                SendClientMessage(playerid, x_green, "DRUG-LAB: Nemate dovoljnu kolicinu potrebnih stvari za proces prerade!");
                return ~1;
            }
        }

        case DRUG_COCAINE: {

            if(Inventory_GetItemQuantity(playerid, INVENTORY_ITEM_CHEMICALS) != 5 && Inventory_GetItemQuantity(playerid, INVENTORY_ITEM_ALCOHOL) != 1 \
              && Inventory_GetItemQuantity(playerid, INVENTORY_ITEM_DISTILLED_WATER) != 2 && Inventory_GetItemQuantity(playerid, INVENTORY_ITEM_HERBS) != 7)
                {
                SendClientMessage(playerid, x_green, "DRUG-LAB: Nemate dovoljnu kolicinu potrebnih stvari za proces prerade!");
                return ~1;
            }
        }

        case DRUG_MUSHROOMS: {

            if(Inventory_GetItemQuantity(playerid, INVENTORY_ITEM_CHEMICALS) != 5 && Inventory_GetItemQuantity(playerid, INVENTORY_ITEM_LAB_EQUIPMENT) != 1 \
              && Inventory_GetItemQuantity(playerid, INVENTORY_ITEM_HERBS) != 5)
            {
                SendClientMessage(playerid, x_green, "DRUG-LAB: Nemate dovoljnu kolicinu potrebnih stvari za proces prerade!");
                return ~1;
            }
        }
    }

    return (1);
}

StartDrugProduction(playerid, drugType) {
    if(!IsPlayerConnected(playerid)) return 0;

    Drugs_CheckValidPreparation(playerid, drugType);

    if(gPlayerDrugData[playerid][pIsProducingDrugs]) 
        return SendClientMessage(playerid, x_red, "DRUG-LAB: Vec proizvodis drogu!");

    gPlayerDrugData[playerid][pIsProducingDrugs] = true;
    gPlayerDrugData[playerid][pDrugProductionTimer] = SetTimerEx("FinishDrugProduction", PRODUCTION_TIME, false, "dd", playerid, drugType);

    TogglePlayerControllable(playerid, false);

    new message[64];
    format(message, sizeof(message), "DRUG-LAB: Zapoceo si proizvodnju %s. Sacekaj 5 minuta.", 
        GetDrugName(E_DRUG_TYPES:drugType));
    SendClientMessage(playerid, x_green, message);
    return 1;
}

GetDrugName(E_DRUG_TYPES:drugType) {
    new drugName[32];
    switch(drugType) {
        case DRUG_SPEED: drugName = "Speed-a";
        case DRUG_MUSHROOMS: drugName = "pecuraka";
        case DRUG_COCAINE: drugName = "kokaina";
        default: drugName = "nepoznato";
    }
    return drugName;
}

// ========================================================================
// Commands
// ========================================================================

YCMD:droge(playerid, params[], help) {
    if(!IsPlayerInAnyDrugZone(playerid))
        return SendClientMessage(playerid, x_red, "DRUG-LAB: Nisi na odgovarajucoj lokaciji!");
    
    return ShowMainDrugDialog(playerid);
}

// ========================================================================
// Location & Zone Functions
// ========================================================================

IsPlayerInDrugZone(playerid, E_DRUG_TYPES:drugType) {
    if(!IsPlayerConnected(playerid)) return false;
    
    switch(drugType) {
        case DRUG_SPEED: {
            if(IsPlayerInRangeOfPoint(playerid, 3.0, -2415.0857,-2466.1589,-77.8954))
                return (true);
        }
        case DRUG_MUSHROOMS: {
            if(IsPlayerInRangeOfPoint(playerid, 3.0, -2415.0857,-2466.1589,-77.8954))
                return (true);
        }
        case DRUG_COCAINE: {
            if(IsPlayerInRangeOfPoint(playerid, 3.0, -2415.0857,-2466.1589,-77.8954))
                return (true);
        }
    }
    return false;
}

IsPlayerInAnyDrugZone(playerid) {
    if(!IsPlayerConnected(playerid)) return 0;
    
    if(IsPlayerInDrugZone(playerid, DRUG_SPEED)) return 1;
    if(IsPlayerInDrugZone(playerid, DRUG_MUSHROOMS)) return 1;
    if(IsPlayerInDrugZone(playerid, DRUG_COCAINE)) return 1;
    
    return 0;
}

// ========================================================================
// Drug Effects System
// ========================================================================

ApplyDrugEffect(playerid, drugType) {
    if(!IsPlayerConnected(playerid)) return 0;
    if(gPlayerDrugData[playerid][pUnderInfluence])
        return SendClientMessage(playerid, x_red, "DRUGS: Vec si pod uticajem droge!");

    switch(drugType) {
        case INVENTORY_ITEM_SPEED: {
            // Store original speed and apply boost
            // Visual effects
            SetPlayerDrunkLevel(playerid, 6000);
            
            // Start effect timer
            gPlayerDrugData[playerid][pUnderInfluence] = true;
            gPlayerDrugData[playerid][pDrugEffectTimer] = SetTimerEx("DrugEffectTimeout", 
                SPEED_EFFECT_TIME, false, "ii", playerid, _:DRUG_SPEED);
        }
        case INVENTORY_ITEM_SHROOMS: {
            // Visual and weather effects
            SetPlayerWeather(playerid, random(20));
            SetPlayerDrunkLevel(playerid, 7000);
            
            // Start hallucination effects
            gPlayerDrugData[playerid][pUnderInfluence] = true;
            gPlayerDrugData[playerid][pDrugEffectTimer] = SetTimerEx("DrugEffectTimeout", 
                MUSHROOM_EFFECT_TIME, false, "ii", playerid, _:DRUG_MUSHROOMS);
            
            // Update hallucinations every 10 seconds
            SetTimerEx("UpdateHallucination", 10000, true, "i", playerid);
        }
        case INVENTORY_ITEM_COCAINE: {
            // Speed and armor boost
            gPlayerDrugData[playerid][pOriginalRunSpeed] = GetPlayerRunSpeed(playerid);
            SetPlayerRunSpeed(playerid, gPlayerDrugData[playerid][pOriginalRunSpeed] * 1.2);
            
            new Float:currentArmor;
            GetPlayerArmour(playerid, currentArmor);
            SetPlayerArmour(playerid, currentArmor + 20.0);
            
            // Start effect timer
            gPlayerDrugData[playerid][pUnderInfluence] = true;
            gPlayerDrugData[playerid][pDrugEffectTimer] = SetTimerEx("DrugEffectTimeout", 
                COCAINE_EFFECT_TIME, false, "ii", playerid, _:DRUG_COCAINE);
        }
    }

    Inventory_Remove(playerid, drugType, 5);

    return 1;
}

// ========================================================================
// Callbacks & Timers
// ========================================================================

forward FinishDrugProduction(playerid, drugType);
public FinishDrugProduction(playerid, drugType) {
    
    if(playerid == INVALID_PLAYER_ID) return 0;
    if(!IsPlayerConnected(playerid)) return 0;
    
    gPlayerDrugData[playerid][pIsProducingDrugs] = false;
    TogglePlayerControllable(playerid, true);
    
    
    new message[128];
    format(message, sizeof(message), "DRUG-LAB: Uspesno si proizveo %s!", GetDrugName(E_DRUG_TYPES:drugType));
    SendClientMessage(playerid, x_green, message);

    switch(E_DRUG_TYPES:drugType) {

        case DRUG_COCAINE: {

            Inventory_AddItem(playerid, INVENTORY_ITEM_COCAINE, 10);
        }

        case DRUG_SPEED: {

            Inventory_AddItem(playerid, INVENTORY_ITEM_SPEED, 15);
        }

        case DRUG_MUSHROOMS: {

            Inventory_AddItem(playerid, INVENTORY_ITEM_SHROOMS, 20);
        }
    }

    return 1;
}

forward DrugEffectTimeout(playerid, drugType);
public DrugEffectTimeout(playerid, drugType) {
    if(!IsPlayerConnected(playerid)) return 0;

    switch(E_DRUG_TYPES:drugType) {
        case DRUG_SPEED: {
            if(random(100) < 20) { // 20% chance of overdose
                new Float:health;
                GetPlayerHealth(playerid, health);
                SetPlayerHealth(playerid, health - 20.0);
                GameTextForPlayer(playerid, "~r~Overdose!", 3000, 3);
            }
            SetPlayerRunSpeed(playerid, gPlayerDrugData[playerid][pOriginalRunSpeed]);
            SetPlayerDrunkLevel(playerid, 0);
        }
        case DRUG_MUSHROOMS: {
            SetPlayerWeather(playerid, 0);
            SetPlayerDrunkLevel(playerid, 0);
            if(random(100) < 30) { // 30% chance of bad trip
                new Float:health;
                GetPlayerHealth(playerid, health);
                SetPlayerHealth(playerid, health - 10.0);
                GameTextForPlayer(playerid, "~r~Bad Trip!", 3000, 3);
            }
        }
        case DRUG_COCAINE: {
            SetPlayerRunSpeed(playerid, gPlayerDrugData[playerid][pOriginalRunSpeed]);
            
            // Cocaine crash effect
            new Float:health;
            GetPlayerHealth(playerid, health);
            SetPlayerHealth(playerid, health - 15.0);
            GameTextForPlayer(playerid, "~r~Crash!", 3000, 3);
            
            // Slow effect for 1 minute
            SetPlayerRunSpeed(playerid, gPlayerDrugData[playerid][pOriginalRunSpeed] * 0.8);
            SetTimerEx("RestorePlayerSpeed", 60000, false, "i", playerid);
        }
    }
    
    gPlayerDrugData[playerid][pUnderInfluence] = false;
    return 1;
}

forward UpdateHallucination(playerid);
public UpdateHallucination(playerid) {
    if(!IsPlayerConnected(playerid)) return 0;
    if(!gPlayerDrugData[playerid][pUnderInfluence]) return 0;
    
    SetPlayerWeather(playerid, random(20));
    SetPlayerTime(playerid, random(24), 0);
    return 1;
}

forward RestorePlayerSpeed(playerid);
public RestorePlayerSpeed(playerid) {
    if(!IsPlayerConnected(playerid)) return 0;
    SetPlayerRunSpeed(playerid, gPlayerDrugData[playerid][pOriginalRunSpeed]);
    return 1;
}

// ========================================================================
// Hooks
// ========================================================================

hook OnPlayerConnect(playerid) {
    // Reset all drug-related data
    gPlayerDrugData[playerid][pIsProducingDrugs] = false;
    gPlayerDrugData[playerid][pUnderInfluence] = false;
    gPlayerDrugData[playerid][pOriginalRunSpeed] = 0.0;
    
    for(new i = 0; i < 3; i++) {
        gPlayerDrugData[playerid][pPlantedCoca][i] = 0;
    }
    return 1;
}

hook OnPlayerDisconnect(playerid, reason) {
    // Clean up timers
    KillTimer(gPlayerDrugData[playerid][pDrugProductionTimer]);
    KillTimer(gPlayerDrugData[playerid][pDrugEffectTimer]);
    return 1;
}

hook OnPlayerDeath(playerid, killerid, reason) {
    // Reset drug effects on death
    if(gPlayerDrugData[playerid][pUnderInfluence]) {
        SetPlayerWeather(playerid, 0);
        SetPlayerTime(playerid, 12, 0);
        SetPlayerDrunkLevel(playerid, 0);
        if(gPlayerDrugData[playerid][pOriginalRunSpeed] > 0) {
            SetPlayerRunSpeed(playerid, gPlayerDrugData[playerid][pOriginalRunSpeed]);
        }
    }
    return 1;
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys) {

    if(PRESSED(KEY_SECONDARY_ATTACK)) {

        if(IsPlayerInRangeOfPoint(playerid, 3.0, 800.8521,-545.9084,16.3359))
        {
            SetPlayerCompensatedPos(playerid, -2406.4624,-2447.5037,-77.8954, 0, 28);
            SetPlayerFacingAngle(playerid, 180.0);
            return ~1;
        }

        if(IsPlayerInRangeOfPoint(playerid, 3.0, -2406.4624,-2447.5037,-77.8954)) {

            SetPlayerCompensatedPos(playerid, 800.8521,-545.9084,16.3359, 0, 0);
            SetPlayerFacingAngle(playerid, 180.0);
            return ~1;
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

// ========================================================================
// Drug Dealer Actor System
// ========================================================================

// Constants
#define MAX_DRUG_DEALERS     3
#define DEALER_CHANGE_TIME   3600000  // 1 hour in milliseconds
#define DEALER_SKIN_ID       179      // Default dealer skin

// Dealer locations array (not real, change it)
new Float:gDealerLocations[][] = {
    { 992.7467,-1084.8202,26.0313,135.8911 },
    { 1937.9640,-1067.0531,24.4174,311.6073},
    { 2698.0137,-1116.9785,69.5781,175.8074},
    { 2840.2112,-1345.9681,11.0625,345.8921},
    { 2209.4211,-2532.9670,13.5469,1.9793 },
    { 2058.5972,-2151.6001,13.6328,84.7816},
    { 1395.2142,-1894.2020,13.4873,89.6369}
};

// Dealer data structure
enum E_DEALER_DATA {
    STREAMER_TAG_ACTOR:dealerActorID,
    dealerLocationIndex,
    bool:dealerInUse,
    dealerUpdateTimer
}
new gDealerData[MAX_DRUG_DEALERS][E_DEALER_DATA];

// ========================================================================
// Dealer Functions
// ========================================================================

CreateDrugDealers() {
    for(new i = 0; i < MAX_DRUG_DEALERS; i++) {
        SpawnRandomDealer(i);
    }
    return 1;
}

SpawnRandomDealer(dealerid) {
    if(dealerid < 0 || dealerid >= MAX_DRUG_DEALERS) return 0;
    
    // If dealer already exists, destroy it
    if(IsValidDynamicActor(gDealerData[dealerid][dealerActorID])) {
        DestroyDynamicActor(gDealerData[dealerid][dealerActorID]);
        gDealerData[dealerid][dealerActorID] = INVALID_STREAMER_ID;
    }
    
    // Find unused location
    new locationIndex;
    do {
        locationIndex = random(sizeof(gDealerLocations));
    } while(IsLocationUsedByDealer(locationIndex));
    
    // Create new dealer
    gDealerData[dealerid][dealerLocationIndex] = locationIndex;
    gDealerData[dealerid][dealerInUse] = true;
    gDealerData[dealerid][dealerActorID] = CreateDynamicActor(DEALER_SKIN_ID,
        gDealerLocations[locationIndex][0],
        gDealerLocations[locationIndex][1],
        gDealerLocations[locationIndex][2],
        gDealerLocations[locationIndex][3],
        true,  // Invulnerable
        100.0, // Stream distance
        0,     // World
        -1     // Interior
    );
    
    printf("[DEALERS]: Dealer ID %d has ben created", dealerid);

    // Set up next location change
    if(gDealerData[dealerid][dealerUpdateTimer]) {
        KillTimer(gDealerData[dealerid][dealerUpdateTimer]);
    }
    gDealerData[dealerid][dealerUpdateTimer] = SetTimerEx("UpdateDealerLocation", 
        DEALER_CHANGE_TIME, false, "i", dealerid);
    
    return 1;
}

IsLocationUsedByDealer(locationIndex) {
    for(new i = 0; i < MAX_DRUG_DEALERS; i++) {
        if(gDealerData[i][dealerInUse] && gDealerData[i][dealerLocationIndex] == locationIndex) {
            return 1;
        }
    }
    return 0;
}

IsPlayerNearDealer(playerid) {
    if(!IsPlayerConnected(playerid)) return 0;
    
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    
    for(new i = 0; i < MAX_DRUG_DEALERS; i++) {
        if(!gDealerData[i][dealerInUse]) continue;
        
        new locationIndex = gDealerData[i][dealerLocationIndex];
        if(IsPlayerInRangeOfPoint(playerid, 3.0,
            gDealerLocations[locationIndex][0],
            gDealerLocations[locationIndex][1],
            gDealerLocations[locationIndex][2])) {
            return 1;
        }
    }
    return 0;
}

// ========================================================================
// Dealer Callbacks
// ========================================================================

forward UpdateDealerLocation(dealerid);
public UpdateDealerLocation(dealerid) {
    if(dealerid < 0 || dealerid >= MAX_DRUG_DEALERS) return 0;
    
    SpawnRandomDealer(dealerid);
    return 1;
}

// ========================================================================
// Additional Hooks
// ========================================================================

hook OnGameModeInit() {
    CreateDrugDealers();
    return 1;
}

hook OnDynamicActorStreamIn(STREAMER_TAG_ACTOR:actorid, forplayerid) {
    // Optional: Add visual effect when dealer comes into view
    return 1;
}

// ========================================================================
// Dealer Commands
// ========================================================================


YCMD:kupidrogu(playerid, params[], help) {
    if(help) {
        SendClientMessage(playerid, x_green, "DEALER: Koristi /kupidrogu da kupis sastojke za drogu od dilera.");
        return 1;
    }

    if(!IsPlayerNearDealer(playerid))
        return SendClientMessage(playerid, x_red, "DEALER: Nisi blizu dilera!");
        
    Dialog_Show(playerid, DRUGS_DEALER, DIALOG_STYLE_TABLIST,
        "Kupovina droge",
        "Pseudoefedrin\tCena: $1000\n\
        Hemikalije\tCena: $800\n\
        Laboratorijska oprema\tCena: $2000\n\
        Koka listovi\tCena: $1500\n\
        Benzin\tCena: $500\n\
        Omeprazol\tCena: $1000",
        "Kupi", "Izadji");
    return 1;
}

YCMD:dealertp(playerid, params[], help) {

    if(!IsPlayerAdmin(playerid))
        return (true);

    new dealerid;
    if(sscanf(params, "d", dealerid))
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"/dealertp <dealer>");

    new bool:dealerFound = false;

    if(gDealerData[dealerid][dealerInUse])
    {
        dealerFound = true;
    }

    if(!dealerFound)
        return SendClientMessage(playerid, x_faction, "DEALER: Unjeli ste krivi ID dilera!");


    new locationIndex = gDealerData[dealerid][dealerLocationIndex];
    SetPlayerCompensatedPos(playerid, gDealerLocations[locationIndex][0],
                                      gDealerLocations[locationIndex][1],
                                      gDealerLocations[locationIndex][2]);

    return 1;
}

// ========================================================================
// Dealer Dialogs
// ========================================================================

Dialog:DRUGS_DEALER(playerid, response, listitem, string: inputtext[]) {
    if(!response) return 1;
    if(!IsPlayerNearDealer(playerid))
        return SendClientMessage(playerid, x_red, "DEALER: Nisi blizu dilera!");
    
    new xPrice;
    new itemName[32];
    new xitemID;
    
    switch(listitem) {
        case 0: { // Pseudoefedrin
            xPrice = 1000;
            itemName = "Pseudoefedrin";
            xitemID = INVENTORY_ITEM_PSEUDOEPHEDRINE;
        }
        case 1: { // Hemikalije
            xPrice = 800;
            itemName = "Hemikalije";
            xitemID = INVENTORY_ITEM_CHEMICALS;
        }
        case 2: { // Lab oprema
            xPrice = 2000;
            itemName = "Laboratorijska oprema";
            xitemID = INVENTORY_ITEM_LAB_EQUIPMENT;
            
        }
        case 3: { // Koka listovi
            xPrice = 1500;
            itemName = "Koka listovi";
            xitemID = INVENTORY_ITEM_HERBS;
        }
        case 4: { // Benzin
            xPrice = 500;
            itemName = "Benzin";
            xitemID = INVENTORY_ITEM_GASOLINE;
        }
        case 5: { // Omeprazol
            xPrice = 1000;
            itemName = "Omeprazol";
            xitemID = INVENTORY_ITEM_OMEPRAZOLE;
        }
    }
    
    // Check if player has enough money
    if(GetPlayerMoney(playerid) < xPrice) {
        SendClientMessage(playerid, x_faction, "DEALER: Nemas dovoljno novca!");
        return 1;
    }
    
    if(Inventory_GetItemQuantity(playerid, xitemID) >= sz_quantityInfo[xitemID-50][maxQuantity])
        return SendClientMessage(playerid, x_faction, "DEALER: Vec posjedujete maksimalnu kolicinu ovog predmeta!");
    
    Inventory_AddItem(playerid, xitemID, 1);
    GivePlayerMoney(playerid, -xPrice);
    
    new message[128];
    format(message, sizeof(message), "DEALER: Kupio si %s za $%d.", itemName, xPrice);
    SendClientMessage(playerid, x_faction, message);
    return 1;
}

