#include <ysilib\YSI_Coding\y_hooks>

//==============================================================================
//--->>> Player variables
//==============================================================================
enum ePlayerKeysUpdate {
    pKeysUpdTimer,
    bool:pKeysUpdPaused,//Set these to miliseconds???
    KEY:pKeysUpdK,
    KEY:pKeysUpdLR,
    KEY:pKeysUpdUD,
};
new pKeysUpdate[MAX_PLAYERS][ePlayerKeysUpdate];
//==============================================================================
//--->>> Hooks
//==============================================================================
hook OnPlayerConnect(playerid)
{
    pKeysUpdate[playerid][pKeysUpdTimer] = 0;
    pKeysUpdate[playerid][pKeysUpdPaused] = false;
    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    StopPlayerKeysUpdate(playerid);
    return Y_HOOKS_CONTINUE_RETURN_1;
}
//==============================================================================
//--->>> Functions
//==============================================================================
stock StartPlayerKeysUpdate(playerid) 
{ 
    if(!IsPlayerConnected(playerid)) return false;
    pKeysUpdate[playerid][pKeysUpdTimer] = SetTimerEx("UpdatePlayerKeys", 10, true, "d", playerid);
    return true;
}

stock StopPlayerKeysUpdate(playerid) 
{ 
    if(!IsPlayerConnected(playerid)) return false;

    KillTimer(pKeysUpdate[playerid][pKeysUpdTimer]);
    pKeysUpdate[playerid][pKeysUpdTimer] = 0;
    pKeysUpdate[playerid][pKeysUpdPaused] = false;
    return true;
}

stock IsPlayerKeysUpdatePaused(playerid) {
    if(!IsPlayerConnected(playerid)) return 0;
    if(pKeysUpdate[playerid][pKeysUpdTimer] == 0) return 0;

    return pKeysUpdate[playerid][pKeysUpdPaused];
}

stock bool:PausePlayerKeysUpdate(playerid, bool: bPause = true)
{
    if(!IsPlayerConnected(playerid)) return false;

    if(pKeysUpdate[playerid][pKeysUpdTimer] == 0) return false;
    if(pKeysUpdate[playerid][pKeysUpdPaused] == bPause) return false;

    pKeysUpdate[playerid][pKeysUpdPaused] = bPause;
    return true;
}
//==============================================================================
//--->>> Public Functions
//==============================================================================
forward UpdatePlayerKeys(playerid);
public UpdatePlayerKeys(playerid)
{
    //Skip if player keys update is enableed but paused (moving camera, special condition, anything temporary for short period...)
    if(pKeysUpdate[playerid][pKeysUpdPaused]) return false;

	new KEY:keys, KEY:updown, KEY:leftright;
	GetPlayerKeys(playerid, keys, updown, leftright);

    //We dont care about keys, do we pass them?
    if(keys != pKeysUpdate[playerid][pKeysUpdK] || updown != pKeysUpdate[playerid][pKeysUpdUD] || leftright != pKeysUpdate[playerid][pKeysUpdLR] )
    //if(updown != pKeysUpdate[playerid][pKeysUpdUD] || leftright != pKeysUpdate[playerid][pKeysUpdLR] )
    {    
        new retval = CallLocalFunction("OnPlayerKeysUpdate", "ddddddd", playerid, keys, pKeysUpdate[playerid][pKeysUpdK], updown, pKeysUpdate[playerid][pKeysUpdUD], leftright, pKeysUpdate[playerid][pKeysUpdLR]);
        pKeysUpdate[playerid][pKeysUpdK] = keys;
        pKeysUpdate[playerid][pKeysUpdUD] = updown;
        pKeysUpdate[playerid][pKeysUpdLR] = leftright;
        return retval;
    }
    return false;
}

forward OnPlayerKeysUpdate(playerid, KEY:keys, KEY:oldkeys, KEY:updown, KEY:oldupdown, KEY:leftright, KEY:oldleftright);
/*
public OnPlayerKeysUpdate(playerid, KEY:keys, KEY:oldkeys, KEY:updown, KEY:oldupdown, KEY:leftright, KEY:oldleftright);
{
    if(updown == KEY_UP && oldupdown != KEY_UP)
        SendDebug(playerid, "Key up!");

    if(updown == KEY_DOWN && oldupdown != KEY_DOWN)
        SendDebug(playerid, "Key down!");

    if(leftright == KEY_LEFT && oldleftright != KEY_LEFT)
        SendDebug(playerid, "Key left!");

    if(leftright == KEY_RIGHT && oldleftright != KEY_RIGHT)
        SendDebug(playerid, "Key right!");

    return true;
}
*/
//==============================================================================
//--->>> Debug Stuff
//==============================================================================
/*
CMD:startkeysupdate(playerid, params[])
{
    StartPlayerKeysUpdate(playerid);
    SendSuccess(playerid, "Started updating your keys!");
    return 1;
}

CMD:stoptkeysupdate(playerid, params[])
{
    StopPlayerKeysUpdate(playerid);
    SendSuccess(playerid, "Stopped updating your keys!");
    return 1;
}

CMD:pausetkeysupdate(playerid, params[])
{
    PausePlayerKeysUpdate(playerid);
    SendSuccess(playerid, "Paused updating your keys!");
    return 1;
}
*/
