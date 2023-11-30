#include <ysilib\YSI_Coding\y_hooks>

#define MAX_3DSLIDERS (300)

enum eSliderActions
{
    SLIDER_CLICK_INVALID,
    SLIDER_CLICK_LEFT,
    SLIDER_CLICK_RIGHT,
    SLIDER_CLICK_SELECT,
}

enum eSlider
{
    bool:sliderPlayerSelecting,
    Float:sliderRotation,
    sliderObjectLeft,
    sliderObjectRight,
    sliderObjectMiddle,
    sliderObjectMaterialSize
}
new pSliderInfo[MAX_PLAYERS][eSlider];

/*
    @TODO:  Per player and global slider?
            Multiple sliders at the same time?
                Switching current slider
*/
stock CreatePlayerSlider(playerid, Float:x, Float:y, Float:z, Float:rotation, const text[], materialsize)
{
    if(!IsPlayerConnected(playerid)) return false;
    DestroyPlayerSlider(playerid);

    pSliderInfo[playerid][sliderObjectMaterialSize] = materialsize;

	new Float:tmpX, Float:tmpY, Float:tmpA;
    new Float:distance = 0.69;
    
    tmpA = rotation+90;
    tmpX = x;
    tmpY = y;
	tmpX += (distance * floatsin(-tmpA, degrees));
	tmpY += (distance * floatcos(-tmpA, degrees));
    pSliderInfo[playerid][sliderObjectLeft] = CreateDynamicObject(2661, tmpX, tmpY, z, 0.000000, 0.000000, rotation, -1, -1, playerid, 300.00, 300.00);
    SetDynamicObjectMaterialText(pSliderInfo[playerid][sliderObjectLeft], 0, "<<", materialsize, "Ariel", 22, 0, 0xFFFFFFFF, 0x00000000, 1);

    tmpA = rotation+270;
    tmpX = x;
    tmpY = y;
	tmpX += (distance * floatsin(-tmpA, degrees));
	tmpY += (distance * floatcos(-tmpA, degrees));
    pSliderInfo[playerid][sliderObjectRight] = CreateDynamicObject(2661, tmpX, tmpY, z, 0.000000, 0.000000, rotation, -1, -1, playerid, 300.00, 300.00); 
    SetDynamicObjectMaterialText(pSliderInfo[playerid][sliderObjectRight], 0, ">>", materialsize, "Ariel", 22, 0, 0xFFFFFFFF, 0x00000000, 1);


    pSliderInfo[playerid][sliderObjectMiddle] = CreateDynamicObject(2661, x, y, z, 0.000000, 0.000000, rotation, -1, -1, playerid, 300.00, 300.00); 
    SetDynamicObjectMaterialText(pSliderInfo[playerid][sliderObjectMiddle], 0, text, materialsize, "Ariel", 22, 0, 0xFFFFFFFF, 0x00000000, 1);
    pSliderInfo[playerid][sliderPlayerSelecting] = true;
	StartPlayerKeysUpdate(playerid);
    return 1;
}

stock DestroyPlayerSlider(playerid)
{
    if(!IsPlayerConnected(playerid)) return false;
    if(!IsValidDynamicObject(pSliderInfo[playerid][sliderObjectMiddle])) return false;
    pSliderInfo[playerid][sliderPlayerSelecting] = false;
    pSliderInfo[playerid][sliderObjectMaterialSize] = 0;
    DestroyDynamicObject(pSliderInfo[playerid][sliderObjectLeft]);
    DestroyDynamicObject(pSliderInfo[playerid][sliderObjectRight]);
    DestroyDynamicObject(pSliderInfo[playerid][sliderObjectMiddle]);
	StopPlayerKeysUpdate(playerid);
    return 1;
}

stock SetPlayerSliderText(playerid, const text[])
{
    if(!IsPlayerConnected(playerid)) return false;
    if(!IsValidDynamicObject(pSliderInfo[playerid][sliderObjectMiddle])) return false;
    SetDynamicObjectMaterialText(pSliderInfo[playerid][sliderObjectMiddle], 0, text, pSliderInfo[playerid][sliderObjectMaterialSize], "Ariel", 22, 0, 0xFFFFFFFF, 0x00000000, 1);
    return true;
}

hook OnPlayerKeysUpdate(playerid, KEY:keys, KEY:oldkeys, KEY:updown, KEY:oldupdown, KEY:leftright, KEY:oldleftright)
{    
    if(!pSliderInfo[playerid][sliderPlayerSelecting]) return Y_HOOKS_CONTINUE_RETURN_1;
    if(leftright == KEY_LEFT && oldleftright != KEY_LEFT)
    {
        SetDynamicObjectMaterialText(pSliderInfo[playerid][sliderObjectLeft], 0, "<<", pSliderInfo[playerid][sliderObjectMaterialSize], "Ariel", 22, 0, 0xCCCCCCFFF, 0x00000000, 1);
        CallLocalFunction("OnPlayerSlectedSlider", "iii", playerid, leftright, false);
        SetTimerEx("RestoreSliderColor", 300, false, "ii", playerid, leftright);
        //PausePlayerKeysUpdate(playerid, true);
        return Y_HOOKS_BREAK_RETURN_1;
    }
    
    if(leftright == KEY_RIGHT && oldleftright != KEY_RIGHT)
    {
        SetDynamicObjectMaterialText(pSliderInfo[playerid][sliderObjectRight], 0, ">>", pSliderInfo[playerid][sliderObjectMaterialSize], "Ariel", 22, 0, 0xCCCCCCFF, 0x00000000, 1);
        CallLocalFunction("OnPlayerSlectedSlider", "iii", playerid, leftright, false);
        SetTimerEx("RestoreSliderColor", 300, false, "ii", playerid, leftright);
        //PausePlayerKeysUpdate(playerid, true);
        return Y_HOOKS_BREAK_RETURN_1;
    }
	
    if((keys == KEY_SPRINT && oldkeys != KEY_SPRINT) || (keys == KEY_SECONDARY_ATTACK && oldkeys != KEY_SECONDARY_ATTACK))
    {
        CallLocalFunction("OnPlayerSlectedSlider", "iii", playerid, leftright, true);        
        return Y_HOOKS_BREAK_RETURN_1;
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}

forward RestoreSliderColor(playerid, KEY:leftright);
public RestoreSliderColor(playerid, KEY:leftright)
{
    if(leftright == KEY_LEFT)
    {
        SetDynamicObjectMaterialText(pSliderInfo[playerid][sliderObjectLeft], 0, "<<", pSliderInfo[playerid][sliderObjectMaterialSize], "Ariel", 22, 0, 0xFFFFFFFF, 0x00000000, 1);
    }
    else if(leftright == KEY_RIGHT)
    {
        SetDynamicObjectMaterialText(pSliderInfo[playerid][sliderObjectRight], 0, ">>", pSliderInfo[playerid][sliderObjectMaterialSize], "Ariel", 22, 0, 0xFFFFFFFF, 0x00000000, 1);
    }
    PausePlayerKeysUpdate(playerid, false);
    return 1;
}


forward OnPlayerSlectedSlider(playerid, KEY:leftright, bool:selected);



/*
CMD:moveplayerslider(playerid, params[])
{
	new Float:NewX, Float:NewY, Float:NewZ;
	if(sscanf(params, "fF(0.0)F(0.0)", NewX, NewY, NewZ)) return SendUsage(playerid, "/moveplayerslider [X] (Y) (Z)");
    new Float:x, Float:y, Float:z;
    new Float:rx, Float:ry, Float:rz;  

    GetDynamicObjectPos(pSliderInfo[playerid][sliderObjectLeft],x, y, z);
    GetDynamicObjectRot(pSliderInfo[playerid][sliderObjectLeft],rx, ry, rz);
    MoveDynamicObject(pSliderInfo[playerid][sliderObjectLeft], x+NewX, y+NewY, z+NewZ, 1.0);

    GetDynamicObjectPos(pSliderInfo[playerid][sliderObjectRight],x, y, z);
    GetDynamicObjectRot(pSliderInfo[playerid][sliderObjectRight],rx, ry, rz);
    MoveDynamicObject(pSliderInfo[playerid][sliderObjectRight], x+NewX, y+NewY, z+NewZ, 1.0);

    GetDynamicObjectPos(pSliderInfo[playerid][sliderObjectMiddle],x, y, z);
    GetDynamicObjectRot(pSliderInfo[playerid][sliderObjectMiddle],rx, ry, rz);
	//DestroyPlayerSlider(playerid);
    //CreatePlayerSlider(playerid, x+NewX, y+NewY, z+NewZ, rz, "Skin", OBJECT_MATERIAL_SIZE_128x32);
    SendSuccess(playerid, "You have moved slider pos to %f, %f, %f", x+NewX, y+NewY, z+NewZ);
    printf("New slider pos: %f, %f, %f, %f", x+NewX, y+NewY, z+NewZ, rz);

    MoveDynamicObject(pSliderInfo[playerid][sliderObjectMiddle], x+NewX, y+NewY, z+NewZ, 1.0);

	return 1;
}
*/
