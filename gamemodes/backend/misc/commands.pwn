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
*  @Author         Nodi
*  @Date           1st November 2024
*  @Weburl         weburl
*  @Project        maryland_project
*
*  @File           commands.pwn
*  @Module         misc
*/

#include <ysilib\YSI_Coding\y_hooks>

YCMD:help(playerid, params[], help) = komande;
YCMD:commands(playerid, params[], help) = komande;
YCMD:komande(playerid, params[], help) {

    Dialog_Show(playerid, "dialog_Commands", DIALOG_STYLE_LIST, ""c_server"Maryland \187; "c_white"Komande", 
                                                                ""c_server"#1 \187; "c_white"Uopsteno\n\
                                                                "c_server"#2 \187; "c_white"Organizacija\n\
                                                                "c_server"#3 \187; "c_white"Staff\n\
                                                                "c_server"#4 \187; "c_white"VIP", 
                                                                "Odbaeri", "Odustani");
    return 1;
}

YCMD:stats(playerid, params[], help) 
{

    new fmt_dlg[2048];
    format(fmt_dlg, sizeof fmt_dlg, 
                                ""c_job"Account Name : "c_white"%s\n\
                                "c_job"Chracter Name : "c_white"%s\n\
                                "c_job"Score : "c_white"%d\n\
                                "c_job"Exp. : "c_white"%d/%d\n\n\
                                "c_job"Faction Name : "c_white"%s\n\
                                "c_job"Faction ID : "c_white"%d\n\
                                "c_job"Faction Rank : "c_white"%d\n",
                                ReturnPlayerName(playerid), CharacterInfo[playerid][Name], GetPlayerScore(playerid), CharacterInfo[playerid][XP], CharacterInfo[playerid][NeedXP], Faction_ReturnNameByPlayer(playerid), FactionMember[playerid][factionID],
                                FactionMember[playerid][factionRank]);
    Dialog_Show(playerid, "_noReturn", DIALOG_STYLE_MSGBOX, "Maryland \187; "c_job"Statistika", fmt_dlg, "OK", "");
    return 1;
}

YCMD:n(playerid, params[], help) {

    new msg[248];
    if(sscanf(params, "s[248]", msg))
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"/g [TEXT]");

    if(!playerSettings[playerid][gNewbieChat])
        return SendServerMessage(playerid, "Islkljucen vam je newbie chat, "c_ltorange"/tog");

    foreach(new i : Player) {

        if(playerSettings[playerid][gNewbieChat]) {

            SendClientMessage(i, x_ltorange, "(( NEWBIE %s[%d] : %s. ))", ReturnPlayerName(playerid), playerid, msg);
        }
    }

    return (true);
}

Dialog:dialog_Commands(const playerid, response, listitem, string:inputtext[]) {

    if(response) {

        switch(listitem) {

            case 0: {

                Dialog_Show(playerid, "_noReturn", DIALOG_STYLE_MSGBOX,""c_server"Maryland \187; "c_white"Komande",
                                                                        ""c_white"/me /do /b /inventory /ceolist /buzz /accept /buybizcenter\n\
                                                                        /burglary /dron /gps /gpsoff /smsad /sms /call /answer /hangup\n\
                                                                        /fuel /fixengine /fullrepair /testplates /tinspect /winter /stats\n\
                                                                        /dropgun, /pickupgun /kuca /v /firma", "Ok", "");
            }

            case 1: {

                if(PoliceMember[playerid][policeID] > 0) {

                    Dialog_Show(playerid, "_noReturn", DIALOG_STYLE_MSGBOX,""c_server"Maryland \187; "c_white"Police",
                                                                        ""c_white"/cuff /tie /pu /su /bork /r /izbaci", "Ok", "");
                }

                if(FactionMember[playerid][factionID] > 0) {

                    Dialog_Show(playerid, "_noReturn", DIALOG_STYLE_MSGBOX, ""c_server"Maryland \187; "c_white"Faction",
                                                                            "/f /faction", "Ok", "");
                }
            }

            case 2: {

                if(PlayerInfo[playerid][Staff] > 0) {

                    Dialog_Show(playerid, "_noReturn", DIALOG_STYLE_MSGBOX,""c_server"Maryland \187; "c_white"Staff",
                                                                        ""c_white"/sduty /sc /sveh /port /goto /cc /gethere\n\
                                                                        /jetpack /nitro /fv /setskin /xgoto /setint /setvw\n\
                                                                        /aclearwl /givegun /restart /slap /sm /freeze /tod", "Ok", "");
                }
            }

            case 3: {

                Dialog_Show(playerid, "_noReturn", DIALOG_STYLE_MSGBOX, ""c_server"Maryland \187; "c_white"Staff", 
                                                                        ""c_ltorange"VIP BRONZE : "c_white"/vport, /vtod, /vweather, /g, /vpm, /vfv "c_ltorange"(3 min cooldown)\n\
                                                                        "c_ltorange"VIP SILVER : "c_white"/vport, /vtod, /vweather, /g, /vpm, /vfv "c_ltorange"(2 min cooldown), "c_white"/vtp "c_ltorange"(uz zahtjev igracu - 60 sekundi cooldown)   DODATNO: Armor 25%% pri spawnu.\n\
                                                                        "c_ltorange"VIP GOLD : "c_white"/vport, /vtod, /vweather, /g, /vfv "c_ltorange"(1 min cooldown), "c_white"/vtp "c_ltorange"(uz zahtjev igracu - 30 sekundi cooldown), "c_white"/vpm, /vgetveh "c_ltorange"(5 min cooldown), "c_white"/vipmenu   "c_ltorange"DODATNO: Armor 75%% pri spawnu.\n\
                                                                        "c_ltorange"VIP PLATINUM : "c_white"/vport, /vtod, /vweather, /g, /vfv "c_ltorange"(30 sekundi cooldown), "c_white"/vtp "c_ltorange"(uz zahtjev igracu - 15 sekundi cooldown), /vgethere "c_ltorange"(30 sekundi cooldown) "c_white"/vpm, /vgetveh "c_ltorange"(3 min cooldown), \n\
                                                                        VIP PLATINUM :"c_white"/vipmenu, /vipcolor, /vtransfer, /vgoto "c_ltorange"(1 - Kuca, 2 - Firma, 3 - Vozilo), "c_white"/viprac, /vipfill "c_ltorange"(1 sat cooldown), "c_white"/vipskin   "c_ltorange"\nDODATNO: Armor 100%% pri spawnu, zastita od /steal, zastita od radara, 5%% bonusa na svaku pljacku.", 
                "Ok", "");
            }
        }
    }

}

YCMD:pay(playerid, params[], help) {

    new targetid, Float:money;

    if(sscanf(params, "uf", targetid, money))
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"/pay <id/ime> <kolicina>");

    if(money <= 0.00 || money > 5000.00)
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Kolicina novca ne moze biti manja od 0.00 ili veca od 5000.00");

    if(GetPlayerMoney(playerid) < money)
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Nemate dovoljno novca!");

    if(targetid == INVALID_PLAYER_ID) return (true);

    if(!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, x_server, "maryalnd \187; "c_white"Taj igrac nije konektovan na server!");

    if(!DistanceBetweenPlayers(3.40, playerid, targetid))
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Niste u blizini tog igraca!");

    ApplyAnimation(playerid, !"DEALER", !"shop_pay", 4.1, false, false, false, false, 0);

    GivePlayerMoney(playerid, -money);
    GivePlayerMoney(targetid, money);

    SendClientMessage(playerid, x_server, "maryland \187; "c_white"Dali ste igracu %s %.2f$", ReturnCharacterName(targetid), money);
    SendClientMessage(targetid, x_server, "maryland \187; "c_white"Igrac %s vam je dao %.2f$", ReturnCharacterName(playerid), money);

    return (true);
}

YCMD:spa(playerid, params[], help) {

    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);

    return (true);
}

new g_TodayPlayerRecord = 0;
new g_LastRecordCheck = 0;
new g_ServerStartTime;

stock UpdatePlayerRecord()
{
    new query[256];
    new year, month, day;
    getdate(year, month, day);
    
    new today = year * 10000 + month * 100 + day;
    if(g_LastRecordCheck == today) return 0;
    
    g_LastRecordCheck = today;
    
    mysql_format(SQL, query, sizeof(query), 
        "INSERT INTO daily_records (record_date, player_count) \
        VALUES (CURDATE(), %d) \
        ON DUPLICATE KEY UPDATE player_count = GREATEST(player_count, %d)",
        g_TodayPlayerRecord, g_TodayPlayerRecord
    );
    mysql_tquery(SQL, query);
    
    return 1;
}

hook OnPlayerConnect(playerid)
{
    new connected = Iter_Count(Player);
    if(connected > g_TodayPlayerRecord)
    {
        g_TodayPlayerRecord = connected;
        UpdatePlayerRecord();
    }
    return 1;
}

hook OnGameModeInit()
{
    mysql_tquery(SQL, 
        "CREATE TABLE IF NOT EXISTS daily_records (\
            record_date DATE PRIMARY KEY,\
            player_count INT NOT NULL\
        )"
    );
    g_TodayPlayerRecord = 0;
    g_LastRecordCheck = 0;
    g_ServerStartTime = gettime();
    return 1;
}

YCMD:dnevnirekord(playerid, params[], help)
{
    if(help)
    {
        notification.Show(playerid, "HELP", "Prikazuje dnevne rekorde igraca", "+", BOXCOLOR_BLUE);
        return 1;
    }

    new query[512];
    mysql_format(SQL, query, sizeof(query), 
        "SELECT \
            DATE_FORMAT(record_date, '%%d/%%m/%%Y') as formatted_date, \
            player_count, \
            CASE \
                WHEN record_date = CURDATE() THEN 1 \
                ELSE 0 \
            END as is_today \
        FROM daily_records \
        WHERE record_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) \
        ORDER BY record_date DESC"
    );
    mysql_tquery(SQL, query, "OnDailyRecordShow", "i", playerid);
    return 1;
}

forward OnDailyRecordShow(playerid);
public OnDailyRecordShow(playerid)
{
    new string[512] = "Dnevni rekordi (zadnjih 7 dana):\n\n";
    new date[16], players, is_today;
    new rows = cache_num_rows();

    if(rows == 0)
    {
        strcat(string, "Nema zabelezenjih rekorda.");
    }
    else
    {
        for(new i = 0; i < rows; i++)
        {
            cache_get_value_name(i, "formatted_date", date, sizeof(date));
            cache_get_value_name_int(i, "player_count", players);
            cache_get_value_name_int(i, "is_today", is_today);

            if(is_today)
            {
                if(g_TodayPlayerRecord > players)
                    players = g_TodayPlayerRecord;
            }

            format(string, sizeof(string), "%s%s: %d igraca\n", 
                string, date, players);
        }
    }

    Dialog_Show(playerid, "DIALOG_DAILY_RECORD", DIALOG_STYLE_MSGBOX, 
        "Dnevni Rekordi", string, "Zatvori", "");
    return 1;
}

YCMD:uptime(playerid, params[], help)
{
    if(help)
    {
        notification.Show(playerid, "HELP", "Prikazuje koliko je server online", "+", BOXCOLOR_BLUE);
        return 1;
    }

    new current_time = gettime();
    new uptime = current_time - g_ServerStartTime;
    
    new days = uptime / 86400;
    new hours = (uptime % 86400) / 3600;
    new minutes = (uptime % 3600) / 60;
    new seconds = uptime % 60;
    
    new string[128];
    format(string, sizeof(string), "Server Uptime: %d dana, %d sati, %d minuta, %d sekundi", 
        days, hours, minutes, seconds);
    
    SendClientMessage(playerid, -1, string);
    return 1;
}

YCMD:ts(playerid, params[], help) = teamspeak;
YCMD:teamspeak(playerid, params[], help)
{
    if(help)
    {
        notification.Show(playerid, "HELP", "Prikazuje TeamSpeak IP adresu servera", "+", BOXCOLOR_BLUE);
        return 1;
    }
    
    SendClientMessage(playerid, x_server, "maryland \187; "c_white"TeamSpeak IP: maryland");
    return 1;
}

YCMD:forum(playerid, params[], help)
{
    if(help)
    {
        notification.Show(playerid, "HELP", "Prikazuje forum adresu servera", "+", BOXCOLOR_BLUE);
        return 1;
    }
    
    SendClientMessage(playerid, x_server, "maryland \187; "c_white"Forum: https://forum.maryland-ogc.com");
    return 1;
}