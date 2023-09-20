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
const MAX_POLICE = 30;
const MAX_RANK_NAME = 32;
//============================================================ Enums (sufix f = Faction)

enum E_POLICE_DATA {

    fPoliceID,                          //* Faction ID (SQL ID)                                                                           

    fPoliceName[60],                    //* Police Ime (Maryland Police Department, Egypt Police Department etc...)
    fPoliceShortName[30],               //* Police Short Name (MPD, EGY PD etc...)
    fPoliceAdress[35],                  //* Police Adress (Blok 45 Djure Snajdera)
    fPoliceState[30],                   //* Police State (Maryland, Egypt, Italy)

    fPoliceBoss,                        //* SQL ID Igraca koji je Sef Organizacije
    fPoliceType,                        //* Tip Policije potreban zbog skinova logic (Patrola , Sheriff, FBI etc..), posto ce imati iste komande.

    Float:fPoliceEntrance[3],           //* x, y, z
    Float:fPoliceExit[3],               //* x, y, z
    fPoliceInt,                         //* interijer id od police
    
    bool:fPoliceVault,                  //* Sef Policije
    fPoliceMoney,                       //* Police Money
    fPoliceDirtMoney                    //* Prljav Novac
    fConfiscatedDrugs                   //* Oduzeta droga
    
    Float:fDutyPoint[3],                //* Duty location
    Float:fEquipment[3],                //* Pozicije za opremu

    fPolicePickup,                      //* Pickup (Create marker)
    Text3D:fPoliceLabel,                //* Label

    fPoliceRanks[3][MAX_RANK_NAME],     //* Rankovi u svakoj policiji ima ih 3 (3 ranka i 3 skina), 4 je boss
    fPoliceSkins[4]                     //* Skinovi za rankove i tip svake policije   
    //? > Za da li je igrac clan orge imacemo drugu tabelu player_faction (i imace dal je police, id orge kojoj pripada itd bolje nego da radimo ovde array od 30 membera i da ucitava nije pregledno i smor je za cuvanje)
};
new fPoliceInfo[MAX_POLICE][E_POLICE_DATA];
new Iterator:iter_Police<MAX_POLICE>;

//============================================================ Boze Pomozi

hook OnGameModeInit()
{
    print("backend/faction_police.script loaded");

    mysql_tquery(SQL, "SELECT * FROM `faction_police`", "PoliceLoad", "");
}

forward PoliceLoad();
public PoliceLoad()
{

    new rows = cache_num_rows();

    if(!rows)
		return print("\n[State Factions]: 0 factions ucitano.\n");

    static
        Label[256];

    for(new i=0; i < rows; i++) if(i < MAX_POLICE)
    {
        cache_get_value_name_int(i, "fPoliceID", fPoliceInfo[i][fPoliceID]);

        cache_get_value_name(i, "fPoliceName", fPoliceInfo[i][fPoliceName], 60);
        cache_get_value_name(i, "fPoliceShortName", fPoliceInfo[i][fPoliceShortName], 30);
        cache_get_value_name(i, "fPoliceAdress", fPoliceInfo[i][fPoliceAdress], 35);
        cache_get_value_name(i, "fPoliceState", fPoliceInfo[i][fPoliceState], 30);

        cache_get_value_name_int(i, "fPoliceBoss", fPoliceInfo[i][fPoliceBoss]);
        cache_get_value_name_int(i, "fPoliceType", fPoliceInfo[i][fPoliceType]);

 		cache_get_value_name_float(i, "fPoliceX", fPoliceInfo[i][fPoliceEntrance][0]);
		cache_get_value_name_float(i, "fPoliceY", fPoliceInfo[i][fPoliceEntrance][1]);
		cache_get_value_name_float(i, "fPoliceZ", fPoliceInfo[i][fPoliceEntrance][2]);

		cache_get_value_name_float(i, "fPoliceExitX", fPoliceInfo[i][fPoliceExit][0]);
		cache_get_value_name_float(i, "fPoliceExitY", fPoliceInfo[i][fPoliceExit][1]);
		cache_get_value_name_float(i, "fPoliceExitZ", fPoliceInfo[i][fPoliceExit][2]); 
             
		cache_get_value_name_int(i, "fPoliceInt", fPoliceInfo[i][fPoliceInt]);

		cache_get_value_name_int(i, "fPoliceVault", fPoliceInfo[i][fPoliceVault]);
        cache_get_value_name_int(i, "fPoliceMoney", fPoliceInfo[i][fPoliceMoney]);
        cache_get_value_name_int(i, "fPoliceDirtMoney", fPoliceInfo[i][fPoliceDirtMoney]);
        cache_get_value_name_int(i, "fConfiscatedDrugs", fPoliceInfo[i][fConfiscatedDrugs]);

 		cache_get_value_name_float(i, "fDutyPointX", fPoliceInfo[i][fDutyPoint][0]);
		cache_get_value_name_float(i, "fDutyPointY", fPoliceInfo[i][fDutyPoint][1]);
		cache_get_value_name_float(i, "fDutyPointZ", fPoliceInfo[i][fDutyPoint][2]);

		cache_get_value_name_float(i, "fEquipmentX", fPoliceInfo[i][fEquipment][0]);
		cache_get_value_name_float(i, "fEquipmentY", fPoliceInfo[i][fEquipment][1]);
		cache_get_value_name_float(i, "fEquipmentZ", fPoliceInfo[i][fEquipment][2]);

        cache_get_value_name(i, "fPoliceRank1", fPoliceInfo[i][fPoliceRanks][0], 32);
        cache_get_value_name(i, "fPoliceRank2", fPoliceInfo[i][fPoliceRanks][1], 32);
        cache_get_value_name(i, "fPoliceRank3", fPoliceInfo[i][fPoliceRanks][2], 32);

        cache_get_value_name_int(i, "fPoliceSkins1", fPoliceInfo[i][fPoliceSkins][0]);
        cache_get_value_name_int(i, "fPoliceSkins2", fPoliceInfo[i][fPoliceSkins][1]);
        cache_get_value_name_int(i, "fPoliceSkins3", fPoliceInfo[i][fPoliceSkins][2]);
        cache_get_value_name_int(i, "fPoliceSkins4", fPoliceInfo[i][fPoliceSkins][3]);

        fPoliceInfo[i][fPolicePickup] = CreateMarker(ICON_POLICE_CAR, random(5), false, fPoliceInfo[i][fPoliceEntrance][0], fPoliceInfo[i][fPoliceEntrance][1],fPoliceInfo[i][fPoliceEntrance][2]-1.0, 0, 0);
		fPoliceInfo[i][fPolIDUsed] = true;
    }
    printf("\n[State Factions]: %d Factions ucitano.\n",rows);
    return (true);
}
