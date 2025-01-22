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
 *  @Date           05th May 2023
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           quiz.pwn
 *  @Module         misc
 */

#include <ysilib\YSI_Coding\y_hooks>

// Quiz system variables
static 
    bool:QuizActive,
    QuizAnswer[64],
    QuizTimer,
    QuizEndTimer;

enum e_QUESTION_DATA {

    eQuestion[76],
    eAnswer[32]
}

// Quiz questions and answers array
static const QuizQuestions[25][e_QUESTION_DATA] = {
    {"Koji je glavni grad Srbije?", "beograd"},
    {"Koliko slova ima rec 'Automobil'?", "9"},
    {"Koje godine je osnovan GTA San Andreas?", "2004"},
    {"Koji je glavni grad Hrvatske?", "zagreb"},
    {"Koliko dana ima godina?", "365"},
    {"Koje godine je izasao GTA V?", "2013"},
    {"Koliko minuta ima jedan sat?", "60"},
    {"Koji je glavni grad Bosne i Hercegovine?", "sarajevo"},
    {"Koliko sekundi ima jedan minut?", "60"},
    {"Koje godine je osnovan Counter-Strike 1.6?", "2000"},
    {"Koji je glavni grad Slovenije?", "ljubljana"},
    {"Koliko sati ima jedan dan?", "24"},
    {"Koji je glavni grad Crne Gore?", "podgorica"},
    {"Koliko meseci ima godina?", "12"},
    {"Koji je glavni grad Makedonije?", "skoplje"},
    {"Koliko nedelja ima godina?", "52"},
    {"Koje godine je izasao prvi GTA?", "1997"},
    {"Koji je glavni grad Albanije?", "tirana"},
    {"Koliko tocka ima automobil?", "4"},
    {"Koje godine je izasao Counter-Strike: Source?", "2004"},
    {"Koji je glavni grad Bugarske?", "sofija"},
    {"Koliko igraca ima u jednom timu u fudbalu?", "11"},
    {"Koliko slova ima rec 'Policija'?", "8"},
    {"Koje godine je izasao GTA Vice City?", "2002"},
    {"Koji je glavni grad Rumunije?", "bukurest"}
};

forward StartRandomQuiz();
public StartRandomQuiz()
{
    if(QuizActive) 
        StopQuiz();

    new randQuestion = random(sizeof(QuizQuestions));
    
    QuizActive = true;

    static tmp_str[ sizeof QuizAnswer ];
    format(tmp_str, sizeof tmp_str, "%s", QuizQuestions[randQuestion][eAnswer]);
    strmid(QuizAnswer, tmp_str, 0, sizeof tmp_str );

    new string[144];
    format(string, sizeof(string), ""c_server"[QUIZ] "c_white"Pitanje: %s", QuizQuestions[randQuestion][eQuestion]);
    SendClientMessageToAll(-1, string);
    SendClientMessageToAll(-1, ""c_server"[QUIZ] "c_white"Imate 60 sekundi da odgovorite!");

    // Set timer to end quiz after 60 seconds
    QuizEndTimer = SetTimer("EndQuiz", 60000, false);
    return 1;
}

// Add this new forward function
forward EndQuiz();
public EndQuiz()
{
    if(QuizActive)
    {
        QuizActive = false;
        QuizAnswer[0] = EOS;
        SendClientMessageToAll(-1, ""c_server"[QUIZ] "c_white"Vreme je isteklo! Niko nije tacno odgovorio.");
        
        // Start new timer for next quiz
        KillTimer(QuizTimer);
        QuizTimer = SetTimer("StartRandomQuiz", (random(600000) + 300000), true);
    }
}

hook OnGameModeInit()
{
    QuizTimer = SetTimer("StartRandomQuiz", (random(600000) + 300000), true);
    return 1;
}

hook OnGameModeExit()
{
    KillTimer(QuizTimer);
    KillTimer(QuizEndTimer);

    return 1;
}

stock bool:GetQuizStatus() {

    return QuizActive;
}

StopQuiz()
{
    QuizActive = false;
    QuizAnswer[0] = EOS;

    // Start new timer for next quiz
    KillTimer(QuizTimer);
    KillTimer(QuizEndTimer);
    QuizTimer = SetTimer("StartRandomQuiz", (random(600000) + 300000), true);

    return 1;
}

hook OnPlayerText(playerid, text[])
{

    if(QuizActive && !strcmp(text, QuizAnswer, true))
    {
        // Kill the end timer since someone answered correctly
        new string[144];
        // Give reward
        GivePlayerMoney(playerid, 200);
        // Announce winner
        format(string, sizeof(string), ""c_server"[QUIZ] "c_white"%s je tacno odgovorio i osvojio $200!", 
            ReturnCharacterName(playerid));
        SendClientMessageToAll(-1, string);
        // Reset quiz
        KillTimer(QuizEndTimer);
        StopQuiz();
        return Y_HOOKS_CONTINUE_RETURN_0;
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}


// Function to manually start a quiz (for admins)
YCMD:startquiz(playerid, params[], help)
{
    if(help)
    {
        notification.Show(playerid, "HELP", "Komanda koja pokrece quiz", "+", BOXCOLOR_BLUE);
        return 1;
    }

    if(GetPlayerStaffLevel(playerid) < e_ASSISTANT)
        return notification.Show(playerid, "Greska", "Samo staff moze ovo!", "!", BOXCOLOR_RED);

    if(QuizActive)
        return notification.Show(playerid, "GRESKA", "Quiz je vec aktivan!", "!", BOXCOLOR_RED);

    StartRandomQuiz();
    notification.Show(playerid, "USPESNO", "Pokrenuli ste quiz!", "!", BOXCOLOR_GREEN);

    return 1;
}