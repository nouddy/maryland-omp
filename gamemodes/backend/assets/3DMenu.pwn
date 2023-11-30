//3DMenu. Author: SDraw

#include <ysilib\YSI_Coding\y_hooks>
#include <ysilib\YSI_Data\y_iterate>
#include <streamer>

/* Fake natives. Thanks to TheArcher.
native Create3DMenu(Float:x,Float:y,Float:z,Float:rotation,boxes,playerid);
native SetBoxText(MenuID,box,text[],materialsize,fontface[],fontsize,bold,fontcolor,backcolor,textalignment);
native Select3DMenu(playerid,MenuID);
native CancelSelect3DMenu(playerid,MenuID);
native Destroy3DMenu(MenuID);
*/


#define MAX_3DMENUS (128)
#define MAX_BOXES (16)

#define INVALID_3D_MENU (-1)

new SelectedMenu[MAX_PLAYERS];
new SelectedBox[MAX_PLAYERS];

enum MenuParams { 
	Float:	Rotation,
			Boxes,
	bool:	IsExist,
			Objects[MAX_BOXES],
	Float:	AddingX,
	Float:	AddingY
};

new MenuInfo[MAX_3DMENUS][MenuParams];

//Callbacks
forward OnPlayerSelect3DMenuBox(playerid,MenuID,selected);
forward OnPlayerChange3DMenuBox(playerid,MenuID,boxid);
forward bool:Destroy3DMenu(MenuID);


//@NOTE: OpenMP fucked up floatsin/floatcos, if rotation is < 0, or >= 360, they return 0
stock Create3DMenu(Float:x,Float:y,Float:z,Float:rotation,boxes,playerid)
{
	if(boxes > MAX_BOXES || boxes <= 0) return INVALID_3D_MENU;
	for(new i = 0; i < MAX_3DMENUS; i++)
	{
	    if(!MenuInfo[i][IsExist])
	    {
	        MenuInfo[i][Rotation] = rotation;
			MenuInfo[i][Boxes] = boxes;
			
            if(rotation == 0 || rotation == 360) { MenuInfo[i][AddingX] = 0.0; MenuInfo[i][AddingY] = -0.25; }
			if(rotation == 180) { MenuInfo[i][AddingX] = 0.0; MenuInfo[i][AddingY] = 0.25; }
			if(rotation == 90) { MenuInfo[i][AddingX] = 0.25; MenuInfo[i][AddingY] = 0.0; }
			if(rotation == 270) { MenuInfo[i][AddingX] = -0.25; MenuInfo[i][AddingY] = 0.0; }
			if((rotation > 0 && rotation < 90) || (rotation > 270 && rotation < 360))
			{
				MenuInfo[i][AddingX] = 0.25*floatsin(rotation,degrees);
				MenuInfo[i][AddingY] = -floatcos(rotation,degrees)*0.25;
			}
			if((rotation > 90 && rotation < 180) || (rotation > 180 && rotation < 270))
			{
				MenuInfo[i][AddingX] = 0.25*floatsin(rotation,degrees);
				MenuInfo[i][AddingY] = -floatcos(rotation,degrees)*0.25;
			}
	        for(new b = 0; b < boxes; b++)
			{
				if(b < 6) MenuInfo[i][Objects][b] = CreateDynamicObject(2661,x,y,z+1.65-0.55*b,0,0,rotation,-1,-1,playerid,100.0);
				if(b >= 6)
				{
				    new Float:NextLineX,Float:NextLineY;
				    NextLineX = floatcos(rotation,degrees)+0.05*floatcos(rotation,degrees); NextLineY = floatsin(rotation,degrees)+0.05*floatsin(rotation,degrees);
				    if(b < 8) MenuInfo[i][Objects][b] = CreateDynamicObject(2661,x+NextLineX,y+NextLineY,z+1.65-0.55*(b-4),0,0,rotation,-1,-1,playerid,100.0);
				    if(b > 7 && b < 12) MenuInfo[i][Objects][b] = CreateDynamicObject(2661,x+NextLineX*2,y+NextLineY*2,z+1.65-0.55*(b-8),0,0,rotation,-1,-1,playerid,100.0);
				    if(b > 11 && b < 16) MenuInfo[i][Objects][b] = CreateDynamicObject(2661,x+NextLineX*3,y+NextLineY*3,z+1.65-0.55*(b-12),0,0,rotation,-1,-1,playerid,100.0);
	            }
			}			
			MenuInfo[i][IsExist] = true;
			return i;
		}
	}
	return INVALID_3D_MENU;
}

stock bool:SetBoxText(MenuID,box, const text[],materialsize, const fontface[],fontsize,bold,fontcolor,backcolor,textalignment)
{
	if(!MenuInfo[MenuID][IsExist]) return false;
	if(box == MenuInfo[MenuID][Boxes] || box < 0) return false;
	if(MenuInfo[MenuID][Objects][box] == INVALID_STREAMER_ID) return false;
	SetDynamicObjectMaterialText(MenuInfo[MenuID][Objects][box],0,text,materialsize,fontface,fontsize,bold,fontcolor,backcolor,textalignment);
	return true;
}

stock bool:Select3DMenu(playerid,MenuID, menubox = 0)
{
	if(!MenuInfo[MenuID][IsExist]) return false;
	new Float:x,Float:y,Float:z;
	SelectedBox[playerid] = menubox;
	SelectedMenu[playerid] = MenuID;
 	GetDynamicObjectPos(MenuInfo[MenuID][Objects][SelectedBox[playerid]],x,y,z);
	MoveDynamicObject(MenuInfo[MenuID][Objects][SelectedBox[playerid]],x+MenuInfo[MenuID][AddingX],y+MenuInfo[MenuID][AddingY], z, 1.0);
	return true;
}

hook OnScriptInit()
{
	for(new i = 0; i < MAX_3DMENUS; i++)
	{
	    for(new b = 0; b < MAX_BOXES; b++) MenuInfo[i][Objects][b] = INVALID_STREAMER_ID;
	    MenuInfo[i][Boxes] = 0;
	    MenuInfo[i][IsExist] = false;
	    MenuInfo[i][AddingX] = 0.0;
 		MenuInfo[i][AddingY] = 0.0;
	}
}
hook OnScriptExit()
{
	for(new i = 0; i < MAX_3DMENUS; i++)
	{
		if(MenuInfo[i][IsExist]) Destroy3DMenu(i);
	}
}

hook OnPlayerConnect(playerid)
{
    SelectedMenu[playerid] = INVALID_3D_MENU;
	SelectedBox[playerid] = INVALID_3D_MENU;
}

hook OnPlayerKeysUpdate(playerid, KEY:keys, KEY:oldkeys, KEY:updown, KEY:oldupdown, KEY:leftright, KEY:oldleftright)
{
	if(SelectedMenu[playerid] == INVALID_3D_MENU) return Y_HOOKS_CONTINUE_RETURN_1;
	new MenuID = SelectedMenu[playerid];

	new Float:x,Float:y,Float:z;
	if(updown == KEY_DOWN && oldupdown != KEY_DOWN)
	{
		//SendClientMessage(playerid, -1, "Debug: Menu Down");

	    GetDynamicObjectPos(MenuInfo[MenuID][Objects][SelectedBox[playerid]],x,y,z);
		MoveDynamicObject(MenuInfo[MenuID][Objects][SelectedBox[playerid]],x-MenuInfo[MenuID][AddingX],y-MenuInfo[MenuID][AddingY],z, 1.0);

		SelectedBox[playerid]++;
		if(SelectedBox[playerid] >= MenuInfo[MenuID][Boxes]) SelectedBox[playerid] = 0;
		GetDynamicObjectPos(MenuInfo[MenuID][Objects][SelectedBox[playerid]],x,y,z);
		MoveDynamicObject(MenuInfo[MenuID][Objects][SelectedBox[playerid]],x+MenuInfo[MenuID][AddingX],y+MenuInfo[MenuID][AddingY],z, 1.0);
		return Y_HOOKS_BREAK_RETURN_1;
	}
	else if(updown == KEY_UP && oldupdown != KEY_UP)
	{
		//SendClientMessage(playerid, -1, "Debug: Menu UP");

	    GetDynamicObjectPos(MenuInfo[MenuID][Objects][SelectedBox[playerid]],x,y,z);
		MoveDynamicObject(MenuInfo[MenuID][Objects][SelectedBox[playerid]],x-MenuInfo[MenuID][AddingX],y-MenuInfo[MenuID][AddingY],z, 1.0);

		SelectedBox[playerid]--;
		if(SelectedBox[playerid] < 0) SelectedBox[playerid] = (MenuInfo[MenuID][Boxes]-1);
		GetDynamicObjectPos(MenuInfo[MenuID][Objects][SelectedBox[playerid]],x,y,z);
		MoveDynamicObject(MenuInfo[MenuID][Objects][SelectedBox[playerid]],x+MenuInfo[MenuID][AddingX],y+MenuInfo[MenuID][AddingY],z, 1.0);
		return Y_HOOKS_BREAK_RETURN_1;
	}
	else if(keys == KEY_NO || keys == KEY_UP) 
	{
		CallLocalFunction("OnPlayerChange3DMenuBox","idd",playerid,MenuID,SelectedBox[playerid]);
		return Y_HOOKS_BREAK_RETURN_1;
	}
	else if(keys == KEY_SPRINT || keys == KEY_SECONDARY_ATTACK) 
	{
		CallLocalFunction("OnPlayerSelect3DMenuBox","idd",playerid,MenuID,SelectedBox[playerid]);
		return Y_HOOKS_BREAK_RETURN_1;
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

stock bool:CancelSelect3DMenu(playerid,MenuID)
{
    if(!MenuInfo[MenuID][IsExist]) return false;
	new Float:x,Float:y,Float:z;
 	GetDynamicObjectPos(MenuInfo[MenuID][Objects][SelectedBox[playerid]],x,y,z);
	MoveDynamicObject(MenuInfo[MenuID][Objects][SelectedBox[playerid]],x-MenuInfo[MenuID][AddingX],y-MenuInfo[MenuID][AddingY],z, 1.0);
	SelectedMenu[playerid] = false;
	SelectedBox[playerid] = false;
	return true;
}

stock bool:Destroy3DMenuDelayed(MenuID, delayTime=3000)
{
	if(MenuID == INVALID_3D_MENU) return false;
    if(!MenuInfo[MenuID][IsExist]) return false;
    foreach(new i : Player) if(SelectedMenu[i] == MenuID) CancelSelect3DMenu(i,MenuID);

	SetTimerEx("Destroy3DMenu", delayTime, false, "d", MenuID);
	return true;
}

//@TODO: Add callback On3DMenuDestroyed ???
public bool:Destroy3DMenu(MenuID)
{
	if(MenuID == INVALID_3D_MENU) return false;
    if(!MenuInfo[MenuID][IsExist]) return false;
    
    foreach(new i : Player) if(SelectedMenu[i] == MenuID) CancelSelect3DMenu(i,MenuID);

    for(new i = 0; i < MenuInfo[MenuID][Boxes]; i++)
    {
		DestroyDynamicObject(MenuInfo[MenuID][Objects][i]);
		MenuInfo[MenuID][Objects][i] = INVALID_STREAMER_ID;
	}
 	MenuInfo[MenuID][Boxes] = 0;
 	MenuInfo[MenuID][IsExist] = false;
 	MenuInfo[MenuID][AddingX] = 0.0;
 	MenuInfo[MenuID][AddingY] = 0.0;
	return true;
}