#define MIXED_SPELLINGS

#include <open.mp>
#include <mSelection>

new skinlist = mS_INVALID_LISTID;

main() { return 1; }

public OnGameModeInit() {

    skinlist = LoadModelSelectionMenu("skins.txt");

    return 1;

}

public OnPlayerCommandText(playerid, cmdtext[]) {

    if (!strcmp(cmdtext, "/radimribara", true))
    {
        ShowModelSelectionMenu( playerid, skinlist, "Select Skin");
        return 1;
    }
    return 0;
}