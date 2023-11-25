/***
 *
 *  ##     ##    ###    ########  ##    ## ##          ###    ##    ## ########  
 *  ###   ###   ## ##   ##     ##  ##  ##  ##         ## ##   ###   ## ##     ## 
 *  #### ####  ##   ##  ##     ##   ####   ##        ##   ##  ####  ## ##     ## 
 *  ## ### ## ##     ## ########     ##    ##       ##     ## ## ## ## ##     ## 
 *  ##     ## ######### ##   ##      ##    ##       ######### ##  #### ##     ## 
 *  ##     ## ##     ## ##    ##     ##    ##       ##     ## ##   ### ##     ## 
 *  ##     ## ##     ## ##     ##    ##    ######## ##     ## ##    ## ########   
 *
 *  @Author         Vostic & Ogy_
 *  @Date           05th May 2023
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           fuel.script
 *  @Module         vehicle
 */

#include <ysilib\YSI_Coding\y_hooks>

new bool:fuel_IsActive[MAX_PLAYERS],
    fuel_Timer[MAX_PLAYERS],
    fuel_Counter[MAX_PLAYERS];

new PlayerBar:fuel_Bar[MAX_PLAYERS];


new PlayerText:Fuel_UI[MAX_PLAYERS][4];

hook OnGameModeInit()
{
    print("backend/vehicle/fuel.pwn loaded");

    return Y_HOOKS_CONTINUE_RETURN_1;
}

forward fuel_StartFueling(playerid);
public fuel_StartFueling(playerid) {

    if(fuel_Counter[playerid] > 100) {

        KillTimer(fuel_Timer[playerid]);   
        DestroyPlayerProgressBar(playerid, fuel_Bar[playerid]);
        return true;
    }

    fuel_Counter[playerid]++;
    SetPlayerProgressBarValue(playerid, fuel_Bar[playerid], fuel_Counter[playerid]);

    return (false);
}

stock Fuel_ShowInterface(playerid, const bool:option) {

    if(option) {

        for(new i = 0; i < sizeof Fuel_UI[]; i++) {

            if(Fuel_UI[playerid][i] == INVALID_PLAYER_TEXT_DRAW) continue;

            PlayerTextDrawDestroy(playerid,Fuel_UI[playerid][i]);
            Fuel_UI[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
        }

        Fuel_UI[playerid][0] = CreatePlayerTextDraw(playerid, 114.532798, 373.551055, "LD_SPAC:white");
        PlayerTextDrawTextSize(playerid, Fuel_UI[playerid][0], 5.000000, 1.000000);
        PlayerTextDrawAlignment(playerid, Fuel_UI[playerid][0], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Fuel_UI[playerid][0], -1);
        PlayerTextDrawSetShadow(playerid, Fuel_UI[playerid][0], 0);
        PlayerTextDrawBackgroundColour(playerid, Fuel_UI[playerid][0], 255);
        PlayerTextDrawFont(playerid, Fuel_UI[playerid][0], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Fuel_UI[playerid][0], false);

        Fuel_UI[playerid][1] = CreatePlayerTextDraw(playerid, 122.333381, 422.711212, "trenutno_sipas_gorivo..");
        PlayerTextDrawLetterSize(playerid, Fuel_UI[playerid][1], 0.115666, 0.517333);
        PlayerTextDrawAlignment(playerid, Fuel_UI[playerid][1], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Fuel_UI[playerid][1], -1);
        PlayerTextDrawSetShadow(playerid, Fuel_UI[playerid][1], 0);
        PlayerTextDrawBackgroundColour(playerid, Fuel_UI[playerid][1], 255);
        PlayerTextDrawFont(playerid, Fuel_UI[playerid][1], TEXT_DRAW_FONT_2);
        PlayerTextDrawSetProportional(playerid, Fuel_UI[playerid][1], true);

        Fuel_UI[playerid][2] = CreatePlayerTextDraw(playerid, 123.000053, 415.244537, "cena:_3$");
        PlayerTextDrawLetterSize(playerid, Fuel_UI[playerid][2], 0.115666, 0.517333);
        PlayerTextDrawAlignment(playerid, Fuel_UI[playerid][2], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Fuel_UI[playerid][2], -1);
        PlayerTextDrawSetShadow(playerid, Fuel_UI[playerid][2], 0);
        PlayerTextDrawBackgroundColour(playerid, Fuel_UI[playerid][2], 255);
        PlayerTextDrawFont(playerid, Fuel_UI[playerid][2], TEXT_DRAW_FONT_2);
        PlayerTextDrawSetProportional(playerid, Fuel_UI[playerid][2], true);

        Fuel_UI[playerid][3] = CreatePlayerTextDraw(playerid, 123.000053, 407.844085, "sipano:_4L");
        PlayerTextDrawLetterSize(playerid, Fuel_UI[playerid][3], 0.115666, 0.517333);
        PlayerTextDrawAlignment(playerid, Fuel_UI[playerid][3], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Fuel_UI[playerid][3], -1);
        PlayerTextDrawSetShadow(playerid, Fuel_UI[playerid][3], 0);
        PlayerTextDrawBackgroundColour(playerid, Fuel_UI[playerid][3], 255);
        PlayerTextDrawFont(playerid, Fuel_UI[playerid][3], TEXT_DRAW_FONT_2);
        PlayerTextDrawSetProportional(playerid, Fuel_UI[playerid][3], true);

        for(new i = 0; i < sizeof Fuel_UI[]; i++) {

            PlayerTextDrawShow(playerid, Fuel_UI[playerid][i]);
        }
    }

    else {

        for(new i = 0; i < sizeof Fuel_UI[]; i++) {

            if(Fuel_UI[playerid][i] == INVALID_PLAYER_TEXT_DRAW) continue;

            PlayerTextDrawDestroy(playerid,Fuel_UI[playerid][i]);
            Fuel_UI[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
        }
    }
    return (true);
}

YCMD:fuel(playerid, params[], help) {

    Fuel_ShowInterface(playerid, true);

    fuel_Timer[playerid] = SetTimerEx("fuel_StartFueling", 100, true, "d", playerid);

    fuel_Bar[playerid] = CreatePlayerProgressBar(playerid, 114.532798, 373.551055, 3, 50, 0xFF1C1CFF, 100.0, BAR_DIRECTION_UP);
    ShowPlayerProgressBar(playerid, fuel_Bar[playerid]);
    SetPlayerProgressBarValue(playerid, fuel_Bar[playerid], 0);

    return 1;
}