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
 *  @Author         Vostic & Ogy_
 *  @Date           29th May 2023
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           ulazi-izlazi.entrance
 *  @Module         entrance
*/

#include <ysilib\YSI_Coding\y_hooks>


forward UlaziIzlazi(playerid);
public UlaziIzlazi(playerid)
{
    static
        id = -1,entrance_finded = false;

    if ((id = Business_Nearest(playerid)) != -1)
    {
        if (BusinessData[id][bizLocked])
            return SendClientMessage(playerid, x_red,"This business is closed by the owner.");

        SetPlayerPos(playerid, BusinessData[id][bizInt][0], BusinessData[id][bizInt][1], BusinessData[id][bizInt][2]);
        SetPlayerFacingAngle(playerid, BusinessData[id][bizInt][3]);

        SetPlayerInterior(playerid, BusinessData[id][bizInterior]);
        SetPlayerVirtualWorld(playerid, BusinessData[id][bizID] + 6000);

        PlayerInfo[playerid][pBiznisID] = BusinessData[id][bizID];

        SetCameraBehindPlayer(playerid);

        if (strlen(BusinessData[id][bizMessage]) && strcmp(BusinessData[id][bizMessage], "NULL", true)) {
            SendClientMessage(playerid, x_ogyColour, BusinessData[id][bizMessage]);
        }
        return 1;
    }
    if ((id = Business_Inside(playerid)) != -1 && IsPlayerInRangeOfPoint(playerid, 2.5, BusinessData[id][bizInt][0], BusinessData[id][bizInt][1], BusinessData[id][bizInt][2]))
    {
        SetPlayerPos(playerid, BusinessData[id][bizPos][0], BusinessData[id][bizPos][1], BusinessData[id][bizPos][2]);
        SetPlayerFacingAngle(playerid, BusinessData[id][bizPos][3] - 180.0);

        SetPlayerInterior(playerid, BusinessData[id][bizExterior]);
        SetPlayerVirtualWorld(playerid, BusinessData[id][bizExteriorVW]);

        SetCameraBehindPlayer(playerid);
        PlayerInfo[playerid][pBiznisID] = -1;
        return 1;
    }
    if( !entrance_finded )
    {
        foreach(new i : Kuce)
        {
            if(IsPlayerInRangeOfPoint( playerid, 2.0, HouseData[ i ][ housePos ][ 0 ], HouseData[ i ][ housePos ][ 1 ], HouseData[ i ][ housePos ][ 2 ] ) )
            {
                if( HouseData[ i ][ houseLocked ] == false)
                {
                    SetPlayerPos( playerid, HouseData[ i ][ housePosInt ][ 0 ], HouseData[ i ][ housePosInt ][ 1 ], HouseData[ i ][ housePosInt ][ 2 ] );
                    UcitajIgracuObjekte( playerid );
                    SetCameraBehindPlayer( playerid );
                    SetPlayerInterior( playerid, HouseData[ i ][ houseInterior ] );
                    SetPlayerVirtualWorld( playerid, HouseData[ i ][ houseInteriorVW ] );
                    SetPlayerTime( playerid, 12, 0 );
                    inProperty[ playerid ] = i;

                    entrance_finded = true;
                    break;
                }
                else return GameTextForPlayer( playerid, "~r~Zakljucano", 5000, 6 );
            }
            else if( IsPlayerInRangeOfPoint( playerid, 2.0, HouseData[ i ][ housePosInt ][ 0 ], HouseData[ i ][ housePosInt ][ 1 ], HouseData[ i ][ housePosInt ][ 2 ] ) && GetPlayerVirtualWorld( playerid ) == HouseData[ i ][ houseInteriorVW ] )
            {
                SetPlayerPos( playerid, HouseData[ i ][ housePos ][ 0 ], HouseData[ i ][ housePos ][ 1 ], HouseData[ i ][ housePos ][ 2 ] );
                UcitajIgracuObjekte( playerid );
                SetCameraBehindPlayer( playerid );
                SetPlayerInterior( playerid, 0);
                SetPlayerVirtualWorld( playerid, 0);
                //SetPlayerTime( playerid, ServerInfo[ VremeInGame ], 0 );
                inProperty[ playerid ] = -1;

                entrance_finded = false;
                break;
            }
        }
    }

    return (true);
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if( PRESSED( KEY_SECONDARY_ATTACK ) ) {
        if( GetPlayerState( playerid ) == 1 ) {
            UlaziIzlazi( playerid );
        }
    }
    return (true);
}

hook OnGameModeInit()
{
    print("entrance/ulazi-izlazi.entrance loaded");  
    return 1;
}