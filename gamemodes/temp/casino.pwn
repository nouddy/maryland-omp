/***
 *  Casino System Documentation
 *  ==========================
 *
 *  Features:
 *  ---------
 *  1. Basic Casino Management:
 *     - Entrance fee system
 *     - Chip conversion system
 *     - VIP levels with benefits
 *     - Daily betting limits
 *     - Anti-spam protection
 *     - 30% controlled win rate
 *
 *  2. Games Implemented:
 *     a) Coin Flip (Heads/Tails)
 *        - Simple 50/50 game
 *        - Commands: /coinflip [bet] [heads/tails]
 *        - Payout: 2x bet
 *
 *     b) Hi-Lo
 *        - Guess if next number is higher/lower
 *        - Commands: /hilo [bet], /higher, /lower, /collect
 *        - Progressive multiplier system
 *        - Increasing risk/reward
 *
 *     c) Rock Paper Scissors
 *        - Classic RPS game
 *        - Command: /rps [bet] [rock/paper/scissors]
 *        - Payout: 2x bet
 *
 *     d) Lucky 7
 *        - Three number combination game
 *        - Command: /lucky7 [bet]
 *        - Multiple winning combinations:
 *          * Triple 7s: 7x bet
 *          * Sum of 7: 3x bet
 *          * Three of a kind: 5x bet
 *
 *     e) Bingo
 *        - Full bingo card system
 *        - Command: /buybingo
 *        - Progressive pot system
 *        - Line and full card wins
 *
 *     f) Crash Game
 *        - Multiplier-based betting game
 *        - Commands: /crashbet [amount], /cashout
 *        - Progressive multiplier
 *        - Risk/reward gameplay
 *
 *  3. Security Features:
 *     - Anti-cheat detection
 *     - Bet limiting system
 *     - Suspicious activity logging
 *     - Daily chip limits
 *     - Transaction logging
 *     - State verification
 *
 *  4. Administrative Tools:
 *     - Casino statistics tracking
 *     - Player monitoring
 *     - Jackpot management
 *     - VIP level control
 *
 *  5. Database Integration:
 *     Tables:
 *     - casino_players: Player data and chips
 *     - casino_logs: Transaction history
 *     - casino_suspicious_activity: Security logs
 *
 *  6. Economy Features:
 *     - House commission (10%)
 *     - Jackpot contribution system
 *     - VIP multipliers
 *     - Betting limits
 *
 *  Commands:
 *  ---------
 *  Player Commands:
 *  - /buychips [amount]    - Convert money to chips
 *  - /sellchips [amount]   - Convert chips to money
 *  - /casinostats          - View personal statistics
 *  - /jackpot             - View current jackpot
 *
 *  Game Commands:
 *  - /coinflip [bet] [heads/tails]
 *  - /hilo [bet]
 *  - /higher
 *  - /lower
 *  - /collect
 *  - /rps [bet] [choice]
 *  - /lucky7 [bet]
 *  - /buybingo
 *  - /crashbet [amount]
 *  - /cashout
 *
 *  Admin Commands:
 *  - /setjackpot [amount]
 *  - /resetchipdaily [playerid]
 *  - /casinoadmin
 *
 *  Constants:
 *  ----------
 *  - MIN_BET: 100
 *  - MAX_BET: 50000
 *  - CASINO_COMMISSION: 10%
 *  - MAX_DAILY_CHIPS: 1000000
 *  - ANTI_SPAM_DELAY: 3 seconds
 *
 *  @Author         Vostic
 *  @Version        1.0
 *  @Date           Current Date
 */

#include <ysilib\YSI_Coding\y_hooks>

// Constants for casino
#define CASINO_ENTRANCE_COST 1000
#define MIN_BET 100
#define MAX_BET 50000
#define CASINO_COMMISSION 10 // 10% commission

// Additional constants
#define JACKPOT_MIN_BET 1000
#define MAX_DAILY_CHIPS 1000000
#define ANTI_SPAM_DELAY 3 // seconds
#define BLACKJACK_MAX_CARDS 10
#define POKER_MAX_PLAYERS 6
#define POKER_MIN_PLAYERS 2

// Enums and variables
enum E_PLAYER_CASINO {
    pChips,
    pLastBet,
    pLastGame,
    bool:pInCasino,
    pDailyChips,
    pLastBetTime,
    pLastGameTime,
    bool:pInGame,
    pVIPLevel
}
new PlayerCasino[MAX_PLAYERS][E_PLAYER_CASINO];

// Game types
enum E_CASINO_GAMES {
    GAME_NONE,
    GAME_ROULETTE,
    GAME_SLOTS,
    GAME_BLACKJACK,
    GAME_POKER,
    GAME_DICE
}

// Global variables
new g_JackpotAmount = 0;
new g_CasinoArea;

// Card-related enums
enum E_CARD {
    CARD_VALUE,
    CARD_SUIT
}

// Poker table structure
enum E_POKER_TABLE {
    bool:tableActive,
    tablePlayers[POKER_MAX_PLAYERS],
    tableCurrentBet,
    tablePot,
    tableDealer,
    tableCurrentPlayer,
    tableRound
}
new PokerTables[MAX_POKER_TABLES][E_POKER_TABLE];

// Win rate control (30% chance)
stock bool:ShouldPlayerWin()
{
    return (random(100) < 30); // 30% win chance
}

// Enhanced security checks
stock bool:IsValidBet(playerid, bet)
{
    if(!IsValidPlayer(playerid))
        return false;
        
    if(bet < MIN_BET || bet > MAX_BET)
        return false;
        
    if(bet > PlayerCasino[playerid][pChips])
        return false;
        
    if(bet > GetPlayerMaxChips(playerid))
        return false;
        
    return true;
}

// Modified PlayCoinFlip with 30% win rate
stock PlayCoinFlip(playerid, bet, bool:heads)
{
    if(!IsValidBet(playerid, bet))
        return 0;
        
    PlayerCasino[playerid][pInGame] = true;
    PlayerCasino[playerid][pChips] -= bet;
    PlayerCasino[playerid][pLastBetTime] = gettime();
    
    new bool:win = ShouldPlayerWin();
    new bool:result = (win == heads); // Force result based on win chance
    new winnings = (result) ? bet * 2 : 0;
    
    // Apply commission on wins
    if(winnings > 0)
    {
        new commission = floatround(winnings * (CASINO_COMMISSION / 100.0));
        winnings -= commission;
        g_JackpotAmount += commission;
    }
    
    PlayerCasino[playerid][pChips] += winnings;
    LogCasinoGame(playerid, "COINFLIP", bet, winnings);
    
    new str[128];
    format(str, sizeof(str), "* Coin landed on %s! You %s $%d!",
        result ? ("heads") : ("tails"),
        (winnings > 0) ? ("won") : ("lost"),
        (winnings > 0) ? (winnings - bet) : bet);
    SendClientMessage(playerid, x_green, str);
    
    PlayerCasino[playerid][pInGame] = false;
    return 1;
}

// Hi-Lo Game
enum E_HILO_GAME {
    bool:hiloActive,
    hiloCurrentNumber,
    hiloBet,
    hiloStreak,
    Float:hiloMultiplier
}
new HiLoGame[MAX_PLAYERS][E_HILO_GAME];

YCMD:hilo(playerid, params[], help)
{
    new bet;
    if(sscanf(params, "i", bet))
        return SendClientMessage(playerid, x_red, "USAGE: /hilo [bet]");
        
    if(!IsPlayerEligibleToBet(playerid, bet))
        return SendClientMessage(playerid, x_red, "* You can't play Hi-Lo right now!");
        
    StartHiLoGame(playerid, bet);
    return 1;
}

YCMD:higher(playerid, params[])
{
    if(!HiLoGame[playerid][hiloActive])
        return SendClientMessage(playerid, x_red, "* You're not in a Hi-Lo game!");
        
    PlayHiLo(playerid, true);
    return 1;
}

YCMD:lower(playerid, params[])
{
    if(!HiLoGame[playerid][hiloActive])
        return SendClientMessage(playerid, x_red, "* You're not in a Hi-Lo game!");
        
    PlayHiLo(playerid, false);
    return 1;
}

stock StartHiLoGame(playerid, bet)
{
    PlayerCasino[playerid][pInGame] = true;
    PlayerCasino[playerid][pChips] -= bet;
    
    HiLoGame[playerid][hiloActive] = true;
    HiLoGame[playerid][hiloBet] = bet;
    HiLoGame[playerid][hiloStreak] = 0;
    HiLoGame[playerid][hiloMultiplier] = 1.0;
    HiLoGame[playerid][hiloCurrentNumber] = random(100) + 1;
    
    new str[128];
    format(str, sizeof(str), "* Current number: %d\nUse /higher or /lower to guess the next number!",
        HiLoGame[playerid][hiloCurrentNumber]);
    SendClientMessage(playerid, x_green, str);
    
    return 1;
}

stock PlayHiLo(playerid, bool:higher)
{
    new oldNumber = HiLoGame[playerid][hiloCurrentNumber];
    new newNumber;
    new bool:win = ShouldPlayerWin();
    
    if(higher)
    {
        newNumber = win ? (oldNumber + random(20) + 1) : (oldNumber - random(20));
        if(newNumber > 100) newNumber = 100;
        if(newNumber < 1) newNumber = 1;
    }
    else
    {
        newNumber = win ? (oldNumber - random(20) - 1) : (oldNumber + random(20));
        if(newNumber > 100) newNumber = 100;
        if(newNumber < 1) newNumber = 1;
    }
    
    if(newNumber == oldNumber)
    {
        HiLoGame[playerid][hiloStreak]++;
        HiLoGame[playerid][hiloMultiplier] += 0.5;
        HiLoGame[playerid][hiloCurrentNumber] = newNumber;
        
        new str[128];
        format(str, sizeof(str), "* New number: %d! Correct! Streak: %d, Multiplier: %.1fx\nContinue or /collect your winnings!",
            newNumber, HiLoGame[playerid][hiloStreak], HiLoGame[playerid][hiloMultiplier]);
        SendClientMessage(playerid, x_green, str);
    }
    else
    {
        new str[128];
        format(str, sizeof(str), "* New number: %d! Wrong! You lost your bet of $%d!",
            newNumber, HiLoGame[playerid][hiloBet]);
        SendClientMessage(playerid, x_red, str);
        
        EndHiLoGame(playerid, false);
    }
    return 1;
}

YCMD:collect(playerid, params[])
{
    if(!HiLoGame[playerid][hiloActive])
        return SendClientMessage(playerid, x_red, "* You're not in a Hi-Lo game!");
        
    EndHiLoGame(playerid, true);
    return 1;
}

stock EndHiLoGame(playerid, bool:collected)
{
    if(collected)
    {
        new winnings = floatround(HiLoGame[playerid][hiloBet] * HiLoGame[playerid][hiloMultiplier]);
        
        // Apply commission
        new commission = floatround(winnings * (CASINO_COMMISSION / 100.0));
        winnings -= commission;
        g_JackpotAmount += commission;
        
        PlayerCasino[playerid][pChips] += winnings;
        LogCasinoGame(playerid, "HILO", HiLoGame[playerid][hiloBet], winnings);
        
        new str[128];
        format(str, sizeof(str), "* You've collected your winnings: $%d!", winnings);
        SendClientMessage(playerid, x_green, str);
    }
    
    HiLoGame[playerid][hiloActive] = false;
    PlayerCasino[playerid][pInGame] = false;
    return 1;
}

hook OnGameModeInit()
{
    print("Casino system loaded");
    
    // Create casino entrance checkpoint
    CreateDynamicCP(1234.5, 1234.5, 10.0, 2.0, -1, -1, -1, 100.0);
    
    // Create necessary tables using existing SQL handler
    mysql_tquery(SQL, "CREATE TABLE IF NOT EXISTS casino_logs (\
        id INT AUTO_INCREMENT PRIMARY KEY,\
        player_id INT,\
        game_type VARCHAR(32),\
        bet_amount INT,\
        win_amount INT,\
        timestamp DATETIME DEFAULT CURRENT_TIMESTAMP)");

    // Create casino area
    g_CasinoArea = CreateDynamicSphere(1234.5, 1234.5, 10.0, 50.0);

    // Additional tables
    mysql_tquery(SQL, "CREATE TABLE IF NOT EXISTS casino_players (\
        player_id INT PRIMARY KEY,\
        total_bets INT,\
        total_wins INT,\
        last_daily_reset DATETIME,\
        chips INT DEFAULT 0)");

    return 1;
}

hook OnPlayerConnect(playerid)
{
    // Reset all game states
    PlayerCasino[playerid][pInGame] = false;
    PlayerCasino[playerid][pChips] = 0;
    PlayerCasino[playerid][pLastBetTime] = 0;
    PlayerCasino[playerid][pDailyChips] = 0;
    HiLoGame[playerid][hiloActive] = false;
    CrashGame[playerid][crashActive] = false;
    BingoCards[playerid][cardActive] = false;
    
    return 1;
}

// Security checks
stock bool:IsValidPlayer(playerid)
{
    if(playerid < 0 || playerid >= MAX_PLAYERS) return false;
    if(!IsPlayerConnected(playerid)) return false;
    return true;
}

stock bool:IsPlayerInCasino(playerid)
{
    if(!IsValidPlayer(playerid)) return false;
    if(!IsPlayerInDynamicArea(playerid, g_CasinoArea)) return false;
    if(!PlayerCasino[playerid][pInCasino]) return false;
    return true;
}

// Enhanced security for IsPlayerEligibleToBet
stock bool:IsPlayerEligibleToBet(playerid, bet_amount)
{
    if(!IsValidPlayer(playerid))
        return false;

    if(!IsPlayerInCasino(playerid))
        return false;

    if(PlayerCasino[playerid][pInGame])
        return false;

    if(bet_amount < MIN_BET || bet_amount > MAX_BET)
        return false;

    if(PlayerCasino[playerid][pChips] < bet_amount)
        return false;

    if(gettime() - PlayerCasino[playerid][pLastBetTime] < ANTI_SPAM_DELAY)
        return false;

    if(PlayerCasino[playerid][pDailyChips] + bet_amount > MAX_DAILY_CHIPS)
        return false;

    return true;
}

// Enhanced buy chips command
YCMD:buychips(playerid, params[], help)
{
    if(!PlayerCasino[playerid][pInCasino]) 
        return SendClientMessage(playerid, x_red, "* You must be in the casino to buy chips!");
        
    new amount;
    if(sscanf(params, "i", amount)) 
        return SendClientMessage(playerid, x_red, "USAGE: /buychips [amount]");
        
    if(amount < MIN_BET || amount > MAX_BET)
        return SendClientMessage(playerid, x_red, "* Invalid amount! Min: %d, Max: %d", MIN_BET, MAX_BET);
        
    if(GetPlayerMoney(playerid) < amount)
        return SendClientMessage(playerid, x_red, "* You don't have enough money!");

    // Process transaction
    GivePlayerMoney(playerid, -amount);
    PlayerCasino[playerid][pChips] += amount;

    // Log transaction
    new query[256];
    mysql_format(SQL, query, sizeof(query), 
        "INSERT INTO casino_logs (player_id, game_type, bet_amount, win_amount) VALUES (%d, 'CHIPS_PURCHASE', %d, 0)",
        GetPlayerAccountID(playerid), amount);
    mysql_tquery(SQL, query);

    SendClientMessage(playerid, x_green, "* You've purchased %d chips!", amount);
    return 1;
}

// Roulette system
YCMD:roulette(playerid, params[], help)
{
    if(!IsPlayerEligibleToBet(playerid, 0))
        return SendClientMessage(playerid, x_red, "* You can't play roulette right now!");

    Dialog_Show(playerid, DIALOG_ROULETTE, DIALOG_STYLE_LIST, "Roulette",
        "Place bet on number (x35)\n\
        Place bet on color (x2)\n\
        Place bet on even/odd (x2)",
        "Select", "Cancel");
    return 1;
}

// Slot machines
YCMD:slots(playerid, params[], help)
{
    new bet;
    if(sscanf(params, "i", bet))
        return SendClientMessage(playerid, x_red, "USAGE: /slots [bet]");

    if(!IsPlayerEligibleToBet(playerid, bet))
        return SendClientMessage(playerid, x_red, "* You can't play slots right now!");

    PlaySlotMachine(playerid, bet);
    return 1;
}

// Function to process slot machine game
stock PlaySlotMachine(playerid, bet)
{
    PlayerCasino[playerid][pInGame] = true;
    PlayerCasino[playerid][pLastBetTime] = gettime();
    PlayerCasino[playerid][pDailyChips] += bet;
    PlayerCasino[playerid][pChips] -= bet;

    // Generate random symbols
    new symbols[3];
    for(new i = 0; i < 3; i++)
        symbols[i] = random(6); // 0-5 different symbols

    // Calculate winnings
    new winnings = 0;
    if(symbols[0] == symbols[1] && symbols[1] == symbols[2]) // All match
        winnings = bet * 10;
    else if(symbols[0] == symbols[1] || symbols[1] == symbols[2] || symbols[0] == symbols[2]) // Two match
        winnings = bet * 2;

    // Apply casino commission
    if(winnings > 0)
    {
        new commission = floatround(winnings * (CASINO_COMMISSION / 100.0));
        winnings -= commission;
        g_JackpotAmount += commission;
    }

    // Update player chips
    PlayerCasino[playerid][pChips] += winnings;

    // Log game
    LogCasinoGame(playerid, "SLOTS", bet, winnings);

    // Show results
    ShowSlotResults(playerid, symbols, winnings);
    PlayerCasino[playerid][pInGame] = false;
}

// Function to log casino games
stock LogCasinoGame(playerid, const game_type[], bet, winnings)
{
    new query[256];
    mysql_format(SQL, query, sizeof(query),
        "INSERT INTO casino_logs (player_id, game_type, bet_amount, win_amount) VALUES (%d, '%e', %d, %d)",
        GetPlayerAccountID(playerid), game_type, bet, winnings);
    mysql_tquery(SQL, query);
}

// Blackjack command
YCMD:blackjack(playerid, params[], help)
{
    if(!IsPlayerEligibleToBet(playerid, 0))
        return SendClientMessage(playerid, x_red, "* You can't play blackjack right now!");

    Dialog_Show(playerid, DIALOG_BLACKJACK_BET, DIALOG_STYLE_INPUT, "Blackjack - Place Bet",
        "Enter your bet amount:\nMinimum: %d\nMaximum: %d",
        "Bet", "Cancel", MIN_BET, MAX_BET);
    return 1;
}

// Blackjack game processing
stock StartBlackjackGame(playerid, bet)
{
    if(!IsPlayerEligibleToBet(playerid, bet))
        return 0;

    PlayerCasino[playerid][pInGame] = true;
    PlayerCasino[playerid][pChips] -= bet;
    PlayerCasino[playerid][pLastBetTime] = gettime();

    // Deal initial cards
    new playerCards[BLACKJACK_MAX_CARDS];
    new dealerCards[BLACKJACK_MAX_CARDS];
    
    playerCards[0] = random(52);
    playerCards[1] = random(52);
    dealerCards[0] = random(52);
    dealerCards[1] = random(52);

    // Show cards and options
    ShowBlackjackHand(playerid, playerCards, dealerCards, true);
    return 1;
}

// Poker command
YCMD:poker(playerid, params[], help)
{
    if(!IsPlayerEligibleToBet(playerid, 0))
        return SendClientMessage(playerid, x_red, "* You can't play poker right now!");

    Dialog_Show(playerid, DIALOG_POKER_MENU, DIALOG_STYLE_LIST, "Poker Menu",
        "Join Table\nCreate Table\nLeave Table",
        "Select", "Cancel");
    return 1;
}

// Poker table management
stock CreatePokerTable(playerid, buy_in)
{
    new tableID = GetFreePokerTable();
    if(tableID == -1)
        return 0;

    PokerTables[tableID][tableActive] = true;
    PokerTables[tableID][tableDealer] = playerid;
    PokerTables[tableID][tablePlayers][0] = playerid;
    PokerTables[tableID][tableCurrentBet] = buy_in;

    return tableID;
}

// Dice command
YCMD:dice(playerid, params[], help)
{
    new bet, prediction;
    if(sscanf(params, "ii", bet, prediction))
        return SendClientMessage(playerid, x_red, "USAGE: /dice [bet] [prediction (2-12)]");

    if(!IsPlayerEligibleToBet(playerid, bet))
        return SendClientMessage(playerid, x_red, "* You can't play dice right now!");

    if(prediction < 2 || prediction > 12)
        return SendClientMessage(playerid, x_red, "* Prediction must be between 2 and 12!");

    PlayDiceGame(playerid, bet, prediction);
    return 1;
}

// Dice game processing
stock PlayDiceGame(playerid, bet, prediction)
{
    PlayerCasino[playerid][pInGame] = true;
    PlayerCasino[playerid][pChips] -= bet;
    PlayerCasino[playerid][pLastBetTime] = gettime();

    new dice1 = random(6) + 1;
    new dice2 = random(6) + 1;
    new total = dice1 + dice2;

    new winnings = 0;
    if(total == prediction)
        winnings = bet * 10;
    else if((prediction <= 7 && total <= 7) || (prediction > 7 && total > 7))
        winnings = bet * 2;

    // Apply commission
    if(winnings > 0)
    {
        new commission = floatround(winnings * (CASINO_COMMISSION / 100.0));
        winnings -= commission;
        g_JackpotAmount += commission;
    }

    PlayerCasino[playerid][pChips] += winnings;
    LogCasinoGame(playerid, "DICE", bet, winnings);

    // Show results
    ShowDiceResults(playerid, dice1, dice2, prediction, winnings);
    PlayerCasino[playerid][pInGame] = false;
}

// Jackpot command
YCMD:jackpot(playerid, params[], help)
{
    if(!IsPlayerEligibleToBet(playerid, JACKPOT_MIN_BET))
        return SendClientMessage(playerid, x_red, "* You can't play jackpot right now!");

    Dialog_Show(playerid, DIALOG_JACKPOT, DIALOG_STYLE_MSGBOX, "Jackpot",
        "Current Jackpot: $%d\nMinimum bet: $%d\n\nWould you like to try your luck?",
        "Yes", "No", g_JackpotAmount, JACKPOT_MIN_BET);
    return 1;
}

// Admin commands
YCMD:casinoadmin(playerid, params[], help)
{
    if(!IsPlayerAdmin(playerid))
        return SendClientMessage(playerid, x_red, "* You don't have permission to use this command!");

    Dialog_Show(playerid, DIALOG_CASINO_ADMIN, DIALOG_STYLE_LIST, "Casino Admin",
        "View Statistics\nReset Jackpot\nBan Player\nView Logs",
        "Select", "Cancel");
    return 1;
}

// Dialog processors
Dialog:DIALOG_ROULETTE(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    switch(listitem)
    {
        case 0: // Number bet
            Dialog_Show(playerid, DIALOG_ROULETTE_NUMBER, DIALOG_STYLE_INPUT, "Roulette - Number",
                "Enter a number (0-36):", "Bet", "Back");
        case 1: // Color bet
            Dialog_Show(playerid, DIALOG_ROULETTE_COLOR, DIALOG_STYLE_LIST, "Roulette - Color",
                "Red\nBlack", "Bet", "Back");
        case 2: // Even/Odd bet
            Dialog_Show(playerid, DIALOG_ROULETTE_EVENODD, DIALOG_STYLE_LIST, "Roulette - Even/Odd",
                "Even\nOdd", "Bet", "Back");
    }
    return 1;
}

// Helper functions
stock ShowBlackjackHand(playerid, playerCards[], dealerCards[], bool:initial = false)
{
    if(!IsValidPlayer(playerid))
        return 0;

    new str[256], playerTotal = 0, dealerTotal = 0;
    
    // Calculate player's total
    for(new i = 0; i < BLACKJACK_MAX_CARDS && playerCards[i] != 0; i++)
    {
        playerTotal += GetCardValue(playerCards[i]);
    }

    // Calculate dealer's visible total
    if(initial)
    {
        dealerTotal = GetCardValue(dealerCards[0]); // Show only first card
        format(str, sizeof(str), "Your cards: %s (Total: %d)\nDealer shows: %s",
            GetCardString(playerCards[0]), playerTotal, GetCardString(dealerCards[0]));
    }
    else
    {
        for(new i = 0; i < BLACKJACK_MAX_CARDS && dealerCards[i] != 0; i++)
        {
            dealerTotal += GetCardValue(dealerCards[i]);
        }
        format(str, sizeof(str), "Your cards: %s (Total: %d)\nDealer's cards: %s (Total: %d)",
            GetCardsString(playerCards), playerTotal, GetCardsString(dealerCards), dealerTotal);
    }

    Dialog_Show(playerid, DIALOG_BLACKJACK_GAME, DIALOG_STYLE_LIST, "Blackjack",
        str, "Hit", "Stand");
    return 1;
}

stock ShowDiceResults(playerid, dice1, dice2, prediction, winnings)
{
    if(!IsValidPlayer(playerid))
        return 0;

    new str[128];
    format(str, sizeof(str), "Dice Roll: %d + %d = %d\nYour prediction: %d\nWinnings: $%d",
        dice1, dice2, dice1 + dice2, prediction, winnings);
    
    Dialog_Show(playerid, DIALOG_DICE_RESULTS, DIALOG_STYLE_MSGBOX, "Dice Results",
        str, "OK", "");
    return 1;
}

stock ShowSlotResults(playerid, symbols[], winnings)
{
    if(!IsValidPlayer(playerid))
        return 0;

    new str[128];
    format(str, sizeof(str), "Slots: %s %s %s\nWinnings: $%d",
        GetSlotSymbol(symbols[0]),
        GetSlotSymbol(symbols[1]),
        GetSlotSymbol(symbols[2]),
        winnings);
    
    Dialog_Show(playerid, DIALOG_SLOTS_RESULTS, DIALOG_STYLE_MSGBOX, "Slot Results",
        str, "OK", "");
    return 1;
}

stock GetFreePokerTable()
{
    for(new i = 0; i < MAX_POKER_TABLES; i++)
    {
        if(!PokerTables[i][tableActive])
            return i;
    }
    return -1;
}

// Helper functions for card games
stock GetCardValue(cardid)
{
    new value = cardid % 13 + 1;
    return (value > 10) ? 10 : value;
}

stock GetCardString(cardid)
{
    // Using ASCII-safe characters for card suits
    new suits[] = {'H', 'D', 'C', 'S'}; // Hearts, Diamonds, Clubs, Spades
    new values[] = {'A', '2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K'};
    new suit = cardid / 13;
    new value = cardid % 13;
    
    new str[8];
    format(str, sizeof(str), "%c%c", values[value], suits[suit]); // Example: "AH" for Ace of Hearts
    return str;
}

stock GetCardsString(cards[])
{
    new str[64] = "";
    for(new i = 0; i < BLACKJACK_MAX_CARDS && cards[i] != 0; i++)
    {
        strcat(str, GetCardString(cards[i]));
        strcat(str, " ");
    }
    return str;
}

stock GetSlotSymbol(symbolid)
{
    // Using ASCII-safe characters for slot symbols
    new symbols[][] = {
        "Cherry",    // Instead of ??
        "Orange",    // Instead of ??
        "Lemon",     // Instead of ??
        "Grape",     // Instead of ??
        "Diamond",   // Instead of ??
        "Seven"      // Instead of 7??
    };
    return symbols[symbolid];
}

// Enhanced poker table management
stock JoinPokerTable(playerid, tableid)
{
    if(!IsValidPlayer(playerid))
        return 0;
        
    if(tableid < 0 || tableid >= MAX_POKER_TABLES)
        return 0;
        
    if(!PokerTables[tableid][tableActive])
        return 0;
        
    // Find empty seat
    new seatid = -1;
    for(new i = 0; i < POKER_MAX_PLAYERS; i++)
    {
        if(PokerTables[tableid][tablePlayers][i] == INVALID_PLAYER_ID)
        {
            seatid = i;
            break;
        }
    }
    
    if(seatid == -1)
        return 0;
        
    PokerTables[tableid][tablePlayers][seatid] = playerid;
    return 1;
}

stock LeavePokerTable(playerid, tableid)
{
    if(!IsValidPlayer(playerid))
        return 0;
        
    if(tableid < 0 || tableid >= MAX_POKER_TABLES)
        return 0;
        
    // Find player's seat
    for(new i = 0; i < POKER_MAX_PLAYERS; i++)
    {
        if(PokerTables[tableid][tablePlayers][i] == playerid)
        {
            PokerTables[tableid][tablePlayers][i] = INVALID_PLAYER_ID;
            
            // Check if table is empty
            new players = 0;
            for(new j = 0; j < POKER_MAX_PLAYERS; j++)
            {
                if(PokerTables[tableid][tablePlayers][j] != INVALID_PLAYER_ID)
                    players++;
            }
            
            if(players == 0)
                PokerTables[tableid][tableActive] = false;
                
            return 1;
        }
    }
    return 0;
}

// Enhanced transaction handling
stock GivePlayerCasinoChips(playerid, amount)
{
    if(!IsValidPlayer(playerid))
        return 0;
        
    PlayerCasino[playerid][pChips] += amount;
    
    new query[128];
    mysql_format(SQL, query, sizeof(query),
        "UPDATE casino_players SET chips = chips + %d WHERE player_id = %d",
        amount, GetPlayerAccountID(playerid));
    mysql_tquery(SQL, query);
    
    return 1;
}

stock TakePlayerCasinoChips(playerid, amount)
{
    if(!IsValidPlayer(playerid))
        return 0;
        
    if(PlayerCasino[playerid][pChips] < amount)
        return 0;
        
    PlayerCasino[playerid][pChips] -= amount;
    
    new query[128];
    mysql_format(SQL, query, sizeof(query),
        "UPDATE casino_players SET chips = chips - %d WHERE player_id = %d",
        amount, GetPlayerAccountID(playerid));
    mysql_tquery(SQL, query);
    
    return 1;
}

// Dialog processors for jackpot
Dialog:DIALOG_JACKPOT(playerid, response, listitem, inputtext[])
{
    if(!response) return 1;
    
    Dialog_Show(playerid, DIALOG_JACKPOT_BET, DIALOG_STYLE_INPUT, "Jackpot - Place Bet",
        "Current Jackpot: $%d\nMinimum bet: $%d\n\nEnter your bet amount:",
        "Bet", "Cancel", g_JackpotAmount, JACKPOT_MIN_BET);
    return 1;
}

Dialog:DIALOG_JACKPOT_BET(playerid, response, listitem, inputtext[])
{
    if(!response) return 1;
    
    new bet = strval(inputtext);
    if(bet < JACKPOT_MIN_BET)
        return SendClientMessage(playerid, x_red, "* Minimum jackpot bet is $%d!", JACKPOT_MIN_BET);
        
    if(!IsPlayerEligibleToBet(playerid, bet))
        return SendClientMessage(playerid, x_red, "* You can't place this bet!");
        
    PlayJackpot(playerid, bet);
    return 1;
}

// Jackpot game processing
stock PlayJackpot(playerid, bet)
{
    if(!IsValidPlayer(playerid))
        return 0;
        
    PlayerCasino[playerid][pInGame] = true;
    PlayerCasino[playerid][pLastBetTime] = gettime();
    PlayerCasino[playerid][pDailyChips] += bet;
    PlayerCasino[playerid][pChips] -= bet;
    
    // Add bet to jackpot
    g_JackpotAmount += bet;
    
    // 0.1% chance to win jackpot (adjustable)
    new bool:won = (random(1000) == 0);
    
    if(won)
    {
        // Winner gets 90% of jackpot
        new winnings = floatround(g_JackpotAmount * 0.9);
        PlayerCasino[playerid][pChips] += winnings;
        g_JackpotAmount = floatround(g_JackpotAmount * 0.1); // Leave 10% seed money
        
        // Log jackpot win
        LogCasinoGame(playerid, "JACKPOT_WIN", bet, winnings);
        
        // Announce winner
        new str[128];
        format(str, sizeof(str), "* %s has won the jackpot! Amount: $%d!", ReturnPlayerName(playerid), winnings);
        SendClientMessageToAll(x_yellow, str);
    }
    else
    {
        SendClientMessage(playerid, x_red, "* Better luck next time!");
    }
    
    PlayerCasino[playerid][pInGame] = false;
    return 1;
}

// Daily chip limit management
stock ResetDailyChipLimit(playerid)
{
    if(!IsValidPlayer(playerid))
        return 0;
        
    PlayerCasino[playerid][pDailyChips] = 0;
    
    new query[128];
    mysql_format(SQL, query, sizeof(query),
        "UPDATE casino_players SET last_daily_reset = NOW() WHERE player_id = %d",
        GetPlayerAccountID(playerid));
    mysql_tquery(SQL, query);
    
    return 1;
}

stock CheckDailyChipLimit(playerid)
{
    if(!IsValidPlayer(playerid))
        return 0;
        
    new query[256];
    mysql_format(SQL, query, sizeof(query),
        "SELECT TIMESTAMPDIFF(HOUR, last_daily_reset, NOW()) as hours FROM casino_players WHERE player_id = %d",
        GetPlayerAccountID(playerid));
        
    mysql_tquery(SQL, query, "OnCheckDailyLimit", "i", playerid);
    return 1;
}

forward OnCheckDailyLimit(playerid);
public OnCheckDailyLimit(playerid)
{
    new hours;
    cache_get_value_name_int(0, "hours", hours);
    
    if(hours >= 24)
    {
        ResetDailyChipLimit(playerid);
    }
    return 1;
}

// VIP benefits
stock GetPlayerVIPMultiplier(playerid)
{
    if(!IsValidPlayer(playerid))
        return 1.0;
        
    switch(PlayerCasino[playerid][pVIPLevel])
    {
        case 1: return 1.1; // 10% bonus
        case 2: return 1.2; // 20% bonus
        case 3: return 1.3; // 30% bonus
        default: return 1.0;
    }
}

// Enhanced chip management
stock GetPlayerMaxChips(playerid)
{
    if(!IsValidPlayer(playerid))
        return MAX_BET;
        
    new max_chips = MAX_BET;
    
    // VIP players get higher limits
    switch(PlayerCasino[playerid][pVIPLevel])
    {
        case 1: max_chips *= 2;  // Double limit
        case 2: max_chips *= 5;  // 5x limit
        case 3: max_chips *= 10; // 10x limit
    }
    
    return max_chips;
}

// Admin commands for casino management
YCMD:setjackpot(playerid, params[], help)
{
    if(!IsPlayerAdmin(playerid))
        return SendClientMessage(playerid, x_red, "* You don't have permission to use this command!");
        
    new amount;
    if(sscanf(params, "i", amount))
        return SendClientMessage(playerid, x_red, "USAGE: /setjackpot [amount]");
        
    g_JackpotAmount = amount;
    
    new str[128];
    format(str, sizeof(str), "* Admin %s has set the jackpot to $%d", ReturnPlayerName(playerid), amount);
    SendClientMessageToAll(x_yellow, str);
    
    return 1;
}

YCMD:resetchipdaily(playerid, params[], help)
{
    if(!IsPlayerAdmin(playerid))
        return SendClientMessage(playerid, x_red, "* You don't have permission to use this command!");
        
    new targetid;
    if(sscanf(params, "u", targetid))
        return SendClientMessage(playerid, x_red, "USAGE: /resetchipdaily [playerid]");
        
    if(!IsValidPlayer(targetid))
        return SendClientMessage(playerid, x_red, "* Invalid player ID!");
        
    ResetDailyChipLimit(targetid);
    SendClientMessage(playerid, x_green, "* You've reset the daily chip limit for that player.");
    
    return 1;
}

// Casino statistics
YCMD:casinostats(playerid, params[], help)
{
    if(!IsValidPlayer(playerid))
        return 0;
        
    new query[256];
    mysql_format(SQL, query, sizeof(query),
        "SELECT SUM(bet_amount) as total_bets, SUM(win_amount) as total_wins \
        FROM casino_logs WHERE player_id = %d",
        GetPlayerAccountID(playerid));
        
    mysql_tquery(SQL, query, "OnShowCasinoStats", "i", playerid);
    return 1;
}

forward OnShowCasinoStats(playerid);
public OnShowCasinoStats(playerid)
{
    new total_bets, total_wins;
    cache_get_value_name_int(0, "total_bets", total_bets);
    cache_get_value_name_int(0, "total_wins", total_wins);
    
    new str[256];
    format(str, sizeof(str), "Casino Statistics\n\n\
        Total Bets: $%d\n\
        Total Wins: $%d\n\
        Net Profit: $%d\n\
        Current Chips: $%d\n\
        Daily Chips Used: $%d/$%d",
        total_bets, total_wins, total_wins - total_bets,
        PlayerCasino[playerid][pChips],
        PlayerCasino[playerid][pDailyChips], MAX_DAILY_CHIPS);
        
    Dialog_Show(playerid, DIALOG_CASINO_STATS, DIALOG_STYLE_MSGBOX,
        "Casino Statistics", str, "Close", "");
    
    return 1;
}

// Rock Paper Scissors
enum E_RPS_CHOICE {
    CHOICE_ROCK,
    CHOICE_PAPER,
    CHOICE_SCISSORS
}

YCMD:rps(playerid, params[], help)
{
    new bet, choice[10];
    if(sscanf(params, "is[10]", bet, choice))
        return SendClientMessage(playerid, x_red, "USAGE: /rps [bet] [rock/paper/scissors]");
        
    if(!IsPlayerEligibleToBet(playerid, bet))
        return SendClientMessage(playerid, x_red, "* You can't play RPS right now!");
        
    new E_RPS_CHOICE playerChoice;
    if(!strcmp(choice, "rock", true)) playerChoice = CHOICE_ROCK;
    else if(!strcmp(choice, "paper", true)) playerChoice = CHOICE_PAPER;
    else if(!strcmp(choice, "scissors", true)) playerChoice = CHOICE_SCISSORS;
    else return SendClientMessage(playerid, x_red, "* Choose rock, paper, or scissors!");
    
    PlayRPS(playerid, bet, playerChoice);
    return 1;
}

stock PlayRPS(playerid, bet, E_RPS_CHOICE:playerChoice)
{
    if(!IsValidBet(playerid, bet))
        return 0;
        
    PlayerCasino[playerid][pInGame] = true;
    PlayerCasino[playerid][pChips] -= bet;
    
    new bool:win = ShouldPlayerWin();
    new E_RPS_CHOICE:casinoChoice;
    
    if(win)
    {
        // Force casino to lose
        switch(playerChoice)
        {
            case CHOICE_ROCK: casinoChoice = CHOICE_SCISSORS;
            case CHOICE_PAPER: casinoChoice = CHOICE_ROCK;
            case CHOICE_SCISSORS: casinoChoice = CHOICE_PAPER;
        }
    }
    else
    {
        // Force casino to win
        switch(playerChoice)
        {
            case CHOICE_ROCK: casinoChoice = CHOICE_PAPER;
            case CHOICE_PAPER: casinoChoice = CHOICE_SCISSORS;
            case CHOICE_SCISSORS: casinoChoice = CHOICE_ROCK;
        }
    }
    
    new winnings = 0;
    
    // Determine winner
    if(playerChoice == casinoChoice) // Draw
        winnings = bet;
    else if((playerChoice == CHOICE_ROCK && casinoChoice == CHOICE_SCISSORS) ||
            (playerChoice == CHOICE_PAPER && casinoChoice == CHOICE_ROCK) ||
            (playerChoice == CHOICE_SCISSORS && casinoChoice == CHOICE_PAPER))
        winnings = bet * 2;
        
    // Apply commission on wins
    if(winnings > bet)
    {
        new commission = floatround(winnings * (CASINO_COMMISSION / 100.0));
        winnings -= commission;
        g_JackpotAmount += commission;
    }
    
    PlayerCasino[playerid][pChips] += winnings;
    LogCasinoGame(playerid, "RPS", bet, winnings);
    
    new choiceNames[][] = {"Rock", "Paper", "Scissors"};
    new str[128];
    format(str, sizeof(str), "* You chose %s, Casino chose %s! You %s $%d!",
        choiceNames[_:playerChoice], choiceNames[_:casinoChoice],
        (winnings > bet) ? ("won") : (winnings == bet ? ("tied") : ("lost")),
        (winnings > bet) ? (winnings - bet) : (bet - winnings));
    SendClientMessage(playerid, x_green, str);
    
    PlayerCasino[playerid][pInGame] = false;
    return 1;
}

// Lucky 7
YCMD:lucky7(playerid, params[], help)
{
    new bet;
    if(sscanf(params, "i", bet))
        return SendClientMessage(playerid, x_red, "USAGE: /lucky7 [bet]");
        
    if(!IsPlayerEligibleToBet(playerid, bet))
        return SendClientMessage(playerid, x_red, "* You can't play Lucky 7 right now!");
        
    PlayLucky7(playerid, bet);
    return 1;
}

stock PlayLucky7(playerid, bet)
{
    PlayerCasino[playerid][pInGame] = true;
    PlayerCasino[playerid][pChips] -= bet;
    
    new numbers[3];
    new winnings = 0;
    
    // Generate numbers
    for(new i = 0; i < 3; i++)
        numbers[i] = random(7) + 1;
    
    // Check combinations
    if(numbers[0] == 7 && numbers[1] == 7 && numbers[2] == 7)
        winnings = bet * 7; // Triple 7
    else if(numbers[0] + numbers[1] + numbers[2] == 7)
        winnings = bet * 3; // Sum of 7
    else if(numbers[0] == numbers[1] && numbers[1] == numbers[2])
        winnings = bet * 5; // Three of a kind
        
    // Apply commission
    if(winnings > 0)
    {
        new commission = floatround(winnings * (CASINO_COMMISSION / 100.0));
        winnings -= commission;
        g_JackpotAmount += commission;
    }
    
    PlayerCasino[playerid][pChips] += winnings;
    LogCasinoGame(playerid, "LUCKY7", bet, winnings);
    
    new str[128];
    format(str, sizeof(str), "* Numbers: [%d] [%d] [%d] - You %s $%d!",
        numbers[0], numbers[1], numbers[2],
        (winnings > 0) ? ("won") : ("lost"),
        (winnings > 0) ? (winnings) : (bet));
    SendClientMessage(playerid, x_green, str);
    
    PlayerCasino[playerid][pInGame] = false;
    return 1;
}

// Bingo System
enum E_BINGO_CARD {
    bool:cardActive,
    cardNumbers[25],
    cardMarked[25],
    cardOwner,
    cardCost
}
new BingoCards[MAX_PLAYERS][E_BINGO_CARD];
new bool:BingoGameActive = false;
new BingoCurrentNumber = 0;
new BingoPot = 0;
new BingoTimer = -1;

YCMD:buybingo(playerid, params[], help)
{
    if(!BingoGameActive)
        return SendClientMessage(playerid, x_red, "* No Bingo game is currently active!");
        
    if(BingoCards[playerid][cardActive])
        return SendClientMessage(playerid, x_red, "* You already have a Bingo card!");
        
    if(!IsPlayerEligibleToBet(playerid, 1000)) // Fixed price for Bingo card
        return SendClientMessage(playerid, x_red, "* You can't buy a Bingo card right now!");
        
    GenerateBingoCard(playerid);
    return 1;
}

stock GenerateBingoCard(playerid)
{
    PlayerCasino[playerid][pChips] -= 1000;
    BingoCards[playerid][cardActive] = true;
    BingoCards[playerid][cardOwner] = playerid;
    BingoCards[playerid][cardCost] = 1000;
    BingoPot += 1000;
    
    // Generate random numbers for card
    new numbers[75], idx;
    for(new i = 0; i < 75; i++) numbers[i] = i + 1;
    
    // Fisher-Yates shuffle
    for(new i = 74; i > 0; i--)
    {
        new j = random(i + 1);
        new temp = numbers[i];
        numbers[i] = numbers[j];
        numbers[j] = temp;
    }
    
    // Fill card with first 25 numbers
    for(new i = 0; i < 25; i++)
    {
        BingoCards[playerid][cardNumbers][i] = numbers[i];
        BingoCards[playerid][cardMarked][i] = 0;
    }
    
    ShowBingoCard(playerid);
    return 1;
}

// Crash Game
enum E_CRASH_GAME {
    bool:crashActive,
    crashBet,
    Float:crashMultiplier,
    crashStartTime
}
new CrashGame[MAX_PLAYERS][E_CRASH_GAME];
new bool:CrashGameRunning = false;
new Float:CrashCurrentMultiplier = 1.0;
new CrashTimer = -1;

YCMD:crashbet(playerid, params[], help)
{
    new bet;
    if(sscanf(params, "i", bet))
        return SendClientMessage(playerid, x_red, "USAGE: /crashbet [amount]");
        
    if(!IsPlayerEligibleToBet(playerid, bet))
        return SendClientMessage(playerid, x_red, "* You can't place a Crash bet right now!");
        
    if(CrashGame[playerid][crashActive])
        return SendClientMessage(playerid, x_red, "* You already have an active Crash bet!");
        
    StartCrashBet(playerid, bet);
    return 1;
}

YCMD:cashout(playerid, params[])
{
    if(!CrashGame[playerid][crashActive])
        return SendClientMessage(playerid, x_red, "* You don't have an active Crash bet!");
        
    if(!CrashGameRunning)
        return SendClientMessage(playerid, x_red, "* The Crash game isn't running!");
        
    CashoutCrash(playerid);
    return 1;
}

stock StartCrashBet(playerid, bet)
{
    PlayerCasino[playerid][pChips] -= bet;
    CrashGame[playerid][crashActive] = true;
    CrashGame[playerid][crashBet] = bet;
    CrashGame[playerid][crashMultiplier] = 1.0;
    CrashGame[playerid][crashStartTime] = gettime();
    
    SendClientMessage(playerid, x_green, "* Your Crash bet is placed! Use /cashout to collect your winnings!");
    
    if(!CrashGameRunning)
        StartCrashGame();
        
    return 1;
}

stock CashoutCrash(playerid)
{
    if(!CrashGame[playerid][crashActive])
        return 0;
        
    new winnings = floatround(CrashGame[playerid][crashBet] * CrashCurrentMultiplier);
    
    // Apply commission
    new commission = floatround(winnings * (CASINO_COMMISSION / 100.0));
    winnings -= commission;
    g_JackpotAmount += commission;
    
    PlayerCasino[playerid][pChips] += winnings;
    LogCasinoGame(playerid, "CRASH", CrashGame[playerid][crashBet], winnings);
    
    new str[128];
    format(str, sizeof(str), "* You cashed out at %.2fx! Won: $%d!",
        CrashCurrentMultiplier, winnings - CrashGame[playerid][crashBet]);
    SendClientMessage(playerid, x_green, str);
    
    CrashGame[playerid][crashActive] = false;
    return 1;
}

forward UpdateCrashGame();
public UpdateCrashGame()
{
    if(!CrashGameRunning)
        return 0;
        
    CrashCurrentMultiplier += 0.1;
    
    // Controlled crash chance based on multiplier
    new crash_chance = floatround(CrashCurrentMultiplier * 15); // Higher multiplier = higher crash chance
    if(random(100) < crash_chance)
    {
        EndCrashGame();
        return 0;
    }
    
    // Maximum multiplier cap for security
    if(CrashCurrentMultiplier > 10.0)
    {
        EndCrashGame();
        return 0;
    }
    
    // Update all players
    new str[32];
    format(str, sizeof(str), "* Crash: %.2fx", CrashCurrentMultiplier);
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i) && CrashGame[i][crashActive])
        {
            SendClientMessage(i, x_green, str);
        }
    }
    
    return 1;
}

stock StartCrashGame()
{
    if(CrashGameRunning)
        return 0;
        
    CrashGameRunning = true;
    CrashCurrentMultiplier = 1.0;
    CrashTimer = SetTimer("UpdateCrashGame", 1000, true);
    
    SendClientMessageToAll(x_green, "* New Crash game started!");
    return 1;
}

stock EndCrashGame()
{
    if(!CrashGameRunning)
        return 0;
        
    CrashGameRunning = false;
    KillTimer(CrashTimer);
    
    // Process all active bets as losses
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i) && CrashGame[i][crashActive])
        {
            CrashGame[i][crashActive] = false;
            SendClientMessage(i, x_red, "* CRASH! You lost your bet!");
        }
    }
    
    SendClientMessageToAll(x_red, "* Crash game ended! Next game starting soon...");
    SetTimer("StartCrashGame", 5000, false);
    return 1;
}

// Anti-cheat measures
stock DetectAbnormalBetting(playerid, bet)
{
    new current_time = gettime();
    
    // Check for rapid betting
    if(current_time - PlayerCasino[playerid][pLastBetTime] < 2)
    {
        LogSuspiciousActivity(playerid, "Rapid betting detected");
        return 0;
    }
    
    // Check for unusual bet patterns
    if(bet > PlayerCasino[playerid][pChips] / 2)
    {
        LogSuspiciousActivity(playerid, "Large bet relative to balance");
    }
    
    return 1;
}

stock LogSuspiciousActivity(playerid, const reason[])
{
    new query[256], player_name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, player_name, sizeof(player_name));
    
    mysql_format(SQL, query, sizeof(query),
        "INSERT INTO casino_suspicious_activity (player_id, player_name, reason, timestamp) \
        VALUES (%d, '%e', '%e', NOW())",
        GetPlayerAccountID(playerid), player_name, reason);
    mysql_tquery(SQL, query);
}
