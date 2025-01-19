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
 *  @Author         Vostic & Nodi
 *  @Github         (github.com/vosticdev) & (github.com/DinoWETT)
 *  @Date           19th Sep 2023
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           vipsys.pwn
 *  @Module         misc

*/

#include <ysilib\YSI_Coding\y_hooks>

enum _weaponInfos{
	wName[24],
	wID,
	wSlot,
	wModel
}

#define MAX_DROPPED_GUNS 1000

enum e_DROP_GUN_DATA {
	Float:ObjPos[ 3 ],
	gObjID,
	ObjData[ 2 ]
}
new dGunData[ MAX_DROPPED_GUNS ][ e_DROP_GUN_DATA ];
new gDropGunCoolDown[MAX_PLAYERS];

new WeaponInfos[ 47 ][ _weaponInfos ] = {
	{"No gun", 0, 0, 0 },
	{"Brass Knuckles", 1, 0, 331 },
	{"Golf Club", 2, 1, 333 },
	{"Nightstick", 3, 1, 334 },
	{"Knife", 4, 1, 335 },
	{"Baseball Bat", 5, 1, 336 },
	{"Shovel", 6, 1, 337 },
	{"Pool Cue", 7, 1, 338 },
	{"Katana", 8, 1, 339 },
	{"Chainsaw", 9, 1, 341 },
	{"Double-ended Dildo", 10, 10, 321 },
	{"Dildo", 11, 10, 321 },
	{"Vibrator", 12, 10, 323 },
	{"Silver Vibrator", 13, 10, 324 },
	{"Flowers", 14, 10, 325 },
	{"Cane", 15, 10, 326 },
	{"Grenade", 16, 8, 342 },
	{"Tear Gas", 17, 8, 343 },
	{"Molotov Cocktail", 18, 8, 344 },
	{"No gun", 19, -1, 0 },
	{"No gun", 20, -1, 0 },
	{"No gun", 21, -1, 0 },
	{"Colt .45", 22, 2, 346 },
	{"Silenced Colt .45", 23, 2, 347 },
	{"Desert Eagle", 24, 2, 348 },
	{"Shotgun", 25, 3, 349 },
	{"Sawnoff Shotgun", 26, 3, 350 },
	{"Combat Shotgun", 27, 3, 351 },
	{"Micro SMG", 28, 4, 352 },
	{"MP5", 29, 4, 353 },
	{"AK47", 30, 5, 355 },
	{"M4", 31, 5, 356 },
	{"Tec-9", 32, 4, 372 },
	{"Country Rifle", 33, 6, 357 },
	{"Sniper Rifle", 34, 6, 358 },
	{"RPG", 35, 7, 359 },
	{"HS Rocket", 36, 7, 0 },
	{"Flamethrower", 37, 7, 361 },
	{"Minigun", 38, 7, 362 },
	{"Satchel Charge", 39, 8, 363 },
	{"Detonator", 40, 12, 364 },
	{"Spraycan", 41, 9, 365 },
	{"Fire Extinguisher", 42, 9, 366 },
	{"Camera", 43, 9, 367 },
	{"Night Vis Goggles", 44, 11, 368 },
	{"Thermal Goggles", 45, 11, 369 },
	{"Parachute", 46, 11, 371 }
};

hook OnPlayerConnect(playerid) {

    gDropGunCoolDown[playerid] = gettime();

    return Y_HOOKS_CONTINUE_RETURN_1;
}

YCMD:dropgun( playerid, params[], help ) {
    
    if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return SendServerMessage( playerid, "Morate biti van vozila kako biste bacili oruzje." );
	if(gDropGunCoolDown[playerid] > gettime()) return SendServerMessage( playerid, "Morate sacekati jos %d sekundi da bi ponovo bacili oruzje.", convertTime( gDropGunCoolDown[ playerid ]-gettime() ));
	
	new WEAPON:tmp_gun = GetPlayerWeapon( playerid );
	new tmp_ammo = GetPlayerAmmo(playerid);

    new tmp_str[248];

	if( tmp_gun > WEAPON_FIST && tmp_ammo != 0 ) {
	    
        new tmp_id = -1;

        for( new j = 0; j < MAX_DROPPED_GUNS; j++ ) {

            if( dGunData[ j ][ ObjPos ][ 0 ] == 0.0 ) {

                tmp_id = j;
                break;
            }
        }

        if( tmp_id == -1 ) return SendServerMessage( playerid, "Trenutno ne mozes baciti oruzje na pod." );
        RemovePlayerWeapon( playerid, tmp_gun );

        dGunData[tmp_id][ ObjData ][ 0 ] = tmp_gun;
        dGunData[tmp_id][ ObjData ][ 1 ] = tmp_ammo;

        gDropGunCoolDown[playerid] = gettime() + 5;

        GetPlayerPos( playerid, dGunData[tmp_id][ ObjPos ][ 0 ], dGunData[tmp_id][ ObjPos ][ 1 ], dGunData[tmp_id][ ObjPos ][ 2 ] );
        dGunData[tmp_id][ gObjID ] = CreateDynamicObject( WeaponInfos[ tmp_gun ][ wModel ], dGunData[tmp_id][ ObjPos ][ 0 ], dGunData[tmp_id][ ObjPos ][ 1 ], dGunData[tmp_id][ ObjPos ][ 2 ]-1, 93.7, 120.0, 120.0 );
        SendClientMessage( playerid, x_ltorange, "Bacio si oruzje "c_white"%s.", WeaponInfos[ dGunData[tmp_id][ ObjData ][ 0 ] ][ wName ] );

        format( tmp_str, sizeof( tmp_str ), "* %s baca oruzje na pod.", ReturnCharacterName( playerid ) );
        ProxDetector(playerid, 10.0, x_grey, tmp_str);

    }
	return true;
}


YCMD:pickupgun( playerid, params[], help ) {

    if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return SendServerMessage( playerid, "Morate biti van vozila kako biste bacili oruzje." );

    static tmp_str[248];
	new tmp_id = -1;
	for( new a = 0; a < MAX_DROPPED_GUNS; a++ ) {
		if( IsPlayerInRangeOfPoint( playerid, 5.0, dGunData[ a ][ ObjPos ][ 0] , dGunData[ a ][ ObjPos ][ 1 ], dGunData[ a ][ ObjPos ][ 2 ] ) ) {
			tmp_id = a;
		    break;
		}
	}
	if( tmp_id == -1 ) return SendServerMessage( playerid, "Ne nalazite se blizu dropovanog oruzja." );
	if( IsValidDynamicObject( dGunData[tmp_id][ gObjID ] ) ) DestroyDynamicObject( dGunData[tmp_id][ gObjID ] );

	GivePlayerWeapon( playerid, WEAPON:dGunData[tmp_id][ ObjData ][ 0 ], dGunData[tmp_id][ ObjData ][ 1 ] );

	dGunData[tmp_id][ ObjPos ][ 0 ] = 0.0;
	dGunData[tmp_id][ ObjPos ][ 1 ] = 0.0;
	dGunData[tmp_id][ ObjPos ][ 2 ] = 0.0;
	dGunData[tmp_id][ gObjID ] = -1;
	dGunData[tmp_id][ ObjData ][ 0 ] = 0;
	dGunData[tmp_id][ ObjData ][ 1 ] = 0;

	format( tmp_str, sizeof( tmp_str ), "%s podize oruzje sa poda.", ReturnCharacterName( playerid ) );
	ProxDetector(playerid, 10.0, x_grey, tmp_str);

	return true;
}