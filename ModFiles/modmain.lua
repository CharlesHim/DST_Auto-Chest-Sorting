--提示：本mod修改自https://steamcommunity.com/sharedfiles/filedetails/?id=2321974509 
--原作者：buzite26 & Efrem4ik 
--修复bug：瑶光

--从饥荒历史版本的源码里翻出了旧版的RemoveItemBySlot函数。此处重新定义了它。
local Container = require("components/container")

local function OldRemoveItemBySlot(self,slot)
	if slot and self.slots[slot] then
		local item = self.slots[slot]
		if item then
			self.slots[slot] = nil
			if item.components.inventoryitem then
				item.components.inventoryitem:OnRemoved()
			end

			self.inst:PushEvent("itemlose", {slot = slot, prev_item = item})
		end
		item.prevcontainer = self
		item.prevslot = slot
		return item
		end
end

if not Container.OldRemoveItemBySlot then
	Container.OldRemoveItemBySlot = OldRemoveItemBySlot
end

------------------------------------------------------------

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local RECIPETABS = GLOBAL.RECIPETABS
local Ingredient = GLOBAL.Ingredient
local FOODTYPE = GLOBAL.FOODTYPE
local TECH = GLOBAL.TECH
local TUNING = GLOBAL.TUNING
local TheSim = GLOBAL.TheSim
local Vector3 = GLOBAL.Vector3
local ACTIONS = GLOBAL.ACTIONS
local TheNet = GLOBAL.TheNet

---------------------------------------------------------------

local function stack_up(inst)
	for i = 1,inst.components.container:GetNumSlots() do
		local d_item = inst.components.container:OldRemoveItemBySlot(i)
        if d_item ~= nil then inst.components.container:GiveItem(d_item) end
    end
end

function compare(a,b)
	if a ~= nil and b ~= nil then
		if a.prefab == b.prefab then
			if a.components.stackable ~= nil and b.components.stackable ~= nil then
                return a.components.stackable:StackSize() > b.components.stackable:StackSize()
            end
			return false 
		end
		return a.prefab < b.prefab
	end
	return true
end

local function sort_up(inst)
	table.sort(inst.components.container.slots, compare)
end

function sync_conainer(inst)
	for i = 1,inst.components.container:GetNumSlots() do
		local item = inst.components.container.slots[i]
		if item ~= nil then
			inst:PushEvent("itemget", { slot = i, item = item})
		end
    end
end

--------------------------------------------------------------------------

local function sort_fn(inst)		--新定义的函数
	stack_up(inst)
	sort_up(inst)
	sync_conainer(inst)
end

local function onopen(inst, old_open)
	sort_fn(inst)
	if old_open then
		old_open(inst)
	else
		print("\n\n ERROR! old_open is nil!!! \n\n")
	end
end


if GetModConfigData("sort_chest") then
	AddPrefabPostInit("treasurechest", function(inst)
		if not GLOBAL.TheWorld.ismastersim then return inst end

		local old_open = inst.components.container.onopenfn
		inst.components.container.onopenfn = function(inst)
			onopen(inst, old_open)
		end

	end)
end

if GetModConfigData("sort_dragonflychest") then
	AddPrefabPostInit("dragonflychest", function(inst)
		if not GLOBAL.TheWorld.ismastersim then return inst end

		local old_open = inst.components.container.onopenfn
		inst.components.container.onopenfn = function(inst)
			onopen(inst, old_open)
		end

	end)
end

if GetModConfigData("SIB") then
	AddPrefabPostInit("icebox", function(inst)
		if not GLOBAL.TheWorld.ismastersim then return inst end

		local old_open = inst.components.container.onopenfn
		inst.components.container.onopenfn = function(inst)
			onopen(inst, old_open)
		end

	end)
end

if GetModConfigData("SSB") then
	AddPrefabPostInit("saltbox", function(inst)
		if not GLOBAL.TheWorld.ismastersim then return inst end

		local old_open = inst.components.container.onopenfn
		inst.components.container.onopenfn = function(inst)
			onopen(inst, old_open)
		end

	end)
end

if GetModConfigData("sort_bookstation") then
	AddPrefabPostInit("bookstation", function(inst)
		if not GLOBAL.TheWorld.ismastersim then return inst end

		local old_open = inst.components.container.onopenfn
		inst.components.container.onopenfn = function(inst)
			onopen(inst, old_open)
		end

	end)
end

if GetModConfigData("mod_support_enabled") then

	local mod_prefab_list = 
	{
		"storeroom",		--储藏室
		"cellar",			--地窖
		"medal_livingroot_chest",	--勋章 树根宝箱
		"bearger_chest",	--勋章 熊皮宝箱
		"hclr_supermu1",	--懈怠科技 四个升级版箱子冰箱
		"hclr_supermu2",
		"hclr_superice1",
		"hclr_superice2",
		"mo_chester",
		"mo_icebox",
		"lg_chest",			--海洋传说 雨花·银龙宝箱
		"venus_icebox",		--泰拉虚空异界 萝卜冰箱	
		"sora2ice",			--小穹 寒冰箱子
		"hiddenmoonlight",	--棱镜 月藏宝匣
		"chest_whitewood",	--棱镜 白木展示台
		"chest_whitewood_big",		--棱镜 白木展示柜
		"chest_whitewood_big_inf",	--棱镜 白木展示柜·无限
		"hiddenmoonlight_inf",		--棱镜 月藏宝匣·无限
		"xd_wsjx",			--登仙 无双剑匣
		"xd_dbg",			--登仙 多宝格
		"xd_hhlmz",			--登仙 黄花梨木桌
		"xd_crc",			--登仙 储肉仓
		"xd_sgc",			--登仙 蔬果仓
		"xd_lgzbh",			--登仙 流光珠宝盒
		"xd_gjx",			--登仙 工具匣
		"xd_mg",			--登仙 蜜罐
		"xd_mglz",			--登仙 蘑菇篓子
		"xd_lbx",			--登仙 灵宝箱 
		----- 在下面添加模组容器预制件名称，注意使用英文引号与逗号 -----




		----- 在上面添加模组容器预制件名称，注意使用英文引号与逗号 -----
	}

	for _, v in pairs(mod_prefab_list) do
		AddPrefabPostInit(v,function(inst)
			if not GLOBAL.TheWorld.ismastersim then return inst end

			local old_open = inst.components.container.onopenfn
			inst.components.container.onopenfn = function(inst)
				onopen(inst, old_open)
			end
			
		end)
	end
end


	
