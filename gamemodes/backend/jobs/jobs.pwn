
#include <ysilib\YSI_Coding\y_hooks>

#define MAX_JOBS                 (6)
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
    JOB_BUS_DRIVER,
    JOB_MEDIC,
    JOB_CARPENTRY,
    JOB_MOWER
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
    jobVehicle
}

new playerJob[MAX_PLAYERS],
    playerUniform[MAX_PLAYERS],
    playerContract[MAX_PLAYERS];

new jobInfo[MAX_JOBS][e_JOB_DATA] = {

    {INVALID_JOB_ID, "UNDEFINED:", JOB_QUALIFICATION_NONE, {0.00, 0.00, 0.00}, {0.00, 0.00, 0.00}, 24, -1, INVALID_BUSINESS_ID, -1, INVALID_VEHICLE_ID},
    {JOB_MECHANIC, "Mehanicar", JOB_QUALIFICATION_NONE, {1088.4877,-1185.4963,21.9630}, {1103.1801,-1184.1455,18.3704}, 50, 230, INVALID_BUSINESS_ID, 3, 525},
    {JOB_BUS_DRIVER, "Vozac Autobusa", JOB_QUALIFICATION_HIGH_SCHOOL, {1752.5388,-1894.2367,13.5574}, {1753.8374,-1885.9547,13.5571}, 253, 200, INVALID_BUSINESS_ID, 2, 431},
    {JOB_MEDIC, "Bolnicar", JOB_QUALIFICATION_COLLEGE, {1145.2380,-1303.6646,1019.4139}, {1148.7601,-1302.8539,1019.4139}, 274, 150, INVALID_BUSINESS_ID, 4, 416},
    {JOB_CARPENTRY, "Stolar", JOB_QUALIFICATION_NONE, {122.3619,-294.1564,1.5781}, {1417.1678,-30.5823,1000.9615}, 16, 150, INVALID_BUSINESS_ID, 2, INVALID_VEHICLE_ID},
    {JOB_MOWER, "Kosac Trave", JOB_QUALIFICATION_NONE, {1228.2214,-2363.1228,10.7937}, {1234.0742,-2359.8420,10.7937}, 162, 110, INVALID_BUSINESS_ID, 2, 572}
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

stock Job_SetPlayerJob(playerid, job) {

    if(!IsPlayerConnected(playerid)) return 0;
    if(playerid == INVALID_PLAYER_ID) return 0;

    if(playerJob[playerid] != INVALID_JOB_ID && job != INVALID_JOB_ID) 
        return SendClientMessage(playerid, x_server, "posao \187; "c_white"Vec ste zaposleni!");

    if(job == INVALID_JOB_ID)
    {
        SendClientMessage(playerid, x_server, "[JOB] >> "c_white"Uspjesno ste dali otkaz!");
        playerJob[playerid] = INVALID_JOB_ID;
        playerUniform[playerid] = INVALID_JOB_ID;    
        SetPlayerSkin(playerid, CharacterInfo[playerid][Skin]);
        return ~1;
    }

    playerContract[playerid] = gettime() + jobInfo[job][jobContract]*3600;
    playerJob[playerid] = jobInfo[job][jobID];

    SendClientMessage(playerid, x_server, "posao \187; "c_white"Uspjesno ste se zaposlili kao %s", jobInfo[job][jobName]);
    SendClientMessage(playerid, x_server, "posao \187; "c_white"Ugovor posla traje : "c_white"%d sata", jobInfo[job][jobContract]);
    SendClientMessage(playerid, x_server, "posao \187; "c_white"Da vidite informacije o poslu /job");

    return 1;
}

stock Job_GivePlayerSalary(playerid, salary) {

    new tmp_id = playerJob[playerid];

    GiveCharXP(playerid, 25);
    GivePlayerMoney(playerid, salary);
    SendClientMessage(playerid, x_server, "%s \187; "c_white"Uspjesno ste zaradili %d$", jobInfo[tmp_id][jobName], salary);
    return (true);
}


stock Job_LoadData() {

    print("-                    -");
    print("");

    new tj_str[256], tu_str[256];

    for(new i = 0; i < sizeof jobInfo; i++) {

        if(jobInfo[i][jobID] > INVALID_JOB_ID) {
            
            format(tj_str, sizeof tj_str, ""c_grey"\187; "c_white"Job : %s "c_grey"\171; \n\187; "c_white"Take Job [ N ]"c_grey" \171;", jobInfo[i][jobName]);
            format(tu_str, sizeof tu_str, ""c_grey"\187; "c_white"Job : %s "c_grey"\171; \n\187; "c_white"Uniform [ N ]"c_grey" \171;", jobInfo[i][jobName]);

            jobPickup[i][0] = CreateDynamicPickup(1210, 1, jobInfo[i][jobPos][0], jobInfo[i][jobPos][1], jobInfo[i][jobPos][2], -1, -1);
            jobLabel[i][0] = CreateDynamic3DTextLabel(tj_str, -1, jobInfo[i][jobPos][0], jobInfo[i][jobPos][1], jobInfo[i][jobPos][2], 3.50, INVALID_VEHICLE_ID, INVALID_PLAYER_ID, 0, -1, -1);
            
            jobPickup[i][1] = CreateDynamicPickup(1275, 1, jobInfo[i][jobUniformPos][0], jobInfo[i][jobUniformPos][1], jobInfo[i][jobUniformPos][2], -1, -1);
            jobLabel[i][1] = CreateDynamic3DTextLabel(tu_str,  -1, jobInfo[i][jobUniformPos][0], jobInfo[i][jobUniformPos][1], jobInfo[i][jobUniformPos][2], 3.50, INVALID_VEHICLE_ID, INVALID_PLAYER_ID, 0, -1, -1);

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

        if(IsPlayerInRangeOfPoint(playerid, 1.70, jobInfo[i][jobPos][0], jobInfo[i][jobPos][1], jobInfo[i][jobPos][2]))
            return i;
    }

    return INVALID_JOB_ID;
}

stock Job_GetNearestUniform(const playerid) {

    foreach(new i : iter_Jobs) {

        if(IsPlayerInRangeOfPoint(playerid, 1.70, jobInfo[i][jobUniformPos][0], jobInfo[i][jobUniformPos][1], jobInfo[i][jobUniformPos][2]))
            return i;
    }

    return INVALID_JOB_ID;
}

stock Job_ReturnName(job_id) {

    foreach(new i : iter_Jobs) {

        if(job_id == jobInfo[i][jobID]);
            return jobInfo[i][jobName];
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

        new uniform = job.GetNearestUniform(playerid);

        if(uniform != INVALID_JOB_ID) {

            if(playerJob[playerid] == jobInfo[uniform][jobID]) 
            {

                if(playerUniform[playerid] == jobInfo[uniform][jobID]) {

                    playerUniform[playerid] = INVALID_JOB_ID;

                    SetPlayerSkin(playerid, CharacterInfo[playerid][Skin]);
                    SendClientMessage(playerid, 0xFF0056FF, "%s \187; "c_white"Uspjesno ste skinuli uniformu!", jobInfo[uniform][jobName]);
                }

                else {

                    playerUniform[playerid] = jobInfo[uniform][jobID];

                    SetPlayerSkin(playerid, jobInfo[uniform][jobUniform]);
                    SendClientMessage(playerid, 0xFF0056FF, "%s \187; "c_white"Uspjesno ste uzeli uniformu!", jobInfo[uniform][jobName]);
                }
            }
            else { SendClientMessage(playerid, x_server, "[JOB] >> "c_white"Niste zaposljeni kao %s", jobInfo[uniform][jobName]); }
        }

    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}


YCMD:poslovi(playerid, params[], help) = jobs;
YCMD:jobs(playerid, params[], help) 
{
    new dialogStrg[246];

    foreach(new i : iter_Jobs) {

        if(i == INVALID_JOB_ID) {

            SendClientMessage(playerid, x_server, "[JOB] >> "c_white"Desila se greska u skripti!");
            return ~1;
        }
        format(dialogStrg, sizeof dialogStrg, " >> "c_white"%d | %s\n%s", jobInfo[i][jobID], jobInfo[i][jobName], dialogStrg);
    }
    Dialog_Show(playerid, "dialog_JobList", DIALOG_STYLE_LIST, ">> Poslovi", dialogStrg, "OK", "");
    return 1;
}

YCMD:posao(playerid, params[], help) = job;
YCMD:job(playerid, params[], help) {

    if(playerJob[playerid] == INVALID_JOB_ID) 
        return SendClientMessage(playerid, x_server, "[JOB] >> "c_white"Niste zaposleni!");

    ShowPlayerJobDialog(playerid, playerJob[playerid]);

    return 1;
}

YCMD:otkaz(playerid, params[], help) {

    if(playerJob[playerid] == INVALID_JOB_ID) 
        return SendClientMessage(playerid, x_server, "[JOB] >> "c_white"Niste zaposleni!");
        
    job.SetPlayerJob(playerid, INVALID_JOB_ID);

    return (true);
}

YCMD:ugovor(playerid, params[], help) = contract;
YCMD:contract(playerid, params[], help) 
{

    new sTime[20];

    GetRemainingTime(playerContract[playerid], sTime);

    SendClientMessage(playerid, x_server, "[JOB] >> "c_white"Preostalo vrjeme do isteka ugovora %s", sTime);
    
    return 1;
}

YCMD:setjob(playerid, params[], help) 
{
    
    if(GetPlayerStaffLevel(playerid) < 2)
        return SendClientMessage(playerid, "Niste u mogucnosti koristiti ovu komandu!");

    new s_JobID, targetid;
    if(sscanf(params, "ud", s_JobID, targetid))
        return SendServerMessage(playerid, "/setjob <ID/Ime Igraca> <posao>");

    if(s_JobID <= JOB_UNKNOWN || s_JobID > JOB_MOWER )
        return SendServerMessage(playerid, "Unjeli ste krivi ID posla.");

    if(!IsPlayerConnected(targetid))
        return SendServerMessage(playerid, "Taj igrac nije konektovan na server!");

    if(GetPlayerStaffLevel(targetid) > 0 && targetid != playerid)
        return SendServerMessage(playerid, "Ne mozes postaviti posao adminu!");


    Job_SetPlayerJob(playerid, s_JobID);

    SendClientMessage(targetid, x_ltorange, "#JOB: "c_white"Staff %s[%d] vam je postavio posao %s.", ReturnCharacterName(playerid), playerid, Job_ReturnName(s_JobID));
    SendClientMessage(playerid, x_ltorange, "#JOB: "c_white"Uspjesno ste postavili posao %s igracu %s[%d].", Job_ReturnName(s_JobID), ReturnCharacterName(targetid), targetid);

    return 1;
}

stock ShowPlayerJobDialog(playerid, job_id) {

    if(job_id == JOB_BUS_DRIVER) {

        Dialog_Show(playerid, "_noReturn", DIALOG_STYLE_MSGBOX, "Bus Vozac", 
                                           ""c_ltorange"\
                                           Posao vozaca autobusa u okrugu Los Santos omogucava igracima da zarade prevozeci putnike izmedju raznih stanica.\n\
                                           Da biste zapoceli posao, potrebno je da obucete poslovnu uniformu i udjete u autobus. Nakon ulaska u vozilo, automatski \n\
                                           ce se postaviti marker koji vodi do sledece stanice. Vozaci treba da prate rutu i tacno se zaustavljaju na oznacenim lokacijama kako bi uspesno obavili posao.\n\
                                           Ovaj posao je idealan za one koji vole istrazivati grad i komunicirati s virtuelnim svetom, uz osiguranje stabilne zarade.", "Ok", "");
        return ~1;
    }

    else if(job_id == JOB_BUS_DRIVER) {

        Dialog_Show(playerid, "_noReturn", DIALOG_STYLE_MSGBOX, "Mehanicar", 
                                           ""c_ltorange"\
                                           Posao mehanicara omogucava igracima da popravljaju i unapredjuju vozila.\n\
                                           Posao se zapocinje uzimanjem opreme i unosom komande "c_white"/startservice, "c_ltorange"nakon cega igrac dobije listu delova koje mora ugraditi. \n\
                                           Da bi uzeo odredjeni deo, koristi komande kao sto su "c_white"/bumpers, /spoilers, /nitrous i /wheels.\n\
                                           "c_ltorange"Deo se automatski ugradi kada igrac udje u oznaceni pickup. Ako igrac zaboravi koje delove treba ugraditi, listu moze proveriti komandom "c_white"/lsclist.\n\
                                           Ovaj posao je idealan za one koji vole raditi na vozilima i zaradjivati kroz precizne zadatke.", "Ok", "");
        return ~1;
    }

    else if(job_id == JOB_CARPENTRY) {

        Dialog_Show(playerid, "_noReturn", DIALOG_STYLE_MSGBOX, "Mehanicar", 
                                           ""c_ltorange"\
                                           Posao stolara omogucava igracima da obradjuju drvo i prave proizvode spremne za transport.\n\
                                           Posao zapocinje tako sto igrac, noseci poslovnu uniformu, ode do mesta za uzimanje alata. \n\
                                           Ako ima alat, ide do lokacije za premazivanje alata. Kada je alat pripremljen, igrac odlazi do mesta gde preuzima neobradjeno drvo. \n\
                                           Zatim, koristi masinu za obradu drveta kako bi oblikovao materijal. Kada je drvo uspesno obradjeno, igrac ga nosi do masine za premazivanje\n\
                                           gde ga finalno zavrsava. Gotov proizvod se zatim nosi do polica spremnih za transport. \n\
                                           Ovaj posao zahteva preciznost i strpljenje, a donosi stabilnu zaradu kroz proizvodnju kvalitetnih predmeta\
                                           ", "Ok", "");
        return ~1;
    }

    else if(job_id == JOB_MOWER) {

        
    }
}