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
 *  @Author         Vostic
 *  @Date           27th May 2023
 *  @Weburl         weburl
 *  @Project        maryland_project
 *
 *  @File           exp.pwn
 *  @Module         modules
 */

#include <ysilib\YSI_Coding\y_hooks>

new PlayerText:exp_UI[MAX_PLAYERS][8];

forward Exp_DestroyInterface(playerid);
public Exp_DestroyInterface(playerid) {

    for(new i = 0; i < sizeof exp_UI[]; i++) {

        if(exp_UI[playerid][i] == INVALID_PLAYER_TEXT_DRAW) continue;
        PlayerTextDrawDestroy(playerid, exp_UI[playerid][i]);
        exp_UI[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
    }

    return (true);
}

stock Exp_UpdateInterface(playerid, amount) {

    for(new i = 0; i < sizeof exp_UI[]; i++) {

        if(exp_UI[playerid][i] == INVALID_PLAYER_TEXT_DRAW) continue;
        PlayerTextDrawDestroy(playerid, exp_UI[playerid][i]);
        exp_UI[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
    }

    new tmpstr[200];
    format(tmpstr, sizeof tmpstr, "%d / %d", CharacterInfo[playerid][XP], CharacterInfo[playerid][NeedXP]);

    exp_UI[playerid][0] = CreatePlayerTextDraw(playerid, 247.666824, 4.837070, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, exp_UI[playerid][0], 25.000000, 28.000000);
    PlayerTextDrawAlignment(playerid, exp_UI[playerid][0], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, exp_UI[playerid][0], -1965318913);
    PlayerTextDrawSetShadow(playerid, exp_UI[playerid][0], 0);
    PlayerTextDrawBackgroundColour(playerid, exp_UI[playerid][0], 255);
    PlayerTextDrawFont(playerid, exp_UI[playerid][0], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, exp_UI[playerid][0], false);

    exp_UI[playerid][1] = CreatePlayerTextDraw(playerid, 248.833450, 5.881515, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, exp_UI[playerid][1], 22.789995, 25.809972);
    PlayerTextDrawAlignment(playerid, exp_UI[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, exp_UI[playerid][1], 505488639);
    PlayerTextDrawSetShadow(playerid, exp_UI[playerid][1], 0);
    PlayerTextDrawBackgroundColour(playerid, exp_UI[playerid][1], 255);
    PlayerTextDrawFont(playerid, exp_UI[playerid][1], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, exp_UI[playerid][1], false);

    new Float:progressCalc = ( CharacterInfo[playerid][XP] ) / ( CharacterInfo[playerid][NeedXP] / 100 ) * 1.1;

    exp_UI[playerid][2] = CreatePlayerTextDraw(playerid, 271.166809, 12.933365, "ld_spac:white");
    PlayerTextDrawTextSize(playerid, exp_UI[playerid][2], 113.000000, 11.00);
    PlayerTextDrawAlignment(playerid, exp_UI[playerid][2], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, exp_UI[playerid][2], 505488639);
    PlayerTextDrawSetShadow(playerid, exp_UI[playerid][2], 0);
    PlayerTextDrawBackgroundColour(playerid, exp_UI[playerid][2], 255);
    PlayerTextDrawFont(playerid, exp_UI[playerid][2], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, exp_UI[playerid][2], false);

    exp_UI[playerid][3] = CreatePlayerTextDraw(playerid, 272.466888, 15.233374, "ld_spac:white");
    PlayerTextDrawTextSize(playerid, exp_UI[playerid][3], progressCalc, 7.000000);
    PlayerTextDrawAlignment(playerid, exp_UI[playerid][3], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, exp_UI[playerid][3], -1965318913);
    PlayerTextDrawSetShadow(playerid, exp_UI[playerid][3], 0);
    PlayerTextDrawBackgroundColour(playerid, exp_UI[playerid][3], 255);
    PlayerTextDrawFont(playerid, exp_UI[playerid][3], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, exp_UI[playerid][3], false);

    exp_UI[playerid][4] = CreatePlayerTextDraw(playerid, 257.333374, 14.792613, "hud:radar_race");
    PlayerTextDrawTextSize(playerid, exp_UI[playerid][4], 6.000000, 8.000000);
    PlayerTextDrawAlignment(playerid, exp_UI[playerid][4], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, exp_UI[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, exp_UI[playerid][4], 0);
    PlayerTextDrawBackgroundColour(playerid, exp_UI[playerid][4], 255);
    PlayerTextDrawFont(playerid, exp_UI[playerid][4], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, exp_UI[playerid][4], false);

    exp_UI[playerid][5] = CreatePlayerTextDraw(playerid, 252.800018, 9.885190, "");
    PlayerTextDrawTextSize(playerid, exp_UI[playerid][5], 15.000000, 19.000000);
    PlayerTextDrawAlignment(playerid, exp_UI[playerid][5], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, exp_UI[playerid][5], -1965319117);
    PlayerTextDrawSetShadow(playerid, exp_UI[playerid][5], 0);
    PlayerTextDrawBackgroundColour(playerid, exp_UI[playerid][5], -256);
    PlayerTextDrawFont(playerid, exp_UI[playerid][5], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid, exp_UI[playerid][5], false);
    PlayerTextDrawSetPreviewModel(playerid, exp_UI[playerid][5], 1317);
    PlayerTextDrawSetPreviewRot(playerid, exp_UI[playerid][5], 0.000000, 0.000000, 92.000000, 1.000000);

    exp_UI[playerid][6] = CreatePlayerTextDraw(playerid, 326.333587, 24.488885, "110_/_1250");
    PlayerTextDrawLetterSize(playerid, exp_UI[playerid][6], 0.117333, 0.645926);
    PlayerTextDrawAlignment(playerid, exp_UI[playerid][6], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, exp_UI[playerid][6], -1);
    PlayerTextDrawSetShadow(playerid, exp_UI[playerid][6], 0);
    PlayerTextDrawBackgroundColour(playerid, exp_UI[playerid][6], 255);
    PlayerTextDrawFont(playerid, exp_UI[playerid][6], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, exp_UI[playerid][6], true);
    PlayerTextDrawSetString(playerid, exp_UI[playerid][6], tmpstr);

    new tmpSstr[64];
    new xCol;

    if(amount > 0) {

        xCol = 2028198143;
        format(tmpSstr, sizeof tmpSstr, "+%d XP", amount);
    }

    if(amount < 0) {

        xCol = -482065153;
        format(tmpSstr, sizeof tmpSstr, "-%d XP");
    }

    exp_UI[playerid][7] = CreatePlayerTextDraw(playerid, 636.333312, 162.607421, tmpSstr);
    PlayerTextDrawLetterSize(playerid, exp_UI[playerid][7], 0.332000, 1.973330);
    PlayerTextDrawAlignment(playerid, exp_UI[playerid][7], TEXT_DRAW_ALIGN_RIGHT);
    PlayerTextDrawColour(playerid, exp_UI[playerid][7], xCol);
    PlayerTextDrawSetShadow(playerid, exp_UI[playerid][7], 0);
    PlayerTextDrawSetOutline(playerid, exp_UI[playerid][7], 1);
    PlayerTextDrawBackgroundColour(playerid, exp_UI[playerid][7], 255);
    PlayerTextDrawFont(playerid, exp_UI[playerid][7], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, exp_UI[playerid][7], TRUE);

    for(new i = 0; i < sizeof exp_UI[]; i++) 
        PlayerTextDrawShow(playerid, exp_UI[playerid][i]);
    
    SetTimerEx("Exp_DestroyInterface", 3500, false, "d", playerid);
    return (true);
}

ptask exp_UpdatePlayer[3600000](playerid) {

    new xxRandRandom = RandomMinMax(30, 120);
    GiveCharXP(playerid, xxRandRandom);

    return (true);
}

hook OnPlayerConnect(playerid) {

    Exp_DestroyInterface(playerid);

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnCharacterLoaded(playerid)
{
    SetPlayerScore(playerid, CharacterInfo[playerid][Score]);
}

stock GiveCharXP(playerid, amount)
{
    CharacterInfo[playerid][XP] += amount;

    if (CharacterInfo[playerid][XP] >= CharacterInfo[playerid][NeedXP])
    {   
        LevelUpChar(playerid);
    }

    Exp_UpdateInterface(playerid, amount);

    PlayerPlaySound(playerid, 1149, 0.00, 0.00, 0.00);

    UpdateSqlInt(SQL, "characters", "XP", CharacterInfo[playerid][XP], "character_id", GetCharacterSQLID(playerid));
    // SendClientMessage(playerid, -1, "Dobili ste XP!");
}

stock RemoveCharXP(playerid, amount)
{
    CharacterInfo[playerid][XP] -= amount;
    if (CharacterInfo[playerid][XP] < 0)
    {
        CharacterInfo[playerid][XP] = 0;
    }
    Exp_UpdateInterface(playerid, amount);
    UpdateSqlInt(SQL, "characters", "XP", CharacterInfo[playerid][XP], "character_id", GetCharacterSQLID(playerid));
}

stock SetCharXP(playerid, amount)
{
    CharacterInfo[playerid][XP] = amount;

    if (CharacterInfo[playerid][XP] >= CharacterInfo[playerid][NeedXP])
    {
        LevelUpChar(playerid);
    }

    UpdateSqlInt(SQL, "characters", "XP", amount, "character_id", GetCharacterSQLID(playerid));
}

stock LevelUpChar(playerid)
{
    CharacterInfo[playerid][XP] -= CharacterInfo[playerid][NeedXP];
    CharacterInfo[playerid][Score]++;
    CharacterInfo[playerid][NeedXP] = floatround(CharacterInfo[playerid][NeedXP] * 1.5); // Svaki nivo zahteva 50% vise XP-a

    SetPlayerScore(playerid, CharacterInfo[playerid][Score]);

    new tmpStr[64];
    format(tmpStr, sizeof tmpStr, "Uspjesno ste se level-up na level %d", CharacterInfo[playerid][Score]);
    Notify_SendNotification(playerid, tmpStr, "LEVEL-UP", 1239);

    PlayerPlaySound(playerid, 30800, 0.00, 0.00, 0.00);

    UpdateSqlInt(SQL, "characters", "XP", CharacterInfo[playerid][XP], "character_id", GetCharacterSQLID(playerid));
    UpdateSqlInt(SQL, "characters", "NeedXP", CharacterInfo[playerid][NeedXP], "character_id", GetCharacterSQLID(playerid));
    UpdateSqlInt(SQL, "characters", "Score", CharacterInfo[playerid][Score], "character_id", GetCharacterSQLID(playerid));

    // SendClientMessage(playerid, -1, "?estitamo! Dostigli ste novi nivo!");
}
