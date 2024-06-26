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

--состаковать все --我看不懂，这句注释是俄语吗？我的翻译机也翻译不了，管它呢，先留着吧
local function stack_up(inst)
	for i = 1,inst.components.container:GetNumSlots() do
		-- local d_item = inst.components.container:RemoveItemBySlot(i)	--根据上面定义的函数修改了此处调用
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

function sync_conainer(inst)
	for i = 1,inst.components.container:GetNumSlots() do
		local item = inst.components.container.slots[i]
		if item ~= nil then
			inst:PushEvent("itemget", { slot = i, item = item})
		end
    end
end

--отсортировать все --我看不懂，这句注释是俄语吗？我的翻译机也翻译不了，管它呢，先留着吧
local function sort_up(inst)
	table.sort(inst.components.container.slots, compare)
end

local old_open = nil
local function onopen(inst)
	stack_up(inst)
	sort_up(inst)
	sync_conainer(inst)
	if old_open then old_open(inst) end
end

AddPrefabPostInit("treasurechest", function(inst)
    if not GLOBAL.TheWorld.ismastersim then return inst end
	old_open = inst.components.container.onopenfn
	inst.components.container.onopenfn = onopen
end)
AddPrefabPostInit("dragonflychest", function(inst)
    if not GLOBAL.TheWorld.ismastersim then return inst end
	old_open = inst.components.container.onopenfn
	inst.components.container.onopenfn = onopen
end)

if GetModConfigData("SIB") then
	AddPrefabPostInit("icebox", function(inst)
		if not GLOBAL.TheWorld.ismastersim then return inst end
		old_open = inst.components.container.onopenfn
		inst.components.container.onopenfn = onopen
	end)
end

if GetModConfigData("SSB") then
	AddPrefabPostInit("saltbox", function(inst)
		if not GLOBAL.TheWorld.ismastersim then return inst end
		old_open = inst.components.container.onopenfn
		inst.components.container.onopenfn = onopen
	end)
end

if GetModConfigData("sort_bookstation") then
	AddPrefabPostInit("bookstation", function(inst)
		if not GLOBAL.TheWorld.ismastersim then return inst end
		old_open = inst.components.container.onopenfn
		inst.components.container.onopenfn = onopen
	end)
end

if GetModConfigData("mod_support_enabled") then

	local mod_prefab_list = 
	{
		"storeroom",		--储藏室
		"cellar",			--地窖
		"medal_livingroot_chest",	--勋章的树根宝箱
		"bearger_chest",	--勋章的熊皮宝箱
		"hclr_supermu1",	--懈怠科技升级版的四个箱子冰箱
		"hclr_supermu2",
		"hclr_superice1",
		"hclr_superice2",
		"mo_chester",
		"mo_icebox",
		"lg_chest",			--海洋传说的 雨花·银龙宝箱
		"venus_icebox",		--泰拉：虚空异界的 萝卜冰箱	
		"sora2ice",			--小穹 寒冰箱子
		"hiddenmoonlight",	--棱镜 月藏宝匣
		"chest_whitewood",	--棱镜 白木展示台
		"chest_whitewood_big",		--棱镜 白木展示柜
		"chest_whitewood_big_inf",	--棱镜 白木展示柜·无限
		"hiddenmoonlight_inf",		--棱镜 月藏宝匣·无限
		----- 在下面添加模组容器预制件名称，注意使用英文引号与逗号 -----




		----- 在上面添加模组容器预制件名称，注意使用英文引号与逗号 -----
	}

	for _, v in pairs(mod_prefab_list) do
		AddPrefabPostInit(v,function(inst)
			if not GLOBAL.TheWorld.ismastersim then 
				return inst 
			end
			old_open = inst.components.container.onopenfn
			inst.components.container.onopenfn = onopen
		end)
	end
end


	
