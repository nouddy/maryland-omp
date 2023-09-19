#include <ysilib\YSI_Coding\y_hooks>
//////////////////////////////////////// Textdraws Imena (Defines) ///////////////////////////////////////////////////

//new PlayerText:BankaIgraca[MAX_PLAYERS];
/////////////////////////////////////// Public za sve PlayerTdove  ////////////////////////////////////////////////////


hook OnGameModeInit()
{
    print("frontend/main.tde loaded");

    CreateTextdraws();		//Stock za tdove
}

hook OnPlayerSpawn(playerid)
{
    //! GlobalTD
    /*
  
    ? Zbog umiranja igraca, svakog pozivanja "SpawnPlayer"(Kada izadje/udje u interier itd... premaknjeno u timer Spawn_Player);

    for(new i=0; i< 30; i++)
    {
        TextDrawShowForPlayer(playerid, MarylandLogo[i]);
    }

    for(new i=0; i< 40; i++)
    {
        TextDrawShowForPlayer(playerid, Global_TD[i]);
    }

    //
    for(new i=0; i< 8; i++)
    {
        PlayerTextDrawShow(playerid, Player_TDs[playerid][i]);
    }
    //! Ime Igraca
    static pname[25];
	format(pname, sizeof(pname), "%s", ReturnPlayerName(playerid));
	PlayerTextDrawSetString(playerid, Player_TDs[playerid][1], pname);
    PlayerTextDrawShow(playerid, Player_TDs[playerid][1]);

    // //! Banka Igraca
    // static stringic[ 40 ];

	// if(player_BankAccount[playerid] == 0) {
	//     PlayerTextDrawSetString(playerid, BankaIgraca[playerid], "Nemate Racun" );
    // }
    // else {
    //     format(stringic, sizeof(stringic), "%d$", player_BankMoney[playerid]);
	//     PlayerTextDrawSetString(playerid, BankaIgraca[playerid],stringic);
    // }
    // PlayerTextDrawShow(playerid, BankaIgraca[playerid]);

	//!skin provera
	PlayerTextDrawSetPreviewModel(playerid, Player_TDs[playerid][0], PlayerInfo[playerid][Skin]);
	PlayerTextDrawShow(playerid, Player_TDs[playerid][0]);

    */

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerConnect(playerid)
{
    CreatePlayerTextDraws(playerid);

    return Y_HOOKS_CONTINUE_RETURN_1;
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////

stock CreateTextdraws() {

    //Logo
    MarylandLogo[0] = TextDrawCreate(549.733154, 39.196327, "");
    TextDrawTextSize(MarylandLogo[0], 19.000000, -24.000000);
    TextDrawAlignment(MarylandLogo[0], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(MarylandLogo[0], -1);
    TextDrawSetShadow(MarylandLogo[0], 0);
    TextDrawBackgroundColour(MarylandLogo[0], -256);
    TextDrawFont(MarylandLogo[0], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(MarylandLogo[0], false);
    TextDrawSetPreviewModel(MarylandLogo[0], 1318);
    TextDrawSetPreviewRot(MarylandLogo[0], 0.000000, 15.000000, -1.000000, 1.000000);

    MarylandLogo[1] = TextDrawCreate(551.733398, -5.518454, "");
    TextDrawTextSize(MarylandLogo[1], 18.000000, 49.000000);
    TextDrawAlignment(MarylandLogo[1], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(MarylandLogo[1], -1);
    TextDrawSetShadow(MarylandLogo[1], 0);
    TextDrawBackgroundColour(MarylandLogo[1], -256);
    TextDrawFont(MarylandLogo[1], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(MarylandLogo[1], false);
    TextDrawSetPreviewModel(MarylandLogo[1], 19177);
    TextDrawSetPreviewRot(MarylandLogo[1], 0.000000, 0.000000, 0.000000, 1.000000);

    MarylandLogo[2] = TextDrawCreate(551.533325, 37.196365, "");
    TextDrawTextSize(MarylandLogo[2], 17.000000, -20.000000);
    TextDrawAlignment(MarylandLogo[2], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(MarylandLogo[2], -1);
    TextDrawSetShadow(MarylandLogo[2], 0);
    TextDrawBackgroundColour(MarylandLogo[2], -256);
    TextDrawFont(MarylandLogo[2], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(MarylandLogo[2], false);
    TextDrawSetPreviewModel(MarylandLogo[2], 1318);
    TextDrawSetPreviewRot(MarylandLogo[2], 0.000000, 15.000000, -1.000000, 1.000000);

    MarylandLogo[3] = TextDrawCreate(552.699707, 31.837007, "");
    TextDrawTextSize(MarylandLogo[3], 20.000000, -14.000000);
    TextDrawAlignment(MarylandLogo[3], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(MarylandLogo[3], -1);
    TextDrawSetShadow(MarylandLogo[3], 0);
    TextDrawBackgroundColour(MarylandLogo[3], -256);
    TextDrawFont(MarylandLogo[3], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(MarylandLogo[3], false);
    TextDrawSetPreviewModel(MarylandLogo[3], 1318);
    TextDrawSetPreviewRot(MarylandLogo[3], 0.000000, -15.000000, -1.000000, 1.000000);

    MarylandLogo[4] = TextDrawCreate(551.899780, 36.770309, "");
    TextDrawTextSize(MarylandLogo[4], 20.000000, -14.000000);
    TextDrawAlignment(MarylandLogo[4], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(MarylandLogo[4], -1);
    TextDrawSetShadow(MarylandLogo[4], 0);
    TextDrawBackgroundColour(MarylandLogo[4], -256);
    TextDrawFont(MarylandLogo[4], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(MarylandLogo[4], false);
    TextDrawSetPreviewModel(MarylandLogo[4], 1318);
    TextDrawSetPreviewRot(MarylandLogo[4], 0.000000, -15.000000, -1.000000, 1.000000);

    MarylandLogo[5] = TextDrawCreate(552.333068, 34.896244, "");
    TextDrawTextSize(MarylandLogo[5], 20.000000, -14.000000);
    TextDrawAlignment(MarylandLogo[5], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(MarylandLogo[5], -1);
    TextDrawSetShadow(MarylandLogo[5], 0);
    TextDrawBackgroundColour(MarylandLogo[5], -256);
    TextDrawFont(MarylandLogo[5], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(MarylandLogo[5], false);
    TextDrawSetPreviewModel(MarylandLogo[5], 1318);
    TextDrawSetPreviewRot(MarylandLogo[5], 0.000000, -15.000000, -1.000000, 1.000000);

    MarylandLogo[6] = TextDrawCreate(554.166503, 36.937088, "");
    TextDrawTextSize(MarylandLogo[6], 12.000000, -14.000000);
    TextDrawAlignment(MarylandLogo[6], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(MarylandLogo[6], -1);
    TextDrawSetShadow(MarylandLogo[6], 0);
    TextDrawBackgroundColour(MarylandLogo[6], -256);
    TextDrawFont(MarylandLogo[6], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(MarylandLogo[6], false);
    TextDrawSetPreviewModel(MarylandLogo[6], 1318);
    TextDrawSetPreviewRot(MarylandLogo[6], 0.000000, 15.000000, -1.000000, 1.000000);

    MarylandLogo[7] = TextDrawCreate(553.966674, 7.914912, "");
    TextDrawTextSize(MarylandLogo[7], 25.000000, 44.000000);
    TextDrawAlignment(MarylandLogo[7], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(MarylandLogo[7], -1);
    TextDrawSetShadow(MarylandLogo[7], 0);
    TextDrawBackgroundColour(MarylandLogo[7], -256);
    TextDrawFont(MarylandLogo[7], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(MarylandLogo[7], false);
    TextDrawSetPreviewModel(MarylandLogo[7], 19177);
    TextDrawSetPreviewRot(MarylandLogo[7], 0.000000, 0.000000, 0.000000, 1.000000);

    MarylandLogo[8] = TextDrawCreate(564.433166, 39.411170, "");
    TextDrawTextSize(MarylandLogo[8], 19.000000, -24.000000);
    TextDrawAlignment(MarylandLogo[8], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(MarylandLogo[8], -1);
    TextDrawSetShadow(MarylandLogo[8], 0);
    TextDrawBackgroundColour(MarylandLogo[8], -256);
    TextDrawFont(MarylandLogo[8], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(MarylandLogo[8], false);
    TextDrawSetPreviewModel(MarylandLogo[8], 1318);
    TextDrawSetPreviewRot(MarylandLogo[8], 0.000000, -15.000000, -1.000000, 1.000000);

    MarylandLogo[9] = TextDrawCreate(563.333374, -5.518465, "");
    TextDrawTextSize(MarylandLogo[9], 18.000000, 49.000000);
    TextDrawAlignment(MarylandLogo[9], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(MarylandLogo[9], -1);
    TextDrawSetShadow(MarylandLogo[9], 0);
    TextDrawBackgroundColour(MarylandLogo[9], -256);
    TextDrawFont(MarylandLogo[9], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(MarylandLogo[9], false);
    TextDrawSetPreviewModel(MarylandLogo[9], 19177);
    TextDrawSetPreviewRot(MarylandLogo[9], 0.000000, 0.000000, 0.000000, 1.000000);

    MarylandLogo[10] = TextDrawCreate(564.299926, 38.170509, "");
    TextDrawTextSize(MarylandLogo[10], 17.000000, -20.000000);
    TextDrawAlignment(MarylandLogo[10], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(MarylandLogo[10], -1);
    TextDrawSetShadow(MarylandLogo[10], 0);
    TextDrawBackgroundColour(MarylandLogo[10], -256);
    TextDrawFont(MarylandLogo[10], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(MarylandLogo[10], false);
    TextDrawSetPreviewModel(MarylandLogo[10], 1318);
    TextDrawSetPreviewRot(MarylandLogo[10], 0.000000, -15.000000, -1.000000, 1.000000);

    MarylandLogo[11] = TextDrawCreate(559.699584, 31.707368, "");
    TextDrawTextSize(MarylandLogo[11], 21.000000, -13.060001);
    TextDrawAlignment(MarylandLogo[11], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(MarylandLogo[11], -1);
    TextDrawSetShadow(MarylandLogo[11], 0);
    TextDrawBackgroundColour(MarylandLogo[11], -256);
    TextDrawFont(MarylandLogo[11], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(MarylandLogo[11], false);
    TextDrawSetPreviewModel(MarylandLogo[11], 1318);
    TextDrawSetPreviewRot(MarylandLogo[11], 0.000000, 15.000000, 180.000000, 1.000000);

    MarylandLogo[12] = TextDrawCreate(560.799560, 35.848022, "");
    TextDrawTextSize(MarylandLogo[12], 21.000000, -13.060001);
    TextDrawAlignment(MarylandLogo[12], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(MarylandLogo[12], -1);
    TextDrawSetShadow(MarylandLogo[12], 0);
    TextDrawBackgroundColour(MarylandLogo[12], -256);
    TextDrawFont(MarylandLogo[12], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(MarylandLogo[12], false);
    TextDrawSetPreviewModel(MarylandLogo[12], 1318);
    TextDrawSetPreviewRot(MarylandLogo[12], 0.000000, 15.000000, 180.000000, 1.000000);

    MarylandLogo[13] = TextDrawCreate(559.399658, 35.218387, "");
    TextDrawTextSize(MarylandLogo[13], 21.000000, -13.060001);
    TextDrawAlignment(MarylandLogo[13], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(MarylandLogo[13], -1);
    TextDrawSetShadow(MarylandLogo[13], 0);
    TextDrawBackgroundColour(MarylandLogo[13], -256);
    TextDrawFont(MarylandLogo[13], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(MarylandLogo[13], false);
    TextDrawSetPreviewModel(MarylandLogo[13], 1318);
    TextDrawSetPreviewRot(MarylandLogo[13], 0.000000, 15.000000, 180.000000, 1.000000);

    MarylandLogo[14] = TextDrawCreate(543.133178, 43.370460, "");
    TextDrawTextSize(MarylandLogo[14], 45.000000, -18.000000);
    TextDrawAlignment(MarylandLogo[14], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(MarylandLogo[14], -1064116481);
    TextDrawSetShadow(MarylandLogo[14], 0);
    TextDrawBackgroundColour(MarylandLogo[14], -256);
    TextDrawFont(MarylandLogo[14], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(MarylandLogo[14], false);
    TextDrawSetPreviewModel(MarylandLogo[14], 2965);
    TextDrawSetPreviewRot(MarylandLogo[14], 90.000000, 0.000000, 90.000000, 1.000000);

    MarylandLogo[15] = TextDrawCreate(534.500000, 21.214885, "");
    TextDrawTextSize(MarylandLogo[15], 46.000000, 32.000000);
    TextDrawAlignment(MarylandLogo[15], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(MarylandLogo[15], -1064116481);
    TextDrawSetShadow(MarylandLogo[15], 0);
    TextDrawBackgroundColour(MarylandLogo[15], -256);
    TextDrawFont(MarylandLogo[15], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(MarylandLogo[15], false);
    TextDrawSetPreviewModel(MarylandLogo[15], 19177);
    TextDrawSetPreviewRot(MarylandLogo[15], 0.000000, 0.000000, 0.000000, 1.000000);

    MarylandLogo[16] = TextDrawCreate(552.300048, 21.085275, "");
    TextDrawTextSize(MarylandLogo[16], 46.000000, 32.000000);
    TextDrawAlignment(MarylandLogo[16], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(MarylandLogo[16], -1064116481);
    TextDrawSetShadow(MarylandLogo[16], 0);
    TextDrawBackgroundColour(MarylandLogo[16], -256);
    TextDrawFont(MarylandLogo[16], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(MarylandLogo[16], false);
    TextDrawSetPreviewModel(MarylandLogo[16], 19177);
    TextDrawSetPreviewRot(MarylandLogo[16], 0.000000, 0.000000, 0.000000, 1.000000);

    MarylandLogo[17] = TextDrawCreate(519.066589, 5.537127, "");
    TextDrawTextSize(MarylandLogo[17], 88.000000, 58.000000);
    TextDrawAlignment(MarylandLogo[17], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(MarylandLogo[17], -1064116481);
    TextDrawSetShadow(MarylandLogo[17], 0);
    TextDrawBackgroundColour(MarylandLogo[17], -256);
    TextDrawFont(MarylandLogo[17], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(MarylandLogo[17], false);
    TextDrawSetPreviewModel(MarylandLogo[17], 19177);
    TextDrawSetPreviewRot(MarylandLogo[17], 0.000000, 0.000000, 0.000000, 1.000000);

    MarylandLogo[18] = TextDrawCreate(525.466979, 5.537127, "");
    TextDrawTextSize(MarylandLogo[18], 88.000000, 58.000000);
    TextDrawAlignment(MarylandLogo[18], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(MarylandLogo[18], -1064116481);
    TextDrawSetShadow(MarylandLogo[18], 0);
    TextDrawBackgroundColour(MarylandLogo[18], -256);
    TextDrawFont(MarylandLogo[18], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(MarylandLogo[18], false);
    TextDrawSetPreviewModel(MarylandLogo[18], 19177);
    TextDrawSetPreviewRot(MarylandLogo[18], 0.000000, 0.000000, 0.000000, 1.000000);

    MarylandLogo[19] = TextDrawCreate(522.267089, 3.592641, "");
    TextDrawTextSize(MarylandLogo[19], 88.000000, 58.000000);
    TextDrawAlignment(MarylandLogo[19], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(MarylandLogo[19], -1064116481);
    TextDrawSetShadow(MarylandLogo[19], 0);
    TextDrawBackgroundColour(MarylandLogo[19], -256);
    TextDrawFont(MarylandLogo[19], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(MarylandLogo[19], false);
    TextDrawSetPreviewModel(MarylandLogo[19], 19177);
    TextDrawSetPreviewRot(MarylandLogo[19], 0.000000, 0.000000, 0.000000, 1.000000);

    MarylandLogo[20] = TextDrawCreate(559.733337, 37.088882, "LD_SPAC:white");
    TextDrawTextSize(MarylandLogo[20], 14.000000, 2.000000);
    TextDrawAlignment(MarylandLogo[20], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(MarylandLogo[20], -1064116481);
    TextDrawSetShadow(MarylandLogo[20], 0);
    TextDrawBackgroundColour(MarylandLogo[20], 255);
    TextDrawFont(MarylandLogo[20], TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawSetProportional(MarylandLogo[20], false);

    MarylandLogo[21] = TextDrawCreate(550.233398, 28.681629, "");
    TextDrawTextSize(MarylandLogo[21], 28.000000, 19.160003);
    TextDrawAlignment(MarylandLogo[21], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(MarylandLogo[21], -1);
    TextDrawSetShadow(MarylandLogo[21], 0);
    TextDrawBackgroundColour(MarylandLogo[21], -256);
    TextDrawFont(MarylandLogo[21], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(MarylandLogo[21], false);
    TextDrawSetPreviewModel(MarylandLogo[21], 19177);
    TextDrawSetPreviewRot(MarylandLogo[21], 0.000000, 0.000000, 0.000000, 1.000000);

    MarylandLogo[22] = TextDrawCreate(555.033691, 28.681629, "");
    TextDrawTextSize(MarylandLogo[22], 28.000000, 19.160003);
    TextDrawAlignment(MarylandLogo[22], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(MarylandLogo[22], -1);
    TextDrawSetShadow(MarylandLogo[22], 0);
    TextDrawBackgroundColour(MarylandLogo[22], -256);
    TextDrawFont(MarylandLogo[22], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(MarylandLogo[22], false);
    TextDrawSetPreviewModel(MarylandLogo[22], 19177);
    TextDrawSetPreviewRot(MarylandLogo[22], 0.000000, 0.000000, 0.000000, 1.000000);

    MarylandLogo[23] = TextDrawCreate(543.133178, 43.370460, "");
    TextDrawTextSize(MarylandLogo[23], 45.000000, -18.000000);
    TextDrawAlignment(MarylandLogo[23], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(MarylandLogo[23], -120);
    TextDrawSetShadow(MarylandLogo[23], 0);
    TextDrawBackgroundColour(MarylandLogo[23], -256);
    TextDrawFont(MarylandLogo[23], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(MarylandLogo[23], false);
    TextDrawSetPreviewModel(MarylandLogo[23], 2965);
    TextDrawSetPreviewRot(MarylandLogo[23], 90.000000, 0.000000, 90.000000, 1.000000);

    MarylandLogo[24] = TextDrawCreate(545.533447, 88.226043, "");
    TextDrawTextSize(MarylandLogo[24], 42.000000, -93.000000);
    TextDrawAlignment(MarylandLogo[24], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(MarylandLogo[24], -1064116481);
    TextDrawSetShadow(MarylandLogo[24], 0);
    TextDrawBackgroundColour(MarylandLogo[24], -256);
    TextDrawFont(MarylandLogo[24], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(MarylandLogo[24], false);
    TextDrawSetPreviewModel(MarylandLogo[24], 19177);
    TextDrawSetPreviewRot(MarylandLogo[24], 0.000000, 0.000000, 0.000000, 1.000000);

    MarylandLogo[25] = TextDrawCreate(545.500122, -7.362924, "");
    TextDrawTextSize(MarylandLogo[25], 42.000000, 83.000000);
    TextDrawAlignment(MarylandLogo[25], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(MarylandLogo[25], -1064116481);
    TextDrawSetShadow(MarylandLogo[25], 0);
    TextDrawBackgroundColour(MarylandLogo[25], -256);
    TextDrawFont(MarylandLogo[25], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(MarylandLogo[25], false);
    TextDrawSetPreviewModel(MarylandLogo[25], 19177);
    TextDrawSetPreviewRot(MarylandLogo[25], 0.000000, 0.000000, 0.000000, 1.000000);

    MarylandLogo[26] = TextDrawCreate(561.666503, 25.196397, "V");
    TextDrawLetterSize(MarylandLogo[26], 0.352665, 1.890370);
    TextDrawAlignment(MarylandLogo[26], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(MarylandLogo[26], -188);
    TextDrawSetShadow(MarylandLogo[26], 0);
    TextDrawBackgroundColour(MarylandLogo[26], 255);
    TextDrawFont(MarylandLogo[26], TEXT_DRAW_FONT_2);
    TextDrawSetProportional(MarylandLogo[26], true);

    MarylandLogo[27] = TextDrawCreate(562.066833, 51.081558, "");
    TextDrawTextSize(MarylandLogo[27], 9.000000, -21.000000);
    TextDrawAlignment(MarylandLogo[27], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(MarylandLogo[27], -188);
    TextDrawSetShadow(MarylandLogo[27], 0);
    TextDrawBackgroundColour(MarylandLogo[27], -256);
    TextDrawFont(MarylandLogo[27], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(MarylandLogo[27], false);
    TextDrawSetPreviewModel(MarylandLogo[27], 19177);
    TextDrawSetPreviewRot(MarylandLogo[27], 0.000000, 0.000000, 0.000000, 1.000000);

    MarylandLogo[28] = TextDrawCreate(562.233581, 15.633377, "");
    TextDrawTextSize(MarylandLogo[28], 8.709993, 33.400100);
    TextDrawAlignment(MarylandLogo[28], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(MarylandLogo[28], -1);
    TextDrawSetShadow(MarylandLogo[28], 0);
    TextDrawBackgroundColour(MarylandLogo[28], -256);
    TextDrawFont(MarylandLogo[28], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(MarylandLogo[28], false);
    TextDrawSetPreviewModel(MarylandLogo[28], 19177);
    TextDrawSetPreviewRot(MarylandLogo[28], 0.000000, 0.000000, 0.000000, 1.000000);

    MarylandLogo[29] = TextDrawCreate(562.533569, 25.133256, "");
    TextDrawTextSize(MarylandLogo[29], 8.000000, 18.000000);
    TextDrawAlignment(MarylandLogo[29], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(MarylandLogo[29], -1);
    TextDrawSetShadow(MarylandLogo[29], 0);
    TextDrawBackgroundColour(MarylandLogo[29], -256);
    TextDrawFont(MarylandLogo[29], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(MarylandLogo[29], false);
    TextDrawSetPreviewModel(MarylandLogo[29], 19177);
    TextDrawSetPreviewRot(MarylandLogo[29], 180.000000, 0.000000, 0.000000, 1.000000);

    //Global

    Global_TD[0] = TextDrawCreate(135.000030, 424.529602, "LD_SPAC:white");
    TextDrawTextSize(Global_TD[0], 511.000000, 16.190004);
    TextDrawAlignment(Global_TD[0], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[0], 404232447);
    TextDrawSetShadow(Global_TD[0], 0);
    TextDrawBackgroundColour(Global_TD[0], 255);
    TextDrawFont(Global_TD[0], TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawSetProportional(Global_TD[0], false);

    Global_TD[1] = TextDrawCreate(104.366683, 391.114929, "");
    TextDrawTextSize(Global_TD[1], 61.000000, 90.000000);
    TextDrawAlignment(Global_TD[1], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[1], 0x8DC9F3FF);
    TextDrawSetShadow(Global_TD[1], 0);
    TextDrawBackgroundColour(Global_TD[1], 0xFFFFFF00);
    TextDrawFont(Global_TD[1], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(Global_TD[1], false);
    TextDrawSetPreviewModel(Global_TD[1], 19177);
    TextDrawSetPreviewRot(Global_TD[1], 0.000000, 180.000000, 0.000000, 1.000000);

    Global_TD[2] = TextDrawCreate(100.366744, 383.814483, "");
    TextDrawTextSize(Global_TD[2], 61.000000, 90.000000);
    TextDrawAlignment(Global_TD[2], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[2], 0x8DC9F3FF);
    TextDrawSetShadow(Global_TD[2], 0);
    TextDrawBackgroundColour(Global_TD[2], 0xFFFFFF00);
    TextDrawFont(Global_TD[2], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(Global_TD[2], false);
    TextDrawSetPreviewModel(Global_TD[2], 19177);
    TextDrawSetPreviewRot(Global_TD[2], 0.000000, 180.000000, 0.000000, 1.000000);

    Global_TD[3] = TextDrawCreate(104.666679, 383.814483, "");
    TextDrawTextSize(Global_TD[3], 61.000000, 90.000000);
    TextDrawAlignment(Global_TD[3], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[3], 0x8DC9F3FF);
    TextDrawSetShadow(Global_TD[3], 0);
    TextDrawBackgroundColour(Global_TD[3], 0xFFFFFF00);
    TextDrawFont(Global_TD[3], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(Global_TD[3], false);
    TextDrawSetPreviewModel(Global_TD[3], 19177);
    TextDrawSetPreviewRot(Global_TD[3], 0.000000, 0.000000, 0.000000, 1.000000);

    Global_TD[4] = TextDrawCreate(108.366622, 391.314941, "");
    TextDrawTextSize(Global_TD[4], 61.000000, 90.000000);
    TextDrawAlignment(Global_TD[4], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[4], 0x8DC9F3FF);
    TextDrawSetShadow(Global_TD[4], 0);
    TextDrawBackgroundColour(Global_TD[4], 0xFFFFFF00);
    TextDrawFont(Global_TD[4], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(Global_TD[4], false);
    TextDrawSetPreviewModel(Global_TD[4], 19177);
    TextDrawSetPreviewRot(Global_TD[4], 0.000000, 0.000000, 0.000000, 1.000000);

    Global_TD[5] = TextDrawCreate(128.266647, 417.448333, "");
    TextDrawTextSize(Global_TD[5], 29.000000, 31.150003);
    TextDrawAlignment(Global_TD[5], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[5], 404232192);
    TextDrawSetShadow(Global_TD[5], 0);
    TextDrawBackgroundColour(Global_TD[5], 404232192);
    TextDrawFont(Global_TD[5], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(Global_TD[5], false);
    TextDrawSetPreviewModel(Global_TD[5], 2965);
    TextDrawSetPreviewRot(Global_TD[5], 90.000000, 0.000000, 90.000000, 1.000000);

    Global_TD[6] = TextDrawCreate(128.766677, 417.448333, "");
    TextDrawTextSize(Global_TD[6], 29.000000, 31.000000);
    TextDrawAlignment(Global_TD[6], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[6], 404232192);
    TextDrawSetShadow(Global_TD[6], 0);
    TextDrawBackgroundColour(Global_TD[6], 404232192);
    TextDrawFont(Global_TD[6], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(Global_TD[6], false);
    TextDrawSetPreviewModel(Global_TD[6], 2965);
    TextDrawSetPreviewRot(Global_TD[6], 90.000000, 0.000000, 90.000000, 1.000000);

    Global_TD[7] = TextDrawCreate(143.200531, 424.529602, "LD_SPAC:white");
    TextDrawTextSize(Global_TD[7], 27.000000, 16.000000);
    TextDrawAlignment(Global_TD[7], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[7], 404232447);
    TextDrawSetShadow(Global_TD[7], 0);
    TextDrawBackgroundColour(Global_TD[7], 255);
    TextDrawFont(Global_TD[7], TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawSetProportional(Global_TD[7], false);

    Global_TD[8] = TextDrawCreate(128.333908, 438.503692, "particle:lamp_shad_64");
    TextDrawTextSize(Global_TD[8], 22.899997, -14.000000);
    TextDrawAlignment(Global_TD[8], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[8], 0x8DC9F34D);
    TextDrawSetShadow(Global_TD[8], 0);
    TextDrawBackgroundColour(Global_TD[8], 0x00000000);
    TextDrawFont(Global_TD[8], TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawSetProportional(Global_TD[8], false);

    Global_TD[9] = TextDrawCreate(157.933273, 428.148284, "");
    TextDrawTextSize(Global_TD[9], 7.000000, 8.000000);
    TextDrawAlignment(Global_TD[9], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[9], -1);
    TextDrawSetShadow(Global_TD[9], 0);
    TextDrawBackgroundColour(Global_TD[9], 0xFFFFFF00);
    TextDrawFont(Global_TD[9], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(Global_TD[9], false);
    TextDrawSetPreviewModel(Global_TD[9], 1316);
    TextDrawSetPreviewRot(Global_TD[9], 90.000000, 0.000000, 0.000000, 1.000000);

    Global_TD[10] = TextDrawCreate(158.399963, 428.548370, "");
    TextDrawTextSize(Global_TD[10], 6.180004, 7.150002);
    TextDrawAlignment(Global_TD[10], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[10], 404232447);
    TextDrawSetShadow(Global_TD[10], 0);
    TextDrawBackgroundColour(Global_TD[10], 0xFFFFFF00);
    TextDrawFont(Global_TD[10], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(Global_TD[10], false);
    TextDrawSetPreviewModel(Global_TD[10], 1316);
    TextDrawSetPreviewRot(Global_TD[10], 90.000000, 0.000000, 0.000000, 1.000000);

    Global_TD[11] = TextDrawCreate(160.466674, 429.148193, "i");
    TextDrawLetterSize(Global_TD[11], 0.189666, 0.587849);
    TextDrawAlignment(Global_TD[11], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[11], -1);
    TextDrawSetShadow(Global_TD[11], 0);
    TextDrawBackgroundColour(Global_TD[11], 255);
    TextDrawFont(Global_TD[11], TEXT_DRAW_FONT_0);
    TextDrawSetProportional(Global_TD[11], true);

    Global_TD[12] = TextDrawCreate(156.666687, 439.562957, "LD_SPAC:white");
    TextDrawTextSize(Global_TD[12], 208.000000, 1.169999);
    TextDrawAlignment(Global_TD[12], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[12], -222);
    TextDrawSetShadow(Global_TD[12], 0);
    TextDrawBackgroundColour(Global_TD[12], 255);
    TextDrawFont(Global_TD[12], TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawSetProportional(Global_TD[12], false);

    Global_TD[13] = TextDrawCreate(353.366699, 438.318389, "LD_SPAC:white");
    TextDrawTextSize(Global_TD[13], 11.230005, 0.400000);
    TextDrawAlignment(Global_TD[13], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[13], -188);
    TextDrawSetShadow(Global_TD[13], 0);
    TextDrawBackgroundColour(Global_TD[13], 255);
    TextDrawFont(Global_TD[13], TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawSetProportional(Global_TD[13], false);

    Global_TD[14] = TextDrawCreate(353.399932, 426.274261, "");
    TextDrawTextSize(Global_TD[14], 10.919998, 12.000000);
    TextDrawAlignment(Global_TD[14], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[14], -222);
    TextDrawSetShadow(Global_TD[14], 0);
    TextDrawBackgroundColour(Global_TD[14], 0xFFFFFF00);
    TextDrawFont(Global_TD[14], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(Global_TD[14], false);
    TextDrawSetPreviewModel(Global_TD[14], 1317);
    TextDrawSetPreviewRot(Global_TD[14], 0.000000, 0.000000, 90.000000, 0.200000);

    Global_TD[15] = TextDrawCreate(355.666687, 426.444396, "N");
    TextDrawLetterSize(Global_TD[15], 0.208333, 0.957036);
    TextDrawAlignment(Global_TD[15], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[15], -1);
    TextDrawSetShadow(Global_TD[15], 0);
    TextDrawBackgroundColour(Global_TD[15], 255);
    TextDrawFont(Global_TD[15], TEXT_DRAW_FONT_0);
    TextDrawSetProportional(Global_TD[15], true);

    Global_TD[16] = TextDrawCreate(452.667205, 439.548156, "LD_SPAC:white");
    TextDrawTextSize(Global_TD[16], 131.650192, 1.219998);
    TextDrawAlignment(Global_TD[16], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[16], -222);
    TextDrawSetShadow(Global_TD[16], 0);
    TextDrawBackgroundColour(Global_TD[16], 255);
    TextDrawFont(Global_TD[16], TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawSetProportional(Global_TD[16], false);

    Global_TD[17] = TextDrawCreate(454.733337, 428.148254, "");
    TextDrawTextSize(Global_TD[17], 7.000000, 8.000000);
    TextDrawAlignment(Global_TD[17], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[17], -1);
    TextDrawSetShadow(Global_TD[17], 0);
    TextDrawBackgroundColour(Global_TD[17], 0xFFFFFF00);
    TextDrawFont(Global_TD[17], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(Global_TD[17], false);
    TextDrawSetPreviewModel(Global_TD[17], 1316);
    TextDrawSetPreviewRot(Global_TD[17], 90.000000, 0.000000, 0.000000, 1.000000);

    Global_TD[18] = TextDrawCreate(455.066955, 428.548461, "");
    TextDrawTextSize(Global_TD[18], 6.180004, 7.150002);
    TextDrawAlignment(Global_TD[18], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[18], 404232447);
    TextDrawSetShadow(Global_TD[18], 0);
    TextDrawBackgroundColour(Global_TD[18], 0xFFFFFF00);
    TextDrawFont(Global_TD[18], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(Global_TD[18], false);
    TextDrawSetPreviewModel(Global_TD[18], 1316);
    TextDrawSetPreviewRot(Global_TD[18], 90.000000, 0.000000, 0.000000, 1.000000);

    Global_TD[19] = TextDrawCreate(456.833404, 427.848114, "s");
    TextDrawLetterSize(Global_TD[19], 0.177331, 0.679108);
    TextDrawAlignment(Global_TD[19], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[19], -1);
    TextDrawSetShadow(Global_TD[19], 0);
    TextDrawBackgroundColour(Global_TD[19], 255);
    TextDrawFont(Global_TD[19], TEXT_DRAW_FONT_0);
    TextDrawSetProportional(Global_TD[19], true);

    Global_TD[20] = TextDrawCreate(514.333374, 438.318389, "LD_SPAC:white");
    TextDrawTextSize(Global_TD[20], 11.230005, 0.400000);
    TextDrawAlignment(Global_TD[20], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[20], -188);
    TextDrawSetShadow(Global_TD[20], 0);
    TextDrawBackgroundColour(Global_TD[20], 255);
    TextDrawFont(Global_TD[20], TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawSetProportional(Global_TD[20], false);

    Global_TD[21] = TextDrawCreate(514.367553, 426.274261, "");
    TextDrawTextSize(Global_TD[21], 10.919998, 12.000000);
    TextDrawAlignment(Global_TD[21], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[21], -222);
    TextDrawSetShadow(Global_TD[21], 0);
    TextDrawBackgroundColour(Global_TD[21], 0xFFFFFF00);
    TextDrawFont(Global_TD[21], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(Global_TD[21], false);
    TextDrawSetPreviewModel(Global_TD[21], 1317);
    TextDrawSetPreviewRot(Global_TD[21], 0.000000, 0.000000, 90.000000, 0.200000);

    Global_TD[22] = TextDrawCreate(517.033447, 426.444335, "B");
    TextDrawLetterSize(Global_TD[22], 0.208333, 0.957036);
    TextDrawAlignment(Global_TD[22], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[22], -1);
    TextDrawSetShadow(Global_TD[22], 0);
    TextDrawBackgroundColour(Global_TD[22], 255);
    TextDrawFont(Global_TD[22], TEXT_DRAW_FONT_0);
    TextDrawSetProportional(Global_TD[22], true);

    Global_TD[23] = TextDrawCreate(572.919067, 438.318389, "LD_SPAC:white");
    TextDrawTextSize(Global_TD[23], 11.230005, 0.400000);
    TextDrawAlignment(Global_TD[23], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[23], -188);
    TextDrawSetShadow(Global_TD[23], 0);
    TextDrawBackgroundColour(Global_TD[23], 255);
    TextDrawFont(Global_TD[23], TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawSetProportional(Global_TD[23], false);

    Global_TD[24] = TextDrawCreate(572.953247, 426.274261, "");
    TextDrawTextSize(Global_TD[24], 10.919998, 12.000000);
    TextDrawAlignment(Global_TD[24], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[24], -222);
    TextDrawSetShadow(Global_TD[24], 0);
    TextDrawBackgroundColour(Global_TD[24], 0xFFFFFF00);
    TextDrawFont(Global_TD[24], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(Global_TD[24], false);
    TextDrawSetPreviewModel(Global_TD[24], 1317);
    TextDrawSetPreviewRot(Global_TD[24], 0.000000, 0.000000, 90.000000, 0.200000);

    Global_TD[25] = TextDrawCreate(575.619140, 426.444335, "G");
    TextDrawLetterSize(Global_TD[25], 0.208333, 0.957036);
    TextDrawAlignment(Global_TD[25], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[25], -1);
    TextDrawSetShadow(Global_TD[25], 0);
    TextDrawBackgroundColour(Global_TD[25], 255);
    TextDrawFont(Global_TD[25], TEXT_DRAW_FONT_0);
    TextDrawSetProportional(Global_TD[25], true);

    Global_TD[26] = TextDrawCreate(631.888183, 427.274017, "19:16_~n~~w~18/05/2023");
    TextDrawLetterSize(Global_TD[26], 0.103666, 0.525627);
    TextDrawAlignment(Global_TD[26], TEXT_DRAW_ALIGN_RIGHT);
    TextDrawColour(Global_TD[26], -1);
    TextDrawSetShadow(Global_TD[26], 0);
    TextDrawBackgroundColour(Global_TD[26], 255);
    TextDrawFont(Global_TD[26], TEXT_DRAW_FONT_2);
    TextDrawSetProportional(Global_TD[26], true);

    Global_TD[27] = TextDrawCreate(496.701049, 99.553695, "");
    TextDrawTextSize(Global_TD[27], 63.980003, 14.000000);
    TextDrawAlignment(Global_TD[27], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[27], 136);
    TextDrawSetShadow(Global_TD[27], 0);
    TextDrawBackgroundColour(Global_TD[27], 0xFFFFFF00);
    TextDrawFont(Global_TD[27], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(Global_TD[27], false);
    TextDrawSetPreviewModel(Global_TD[27], 1317);
    TextDrawSetPreviewRot(Global_TD[27], -30.000000, 0.000000, 90.000000, 1.000000);

    Global_TD[28] = TextDrawCreate(541.102111, 117.631446, "");
    TextDrawTextSize(Global_TD[28], 65.000000, -13.000000);
    TextDrawAlignment(Global_TD[28], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[28], 404232342);
    TextDrawSetShadow(Global_TD[28], 0);
    TextDrawBackgroundColour(Global_TD[28], 0xFFFFFF00);
    TextDrawFont(Global_TD[28], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(Global_TD[28], false);
    TextDrawSetPreviewModel(Global_TD[28], 1317);
    TextDrawSetPreviewRot(Global_TD[28], -30.000000, 0.000000, 90.000000, 1.000000);

    Global_TD[29] = TextDrawCreate(529.266418, 105.614746, "HJ:_ON");
    TextDrawLetterSize(Global_TD[29], 0.115331, 0.571259);
    TextDrawAlignment(Global_TD[29], TEXT_DRAW_ALIGN_CENTRE);
    TextDrawColour(Global_TD[29], -1);
    TextDrawSetShadow(Global_TD[29], 1);
    TextDrawBackgroundColour(Global_TD[29], 34);
    TextDrawFont(Global_TD[29], TEXT_DRAW_FONT_2);
    TextDrawSetProportional(Global_TD[29], true);

    Global_TD[30] = TextDrawCreate(572.765075, 105.614753, "HH:_ON");
    TextDrawLetterSize(Global_TD[30], 0.115331, 0.571259);
    TextDrawAlignment(Global_TD[30], TEXT_DRAW_ALIGN_CENTRE);
    TextDrawColour(Global_TD[30], -1);
    TextDrawSetShadow(Global_TD[30], 1);
    TextDrawBackgroundColour(Global_TD[30], 34);
    TextDrawFont(Global_TD[30], TEXT_DRAW_FONT_2);
    TextDrawSetProportional(Global_TD[30], true);

    Global_TD[31] = TextDrawCreate(506.034423, 111.168518, "");
    TextDrawTextSize(Global_TD[31], 63.980003, 14.000000);
    TextDrawAlignment(Global_TD[31], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[31], 404232322);
    TextDrawSetShadow(Global_TD[31], 0);
    TextDrawBackgroundColour(Global_TD[31], 0xFFFFFF00);
    TextDrawFont(Global_TD[31], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(Global_TD[31], false);
    TextDrawSetPreviewModel(Global_TD[31], 1317);
    TextDrawSetPreviewRot(Global_TD[31], -30.000000, 0.000000, 90.000000, 1.000000);

    Global_TD[32] = TextDrawCreate(552.968994, 126.986999, "");
    TextDrawTextSize(Global_TD[32], 52.000000, -11.000000);
    TextDrawAlignment(Global_TD[32], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[32], 404232342);
    TextDrawSetShadow(Global_TD[32], 0);
    TextDrawBackgroundColour(Global_TD[32], 0xFFFFFF00);
    TextDrawFont(Global_TD[32], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(Global_TD[32], false);
    TextDrawSetPreviewModel(Global_TD[32], 1317);
    TextDrawSetPreviewRot(Global_TD[32], -30.000000, 0.000000, 90.000000, 1.000000);

    Global_TD[33] = TextDrawCreate(-36.666633, 424.529602, "LD_SPAC:white");
    TextDrawTextSize(Global_TD[33], 83.000000, 16.190004);
    TextDrawAlignment(Global_TD[33], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[33], 404232447);
    TextDrawSetShadow(Global_TD[33], 0);
    TextDrawBackgroundColour(Global_TD[33], 255);
    TextDrawFont(Global_TD[33], TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawSetProportional(Global_TD[33], false);

    Global_TD[34] = TextDrawCreate(19.333324, 383.977874, "");
    TextDrawTextSize(Global_TD[34], 61.000000, 90.000000);
    TextDrawAlignment(Global_TD[34], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[34], -1916144641);
    TextDrawSetShadow(Global_TD[34], 0);
    TextDrawBackgroundColour(Global_TD[34], -256);
    TextDrawFont(Global_TD[34], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(Global_TD[34], false);
    TextDrawSetPreviewModel(Global_TD[34], 19177);
    TextDrawSetPreviewRot(Global_TD[34], 0.000000, 180.000000, 0.000000, 1.000000);

    Global_TD[35] = TextDrawCreate(15.333323, 391.444580, "");
    TextDrawTextSize(Global_TD[35], 61.000000, 90.000000);
    TextDrawAlignment(Global_TD[35], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[35], -1916144641);
    TextDrawSetShadow(Global_TD[35], 0);
    TextDrawBackgroundColour(Global_TD[35], -256);
    TextDrawFont(Global_TD[35], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(Global_TD[35], false);
    TextDrawSetPreviewModel(Global_TD[35], 19177);
    TextDrawSetPreviewRot(Global_TD[35], 0.000000, 180.000000, 0.000000, 1.000000);

    Global_TD[36] = TextDrawCreate(15.333321, 383.148315, "");
    TextDrawTextSize(Global_TD[36], 61.000000, 90.000000);
    TextDrawAlignment(Global_TD[36], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[36], -1916144641);
    TextDrawSetShadow(Global_TD[36], 0);
    TextDrawBackgroundColour(Global_TD[36], -256);
    TextDrawFont(Global_TD[36], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(Global_TD[36], false);
    TextDrawSetPreviewModel(Global_TD[36], 19177);
    TextDrawSetPreviewRot(Global_TD[36], 0.000000, 0.000000, 0.000000, 1.000000);

    Global_TD[37] = TextDrawCreate(10.999989, 391.029785, "");
    TextDrawTextSize(Global_TD[37], 61.000000, 90.000000);
    TextDrawAlignment(Global_TD[37], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[37], -1916144641);
    TextDrawSetShadow(Global_TD[37], 0);
    TextDrawBackgroundColour(Global_TD[37], -256);
    TextDrawFont(Global_TD[37], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(Global_TD[37], false);
    TextDrawSetPreviewModel(Global_TD[37], 19177);
    TextDrawSetPreviewRot(Global_TD[37], 0.000000, 0.000000, 0.000000, 1.000000);

    Global_TD[38] = TextDrawCreate(31.333381, 438.733428, "particle:lamp_shad_64");
    TextDrawTextSize(Global_TD[38], 22.899997, -14.000000);
    TextDrawAlignment(Global_TD[38], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[38], -1916144819);
    TextDrawSetShadow(Global_TD[38], 0);
    TextDrawBackgroundColour(Global_TD[38], 255);
    TextDrawFont(Global_TD[38], TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawSetProportional(Global_TD[38], false);

    Global_TD[39] = TextDrawCreate(16.666646, 425.044433, "");
    TextDrawTextSize(Global_TD[39], 6.000000, 7.000000);
    TextDrawAlignment(Global_TD[39], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(Global_TD[39], -1);
    TextDrawSetShadow(Global_TD[39], 0);
    TextDrawBackgroundColour(Global_TD[39], -256);
    TextDrawFont(Global_TD[39], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawSetProportional(Global_TD[39], false);
    TextDrawSetPreviewModel(Global_TD[39], 1240);
    TextDrawSetPreviewRot(Global_TD[39], 0.000000, 0.000000, 0.000000, 1.000000);
}
stock CreatePlayerTextDraws(playerid)
{
    Player_TDs[playerid][0] = CreatePlayerTextDraw(playerid, 406.000610, 410.940673, "");
    PlayerTextDrawTextSize(playerid, Player_TDs[playerid][0], 42.000000, 47.000000);
    PlayerTextDrawAlignment(playerid, Player_TDs[playerid][0], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, Player_TDs[playerid][0], -1);
    PlayerTextDrawSetShadow(playerid, Player_TDs[playerid][0], 0);
    PlayerTextDrawFont(playerid, Player_TDs[playerid][0], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid, Player_TDs[playerid][0], false);
    PlayerTextDrawBackgroundColour(playerid, Player_TDs[playerid][0], 0);
    PlayerTextDrawSetPreviewModel(playerid, Player_TDs[playerid][0], 119);
    PlayerTextDrawSetPreviewRot(playerid, Player_TDs[playerid][0], -80.000000, 0.000000, 0.000000, 0.699998);

    Player_TDs[playerid][1] = CreatePlayerTextDraw(playerid, 369.333404, 429.762939, "~w~daddy_corelli");
    PlayerTextDrawLetterSize(playerid, Player_TDs[playerid][1], 0.103666, 0.525627);
    PlayerTextDrawAlignment(playerid, Player_TDs[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, Player_TDs[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, Player_TDs[playerid][1], 0);
    PlayerTextDrawBackgroundColour(playerid, Player_TDs[playerid][1], 255);
    PlayerTextDrawFont(playerid, Player_TDs[playerid][1], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, Player_TDs[playerid][1], true);

    Player_TDs[playerid][2] = CreatePlayerTextDraw(playerid, 508.733978, 429.762939, "~g~~h~$~w~123456789");
    PlayerTextDrawLetterSize(playerid, Player_TDs[playerid][2], 0.103666, 0.525627);
    PlayerTextDrawAlignment(playerid, Player_TDs[playerid][2], TEXT_DRAW_ALIGN_RIGHT);
    PlayerTextDrawColour(playerid, Player_TDs[playerid][2], -1);
    PlayerTextDrawSetShadow(playerid, Player_TDs[playerid][2], 0);
    PlayerTextDrawBackgroundColour(playerid, Player_TDs[playerid][2], 255);
    PlayerTextDrawFont(playerid, Player_TDs[playerid][2], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, Player_TDs[playerid][2], true);

    Player_TDs[playerid][3] = CreatePlayerTextDraw(playerid, 567.320678, 429.762939, "~y~~h~g~w~123456789");
    PlayerTextDrawLetterSize(playerid, Player_TDs[playerid][3], 0.103666, 0.525627);
    PlayerTextDrawAlignment(playerid, Player_TDs[playerid][3], TEXT_DRAW_ALIGN_RIGHT);
    PlayerTextDrawColour(playerid, Player_TDs[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, Player_TDs[playerid][3], 0);
    PlayerTextDrawBackgroundColour(playerid, Player_TDs[playerid][3], 255);
    PlayerTextDrawFont(playerid, Player_TDs[playerid][3], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, Player_TDs[playerid][3], true);

    Player_TDs[playerid][4] = CreatePlayerTextDraw(playerid, 537.799682, 117.685073, "aerodrom");
    PlayerTextDrawLetterSize(playerid, Player_TDs[playerid][4], 0.115331, 0.571259);
    PlayerTextDrawAlignment(playerid, Player_TDs[playerid][4], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, Player_TDs[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, Player_TDs[playerid][4], 1);
    PlayerTextDrawBackgroundColour(playerid, Player_TDs[playerid][4], 34);
    PlayerTextDrawFont(playerid, Player_TDs[playerid][4], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, Player_TDs[playerid][4], true);

    Player_TDs[playerid][5] = CreatePlayerTextDraw(playerid, 578.797912, 117.685073, "wl:_0");
    PlayerTextDrawLetterSize(playerid, Player_TDs[playerid][5], 0.115331, 0.571259);
    PlayerTextDrawAlignment(playerid, Player_TDs[playerid][5], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, Player_TDs[playerid][5], -1);
    PlayerTextDrawSetShadow(playerid, Player_TDs[playerid][5], 1);
    PlayerTextDrawBackgroundColour(playerid, Player_TDs[playerid][5], 34);
    PlayerTextDrawFont(playerid, Player_TDs[playerid][5], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, Player_TDs[playerid][5], true);

    Player_TDs[playerid][6] = CreatePlayerTextDraw(playerid,172.000015, 429.118591, "random....");
    PlayerTextDrawLetterSize(playerid,Player_TDs[playerid][6], 0.113664, 0.596148);
    PlayerTextDrawAlignment(playerid, Player_TDs[playerid][6], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid,Player_TDs[playerid][6], -1);
    PlayerTextDrawSetShadow(playerid,Player_TDs[playerid][6], 0);
    PlayerTextDrawBackgroundColour(playerid,Player_TDs[playerid][6], 255);
    PlayerTextDrawFont(playerid, Player_TDs[playerid][6], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid,Player_TDs[playerid][6], true);

    Player_TDs[playerid][7] = CreatePlayerTextDraw(playerid, 19.000013, 432.251922, "UNSAFE");
    PlayerTextDrawLetterSize(playerid, Player_TDs[playerid][7], 0.113664, 0.596148);
    PlayerTextDrawAlignment(playerid, Player_TDs[playerid][7], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, Player_TDs[playerid][7], -1);
    PlayerTextDrawSetShadow(playerid, Player_TDs[playerid][7], 0);
    PlayerTextDrawBackgroundColour(playerid, Player_TDs[playerid][7], 255);
    PlayerTextDrawFont(playerid, Player_TDs[playerid][7], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, Player_TDs[playerid][7], true);
}

task VremeDatum[1000]()
{
	new dan, godina, mesec;
	getdate(godina, mesec, dan);
	new sati,minuti;
	gettime(sati, minuti);
	new stringic[40];
    format(stringic, sizeof(stringic), "%s%d:%s%d_~n~~w~%d/%s%d/%s%d", (sati < 10) ? ("0") : (""), sati, (minuti < 10) ? ("0") : (""), minuti, dan, ((mesec < 10) ? ("0") : ("")), mesec, (godina < 10) ? ("0") : (""), godina);
    TextDrawSetString(Global_TD[26], stringic);
	return Y_HOOKS_CONTINUE_RETURN_1;
}