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
	text = "Do",
	position = Vector3(0, -140, 0),
	fn = function(inst, doer)
		if not TheWorld.ismastersim then
			SendModRPCToServer(MOD_RPC["bulingbuling"]["do_widget_button"], inst.GUID)
			return
		end
		local peifang = ""
		local slots = inst.components.container.slots
		for k=1,9 do
			local item = inst.components.container:GetItemInSlot(k)
			if item == nil then
				item = "nil"
				else
				item = item.prefab
			end
			peifang = peifang..item..","
		end
		for k,v in pairs(cookhechengbiao) do
			if v[1] == peifang then
				--[[local item = inst.components.container:GetItemInSlot(8)
				if item and item:HasTag("buling_cook_tool") then
					item = inst.components.container:GetItemInSlot(8).prefab
				else
					item = nil
				end]]
				local opener = doer or (inst.components.container and inst.components.container.openers and next(inst.components.container.openers)) or inst.components.container.opener or inst
				local _crafted = SpawnPrefab(k)
				if _crafted then
					if opener and opener.components and opener.components.inventory then
						opener.components.inventory:GiveItem(_crafted, nil, inst:GetPosition())
					else
						_crafted.Transform:SetPosition(inst.Transform:GetWorldPosition())
					end
				end
				for k=1,9 do
					local item = inst.components.container:GetItemInSlot(k)
					if item ~= nil then
						if item.components.stackable and item.components.stackable.stacksize > 1  then
							item.components.stackable:SetStackSize(item.components.stackable.stacksize - 1)
						elseif  not item:HasTag("buling_cook_tool") then
							item:Remove()
						end
					end
				end
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
    MakeInventoryPhysics(inst)
    inst:AddComponent("inspectable")
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
	inst.AnimState:PlayAnimation("cooktable")
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
---通用
local function commonfn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
	inst:AddComponent("edible")
	inst.bl_hea = 0
	inst.bl_hun = 0
	inst.bl_san = 0
	inst.bl_ady = 10
	inst.AnimState:SetBank("buling_food")
    inst.AnimState:SetBuild("buling_food")
	inst.components.edible.foodtype = "VEGGIE"
	inst:DoTaskInTime(0,function()
		inst.components.edible.healthvalue = inst.bl_hea
		inst.components.edible.hungervalue = inst.bl_hun
		inst.components.edible.sanityvalue = inst.bl_san
	end) 
	--[[inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(inst.bl_ady*total_day_time)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"]]
    return inst
end
--食材
local function buling_food_mianfen(inst, doer)--面粉
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_flour"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_flour.xml"
	inst.AnimState:PlayAnimation("flour")
	inst.bl_ady = 40
    return inst
end
local function buling_bread(inst, doer)--面包
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_bread"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_bread.xml"
	inst.AnimState:PlayAnimation("buling_bread")
	inst.bl_hea = 0
	inst.bl_hun = 10
	inst.bl_san = 0
    return inst
end
local function buling_cream(inst, doer)--奶油
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_cream"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_cream.xml"
	inst.AnimState:PlayAnimation("buling_cream")
	inst.bl_hea = 0
	inst.bl_hun = 0
	inst.bl_san = 10
    return inst
end
local function buling_xifan(inst, doer)--稀饭
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_xifan"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_xifan.xml"
	inst.AnimState:PlayAnimation("buling_xifan")
	inst.bl_hea = 0
	inst.bl_hun = 10
	inst.bl_san = 0
    return inst
end
local function buling_shucaisui(inst, doer)--蔬菜碎
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_shucaizahui"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_shucaizahui.xml"
	inst.AnimState:PlayAnimation("buling_shucaizahui")
	inst.bl_hea = 0
	inst.bl_hun = 5
	inst.bl_san = 0
    return inst
end
--料理
local function buling_food_aoliao(inst, doer)--奥利奥
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_aoliao"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_aoliao.xml"
	inst.AnimState:PlayAnimation("aoliao")
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
local function buling_food_baojiangdangao(inst, doer)--爆浆蛋糕
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_baojiangdangao"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_baojiangdangao.xml"
	inst.AnimState:PlayAnimation("buling_baojiangdangao")
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
local function buling_bingkaxianbing(inst, doer)--宾卡馅饼
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_bingkaxianbing"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_bingkaxianbing.xml"
	inst.AnimState:PlayAnimation("buling_bingkaxianbing")
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
local function buling_sanmingzhi(inst, doer)--三明治
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_sanmingzhi"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_sanmingzhi.xml"
	inst.AnimState:PlayAnimation("buling_sanmingzhi")
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
local function buling_kaolengmian(inst, doer)--烤冷面
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_kaolengmian"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_kaolengmian.xml"
	inst.AnimState:PlayAnimation("buling_kaolengmian")
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
local function buling_hongguzhou(inst, doer)--红菇煲
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_hongguzhou"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_hongguzhou.xml"
	inst.AnimState:PlayAnimation("buling_hongguzhou")
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
local function buling_jianbingguozi(inst, doer)--煎饼果子
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_jianbingguozi"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_jianbingguozi.xml"
	inst.AnimState:PlayAnimation("buling_jianbingguozi")
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
local function buling_jiangguomusi(inst, doer)--浆果慕斯
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_jiangguomusi"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_jiangguomusi.xml"
	inst.AnimState:PlayAnimation("buling_jiangguomusi")
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
local function buling_languzhou(inst, doer)--蓝菇煲
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_languzhou"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_languzhou.xml"
	inst.AnimState:PlayAnimation("buling_languzhou")
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
local function buling_luobubao(inst, doer)--萝卜煲
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_luobubao"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_luobubao.xml"
	inst.AnimState:PlayAnimation("buling_luobubao")
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
local function buling_lvguzhou(inst, doer)--绿菇煲
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_lvguzhou"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_lvguzhou.xml"
	inst.AnimState:PlayAnimation("buling_lvguzhou")
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
local function buling_mapodoufu(inst, doer)--麻婆豆腐
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_mapodoufu"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_mapodoufu.xml"
	inst.AnimState:PlayAnimation("buling_mapodoufu")
	inst.bl_hea = 50
	inst.bl_hun = 10
	inst.bl_san = 20

    return inst
end
local function buling_sangubao(inst, doer)--三菇煲
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_sangubao"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_sangubao.xml"
	inst.AnimState:PlayAnimation("buling_sangubao")
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
local function buling_qiancengbing(inst, doer)--千层饼
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_qiancengbing"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_qiancengbing.xml"
	inst.AnimState:PlayAnimation("buling_qiancengbing")
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
local function buling_xiangcaobuding(inst, doer)--香草布丁
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_xiangcaobuding"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_xiangcaobuding.xml"
	inst.AnimState:PlayAnimation("buling_xiangcaobuding")
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
local function buling_tianmishala(inst, doer)--甜蜜沙拉
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_tianmishala"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_tianmishala.xml"
	inst.AnimState:PlayAnimation("buling_tianmishala")
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
local function buling_xiangjiaoxianbing(inst, doer)--香蕉煎饼
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_xiangjiaoxianbing"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_xiangjiaoxianbing.xml"
	inst.AnimState:PlayAnimation("buling_xiangjiaoxianbing")
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
local function buling_xiguazhi(inst, doer)--西瓜汁
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_xiguazhi"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_xiguazhi.xml"
	inst.AnimState:PlayAnimation("buling_xiguazhi")
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
local function buling_suroudacan(inst, doer)--素肉大餐
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_suroudacan"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_suroudacan.xml"
	inst.AnimState:PlayAnimation("buling_suroudacan")
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
local function buling_kaodigua(inst, doer)--炸地瓜
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_kaodigua"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_kaodigua.xml"
	inst.AnimState:PlayAnimation("buling_kaodigua")
	inst.bl_hea = 0
	inst.bl_hun = 30
	inst.bl_san = 5
    return inst
end
local function buling_fangxingjiaotang(inst, doer)--方形焦糖
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_fangxingjiaotang"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_fangxingjiaotang.xml"
	inst.AnimState:PlayAnimation("buling_fangxiangjiaotang")
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
local function buling_fanshujianbing(inst, doer)--番薯煎饼
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_fanshujianbing"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_fanshujianbing.xml"
	inst.AnimState:PlayAnimation("buling_fanshujianbing")
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
local function buling_fanshuni(inst, doer)--番薯泥
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_fanshuni"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_fanshuni.xml"
	inst.AnimState:PlayAnimation("buling_fanshuni")
	inst.bl_hea = 5
	inst.bl_hun = 30
	inst.bl_san = 0
    return inst
end
--
local function buling_fanshuzhou(inst, doer)--番薯粥
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_fanshuzhou"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_fanshuzhou.xml"
	inst.AnimState:PlayAnimation("buling_fanshuzhou")
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
local function buling_fengmibuding(inst, doer)--蜂蜜布丁
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_fengmibuding"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_fengmibuding.xml"
	inst.AnimState:PlayAnimation("buling_fengmibuding")
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
local function buling_fengmimianbao(inst, doer)--蜂蜜面包
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_fengmimianbao"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_fengmimianbao.xml"
	inst.AnimState:PlayAnimation("buling_fengmimianbao")
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
local function buling_guodongjuan(inst, doer)--果冻卷
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_guodongjuan"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_guodongjuan.xml"
	inst.AnimState:PlayAnimation("buling_guodongjuan")
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
local function buling_guojiangtongxinfen(inst, doer)--果酱通心粉
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_guojiangtongxinfen"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_guojiangtongxinfen.xml"
	inst.AnimState:PlayAnimation("buling_guojiangtongxinfen")
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
local function buling_honggumianbao(inst, doer)--红菇面包
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_honggumianbao"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_honggumianbao.xml"
	inst.AnimState:PlayAnimation("buling_honggumianbao")
	inst.bl_hea = 10
	inst.bl_hun = 20
	inst.bl_san = 12.5
    return inst
end
local function buling_huluobotang(inst, doer)--胡萝卜汤
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_huluobotang"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_huluobotang.xml"
	inst.AnimState:PlayAnimation("buling_huluobotang")
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
local function buling_jiangguodangao(inst, doer)--浆果蛋糕
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_jiangguodangao"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_jiangguodangao.xml"
	inst.AnimState:PlayAnimation("buling_jiangguodangao")
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
local function buling_jiangguosanmingzhi(inst, doer)--浆果三明治
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_jiangguosanmingzhi"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_jiangguosanmingzhi.xml"
	inst.AnimState:PlayAnimation("buling_jiangguosanmingzhi")
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
local function buling_kafeitang(inst, doer)--咖啡糖
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_kafeitang"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_kafeitang.xml"
	inst.AnimState:PlayAnimation("buling_kafeitang")
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
local function buling_luobodangao(inst, doer)--萝卜蛋糕
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_luobodangao"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_luobodangao.xml"
	inst.AnimState:PlayAnimation("buling_luobodangao")
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
local function buling_luobogao(inst, doer)--萝卜糕
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_luobogao"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_luobogao.xml"
	inst.AnimState:PlayAnimation("buling_luobogao")
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
local function buling_mianbaopian(inst, doer)--面包片
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_mianbaopian"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_mianbaopian.xml"
	inst.AnimState:PlayAnimation("buling_mianbaopian")
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
local function buling_moguhanbao(inst, doer)--蘑菇汉堡
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_moguhanbao"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_moguhanbao.xml"
	inst.AnimState:PlayAnimation("buling_moguhanbao")
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
local function buling_mogutang(inst, doer)--蘑菇汤
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_mogutang"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_mogutang.xml"
	inst.AnimState:PlayAnimation("buling_mogutang")
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
local function buling_nailaotongxinfen(inst, doer)--奶酪通心粉
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_nailaotongxinfen"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_nailaotongxinfen.xml"
	inst.AnimState:PlayAnimation("buling_nailaotongxinfen")
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
local function buling_pisa(inst, doer)--披萨
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_pisa"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_pisa.xml"
	inst.AnimState:PlayAnimation("buling_pisa")
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
local function buling_qiaokelipai(inst, doer)--巧克力派
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_qiaokelipai"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_qiaokelipai.xml"
	inst.AnimState:PlayAnimation("buling_qiaokelipai")
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
local function buling_qiaokelixianbing(inst, doer)--巧克力馅饼
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_qiaokelixianbing"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_qiaokelixianbing.xml"
	inst.AnimState:PlayAnimation("buling_qiaokelixianbing")
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
local function buling_qieheshutiao(inst, doer)--茄盒薯条
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_qieheshutiao"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_qieheshutiao.xml"
	inst.AnimState:PlayAnimation("buling_qieheshutiao")
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
local function buling_shucaizahui(inst, doer)--蔬菜杂烩
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_shucaizahui"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_shucaizahui.xml"
	inst.AnimState:PlayAnimation("buling_shucaizahui")
	inst.bl_hea = 10
	inst.bl_hun = 20
	inst.bl_san = 12.5
    return inst
end
local function buling_suanrongguhe(inst, doer)--蒜蓉菇盒
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_suanrongguhe"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_suanrongguhe.xml"
	inst.AnimState:PlayAnimation("buling_suanrongguhe")
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
local function buling_suanrongmianbao(inst, doer)--蔬菜面包
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_suanrongmianbao"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_suanrongmianbao.xml"
	inst.AnimState:PlayAnimation("buling_suanrongmianbao")
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
local function buling_tianshuni(inst, doer)--甜薯泥
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_tianshuni"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_tianshuni.xml"
	inst.AnimState:PlayAnimation("buling_tianshuni")
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
local function buling_zhaluobowanzi(inst, doer)--炸萝卜丸子
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_zhaluobowanzi"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_zhaluobowanzi.xml"
	inst.AnimState:PlayAnimation("buling_zhaluobowanzi")
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
local function buling_zhawanzi(inst, doer)--炸丸子
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_zhawanzi"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_zhawanzi.xml"
	inst.AnimState:PlayAnimation("buling_zhawanzi")
	inst.bl_hun = 33
	inst.bl_hea = 15
	inst.bl_san = 33
	inst.bl_ady = 15
    return inst
end
local function buling_shucaishala(inst, doer)--蔬菜沙拉
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "buling_shucaishala"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_shucaishala.xml"
	inst.AnimState:PlayAnimation("buling_shucaishala")
	inst.bl_hun = 50
	inst.bl_hea = 5
	inst.bl_san = 10
	inst.bl_ady = 15
	inst.components.edible:SetOnEatenFn(function(inst,eater)
		if eater.components.buling_buff then
			eater.components.buling_buff:Addbulingbuff_Additive('buling_chaotishen', 4)
		end
	end)
    return inst
end

--
AddIngredientValues({"buling_goatmilk"}, {dairy=1})
local function buling_goatmilk(inst, doer)--羊奶
    local inst = commonfn(inst)
	inst.components.inventoryitem.imagename = "goatmilk"
	inst.components.inventoryitem.atlasname = "images/inventoryimages.xml"
	inst.AnimState:SetBank("goatmilk")
    inst.AnimState:SetBuild("goatmilk")
    inst.AnimState:PlayAnimation("idle")
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