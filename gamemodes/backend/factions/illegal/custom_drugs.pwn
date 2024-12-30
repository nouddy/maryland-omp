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
#define PRODUCTION_TIME       300000  // 5 minutes
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

// Production locations (not real, change it)
new Float:gSpeedLabLocations[][] = {
    {1234.5, 2345.6, 10.5},  // Lab 1
    {2345.6, 3456.7, 10.5}   // Lab 2
};
// Mushroom locations (not real, change it)
new Float:gMushroomLocations[][] = {
    {-1234.5, -2345.6, 10.5},  // Forest 1
    {-2345.6, -3456.7, 10.5}   // Forest 2
};

// Coca plant locations (not real, change it)
new Float:gCocaPlantLocations[][] = {
    {3456.7, 4567.8, 10.5},  // Mountain 1
    {4567.8, 5678.9, 10.5}   // Mountain 2
};

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

hook OnPlayerUpdate(playerid) {
    if(!IsPlayerConnected(playerid)) return 1;
    if(gPlayerDrugData[playerid][pOriginalRunSpeed] <= 0.0) return 1;
    
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && (GetPlayerKeys(playerid) & KEY_SPRINT)) {
        new Float:x, Float:y, Float:z;
        GetPlayerVelocity(playerid, x, y, z);
        
        // Multiply current velocity by speed multiplier
        SetPlayerVelocity(playerid, 
            x * gPlayerDrugData[playerid][pOriginalRunSpeed],
            y * gPlayerDrugData[playerid][pOriginalRunSpeed],
            z
        );
    }
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
    
    StartDrugProduction(playerid, DRUG_SPEED);
    return 1;
}

Dialog:DRUGS_MUSHROOMS(playerid, response, listitem, string: inputtext[]) {
    if(!response) return ShowMainDrugDialog(playerid);
    
    if(!IsPlayerInDrugZone(playerid, DRUG_MUSHROOMS))
        return SendClientMessage(playerid, x_red, "Nisi na odgovarajucoj lokaciji!");
    
    StartDrugProduction(playerid, DRUG_MUSHROOMS);
    return 1;
}

Dialog:DRUGS_COCAINE(playerid, response, listitem, string: inputtext[]) {
    if(!response) return ShowMainDrugDialog(playerid);
    
    if(!IsPlayerInDrugZone(playerid, DRUG_COCAINE))
        return SendClientMessage(playerid, x_red, "Nisi na odgovarajucoj lokaciji!");
    
    StartDrugProduction(playerid, DRUG_COCAINE);
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

StartDrugProduction(playerid, drugType) {
    if(!IsPlayerConnected(playerid)) return 0;
    if(gPlayerDrugData[playerid][pIsProducingDrugs]) 
        return SendClientMessage(playerid, x_red, "Vec proizvodis drogu!");

    gPlayerDrugData[playerid][pIsProducingDrugs] = true;
    gPlayerDrugData[playerid][pDrugProductionTimer] = SetTimerEx("FinishDrugProduction", 
        PRODUCTION_TIME, false, "ii", playerid, drugType);
    
    new message[64];
    format(message, sizeof(message), "Zapoceo si proizvodnju %s. Sacekaj 5 minuta.", 
        GetDrugName(drugType));
    SendClientMessage(playerid, x_green, message);
    return 1;
}

GetDrugName(drugType) {
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

CMD:droge(playerid, params[]) {
    if(!IsPlayerInAnyDrugZone(playerid))
        return SendClientMessage(playerid, x_red, "Nisi na odgovarajucoj lokaciji!");
    
    return ShowMainDrugDialog(playerid);
}

// ========================================================================
// Location & Zone Functions
// ========================================================================

IsPlayerInDrugZone(playerid, drugType) {
    if(!IsPlayerConnected(playerid)) return 0;
    
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    
    switch(drugType) {
        case DRUG_SPEED: {
            for(new i = 0; i < sizeof(gSpeedLabLocations); i++) {
                if(IsPlayerInRangeOfPoint(playerid, 3.0, 
                    gSpeedLabLocations[i][0], 
                    gSpeedLabLocations[i][1], 
                    gSpeedLabLocations[i][2])) {
                    return 1;
                }
            }
        }
        case DRUG_MUSHROOMS: {
            for(new i = 0; i < sizeof(gMushroomLocations); i++) {
                if(IsPlayerInRangeOfPoint(playerid, 3.0, 
                    gMushroomLocations[i][0], 
                    gMushroomLocations[i][1], 
                    gMushroomLocations[i][2])) {
                    return 1;
                }
            }
        }
        case DRUG_COCAINE: {
            for(new i = 0; i < sizeof(gCocaPlantLocations); i++) {
                if(IsPlayerInRangeOfPoint(playerid, 3.0, 
                    gCocaPlantLocations[i][0], 
                    gCocaPlantLocations[i][1], 
                    gCocaPlantLocations[i][2])) {
                    return 1;
                }
            }
        }
    }
    return 0;
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
        return SendClientMessage(playerid, x_red, "Vec si pod uticajem droge!");

    switch(drugType) {
        case DRUG_SPEED: {
            // Store original speed and apply boost
            gPlayerDrugData[playerid][pOriginalRunSpeed] = GetPlayerRunSpeed(playerid);
            SetPlayerRunSpeed(playerid, gPlayerDrugData[playerid][pOriginalRunSpeed] * 1.3);
            
            // Visual effects
            SetPlayerDrunkLevel(playerid, 2000);
            
            // Start effect timer
            gPlayerDrugData[playerid][pUnderInfluence] = true;
            gPlayerDrugData[playerid][pDrugEffectTimer] = SetTimerEx("DrugEffectTimeout", 
                SPEED_EFFECT_TIME, false, "ii", playerid, DRUG_SPEED);
        }
        case DRUG_MUSHROOMS: {
            // Visual and weather effects
            SetPlayerWeather(playerid, random(20));
            SetPlayerDrunkLevel(playerid, 4000);
            
            // Start hallucination effects
            gPlayerDrugData[playerid][pUnderInfluence] = true;
            gPlayerDrugData[playerid][pDrugEffectTimer] = SetTimerEx("DrugEffectTimeout", 
                MUSHROOM_EFFECT_TIME, false, "ii", playerid, DRUG_MUSHROOMS);
            
            // Update hallucinations every 10 seconds
            SetTimerEx("UpdateHallucination", 10000, true, "i", playerid);
        }
        case DRUG_COCAINE: {
            // Speed and armor boost
            gPlayerDrugData[playerid][pOriginalRunSpeed] = GetPlayerRunSpeed(playerid);
            SetPlayerRunSpeed(playerid, gPlayerDrugData[playerid][pOriginalRunSpeed] * 1.2);
            
            new Float:currentArmor;
            GetPlayerArmour(playerid, currentArmor);
            SetPlayerArmour(playerid, currentArmor + 20.0);
            
            // Start effect timer
            gPlayerDrugData[playerid][pUnderInfluence] = true;
            gPlayerDrugData[playerid][pDrugEffectTimer] = SetTimerEx("DrugEffectTimeout", 
                COCAINE_EFFECT_TIME, false, "ii", playerid, DRUG_COCAINE);
        }
    }
    return 1;
}

// ========================================================================
// Callbacks & Timers
// ========================================================================

forward FinishDrugProduction(playerid, drugType);
public FinishDrugProduction(playerid, drugType) {
    if(!IsPlayerConnected(playerid)) return 0;
    
    gPlayerDrugData[playerid][pIsProducingDrugs] = false;
    
    // Here you would add the drug to player's inventory
    // AddItemToInventory(playerid, GetDrugItemID(drugType), 1);
    
    new message[128];
    format(message, sizeof(message), "Uspesno si proizveo %s!", GetDrugName(drugType));
    SendClientMessage(playerid, x_green, message);
    return 1;
}

forward DrugEffectTimeout(playerid, drugType);
public DrugEffectTimeout(playerid, drugType) {
    if(!IsPlayerConnected(playerid)) return 0;

    switch(drugType) {
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

// ========================================================================
// Drug Dealer Actor System
// ========================================================================

// Constants
#define MAX_DRUG_DEALERS     3
#define DEALER_CHANGE_TIME   3600000  // 1 hour in milliseconds
#define DEALER_SKIN_ID       179      // Default dealer skin

// Dealer locations array (not real, change it)
new Float:gDealerLocations[][] = {
    {1234.5, 2345.6, 10.5, 90.0},    // X, Y, Z, Rotation
    {2345.6, 3456.7, 10.5, 180.0},
    {3456.7, 4567.8, 10.5, 270.0},
    {4567.8, 5678.9, 10.5, 0.0},
    {5678.9, 6789.0, 10.5, 45.0},
    {6789.0, 7890.1, 10.5, 135.0},
    {7890.1, 8901.2, 10.5, 225.0},
    {8901.2, 9012.3, 10.5, 315.0}
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
        SendClientMessage(playerid, x_green, "Koristi /kupidrogu da kupis sastojke za drogu od dilera.");
        return 1;
    }

    if(!IsPlayerNearDealer(playerid))
        return SendClientMessage(playerid, x_red, "Nisi blizu dilera!");
        
    Dialog_Show(playerid, DRUGS_DEALER, DIALOG_STYLE_LIST,
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

// ========================================================================
// Dealer Dialogs
// ========================================================================

Dialog:DRUGS_DEALER(playerid, response, listitem, string: inputtext[]) {
    if(!response) return 1;
    if(!IsPlayerNearDealer(playerid))
        return SendClientMessage(playerid, x_red, "Nisi blizu dilera!");
    
    new price;
    new itemName[32];
    
    switch(listitem) {
        case 0: { // Pseudoefedrin
            price = 1000;
            itemName = "Pseudoefedrin";
        }
        case 1: { // Hemikalije
            price = 800;
            itemName = "Hemikalije";
        }
        case 2: { // Lab oprema
            price = 2000;
            itemName = "Laboratorijska oprema";
        }
        case 3: { // Koka listovi
            price = 1500;
            itemName = "Koka listovi";
        }
        case 4: { // Benzin
            price = 500;
            itemName = "Benzin";
        }
        case 5: { // Omeprazol
            price = 1000;
            itemName = "Omeprazol";
        }
    }
    
    // Check if player has enough money
    if(GetPlayerMoney(playerid) < price) {
        SendClientMessage(playerid, x_red, "Nemas dovoljno novca!");
        return 1;
    }
    
    // Here you would implement your inventory system
    // AddItemToInventory(playerid, listitem + ITEM_DRUG_INGREDIENTS_START, 1);
    
    GivePlayerMoney(playerid, -price);
    
    new message[128];
    format(message, sizeof(message), "Kupio si %s za $%d.", itemName, price);
    SendClientMessage(playerid, x_green, message);
    return 1;
}

