#include <ysilib\YSI_Coding\y_hooks>

//@TODO: Add argument for who is calling function to return success/fail to given entity
//========================================================================================================================================================
//--->>> Create bank account
//========================================================================================================================================================
stock CreateBankAccount(ownerid, OWNER_TYPE:ownertype = OWNER_TYPE_PLAYER)
{
    new Query[256];
    mysql_format(SQL, Query, sizeof(Query), "INSERT INTO `bank_accounts` SET `OwnerID` = %d, `OwnerType` = '%d'", ownerid, _:ownertype);
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
    mysql_format(SQL, Query, sizeof(Query), "DELETE FROM `bank_accounts` WHERE `OwnerID` = %d AND `OwnerType` = %d", ownerid, _:ownertype);
    mysql_tquery(SQL, Query, "SqlDeleteBankAccount", "ddd", -1, ownerid, _:ownertype);
    return 1;
}

stock DeleteBankAccountByAccountID(accountid)
{
    new Query[256];
    mysql_format(SQL, Query, sizeof(Query), "DELETE FROM `bank_accounts` WHERE `ID` = %d", accountid);
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
    mysql_format(SQL, Query, sizeof(Query), "UPDATE `bank_accounts` SET `OwnerID` = %d, `OwnerType` = %d WHERE `ID` = %d", newownerid, _:newownertype, accountid);
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
    mysql_format(SQL, Query, sizeof(Query), "SELECT * FROM `bank_accounts` WHERE `ID` = %d LIMIT %d OFFSET %d", accountid, limit, offset);
    mysql_tquery(SQL, Query, "SqlGetAccountDetails", "ddd", accountid, -1, -1);
    return 1;
}

stock GetAccountDetailsByOwner(ownerid, OWNER_TYPE:ownerype, offset = 0, limit = 10)
{

    new partialQueryStr[128];
    switch(ownertype)
    {
        case 0: partialQueryStr = "`characters` ON `characters`.`ID` = `bank_accounts`.`OwnerID`";
    }


    new Query[256];
    mysql_format(SQL, Query, sizeof(Query), "SELECT * FROM `bank_accounts` INNER JOIN %s WHERE `bank_accounts`.`OwnerID` = %d AND `bank_accounts`.`OwnerType` = %d LIMIT %d OFFSET %d", partialQueryStr, ownerid, _:ownerype, limit, offset);
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

    cache_get_value_name_int(0, "ID", BankAccountID);
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
    mysql_format(SQL, Query, sizeof(Query),"SELECT `bankaccounts`.*, COALESCE(`characters`.`cName`, `factions`.`factionName`) AS `OwnerName` FROM `bankaccounts`\
                                            LEFT JOIN `characters` ON `characters`.`character_id` = `bankaccounts`.`OwnerID` AND `bankaccounts`.`OwnerType` = 'Player'\
                                            LEFT JOIN `factions` ON `factions`.`factionID` = `bankaccounts`.`OwnerID` AND `bankaccounts`.`OwnerType` = 'Faction'\
                                            WHERE (`bankaccounts`.`OwnerID` = %d AND `OwnerType` = 'Player') OR (`bankaccounts`.`OwnerType` = 'Faction' AND `factions`.`factionBoss` = %d) LIMIT %d OFFSET %d",
                                            GetCharacterSQLID(playerid), GetCharacterSQLID(playerid), limit, offset);


    mysql_tquery(SQL, Query, "SqlShowBankAccountsForPlayer", "dd", playerid, characterid);
    return 1;
}

forward SqlShowBankAccountsForPlayer(playerid, characterid);
public SqlShowBankAccountsForPlayer(playerid, characterid)
{
    SendClientMessage(playerid, -1, "Debug: SqlShowBankAccountsForPlayer(playerid = %d, characterid = %d);", playerid, characterid);

    if(cache_num_rows() < 1) 
    {
        printf("Failed to show gui bank accounts for player %d character %d", playerid, characterid);
        return 0;
    }

    for(new i = 0; i < cache_num_rows(); i++)
    {
        new BankAccountID;
        new BankAccountOwnerID;
        new OWNER_TYPE:BankOwnerType;
        new BankOwnerName[56];
        new Float:BankAccountCurrencies[MONEY_TYPE];

        cache_get_value_name_int(i, "AccountID", BankAccountID);
        cache_get_value_name_int(i, "OwnerID", BankAccountOwnerID);
        cache_get_value_name_int(i, "OwnerType", _:BankOwnerType);
        
        cache_get_value_name(i, "OwnerName", _:BankOwnerName);

        cache_get_value_name_float(i, "Dollar", Float:BankAccountCurrencies[MONEY_TYPE_DOLLAR]);
        cache_get_value_name_float(i, "Euro", Float:BankAccountCurrencies[MONEY_TYPE_EURO]);
        cache_get_value_name_float(i, "Pound", Float:BankAccountCurrencies[MONEY_TYPE_POUND]);

        ShowPlayerBankAccountInfo(playerid, i, BankAccountID, BankOwnerName,  BankAccountCurrencies);
    }
    return 1;
}

