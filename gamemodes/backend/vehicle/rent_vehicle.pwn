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
 *  @File           rent_vehicle.pwn
 *  @Module         vehicle
 */


#include <ysilib\YSI_Coding\y_hooks>

#define MAX_RENTALS (100)
#define INVALID_RENTAL_ID (-1)
#define RENTAL_PRICE_PER_MIN (5.0)

// Rent Enum
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

// Variables for rent - player side
new bool:PlayerRenting[MAX_PLAYERS],
    PlayerRentModel[MAX_PLAYERS],
    PlayerRentalVehicle[MAX_PLAYERS],
    PlayerRentalTimer[MAX_PLAYERS],
    bool:RentShown[MAX_PLAYERS],
    Text3D:RentVehLabel[MAX_PLAYERS];

// rent td
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

hook OnPlayerConnect(playerid)
{
    PlayerRenting[playerid] = false;
    RentShown[playerid] = false;
    PlayerRentModel[playerid] = INVALID_RENTAL_ID;
    PlayerRentalVehicle[playerid] = INVALID_VEHICLE_ID;
    PlayerRentalTimer[playerid] = -1;

    if(IsValid3DTextLabel(RentVehLabel[playerid]))
        Delete3DTextLabel(RentVehLabel[playerid]);

    return Y_HOOKS_CONTINUE_RETURN_1;

}

hook OnPlayerDisconnect(playerid, reason) {

    if(PlayerRenting[playerid]) {

        DestroyVehicle(PlayerRentalVehicle[playerid]);
        Delete3DTextLabel(RentVehLabel[playerid]);
        KillTimer(PlayerRentalTimer[playerid]);

        PlayerRentModel[playerid] = INVALID_RENTAL_ID;
        PlayerRentalVehicle[playerid] = INVALID_RENTAL_ID;
        PlayerRenting[playerid] = false;

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

////////////////////////////////////////////////////////////
//?Hooks
///////////////////////////////////////////////////////////

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if(!ispassenger && PlayerRentalVehicle[playerid] != vehicleid)  //* Jer si napravio provjeru samo ako je igrac na vozacevom mjestu
    {
		foreach(new i : Player)
		{
  			if(GetPlayerVehicleID(i) == vehicleid && GetPlayerState(i) == PLAYER_STATE_DRIVER) 
	    	{
				if(GetPlayerStaffLevel(playerid) < 4)
				{
			 		new Float:pPos[3];
					GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
					SetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
					ClearAnimations(playerid);
			  		GameTextForPlayer(playerid, "~r~GDE CES???~n~ovo nije tvoje vozilo!", 5000, 3);
			  		return ~1;
				}
			}
		}
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
    if(PRESSED(KEY_NO))
    {
        if(IsPlayerNearRent(playerid) != INVALID_RENTAL_ID)
        {
            if(PlayerRenting[playerid]) return SendClientMessage(playerid, x_red, "maryland \187; "c_white"Vec rentas vozilo.");

            new rID = IsPlayerNearRent(playerid);
            RentaCar_Interface(playerid, true);

            foreach(new i : iter_Rental) {

                if(PlayerRental[rID][rentID]  == PlayerRental[i][rentID]) {

                    PlayerTextDraw_UpdateModel(playerid, RentacarTD[playerid][12], PlayerRental[i][rentVehModels][0]);
                    PlayerTextDraw_UpdateModel(playerid, RentacarTD[playerid][13], PlayerRental[i][rentVehModels][1]);
                    PlayerTextDraw_UpdateModel(playerid, RentacarTD[playerid][14], PlayerRental[i][rentVehModels][2]);
                    break;
                }
            }
        }
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if(!Rent_IsInterfaceActive(playerid)) 
        return Y_HOOKS_CONTINUE_RETURN_1;

    if(clickedid == INVALID_TEXT_DRAW)
    {
        RentaCar_Interface(playerid, false);
        CancelSelectTextDraw(playerid);

        return Y_HOOKS_BREAK_RETURN_1;
    }

	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
    if(!Rent_IsInterfaceActive(playerid)) 
        return Y_HOOKS_CONTINUE_RETURN_1;

    new rID = IsPlayerNearRent(playerid);
    foreach (new i : iter_Rental)
    {
        if (PlayerRental[rID][rentID] == PlayerRental[i][rentID])
        {
            if (playertextid == RentacarTD[playerid][12])
            {
                PlayerRentModel[playerid] = PlayerRental[i][rentVehModels][0];
                Dialog_Show(playerid, dialog_rentveh, DIALOG_STYLE_INPUT, "Maryland Rent", "Upisite na koje vreme zelite iznajmiti vozilo:\n\n** CENA RENTA JE 5$ PO MINUTI.", "Dalje", "Izlaz");

            }
            if (playertextid == RentacarTD[playerid][13])
            {
                PlayerRentModel[playerid] = PlayerRental[i][rentVehModels][1];
                Dialog_Show(playerid, dialog_rentveh, DIALOG_STYLE_INPUT, "Maryland Rent", "Upisite na koje vreme zelite iznajmiti vozilo:\n\n** CENA RENTA JE 5$ PO MINUTI.", "Dalje", "Izlaz");

            }
            if (playertextid == RentacarTD[playerid][14])
            {
                PlayerRentModel[playerid] = PlayerRental[i][rentVehModels][2];
                Dialog_Show(playerid, dialog_rentveh, DIALOG_STYLE_INPUT, "Maryland Rent", "Upisite na koje vreme zelite iznajmiti vozilo:\n\n** CENA RENTA JE 5$ PO MINUTI.", "Dalje", "Izlaz");
            }
            break;
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

Dialog: dialog_rentveh(const playerid, response, listitem, string: inputtext[])
{
    if(!response)
    {
        RentaCar_Interface(playerid, false);
        CancelSelectTextDraw(playerid);
        SendClientMessage(playerid, x_server, "maryland \187; "c_white"Odustali ste od iznajmljivanja vozila.");
    }

	if(response)
	{
        new time;

        if(sscanf(inputtext, "i", time))
			return  Dialog_Show(playerid, dialog_rentveh, DIALOG_STYLE_INPUT, "Maryland Rent", "Upisite na koje vreme zelite iznajmiti vozilo:\n\n** CENA RENTA JE 5$ PO MINUTI.", "Dalje", "Izlaz");

        if(!IsNumeric(inputtext))
            return Dialog_Show(playerid, dialog_rentveh, DIALOG_STYLE_INPUT, "Maryland Rent", "Upisite na koje vreme zelite iznajmiti vozilo:\n\n** CENA RENTA JE 5$ PO MINUTI.", "Dalje", "Izlaz");

        if(GetPlayerMoney(playerid) < RENTAL_PRICE_PER_MIN*time)
            return  Dialog_Show(playerid, dialog_rentveh, DIALOG_STYLE_INPUT, "Maryland Rent", "Upisite na koje vreme zelite iznajmiti vozilo:\n\n** CENA RENTA JE 5$ PO MINUTI.", "Dalje", "Izlaz");


        RentInProgress(playerid, PlayerRentModel[playerid], time);
        RentaCar_Interface(playerid, false);
        CancelSelectTextDraw(playerid);
        SendClientMessage(playerid, x_server, "maryland \187; "c_white"Uspe�no ste iznajmili vozilo na %d minuta.", time);
	}

	return Y_HOOKS_CONTINUE_RETURN_1;
}

//COMMANDS

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

YCMD:unrent(playerid, params[], help) 
{ 
    if (!PlayerRenting[playerid]) return SendClientMessage(playerid, x_red, "maryland \187; "c_white"Nemas rentano vozilo.");

    DestroyVehicle(PlayerRentalVehicle[playerid]);
    Delete3DTextLabel(RentVehLabel[playerid]);
    PlayerRentModel[playerid] = INVALID_RENTAL_ID;
    PlayerRentalVehicle[playerid] = INVALID_VEHICLE_ID;

    PlayerRenting[playerid] = false;

    KillTimer(PlayerRentalTimer[playerid]);

    SendClientMessage(playerid, x_server, "maryland \187; "c_white"Vratio si rentovano vozilo.");
    
    return true;
}

//

//? FPS
forward Create_Rent(id);
public Create_Rent(id) {

	PlayerRental[id][rentID] = cache_insert_id();
	Iter_Add(iter_Rental, id);

    PlayerRental[id][rentalPickup] = CreatePickup(2485, 1, PlayerRental[id][rentalPos][0],PlayerRental[id][rentalPos][1], PlayerRental[id][rentalPos][2], 0);
    PlayerRental[id][RentalLabel] = Create3DTextLabel(""c_server" \187; "c_grey"Za rent pritisnite 'N' "c_server"\171;", -1, PlayerRental[id][rentalPos][0],PlayerRental[id][rentalPos][1],PlayerRental[id][rentalPos][2], 3.50, -1);

	return (true);
}

// Timer 
forward ExpireRental(playerid);
public ExpireRental(playerid)
{

    DestroyVehicle(PlayerRentalVehicle[playerid]);
    Delete3DTextLabel(RentVehLabel[playerid]);

    PlayerRentModel[playerid] = INVALID_RENTAL_ID;
    PlayerRentalVehicle[playerid] = INVALID_VEHICLE_ID;

    PlayerRenting[playerid] = false;

    KillTimer(PlayerRentalTimer[playerid]);

    SendClientMessage(playerid, x_server, "maryland \187; "c_white"Istekao ti je rent, vozilo je vraceno rent kuci.");
    
    return true;
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
        RentShown[playerid] = true;

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
        RentShown[playerid] = false;
        CancelSelectTextDraw(playerid);
    }
}


stock Rent_IsInterfaceActive(playerid) {

    return RentShown[playerid];
}


stock RentInProgress(playerid, model, time)
{
    new Float:pPos[4];
    GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
    GetPlayerFacingAngle(playerid, pPos[3]);

    PlayerRentalVehicle[playerid] = CreateVehicle(model, pPos[0] + 2.0, pPos[1], pPos[2], pPos[3], -1, -1, 0);

    PutPlayerInVehicle(playerid, PlayerRentalVehicle[playerid], 0);

    PlayerRenting[playerid] = true;

    new stringic[128];
    format(stringic, sizeof(stringic), ""c_server"\187;"c_white"Rent Vehicle"c_server"\171;\n\187;"c_white"Vlasnik: %s"c_server"\171;", ReturnPlayerName(playerid));

    RentVehLabel[playerid] = Create3DTextLabel(stringic, -1, pPos[0], pPos[1], pPos[2] + 2.0, 10.0, 0);
    Attach3DTextLabelToVehicle(RentVehLabel[playerid], PlayerRentalVehicle[playerid],  0.0, 0.0, 0.0);
    PlayerRentalTimer[playerid] = SetTimerEx("ExpireRental", time*60000, false, "i", playerid);

    GivePlayerMoney(playerid, -RENTAL_PRICE_PER_MIN*time, MONEY_TYPE_DOLLAR);

    SendClientMessage(playerid, x_server, "maryland \187; "c_white"Uspesno si rentao vozilo marke "c_server"%s "c_white"za "c_server"$%.2f.", ReturnVehicleModelName(model), RENTAL_PRICE_PER_MIN*time);

    return true;
}


IsPlayerNearRent(playerid) {

    foreach(new j : iter_Rental) {

        if(IsPlayerInRangeOfPoint(playerid, 4.0, PlayerRental[j][rentalPos][0], PlayerRental[j][rentalPos][1], PlayerRental[j][rentalPos][2])) return j;
    }
    return INVALID_RENTAL_ID;
}
