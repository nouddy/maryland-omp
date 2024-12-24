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

new const sz_NitrousList[][e_LSC_NITROUS_DATA] = {

    { "Small Nitrous",      1008},
    { "Medium Nitrous",     1009},
    { "Large Nitrous",      1010}

};

new const sz_BumperList[][e_LSC_BUMPER_DATA] = {

    { "Alien Front Bumper",	    1171},
    { "X-Flow Front Bumper",	1172},
    { "Chromer Bumper",	        1173},
    { "Slamin Bumper",	        1174},
    { "Hyperflow",              1173}
};

new const sz_SpoilerList[][e_LSC_SPOILER_DATA] = {

    { "Alien Spoiler",	1138},
    { "X-Flow Spoiler",	1139},
    { "Win Spoiler",	1140},
    { "Champ Spoiler",	1141},
    { "Drag Spoiler",	1142},
    { "Fury Spoiler",	1147},
    { "Race Spoiler",	1162},
    { "Worx Spoiler",	1146},
    { "Alpha Spoiler",	1003},
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

new mechanic_pPickup;

new lsc_tmp_idx[MAX_PLAYERS][4];

new msBumpers = mS_INVALID_LISTID,
    msSpoilers = mS_INVALID_LISTID,
    msNitrous = mS_INVALID_LISTID,
    msWheels = mS_INVALID_LISTID;

hook OnGameModeInit() {

    CreateCustomMarker(""c_server"[ Los Santos Customs ]\n"c_server"» "c_white"'/bumpers'\n"c_server"» "c_white"'/spoilers'", 1085.8417,-1205.1615,17.8047, -1, -1, 50.0); // Tehnicki Pregled

    CreateCustomMarker(""c_server"[ Los Santos Customs ]\n"c_server"» "c_white"'/nitrous'", 1094.5205,-1186.4772,18.3243, -1, -1, 50.0); // Tehnicki Pregled
    CreateCustomMarker(""c_server"[ Los Santos Customs ]\n"c_server"» "c_white"'/wheels'", 1084.4229,-1197.7640,17.9871, -1, -1, 50.0); // Tehnicki Pregled

    mechanic_pPickup = CreateDynamicPickup(19627, 1, 1103.2499,-1227.9851,15.8271);

    msBumpers = LoadModelSelectionMenu("bumpers.txt");
    msSpoilers = LoadModelSelectionMenu("spoilers.txt");
    msNitrous = LoadModelSelectionMenu("nitrous.txt");
    msWheels = LoadModelSelectionMenu("wheels.txt");

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

    lsc_tmp_idx[playerid][0] = -1;
    lsc_tmp_idx[playerid][1] = -1;
    lsc_tmp_idx[playerid][2] = -1;
    lsc_tmp_idx[playerid][3] = -1;

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
        format(answr1, sizeof answr1, "{009933}DA");
    else format(answr1, sizeof answr1, "{FF0000}NE");

    if(mechanic_CurrentList[playerid][1] == mechanic_List[playerid][1])
        format(answr2, sizeof answr2, "{009933}DA");
    else format(answr2, sizeof answr2, "{FF0000}NE");

    if(mechanic_CurrentList[playerid][2] == mechanic_List[playerid][2])
        format(answr3, sizeof answr3, "{009933}DA");
    else format(answr3, sizeof answr3, "{FF0000}NE");

    if(mechanic_CurrentList[playerid][3] == mechanic_List[playerid][3])
        format(answr4, sizeof answr4, "{009933}DA");
    else format(answr4, sizeof answr4, "{FF0000}NE");

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

    ShowModelSelectionMenu(playerid, msBumpers, "Bumpers");
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

    ShowModelSelectionMenu(playerid, msSpoilers, "Spoilers");
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

    ShowModelSelectionMenu(playerid, msNitrous, "Nitrous");
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

    ShowModelSelectionMenu(playerid, msWheels, "Wheels");

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
                                sz_BumperList[lsc_tmp_idx[playerid][0]][bumperName], sz_SpoilerList[lsc_tmp_idx[playerid][1]][spoilerName], sz_TiresList[lsc_tmp_idx[playerid][2]][tireName], sz_NitrousList[lsc_tmp_idx[playerid][3]][nitroName] );

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

    new bool:engine, bool:lights, bool:alarm, bool:doors, bool:bonnet, bool:boot, bool:objective;
    GetVehicleParamsEx(mechanic_pVehicle[playerid], engine, lights, alarm, doors, bonnet, boot, objective);

    SetVehicleParamsEx(mechanic_pVehicle[playerid], engine, VEHICLE_PARAMS_ON, alarm, true, true, boot, objective);

    new VEHICLE_PANEL_STATUS:xpanels,
        VEHICLE_DOOR_STATUS:xdoors,
        VEHICLE_LIGHT_STATUS:xlights,
        VEHICLE_TIRE_STATUS:xtires;
    GetVehicleDamageStatus(mechanic_pVehicle[playerid], xpanels, xdoors, xlights, xtires);
    xdoors = ( VEHICLE_DOOR_STATUS_HOOD_OPEN | VEHICLE_DOOR_STATUS_TRUNK_OPEN  | VEHICLE_DOOR_STATUS_PASSENGER_OPEN | VEHICLE_DOOR_STATUS_DRIVER_OPEN);
    UpdateVehicleDamageStatus(mechanic_pVehicle[playerid], xpanels, xdoors, xlights, xtires);

    new dlgStr[2049];

    mechanic_InProgress[playerid] = true;

    lsc_tmp_idx[playerid][0] = random( sizeof sz_BumperList ); 
    lsc_tmp_idx[playerid][1] = random( sizeof sz_SpoilerList ); 
    lsc_tmp_idx[playerid][2] = random( sizeof sz_TiresList );
    lsc_tmp_idx[playerid][3] = random( sizeof sz_NitrousList ); 

    mechanic_List[playerid][0] = sz_BumperList[lsc_tmp_idx[playerid][0]][bumperModel];
    mechanic_List[playerid][1] = sz_SpoilerList[lsc_tmp_idx[playerid][1]][spoilerModel];
    mechanic_List[playerid][2] = sz_TiresList[lsc_tmp_idx[playerid][2]][tireModel];
    mechanic_List[playerid][3] = sz_NitrousList[lsc_tmp_idx[playerid][3]][nitroModel];

    format(dlgStr, sizeof dlgStr, 
                                ""c_green" SPISAK STVARI\n\
                                "c_white"Branik : "c_green"%s\n\
                                "c_white"Spojler : "c_green"%s\n\
                                "c_white"Felne : "c_green"%s\n\
                                "c_white"Nitro : "c_green"%s",
                                sz_BumperList[lsc_tmp_idx[playerid][0]][bumperName], sz_SpoilerList[lsc_tmp_idx[playerid][1]][spoilerName], sz_TiresList[lsc_tmp_idx[playerid][2]][tireName], sz_NitrousList[lsc_tmp_idx[playerid][3]][nitroName] );

    Dialog_Show(playerid, "dialog_tuneList", DIALOG_STYLE_MSGBOX, "Los Santos Customs \187; "c_green"TODO List", dlgStr, "Ok", "");


    return (true);
}

hook OnPlayerModelSelection( playerid, response, listid, modelid) {
    if(listid == msBumpers) {
        if( response ) {
            
            if(!mechanic_InProgress[playerid])
                return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Niste zapoceli servis auta!");

            if(mechanic_Carry1[playerid] != -1)
                return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Vec nosite neki dio!");
        
            mechanic_Carry1[playerid] = 0;
            mechanic_Carry2[playerid] = modelid;

            if(IsPlayerAttachedObjectSlotUsed(playerid, INDEX_SLOT_MECHANIC))
                RemovePlayerAttachedObject(playerid, INDEX_SLOT_MECHANIC);
            
            if(modelid == 1174) 
                SetPlayerAttachedObject(playerid, INDEX_SLOT_MECHANIC, modelid, 5, 0.114998, -0.387000, -1.009997, 64.799934, -163.399826, 82.999961, 1.000000, 1.000000, 1.000000);
            else
                SetPlayerAttachedObject(playerid, INDEX_SLOT_MECHANIC, modelid, 5, -0.563001, -0.426999, -1.316998, 64.799934, -163.399826, 82.999961, 1.000000, 1.000000, 1.000000);

            SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
        }
    }

    if(listid == msSpoilers) {
        if( response ) {
            
            if(!mechanic_InProgress[playerid])
                return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Niste zapoceli servis auta!");

            if(mechanic_Carry1[playerid] != -1)
                return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Vec nosite neki dio!");
        
            mechanic_Carry1[playerid] = 1;
            mechanic_Carry2[playerid] = modelid;

            if(IsPlayerAttachedObjectSlotUsed(playerid, INDEX_SLOT_MECHANIC))
                RemovePlayerAttachedObject(playerid, INDEX_SLOT_MECHANIC);
            
            SetPlayerAttachedObject(playerid, INDEX_SLOT_MECHANIC, modelid, 5, 0.208000, -0.160999, 0.040999, -83.699821, -4.400029, -74.300056, 1.000000, 1.000000, 1.000000);

            SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
        }
    }

    if(listid == msWheels) {
        if( response ) {
            
            if(!mechanic_InProgress[playerid])
                return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Niste zapoceli servis auta!");

            if(mechanic_Carry1[playerid] != -1)
                return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Vec nosite neki dio!");
        
            mechanic_Carry1[playerid] = 2;
            mechanic_Carry2[playerid] = modelid;

            if(IsPlayerAttachedObjectSlotUsed(playerid, INDEX_SLOT_MECHANIC))
                RemovePlayerAttachedObject(playerid, INDEX_SLOT_MECHANIC);
            
            SetPlayerAttachedObject(playerid, INDEX_SLOT_MECHANIC, modelid, 5, 0.1, 0.1, 0.0, 0.0, 0.0, 0.0);

            SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
        }
    }

    if(listid == msNitrous) {
        if( response ) {
            
            if(!mechanic_InProgress[playerid])
                return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Niste zapoceli servis auta!");

            if(mechanic_Carry1[playerid] != -1)
                return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Vec nosite neki dio!");

            mechanic_Carry1[playerid] = 3;
            mechanic_Carry2[playerid] = modelid;

            if(IsPlayerAttachedObjectSlotUsed(playerid, INDEX_SLOT_MECHANIC))
                RemovePlayerAttachedObject(playerid, INDEX_SLOT_MECHANIC);
            
            SetPlayerAttachedObject(playerid, INDEX_SLOT_MECHANIC, modelid, 5, 0.137000, 0.000999, 0.091000, -83.699821, -4.400029, -74.100051, 1.000000, 1.000000, 1.000000);

            SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
        }
    }

    return 1;
}

hook OnPlayerPickUpDynPickup(playerid, pickupid) {

    if(pickupid == mechanic_pPickup) {

        if(mechanic_Carry1[playerid] == -1)
            return (true);

        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
        RemovePlayerAttachedObject(playerid, INDEX_SLOT_MECHANIC);
        ApplyAnimation(playerid, !"CARRY", !"putdwn", 4.1, false, false, false, false, SYNC_NONE);

        mechanic_CurrentList[playerid][ mechanic_Carry1[playerid] ] = mechanic_Carry2[playerid]; 
        mechanic_Carry1[playerid] = -1;
        mechanic_Carry2[playerid] = -1;

        LCS_ShowTuneListDialog(playerid);  
        PlayerPlaySound(playerid,32000,0,0,0.0);

        if(mechanic_CurrentList[playerid][0] == mechanic_List[playerid][0] &&\
        mechanic_CurrentList[playerid][1] == mechanic_List[playerid][1] &&\
        mechanic_CurrentList[playerid][2] == mechanic_List[playerid][2] &&\
        mechanic_CurrentList[playerid][3] == mechanic_List[playerid][3]) {

            DestroyVehicle(mechanic_pVehicle[playerid]);
            SetPlayerVirtualWorld(playerid, 0);
            job.GivePlayerSalary(playerid, jobInfo[playerJob[playerid]][jobSalary]);

            if(QuestData[playerid][questDone][1] == 0) {

                QuestData[playerid][questDone][1] = 1;
                UpdateSqlInt(SQL, "character_quests", "Quest_2", 1, "characterid", GetCharacterSQLID(playerid));
                SendClientMessage(playerid, x_server, "maryland \187; "c_white"Uspjesno ste zavrsili quest : %s", sz_QuestList[1][questName]);
                GivePlayerMoney(playerid, sz_QuestList[1][questAwards][0]);
                GiveCharXP(playerid, sz_QuestList[1][questAwards][1]);
            }
            
            mechanic_InProgress[playerid] = false;

            mechanic_List[playerid][0] = -1;
            mechanic_List[playerid][1] = -1;
            mechanic_List[playerid][2] = -1;
            mechanic_List[playerid][3] = -1;

            mechanic_CurrentList[playerid][0] = -1;
            mechanic_CurrentList[playerid][1] = -1;
            mechanic_CurrentList[playerid][2] = -1;
            mechanic_CurrentList[playerid][3] = -1;

            lsc_tmp_idx[playerid][0] = -1;
            lsc_tmp_idx[playerid][1] = -1;
            lsc_tmp_idx[playerid][2] = -1;
            lsc_tmp_idx[playerid][3] = -1;

            mechanic_Carry1[playerid] = -1;
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}