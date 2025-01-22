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
*  @File           chat_settings.pwn
*  @Module         misc
*/

#include <ysilib\YSI_Coding\y_hooks>

enum e_PLAYER_SETTINGS {

    bool:gLeaderChat,
    bool:gNewbieChat,
    bool:gVIPChat
}

new playerSettings[MAX_PLAYERS][e_PLAYER_SETTINGS];

forward mysql_LoadPlayerSettings(playerid);
public mysql_LoadPlayerSettings(playerid) {

    new rows = cache_num_rows();
    if(!rows) return (true);

    cache_get_value_name_bool(0, "leaderChat", playerSettings[playerid][gLeaderChat]);
    cache_get_value_name_bool(0, "newbieChat", playerSettings[playerid][gNewbieChat]);
    cache_get_value_name_bool(0, "vipChat", playerSettings[playerid][gVIPChat]);

    return (true);
}

hook OnCharacterLoaded(playerid) {

    new q[128];
    mysql_format(SQL, q, sizeof q, "SELECT * FROM `player_settings` WHERE `character_id` = '%d'", GetCharacterSQLID(playerid));
    mysql_tquery(SQL, q, "mysql_LoadPlayerSettings", "d", playerid);

    return Y_HOOKS_CONTINUE_RETURN_1;
}

stock FormatSettingsString(bool:option) {

    static str[12];

    if(option == true)
        str = "{DAA520}ON";
    else   
        str = "{FF00FF}OFF";

    return str;
}

YCMD:tog(playerid, params[], help) {


    static dlgStr[2884];
    
    format(dlgStr, sizeof dlgStr, "\
                                  "c_white"Leader Chat \187; %s\n\
                                  "c_white"Newbie Chat \187; %s\n\
                                  "c_white"VIP Chat \187; %s",
                                  FormatSettingsString(playerSettings[playerid][gLeaderChat]),
                                  FormatSettingsString(playerSettings[playerid][gNewbieChat]),
                                  FormatSettingsString(playerSettings[playerid][gVIPChat]));

    Dialog_Show(playerid, "dialog_chatSettings", DIALOG_STYLE_LIST, "Maryland - Podesavanja", dlgStr, "Odaberi", "Odustani");

    return Y_HOOKS_CONTINUE_RETURN_1;
}

Dialog:dialog_chatSettings(playerid, response, listitem, string: inputtext[]) {
    
    if(response) {

        switch(listitem) {

            case 0: {

                if(playerSettings[playerid][gLeaderChat]) {
                    
                    playerSettings[playerid][gLeaderChat] = false;
                    SendServerMessage(playerid, "Iskljucili ste leader chat.");

                    new q[248];
                    mysql_format(SQL, q, sizeof q, "UPDATE `player_settings` SET `leaderChat` = 'false' WHERE `character_id` = '%d'", GetCharacterSQLID(playerid));
                    mysql_tquery(SQL, q);

                    return Y_HOOKS_CONTINUE_RETURN_1;
                }

                else if(!playerSettings[playerid][gLeaderChat]) {
                    
                    playerSettings[playerid][gLeaderChat] = true;
                    SendServerMessage(playerid, "Ukljucili ste leader chat.");

                    new q[248];
                    mysql_format(SQL, q, sizeof q, "UPDATE `player_settings` SET `leaderChat` = 'true' WHERE `character_id` = '%d'", GetCharacterSQLID(playerid));
                    mysql_tquery(SQL, q);

                    return Y_HOOKS_CONTINUE_RETURN_1;
                }
            }

            case 1: {

                if(playerSettings[playerid][gNewbieChat]) {
                    
                    playerSettings[playerid][gNewbieChat] = false;
                    SendServerMessage(playerid, "Iskljucili ste newbie chat.");

                    new q[248];
                    mysql_format(SQL, q, sizeof q, "UPDATE `player_settings` SET `newbieChat` = 'false' WHERE `character_id` = '%d'", GetCharacterSQLID(playerid));
                    mysql_tquery(SQL, q);

                    return Y_HOOKS_CONTINUE_RETURN_1;
                }

                else if(!playerSettings[playerid][gNewbieChat]) {
                    
                    playerSettings[playerid][gNewbieChat] = true;
                    SendServerMessage(playerid, "Ukljucili ste newbie chat.");

                    new q[248];
                    mysql_format(SQL, q, sizeof q, "UPDATE `player_settings` SET `newbieChat` = 'true' WHERE `character_id` = '%d'", GetCharacterSQLID(playerid));
                    mysql_tquery(SQL, q);

                    return Y_HOOKS_CONTINUE_RETURN_1;
                }
            }

            case 2: {

                if(playerSettings[playerid][gVIPChat]) {
                    
                    playerSettings[playerid][gVIPChat] = false;
                    SendServerMessage(playerid, "Iskljucili ste VIP chat.");

                    new q[248];
                    mysql_format(SQL, q, sizeof q, "UPDATE `player_settings` SET `vipChat` = 'false' WHERE `character_id` = '%d'", GetCharacterSQLID(playerid));
                    mysql_tquery(SQL, q);
                    return Y_HOOKS_CONTINUE_RETURN_1;
                }

                else if(!playerSettings[playerid][gVIPChat]) {
                    
                    playerSettings[playerid][gVIPChat] = true;
                    SendServerMessage(playerid, "Ukljucili ste VIP chat.");

                    new q[248];
                    mysql_format(SQL, q, sizeof q, "UPDATE `player_settings` SET `vipChat` = 'true' WHERE `character_id` = '%d'", GetCharacterSQLID(playerid));
                    mysql_tquery(SQL, q);

                    return Y_HOOKS_CONTINUE_RETURN_1;
                }
            }
        }
    }

    return 1;
}
