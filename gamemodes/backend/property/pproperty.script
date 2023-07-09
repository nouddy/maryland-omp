/***
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
 *  @Date           24th May 2023
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           pproperty.script
 *  @Module         property
 */

//? Player Property Script


hook OnPlayerLoaded(playerid)
{
    new q[150];
    mysql_format(SQL, q, sizeof(q), "SELECT * FROM player_property WHERE player_id = '%d' LIMIT 1", PlayerInfo[playerid][SQLID]);
    mysql_tquery(SQL, q, "LoadPlayerProperty", "i", playerid);
    return true;
}

forward LoadPlayerProperty(playerid);
public LoadPlayerProperty(playerid)
{
    new rows;
    cache_get_row_count(rows);
    if(!rows)
    {  
        new q[300];
        mysql_format(SQL, q, sizeof(q), 
           "INSERT INTO `player_property` (player_id, HouseID) \ 
            VALUES('%d', '-1')", PlayerInfo[playerid][SQLID]);
        mysql_tquery(SQL, q);
    }
    else
    {
        cache_get_value_name_int(0, "HouseID", PlayerProperty[playerid][HouseID]);
    }
}

YCMD:buyhouse(playerid, params[], help)
{
	new id = GetNearestHouse(playerid);

	if(id == -1)
		return SendClientMessage(playerid, x_red, "Nema kuca u vasoj blizini.");

	if (House_GetCount(playerid) >= 1)
		return SendClientMessage(playerid, x_red, "Mozete posedovati samo jednu kucu.");

	if (HouseData[id][houseOwner] != 0)
	    return SendClientMessage(playerid, x_red, "Ova kuca poseduje vlasnika.");

	if (HouseData[id][housePrice] > PlayerInfo[playerid][Novac])
	    return SendClientMessage(playerid, x_red, "Nemate dovoljno novca da kupite ovu kucu.");

    HouseData[id][houseOwner] = GetPlayerSQLID(playerid);
   	PlayerProperty[playerid][HouseID] = id;
	SavePropForPlayer(playerid);

	House_Label(id);
	House_Save(id);

    VosticGiveMoney(playerid, -HouseData[id][housePrice]);

    va_SendClientMessage(playerid, x_server, "Uspesno ste kupili kucu za %s",FormatNumber(HouseData[id][housePrice]));
	return (true);
}
YCMD:kuca(playerid, params[], help)
{
	if(PlayerProperty[playerid][HouseID] == -1)
		return SendClientMessage(playerid, x_red, "Vi nemate kucu.");

	foreach(new i : Kuce)
	{
		if(HouseData[i][houseOwner] == GetPlayerSQLID(playerid))
		{
			if(House_Inside(playerid))
			{
				OdabraoKucu[playerid] = i;
				Dialog_Show(playerid, dialog_kucaodabir, DIALOG_STYLE_LIST, "Maryland - Kuca Opcije:", "01\t\tInformacije o kuci\n02\t\tZakljucaj/Otkljucaj\n03\t\tLociraj Kucu\n04\t\tUnapredi kucu\n05\t\tProdaj kucu igracu", "Dalje", "Izlaz");
			}
			else
			{
				SendClientMessage(playerid, x_server, "Niste u kuci.");
				return 1;
			}
		}
	}
	return (true);
}

//----------------------------------------------------------------
Dialog:dialog_kucaodabir(playerid, response, listitem, inputtext[])
{
	if(!response) return OdabraoKucu[playerid] = -1;
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				new id = OdabraoKucu[playerid];
				if(inProperty[playerid] == -1)
					return SendClientMessage(playerid, x_red, "Niste u kuci.");

				new zakljucan[30];
				if(HouseData[id][houseLocked] == false) zakljucan = "Opened"; else zakljucan = "Locked";
				new string[200];
				format(string,sizeof(string),"{65FEAF}Informacije o kuci\n\t"c_white"Vlasnik Kuce: %s\n\tID Kuce: %d\n\tStatus vrata: %s\n\t"c_white"Cena kuce: %s",ReturnPlayerName(playerid),id,zakljucan,FormatNumber(HouseData[id][housePrice]));
				Dialog_Show(playerid, dialog_none, DIALOG_STYLE_MSGBOX, "Informacije o kuci", string, "Nazad", "");
				OdabraoKucu[playerid] = -1;
			}
			case 1:
			{
				new id = OdabraoKucu[playerid];

				if(IsPlayerInRangeOfPoint(playerid, 2.0, HouseData[id][housePos][0],HouseData[id][housePos][1],HouseData[id][housePos][2]) || inProperty[playerid] == id)
				{
					if (!HouseData[id][houseLocked])
					{
						HouseData[id][houseLocked] = true;
						House_Save(id);
						House_Label(id);

						SendClientMessage(playerid, x_server, "Uspesno ste zakljucali vasu kucu.");
						PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
						OdabraoKucu[playerid] = -1;
					}
					else
					{
						HouseData[id][houseLocked] = false;
						House_Save(id);
						House_Label(id);

						SendClientMessage(playerid, x_server, "Uspesno ste otkljucali vasu kucu.");
						PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
						OdabraoKucu[playerid] = -1;
					}
				}

			}
			case 2 .. 4:
			{
				return SendClientMessage(playerid, x_red, "Trenutno nedostupno.");
			}
		}
	}
	return (true);
}