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
 *  @Author         Noddy_
 *  @Date           11th December 2024
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           ls_customs.pwn
 *  @Module         jobs


 *      >> [ NOTES ] << 

 * Player sided job, gdje igrac placa aktora da mu odradi posao ili, da plati aktivnog mehanicara kako bi mu on prefarbo ili da sam pokusa prefarbati
 * OnVehicleRespray(playerid, vehicleid, color1, color2) - uz pomoc ovog callback-a odraditi da igrac moze zajebat 
 *  1107.7605,-1185.3486,18.3704 - Painjob komanda



*/

#include <ysilib\YSI_Coding\y_hooks>

#define INDEX_SLOT_MECHANIC         ( 9 )

enum e_LSC_TIRE_DATA {

    tireName[64],
    tireModel
}

enum e_LSC_SPOILER_DATA {

    spoilerName[64],
    spoilerModel
}

enum e_LSC_BUMPER_DATA {

    bumperName[64],
    bumperModel
}

enum e_LSC_NITROUS_DATA {

    nitroName[64],
    nitroModel

}

new const sz_TiresList[][e_LSC_TIRE_DATA] = {

    { "Access",	    1082},
    { "Atomic",	    1085},
    { "Ahab",	    1077},
    { "Virtual",	1078},
    { "Cutter",     1076},
    { "Classic",	1075},
    { "Dollar",	    1084},
    { "Twist",	    1083},
    { "Wires",	    1081},
    { "Trance",	    1080},
    { "Switch",	    1079},
    { "Grove",	    1086}

};

new const sz_NitrousList[][] = {

    { "Small Nitrous",      1008},
    { "Medium Nitrous",     1009},
    { "Large Nitrous",      1010}

};

new const sz_BumperList[][] = {

    { "Alien Front Bumper",	    1171},
    { "X-Flow Front Bumper",	1172},
    { "Chromer Bumper",	        1173},
    { "Slamin Bumper",	        1174},
    { "Hyperflow",              1173}
};

new const sz_SpoilerList[][] = {

    { "Alien Spoiler",	1138},
    { "X-Flow Spoiler",	1139},
    { "Win Spoiler",	1140},
    { "Champ Spoiler",	1141},
    { "Drag Spoiler",	1142},
    { "Fury Spoiler",	1060},
    { "Race Spoiler",	1060},
    { "Worx Spoiler",	1060},
    { "Alpha Spoiler",	1060},
    { "Pro Spoiler",	1060}
};

new const sz_LSCVehicles[] = {

    411, 
    451, 
    541, 
    560, 
    540, 
    546, 
    547, 
    550
};

new mechanic_List[MAX_PLAYERS][4],
    mechanic_CurrentList[MAX_PLAYERS][4],
    mechanic_Carry1[MAX_PLAYERS],
    mechanic_Carry2[MAX_PLAYERS],
    bool:mechanic_InProgress[MAX_PLAYERS],
    mechanic_pVehicle[MAX_PLAYERS];

hook OnGameModeInit() {

    CreateCustomMarker(""c_server"[ Los Santos Customs ]\n"c_server"» "c_white"'/bumpers'\n"c_server"» "c_white"'/spoilers'", 1085.8417,-1205.1615,17.8047, -1, -1, 50.0); // Tehnicki Pregled

    CreateCustomMarker(""c_server"[ Los Santos Customs ]\n"c_server"» "c_white"'/nitrous'", 1094.5205,-1186.4772,18.3243, -1, -1, 50.0); // Tehnicki Pregled
    CreateCustomMarker(""c_server"[ Los Santos Customs ]\n"c_server"» "c_white"'/wheels'", 1084.4229,-1197.7640,17.9871, -1, -1, 50.0); // Tehnicki Pregled

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerConnect(playerid) {

    mechanic_InProgress[playerid] = false;

    mechanic_List[playerid][0] = -1;
    mechanic_List[playerid][1] = -1;
    mechanic_List[playerid][2] = -1;
    mechanic_List[playerid][3] = -1;

    mechanic_CurrentList[playerid][0] = -1;
    mechanic_CurrentList[playerid][1] = -1;
    mechanic_CurrentList[playerid][2] = -1;
    mechanic_CurrentList[playerid][3] = -1;

    if(IsValidVehicle(mechanic_pVehicle[playerid]))
        DestroyVehicle(mechanic_pVehicle[playerid]);

    mechanic_Carry1[playerid] = -1;

    return Y_HOOKS_CONTINUE_RETURN_1;
}

stock LCS_ShowTuneListDialog(playerid) {

    new answr1[32];
    new answr2[32];
    new answr3[32];
    new answr4[32];

    if(mechanic_CurrentList[playerid][0] == mechanic_List[playerid][0])
        format(answr1, sizeof answr1, "DA");
    else format(answr1, sizeof answr1, "NE");

    if(mechanic_CurrentList[playerid][1] == mechanic_List[playerid][1])
        format(answr2, sizeof answr2, "DA");
    else format(answr2, sizeof answr2, "NE");

    if(mechanic_CurrentList[playerid][2] == mechanic_List[playerid][2])
        format(answr3, sizeof answr3, "DA");
    else format(answr3, sizeof answr3, "NE");

    if(mechanic_CurrentList[playerid][3] == mechanic_List[playerid][3])
        format(answr4, sizeof answr4, "DA");
    else format(answr4, sizeof answr4, "NE");

    new dlgStr[2048];

    format(dlgStr, sizeof dlgStr, 
                            ""c_green" SPISAK STVARI\n\
                            "c_white"Branik : "c_green"%s\n\
                            "c_white"Spojler : "c_green"%s\n\
                            "c_white"Felne : "c_green"%s\n\
                            "c_white"Nitro : "c_green"%s",
                            answr1, answr2, answr3, answr4 );

    Dialog_Show(playerid, "_noReturn", DIALOG_STYLE_MSGBOX, "Los Santos Customs \187; "c_green"Current List", dlgStr, "Ok", "");
    return (true);
}

YCMD:bumpers(playerid, params[], help) 
{

    if(playerJob[playerid] != JOB_MECHANIC)
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Niste zaposleni kao mehanicar!");
    
    if(playerUniform[playerid] != JOB_MECHANIC) 
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Nemate poslovnu uniformu!");

    if(!IsPlayerInRangeOfPoint(playerid, 1.7, 1085.8417,-1205.1615,17.8047))
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Ne nalazite se na mjestu za uzimanje djelova (branik)!");

    new dlgStr[2040], dlgStrcat[64];

    for(new i = 0; i < sizeof sz_BumperList; i++) {

        format(dlgStrcat, sizeof dlgStrcat, ""c_server"#%d \187; "c_green"%s\n", i, sz_BumperList[i][bumperName]);
        strcat(dlgStr, dlgStrcat);

    }

    Dialog_Show(playerid, "dialog_BumperList", DIALOG_STYLE_LIST, "Los Santos Customs \187; "c_green"Bumpers", dlgStr, "Izaberi", "Odustani");
    return 1;
}

YCMD:spoilers(playerid, params[], help) 
{

    if(playerJob[playerid] != JOB_MECHANIC)
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Niste zaposleni kao mehanicar!");
    
    if(playerUniform[playerid] != JOB_MECHANIC) 
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Nemate poslovnu uniformu!");

    if(!IsPlayerInRangeOfPoint(playerid, 1.7, 1085.8417,-1205.1615,17.8047))
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Ne nalazite se na mjestu za uzimanje djelova (spojler)!");

    new dlgStr[2040], dlgStrcat[288];

    for(new i = 0; i < sizeof sz_SpoilerList; i++) {

        format(dlgStrcat, sizeof dlgStrcat, ""c_server"#%d \187; "c_green"%s\n", i, sz_SpoilerList[i][bumperName]);
        strcat(dlgStr, dlgStrcat);
    }

    Dialog_Show(playerid, "dialog_SpoilerList", DIALOG_STYLE_LIST, "Los Santos Customs \187; "c_green"Spoilers", dlgStr, "Izaberi", "Odustani");
    
    return 1;
}

YCMD:nitrous(playerid, params[], help) 
{
    
    if(playerJob[playerid] != JOB_MECHANIC)
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Niste zaposleni kao mehanicar!");
    
    if(playerUniform[playerid] != JOB_MECHANIC) 
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Nemate poslovnu uniformu!");

    if(!IsPlayerInRangeOfPoint(playerid, 1.7, 1094.5205,-1186.4772,18.3243))
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Ne nalazite se na mjestu za uzimanje djelova (nitro)!");

    new dlgStr[2040], dlgStrcat[64];

    for(new i = 0; i < sizeof sz_NitrousList; i++) {

        format(dlgStrcat, sizeof dlgStrcat, ""c_server"#%d \187; "c_green"%s\n", i, sz_NitrousList[i][bumperName]);
        strcat(dlgStr, dlgStrcat);
    }

    Dialog_Show(playerid, "dialog_NitrousList", DIALOG_STYLE_LIST, "Los Santos Customs \187; "c_green"Nitrous", dlgStr, "Izaberi", "Odustani");

    return 1;
}

YCMD:wheels(playerid, params[], help) 
{
    
    if(playerJob[playerid] != JOB_MECHANIC)
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Niste zaposleni kao mehanicar!");
    
    if(playerUniform[playerid] != JOB_MECHANIC) 
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Nemate poslovnu uniformu!");

    if(!IsPlayerInRangeOfPoint(playerid, 1.7, 1084.4229,-1197.7640,17.9871))
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Ne nalazite se na mjestu za uzimanje djelova (nitro)!");

    new dlgStr[2040], dlgStrcat[64];

    for(new i = 0; i < sizeof sz_TiresList; i++) {

        format(dlgStrcat, sizeof dlgStrcat, ""c_server"#%d \187; "c_green"%s\n", i, sz_TiresList[i][tireName]);
        strcat(dlgStr, dlgStrcat);
    }

    Dialog_Show(playerid, "dialog_WheelsList", DIALOG_STYLE_LIST, "Los Santos Customs \187; "c_green"Wheels", dlgStr, "Izaberi", "Odustani");

    return 1;
}

YCMD:carservice(playerid, params[], help) 
{   
    if(playerJob[playerid] != JOB_MECHANIC)
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Niste zaposleni kao mehanicar!");
    
    if(playerUniform[playerid] != JOB_MECHANIC) 
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Nemate poslovnu uniformu!");

    if(!IsPlayerInRangeOfPoint(playerid, 1.70, 1103.1528,-1224.9373,18.3765)) 
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Ne nalazite se na poziciji za servis vozila!");

    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
    RemovePlayerAttachedObject(playerid, INDEX_SLOT_MECHANIC);
    ApplyAnimation(playerid, "CARRY", "putdwn", 4.1, false, true, true, false, 2);

    mechanic_CurrentList[playerid][ mechanic_Carry1[playerid] ] = mechanic_Carry2[playerid]; 
    mechanic_Carry1[playerid] = -1;

    LCS_ShowTuneListDialog(playerid);

    if(mechanic_CurrentList[playerid][0] == mechanic_List[playerid][0] &&\
       mechanic_CurrentList[playerid][1] == mechanic_List[playerid][1] &&\
       mechanic_CurrentList[playerid][2] == mechanic_List[playerid][2] &&\
       mechanic_CurrentList[playerid][3] == mechanic_List[playerid][3]) {

        DestroyVehicle(mechanic_pVehicle[playerid]);
        SetPlayerVirtualWorld(playerid, 0);
        job.GivePlayerSalary(playerid, jobInfo[playerJob[playerid]][jobSalary]);
        
        mechanic_InProgress[playerid] = false;

        mechanic_List[playerid][0] = -1;
        mechanic_List[playerid][1] = -1;
        mechanic_List[playerid][2] = -1;
        mechanic_List[playerid][3] = -1;

        mechanic_CurrentList[playerid][0] = -1;
        mechanic_CurrentList[playerid][1] = -1;
        mechanic_CurrentList[playerid][2] = -1;
        mechanic_CurrentList[playerid][3] = -1;

        mechanic_Carry1[playerid] = -1;
    }

    return 1;
}

YCMD:lsclist(playerid, params[], help) {

    if(playerJob[playerid] != JOB_MECHANIC)
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Niste zaposleni kao mehanicar!");
    
    if(playerUniform[playerid] != JOB_MECHANIC) 
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Nemate poslovnu uniformu!");

    if(!mechanic_InProgress[playerid])
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Ne servisirate ni jedno vozilo!");

    new dlgStr[2047];

    format(dlgStr, sizeof dlgStr, 
                                ""c_green" SPISAK STVARI\n\
                                "c_white"Branik : "c_green"%s\n\
                                "c_white"Spojler : "c_green"%s\n\
                                "c_white"Felne : "c_green"%s\n\
                                "c_white"Nitro : "c_green"%s",
                                sz_BumperList[mechanic_List[playerid][0]][bumperName], sz_SpoilerList[mechanic_List[playerid][1]][spoilerName], sz_TiresList[mechanic_List[playerid][2]][tireName], sz_NitrousList[mechanic_List[playerid][3]][nitroName] );

    Dialog_Show(playerid, "dialog_tuneList", DIALOG_STYLE_MSGBOX, "Los Santos Customs \187; "c_green"TODO List", dlgStr, "Ok", "");

    return (true);
}

YCMD:startservice(playerid, params[], help) {

    if(playerJob[playerid] != JOB_MECHANIC)
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Niste zaposleni kao mehanicar!");
    
    if(playerUniform[playerid] != JOB_MECHANIC) 
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Nemate poslovnu uniformu!");

    if(mechanic_InProgress[playerid])
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Vec servisirate neko vozilo!");

    SetPlayerVirtualWorld(playerid, playerid+1);

    new xRand = random(sizeof sz_LSCVehicles);
    new cColor = RandomMinMax(10, 255);
    mechanic_pVehicle[playerid] = CreateVehicle(sz_LSCVehicles[xRand], 1103.0853,-1227.4819,18.0958,179.5994, cColor, cColor, 1500);
    SetVehicleVirtualWorld(mechanic_pVehicle[playerid], playerid+1);

    new dlgStr[2049];

    mechanic_InProgress[playerid] = true;

    mechanic_List[playerid][0] = random( sizeof sz_BumperList ); 
    mechanic_List[playerid][1] = random( sizeof sz_SpoilerList ); 
    mechanic_List[playerid][2] = random( sizeof sz_TiresList );
    mechanic_List[playerid][3] = random( sizeof sz_NitrousList ); 

    format(dlgStr, sizeof dlgStr, 
                                ""c_green" SPISAK STVARI\n\
                                "c_white"Branik : "c_green"%s\n\
                                "c_white"Spojler : "c_green"%s\n\
                                "c_white"Felne : "c_green"%s\n\
                                "c_white"Nitro : "c_green"%s",
                                sz_BumperList[mechanic_List[playerid][0]][bumperName], sz_SpoilerList[mechanic_List[playerid][1]][spoilerName], sz_TiresList[mechanic_List[playerid][2]][tireName], sz_NitrousList[mechanic_List[playerid][3]][nitroName] );

    Dialog_Show(playerid, "dialog_tuneList", DIALOG_STYLE_MSGBOX, "Los Santos Customs \187; "c_green"TODO List", dlgStr, "Ok", "");

    return (true);
}


Dialog:dialog_BumperList(const playerid, response, listitem, string: inputtext[]) {

    if(response) {

        if(mechanic_Carry1[playerid] != -1)
            return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Vec nosite neki dio!");
    
        mechanic_Carry1[playerid] = 0;
        mechanic_Carry2[playerid] = listitem;

        RemovePlayerAttachedObject(playerid, INDEX_SLOT_MECHANIC);
        SetPlayerAttachedObject(playerid, INDEX_SLOT_MECHANIC, sz_BumperList[listitem][bumperModel], 5, 0.1, 0.0, 0.0, 0.0, 0.0);
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
    }

    return (true);
}

Dialog:dialog_SpoilerList(const playerid, response, listitem, string: inputtext[]) {

    if(response) {

        if(mechanic_Carry1[playerid] != -1)
            return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Vec nosite neki dio!");
    
        mechanic_Carry1[playerid] = 1;
        mechanic_Carry2[playerid] = listitem;
        RemovePlayerAttachedObject(playerid, INDEX_SLOT_MECHANIC);
        SetPlayerAttachedObject(playerid, INDEX_SLOT_MECHANIC, sz_SpoilerList[listitem][spoilerModel], 5, 0.1, 0.0, 0.0, 0.0, 0.0);
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
    }

    return (true);
}

Dialog:dialog_WheelsList(const playerid, response, listitem, string: inputtext[]) {

    if(response) {

        if(mechanic_Carry1[playerid] != -1)
            return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Vec nosite neki dio!");
    
        mechanic_Carry1[playerid] = 2;
        mechanic_Carry2[playerid] = listitem;
        RemovePlayerAttachedObject(playerid, INDEX_SLOT_MECHANIC);
        SetPlayerAttachedObject(playerid, INDEX_SLOT_MECHANIC, sz_TiresList[listitem][tireModel], 5, 0.1, 0.0, 0.0, 0.0, 0.0);
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
    }

    return (true);
}

Dialog:dialog_NitrousList(const playerid, response, listitem, string: inputtext[]) {

    if(response) {

        if(mechanic_Carry1[playerid] != -1)
            return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Vec nosite neki dio!");
    
        mechanic_Carry1[playerid] = 3;
        mechanic_Carry2[playerid] = listitem;
        RemovePlayerAttachedObject(playerid, INDEX_SLOT_MECHANIC);
        SetPlayerAttachedObject(playerid, INDEX_SLOT_MECHANIC, sz_NitrousList[listitem][nitroName], 5, 0.1, 0.0, 0.0, 0.0, 0.0);
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
    }

    return (true);
}