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
 *  @Date           03th Jun 2023
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           faction_police.script
 *  @Module         backend
 */

 #include <ysilib\YSI_Coding\y_hooks>

 //============================================================ Defines
const MAX_POLICE = 30;
const MAX_RANK_NAME = 32;
//============================================================ Enums (sufix f = Faction)

enum E_POLICE_DATA {

    fPoliceID,                     

    fPoliceName[60],               
    fPoliceShortName[30],          
    fPoliceAdress[35],             
    fPoliceState[30],              

    fPoliceBoss,                   
    fPoliceType,                   

    Float:fPoliceEntrance[3],      
    Float:fPoliceExit[3],          
    fPoliceInt,                    
    
    bool:fPoliceVault,             
    fPoliceMoney,                  
    fPoliceDirtMoney,              
    fConfiscatedDrugs,             
    
    Float:fDutyPoint[3],           
    Float:fEquipment[3],           

    fPolicePickup,                 
    Text3D:fPoliceLabel,           

    fPoliceSkins[4]                
}


new fPoliceInfo[MAX_POLICE][E_POLICE_DATA];
new Iterator:iter_Police<MAX_POLICE>;

new fPoliceRanks[MAX_POLICE][3][MAX_RANK_NAME];

new fCreatingID[MAX_PLAYERS] = -1;

//============================================================ Boze Pomozi

stock GetPoliceType(id) {

    new string[30];

    switch (fPoliceInfo[id][fPoliceType]) {
        case 1: { string = "Saobracajna Policija"; }
        case 2: { string = "Policija"; }
        case 3: { string = "Specijalne Jedinice"; }
    }
    return string;
}

hook OnGameModeInit()
{
    print("backend/faction_police.script loaded");

    mysql_tquery(SQL, "SELECT * FROM `faction_police`", "PoliceLoad", "");
}

forward PoliceLoad();
public PoliceLoad()
{

    new rows = cache_num_rows();

    if(!rows)
		return print("\n[State Factions]: 0 factions ucitano.\n");


    for(new i=0; i < rows; i++) if(i < MAX_POLICE)
    {
        cache_get_value_name_int(i, "fPoliceID", fPoliceInfo[i][fPoliceID]);

        cache_get_value_name(i, "fPoliceName", fPoliceInfo[i][fPoliceName], 60);
        cache_get_value_name(i, "fPoliceShortName", fPoliceInfo[i][fPoliceShortName], 30);
        cache_get_value_name(i, "fPoliceAdress", fPoliceInfo[i][fPoliceAdress], 35);
        cache_get_value_name(i, "fPoliceState", fPoliceInfo[i][fPoliceState], 30);

        cache_get_value_name_int(i, "fPoliceBoss", fPoliceInfo[i][fPoliceBoss]);
        cache_get_value_name_int(i, "fPoliceType", fPoliceInfo[i][fPoliceType]);

 		cache_get_value_name_float(i, "fPoliceX", fPoliceInfo[i][fPoliceEntrance][0]);
		cache_get_value_name_float(i, "fPoliceY", fPoliceInfo[i][fPoliceEntrance][1]);
		cache_get_value_name_float(i, "fPoliceZ", fPoliceInfo[i][fPoliceEntrance][2]);

		cache_get_value_name_float(i, "fPoliceExitX", fPoliceInfo[i][fPoliceExit][0]);
		cache_get_value_name_float(i, "fPoliceExitY", fPoliceInfo[i][fPoliceExit][1]);
		cache_get_value_name_float(i, "fPoliceExitZ", fPoliceInfo[i][fPoliceExit][2]); 
             
		cache_get_value_name_int(i, "fPoliceInt", fPoliceInfo[i][fPoliceInt]);

		cache_get_value_name_int(i, "fPoliceVault", fPoliceInfo[i][fPoliceVault]);
        cache_get_value_name_int(i, "fPoliceMoney", fPoliceInfo[i][fPoliceMoney]);
        cache_get_value_name_int(i, "fPoliceDirtMoney", fPoliceInfo[i][fPoliceDirtMoney]);
        cache_get_value_name_int(i, "fConfiscatedDrugs", fPoliceInfo[i][fConfiscatedDrugs]);

 		cache_get_value_name_float(i, "fDutyPointX", fPoliceInfo[i][fDutyPoint][0]);
		cache_get_value_name_float(i, "fDutyPointY", fPoliceInfo[i][fDutyPoint][1]);
		cache_get_value_name_float(i, "fDutyPointZ", fPoliceInfo[i][fDutyPoint][2]);

		cache_get_value_name_float(i, "fEquipmentX", fPoliceInfo[i][fEquipment][0]);
		cache_get_value_name_float(i, "fEquipmentY", fPoliceInfo[i][fEquipment][1]);
		cache_get_value_name_float(i, "fEquipmentZ", fPoliceInfo[i][fEquipment][2]);

        cache_get_value_name(i, "fPoliceRank1", fPoliceRanks[i][0], 32);
        cache_get_value_name(i, "fPoliceRank2", fPoliceRanks[i][1], 32);
        cache_get_value_name(i, "fPoliceRank3", fPoliceRanks[i][2], 32);


        cache_get_value_name_int(i, "fPoliceSkins1", fPoliceInfo[i][fPoliceSkins][0]);
        cache_get_value_name_int(i, "fPoliceSkins2", fPoliceInfo[i][fPoliceSkins][1]);
        cache_get_value_name_int(i, "fPoliceSkins3", fPoliceInfo[i][fPoliceSkins][2]);
        cache_get_value_name_int(i, "fPoliceSkins4", fPoliceInfo[i][fPoliceSkins][3]);

        new tmp_str[420];
        format(tmp_str, sizeof tmp_str, ""c_server"%s \187; "c_white"%d\n "c_server"Tip \187; "c_white"%s\n"c_server"Adresa \187; "c_white"%s", fPoliceInfo[i][fPoliceName], fPoliceInfo[i][fPoliceID], fPoliceInfo[i][fPoliceAdress]);

        fPoliceInfo[i][fPolicePickup] = CreatePickup(1581, 1, fPoliceInfo[i][fPoliceEntrance][0], fPoliceInfo[i][fPoliceEntrance][1], fPoliceInfo[i][fPoliceEntrance][2], 0);
        fPoliceInfo[i][fPoliceLabel] = Create3DTextLabel(tmp_str, -1, fPoliceInfo[i][fPoliceEntrance][0], fPoliceInfo[i][fPoliceEntrance][1], fPoliceInfo[i][fPoliceEntrance][2], 3.0, 0);
    
        Iter_Add(iter_Police, i);
    }
    printf("\n[State Factions]: %d Factions ucitano.\n",rows);
    return (true);
}

forward CreatePolice(id);
public CreatePolice(id) {

    fPoliceInfo[id][fPoliceID] = cache_insert_id();
    Iter_Add(iter_Police, id);

    new tmp_str[420];

    // TU sm brzo

     format(tmp_str, sizeof tmp_str, ""c_server"%s \187; "c_white"%d\n "c_server"Tip \187; "c_white"%s\n"c_server"Adresa \187; "c_white"%s", fPoliceInfo[i][fPoliceName], fPoliceInfo[i][fPoliceID], fPoliceInfo[i][fPoliceAdress]);

    fPoliceInfo[id][fPolicePickup] = CreatePickup(1581, 1, fPoliceInfo[id][fPoliceEntrance][0], fPoliceInfo[id][fPoliceEntrance][1], fPoliceInfo[id][fPoliceEntrance][2], 0);
    fPoliceInfo[id][fPoliceLabel] = Create3DTextLabel(tmp_str, -1, fPoliceInfo[id][fPoliceEntrance][0], fPoliceInfo[id][fPoliceEntrance][1], fPoliceInfo[id][fPoliceEntrance][2], 3.0, 0);

    return 1;
}

Dialog:dialog_createPolice(const playerid, response, listitem, string:inputtext[]) {

    if(!response)
        return false;

    new id = Iter_Free(iter_Police);
    fCreatingID[playerid] = id;

    new fpID = fCreatingID[playerid];

    if(strlen(inputtext) < 5 || strlen(inputtext) > 60)
        return Dialog_Show(playerid, "dialog_createPolice", DIALOG_STYLE_INPUT, "Maryland - Police Creation", "** Upisite zeljeno ime za policiju", "Unesi", "Odustani");

    new str_namePolice[60];
    format(str_namePolice, sizeof str_namePolice, "%s", inputtext);

    fPoliceInfo[fpID][fPoliceName] = str_namePolice;

    Dialog_Show(playerid, "dialog_policeShort", DIALOG_STYLE_INPUT, "Maryland - Police Creation", "** Upisite zeljeno skraceno ime za policiju", "Unesi", "Odustani");

    return 1;
}

Dialog:dialog_policeShort(const playerid, response, listitem, string:inputtext[]) {

    if(!response)
        return false;

    if(strlen(inputtext) < 2 || strlen(inputtext) > 30)
        return Dialog_Show(playerid, "dialog_policeShort", DIALOG_STYLE_INPUT, "Maryland - Police Creation", "** Upisite zeljeno skraceno ime za policiju", "Unesi", "Odustani");

    new fpID = fCreatingID[playerid];

    new str_shortPolice[30];
    format(str_shortPolice, sizeof str_shortPolice, "%s", inputtext);

    fPoliceInfo[fpID][fPoliceShortName] = str_shortPolice;

    Dialog_Show(playerid, "dialog_PoliceType", DIALOG_STYLE_LIST, "Maryland - Police Creation", "1) Saobracajna Policija\n2) Policija", "Odaberi", "Odustani");

    

    return 1;
}

Dialog:dialog_PoliceType(const playerid, response, listitem, string:inputtext[]) {

    if(!response)
        return false;

    new tmp_type = listitem+1;
    new fpID = fCreatingID[playerid];


    fPoliceInfo[fpID][fPoliceType] = tmp_type;

    Dialog_Show(playerid, "dialog_policeRank1", DIALOG_STYLE_INPUT, "Maryland - Police Creation", "** Unesite ime za Rank 1", "Unesi", "Odustani");

    return 1;
}

Dialog:dialog_policeRank1(const playerid, response, listitem, string:inputtext[]) {

    if(!response)
        return false;

    if(strlen(inputtext) < 4 || strlen(inputtext) > MAX_RANK_NAME)
        return Dialog_Show(playerid, "dialog_policeRank1", DIALOG_STYLE_INPUT, "Maryland - Police Creation", "** Unesite ime za Rank 1", "Unesi", "Odustani");

    new fpID = fCreatingID[playerid];

    new str_rankName[MAX_RANK_NAME];
    format(str_rankName, sizeof str_rankName, "%s", inputtext);

    fPoliceRanks[fpID][0] = str_rankName;

    Dialog_Show(playerid, "dialog_policeRank2", DIALOG_STYLE_INPUT, "Maryland - Police Creation", "** Unesite ime za Rank 2", "Unesi", "Odustani");

    

    return 1;
}

Dialog:dialog_policeRank2(const playerid, response, listitem, string:inputtext[]) {

    if(!response)
        return false;

    if(strlen(inputtext) < 4 || strlen(inputtext) > MAX_RANK_NAME)
        return Dialog_Show(playerid, "dialog_policeRank2", DIALOG_STYLE_INPUT, "Maryland - Police Creation", "** Unesite ime za Rank 2", "Unesi", "Odustani");

    new fpID = fCreatingID[playerid];

    new str_rankName[MAX_RANK_NAME];
    format(str_rankName, sizeof str_rankName, "%s", inputtext);

    fPoliceRanks[fpID][1] = str_rankName;

    Dialog_Show(playerid, "dialog_policeRank3", DIALOG_STYLE_INPUT, "Maryland - Police Creation", "** Unesite ime za Rank 3", "Unesi", "Odustani");

    return 1;
}

Dialog:dialog_policeRank3(const playerid, response, listitem, string:inputtext[]) {

    if(!response)
        return false;

    if(strlen(inputtext) < 4 || strlen(inputtext) > MAX_RANK_NAME)
        return Dialog_Show(playerid, "dialog_policeRank3", DIALOG_STYLE_INPUT, "Maryland - Police Creation", "** Unesite ime za Rank 3", "Unesi", "Odustani");

    new fpID = fCreatingID[playerid];

    new str_rankName[MAX_RANK_NAME];
    format(str_rankName, sizeof str_rankName, "%s", inputtext);

    fPoliceRanks[fpID][2] = str_rankName;

    Dialog_Show(playerid, "dialog_policeSkin1", DIALOG_STYLE_INPUT, "Maryland - Police Creation", "** Unesite zeljeni skin za Rank 1", "Unesi", "Odustani");


    return 1;
}

Dialog:dialog_policeSkin1(const playerid, response, listitem, string:inputtext[]) {

    if(!response)
        return false;

    new fpID = fCreatingID[playerid];
    new skinid = strval(inputtext);

    fPoliceInfo[fpID][fPoliceSkins][0] = skinid;

    Dialog_Show(playerid, "dialog_policeSkin2", DIALOG_STYLE_INPUT, "Maryland - Police Creation", "** Unesite zeljeni skin za Rank 2", "Unesi", "Odustani");

    return 1;
}

Dialog:dialog_policeSkin2(const playerid, response, listitem, string:inputtext[]) {

    if(!response)
        return false;

    new fpID = fCreatingID[playerid];
    new skinid = strval(inputtext);

    fPoliceInfo[fpID][fPoliceSkins][1] = skinid;

    Dialog_Show(playerid, "dialog_policeSkin3", DIALOG_STYLE_INPUT, "Maryland - Police Creation", "** Unesite zeljeni skin za Rank 3", "Unesi", "Odustani");

    return 1;
}

Dialog:dialog_policeSkin3(const playerid, response, listitem, string:inputtext[]) {

    if(!response)
        return false;

    new fpID = fCreatingID[playerid];
    new skinid = strval(inputtext);

    fPoliceInfo[fpID][fPoliceSkins][2] = skinid;

    Dialog_Show(playerid, "dialog_policeSkin4", DIALOG_STYLE_INPUT, "Maryland - Police Creation", "** Unesite zeljeni skin za Rank 4", "Unesi", "Odustani");

    return 1;
}

Dialog:dialog_policeSkin4(const playerid, response, listitem, string:inputtext[]) {

    if(!response)
        return false;

    new fpID = fCreatingID[playerid];
    new skinid = strval(inputtext);

    fPoliceInfo[fpID][fPoliceSkins][3] = skinid;

    Dialog_Show(playerid, "dialog_policeAccept", DIALOG_STYLE_MSGBOX, "Maryland - Police Creation", "Ime Policije : %s\n Skracenica : %s\n Tip : %s", "Prihvati", "Odustani", 
                                                 fPoliceInfo[fpID][fPoliceName], fPoliceInfo[fpID][fPoliceShortName], GetPoliceType(fpID));
    return 1;
}

Dialog:dialog_policeAccept(const playerid, response, listitem, string:inputtext[]) {

    if(!response)
        return false;

    if(response) {

        new fpID = fCreatingID[playerid];
        new Float:pPos[3];

        GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);

        new zone[28], add[35];
        GetPlayer2DZone(playerid, zone, sizeof(zone));
        format(add, sizeof(add), "%s, Maryland", zone);
        strmid(fPoliceInfo[fpID][fPoliceAdress], add, 0, sizeof(add), 255);

        fPoliceInfo[fpID][fPoliceEntrance][0] = pPos[0];
        fPoliceInfo[fpID][fPoliceEntrance][1] = pPos[1];
        fPoliceInfo[fpID][fPoliceEntrance][2] = pPos[2];

        new query[789];
        mysql_format(SQL, query, sizeof query, "INSERT INTO `faction_police` (`fPoliceName`, `fPoliceShortName`, `fPoliceAdress`, `fPoliceType`, `fPoliceX`, `fPoliceY`, `fPoliceZ`, \
                                                `fPoliceRank1`, `fPoliceRank2`, `fPoliceRank3`, `fPoliceSkins1`, `fPoliceSkins2`, `fPoliceSkins3`, `fPoliceSkins4`) \
                                                VALUES ('%e', '%e', '%e', '%i', '%f', '%f', '%f', '%e', '%e', '%e', '%i', '%i', '%i', '%i')", 
                                                fPoliceInfo[fpID][fPoliceName], fPoliceInfo[fpID][fPoliceShortName], fPoliceInfo[fpID][fPoliceAdress],
                                                fPoliceInfo[fpID][fPoliceType], fPoliceInfo[fpID][fPoliceEntrance][0], fPoliceInfo[fpID][fPoliceEntrance][1],
                                                fPoliceInfo[fpID][fPoliceEntrance][2], fPoliceRanks[fpID][0], fPoliceRanks[fpID][1], fPoliceRanks[fpID][2], 
                                                fPoliceInfo[fpID][fPoliceSkins][0], fPoliceInfo[fpID][fPoliceSkins][1], fPoliceInfo[fpID][fPoliceSkins][2], fPoliceInfo[fpID][fPoliceSkins][3]);
        mysql_tquery(SQL, query, "CreatePolice", "i", fpID);

    }

    return 1;
}