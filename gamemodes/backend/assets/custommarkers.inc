#if !defined _samp_included
    #include "a_samp.inc"
#endif

#if !defined _streamer_included
    #include "streamer.inc"
#endif

#if defined _INC_custommarkers
	#endinput
#endif
#define _INC_custommarkers

#include <ysilib\YSI_Coding\y_hooks>

#if !defined MAX_MARKERS
    #define MAX_MARKERS (401)
#endif

#define INVALID_MARKER_ID (-1)

static const COLOR_ARRAY[] =
{
    0x00000000, 
    0xFF33FFFF, // plava  = klasicna
    0xFFCC00FF,  
    0xEB8C6CFF, // OGY OMILJENA / LJUBICASTA 
    0xFFFF66CC, // roze
    0xFF333333,
    0xFFFFFF00,
    0xFFFF0000
};

enum eMarkerData {

    STREAMER_TAG_AREA:markerArea,
    STREAMER_TAG_OBJECT:markerObject[2],
    Float:markerPos[3],
    markerWorld,
    markerInterior,
    Float:markerStreamDistance,
    markerColour,
}
static markerData[MAX_MARKERS][eMarkerData];


stock IsValidMarker(markerid)
{
    if(markerid < 0 || markerid >= sizeof(markerData)) return false;

    if(markerData[markerid][markerObject][0] != INVALID_STREAMER_ID)
        return true;

    return false;
}

static GetFreeMarkerID() {

    for (new i = 0; i < sizeof(markerData); i++) {

        if (!IsValidMarker(i))
            return i;
    }
    return INVALID_MARKER_ID;
}

stock ResetMarkerData(markerid)
{
    if(markerid < 0 || markerid >= sizeof(markerData)) return false;

    markerData[markerid][markerArea] = INVALID_STREAMER_ID;
    markerData[markerid][markerObject][0] = INVALID_STREAMER_ID;
    markerData[markerid][markerObject][1] = INVALID_STREAMER_ID;

    markerData[markerid][markerPos][0] = 0.0;
    markerData[markerid][markerPos][1] = 0.0;
    markerData[markerid][markerPos][2] = 0.0;

    markerData[markerid][markerWorld] = -1;
    markerData[markerid][markerInterior] = -1;
    markerData[markerid][markerStreamDistance] = 50.0;
    markerData[markerid][markerColour] = 0x00000000;
    return true;
}

hook OnGameModeInit()
{
    for (new i = 0; i < sizeof(markerData); i++) {
        ResetMarkerData(i);
    }
}

stock GetMarkerColor(markerid) {
    if (!IsValidMarker(markerid)) return 0x0;
    return markerData[markerid][markerColour];
}


stock CreateMarker(Float:x, Float:y, Float:z, Float:streamDistance = 50.0, WorldID = -1, InteriorID = -1, MarkerColour = 0x0)
{
    new markerid = GetFreeMarkerID();
    if(markerid == INVALID_MARKER_ID) return INVALID_MARKER_ID;

    markerData[markerid][markerPos][0] = x;
    markerData[markerid][markerPos][1] = y;
    markerData[markerid][markerPos][2] = z;

    markerData[markerid][markerWorld] = WorldID;
    markerData[markerid][markerInterior] = InteriorID;
    markerData[markerid][markerStreamDistance] = streamDistance;

    if(MarkerColour == 0x0)
        markerData[markerid][markerColour] = COLOR_ARRAY[random(7)+1];
    else
        markerData[markerid][markerColour] = MarkerColour;
        
    //------------------------------------------------------------------------------------------------------------------------------
    markerData[markerid][markerObject][0] = CreateDynamicObject(19197, markerData[markerid][markerPos][0], markerData[markerid][markerPos][1], markerData[markerid][markerPos][2], 0.0, 0.0, 0.0, markerData[markerid][markerWorld], markerData[markerid][markerInterior], -1, markerData[markerid][markerStreamDistance], markerData[markerid][markerStreamDistance]);
    SetDynamicObjectMaterial(markerData[markerid][markerObject][0], 0, 19063, "xmasorbs", "sphere",0x00000000);
    //------------------------------------------------------------------------------------------------------------------------------
    markerData[markerid][markerObject][1] = CreateDynamicObject(19197, markerData[markerid][markerPos][0], markerData[markerid][markerPos][1], markerData[markerid][markerPos][2], 0.0, 0.0, 0.0, markerData[markerid][markerWorld], markerData[markerid][markerInterior], -1, markerData[markerid][markerStreamDistance], markerData[markerid][markerStreamDistance]);
    SetDynamicObjectMaterial( markerData[markerid][markerObject][1], 0, 19063, "xmasorbs", "sphere", markerData[markerid][markerColour]);
    //------------------------------------------------------------------------------------------------------------------------------
    markerData[markerid][markerArea] = CreateDynamicCylinder(x, y, (z - 1.0), (z + 10.0), 2.0, WorldID, InteriorID, -1);
    return true;
}  

stock DestroyMarker(markerid)
{
    if(!IsValidMarker(markerid)) return false;

    DestroyDynamicObject(markerData[markerid][markerObject][0]);
    DestroyDynamicObject(markerData[markerid][markerObject][1]);
    DestroyDynamicArea(markerData[markerid][markerArea]);

    ResetMarkerData(markerid);
    return true;
}

hook OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
{
    for(new i = 0; i < sizeof(markerData); i++)
    {
        if(markerData[i][markerArea] != areaid) continue;
        CallLocalFunction("OnPlayerEnterMarkerArea", "dd", playerid, i);
        break;
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}

forward OnPlayerEnterMarkerArea(playerid, markerid);