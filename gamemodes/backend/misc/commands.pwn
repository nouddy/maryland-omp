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
*  @File           medical.pwn
*  @Module         misc
*/

#include <ysilib\YSI_Coding\y_hooks>

YCMD:commands(playerid, params[], help) = komande;
YCMD:komande(playerid, params[], help) {

    Dialog_Show(playerid, "dialog_Commands", DIALOG_STYLE_LIST, ""c_server"Maryland \187; "c_white"Komande", 
                                                                ""c_server"#1 \187; "c_white"Uopsteno\n\
                                                                "c_server"#2 \187; "c_white"Organizacija\n\
                                                                "c_server"#3 \187; "c_white"Staff", 
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

YCMD:g(playerid, params[], help) {

    new msg[248];
    if(sscanf(params, "s[248]", msg))
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"/g [TEXT]");

    SendClientMessageToAll(x_ltorange, "(( %s[%d] : %s. ))", ReturnPlayerName(playerid), playerid, msg);

    return (true);
}

Dialog:dialog_Commands(const playerid, response, listitem, string:inputtext[]) {

    if(response) {

        switch(listitem) {

            case 0: {

                Dialog_Show(playerid, "_noReturn", DIALOG_STYLE_MSGBOX,""c_server"Maryland \187; "c_white"Komande",
                                                                        ""c_white"/me /do /b /inventory /ceolist /buzz /accept /buybizcenter\n\
                                                                        /burglary /dron /gps /gpsoff /smsad /sms /call /answer /hangup\n\
                                                                        /fuel /fixengine /fullrepair /testplates /tinspect /winter /stats", "Ok", "");
            }

            case 1: {

                if(PoliceMember[playerid][policeID] > 0) {

                    Dialog_Show(playerid, "_noReturn", DIALOG_STYLE_MSGBOX,""c_server"Maryland \187; "c_white"Police",
                                                                        ""c_white"/cuff /tie /pu /su /bork", "Ok", "");
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
        }
    }

}

YCMD:spa(playerid, params[], help) {

    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);

    return (true);
}