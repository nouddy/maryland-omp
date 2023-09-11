/*

    ? Map optimization by Ferid
    ? Credits : Levu on BS
    ? @TODO: Izbaciti opti-draw.inc potpuno.

*/


Object_IsLarge( id ) {
	switch( id ) {
		case 7584, 8395, 9901, 6863: return true;
	}
	return false;
}

Object_IsMedium( id ) {
	switch( id ) {
		case 18981, 19377, 18766: return true;
	}
	return false;
}


Maryland_CreateDynamicObject( objid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = 300.0, Float:drawdistance = 300.0, areaid = -1, priority = 0 )
{
	if( Object_IsLarge( objid ) ) {
		streamdistance = 800.0;
		drawdistance = 800.0;
		priority = 8;
	}
	else if( Object_IsMedium( objid ) ) {
		streamdistance = 500.0;
		drawdistance = 500.0;
		priority = 6;
	}
	return CreateDynamicObject( objid, x, y, z, rx, ry, rz, worldid, interiorid, playerid, streamdistance, drawdistance, areaid, priority ); 
}