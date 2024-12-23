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
 *  @Date           22th Dec 2024
 *  @Weburl         weburl
 *  @Project        maryland_project
 *
 *  @File           lifeinsurance.pwn
 *  @Module         modules
 
*/

#include <ysilib\YSI_Coding\y_hooks>

#define INSURANCE_COST      250.0 //(dodati na racune koji idu svakih sat vremena da mu se skida kao 5$ za mesecno odrzavanje osiguranja)
#define DEATH_PENALTY_RATE  0.05 // 5% od ukupne kolicine novca koju ima 

enum E_INSURANCE {
    bool:hasInsurance
}
new g_PlayerInsurance[MAX_PLAYERS][E_INSURANCE];

hook OnGameModeInit()
{
    print("misc/lifeinsurance.pwn loaded");
    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerConnect(playerid)
{
    g_PlayerInsurance[playerid][hasInsurance] = false;
    return Y_HOOKS_CONTINUE_RETURN_1;
}

stock HasLifeInsurance(playerid)
{
    return g_PlayerInsurance[playerid][hasInsurance];
}

hook OnPlayerDeath(playerid, killerid, reason)
{
    if(!HasLifeInsurance(playerid))
    {
        new Float:money = GetPlayerMoney(playerid);
        new Float:penalty = money * DEATH_PENALTY_RATE;
        GivePlayerMoney(playerid, -penalty);
        
        new string[128];
        format(string, sizeof(string), "LIFE-INSURANCE: Izgubio si $%.2f zbog toga sto nemas osiguranje!", penalty);
        SendClientMessage(playerid, x_ltred, string);
    }
    else
    {
        SendClientMessage(playerid, x_green, "LIFE-INSURANCE: Osiguranje ti je spasilo novac!");
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}


hook OnCharacterLoaded(playerid)
{
    LoadPlayerInsurance(playerid);
    
    return true;
}

forward OnPlayerInsuranceLoad(playerid);
public OnPlayerInsuranceLoad(playerid)
{
    if(!cache_num_rows()) 
    {
        new query[128];
        mysql_format(SQL, query, sizeof(query), 
           "INSERT INTO life_insurance (character_id, purchase_date, expiry) VALUES (%d, NOW(), NOW())",
           GetCharacterSQLID(playerid)
        );
        mysql_tquery(SQL, query);
        g_PlayerInsurance[playerid][hasInsurance] = false;
    }
    else 
    {
        new query[128];
        mysql_format(SQL, query, sizeof(query), 
            "SELECT IF(expiry > NOW(), 1, 0) as valid FROM life_insurance WHERE character_id = %d",
            GetCharacterSQLID(playerid)
        );
        mysql_tquery(SQL, query, "OnInsuranceValidCheck", "i", playerid);
    }
}

forward OnInsuranceValidCheck(playerid);
public OnInsuranceValidCheck(playerid)
{
    if(cache_num_rows())
    {
        new bool:is_valid;
        cache_get_value_name_int(0, "valid", is_valid);
        
        if(is_valid)
        {
            g_PlayerInsurance[playerid][hasInsurance] = true;
        }
        else
        {
            DeleteExpiredInsurance(playerid);
        }
    }
}

stock LoadPlayerInsurance(playerid)
{
    new query[128];
    mysql_format(SQL, query, sizeof(query), 
        "SELECT * FROM life_insurance WHERE character_id = %d", GetCharacterSQLID(playerid));
    mysql_tquery(SQL, query, "OnPlayerInsuranceLoad", "i", playerid);
    return (true);
}

stock DeleteExpiredInsurance(playerid)
{
    g_PlayerInsurance[playerid][hasInsurance] = false;
    
    new query[128];
    mysql_format(SQL, query, sizeof(query), 
        "DELETE FROM life_insurance WHERE character_id = %d", 
        GetCharacterSQLID(playerid)
    );
    mysql_tquery(SQL, query);
}

Dialog:INSURANCE_PURCHASE(playerid, response, listitem, inputtext[])
{
    if(!response) return (true);
    
    if(HasLifeInsurance(playerid))
    {
        SendClientMessage(playerid, x_ltred, "LIFE-INSURANCE: Vec imas zivotno osiguranje!");
        return (true);
    }
    
    if(GetPlayerMoney(playerid) < INSURANCE_COST)
    {
        SendClientMessage(playerid, x_ltred, "LIFE-INSURANCE: Nemas dovoljno novca!");
        return (true);
    }
    
    GivePlayerMoney(playerid, -INSURANCE_COST);
    
    new query[256];
    mysql_format(SQL, query, sizeof(query), 
        "UPDATE life_insurance SET purchase_date = NOW(), expiry = DATE_ADD(NOW(), INTERVAL 30 DAY) WHERE character_id = %d",
        GetCharacterSQLID(playerid)
    );
    mysql_tquery(SQL, query, "OnInsurancePurchased", "i", playerid);
    
    SendClientMessage(playerid, x_green, "LIFE-INSURANCE: Kupio si zivotno osiguranje na 30 dana!");
    return (true);
}

forward OnInsurancePurchased(playerid);
public OnInsurancePurchased(playerid)
{
    g_PlayerInsurance[playerid][hasInsurance] = true;
}

YCMD:checkinsurance(playerid, params[], help)
{
    if(!HasLifeInsurance(playerid))
    {
        SendClientMessage(playerid, x_ltred, "LIFE-INSURANCE: Nemas zivotno osiguranje!");
        return (true);
    }
    
    new query[128];
    mysql_format(SQL, query, sizeof(query), 
        "SELECT DATEDIFF(expiry, NOW()) as days_left FROM life_insurance WHERE character_id = %d",
        GetCharacterSQLID(playerid)
    );
    mysql_tquery(SQL, query, "OnCheckInsurance", "i", playerid);
    return (true);
}

YCMD:buyinsurance(playerid, params[], help)
{
    // if(!IsPlayerInBank(playerid))
    //     return SendClientMessage(playerid, x_red, "Moras biti u banci da kupis osiguranje!"); dodati ovo kasnije
        
    new string[256];
    format(string, sizeof(string), 
        "Zivotno osiguranje\n\n\
        Cena: $%.2f\n\
        Trajanje: 30 dana\n\
        Prednosti:\n\
        - Ne izgubis novac na smrti\n\
        - Mir u duhu\n\n\
        Zelis li da kupis zivotno osiguranje?",
        INSURANCE_COST
    );
    
    Dialog_Show(playerid, "INSURANCE_PURCHASE", DIALOG_STYLE_MSGBOX,
        "Kupovina zivotnog osiguranja",
        string,
        "Kupi", "Odustani"
    );
    return (true);
}
