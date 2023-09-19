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
 *  @Author         Ogy__
 *  @Date           12th Sept. 2023
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           metros.script
 *  @Module         metros
 */

#include <ysilib\YSI_Coding\y_hooks>

#define MAX_METROS 			(100)
/*
     ___                 _      
    (  _)               ( )     
    | |   ___  ____  __ | |  __ 
    ( )_ ( o )( __ )(_' ( _)(_' 
    /___\ \_/ /_\/_\/__)/_\ /__)
                                
*/
new Text3D:MetroLabel[MAX_METROS],
	MetroPickup[MAX_METROS],
	bool:ogy_finished = true,
	MetroStanica[MAX_PLAYERS],
	MetroTimer[MAX_PLAYERS];
/*
     ____                        
    (  __)                       
    | |_   ____  _ _  __  __  __ 
    (  _) ( __ )( U )( _`'_ )(_' 
    /____\/_\/_\/___\/_\`'/_\/__)

*/

enum metroEnum {

	MetroSQLID,
	MetroRutaID,
	Float:MetroX,
	Float:MetroY,
	Float:MetroZ,
	MetroInt,
	MetroVirtual
}
new metroInfo[MAX_METROS][metroEnum],
	Iterator:Metros<MAX_METROS>;

/*
     _  _            _        
    ( )( )          ( )       
    | L| | ___  ___ | | _  __ 
    ( __ )( o )( o )( _'( (_' 
    /_\/_\ \_/  \_/ /_\\_|/__)

*/

hook OnGameModeInit()
{
	if(ogy_finished)
    {
        print("metros/metros.script loaded");  
    }

    Iter_Init(Metros);
    mysql_pquery(SQL, "SELECT * FROM `metros`", "LoadMetros" );
}

hook OnPlayerConnect(playerid)
{
	MetroStanica[playerid] = 0;
	KillTimer(MetroTimer[playerid]);
	return 1;
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
	if(newkeys & KEY_NO)
	{
		foreach(new idzz : Metros)
	    {
	        if(IsPlayerInRangeOfPoint(playerid, 1.0, metroInfo[ idzz ][ MetroX ], metroInfo[ idzz ][ MetroY ], metroInfo[ idzz ][ MetroZ ]))
	        {
	        	switch(metroInfo[idzz][MetroRutaID])
	        	{
	        		case 1: Dialog_Show(playerid, "dialog_metrostanica1", DIALOG_STYLE_LIST, "Metro - Odabir Rute", "Banka\nOpstina", "Dalje", "Izlaz");
	        		case 2: Dialog_Show(playerid, "dialog_metrostanica2", DIALOG_STYLE_LIST, "Metro - Odabir Rute", "Banka\nOpstina", "Dalje", "Izlaz");
	        		case 3: Dialog_Show(playerid, "dialog_metrostanica3", DIALOG_STYLE_LIST, "Metro - Odabir Rute", "Banka\nOpstina", "Dalje", "Izlaz");
	        		case 4: Dialog_Show(playerid, "dialog_metrostanica4", DIALOG_STYLE_LIST, "Metro - Odabir Rute", "Banka\nOpstina", "Dalje", "Izlaz");
	        		case 5: Dialog_Show(playerid, "dialog_metrostanica5", DIALOG_STYLE_LIST, "Metro - Odabir Rute", "Banka\nOpstina", "Dalje", "Izlaz");
	        	}
	        }
	    }
	}
	return (true);
}

/*
	* DIalogs
*/

Dialog:dialog_metrostanica1(const playerid, response, listitem, string:inputtext[])
{
	if(!response) return 1;
	if(response)
	{
		switch(listitem)
		{
			case 0: SetTimerEx("MetroEnter", 4000, false, "ii",playerid, 1), MetroStanica[playerid] = 1;
			case 1: SetTimerEx("MetroEnter", 4000, false, "ii",playerid, 2), MetroStanica[playerid] = 2;
		}
	}
	return (true);
}
Dialog:dialog_metrostanica2(const playerid, response, listitem, string:inputtext[])
{
	if(!response) return 1;
	if(response)
	{
		switch(listitem)
		{
			case 0: SetTimerEx("MetroEnter", 4000, false, "ii",playerid, 1), MetroStanica[playerid] = 1;
			case 1: SetTimerEx("MetroEnter", 4000, false, "ii",playerid, 2), MetroStanica[playerid] = 2;
		}
	}
	return (true);
}
Dialog:dialog_metrostanica3(const playerid, response, listitem, string:inputtext[])
{
	if(!response) return 1;
	if(response)
	{
		switch(listitem)
		{
			case 0: SetTimerEx("MetroEnter", 4000, false, "ii",playerid, 1), MetroStanica[playerid] = 1;
			case 1: SetTimerEx("MetroEnter", 4000, false, "ii",playerid, 2), MetroStanica[playerid] = 2;
		}
	}
	return (true);
}
Dialog:dialog_metrostanica4(const playerid, response, listitem, string:inputtext[])
{
	if(!response) return 1;
	if(response)
	{
		switch(listitem)
		{
			case 0: SetTimerEx("MetroEnter", 4000, false, "ii",playerid, 1), MetroStanica[playerid] = 1;
			case 1: SetTimerEx("MetroEnter", 4000, false, "ii",playerid, 2), MetroStanica[playerid] = 2;
		}
	}
	return (true);
}
Dialog:dialog_metrostanica5(const playerid, response, listitem, string:inputtext[])
{
	if(!response) return 1;
	if(response)
	{
		switch(listitem)
		{
			case 0: SetTimerEx("MetroEnter", 4000, false, "ii",playerid, 1), MetroStanica[playerid] = 1;
			case 1: SetTimerEx("MetroEnter", 4000, false, "ii",playerid, 2), MetroStanica[playerid] = 2;
		}
	}
	return (true);
}
/*
     _                _      _   ___                 
    ( )              ( )    / ) /  _)                
    | |   ___  ___  _| |   / /  \_"-.  ___  _ _  ___ 
    ( )_ ( o )( o )/ o )  ( /    __) )( o )( V )( o_)
    /___\ \_/ /_^_\\___\ /_/    /___/ /_^_\ \_/  \(  

*/

forward LoadMetros();
public LoadMetros()
{
	new iRows, id;
	cache_get_row_count(iRows);
	for(new i = 0; i < iRows; i++)
	{
	    cache_get_value_name_int(i, "metroID", id);
	    cache_get_value_name_int(i, "metroRuta", metroInfo[id][MetroRutaID]);
	    cache_get_value_name_float(i, "metroX",metroInfo[id][MetroX]);
	    cache_get_value_name_float(i, "metroY",metroInfo[id][MetroY]);
	    cache_get_value_name_float(i, "metroZ",metroInfo[id][MetroZ]);
	    cache_get_value_name_int(i, "metroInt", metroInfo[id][MetroInt]);
	    cache_get_value_name_int(i, "metroVw", metroInfo[id][MetroVirtual]);
		Iter_Add(Metros, 0);
		Iter_Add(Metros, id);
		MetrosLabel(id);
	}
	printf("Ucitavanje Metro Stanica(%d)... Uspesno",iRows);
	return (true);
}

forward SaveMetros(metro);
public SaveMetros(metro)
{
	new query[300];
    format(query, sizeof(query),"`metroX`='%f',`metroY`='%f',`metroZ`='%f',`metroInt`='%d',`metroVw`='%d',`metroRuta`='%d'",
		metroInfo[metro][MetroX],
		metroInfo[metro][MetroY],
		metroInfo[metro][MetroZ],
		metroInfo[metro][MetroInt],
		metroInfo[metro][MetroVirtual],
		metroInfo[metro][MetroRutaID]
	);
	format(query, sizeof(query), "UPDATE `metros` SET %s WHERE `metroID`='%i'", query, metro);
	mysql_tquery(SQL, query);
	return (true);
}


forward CreateMetro(id);
public CreateMetro(id)
{
	metroInfo[id][MetroSQLID] = cache_insert_id();
	Iter_Add(Metros, id);
	return (true);
}
/*
     ____                _   _                
    (  __)              ( ) (_)               
    | |_   _ _  ____  __| |  _  ___  ____  __ 
    ( __) ( U )( __ )/ /( _)( )( o )( __ )(_' 
    /_\   /___\/_\/_\\_\/_\ /_\ \_/ /_\/_\/__)

*/

forward MetroEnter(playerid, id);
public MetroEnter(playerid, id)
{
	// id == 1 = 30sec
	// id == 2 = 60sec
	switch(id)
	{
		case 1:
		{
			MetroTimer[playerid] = SetTimerEx("MetroExit", 30*1000, false, "ii", playerid, MetroStanica[playerid]);
			SendClientMessage(playerid, 0x0086e3FF, "> Metro Stanica: {ffffff}Usli ste u metro stanicu, sacekajte dok metro dodje do lokacije.");
		}
		case 2:
		{

			MetroTimer[playerid] = SetTimerEx("MetroExit", 60*1000, false, "ii", playerid, MetroStanica[playerid]);
			SendClientMessage(playerid, 0x0086e3FF, "> Metro Stanica: {ffffff}Usli ste u metro stanicu, sacekajte dok metro dodje do lokacije.");
		}
	}
	return (true);
}

forward MetroExit(playerid, id);
public MetroExit(playerid, id)
{

	KillTimer(MetroTimer[playerid]);
	switch(id)
	{
		case 1:
		{
			SendClientMessage(playerid, 0x0086e3FF, "> Metro Stanica: {ffffff}Ruta1.");
		}
		case 2:
		{
			SendClientMessage(playerid, 0x0086e3FF, "> Metro Stanica: {ffffff}Ruta2");
		}
		case 3:
		{
			SendClientMessage(playerid, 0x0086e3FF, "> Metro Stanica: {ffffff}Ruta3");
		}	
		case 4:
		{
			SendClientMessage(playerid, 0x0086e3FF, "> Metro Stanica: {ffffff}Ruta4");
		}
		case 5:
		{
			SendClientMessage(playerid, 0x0086e3FF, "> Metro Stanica: {ffffff}Ruta5");
		}
	}
	return (true);
}
forward sql_createmetro(id);
public sql_createmetro(id)
{
	static q[850];
	mysql_format(SQL, q, sizeof(q),
	    "INSERT INTO `metros` (`metroX`, `metroY`, `metroZ`, `metroRuta`, `metroInt`, `metroVw`) \
		 VALUES('%f','%f','%f','%d','%d','%d')", 
		 metroInfo[id][MetroX],metroInfo[id][MetroY],metroInfo[id][MetroZ],metroInfo[id][MetroRutaID],metroInfo[id][MetroInt],metroInfo[id][MetroVirtual]);

	mysql_pquery(SQL, q, "CreateMetro", "i", id);
	return (true);
}
StanicaIzRute(ruta)
{
	new rutazz[50] = "Nema Rute";
	switch(metroInfo[ruta][MetroRutaID]) 
	{
	    case 0: rutazz = "Nema Rute";
		case 1: rutazz = "Ruta1";
		case 2: rutazz = "Ruta2";
		case 3: rutazz = "Ruta3";
		case 4: rutazz = "Ruta4";
		case 5: rutazz = "Ruta5";
		case 6: rutazz = "Ruta6";
	}
	return rutazz;
}

NearestMetro( playerid ) {

    foreach(new i : Metros)
    if(IsPlayerInRangeOfPoint( playerid, 5.0, metroInfo[ i ][ MetroX ], metroInfo[ i ][ MetroY ], metroInfo[ i ][ MetroZ ] ) ) 
    {
		if( GetPlayerInterior( playerid ) == metroInfo[ i ][ MetroInt ] && GetPlayerVirtualWorld( playerid ) == metroInfo[ i ][ MetroVirtual ] )
		return i;
	}
	return -1;
}

forward MetrosLabel(id);
public MetrosLabel(id)
{
	DestroyDynamic3DTextLabel(MetroLabel[id]);
	DestroyDynamicPickup(MetroPickup[id]);
	new stringic[100];
	format(stringic, sizeof(stringic),"   � {ffffff}METRO STANICA{23DEEB} �   \n\nStanica: %s",StanicaIzRute(id));
	MetroLabel[id] = CreateDynamic3DTextLabel(stringic, 0x23DEEBFF, metroInfo[id][MetroX],metroInfo[id][MetroY],metroInfo[id][MetroZ],10.0,INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0);

	//MetroPickup[id] = CreateDynamicPickup(19605, 1, metroInfo[id][MetroX],metroInfo[id][MetroY],metroInfo[id][MetroZ]);
	CreateMarker(4,true,metroInfo[id][MetroX],metroInfo[id][MetroY],metroInfo[id][MetroZ]-1.0,0, 0);
	return (true);
}