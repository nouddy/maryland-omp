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
 *  @File           db-config.script
 *  @Module         database
 */

#include <ysilib\YSI_Coding\y_hooks>

new MySQL:SQL;
new MYSQL_DB_ML[32];

stock file_ReadValue(szParse[], const szValueName[], szDest[], iDestLen) { // brian!!1

    new
        iPos = strfind(szParse, "=", false),
        iLength = strlen(szParse);
        
    while(iLength-- && szParse[iLength] <= ' ') {
        szParse[iLength] = 0;
    }

    if(strcmp(szParse, szValueName, false, iPos) == 0) {
        strmid(szDest, szParse, iPos + 1, iLength + 1, iDestLen);
        return 1;
    }
    return 0;
}

hook OnGameModeInit(){

	// ? Dodan mysql_connect_file ( SIGURNIJE );

	new File: fileHandle = fopen("mysql.cfg", io_read);
	new fileString[128],
		MYSQL_HOST[20], MYSQL_USER[20], MYSQL_PASS[32];

	while(fread(fileHandle, fileString, sizeof(fileString))) 
    {
        if(file_ReadValue(fileString, "HOST", MYSQL_HOST, sizeof(MYSQL_HOST))) continue;
        if(file_ReadValue(fileString, "USER", MYSQL_USER, sizeof(MYSQL_USER))) continue;
        if(file_ReadValue(fileString, "PASS", MYSQL_PASS, sizeof(MYSQL_PASS))) continue;
        if(file_ReadValue(fileString, "DB",   MYSQL_DB_ML,   sizeof(MYSQL_DB_ML))) continue;
    }
    fclose(fileHandle);


	SQL = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DB_ML);

	if(SQL == MYSQL_INVALID_HANDLE || mysql_errno(SQL) != 0)
	{
		print("MySQL \187; Niste se uspjeli konektovati na data bazu, gasim server.");
		SendRconCommand("exit");
		return 1;
	}
	print("MySQL \187; Uspjesno smo se konektovali na SQL server.");
	print("database/db-config.script loaded");
	//****************************************************************************//
	return 1;
}

hook OnGameModeExit(){
	mysql_close(SQL);
	return 1;
}