/***
 *    Robbery System with roles
 *    Author: Vostic / Noddy
 *    Description: Handles bank robberies, roles, and rewards
 */

// ========================================================================
// Includes
// ========================================================================

#include <ysilib\YSI_Coding\y_hooks>

// ========================================================================
// Constants & Enums
// ========================================================================

// Wish me good luck pipl
//* 1676.27 -1464.04 1682.24 -1456.8  - Fleeca Area if lasers are not disabled!
//* 1663.11 -1473.34 1711.27 -1445.7  - Fleeca Area to disable alarms with ometacem      
//* SetWeather(9); ->               Foggy weather for H4RBOR Interior when player puts tear gas in

enum E_ROBBERY_RANKS {

    RANK_NOVICE,      // 0-2 successful robberies
    RANK_PROFESSIONAL,// 3-7 successful robberies
    RANK_MASTERMIND   // 8+ successful robberies
}

// ========================================================================
// Struct
// ========================================================================

enum E_ROBBERY_BANKS {

    ROBBERY_BANK_UNKNOWN,
    ROBBERY_BANK_HARBOR,
    ROBBERY_BANK_FLEECA
}

// gRobberySteps[3] gRoberySteps = ROB1 | ROB2

enum E_ROBBERY_STEPS  (<<=1) {

    ROBBERY_STEP_LASERS = 1,
    ROBBERY_STEP_CAMERAS,      
    ROBBERY_STEP_TEAR_GAS, 
    ROBBERY_STEP_ALARM,
    ROBBERY_STEP_DYNAMITE,
    ROBBERY_STEP_FINISH
}

// static const RobberySteps[E_ROBBERY_STEPS][32] = {

//     "Lasers",
//     "Cameras",
//     "Tear Gas"

// };

static const RobberyBanks[E_ROBBERY_BANKS][32] = {

    "Unknown",
    "H4RBOR Bank",
    "Fleeca Bank"
};

static const RobberyBanksCooldown[E_ROBBERY_BANKS] = {

    0,
    60,     //* 60 Minutes ( gettime() + ( 60 * RobberyBanksCooldown[ROBBERY_BANK_HARBOR] ) ) or smth like that
    30      //* 60 Minutes ( gettime() + ( 60 * RobberyBanksCooldown[ROBBERY_BANK_FLEECA] ) ) or smth like that
};

enum E_ROBBERY_STATUS {

    Float:gRobberyTake[E_ROBBERY_BANKS],
    bool:gRobberyActive[E_ROBBERY_BANKS],
    gRobberyCooldown[E_ROBBERY_BANKS]
}

new gRobberyStatistic[E_ROBBERY_STATUS];
new gFleecaArea[2];

enum E_ROBBERY_CREW {

    ROBBERY_CREW_UNKNOWN,
    ROBBERY_CREW_DRIVER,
    ROBBERY_CREW_HACKER,
    ROBBERY_CREW_BURGLAR
};

static const RobberyCrew[E_ROBBERY_CREW][32] = {

    "Unknown",
    "Driver",
    "Hacker",
    "Pljaclkas"
};

enum E_PLAYER_ROBBERY {

    E_ROBBERY_BANKS:gRobberyType,
    gRobberyCrewMembers,
    gRobberyLeader,
    bool:gRobberyCrew,
    E_ROBBERY_STEPS:gRobberyProgress,
    bool:gRobberyInPreparation,
    bool:gRobberyStatus[E_ROBBERY_CREW],
    bool:robberyStealing
}

new gPlayerRobbery[MAX_PLAYERS][E_PLAYER_ROBBERY],
    gPlayerRobberyCrewLeader[MAX_PLAYERS],
    gPlayerRobberyInvite[MAX_PLAYERS],
    gPlayerStartJamming[MAX_PLAYERS],
    E_ROBBERY_CREW:gPlayerRobberyInviteCrewType[MAX_PLAYERS];

new E_ROBBERY_CREW:gPlayerCrewAssigment[MAX_PLAYERS];
    
new gRobberySafeObject[2];

new gDynamiteTimer[MAX_PLAYERS];
new gRobberyCount[MAX_PLAYERS];
new gRobberyTimer[MAX_PLAYERS];

// ========================================================================
// Hacking
// =======================================================================

const ROBBERY_MAX_HACKING_NUMBERS       =      (16);

new PlayerText:Robbery_HackingUI[MAX_PLAYERS][22];
new gRobberyCombination[MAX_PLAYERS];
new gRobberyActiveCombination[MAX_PLAYERS][4];
new gRobberyCombinationNumber[MAX_PLAYERS][4];  //* If the combination is 5821 in this var the numbers will be stored 5 | 2 | 8 | 1 etc...
new gCombinationIndex[MAX_PLAYERS];             //* The index of an number if the number is 5821, indexes will go like this : 0 - 5  |  1 - 8  |   2 - 2  |   3 - 1

new gRobberyBreachTimer[MAX_PLAYERS],
    bool:gRobberyCheckPoint[MAX_PLAYERS];

forward Robbery_CreateExplosion(playerid);
public Robbery_CreateExplosion(playerid) {

    CreateExplosion(1311.0708,2557.8801,-21.6686, 1, 5.0);
    KillTimer(gDynamiteTimer[playerid]);
    
    DestroyDynamicObject(gRobberySafeObject[0]);
    DestroyDynamicObject(gRobberySafeObject[1]);

    new leaderid = gPlayerRobberyCrewLeader[playerid];
    Robbery_SendHeistMessage(leaderid, ""c_white"Vrata sefa su srusena, banka je spremna za pljacku!");

    return (true);
}

forward Robbery_UpdateHackingCombination(playerid);
public Robbery_UpdateHackingCombination(playerid) {

    if(gRobberyCombination[playerid] != 0) {

        new combined = (gRobberyCombinationNumber[playerid][0] * 1000) + (gRobberyCombinationNumber[playerid][1] * 100) + (gRobberyCombinationNumber[playerid][2] * 10) + gRobberyCombinationNumber[playerid][3];

        if(combined == gRobberyCombination[playerid]) {

            SendClientMessage(playerid, x_faction, "LAPSU$-R3M0T3: "c_white"Uspjesno ste ugasili sve alarme H4RBOR Banke!");
            PlayerPlaySound(playerid, 1137, 0.00, 0.00, 0.00);
            Robbery_ResetHackingInterface(playerid);
            KillTimer(gRobberyBreachTimer[playerid]);
            CreateSurvivalInterface(playerid);
            
            new leaderid = gPlayerRobberyCrewLeader[playerid]; static tmpStr[248];

            gPlayerRobbery[leaderid][gRobberyProgress] = ROBBERY_STEP_ALARM;

            format(tmpStr, sizeof tmpStr, "LAPSU$-R3M0T3: "c_ltorange"%s %s[%d] je uspjesno ugasio sve alarme H4RBOR Banke!", RobberyCrew[ROBBERY_CREW_HACKER], ReturnCharacterName(playerid), playerid);
            Robbery_SendHeistMessage(leaderid, tmpStr);

            return ~1;
        }

        if(combined != gRobberyCombination[playerid] && gCombinationIndex[playerid] == 3) {
            
            KillTimer(gRobberyBreachTimer[playerid]);
            SendClientMessage(playerid, x_faction, "LAPSU$-R3M0T3: "c_white"Pokusajte ponovo!");
            Robbery_FormatHackingCombination(playerid);
            return ~1;

        }

        else {

            Robbery_UpdateCombination(playerid);
        }
    }

    return (true);
}

stock Robbery_SendHeistMessage(leaderid, const msg[ ]) {

    foreach(new i : Player) {

        if(gPlayerRobberyCrewLeader[i] == leaderid) {

            SendClientMessage(i, x_faction, msg);
        }
    }
}

stock Robbery_ResetPlayerVars(playerid) {

    gRobberyCheckPoint[playerid] = false;

    gPlayerRobberyInvite[playerid] = INVALID_PLAYER_ID;
    gPlayerRobberyInviteCrewType[playerid] = ROBBERY_CREW_UNKNOWN;

    gPlayerRobbery[playerid][gRobberyType] = ROBBERY_BANK_UNKNOWN;
    gPlayerRobbery[playerid][gRobberyCrewMembers] = 0;
    gPlayerRobbery[playerid][gRobberyLeader] = INVALID_PLAYER_ID;
    gPlayerRobbery[playerid][gRobberyInPreparation] = false;

    gPlayerRobbery[playerid][gRobberyStatus][ROBBERY_CREW_BURGLAR] = false;
    gPlayerRobbery[playerid][gRobberyStatus][ROBBERY_CREW_DRIVER] = false;
    gPlayerRobbery[playerid][gRobberyStatus][ROBBERY_CREW_HACKER] = false;

    gPlayerRobberyCrewLeader[playerid] = INVALID_PLAYER_ID;

    gPlayerStartJamming[playerid] = false;
    gRobberyCombination[playerid] = 0;
    gRobberyCount[playerid] = 0;
    gCombinationIndex[playerid] = -1;

    gRobberyCombinationNumber[playerid][0] = 0;
    gRobberyCombinationNumber[playerid][1] = 0;
    gRobberyCombinationNumber[playerid][2] = 0;
    gRobberyCombinationNumber[playerid][3] = 0;

    return (true);
}

stock Robbery_UpdateCombination(playerid) {

    new tmp_combination[ROBBERY_MAX_HACKING_NUMBERS];
    new tmp_str[3];

    for(new j = 0; j < ROBBERY_MAX_HACKING_NUMBERS; j++) {

        tmp_combination[j] = RandomMinMax(1, 10);
    }

    for(new x = 6; x < sizeof Robbery_HackingUI[]; x++ ) {

        format(tmp_str, sizeof tmp_str, "%d", tmp_combination[x-6]);
        PlayerTextDrawSetString(playerid, Robbery_HackingUI[playerid][x], tmp_str);
    }  

    if(gRobberyCombinationNumber[playerid][0] != 0) 
    {
        format(tmp_str, sizeof tmp_str, "%d", gRobberyCombinationNumber[playerid][0]);
        PlayerTextDrawSetString(playerid, Robbery_HackingUI[playerid][18], tmp_str);
    }

    if(gRobberyCombinationNumber[playerid][1] != 0) 
    {
        format(tmp_str, sizeof tmp_str, "%d", gRobberyCombinationNumber[playerid][1]);
        PlayerTextDrawSetString(playerid, Robbery_HackingUI[playerid][19], tmp_str);
    }

    if(gRobberyCombinationNumber[playerid][2] != 0) 
    {
        format(tmp_str, sizeof tmp_str, "%d", gRobberyCombinationNumber[playerid][2]);
        PlayerTextDrawSetString(playerid, Robbery_HackingUI[playerid][20], tmp_str);
    }
    
    if(gRobberyCombinationNumber[playerid][3] != 0) 
    {
        format(tmp_str, sizeof tmp_str, "%d", gRobberyCombinationNumber[playerid][3]);
        PlayerTextDrawSetString(playerid, Robbery_HackingUI[playerid][21], tmp_str);
    }

    gRobberyActiveCombination[playerid][0] = tmp_combination[12];  
    gRobberyActiveCombination[playerid][1] = tmp_combination[13];  
    gRobberyActiveCombination[playerid][2] = tmp_combination[14];  
    gRobberyActiveCombination[playerid][3] = tmp_combination[15];  

    return (true);
}

stock Robbery_ChoseHackingCombination(playerid) {

    if(gCombinationIndex[playerid] != -1) {

        new tmp_idx = gCombinationIndex[playerid];
        gRobberyCombinationNumber[playerid][tmp_idx] = gRobberyActiveCombination[playerid][ tmp_idx ];
    }

    return (true);
}


stock Robbery_ResetHackingCombination(playerid) {

    new tmp_combination[ROBBERY_MAX_HACKING_NUMBERS];
    new tmp_str[3];

    for(new j = 0; j < ROBBERY_MAX_HACKING_NUMBERS; j++) {

        tmp_combination[j] = RandomMinMax(1, 10);
    }

    for(new x = 6; x < sizeof Robbery_HackingUI[]; x++ ) {

        format(tmp_str, sizeof tmp_str, "%d", tmp_combination[x-6]);
        PlayerTextDrawSetString(playerid, Robbery_HackingUI[playerid][x], tmp_str);
    }  

    gRobberyActiveCombination[playerid][0] = tmp_combination[12];  
    gRobberyActiveCombination[playerid][1] = tmp_combination[13];  
    gRobberyActiveCombination[playerid][2] = tmp_combination[14];  
    gRobberyActiveCombination[playerid][3] = tmp_combination[15];  
    return (true);
}

stock Robbery_FormatHackingCombination(playerid) {

    if(playerid == INVALID_PLAYER_ID)
        return (false);

    new playerNum = GenerateNonZeroRandomNumber();
    new tmp_combination[ROBBERY_MAX_HACKING_NUMBERS] = 0;

    PlayerPlaySound(playerid, 41603, 0.00, 0.00, 0.00);

    gRobberyCombination[playerid] = playerNum;

    gRobberyCombinationNumber[playerid][0] = 0;
    gRobberyCombinationNumber[playerid][1] = 0;
    gRobberyCombinationNumber[playerid][2] = 0;
    gRobberyCombinationNumber[playerid][3] = 0;

    gCombinationIndex[playerid] = -1;

    for(new j = 0; j < ROBBERY_MAX_HACKING_NUMBERS; j++) {

        tmp_combination[j] = RandomMinMax(1, 10);
    }

    new tmp_str[3];

    for(new x = 6; x < sizeof Robbery_HackingUI[]; x++ ) {

        format(tmp_str, sizeof tmp_str, "%d", tmp_combination[x-6]);
        PlayerTextDrawSetString(playerid, Robbery_HackingUI[playerid][x], tmp_str);
    }
    
    gRobberyActiveCombination[playerid][0] = tmp_combination[12];  
    gRobberyActiveCombination[playerid][1] = tmp_combination[13];  
    gRobberyActiveCombination[playerid][2] = tmp_combination[14];  
    gRobberyActiveCombination[playerid][3] = tmp_combination[15];  

    SendClientMessage(playerid, x_faction, "LAPSU$-R3M0T3: "c_white"Vasa kombinacija za brute-force je - %d", gRobberyCombination[playerid]);
    SendClientMessage(playerid, x_faction, "LAPSU$-R3M0T3: "c_white"Ukoliko je dobitna kombinacija na pravom mjestu u zelenom redu pritisnite 'N'");
    SendClientMessage(playerid, x_faction, "LAPSU$-R3M0T3: "c_white"Zapamtite, brojevi idu sa lijeva na desno!");

    gRobberyBreachTimer[playerid] = SetTimerEx("Robbery_UpdateHackingCombination", 850, true, "d", playerid);
    return (true);
}

stock Robbery_ResetHackingInterface(playerid) {

    for(new i = 0; i < sizeof Robbery_HackingUI[]; i++) {

        if(Robbery_HackingUI[playerid][i] == INVALID_PLAYER_TEXT_DRAW) continue;

        PlayerTextDrawDestroy(playerid, Robbery_HackingUI[playerid][i]);
        Robbery_HackingUI[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
    }

    return (true);
}

stock Robbery_ShowHackingInterface(playerid) {

    // PlayerTextDrawSetProportional\((.*),(.*), 1\);
    // PlayerTextDrawSetProportional($1, $2, true);

    Robbery_ResetHackingInterface(playerid);
    ToggleGlobalTextDraw(playerid, false);
    ResetSurvivalInterface(playerid);

    Robbery_HackingUI[playerid][0] = CreatePlayerTextDraw(playerid, 519.000000, 239.622268, "");
    PlayerTextDrawTextSize(playerid, Robbery_HackingUI[playerid][0], 133.000000, 175.000000);
    PlayerTextDrawAlignment(playerid, Robbery_HackingUI[playerid][0], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColor(playerid, Robbery_HackingUI[playerid][0], 255);
    PlayerTextDrawSetShadow(playerid, Robbery_HackingUI[playerid][0], 0);
    PlayerTextDrawFont(playerid, Robbery_HackingUI[playerid][0], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawBackgroundColor(playerid, Robbery_HackingUI[playerid][0], 0x00000000);
    PlayerTextDrawSetProportional(playerid, Robbery_HackingUI[playerid][0], false);
    PlayerTextDrawSetPreviewModel(playerid, Robbery_HackingUI[playerid][0], 2729);
    PlayerTextDrawSetPreviewRot(playerid, Robbery_HackingUI[playerid][0], 0.000000, 0.000000, 0.000000, 1.000000);

    Robbery_HackingUI[playerid][1] = CreatePlayerTextDraw(playerid, 519.000000, 298.111145, "");
    PlayerTextDrawTextSize(playerid, Robbery_HackingUI[playerid][1], 133.000000, 175.000000);
    PlayerTextDrawAlignment(playerid, Robbery_HackingUI[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColor(playerid, Robbery_HackingUI[playerid][1], 255);\
    PlayerTextDrawBackgroundColor(playerid, Robbery_HackingUI[playerid][1], 0x00000000);
    PlayerTextDrawSetShadow(playerid, Robbery_HackingUI[playerid][1], 0);
    PlayerTextDrawFont(playerid, Robbery_HackingUI[playerid][1], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid,  Robbery_HackingUI[playerid][1], false);
    PlayerTextDrawSetPreviewModel(playerid, Robbery_HackingUI[playerid][1], 2729);
    PlayerTextDrawSetPreviewRot(playerid, Robbery_HackingUI[playerid][1], 0.000000, 0.000000, 0.000000, 1.000000);

    Robbery_HackingUI[playerid][2] = CreatePlayerTextDraw(playerid, 583.999816, 434.585174, "");
    PlayerTextDrawTextSize(playerid, Robbery_HackingUI[playerid][2], 8.000000, -9.000000);
    PlayerTextDrawAlignment(playerid, Robbery_HackingUI[playerid][2], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColor(playerid, Robbery_HackingUI[playerid][2], -152);
    PlayerTextDrawSetShadow(playerid, Robbery_HackingUI[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, Robbery_HackingUI[playerid][2], -256);
    PlayerTextDrawFont(playerid, Robbery_HackingUI[playerid][2], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid,  Robbery_HackingUI[playerid][2], false);
    PlayerTextDrawSetPreviewModel(playerid, Robbery_HackingUI[playerid][2], 1316);
    PlayerTextDrawSetPreviewRot(playerid, Robbery_HackingUI[playerid][2], 90.000000, 0.000000, 0.000000, 1.000000);

    Robbery_HackingUI[playerid][3] = CreatePlayerTextDraw(playerid, 564.333312, 290.385162, ">_");
    PlayerTextDrawLetterSize(playerid, Robbery_HackingUI[playerid][3], 0.178666, 0.940444);
    PlayerTextDrawTextSize(playerid, Robbery_HackingUI[playerid][3], 0.000000, 330.000000);
    PlayerTextDrawAlignment(playerid, Robbery_HackingUI[playerid][3], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColor(playerid, Robbery_HackingUI[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, Robbery_HackingUI[playerid][3], 0);
    PlayerTextDrawBackgroundColor(playerid, Robbery_HackingUI[playerid][3], 255);
    PlayerTextDrawFont(playerid, Robbery_HackingUI[playerid][3], TEXT_DRAW_FONT_3);
    PlayerTextDrawSetProportional(playerid,  Robbery_HackingUI[playerid][3], true);

    Robbery_HackingUI[playerid][4] = CreatePlayerTextDraw(playerid, 566.333190, 294.533355, "-");
    PlayerTextDrawLetterSize(playerid, Robbery_HackingUI[playerid][4], 0.397666, 0.699852);
    PlayerTextDrawTextSize(playerid, Robbery_HackingUI[playerid][4], 0.000000, 330.000000);
    PlayerTextDrawAlignment(playerid, Robbery_HackingUI[playerid][4], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColor(playerid, Robbery_HackingUI[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, Robbery_HackingUI[playerid][4], 0);
    PlayerTextDrawBackgroundColor(playerid, Robbery_HackingUI[playerid][4], 255);
    PlayerTextDrawFont(playerid, Robbery_HackingUI[playerid][4], TEXT_DRAW_FONT_3);
    PlayerTextDrawSetProportional(playerid,  Robbery_HackingUI[playerid][4], true);

    Robbery_HackingUI[playerid][5] = CreatePlayerTextDraw(playerid, 588.999511, 292.459320, "LAPSU$_REMOTE");
    PlayerTextDrawLetterSize(playerid, Robbery_HackingUI[playerid][5], 0.134333, 0.567111);
    PlayerTextDrawTextSize(playerid, Robbery_HackingUI[playerid][5], 0.000000, 330.000000);
    PlayerTextDrawAlignment(playerid, Robbery_HackingUI[playerid][5], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColor(playerid, Robbery_HackingUI[playerid][5], -1);
    PlayerTextDrawSetShadow(playerid, Robbery_HackingUI[playerid][5], 0);
    PlayerTextDrawBackgroundColor(playerid, Robbery_HackingUI[playerid][5], 255);
    PlayerTextDrawFont(playerid, Robbery_HackingUI[playerid][5], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid,  Robbery_HackingUI[playerid][5], true);

    Robbery_HackingUI[playerid][6] = CreatePlayerTextDraw(playerid, 565.999816, 314.859222, "1");
    PlayerTextDrawLetterSize(playerid, Robbery_HackingUI[playerid][6], 0.550000, 1.965037);
    PlayerTextDrawTextSize(playerid, Robbery_HackingUI[playerid][6], 0.000000, 330.000000);
    PlayerTextDrawAlignment(playerid, Robbery_HackingUI[playerid][6], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColor(playerid, Robbery_HackingUI[playerid][6], -1);
    PlayerTextDrawSetShadow(playerid, Robbery_HackingUI[playerid][6], 0);
    PlayerTextDrawBackgroundColor(playerid, Robbery_HackingUI[playerid][6], 255);
    PlayerTextDrawFont(playerid, Robbery_HackingUI[playerid][6], TEXT_DRAW_FONT_3);
    PlayerTextDrawSetProportional(playerid,  Robbery_HackingUI[playerid][6], true);

    Robbery_HackingUI[playerid][7] = CreatePlayerTextDraw(playerid, 579.999877, 314.859222, "1");
    PlayerTextDrawLetterSize(playerid, Robbery_HackingUI[playerid][7], 0.550000, 1.965037);
    PlayerTextDrawTextSize(playerid, Robbery_HackingUI[playerid][7], 0.000000, 330.000000);
    PlayerTextDrawAlignment(playerid, Robbery_HackingUI[playerid][7], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColor(playerid, Robbery_HackingUI[playerid][7], -1);
    PlayerTextDrawSetShadow(playerid, Robbery_HackingUI[playerid][7], 0);
    PlayerTextDrawBackgroundColor(playerid, Robbery_HackingUI[playerid][7], 255);
    PlayerTextDrawFont(playerid, Robbery_HackingUI[playerid][7], TEXT_DRAW_FONT_3);
    PlayerTextDrawSetProportional(playerid,  Robbery_HackingUI[playerid][7], true);

    Robbery_HackingUI[playerid][8] = CreatePlayerTextDraw(playerid, 592.999877, 314.859222, "1");
    PlayerTextDrawLetterSize(playerid, Robbery_HackingUI[playerid][8], 0.550000, 1.965037);
    PlayerTextDrawTextSize(playerid, Robbery_HackingUI[playerid][8], 0.000000, 330.000000);
    PlayerTextDrawAlignment(playerid, Robbery_HackingUI[playerid][8], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColor(playerid, Robbery_HackingUI[playerid][8], -1);
    PlayerTextDrawSetShadow(playerid, Robbery_HackingUI[playerid][8], 0);
    PlayerTextDrawBackgroundColor(playerid, Robbery_HackingUI[playerid][8], 255);
    PlayerTextDrawFont(playerid, Robbery_HackingUI[playerid][8], TEXT_DRAW_FONT_3);
    PlayerTextDrawSetProportional(playerid,  Robbery_HackingUI[playerid][8], true);

    Robbery_HackingUI[playerid][9] = CreatePlayerTextDraw(playerid, 605.666625, 314.859222, "1");
    PlayerTextDrawLetterSize(playerid, Robbery_HackingUI[playerid][9], 0.550000, 1.965037);
    PlayerTextDrawTextSize(playerid, Robbery_HackingUI[playerid][9], 0.000000, 330.000000);
    PlayerTextDrawAlignment(playerid, Robbery_HackingUI[playerid][9], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColor(playerid, Robbery_HackingUI[playerid][9], -1);
    PlayerTextDrawSetShadow(playerid, Robbery_HackingUI[playerid][9], 0);
    PlayerTextDrawBackgroundColor(playerid, Robbery_HackingUI[playerid][9], 255);
    PlayerTextDrawFont(playerid, Robbery_HackingUI[playerid][9], TEXT_DRAW_FONT_3);
    PlayerTextDrawSetProportional(playerid,  Robbery_HackingUI[playerid][9], true);

    Robbery_HackingUI[playerid][10] = CreatePlayerTextDraw(playerid, 565.999816, 339.333282, "2");
    PlayerTextDrawLetterSize(playerid, Robbery_HackingUI[playerid][10], 0.550000, 1.965037);
    PlayerTextDrawTextSize(playerid, Robbery_HackingUI[playerid][10], 0.000000, 330.000000);
    PlayerTextDrawAlignment(playerid, Robbery_HackingUI[playerid][10], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColor(playerid, Robbery_HackingUI[playerid][10], -1);
    PlayerTextDrawSetShadow(playerid, Robbery_HackingUI[playerid][10], 0);
    PlayerTextDrawBackgroundColor(playerid, Robbery_HackingUI[playerid][10], 255);
    PlayerTextDrawFont(playerid, Robbery_HackingUI[playerid][10], TEXT_DRAW_FONT_3);
    PlayerTextDrawSetProportional(playerid,  Robbery_HackingUI[playerid][10], true);

    Robbery_HackingUI[playerid][11] = CreatePlayerTextDraw(playerid, 580.666503, 339.333282, "2");
    PlayerTextDrawLetterSize(playerid, Robbery_HackingUI[playerid][11], 0.550000, 1.965037);
    PlayerTextDrawTextSize(playerid, Robbery_HackingUI[playerid][11], 0.000000, 330.000000);
    PlayerTextDrawAlignment(playerid, Robbery_HackingUI[playerid][11], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColor(playerid, Robbery_HackingUI[playerid][11], -1);
    PlayerTextDrawSetShadow(playerid, Robbery_HackingUI[playerid][11], 0);
    PlayerTextDrawBackgroundColor(playerid, Robbery_HackingUI[playerid][11], 255);
    PlayerTextDrawFont(playerid, Robbery_HackingUI[playerid][11], TEXT_DRAW_FONT_3);
    PlayerTextDrawSetProportional(playerid,  Robbery_HackingUI[playerid][11], true);

    Robbery_HackingUI[playerid][12] = CreatePlayerTextDraw(playerid, 594.333007, 339.333282, "2");
    PlayerTextDrawLetterSize(playerid, Robbery_HackingUI[playerid][12], 0.550000, 1.965037);
    PlayerTextDrawTextSize(playerid, Robbery_HackingUI[playerid][12], 0.000000, 330.000000);
    PlayerTextDrawAlignment(playerid, Robbery_HackingUI[playerid][12], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColor(playerid, Robbery_HackingUI[playerid][12], -1);
    PlayerTextDrawSetShadow(playerid, Robbery_HackingUI[playerid][12], 0);
    PlayerTextDrawBackgroundColor(playerid, Robbery_HackingUI[playerid][12], 255);
    PlayerTextDrawFont(playerid, Robbery_HackingUI[playerid][12], TEXT_DRAW_FONT_3);
    PlayerTextDrawSetProportional(playerid,  Robbery_HackingUI[playerid][12], true);

    Robbery_HackingUI[playerid][13] = CreatePlayerTextDraw(playerid, 606.999755, 339.333282, "2");
    PlayerTextDrawLetterSize(playerid, Robbery_HackingUI[playerid][13], 0.550000, 1.965037);
    PlayerTextDrawTextSize(playerid, Robbery_HackingUI[playerid][13], 0.000000, 330.000000);
    PlayerTextDrawAlignment(playerid, Robbery_HackingUI[playerid][13], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColor(playerid, Robbery_HackingUI[playerid][13], -1);
    PlayerTextDrawSetShadow(playerid, Robbery_HackingUI[playerid][13], 0);
    PlayerTextDrawBackgroundColor(playerid, Robbery_HackingUI[playerid][13], 255);
    PlayerTextDrawFont(playerid, Robbery_HackingUI[playerid][13], TEXT_DRAW_FONT_3);
    PlayerTextDrawSetProportional(playerid,  Robbery_HackingUI[playerid][13], true);

    Robbery_HackingUI[playerid][14] = CreatePlayerTextDraw(playerid, 565.999816, 363.807373, "3");
    PlayerTextDrawLetterSize(playerid, Robbery_HackingUI[playerid][14], 0.550000, 1.965037);
    PlayerTextDrawTextSize(playerid, Robbery_HackingUI[playerid][14], 0.000000, 330.000000);
    PlayerTextDrawAlignment(playerid, Robbery_HackingUI[playerid][14], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColor(playerid, Robbery_HackingUI[playerid][14], -1);
    PlayerTextDrawSetShadow(playerid, Robbery_HackingUI[playerid][14], 0);
    PlayerTextDrawBackgroundColor(playerid, Robbery_HackingUI[playerid][14], 255);
    PlayerTextDrawFont(playerid, Robbery_HackingUI[playerid][14], TEXT_DRAW_FONT_3);
    PlayerTextDrawSetProportional(playerid,  Robbery_HackingUI[playerid][14], true);

    Robbery_HackingUI[playerid][15] = CreatePlayerTextDraw(playerid, 580.999816, 363.807373, "3");
    PlayerTextDrawLetterSize(playerid, Robbery_HackingUI[playerid][15], 0.550000, 1.965037);
    PlayerTextDrawTextSize(playerid, Robbery_HackingUI[playerid][15], 0.000000, 330.000000);
    PlayerTextDrawAlignment(playerid, Robbery_HackingUI[playerid][15], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColor(playerid, Robbery_HackingUI[playerid][15], -1);
    PlayerTextDrawSetShadow(playerid, Robbery_HackingUI[playerid][15], 0);
    PlayerTextDrawBackgroundColor(playerid, Robbery_HackingUI[playerid][15], 255);
    PlayerTextDrawFont(playerid, Robbery_HackingUI[playerid][15], TEXT_DRAW_FONT_3);
    PlayerTextDrawSetProportional(playerid,  Robbery_HackingUI[playerid][15], true);

    Robbery_HackingUI[playerid][16] = CreatePlayerTextDraw(playerid, 594.666564, 363.807373, "3");
    PlayerTextDrawLetterSize(playerid, Robbery_HackingUI[playerid][16], 0.550000, 1.965037);
    PlayerTextDrawTextSize(playerid, Robbery_HackingUI[playerid][16], 0.000000, 330.000000);
    PlayerTextDrawAlignment(playerid, Robbery_HackingUI[playerid][16], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColor(playerid, Robbery_HackingUI[playerid][16], -1);
    PlayerTextDrawSetShadow(playerid, Robbery_HackingUI[playerid][16], 0);
    PlayerTextDrawBackgroundColor(playerid, Robbery_HackingUI[playerid][16], 255);
    PlayerTextDrawFont(playerid, Robbery_HackingUI[playerid][16], TEXT_DRAW_FONT_3);
    PlayerTextDrawSetProportional(playerid,  Robbery_HackingUI[playerid][16], true);

    Robbery_HackingUI[playerid][17] = CreatePlayerTextDraw(playerid, 607.666625, 363.807373, "3");
    PlayerTextDrawLetterSize(playerid, Robbery_HackingUI[playerid][17], 0.550000, 1.965037);
    PlayerTextDrawTextSize(playerid, Robbery_HackingUI[playerid][17], 0.000000, 330.000000);
    PlayerTextDrawAlignment(playerid, Robbery_HackingUI[playerid][17], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColor(playerid, Robbery_HackingUI[playerid][17], -1);
    PlayerTextDrawSetShadow(playerid, Robbery_HackingUI[playerid][17], 0);
    PlayerTextDrawBackgroundColor(playerid, Robbery_HackingUI[playerid][17], 255);
    PlayerTextDrawFont(playerid, Robbery_HackingUI[playerid][17], TEXT_DRAW_FONT_3);
    PlayerTextDrawSetProportional(playerid,  Robbery_HackingUI[playerid][17], true);

    Robbery_HackingUI[playerid][18] = CreatePlayerTextDraw(playerid, 565.999816, 385.377838, "4");
    PlayerTextDrawLetterSize(playerid, Robbery_HackingUI[playerid][18], 0.550000, 1.965037);
    PlayerTextDrawTextSize(playerid, Robbery_HackingUI[playerid][18], 0.000000, 330.000000);
    PlayerTextDrawAlignment(playerid, Robbery_HackingUI[playerid][18], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColor(playerid, Robbery_HackingUI[playerid][18], 16711935);
    PlayerTextDrawSetShadow(playerid, Robbery_HackingUI[playerid][18], 0);
    PlayerTextDrawBackgroundColor(playerid, Robbery_HackingUI[playerid][18], 255);
    PlayerTextDrawFont(playerid, Robbery_HackingUI[playerid][18], TEXT_DRAW_FONT_3);
    PlayerTextDrawSetProportional(playerid,  Robbery_HackingUI[playerid][18], true);

    Robbery_HackingUI[playerid][19] = CreatePlayerTextDraw(playerid, 581.666625, 385.377838, "4");
    PlayerTextDrawLetterSize(playerid, Robbery_HackingUI[playerid][19], 0.550000, 1.965037);
    PlayerTextDrawTextSize(playerid, Robbery_HackingUI[playerid][19], 0.000000, 330.000000);
    PlayerTextDrawAlignment(playerid, Robbery_HackingUI[playerid][19], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColor(playerid, Robbery_HackingUI[playerid][19], 16711935);
    PlayerTextDrawSetShadow(playerid, Robbery_HackingUI[playerid][19], 0);
    PlayerTextDrawBackgroundColor(playerid, Robbery_HackingUI[playerid][19], 255);
    PlayerTextDrawFont(playerid, Robbery_HackingUI[playerid][19], TEXT_DRAW_FONT_3);
    PlayerTextDrawSetProportional(playerid,  Robbery_HackingUI[playerid][19], true);

    Robbery_HackingUI[playerid][20] = CreatePlayerTextDraw(playerid, 595.999877, 385.377838, "4");
    PlayerTextDrawLetterSize(playerid, Robbery_HackingUI[playerid][20], 0.550000, 1.965037);
    PlayerTextDrawTextSize(playerid, Robbery_HackingUI[playerid][20], 0.000000, 330.000000);
    PlayerTextDrawAlignment(playerid, Robbery_HackingUI[playerid][20], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColor(playerid, Robbery_HackingUI[playerid][20], 16711935);
    PlayerTextDrawSetShadow(playerid, Robbery_HackingUI[playerid][20], 0);
    PlayerTextDrawBackgroundColor(playerid, Robbery_HackingUI[playerid][20], 255);
    PlayerTextDrawFont(playerid, Robbery_HackingUI[playerid][20], TEXT_DRAW_FONT_3);
    PlayerTextDrawSetProportional(playerid,  Robbery_HackingUI[playerid][20], true);

    Robbery_HackingUI[playerid][21] = CreatePlayerTextDraw(playerid, 609.999694, 385.377838, "4");
    PlayerTextDrawLetterSize(playerid, Robbery_HackingUI[playerid][21], 0.550000, 1.965037);
    PlayerTextDrawTextSize(playerid, Robbery_HackingUI[playerid][21], 0.000000, 330.000000);
    PlayerTextDrawAlignment(playerid, Robbery_HackingUI[playerid][21], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColor(playerid, Robbery_HackingUI[playerid][21], 16711935);
    PlayerTextDrawSetShadow(playerid, Robbery_HackingUI[playerid][21], 0);
    PlayerTextDrawBackgroundColor(playerid, Robbery_HackingUI[playerid][21], 255);
    PlayerTextDrawFont(playerid, Robbery_HackingUI[playerid][21], TEXT_DRAW_FONT_3);
    PlayerTextDrawSetProportional(playerid,  Robbery_HackingUI[playerid][21], true);

    for(new i = 0; i < sizeof Robbery_HackingUI[]; i++) {

        PlayerTextDrawShow(playerid, Robbery_HackingUI[playerid][i]);
    }

}

// ========================================================================
// Functions
// =======================================================================

stock Robbery_ReturnCrewMembers(leader) {

    static count = 0;

    foreach(new i : Player) {

        if( leader == gPlayerRobberyCrewLeader[i] ) {

            count++;
        }
    }

    return count;
}

stock Robbery_ShowPlaningDialog(playerid) {

    Dialog_Show(playerid, "dialog_RobberyOption", DIALOG_STYLE_LIST, "Choose Bank", "#1 Fleeca\n#2 H4RBOR Bank", "Odaberi", "Odustani");

    return (true);
}

stock Robbery_ShowBankPlan(playerid, E_ROBBERY_BANKS:bankType) {

    switch(bankType) {

        case ROBBERY_BANK_UNKNOWN: {  }

        case ROBBERY_BANK_HARBOR: {

            static stepStr[3][32];

            for(new E_ROBBERY_CREW:j = E_ROBBERY_CREW:0; j < E_ROBBERY_CREW:3; j++) {

                if(gPlayerRobbery[playerid][gRobberyStatus][j])
                    format(stepStr[_:j], sizeof stepStr[], ""c_ltorange"Spremno");
                else
                    format(stepStr[_:j], sizeof stepStr[], ""c_red"N/A");
            }

            new dlgStr[568];
            format(dlgStr, sizeof dlgStr, "Banka %s\n%s - %s\n%s - %s\n%s - %s", RobberyBanks[ gPlayerRobbery[playerid][gRobberyType] ],
                                                                                 RobberyCrew[ROBBERY_CREW_DRIVER], stepStr[0], RobberyCrew[ROBBERY_CREW_HACKER], stepStr[1], RobberyCrew[ROBBERY_CREW_BURGLAR], stepStr[2] );
            Dialog_Show(playerid, "dialog_heistNoReturn", DIALOG_STYLE_MSGBOX, "Heist", dlgStr, "Ok", "");
        }

        case ROBBERY_BANK_FLEECA: {

            static stepStr[2][32];

            for(new E_ROBBERY_CREW:j = E_ROBBERY_CREW:0; j < E_ROBBERY_CREW:2; j++) {

                if(gPlayerRobbery[playerid][gRobberyStatus][j])
                    format(stepStr[_:j], sizeof stepStr[], ""c_ltorange"Spremno");
                else
                    format(stepStr[_:j], sizeof stepStr[], ""c_red"N/A");
            }

            new dlgStr[568];
            format(dlgStr, sizeof dlgStr, "Banka %s\n%s - %s\n%s - %s", RobberyBanks[ gPlayerRobbery[playerid][gRobberyType] ],
                                                                                 RobberyCrew[ROBBERY_CREW_DRIVER], stepStr[0], RobberyCrew[ROBBERY_CREW_HACKER], stepStr[1]);
            Dialog_Show(playerid, "dialog_heistNoReturn", DIALOG_STYLE_MSGBOX, "Heist", dlgStr, "Ok", "");
        }
    }

    return (true);
}

stock Robbery_InvitePlayerToCrew(playerid, target, E_ROBBERY_CREW:crewType) {

    if(target == INVALID_PLAYER_ID) return (false);
    if(playerid == INVALID_PLAYER_ID) return (false);

    if(Robbery_ReturnCrewMembers(playerid) == 5)
        return true;

    if(crewType < ROBBERY_CREW_DRIVER || crewType > ROBBERY_CREW_BURGLAR )
        return SendClientMessage(playerid, x_faction, "HEIST: "c_white"Unijeli ste krivi tip pozicije / crew type!");

    if(!IsPlayerConnected(playerid)) return (true);
    if(!IsPlayerConnected(target)) 
        return SendClientMessage(playerid, x_faction, "HEIST: "c_white"Taj igrac nije konektovan na server!"); 

    if(gPlayerRobberyCrewLeader[target] != INVALID_PLAYER_ID)
        return SendClientMessage(playerid, x_faction, "HEIST: "c_white"Taj igrac je vec dio crew-a za heist!");  

    if(gPlayerRobbery[target][gRobberyLeader] == target) 
        return SendClientMessage(playerid, x_faction, "HEIST: "c_white"Taj igrac je vec dio crew-a za heist!");  

    if(gPlayerRobberyInviteCrewType[target] != ROBBERY_CREW_UNKNOWN || gPlayerRobberyInvite[target] != INVALID_PLAYER_ID)
        return SendClientMessage(playerid, x_faction, "HEIST: "c_white"Neko je vec ponudio zahtjev za pridruzivanje ovom igracu!");  

    if(gPlayerRobberyInvite[playerid] == target)
        return SendClientMessage(playerid, x_faction, "HEIST: "c_white"Vec ste poslali zahtjev za pridruzivanje ovom igracu!");  

    if(gPlayerRobberyInvite[playerid] != INVALID_PLAYER_ID)
        return SendClientMessage(playerid, x_faction, "HEIST: "c_white"Vec ste poslali zahtjev za pridruzivanje nekom igracu!");  

    if(target == playerid)
        return SendClientMessage(playerid, x_faction, "HEIST: "c_white"Ne mozete poslati zahtjev samom sebi!");  

    if(IsPlayerPoliceMember(target))
        return SendClientMessage(playerid, x_faction, "HEIST: "c_white"Ne mozete poslati zahtjev za pridruzivanje ovom igracu!"); 

    if(!DistanceBetweenPlayers(3.40, playerid, target))
        return SendClientMessage(playerid, x_faction, "HEIST: "c_white"Niste u blizini tog igraca!");

    if(gPlayerRobbery[playerid][gRobberyStatus][crewType])
        return SendClientMessage(playerid, x_faction, "HEIST: "c_white"Vec imate popunjenu poziciju kao - "c_ltorange"%s!", RobberyCrew[crewType]);

    gPlayerRobberyInvite[playerid] = target;
    gPlayerRobberyInvite[target] = playerid;
    gPlayerRobberyInviteCrewType[target] = crewType;

    static sstr[488];
    format(sstr, sizeof sstr, ""c_white"Igrac "c_ltorange"%s[%d] "c_white"vam je poslao zahtjev pridruzivanje grupe za heist, kao "c_ltorange"%s",
                                ReturnCharacterName(playerid), playerid, RobberyCrew[crewType]);

    Dialog_Show(target, "dialog_heistCrewInvite", DIALOG_STYLE_MSGBOX, "Heist Invitation", sstr, "PRIHVATI", "ODBIJ");

    return (true);
}

forward Robbery_OnPlayerUseJammer(playerid);
public Robbery_OnPlayerUseJammer(playerid) {

    if(gPlayerCrewAssigment[playerid] == ROBBERY_CREW_HACKER) {

        if(!IsPlayerInDynamicArea(playerid, gFleecaArea[1] ))
            return SendClientMessage(playerid, x_faction, "HEIST: "c_white"Morate biti u blizini Fleeca Banke kako biste iskoristili ometac signala!");
        
        if(gPlayerStartJamming[playerid])
            return (true);

        Inventory_ResetInterface(playerid);
        Inventory_Remove(playerid, INVENTORY_ITEM_JAMMER, 1);
        SetTimerEx("Robbery_JamCamerasAndLasers", 15 * 1000, false, "d", playerid);
        SendClientMessage(playerid, x_faction, "HEIST: "c_white"Zapoceli ste ometanje signala za kamere i lasere, ostanite na mjestu i sacekajte 15 sekundi!");

        PlayerPlaySound(playerid, 41603, 0.00, 0.00, 0.00);

        gPlayerStartJamming[playerid] = true;
    
    }
    
    return (true);
}

forward Robbery_JamCamerasAndLasers(playerid); 
public Robbery_JamCamerasAndLasers(playerid) {

    if(!gPlayerStartJamming[playerid])
        return (false);

    if(!IsPlayerInDynamicArea(playerid,  gFleecaArea[1]))
        return SendClientMessage(playerid, x_faction, "HEIST: "c_white"Napustili ste zonu banke, te vam je ometanje lasera propalo!");

    new leaderid = gPlayerRobberyCrewLeader[playerid];
    gPlayerRobbery[leaderid][gRobberyProgress] = ROBBERY_STEP_CAMERAS | ROBBERY_STEP_LASERS;
    PlayerPlaySound(playerid, 1137, 0.00, 0.00, 0.00);
    foreach(new i : Player) {

        if(gPlayerRobberyCrewLeader[i] == leaderid) {

            SendClientMessage(i, x_faction, "HEIST: %s %s je uspjesno omeo sve kamere i lasere sa ometacem signala!", RobberyCrew[ROBBERY_CREW_HACKER], ReturnCharacterName(playerid));
        }
    }

    return (true);
}

forward Robbery_FinishFleeca(playerid); 
public Robbery_FinishFleeca(playerid) {

    static tmpStr[248];
    format(tmpStr, sizeof tmpStr, ""c_white"%s[%d] je uspjesno opljackao Fleeca Banku, i uzeo %.2f$", ReturnCharacterName(playerid), playerid, gRobberyStatistic[gRobberyTake][ROBBERY_BANK_FLEECA] );

    GivePlayerMoney(playerid, gRobberyStatistic[gRobberyTake][ROBBERY_BANK_FLEECA]);
    Robbery_SendHeistMessage(playerid, tmpStr);
    gRobberyStatistic[gRobberyActive][ROBBERY_BANK_FLEECA] = false;
    gRobberyStatistic[gRobberyCooldown][ROBBERY_BANK_FLEECA] = gettime() + ( 60 * RobberyBanksCooldown[ROBBERY_BANK_FLEECA] );

    return (true);
}

forward Robbery_BurglarHarborVault(playerid);
public Robbery_BurglarHarborVault(playerid) {

    if(gRobberyCount[playerid] > 0) {

        gRobberyCount[playerid]--;
        GameTextForPlayer(playerid, "~b~JOS %d SEKUNDI", 1000, 3, gRobberyCount[playerid]);
        ApplyAnimation(playerid, !"WEAPONS", !"SHP_1H_Ret_S", 4.0, false, true, true, true, 0);
        KillTimer(gRobberyTimer[playerid]);
        gRobberyTimer[playerid] = SetTimerEx("Robbery_BurglarHarborVault", 1000, false, "d", playerid);
        return ~1;
    }

    else if(gRobberyCount[playerid] <= 0) {

        static tmpStr[248];
        format(tmpStr, sizeof tmpStr, "Pljackas %s je uspjesno uzeo pare iz sefa, spremni ste za bjeg!", ReturnCharacterName(playerid));
        
        new leaderid = gPlayerRobberyCrewLeader[playerid];

        ClearAnimations(playerid);  
        Robbery_SendHeistMessage(gPlayerRobberyCrewLeader[playerid], tmpStr);
        TogglePlayerControllable(playerid, true);
        KillTimer(gRobberyTimer[playerid]);
        
        gPlayerRobbery[leaderid][gRobberyProgress] = ROBBERY_STEP_FINISH;
        
        DisablePlayerCheckpoint(playerid);
        SetPlayerCheckpoint(playerid, 204.9133,-230.3236,1.5057, 3.50);
        gRobberyCheckPoint[playerid] = true;
        return ~1;
    }

    return (true);
}

// ========================================================================
// Hooks
// ========================================================================

hook OnGameModeInit() {

    //* Areas for fleeca (1. Area for lasers, 2. Area to disable lasers and cameras with ometac singala)

    gFleecaArea[0] = CreateDynamicRectangle(1676.27, -1464.04, 1682.24, -1456.8);
    gFleecaArea[1] = CreateDynamicRectangle(1663.11, -1473.34, 1711.27, -1445.7);

    gRobberyStatistic[gRobberyActive][ROBBERY_BANK_HARBOR] = false;
    gRobberyStatistic[gRobberyActive][ROBBERY_BANK_FLEECA] = false;
    gRobberyStatistic[gRobberyCooldown][ROBBERY_BANK_HARBOR] = gettime();
    gRobberyStatistic[gRobberyCooldown][ROBBERY_BANK_FLEECA] = gettime();

    gRobberyStatistic[gRobberyTake][ROBBERY_BANK_HARBOR] = 68122.58;
    gRobberyStatistic[gRobberyTake][ROBBERY_BANK_FLEECA] = 24572.42;

    gRobberySafeObject[0] = CreateDynamicObject(2025, 1311.702270, 2556.406494, -22.058546, 0.000014, 0.000000, 177.499816, -1, 29, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(gRobberySafeObject[0], 0, 19962, "samproadsigns", "materialtext1", 0x00000000); 
    
    gRobberySafeObject[1] = CreateDynamicObject(18886, 1311.098876, 2557.819824, -20.740982, 89.800209, 91.301528, 89.998527, -1, 29, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(gRobberySafeObject[1] , 0, 3440, "airportpillar", "metalic_64", 0xFFFFFFFF);
    SetDynamicObjectMaterial(gRobberySafeObject[1] , 1, 3440, "airportpillar", "metalic_64", 0x00000000);
    SetDynamicObjectMaterial(gRobberySafeObject[1] , 2, 3440, "airportpillar", "metalic_64", 0x00000000);

    CreateDynamic3DTextLabel(""c_grey"\187; "c_white"H4RBOR VAULT\n"c_white"[ N ]", -1, 1311.0931,2547.5273,-21.6686, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 29);

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook Robbery_CheckPlayerGasMask(playerid) {

    foreach(new i : Player) {

        if(gPlayerRobbery[i][gRobberyType] == ROBBERY_BANK_HARBOR) {

            if(gPlayerRobbery[i][gRobberyProgress] >= ROBBERY_STEP_TEAR_GAS) {

                SetPlayerWeather(playerid, 9);
            }
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid) {

    if(areaid == gFleecaArea[0]) {

        new leaderid = gPlayerRobberyCrewLeader[playerid];
        
        if(gPlayerRobbery[leaderid][robberyStealing]) {

            if(gPlayerCrewAssigment[playerid] == ROBBERY_CREW_BURGLAR) {

                gPlayerRobbery[leaderid][robberyStealing] = false;
                PlayerPlaySound(playerid, 21001, 0.00, 0.00, 0.00);
                foreach(new i : Player) {

                    if(gPlayerRobberyCrewLeader[i] == leaderid) {

                        SendClientMessage(i, x_faction, "HEIST: Pljackas je napustio zonu sefa te je pljacka propala!");
                    }
                }
            }
        }
    }

    ///gPlayerStartJamming
    if(areaid == gFleecaArea[1]) 
    {

        if(gPlayerStartJamming[playerid]) 
        {

            gPlayerStartJamming[playerid] = false;
            new leaderid = gPlayerRobberyCrewLeader[playerid];

            foreach(new i : Player) {

                if(gPlayerRobberyCrewLeader[i] == leaderid) {

                    SendClientMessage(i, x_faction, "HEIST: Hacker %s je napustio zonu hakiranja, te je hakiranje propalo!", ReturnCharacterName(playerid));
                
                }    
            }
        }
    }

    return (true);
}

hook OnPlayerEnterCheckpoint(playerid) {


    if(gRobberyCheckPoint[playerid]) {


        if(IsPlayerInRangeOfPoint(playerid, 3.7, 204.9133,-230.3236,1.5057))
        {

            if(gPlayerCrewAssigment[playerid] != ROBBERY_CREW_BURGLAR)
                return SendClientMessage(playerid, x_faction, "HEIST: Samo pljackas moze dostaviti novac!");

            new leaderid = gPlayerRobberyCrewLeader[playerid];

            static tmpStr[248];
            format(tmpStr, sizeof tmpStr, ""c_white"Pljackas %s[%d] je dostavio novac na lokaciju, te je dobio %.2f$", ReturnCharacterName(playerid), playerid, gRobberyStatistic[gRobberyTake][ROBBERY_BANK_HARBOR]);
            Robbery_SendHeistMessage(leaderid, tmpStr);

            SendClientMessageToAll(x_faction, "H4RBOR BANK: "c_white"Nepoznata grupa pljackasa je opljackala H4RBOR Banku!");
            SendClientMessageToAll(x_faction, "H4RBOR BANK: "c_white"Odnesena svota novca je priblizno %.2f$!", gRobberyStatistic[gRobberyTake][ROBBERY_BANK_HARBOR]);

            gRobberyStatistic[gRobberyActive][ROBBERY_BANK_HARBOR] = false;
            gRobberyStatistic[gRobberyCooldown][ROBBERY_BANK_HARBOR] = gettime() + (60 * RobberyBanksCooldown[ROBBERY_BANK_HARBOR]);

            Robbery_ResetPlayerVars(playerid);
            return Y_HOOKS_BREAK_RETURN_1;
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid) {

    if(areaid == gFleecaArea[0]) {

        new leaderid = gPlayerRobberyCrewLeader[playerid];

        if(gPlayerRobbery[leaderid][robberyStealing]) 
            return ~1;

        if(gPlayerCrewAssigment[playerid] == ROBBERY_CREW_BURGLAR && gPlayerRobbery[leaderid][gRobberyCrew]) 
        {

            if(gPlayerRobbery[leaderid][gRobberyProgress] == ROBBERY_STEP_CAMERAS | ROBBERY_STEP_LASERS) 
            {
                SendClientMessage(playerid, x_faction, "HEIST: Zapoceli ste pljacku, ostanite u radiusu od sefa!");
                gPlayerRobbery[leaderid][robberyStealing] = true;
                SetTimerEx("Robbery_FinishFleeca", 120 * 1000, false, "d", playerid);
            }

            else {

                SendClientMessage(playerid, x_faction, "HEIST: Zapoceli ste pljacku, ostanite u radiusu od sefa!");
                SendClientMessageToAll(x_faction, "HEIST: Nepoznata grupa ljudi je zapocela pljacku Fleeca Banke!");
                SendClientMessageToAll(x_faction, "HEIST: Mole se svi gradjani da se smaknu sa mjesta, i pricekaju policiju da intervenise!");

                
                PlayerPlaySound(playerid, 3401, 0.00, 0.00, 0.00);

                foreach(new j : Player) {

                    if(leaderid == gPlayerRobberyCrewLeader[j]) {

                        Police_SetPlayerWantedLevel(j, 6, "Nadzorna Kamera");
                    }
                }

                gPlayerRobbery[leaderid][robberyStealing] = true;
                SetTimerEx("Robbery_FinishFleeca", 120 * 1000, false, "d", playerid);
            }
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerConnect(playerid) {

    //* Var Reset

    Robbery_ResetHackingInterface(playerid);

    Robbery_ResetPlayerVars(playerid);

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerDisconnect(playerid, reason) {

    if(gPlayerCrewAssigment[playerid] != ROBBERY_CREW_UNKNOWN) {

        new leaderid = gPlayerRobberyCrewLeader[playerid];

        if(Robbery_ReturnCrewMembers(leaderid) < 2) {

            static tmpStr[248];
            format(tmpStr, sizeof tmpStr, ""c_white"Heist je propao, "c_ltorange"%s %s[%d] "c_white"je napustio server.", RobberyCrew[ gPlayerCrewAssigment[playerid] ], ReturnCharacterName(playerid), playerid);

            Robbery_SendHeistMessage(leaderid, tmpStr);

            foreach(new i : Player) {

                if(leaderid == gPlayerRobberyCrewLeader[i]) {

                    if(gPlayerCrewAssigment[i] == ROBBERY_CREW_HACKER && gRobberyCombination[i] != 0) {

                        Robbery_ResetHackingInterface(playerid);
                        KillTimer(gRobberyBreachTimer[playerid]);
                    }

                    Robbery_ResetPlayerVars(i);
                }
            }

        }
    }

    if(gPlayerRobbery[playerid][gRobberyLeader] == playerid) {

        Robbery_SendHeistMessage(gPlayerRobbery[playerid][gRobberyLeader], "Heist je propao, leader heist crew-a je napustio server.");

        foreach(new i : Player) {

            if(gPlayerRobbery[playerid][gRobberyLeader] == gPlayerRobberyCrewLeader[i]) {

                Robbery_ResetPlayerVars(i);

                if(gPlayerCrewAssigment[i] == ROBBERY_CREW_HACKER && gRobberyCombination[i] != 0) {

                    Robbery_ResetHackingInterface(playerid);
                    KillTimer(gRobberyBreachTimer[playerid]);
                }
            }
        }

        Robbery_ResetPlayerVars(playerid);
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerDeath(playerid, killerid, reason)
{

    if(gPlayerCrewAssigment[playerid] == ROBBERY_CREW_BURGLAR) {

        if(gRobberyCount[playerid] != 0) {
            
            new leaderid = gPlayerRobberyCrewLeader[playerid];
            Robbery_SendHeistMessage(leaderid, "Pljacka je propala, pljackas je ubijen tokom kradje novca iz sefa!");

            foreach(new i : Player) {

                if(leaderid == gPlayerRobberyCrewLeader[i]) {

                    Police_SetPlayerWantedLevel(i, 6, "Policija");
                    Robbery_ResetPlayerVars(i);
                }
            }
        }
    }

    if(gPlayerRobbery[playerid][gRobberyLeader] == playerid) {

        Robbery_SendHeistMessage(gPlayerRobbery[playerid][gRobberyLeader], "Pljacka je propala, leader heist crew-a je umro!");

        foreach(new i : Player) {

            if(gPlayerRobbery[playerid][gRobberyLeader] == gPlayerRobberyCrewLeader[i]) {

                Police_SetPlayerWantedLevel(i, 6, "Policija");
                Robbery_ResetPlayerVars(i);

                if(gPlayerCrewAssigment[i] == ROBBERY_CREW_HACKER && gRobberyCombination[i] != 0) {

                    Robbery_ResetHackingInterface(playerid);
                    KillTimer(gRobberyBreachTimer[playerid]);
                }
            }
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys) {

    if(PRESSED(KEY_NO)) {

        if(gRobberyCombination[playerid] != 0) {

            gCombinationIndex[playerid]++;

            if(gCombinationIndex[playerid] > 3)
                return Y_HOOKS_BREAK_RETURN_1;

            Robbery_ChoseHackingCombination(playerid);

        }

        if(IsPlayerInRangeOfPoint(playerid, 3.0, 1311.0931,2547.5273,-21.6686)) {

            new leaderid = gPlayerRobberyCrewLeader[playerid];
            
            if(leaderid == INVALID_PLAYER_ID)
                return Y_HOOKS_BREAK_RETURN_1;

            if(gPlayerRobbery[playerid][gRobberyProgress] != ROBBERY_STEP_DYNAMITE) 
                return (true);

            if(gPlayerCrewAssigment[playerid] != ROBBERY_CREW_BURGLAR)
                return SendClientMessage(playerid, x_faction, "HEIST: "c_white"Samo pljackas moze ovo!");

            if(gRobberyCount[playerid] != 0)
                return (true);
        
            TogglePlayerControllable(playerid, false);
            gRobberyCount[playerid] = 120;
            gRobberyTimer[playerid] = SetTimerEx("Robbery_BurglarHarborVault", 1000, false, "d", playerid);

        }
    }

    return (true);
}

YCMD:heistplan(playerid, params[], help) {

    if(!IsPlayerInRangeOfPoint(playerid, 3.40, -1581.5887,-2697.9929,2.0221))
        return (true);

    Robbery_ShowPlaningDialog(playerid);
    return (true);
} 

YCMD:startheist(playerid, params[], help) {

    if(gPlayerRobbery[playerid][gRobberyInPreparation])
        return SendClientMessage(playerid, x_faction, "HEIST: "c_white"Vec ste zapoceli planiranje heista!");

    new E_ROBBERY_BANKS:bankType;
    if(sscanf(params, "d", _:bankType))
    {
        SendClientMessage(playerid, x_faction, "HEIST: "c_white"/startheist [ BANK ]");
        SendClientMessage(playerid, x_faction, "* "c_white"1 - H4RBOR Bank  2 - Fleeca Bank");
        return ~1;
    }

    if(bankType < ROBBERY_BANK_HARBOR || bankType > ROBBERY_BANK_FLEECA)
        return (true);

    if(gRobberyStatistic[gRobberyActive][bankType])
        return SendClientMessage(playerid, x_server, "HESIT: "c_white"Neko je vec zapoceo pljacku te banke!");
    
    if(gRobberyStatistic[gRobberyCooldown][bankType] > gettime())
        return SendClientMessage(playerid, x_server, "HEIST: "c_white"Neko je nedavno opljackao ovu banku! Pokusajte kasnije...");


    gPlayerRobbery[playerid][gRobberyType] = bankType;
    gPlayerRobbery[playerid][gRobberyCrewMembers] = 0;
    gPlayerRobbery[playerid][gRobberyLeader] = playerid;
    gPlayerRobbery[playerid][gRobberyInPreparation] = true;
    gPlayerRobberyCrewLeader[playerid] = playerid;
    gPlayerCrewAssigment[playerid] = ROBBERY_CREW_BURGLAR;

    SendClientMessage(playerid, x_faction, "HEIST: "c_white"Zapoceli ste hesit preparation "c_faction"[ %s ]", RobberyBanks[ bankType ]);
    SendClientMessage(playerid, x_faction, "HEIST: "c_white"Kako biste pozvali nekog clana, koristite komandu "c_ltorange"/heistinvite");
    return (true);
}

YCMD:heistinvite(playerid, params[], help) {

    if(!gPlayerRobbery[playerid][gRobberyInPreparation])
        return SendClientMessage(playerid, x_faction, "HEIST: "c_white"Niste zapoceli planiranje heist-a!");

    new crewid, E_ROBBERY_CREW:gCrewType;

    if(sscanf(params, "ud", crewid, _:gCrewType))
    {
        SendClientMessage(playerid, x_faction, "HEIST: "c_white"/heistinvite [ ID/Ime Igraca ] [ Crew Type ]");
        SendClientMessage(playerid, x_faction, "* "c_white"1 - Driver  2 - Hacker  3 - Pljackas");
        return ~1;
    }

    Robbery_InvitePlayerToCrew(playerid, crewid, gCrewType);

    return (true);
}

YCMD:teargas(playerid, params[], help) 
{
    
    if(!IsPlayerInRangeOfPoint(playerid, 2.0, 982.4846,-1212.9150,11.7786))
        return (true);

    new leaderid = gPlayerRobberyCrewLeader[playerid];

    if(leaderid == INVALID_PLAYER_ID)
        return (true);

    if(gPlayerRobbery[leaderid][gRobberyProgress] == ROBBERY_STEP_TEAR_GAS)
        return SendClientMessage(playerid, x_faction, "HEIST: "c_white"Vec ste postavili suzavac u ventilaciju!");

    CreateDynamicObject(18716, 983.3306,-1211.9404,14.3917, 0.00, 0.00, 0.00);

    gRobberyStatistic[gRobberyActive][ROBBERY_BANK_HARBOR] = true; 

    static tmpStr[248];
    format(tmpStr, sizeof tmpStr, "HEIST: "c_white"%s[%d] je postavio suzavac, pripremite gas maske za ulaz u H4RBOR Banku!", ReturnCharacterName(playerid), playerid);

    gPlayerRobbery[leaderid][gRobberyProgress] = ROBBERY_STEP_TEAR_GAS;
    Robbery_SendHeistMessage(leaderid, tmpStr );
    return 1;
}

YCMD:bruteforce(playerid, params[], help) {

    if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1307.5564,2557.7239,-21.6686))
        return (true);

    if(gPlayerRobberyCrewLeader[playerid] == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, x_faction, "HEIST: "c_white"Niste clan grupe za heist!");

    new leaderid = gPlayerRobberyCrewLeader[playerid];

    if(gPlayerCrewAssigment[playerid] != ROBBERY_CREW_HACKER)
        return SendClientMessage(playerid, x_faction, "HEIST: "c_white"Samo hacker moze ovo!");

    if(gPlayerRobbery[leaderid][gRobberyProgress] != ROBBERY_STEP_TEAR_GAS)
        return SendClientMessage(playerid, x_faction, "HEIST: "c_white"Niste ubacili suzavac u ventilaciju!");

    if(gRobberyCombination[playerid] != 0)
        return SendClientMessage(playerid, x_faction, "HEIST: "c_white"Vec hakujes alarme!");

    if(gPlayerRobbery[leaderid][gRobberyProgress] == ROBBERY_STEP_ALARM)
        return SendClientMessage(playerid, x_faction, "HEIST: "c_white"Vec si ugasio sve alarme!");


    Robbery_ShowHackingInterface(playerid);
    Robbery_FormatHackingCombination(playerid);

    return (true);
}

YCMD:dynamite(playerid, params[], help) {

    if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1311.0708,2557.8801,-21.6686))
        return (true);

    if(gPlayerRobberyCrewLeader[playerid] == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, x_faction, "HEIST: "c_white"Niste clan grupe za heist!");

    new leaderid = gPlayerRobberyCrewLeader[playerid];

    if(gPlayerRobbery[leaderid][gRobberyProgress] != ROBBERY_STEP_ALARM)
        return SendClientMessage(playerid, x_faction, "HEIST: "c_white"Niste ugasili sve alarme!");

    if(gPlayerRobbery[leaderid][gRobberyProgress] == ROBBERY_STEP_DYNAMITE)
        return SendClientMessage(playerid, x_faction, "HEIST: "c_white"Vec ste postavili dinamit!");

    gDynamiteTimer[playerid] = SetTimerEx("Robbery_CreateExplosion", 10 * 1000, false, "d", playerid);
    gPlayerRobbery[leaderid][gRobberyProgress] = ROBBERY_STEP_DYNAMITE;

    static tmpMsg[248];
    format(tmpMsg, sizeof tmpMsg, ""c_white"%s[%d] je postavio dinamit, odaljite se i pricekajte 10 sekundi!", ReturnCharacterName(playerid), playerid);
    Robbery_SendHeistMessage(leaderid, tmpMsg);

    return (true);
}

Dialog:dialog_RobberyOption( const playerid, response, listitem, string:inputtext[] ) {

    if(response) {

        new E_ROBBERY_BANKS:tmp_bank = E_ROBBERY_BANKS:(listitem + 1);
        Robbery_ShowBankPlan(playerid, tmp_bank);
    }

    return (true);
}

Dialog:dialog_heistCrewInvite( const playerid, response, listitem, string:inputtext[] ) {

    if(!response) {

        new target = gPlayerRobberyInvite[playerid];

        SendClientMessage(target, x_faction, "HEIST: "c_white"%s je odbio vas poziv za pridruzivanje u crew", ReturnPlayerName(playerid));

        gPlayerRobberyInvite[target] = INVALID_PLAYER_ID;
        gPlayerRobberyInvite[playerid] = INVALID_PLAYER_ID;
        gPlayerRobberyInviteCrewType[playerid] = ROBBERY_CREW_UNKNOWN;
        return Y_HOOKS_BREAK_RETURN_1;
    }

    new target = gPlayerRobberyInvite[playerid];

    SendClientMessage(target,  x_faction, "HEIST: "c_white"%s je prihvatio vas poziv za pridruzivanje u crew", ReturnPlayerName(playerid));

    gPlayerRobbery[target][gRobberyCrewMembers]++;
    gPlayerRobbery[target][gRobberyStatus][ gPlayerRobberyInviteCrewType[playerid] ] = true;
    gPlayerRobberyCrewLeader[playerid] = target;
    gPlayerCrewAssigment[playerid] = gPlayerRobberyInviteCrewType[playerid];

    SendClientMessage(playerid, x_faction, "HEIST: "c_white"Uspjesno ste se pridruzili u crew kao "c_ltorange"%s", RobberyCrew[gPlayerRobberyInviteCrewType[playerid]]);

    if( gPlayerRobbery[target][gRobberyType] == ROBBERY_BANK_FLEECA) {  

        //* HACKER AND DRIVER     HACKER AND BURGLAR   DRIVER AND BURGLAR

        if( ( gPlayerRobbery[target][gRobberyStatus][ROBBERY_CREW_HACKER] && gPlayerRobbery[target][gRobberyStatus][ROBBERY_CREW_DRIVER] ) || \
            ( gPlayerRobbery[target][gRobberyStatus][ROBBERY_CREW_BURGLAR] && gPlayerRobbery[target][gRobberyStatus][ROBBERY_CREW_DRIVER] ) || \
            ( gPlayerRobbery[target][gRobberyStatus][ROBBERY_CREW_HACKER] && gPlayerRobbery[target][gRobberyStatus][ROBBERY_CREW_BURGLAR] ) )
        {

            if(gPlayerRobbery[target][gRobberyCrew]) return (true);

            foreach(new i : Player) {

                if(gPlayerRobberyCrewLeader[i] == target) {

                    SendClientMessage(i, x_faction, "HEIST: Clanovi za heist su uspjesno dodjeljeni, mozete poceti sa pljackom!");
                }
            }

            gPlayerRobbery[target][gRobberyCrew] = true;

        }
    }

    if( gPlayerRobbery[target][gRobberyType] == ROBBERY_BANK_HARBOR) {  

        //* HACKER AND DRIVER     HACKER AND BURGLAR   DRIVER AND BURGLAR

        if( ( gPlayerRobbery[target][gRobberyStatus][ROBBERY_CREW_HACKER] && gPlayerRobbery[target][gRobberyStatus][ROBBERY_CREW_DRIVER] ) || \
            ( gPlayerRobbery[target][gRobberyStatus][ROBBERY_CREW_BURGLAR] && gPlayerRobbery[target][gRobberyStatus][ROBBERY_CREW_DRIVER] ) || \
            ( gPlayerRobbery[target][gRobberyStatus][ROBBERY_CREW_HACKER] && gPlayerRobbery[target][gRobberyStatus][ROBBERY_CREW_BURGLAR] ) )
        {

            foreach(new i : Player) {

                if(gPlayerRobberyCrewLeader[i] == target) {

                    SendClientMessage(i, x_faction, "HEIST: Clanovi za heist su uspjesno dodjeljeni, mozete poceti sa pljackom!");
                }
            }

            gPlayerRobbery[target][gRobberyCrew] = true;

        }
    }

    gPlayerRobberyInvite[target] = INVALID_PLAYER_ID;
    gPlayerRobberyInvite[playerid] = INVALID_PLAYER_ID;
    gPlayerRobberyInviteCrewType[playerid] = ROBBERY_CREW_UNKNOWN;

    return (true);
}

//* DEBUG:

stock GenerateNonZeroRandomNumber()
{   
    //Thanks GPT

    new number;
    new hasZero;

    while (TRUE)
    {
       
        number = random(9000) + 1000; 
        
        hasZero = 0;
        new temp = number;

        while (temp > 0)
        {
            if (temp % 10 == 0) 
            {
                hasZero = 1;
                break;
            }
            temp /= 10;
        }

        if (!hasZero) 
        {
            return number;
        }
    }

    return number;
}

YCMD:messageme(playerid, params[], help) {

    SendServerMessage(playerid, "Nigger %d", 420);

    return (true);
}