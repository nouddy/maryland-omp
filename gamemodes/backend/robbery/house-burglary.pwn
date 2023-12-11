#include <ysilib\YSI_Coding\y_hooks>

#define INDEX_SLOT_ELECTRONIC_GOODS     ( 7 )

new burglary_Van[MAX_PLAYERS];
new burglary_Objects[MAX_PLAYERS][3];

new PlayerText3D:burglary_Labels[MAX_PLAYERS][3];

new burglary_CoolDown[MAX_PLAYERS];
new burglary_Counter[MAX_PLAYERS];
new bool:burglary_InProgress[MAX_PLAYERS];

new burglary_Icon[MAX_PLAYERS],
    PlayerText3D:burglary_HouseLabel[MAX_PLAYERS],
    burglary_HouseID[MAX_PLAYERS];

new stolenObjects[MAX_PLAYERS];

enum e_BURGLARY_HOUSE_DATA {

    Float:house_Pos[3]
}

new BurglaryInfo[][e_BURGLARY_HOUSE_DATA] = {

    { {1872.2445, -1912.4388, 15.2568} },
    { {2067.0554, -1656.4021, 14.0246} },
    { {2000.0170, -1114.7700, 27.1250} }

};

//*         >> [ HOOKS ] <<

hook OnGameModeInit() {

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerConnect(playerid) {

    burglary_HouseID[playerid] = -1;
    stolenObjects[playerid] = 0;

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerDisconnect(playerid, reason) {

    for(new i = 0; i < sizeof burglary_Labels[]; i++) {

        DeletePlayer3DTextLabel(playerid, burglary_Labels[playerid][i]);
    }

    if(bool:IsValidPlayer3DTextLabel(playerid, PlayerText3D:burglary_HouseLabel[playerid]))
        return DeletePlayer3DTextLabel(playerid, burglary_HouseLabel[playerid]);

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerDeath(playerid, killerid, reason) {

    if(burglary_CoolDown[playerid] < gettime()) {

        SendClientMessage(playerid, x_server, "maryland \187; "c_white"Provala kuce je propala jer ste umrli!");
        burglary_CoolDown[playerid] = 0;
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger) {

    if(vehicleid == burglary_Van[playerid]) {

        if(burglary_InProgress[playerid] && burglary_HouseID[playerid] == -1) {

            burglary_HouseID[playerid] = random(3);

            stolenObjects[playerid] = 0;

            RemovePlayerMapIcon(playerid, burglary_Icon[playerid]);
            burglary_Icon[playerid] = SetPlayerMapIcon(playerid, 11, BurglaryInfo[burglary_HouseID[playerid]][house_Pos][0], BurglaryInfo[burglary_HouseID[playerid]][house_Pos][1], BurglaryInfo[burglary_HouseID[playerid]][house_Pos][2], 52, -1, MAPICON_GLOBAL);

            SendClientMessage(playerid, x_server, "maryland \187; "c_white"Dobili ste lokaciju kuce!");
            SendClientMessage(playerid, x_server, "maryland \187; "c_white"Kad pokupite predmed iz kuce, ostavljate ga u gepek od kombija putem tipke 'N'!");

            SendClientMessage(playerid, -1, " ");

            SendClientMessage(playerid, x_grey, "Ryder \187; "c_white"Kuca je otkljucana, odradi sve kako treba. Ostalo je na tebi!");

            burglary_HouseLabel[playerid] =  CreatePlayer3DTextLabel(playerid, "\187; "c_white"Kuca za obijanje" c_grey"\171;\n\187; "c_white"[ F ]"c_grey"\171;", x_grey, BurglaryInfo[burglary_HouseID[playerid]][house_Pos][0], BurglaryInfo[burglary_HouseID[playerid]][house_Pos][1], BurglaryInfo[burglary_HouseID[playerid]][house_Pos][2], 3.50);

        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys) {

    if(PRESSED( KEY_SECONDARY_ATTACK)) {

        if(burglary_InProgress[playerid]) {

            if(IsPlayerInRangeOfPoint(playerid, 3.50, BurglaryInfo[burglary_HouseID[playerid]][house_Pos][0], BurglaryInfo[burglary_HouseID[playerid]][house_Pos][1], BurglaryInfo[burglary_HouseID[playerid]][house_Pos][2])) {

                SetPlayerPos(playerid, 224.28,1289.19,1082.14);
                SetPlayerVirtualWorld(playerid, playerid+1);
                SetPlayerInterior(playerid, 1);
            }

            else if(IsPlayerInRangeOfPoint(playerid, 3.50, 224.28,1289.19,1082.14)) {

                SetPlayerPos(playerid, BurglaryInfo[burglary_HouseID[playerid]][house_Pos][0], BurglaryInfo[burglary_HouseID[playerid]][house_Pos][1], BurglaryInfo[burglary_HouseID[playerid]][house_Pos][2]);
                SetPlayerInterior(playerid, 0);
                SetPlayerVirtualWorld(playerid, 0);
            }
        }
    }

    if(PRESSED( KEY_NO)) {

        if(burglary_InProgress[playerid]) {

            if(IsPlayerInRangeOfVehicle(playerid, burglary_Van[playerid], 3.50)) {

                if(IsPlayerAttachedObjectSlotUsed(playerid, INDEX_SLOT_ELECTRONIC_GOODS)) {

                    ApplyAnimation(playerid, "CARRY", "putdwn", 4.1, false, true, true, false, 2);
                    stolenObjects[playerid]++;

                    SendClientMessage(playerid, -1, "Stolen Objects - %d", stolenObjects[playerid]);

                    if(stolenObjects[playerid] == 3) {

                        SendClientMessage(playerid, x_server, "maryland \187; "c_white"Uspjesno ste pokupili sve elektronske naprave, vratite se na pocetnu lokaciju!");
                        RemovePlayerMapIcon(playerid, burglary_Icon[playerid]);

                        burglary_Icon[playerid] = SetPlayerMapIcon(playerid, 11, 2087.1863, -1557.7731, 12.8787, 51, -1, MAPICON_GLOBAL);

                        SendClientMessage(playerid, -1, " ");

                        SendClientMessage(playerid, x_server, "maryland \187; "c_white"Kada stignete na lokaciju pritisnite tipku 'N' kako bi zavrsili provalu!");

                        //bool:ApplyAnimation(playerid, const animationLibrary[], const animationName[], Float:delta, bool:loop, bool:lockX, bool:lockY, bool:freeze, time, FORCE_SYNC:forceSync = SYNC_NONE)
                        RemovePlayerAttachedObject(playerid, INDEX_SLOT_ELECTRONIC_GOODS);
                        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);

                    }
                }
            }

            if(IsPlayerInRangeOfPoint(playerid, 3.50, 2087.1863, -1557.7731, 12.8787)) {

                for(new i = 0; i < sizeof burglary_Objects[]; i++) { 
                    
                    if(!IsValidPlayerObject(playerid, burglary_Objects[playerid][i])) {

                        new randomMoney = RandomMinMax(1500, 3500);

                        GivePlayerMoney(playerid, randomMoney);

                        SendClientMessage(playerid, x_server, "maryland \187; "c_white"Uspjesno ste obavili provalu te zaradili novac!");

                        burglary_InProgress[playerid] = false;

                        RemovePlayerFromVehicle(playerid);
                        DestroyVehicle(burglary_Van[playerid]);

                        for(new o = 0; o < sizeof burglary_Objects[]; o++) { if(IsValidPlayerObject(playerid, burglary_Objects[playerid][o])) return DestroyPlayerObject(playerid, burglary_Objects[playerid][o]); }
                        for(new j = 0; j < sizeof burglary_Labels[]; j++) { if(bool:IsValidPlayer3DTextLabel(playerid, burglary_Labels[playerid][j])) return DeletePlayer3DTextLabel(playerid, burglary_Labels[playerid][j]); }                  

                        if(bool:IsValidPlayer3DTextLabel(playerid, burglary_HouseLabel[playerid]))
                            return DeletePlayer3DTextLabel(playerid, burglary_HouseLabel[playerid]);

                        return Y_HOOKS_BREAK_RETURN_1;
                    }
                }

            }

            for(new i = 0; i < sizeof burglary_Objects[]; i++) {

                new Float:oPos[3];
                new Float:oRot[3];
                GetPlayerObjectPos(playerid, burglary_Objects[playerid][i], oPos[0], oPos[1], oPos[2]);
                GetPlayerObjectRot(playerid, burglary_Objects[playerid][i], oRot[0], oRot[1], oRot[2]);

                if(IsPlayerInRangeOfPoint(playerid, 3.50, oPos[0], oPos[1], oPos[2])) {

                    new modelID = GetPlayerObjectModel(playerid, burglary_Objects[playerid][i]);

                    if(!IsValidPlayerObject(playerid, burglary_Objects[playerid][i])) {

                        burglary_Objects[playerid][i] = CreatePlayerObject(playerid, modelID, oPos[0], oPos[1], oPos[2], oRot[0], oRot[1], oRot[2], 350.00);
                    }

                    SetPlayerAttachedObject(playerid, INDEX_SLOT_ELECTRONIC_GOODS, modelID, 5, 0.1, 0.1, 0.0, 0.0, 0.0, 0.0);
                    //* SetPlayerAttachedObject(playerid, index, modelid, bone, Float:fOffsetX = 0.0, Float:fOffsetY = 0.0, Float:fOffsetZ = 0.0, Float:fRotX = 0.0, Float:fRotY = 0.0, Float:fRotZ = 0.0, Float:fScaleX = 1.0, Float:fScaleY = 1.0, Float:fScaleZ = 1.0, materialcolor1 = 0, materialcolor2 = 0)
                    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY); 

                    DeletePlayer3DTextLabel(playerid, burglary_Labels[playerid][i]);
                    DestroyPlayerObject(playerid, burglary_Objects[playerid][i]);

                    return Y_HOOKS_BREAK_RETURN_1;
                }
            }
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

//*         >> [ COMMANDS ] <<

YCMD:burglary(playerid, params[], help) 
{

    if(burglary_InProgress[playerid]) return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Vec ste zapoceli provalu kuce!");

    if(burglary_CoolDown[playerid] > gettime()) return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Pokusajte za %s", ConvertToMinutes(burglary_CoolDown[playerid]));

    burglary_CoolDown[playerid] = gettime()+1200; // CoolDown on 20 minutes!

    SendClientMessage(playerid, x_server, "maryland \187; "c_white"Idite do kombija koji vam je oznacen na mapi!");

    if(!IsValidVehicle(burglary_Van[playerid])) { burglary_Van[playerid] = CreateVehicle(414, 2087.1863, -1557.7731, 12.8787, 178.1412, 1, 1, 1500); }
    burglary_Icon[playerid] = SetPlayerMapIcon(playerid, 11, 2087.1863, -1557.7731, 12.8787, 51, -1, MAPICON_GLOBAL);

    burglary_Labels[playerid][0] = CreatePlayer3DTextLabel(playerid, "\187; "c_white"Elektronska Roba" c_grey"\171;\n\187; "c_white"[ N ]"c_grey"\171;", x_grey, 224.225616, 1289.901489, 1081.751220, 3.50);
    burglary_Labels[playerid][1] = CreatePlayer3DTextLabel(playerid, "\187; "c_white"Elektronska Roba" c_grey"\171;\n\187; "c_white"[ N ]"c_grey"\171;", x_grey, 231.092285, 1290.977294, 1081.190673, 3.50);
    burglary_Labels[playerid][2] = CreatePlayer3DTextLabel(playerid, "\187; "c_white"Elektronska Roba" c_grey"\171;\n\187; "c_white"[ N ]"c_grey"\171;", x_grey, 230.566833, 1286.307617, 1082.010742, 3.50);

    burglary_Objects[playerid][0] = CreatePlayerObject(playerid, 1785, 224.225616, 1289.901489, 1081.751220, 0.000000, 0.000000, 91.300094, 250.0);
    burglary_Objects[playerid][1] = CreatePlayerObject(playerid, 2226, 231.092285, 1290.977294, 1081.190673, 0.000000, 0.000000, -90.799987, 250.0);
    burglary_Objects[playerid][2] = CreatePlayerObject(playerid, 19893, 230.566833, 1286.307617, 1082.010742, 0.000000, 0.000000, 160.199966, 250.0);

    burglary_InProgress[playerid] = true;

    return 1;
}

YCMD:burglaryveh(playerid, params[], help) 
{
    
    new Float:pPos[3];
    GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);

    SetVehiclePos(burglary_Van[playerid], pPos[0], pPos[1], pPos[2]);
    PutPlayerInVehicle(playerid, burglary_Van[playerid], 0);

    return 1;
}

YCMD:burglaryhosue(playerid, params[], help) 
{
    SetPlayerPos(playerid, BurglaryInfo[burglary_HouseID[playerid]][house_Pos][0], BurglaryInfo[burglary_HouseID[playerid]][house_Pos][1], BurglaryInfo[burglary_HouseID[playerid]][house_Pos][2]);
    
    return 1;
}

/*

        ?     >> [ MISC ] <<
        ?                     X      Y      Z         INT
        * >> pawnokit.ru -> 224.28,1289.19,1082.14 | [ 1 ] - House Interior

        ? 224.225616, 1289.901489, 1081.751220 - Electronic Goods Label
        ? 231.092285, 1290.977294, 1081.190673 - Electronic Goods Label
        ? 230.566833, 1286.307617, 1082.010742 - Electronic Goods Label

        ? ChatGPT help, I was too lazy to do it <3

        ? SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY); 

        ? Attach DVD Player
        * SetPlayerAttachedObject(playerid, INDEX_SLOT_ELECTRONIC_GOODS, 1785, 0.1, 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);

        ? Attach HiFi Radio
        * SetPlayerAttachedObject(playerid, INDEX_SLOT_ELECTRONIC_GOODS, 2226, 0.1, 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);

        ? Attach Laptop
        * SetPlayerAttachedObject(playerid, INDEX_SLOT_ELECTRONIC_GOODS, 19893, 0.1, 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);

*/