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
 *  @Author         Vostic & Ogy_
 *  @Date           05th May 2023
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           globalstuff.asset
 *  @Module         assets
 */

#include <ysilib\YSI_Coding\y_hooks>

new PlayerText:g_NotifyTD[MAX_PLAYERS][12],
    bool:p_NotifyShown[MAX_PLAYERS];

stock Notify_SendNotification(playerid, const notification[], const header[], modelid) {

    if(p_NotifyShown[playerid]) return (true);

    for(new i = 0; i < sizeof g_NotifyTD[]; i++) {

        PlayerTextDrawDestroy(playerid, g_NotifyTD[playerid][i]);

        g_NotifyTD[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
        p_NotifyShown[playerid] = false;
    }

    g_NotifyTD[playerid][0] = CreatePlayerTextDraw(playerid, 253.000122, 352.451995, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, g_NotifyTD[playerid][0], 124.000000, 56.000000);
    PlayerTextDrawAlignment(playerid, g_NotifyTD[playerid][0], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, g_NotifyTD[playerid][0], 320149759);
    PlayerTextDrawSetShadow(playerid, g_NotifyTD[playerid][0], 0);
    PlayerTextDrawBackgroundColour(playerid, g_NotifyTD[playerid][0], 255);
    PlayerTextDrawFont(playerid, g_NotifyTD[playerid][0], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, g_NotifyTD[playerid][0], false);

    g_NotifyTD[playerid][1] = CreatePlayerTextDraw(playerid, 248.133453, 350.363128, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, g_NotifyTD[playerid][1], 10.000000, 12.000000);
    PlayerTextDrawAlignment(playerid, g_NotifyTD[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, g_NotifyTD[playerid][1], 320149759);
    PlayerTextDrawSetShadow(playerid, g_NotifyTD[playerid][1], 0);
    PlayerTextDrawBackgroundColour(playerid, g_NotifyTD[playerid][1], 255);
    PlayerTextDrawFont(playerid, g_NotifyTD[playerid][1], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, g_NotifyTD[playerid][1], false);

    g_NotifyTD[playerid][2] = CreatePlayerTextDraw(playerid, 248.133453, 398.366943, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, g_NotifyTD[playerid][2], 10.000000, 12.000000);
    PlayerTextDrawAlignment(playerid, g_NotifyTD[playerid][2], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, g_NotifyTD[playerid][2], 320149759);
    PlayerTextDrawSetShadow(playerid, g_NotifyTD[playerid][2], 0);
    PlayerTextDrawBackgroundColour(playerid, g_NotifyTD[playerid][2], 255);
    PlayerTextDrawFont(playerid, g_NotifyTD[playerid][2], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, g_NotifyTD[playerid][2], false);

    g_NotifyTD[playerid][3] = CreatePlayerTextDraw(playerid, 371.600036, 398.366943, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, g_NotifyTD[playerid][3], 10.000000, 12.000000);
    PlayerTextDrawAlignment(playerid, g_NotifyTD[playerid][3], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, g_NotifyTD[playerid][3], 320149759);
    PlayerTextDrawSetShadow(playerid, g_NotifyTD[playerid][3], 0);
    PlayerTextDrawBackgroundColour(playerid, g_NotifyTD[playerid][3], 255);
    PlayerTextDrawFont(playerid, g_NotifyTD[playerid][3], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, g_NotifyTD[playerid][3], false);

    g_NotifyTD[playerid][4] = CreatePlayerTextDraw(playerid, 371.600036, 350.448364, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, g_NotifyTD[playerid][4], 10.000000, 12.000000);
    PlayerTextDrawAlignment(playerid, g_NotifyTD[playerid][4], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, g_NotifyTD[playerid][4], 320149759);
    PlayerTextDrawSetShadow(playerid, g_NotifyTD[playerid][4], 0);
    PlayerTextDrawBackgroundColour(playerid, g_NotifyTD[playerid][4], 255);
    PlayerTextDrawFont(playerid, g_NotifyTD[playerid][4], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, g_NotifyTD[playerid][4], false);

    g_NotifyTD[playerid][5] = CreatePlayerTextDraw(playerid, 249.966613, 357.174102, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, g_NotifyTD[playerid][5], 129.940582, 46.000000);
    PlayerTextDrawAlignment(playerid, g_NotifyTD[playerid][5], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, g_NotifyTD[playerid][5], 320149759);
    PlayerTextDrawSetShadow(playerid, g_NotifyTD[playerid][5], 0);
    PlayerTextDrawBackgroundColour(playerid, g_NotifyTD[playerid][5], 255);
    PlayerTextDrawFont(playerid, g_NotifyTD[playerid][5], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, g_NotifyTD[playerid][5], false);

    g_NotifyTD[playerid][6] = CreatePlayerTextDraw(playerid, 347.999938, 349.962890, "");
    PlayerTextDrawTextSize(playerid, g_NotifyTD[playerid][6], 35.000000, 38.000000);
    PlayerTextDrawAlignment(playerid, g_NotifyTD[playerid][6], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, g_NotifyTD[playerid][6], 121);
    PlayerTextDrawBackgroundColour(playerid, g_NotifyTD[playerid][6], 0x00000000);
    PlayerTextDrawSetShadow(playerid, g_NotifyTD[playerid][6], 0);
    PlayerTextDrawFont(playerid, g_NotifyTD[playerid][6], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid, g_NotifyTD[playerid][6], false);
    PlayerTextDrawSetPreviewModel(playerid, g_NotifyTD[playerid][6], 2729);
    PlayerTextDrawSetPreviewRot(playerid, g_NotifyTD[playerid][6], 0.000000, 0.000000, -23.000000, 1.000000);

    g_NotifyTD[playerid][7] = CreatePlayerTextDraw(playerid, 348.333282, 352.866607, "");
    PlayerTextDrawTextSize(playerid, g_NotifyTD[playerid][7], 35.000000, 31.000000);
    PlayerTextDrawAlignment(playerid, g_NotifyTD[playerid][7], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, g_NotifyTD[playerid][7], -1);
    PlayerTextDrawBackgroundColour(playerid, g_NotifyTD[playerid][7], 0x00000000);
    PlayerTextDrawSetShadow(playerid, g_NotifyTD[playerid][7], 0);
    PlayerTextDrawFont(playerid, g_NotifyTD[playerid][7], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid, g_NotifyTD[playerid][7], false);
    PlayerTextDrawSetPreviewModel(playerid, g_NotifyTD[playerid][7], modelid);
    PlayerTextDrawSetPreviewRot(playerid, g_NotifyTD[playerid][7], 0.000000, 0.000000, -23.000000, 1.000000);

    g_NotifyTD[playerid][8] = CreatePlayerTextDraw(playerid, 360.666534, 385.637023, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, g_NotifyTD[playerid][8], 13.000000, 14.000000);
    PlayerTextDrawAlignment(playerid, g_NotifyTD[playerid][8], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, g_NotifyTD[playerid][8], -242);
    PlayerTextDrawSetShadow(playerid, g_NotifyTD[playerid][8], 0);
    PlayerTextDrawBackgroundColour(playerid, g_NotifyTD[playerid][8], 255);
    PlayerTextDrawFont(playerid, g_NotifyTD[playerid][8], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, g_NotifyTD[playerid][8], false);

    g_NotifyTD[playerid][9] = CreatePlayerTextDraw(playerid, 364.866760, 387.451934, "?");
    PlayerTextDrawLetterSize(playerid, g_NotifyTD[playerid][9], 0.276666, 1.048296);
    PlayerTextDrawAlignment(playerid, g_NotifyTD[playerid][9], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, g_NotifyTD[playerid][9], 1755048447);
    PlayerTextDrawSetShadow(playerid, g_NotifyTD[playerid][9], 0);
    PlayerTextDrawBackgroundColour(playerid, g_NotifyTD[playerid][9], 255);
    PlayerTextDrawFont(playerid, g_NotifyTD[playerid][9], TEXT_DRAW_FONT_AHARONI_BOLD);
    PlayerTextDrawSetProportional(playerid, g_NotifyTD[playerid][9], true);

    g_NotifyTD[playerid][10] = CreatePlayerTextDraw(playerid, 312.333374, 350.948120, header);
    PlayerTextDrawLetterSize(playerid, g_NotifyTD[playerid][10], 0.149333, 0.774518);
    PlayerTextDrawAlignment(playerid, g_NotifyTD[playerid][10], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, g_NotifyTD[playerid][10], -1);
    PlayerTextDrawSetShadow(playerid, g_NotifyTD[playerid][10], 0);
    PlayerTextDrawBackgroundColour(playerid, g_NotifyTD[playerid][10], 255);
    PlayerTextDrawFont(playerid, g_NotifyTD[playerid][10], TEXT_DRAW_FONT_AHARONI_BOLD);
    PlayerTextDrawSetProportional(playerid, g_NotifyTD[playerid][10], true);


    g_NotifyTD[playerid][11] = CreatePlayerTextDraw(playerid, 252.333374, 368.785064, notification);
    PlayerTextDrawLetterSize(playerid, g_NotifyTD[playerid][11], 0.117999, 0.558814);
    PlayerTextDrawAlignment(playerid, g_NotifyTD[playerid][11], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, g_NotifyTD[playerid][11], -1);
    PlayerTextDrawSetShadow(playerid, g_NotifyTD[playerid][11], 0);
    PlayerTextDrawBackgroundColour(playerid, g_NotifyTD[playerid][11], 255);
    PlayerTextDrawFont(playerid, g_NotifyTD[playerid][11], TEXT_DRAW_FONT_AHARONI_BOLD);
    PlayerTextDrawSetProportional(playerid, g_NotifyTD[playerid][11], true);

    p_NotifyShown[playerid] = true;

    for(new i = 0; i < sizeof g_NotifyTD[]; i++) {

        PlayerTextDrawShow(playerid, g_NotifyTD[playerid][i]);
    }
    
    SetTimerEx("notify_DestroyInterface", 5000, false, "d", playerid);

    return (true);
}

hook OnPlayerConnect(playerid) {

    p_NotifyShown[playerid] = false;
}

forward notify_DestroyInterface(playerid);
public notify_DestroyInterface(playerid) {

    if(p_NotifyShown[playerid]) {

        for(new i = 0; i < sizeof g_NotifyTD[]; i++) {

            PlayerTextDrawDestroy(playerid, g_NotifyTD[playerid][i]);

            g_NotifyTD[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
            p_NotifyShown[playerid] = false;
        }
    }
    return (true);
}

YCMD:notifyme(playerid, params[], help) 
{
    Notify_SendNotification(playerid, "Kuca poso poso kuca~n~\
                                       Sta znam nista ne znam", "Header1", 1247);

    return 1;
}