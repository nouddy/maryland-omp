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
 *  @Author         Vostic
 *  @Date           27th May 2023
 *  @Weburl         weburl
 *  @Project        maryland_project
 *
 *  @File           clickplayertd.asset
 *  @Module         asset
 */

 //? Hook zbog truncated 31 characters

#include <ysilib\YSI_Coding\y_hooks>

hook OnGameModeInit()
{
	print("backend/asset/clickplayertd.asset loaded");


    return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if(playertextid == Register_PTD[playerid][50])
	{
		if(RegisterPass[playerid])
			return SendClientMessage(playerid, x_ogyColour, "> Vec ste popunili ovo polje.");

		Dialog_Show(playerid, "dialog_regpassword", DIALOG_STYLE_INPUT,
					"Registracija",
					"%s, unesite Vasu zeljenu lozinku: ",
					"Potvrdi", "Izlaz", ReturnPlayerName(playerid)
				);		
	}
	else if(playertextid == Register_PTD[playerid][49]) // email
	{
		if(RegisterEmail[playerid])
			return SendClientMessage(playerid, x_ogyColour, "> Vec ste popunili ovo polje.");


		Dialog_Show(playerid, "dialog_reggmail", DIALOG_STYLE_INPUT,
			"Email",
			"Upisite vas email, sa kojim cete u slucaju gubitka akaunta vratiti isti.",
			"Unesi", "Izlaz"
			);
	}
	else if(playertextid == Register_PTD[playerid][51]) // drzava
	{
		if(RegisterDrzava[playerid])
			return SendClientMessage(playerid, x_ogyColour, "> Vec ste popunili ovo polje.");


		Dialog_Show(playerid, "dialog_regdrzava", DIALOG_STYLE_LIST,
			"Izaberite drzavu",
			"Srbija\nCrna Gora\nBosna i Hercegovina\nMakedonija\nHrvatska\nSlovenija",
			"Unesi", "Izlaz"
			);
	}	
	else if(playertextid == Register_PTD[playerid][52])
	{
		if(RegisterGodine[playerid])
			return SendClientMessage(playerid, x_ogyColour, "> Vec ste popunili ovo polje.");


		Dialog_Show(playerid, "dialog_regages", DIALOG_STYLE_INPUT,
			"Godine",
			"Koliko imate godina: ",
			"Unesi", "Izlaz"
			);
	}
	else if(playertextid == Register_PTD[playerid][53]) // pol
	{
		if(RegisterPol[playerid])
			return SendClientMessage(playerid, x_ogyColour, "> Vec ste popunili ovo polje.");


		Dialog_Show(playerid, "dialog_regpol", DIALOG_STYLE_LIST,
			"Odaberite koji ste pol",
			"Musko\nZensko",
			"Unesi", "Izlaz"
			);
	}
	else if(playertextid == Register_PTD[playerid][55])
	{
		if(!RegisterPol[playerid] || !RegisterPass[playerid] || !RegisterEmail[playerid] || !RegisterDrzava[playerid] || !RegisterGodine[playerid])
			return SendClientMessage(playerid, x_ogyColour, "> Nesto od ponudjenih delova registera niste popunili.");


		if(Registered[playerid])
			return SendClientMessage(playerid, x_ogyColour, "> Vas akaunt je vec napravljen u bazi podataka, sacekajte...");

		CreatePlayerRegister(playerid, false);
		new query[550];
		mysql_format(SQL, query, sizeof(query), "INSERT INTO `players` (`Username`, `Password`, `Skin`, `Level`, `Novac`, `Godine`, `RegisterDate`, `Email`, `Drzava`, `Pol`) \ 
			VALUES ('%e', '%d', '%d', '1', '2000', '%d', '%e', '%e', '%e', '%e')", 
			ReturnPlayerName(playerid), PlayerInfo[playerid][Password], PlayerInfo[playerid][Skin], PlayerInfo[playerid][Godine], ReturnDate(), PlayerInfo[playerid][Email],PlayerInfo[playerid][Drzava],PlayerInfo[playerid][Pol] );
		mysql_tquery(SQL, query, "PlayerRegistered", "i", playerid);


		Registered[playerid] = true;
		defer Register_Player(playerid);
	}
	else if(playertextid == OdabirSkina_PTD[playerid][3]) // sesir promeni samo ono sranje td
	{	
		if(PlayerInfo[playerid][AttachedObject][0] != -1)
			return SendClientMessage(playerid, 0x8D9BFFFF, "[Dodan objekat]: {ffffff}Vec posedujete objekat na tom delu.");


		PlayerInfo[playerid][AttachedObject][0] = SetPlayerAttachedObject(playerid, 1, 18968, 2,  0.176000, -0.011000, -0.001000,  89.400024, 79.100112, 1.600000,  1.000000, 1.000000, 1.000000); // 29
		SendClientMessage(playerid, 0x8D9BFFFF, "[Dodan objekat]: {ffffff}Dodali ste objekat na vase telo.");

		PlayerInfo[playerid][AttachedObject][0]  = 1;
	}
	else if(playertextid == OdabirSkina_PTD[playerid][7]) // naocare promeni samo ono sranje td
	{
		if(PlayerInfo[playerid][AttachedObject][1] != -1)
			return SendClientMessage(playerid, 0x8D9BFFFF, "[Dodan objekat]: {ffffff}Vec posedujete objekat na tom delu.");



		PlayerInfo[playerid][AttachedObject][1] = SetPlayerAttachedObject(playerid, 1, 19025, 2,  0.086000, 0.013999, -0.001000,  89.500022, 72.500076, 1.600000,  1.000000, 1.000000, 1.000000); // 289

		PlayerInfo[playerid][AttachedObject][1] = 1;

		SendClientMessage(playerid, 0x8D9BFFFF, "[Dodan objekat]: {ffffff}Dodali ste objekat na vase telo.");
	}
	else if(playertextid == OdabirSkina_PTD[playerid][8]) // nastavi deo promeni samo ono sranje td
	{
		Dialog_Show(playerid, "dialog_confirmreg", DIALOG_STYLE_MSGBOX,
				"Odabir karaktera.",
				"Postovani %s, posedujete dodatke\nObjekat1 > %s\nObjekat2 > %s\nDa li zelite da nastavite?",
				"Nastavi", "Skini Objekat", ReturnPlayerName(playerid),PlayerInfo[playerid][AttachedObject][0] == 1 ? "{36FF00}Kapica." : "{FF2D00}Nista.", PlayerInfo[playerid][AttachedObject][1] == 1 ? "{36FF00}Naocare." : "{FF2D00}Nista."
		);
	}
	else if(playertextid == BinanceTD[playerid][159])
	{
		Dialog_Show(playerid, dialog_cryptofaq, DIALOG_STYLE_LIST, "Crypto Cesta pitanja:", "Kako ovaj system funkcionise?\nKako kupovati?\nKako prodavati?\nZasto bas ovo?", "Dalje", "Izlaz");
	}
	else if(playertextid == BinanceTD[playerid][149])
	{
		Dialog_Show(playerid, dialog_kupibtc, DIALOG_STYLE_INPUT, "Kupovina BTC", "Upisite za koliko novca zelite da kupite ovu kriptovalutu:\n\n** CENA BITCOINA VARIRA PROVERITE PRE KUPOVINE.", "Dalje", "Izlaz");
	}
	else if(playertextid == BinanceTD[playerid][154])
	{
		Dialog_Show(playerid, dialog_prodajbtc, DIALOG_STYLE_INPUT, "Prodaja BTC", "Upisite za koliko novca zelite da prodate ovu kriptovalutu:\n\n** CENA BITCOINA VARIRA PROVERITE PRE PRODAJE.", "Dalje", "Izlaz");
	}
	else if(playertextid == BinanceTD[playerid][150])
	{
		Dialog_Show(playerid, dialog_kupiltc, DIALOG_STYLE_INPUT, "Kupovina LTC", "Upisite za koliko novca zelite da kupite ovu kriptovalutu:\n\n** CENA BITCOINA VARIRA PROVERITE PRE KUPOVINE.", "Dalje", "Izlaz");
	}
	else if(playertextid == BinanceTD[playerid][151])
	{
		Dialog_Show(playerid, dialog_kupiusdt, DIALOG_STYLE_INPUT, "Kupovina USDT", "Upisite za koliko novca zelite da kupite ovu kriptovalutu:\n\n** CENA BITCOINA VARIRA PROVERITE PRE KUPOVINE.", "Dalje", "Izlaz");
	}
	else if(playertextid == BinanceTD[playerid][152])
	{
		Dialog_Show(playerid, dialog_kupidot, DIALOG_STYLE_INPUT, "Kupovina DOT", "Upisite za koliko novca zelite da kupite ovu kriptovalutu:\n\n** CENA BITCOINA VARIRA PROVERITE PRE KUPOVINE.", "Dalje", "Izlaz");
	}
	else if(playertextid == BinanceTD[playerid][153])
	{
		Dialog_Show(playerid, dialog_kupixrp, DIALOG_STYLE_INPUT, "Kupovina XRP", "Upisite za koliko novca zelite da kupite ovu kriptovalutu:\n\n** CENA BITCOINA VARIRA PROVERITE PRE KUPOVINE.", "Dalje", "Izlaz");
	}
	return 1;
}