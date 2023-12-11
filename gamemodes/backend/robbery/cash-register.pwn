#include <ysilib\YSI_Coding\y_hooks>

// 2771 - Object model for cash register
// 18703 - Smoke model

#define MAX_CASH_REGISTERS      (40)


enum e_CASH_REGISTER_DATA {

    registerID,
    Float:registerPos[3],
    Float:registerRot[3],
    registerInterior,
    registerVW
}

new CashRegister[MAX_CASH_REGISTERS][e_CASH_REGISTER_DATA],
   
    Text3D:CashRegister_Label[MAX_CASH_REGISTERS],
    CashRegister_Object[MAX_CASH_REGISTERS],
    CashRegister_Money[MAX_CASH_REGISTERS],
   
    CashRegister_Timer[MAX_CASH_REGISTERS],
    CashRegister_CoolDown[MAX_CASH_REGISTERS],

    Iterator:iter_CRegister<MAX_CASH_REGISTERS>;

new CashRegister_InProgress[MAX_PLAYERS];

forward CashRegister_LoadData();
public CashRegister_LoadData() {

    new rows = cache_num_rows();

    if(!rows) return false;

    for(new i = 0; i < rows; i++) {

        cache_get_value_name_int(i, "registerID", CashRegister[i][registerID]);

        cache_get_value_name_float(i, "posX", CashRegister[i][registerPos][0]);
        cache_get_value_name_float(i, "posY", CashRegister[i][registerPos][1]);
        cache_get_value_name_float(i, "posZ", CashRegister[i][registerPos][2]);

        cache_get_value_name_float(i, "rotX", CashRegister[i][registerRot][0]);
        cache_get_value_name_float(i, "rotY", CashRegister[i][registerRot][1]);
        cache_get_value_name_float(i, "rotZ", CashRegister[i][registerRot][2]);

        cache_get_value_name_int(i, "Interior", CashRegister[i][registerInterior]);
        cache_get_value_name_int(i, "VW", CashRegister[i][registerVW]);

        CashRegister_Object[i] = CreateDynamicObject(2771, CashRegister[i][registerPos][0], CashRegister[i][registerPos][1], CashRegister[i][registerPos][2], CashRegister[i][registerRot][0], CashRegister[i][registerRot][1], CashRegister[i][registerRot][2], CashRegister[i][registerVW], CashRegister[i][registerInterior], -1);

        new cashReg_str[102];

        format(cashReg_str, sizeof cashReg_str, ""c_server" \187; "c_grey"Kasa "c_server"\171;\n\187; "c_grey"Da opljackate kasu pritisnite 'N' "c_server"\171;");
        CashRegister_Label[i] = Create3DTextLabel(cashReg_str, -1,CashRegister[i][registerPos][0], CashRegister[i][registerPos][1], CashRegister[i][registerPos][2], Float:3.70, CashRegister[i][registerVW]);

        Iter_Add(iter_CRegister, i);
    }

    return (true);
}

forward CashRegister_InsertData(id);
public CashRegister_InsertData(id) {

    CashRegister[id][registerID] = cache_insert_id();

    new cashReg_str[102];
    format(cashReg_str, sizeof cashReg_str, ""c_server" \187; "c_grey"Kasa "c_server"\171;\n\187; "c_grey"Da opljackate kasu pritisnite 'N' "c_server"\171;");
    CashRegister_Label[id] = Create3DTextLabel(cashReg_str, -1,CashRegister[id][registerPos][0], CashRegister[id][registerPos][1], CashRegister[id][registerPos][2], Float:3.70, CashRegister[id][registerVW]);

    Iter_Add(iter_CRegister, id);

    return (true);
}

hook OnGameModeInit() {

    mysql_tquery(MySQL:SQL, "SELECT * FROM `cash_registers`", "CashRegister_LoadData");

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerEditDynamicObject(playerid, STREAMER_TAG_OBJECT:objectid, EDIT_RESPONSE:response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz) {

    new crID = CashRegister_InProgress[playerid];

    if(objectid == CashRegister_Object[crID]) {

        if(response == EDIT_RESPONSE_FINAL) {

            SetDynamicObjectPos(CashRegister_Object[crID], Float:x, Float:y, Float:z);
            SetDynamicObjectRot(CashRegister_Object[crID], Float:rx, Float:ry, Float:rz);


            CashRegister[crID][registerPos][0] = x;
            CashRegister[crID][registerPos][1] = y;
            CashRegister[crID][registerPos][2] = z;

            CashRegister[crID][registerRot][0] = rx;
            CashRegister[crID][registerRot][1] = ry;
            CashRegister[crID][registerRot][2] = rz;

            CashRegister[crID][registerInterior] = GetPlayerInterior(playerid);
            CashRegister[crID][registerVW] = GetPlayerVirtualWorld(playerid);

            new q[260];

            mysql_format(MySQL:SQL, q, sizeof q, "INSERT INTO `cash_registers` (`posX`, `posY`, `posZ`, `rotX`, `rotY`, `rotZ`, `Interior`, `VW`) \
                                                      VALUES ('%f', '%f', '%f', '%f', '%f', '%f', '%d', '%d')",
                                                      CashRegister[crID][registerPos][0], CashRegister[crID][registerPos][1], CashRegister[crID][registerPos][2],
                                                      CashRegister[crID][registerRot][0], CashRegister[crID][registerRot][1], CashRegister[crID][registerRot][2],
                                                      CashRegister[crID][registerInterior], CashRegister[crID][registerVW]);
            mysql_tquery(MySQL:SQL, q, "CashRegister_InsertData", "d", crID);
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

YCMD:createcashregister(playerid, params[], help) 
{
    
    new crID = CashRegister_InProgress[playerid] = Iter_Free(iter_CRegister);

    new Float:pPos[3];

    GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);

    CashRegister_Object[crID] = CreateDynamicObject(2771, pPos[0], pPos[1], pPos[2], 0.00, 0.00, 90.00, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1);
    EditDynamicObject(playerid,  CashRegister_Object[crID]);

    return 1;
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys) {

    if(PRESSED(KEY_NO) && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {

        for(new i = 0; i < MAX_CASH_REGISTERS; i++) {

            if(IsPlayerInRangeOfPoint(playerid, 3.50, CashRegister[i][registerPos][0], CashRegister[i][registerPos][1], CashRegister[i][registerPos][2])) {

                if(CashRegister_CoolDown[i] > 1)
                    return SendClientMessage(playerid, x_green, ">> Ova kasa je opljackana nedavno!");

                CashRegister_CoolDown[i] = 120;

                new randValue = RandomMinMax(20, 250);
                SendClientMessage(playerid, x_green, ">> Uspjesno ste uzeli "c_white"%d$ "c_green"iz kase!", randValue);

                GivePlayerMoney(playerid, randValue);

                CashRegister_Timer[i] = SetTimerEx("CashRegister_Reset", 1000, true, "ii", i, -1);

                if(FactionMember[playerid][factionID] > 0) {

                    FactionMember[playerid][factionRespect]++;
                    SendClientMessage(playerid, x_green, ">> Uspjesno ste dobili faction respect, trenutno imate "c_white"%d "c_green"respekata!", FactionMember[playerid][factionRespect]);

                    new q[267];

                    mysql_format(MySQL:SQL, q, sizeof q, "UPDATE `faction_members` SET `faction_respekt` = '%d' WHERE character_id = '%d'", FactionMember[playerid][factionRespect], PlayerInfo[playerid][SQLID]);
                    mysql_tquery(MySQL:SQL, q);
                }
            }
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerPickUpDynamicPickup(playerid, STREAMER_TAG_PICKUP:pickupid) {

    for(new i = 0; i < MAX_CASH_REGISTERS; i++) {

        if(pickupid == CashRegister_Money[i]) {

            new randValue = RandomMinMax(20, 250);
            GivePlayerMoney(playerid, randValue);
            DestroyDynamicPickup(CashRegister_Money[i]);
        }
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerShootDynamicObject(playerid, weaponid, STREAMER_TAG_OBJECT:objectid, Float:x, Float:y, Float:z) {

    for(new i = 0; i < MAX_CASH_REGISTERS; i++) {

        if(objectid == CashRegister_Object[i]) {
            
            if(CashRegister_CoolDown[i] > 1)
                return SendClientMessage(playerid, x_green, ">> Ova kasa je opljackana nedavno!");

            new Float:a = CashRegister[i][registerRot][2] + 180.0;

            CashRegister_CoolDown[i] = 120;

            new cashReg_str[102];
            format(cashReg_str, sizeof cashReg_str, ""c_server" \187; "c_grey"Kasa "c_server"\171;\n\187; "c_grey"Ponovno pljackanje moguce za %s "c_server"\171;", ConvertToMinutes(CashRegister_CoolDown[i]));
            Update3DTextLabelText(CashRegister_Label[i], -1, cashReg_str);

            CashRegister_Money[i] = CreateDynamicPickup(1212, 1, CashRegister[i][registerPos][0] + (1.25 * floatsin(-a, degrees)), CashRegister[i][registerPos][1] + (1.25 * floatcos(-a, degrees)), CashRegister[i][registerPos][2] - 0.5);
            CashRegister_Timer[i] = SetTimerEx("CashRegister_Reset", 1000, true, "ii", i, CreateDynamicObject(18703, CashRegister[i][registerPos][0] - (0.15 * floatsin(-a, degrees)), CashRegister[i][registerPos][1] - (0.15 * floatcos(-a, degrees)), CashRegister[i][registerPos][2] - 1.65, 0.00, 0.00, 0.00, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid)));

            return Y_HOOKS_BREAK_RETURN_1;
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

forward CashRegister_Reset(id, smoke);
public CashRegister_Reset(id, smoke) {

    if(CashRegister_CoolDown[id] > 1) {

        CashRegister_CoolDown[id]--;

        new cashReg_str[102];
        format(cashReg_str, sizeof cashReg_str, ""c_server" \187; "c_grey"Kasa "c_server"\171;\n\187; "c_grey"Ponovno pljackanje moguce za %s "c_server"\171;", ConvertToMinutes(CashRegister_CoolDown[id]));
        Update3DTextLabelText(CashRegister_Label[id], -1, cashReg_str);
    }

    else{

        if(IsValidDynamicObject(smoke)) 
            return DestroyDynamicObject(smoke);

        new cashReg_str[102];
        format(cashReg_str, sizeof cashReg_str, ""c_server" \187; "c_grey"Kasa "c_server"\171;\n\187; "c_grey"Da opljackate kasu pritisnite 'N' "c_server"\171;");
        Update3DTextLabelText(CashRegister_Label[id], -1, cashReg_str);

        CashRegister_CoolDown[id] = 0;
        KillTimer(CashRegister_Timer[id]);
    }

    return (true);
}

ConvertToMinutes(time)
{
    // http://forum.sa-mp.com/showpost.php?p=3223897&postcount=11
    new string[15];//-2000000000:00 could happen, so make the string 15 chars to avoid any errors
    format(string, sizeof(string), "%02d:%02d", time / 60, time % 60);
    return string;
}