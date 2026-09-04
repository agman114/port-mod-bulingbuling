local GLOBAL = _G
local function SendBulingRPC(rpc_name, ...)
	local rpc = (TheSim and TheSim.GetModRPC and TheSim:GetModRPC("bulingbuling", rpc_name))
		or (GLOBAL and GLOBAL.GetModRPC and GLOBAL.GetModRPC("bulingbuling", rpc_name))
		or (GLOBAL and GLOBAL.MOD_RPC and GLOBAL.MOD_RPC["bulingbuling"] and GLOBAL.MOD_RPC["bulingbuling"][rpc_name])
	if rpc then
		SendModRPCToServer(rpc, ...)
	end
end

local assets ={
	Asset("ANIM", "anim/buling_food.zip"),
	Asset("ATLAS", "images/inventoryimages/buling_cooktable.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_aoliao.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_baojiangdangao.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_bingkaxianbing.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_flour.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_hongguzhou.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_jianbingguozi.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_jiangguomusi.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_kaodigua.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_kaolengmian.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_languzhou.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_luobubao.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_lvguzhou.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_mapodoufu.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_qiancengbing.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_sangubao.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_sanmingzhi.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_suroudacan.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_tianmishala.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_xiangcaobuding.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_xiangjiaoxianbing.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_xiguazhi.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_bread.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_cook_guo.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_cook_kaopan.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_cook_jiaobanbo.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_cook_caidao.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_xifan.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_fangxingjiaotang.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_fanshujianbing.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_fanshuni.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_fanshuzhou.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_fengmibuding.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_fengmimianbao.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_guodongjuan.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_guojiangtongxinfen.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_honggumianbao.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_huluobotang.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_jiangguodangao.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_jiangguosanmingzhi.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_kafeitang.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_luobodangao.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_luobogao.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_mianbaopian.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_moguhanbao.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_mogutang.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_nailaotongxinfen.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_pisa.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_qiaokelipai.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_qiaokelixianbing.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_qieheshutiao.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_shucaishala.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_shucaizahui.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_suanrongguhe.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_suanrongmianbao.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_tianshuni.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_zhaluobowanzi.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_zhawanzi.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_shucaisui.xml"), 
	Asset("ATLAS", "images/inventoryimages/buling_cream.xml"), 

}
	--[[["buling_cook_kao"]={"cutstone,nil,cutstone,cutstone,cutstone,cutstone,charcoal,torch,charcoal,"},
	["buling_cook_guo"]={"nil,nil,nil,buling_zhongziding,nil,buling_zhongziding,buling_zhongziding,buling_zhongziding,buling_zhongziding,"},
	["buling_cook_jiaobanbo"]={"boards,boards,boards,nil,nil,nil,boards,boards,boards,"},
	["buling_bread"]={"nil,nil,nil,nil,buling_flour,nil,nil,buling_cook_kao,nil,"},
	["buling_xifan"]={"nil,nil,nil,nil,buling_flour,nil,nil,buling_cook_guo,nil,"},
	["buling_baojiangdangao"]={"nil,berries_cooked,nil,buling_bread,honey,buling_bread,nil,buling_cook_kao,nil,"},
	["buling_jianbingguozi"]={"bird_egg,plantmeat,bird_egg,buling_flour,buling_flour,buling_flour,nil,buling_cook_kao,nil,"},
	["buling_kaodigua"]={"nil,nil,nil,nil,sweet_potato,nil,nil,buling_cook_kao,nil,"},
	["buling_bingkaxianbing"]={"nil,ratatouille,nil,buling_flour,buling_flour,buling_flour,nil,buling_cook_kao,nil,"},
	["buling_kaolengmian"]={"nil,bird_egg,nil,nil,buling_flour,nil,nil,buling_cook_kao,nil,"},
	["buling_sanmingzhi"]={"nil,buling_bread,nil,cactus_meat,flowersalad,cactus_meat,nil,buling_bread,nil,"},
	["buling_qiancengbing"]={"buling_flour,buling_flour,buling_flour,plantmeat,honey,plantmeat,buling_flour,buling_cook_kao,buling_flour,"},
	["buling_xiangcaobuding"]={"tallbirdegg,petals,goatmilk,buling_flour,honey,buling_flour,nil,buling_cook_zheng,nil,"},
	["buling_jiangguomusi"]={"nil,berries,nil,coconut_cooked,nil,coconut_cooked,nil,nil,nil,"},
	["buling_luobubao"]={"carrot,carrot,carrot,nil,buling_xifan,nil,nil,buling_cook_guo,nil,"},
	["buling_aoliao"]={"buling_flour,coffeebeans_cooked,buling_flour,buling_flour,coffeebeans_cooked,buling_flour,nil,buling_cook_kao,nil,"},
	["buling_sangubao"]={"red_cap,green_cap,blue_cap,nil,buling_xifan,nil,nil,buling_cook_zheng,nil,"},
	["buling_lvguzhou"]={"nil,green_cap,nil,nil,buling_xifan,nil,nil,buling_cook_guo,nil,"},
	["buling_languzhou"]={"nil,blue_cap,nil,nil,buling_xifan,nil,nil,buling_cook_guo,nil,"},
	["buling_hongguzhou"]={"nil,red_cap,nil,nil,buling_xifan,nil,nil,buling_cook_guo,nil,"},]]
local cookhechengbiao ={

	["buling_cook_kaopan"]={"nil,nil,nil,goldnugget,goldnugget,goldnugget,nil,nil,nil,"},
	["buling_cook_guo"]={"nil,nil,nil,rocks,nil,rocks,rocks,rocks,rocks,"},
	["buling_cook_caidao"]={"nil,nil,nil,flint,flint,twigs,flint,flint,flint,"},
	["buling_bread"] = {"nil,nil,nil,nil,buling_flour,nil,nil,buling_cook_kaopan,nil,"},
	["buling_xifan"] = {"nil,nil,nil,nil,buling_flour,nil,nil,buling_cook_guo,nil,"},
	["buling_hongguzhou"] = {"nil,red_cap,nil,nil,buling_xifan,nil,nil,buling_cook_guo,nil,"},
	["buling_languzhou"] = {"nil,blue_cap,nil,nil,buling_xifan,nil,nil,buling_cook_guo,nil,"},
	["buling_lvguzhou"] = {"nil,green_cap,nil,nil,buling_xifan,nil,nil,buling_cook_guo,nil,"},
	["buling_honggumianbao"] = {"nil,red_cap,nil,nil,buling_bread,nil,nil,buling_cook_caidao,nil,"},
	["buling_suanrongguhe"] = {"nil,nil,nil,red_cap,green_cap,blue_cap,nil,buling_cook_kaopan,nil,"},
	["buling_sangubao"] = {"red_cap,green_cap,blue_cap,nil,buling_xifan,nil,nil,buling_cook_guo,nil,"},
	["buling_moguhanbao"] = {"buling_bread,nil,buling_bread,red_cap,green_cap,blue_cap,nil,buling_cook_caidao,nil,"},
	["buling_mogutang"] = {"nil,nil,nil,red_cap,green_cap,blue_cap,nil,buling_cook_guo,nil,"},
	["buling_luobubao"] = {"carrot,carrot,carrot,nil,buling_xifan,nil,nil,buling_cook_guo,nil,"},
	["buling_zhaluobowanzi"] = {"nil,buling_flour,nil,buling_flour,carrot,buling_flour,nil,buling_cook_kaopan,nil,"},
	["buling_huluobotang"] = {"nil,nil,nil,carrot,carrot,carrot,nil,buling_cook_guo,nil,"},
	["buling_luobodangao"] = {"nil,nil,nil,carrot,buling_bread,carrot,nil,buling_cook_kaopan,nil,"},
	["buling_luobogao"] = {"nil,nil,nil,radish,buling_flour,radish,nil,buling_cook_kaopan,nil,"},
	["buling_jiangguomusi"] = {"nil,buling_cream,nil,buling_flour,berries,buling_flour,nil,buling_cook_kaopan,nil,"},
	["buling_jiangguodangao"] = {"berries,berries,berries,buling_flour,buling_bread,buling_flour,nil,buling_cook_kaopan,nil,"},
	["buling_jiangguosanmingzhi"] = {"berries,buling_bread,berries,berries,buling_bread,berries,nil,buling_cook_caidao,nil,"},
	["buling_guodongjuan"] = {"bird_egg,buling_cream,bird_egg,berries,buling_flour,berries,nil,buling_cook_kaopan,nil,"},
	["buling_guojiangtongxinfen"] = {"nil,jammypreserves,nil,buling_flour,berries,buling_flour,nil,buling_cook_guo,nil,"},
	["buling_nailaotongxinfen"] = {"nil,goatmilk,nil,buling_flour,goatmilk,buling_flour,nil,buling_cook_guo,nil,"},
	["buling_baojiangdangao"] = {"nil,buling_flour,nil,buling_shucaisui,buling_bread,buling_shucaisui,nil,buling_cook_kaopan,nil,"},
	["buling_kafeitang"] = {"coffeebeans,coffeebeans,coffeebeans,honey,coffeebeans,honey,nil,buling_cook_kaopan,nil,"},
	["buling_aoliao"] = {"coffeebeans,coffeebeans,coffeebeans,nil,buling_flour,nil,nil,buling_cook_kaopan,nil,"},
	["buling_bingkaxianbing"] = {"nil,buling_flour,nil,buling_shucaisui,buling_flour,buling_shucaisui,nil,buling_cook_kaopan,nil,"},
	["buling_kaolengmian"] = {"nil,buling_flour,nil,buling_shucaisui,buling_flour,buling_shucaisui,buling_cook_kaopan,nil,buling_cook_caidao,"},
	["buling_sanmingzhi"] = {"nil,buling_bread,nil,cactus_meat,buling_bread,cactus_meat,nil,buling_cook_caidao,nil,"},
	["buling_jianbingguozi"] = {"nil,bird_egg,nil,buling_shucaisui,buling_flour,buling_shucaisui,buling_cook_kaopan,nil,buling_cook_caidao,"},
	["buling_qiancengbing"] = {"buling_flour,plantmeat,buling_flour,buling_shucaisui,buling_flour,buling_shucaisui,nil,buling_cook_kaopan,nil,"},
	["buling_xiangcaobuding"] = {"petals,buling_cream,petals,bird_egg,buling_flour,bird_egg,nil,buling_cook_kaopan,nil,"},
	["buling_tianmishala"] = {"nil,honey,nil,buling_shucaisui,buling_shucaisui,buling_shucaisui,nil,buling_cook_caidao,nil,"},
	["buling_xiangjiaoxianbing"] = {"nil,buling_flour,nil,buling_flour,cave_banana,buling_flour,nil,buling_cook_kaopan,nil,"},
	["buling_xiguazhi"] = {"nil,nil,nil,nil,watermelon,nil,nil,buling_cook_caidao,nil,"},
	["buling_suroudacan"] = {"nil,buling_shucaisui,nil,buling_shucaisui,plantmeat,buling_shucaisui,nil,buling_cook_kaopan,nil,"},
	["buling_fangxingjiaotang"] = {"nil,nil,nil,honey,honey,honey,nil,buling_cook_kaopan,nil,"},
	["buling_kaodigua"] = {"nil,nil,nil,nil,sweet_potato,nil,nil,buling_cook_kaopan,nil,"},
	["buling_fanshujianbing"] = {"nil,nil,nil,buling_flour,sweet_potato,buling_flour,nil,buling_cook_kaopan,nil,"},
	["buling_fanshuni"] = {"nil,nil,nil,nil,sweet_potato,nil,nil,buling_cook_guo,nil,"},
	["buling_fanshuzhou"] = {"nil,sweet_potato,nil,nil,buling_xifan,nil,nil,buling_cook_guo,nil,"},
	["buling_tianshuni"] = {"nil,nil,nil,honey,sweet_potato,honey,nil,buling_cook_guo,nil,"},
	["buling_fengmibuding"] = {"honey,buling_cream,honey,bird_egg,buling_flour,bird_egg,nil,buling_cook_kaopan,nil,"},
	["buling_fengmimianbao"] = {"nil,nil,nil,honey,buling_bread,honey,nil,buling_cook_caidao,nil,"},
	["buling_mianbaopian"] = {"nil,jammypreserves,nil,nil,buling_bread,nil,nil,buling_cook_caidao,nil,"},
	["buling_pisa"] = {"nil,dragonfruit,nil,buling_flour,buling_shucaisui,buling_flour,nil,buling_cook_kaopan,nil,"},
	["buling_qiaokelipai"] = {"buling_flour,coffeebeans,buling_flour,bird_egg,buling_cream,bird_egg,nil,buling_cook_kaopan,nil,"},
	["buling_qiaokelixianbing"] = {"buling_flour,coffeebeans,buling_flour,bird_egg,buling_flour,bird_egg,nil,buling_cook_kaopan,nil,"},
	["buling_qieheshutiao"] = {"eggplant,buling_shucaisui,eggplant,buling_flour,sweet_potato,buling_flour,nil,buling_cook_kaopan,nil,"},
	["buling_shucaishala"] = {"buling_cream,buling_shucaisui,buling_cream,buling_shucaisui,buling_shucaisui,buling_shucaisui,nil,buling_cook_guo,nil,"},
	["buling_suanrongmianbao"] = {"nil,buling_shucaisui,nil,nil,buling_bread,nil,nil,buling_cook_caidao,nil,"},
	["buling_zhawanzi"] = {"buling_shucaisui,buling_flour,buling_shucaisui,buling_flour,buling_shucaisui,buling_flour,nil,buling_cook_kaopan,nil,"},
}
GLOBAL.BULING_COOKHECHENGBIAO = cookhechengbiao
local seg_time = 30
local total_day_time = seg_time*16
local slotpos = {}
for y = 2, 0, -1 do
	for x = 0, 2 do
		table.insert(slotpos, Vector3(80*x-80*2+80, 80*y-80*2+80,0))
	end
end
local function cooktable(inst, doer)
	local widgetbuttoninfo = {
	text = "Cook",
	position = Vector3(0, -140, 0),
	fn = function(inst, doer)
		if not TheWorld.ismastersim then
			SendBulingRPC("do_widget_button", inst)
			return
		end
		local peifang = ""
		local slots = inst.components.container and inst.components.container.slots
		for k=1,9 do
			local item = inst.components.container:GetItemInSlot(k)
			if item == nil then
				item = "nil"
			else
				item = item.prefab
			end
			peifang = peifang..item..","
		end
		print("[BULING COOKTABLE] Slots pattern: '" .. tostring(peifang) .. "'")
		local matched_recipe = nil
		for recipe_name, recipe_data in pairs(cookhechengbiao) do
			if recipe_data[1] == peifang then
				matched_recipe = recipe_name
				break
			end
		end
		local opener = doer or (inst.components.container and inst.components.container.openers and next(inst.components.container.openers)) or inst.components.container.opener or inst
		local player_talker = (doer and doer.components and doer.components.talker and doer) or (opener and opener.components and opener.components.talker and opener)
		if matched_recipe then
			print("[BULING COOKTABLE] MATCH FOUND: " .. tostring(matched_recipe))
			local _crafted = SpawnPrefab(matched_recipe)
			if _crafted then
				local player_doer = (doer and doer.components and doer.components.inventory and doer) or (opener and opener.components and opener.components.inventory and opener)
				if player_doer then
					player_doer.components.inventory:GiveItem(_crafted, nil, inst:GetPosition())
				else
					_crafted.Transform:SetPosition(inst.Transform:GetWorldPosition())
				end
			end
			for slot_i=1,9 do
				local item = inst.components.container:GetItemInSlot(slot_i)
				if item ~= nil then
					if item.components.stackable and item.components.stackable.stacksize > 1 then
						item.components.stackable:SetStackSize(item.components.stackable.stacksize - 1)
					elseif not item:HasTag("buling_cook_tool") then
						item:Remove()
					end
				end
			end
			if player_talker then
				player_talker.components.talker:Say("Cooking successful! / Приготовлено!")
			end
		else
			print("[BULING COOKTABLE] NO MATCH FOUND for pattern: '" .. tostring(peifang) .. "'")
			if player_talker then
				player_talker.components.talker:Say("No recipe matches these ingredients! / Нет подходящего рецепта!")
			end
		end
	end}
	local function OnOpen(inst, doer)
		local _target = doer or inst
		if _target and _target.PushEvent then _target:PushEvent("OpenBuling_food") end
	end
	local function OnClose(inst, doer)
		local _target = doer or inst
		if _target and _target.PushEvent then _target:PushEvent("CloseBuling_food") end
	end
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, .5)

	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
	inst.AnimState:PlayAnimation("cooktable")
	inst:AddTag("structure")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

    inst:AddComponent("inspectable")
	inst:AddComponent("container")
	inst.components.container:SetNumSlots(#slotpos)
	inst.components.container.widgetslotpos = slotpos
	inst.components.container.widget = { slotpos = inst.components.container.widgetslotpos, animbank = inst.components.container.widgetanimbank or 'ui_chest_3x3', animbuild = inst.components.container.widgetanimbuild or 'ui_chest_3x3', pos = inst.components.container.widgetpos or Vector3(0,200,0), buttoninfo = inst.components.container.widgetbuttoninfo, side_align_tip = 100 }
    inst.components.container.widgetanimbank = "ui_chest_3x3"
    inst.components.container.widgetanimbuild = "ui_chest_3x3"
    inst.components.container.widgetpos = Vector3(0,200,0)
    inst.components.container.side_align_tip = 100
	inst.components.container.widgetbuttoninfo = widgetbuttoninfo
	--inst.components.container.acceptsstacks = false
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
	inst.beeritem = "buling_cooktable_item"
	return inst
end
---通用食物基础实体
local function food_setup(anim, imagename, atlasname)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("buling_food")
    inst.AnimState:SetBuild("buling_food")
    if anim then
        inst.AnimState:PlayAnimation(anim)
    end

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    if imagename then
        inst.components.inventoryitem.imagename = imagename
    end
    if atlasname then
        inst.components.inventoryitem.atlasname = atlasname
    end

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.VEGGIE
    inst:DoTaskInTime(0, function()
        if inst.components.edible then
            inst.components.edible.healthvalue = inst.bl_hea or 0
            inst.components.edible.hungervalue = inst.bl_hun or 0
            inst.components.edible.sanityvalue = inst.bl_san or 0
        end
    end)

    return inst
end

local function commonfn(anim, imagename, atlasname)
    return food_setup(anim, imagename, atlasname)
end

local function buling_food_mianfen(inst, doer)
	local inst = food_setup("flour", "buling_flour", "images/inventoryimages/buling_flour.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_ady = 40
	return inst
end
local function buling_bread(inst, doer)
	local inst = food_setup("buling_bread", "buling_bread", "images/inventoryimages/buling_bread.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hea = 0
	inst.bl_hun = 10
	inst.bl_san = 0
	return inst
end
local function buling_cream(inst, doer)
	local inst = food_setup("buling_cream", "buling_cream", "images/inventoryimages/buling_cream.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hea = 0
	inst.bl_hun = 0
	inst.bl_san = 10
	return inst
end
local function buling_xifan(inst, doer)
	local inst = food_setup("buling_xifan", "buling_xifan", "images/inventoryimages/buling_xifan.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hea = 0
	inst.bl_hun = 10
	inst.bl_san = 0
	return inst
end
local function buling_shucaisui(inst, doer)
	local inst = food_setup("buling_shucaizahui", "buling_shucaizahui", "images/inventoryimages/buling_shucaizahui.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hea = 0
	inst.bl_hun = 5
	inst.bl_san = 0
--料理
	return inst
end
local function buling_food_aoliao(inst, doer)
	local inst = food_setup("aoliao", "buling_aoliao", "images/inventoryimages/buling_aoliao.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hun = 10
	inst.bl_hea = 5
	inst.bl_san = 30
	inst.bl_ady = 10
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.locomotor then
			eater.components.locomotor:AddSpeedModifier_Additive("CAFFEINE",5, total_day_time/2)
			end
	end)
	return inst
end
local function buling_food_baojiangdangao(inst, doer)
	local inst = food_setup("buling_baojiangdangao", "buling_baojiangdangao", "images/inventoryimages/buling_baojiangdangao.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hea = 10
	inst.bl_hun = 50
	inst.bl_san = 10
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_kaiwei', 250)
			end
	end)
	return inst
end
local function buling_bingkaxianbing(inst, doer)
	local inst = food_setup("buling_bingkaxianbing", "buling_bingkaxianbing", "images/inventoryimages/buling_bingkaxianbing.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_tishen', 100)
			end
	end)
	inst.bl_hea = 40
	inst.bl_hun = 20
	inst.bl_san = 15
	return inst
end
local function buling_sanmingzhi(inst, doer)
	local inst = food_setup("buling_sanmingzhi", "buling_sanmingzhi", "images/inventoryimages/buling_sanmingzhi.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_chaotishen', 30)
			end
	end)
	inst.bl_hea = 0
	inst.bl_hun = 30
	inst.bl_san = 0
	return inst
end
local function buling_kaolengmian(inst, doer)
	local inst = food_setup("buling_kaolengmian", "buling_kaolengmian", "images/inventoryimages/buling_kaolengmian.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_kaiwei', 60)
			end
	end)
	inst.bl_hea = 5
	inst.bl_hun = 30
	inst.bl_san = 5
	return inst
end
local function buling_hongguzhou(inst, doer)
	local inst = food_setup("buling_hongguzhou", "buling_hongguzhou", "images/inventoryimages/buling_hongguzhou.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hea = 1
	inst.bl_hun = 20
	inst.bl_san = 5
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.poisonable:Cure(eater)
			end
	end)
	return inst
end
local function buling_jianbingguozi(inst, doer)
	local inst = food_setup("buling_jianbingguozi", "buling_jianbingguozi", "images/inventoryimages/buling_jianbingguozi.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_jiankang', 90)
			end
	end)
	inst.bl_hea = 50
	inst.bl_hun = 10
	inst.bl_san = 20
	return inst
end
local function buling_jiangguomusi(inst, doer)
	local inst = food_setup("buling_jiangguomusi", "buling_jiangguomusi", "images/inventoryimages/buling_jiangguomusi.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_meiwei', 60)
			end
	end)
	inst.bl_hea = 5
	inst.bl_hun = 20
	inst.bl_san = 15
	return inst
end
local function buling_languzhou(inst, doer)
	local inst = food_setup("buling_languzhou", "buling_languzhou", "images/inventoryimages/buling_languzhou.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_jiankang', 90)
			end
	end)
	inst.bl_hea = 10
	inst.bl_hun = 15
	inst.bl_san = 5
	return inst
end
local function buling_luobubao(inst, doer)
	local inst = food_setup("buling_luobubao", "buling_luobubao", "images/inventoryimages/buling_luobubao.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_yeshi', 120)
			end
	end)
	inst.Transform:SetScale(2, 2,2)
	inst.bl_hea = 5
	inst.bl_hun = 40
	inst.bl_san = 5
	return inst
end
local function buling_lvguzhou(inst, doer)
	local inst = food_setup("buling_lvguzhou", "buling_lvguzhou", "images/inventoryimages/buling_lvguzhou.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_meiwei', 90)
			end
	end)
	inst.bl_hea = 1
	inst.bl_hun = 15
	inst.bl_san = 20
	return inst
end
local function buling_mapodoufu(inst, doer)
	local inst = food_setup("buling_mapodoufu", "buling_mapodoufu", "images/inventoryimages/buling_mapodoufu.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hea = 50
	inst.bl_hun = 10
	inst.bl_san = 20
	return inst
end
local function buling_sangubao(inst, doer)
	local inst = food_setup("buling_sangubao", "buling_sangubao", "images/inventoryimages/buling_sangubao.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hea = 50
	inst.bl_hun = 50
	inst.bl_san = 50
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('fulanke', 120)
			end
	end)
	return inst
end
local function buling_qiancengbing(inst, doer)
	local inst = food_setup("buling_qiancengbing", "buling_qiancengbing", "images/inventoryimages/buling_qiancengbing.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_chaobaofu', 30)
			end
	end)
	inst.bl_hea = 50
	inst.bl_hun = 20
	inst.bl_san = 20
	return inst
end
local function buling_xiangcaobuding(inst, doer)
	local inst = food_setup("buling_xiangcaobuding", "buling_xiangcaobuding", "images/inventoryimages/buling_xiangcaobuding.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_chaomeiwei', 30)
			end
	end)
	inst.bl_hea = 50
	inst.bl_hun = 10
	inst.bl_san = 20
	return inst
end
local function buling_tianmishala(inst, doer)
	local inst = food_setup("buling_tianmishala", "buling_tianmishala", "images/inventoryimages/buling_tianmishala.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_huaxiang', 60)
			end
	end)
	inst.bl_hea = 15
	inst.bl_hun = 10
	inst.bl_san = 20
	return inst
end
local function buling_xiangjiaoxianbing(inst, doer)
	local inst = food_setup("buling_xiangjiaoxianbing", "buling_xiangjiaoxianbing", "images/inventoryimages/buling_xiangjiaoxianbing.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_xiangjiaowei', 60)
			end
	end)
	inst.bl_hea = 10
	inst.bl_hun = 24
	inst.bl_san = 5
	return inst
end
local function buling_xiguazhi(inst, doer)
	local inst = food_setup("buling_xiguazhi", "buling_xiguazhi", "images/inventoryimages/buling_xiguazhi.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_meiwei', 30)
			end
	end)
	inst.bl_hea = 5
	inst.bl_hun = 18
	inst.bl_san = 5
	return inst
end
local function buling_suroudacan(inst, doer)
	local inst = food_setup("buling_suroudacan", "buling_suroudacan", "images/inventoryimages/buling_suroudacan.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_baofu', 60)
			end
	end)
	inst.bl_hea = 10
	inst.bl_hun = 50
	inst.bl_san = 15
	return inst
end
local function buling_kaodigua(inst, doer)
	local inst = food_setup("buling_kaodigua", "buling_kaodigua", "images/inventoryimages/buling_kaodigua.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hea = 0
	inst.bl_hun = 30
	inst.bl_san = 5
	return inst
end
local function buling_fangxingjiaotang(inst, doer)
	local inst = food_setup("buling_fangxiangjiaotang", "buling_fangxingjiaotang", "images/inventoryimages/buling_fangxingjiaotang.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hun = 20
	inst.bl_hea = 20
	inst.bl_san = 30
	inst.bl_ady = 10
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_meiwei', 240)
			end
	end)
	return inst
end
local function buling_fanshujianbing(inst, doer)
	local inst = food_setup("buling_fanshujianbing", "buling_fanshujianbing", "images/inventoryimages/buling_fanshujianbing.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_baofu', 30)
			end
	end)
	inst.bl_hea = 5
	inst.bl_hun = 30
	inst.bl_san = 5
	return inst
end
local function buling_fanshuni(inst, doer)
	local inst = food_setup("buling_fanshuni", "buling_fanshuni", "images/inventoryimages/buling_fanshuni.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hea = 5
	inst.bl_hun = 30
	inst.bl_san = 0
--
	return inst
end
local function buling_fanshuzhou(inst, doer)
	local inst = food_setup("buling_fanshuzhou", "buling_fanshuzhou", "images/inventoryimages/buling_fanshuzhou.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_kaiwei', 45)
			end
	end)
	inst.bl_hun = 25
	inst.bl_hea = 5
	inst.bl_san = 5
	inst.bl_ady = 10
	return inst
end
local function buling_fengmibuding(inst, doer)
	local inst = food_setup("buling_fengmibuding", "buling_fengmibuding", "images/inventoryimages/buling_fengmibuding.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hun = 50
	inst.bl_hea = 10
	inst.bl_san = 5
	inst.bl_ady = 20
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_guwuxiang', 180)
			end
	end)
	return inst
end
local function buling_fengmimianbao(inst, doer)
	local inst = food_setup("buling_fengmimianbao", "buling_fengmimianbao", "images/inventoryimages/buling_fengmimianbao.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hun = 20
	inst.bl_hea = 15
	inst.bl_san = 5
	inst.bl_ady = 20
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_huaxiang', 60)
			end
	end)
	return inst
end
local function buling_guodongjuan(inst, doer)
	local inst = food_setup("buling_guodongjuan", "buling_guodongjuan", "images/inventoryimages/buling_guodongjuan.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hun = 20
	inst.bl_hea = 5
	inst.bl_san = 30
	inst.bl_ady = 10
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_yangsheng', 60)
			end
	end)
	return inst
end
local function buling_guojiangtongxinfen(inst, doer)
	local inst = food_setup("buling_guojiangtongxinfen", "buling_guojiangtongxinfen", "images/inventoryimages/buling_guojiangtongxinfen.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hun = 40
	inst.bl_hea = 5
	inst.bl_san = 10
	inst.bl_ady = 15
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_meiwei', 180)
			end
	end)
	return inst
end
local function buling_honggumianbao(inst, doer)
	local inst = food_setup("buling_honggumianbao", "buling_honggumianbao", "images/inventoryimages/buling_honggumianbao.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hea = 10
	inst.bl_hun = 20
	inst.bl_san = 12.5
	return inst
end
local function buling_huluobotang(inst, doer)
	local inst = food_setup("buling_huluobotang", "buling_huluobotang", "images/inventoryimages/buling_huluobotang.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hun = 20
	inst.bl_hea = 10
	inst.bl_san = 10
	inst.bl_ady = 15
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_yeshi', 180)
			end
	end)
	return inst
end
local function buling_jiangguodangao(inst, doer)
	local inst = food_setup("buling_jiangguodangao", "buling_jiangguodangao", "images/inventoryimages/buling_jiangguodangao.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hun = 40
	inst.bl_hea = 10
	inst.bl_san = 5
	inst.bl_ady = 15
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_tishen', 120)
			end
	end)
	return inst
end
local function buling_jiangguosanmingzhi(inst, doer)
	local inst = food_setup("buling_jiangguosanmingzhi", "buling_jiangguosanmingzhi", "images/inventoryimages/buling_jiangguosanmingzhi.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hun = 20
	inst.bl_hea = 5
	inst.bl_san = 5
	inst.bl_ady = 10
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_baofu', 120)
			end
	end)
	return inst
end
local function buling_kafeitang(inst, doer)
	local inst = food_setup("buling_kafeitang", "buling_kafeitang", "images/inventoryimages/buling_kafeitang.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hun = 10
	inst.bl_hea = 10
	inst.bl_san = 10
	inst.bl_ady = 5
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.locomotor then
			eater.components.locomotor:AddSpeedModifier_Additive("CAFFEINE",5, total_day_time)
			end
	end)
	return inst
end
local function buling_luobodangao(inst, doer)
	local inst = food_setup("buling_luobodangao", "buling_luobodangao", "images/inventoryimages/buling_luobodangao.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hun = 30
	inst.bl_hea = 5
	inst.bl_san = 5
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_huluobosu', 120)
			end
	end)
	return inst
end
local function buling_luobogao(inst, doer)
	local inst = food_setup("buling_luobogao", "buling_luobogao", "images/inventoryimages/buling_luobogao.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hun = 20
	inst.bl_hea = 10
	inst.bl_san = 10
	inst.bl_ady = 15
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_yeshi', 120)
			end
	end)
	return inst
end
local function buling_mianbaopian(inst, doer)
	local inst = food_setup("buling_mianbaopian", "buling_mianbaopian", "images/inventoryimages/buling_mianbaopian.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hun = 30
	inst.bl_hea = 5
	inst.bl_san = 5
	inst.bl_ady = 15
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_baofu', 60)
			end
	end)
	return inst
end
local function buling_moguhanbao(inst, doer)
	local inst = food_setup("buling_moguhanbao", "buling_moguhanbao", "images/inventoryimages/buling_moguhanbao.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hun = 50
	inst.bl_hea = 20
	inst.bl_san = 5
	inst.bl_ady = 20
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('fulanke', 150)
			end
	end)
	return inst
end
local function buling_mogutang(inst, doer)
	local inst = food_setup("buling_mogutang", "buling_mogutang", "images/inventoryimages/buling_mogutang.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hun = 5
	inst.bl_hea = 5
	inst.bl_san = 5
	inst.bl_ady = 15
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('fulanke', 240)
			end
	end)
	return inst
end
local function buling_nailaotongxinfen(inst, doer)
	local inst = food_setup("buling_nailaotongxinfen", "buling_nailaotongxinfen", "images/inventoryimages/buling_nailaotongxinfen.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_yangsheng', 100)
			end
	end)
	inst.bl_hea = 10
	inst.bl_hun = 20
	inst.bl_san = 12.5
	return inst
end
local function buling_pisa(inst, doer)
	local inst = food_setup("buling_pisa", "buling_pisa", "images/inventoryimages/buling_pisa.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hun = 70
	inst.bl_hea = 30
	inst.bl_san = 30
	inst.bl_ady = 15
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_huangshi', 100)
			end
	end)
	return inst
end
local function buling_qiaokelipai(inst, doer)
	local inst = food_setup("buling_qiaokelipai", "buling_qiaokelipai", "images/inventoryimages/buling_qiaokelipai.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hun = 20
	inst.bl_hea = 5
	inst.bl_san = 20
	inst.bl_ady = 10
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_chaotishen', 100)
			end
	end)
	return inst
end
local function buling_qiaokelixianbing(inst, doer)
	local inst = food_setup("buling_qiaokelixianbing", "buling_qiaokelixianbing", "images/inventoryimages/buling_qiaokelixianbing.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hun = 20
	inst.bl_hea = 40
	inst.bl_san = 10
	inst.bl_ady = 10
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_guwuxiang', 240)
			end
	end)
	return inst
end
local function buling_qieheshutiao(inst, doer)
	local inst = food_setup("buling_qieheshutiao", "buling_qieheshutiao", "images/inventoryimages/buling_qieheshutiao.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hun = 50
	inst.bl_hea = 20
	inst.bl_san = 5
	inst.bl_ady = 10
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_chaomeiwei', 80)
			end
	end)
	return inst
end
local function buling_shucaizahui(inst, doer)
	local inst = food_setup("buling_shucaizahui", "buling_shucaizahui", "images/inventoryimages/buling_shucaizahui.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hea = 10
	inst.bl_hun = 20
	inst.bl_san = 12.5
	return inst
end
local function buling_suanrongguhe(inst, doer)
	local inst = food_setup("buling_suanrongguhe", "buling_suanrongguhe", "images/inventoryimages/buling_suanrongguhe.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hun = 40
	inst.bl_hea = 10
	inst.bl_san = 10
	inst.bl_ady = 10
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('fulanke', 90)
			end
	end)
	return inst
end
local function buling_suanrongmianbao(inst, doer)
	local inst = food_setup("buling_suanrongmianbao", "buling_suanrongmianbao", "images/inventoryimages/buling_suanrongmianbao.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hun = 30
	inst.bl_hea = 5
	inst.bl_san = 10
	inst.bl_ady = 15
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_jiankang', 120)
			end
	end)
	return inst
end
local function buling_tianshuni(inst, doer)
	local inst = food_setup("buling_tianshuni", "buling_tianshuni", "images/inventoryimages/buling_tianshuni.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hun = 26
	inst.bl_hea = 6
	inst.bl_san = 16
	inst.bl_ady = 10
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_jiankang', 120)
			end
	end)
	return inst
end
local function buling_zhaluobowanzi(inst, doer)
	local inst = food_setup("buling_zhaluobowanzi", "buling_zhaluobowanzi", "images/inventoryimages/buling_zhaluobowanzi.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hun = 30
	inst.bl_hea = 20
	inst.bl_san = 5
	inst.bl_ady = 15
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_yeshi', 45)
			end
	end)
	return inst
end
local function buling_zhawanzi(inst, doer)
	local inst = food_setup("buling_zhawanzi", "buling_zhawanzi", "images/inventoryimages/buling_zhawanzi.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hun = 33
	inst.bl_hea = 15
	inst.bl_san = 33
	inst.bl_ady = 15
	return inst
end
local function buling_shucaishala(inst, doer)
	local inst = food_setup("buling_shucaishala", "buling_shucaishala", "images/inventoryimages/buling_shucaishala.xml")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hun = 50
	inst.bl_hea = 5
	inst.bl_san = 10
	inst.bl_ady = 15
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_chaotishen', 4)
			end
	end)
--
AddIngredientValues({"buling_goatmilk"}, {dairy=1})
	return inst
end
local function buling_goatmilk(inst, doer)
	local inst = food_setup("idle", "goatmilk", "images/inventoryimages.xml")
	inst.AnimState:SetBank("goatmilk")
	inst.AnimState:SetBuild("goatmilk")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.bl_hea = TUNING.HEALING_SMALL
	inst.bl_hun = TUNING.CALORIES_SMALL
	inst.bl_san = TUNING.SANITY_SMALL
	return inst
end
return Prefab("buling_cooktable", cooktable, assets),--料理台
Prefab("buling_flour", buling_food_mianfen, assets),--面粉
Prefab("buling_shucaisui", buling_shucaisui, assets),
Prefab("buling_cream", buling_cream, assets),
Prefab("buling_baojiangdangao", buling_food_baojiangdangao, assets),
Prefab("buling_sanmingzhi", buling_sanmingzhi, assets),
Prefab("buling_bread", buling_bread, assets),
Prefab("buling_xifan", buling_xifan, assets),
Prefab("buling_goatmilk", buling_goatmilk, assets),
Prefab("buling_aoliao", buling_food_aoliao, assets),
Prefab("buling_shucaishala", buling_shucaishala, assets),
Prefab("buling_bingkaxianbing", buling_bingkaxianbing, assets),
Prefab("buling_kaolengmian", buling_kaolengmian, assets),
Prefab("buling_hongguzhou", buling_hongguzhou, assets),
Prefab("buling_jianbingguozi", buling_jianbingguozi, assets),
Prefab("buling_jiangguomusi", buling_jiangguomusi, assets),
Prefab("buling_languzhou", buling_languzhou, assets),
Prefab("buling_luobubao", buling_luobubao, assets),
Prefab("buling_lvguzhou", buling_lvguzhou, assets),
Prefab("buling_mapodoufu", buling_mapodoufu, assets),
Prefab("buling_sangubao", buling_sangubao, assets),
Prefab("buling_qiancengbing", buling_qiancengbing, assets),
Prefab("buling_xiangcaobuding", buling_xiangcaobuding, assets),
Prefab("buling_tianmishala", buling_tianmishala, assets),
Prefab("buling_xiangjiaoxianbing", buling_xiangjiaoxianbing, assets),
Prefab("buling_xiguazhi", buling_xiguazhi, assets),
Prefab("buling_suroudacan", buling_suroudacan, assets),
Prefab("buling_kaodigua", buling_kaodigua, assets),
Prefab("buling_fangxingjiaotang",buling_fangxingjiaotang, assets),
Prefab("buling_fanshujianbing", buling_fanshujianbing, assets),
Prefab("buling_fanshuni", buling_fanshuni, assets),
Prefab("buling_fanshuzhou",buling_fanshuzhou, assets), 
Prefab("buling_fengmibuding", buling_fengmibuding, assets),
Prefab("buling_fengmimianbao", buling_fengmimianbao, assets),
Prefab("buling_guodongjuan", buling_guodongjuan, assets),
Prefab("buling_guojiangtongxinfen", buling_guojiangtongxinfen, assets),
Prefab("buling_honggumianbao", buling_honggumianbao, assets),
Prefab("buling_huluobotang", buling_huluobotang, assets),
Prefab("buling_jiangguodangao", buling_jiangguodangao, assets),
Prefab("buling_jiangguosanmingzhi", buling_jiangguosanmingzhi, assets),
Prefab("buling_kafeitang", buling_kafeitang, assets),
Prefab("buling_luobodangao", buling_luobodangao, assets),
Prefab("buling_luobogao", buling_luobogao, assets),
Prefab("buling_mianbaopian", buling_mianbaopian, assets),
Prefab("buling_moguhanbao", buling_moguhanbao, assets),
Prefab("buling_mogutang", buling_mogutang, assets),
Prefab("buling_nailaotongxinfen", buling_nailaotongxinfen, assets),
Prefab("buling_pisa", buling_pisa, assets),
Prefab("buling_qiaokelipai", buling_qiaokelipai, assets),
Prefab("buling_qiaokelixianbing", buling_qiaokelixianbing, assets),
Prefab("buling_qieheshutiao", buling_qieheshutiao, assets),
Prefab("buling_shucaizahui", buling_shucaizahui, assets),
Prefab("buling_suanrongguhe", buling_suanrongguhe, assets),
Prefab("buling_suanrongmianbao", buling_suanrongmianbao, assets),
Prefab("buling_tianshuni", buling_tianshuni, assets),
Prefab("buling_zhaluobowanzi", buling_zhaluobowanzi, assets),
Prefab("buling_zhawanzi", buling_zhawanzi, assets),
MakePlacer("buling_cooktable_placer", "buling_box", "buling_box", "cooktable")