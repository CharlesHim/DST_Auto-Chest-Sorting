# 介绍

这是游戏饥荒联机版的自动整理箱子模组。  

主要功能与特性：
- 在关上箱子时，自动合并堆叠、整理物品顺序。  
- 支持新更新的大箱子，也可以选择是否整理冰箱和盐盒。  
- 理论上兼容修改箱子容量、修改堆叠数量之类的模组。  
- 特别为 地窖/Storm Cellar 和 储藏室/Storeroom 添加了支持。  
- 还有其它模组容器支持，包括但不限于棱镜、勋章、海洋传说、怠惰科技等，详见改动日志。  

> 别忘了在配置选项中打开“**模组支持**”功能！  

## English

This is a QoL Mod for *Don't Starve Together* which automatically sorts loot in chests on closing.   

- Works well with Chest Size Tweak、Stack Size Tweak. Tall chests  are supported.  
- Added support for *Storm Cellar* and *Storeroom*.  
- And more Mod containers are supported! See change log for detail.   
 
> Don't forget to turn "**Add Mod Support**" on in the configuration options!  

## 关于模组容器整理

如果内置的模组容器支持没有覆盖到你正在使用的模组，你可以按以下方法手动添加：  
> `modmain.lua` 的末尾预留有模组物品的清单在这里写入容器预制件的名称即可。  
> 别忘了打开设置里的“**模组支持**”选项！  
```
local mod_prefab_list = 
{
	"storeroom",			--储藏室
	"cellar",			--地窖
	"medal_livingroot_chest",	--勋章的树根宝箱
	"bearger_chest",		--勋章的熊皮宝箱
	-- （篇幅原因 此处省略部分内置列表）
	----- 在下面添加模组容器预制件名称，注意使用英文引号与逗号 -----



	----- 在上面添加模组容器预制件名称，注意使用英文引号与逗号 -----
}
```  

**注意**：模组的更新会导致手动写入的内容被覆盖，请自行备份.也可以分享到 Steam 创意工坊讨论区，或者发 PR，让作者写进模组。  


> 修改自 Automatic Chest Sorting，修复了一些问题，并添加了中文翻译与指南。  
> 原作者：buzite26 & Efrem4ik  
> 代码与图标资源托管于GitHub：CharlesHim/DST_Auto-Chest-Sorting  