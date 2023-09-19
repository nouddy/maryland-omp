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
 *  @Author         Ogy_
 *  @Date           25th May 2023
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           notifikacije.script
 *  @Module         messages
 */


#include <ysilib\YSI_Coding\y_hooks>

new bool:PlayerNotify[MAX_PLAYERS],
    PlayerNotifyTimer[MAX_PLAYERS];

new PlayerText:Notify_PTD[MAX_PLAYERS][39];

hook OnGameModeInit()
{
    print("messages/notifikacije.script loaded");

    return 1;
}

hook OnPlayerConnect(playerid)
{
    PlayerNotify[playerid] = false;
    KillTimer(PlayerNotifyTimer[playerid]);
    return 1;
}

forward SendPlayerNotify(playerid,const naslov[], const poruka[], id_simbola);
public SendPlayerNotify(playerid,const naslov[], const poruka[], id_simbola) // 1 = uzvicnik || 2 = upitnik || 3 = +
{

    if(!PlayerNotify[playerid])
    {

        PlayerNotify[playerid] = true;

        new simbol[2];
        switch(id_simbola)
        {
            case 1: simbol = "!";
            case 2: simbol = "?";
            case 3: simbol = "+";

        }
        BuildNotifyTextDraws(playerid,id_simbola, true);
        PlayerTextDrawSetString(playerid, Notify_PTD[playerid][32], simbol);

        new stringic[40];
        format(stringic,sizeof(stringic), "%s",naslov);
        PlayerTextDrawSetString(playerid,Notify_PTD[playerid][37], stringic);

        new porukazz[70];
        format(porukazz,sizeof(porukazz),"%s",poruka);
        PlayerTextDrawSetString(playerid,Notify_PTD[playerid][38], porukazz);
        PlayerNotifyTimer[playerid] = SetTimerEx("UgasiNotifyIgracu", 8000, false, "i", playerid);

    }
    else return SendClientMessage(playerid, x_ogyColour, poruka);
    return 1;
}
forward UgasiNotifyIgracu(playerid);
public UgasiNotifyIgracu(playerid)
{
    BuildNotifyTextDraws(playerid,0, false);
    PlayerNotify[playerid] = false;
    KillTimer(PlayerNotifyTimer[playerid]);

    return 1;
}
forward BuildNotifyTextDraws(playerid,idsymbola, bool:show);
public BuildNotifyTextDraws(playerid,idsymbola, bool:show)
{
     if(show == true)
     {
        for(new i = 0; i < 39; i++)
        {
            PlayerTextDrawHide( playerid, Notify_PTD[ playerid ][ i ] );
            PlayerTextDrawDestroy( playerid, Notify_PTD[ playerid ][ i ] );
            Notify_PTD[ playerid ][ i ] = PlayerText:INVALID_TEXT_DRAW;
        }
        Notify_PTD[playerid][0] = CreatePlayerTextDraw(playerid, -20.166748, 247.348144, "");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][0], 58.000000, 81.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][0], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][0], 404232447);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][0], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][0], 0xFFFFFF00);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][0], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][0], false);
        PlayerTextDrawSetPreviewModel(playerid, Notify_PTD[playerid][0], 19177);
        PlayerTextDrawSetPreviewRot(playerid, Notify_PTD[playerid][0], 0.000000, 0.000000, 0.000000, 1.000000);

        Notify_PTD[playerid][1] = CreatePlayerTextDraw(playerid, -16.600040, 241.155487, "");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][1], 58.000000, 81.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][1], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][1], 404232447);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][1], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][1], 0xFFFFFF00);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][1], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][1], false);
        PlayerTextDrawSetPreviewModel(playerid, Notify_PTD[playerid][1], 19177);
        PlayerTextDrawSetPreviewRot(playerid, Notify_PTD[playerid][1], 0.000000, 0.000000, 0.000000, 1.000000);

        Notify_PTD[playerid][2] = CreatePlayerTextDraw(playerid, -13.066654, 234.862884, "");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][2], 58.000000, 81.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][2], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][2], 404232447);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][2], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][2], 0xFFFFFF00);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][2], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][2], false);
        PlayerTextDrawSetPreviewModel(playerid, Notify_PTD[playerid][2], 19177);
        PlayerTextDrawSetPreviewRot(playerid, Notify_PTD[playerid][2], 0.000000, 0.000000, 0.000000, 1.000000);

        Notify_PTD[playerid][3] = CreatePlayerTextDraw(playerid, -1.733343, 215.596282, "");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][3], 58.000000, 81.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][3], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][3], 404232447);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][3], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][3], 0xFFFFFF00);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][3], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][3], false);
        PlayerTextDrawSetPreviewModel(playerid, Notify_PTD[playerid][3], 19177);
        PlayerTextDrawSetPreviewRot(playerid, Notify_PTD[playerid][3], 0.000000, 0.000000, 0.000000, 1.000000);

        Notify_PTD[playerid][4] = CreatePlayerTextDraw(playerid, -5.066713, 221.433258, "");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][4], 58.000000, 81.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][4], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][4], 404232447);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][4], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][4], 0xFFFFFF00);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][4], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][4], false);
        PlayerTextDrawSetPreviewModel(playerid, Notify_PTD[playerid][4], 19177);
        PlayerTextDrawSetPreviewRot(playerid, Notify_PTD[playerid][4], 0.000000, 0.000000, 0.000000, 1.000000);

        Notify_PTD[playerid][5] = CreatePlayerTextDraw(playerid, -8.733402, 227.670288, "");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][5], 58.000000, 81.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][5], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][5], 404232447);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][5], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][5], 0xFFFFFF00);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][5], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][5], false);
        PlayerTextDrawSetPreviewModel(playerid, Notify_PTD[playerid][5], 19177);
        PlayerTextDrawSetPreviewRot(playerid, Notify_PTD[playerid][5], 0.000000, 0.000000, 0.000000, 1.000000);

        Notify_PTD[playerid][6] = CreatePlayerTextDraw(playerid, -10.500096, 230.574005, "");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][6], 58.000000, 81.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][6], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][6], 404232447);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][6], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][6], 0xFFFFFF00);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][6], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][6], false);
        PlayerTextDrawSetPreviewModel(playerid, Notify_PTD[playerid][6], 19177);
        PlayerTextDrawSetPreviewRot(playerid, Notify_PTD[playerid][6], 0.000000, 0.000000, 0.000000, 1.000000);

        Notify_PTD[playerid][7] = CreatePlayerTextDraw(playerid, 9.166495, 291.788787, "LD_SPAC:white");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][7], 23.000000, -7.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][7], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][7], 404232447);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][7], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][7], 255);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][7], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][7], false);

        Notify_PTD[playerid][8] = CreatePlayerTextDraw(playerid, 12.499782, 285.566558, "LD_SPAC:white");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][8], 23.000000, -7.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][8], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][8], 404232447);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][8], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][8], 255);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][8], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][8], false);

        Notify_PTD[playerid][9] = CreatePlayerTextDraw(playerid, 16.833196, 280.588806, "LD_SPAC:white");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][9], 24.000000, -10.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][9], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][9], 404232447);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][9], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][9], 255);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][9], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][9], false);

        Notify_PTD[playerid][10] = CreatePlayerTextDraw(playerid, 20.166574, 274.366546, "LD_SPAC:white");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][10], 24.000000, -10.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][10], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][10], 404232447);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][10], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][10], 255);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][10], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][10], false);

        Notify_PTD[playerid][11] = CreatePlayerTextDraw(playerid, 24.166606, 267.729583, "LD_SPAC:white");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][11], 7.000000, -9.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][11], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][11], 404232447);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][11], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][11], 255);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][11], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][11], false);

        Notify_PTD[playerid][12] = CreatePlayerTextDraw(playerid, -12.200077, 308.570281, "");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][12], 75.000000, -74.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][12], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][12], 404232447);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][12], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][12], 0xFFFFFF00);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][12], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][12], false);
        PlayerTextDrawSetPreviewModel(playerid, Notify_PTD[playerid][12], 2965);
        PlayerTextDrawSetPreviewRot(playerid, Notify_PTD[playerid][12], 90.000000, 0.000000, 90.000000, 1.000000);

        Notify_PTD[playerid][13] = CreatePlayerTextDraw(playerid, 26.399883, 252.411102, "LD_SPAC:white");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][13], 71.500106, 39.389934);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][13], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][13], 404232447);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][13], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][13], 255);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][13], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][13], false);

        Notify_PTD[playerid][14] = CreatePlayerTextDraw(playerid, 69.033432, 247.348144, "");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][14], 58.000000, 81.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][14], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][14], 404232447);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][14], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][14], 0xFFFFFF00);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][14], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][14], false);
        PlayerTextDrawSetPreviewModel(playerid, Notify_PTD[playerid][14], 19177);
        PlayerTextDrawSetPreviewRot(playerid, Notify_PTD[playerid][14], 0.000000, 180.000000, 0.000000, 1.000000);

        Notify_PTD[playerid][15] = CreatePlayerTextDraw(playerid, 72.366867, 241.540710, "");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][15], 58.000000, 81.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][15], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][15], 404232447);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][15], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][15], 0xFFFFFF00);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][15], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][15], false);
        PlayerTextDrawSetPreviewModel(playerid, Notify_PTD[playerid][15], 19177);
        PlayerTextDrawSetPreviewRot(playerid, Notify_PTD[playerid][15], 0.000000, 180.000000, 0.000000, 1.000000);

        Notify_PTD[playerid][16] = CreatePlayerTextDraw(playerid, 76.033615, 235.318481, "");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][16], 58.000000, 81.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][16], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][16], 404232447);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][16], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][16], 0xFFFFFF00);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][16], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][16], false);
        PlayerTextDrawSetPreviewModel(playerid, Notify_PTD[playerid][16], 19177);
        PlayerTextDrawSetPreviewRot(playerid, Notify_PTD[playerid][16], 0.000000, 180.000000, 0.000000, 1.000000);

        Notify_PTD[playerid][17] = CreatePlayerTextDraw(playerid, 79.366989, 229.511077, "");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][17], 58.000000, 81.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][17], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][17], 404232447);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][17], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][17], 0xFFFFFF00);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][17], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][17], false);
        PlayerTextDrawSetPreviewModel(playerid, Notify_PTD[playerid][17], 19177);
        PlayerTextDrawSetPreviewRot(playerid, Notify_PTD[playerid][17], 0.000000, 180.000000, 0.000000, 1.000000);

        Notify_PTD[playerid][18] = CreatePlayerTextDraw(playerid, 82.700332, 223.703674, "");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][18], 58.000000, 81.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][18], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][18], 404232447);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][18], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][18], 0xFFFFFF00);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][18], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][18], false);
        PlayerTextDrawSetPreviewModel(playerid, Notify_PTD[playerid][18], 19177);
        PlayerTextDrawSetPreviewRot(playerid, Notify_PTD[playerid][18], 0.000000, 180.000000, 0.000000, 1.000000);

        Notify_PTD[playerid][19] = CreatePlayerTextDraw(playerid, 85.367019, 219.140747, "");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][19], 58.000000, 81.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][19], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][19], 404232447);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][19], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][19], 0xFFFFFF00);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][19], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][19], false);
        PlayerTextDrawSetPreviewModel(playerid, Notify_PTD[playerid][19], 19177);
        PlayerTextDrawSetPreviewRot(playerid, Notify_PTD[playerid][19], 0.000000, 180.000000, 0.000000, 1.000000);

        Notify_PTD[playerid][20] = CreatePlayerTextDraw(playerid, 87.333755, 215.722259, "");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][20], 58.000000, 81.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][20], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][20], 404232447);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][20], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][20], 0xFFFFFF00);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][20], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][20], false);
        PlayerTextDrawSetPreviewModel(playerid, Notify_PTD[playerid][20], 19177);
        PlayerTextDrawSetPreviewRot(playerid, Notify_PTD[playerid][20], 0.000000, 180.000000, 0.000000, 1.000000);

        Notify_PTD[playerid][21] = CreatePlayerTextDraw(playerid, 94.133186, 252.396270, "LD_SPAC:white");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][21], 20.000000, 9.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][21], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][21], 404232447);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][21], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][21], 255);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][21], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][21], false);

        Notify_PTD[playerid][22] = CreatePlayerTextDraw(playerid, 97.466491, 260.692535, "LD_SPAC:white");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][22], 15.000000, 6.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][22], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][22], 404232447);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][22], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][22], 255);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][22], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][22], false);

        Notify_PTD[playerid][23] = CreatePlayerTextDraw(playerid, 97.133064, 265.255523, "LD_SPAC:white");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][23], 10.000000, 7.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][23], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][23], 404232447);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][23], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][23], 255);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][23], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][23], false);

        Notify_PTD[playerid][24] = CreatePlayerTextDraw(playerid, 96.799751, 270.648132, "LD_SPAC:white");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][24], 8.000000, 8.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][24], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][24], 404232447);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][24], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][24], 255);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][24], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][24], false);

        Notify_PTD[playerid][25] = CreatePlayerTextDraw(playerid, 95.799751, 277.699890, "LD_SPAC:white");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][25], 6.000000, 7.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][25], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][25], 404232447);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][25], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][25], 255);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][25], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][25], false);

        Notify_PTD[playerid][26] = CreatePlayerTextDraw(playerid, 18.066535, 258.303680, "LD_SPAC:white");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][26], 12.130002, 9.039999);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][26], TEXT_DRAW_ALIGN_LEFT);
        //PlayerTextDrawColour(playerid, Notify_PTD[playerid][26], 1924239615); // mijenja boju
        CheckSymbolColour(playerid, idsymbola, Notify_PTD[playerid][26]);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][26], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][26], 255);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][26], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][26], false);

        Notify_PTD[playerid][27] = CreatePlayerTextDraw(playerid, -13.099918, 215.333312, "");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][27], 87.000000, 95.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][27], TEXT_DRAW_ALIGN_LEFT);
        //PlayerTextDrawColour(playerid, Notify_PTD[playerid][27], 1924239615); // mijenja boju
        CheckSymbolColour(playerid, idsymbola, Notify_PTD[playerid][27]);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][27], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][27], 0xFFFFFF00);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][27], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][27], false);
        PlayerTextDrawSetPreviewModel(playerid, Notify_PTD[playerid][27], 19177);
        PlayerTextDrawSetPreviewRot(playerid, Notify_PTD[playerid][27], 0.000000, 180.000000, 0.000000, 1.000000);

        Notify_PTD[playerid][28] = CreatePlayerTextDraw(playerid, -25.900691, 215.333312, "");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][28], 87.000000, 95.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][28], TEXT_DRAW_ALIGN_LEFT);
        //PlayerTextDrawColour(playerid, Notify_PTD[playerid][28], 1924239615); // mijenja boju
        CheckSymbolColour(playerid, idsymbola, Notify_PTD[playerid][28]);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][28], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][28], 0xFFFFFF00);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][28], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][28], false);
        PlayerTextDrawSetPreviewModel(playerid, Notify_PTD[playerid][28], 19177);
        PlayerTextDrawSetPreviewRot(playerid, Notify_PTD[playerid][28], 0.000000, 180.000000, 0.000000, 1.000000);

        Notify_PTD[playerid][29] = CreatePlayerTextDraw(playerid, 117.866561, 291.403594, "");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][29], -27.000000, -39.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][29], TEXT_DRAW_ALIGN_LEFT);
        //PlayerTextDrawColour(playerid, Notify_PTD[playerid][29], 1924239510); // mijenja boju
        CheckSymbolColour(playerid, idsymbola, Notify_PTD[playerid][29]);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][29], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][29], 0xFFFFFF00);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][29], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][29], false);
        PlayerTextDrawSetPreviewModel(playerid, Notify_PTD[playerid][29], 1317);
        PlayerTextDrawSetPreviewRot(playerid, Notify_PTD[playerid][29], 0.000000, -40.000000, 90.000000, 0.699998);

        Notify_PTD[playerid][30] = CreatePlayerTextDraw(playerid, 63.899211, 195.451812, "");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][30], 99.000000, 127.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][30], TEXT_DRAW_ALIGN_LEFT);
        //PlayerTextDrawColour(playerid, Notify_PTD[playerid][30], 1924239615); // mijenja boju
        CheckSymbolColour(playerid, idsymbola, Notify_PTD[playerid][30]);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][30], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][30], 0xFFFFFF00);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][30], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][30], false);
        PlayerTextDrawSetPreviewModel(playerid, Notify_PTD[playerid][30], 19177);
        PlayerTextDrawSetPreviewRot(playerid, Notify_PTD[playerid][30], 0.000000, 180.000000, 0.000000, 1.000000);

        Notify_PTD[playerid][31] = CreatePlayerTextDraw(playerid, 100.533111, 246.633300, "");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][31], 25.000000, 25.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][31], TEXT_DRAW_ALIGN_LEFT);
        //PlayerTextDrawColour(playerid, Notify_PTD[playerid][31], 1924239615); // mijenja boju
        CheckSymbolColour(playerid, idsymbola, Notify_PTD[playerid][31]);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][31], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][31], 0xFFFFFF00);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][31], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][31], false);
        PlayerTextDrawSetPreviewModel(playerid, Notify_PTD[playerid][31], 2965);
        PlayerTextDrawSetPreviewRot(playerid, Notify_PTD[playerid][31], 90.000000, 0.000000, 90.000000, 1.000000);

        Notify_PTD[playerid][32] = CreatePlayerTextDraw(playerid, 25.699932, 257.999938, "?");
        PlayerTextDrawLetterSize(playerid, Notify_PTD[playerid][32], 0.178665, 0.923851);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][32], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][32], -1);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][32], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][32], 255);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][32], TEXT_DRAW_FONT_1);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][32], true);

        Notify_PTD[playerid][33] = CreatePlayerTextDraw(playerid, 87.000076, 251.651794, "particle:lamp_shad_64");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][33], 8.000000, 40.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][33], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][33], 404232447);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][33], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][33], 0x00000000);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][33], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][33], false);

        Notify_PTD[playerid][34] = CreatePlayerTextDraw(playerid, 83.199844, 251.651794, "particle:lamp_shad_64");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][34], 16.000000, 40.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][34], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][34], 404232447);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][34], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][34], 0x00000000);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][34], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][34], false);

        Notify_PTD[playerid][35] = CreatePlayerTextDraw(playerid, 79.199752, 290.659149, "particle:lamp_shad_64");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][35], 15.000000, -38.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][35], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][35], 404232447);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][35], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][35], 0x00000000);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][35], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][35], false);

        Notify_PTD[playerid][36] = CreatePlayerTextDraw(playerid, 78.866439, 290.659149, "particle:lamp_shad_64");
        PlayerTextDrawTextSize(playerid, Notify_PTD[playerid][36], 21.000000, -38.000000);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][36], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][36], 404232447);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][36], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][36], 0x00000000);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][36], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][36], false);

        Notify_PTD[playerid][37] = CreatePlayerTextDraw(playerid, 43.499946, 259.244415, "naslov");
        PlayerTextDrawLetterSize(playerid, Notify_PTD[playerid][37], 0.108998, 0.679109);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][37], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][37], -1);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][37], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][37], 255);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][37], TEXT_DRAW_FONT_2);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][37], true);

        Notify_PTD[playerid][38] = CreatePlayerTextDraw(playerid, 20.166574, 273.347930, "Lorem_ipsum_.....");
        PlayerTextDrawLetterSize(playerid, Notify_PTD[playerid][38], 0.090998, 0.525628);
        PlayerTextDrawAlignment(playerid, Notify_PTD[playerid][38], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Notify_PTD[playerid][38], -1061109505);
        PlayerTextDrawSetShadow(playerid, Notify_PTD[playerid][38], 0);
        PlayerTextDrawBackgroundColour(playerid, Notify_PTD[playerid][38], 255);
        PlayerTextDrawFont(playerid, Notify_PTD[playerid][38], TEXT_DRAW_FONT_2);
        PlayerTextDrawSetProportional(playerid, Notify_PTD[playerid][38], true);

        for(new i = 0; i < 39; i++) { PlayerTextDrawShow(playerid, Notify_PTD[playerid][i]); }
     }
     else
     {
        for(new i = 0; i < 39; i++)
        {
            PlayerTextDrawHide( playerid, Notify_PTD[ playerid ][ i ] );
            PlayerTextDrawDestroy( playerid, Notify_PTD[ playerid ][ i ] );
            Notify_PTD[ playerid ][ i ] = PlayerText:INVALID_TEXT_DRAW;
        }
     }
     return 1;
}
CheckSymbolColour(playerid,idsymbola, PlayerText:td)
{
    switch(idsymbola)
    {
        case 1: PlayerTextDrawColour(playerid, td, 0xFF0000FF); // UZVICNIK
        case 2: PlayerTextDrawColour(playerid, td, 0x0086E3FF); // UPITNIK
        case 3: PlayerTextDrawColour(playerid, td, 0xC092DEFF); // PLUS
    }
    return (true);
}