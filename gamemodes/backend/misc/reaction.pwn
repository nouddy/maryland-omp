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
 *  @File           staff.script
 *  @Module         staff
 */

#include <ysilib\YSI_Coding\y_hooks>

// Configuration
#define REACTION_REWARD       200    // $200 reward
#define REACTION_INTERVAL     1800    // 30 minutes (in seconds)

// Variables
static 
    bool:reactionActive,
    reactionString[64],
    reactionTimer;

// Array of possible reactions (add more as needed)
static const ReactionPhrases[][] = {
    "Maryland Roleplay",
    "Dobrodosli na server",
    "Uzivajte u igri",
    "Postujte pravila",
    "Prijatan provod",
    "Zabavite se",
    "Srecno igranje"
};

// Random character generation
static const ReactionChars[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

// Functions
GenerateReactionString()
{
    new type = random(2); // 0 = phrase, 1 = random chars
    
    if(type == 0)
    {
        // Use predefined phrase
        format(reactionString, sizeof(reactionString), "%s", ReactionPhrases[random(sizeof(ReactionPhrases))]);
    }
    else
    {
        // Generate random characters
        new length = random(10) + 5;
        for(new i = 0; i < length; i++)
        {
            reactionString[i] = ReactionChars[random(sizeof(ReactionChars) - 1)];
        }
        reactionString[length] = EOS;
    }
    return 1;
}

StartReaction()
{
    if(reactionActive)
        StopReaction();  // Ako nije odgovorio niko na prethodnu da da novu zbog tajmera.
    
    GenerateReactionString();
    reactionActive = true;
    
    // Announce to all players
    SendClientMessageToAll(x_server, "______________________________");
    SendClientMessageToAll(x_server, ""c_server"REAKCIJA: "c_white"Prvi koji napise ovu rec/recenicu dobija $%d", REACTION_REWARD);
    SendClientMessageToAll(x_server, ""c_server"» "c_white"%s", reactionString);
    SendClientMessageToAll(x_server, "______________________________");
    
    return 1;
}

StopReaction()
{
    reactionActive = false;
    reactionString[0] = EOS;
    return 1;
}

hook OnGameModeInit()
{
    reactionTimer = SetTimer("StartNewReaction", REACTION_INTERVAL * 1000, true);
    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnGameModeExit()
{
    KillTimer(reactionTimer);
    return Y_HOOKS_CONTINUE_RETURN_1;
}

forward StartNewReaction();
public StartNewReaction()
{
    StartReaction();
    return 1;
}

stock bool:GetReactionStatus() {

    return reactionActive;
}

hook OnPlayerText(playerid, text[])
{
    if(reactionActive && !strcmp(text, reactionString, true))
    {
        // Player won the reaction
        GivePlayerMoney(playerid, REACTION_REWARD);
        
        // Announce winner
        new string[128];
        format(string, sizeof(string), ""c_server"» "c_white"%s je prvi napisao rec/recenicu i osvojio $%d!", 
            ReturnPlayerName(playerid), REACTION_REWARD);
        SendClientMessageToAll(-1, string);
        
        // Stop the current reaction
        StopReaction();
        return Y_HOOKS_CONTINUE_RETURN_0;
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}

// Command to force start a reaction (for testing)
YCMD:forcereaction(playerid, params[], help)
{
    if(help)
    {
        notification.Show(playerid, "HELP", "Forsira novu reakciju", "+", BOXCOLOR_BLUE);
        return 1;
    }

    if(GetPlayerStaffLevel(playerid) < e_HEAD_MANAGER)
        return notification.Show(playerid, "Greska", "Samo head manager+ moze ovo!", "!", BOXCOLOR_RED);

    StartReaction();
    notification.Show(playerid, "USPESNO", "Uspesno ste pokrenuli novu reakciju!", "!", BOXCOLOR_GREEN);

    return 1;
}