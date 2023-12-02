
#include <ysilib\YSI_Coding\y_hooks>

#define MAX_JOBS                 (3)
#define MAX_JOB_LEN              (32)

#define INVALID_JOB_ID           (-1)
#define INVALID_BUSINESS_ID      (-1)

//*         >> [ SYNTAX ] << 

#define job.                Job_

enum {

    JOB_QUALIFICATION_NONE = 0,
    JOB_QUALIFICATION_HIGH_SCHOOL,
    JOB_QUALIFICATION_COLLEGE
}

enum {

    JOB_UNKNOWN = 0,
    JOB_MECHANIC,
    JOB_BUS_DRIVER
}

enum e_JOB_DATA {

    jobID,
    jobName[MAX_JOB_LEN],
    jobQualification,

    Float:jobPos[3],
    Float:jobUniformPos[3],

    jobUniform,
    jobSalary,
    jobBusinessID,

    jobContract,
}

new playerJob[MAX_PLAYERS],
    playerUniform[MAX_PLAYERS],
    playerContract[MAX_PLAYERS];

new jobInfo[MAX_JOBS][e_JOB_DATA] = {

    {INVALID_JOB_ID, "UNDEFINED:", JOB_QUALIFICATION_NONE, {0.00, 0.00, 0.00}, {0.00, 0.00, 0.00}, 24, -1, INVALID_BUSINESS_ID, -1},
    {JOB_MECHANIC, "Mehanicar", JOB_QUALIFICATION_NONE, {1088.4877,-1185.4963,21.9630}, {1103.1801,-1184.1455,18.3704}, 24, 2500, INVALID_BUSINESS_ID, 3},
    {JOB_BUS_DRIVER, "Vozac Autobusa", JOB_QUALIFICATION_HIGH_SCHOOL, {0.00, 0.00, 0.00}, {0.00, 0.00, 0.00}, 253, 3500, INVALID_BUSINESS_ID, 2}
};

new Text3D:jobLabel[MAX_JOBS][2],
    jobPickup[MAX_JOBS][2];

new Iterator:iter_Jobs<MAX_JOBS>;

stock Job_GetQualification(job) {

    if(jobInfo[job][jobID] == INVALID_JOB_ID)
        return SendClientMessage(playerid, x_server, "[JOB] >> "c_white"GRESKA: Ne postojeci posao!");

    new string[24];

    switch(jobInfo[job][jobQualification]) {

        case JOB_QUALIFICATION_NONE: { string = "Nema"; }
        case JOB_QUALIFICATION_HIGH_SCHOOL: { string = "Srednja Skola"; }
        case JOB_QUALIFICATION_COLLEGE : { string = "Fakultet"; }
        default : { string = "[ UNDEFINED ]"; }
    }

    return (string);
}

stock Job_SetPlayerJob(const playerid, job) {

    if(job == INVALID_JOB_ID)
    {
        SendClientMessage(playerid, x_server, "[JOB] >> "c_white"Uspjesno ste dali otkaz!");
        playerJob[playerid] = INVALID_JOB_ID;
        playerUniform[playerid] = INVALID_JOB_ID;    
    }

    if(playerJob[playerid] != INVALID_JOB_ID) return 
        SendClientMessage(playerid, x_server, "[JOB] >> "c_white"Vec ste zaposleni!");

    playerContract[playerid] = gettime() + jobInfo[job][jobContract]*3600;

    SendClientMessage(playerid, x_server, "[JOB] >> "c_white"Uspjesno ste se zaposlili kao %s", jobInfo[job][jobName]);
    SendClientMessage(playerid, x_server, "[JOB] >> "c_white"Ugovor posla traje : "c_white"%d sata", jobInfo[job][jobContract]);
    SendClientMessage(playerid, x_server, "[JOB] >> "c_white"Da vidite informacije o poslu /job");

    return (true);
}

stock Job_GivePlayerSalary(playerid, salary, business = INVALID_BUSINESS_ID) {

    GivePlayerMoney(playerid, salary);
    SendClientMessage(playerid, x_server, "[JOB] >> "c_white"Uspjesno ste zaradili %s$", salary);

    if(business != INVALID_BUSINESS_ID) {

        //* Dati u kasu od biznisa novac!!
    }

    return (true);
}


stock Job_LoadData() {

    print("-                    -");
    print("");

    for(new i = 0; i < sizeof jobInfo; i++) {

        if(jobInfo[i][jobID] > INVALID_JOB_ID) {

            jobPickup[i][0] = CreatePickup(1210, 1, jobInfo[i][jobPos][0], jobInfo[i][jobPos][1], jobInfo[i][jobPos][2], 0);
            jobLabel[i][0] = Create3DTextLabel(""c_grey"\187; "c_white"Job : %s "c_grey"\171; \n\187; "c_white"Take Job [ N ]"c_grey" \171;", -1, jobInfo[i][jobPos][0], jobInfo[i][jobPos][1], jobInfo[i][jobPos][2], 3.50, 0, false, jobInfo[i][jobName]);
        
            jobPickup[i][1] = CreatePickup(1275, 1, jobInfo[i][jobUniformPos][0], jobInfo[i][jobUniformPos][1], jobInfo[i][jobUniformPos][2], 0);
            jobLabel[i][1] = Create3DTextLabel(""c_grey"\187; "c_white"Job : %s "c_grey"\187; \n\171; "c_white"Uniform [ N ]"c_grey" \171;", -1, jobInfo[i][jobUniformPos][0], jobInfo[i][jobUniformPos][1], jobInfo[i][jobUniformPos][2], 3.50, 0, false, jobInfo[i][jobName]);

            printf("[ JOB ] %s #LOADED", jobInfo[i][jobName]);

            Iter_Add(iter_Jobs, i);

        }
    }

    print("");
    print("-                    -");

    return (true);
}

stock Job_GetNearest(const playerid) {

    foreach(new i : iter_Jobs) {

        if(IsPlayerInRangeOfPoint(playerid, 3.50, jobInfo[i][jobPos][0], jobInfo[i][jobPos][1], jobInfo[i][jobPos][2]))
            return i;
    }

    return INVALID_JOB_ID;
}

hook OnGameModeInit() {
    
    print("- SELECT * jobs.pwn - LOADED");

    job.LoadData();

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerConnect(playerid) {

    playerJob[playerid] = playerUniform[playerid] = INVALID_JOB_ID;

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys) {

    if(newkeys == KEY_NO) {

        new job = job.GetNearest(playerid);

        if(job != INVALID_JOB_ID) {

            job.SetPlayerJob(playerid, job);

        }

        if(IsPlayerInRangeOfPoint(playerid, 3.50, jobInfo[job][jobUniformPos][0], jobInfo[job][jobUniformPos][1], jobInfo[job][jobUniformPos][2])) {

            if(playerJob[playerid] == job) {

                if(playerUniform[playerid] == jobInfo[job][jobID]) {

                    playerUniform[playerid] = INVALID_JOB_ID;

                    SetPlayerSkin(playerid, CharacterInfo[playerid][Skin]);
                    SendClientMessage(playerid, x_server, "[JOB] >> "c_white"Uspjesno ste skinuli uniformu!");
                }

                else {

                    playerUniform[playerid] = jobInfo[job][jobID];

                    SetPlayerSkin(playerid, jobInfo[job][jobUniform]);
                    SendClientMessage(playerid, x_server, "[JOB] >> "c_white"Uspjesno ste uzeli uniformu!");
                }
            }
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

YCMD:poslovi(playerid, params[], help) = jobs;
YCMD:jobs(playerid, params[], help) 
{
    
    foreach(new i : iter_Jobs) {

        if(i == INVALID_JOB_ID) {

            SendClientMessage(playerid, x_server, "[JOB] >> "c_white"Nema biznis nema pari!");
            return ~1;
        }

        new dialogStrg[246];
        format(dialogStrg, sizeof dialogStrg, "[JOB] >> "c_white"%d | %s\n", jobInfo[i][jobID], jobInfo[i][jobName]);

        Dialog_Show(playerid, "dialog_JobList", DIALOG_STYLE_LIST, ">> Poslovi", dialogStrg, "OK", "");

    }

    return 1;
}

YCMD:posao(playerid, params[], help) = job;
YCMD:job(playerid, params[], help) {

    if(playerJob[playerid] == INVALID_JOB_ID) 
        return SendClientMessage(playerid, x_server, "[JOB] >> "c_white"Niste zaposleni!");

    Dialog_Show(playerid, "job-noreturn", DIALOG_STYLE_MSGBOX, ">> Posao", ""c_white"Trenutni posao : "c_green"%s"c_white"\nUgovor "c_green"%s"c_white"\nDa pregledate dodatne komande za posao "c_green"/jobhelp",
                                                                 "OK", "", jobInfo[playerJob[playerid]][jobName], jobInfo[playerJob[playerid]][jobContract]);

    return 1;
}

YCMD:jobhelp(playerid, params[], help) 
{
    
    if(playerJob[playerid] == INVALID_JOB_ID) 
        return SendClientMessage(playerid, x_server, "[JOB] >> "c_white"Niste zaposleni!");

    return 1;
}
YCMD:ugovor(playerid, params[], help) = contract;
YCMD:contract(playerid, params[], help) 
{

    new sTime[20];

    GetRemainingTime(playerContract[playerid], sTime);

    SendClientMessage(playerid, x_server, "[JOB] >> "c_white"Preostalo vrjeme do isteka ugovora %s", sTime);
    
    return 1;
}
