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

 new MySQL: SQL;

hook OnGameModeInit()
{
    mysql_log(ALL);

	SQL = mysql_connect_file("mysql.ini");

    if(mysql_errno(SQL) != 0)
    {
        printf("[MYSQL] Database connection failed, check mysql.ini!");
    }
    else
    {
        printf("[MYSQL] Connected to database succesfully");
    }
    return (true);
}

hook OnGameModeExit()
{
    if(SQL)
    {
        mysql_close(SQL);
    }
    return (true);
}