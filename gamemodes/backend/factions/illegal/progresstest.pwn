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
 *  @Date           05th May 2023
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           progresstest
 *  @Module         vehicle
 */

#include <ysilib\YSI_Coding\y_hooks>


new
    PlayerBar:gBar,
    Float:gBarValue = 0.0,
    Float:gInc = 1.0,
    bool:gFilling = false;

new PlayerText:TemperatureCheck[MAX_PLAYERS][3];


funtests(playerid) {
    gBar = CreatePlayerProgressBar(playerid, 125.333358, 306.822174, 8.0, 97.0, 0x11acFFFF, 100.0, BAR_DIRECTION_UP);
    SetPlayerProgressBarValue(playerid, gBar, gBarValue);
    ShowPlayerProgressBar(playerid, gBar);
    CocaineInterface(playerid, true);
}

forward updatebar();
public updatebar() {
    if (!gFilling) {
        gBarValue -= 0.5; // Decrease the bar value
        if (gBarValue < 0.0) {
            gBarValue = 0.0; // Ensure it doesn't go below 0
        }
    }
    
    SetPlayerProgressBarValue(0, gBar, gBarValue);
    UpdateTemperatureTextDraw(0);
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys) {
    if (newkeys & KEY_NO) {
        gFilling = true; // Start filling when N is pressed
        gBarValue += gInc; // Increment the bar value
        if (gBarValue > 100.0) { // Assuming max value is 100
            gBarValue = 100.0; // Ensure it doesn't exceed max
        }
        UpdateTemperatureTextDraw(playerid); // Update temperature text after increment
    } else {
        gFilling = false; // Stop filling when N is released
    }
}


CMD:cookcocaine(playerid, params[]) {
    funtests(playerid); // Initialize the progress bar
    SetTimer("updatebar", 100, true); // Start the update timer
    return 1;
}

stock UpdateTemperatureTextDraw(playerid) {
    new temp[48];
    format(temp, sizeof temp, "Temperature: %.2f", gBarValue);
    PlayerTextDrawSetString(playerid, TemperatureCheck[playerid][2], temp); // Update the text draw string
}

stock CocaineInterface(playerid, bool:show) {
    if (show) {
        // Adjust positions of the lines/text draws
        new Float:lineYPosition = 306.822174; // 
        new Float:lineYPosition2 = 380.0; //

        for (new i = 0; i < sizeof TemperatureCheck[]; i++) {
            PlayerTextDrawHide(playerid, TemperatureCheck[playerid][i]);
            PlayerTextDrawDestroy(playerid, TemperatureCheck[playerid][i]);
            TemperatureCheck[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
        }

        // Create first line
        TemperatureCheck[playerid][0] = CreatePlayerTextDraw(playerid, 97.999977, lineYPosition, "-----------");
        PlayerTextDrawLetterSize(playerid, TemperatureCheck[playerid][0], 0.400000, 1.600000);
        PlayerTextDrawAlignment(playerid, TemperatureCheck[playerid][0], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, TemperatureCheck[playerid][0], -16776961);
        PlayerTextDrawSetShadow(playerid, TemperatureCheck[playerid][0], 0);
        PlayerTextDrawBackgroundColour(playerid, TemperatureCheck[playerid][0], 255);
        PlayerTextDrawFont(playerid, TemperatureCheck[playerid][0], TEXT_DRAW_FONT_1);
        PlayerTextDrawSetProportional(playerid, TemperatureCheck[playerid][0], true);

        // Create second line
        TemperatureCheck[playerid][1] = CreatePlayerTextDraw(playerid, 97.999977, lineYPosition2, "-----------");
        PlayerTextDrawLetterSize(playerid, TemperatureCheck[playerid][1], 0.400000, 1.600000);
        PlayerTextDrawAlignment(playerid, TemperatureCheck[playerid][1], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, TemperatureCheck[playerid][1], 65535);
        PlayerTextDrawSetShadow(playerid, TemperatureCheck[playerid][1], 0);
        PlayerTextDrawBackgroundColour(playerid, TemperatureCheck[playerid][1], 255);
        PlayerTextDrawFont(playerid, TemperatureCheck[playerid][1], TEXT_DRAW_FONT_1);
        PlayerTextDrawSetProportional(playerid, TemperatureCheck[playerid][1], true);
        
        // Create temperature display
        new temp[48];
        format(temp, sizeof temp, "Temperature: %.2f", gBarValue);
        TemperatureCheck[playerid][2] = CreatePlayerTextDraw(playerid, 128.333358, 404.459259, temp);
        PlayerTextDrawLetterSize(playerid, TemperatureCheck[playerid][2], 0.122666, 0.708147);
        PlayerTextDrawAlignment(playerid, TemperatureCheck[playerid][2], TEXT_DRAW_ALIGN_CENTER);
        PlayerTextDrawColour(playerid, TemperatureCheck[playerid][2], -1);
        PlayerTextDrawSetShadow(playerid, TemperatureCheck[playerid][2], 0);
        PlayerTextDrawBackgroundColour(playerid, TemperatureCheck[playerid][2], 255);
        PlayerTextDrawFont(playerid, TemperatureCheck[playerid][2], TEXT_DRAW_FONT_1);
        PlayerTextDrawSetProportional(playerid, TemperatureCheck[playerid][2], true);

        for (new i = 0; i < sizeof TemperatureCheck[]; i++) {
            PlayerTextDrawShow(playerid, TemperatureCheck[playerid][i]);
        }
    } else {
        for (new i = 0; i < sizeof TemperatureCheck[]; i++) {
            PlayerTextDrawHide(playerid, TemperatureCheck[playerid][i]);
            PlayerTextDrawDestroy(playerid, TemperatureCheck[playerid][i]);
            TemperatureCheck[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
        }
    }
}
