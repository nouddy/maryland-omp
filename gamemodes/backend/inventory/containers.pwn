/*
 *
 *  ##     ##    ###    ########  ##    ## ##          ###    ##    ## ########  
 *  ###   ###   ## ##   ##     ##  ##  ##  ##         ## ##   ###   ## ##     ## 
 *  #### ####  ##   ##  ##     ##   ####   ##        ##   ##  ####  ## ##     ## 
 *  ## ### ## ##     ## ########     ##    ##       ##     ## ## ## ## ##     ## 
 *  ##     ## ######### ##   ##      ##    ##       ######### ##  #### ##     ## 
 *  ##     ## ##     ## ##    ##     ##    ##       ##     ## ##   ### ##     ## 
 *  ##     ## ##     ## ##     ##    ##    ######## ##     ## ##    ## ########   
 *
 *  @Author         Nodi
 *  @Github         (github.com/vosticdev) & (github.com/nouddy)
 *  @Date           03 Nov 2024
 *  @Weburl         https://maryland-ogc.com
 *  @Project        maryland_project
 *
 *  @File           main.pwn
 *  @Module         inventory
 */

#include <ysilib\YSI_Coding\y_hooks>


//*==============================================================================
//*--->>> Begining
//*==============================================================================

#define MAX_P_CONTAINERS      (1000)

#define CONTAINER_FLOOR_ID     (0)

enum {

    CONTAINER_TYPE_TRUNK,
    CONTAINER_TYPE_WARDROBE,
    CONTAINER_TYPE_FLOOR
}

enum e_CONTAINER_INFO {

    containerID,
    containerType,
    containerItem,
    containerItemType,
    containerItemQuantity,
    containerModel,

    Float:containerPos[3] // * Only used for dropped items
}

new ContainerData[MAX_P_CONTAINERS][e_CONTAINER_INFO],
    Iterator:iter_Containers<MAX_P_CONTAINERS>,
    Text3D:containerLabel[MAX_P_CONTAINERS],
    containerObject[MAX_P_CONTAINERS];

//*==============================================================================
//*--->>> Querys
//*==============================================================================

forward mysql_LoadContainerData();
public mysql_LoadContainerData() {

    new rows = cache_num_rows();

    if(!rows) return print("No containers loaded.");

    for(new i = 0; i < rows; i++) {

        cache_get_value_name_int(i, "ID", ContainerData[i][containerID]);
        cache_get_value_name_int(i, "Type", ContainerData[i][containerType]);
        cache_get_value_name_int(i, "Item", ContainerData[i][containerItem]);
        cache_get_value_name_int(i, "ItemType", ContainerData[i][containerItemType]);
        cache_get_value_name_int(i, "Quantity", ContainerData[i][containerItemQuantity]);
        cache_get_value_name_int(i, "Model", ContainerData[i][containerModel]);

        cache_get_value_name_float(i, "posX", ContainerData[i][containerPos][0]);
        cache_get_value_name_float(i, "posY", ContainerData[i][containerPos][1]);
        cache_get_value_name_float(i, "posZ", ContainerData[i][containerPos][2]);

        Iter_Add(iter_Containers, i);

        if(ContainerData[i][containerPos][0] != 0.00) {
            
            new tmp_str[64];
            format(tmp_str, sizeof tmp_str, ""c_server"\187; "c_white"%s "c_server"\171;\n"c_server"\187; "c_white"[ N ]"c_server" \171;", Inventory_ReturnItemName( ContainerData[i][containerItem]));

            containerLabel[i] = Create3DTextLabel("", -1, ContainerData[i][containerPos][0], ContainerData[i][containerPos][1], ContainerData[i][containerPos][2], 
                                                          4.50, 0);
            containerObject[i] = CreateObject(ContainerData[i][containerModel], ContainerData[i][containerPos][0], ContainerData[i][containerPos][1], ContainerData[i][containerPos][2], 
                                              0.00, 0.00, 0.00, 45.00);
        }
    }

    return true;
}

//*==============================================================================
//*--->>> Hooks
//*==============================================================================

hook OnGameModeInit() {

    mysql_tquery(SQL, "SELECT * FROM `inv_containers`", "mysql_LoadContainerData");

    return Y_HOOKS_CONTINUE_RETURN_1;
}

//*==============================================================================
//*--->>> Dialogs
//*==============================================================================