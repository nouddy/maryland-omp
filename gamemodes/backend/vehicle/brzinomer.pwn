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
 *  @File           brzinomer.script
 *  @Module         vehicle
 */

#include <ysilib\YSI_Coding\y_hooks>
//////////////////////////////////////// PlayerTextDraws Imena (Defines) ///////////////////////////////////////////////////
new PlayerText:speed_TD[MAX_PLAYERS][11];

//
//
hook OnGameModeInit()
{
    print("frontend/speed_TD.tde loaded");

    return Y_HOOKS_CONTINUE_RETURN_1;
}
//
new stock g_arrVehicleNames[][] = {
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
    "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
    "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach",
    "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
    "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
    "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
    "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
    "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
    "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
    "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
    "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
    "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
    "Fortune", "Cadrona", "SWAT Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Streak", "Freight", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
    "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "LSPD Car", "SFPD Car", "LVPD Car",
    "Police Rancher", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
    "Boxville", "Tiller", "Utility Trailer"
};
//

hook OnPlayerStateChange(playerid, PLAYER_STATE:newstate, PLAYER_STATE:oldstate)
{
    new vehicle = GetPlayerVehicleID( playerid );
    new string[32];
    if( newstate == PLAYER_STATE_DRIVER ) {

        printf("%d Vlasnik vozila - %d Vozilo ID", eVehicle[vehicle][vOwner], eVehicle[vehicle][vID]);

        if( !IsVehicleBicycle(vehicle)) {

            BuildSpeedTextDraws(playerid, true);
            // Model vozila
            PlayerTextDrawSetPreviewModel(playerid, speed_TD[playerid][3], GetVehicleModel(vehicle));
            PlayerTextDrawShow(playerid, speed_TD[playerid][3]);

            // Ime vozila
            format( string, sizeof( string ), "%s", ReturnVehicleModelName(GetVehicleModel(vehicle)));
            PlayerTextDrawSetString( playerid, speed_TD[playerid][8], string );

            new miles[ 64 ];
            format( miles, sizeof( miles ), "%dkm", eVehicle[vehicle][vRangeKM]);
            PlayerTextDrawSetString(playerid, speed_TD[playerid][7], miles);
        }
    }
    else if( newstate == PLAYER_STATE_ONFOOT ) {
        BuildSpeedTextDraws(playerid, false);
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}

ptask BrzinomerUpdate[1000](playerid)
{
    if( IsPlayerInAnyVehicle( playerid ) && GetPlayerState( playerid ) == PLAYER_STATE_DRIVER ) {

        new vehicle = GetPlayerVehicleID(playerid);

        if(!IsVehicleBicycle(vehicle)) 
        {
            if(eVehicle[vehicle][vOwner] == VEHICLE_OWNER_NONE) {

				eVehicle[ vehicle ][ vRange ] += ( GetSpeed(playerid)*10 )/36;
				if( eVehicle[ vehicle ][ vRange ] > 999 )
				{
					eVehicle[ vehicle ][ vRangeKM ]++;
					eVehicle[ vehicle ][ vRange ] = 0;
                    printf("%d - Nova kilometraza, %d - Novi metri", eVehicle[vehicle][vRangeKM], eVehicle[vehicle][vRange]);
				}
            }

            if(eVehicle[vehicle][vOwner] == PlayerInfo[playerid][SQLID]) {
                
				eVehicle[ vehicle ][ vRange ] += ( GetSpeed(playerid)*10 )/36;
				if( eVehicle[ vehicle ][ vRange ] > 999 )
				{
					eVehicle[ vehicle ][ vRangeKM ]++;
					eVehicle[ vehicle ][ vRange ] = 0;

                    new query[350];

                    format(query, sizeof(query), "UPDATE `vehicles` SET `vRange` = '%d', `vRangeKM` = '%d' WHERE `vOwner` = '%d'", eVehicle[vehicle][vRange], eVehicle[vehicle][vRangeKM], eVehicle[vehicle][vOwner]);
                    mysql_tquery(SQL, query);
				}
            }

            new string[ 32 ];
            format( string, sizeof( string ), "%d", GetSpeed( playerid ) );
            PlayerTextDrawSetString( playerid, speed_TD[playerid][2], string );

            new miles[ 64 ];
            format( miles, sizeof( miles ), "%dkm", eVehicle[vehicle][vRangeKM]);
            PlayerTextDrawSetString( playerid, speed_TD[playerid][7], miles);

        }

    }    
    return 1;
}
hook OnPlayerDisconnect(playerid, reason)
{
    BuildSpeedTextDraws(playerid, false);

    return Y_HOOKS_CONTINUE_RETURN_1;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////

forward BuildSpeedTextDraws(playerid, bool:show);
public BuildSpeedTextDraws(playerid, bool:show)
{
    if(show == true)
    {
        for(new i = 0; i < 11; i++)
        {
            PlayerTextDrawHide( playerid, speed_TD[ playerid ][ i ] );
            PlayerTextDrawDestroy( playerid, speed_TD[ playerid ][ i ] );
            speed_TD[ playerid ][ i ] = PlayerText:INVALID_TEXT_DRAW;
        }
        speed_TD[playerid][0] = CreatePlayerTextDraw(playerid, 420.100524, 381.657409, "");
        PlayerTextDrawTextSize(playerid, speed_TD[playerid][0], 161.000000, 36.000000);
        PlayerTextDrawAlignment(playerid, speed_TD[playerid][0], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, speed_TD[playerid][0], 404232292);
        PlayerTextDrawSetShadow(playerid, speed_TD[playerid][0], 0);
        PlayerTextDrawBackgroundColour(playerid, speed_TD[playerid][0], 0xFFFFFF00);
        PlayerTextDrawFont(playerid, speed_TD[playerid][0], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, speed_TD[playerid][0], false);
        PlayerTextDrawSetPreviewModel(playerid, speed_TD[playerid][0], 1317);
        PlayerTextDrawSetPreviewRot(playerid, speed_TD[playerid][0], -30.000000, 0.000000, 90.000000, 1.000000);

        speed_TD[playerid][1] = CreatePlayerTextDraw(playerid, 420.100524, 381.657409, "");
        PlayerTextDrawTextSize(playerid, speed_TD[playerid][1], 161.000000, 36.000000);
        PlayerTextDrawAlignment(playerid, speed_TD[playerid][1], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, speed_TD[playerid][1], 404232292);
        PlayerTextDrawSetShadow(playerid, speed_TD[playerid][1], 0);
        PlayerTextDrawBackgroundColour(playerid, speed_TD[playerid][1], 0xFFFFFF00);
        PlayerTextDrawFont(playerid, speed_TD[playerid][1], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, speed_TD[playerid][1], false);
        PlayerTextDrawSetPreviewModel(playerid, speed_TD[playerid][1], 1317);
        PlayerTextDrawSetPreviewRot(playerid, speed_TD[playerid][1], -30.000000, 0.000000, 90.000000, 1.000000);

        speed_TD[playerid][2] = CreatePlayerTextDraw(playerid, 501.100189, 394.848205, "000");
        PlayerTextDrawLetterSize(playerid, speed_TD[playerid][2], 0.156663, 0.878220);
        PlayerTextDrawAlignment(playerid, speed_TD[playerid][2], TEXT_DRAW_ALIGN_CENTRE);
        PlayerTextDrawColour(playerid, speed_TD[playerid][2], -1);
        PlayerTextDrawSetShadow(playerid, speed_TD[playerid][2], 1);
        PlayerTextDrawBackgroundColour(playerid, speed_TD[playerid][2], 34);
        PlayerTextDrawFont(playerid, speed_TD[playerid][2], TEXT_DRAW_FONT_2);
        PlayerTextDrawSetProportional(playerid, speed_TD[playerid][2], true);

        speed_TD[playerid][3] = CreatePlayerTextDraw(playerid, 482.032257, 392.229766, "");
        PlayerTextDrawTextSize(playerid, speed_TD[playerid][3], 39.000000, 43.000000);
        PlayerTextDrawAlignment(playerid, speed_TD[playerid][3], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, speed_TD[playerid][3], -1);
        PlayerTextDrawSetShadow(playerid, speed_TD[playerid][3], 0);
        PlayerTextDrawFont(playerid, speed_TD[playerid][3], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, speed_TD[playerid][3], false);
        PlayerTextDrawSetPreviewModel(playerid, speed_TD[playerid][3], 411);
        PlayerTextDrawBackgroundColour(playerid, speed_TD[playerid][3], 0);
        PlayerTextDrawSetPreviewRot(playerid, speed_TD[playerid][3], 0.000000, 0.000000, 90.000000, 1.000000);
        PlayerTextDrawSetPreviewVehicleColours(playerid, speed_TD[playerid][3], 1, 1);

        speed_TD[playerid][4] = CreatePlayerTextDraw(playerid, 532.000488, 397.637145, "model");
        PlayerTextDrawLetterSize(playerid, speed_TD[playerid][4], 0.094663, 0.600296);
        PlayerTextDrawAlignment(playerid, speed_TD[playerid][4], TEXT_DRAW_ALIGN_CENTRE);
        PlayerTextDrawColour(playerid, speed_TD[playerid][4], -1);
        PlayerTextDrawSetShadow(playerid, speed_TD[playerid][4], 0);
        PlayerTextDrawBackgroundColour(playerid, speed_TD[playerid][4], 34);
        PlayerTextDrawFont(playerid, speed_TD[playerid][4], TEXT_DRAW_FONT_2);
        PlayerTextDrawSetProportional(playerid, speed_TD[playerid][4], true);

        speed_TD[playerid][5] = CreatePlayerTextDraw(playerid, 501.200195, 401.948638, "~w~km/h");
        PlayerTextDrawLetterSize(playerid, speed_TD[playerid][5], 0.087999, 0.455110);
        PlayerTextDrawAlignment(playerid, speed_TD[playerid][5], TEXT_DRAW_ALIGN_CENTRE);
        PlayerTextDrawColour(playerid, speed_TD[playerid][5], 255);
        PlayerTextDrawSetShadow(playerid, speed_TD[playerid][5], 1);
        PlayerTextDrawBackgroundColour(playerid, speed_TD[playerid][5], 34);
        PlayerTextDrawFont(playerid, speed_TD[playerid][5], TEXT_DRAW_FONT_2);
        PlayerTextDrawSetProportional(playerid, speed_TD[playerid][5], true);

        speed_TD[playerid][6] = CreatePlayerTextDraw(playerid, 469.634399, 397.551910, "benzin");
        PlayerTextDrawLetterSize(playerid, speed_TD[playerid][6], 0.094663, 0.600296);
        PlayerTextDrawAlignment(playerid, speed_TD[playerid][6], TEXT_DRAW_ALIGN_CENTRE);
        PlayerTextDrawColour(playerid, speed_TD[playerid][6], -1);
        PlayerTextDrawSetShadow(playerid, speed_TD[playerid][6], 0);
        PlayerTextDrawBackgroundColour(playerid, speed_TD[playerid][6], 34);
        PlayerTextDrawFont(playerid, speed_TD[playerid][6], TEXT_DRAW_FONT_2);
        PlayerTextDrawSetProportional(playerid, speed_TD[playerid][6], true);

        speed_TD[playerid][7] = CreatePlayerTextDraw(playerid, 469.634399, 402.552215, "~w~0000000km");
        PlayerTextDrawLetterSize(playerid, speed_TD[playerid][7], 0.094663, 0.600296);
        PlayerTextDrawAlignment(playerid, speed_TD[playerid][7], TEXT_DRAW_ALIGN_CENTRE);
        PlayerTextDrawColour(playerid, speed_TD[playerid][7], -1061109505);
        PlayerTextDrawSetShadow(playerid, speed_TD[playerid][7], 0);
        PlayerTextDrawBackgroundColour(playerid, speed_TD[playerid][7], 34);
        PlayerTextDrawFont(playerid, speed_TD[playerid][7], TEXT_DRAW_FONT_2);
        PlayerTextDrawSetProportional(playerid, speed_TD[playerid][7], true);

        speed_TD[playerid][8] = CreatePlayerTextDraw(playerid, 531.901611, 402.552307, "infernus");
        PlayerTextDrawLetterSize(playerid, speed_TD[playerid][8], 0.094663, 0.600296);
        PlayerTextDrawAlignment(playerid, speed_TD[playerid][8], TEXT_DRAW_ALIGN_CENTRE);
        PlayerTextDrawColour(playerid, speed_TD[playerid][8], -1061109505);
        PlayerTextDrawSetShadow(playerid, speed_TD[playerid][8], 0);
        PlayerTextDrawBackgroundColour(playerid, speed_TD[playerid][8], 34);
        PlayerTextDrawFont(playerid, speed_TD[playerid][8], TEXT_DRAW_FONT_2);
        PlayerTextDrawSetProportional(playerid, speed_TD[playerid][8], true);

        speed_TD[playerid][9] = CreatePlayerTextDraw(playerid, 441.767303, 394.931579, "");
        PlayerTextDrawTextSize(playerid, speed_TD[playerid][9], 55.000000, 15.000000);
        PlayerTextDrawAlignment(playerid, speed_TD[playerid][9], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, speed_TD[playerid][9], 404232292);
        PlayerTextDrawSetShadow(playerid, speed_TD[playerid][9], 0);
        PlayerTextDrawBackgroundColour(playerid, speed_TD[playerid][9], 0xFFFFFF00);
        PlayerTextDrawFont(playerid, speed_TD[playerid][9], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, speed_TD[playerid][9], false);
        PlayerTextDrawSetPreviewModel(playerid, speed_TD[playerid][9], 1317);
        PlayerTextDrawSetPreviewRot(playerid, speed_TD[playerid][9], -30.000000, 0.000000, 90.000000, 1.000000);

        speed_TD[playerid][10] = CreatePlayerTextDraw(playerid, 504.934509, 394.931610, "");
        PlayerTextDrawTextSize(playerid, speed_TD[playerid][10], 55.000000, 15.000000);
        PlayerTextDrawAlignment(playerid, speed_TD[playerid][10], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, speed_TD[playerid][10], 404232292);
        PlayerTextDrawSetShadow(playerid, speed_TD[playerid][10], 0);
        PlayerTextDrawBackgroundColour(playerid, speed_TD[playerid][10], 0xFFFFFF00);
        PlayerTextDrawFont(playerid, speed_TD[playerid][10], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawSetProportional(playerid, speed_TD[playerid][10], false);
        PlayerTextDrawSetPreviewModel(playerid, speed_TD[playerid][10], 1317);
        PlayerTextDrawSetPreviewRot(playerid, speed_TD[playerid][10], -30.000000, 0.000000, 90.000000, 1.000000);

        for(new i = 0; i < 11; i++) { PlayerTextDrawShow(playerid, speed_TD[playerid][i]); }

    }
    else
    {
        for(new i = 0; i < 11; i++)
        {
            PlayerTextDrawHide( playerid, speed_TD[ playerid ][ i ] );
            PlayerTextDrawDestroy( playerid, speed_TD[ playerid ][ i ] );
            speed_TD[ playerid ][ i ] = PlayerText:INVALID_TEXT_DRAW;
        }
    }
}

stock GetSpeed(playerid) {
    new Float:ST[ 4 ];
    if( IsPlayerInAnyVehicle( playerid ) )
    	GetVehicleVelocity( GetPlayerVehicleID( playerid ), ST[ 0 ], ST[ 1 ], ST[ 2 ] );
    else
		GetPlayerVelocity( playerid, ST[ 0 ], ST[ 1 ], ST[ 2 ] );

    ST[ 3 ] = floatsqroot(floatpower(floatabs(ST[ 0 ]), 2.0) + floatpower(floatabs(ST[ 1 ]), 2.0) + floatpower(floatabs(ST[ 2 ]), 2.0)) * 178.8617875;
    return floatround( ST[ 3 ] );
}

ReturnVehicleModelName(model)
{
    new
        name[32] = "None";

    if (model < 400 || model > 611)
        return name;

    format(name, sizeof(name), g_arrVehicleNames[model - 400]);
    return name;
}