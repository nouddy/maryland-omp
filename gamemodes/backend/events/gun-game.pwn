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
 *  @Date           01 Nov 2024
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           gun-game.pwn
 *  @Module         events

*/


#include <ysilib\YSI_Coding\y_hooks>

#define GUNG_GAME_VW            (6)
#define MAX_GUNGAME_LEVEL       (12)
#define MAX_TOP_PLAYERS         (3)
#define DEATHS_TO_DEMOTE        (2)
#define KILLS_TO_ADVANCE        (2)

//*==============================================================================
//?--->>> Begining
//*==============================================================================

//*     -> Start : 34(SNIPER)   -> End 22(COLT45)
//*     -> MIN.X -473, MIN.Y 2184.5, MAX.X -340, MAX.Y 2290.5
//*     -> SetPlayerWorldBounds(playerid, -340.0, -473.0, 2290.5, 2184.5)

enum E_GUNGAME_PLAYER_DATA {

    ggWeapon,
    ggKills,
    ggLevel,
    ggKillStreak,
    ggDeathStreak
}

new GunGame[MAX_PLAYERS][E_GUNGAME_PLAYER_DATA],
    Iterator:iter_GunGamePlayers<MAX_PLAYERS>,
    bool:playerGunGame[MAX_PLAYERS],
    bool:playerGunGameDeath[MAX_PLAYERS],
    bool:gunGameActive = false;

new PlayerText:gungame_UI[MAX_PLAYERS][23];

enum E_GUNGAME_SPAWN {

    Float:ggSpawn[3]
}

new const Float:sz_RandomGunGamePositions[][E_GUNGAME_SPAWN] = {

    { { -439.4956,2210.7478,42.4297 } },
    { { -417.9405,2210.1182,42.4297 } },
    { { -396.6783,2234.3181,42.4297 } },
    { { -384.2307,2257.1550,42.4314 } },
    { { -404.7101,2281.4351,41.1907 } },
    { { -428.2449,2276.5164,42.6620 } },
    { { -446.1151,2254.3628,42.4297 } },
    { { -439.1741,2222.6431,46.9560 } },
    { { -423.9549,2194.0376,42.3159 } },
    { { -396.9702,2176.8145,41.6251 } },
    { { -341.4369,2202.2747,42.4844 } },
    { { -327.4710,2226.5952,43.2655 } },
    { { -342.1971,2261.2209,46.8735 } },
    { { -419.6798,2285.3262,42.2397 } },
    { { -450.3276,2260.8374,44.3837 } }
};

enum E_TOP_PLAYERS {
    tp_playerid,
    tp_level
}

static TopPlayers[MAX_TOP_PLAYERS][E_TOP_PLAYERS];

new const gg_WeaponModels[47] = {
	0,331,333,
	334,335,336,
	337,338,339,
	341,321,321,
	323,324,325,
	326,342,343,
	344,
	18631,
	18631,
	18631
	,346,347,
	348,349,350,
	351,352,353,
	355,356,372,
	357,358,359,
	360,361,362,
	363,364,365,
	366,367,368,
	369,371	
};

//*==============================================================================
//?--->>> functions
//*==============================================================================

stock PrepareGunGame(playerid) {

    GivePlayerWeapon(playerid, WEAPON_SNIPER, 20000);
    SetPlayerWorldBounds(playerid, -340.0, -473.0, 2290.5, 2184.5);
    
    GunGame[playerid][ggWeapon] = WEAPON_SNIPER;
    GunGame[playerid][ggLevel] = 0;

    new idx = random( sizeof sz_RandomGunGamePositions );
    SetPlayerPos(playerid, sz_RandomGunGamePositions[idx][ggSpawn][0], sz_RandomGunGamePositions[idx][ggSpawn][1], sz_RandomGunGamePositions[idx][ggSpawn][2]);
    SendClientMessage(playerid, x_faction, "GUN-GAME: Uspjesno ste se pridruzili gun game-u!");

    PlayerTextDraw_UpdateModel(playerid, gungame_UI[playerid][19], gg_WeaponModels[ WEAPON:WEAPON_SNIPER ]  );
    PlayerTextDraw_UpdateModel(playerid, gungame_UI[playerid][20], gg_WeaponModels[ WEAPON: (WEAPON_SNIPER-1) ]  );

    Iter_Add(iter_GunGamePlayers, playerid);

    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 6);

    return (true);
}


stock ResetGunGameInterface(playerid) {

    for(new i = 0; i < sizeof gungame_UI[]; i++) {

        if(gungame_UI[playerid][i] == INVALID_PLAYER_TEXT_DRAW) continue;

        PlayerTextDrawDestroy(playerid, gungame_UI[playerid][i]);
        gungame_UI[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
    }
}

stock ShowGunGameInterface(playerid) {

    ResetGunGameInterface(playerid);

    gungame_UI[playerid][0] = CreatePlayerTextDraw(playerid, 337.333312, -8.851857, "");
    PlayerTextDrawTextSize(playerid, gungame_UI[playerid][0], 53.000000, 59.000000);
    PlayerTextDrawAlignment(playerid, gungame_UI[playerid][0], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColor(playerid, gungame_UI[playerid][0], 255);
    PlayerTextDrawSetShadow(playerid, gungame_UI[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, gungame_UI[playerid][0], 0xFFFFFF00);
    PlayerTextDrawFont(playerid, gungame_UI[playerid][0], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid, gungame_UI[playerid][0], false);
    PlayerTextDrawSetPreviewModel(playerid, gungame_UI[playerid][0], 2729);
    PlayerTextDrawSetPreviewRot(playerid, gungame_UI[playerid][0], 0.000000, 0.000000, 0.000000, 1.000000);

    gungame_UI[playerid][1] = CreatePlayerTextDraw(playerid, 294.666656, -8.851857, "");
    PlayerTextDrawTextSize(playerid, gungame_UI[playerid][1], 53.000000, 59.000000);
    PlayerTextDrawAlignment(playerid, gungame_UI[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColor(playerid, gungame_UI[playerid][1], 255);
    PlayerTextDrawSetShadow(playerid, gungame_UI[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, gungame_UI[playerid][1], 0xFFFFFF00);
    PlayerTextDrawFont(playerid, gungame_UI[playerid][1], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid, gungame_UI[playerid][1], false);
    PlayerTextDrawSetPreviewModel(playerid, gungame_UI[playerid][1], 2729);
    PlayerTextDrawSetPreviewRot(playerid, gungame_UI[playerid][1], 0.000000, 0.000000, 0.000000, 1.000000);

    gungame_UI[playerid][2] = CreatePlayerTextDraw(playerid, 250.000030, -8.851857, "");
    PlayerTextDrawTextSize(playerid, gungame_UI[playerid][2], 53.000000, 59.000000);
    PlayerTextDrawAlignment(playerid, gungame_UI[playerid][2], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColor(playerid, gungame_UI[playerid][2], 255);
    PlayerTextDrawSetShadow(playerid, gungame_UI[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, gungame_UI[playerid][2], 0xFFFFFF00);
    PlayerTextDrawFont(playerid, gungame_UI[playerid][2], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid,  gungame_UI[playerid][2], false);
    PlayerTextDrawSetPreviewModel(playerid, gungame_UI[playerid][2], 2729);
    PlayerTextDrawSetPreviewRot(playerid, gungame_UI[playerid][2], 0.000000, 0.000000, 0.000000, 1.000000);

    gungame_UI[playerid][3] = CreatePlayerTextDraw(playerid, 253.666748, 0.274068, "");
    PlayerTextDrawTextSize(playerid, gungame_UI[playerid][3], 45.000000, 38.000000);
    PlayerTextDrawAlignment(playerid, gungame_UI[playerid][3], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColor(playerid, gungame_UI[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, gungame_UI[playerid][3], 0);
    PlayerTextDrawBackgroundColor(playerid, gungame_UI[playerid][3], 0xFFFFFF00);
    PlayerTextDrawFont(playerid, gungame_UI[playerid][3], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid,  gungame_UI[playerid][3], false);
    PlayerTextDrawSetPreviewModel(playerid, gungame_UI[playerid][3], 180);
    PlayerTextDrawSetPreviewRot(playerid, gungame_UI[playerid][3], 0.000000, 0.000000, 0.000000, 1.000000);

    gungame_UI[playerid][4] = CreatePlayerTextDraw(playerid, 297.666748, 0.274068, "");
    PlayerTextDrawTextSize(playerid, gungame_UI[playerid][4], 45.000000, 38.000000);
    PlayerTextDrawAlignment(playerid, gungame_UI[playerid][4], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColor(playerid, gungame_UI[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, gungame_UI[playerid][4], 0);
    PlayerTextDrawBackgroundColor(playerid, gungame_UI[playerid][4], 0xFFFFFF00);
    PlayerTextDrawFont(playerid, gungame_UI[playerid][4], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid,  gungame_UI[playerid][4], false);
    PlayerTextDrawSetPreviewModel(playerid, gungame_UI[playerid][4], 180);
    PlayerTextDrawSetPreviewRot(playerid, gungame_UI[playerid][4], 0.000000, 0.000000, 0.000000, 1.000000);

    gungame_UI[playerid][5] = CreatePlayerTextDraw(playerid, 341.666717, 0.274068, "");
    PlayerTextDrawTextSize(playerid, gungame_UI[playerid][5], 45.000000, 38.000000);
    PlayerTextDrawAlignment(playerid, gungame_UI[playerid][5], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColor(playerid, gungame_UI[playerid][5], -1);
    PlayerTextDrawBackgroundColor(playerid, gungame_UI[playerid][5], 0xFFFFFF00);
    PlayerTextDrawSetShadow(playerid, gungame_UI[playerid][5], 0);
    PlayerTextDrawFont(playerid, gungame_UI[playerid][5], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid,  gungame_UI[playerid][5], false);
    PlayerTextDrawSetPreviewModel(playerid, gungame_UI[playerid][5], 180);
    PlayerTextDrawSetPreviewRot(playerid, gungame_UI[playerid][5], 0.000000, 0.000000, 0.000000, 1.000000);

    gungame_UI[playerid][6] = CreatePlayerTextDraw(playerid, 250.333267, 7.325920, "");
    PlayerTextDrawTextSize(playerid, gungame_UI[playerid][6], 52.000000, 38.000000);
    PlayerTextDrawAlignment(playerid, gungame_UI[playerid][6], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColor(playerid, gungame_UI[playerid][6], 255);
    PlayerTextDrawSetShadow(playerid, gungame_UI[playerid][6], 0);
    PlayerTextDrawBackgroundColor(playerid, gungame_UI[playerid][6], 0xFFFFFF00);
    PlayerTextDrawBackgroundColor(playerid, gungame_UI[playerid][6], -256);
    PlayerTextDrawFont(playerid, gungame_UI[playerid][6], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid,  gungame_UI[playerid][6], false);
    PlayerTextDrawSetPreviewModel(playerid, gungame_UI[playerid][6], 2729);
    PlayerTextDrawSetPreviewRot(playerid, gungame_UI[playerid][6], 0.000000, 0.000000, 0.000000, 1.000000);

    gungame_UI[playerid][7] = CreatePlayerTextDraw(playerid, 294.999816, 7.325920, "");
    PlayerTextDrawTextSize(playerid, gungame_UI[playerid][7], 52.000000, 38.000000);
    PlayerTextDrawAlignment(playerid, gungame_UI[playerid][7], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColor(playerid, gungame_UI[playerid][7], 255);
    PlayerTextDrawSetShadow(playerid, gungame_UI[playerid][7], 0);
    PlayerTextDrawBackgroundColor(playerid, gungame_UI[playerid][7], 0xFFFFFF00);
    PlayerTextDrawFont(playerid, gungame_UI[playerid][7], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid,  gungame_UI[playerid][7], false);
    PlayerTextDrawSetPreviewModel(playerid, gungame_UI[playerid][7], 2729);
    PlayerTextDrawSetPreviewRot(playerid, gungame_UI[playerid][7], 0.000000, 0.000000, 0.000000, 1.000000);

    gungame_UI[playerid][8] = CreatePlayerTextDraw(playerid, 338.333221, 7.325920, "");
    PlayerTextDrawTextSize(playerid, gungame_UI[playerid][8], 52.000000, 38.000000);
    PlayerTextDrawAlignment(playerid, gungame_UI[playerid][8], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColor(playerid, gungame_UI[playerid][8], 255);
    PlayerTextDrawSetShadow(playerid, gungame_UI[playerid][8], 0);
    PlayerTextDrawBackgroundColor(playerid, gungame_UI[playerid][8], 0xFFFFFF00);
    PlayerTextDrawFont(playerid, gungame_UI[playerid][8], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid,  gungame_UI[playerid][8], false);
    PlayerTextDrawSetPreviewModel(playerid, gungame_UI[playerid][8], 2729);
    PlayerTextDrawSetPreviewRot(playerid, gungame_UI[playerid][8], 0.000000, 0.000000, 0.000000, 1.000000);

    gungame_UI[playerid][9] = CreatePlayerTextDraw(playerid, 276.333282, 19.096313, "N/A");
    PlayerTextDrawLetterSize(playerid, gungame_UI[playerid][9], 0.083333, 0.521481);
    PlayerTextDrawAlignment(playerid, gungame_UI[playerid][9], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColor(playerid, gungame_UI[playerid][9], -1);
    PlayerTextDrawSetShadow(playerid, gungame_UI[playerid][9], 0);
    PlayerTextDrawBackgroundColor(playerid, gungame_UI[playerid][9], 255);
    PlayerTextDrawFont(playerid, gungame_UI[playerid][9], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid,  gungame_UI[playerid][9], true);

    gungame_UI[playerid][10] = CreatePlayerTextDraw(playerid, 321.333251, 19.096313, "N/A");
    PlayerTextDrawLetterSize(playerid, gungame_UI[playerid][10], 0.083333, 0.521481);
    PlayerTextDrawAlignment(playerid, gungame_UI[playerid][10], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColor(playerid, gungame_UI[playerid][10], -1);
    PlayerTextDrawSetShadow(playerid, gungame_UI[playerid][10], 0);
    PlayerTextDrawBackgroundColor(playerid, gungame_UI[playerid][10], 255);
    PlayerTextDrawFont(playerid, gungame_UI[playerid][10], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid,  gungame_UI[playerid][10], true);

    gungame_UI[playerid][11] = CreatePlayerTextDraw(playerid, 363.999969, 19.096313, "N/A");
    PlayerTextDrawLetterSize(playerid, gungame_UI[playerid][11], 0.083333, 0.521481);
    PlayerTextDrawAlignment(playerid, gungame_UI[playerid][11], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColor(playerid, gungame_UI[playerid][11], -1);
    PlayerTextDrawSetShadow(playerid, gungame_UI[playerid][11], 0);
    PlayerTextDrawBackgroundColor(playerid, gungame_UI[playerid][11], 255);
    PlayerTextDrawFont(playerid, gungame_UI[playerid][11], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid,  gungame_UI[playerid][11], true);

    gungame_UI[playerid][12] = CreatePlayerTextDraw(playerid, 257.333435, 2.348145, "");
    PlayerTextDrawTextSize(playerid, gungame_UI[playerid][12], 34.000000, 58.000000);
    PlayerTextDrawAlignment(playerid, gungame_UI[playerid][12], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColor(playerid, gungame_UI[playerid][12], -1);
    PlayerTextDrawSetShadow(playerid, gungame_UI[playerid][12], 0);
    PlayerTextDrawBackgroundColor(playerid, gungame_UI[playerid][12], 0xFFFFFF00);
    PlayerTextDrawFont(playerid, gungame_UI[playerid][12], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid,  gungame_UI[playerid][12], false);
    PlayerTextDrawSetPreviewModel(playerid, gungame_UI[playerid][12], 356);
    PlayerTextDrawSetPreviewRot(playerid, gungame_UI[playerid][12], 0.000000, 360.000000, 201.000000, 2.445255);

    gungame_UI[playerid][13] = CreatePlayerTextDraw(playerid, 302.000030, 2.348145, "");
    PlayerTextDrawTextSize(playerid, gungame_UI[playerid][13], 34.000000, 58.000000);
    PlayerTextDrawAlignment(playerid, gungame_UI[playerid][13], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColor(playerid, gungame_UI[playerid][13], -1);
    PlayerTextDrawSetShadow(playerid, gungame_UI[playerid][13], 0);
    PlayerTextDrawBackgroundColor(playerid, gungame_UI[playerid][13], 0xFFFFFF00);
    PlayerTextDrawFont(playerid, gungame_UI[playerid][13], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid,  gungame_UI[playerid][13], false);
    PlayerTextDrawSetPreviewModel(playerid, gungame_UI[playerid][13], 356);
    PlayerTextDrawSetPreviewRot(playerid, gungame_UI[playerid][13], 0.000000, 360.000000, 201.000000, 2.445255);

    gungame_UI[playerid][14] = CreatePlayerTextDraw(playerid, 344.333282, 2.348145, "");
    PlayerTextDrawTextSize(playerid, gungame_UI[playerid][14], 34.000000, 58.000000);
    PlayerTextDrawAlignment(playerid, gungame_UI[playerid][14], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColor(playerid, gungame_UI[playerid][14], -1);
    PlayerTextDrawBackgroundColor(playerid, gungame_UI[playerid][14], 0xFFFFFF00);
    PlayerTextDrawSetShadow(playerid, gungame_UI[playerid][14], 0);
    PlayerTextDrawFont(playerid, gungame_UI[playerid][14], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid,  gungame_UI[playerid][14], false);
    PlayerTextDrawSetPreviewModel(playerid, gungame_UI[playerid][14], 356);
    PlayerTextDrawSetPreviewRot(playerid, gungame_UI[playerid][14], 0.000000, 360.000000, 201.000000, 2.445255);

    gungame_UI[playerid][15] = CreatePlayerTextDraw(playerid, 536.333435, 254.555587, "");
    PlayerTextDrawTextSize(playerid, gungame_UI[playerid][15], 23.000000, 20.000000);
    PlayerTextDrawAlignment(playerid, gungame_UI[playerid][15], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColor(playerid, gungame_UI[playerid][15], 255);
    PlayerTextDrawSetShadow(playerid, gungame_UI[playerid][15], 0);
    PlayerTextDrawBackgroundColor(playerid, gungame_UI[playerid][15], 0xFFFFFF00);
    PlayerTextDrawBackgroundColor(playerid, gungame_UI[playerid][15], -256);
    PlayerTextDrawFont(playerid, gungame_UI[playerid][15], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid,  gungame_UI[playerid][15], false);
    PlayerTextDrawSetPreviewModel(playerid, gungame_UI[playerid][15], 1316);
    PlayerTextDrawSetPreviewRot(playerid, gungame_UI[playerid][15], 190.000000, 235.000000, 0.000000, 0.400000);

    gungame_UI[playerid][16] = CreatePlayerTextDraw(playerid, 559.333251, 254.555526, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, gungame_UI[playerid][16], 85.000000, 20.000000);
    PlayerTextDrawAlignment(playerid, gungame_UI[playerid][16], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColor(playerid, gungame_UI[playerid][16], 255);
    PlayerTextDrawSetShadow(playerid, gungame_UI[playerid][16], 0);
    PlayerTextDrawBackgroundColor(playerid, gungame_UI[playerid][16], 255);
    PlayerTextDrawFont(playerid, gungame_UI[playerid][16], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid,  gungame_UI[playerid][16], false);

    gungame_UI[playerid][17] = CreatePlayerTextDraw(playerid, 559.333251, 278.199951, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, gungame_UI[playerid][17], 85.000000, 20.000000);
    PlayerTextDrawAlignment(playerid, gungame_UI[playerid][17], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColor(playerid, gungame_UI[playerid][17], 255);
    PlayerTextDrawSetShadow(playerid, gungame_UI[playerid][17], 0);
    PlayerTextDrawBackgroundColor(playerid, gungame_UI[playerid][17], 255);
    PlayerTextDrawFont(playerid, gungame_UI[playerid][17], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid,  gungame_UI[playerid][17], false);

    gungame_UI[playerid][18] = CreatePlayerTextDraw(playerid, 536.333435, 278.200103, "");
    PlayerTextDrawTextSize(playerid, gungame_UI[playerid][18], 23.000000, 20.000000);
    PlayerTextDrawAlignment(playerid, gungame_UI[playerid][18], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColor(playerid, gungame_UI[playerid][18], 255);
    PlayerTextDrawSetShadow(playerid, gungame_UI[playerid][18], 0);
    PlayerTextDrawBackgroundColor(playerid, gungame_UI[playerid][18], 0xFFFFFF00);
    PlayerTextDrawFont(playerid, gungame_UI[playerid][18], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid,  gungame_UI[playerid][18], false);
    PlayerTextDrawSetPreviewModel(playerid, gungame_UI[playerid][18], 1316);
    PlayerTextDrawSetPreviewRot(playerid, gungame_UI[playerid][18], 190.000000, 235.000000, 0.000000, 0.400000);

    gungame_UI[playerid][19] = CreatePlayerTextDraw(playerid, 543.666381, 235.888870, "");
    PlayerTextDrawTextSize(playerid, gungame_UI[playerid][19], 34.000000, 58.000000);
    PlayerTextDrawAlignment(playerid, gungame_UI[playerid][19], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColor(playerid, gungame_UI[playerid][19], -1);
    PlayerTextDrawSetShadow(playerid, gungame_UI[playerid][19], 0);
    PlayerTextDrawFont(playerid, gungame_UI[playerid][19], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid, gungame_UI[playerid][19], false);
    PlayerTextDrawBackgroundColor(playerid, gungame_UI[playerid][19], 0xFFFFFF00);
    PlayerTextDrawSetPreviewModel(playerid, gungame_UI[playerid][19], 355);
    PlayerTextDrawSetPreviewRot(playerid, gungame_UI[playerid][19], 0.000000, 360.000000, 201.000000, 2.445255);

    gungame_UI[playerid][20] = CreatePlayerTextDraw(playerid, 538.333129, 258.288909, "");
    PlayerTextDrawTextSize(playerid, gungame_UI[playerid][20], 34.000000, 58.000000);
    PlayerTextDrawAlignment(playerid, gungame_UI[playerid][20], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColor(playerid, gungame_UI[playerid][20], -1);
    PlayerTextDrawSetShadow(playerid, gungame_UI[playerid][20], 0);
    PlayerTextDrawFont(playerid, gungame_UI[playerid][20], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid, gungame_UI[playerid][20], false);
    PlayerTextDrawBackgroundColor(playerid, gungame_UI[playerid][20], 0xFFFFFF00);
    PlayerTextDrawSetPreviewModel(playerid, gungame_UI[playerid][20], 372);
    PlayerTextDrawSetPreviewRot(playerid, gungame_UI[playerid][20], 0.000000, 360.000000, 201.000000, 2.445255);

    gungame_UI[playerid][21] = CreatePlayerTextDraw(playerid, 606.666564, 260.103668, "CURRENT_WEAPON");
    PlayerTextDrawLetterSize(playerid, gungame_UI[playerid][21], 0.102333, 0.633481);
    PlayerTextDrawAlignment(playerid, gungame_UI[playerid][21], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColor(playerid, gungame_UI[playerid][21], -1);
    PlayerTextDrawSetShadow(playerid, gungame_UI[playerid][21], 0);
    PlayerTextDrawBackgroundColor(playerid, gungame_UI[playerid][21], 255);
    PlayerTextDrawFont(playerid, gungame_UI[playerid][21], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid,  gungame_UI[playerid][21], true);

    gungame_UI[playerid][22] = CreatePlayerTextDraw(playerid, 606.666564, 284.992614, "NEXT_WEAPON");
    PlayerTextDrawLetterSize(playerid, gungame_UI[playerid][22], 0.102333, 0.633481);
    PlayerTextDrawAlignment(playerid, gungame_UI[playerid][22], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColor(playerid, gungame_UI[playerid][22], -1);
    PlayerTextDrawSetShadow(playerid, gungame_UI[playerid][22], 0);
    PlayerTextDrawBackgroundColor(playerid, gungame_UI[playerid][22], 255);
    PlayerTextDrawFont(playerid, gungame_UI[playerid][22], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid,  gungame_UI[playerid][22], true);

    for(new i = 0; i < sizeof gungame_UI[]; i++) {

        PlayerTextDrawShow(playerid, gungame_UI[playerid][i]);
    }

    return (true);
}

stock GunGame_GivePlayerWeapon(playerid) {
    if(playerGunGame[playerid]) return 0;
    
    GunGame[playerid][ggWeapon] -= 1;
    new WEAPON:wep = WEAPON:( GunGame[playerid][ggWeapon] );
    ResetPlayerWeapons(playerid);
    GivePlayerWeapon(playerid, wep, 9999);

    PlayerTextDraw_UpdateModel(playerid, gungame_UI[playerid][19], gg_WeaponModels[ wep ]  );
    PlayerTextDraw_UpdateModel(playerid, gungame_UI[playerid][20], gg_WeaponModels[ wep-1 ]  );

    return 1;
}

stock GunGame_AdvancePlayer(playerid) {
    if(GunGame[playerid][ggLevel] >= MAX_GUNGAME_LEVEL - 1) return 0;
    

    GunGame[playerid][ggLevel]++;
    GunGame[playerid][ggKillStreak] = 0;
    GunGame_GivePlayerWeapon(playerid);
    // Update textdraws here
    return 1;
}

stock GunGame_DemotePlayer(playerid) {
    if(GunGame[playerid][ggLevel] <= 0) return 0;
    
    GunGame[playerid][ggLevel]--;
    GunGame[playerid][ggDeathStreak] = 0;
    GunGame_GivePlayerWeapon(playerid);
    // Update textdraws here
    return 1;
}

//*==============================================================================
//?--->>> hooks
//*==============================================================================

YCMD:startgg(playerid, params[], help) 
{
    gunGameActive = true;

    TopPlayers[0][tp_level] = -1;
    TopPlayers[1][tp_level] = -1;
    TopPlayers[2][tp_level] = -1;

    TopPlayers[0][tp_playerid] = INVALID_PLAYER_ID;
    TopPlayers[1][tp_playerid] = INVALID_PLAYER_ID;
    TopPlayers[2][tp_playerid] = INVALID_PLAYER_ID;

    return 1;
}

YCMD:joingg(playerid, params[], help) {

    PrepareGunGame(playerid);
    ShowGunGameInterface(playerid);

    return 1;
}

YCMD:advanceme(playerid, params[], help) {

    GunGame_AdvancePlayer(playerid);

    return 1;
}

hook OnPlayerConnect(playerid) {

    ResetGunGameInterface(playerid);

    playerGunGame[playerid] = false;
    playerGunGameDeath[playerid] = false;

    return Y_HOOKS_CONTINUE_RETURN_1;
}


hook OnPlayerSpawn(playerid) {

    if(playerGunGameDeath[playerid]) {

        new idx = random( sizeof sz_RandomGunGamePositions );

        GivePlayerWeapon(playerid, WEAPON_SNIPER, 20000);
        SetPlayerWorldBounds(playerid, -340.0, -473.0, 2290.5, 2184.5);
        SetPlayerPos(playerid, sz_RandomGunGamePositions[idx][ggSpawn][0], sz_RandomGunGamePositions[idx][ggSpawn][1], sz_RandomGunGamePositions[idx][ggSpawn][2]);
        return Y_HOOKS_BREAK_RETURN_1;
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerDisconnect(playerid, reason) {

    if(playerGunGame[playerid]) {

        Iter_Remove(iter_GunGamePlayers, playerid);

        GunGame[playerid][ggKills] = 0;
        GunGame[playerid][ggDeathStreak] = 0;
        GunGame[playerid][ggKillStreak] = 0;
        GunGame[playerid][ggLevel] = 0;
        GunGame[playerid][ggWeapon] = WEAPON_UNKNOWN;

        if(Iter_Count(iter_GunGamePlayers) <= 3) {

            SendClientMessageToAll(-1, "GunGame se prekino!");
            return Y_HOOKS_BREAK_RETURN_1;
        }
    }

    return Y_HOOKS_BREAK_RETURN_1;
}

hook OnPlayerDeath(playerid, killerid, WEAPON:reason) {

    if(playerGunGame[playerid] && playerGunGame[killerid]) {

        if(reason == WEAPON_COLT45) {

            SendClientMessageToAll(-1, "ALOOO POBEDA!!!");
            return ~1;
        }

        playerGunGameDeath[playerid] = true;

        GunGame[playerid][ggDeathStreak]++;
        GunGame[playerid][ggKillStreak] = 0;

        GunGame[killerid][ggKillStreak]++;
        GunGame[killerid][ggDeathStreak] = 0;

        if(GunGame[playerid][ggDeathStreak] >= DEATHS_TO_DEMOTE) {
            GunGame_DemotePlayer(playerid);
        }

        if(GunGame[killerid][ggKillStreak] >= KILLS_TO_ADVANCE) {
            GunGame_AdvancePlayer(killerid);
        }
            
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

task UpdateTopPlayers[1000]() {
    
    if(!gunGameActive) return 0;

    for(new i = 0; i < MAX_TOP_PLAYERS; i++) {
        TopPlayers[i][tp_playerid] = INVALID_PLAYER_ID;
        TopPlayers[i][tp_level] = -1;
    }
    
    foreach(new i : Player) {
        if(!playerGunGame[i]) continue;
        
        for(new pos = 0; pos < MAX_TOP_PLAYERS; pos++) {
            if(GunGame[i][ggLevel] > TopPlayers[pos][tp_level]) {
                for(new shift = MAX_TOP_PLAYERS-1; shift > pos; shift--) {
                    TopPlayers[shift] = TopPlayers[shift-1];
                }
                TopPlayers[pos][tp_playerid] = i;
                TopPlayers[pos][tp_level] = GunGame[i][ggLevel];
                break;
            }
        }
    }

    foreach(new j : iter_GunGamePlayers) {

        if(TopPlayers[0][tp_playerid] != INVALID_PLAYER_ID) { 

            PlayerTextDrawSetString(j, gungame_UI[j][9], "%s", ReturnPlayerName(TopPlayers[0][tp_playerid]));
            PlayerTextDraw_UpdateModel(j, gungame_UI[j][3], GetPlayerSkin(TopPlayers[0][tp_playerid]));
            PlayerTextDraw_UpdateModel(j, gungame_UI[j][12], gg_WeaponModels[ GetPlayerWeapon( TopPlayers[0][tp_playerid] ) ]);
        }

        if(TopPlayers[1][tp_playerid] != INVALID_PLAYER_ID) {

            PlayerTextDrawSetString(j, gungame_UI[j][10], "%s", ReturnPlayerName(TopPlayers[1][tp_playerid]));
            PlayerTextDraw_UpdateModel(j, gungame_UI[j][4], GetPlayerSkin(TopPlayers[1][tp_playerid]));
            PlayerTextDraw_UpdateModel(j, gungame_UI[j][13], gg_WeaponModels[ GetPlayerWeapon( TopPlayers[1][tp_playerid] ) ]);

        }
        if(TopPlayers[2][tp_playerid] != INVALID_PLAYER_ID) {

            PlayerTextDrawSetString(j, gungame_UI[j][11], "%s", ReturnPlayerName(TopPlayers[2][tp_playerid]));
            PlayerTextDraw_UpdateModel(j, gungame_UI[j][5], GetPlayerSkin(TopPlayers[2][tp_playerid]));
            PlayerTextDraw_UpdateModel(j, gungame_UI[j][14], gg_WeaponModels[ GetPlayerWeapon( TopPlayers[2][tp_playerid] ) ]);
        }
    }

    return (true);
}
