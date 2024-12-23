#include <ysilib\YSI_Coding\y_hooks>

//@TODO: Add argument for who is calling function to return success/fail to given entity
//========================================================================================================================================================
//--->>> Create bank account
//========================================================================================================================================================

stock CreateBankAccount(ownerid, OWNER_TYPE:ownertype = OWNER_TYPE_PLAYER)
{
    new Query[256];
    mysql_format(SQL, Query, sizeof(Query), "INSERT INTO `bankaccounts` SET `OwnerID` = %d, `OwnerType` = '%d'", ownerid, _:ownertype);
    mysql_tquery(SQL, Query, "SqlCreateBankAccount", "dd", ownerid, _:ownertype);
    return 1;
}
 
forward SqlCreateBankAccount(ownerid, OWNER_TYPE:ownertype);
public SqlCreateBankAccount(ownerid, OWNER_TYPE:ownertype) 
{
    new bankaccount = cache_insert_id();
    if(bankaccount == -1)
    {
        if(ownertype == OWNER_TYPE_PLAYER)
            SendClientMessage(ownerid, -1, "Failed to create new bank account.");

        printf("Failed to create new bank account.");
        return 0;
    }
    printf("You have created new bank account. Your account %d (IBAN %012d), owner id %d and owner type %s", bankaccount, bankaccount, ownerid,  OwnerTypeString[ownertype]);

    //Temporary solution, add arguments
    if(ownertype == OWNER_TYPE_PLAYER)
        SendClientMessage(ownerid, -1, "Bank account %d with IBAN %012d has been created for you.", bankaccount, bankaccount);
    return 1;
}

//========================================================================================================================================================
//--->>> Delete bank account
//========================================================================================================================================================
stock DeleteBankAccountByOwner(ownerid, OWNER_TYPE:ownertype)
{
    new Query[256];
    mysql_format(SQL, Query, sizeof(Query), "DELETE FROM `bankaccounts` WHERE `OwnerID` = %d AND `OwnerType` = %d", ownerid, _:ownertype);
    mysql_tquery(SQL, Query, "SqlDeleteBankAccount", "ddd", -1, ownerid, _:ownertype);
    return 1;
}

stock DeleteBankAccountByAccountID(accountid)
{
    new Query[256];
    mysql_format(SQL, Query, sizeof(Query), "DELETE FROM `bankaccounts` WHERE `AccountID` = %d", accountid);
    mysql_tquery(SQL, Query, "SqlDeleteBankAccount", "ddd", accountid, -1, -1);
    return 1;
}
//--------------------------------------------------------------------------------------------------------------------------------------------------------

//@TODO: Remove cards and stuff for closed bank account.
forward SqlDeleteBankAccount(accountid, ownerid, OWNER_TYPE:ownertype);
public SqlDeleteBankAccount(accountid, ownerid, OWNER_TYPE:ownertype) 
{
    new affectedrows = cache_affected_rows();
    if(affectedrows == -1)
    {
        printf("Failed to delete bank account %d owned by %s %d ", accountid,  OwnerTypeString[ownertype], ownerid);
        return 0;
    }

    printf("You have deleted bank account %d, owned by %s %d", accountid,  OwnerTypeString[ownertype], ownerid);
    return 1;
}

//========================================================================================================================================================
//--->>> Transfer bank account
//========================================================================================================================================================
stock TransferBankAccountOwnership(accountid, newownerid, OWNER_TYPE:newownertype)
{
    new Query[256];
    mysql_format(SQL, Query, sizeof(Query), "UPDATE `bankaccounts` SET `OwnerID` = %d, `OwnerType` = %d WHERE `AccountID` = %d", newownerid, _:newownertype, accountid);
    mysql_tquery(SQL, Query, "SqlTransferBankAccountOwnership", "ddd", accountid, newownerid, _:newownertype);
    return 1;
}

forward SqlTransferBankAccountOwnership(accountid, ownerid, OWNER_TYPE:ownertype);
public SqlTransferBankAccountOwnership(accountid, ownerid, OWNER_TYPE:ownertype) 
{
    new updatedrows = cache_affected_rows();
    if(updatedrows == -1) 
    {
        printf("Failed to transfer account %d to new owner %s - %d", accountid,  OwnerTypeString[ownertype], ownerid);
        return 0;
    }
    printf("You have transfered account %d to new owner %s - %d", accountid,  OwnerTypeString[ownertype], ownerid);
    return updatedrows;
}


//========================================================================================================================================================
//--->>> Get bank account details
//========================================================================================================================================================
stock GetAccountDetailsByID(accountid, offset = 0, limit = 10)
{
    new Query[256];
    mysql_format(SQL, Query, sizeof(Query), "SELECT * FROM `bankaccounts` WHERE `AccountID` = %d LIMIT %d OFFSET %d", accountid, limit, offset);
    mysql_tquery(SQL, Query, "SqlGetAccountDetails", "ddd", accountid, -1, -1);
    return 1;
}

stock GetAccountDetailsByOwner(ownerid, OWNER_TYPE:ownerype, offset = 0, limit = 10)
{

    new partialQueryStr[128];
    switch(ownertype)
    {
        case 0: partialQueryStr = "`characters` ON `characters`.`character_id` = `bankaccounts`.`OwnerID`";
    }


    new Query[256];
    mysql_format(SQL, Query, sizeof(Query), "SELECT * FROM `bankaccounts` INNER JOIN %s WHERE `bankaccounts`.`OwnerID` = %d AND `bankaccounts`.`OwnerType` = %d LIMIT %d OFFSET %d", partialQueryStr, ownerid, _:ownerype, limit, offset);
    mysql_tquery(SQL, Query, "SqlGetAccountDetails", "ddd", -1, ownerid, _:ownerype);    
    return 1;
}

forward SqlGetAccountDetails(accountid, ownerid, OWNER_TYPE:ownertype);
public SqlGetAccountDetails(accountid, ownerid, OWNER_TYPE:ownertype)
{
    if(cache_num_rows() < 1) 
    {
        printf("Failed to get bank account info for account %d, owner %d type %s", accountid, ownerid, OwnerTypeString[ownertype]);
        return 0;
    }

    new BankAccountID;
    new BankAccountOwnerID;
    new OWNER_TYPE:BankOwnerType;
    new Float:BankAccountCurrencies[3];

    cache_get_value_name_int(0, "AccountID", BankAccountID);
    cache_get_value_name_int(0, "OwnerID", BankAccountOwnerID);
    cache_get_value_name_int(0, "OwnerType", _:BankOwnerType);

    cache_get_value_name_float(0, "Dollar", BankAccountCurrencies[0]);
    cache_get_value_name_float(0, "Euro", BankAccountCurrencies[1]);
    cache_get_value_name_float(0, "Pound", BankAccountCurrencies[2]);
    return 1;
}

//========================================================================================================================================================
//--->>> Show bank accounts for player - GUI
//========================================================================================================================================================
stock ShowBankAccountsForPlayer(playerid, offset = 0, limit = 10)
{
    new Query[1024];
    new characterid = CharacterInfo[playerid][SQLID];

    /*
    mysql_format(SQL, Query, sizeof(Query), "SELECT `bankaccounts`.*, COALESCE(`characters`.`cName`, `factions`.`Name`) AS `OwnerName` FROM `bankaccounts`\
                                                LEFT JOIN `characters` ON `characters`.`character_id` = `bankaccounts`.`OwnerID` AND `bankaccounts`.`OwnerType` = 'Player'\
                                                LEFT JOIN `factions` ON `factions`.`ID` = `bankaccounts`.`OwnerID` AND `bankaccounts`.`OwnerType` = 'Faction'\
                                                WHERE (`bankaccounts`.`OwnerID` = %d AND `OwnerType` = 'Player') OR (`bankaccounts`.`OwnerType` = 'Faction' AND `factions`.`factionBoss` = %d)\
                                                LIMIT %d OFFSET %d", GetCharacterSQLID(playerid), GetCharacterSQLID(playerid), characterid, limit, offset);
    */
    mysql_format(SQL, Query, sizeof(Query),"SELECT `bankaccounts`.*, COALESCE(`characters`.`cName`, `factions`.`factionName`, `re_business`.`bName`) AS `OwnerName` FROM `bankaccounts`\
                                            LEFT JOIN `characters` ON `characters`.`character_id` = `bankaccounts`.`OwnerID` AND `bankaccounts`.`OwnerType` = 'Player'\
                                            LEFT JOIN `factions` ON `factions`.`factionID` = `bankaccounts`.`OwnerID` AND `bankaccounts`.`OwnerType` = 'Faction'\
                                            LEFT JOIN `re_business` ON `re_business`.`bID` = `bankaccounts`.`OwnerID` AND `bankaccounts`.`OwnerType` = 'Bussiness'\
                                            WHERE (`bankaccounts`.`OwnerID` = %d AND `OwnerType` = 'Player') OR (`bankaccounts`.`OwnerType` = 'Faction' AND `factions`.`factionBoss` = %d) OR (`bankaccounts`.`OwnerType` = 'Bussiness' AND `re_business`.`bOwner` = %d) LIMIT %d OFFSET %d",
                                            GetCharacterSQLID(playerid), GetCharacterSQLID(playerid), GetCharacterSQLID(playerid), limit, offset);


    mysql_tquery(SQL, Query, "SqlShowBankAccountsForPlayer", "dd", playerid, characterid);
    return 1;
}

forward SqlShowBankAccountsForPlayer(playerid, characterid);
public SqlShowBankAccountsForPlayer(playerid, characterid)
{
    SendClientMessage(playerid, -1, "Debug: SqlShowBankAccountsForPlayer(playerid = %d, characterid = %d);", playerid, characterid);

    if(cache_num_rows() < 1) 
    {
        // printf("Failed to show gui bank accounts for player %d character %d", playerid, characterid);
        ActivePlayerBankAccount[playerid] = -1;
        return 0;
    }

    ActivePlayerBankAccount[playerid] = 0;

    for(new i = 0; i < cache_num_rows(); i++)
    {
        new BankAccountID;
        new BankAccountOwnerID;
        new OWNER_TYPE:BankOwnerType;
        new BankOwnerName[56];
        new Float:BankAccountCurrencies[eCurrency];

        cache_get_value_name_int(i, "AccountID", BankAccountID);
        cache_get_value_name_int(i, "OwnerID", BankAccountOwnerID);
        cache_get_value_name_int(i, "OwnerType", _:BankOwnerType);
        
        cache_get_value_name(i, "OwnerName", _:BankOwnerName);

        cache_get_value_name_float(i, "Dollar", Float:BankAccountCurrencies[CURRENCY_DOLLAR]);
        cache_get_value_name_float(i, "Euro", Float:BankAccountCurrencies[CURRENCY_EURO]);
        cache_get_value_name_float(i, "Pound", Float:BankAccountCurrencies[CURRENCY_POUND]);

        ShowPlayerBankAccountInfo(playerid, i, BankAccountID, BankOwnerName,  BankAccountCurrencies);
    }
    return 1;
}

//* Frosty forgive me

hook OnPlayerConnect(playerid) {

    WithdrawCurrency[playerid] = 0;
    ActiveWithdrawAmmount[playerid] = 0.00;

    ActiveChosenCurrency[playerid] = 0;
    ActiveDepositAmmount[playerid] = 0.00;

    HideBankWithdrawPage(playerid);

    return Y_HOOKS_CONTINUE_RETURN_1;
}

forward CheckBankAccountAvailability(playerid, OWNER_TYPE:type);
public CheckBankAccountAvailability(playerid, OWNER_TYPE:type) {

    switch(type) {

        case OWNER_TYPE_PLAYER: {

            new rows = cache_num_rows();

            if(!rows) {

                CreateBankAccount(GetCharacterSQLID(playerid), OWNER_TYPE_PLAYER);
                SendClientMessage(playerid, x_server, "maryland \187; "c_white"Uspjesno ste otvorili bankovni racun, tip : Personal");

                if(QuestData[playerid][questDone][2] == 0) {

                    QuestData[playerid][questDone][2] = 1;
                    UpdateSqlInt(SQL, "character_quests", "Quest_3", 1, "characterid", GetCharacterSQLID(playerid));
                    SendClientMessage(playerid, x_server, "maryland \187; "c_white"Uspjesno ste zavrsili quest : %s", sz_QuestList[2][questName]);
                    GivePlayerMoney(playerid, sz_QuestList[2][questAwards][0]);
                    GiveCharXP(playerid, sz_QuestList[2][questAwards][1]);
                }

            }

            static accCount = 0;
            cache_get_value_name_int(0, "character_accs", accCount);

            if(accCount >= 8)
                return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Vec posjedujete maksimalan broj osobnih racuna [ 8 ]");

            CreateBankAccount(GetCharacterSQLID(playerid), OWNER_TYPE_PLAYER);
            SendClientMessage(playerid, x_server, "maryland \187; "c_white"Uspjesno ste otvorili bankovni racun, tip : Personal");
            return ~1;
        }

        case OWNER_TYPE_BUSINESS: {

            new rows = cache_num_rows();

            if(!rows) {

                CreateBankAccount(PlayerProperty[playerid][BusinessID], OWNER_TYPE_BUSINESS);
                SendClientMessage(playerid, x_server, "maryland \187; "c_white"Uspjesno ste otvorili bankovni racun, tip : Firma");

                if(QuestData[playerid][questDone][2] == 0) {

                    QuestData[playerid][questDone][2] = 1;
                    UpdateSqlInt(SQL, "character_quests", "Quest_3", 1, "characterid", GetCharacterSQLID(playerid));
                    SendClientMessage(playerid, x_server, "maryland \187; "c_white"Uspjesno ste zavrsili quest : %s", sz_QuestList[2][questName]);
                    GivePlayerMoney(playerid, sz_QuestList[2][questAwards][0]);
                    GiveCharXP(playerid, sz_QuestList[2][questAwards][1]);
                }
                
            }

            static accCount = 0;
            cache_get_value_name_int(0, "business_accs", accCount);

            if(accCount >= 1)
                return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Vec posjedujete maksimalan broj racuna za firmu [ 1 ]");

            CreateBankAccount(PlayerProperty[playerid][BusinessID], OWNER_TYPE_BUSINESS);
            SendClientMessage(playerid, x_server, "maryland \187; "c_white"Uspjesno ste otvorili bankovni racun, tip : Firma");
        }

        case OWNER_TYPE_FACTION: {

            new rows = cache_num_rows();

            if(!rows) {

                CreateBankAccount(FactionMember[playerid][factionID], OWNER_TYPE_FACTION);
                SendClientMessage(playerid, x_server, "maryland \187; "c_white"Uspjesno ste otvorili bankovni racun, tip : Fakcija");

                if(QuestData[playerid][questDone][2] == 0) {

                    QuestData[playerid][questDone][2] = 1;
                    UpdateSqlInt(SQL, "character_quests", "Quest_3", 1, "characterid", GetCharacterSQLID(playerid));
                    SendClientMessage(playerid, x_server, "maryland \187; "c_white"Uspjesno ste zavrsili quest : %s", sz_QuestList[2][questName]);
                    GivePlayerMoney(playerid, sz_QuestList[2][questAwards][0]);
                    GiveCharXP(playerid, sz_QuestList[2][questAwards][1]);
                }
            }

            static accCount = 0;
            cache_get_value_name_int(0, "faction_accs", accCount);

            if(accCount >= 1)
                return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Vec posjedujete maksimalan broj racuna za fakciju [ 1 ]");

            CreateBankAccount(FactionMember[playerid][factionID], OWNER_TYPE_FACTION);
            SendClientMessage(playerid, x_server, "maryland \187; "c_white"Uspjesno ste otvorili bankovni racun, tip : Fakcija");
        }
    }
    return 1;
}

YCMD:bank(playerid, params[], help) 
{

    if(!IsPlayerInRangeOfPoint(playerid, 1.7, 1276.6034,2567.2729,-21.6486))
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Ne nalazite se kod saltera u banci!");

    BankCreateMainUI(playerid);
	SelectTextDraw(playerid, -1);

    return 1;
}

//dialog_deleteBankAccount
Dialog:dialog_deleteBankAccount(const playerid, response, listitem, string: inputtext[]) {

    if(response) {

        new tmp_idx = ActivePlayerBankAccount[playerid];
        DeleteBankAccountByAccountID(PlayerBankAccounts[playerid][tmp_idx][IBAN]);
    }

    return (true);
}

Dialog:dialog_CreateBankAccount(const playerid, response, listitem, string: inputtext[]) {

    if(response) {

        switch(listitem) {

            case 0: {

                new q[128];
                mysql_format(SQL, q, sizeof q, "SELECT count(*) as `character_accs` FROM `bankaccounts` WHERE `OwnerID` = '%d' AND `OwnerType` = 'Player'", GetCharacterSQLID(playerid));
                mysql_tquery(SQL, q, "CheckBankAccountAvailability", "dd", playerid, _:OWNER_TYPE_PLAYER);

            }

            case 1: {
                
                new bool:businessFound = false;

                foreach(new i : iter_Business) {

                    if(re_BusinessData[i][bOwner] == GetCharacterSQLID(playerid))
                    {
                        businessFound = true;
                        break;
                    }
                }

                if(!businessFound)
                    return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Ne posjedujete firmu!");

                new q[128];
                mysql_format(SQL, q, sizeof q, "SELECT count(*) as `business_accs` FROM `bankaccounts` WHERE `OwnerID` = '%d' AND `OwnerType` = 'Bussiness'", PlayerProperty[playerid][BusinessID]);
                mysql_tquery(SQL, q, "CheckBankAccountAvailability", "dd", playerid, _:OWNER_TYPE_BUSINESS);

            }

            case 2: {

                if(FactionMember[playerid][factionID] == 0 && FactionMember[playerid][factionRank] != 4)
                    return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Niste leader niti jedne fakcije!");

                new q[128];
                mysql_format(SQL, q, sizeof q, "SELECT count(*) as `faction_accs` FROM `bankaccounts` WHERE `OwnerID` = '%d' AND `OwnerType` = 'Faction'", FactionMember[playerid][factionID]);
                mysql_tquery(SQL, q, "CheckBankAccountAvailability", "dd", playerid, _:OWNER_TYPE_FACTION);
            }
        }
    }

    return (true);
}

//* ActiveChosenCurrency[playerid]

Dialog:dialog_depositChoseCurrency(const playerid, response, listitem, string: inputtext[]) {

    if(response) {

        //->CurrencyString[CURRENCY_DOLLAR]
        // 
        ActiveChosenCurrency[playerid] = listitem+1;
        PlayerTextDrawSetString(playerid, BankDepositPageTDs[playerid][13], GetCurrencyString(eCurrency: (listitem+1) ));
        SendClientMessage(playerid, x_server, "maryland \187; "c_white"Izabrana valua : %s", GetCurrencyString(eCurrency: (listitem+1) ));

        PlayerTextDrawSetString(playerid, BankDepositPageTDs[playerid][20], "CURRENT: %.2f", PlayerBankAccounts[playerid][ ActivePlayerBankAccount[playerid] ][Currencies][ eCurrency:ActiveChosenCurrency[playerid] ]); 
    }

    if(!response)
        ActiveChosenCurrency[playerid] = 0;

    return (true);
}

Dialog:dialog_depositValue(const playerid, response, listitem, string: inputtext[]) {

    if(response) {

        new Float:depositAmount;
        ActiveDepositAmmount[playerid] = 0.00;

        if(sscanf(inputtext, "f", depositAmount))
            return Dialog_Show(playerid, "dialog_depositValue", DIALOG_STYLE_INPUT, ""c_ltorange"H4RBOR BANK \187; "c_white"Deposit Value",
                                                                             "Unesite zeljenu kolicinu novca za deposit.", "INPUT", "DENY");

        if(IsNull(inputtext))
            return Dialog_Show(playerid, "dialog_depositValue", DIALOG_STYLE_INPUT, ""c_ltorange"H4RBOR BANK \187; "c_white"Deposit Value",
                                                                             "Unesite zeljenu kolicinu novca za deposit.", "INPUT", "DENY");

        if(depositAmount <= 0 || depositAmount > GetPlayerMoney(playerid, eCurrency:ActiveChosenCurrency[playerid]))
            return Dialog_Show(playerid, "dialog_depositValue", DIALOG_STYLE_INPUT, ""c_ltorange"H4RBOR BANK \187; "c_white"Deposit Value",
                                                                             "Unesite zeljenu kolicinu novca za deposit.\n"c_ltorange"Nemate dovoljnu kolicinu novca pri ruci!", "INPUT", "DENY");

        ActiveDepositAmmount[playerid] = 0.00;
        ActiveDepositAmmount[playerid] += depositAmount;

        PlayerTextDrawSetString(playerid, BankDepositPageTDs[playerid][14], "%.2f", ActiveDepositAmmount[playerid]);
    }

    if(!response) {

        ActiveDepositAmmount[playerid] = 0.00;
        ActiveChosenCurrency[playerid] = 0;
    }

    return (true);
}

Dialog:dialog_withdrawChoseCurrency(const playerid, response, listitem, string: inputtext[]) {

    if(response) {

        WithdrawCurrency[playerid] = listitem+1;
        PlayerTextDrawSetString(playerid, BankWithdrawPageTDs[playerid][13], GetCurrencyString(eCurrency: (listitem+1) ));
        SendClientMessage(playerid, x_server, "maryland \187; "c_white"Izabrana valua : %s", GetCurrencyString(eCurrency: (listitem+1) ));
        PlayerTextDrawSetString(playerid, BankWithdrawPageTDs[playerid][20], "CURRENT: %.2f", PlayerBankAccounts[playerid][ ActivePlayerBankAccount[playerid] ][Currencies][ eCurrency:WithdrawCurrency[playerid] ]); 
    }

    if(!response) {

        WithdrawCurrency[playerid] = 0;
        ActiveWithdrawAmmount[playerid] = 0.00;
    }
    return (true);
}

Dialog:dialog_withdrawValue(const playerid, response, listitem, string: inputtext[]) {

    if(response) {

        new Float:withdrawAmount;
        ActiveWithdrawAmmount[playerid] = 0.00;

        if(sscanf(inputtext, "f", withdrawAmount))
            return Dialog_Show(playerid, "dialog_withdrawValue", DIALOG_STYLE_INPUT, ""c_ltorange"H4RBOR BANK \187; "c_white"Withdraw Value",
                                                                             "Unesite zeljenu kolicinu novca koju zelite podignuti za racuna.", "INPUT", "DENY");

        if(IsNull(inputtext))
            return Dialog_Show(playerid, "dialog_withdrawValue", DIALOG_STYLE_INPUT, ""c_ltorange"H4RBOR BANK \187; "c_white"Deposit Value",
                                                                             "Unesite zeljenu kolicinu novca koju zelite podignuti za racuna.", "INPUT", "DENY");

        if(withdrawAmount <= 0 || withdrawAmount > PlayerBankAccounts[playerid][ ActivePlayerBankAccount[playerid] ][Currencies][ eCurrency:WithdrawCurrency[playerid]])
            return Dialog_Show(playerid, "dialog_withdrawValue", DIALOG_STYLE_INPUT, ""c_ltorange"H4RBOR BANK \187; "c_white"Deposit Value",
                                                                             "Unesite zeljenu kolicinu novca koju zelite podignuti za racuna..\n"c_ltorange"Nemate dovoljnu kolicinu novca na racunu!", "INPUT", "DENY");

        ActiveWithdrawAmmount[playerid] = 0.00;
        ActiveWithdrawAmmount[playerid] += withdrawAmount;

        PlayerTextDrawSetString(playerid, BankWithdrawPageTDs[playerid][14], "%.2f", ActiveWithdrawAmmount[playerid]);
    }

    if(!response) {

        ActiveWithdrawAmmount[playerid] = 0.00;
        WithdrawCurrency[playerid] = 0;
    }

    return (true);
}