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
 *  @Date           03th Jun 2023
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           faction_police.script
 *  @Module         backend
 */

 #include <ysilib\YSI_Coding\y_hooks>

 //============================================================ Defines
#define MAX_POLICE (30)
#define MAX_RANK_NAME(32)
//============================================================ Enums (sufix f = Faction)

enum fPoliceData {
    fPoliceID,                       //* Faction ID (SQL ID)                                                                           
    bool:fPoliceExist,               //* Dali faction postoji logic
    fPoliceName[60],                 //* Police Ime (Maryland Police Department, Egypt Police Department etc...)
    fPoliceShortName[30],            //* Police Short Name (MPD, EGY PD etc...)
    fPoliceAdress[35],               //* Police Adress (Blok 45 Djure Snajdera)
    fPoliceBoss,                     //* SQL ID Igraca koji je Sef Organizacije
    fPoliceType,                     //* Tip Policije potreban zbog skinova logic (MPD, EGY PD, FBI etc..), posto ce imati iste komande.
    Float:fPoliceExterior[4],        //* x, y, z, a
    Float:fPoliceInterior[4],        //* x,y,z, a
    fPoliceInt,                      //* interijer id od police
    fPoliceExt,                      //* interijer na izlazu koji se seta
    fPoliceExtVW,                    //* Vw za izlaz jer se za ulaz povecava logic
    bool:fPoliceLocked,              //* Boolean locked / unlocked
    fPoliceVault,                    //* Sef Policije
    bool:fPolIDUsed,                 //* Da li je id Policije iskoriscen
    fPolicePickup,                   //* Pickup (Create marker)
    Text3D: fPoliceLabel,            //* Label
    fPoliceRanks[3],                 //* Rankovi u svakoj policiji ima ih 3 (3 ranka i 3 skina), 4 je boss
    fPoliceSkins[4]                  //* Skinovi za rankove i tip svake policije   
//? > Za da li je igrac clan orge imacemo drugu tabelu player_faction (i imace dal je police, id orge kojoj pripada itd bolje nego da radimo ovde array od 30 membera i da ucitava nije pregledno i smor je za cuvanje)
};
new fPoliceInfo[MAX_POLICE][fPoliceData];

//============================================================ Boze Pomozi

hook OnGameModeInit()
{
    print("backend/faction_police.script loaded");

    mysql_tquery(SQL, "SELECT * FROM `faction_police`", "PoliceLoad", "");
}

forward PoliceLoad();
public PoliceLoad()
{
    if(!cache_num_rows())
		return print("\n[State Factions]: 0 factions ucitano.\n");

    static
        rows,
        Label[256];

    cache_get_row_count(rows);

    for(new i=0; i < rows; i++) if(i < MAX_POLICE)
    {
        fPoliceInfo[i][fPoliceExist] = true;
        cache_get_value_name_int(i, "fPoliceID", fPoliceInfo[i][fPoliceID]);

        cache_get_value_name(i, "fPoliceName", fPoliceInfo[i][fPoliceName], 60);
        cache_get_value_name(i, "fPoliceShortName", fPoliceInfo[i][fPoliceShortName], 30);
        cache_get_value_name(i, "fPoliceAdress", fPoliceInfo[i][fPoliceAdress], 35);

        cache_get_value_name_int(i, "fPoliceBoss", fPoliceInfo[i][fPoliceBoss]);
        cache_get_value_name_int(i, "fPoliceType", fPoliceInfo[i][fPoliceType]);
 		cache_get_value_name_float(i, "fPoliceX", fPoliceInfo[i][fPoliceExterior][0]);
		cache_get_value_name_float(i, "fPoliceY", fPoliceInfo[i][fPoliceExterior][1]);
		cache_get_value_name_float(i, "fPoliceZ", fPoliceInfo[i][fPoliceExterior][2]);
		cache_get_value_name_float(i, "fPoliceA", fPoliceInfo[i][fPoliceExterior][3]);
		cache_get_value_name_float(i, "fPoliceInteriorX", fPoliceInfo[i][fPoliceInterior][0]);
		cache_get_value_name_float(i, "fPoliceInteriorY", fPoliceInfo[i][fPoliceInterior][1]);
		cache_get_value_name_float(i, "fPoliceInteriorZ", fPoliceInfo[i][fPoliceInterior][2]);
		cache_get_value_name_float(i, "fPoliceInteriorA", fPoliceInfo[i][fPoliceInterior][3]);       
		cache_get_value_name_int(i, "fPoliceInt", fPoliceInfo[i][fPoliceInt]);
		cache_get_value_name_int(i, "fPoliceExt", fPoliceInfo[i][fPoliceExt]);
		cache_get_value_name_int(i, "fPoliceExtVW", fPoliceInfo[i][fPoliceExtVW]);
		cache_get_value_name_int(i, "fPoliceLocked", fPoliceInfo[i][fPoliceLocked]);
		cache_get_value_name_int(i, "fPoliceVault", fPoliceInfo[i][fPoliceVault]);

        cache_get_value_name(i, "fPoliceRank1", fPoliceInfo[i][fPoliceRanks][0], 32);
        cache_get_value_name(i, "fPoliceRank2", fPoliceInfo[i][fPoliceRanks][1], 32);
        cache_get_value_name(i, "fPoliceRank3", fPoliceInfo[i][fPoliceRanks][2], 32);

        cache_get_value_name_int(i, "fPoliceSkins1", fPoliceInfo[i][fPoliceSkins][0]);
        cache_get_value_name_int(i, "fPoliceSkins2", fPoliceInfo[i][fPoliceSkins][1]);
        cache_get_value_name_int(i, "fPoliceSkins3", fPoliceInfo[i][fPoliceSkins][2]);
        cache_get_value_name_int(i, "fPoliceSkins4", fPoliceInfo[i][fPoliceSkins][3]);

        fPoliceInfo[i][fPolicePickup] = CreateMarker(ICON_POLICE_CAR, random(5), false, fPoliceInfo[i][fPoliceExterior][0], fPoliceInfo[i][fPoliceExterior][1],fPoliceInfo[i][fPoliceExterior][2]-1.0, 0, 0);
		fPoliceInfo[i][fPolIDUsed] = true;

		if(fPoliceInfo[i][fPoliceExist])
		{
            format(Label, sizeof(Label), ""c_server"» "c_white"%s "c_server"«\n"c_server"» "c_white"%s "c_server"«\n"c_server"» "c_white"%s\n"c_server"Boss » "c_white"%s",fPoliceInfo[i][fPoliceName], fPoliceInfo[i][fPoliceShortName], fPoliceInfo[i][fPoliceAdress], fPoliceInfo[i][fPoliceBoss]);
		}
		fPoliceInfo[i][fPoliceLabel] = CreateDynamic3DTextLabel(Label, x_server, fPoliceInfo[i][fPoliceExterior][0], fPoliceInfo[i][fPoliceExterior][1], fPoliceInfo[i][fPoliceExterior][2]+0.5,30.0, .testlos = 1, .streamdistance = 30.0);

    }
    printf("\n[State Factions]: %d Factions ucitano.\n",rows);
    return (true);
}

//============================================================ Stocks
stock IsNearPolice(playerid, type)
{
	new
	    Float:fPoliceDistance[2] = {99999.0, 0.0},
	    fPoliceIndex = -1
	;
	for (new i = 0; i < MAX_POLICE; i ++) if(fPoliceInfo[i][fPoliceExist] && fPoliceInfo[i][fPoliceType] == type && GetPlayerInterior(playerid) == fPoliceInfo[i][fPoliceExt] && GetPlayerVirtualWorld(playerid) == fPoliceInfo[i][fPoliceExtVW])
	{
		fPoliceDistance[1] = GetPlayerDistanceFromPoint(playerid, fPoliceInfo[i][fPoliceExterior][0], fPoliceInfo[i][fPoliceExterior][1], fPoliceInfo[i][fPoliceExterior][2]);

		if (fPoliceDistance[1] < fPoliceDistance[0])
		{
		    fPoliceDistance[0] = fPoliceDistance[1];
		    fPoliceIndex = i;
		}
	}
	return fPoliceIndex;
}

