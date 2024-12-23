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
 *  @Author         Author
 *  @Date           27th May 2023
 *  @Weburl         weburl
 *  @Project        maryland_project
 *
 *  @File           .pwn
 *  @Module         modules
 */

#include <ysilib\YSI_Coding\y_hooks>

#define CRYPTO_EXCHANGE_FEE 0.05 // 5% fee for crypto-to-crypto exchange
#define CRYPTO_CASH_FEE    0.10 // 10% fee for crypto-to-cash
#define CRYPTO_TRANSFER_FEE 0.03 // 3% fee for player-to-player transfers

enum {
    CRYPTO_BITCOIN,
    CRYPTO_ETHEREUM,
    CRYPTO_LITECOIN,
    CRYPTO_DOGECOIN,
    CRYPTO_TETHER
}

enum E_CRYPTO_DATA {
    crypto_Name[32],
    Float:crypto_CurrentPrice,
    Float:crypto_MinPrice,
    Float:crypto_MaxPrice
}

new const g_CryptoInfo[5][E_CRYPTO_DATA] = {
    {"Bitcoin",    35000.0, 30000.0, 40000.0},
    {"Ethereum",   2200.0,  1800.0,  2500.0},
    {"Litecoin",   180.0,   150.0,   200.0},
    {"Dogecoin",   0.25,    0.15,    0.35},
    {"Tether",     1.0,     0.98,    1.02}
};

enum E_PLAYER_CRYPTO {
    Float:playerBTC,
    Float:playerETH,
    Float:playerLTC,
    Float:playerDOGE,
    Float:playerUSDT
}
new g_PlayerCrypto[MAX_PLAYERS][E_PLAYER_CRYPTO];

// Current prices that change hourly
new Float:g_CurrentPrices[5];

hook OnGameModeInit()
{
    print("misc/cryptovoki.pwn loaded");
    
    // Initialize starting prices
    for(new i = 0; i < 5; i++) {
        g_CurrentPrices[i] = g_CryptoInfo[i][crypto_CurrentPrice];
    }
    
    // Start global price update timer
    SetTimer("UpdateCryptoPrices", 3600000, true); // Every hour
    
    return Y_HOOKS_CONTINUE_RETURN_1;
}

forward UpdateCryptoPrices();
public UpdateCryptoPrices()
{
    for(new i = 0; i < 5; i++)
    {
        new Float:range = g_CryptoInfo[i][crypto_MaxPrice] - g_CryptoInfo[i][crypto_MinPrice];
        new Float:change = (random(200) - 100) / 100.0 * (range * 0.1); // Max 10% change
        
        g_CurrentPrices[i] += change;
        
        // Keep within bounds
        if(g_CurrentPrices[i] < g_CryptoInfo[i][crypto_MinPrice])
            g_CurrentPrices[i] = g_CryptoInfo[i][crypto_MinPrice];
        else if(g_CurrentPrices[i] > g_CryptoInfo[i][crypto_MaxPrice])
            g_CurrentPrices[i] = g_CryptoInfo[i][crypto_MaxPrice];
    }
    
    // Notify all players
    foreach(new i : Player) {
        if(pConnectState[i] == PLAYER_CONNECT_STATE_CONNECTED) {
            SendClientMessage(i, x_ltorange, "CRYPTO: Crypto cene su azurirane! Koristi /crypto da proveris nove cene.");
        }
    }
}

hook OnCharacterLoaded(playerid)
{
    LoadPlayerCrypto(playerid);
    return Y_HOOKS_CONTINUE_RETURN_1;
}

forward OnPlayerCryptoLoad(playerid);
public OnPlayerCryptoLoad(playerid)
{
    if(!cache_num_rows())
    {
        new query[128];
        mysql_format(SQL, query, sizeof(query),
            "INSERT INTO crypto_wallets (character_id) VALUES (%d)",
            GetCharacterSQLID(playerid)
        );
        mysql_tquery(SQL, query);
        
        // Initialize with 0
        g_PlayerCrypto[playerid][playerBTC] = 0.0;
        g_PlayerCrypto[playerid][playerETH] = 0.0;
        g_PlayerCrypto[playerid][playerLTC] = 0.0;
        g_PlayerCrypto[playerid][playerDOGE] = 0.0;
        g_PlayerCrypto[playerid][playerUSDT] = 0.0;
    }
    else
    {
        cache_get_value_name_float(0, "bitcoin", g_PlayerCrypto[playerid][playerBTC]);
        cache_get_value_name_float(0, "ethereum", g_PlayerCrypto[playerid][playerETH]);
        cache_get_value_name_float(0, "litecoin", g_PlayerCrypto[playerid][playerLTC]);
        cache_get_value_name_float(0, "dogecoin", g_PlayerCrypto[playerid][playerDOGE]);
        cache_get_value_name_float(0, "tether", g_PlayerCrypto[playerid][playerUSDT]);
    }
}

stock Float:GetCryptoPrice(type)
{
    if(type < 0 || type >= 5) return 0.0;
    return g_CurrentPrices[type];
}

stock bool:SellCrypto(playerid, type, Float:amount)
{
    if(amount <= 0.0) return false;
    
    new Float:current = 0.0;
    switch(type)
    {
        case CRYPTO_BITCOIN:  current = g_PlayerCrypto[playerid][playerBTC];
        case CRYPTO_ETHEREUM: current = g_PlayerCrypto[playerid][playerETH];
        case CRYPTO_LITECOIN: current = g_PlayerCrypto[playerid][playerLTC];
        case CRYPTO_DOGECOIN: current = g_PlayerCrypto[playerid][playerDOGE];
        case CRYPTO_TETHER:   current = g_PlayerCrypto[playerid][playerUSDT];
    }
    
    if(current < amount) return false;
    
    new Float:value = amount * GetCryptoPrice(type);
    GivePlayerMoney(playerid, floatround(value, floatround_floor));
    
    switch(type)
    {
        case CRYPTO_BITCOIN:  g_PlayerCrypto[playerid][playerBTC] -= amount;
        case CRYPTO_ETHEREUM: g_PlayerCrypto[playerid][playerETH] -= amount;
        case CRYPTO_LITECOIN: g_PlayerCrypto[playerid][playerLTC] -= amount;
        case CRYPTO_DOGECOIN: g_PlayerCrypto[playerid][playerDOGE] -= amount;
        case CRYPTO_TETHER:   g_PlayerCrypto[playerid][playerUSDT] -= amount;
    }
    
    SavePlayerCrypto(playerid);
    return true;
}

stock SavePlayerCrypto(playerid)
{
    new query[512];
    mysql_format(SQL, query, sizeof(query),
        "UPDATE crypto_wallets SET bitcoin = %.8f, ethereum = %.8f, litecoin = %.8f, dogecoin = %.8f, tether = %.8f WHERE character_id = %d",
        g_PlayerCrypto[playerid][playerBTC],
        g_PlayerCrypto[playerid][playerETH],
        g_PlayerCrypto[playerid][playerLTC],
        g_PlayerCrypto[playerid][playerDOGE],
        g_PlayerCrypto[playerid][playerUSDT],
        GetCharacterSQLID(playerid)
    );
    mysql_tquery(SQL, query);
}

stock LoadPlayerCrypto(playerid)
{
    new query[128];
    mysql_format(SQL, query, sizeof(query),
        "SELECT * FROM crypto_wallets WHERE character_id = %d",
        GetCharacterSQLID(playerid)
    );
    mysql_tquery(SQL, query, "OnPlayerCryptoLoad", "i", playerid);
}

// Funkcija za transfer crypto izmedju igraca
stock bool:TransferCrypto(playerid, targetid, cryptotype, Float:amount)
{
    if(amount <= 0.0) return false;
    
    new Float:current = 0.0;
    switch(cryptotype)
    {
        case CRYPTO_BITCOIN:  current = g_PlayerCrypto[playerid][playerBTC];
        case CRYPTO_ETHEREUM: current = g_PlayerCrypto[playerid][playerETH];
        case CRYPTO_LITECOIN: current = g_PlayerCrypto[playerid][playerLTC];
        case CRYPTO_DOGECOIN: current = g_PlayerCrypto[playerid][playerDOGE];
        case CRYPTO_TETHER:   current = g_PlayerCrypto[playerid][playerUSDT];
    }
    
    new Float:fee = amount * CRYPTO_TRANSFER_FEE;
    new Float:total_amount = amount + fee;
    
    if(current < total_amount) return false;
    
    // Oduzmi od onoga kome saljes (amount + fee)
    switch(cryptotype)
    {
        case CRYPTO_BITCOIN:  g_PlayerCrypto[playerid][playerBTC] -= total_amount;
        case CRYPTO_ETHEREUM: g_PlayerCrypto[playerid][playerETH] -= total_amount;
        case CRYPTO_LITECOIN: g_PlayerCrypto[playerid][playerLTC] -= total_amount;
        case CRYPTO_DOGECOIN: g_PlayerCrypto[playerid][playerDOGE] -= total_amount;
        case CRYPTO_TETHER:   g_PlayerCrypto[playerid][playerUSDT] -= total_amount;
    }
    
    // Dodaj igracu koji prima (samo amount, fee se "spaljuje")
    switch(cryptotype)
    {
        case CRYPTO_BITCOIN:  g_PlayerCrypto[targetid][playerBTC] += amount;
        case CRYPTO_ETHEREUM: g_PlayerCrypto[targetid][playerETH] += amount;
        case CRYPTO_LITECOIN: g_PlayerCrypto[targetid][playerLTC] += amount;
        case CRYPTO_DOGECOIN: g_PlayerCrypto[targetid][playerDOGE] += amount;
        case CRYPTO_TETHER:   g_PlayerCrypto[targetid][playerUSDT] += amount;
    }
    
    SavePlayerCrypto(playerid);
    SavePlayerCrypto(targetid);
    
    new string[128];
    format(string, sizeof(string), "CRYPTO: Poslao si %.8f %s igracu %s (Fee: %.8f)", 
        amount, g_CryptoInfo[cryptotype][crypto_Name], ReturnPlayerName(targetid), fee);
    SendClientMessage(playerid, x_ltorange, string);
    
    format(string, sizeof(string), "CRYPTO: Primio si %.8f %s od igraca %s", 
        amount, g_CryptoInfo[cryptotype][crypto_Name], ReturnPlayerName(playerid));
    SendClientMessage(targetid, x_ltorange, string);
    
    return true;
}

// Funkcija za zamenu jedne kriptovalute za drugu
stock bool:ExchangeCrypto(playerid, from_type, to_type, Float:amount)
{
    if(amount <= 0.0 || from_type == to_type) return false;
    
    new Float:current = 0.0;
    switch(from_type)
    {
        case CRYPTO_BITCOIN:  current = g_PlayerCrypto[playerid][playerBTC];
        case CRYPTO_ETHEREUM: current = g_PlayerCrypto[playerid][playerETH];
        case CRYPTO_LITECOIN: current = g_PlayerCrypto[playerid][playerLTC];
        case CRYPTO_DOGECOIN: current = g_PlayerCrypto[playerid][playerDOGE];
        case CRYPTO_TETHER:   current = g_PlayerCrypto[playerid][playerUSDT];
    }
    
    new Float:fee = amount * CRYPTO_EXCHANGE_FEE;
    if(current < (amount + fee)) return false;
    
    // Izra?unaj vrednost u drugoj kriptovaluti
    new Float:from_value = amount * GetCryptoPrice(from_type);
    new Float:to_amount = from_value / GetCryptoPrice(to_type);
    
    // Oduzmi originalnu valutu (amount + fee)
    switch(from_type)
    {
        case CRYPTO_BITCOIN:  g_PlayerCrypto[playerid][playerBTC] -= (amount + fee);
        case CRYPTO_ETHEREUM: g_PlayerCrypto[playerid][playerETH] -= (amount + fee);
        case CRYPTO_LITECOIN: g_PlayerCrypto[playerid][playerLTC] -= (amount + fee);
        case CRYPTO_DOGECOIN: g_PlayerCrypto[playerid][playerDOGE] -= (amount + fee);
        case CRYPTO_TETHER:   g_PlayerCrypto[playerid][playerUSDT] -= (amount + fee);
    }
    
    // Dodaj novu valutu
    switch(to_type)
    {
        case CRYPTO_BITCOIN:  g_PlayerCrypto[playerid][playerBTC] += to_amount;
        case CRYPTO_ETHEREUM: g_PlayerCrypto[playerid][playerETH] += to_amount;
        case CRYPTO_LITECOIN: g_PlayerCrypto[playerid][playerLTC] += to_amount;
        case CRYPTO_DOGECOIN: g_PlayerCrypto[playerid][playerDOGE] += to_amount;
        case CRYPTO_TETHER:   g_PlayerCrypto[playerid][playerUSDT] += to_amount;
    }
    
    SavePlayerCrypto(playerid);
    
    new string[128];
    format(string, sizeof(string), "CRYPTO: Zamenio si %.8f %s za %.8f %s (Fee: %.8f %s)", 
        amount, g_CryptoInfo[from_type][crypto_Name],
        to_amount, g_CryptoInfo[to_type][crypto_Name],
        fee, g_CryptoInfo[from_type][crypto_Name]);
    SendClientMessage(playerid, x_ltorange, string);
    
    return true;
}

// Funkcija za pretvaranje kripta u novac
stock bool:CryptoToCash(playerid, cryptotype, Float:amount)
{
    if(amount <= 0.0) return false;
    
    new Float:current = 0.0;
    switch(cryptotype)
    {
        case CRYPTO_BITCOIN:  current = g_PlayerCrypto[playerid][playerBTC];
        case CRYPTO_ETHEREUM: current = g_PlayerCrypto[playerid][playerETH];
        case CRYPTO_LITECOIN: current = g_PlayerCrypto[playerid][playerLTC];
        case CRYPTO_DOGECOIN: current = g_PlayerCrypto[playerid][playerDOGE];
        case CRYPTO_TETHER:   current = g_PlayerCrypto[playerid][playerUSDT];
    }
    
    if(current < amount) return false;
    
    new Float:value = amount * GetCryptoPrice(cryptotype);
    new Float:fee = value * CRYPTO_CASH_FEE;
    new Float:final_value = value - fee;
    
    // Oduzmi crypto
    switch(cryptotype)
    {
        case CRYPTO_BITCOIN:  g_PlayerCrypto[playerid][playerBTC] -= amount;
        case CRYPTO_ETHEREUM: g_PlayerCrypto[playerid][playerETH] -= amount;
        case CRYPTO_LITECOIN: g_PlayerCrypto[playerid][playerLTC] -= amount;
        case CRYPTO_DOGECOIN: g_PlayerCrypto[playerid][playerDOGE] -= amount;
        case CRYPTO_TETHER:   g_PlayerCrypto[playerid][playerUSDT] -= amount;
    }
    
    GivePlayerMoney(playerid, floatround(final_value, floatround_floor));
    SavePlayerCrypto(playerid);
    
    new string[128];
    format(string, sizeof(string), "CRYPTO: Prodao si %.8f %s za $%d (Fee: $%d)", 
        amount, g_CryptoInfo[cryptotype][crypto_Name], 
        floatround(final_value), floatround(fee));
    SendClientMessage(playerid, x_ltorange, string);
    
    return true;
}

stock GivePlayerCrypto(playerid, cryptotype, Float:amount)
{
    if(amount <= 0.0) return 0;
    
    switch(cryptotype)
    {
        case CRYPTO_BITCOIN:  g_PlayerCrypto[playerid][playerBTC] += amount;
        case CRYPTO_ETHEREUM: g_PlayerCrypto[playerid][playerETH] += amount;
        case CRYPTO_LITECOIN: g_PlayerCrypto[playerid][playerLTC] += amount;
        case CRYPTO_DOGECOIN: g_PlayerCrypto[playerid][playerDOGE] += amount;
        case CRYPTO_TETHER:   g_PlayerCrypto[playerid][playerUSDT] += amount;
    }
    
    SavePlayerCrypto(playerid);
    
    new string[128];
    format(string, sizeof(string), "CRYPTO: Dobio si %.8f %s kao nagradu!", 
        amount, g_CryptoInfo[cryptotype][crypto_Name]);
    SendClientMessage(playerid, x_ltorange, string);
    
    return 1;
}

YCMD:givecrypto(playerid, params[], help)
{
    if(!IsPlayerAdmin(playerid)) return 0;
    
    new targetid, type, Float:amount;
    if(sscanf(params, "udf", targetid, type, amount))
    {
        SendClientMessage(playerid, -1, "USAGE: /givecrypto [playerid] [type 0-4] [amount]");
        SendClientMessage(playerid, -1, "Types: 0-BTC, 1-ETH, 2-LTC, 3-DOGE, 4-USDT");
        return 1;
    }
    
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, -1, "Igrac nije konektovan!");
    if(type < 0 || type > 4) return SendClientMessage(playerid, -1, "Nevalidan tip kripta!");
    
    GivePlayerCrypto(targetid, type, amount);
    
    printf("[ADMIN] %s je dao %.8f %s igracu %s", 
        ReturnPlayerName(playerid), 
        amount, 
        g_CryptoInfo[type][crypto_Name], 
        ReturnPlayerName(targetid)
    );
    return 1;
}

YCMD:exchangecrypto(playerid, params[], help)
{
    new from_type, to_type, Float:amount;
    if(sscanf(params, "ddf", from_type, to_type, amount))
    {
        SendClientMessage(playerid, -1, "USAGE: /exchangecrypto [from_type 0-4] [to_type 0-4] [amount]");
        SendClientMessage(playerid, -1, "Types: 0-BTC, 1-ETH, 2-LTC, 3-DOGE, 4-USDT");
        return 1;
    }
    
    if(from_type < 0 || from_type > 4 || to_type < 0 || to_type > 4)
        return SendClientMessage(playerid, x_ltorange, "CRYPTO: Nevalidan tip kripta!");
    
    if(ExchangeCrypto(playerid, from_type, to_type, amount))
    {
        printf("[CRYPTO] %s je zamenio %.8f %s za %s", 
            ReturnPlayerName(playerid), 
            amount,
            g_CryptoInfo[from_type][crypto_Name],
            g_CryptoInfo[to_type][crypto_Name]
        );
    }
    else
    {
        SendClientMessage(playerid, x_ltorange, "CRYPTO: Greska pri zameni kripta! Proverite da li imate dovoljno.");
    }
    return 1;
}

YCMD:cryptotocash(playerid, params[], help)
{
    new type, Float:amount;
    if(sscanf(params, "df", type, amount))
    {
        SendClientMessage(playerid, -1, "USAGE: /cryptotocash [type 0-4] [amount]");
        SendClientMessage(playerid, -1, "Types: 0-BTC, 1-ETH, 2-LTC, 3-DOGE, 4-USDT");
        return 1;
    }
    
    if(type < 0 || type > 4)
        return SendClientMessage(playerid, x_ltorange, "CRYPTO: Nevalidan tip kripta!");
    
    if(CryptoToCash(playerid, type, amount))
    {
        printf("[CRYPTO] %s je konvertovao %.8f %s u novac", 
            ReturnPlayerName(playerid), 
            amount,
            g_CryptoInfo[type][crypto_Name]
        );
    }
    else
    {
        SendClientMessage(playerid, x_ltorange, "CRYPTO: Greska pri konverziji! Proverite da li imate dovoljno.");
    }
    return 1;
}

YCMD:sendcrypto(playerid, params[], help)
{
    new targetid, type, Float:amount;
    if(sscanf(params, "udf", targetid, type, amount))
    {
        SendClientMessage(playerid, -1, "USAGE: /sendcrypto [playerid] [type 0-4] [amount]");
        SendClientMessage(playerid, -1, "Types: 0-BTC, 1-ETH, 2-LTC, 3-DOGE, 4-USDT");
        return 1;
    }
    
    if(!IsPlayerConnected(targetid)) 
        return SendClientMessage(playerid, -1, "Igrac nije konektovan!");
    
    if(type < 0 || type > 4)
        return SendClientMessage(playerid, x_ltorange, "CRYPTO: Nevalidan tip kripta!");
    
    if(TransferCrypto(playerid, targetid, type, amount))
    {
        printf("[CRYPTO] %s je poslao %.8f %s igracu %s", 
            ReturnPlayerName(playerid), 
            amount,
            g_CryptoInfo[type][crypto_Name],
            ReturnPlayerName(targetid)
        );
    }
    else
    {
        SendClientMessage(playerid, x_ltorange, "CRYPTO: Greska pri slanju! Proverite da li imate dovoljno.");
    }
    return 1;
}

// Komanda za proveru stanja
YCMD:mycrypto(playerid, params[], help)
{
    new string[512];
    format(string, sizeof(string), "Tvoj Crypto Novcanik:\n\n");
    
    format(string, sizeof(string), ""c_ltorange"%s%s: %.8f (Vrednost: $%.2f)\n", 
        string, 
        g_CryptoInfo[0][crypto_Name], 
        g_PlayerCrypto[playerid][playerBTC],
        g_PlayerCrypto[playerid][playerBTC] * GetCryptoPrice(0)
    );
    
    format(string, sizeof(string), ""c_ltorange"%s%s: %.8f (Vrednost: $%.2f)\n", 
        string, 
        g_CryptoInfo[1][crypto_Name], 
        g_PlayerCrypto[playerid][playerETH],
        g_PlayerCrypto[playerid][playerETH] * GetCryptoPrice(1)
    );
    
    format(string, sizeof(string), ""c_ltorange"%s%s: %.8f (Vrednost: $%.2f)\n", 
        string, 
        g_CryptoInfo[2][crypto_Name], 
        g_PlayerCrypto[playerid][playerLTC],
        g_PlayerCrypto[playerid][playerLTC] * GetCryptoPrice(2)
    );
    
    format(string, sizeof(string), ""c_ltorange"%s%s: %.8f (Vrednost: $%.2f)\n", 
        string, 
        g_CryptoInfo[3][crypto_Name], 
        g_PlayerCrypto[playerid][playerDOGE],
        g_PlayerCrypto[playerid][playerDOGE] * GetCryptoPrice(3)
    );
    
    format(string, sizeof(string), ""c_ltorange"%s%s: %.8f (Vrednost: $%.2f)", 
        string, 
        g_CryptoInfo[4][crypto_Name], 
        g_PlayerCrypto[playerid][playerUSDT],
        g_PlayerCrypto[playerid][playerUSDT] * GetCryptoPrice(4)
    );
    
    Dialog_Show(playerid, "_noreturn-cryptovoki", DIALOG_STYLE_MSGBOX, "Crypto Novcanik", string, "Zatvori", "");
    return 1;
}