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

#define MAX_PORT_NAME_LEN       (64)
#define MAX_PORTS               (50)

enum PORT_TYPE {

    PORT_TYPE_MAIN,
    PORT_TYPE_JOB,
    PORT_TYPE_FACTIONS
}

enum e_PORT_DATA {

    portID,
    portName[MAX_PORT_NAME_LEN],
    portType,
    Float:portPosition[3]
}

new PortInfo[MAX_PORTS][e_PORT_DATA],
    Iterator:iter_Ports<MAX_PORTS>;

new tmp_portID[MAX_PLAYERS],
    tmp_portName[MAX_PLAYERS][MAX_PORT_NAME_LEN],
    chosen_PortID[MAX_PLAYERS];

forward mysql_LoadPortData(playerid);
public mysql_LoadPortData(playerid) {

    new rows = cache_num_rows();

    for(new j = 0; j < rows; j++) {

        cache_get_value_name_int(j, "ID", PortInfo[j][portID]);
        cache_get_value_name(j, "Name", PortInfo[j][portName], MAX_PORT_NAME_LEN);
        cache_get_value_name_int(j, "Type", PortInfo[j][portType]);

        cache_get_value_name_float(j, "posX", PortInfo[j][portPosition][0]);
        cache_get_value_name_float(j, "posY", PortInfo[j][portPosition][1]);
        cache_get_value_name_float(j, "posZ", PortInfo[j][portPosition][2]);

        Iter_Add(iter_Ports, j);
    }

    return (true);
}

forward mysql_ChosePort(playerid);
public mysql_ChosePort(playerid) {

    new rows = cache_num_rows();

    if(rows) {

        new _dialogStr[1945];
        new stringicc[256];

        for(new i = 0; i < rows; i++) {

            new pName[MAX_PORT_NAME_LEN];

            cache_get_value_name(i, "Name", pName, MAX_PORT_NAME_LEN);

            format(stringicc, sizeof stringicc, ""c_server"%d \187; "c_white"%s\n", i+1, pName);
            strcat(_dialogStr, stringicc);

            cache_get_value_name_float(i, "posX", PortInfo[i][portPosition][0]);
            cache_get_value_name_float(i, "posY", PortInfo[i][portPosition][1]);
            cache_get_value_name_float(i, "posZ", PortInfo[i][portPosition][2]);

        }

        Dialog_Show(playerid, "dialog_ChosePort", DIALOG_STYLE_LIST, ""c_server"Maryland \187; "c_white"Port", _dialogStr, "Odaberi", "Odustani");
    }

    return true;
}

forward mysql_InsertPort(idx);
public mysql_InsertPort(idx) {

    PortInfo[idx][portID] = cache_insert_id();
    Iter_Add(iter_Ports, idx);

    return true;
}

hook OnGameModeInit() {

    mysql_tquery(SQL, "SELECT * FROM `ports`", "mysql_LoadPortData");

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerConnect(playerid) {

    tmp_portID[playerid] = -1;
    tmp_portName[playerid] = "";
    chosen_PortID[playerid] = -1;
    return (true);
}

YCMD:vport(playerid, params[], help) = port;
YCMD:port(playerid, params[], help) 
{

    new xVIP = GetPlayerVIPLevel(playerid);
    
    if(xVIP == VIP_BRONZE)
        return Dialog_Show(playerid, "dialog_aPort", DIALOG_STYLE_LIST, "Maryland - VIP Port", "1 - Glavno", "Odaberi", "Odustani");
    
    if(xVIP == VIP_SILVER)
        return Dialog_Show(playerid, "dialog_aPort", DIALOG_STYLE_LIST, "Maryland - VIP Port", "1 - Glavno\n2 - Poslovi", "Odaberi", "Odustani");
    
    if(xVIP >= VIP_GOLD)
        return Dialog_Show(playerid, "dialog_aPort", DIALOG_STYLE_LIST, "Maryland - VIP Port", "1 - Glavno\n2 - Poslovi\n3 - Organizacije", "Odaberi", "Odustani");

    if(GetPlayerStaffLevel(playerid) >= e_ASSISTANT)
        return Dialog_Show(playerid, "dialog_aPort", DIALOG_STYLE_LIST, "Maryland - Port", "1 - Glavno\n2 - Poslovi\n3 - Organizacije", "Odaberi", "Odustani");

    SendServerMessage(playerid, "Niste u mogucnosti koristiti ovu komandu!");

    return 1;
}

Dialog:dialog_aPort(const playerid, response, listitem, string:inputtext[]) {

    if(response) {

        new q[248];

        mysql_format(SQL, q, sizeof q, "SELECT * FROM ports WHERE `Type` = '%d'", listitem+1);
        mysql_tquery(SQL, q, "mysql_ChosePort", "d", playerid);
    }

    return (true);
}

Dialog:dialog_ChosePort(const playerid, response, listitem, string:inputtext[]) {

    if(response) {

        if(IsPlayerInAnyVehicle(playerid)) {

            SendClientMessage(playerid, -1, "DEBUG: ALOOO U VOZILU SAM");
            SendClientMessage(playerid, -1, "DEBUG: VEHICLE ID : %d", GetPlayerVehicleID(playerid));
            // SetPlayerCompensatedPos(playerid, PortInfo[listitem][portPosition][0], PortInfo[listitem][portPosition][1], PortInfo[listitem][portPosition][2], 0, 0, 1000);
            SetVehiclePos(GetPlayerVehicleID(playerid), PortInfo[listitem][portPosition][0], PortInfo[listitem][portPosition][1], PortInfo[listitem][portPosition][2]);
            PutPlayerInVehicle(playerid, GetPlayerVehicleID(playerid), 0);
            return Y_HOOKS_BREAK_RETURN_1;
        }

        SetPlayerCompensatedPos(playerid, PortInfo[listitem][portPosition][0], PortInfo[listitem][portPosition][1], PortInfo[listitem][portPosition][2], 0, 0, 1000);
    }

    return (true);
}