--提示：本mod修改自https://steamcommunity.com/sharedfiles/filedetails/?id=2321974509 
--原作者：buzite26 & Efrem4ik 
--修复bug：瑶光


name = "自动整理箱子/Automatic Chest Sorting"
description = "关闭箱子时自动整理，支持大箱子。 \n Automatically sorts loot in chests on closing, with new tall chests supported. \n 注意：模组容器的自动整理，需要在设置里打开“模组支持”。 \n For mod containers, you should turn on \"Add Mod Support\" in mod settings."
author = "󰀜瑶光󰀜 & buzite26 & Efrem4ik"
version = "2.3.1"
api_version = 10
client_only_mod = false
dst_compatible = true
all_clients_require_mod = true
icon_atlas = "modicon.xml"
icon = "modicon.tex"
priority = 3
server_filter_tags = {"gekko auto sort"}

configuration_options = {
    {
        name = "sort_bookstation",
        label = "整理书架/Sort Bookcase",
        hover = "整理书架",
        options = {
            { description = "否/No", data = false },
            { description = "是/Yes", data = true },
        },
        default = false,
    },
    {
        name = "SIB",
        label = "整理冰箱/Sort ice box",
        hover = "堆叠食物时会合并新鲜度",
        options = {
            { description = "否/No", data = false },
            { description = "是/Yes", data = true },
        },
        default = false
    },
    {
        name = "SSB",
        label = "整理盐盒/Sort salt box",
        hover = "堆叠食物时会合并新鲜度",
        options = {
            { description = "否/No", data = false },
            { description = "是/Yes", data = true },
        },
        default = false
    },
    {
        name = "mod_support_enabled",
        label = "模组支持/Add Mod Support",
        hover = "给整理容器的功能添加部分模组支持",
        options = {
            { description = "否/No", data = false },
            { description = "是/Yes", data = true },
        },
        default = true,
    },

}
