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

Dialog:dialog_Commands(const playerid, response, listitem, string:inputtext[]) {

    if(response) {

        switch(listitem) {

            case 0: {

                Dialog_Show(playerid, "_noReturn", DIALOG_STYLE_MSGBOX,""c_server"Maryland \187; "c_white"Komande",
                                                                        ""c_white"/me /do /b /inventory /ceolist /buzz /accept /buybizcenter\n\
                                                                        /burglary /dron /gps /gpsoff /smsad /sms /call /answer /hangup\n\
                                                                        /fuel /fixengine /fullrepair /testplates /tinspect /winter", "Ok", "");
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