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
 *  @Author         Vostic
 *  @Date           24th December 2024
 *  @Weburl         weburl
 *  @Project        maryland_project
 *
 *  @File           discord.pwn
 *  @Module         modules
 */

#include <ysilib\YSI_Coding\y_hooks>

#define DISCORD_CHANNEL_ID "1315052790791540857"

hook OnGameModeInit()
{
	new hour, minute, second;
	gettime(hour, minute, second);
	
	new descStr[128];
	format(descStr, sizeof(descStr), ":white_check_mark: Server has been started successfully");
	
	new DCC_Channel:channel = DCC_FindChannelById(DISCORD_CHANNEL_ID);
	new DCC_Embed:embed = DCC_CreateEmbed(
		"Server Status",
		descStr, 
		"", 
		"", 
		0x00FF00, 
		"Maryland Roleplay" 
	);
	
	new timeStr[32];
	format(timeStr, sizeof(timeStr), ":clock3: %02d:%02d:%02d", hour, minute, second);
	DCC_AddEmbedField(embed, "Start Time", timeStr, true);
	
	DCC_SendChannelEmbedMessage(channel, embed);
	
	print("discord/discord.pwn loaded");
	return 1;
}

hook OnPlayerConnect(playerid)
{
	new 
		hour, minute, second,
		playerIP[16],
		descStr[128],
		timeStr[32];
	
	gettime(hour, minute, second);
	GetPlayerIp(playerid, playerIP, sizeof(playerIP));
	
	format(descStr, sizeof(descStr), ":inbox_tray: **%s** has connected to the server", ReturnPlayerName(playerid));
	format(timeStr, sizeof(timeStr), ":clock3: %02d:%02d:%02d", hour, minute, second);
	
	new DCC_Channel:channel = DCC_FindChannelById(DISCORD_CHANNEL_ID);
	new DCC_Embed:embed = DCC_CreateEmbed(
		"Player Connection", 
		descStr, 
		"", 
		"", 
		0x3498db,
		"Maryland Roleplay" 
	);
	
	DCC_AddEmbedField(embed, ":globe_with_meridians: IP Address", playerIP, true);
	DCC_AddEmbedField(embed, "Time", timeStr, true);
	
	DCC_SendChannelEmbedMessage(channel, embed);
	return 1;
}

hook OnRconLoginAttempt(ip[], password[], success)
{
	new 
		hour, minute, second,
		descStr[128],
		timeStr[32];
	
	gettime(hour, minute, second);
	format(timeStr, sizeof(timeStr), ":clock3: %02d:%02d:%02d", hour, minute, second);
	
	format(descStr, sizeof(descStr), "%s RCON Login Attempt\n:globe_with_meridians: **IP:** %s\n:bust_in_silhouette: **Player:** %s", 
		success ? ":unlock:" : ":lock:", 
		ip,
		ReturnPlayerNameFromIP(ip)
	);
	
	new DCC_Channel:channel = DCC_FindChannelById(DISCORD_CHANNEL_ID);
	new DCC_Embed:embed = DCC_CreateEmbed(
		"RCON Security Alert", 
		descStr, 
		"", 
		"", 
		success ? 0x2ecc71 : 0xe74c3c,
		"Maryland Roleplay" 
	);
	
	DCC_AddEmbedField(embed, "Time", timeStr, true);
	DCC_AddEmbedField(embed, "Password Used", password, true);
	
	DCC_SendChannelEmbedMessage(channel, embed);
	return 1;
}

stock ReturnPlayerNameFromIP(const ip[])
{
    new name[MAX_PLAYER_NAME] = "Unknown";
    
    foreach(new i : Player)
    {
        new playerIP[16];
        GetPlayerIp(i, playerIP, sizeof(playerIP));
        if(!strcmp(ip, playerIP))
        {
            return ReturnPlayerName(i);
        }
    }
    return name;
}
