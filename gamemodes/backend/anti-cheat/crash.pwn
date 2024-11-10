

//*==============================================================================
//*--->>> Hooks
//*==============================================================================

hook OnPlayerWeaponShot(playerid, WEAPON:weaponid, BULLET_HIT_TYPE:hittype, hitid, Float:fX, Float:fY, Float:fZ) {

    if( hittype != BULLET_HIT_TYPE_NONE ) {
        if( !( -1000.0 <= fX <= 1000.0 ) || !( -1000.0 <= fY <= 1000.0 ) || !( -1000.0 <= fZ <= 1000.0 ) ) {
			ACKick( playerid, "Bullet Crasher");
            return Y_HOOKS_BREAK_RETURN_1;
		}
    }
    if( hittype == BULLET_HIT_TYPE_PLAYER ) {
        if( hitid == playerid ) {
			ACKick(playerid, "Bullet Crasher");
        	return Y_HOOKS_BREAK_RETURN_1;
		}
    }
    
    if( hittype == BULLET_HIT_TYPE_PLAYER ) {
        if( fX == 0.000000 && fY == 0.000000 && fZ == 0.500000 && weaponid == UNKNOWN_WEAPON ) {
			ACKick( playerid, "Command Kill");
        	return Y_HOOKS_BREAK_RETURN_1;
        }
    }

    if( hittype == BULLET_HIT_TYPE_NONE && !Weapon_IsValid( weaponid ) ) {
        if( fX == 0.000000 && fY == 0.000000 && fZ == 0.000000 ) {
			ACKick( playerid, "Bullet Crasher");
        	return Y_HOOKS_BREAK_RETURN_1;
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

stock JetPack_OnPlayerUpdate(playerid) {

    if( GetPlayerCameraMode( playerid ) == CAM_MODE_AIMWEAPON ) {
        new Float:cPos[ 3 ];

        GetPlayerCameraPos( playerid, cPos[0], cPos[1], cPos[2] );

        if( cPos[2] < -50000.0 || cPos[2] > 50000.0 ) {
            ACKick( playerid, "Weapon Crasher");
            return Y_HOOKS_BREAK_RETURN_1;
        }
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}