/***
 *
 *  ##     ##    ###    ########  ##    ## ##          ###    ##    ## ########  
 *  ###   ###   ## ##   ##     ##  ##  ##  ##         ## ##   ###   ## ##     ## 
 *  #### ####  ##   ##  ##     ##   ####   ##        ##   ##  ####  ## ##     ## 
 *  ## ### ## ##     ## ########     ##    ##       ##     ## ## ## ## ##     ## 
 *  ##     ## ######### ##   ##      ##    ##       ######### ##  #### ##     ## 
 *  ##     ## ##     ## ##    ##     ##    ##       ##     ## ##   ### ##     ## 
 *  ##     ## ##     ## ##     ##    ##    ######## ##     ## ##    ## ########   
 *
 *  @Author         Vostic & Ogy_
 *  @Date           05th May 2023
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           fuel.script
 *  @Module         vehicle
 */


//? Todo : Make td representation. Add custom func ifrentisnearrent(on createing). 

#include <ysilib\YSI_Coding\y_hooks>

#define MAX_RENTALS (100)
#define INVALID_RENTAL_ID (-1)

enum RentalInfo
{
    rentID,
    rentVehModels[3],
    Timer:rentalTimer,
    Float:rentalPos[3],
    bool:isRented,
    rentalPickup,
    Text3D:RentalLabel
}

new PlayerRental[MAX_RENTALS][RentalInfo];
new Iterator:iter_Rental<MAX_RENTALS>;

new PlayerText:RentacarTD[MAX_PLAYERS][15];

hook OnGameModeInit() {

    print("backend/vehicle/rent_vehicle.pwn -- loaded.");

    mysql_tquery(SQL, "SELECT * FROM `rent`", "RentalLoad", "");

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnGameModeExit() {

    foreach(new j : iter_Rental) {

        Iter_Remove(iter_Rental, j);
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}


forward RentalLoad();
public RentalLoad()
{

    new rows = cache_num_rows();

    if(!rows)
		return print("\n[Rent]: 0 renta ucitano.\n");


    for(new i=0; i < rows; i++) if(i < MAX_RENTALS)
    {
        cache_get_value_name_int(i, "rentID", PlayerRental[i][rentID]);


        cache_get_value_name_int(i, "fVehModel", PlayerRental[i][rentVehModels][0]);
        cache_get_value_name_int(i, "sVehModel", PlayerRental[i][rentVehModels][1]);
        cache_get_value_name_int(i, "tVehModel", PlayerRental[i][rentVehModels][2]);

 		cache_get_value_name_float(i, "rPosX", PlayerRental[i][rentalPos][0]);
		cache_get_value_name_float(i, "rPosY", PlayerRental[i][rentalPos][1]);
		cache_get_value_name_float(i, "rPosZ", PlayerRental[i][rentalPos][2]);

        PlayerRental[i][rentalPickup] = CreatePickup(2485, 1, PlayerRental[i][rentalPos][0],PlayerRental[i][rentalPos][1], PlayerRental[i][rentalPos][2], 0);
        PlayerRental[i][RentalLabel] = Create3DTextLabel(""c_server" \187; "c_grey"Za rent pritisnite 'N' "c_server"\171;", -1, PlayerRental[i][rentalPos][0],PlayerRental[i][rentalPos][1],PlayerRental[i][rentalPos][2], 3.50, -1);

        Iter_Add(iter_Rental, i);
    }
    printf("\n[Rentals]: %d rentova ucitano.\n",rows);
    return (true);
}

///////////////////////////////////////////////////////////
//?Hooks
///////////////////////////////////////////////////////////

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
    if(PRESSED(KEY_NO))
    {
        if(IsPlayerNearRent(playerid) != INVALID_RENTAL_ID)
        {
            new rID = IsPlayerNearRent(playerid);
            RentaCar_Interface(playerid, true);

            PlayerTextDraw_UpdateModel(playerid, RentacarTD[playerid][12], PlayerRental[rID][rentVehModels][0]);
            PlayerTextDraw_UpdateModel(playerid, RentacarTD[playerid][13], PlayerRental[rID][rentVehModels][1]);
            PlayerTextDraw_UpdateModel(playerid, RentacarTD[playerid][14], PlayerRental[rID][rentVehModels][2]);

        }
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}

///////////////////////////////////////////////////////////

YCMD:createrent(playerid, params[], help)
{
    if(help) {

        SendClientMessage(playerid, x_server, "maryland \187; "c_white"Usage: /createrent [model1] [model2] [model3]");
        return true;
    }

    new model1, model2, model3;
    if (sscanf(params, "iii", model1, model2, model3)) return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Usage: /createrent [model1] [model2] [model3]");

    new id = Iter_Free(iter_Rental);
    new Float:pPos[3];
    GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);

    PlayerRental[id][rentalPos][0] = pPos[0];
    PlayerRental[id][rentalPos][1] = pPos[1];
    PlayerRental[id][rentalPos][2] = pPos[2];

    PlayerRental[id][rentVehModels][0] = model1;
    PlayerRental[id][rentVehModels][1] = model2;
    PlayerRental[id][rentVehModels][2] = model3;


    new query[680];
    mysql_format(SQL, query, sizeof query, "INSERT INTO `rent` (`fVehModel`, `sVehModel`, `tVehModel`, `rPosX`, `rPosY`, `rPosZ`) \
    VALUES ('%d', '%d', '%d', '%f', '%f', '%f')", 
    PlayerRental[id][rentVehModels][0], PlayerRental[id][rentVehModels][1], PlayerRental[id][rentVehModels][2], PlayerRental[id][rentalPos][0], PlayerRental[id][rentalPos][1], PlayerRental[id][rentalPos][2]);
    mysql_tquery(SQL, query, "Create_Rent", "i", id);

    SendClientMessage(playerid, x_server, "maryland \187; "c_white"Rent uspesno kreiran.");
    return 1;
}

//Delete
YCMD:deleterent(playerid, params[], help)
{
    new id = IsPlayerNearRent(playerid);

    new q[267];

    mysql_format(SQL, q, sizeof q, "DELETE FROM `rent` WHERE `rentID`= '%d'", id);
    mysql_tquery(SQL, q);

    Iter_Remove(iter_Rental, id);

    if(IsValidPickup(PlayerRental[id][rentalPickup])) { DestroyPickup(PlayerRental[id][rentalPickup]); }
    if(IsValid3DTextLabel(PlayerRental[id][RentalLabel])) { Delete3DTextLabel(PlayerRental[id][RentalLabel]); }

    SendClientMessage(playerid, x_server, "maryland \187; "c_white"Rent id %d | Uspesno obrisan iz baze.", id);

    return (true);
}


//? FPS
forward Create_Rent(id);
public Create_Rent(id) {

	PlayerRental[id][rentID] = cache_insert_id();
	Iter_Add(iter_Rental, id);

    PlayerRental[id][rentalPickup] = CreatePickup(2485, 1, PlayerRental[id][rentalPos][0],PlayerRental[id][rentalPos][1], PlayerRental[id][rentalPos][2], 0);
    PlayerRental[id][RentalLabel] = Create3DTextLabel(""c_server" \187; "c_grey"Za rent pritisnite 'N' "c_server"\171;", -1, PlayerRental[id][rentalPos][0],PlayerRental[id][rentalPos][1],PlayerRental[id][rentalPos][2], 3.50, -1);

	return (true);
}


IsPlayerNearRent(playerid) {

    foreach(new j : iter_Rental) {

        if(IsPlayerInRangeOfPoint(playerid, 4.0, PlayerRental[j][rentalPos][0], PlayerRental[j][rentalPos][1], PlayerRental[j][rentalPos][2])) return j;
    }
    return INVALID_RENTAL_ID;
}


//TD
stock RentaCar_Interface(playerid, bool:show) {
    
    if (show) {

        for (new i = 0; i < sizeof RentacarTD[]; i++) {

            if(RentacarTD[playerid][i] == INVALID_PLAYER_TEXT_DRAW) continue;

            PlayerTextDrawHide(playerid, RentacarTD[playerid][i]);
            PlayerTextDrawDestroy(playerid, RentacarTD[playerid][i]);
            RentacarTD[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
        }

        RentacarTD[playerid][0] = CreatePlayerTextDraw(playerid, 151.000045, 142.140701, "LD_SPAC:white");
        PlayerTextDrawTextSize(playerid, RentacarTD[playerid][0], 341.000000, 207.000000);
        PlayerTextDrawAlignment(playerid, RentacarTD[playerid][0], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, RentacarTD[playerid][0], 135009023);
        PlayerTextDrawSetShadow(playerid, RentacarTD[playerid][0], 0);
        PlayerTextDrawBackgroundColour(playerid, RentacarTD[playerid][0], 255);
        PlayerTextDrawFont(playerid, RentacarTD[playerid][0], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, RentacarTD[playerid][0], false);

        RentacarTD[playerid][1] = CreatePlayerTextDraw(playerid, 151.000045, 142.140701, "loadsc5:loadsc5");
        PlayerTextDrawTextSize(playerid, RentacarTD[playerid][1], 341.000000, 207.000000);
        PlayerTextDrawAlignment(playerid, RentacarTD[playerid][1], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, RentacarTD[playerid][1], -251);
        PlayerTextDrawSetShadow(playerid, RentacarTD[playerid][1], 0);
        PlayerTextDrawBackgroundColour(playerid, RentacarTD[playerid][1], 255);
        PlayerTextDrawFont(playerid, RentacarTD[playerid][1], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, RentacarTD[playerid][1], false);

        RentacarTD[playerid][2] = CreatePlayerTextDraw(playerid, -187.866561, -65.937011, "");
        PlayerTextDrawTextSize(playerid, RentacarTD[playerid][2], 679.000000, 414.000000);
        PlayerTextDrawAlignment(playerid, RentacarTD[playerid][2], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, RentacarTD[playerid][2], -2067335882);
        PlayerTextDrawBackgroundColour(playerid, RentacarTD[playerid][2], 0x00000000);
        PlayerTextDrawSetShadow(playerid, RentacarTD[playerid][2], 0);
        PlayerTextDrawFont(playerid, RentacarTD[playerid][2], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, RentacarTD[playerid][2], false);
        PlayerTextDrawSetPreviewModel(playerid, RentacarTD[playerid][2], 1317);
        PlayerTextDrawSetPreviewRot(playerid, RentacarTD[playerid][2], 0.000000, 270.000000, 73.000000, 1.000000);

        RentacarTD[playerid][3] = CreatePlayerTextDraw(playerid, 265.766571, 279.229675, "");
        PlayerTextDrawTextSize(playerid, RentacarTD[playerid][3], -115.000000, -137.000000);
        PlayerTextDrawAlignment(playerid, RentacarTD[playerid][3], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, RentacarTD[playerid][3], 135009023);
        PlayerTextDrawBackgroundColour(playerid, RentacarTD[playerid][3], 0xFFFFFF00);
        PlayerTextDrawSetShadow(playerid, RentacarTD[playerid][3], 0);
        PlayerTextDrawFont(playerid, RentacarTD[playerid][3], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, RentacarTD[playerid][3], false);
        PlayerTextDrawSetPreviewModel(playerid, RentacarTD[playerid][3], 1316);
        PlayerTextDrawSetPreviewRot(playerid, RentacarTD[playerid][3], 190.000000, 235.000000, 0.000000, 0.400000);

        RentacarTD[playerid][4] = CreatePlayerTextDraw(playerid, 306.099884, 348.918792, "");
        PlayerTextDrawTextSize(playerid, RentacarTD[playerid][4], -115.000000, -137.000000);
        PlayerTextDrawAlignment(playerid, RentacarTD[playerid][4], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, RentacarTD[playerid][4], 135009023);
        PlayerTextDrawBackgroundColour(playerid, RentacarTD[playerid][4], 0xFFFFFF00);
        PlayerTextDrawSetShadow(playerid, RentacarTD[playerid][4], 0);
        PlayerTextDrawFont(playerid, RentacarTD[playerid][4], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, RentacarTD[playerid][4], false);
        PlayerTextDrawSetPreviewModel(playerid, RentacarTD[playerid][4], 1316);
        PlayerTextDrawSetPreviewRot(playerid, RentacarTD[playerid][4], 190.000000, 235.000000, 0.000000, 0.400000);

        RentacarTD[playerid][5] = CreatePlayerTextDraw(playerid, 266.099914, 348.918792, "");
        PlayerTextDrawTextSize(playerid, RentacarTD[playerid][5], -115.000000, -137.000000);
        PlayerTextDrawAlignment(playerid, RentacarTD[playerid][5], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, RentacarTD[playerid][5], 135009023);
        PlayerTextDrawBackgroundColour(playerid, RentacarTD[playerid][5], 0xFFFFFF00);
        PlayerTextDrawSetShadow(playerid, RentacarTD[playerid][5], 0);
        PlayerTextDrawFont(playerid, RentacarTD[playerid][5], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, RentacarTD[playerid][5], false);
        PlayerTextDrawSetPreviewModel(playerid, RentacarTD[playerid][5], 1316);
        PlayerTextDrawSetPreviewRot(playerid, RentacarTD[playerid][5], 190.000000, 235.000000, 0.000000, 0.400000);

        RentacarTD[playerid][6] = CreatePlayerTextDraw(playerid, 212.999938, 307.807464, "MARYLAND");
        PlayerTextDrawLetterSize(playerid, RentacarTD[playerid][6], 0.400000, 1.600000);
        PlayerTextDrawAlignment(playerid, RentacarTD[playerid][6], TEXT_DRAW_ALIGN_CENTER);
        PlayerTextDrawColour(playerid, RentacarTD[playerid][6], -1);
        PlayerTextDrawSetShadow(playerid, RentacarTD[playerid][6], 0);
        PlayerTextDrawBackgroundColour(playerid, RentacarTD[playerid][6], 255);
        PlayerTextDrawFont(playerid, RentacarTD[playerid][6], TEXT_DRAW_FONT_1);
        PlayerTextDrawSetProportional(playerid, RentacarTD[playerid][6], true);

        RentacarTD[playerid][7] = CreatePlayerTextDraw(playerid, 211.666564, 321.081573, "RENT_SERVICE");
        PlayerTextDrawLetterSize(playerid, RentacarTD[playerid][7], 0.138999, 0.608592);
        PlayerTextDrawAlignment(playerid, RentacarTD[playerid][7], TEXT_DRAW_ALIGN_CENTER);
        PlayerTextDrawColour(playerid, RentacarTD[playerid][7], -2067335681);
        PlayerTextDrawSetShadow(playerid, RentacarTD[playerid][7], 0);
        PlayerTextDrawBackgroundColour(playerid, RentacarTD[playerid][7], 255);
        PlayerTextDrawFont(playerid, RentacarTD[playerid][7], TEXT_DRAW_FONT_1);
        PlayerTextDrawSetProportional(playerid, RentacarTD[playerid][7], true);

        RentacarTD[playerid][8] = CreatePlayerTextDraw(playerid, 160.999984, 258.288909, "");
        PlayerTextDrawTextSize(playerid, RentacarTD[playerid][8], 90.000000, 90.000000);
        PlayerTextDrawAlignment(playerid, RentacarTD[playerid][8], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, RentacarTD[playerid][8], -204);
        PlayerTextDrawSetShadow(playerid, RentacarTD[playerid][8], 0);
        PlayerTextDrawBackgroundColour(playerid, RentacarTD[playerid][8], 0x00000000);
        PlayerTextDrawFont(playerid, RentacarTD[playerid][8], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, RentacarTD[playerid][8], false);
        PlayerTextDrawSetPreviewModel(playerid, RentacarTD[playerid][8], 562);
        PlayerTextDrawSetPreviewRot(playerid, RentacarTD[playerid][8], 0.000000, 0.000000, 31.000000, 1.000000);
        PlayerTextDrawSetPreviewVehicleColours(playerid, RentacarTD[playerid][8], 1, 1);

        RentacarTD[playerid][9] = CreatePlayerTextDraw(playerid, 249.000015, 199.385223, "");
        PlayerTextDrawTextSize(playerid, RentacarTD[playerid][9], 90.000000, 90.000000);
        PlayerTextDrawAlignment(playerid, RentacarTD[playerid][9], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, RentacarTD[playerid][9], 180);
        PlayerTextDrawSetShadow(playerid, RentacarTD[playerid][9], 0);
        PlayerTextDrawBackgroundColour(playerid, RentacarTD[playerid][9], 0x00000000);
        PlayerTextDrawFont(playerid, RentacarTD[playerid][9], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, RentacarTD[playerid][9], false);
        PlayerTextDrawSetPreviewModel(playerid, RentacarTD[playerid][9], 2729);
        PlayerTextDrawSetPreviewRot(playerid, RentacarTD[playerid][9], 0.000000, 0.000000, -23.000000, 1.000000);

        RentacarTD[playerid][10] = CreatePlayerTextDraw(playerid, 327.666656, 199.385223, "");
        PlayerTextDrawTextSize(playerid, RentacarTD[playerid][10], 90.000000, 90.000000);
        PlayerTextDrawAlignment(playerid, RentacarTD[playerid][10], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, RentacarTD[playerid][10], 180);
        PlayerTextDrawSetShadow(playerid, RentacarTD[playerid][10], 0);
        PlayerTextDrawBackgroundColour(playerid, RentacarTD[playerid][10], 0x00000000);
        PlayerTextDrawFont(playerid, RentacarTD[playerid][10], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, RentacarTD[playerid][10], false);
        PlayerTextDrawSetPreviewModel(playerid, RentacarTD[playerid][10], 2729);
        PlayerTextDrawSetPreviewRot(playerid, RentacarTD[playerid][10], 0.000000, 0.000000, 0.000000, 1.000000);

        RentacarTD[playerid][11] = CreatePlayerTextDraw(playerid, 406.333465, 199.385223, "");
        PlayerTextDrawTextSize(playerid, RentacarTD[playerid][11], 90.000000, 90.000000);
        PlayerTextDrawAlignment(playerid, RentacarTD[playerid][11], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, RentacarTD[playerid][11], 180);
        PlayerTextDrawSetShadow(playerid, RentacarTD[playerid][11], 0);
        PlayerTextDrawBackgroundColour(playerid, RentacarTD[playerid][11], 0x00000000);
        PlayerTextDrawFont(playerid, RentacarTD[playerid][11], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, RentacarTD[playerid][11], false);
        PlayerTextDrawSetPreviewModel(playerid, RentacarTD[playerid][11], 2729);
        PlayerTextDrawSetPreviewRot(playerid, RentacarTD[playerid][11], 0.000000, 0.000000, 23.000000, 1.000000);

        RentacarTD[playerid][12] = CreatePlayerTextDraw(playerid, 267.666625, 204.777755, "");
        PlayerTextDrawTextSize(playerid, RentacarTD[playerid][12], 65.000000, 77.000000);
        PlayerTextDrawAlignment(playerid, RentacarTD[playerid][12], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, RentacarTD[playerid][12], -1);
        PlayerTextDrawSetShadow(playerid, RentacarTD[playerid][12], 0);
        PlayerTextDrawBackgroundColour(playerid, RentacarTD[playerid][12], 0x00000000);
        PlayerTextDrawFont(playerid, RentacarTD[playerid][12], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, RentacarTD[playerid][12], false);
        PlayerTextDrawSetSelectable(playerid, RentacarTD[playerid][12], true);
        PlayerTextDrawSetPreviewModel(playerid, RentacarTD[playerid][12], 560);
        PlayerTextDrawSetPreviewRot(playerid, RentacarTD[playerid][12], 0.000000, 0.000000, -23.000000, 1.000000);
        PlayerTextDrawSetPreviewVehicleColours(playerid, RentacarTD[playerid][12], 1, 1);

        RentacarTD[playerid][13] = CreatePlayerTextDraw(playerid, 344.999938, 204.777755, "");
        PlayerTextDrawTextSize(playerid, RentacarTD[playerid][13], 65.000000, 77.000000);
        PlayerTextDrawAlignment(playerid, RentacarTD[playerid][13], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, RentacarTD[playerid][13], -1);
        PlayerTextDrawSetShadow(playerid, RentacarTD[playerid][13], 0);
        PlayerTextDrawBackgroundColour(playerid, RentacarTD[playerid][13], 0x00000000);
        PlayerTextDrawFont(playerid, RentacarTD[playerid][13], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, RentacarTD[playerid][13], false);
        PlayerTextDrawSetSelectable(playerid, RentacarTD[playerid][13], true);
        PlayerTextDrawSetPreviewModel(playerid, RentacarTD[playerid][13], 560);
        PlayerTextDrawSetPreviewRot(playerid, RentacarTD[playerid][13], 0.000000, 0.000000, -23.000000, 1.000000);
        PlayerTextDrawSetPreviewVehicleColours(playerid, RentacarTD[playerid][13], 1, 1);

        RentacarTD[playerid][14] = CreatePlayerTextDraw(playerid, 421.666534, 204.777755, "");
        PlayerTextDrawTextSize(playerid, RentacarTD[playerid][14], 65.000000, 77.000000);
        PlayerTextDrawAlignment(playerid, RentacarTD[playerid][14], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, RentacarTD[playerid][14], -1);
        PlayerTextDrawSetShadow(playerid, RentacarTD[playerid][14], 0);
        PlayerTextDrawBackgroundColour(playerid, RentacarTD[playerid][14], 0x00000000);
        PlayerTextDrawFont(playerid, RentacarTD[playerid][14], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, RentacarTD[playerid][14], false);
        PlayerTextDrawSetSelectable(playerid, RentacarTD[playerid][14], true);
        PlayerTextDrawSetPreviewModel(playerid, RentacarTD[playerid][14], 560);
        PlayerTextDrawSetPreviewRot(playerid, RentacarTD[playerid][14], 0.000000, 0.000000, -23.000000, 1.000000);
        PlayerTextDrawSetPreviewVehicleColours(playerid, RentacarTD[playerid][14], 1, 1);

        SelectTextDraw(playerid, x_server);

        for (new i = 0; i < sizeof RentacarTD[]; i++) {
            PlayerTextDrawShow(playerid, RentacarTD[playerid][i]);
        }
    } else {
        for (new i = 0; i < sizeof RentacarTD[]; i++) {

            if(RentacarTD[playerid][i] == INVALID_PLAYER_TEXT_DRAW) continue;

            PlayerTextDrawHide(playerid, RentacarTD[playerid][i]);
            PlayerTextDrawDestroy(playerid, RentacarTD[playerid][i]);
            RentacarTD[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
        }
        CancelSelectTextDraw(playerid);
    }
}
