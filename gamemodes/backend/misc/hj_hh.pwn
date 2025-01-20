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
 *  @Date           05th May 2023
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           hj_hh.pwn
 *  @Module         misc
 */

#include <ysilib\YSI_Coding\y_hooks>

// Add these variables at the top
new bool:HappyHours = false;
new bool:HappyJobs = false;
new Float:HappyHoursMultiplier = 2.0;  // Default 2x multiplier
new Float:HappyJobsMultiplier = 2.0;   // Default 2x multiplier

// Function to check if Happy Hours is active
stock bool:IsHappyHoursActive()
{
    return HappyHours;
}

// Function to check if Happy Jobs is active
stock bool:IsHappyJobsActive()
{
    return HappyJobs;
}

// Function to get Happy Hours multiplier
stock Float:GetHappyHoursMultiplier()
{
    return HappyHoursMultiplier;
}

// Function to get Happy Jobs multiplier
stock Float:GetHappyJobsMultiplier()
{
    return HappyJobsMultiplier;
}

// Command to toggle Happy Hours
YCMD:sethh(playerid, params[], help)
{
    if(help)
    {
        notification.Show(playerid, "HELP", "Ukljuci/iskljuci Happy Hours", "+", BOXCOLOR_BLUE);
        return 1;
    }

    if(GetPlayerStaffLevel(playerid) < e_HEAD_MANAGER)
        return notification.Show(playerid, "GRESKA", "Niste ovlasceni!", "!", BOXCOLOR_RED);

    new option[8], Float:multiplier;
    if(sscanf(params, "s[8]F(2.0)", option, multiplier))
    {
        SendClientMessage(playerid, x_server, "maryland \187; "c_white"/sethh [on/off] [multiplier]");
        SendClientMessage(playerid, x_server, "maryland \187; "c_white"Multiplier je opcion (default: 2.0)");
        return 1;
    }

    if(multiplier < 1.0 || multiplier > 5.0)
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Multiplier mora biti izmedju 1.0 i 5.0!");

    if(!strcmp(option, "on", true))
    {
        if(HappyHours)
            return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Happy Hours je vec ukljucen!");

        HappyHours = true;
        HappyHoursMultiplier = multiplier;

        // Notify all players
        new string[144];
        format(string, sizeof(string), "HAPPY HOURS JE POCEO! (x%.1f zarada)", multiplier);
        SendClientMessageToAll(x_server, string);

        // Log the action
        format(string, sizeof(string), "STAFF: %s je ukljucio Happy Hours (x%.1f)", ReturnPlayerName(playerid), multiplier);
        mysql_write_log(string, LOG_TYPE_STAFF);
    }
    else if(!strcmp(option, "off", true))
    {
        if(!HappyHours)
            return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Happy Hours je vec iskljucen!");

        HappyHours = false;
        
        // Notify all players
        SendClientMessageToAll(x_server, "HAPPY HOURS JE ZAVRSEN!");

        // Log the action
        new string[128];
        format(string, sizeof(string), "STAFF: %s je iskljucio Happy Hours", ReturnPlayerName(playerid));
        mysql_write_log(string, LOG_TYPE_STAFF);
    }
    else
    {
        SendClientMessage(playerid, x_server, "maryland \187; "c_white"Nevazeca opcija! Koristite 'on' ili 'off'");
    }

    return 1;
}

// Command to toggle Happy Jobs
YCMD:sethj(playerid, params[], help)
{
    if(help)
    {
        notification.Show(playerid, "HELP", "Ukljuci/iskljuci Happy Jobs", "+", BOXCOLOR_BLUE);
        return 1;
    }

    if(GetPlayerStaffLevel(playerid) < e_HEAD_MANAGER)
        return notification.Show(playerid, "GRESKA", "Niste ovlasceni!", "!", BOXCOLOR_RED);

    new option[8], Float:multiplier;
    if(sscanf(params, "s[8]F(2.0)", option, multiplier))
    {
        SendClientMessage(playerid, x_server, "maryland \187; "c_white"/sethj [on/off] [multiplier]");
        SendClientMessage(playerid, x_server, "maryland \187; "c_white"Multiplier je opcion (default: 2.0)");
        return 1;
    }

    if(multiplier < 1.0 || multiplier > 5.0)
        return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Multiplier mora biti izmedju 1.0 i 5.0!");

    if(!strcmp(option, "on", true))
    {
        if(HappyJobs)
            return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Happy Jobs je vec ukljucen!");

        HappyJobs = true;
        HappyJobsMultiplier = multiplier;

        // Notify all players
        new string[144];
        format(string, sizeof(string), "HAPPY JOBS JE POCEO! (x%.1f zarada na poslovima)", multiplier);
        SendClientMessageToAll(x_server, string);

        // Log the action
        format(string, sizeof(string), "STAFF: %s je ukljucio Happy Jobs (x%.1f)", ReturnPlayerName(playerid), multiplier);
        mysql_write_log(string, LOG_TYPE_STAFF);
    }
    else if(!strcmp(option, "off", true))
    {
        if(!HappyJobs)
            return SendClientMessage(playerid, x_server, "maryland \187; "c_white"Happy Jobs je vec iskljucen!");

        HappyJobs = false;
        
        // Notify all players
        SendClientMessageToAll(x_server, "HAPPY JOBS JE ZAVRSEN!");

        // Log the action
        new string[128];
        format(string, sizeof(string), "STAFF: %s je iskljucio Happy Jobs", ReturnPlayerName(playerid));
        mysql_write_log(string, LOG_TYPE_STAFF);
    }
    else
    {
        SendClientMessage(playerid, x_server, "maryland \187; "c_white"Nevazeca opcija! Koristite 'on' ili 'off'");
    }

    return 1;
}

// Example usage in your payment functions:
/*
stock GivePlayerJobMoney(playerid, Float:amount)
{
    if(IsHappyJobsActive())
    {
        amount *= GetHappyJobsMultiplier();
    }
    if(IsHappyHoursActive())
    {
        amount *= GetHappyHoursMultiplier();
    }
    GivePlayerMoney(playerid, amount);
}
*/
