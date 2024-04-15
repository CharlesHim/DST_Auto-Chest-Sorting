--提示：本mod修改自https://steamcommunity.com/sharedfiles/filedetails/?id=2321974509 
--原作者：buzite26 & Efrem4ik 
--修复bug：瑶光


name = "自动整理箱子/Automatic chest sorting"
description = "关闭箱子时自动整理，支持大箱子/Automatically sorts loot in chests on closing, with new tall chests supported"
author = "󰀜瑶光󰀜 & buzite26 & Efrem4ik"
version = "2.0.0"
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
        name = "SIB",
        label = "Sort ice box",
        options = {
            { description = "No", data = false },
            { description = "Yes", data = true },
        },
        default = false
    },
    {
        name = "SSB",
        label = "Sort salt box",
        options = {
            { description = "No", data = false },
            { description = "Yes", data = true },
        },
        default = false
    },
}
