#include <ysilib\YSI_Coding\y_hooks>

new burglary_Van[MAX_PLAYERS];
new burglary_Objects[3];

new PlayerText3D:burglary_Labels[MAX_PLAYERS][3];

new burglary_CoolDown[MAX_PLAYERS];
new burglary_Counter[MAX_PLAYERS];

hook OnGameModeInit() {

    burglary_Objects[0] = CreateDynamicObject(1785, 224.225616, 1289.901489, 1081.751220, 0.000000, 0.000000, 91.300094, -1, 1, -1, 300.00, 300.00); 
    burglary_Objects[1] = CreateDynamicObject(2226, 231.092285, 1290.977294, 1081.190673, 0.000000, 0.000000, -90.799987, -1, 1, -1, 300.00, 300.00); 
    burglary_Objects[2] = CreateDynamicObject(19893, 230.566833, 1286.307617, 1082.010742, 0.000000, 0.000000, 160.199966, -1, 1, -1, 300.00, 300.00); 

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerDisconnect(playerid, reason) {

    for(new i = 0; i < sizeof burglary_Labels[]; i++) {

        DeletePlayer3DTextLabel(playerid, burglary_Labels[playerid][i]);
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

YCMD:burglary(playerid, params[], help) 
{
    
    if(burglary_CoolDown[playerid] < gettime()) return SendClientMessage(playerid, x_green, ">> Pokusajte za %s", ConvertToMinutes(burglary_CoolDown[playerid]));

    burglary_CoolDown[playerid] = gettime()+600;

    SendClientMessage(playerid, x_green, ">> Idite do kombija koji vam je oznacen na mapi!");

    burglary_Van[playerid] = AddStaticVehicle(414, 2087.1863, -1557.7731, 12.8787, 178.1412, 1, 1);

    return 1;
}

