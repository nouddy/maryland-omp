#include <ysilib\YSI_Coding\y_hooks>

enum eLOG_TYPE {

    LOG_TYPE_CRIMINAL_RECORD,   //* Prison.
    LOG_TYPE_STAFF,             //* Commands used by staff
    LOG_TYPE_COMMANDS,          //* Log for Commands
    LOG_TYPE_ANTICHEAT,         //* AntiCheat -> Exploits -> Money -> LTA etc...
    LOG_TYPE_FACTION,           //* Robbery and all shit for factions
    LOG_TYPE_CONNECTION         //* S1mple stuff
}

stock mysql_write_log(const str[ ], eLOG_TYPE:LOG_TYPE) {

    static table[64];
    switch(LOG_TYPE) {

        case LOG_TYPE_CRIMINAL_RECORD:  { table = "log_crecords"; }
        case LOG_TYPE_STAFF: { table = "log_staff"; }     
        case LOG_TYPE_COMMANDS: { table = "log_commands"; }       
        case LOG_TYPE_ANTICHEAT:    { table = "log_anticheat"; }
        case LOG_TYPE_FACTION:      { table = "log_faction"; }   
        case LOG_TYPE_CONNECTION:   { table = "log_connection"; } 
    }

    new q[428];
    mysql_format(SQL, q, sizeof q, "INSERT INTO `%s` (`log_str`, `date`) VALUES ('%e', NOW())", table, str);
    mysql_tquery(SQL, q);

    return (true);
}

hook OnGameModeInit()
{
    print("-                                     -");

    mysql_tquery(SQL, "CREATE TABLE IF NOT EXISTS `log_crecords` ( log_str varchar(128) NOT NULL, date DATETIME NOT NULL);");
    mysql_tquery(SQL, "CREATE TABLE IF NOT EXISTS `log_staff` ( log_str varchar(128) NOT NULL, date DATETIME NOT NULL);");
    mysql_tquery(SQL, "CREATE TABLE IF NOT EXISTS `log_commands` ( log_str varchar(128) NOT NULL, date DATETIME NOT NULL);");
    mysql_tquery(SQL, "CREATE TABLE IF NOT EXISTS `log_anticheat` ( log_str varchar(128) NOT NULL, date DATETIME NOT NULL);");
    mysql_tquery(SQL, "CREATE TABLE IF NOT EXISTS `log_faction` ( log_str varchar(128) NOT NULL, date DATETIME NOT NULL);");
    mysql_tquery(SQL, "CREATE TABLE IF NOT EXISTS `log_connection` ( log_str varchar(128) NOT NULL, date DATETIME NOT NULL);");
    
    
    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerCommandText(playerid, cmdtext[]) {

    static log_str[128];
    format(log_str, sizeof log_str, "COMMAND:  %s je iskoristio komandu %s", ReturnPlayerName(playerid), cmdtext);
    mysql_write_log(log_str, LOG_TYPE_COMMANDS);

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnRconLoginAttempt(ip[], password[], success)
{
    if (!success) 
    {
        new ipAddress[16];
        for (new i = 0; i < MAX_PLAYERS; i++) 
        {
            if (!IsPlayerConnected(i))
            {
                continue;
            }

            GetPlayerIp(i, ipAddress, sizeof(ipAddress));
            if (!strcmp(ip, ipAddress, true)) 
            {
                static log_str[128];
                format(log_str, sizeof log_str, "ANTICHEAT-LOG:  %s se pokusao prijaviti kao RCON | IP: %d", ReturnPlayerName(i), GetPlayerRawIp(i));
                mysql_write_log(log_str, LOG_TYPE_ANTICHEAT);
                break;
            }
        }
    }

    if (success) 
    {
        new ipAddress[16];
        for (new i = 0; i < MAX_PLAYERS; i++) 
        {
            if (!IsPlayerConnected(i))
            {
                continue;
            }

            GetPlayerIp(i, ipAddress, sizeof(ipAddress));
            if (!strcmp(ip, ipAddress, true)) 
            {
                static log_str[128];
                format(log_str, sizeof log_str, "ANTICHEAT-LOG:  %s se uspjesno prijavio kao RCON | IP: %d", ReturnPlayerName(i), GetPlayerRawIp(i));
                mysql_write_log(log_str, LOG_TYPE_ANTICHEAT);
                break;
            }
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerConnect(playerid) {

    static log_str[128];
    new pIP[16];
    GetPlayerIp(playerid, pIP, sizeof pIP);
    format(log_str, sizeof log_str, "CONNECT-LOG:  %s se konektuje na server | IP : %s", ReturnPlayerName(playerid), pIP);
    mysql_write_log(log_str, LOG_TYPE_CONNECTION);

    return Y_HOOKS_CONTINUE_RETURN_1;
}
