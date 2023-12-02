#include <ysilib\YSI_Coding\y_hooks>

#define     MAX_FACTIONS            (400)
#define     MAX_FACTION_NAME_LEN    (30)


enum {

    FACTION_TYPE_UNKNOWN = 0,
    FACTION_TYPE_FRIENDS,
    FACTION_TYPE_GANG,
    FACTION_TYPE_MAFIA
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

new faction_ProhibitedSkins[17] = {

    //      >> [ Grove Street Families ] <<

    105,
    106,
    107,
    269,
    270,
    271,
    86,
    149,

    //      >> [ Los Santos Ballas ] <<

    102,
    103,
    104,

    //      >> [ Los Santos Vagos ] <<

    108,
    109,
    110,

    //      >> [ Varios Los Aztecas ] <<

    114,
    115,
    116
};

enum FACTION_CORE {

    factionID,                              // Faction SQL ID
    factionName[MAX_FACTION_NAME_LEN],      // Faction Name on Create
    factionType,         // Faction Type
    
    factionBoss,                            // Faction leader
    factionRightHand,                       // Faction second leader
    
    Float:factionArea[3],                   // Faction will have their area for cars etc.. If is duo they will get random street cords for their area. When they upgrade prop is area.
    factionInterior,                        // When they got upgrade this is interior of prop
    factionVirtualWorld                     // When they got upgrade this is virtual world of prop
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

        if(FactionInfo[i][factionArea][0] != 0.00) {

            new str_faction[128];
            format(str_faction, sizeof str_faction, ""c_server" » "c_grey"Ovaj kvart je poznat po "c_server" %s « \n» "c_grey"Cesto su vidjeni ovde "c_server"«", FactionInfo[i][factionName] );

            faction_Label[i] = Create3DTextLabel(str_faction, -1, FactionInfo[i][factionArea][0], FactionInfo[i][factionArea][1], FactionInfo[i][factionArea][2], 3.50, 0);
        }

    }

    return 1;
}

forward Faction_InsertData(id, member);
public Faction_InsertData(id, member) {

    FactionInfo[id][factionID] = cache_insert_id();

    Iter_Add(iter_Factions, id);

    FactionMember[member][characterID] = PlayerInfo[member][SQLID];
    FactionMember[member][factionID] = FactionInfo[id][factionID];
    FactionMember[member][factionRank] = 1;
    FactionMember[member][factionRespect] = 1;

    new q[260];

    mysql_format(MySQL:SQL, q, sizeof q, "INSERT INTO `faction_members` (`member_id`, `faction_id`, `faction_rank`, `faction_respekt`) \ 
                                             VALUES('%d', '%d', '1', '1')", 
                                      member, FactionInfo[id][factionID]);
    mysql_tquery(MySQL:SQL, q);

    return 1;
}

forward Member_LoadData(id);
public Member_LoadData(id) {

    new rows = cache_num_rows();
    if(!rows) return false;

    else {

        cache_get_value_name_int(0, "member_id", FactionMember[id][characterID]);
        cache_get_value_name_int(0, "faction_id", FactionMember[id][factionID]);
        cache_get_value_name_int(0, "faction_rank", FactionMember[id][factionRank]);
        cache_get_value_name_int(0, "faction_respekt", FactionMember[id][factionRespect]);
    }
    return 1;
}

forward Member_ShowList(playerid);
public Member_ShowList(playerid) {

    new rows = cache_num_rows();
    if(!rows) return SendClientMessage(playerid, x_green, ">> Nemate clanove!");

    else {

        new dialogStr[120];

        for(new i = 0; i < rows; i++) {

            new charID;
            cache_get_value_name_int(i, "member_id", charID);

            format(dialogStr, sizeof dialogStr, ">> %d | << %d\n", i+1, charID);
        }

        Dialog_Show(playerid, "dialog_noreturn-faction", DIALOG_STYLE_LIST, "Faction - Members", dialogStr, "Ok", "");
    }
    return 1;
}

// -------------------- > Callbacks

hook OnGameModeInit() {

    print("factions/faction.pwn > Dev Progress Loaded.");

    //mysql_tquery(SQL, "SELECT * FROM `factions`", "PreloadFactionData");    > For later.

    ActorsFactionCreate[0] = CreateDynamicActor(208, -775.2356, -1972.8859, 8.7799, 182.1289, 1, 100.0, -1, 3, -1);
    ActorsFactionCreate[1] = CreateDynamicActor(228, -775.9028, -1979.6080, 8.7799, 312.1205, 1, 100.0, -1, 3, -1);
    ActorsFactionCreate[2] = CreateDynamicActor(273, -778.6071, -1977.7972, 8.7799, 271.6165, 1, 100.0, -1, 3, -1);
    ActorsFactionCreate[3] = CreateDynamicActor(294, -777.6349, -1975.9537, 8.7799, 204.2099, 1, 100.0, -1, 3, -1);

    ApplyDynamicActorAnimation(ActorsFactionCreate[2], "ped", "SEAT_idle", 4.1, true, true, true, true, 0);

    ApplyDynamicActorAnimation(ActorsFactionCreate[3], "ped", "SEAT_idle", 4.1, true, true, true, true, 0);

    FactionCreateLabels[0] = CreateDynamic3DTextLabel(""c_server" » "c_grey"Faction Create "c_server"«\n"c_server" » "c_grey"Pritisni 'Y' za kreiranje. "c_server"«", x_white, -776.4226, -1977.0199, 8.7799, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 3, -1);

    new q[120];
    mysql_format(MySQL:SQL, q, sizeof q, "SELECT * FROM `factions`", "Faction_LoadData");

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnCharacterLoaded(playerid) {

    new q[120];

    mysql_format(MySQL:SQL, q, sizeof q, "SELECT * FROM `faction_members` WHERE `member_id` = '%d'",GetCharacterSQLID(playerid));
    mysql_tquery(MySQL:SQL, q, "Member_LoadData", "d",GetCharacterSQLID(playerid));


    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys) {

    if(PRESSED(KEY_NO)) {

        if(IsPlayerInRangeOfPoint(playerid, 3.50, -776.4226, -1977.0199, 8.7799) && !faction_InProgress[playerid]) {

            faction_InProgress[playerid] = true;

            Dialog_Show(playerid, "dialog_createFaction", DIALOG_STYLE_INPUT, "Faction Invitation", "Molimo vas unesite ID osobe sa kojom zelite osnovati grupu!", "Unesi", "Odustani");

        }
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}

YCMD:loadmember(playerid, params[], help) 
{
    new q[120];

    mysql_format(MySQL:SQL, q, sizeof q, "SELECT * FROM `faction_members` WHERE `member_id` = '1'");
    mysql_tquery(MySQL:SQL, q, "Member_LoadData", "d", playerid);

    return 1;
}

YCMD:members(playerid, params[], help) 
{
    
    new q[120];

    new orgID = FactionMember[playerid][factionID];
    new sID = FactionInfo[orgID][factionID];

    mysql_format(MySQL:SQL, q, sizeof q, "SELECT `member_id` FROM `faction_members` WHERE `faction_id` = '%d'", sID);
    mysql_tquery(MySQL:SQL, q, "Member_ShowList", "d", playerid);

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
    FactionInfo[fID][factionBoss] = playerid;
    FactionInfo[fID][factionRightHand] = PlayerInfo[faction_SecondBoss[playerid]][SQLID];

    FactionInfo[fID][factionType] = FACTION_TYPE_FRIENDS;

    SendClientMessage(playerid, x_server, "[FACTION] >> "c_white"Uspjesno ste osnovali grupu %s sa vasim saradnikom %s", fName, ReturnPlayerName(faction_SecondBoss[playerid]));
    SendClientMessage(faction_SecondBoss[playerid], x_server, "[FACTION] >> "c_white"Uspjesno ste postali saradnik grupe %s!", fName);

    new q[420];

    mysql_format(MySQL:SQL, q, sizeof q, "INSERT INTO `factions` (`factionName`, `factionType`, `factionBoss`, `factionRightHand`) \
                                                 VALUES('%e', '%d', '%d', '%d')",
                                FactionInfo[fID][factionName], FactionInfo[fID][factionType],
                                FactionInfo[fID][factionBoss], FactionInfo[fID][factionRightHand]);
    mysql_tquery(MySQL:SQL, q, "Faction_InsertData", "dd", fID, faction_SecondBoss[playerid]);

    new query[260];

    mysql_format(MySQL:SQL, query, sizeof query, "INSERT INTO `faction_members` (`member_id`, `faction_id`, `faction_rank`, `faction_respekt`) \
                                             VALUES('%d', '%d', '7', '1')", 
                                     GetCharacterSQLID(playerid), FactionInfo[fID][factionID]);
    mysql_tquery(MySQL:SQL, query);

    return (true);
}
