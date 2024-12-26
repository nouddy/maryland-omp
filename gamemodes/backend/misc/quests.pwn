/*

* Kategorija 1: Po?etni?ki questovi (Starter Quests)
* "Novi Po?etak"
* "Biti ili ne biti (dostavlja?)"
* "Bankarski Ra?un: Prva Lekcija Biznisa"
* "Papir za Volan"
* "Krov nad Glavom"
* "Taste Kupovine"
* "Osnove Preživljavanja"
* "Prvi Poziv: Ispod Površine"
* "ATM Avantura"
* "Modna Revolucija"

* Kategorija 2: Grad i infrastruktura (City & Services Quests)
* "Šetnja Gradom: Tragovi Prošlosti"
* "Poziv za Heroje"
* "?eli?ne Kandže: Popravka Sudbine"
* "Senka Podzemlja"
* "Moj Prvi Kutak"
* "Bela Svetlost Bolnice"
* "Poslednja Kap Goriva"
* "Osiguraj Sudbinu"
* "Poreznik Te Posmatra"
* "Guma u Ruci"

* Kategorija 3: Kriminalne Avanture (Crime Series)
* "Prvi Krik Motora"
* "Ilegalna Dostava: Mra?nih Tajni"
* "Udar na Tlu: Krv ili ?ast"
* "Talac Kapitalizma: Re? je Oružje"
* "No? Provale: Senka u Tami"
* "Šaputanje Bombe: Glas Pakla"
* "Švercerska Veza"
* "Poslednji Trag Politi?ara"
* "Reket sudbine ulica"
* "Reket Sudbine: Ulica Pri?a"
* "Ilegalna Trka: Guma na Asfaltu"
* "Surova Plja?ka: Zvona Alarma"
* "Napad na Zakon: Za Ili Protiv"
* "Bankarska Opsada: Poslednji Ugovor"
* "Oružje u Senkama: Isporu?i ili Pogini"
* "Crno Tržište: Iza Zavese"

*/

#include <ysilib\YSI_Coding\y_hooks>

enum E_QUEST_DATA {

    questID,
    questName[32],
    questDescription[248],
    questAwards[2],
    questHints[128]
}

enum E_PLAYER_QUEST_DATA {

    characterID,
    questDone[7]
}

new QuestData[MAX_PLAYERS][E_PLAYER_QUEST_DATA];

new jason_InProgress[MAX_PLAYERS];

new const sz_QuestList[][E_QUEST_DATA] = {

    { 1, "Novi Pocetak", "Pronadji Jason-a, upoznaj se sa njim i odkrij novosti Marylanda!", { 350, 150 }, "Jedna od najpoznatijih osoba Marylanda [ LOCATION : Market Station]"},
    { 2, "Biti ili ne biti", "Zaposli se kao mehanicar i zaradi svoj prvi novac!", {500, 240}, "Najisplaceniji, i user-friendly posao za nove igrace [ LOCATION : LS Customs]"},
    { 3, "Prva lekcija biznisa", "Otidji do banke i otvori bankovni racun koji ce ti pomoci pri daljnjim potrebama!", {120, 50}, "Jedna izmedju najbitnijih institucija [ LOCATION : H4RBOR Bank ]" },
    { 4, "Papir za Volan", "Otidji do centra za dozvole i polozi vozacki ispit [TIP B]", {0, 150}, "Centar za dozvole [ LOCATION : West Los Santos ]"},
    { 5, "Osnove Preživljavanja", "Otidji do najblizeg 7Elevn-a i kupi item po zelji!", {50, 50}, "/gps => 7Eleven"},
    { 6, "Prvi Poziv: Ispod Površine", "Postani clan ilegalne fakcije", {150, 230}, "Snadjite se sami ;)" },
    { 7, "Modna Revolucija", "Odi do najblizeg butika i odaberi svoj novi stil", {50, 120}, "/gps => Butique"}
};

static jasonActor;

forward quest_UpdateJasonInteraction(playerid, type);
public quest_UpdateJasonInteraction(playerid, type) {

    switch(type) {
        
        case 1: {

            SendClientMessage(playerid, x_forestgreen, "Jason : Izvoli nesto novca, mozda nije dovoljno ali ce ti pomoci.");
            SetTimerEx("quest_UpdateJasonInteraction", 3500, false, "dd", playerid, 2);
            ApplyActorAnimation(jasonActor, !"MISC", !"SEAT_LR", 4.1, false, false, false, true, 0);
        }

        case 2: {

            SendClientMessage(playerid, x_forestgreen, "Jason : Najbolje je da se drzis legalne strane Marylanda, ukoliko ti zatreba pomoc, znas gdje ces me pronaci.");
            ApplyActorAnimation(jasonActor, !"PED", !"SEAT_down", 4.1, false, false, false, true, 0);

            QuestData[playerid][questDone][0] = 1;
            UpdateSqlInt(SQL, "character_quests", "Quest_1", 1, "characterid", GetCharacterSQLID(playerid));
            SendClientMessage(playerid, x_server, "maryland \187; "c_white"Uspjesno ste zavrsili quest : %s", sz_QuestList[0][questName]);
            GivePlayerMoney(playerid, sz_QuestList[0][questAwards][0]);
            GiveCharXP(playerid, sz_QuestList[0][questAwards][1]);
        }
    }
    return (true);
}

forward mysql_LoadCharacterQuests(playerid);
public mysql_LoadCharacterQuests(playerid) {

    new rows = cache_num_rows();

    if(!rows) {

        for(new i = 0; i < 7; i++) {

            QuestData[playerid][questDone][i] = 0;
        }

        new q[128];
        mysql_format(SQL, q, sizeof q, "INSERT INTO `character_quests` (`characterid`) VALUES ('%d')", GetCharacterSQLID(playerid));
        mysql_tquery(SQL, q);
        return 1;
    }

    else {

        static str[44];

        for(new i = 0; i < 7; i++) {

            format(str, sizeof str, "Quest_%d", i+1);
            cache_get_value_name_int(0, str, QuestData[playerid][questDone][i]);
        }
    }


    return (true);
}

hook OnGameModeInit() {

    jasonActor = CreateActor(101, 809.7028,-1342.9017,13.5402,274.5583);
    ApplyActorAnimation(jasonActor, !"PED", !"SEAT_down", 4.1, false, false, false, true, 0);

    CreateCustomMarker(""c_server"[ Jason ]\n"c_white"[ N ]", 810.6173,-1342.9711,13.5386, -1, -1, 50.0);
    //810.6173,-1342.9711,13.5386

    return (true);
}

hook OnCharacterLoaded(playerid) {

    new q[248];
    mysql_format(SQL, q, sizeof q, "SELECT * FROM `character_quests` WHERE `characterid` = '%d'", GetCharacterSQLID(playerid));
    mysql_tquery(SQL, q, "mysql_LoadCharacterQuests", "d", playerid);

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys) {

    if(PRESSED(KEY_NO)) {

        if(IsPlayerInRangeOfPoint(playerid, 1.7, 810.6173,-1342.9711,13.5386)) {

            if(jason_InProgress[playerid])
                return (true);

            if(QuestData[playerid][questDone][0] == 1)
                return (true);
            
            jason_InProgress[playerid] = true;

            SendClientMessage(playerid, x_forestgreen, "Jason : Dobrodosao u Maryland, vidim da si novi i nece ti biti tako lako na pocetku.");
            SetTimerEx("quest_UpdateJasonInteraction", 3500, false, "dd", playerid, 1);
            ApplyActorAnimation(jasonActor, !"MISC", !"SEAT_LR", 4.1, false, false, false, true, 0);
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

YCMD:quests(playerid, params[], help) {

    new fmt_dlg[2048], fmt_str[288], answ_str[7][32];
    
    for(new x = 0; x < 7; x++) {

        if(QuestData[playerid][questDone][x] == 1) 
            format(answ_str[x], sizeof(answ_str[]), ""c_ltorange"Zavrseno"); 
        else
            format(answ_str[x], sizeof(answ_str[]), ""c_forestgreen"Dostupno");
    }

    for(new i = 0; i < sizeof sz_QuestList; i++) {

        format(fmt_str, sizeof fmt_str, ""c_server"#%d \187; \t"c_ltorange" %s \t%s\n", sz_QuestList[i][questID], sz_QuestList[i][questName], answ_str[i]);
        strcat(fmt_dlg, fmt_str);
    }

    Dialog_Show(playerid, "dialog_playerQuests", DIALOG_STYLE_TABLIST, "Maryland \187; "c_server"Quests", fmt_dlg, "Odaberi", "Odustani");

    return (true);
}

Dialog:dialog_playerQuests(const playerid, response, listitem, string:inputtext[]) {

    if(response) {

        new dlgStr[2048];

        format(dlgStr, sizeof dlgStr, ""c_forestgreen"%s\n\nNagrada : "c_ltorange"%d$ | %dxp\n\n"c_forestgreen"Hint : "c_ltorange"%s", sz_QuestList[listitem][questDescription], 
                                                                                                                                    sz_QuestList[listitem][questAwards][0], sz_QuestList[listitem][questAwards][1],
                                                                                                                                    sz_QuestList[listitem][questHints]);
        Dialog_Show(playerid, "dialog_chosenQuest", DIALOG_STYLE_MSGBOX, "Quest", dlgStr, "Ok", "<<");
    }
    return (true);
}

Dialog:dialog_chosenQuest(const playerid, response, listitem, string:inputtext[]) {

    if(!response) {

        new fmt_dlg[2048], fmt_str[288], answ_str[7][32];
    
        for(new x = 0; x < 7; x++) {

            if(QuestData[playerid][questDone][x] == 1) 
                format(answ_str[x], sizeof(answ_str[]), ""c_ltorange"Zavrseno"); 
            else
                format(answ_str[x], sizeof(answ_str[]), ""c_forestgreen"Dostupno");
        }

        for(new i = 0; i < sizeof sz_QuestList; i++) {

            format(fmt_str, sizeof fmt_str, ""c_server"#%d \187; \t"c_ltorange" %s \t%s\n", sz_QuestList[i][questID], sz_QuestList[i][questName], answ_str[i]);
            strcat(fmt_dlg, fmt_str);
        }

        Dialog_Show(playerid, "dialog_playerQuests", DIALOG_STYLE_TABLIST, "Maryland \187; "c_server"Quests", fmt_dlg, "Odaberi", "Odustani");
    }

    return (true);
}