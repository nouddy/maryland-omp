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
 *  @Author         Cmrlj
 *  @Date           27th May 2023
 *  @Weburl         weburl
 *  @Project        maryland_project
 *
 *  @File           .pwn
 *  @Module         modules
 */

#include <ysilib\YSI_Coding\y_hooks>

enum E_SHELL_GAME {
    bool:isPlaying,
    betAmount,
    correctCup,
    selectedCup,
    Timer:gameTimer,
    Timer:animTimer
}

new g_ShellGame[MAX_PLAYERS][E_SHELL_GAME];

// Pozicija gde se igra i pozicija aktora
new const Float:SHELL_GAME_POS[4] = {1211.7153, -1294.5952, 13.5464, 271.0590}; // Pozicija igraca
new const Float:SHELL_ACTOR_POS[4] = {1215.6910, -1295.8300, 13.5468, 90.3685}; // aktor pozicija

#define SHELL_CUP_MODEL 19835    // Prava casa
#define SHELL_BALL_MODEL 3101    // Kugla
#define SHELL_Z_OFFSET 0.02      // Malo podignuto od zemlje
#define SHELL_MOVE_SPEED 1.5     // Brzina pomeranja casa

new g_ShellObjects[MAX_PLAYERS][3];  // case
new g_ShellBall[MAX_PLAYERS];    // Kugla

static g_ShellActor;       // Aktor

new g_IsShellActive;

// Pozicije casa (relativno u odnosu na aktora)
new const Float:g_ShellPositions[][3] = {
    {-0.35, 0.3, SHELL_Z_OFFSET},   // Casa 1 (leva)
    {0.0, 0.3, SHELL_Z_OFFSET},    // Casa 2 (srednja)
    {0.35, 0.3, SHELL_Z_OFFSET}   // Casa 3 (desna)
};

new g_ShellCorrectCups[MAX_PLAYERS][3];

new g_ShellCupPositions[MAX_PLAYERS][3]; // Prati pozicije ?aša (0=levo, 1=sredina, 2=desno)

hook OnGameModeInit()
{
    CreateDynamic3DTextLabel("Shell Game\nPritisnite Y da igrate", -1, 
        SHELL_GAME_POS[0], SHELL_GAME_POS[1], SHELL_GAME_POS[2], 
        10.0
    );

    g_ShellActor = CreateDynamicActor(170, SHELL_ACTOR_POS[0], SHELL_ACTOR_POS[1], SHELL_ACTOR_POS[2], SHELL_ACTOR_POS[3], 1, 100.0, 0, 0);
    ApplyDynamicActorAnimation(g_ShellActor, !"DEALER", !"DEALER_IDLE", 4.1, true, false, false, false, 0);
    
    g_IsShellActive = false;

    CreateDynamicObject(2115, SHELL_ACTOR_POS[0] - 1.0, SHELL_ACTOR_POS[1]-0.64, SHELL_ACTOR_POS[2]-1.0, 0.00, 0.00, 90.0);

    return 1;
}

hook OnPlayerConnect(playerid)
{
    ResetShellGame(playerid);
    return 1;
}

stock ResetShellGame(playerid)
{
    g_ShellGame[playerid][isPlaying] = false;
    g_ShellGame[playerid][betAmount] = 0;
    g_ShellGame[playerid][correctCup] = 0;
    g_ShellGame[playerid][selectedCup] = 0;
    
    if(g_ShellGame[playerid][gameTimer] != Timer:-1)
    {
        stop g_ShellGame[playerid][gameTimer];
        g_ShellGame[playerid][gameTimer] = Timer:-1;
    }
    
    if(g_ShellGame[playerid][animTimer] != Timer:-1)
    {
        stop g_ShellGame[playerid][animTimer];
        g_ShellGame[playerid][animTimer] = Timer:-1;
    }
    
    // Destroy svega
    for(new i = 0; i < 3; i++)
    {
        if(IsValidDynamicObject(g_ShellObjects[playerid][i]))
        {
            DestroyDynamicObject(g_ShellObjects[playerid][i]);
            g_ShellObjects[playerid][i] = INVALID_OBJECT_ID;
        }
    }
    
    if(IsValidDynamicObject(g_ShellBall[playerid]))
    {
        DestroyDynamicObject(g_ShellBall[playerid]);
        g_ShellBall[playerid] = INVALID_OBJECT_ID;
    }
    
    for(new i = 0; i < 3; i++)
    {
        g_ShellCupPositions[playerid][i] = i; // 0=levo, 1=sredina, 2=desno
    }

    g_IsShellActive = false;
}

Dialog:SHELL_GAME_BET(playerid, response, listitem, inputtext[])
{
    if(!response) return 1;
    
    new bet = strval(inputtext);
    if(bet < 100 || bet > 10000) return SendClientMessage(playerid, x_ltorange, "SHELL: Ulog mora biti izmedju $100 i $10,000!");
    
    if(GetPlayerMoney(playerid) < bet) return SendClientMessage(playerid, x_ltorange, "SHELL: Nemate dovoljno novca!");
    
    GivePlayerMoney(playerid, -bet);
    g_ShellGame[playerid][betAmount] = bet;
    g_ShellGame[playerid][isPlaying] = true;
    g_ShellGame[playerid][correctCup] = random(3) + 1; // 1, 2 ili 3
    
    // Kreiraj scenu i pokazi kuglu
    CreateShellGameScene(playerid);
    printf("DEBUG: Correct cup set to: %d", g_ShellGame[playerid][correctCup]);
    
    // Nakon 3 sekunde pocni mesanje
    SetTimerEx("StartShellMixing", 3000, false, "i", playerid);
    SendClientMessage(playerid, x_ltorange, "SHELL: Zapamtite ispod koje case je kuglica...");

    g_IsShellActive = true;

    InterpolateCameraPos(playerid, 1209.079833, -1292.040771, 14.584419, 1213.110107, -1295.857788, 13.930117, 2000);
    InterpolateCameraLookAt(playerid, 1213.368774, -1294.372314, 13.503243, 1217.991577, -1295.809204, 12.848943, 2000);

    return 1;
}

Dialog:SHELL_GAME_CHOICE(playerid, response, listitem, inputtext[])
{
    if(!response) 
    {
        GivePlayerMoney(playerid, g_ShellGame[playerid][betAmount]);
        ResetShellGame(playerid);
        g_IsShellActive = false;
        SetCameraBehindPlayer(playerid);
        return 1;
    }
    
    g_ShellGame[playerid][selectedCup] = listitem + 1;
    
    printf("DEBUG: Player selected visual position %d (left=0, middle=1, right=2)", listitem);
    
    new Float:closest_dist = 9999.0;
    new closest_cup = -1;
    new Float:target_x = SHELL_ACTOR_POS[0] + (g_ShellPositions[listitem][0] * floatcos(-SHELL_ACTOR_POS[3], degrees));
    new Float:target_y = SHELL_ACTOR_POS[1] + (g_ShellPositions[listitem][0] * floatsin(-SHELL_ACTOR_POS[3], degrees));
    
    // Na?i ?ašu koja je najbliža željenoj poziciji
    for(new i = 0; i < 3; i++)
    {
        new Float:x, Float:y, Float:z;
        GetDynamicObjectPos(g_ShellObjects[playerid][i], x, y, z);
        
        new Float:dist = floatsqroot(floatpower(x - target_x, 2.0) + floatpower(y - target_y, 2.0));
        if(dist < closest_dist)
        {
            closest_dist = dist;
            closest_cup = i;
        }
    }
    
    new Float:x, Float:y, Float:z;
    GetDynamicObjectPos(g_ShellObjects[playerid][closest_cup], x, y, z);
    MoveDynamicObject(g_ShellObjects[playerid][closest_cup], x, y, z + 0.2, 2.0);
    
    printf("DEBUG: Lifting cup at physical position %d", listitem);
    
    SetTimerEx("OnShellGameResult", 1000, false, "i", playerid);
    return 1;
}

forward OnShellGameResult(playerid);
public OnShellGameResult(playerid)
{
    if(g_ShellGame[playerid][selectedCup] == g_ShellGame[playerid][correctCup])
    {
        new Float:closest_dist = 9999.0;
        new closest_cup = -1;
        new selected = g_ShellGame[playerid][selectedCup] - 1;
        new Float:target_x = SHELL_ACTOR_POS[0] + (g_ShellPositions[selected][0] * floatcos(-SHELL_ACTOR_POS[3], degrees));
        new Float:target_y = SHELL_ACTOR_POS[1] + (g_ShellPositions[selected][0] * floatsin(-SHELL_ACTOR_POS[3], degrees));
        
        for(new i = 0; i < 3; i++)
        {
            new Float:x, Float:y, Float:z;
            GetDynamicObjectPos(g_ShellObjects[playerid][i], x, y, z);
            
            new Float:dist = floatsqroot(floatpower(x - target_x, 2.0) + floatpower(y - target_y, 2.0));
            if(dist < closest_dist)
            {
                closest_dist = dist;
                closest_cup = i;
            }
        }
        
        new Float:x, Float:y, Float:z;
        GetDynamicObjectPos(g_ShellObjects[playerid][closest_cup], x, y, z);
        SetDynamicObjectPos(g_ShellBall[playerid], x, y, SHELL_ACTOR_POS[2] + 0.05);
        SetDynamicObjectMaterial(g_ShellBall[playerid], 0, 18646, "matcolours", "red", -1);
        
        new winnings = g_ShellGame[playerid][betAmount] * 2;
        GivePlayerMoney(playerid, winnings);
        
        new string[128];
        format(string, sizeof(string), "SHELL: Cestitamo! Pronasli ste kuglicu! Dobitak: $%d", winnings);
        SendClientMessage(playerid, x_ltorange, string);
        SetCameraBehindPlayer(playerid);
        g_IsShellActive = false;
    }
    else
    {
        new string[128];
        format(string, sizeof(string), "Izgubili ste! Kuglica je bila ispod case %d", g_ShellGame[playerid][correctCup]);
        SendClientMessage(playerid, x_ltorange, string);
        SetCameraBehindPlayer(playerid);
        g_IsShellActive = false;
    }
    
    SetTimerEx("ResetShellGameDelayed", 2000, false, "i", playerid);
    return 1;
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
    if((newkeys & KEY_YES) && !g_ShellGame[playerid][isPlaying])
    {
        if(g_IsShellActive)
            return SendClientMessage(playerid, x_ltorange, "SHELL: Neko vec igra sibicarenje!");

        if(IsPlayerInRangeOfPoint(playerid, 3.0, SHELL_GAME_POS[0], SHELL_GAME_POS[1], SHELL_GAME_POS[2]))
        {
            SetPlayerPos(playerid, SHELL_GAME_POS[0], SHELL_GAME_POS[1], SHELL_GAME_POS[2]);
            SetPlayerFacingAngle(playerid, SHELL_GAME_POS[3]);
            SetCameraBehindPlayer(playerid);
            
            Dialog_Show(playerid, "SHELL_GAME_BET", DIALOG_STYLE_INPUT,
                "Shell Game - Ulog",
                "Unesite iznos koji zelite da ulozite ($100-$10,000):",
                "Ulozi", "Odustani"
            );
        }
    }
    return 1;
}

stock ShowShellGameDialog(playerid)
{
    new string[256];
    format(string, sizeof(string), "\
        Casa 1 (leva)\n\
        Casa 2 (srednja)\n\
        Casa 3 (desna)"
    );
    
    static headerShell[64];
    format(headerShell, sizeof headerShell, "Ulog: $%d | Izaberite casu", g_ShellGame[playerid][betAmount]);

    Dialog_Show(playerid, "SHELL_GAME_CHOICE", DIALOG_STYLE_LIST,
        headerShell,
        string,
        "Izaberi", "Odustani"
    );
}

stock CreateShellGameScene(playerid)
{
    printf("DEBUG: Creating scene for player %d", playerid);
    
    SetPlayerFacingAngle(playerid, SHELL_GAME_POS[3]);
    SetCameraBehindPlayer(playerid);
    
    for(new i = 0; i < 3; i++)
    {
        new Float:x = SHELL_ACTOR_POS[0] + (g_ShellPositions[i][0] * floatcos(-SHELL_ACTOR_POS[3], degrees));
        new Float:y = SHELL_ACTOR_POS[1] + (g_ShellPositions[i][0] * floatsin(-SHELL_ACTOR_POS[3], degrees));
        
        g_ShellObjects[playerid][i] = CreateDynamicObject(
            SHELL_CUP_MODEL,
            x -1.0, y, SHELL_ACTOR_POS[2] + SHELL_Z_OFFSET,
            180.0, 0.0, SHELL_ACTOR_POS[3]-0.45, // Okrenute naopako (180 stepeni po X osi)
            .worldid = GetPlayerVirtualWorld(playerid),
            .interiorid = GetPlayerInterior(playerid)
        );

        g_ShellCorrectCups[playerid][i] = i;

        printf("DEBUG: Created cup %d at %f, %f, %f", i + 1, x, y, SHELL_ACTOR_POS[2] + SHELL_Z_OFFSET);
    }
    
    new correct_cup = g_ShellGame[playerid][correctCup] - 1;
    new Float:x = SHELL_ACTOR_POS[0] + (g_ShellPositions[correct_cup][0] * floatcos(-SHELL_ACTOR_POS[3], degrees));
    new Float:y = SHELL_ACTOR_POS[1] + (g_ShellPositions[correct_cup][0] * floatsin(-SHELL_ACTOR_POS[3], degrees));
    
    g_ShellBall[playerid] = CreateDynamicObject(
        SHELL_BALL_MODEL,
        x, y, SHELL_ACTOR_POS[2] + 0.5,
        0.0, 0.0, 0.0,
        .worldid = GetPlayerVirtualWorld(playerid),
        .interiorid = GetPlayerInterior(playerid)
    );
    SetDynamicObjectMaterial(g_ShellBall[playerid], 0, 18646, "matcolours", "red", -1);
    
    printf("DEBUG: Created ball under cup %d at %f, %f, %f", 
        g_ShellGame[playerid][correctCup], x, y, SHELL_ACTOR_POS[2] + 0.05);
}

forward StartShellMixing(playerid);
public StartShellMixing(playerid)
{
    printf("DEBUG: Starting mixing for player %d", playerid);
    
    ClearDynamicActorAnimations(g_ShellActor);
    ApplyDynamicActorAnimation(g_ShellActor, !"CASINO", !"dealone", 4.1, true, false, false, false, 0);
    
    SetDynamicObjectPos(g_ShellBall[playerid], 0.0, 0.0, -1000.0);
    
    new rounds = 5 + random(3);
    AnimateShellRound(playerid, 0, rounds);
}

forward AnimateShellRound(playerid, currentMove, remainingRounds);
public AnimateShellRound(playerid, currentMove, remainingRounds)
{
    if(remainingRounds <= 0)
    {
        ClearDynamicActorAnimations(g_ShellActor);
        ApplyDynamicActorAnimation(g_ShellActor, !"DEALER", !"DEALER_IDLE", 4.1, true, false, false, false, 0);
        ShowShellGameDialog(playerid);
        return;
    }
    
    new cup1 = random(3);
    new cup2;
    do {
        cup2 = random(3);
    } while(cup2 == cup1);
    
    new Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2;
    GetDynamicObjectPos(g_ShellObjects[playerid][g_ShellCupPositions[playerid][cup1]], x1, y1, z1);
    GetDynamicObjectPos(g_ShellObjects[playerid][g_ShellCupPositions[playerid][cup2]], x2, y2, z2);
    
    MoveDynamicObject(g_ShellObjects[playerid][g_ShellCupPositions[playerid][cup1]], x2, y2, z1, SHELL_MOVE_SPEED);
    MoveDynamicObject(g_ShellObjects[playerid][g_ShellCupPositions[playerid][cup2]], x1, y1, z2, SHELL_MOVE_SPEED);
    
    new temp = g_ShellCupPositions[playerid][cup1];
    g_ShellCupPositions[playerid][cup1] = g_ShellCupPositions[playerid][cup2];
    g_ShellCupPositions[playerid][cup2] = temp;
    
    if(g_ShellGame[playerid][correctCup] == cup1 + 1)
        g_ShellGame[playerid][correctCup] = cup2 + 1;
    else if(g_ShellGame[playerid][correctCup] == cup2 + 1)
        g_ShellGame[playerid][correctCup] = cup1 + 1;
    
    printf("DEBUG: Swapped cups %d and %d, ball is now under cup %d", 
        cup1 + 1, cup2 + 1, g_ShellGame[playerid][correctCup]);
    
    SetTimerEx("AnimateShellRound", floatround(SHELL_MOVE_SPEED * 1000) * 2, false, "iii", 
        playerid, currentMove + 1, remainingRounds - 1);
}

forward ResetShellGameDelayed(playerid);
public ResetShellGameDelayed(playerid)
{
    ResetShellGame(playerid);
    return 1;
}
