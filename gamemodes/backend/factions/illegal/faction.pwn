#include <ysilib\YSI_Coding\y_hooks>

#define     MAX_FACTIONS            (400)
#define     MAX_FACTION_NAME_LEN    (30)
#define     VEHICLE_TYPE_FACTION    (1)


enum {

    FACTION_TYPE_UNKNOWN = 0,
    FACTION_TYPE_FRIENDS,
    FACTION_TYPE_GANG,
    FACTION_TYPE_MAFIA
}


enum FACTION_CORE {

    factionID,                              // Faction SQL ID
    factionName[MAX_FACTION_NAME_LEN],      // Faction Name on Create
    factionType,                            // Faction Type
    
    factionBoss,                            // Faction leader
    factionRightHand,                       // Faction second leader
    
    Float:factionArea[3],                   // Faction will have their area for cars etc.. If is duo they will get random street cords for their area. When they upgrade prop is area.
    factionInterior,                        // When they got upgrade this is interior of prop
    factionVirtualWorld,                    // When they got upgrade this is virtual world of prop
    factionHouseID,                        // Faction House for members
    factionBunker                          // Faction Bunker - for heist etc...
}

new FactionInfo[MAX_FACTIONS][FACTION_CORE];
new Iterator:iter_Factions<MAX_FACTIONS>;

new Text3D:faction_Label[MAX_FACTIONS];

// Actors
new ActorsFactionCreate[4];
new Text3D:FactionCreateLabels[1];

new bool:faction_InProgress[MAX_PLAYERS],
    faction_Invite[MAX_PLAYERS],
    faction_SecondBoss[MAX_PLAYERS];

enum e_FACTION_MEMBERS {

    characterID,
    factionID,
    factionRank,
    factionRespect
}

new FactionMember[MAX_PLAYERS][e_FACTION_MEMBERS];

new faction_InviteID[MAX_PLAYERS],
    faction_InviteFID[MAX_PLAYERS];

new PlayerText3D:fa_BunkerLabel[MAX_PLAYERS];

forward PreloadFacitonBunkerLabel(playerid);
public PreloadFacitonBunkerLabel(playerid) {


    new fa_id = Faction_ReturnIndexId(playerid);

    if(FactionInfo[fa_id][factionBunker] != 0)
    {
        fa_BunkerLabel[playerid] = CreatePlayer3DTextLabel(playerid, ""c_server"\187; "c_white"Bunker\n"c_server"\187; "c_white"Za ulaz pritisni 'F'", -1, -1584.0164,-2572.3108,28.8232, 3.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID);  
    }
    else fa_BunkerLabel[playerid] = CreatePlayer3DTextLabel(playerid, ""c_server"\187; "c_white"Bunker\n"c_server"\187; "c_white"Za kupovinu '/buybunker'", -1, -1584.0164,-2572.3108,28.8232, 3.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID);

    return 1;
}

forward Faction_LoadData();
public Faction_LoadData() {

    new rows = cache_num_rows();

    if(!rows) return print("[FACTIONS] - Empty");

    for(new i = 0; i < rows; i++) {

        cache_get_value_name_int(i, "factionID", FactionInfo[i][factionID]);
        cache_get_value_name(i, "factionName", FactionInfo[i][factionName], MAX_FACTION_NAME_LEN);
        cache_get_value_name_int(i, "factionType", FactionInfo[i][factionType]);

        cache_get_value_name_int(i, "factionBoss", FactionInfo[i][factionBoss]);
        cache_get_value_name_int(i, "factionRightHand", FactionInfo[i][factionRightHand]);

        cache_get_value_name_float(i, "factionAreaX", FactionInfo[i][factionArea][0]);
        cache_get_value_name_float(i, "factionAreaY", FactionInfo[i][factionArea][1]);
        cache_get_value_name_float(i, "factionAreaZ", FactionInfo[i][factionArea][2]);

        cache_get_value_name_int(i, "factionInterior", FactionInfo[i][factionInterior]);
        cache_get_value_name_int(i, "factionVirtualWorld", FactionInfo[i][factionVirtualWorld]);
        cache_get_value_name_int(i, "factionHouseID", FactionInfo[i][factionHouseID]);
        cache_get_value_name_int(i, "factionBunker", FactionInfo[i][factionBunker]);

        if(FactionInfo[i][factionArea][0] != 0.00) {

            new str_faction[128];
            format(str_faction, sizeof str_faction, ""c_server" » "c_grey"Ovaj kvart je poznat po "c_server" %s « \n» "c_grey"Cesto su vidjeni ovde "c_server"«", FactionInfo[i][factionName] );

            faction_Label[i] = Create3DTextLabel(str_faction, -1, FactionInfo[i][factionArea][0], FactionInfo[i][factionArea][1], FactionInfo[i][factionArea][2], 3.50, 0);
        }
        new ret = Iter_Add(iter_Factions, i);
        printf("IterFactions [%d] = %d", i, ret);
    }

    return 1;
}

forward Faction_InsertData(id, member, playerid);
public Faction_InsertData(id, member, playerid) {

    FactionInfo[id][factionID] = cache_insert_id();

    Iter_Add(iter_Factions, id);

    FactionMember[member][characterID] = GetCharacterSQLID(member);
    FactionMember[member][factionID] = FactionInfo[id][factionID];
    FactionMember[member][factionRank] = 4;
    FactionMember[member][factionRespect] = 1;

    new q[260];

    mysql_format(MySQL:SQL, q, sizeof q, "INSERT INTO `faction_members` (`member_id`, `faction_id`, `faction_rank`, `faction_respekt`) \
                                          VALUES('%d', '%d', '4', '1')", 
                                      GetCharacterSQLID(member), FactionInfo[id][factionID]);
    mysql_tquery(MySQL:SQL, q);

    new query[260];

    mysql_format(MySQL:SQL, query, sizeof query, "INSERT INTO `faction_members` (`member_id`, `faction_id`, `faction_rank`, `faction_respekt`) \
                                             VALUES('%d', '%d', '4', '1')", 
                                     GetCharacterSQLID(playerid), FactionInfo[id][factionID]);
    mysql_tquery(MySQL:SQL, query);

    FactionMember[playerid][characterID] = GetCharacterSQLID(playerid);
    FactionMember[playerid][factionID] = FactionInfo[id][factionID];
    FactionMember[playerid][factionRank] = 4;
    FactionMember[playerid][factionRespect] = 1;

    if(QuestData[playerid][questDone][5] == 0) {

        QuestData[playerid][questDone][5] = 1;
        UpdateSqlInt(SQL, "character_quests", "Quest_6", 1, "characterid", GetCharacterSQLID(playerid));
        SendClientMessage(playerid, x_server, "maryland \187; "c_white"Uspjesno ste zavrsili quest : %s", sz_QuestList[5][questName]);
        GivePlayerMoney(playerid, sz_QuestList[5][questAwards][0]);
        GiveCharXP(playerid, sz_QuestList[5][questAwards][1]);
    }

    if(QuestData[member][questDone][5] == 0) {

        QuestData[member][questDone][5] = 1;
        UpdateSqlInt(SQL, "character_quests", "Quest_6", 1, "characterid", GetCharacterSQLID(member));
        SendClientMessage(member, x_server, "maryland \187; "c_white"Uspjesno ste zavrsili quest : %s", sz_QuestList[5][questName]);
        GivePlayerMoney(member, sz_QuestList[5][questAwards][0]);
        GiveCharXP(member, sz_QuestList[5][questAwards][1]);
    }

    return 1;
}

forward Member_LoadData(id);
public Member_LoadData(id) {

    new rows = cache_num_rows();
    if(!rows) return false;

    cache_get_value_name_int(0, "member_id", FactionMember[id][characterID]);
    cache_get_value_name_int(0, "faction_id", FactionMember[id][factionID]);
    cache_get_value_name_int(0, "faction_rank", FactionMember[id][factionRank]);
    cache_get_value_name_int(0, "faction_respekt", FactionMember[id][factionRespect]);
    
    CallLocalFunction("PreloadFacitonBunkerLabel", "d", id);
    return 1;   
}

forward Member_ShowList(playerid);
public Member_ShowList(playerid) {

    new rows = cache_num_rows();
    if(!rows) return SendClientMessage(playerid, x_green, ">> Nemate clanove!");

    else {

        new dialogStr[1024];
        new stringicc[288];
        for(new i = 0; i < rows; i++) {

            new charID;
            static charName[MAX_PLAYER_NAME+1];

            cache_get_value_name(i, "cName", charName, sizeof charName);
            cache_get_value_name_int(i, "member_id", charID);

            format(stringicc, sizeof stringicc, ""c_server"#%d \187; "c_ltorange"%s   "c_server"SQLID \187; "c_ltorange"%d\n", i+1, charName, charID);
            strcat(dialogStr, stringicc);
        }

        Dialog_Show(playerid, "dialog_noreturn-faction", DIALOG_STYLE_LIST, "Faction - Members", dialogStr, "Ok", "");
    }
    return 1;
}

// -------------------- > Callbacks

hook OnGameModeInit() {

    print("factions/faction.pwn > Dev Progress Loaded.");

    //mysql_tquery(SQL, "SELECT * FROM `factions`", "PreloadFactionData");    > For later. Sorry mr voki

    ActorsFactionCreate[0] = CreateDynamicActor(208, -775.2356, -1972.8859, 8.7799, 182.1289, 1, 100.0, -1, 3, -1);
    ActorsFactionCreate[1] = CreateDynamicActor(228, -775.9028, -1979.6080, 8.7799, 312.1205, 1, 100.0, -1, 3, -1);
    ActorsFactionCreate[2] = CreateDynamicActor(273, -778.6071, -1977.7972, 8.7799, 271.6165, 1, 100.0, -1, 3, -1);
    ActorsFactionCreate[3] = CreateDynamicActor(294, -777.6349, -1975.9537, 8.7799, 204.2099, 1, 100.0, -1, 3, -1);

    ApplyDynamicActorAnimation(ActorsFactionCreate[2], "ped", "SEAT_idle", 4.1, true, true, true, true, 0);

    ApplyDynamicActorAnimation(ActorsFactionCreate[3], "ped", "SEAT_idle", 4.1, true, true, true, true, 0);

    FactionCreateLabels[0] = CreateDynamic3DTextLabel(""c_server" » "c_grey"Faction Create "c_server"«\n"c_server" » "c_grey"Pritisni 'Y' za kreiranje. "c_server"«", x_white, -776.4226, -1977.0199, 8.7799, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 3, -1);

    mysql_tquery(MySQL:SQL, "SELECT * FROM `factions`", "Faction_LoadData"); // * I just lost 30 minutes on my mistake...

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnCharacterLoaded(playerid) {

    new q[267];

    mysql_format(MySQL:SQL, q, sizeof q, "SELECT * FROM `faction_members` WHERE `member_id` = '%d'",GetCharacterSQLID(playerid));
    mysql_tquery(MySQL:SQL, q, "Member_LoadData", "d", playerid);


    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerConnect(playerid) {

    faction_InviteID[playerid] = INVALID_PLAYER_ID;
    faction_InviteFID[playerid] = 0;

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys) {

    if(PRESSED(KEY_NO)) {

        if(IsPlayerInRangeOfPoint(playerid, 3.50, -776.4226, -1977.0199, 8.7799) && !faction_InProgress[playerid]) {
            
            if(FactionMember[playerid][factionID] != 0)
                return (true);

            faction_InProgress[playerid] = true;

            Dialog_Show(playerid, "dialog_createFaction", DIALOG_STYLE_INPUT, "Faction Invitation", "Molimo vas unesite ID osobe sa kojom zelite osnovati grupu!", "Unesi", "Odustani");

        }
    }

    if(PRESSED(KEY_SECONDARY_ATTACK)) {

        if(IsPlayerInRangeOfPoint(playerid, 1.7, -767.0725,-1966.6206,8.8245) && GetPlayerInterior(playerid) == 3) {

            SetPlayerPos(playerid, 1006.0764,-1230.3038,11.7786);
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
        }

        if(IsPlayerInRangeOfPoint(playerid, 1.70, 1006.0764,-1230.3038,11.7786)) {

            SetPlayerPos(playerid, -767.0725,-1966.6206,8.8245);
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 3);
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}


YCMD:members(playerid, params[], help) 
{

    if(FactionMember[playerid][factionID] == 0)
        return SendClientMessage(playerid, x_grey, "#FACTION : Niste clan niti jedne organizacije!");
    
    new q[267];
    new orgID = FactionMember[playerid][factionID];

    mysql_format(MySQL:SQL, q, sizeof q, "SELECT fm.member_id, fm.faction_id, fm.faction_rank, c.cName \
                                          FROM faction_members fm \
                                          JOIN characters c ON fm.member_id = c.character_id \
                                          WHERE fm.faction_id = '%d';", orgID);
    mysql_tquery(MySQL:SQL, q, "Member_ShowList", "d", playerid);

    return 1;
}

YCMD:f(playerid, params[], help) {

    if(FactionMember[playerid][factionID] == 0)
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Niste clan fakcije!");

    new message[128];

    if(sscanf(params, "s[128]", message))
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"/f [Poruka]");
    
    new fID = FactionMember[playerid][factionID];
    new tmp_message[320];

    foreach(new i : iter_Factions) {

        if(fID == FactionInfo[i][factionID]) {
            
            format(tmp_message, sizeof tmp_message, ""c_faction"%s \187; "c_white"%s[%d] %s.",
            FactionInfo[i][factionName], ReturnPlayerName(playerid), playerid, message);
            break;
        }
    }

    Faction_SendMessage(fID, tmp_message);

    return 1;
}

YCMD:finvite(playerid, params[], help) 
{
    
    if(FactionMember[playerid][factionRank] < 4)
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Niste lider niti jedne organizacije!");

    new targetid;
    
    if(sscanf(params, "u", targetid))
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"/finvite [ID/Ime]!");

    if(!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Igrac nije konektovan na server!");
    
    if(targetid == playerid)
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Ne mozes ubaciti samog sebe :/...");

    if(targetid == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Momak?!");

    if(FactionMember[targetid][factionID] != 0)
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Taj igrac je vec clan neke fakcije!");

    if(IsPlayerPoliceMember(playerid))
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Taj igrac je vec clan neke fakcije!"); 

    if(faction_InviteID[playerid] != INVALID_PLAYER_ID)
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Vec ste poslali poziv nekom igracu!"); 

    if(faction_InviteFID[targetid] != 0)
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Tom igracu je vec ponudjen poziv!"); 

    if(!DistanceBetweenPlayers(3.40, playerid, targetid))
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Niste u blizini tog igraca!");

    //*

    faction_InviteID[playerid] = targetid;
    faction_InviteID[targetid] = playerid;
    faction_InviteFID[targetid] = FactionMember[playerid][factionID];

    SendClientMessage(playerid, x_server, "maryland \187; "c_white"Poslali ste invite za fakciju igracu %s!", ReturnPlayerName(targetid));

    new sstr[2048];
    format(sstr, sizeof sstr, "%s[%d] vas je pozvao da se priduzite organizaciji.\n\
                              "c_white"Fakcija : "c_server"%s[%d].\n\
                              "c_white"Leader : "c_server"%s[%d].\n\
                              "c_white"Ukoliko zelite prihvatiti poziv pritisnite "c_server"PRIHVATI.", 
                              ReturnPlayerName(playerid), playerid, Faction_ReturnNameByPlayer(playerid), FactionMember[playerid][factionID], ReturnPlayerName(playerid), playerid);

    Dialog_Show(faction_InviteID[playerid], "dialog_factionInvite", DIALOG_STYLE_MSGBOX, "Maryland \187; "c_server"Factions", sstr, ""c_green"PRIHVATI", ""c_lred"ODBIJ");
    
    return 1;
}

YCMD:faction(playerid, params[], help) {

    if(FactionMember[playerid][factionID] == 0) return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Niste clan niti jedne organizacije!");

    if(FactionMember[playerid][factionRank] != 4) {

        Dialog_Show(playerid, "dialog_factionOption", DIALOG_STYLE_LIST, ""c_server"Maryland \187; "c_ltorange"Faction", 
                                                                                    ""c_server"#1 \187; "c_ltorange"Informacije\n\
                                                                                    "c_server"#2 \187; "c_ltorange"Clanovi\n\
                                                                                    "c_server"#3 \187; "c_ltorange"Vozila\n", "Ok", "Odustani");
    }

    else {

        Dialog_Show(playerid, "dialog_factionOption", DIALOG_STYLE_LIST, ""c_server"Maryland \187; "c_ltorange"Faction", 
                                                                                    ""c_server"#1 \187; "c_ltorange"Informacije\n\
                                                                                    "c_server"#2 \187; "c_ltorange"Clanovi\n\
                                                                                    "c_server"#3 \187; "c_ltorange"Vozila\n\
                                                                                    "c_server"#4 \187; "c_ltorange"Izbaci Clana\n\
                                                                                    "c_server"#5 \187; "c_ltorange"Ubaci Clana\n\
                                                                                    "c_server"#6 \187; "c_ltorange"Respawn Vozila", "Ok", "Odustani");
    }

    return 1;
}

YCMD:buybunker(playerid, params[], help) {

    if(!IsPlayerInRangeOfPoint(playerid, 2.0, -1584.0164,-2572.3108,28.8232))
        return SendServerMessage(playerid, "Niste u blizini bunkera!");

    if(FactionMember[playerid][factionRank] != 4)
        return SendServerMessage(playerid, "Niste lider fakcije!");

    new fa_id = Faction_ReturnIndexId(playerid);

    if(FactionInfo[fa_id][factionBunker] != 0)
        return SendServerMessage(playerid, "Vasa fakcija vec posjeduje bunker");

    if(GetPlayerMoney(playerid) < 50000.00)
        return SendServerMessage(playerid, "Za bunker vam treba 50.000,00$");

    FactionInfo[fa_id][factionBunker] = 1;

    GivePlayerMoney(playerid, -50000.00);
    SendServerMessage(playerid, "Uspjesno ste kupili bunker za fakciju!");
    Faction_SendMessage(FactionInfo[fa_id][factionID], ""c_grey"#FACTION \187; "c_white"Lider je uspjesno kupio bunker za fakciju!");

    SendClientMessage(playerid, x_ltorange, "Bunker \187; "c_white"Uspjesno ste kupili bunker, bunker vam sluzi za pokretanje heista!");
    SendClientMessage(playerid, x_ltorange, "Bunker \187; "c_white"Heist pokrecete komandom /startheist!");

    new q[128];
    mysql_format(SQL, q, sizeof q, "UPDATE `factions` SET `factionBunker` = '%d' WHERE `factionID` = '%d'", 1, FactionInfo[fa_id][factionID]);
    mysql_tquery(SQL, q);

    foreach(new j : Player) {

        if(FactionMember[j][factionID] == FactionMember[playerid][factionID]) {

            if(IsValidPlayer3DTextLabel(j, fa_BunkerLabel[j]))
                UpdatePlayer3DTextLabelText(j, fa_BunkerLabel[j], x_white, ""c_server"\187; "c_white"Bunker\n"c_server"\187; "c_white"Za ulaz pritisni 'F'");
        }
    }

    return (true);
}

Dialog:dialog_factionOption(playerid, response, listitem, string:inputtext[]) {

    if(response) {

        switch(listitem) {

            case 0: {
                
                new fID = Faction_ReturnIndexId(playerid);

                static faDlg[248];
                format(faDlg, sizeof faDlg, 
                    ""c_white"ID : "c_ltorange"%d\n\
                    "c_white"Ime : "c_ltorange"%s\n\
                    "c_white"Tip : "c_ltorange"%s\n", 
                    FactionInfo[fID][factionID], Faction_ReturnNameByPlayer(playerid), Faction_GetGroupType(fID));

                Dialog_Show(playerid, "_noReturn", DIALOG_STYLE_MSGBOX, ""c_server"Maryland \187; "c_ltorange"Faction", faDlg, "Ok", "");
            }

            case 1: {

                new q[267];
                new orgID = FactionMember[playerid][factionID];

                mysql_format(MySQL:SQL, q, sizeof q, "SELECT fm.member_id, fm.faction_id, fm.faction_rank, c.cName \
                                                    FROM faction_members fm \
                                                    JOIN characters c ON fm.member_id = c.character_id \
                                                    WHERE fm.faction_id = '%d';", orgID);
                mysql_tquery(MySQL:SQL, q, "Member_ShowList", "d", playerid);
            }

            case 2: {

                //
            }

            case 3: {

                Dialog_Show(playerid, "dialog_factionKick", DIALOG_STYLE_INPUT, ""c_server"Maryland \187; "c_ltorange"Kick Member", 
                                                                                "Unesite SQLID igraca/karaktera kojeg zelite izbaciti iz fakcije", "Unesi", "Odustani");
            }

            case 4: {

                Dialog_Show(playerid, "dialog_fLeaderInvite", DIALOG_STYLE_INPUT, ""c_server"Maryland \187; "c_ltorange"Invite Member", "Unesi ime/id igraca kojeg zelite pozvati u vasu fakciju", "Unesi", "Odustani");
            }

            case 5: {

                Faction_RespawnVehicles( v_FACTION_TYPE:VEHICLE_TYPE_FACTION );
                SendClientMessage(playerid, x_faction, "vehicle-respawn \187; "c_white"Uspjesno ste pokrenuli respawn svih vozila!");
            }
        }
    }

    return (true);
}

Dialog:dialog_fLeaderInvite(playerid, response, listitem, string:inputtext[]) {

    if(response) {

        new targetid;
    
        if(sscanf(inputtext, "u", targetid))
            return Dialog_Show(playerid, "dialog_fLeaderInvite", DIALOG_STYLE_INPUT, ""c_server"Maryland \187; "c_ltorange"Invite Member", "Unesi ime/id igraca kojeg zelite pozvati u vasu fakciju", "Unesi", "Odustani");

        if(!IsPlayerConnected(targetid))
            return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Igrac nije konektovan na server!");
        
        if(targetid == playerid)
            return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Ne mozes ubaciti samog sebe :/...");

        if(targetid == INVALID_PLAYER_ID)
            return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Momak?!");

        if(FactionMember[targetid][factionID] != 0)
            return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Taj igrac je vec clan neke fakcije!");

        if(IsPlayerPoliceMember(playerid))
            return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Taj igrac je vec clan neke fakcije!"); 

        if(faction_InviteID[playerid] != INVALID_PLAYER_ID)
            return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Vec ste poslali poziv nekom igracu!"); 

        if(faction_InviteFID[targetid] != 0)
            return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Tom igracu je vec ponudjen poziv!"); 

        if(!DistanceBetweenPlayers(3.40, playerid, targetid))
            return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Niste u blizini tog igraca!");

        //*

        faction_InviteID[playerid] = targetid;
        faction_InviteID[targetid] = playerid;
        faction_InviteFID[targetid] = FactionMember[playerid][factionID];

        SendClientMessage(playerid, x_server, "maryland \187; "c_white"Poslali ste invite za fakciju igracu %s!", ReturnPlayerName(targetid));

        new sstr[2048];
        format(sstr, sizeof sstr, "%s[%d] vas je pozvao da se priduzite organizaciji.\n\
                                "c_white"Fakcija : "c_server"%s[%d].\n\
                                "c_white"Leader : "c_server"%s[%d].\n\
                                "c_white"Ukoliko zelite prihvatiti poziv pritisnite "c_server"PRIHVATI.", 
                                ReturnPlayerName(playerid), playerid, Faction_ReturnNameByPlayer(playerid), FactionMember[playerid][factionID], ReturnPlayerName(playerid), playerid);

        Dialog_Show(faction_InviteID[playerid], "dialog_factionInvite", DIALOG_STYLE_MSGBOX, "Maryland \187; "c_server"Factions", sstr, ""c_green"PRIHVATI", ""c_lred"ODBIJ");
    }

    return (true);
}

Dialog:dialog_factionKick(playerid, response, listitem, string:inputtext[]) {

    if(response) {

        new target;
        if(sscanf(inputtext, "d", target))
            return Dialog_Show(playerid, "dialog_factionKick", DIALOG_STYLE_INPUT, ""c_server"Maryland \187; "c_ltorange"Kick Member", 
                                                                                "Unesite SQLID igraca/karaktera kojeg zelite izbaciti iz fakcije", "Unesi", "Odustani");
        
        if(isnull(inputtext))
            Dialog_Show(playerid, "dialog_factionKick", DIALOG_STYLE_INPUT, ""c_server"Maryland \187; "c_ltorange"Kick Member", 
                                                                                "Unesite SQLID igraca/karaktera kojeg zelite izbaciti iz fakcije", "Unesi", "Odustani");
        if(!IsNumeric(inputtext))
            Dialog_Show(playerid, "dialog_factionKick", DIALOG_STYLE_INPUT, ""c_server"Maryland \187; "c_ltorange"Kick Member", 
                                                                                "Unesite SQLID igraca/karaktera kojeg zelite izbaciti iz fakcije", "Unesi", "Odustani");

        new q[128];
        mysql_format(SQL, q, sizeof q, "SELECT * FROM `faction_members` WHERE `member_id` = '%d' AND `faction_id` = '%d'", target, FactionMember[playerid][factionID]);
        mysql_tquery(SQL, q, "Faction_CheckMemberKick", "d", playerid);
        
    }

    return (true);

}

forward Faction_CheckMemberKick(playerid);
public Faction_CheckMemberKick(playerid) {

    new rows = cache_num_rows();

    if(!rows)
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Taj igrac nije clan vase fakcije!");

    new xMemberID, xFactionID, xFactionRank;

    cache_get_value_name_int(0, "member_id", xMemberID);
    cache_get_value_name_int(0, "faction_id", xFactionID);
    cache_get_value_name_int(0, "faction_rank", xFactionRank);

    if(xFactionRank >= 3)
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Ne mozete kickovati lidera/co-lidera!");

    new q[128]; 
    mysql_format(SQL, q, sizeof q, "DELETE FROM `faction_members` WHERE `member_id` = '%d'", xMemberID);
    mysql_tquery(SQL, q);

    foreach(new i : Player) {

        if(FactionMember[i][factionID] == xFactionID && FactionMember[i][characterID] == xMemberID) {

            FactionMember[i][factionID] = 0;
            FactionMember[i][characterID] = 0;
            FactionMember[i][factionRank] = 0;
            FactionMember[i][factionRespect] = 0;

            SendClientMessage(i, x_server, "maryland \187; "c_white"Leader %s vas je izbacio iz fakcije!", ReturnPlayerName(playerid));
            break;
        }
    }

    return (true);
}

Dialog:dialog_factionInvite(playerid, response, listitem, string:inputtext[]) {

    if(!response) {

        new target = faction_InviteID[playerid];

        SendClientMessage(target, x_server, "maryland \187; "c_white"%s je odbio vas poziv za pridruzivanje u organizaciju", ReturnPlayerName(playerid));

        faction_InviteID[target] = INVALID_PLAYER_ID;
        faction_InviteID[playerid] = INVALID_PLAYER_ID;
        faction_InviteFID[playerid] = 0;
        return Y_HOOKS_BREAK_RETURN_1;
    }

    new target = faction_InviteID[playerid];

    SendClientMessage(target, x_server, "maryland \187; "c_white"%s je prihvatio vas poziv za pridruzivanje u organizaciju", ReturnPlayerName(playerid));

    FactionMember[playerid][factionID] = faction_InviteFID[playerid];
    FactionMember[playerid][characterID] = GetCharacterSQLID(playerid);
    FactionMember[playerid][factionRank] = 1;
    FactionMember[playerid][factionRespect] = 1;

    new query[128];
    mysql_format(SQL, query, sizeof query, "SELECT count(`member_id`) as `fMembers` FROM `faction_members` WHERE `faction_id` = '%d'", FactionMember[target][factionID]);
    mysql_tquery(SQL, query, "Faction_CheckMemberUpgrade", "d", target);

    new q[260];
    mysql_format(MySQL:SQL, q, sizeof q, "INSERT INTO `faction_members` (`member_id`, `faction_id`, `faction_rank`, `faction_respekt`) \
                                          VALUES('%d', '%d', '1', '1')", 
                                      GetCharacterSQLID(playerid), faction_InviteFID[playerid]);
    mysql_tquery(MySQL:SQL, q);

    //*

    new fID = FactionMember[playerid][factionID];
    new tmp_message[320];

    foreach(new i : iter_Factions) {

        if(fID == FactionInfo[i][factionID]) {
            
            format(tmp_message, sizeof tmp_message, ""c_faction"%s \187; %s[%d] se je uspjesno pridruzio organizaciji.",
            FactionInfo[i][factionName], ReturnPlayerName(playerid), playerid);
            SendClientMessage(playerid, x_faction, "FACTION: Uspjesno ste se pridruzili fakciji (%s)", FactionInfo[i][factionName]);
            break;
        }
    }

    if(QuestData[playerid][questDone][5] == 0) {

        QuestData[playerid][questDone][5] = 1;
        UpdateSqlInt(SQL, "character_quests", "Quest_6", 1, "characterid", GetCharacterSQLID(playerid));
        SendClientMessage(playerid, x_server, "maryland \187; "c_white"Uspjesno ste zavrsili quest : %s", sz_QuestList[5][questName]);
        GivePlayerMoney(playerid, sz_QuestList[5][questAwards][0]);
        GiveCharXP(playerid, sz_QuestList[5][questAwards][1]);
    }

    Faction_SendMessage(fID, tmp_message);

    faction_InviteID[target] = INVALID_PLAYER_ID;
    faction_InviteID[playerid] = INVALID_PLAYER_ID;
    faction_InviteFID[playerid] = 0;

    return 1;
}

Dialog:dialog_createFaction(playerid, response, listitem, string:inputtext[]) {

    if(!response) {

        faction_InProgress[playerid] = false;
        Dialog_Close(playerid);
        SendClientMessage(playerid, x_server, "[FACTION] >> "c_white"Odustali ste od kreiranja grupe!");
        return Y_HOOKS_BREAK_RETURN_1;
    }

    new target;

    if(sscanf(inputtext, "u", target))
        return Dialog_Show(playerid, "dialog_createFaction", DIALOG_STYLE_INPUT, "Faction Invitation", "Unjeli ste krivi ID\nMolimo vas unesite ID osobe sa kojom zelite osnovati grupu!", "Unesi", "Odustani");

    if(!IsPlayerConnected(target))
        return Dialog_Show(playerid, "dialog_createFaction", DIALOG_STYLE_INPUT, "Faction Invitation", "Unjeli ste krivi ID\nMolimo vas unesite ID osobe sa kojom zelite osnovati grupu!", "Unesi", "Odustani");

    if(target == INVALID_PLAYER_ID)
        return Dialog_Show(playerid, "dialog_createFaction", DIALOG_STYLE_INPUT, "Faction Invitation", "Unjeli ste krivi ID\nMolimo vas unesite ID osobe sa kojom zelite osnovati grupu!", "Unesi", "Odustani");

    if(target == playerid)
        return Dialog_Show(playerid, "dialog_createFaction", DIALOG_STYLE_INPUT, "Faction Invitation", "Ne mozete pozvati samog sebe\nMolimo vas unesite ID osobe sa kojom zelite osnovati grupu!", "Unesi", "Odustani");

    if(FactionMember[target][factionID] != 0)
        return Dialog_Show(playerid, "dialog_createFaction", DIALOG_STYLE_INPUT, "Faction Invitation", "Taj igrac je clan neke grupe\nMolimo vas unesite ID osobe sa kojom zelite osnovati grupu!", "Unesi", "Odustani");

    if(!IsPlayerInRangeOfPlayer(playerid, target, 4.0, false, false)) 
        return Dialog_Show(playerid, "dialog_createFaction", DIALOG_STYLE_INPUT, "Faction Invitation", "Ne nalazite se blizu te osobe!\nMolimo vas unesite ID osobe sa kojom zelite osnovati grupu!", "Unesi", "Odustani");

    Dialog_Show(target, "dialog_acceptFaction", DIALOG_STYLE_MSGBOX, "Faction Invitation", "Osoba %s vas je pozvala da osnujete zajednicu grupu.\nUkoliko ste zainteresovani pritisnite gumb {737BE1}'PRIVATI'", "Prihvati", "Odustani", ReturnPlayerName(playerid));

    faction_Invite[target] = playerid;
    faction_SecondBoss[playerid] = target;

    SendClientMessage(playerid, x_server, "[FACTION] >> "c_white"Poslali ste zahtjev igracu "c_server"%s. "c_white"Molimo vas sacekajte na odgovor!", ReturnPlayerName(target));

    return (true);
}


Dialog:dialog_acceptFaction(playerid, response, listitem, string:inputtext[]) {

    if(!response) {

        SendClientMessage(faction_Invite[playerid], x_server, "[FACTION] >> "c_white"Osoba %s je odbila vas poziv!", ReturnPlayerName(playerid));
        faction_InProgress[faction_Invite[playerid]] = false;

        faction_Invite[playerid] = INVALID_PLAYER_ID;
        Dialog_Close(playerid);
        SendClientMessage(playerid, x_server, "[FACTION] >> "c_white"Odbili ste poziv za pridruzivanje u grupu!");

        faction_SecondBoss[faction_Invite[playerid]] = INVALID_PLAYER_ID;

        return Y_HOOKS_BREAK_RETURN_1;
    }

    SendClientMessage(faction_Invite[playerid], x_server, "[FACTION] >> "c_white"Osoba %s je prihvatila vas poziv!", ReturnPlayerName(playerid));
    Dialog_Show(faction_Invite[playerid], "dialog_factionName", DIALOG_STYLE_INPUT, "Faction Managment", "Unesite ime zeljene organizacije!", "Unesi", "Odustani");

    return (true);
}

Dialog:dialog_factionName(playerid, response, listitem, string:inputtext[]) {

    if(!response) {

        faction_InProgress[playerid] = false;
        Dialog_Close(playerid);
        SendClientMessage(playerid, x_server, "[FACTION] >> "c_white"Odustali ste od kreiranja grupe!");
        return Y_HOOKS_BREAK_RETURN_1;
    }    

    new fName[MAX_FACTION_NAME_LEN], fID = Iter_Free(iter_Factions);

    if(sscanf(inputtext, "s[30]", fName))
        return Dialog_Show(playerid, "dialog_factionName", DIALOG_STYLE_LIST, "Faction Managment", "Unesite ime zeljene organizacije!", "Unesi", "Odustani");

    format(fName, sizeof fName, "%s", inputtext);

    FactionInfo[fID][factionName] = fName;
    FactionInfo[fID][factionBoss] = GetCharacterSQLID(playerid);
    FactionInfo[fID][factionRightHand] = PlayerInfo[faction_SecondBoss[playerid]][SQLID];

    FactionInfo[fID][factionType] = FACTION_TYPE_FRIENDS;

    SendClientMessage(playerid, x_server, "[FACTION] >> "c_white"Uspjesno ste osnovali grupu %s sa vasim saradnikom %s", fName, ReturnPlayerName(faction_SecondBoss[playerid]));
    SendClientMessage(faction_SecondBoss[playerid], x_server, "[FACTION] >> "c_white"Uspjesno ste postali saradnik grupe %s!", fName);

    new q[420];

    mysql_format(MySQL:SQL, q, sizeof q, "INSERT INTO `factions` (`factionName`, `factionType`, `factionBoss`, `factionRightHand`) \
                                                 VALUES('%e', '%d', '%d', '%d')",
                                FactionInfo[fID][factionName], FactionInfo[fID][factionType],
                                FactionInfo[fID][factionBoss], FactionInfo[fID][factionRightHand]);
    mysql_tquery(MySQL:SQL, q, "Faction_InsertData", "ddd", fID, faction_SecondBoss[playerid], playerid);

    return (true);
}

// Faction Member Respect Give (Stock for robs etc)

stock Faction_ReturnNameByPlayer(playerid) {

    new str[MAX_FACTION_NAME_LEN];
    foreach(new i : iter_Factions) {

        if(FactionMember[playerid][factionID] == FactionInfo[i][factionID])
        { format(str, sizeof str, "%s", FactionInfo[i][factionName]); break; }
    }

    return str;
}

stock Faction_GiveRespect(playerid, amount)
{
    if(FactionMember[playerid][factionID] == 0) return false;

    FactionMember[playerid][factionRespect] += amount;

    new q[256];
    mysql_format(SQL, q, sizeof q, "UPDATE `faction_members` SET `faction_respekt` = '%d' WHERE `member_id` = '%d'", FactionMember[playerid][factionRespect], playerid);
    mysql_tquery(SQL, q);

    SendClientMessage(playerid, x_server, "faction \187; "c_white"Nagradjeni ste sa %d respekta.", amount);

    return true;
}

stock Faction_IsBunkerConnected(playerid) {

    new fa_id = Faction_ReturnIndexId(playerid);

    if(FactionInfo[fa_id][factionBunker] != 0)
        return (true);

    return false;
}

stock ReturnFactionSQLID(player) 
{
    if(player == INVALID_PLAYER_ID) return -1;
    if(!IsPlayerConnected(player)) return -1;

    if(FactionMember[player][factionID] != 0)
        return FactionMember[player][factionID];

    return -1;
} 


stock Faction_CheckConnectedHouse(faction, playerid) {

    if(FactionMember[playerid][factionID] == FactionInfo[faction][factionID]) {

        if(FactionInfo[faction][factionHouseID] != 0)
            return false;

    }

    return (true);
}

stock Faction_ConnectHouse( faction, playerid) {

    new hID = House_ReturnIndexByPlayer(playerid);

    FactionInfo[faction][factionHouseID] = house_ID[ hID ];

    static tmp_message[248];
    format(tmp_message, sizeof tmp_message, ""c_faction"Faction \187; %s[%d] je povezao kucu SQLID %d sa organizacijom.", ReturnCharacterName(playerid), playerid, house_ID[ hID ]);
    Faction_SendMessage(FactionMember[playerid][factionID], tmp_message);

    new q[128];
    mysql_format(SQL, q, sizeof q, "UPDATE `factions` SET `factionHouseID` = '%d' WHERE `factionID` = '%d'", house_ID[ hID ], FactionMember[playerid][factionID]);
    mysql_tquery(SQL, q);

    return (true);
}

stock IsPlayerFactionLeader(playerid) {

    if(FactionMember[playerid][factionRank] == 4)
        return true;

    return false;
}

stock GetPlayerFactionRank(playerid) 
    return FactionMember[playerid][factionRank];

stock IsPlayerFactionMember(playerid) {

    if(FactionMember[playerid][factionID] != 0)
        return true;

    return false;
}




// Stock for counting members of some org by SIKA 101 PLUS

forward Faction_CheckMemberUpgrade(target);
public Faction_CheckMemberUpgrade(target) {

    new rows = cache_num_rows();
    if(!rows)
        return (true);

    new faction_members;
    cache_get_value_name_int(0, "fMembers", faction_members);

    if(faction_members >= 6 && faction_members <= 10) {

        new fID = FactionMember[target][factionID];
        new tmp_message[320];

        foreach(new i : iter_Factions) {

            if(fID == FactionInfo[i][factionID]) {
                
                format(tmp_message, sizeof tmp_message, ""c_faction"%s \187; Vasa fakcija je unapredjena - GANG.");
                Faction_SendMessage(fID, tmp_message);
                FactionInfo[i][factionType] = FACTION_TYPE_GANG;

                new q[128];
                mysql_format(SQL, q, sizeof q, "UPDATE `factions` SET `factionType` = '%d' WHERE `factionID` = '%d'", FactionInfo[i][factionID], FactionInfo[i][factionID]);
                mysql_tquery(SQL, q);

                break;
            }
        }
        return ~1;
    }

    if(faction_members >= 11) {

        new fID = FactionMember[target][factionID];
        new tmp_message[320];

        foreach(new i : iter_Factions) {

            if(fID == FactionInfo[i][factionID]) {
                
                format(tmp_message, sizeof tmp_message, ""c_faction"%s \187; Vasa fakcija je unapredjena - MAFIA.");
                Faction_SendMessage(fID, tmp_message);
                FactionInfo[i][factionType] = FACTION_TYPE_MAFIA;

                new q[128];
                mysql_format(SQL, q, sizeof q, "UPDATE `factions` SET `factionType` = '%d' WHERE `factionID` = '%d'", FactionInfo[i][factionID], FactionInfo[i][factionID]);
                mysql_tquery(SQL, q);
                break;
            }
        }
        return ~1;
    }

    return 1;
}

stock Faction_CountMembers(fID)
{
    new countQuery[256];

    mysql_format(SQL, countQuery, sizeof countQuery, "SELECT COUNT(`member_id`) AS `member_count` FROM `faction_members` WHERE `faction_id` = '%d'", fID);
    mysql_tquery(SQL, countQuery, "Faction_MemberCountCallback", "d", fID);

    return true;
}

stock Faction_GetGroupType(id) {

    new string[24];

    switch(FactionInfo[id][factionType]) {

        case FACTION_TYPE_UNKNOWN: { string = "Civil"; }
        case FACTION_TYPE_FRIENDS: { string = "Friends"; }
        case FACTION_TYPE_GANG: { string = "Gang"; }
        case FACTION_TYPE_MAFIA: { string = "Mafia"; }
        default: { string = "[Undefined]"; }
    }

    return string;
}

stock Faction_PlayerGroupType(playerid) {
    
    foreach(new i : iter_Factions) {

        if(FactionMember[playerid][factionID] == FactionInfo[i][factionID]) 
            return FactionInfo[i][factionType];
    }
    return FACTION_TYPE_UNKNOWN;

}

stock Faction_SendMessage(faction, const message[]) {

    foreach(new i : Player) {

        if(FactionMember[i][factionID] == faction) {

            SendClientMessage(i, -1, message);
        }
    }

    return (true);
}

stock Faction_ReturnIndexId(playerid) {

    foreach(new i : iter_Factions) {

        if(FactionInfo[i][factionID] == FactionMember[playerid][factionID])
            return i;
    }

    return -1;
}


forward Faction_MemberCountCallback(fID);
public Faction_MemberCountCallback(fID)
{
    if(cache_num_rows() > 0)
    {
        new member_count;
        cache_get_value_name_int(0, "member_count", member_count);

        if(member_count < 5) return printf("Ova organizacija ima manje od 5 clanova. Broj clanova u org %d", member_count);
    }

    return true;
}



/* TODO

Make cmd /orgstats za lidere gde mogu pratiti broj membera etc i kolko im fali do sledeceg upgrade
kad dodju do odredjenog sranja odu na mesto na mapi i idu upgrade. I onda ce im traziti da kupe kucu itd sto sve treba za upgrade.
Namestiti safe money za org i za drugs od org.
Dodato brojanje membera od org i dodato logika za davanje respekta igracu.

*/