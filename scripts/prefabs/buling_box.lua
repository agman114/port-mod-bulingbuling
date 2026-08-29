local function SendBulingRPC(rpc_name, ...)
	local rpc = (TheSim and TheSim.GetModRPC and TheSim:GetModRPC("bulingbuling", rpc_name))
		or (GLOBAL and GLOBAL.GetModRPC and GLOBAL.GetModRPC("bulingbuling", rpc_name))
		or (GLOBAL and GLOBAL.MOD_RPC and GLOBAL.MOD_RPC["bulingbuling"] and GLOBAL.MOD_RPC["bulingbuling"][rpc_name])
	if rpc then
		SendModRPCToServer(rpc, ...)
	end
end

local function OnOpen(inst)
	if inst and inst.SoundEmitter then
		inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
	end
end

local function OnClose(inst)
	if inst and inst.SoundEmitter then
		inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")
	end
end

local assets ={
	Asset("ANIM", "anim/buling_manual.zip"),
	Asset("ANIM", "anim/buling_box.zip"),
	Asset("ANIM", "anim/buling_box_2.zip"),
	Asset("ATLAS", "images/inventoryimages/buling_manual.xml"),
	Asset("ANIM", "anim/buling_ronglu.zip"),
	Asset("ANIM", "anim/wakuangji.zip"),
	Asset("ANIM", "anim/ui_buling_chest_3x5.zip"),
}
local function buling_recipes()
	local buling_book_tongxuntai = Recipe("buling_yanjiudian", {Ingredient("boards",10)}, RECIPETABS.BLTAB,{SCIENCE = 20},nil)
end
local hechengbiao = {
--塞德锭
["buling_zhongziding"]={"seeds,nil,seeds,nil,goldnugget,nil,seeds,nil,seeds,"}, 
--植物改良桌
["buling_planttable_item"]={"nil,nil,nil,boards,buling_zhongziding,boards,buling_zhongziding,nil,buling_zhongziding,"},
--不灵萃取机
["buling_ronglu_item"]={"cutstone,cutstone,cutstone,cutstone,transistor,cutstone,buling_zhongziding,buling_zhongziding,buling_zhongziding,"},
--电力中继器
["buling_zhongjiqi_item"]={"buling_zhongziding,transistor,buling_zhongziding,buling_zhongziding,transistor,buling_zhongziding,buling_zhongziding,buling_zhongziding,buling_zhongziding,"},
--生存发电机
["buling_shengcun_item"]={"nil,buling_ronglu_item,nil,buling_zhongziding,buling_zhongjiqi_item,buling_zhongziding,buling_zhongziding,buling_zhongziding,buling_zhongziding,"},
--不灵炮塔
["buling_paotai_item"]={"nil,gears,nil,nil,log,nil,buling_zhongziding,log,buling_zhongziding,"},
--不灵雷达
--["buling_radar_item"]={"buling_zhongziding,compass,buling_zhongziding,buling_zhongziding,buling_zhongjiqi_item,buling_zhongziding,buling_zhongziding,buling_zhongziding,buling_zhongziding,"},
--不灵采集者
["buling_cropbox_item"]={"seeds,seeds,seeds,goldenshovel,gears,goldenshovel,buling_zhongziding,buling_zhongjiqi_item,buling_zhongziding,"},
--不灵电灯
["buling_diandeng_item"]={"nil,buling_glass,nil,nil,torch,nil,nil,buling_zhongziding,nil,"},
--人力发电机
["buling_huosai_item"]={"nil,nil,nil,cutstone,gears,cutstone,cutstone,cutstone,cutstone,"},
--种子培育机
["buling_seedbox_item"]={"buling_glass,buling_zhongziding,buling_glass,seeds,fertilizer,seeds,buling_zhongziding,buling_zhongziding,buling_zhongziding,"},
--太阳能发电机
["buling_solarenergy_item"]={"buling_glass,buling_glass,buling_glass,buling_zhongziding,buling_zhongjiqi_item,buling_zhongziding,buling_zhongziding,buling_zhongziding,buling_zhongziding,"},
--电动剪刀
["buling_jiandao"]={"buling_zhongziding,nil,buling_zhongziding,nil,buling_zhongjiqi_item,nil,twigs,nil,twigs,"},
--电动镐
["buling_diandonggao"]={"buling_zhongziding,buling_zhongjiqi_item,buling_zhongziding,nil,twigs,nil,nil,twigs,nil,"},
--电动斧
["buling_dianlifu"]={"nil,buling_zhongjiqi_item,buling_zhongziding,nil,twigs,buling_zhongziding,nil,twigs,nil,"},
--充电器
["buling_chongdianqi_item"]={"buling_zhongziding,buling_zhongjiqi_item,buling_zhongziding,nil,buling_zhongziding,nil,buling_zhongziding,buling_zhongziding,buling_zhongziding,"},
--齿轮
["gears"]={"nil,buling_zhongziding,nil,buling_zhongziding,nil,buling_zhongziding,nil,buling_zhongziding,nil,"},
--地雷
--["buling_mine"]={"nil,nitre,nil,buling_zhongziding,gears,buling_zhongziding,nil,buling_zhongziding,nil,"},
--扳手
["buling_banshou"]={"nil,buling_zhongziding,nil,nil,twigs,buling_zhongziding,twigs,nil,nil,"},
--合金箱
["buling_chest_item"]={"buling_zhongziding,buling_zhongziding,buling_zhongziding,buling_zhongziding,nil,buling_zhongziding,buling_zhongziding,buling_zhongziding,buling_zhongziding,"},
--化学台
["buling_chemistrytable_item"]={"buling_juhemei_alpha,buling_glass,buling_zhusheqi,boards,boards,boards,boards,nil,boards,"},
--太阳能路灯
["buling_lamp_item"]={"buling_glass,buling_solarenergy_item,buling_glass,nil,buling_diandeng_item,nil,nil,nil,nil,"},
}
local shaozhibiao = {
	["buling_seed_wheat"] = "buling_flour",
	["buling_zhongziding"] = "buling_glass",
	["flint"] = "rocks",
	["rocks"] = "sand",
	["sand"] = "alloy",
	["carrot_seeds"] = "seeds",
	["corn_seeds"] = "seeds",
	["pumpkin_seeds"] = "seeds",
	["eggplant_seeds"] = "seeds",
	["durian_seeds"] = "seeds",
	["sweet_potato_seeds"] = "seeds",
	["pomegranate_seeds"] = "seeds",
	["dragonfruit_seeds"] = "seeds",
	["watermelon_seeds"] = "seeds",
	["aloe_seeds"] = "seeds",
	["asparagus_seeds"] = "seeds",
	["radish_seeds"] = "seeds",
	["gold_dust"] = "goldnugget",
}
local hechengbiao_clothes = {
	["buling_fabric"] = {"cutgrass,cutgrass,nil,cutgrass,cutgrass,nil,nil,nil,nil,"},
	["fabric"] = {"buling_fabric,buling_fabric,nil,buling_fabric,buling_fabric,nil,nil,nil,nil,"},
	["buling_clothe_1"] = {"buling_fabric,nil,buling_fabric,buling_fabric,charcoal,buling_fabric,buling_fabric,buling_fabric,buling_fabric,"},
	["buling_clothe_2"] = {"buling_fabric,nil,buling_fabric,buling_fabric,beefalowool,buling_fabric,buling_fabric,buling_fabric,buling_fabric,"},
	["buling_clothe_3"] = {"buling_fabric,nil,buling_fabric,buling_fabric,petals,buling_fabric,buling_fabric,buling_fabric,buling_fabric,"},
	["buling_clothe_4"] = {"nil,goldnugget,nil,buling_fabric,buling_clothe_1,buling_fabric,nil,goldnugget,nil,"},
	["buling_clothe_5"] = {"buling_fabric,nil,buling_fabric,buling_fabric,heatrock,buling_fabric,buling_fabric,buling_fabric,buling_fabric,"},
	["buling_clothe_6"] = {"fabric,nil,fabric,fabric,buling_fabric,fabric,fabric,fabric,fabric,"},
	["buling_clothe_7"] = {"nil,beefalowool,nil,fabric,buling_clothe_2,fabric,nil,beefalowool,nil,"},
	["buling_clothe_8"] = {"nil,monsterlasagna,nil,monstermeat,buling_clothe_3,monstermeat,nil,monstermeat,nil,"},
	["buling_clothe_9"] = {"fabric,nil,fabric,fabric,buling_solarenergy_item,fabric,fabric,fabric,fabric,"},
	
	["buling_trouser_1"] = {"buling_fabric,buling_fabric,buling_fabric,buling_fabric,nil,buling_fabric,buling_fabric,nil,buling_fabric,"},
	["buling_trouser_2"] = {"fabric,buling_fabric,fabric,buling_fabric,nil,buling_fabric,buling_fabric,nil,buling_fabric,"},
	["buling_trouser_3"] = {"fabric,fabric,fabric,buling_fabric,nil,buling_fabric,buling_fabric,nil,buling_fabric,"},
	["buling_trouser_4"] = {"fabric,fabric,fabric,fabric,nil,fabric,buling_fabric,nil,buling_fabric,"},
	["buling_trouser_5"] = {"fabric,fabric,fabric,fabric,nil,fabric,fabric,nil,fabric,"},
	["buling_trouser_6"] = {"nil,buling_fabric,nil,buling_fabric,buling_trouser_5,buling_fabric,nil,buling_fabric,nil,"},
	
	["buling_dancer_dragon"] = {"thulecite_pieces,nil,thulecite_pieces,thulecite_pieces,buling_core,thulecite_pieces,thulecite_pieces,armorruins,thulecite_pieces,"},
	["buling_cardinal"] = {"buling_puleidi,nil,buling_puleidi,ancient_remnant,buling_core,ancient_remnant,ancient_remnant,ancient_remnant,ancient_remnant,"},
	["buling_eveningrobe"] = {"fabric,nil,fabric,fabric,buling_puleidi,fabric,buling_puleidi,buling_puleidi,buling_puleidi,"},
	["buling_denim"] = {"fabric,nil,fabric,fabric,pitchfork,fabric,fabric,fabric,fabric,"},
	["bulingbuling_sikushui"] = {"ice,nil,ice,tar,buling_clothe_1,tar,fabric,fabric,fabric,"},
	["buling_christmas"] = {"nil,fabric,nil,fabric,buling_clothe_7,fabric,nil,fabric,nil,"},
	
	
}
local weaponhechengbiao ={
--普雷蒂水晶
["buling_puleidi"]={"buling_glass,buling_glass,buling_glass,buling_glass,buling_zhongziding,buling_glass,buling_glass,buling_glass,buling_glass,"},
--普雷蒂金属板
["buling_puleidi_plank"]={"buling_zhongziding,buling_zhongziding,buling_zhongziding,buling_puleidi,buling_puleidi,buling_puleidi,buling_zhongziding,buling_zhongziding,buling_zhongziding,"},
--高压中继器
["buling_zhongjiqi_gaoya_item"]={"buling_zhongziding,buling_puleidi,buling_zhongziding,buling_puleidi,buling_zhongjiqi_item,buling_puleidi,buling_zhongziding,buling_zhongziding,buling_zhongziding,"},
--高级机器核心
["buling_core"]={"buling_puleidi_plank,buling_puleidi_plank,buling_puleidi_plank,buling_puleidi_plank,buling_puleidi,buling_puleidi_plank,buling_puleidi_plank,buling_puleidi_plank,buling_puleidi_plank,"},
--避雷针控制模块
["buling_bileizhen_item"]={"nil,buling_glass,nil,nil,buling_glass,nil,buling_zhongziding,buling_zhongjiqi_gaoya_item,buling_zhongziding,"},
--不灵手枪零式
["buling_gun_zero"]={"buling_glass,buling_glass,buling_glass,buling_glass,gears,buling_glass,buling_zhongziding,nil,nil,"},
--格林机枪
["buling_gun_white"]={"buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,buling_core,buling_puleidi,buling_glass,nil,nil,"},
--脉冲手枪
["buling_gun_yang"]={"buling_glass,buling_glass,buling_glass,buling_glass,buling_gun_zero,buling_glass,buling_bileizhen_item,nil,nil,"},
--轻质手枪
["buling_gun_qing"]={"buling_glass,buling_glass,buling_glass,buling_glass,buling_gun_zero,buling_glass,cane,nil,nil,"},
--标准枪管
["buling_gun_qiangguan"]={"buling_zhongziding,buling_zhongziding,buling_zhongziding,nil,nil,nil,buling_zhongziding,buling_zhongziding,buling_zhongziding,"},
--阳极枪管
["buling_gun_qiangguan_yang"]={"buling_glass,nil,nil,buling_puleidi,buling_gun_qiangguan,buling_glass,buling_glass,nil,nil,"},
--阴极枪管
["buling_gun_qiangguan_ying"]={"buling_zhongziding,nil,nil,buling_glass,buling_gun_qiangguan,buling_zhongziding,buling_zhongziding,nil,nil,"},
--制式电池
["buling_gun_dianchi"]={"nil,buling_zhongziding,nil,buling_glass,buling_zhongjiqi_item,buling_glass,nil,buling_zhongziding,nil,"},
--通量电池
["buling_gun_dianchi_tongliang"]={"nil,buling_zhongjiqi_gaoya_item,nil,buling_zhongziding,buling_gun_dianchi,buling_zhongziding,buling_glass,nil,buling_glass,"},
--太阳能电池
["buling_gun_dianchi_taiyang"]={"nil,buling_solarenergy_item,nil,buling_zhongziding,buling_gun_dianchi,buling_zhongziding,buling_glass,nil,buling_glass,"},
--标准手柄
["buling_gun_shoubing"]={"buling_zhongziding,nil,nil,buling_zhongziding,buling_zhongziding,buling_zhongziding,buling_zhongziding,nil,nil,"},
--标枪手柄
["buling_gun_shoubing_biaoqiang"]={"buling_glass,nil,nil,buling_glass,buling_glass,buling_glass,buling_glass,nil,nil,"},
--狙击手柄
["buling_gun_shoubing_juji"]={"buling_glass,nil,nil,buling_zhongziding,buling_zhongziding,buling_zhongziding,buling_glass,nil,nil,"},
--激光引导器
["buling_gun_jiguang"]={"buling_glass,nil,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,nil,buling_glass,"},
--剥离引导器
["buling_gun_jiguang_boli"]={"buling_glass,nil,nil,buling_puleidi,buling_gun_jiguang,buling_puleidi,buling_glass,nil,nil,"},
--格拉斯引导器
["buling_gun_jiguang_yaoshou"]={"buling_puleidi,nil,nil,buling_glass,buling_gun_jiguang,buling_glass,buling_puleidi,nil,nil,"},
--防水力场
["buling_waterproof_field"]={"buling_diandeng_item,buling_glass,buling_bileizhen_item,buling_glass,buling_zhongjiqi_item,buling_glass,nil,buling_glass,nil,"},
--木质车车
["buling_car_log_item"]={"boards,boards,boards,transistor,buling_chest_item,buling_core,gears,boards,gears,"},
--物质转换器
["buling_conversion"]={"nil,buling_puleidi_plank,nil,buling_puleidi_plank,buling_core,buling_puleidi_plank,nil,buling_puleidi_plank,nil,"},
--次元存储装置
["buling_infinitebox_item"]={"buling_puleidi_plank,buling_puleidi_plank,buling_puleidi_plank,buling_puleidi_plank,buling_conversion,buling_puleidi_plank,buling_puleidi_plank,buling_puleidi_plank,buling_puleidi_plank,"},
--存储芯片
["buling_chipbox"]={"nil,buling_glass,nil,nil,buling_puleidi_plank,nil,nil,nil,nil,"},
--铔金镐
["buling_pickaxe_weapon"]={"nil,buling_yajin,nil,buling_yajin,buling_diandonggao,buling_yajin,nil,buling_yajin,nil,"},
--铔金斧
["buling_axe_weapon"]={"nil,buling_yajin,nil,buling_yajin,buling_dianlifu,buling_yajin,nil,buling_yajin,nil,"},
--铔金剪刀
["buling_shears_weapon"]={"nil,buling_yajin,nil,buling_yajin,buling_jiandao,buling_yajin,nil,buling_yajin,nil,"},
--传送带
["buling_chuansongdai_8"]={"buling_zhongziding,nil,buling_zhongziding,buling_zhongziding,twigs,buling_zhongziding,buling_zhongziding,nil,buling_zhongziding,"},
--机械臂
["buling_jixiebi_item"]={"nil,buling_banshou,nil,nil,buling_chuansongdai_item,nil,nil,nil,nil,"},
--土培箱
["buling_shuipei_item"]={"nil,fertilizer,nil,nil,buling_chuansongdai_item,nil,nil,nil,nil,"},
--物流箱
["buling_chest_mini_item"]={"nil,buling_chest_item,nil,nil,buling_chuansongdai_item,nil,nil,nil,nil,"},
--自动合成台
["buling_zidonghecheng_item"]={"nil,buling_weaponchest_item,nil,nil,buling_chuansongdai_item,nil,nil,nil,nil,"},
--自动萃取台
["buling_ronglu2_item"]={"nil,buling_ronglu_item,nil,nil,buling_zhongjiqi_gaoya_item,nil,nil,buling_chuansongdai_item,nil,"},
--电线杆
["buling_dianxiangan_item"]={"buling_glass,transistor,buling_glass,buling_glass,transistor,buling_glass,buling_glass,buling_glass,buling_glass,"},
--强化炮塔
["buling_repair_box_item"]={"buling_glass,buling_glass,buling_glass,nil,buling_paotai_item,nil,buling_glass,buling_glass,buling_glass,"},
--粉碎机
["buling_fensui_item"]={"buling_glass,buling_glass,buling_glass,buling_glass,nil,buling_glass,buling_glass,buling_glass,buling_glass,"},
}
local seedhechengbiao ={
--注射器
["buling_zhusheqi"]={"nil,buling_glass,nil,nil,buling_glass,nil,buling_glass,buling_zhongziding,buling_glass,"},
--燧石种子
["buling_seed_flint"]={"buling_glass,buling_juhemei_alpha,buling_zhongziding,buling_juhemei_alpha,seeds,buling_juhemei_alpha,buling_zhongziding,buling_juhemei_alpha,buling_zhongziding,"},
--小麦种子
["buling_seed_wheat"]={"seeds,seeds,seeds,nil,seeds,nil,nil,nil,nil,"},
--硝石种子
["buling_seed_nitre"]={"buling_glass,buling_juhemei_alpha,buling_glass,buling_juhemei_alpha,seeds,buling_juhemei_alpha,buling_glass,buling_juhemei_alpha,buling_zhongziding,"},
--岩石种子
["buling_seed_rock"]={"buling_zhongziding,buling_juhemei_alpha,buling_zhongziding,buling_juhemei_alpha,seeds,buling_juhemei_alpha,buling_zhongziding,buling_juhemei_alpha,buling_zhongziding,"},
--黄金种子
["buling_seed_gold"]={"buling_glass,buling_juhemei_alpha,buling_glass,buling_juhemei_alpha,seeds,buling_juhemei_alpha,buling_glass,buling_juhemei_alpha,buling_glass,"},
--十胜石种子
["buling_seed_obsidian"]={"buling_glass,buling_juhemei_beta,buling_glass,buling_juhemei_beta,seeds,buling_juhemei_beta,buling_glass,buling_juhemei_beta,buling_glass,"},
--铥矿种子
["buling_seed_thulecite"]={"buling_zhongziding,buling_juhemei_beta,buling_glass,buling_juhemei_beta,seeds,buling_juhemei_beta,buling_glass,buling_juhemei_beta,buling_zhongziding,"},
--铁矿种子
["buling_seed_iron"]={"buling_zhongziding,buling_juhemei_beta,buling_zhongziding,buling_juhemei_beta,seeds,buling_juhemei_beta,buling_zhongziding,buling_juhemei_beta,buling_zhongziding,"},
--大理石种子
["buling_seed_marble"]={"buling_glass,buling_juhemei_alpha,buling_glass,buling_juhemei_alpha,seeds,buling_juhemei_alpha,buling_zhongziding,buling_juhemei_alpha,buling_zhongziding,"},
--多风种子
["buling_seed_duofeng"]={"pinecone,buling_juhemei_alpha,pinecone,buling_juhemei_alpha,seeds,buling_juhemei_alpha,acorn,buling_juhemei_alpha,acorn,"},
--热带种子
["buling_seed_redai"]={"palmleaf,buling_juhemei_alpha,palmleaf,buling_juhemei_alpha,seeds,buling_juhemei_alpha,seashell,buling_juhemei_alpha,seashell,"},
--贫瘠种子
["buling_seed_pinji"]={"sand,buling_juhemei_alpha,sand,buling_juhemei_alpha,seeds,buling_juhemei_alpha,sand,buling_juhemei_alpha,sand,"},
--荫蔽种子
["buling_seed_yinbi"]={"foliage,buling_juhemei_alpha,foliage,buling_juhemei_alpha,seeds,buling_juhemei_alpha,foliage,buling_juhemei_alpha,foliage,"},
--湿润种子
["buling_seed_shirun"]={"teatree_nut,buling_juhemei_alpha,teatree_nut,buling_juhemei_alpha,seeds,buling_juhemei_alpha,cork,buling_juhemei_alpha,cork,"},
--塞德锭
["buling_zhongziding"]={"nil,seeds,nil,nil,goldnugget,nil,nil,seeds,nil,"}, 
--肥料
["buling_manure_4"]={"nil,ash,nil,ash,nitre,ash,nil,ash,nil,"}, 
--贝塔聚合酶
["buling_juhemei_beta"]={"buling_juhemei_alpha,buling_juhemei_alpha,buling_juhemei_alpha,buling_juhemei_alpha,buling_juhemei_alpha,buling_juhemei_alpha,buling_juhemei_alpha,buling_juhemei_alpha,buling_juhemei_alpha,"}, 
}

--
local function get_name(inst, doer)
	local name = STRINGS.NAMES[string.upper(inst.prefab)]
	local num = 0
	local beer = 0
		if inst.components.beerpower and inst.components.beerpower.PowerMax ~= 0 then
			num = inst.components.beerpower.power
			beer = inst.components.beerpower.beer
			name = name.."\n "..STRINGS.POWER.."<"..string.format("%.0f", num).."/"..inst.components.beerpower.PowerMax.."> "
		end	
	return name
end
local slotpos = {}
for y = 2, 0, -1 do
	for x = 0, 2 do
		table.insert(slotpos, Vector3(80*x-80*2+80, 80*y-80*2+80,0))
	end
end
--
local function buling_manual(inst, doer)
	
	local widgetbuttoninfo = { 
    text = "Do",
    position = Vector3(0, -140, 0),
    fn = function(inst, doer)
		print("[BULING DEBUG] fn called on inst:", inst, "GUID:", inst and inst.GUID, "ismastersim:", TheWorld and TheWorld.ismastersim)
		if not TheWorld.ismastersim then
			print("[BULING DEBUG CLIENT] Sending SendModRPCToServer to server for GUID:", inst and inst.GUID)
			SendBulingRPC("do_widget_button", inst and inst.GUID)
			return
		end
		local opener = doer or (inst.components.container and inst.components.container.openers and next(inst.components.container.openers)) or inst.components.container.opener or inst
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
		print("[BULING CRAFT LOG] Container slots peifang: '" .. tostring(peifang) .. "'")
		local matched = false
		for k,v in pairs(hechengbiao) do
			if v[1] == peifang then
				print("[BULING CRAFT LOG] MATCH FOUND! Recipe key: " .. tostring(k))
				matched = true
				local _crafted = SpawnPrefab(k)
				if _crafted then
					if opener and opener.components and opener.components.inventory then
						opener.components.inventory:GiveItem(_crafted, nil, inst:GetPosition())
					else
						_crafted.Transform:SetPosition(inst.Transform:GetWorldPosition())
					end
				end
				local is_free = GLOBAL.BULING_FREE_CRAFT or (opener and opener.components and opener.components.builder and opener.components.builder.freebuildmode)
				if not is_free then
					for slot_i=1,9 do
						local item = inst.components.container:GetItemInSlot(slot_i)
						if item ~= nil then
							if item.components.stackable and item.components.stackable.stacksize > 1 then
								item.components.stackable:SetStackSize(item.components.stackable.stacksize - 1)
							else
								item:Remove()
							end
						end
					end
				end
				if opener and opener.components and opener.components.talker then
					opener.components.talker:Say("Крафт выполнен!")
				end
				break
			end
		end
		if not matched then
			print("[BULING CRAFT LOG] NO MATCH for peifang: '" .. tostring(peifang) .. "'")
			if opener and opener.components and opener.components.talker then
				opener.components.talker:Say("Неверная комбинация предметов!")
			end
		end
	end, }
	local function OnOpen(inst, doer)
		local _target = doer or inst
		if _target and _target.PushEvent then _target:PushEvent("OpenBuling_manual") end
	end
	local function OnClose(inst, doer)
		local _target = doer or inst
		if _target and _target.PushEvent then _target:PushEvent("CloseBuling_manual") end
	end
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    MakeObstaclePhysics(inst, .5)
    inst:AddComponent("inspectable")
	inst.AnimState:SetBank("buling_manual")
    inst.AnimState:SetBuild("buling_manual")
    inst.AnimState:PlayAnimation("idle")
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
	inst.beeritem = "buling_manual_item"
	return inst
end
local function ronglufn()
	local function itemtest(inst, item, slot)
		if slot == 1 and shaozhibiao[item.prefab] ~= nil  then
			return true
		end
		if slot == 2 then
			return true
		end
		
	end
	local function duidie(inst, doer,itemname)
		local item2 = inst.components.container:GetItemInSlot(2)
		if item2 and item2.prefab == itemname and (item2.components.stackable and not item2.components.stackable:IsFull()) then
			item2.components.stackable:SetStackSize(item2.components.stackable.stacksize+1)
		else
			inst.components.container:GiveItem(SpawnPrefab(itemname), 2)
		end
	end
	local widgetbuttoninfo = {
	text = "BBQ",
	position = Vector3(0, -140, 0),
	fn = function(inst, doer)
		local item = inst.components.container:GetItemInSlot(1)
		if  item then
			if shaozhibiao[item.prefab] ~= nil then
				if inst.components.beerpower.power >= 10 then
					local replacement = shaozhibiao[item.prefab]
					if replacement then
						inst.components.container:ConsumeByName(item.prefab,1)
						duidie(inst,replacement)
						inst.components.beerpower:UpBeer(10)
					end
				else
					local _target = doer or inst
					_target.components.talker:Say(STRINGS.BULING_BWNG)
				end
			end
		end
	end}
	local function OnOpen(inst, doer)
		--VisitURL("https://www.bilibili.com")
		local _target = doer or inst
		if _target and _target.PushEvent then _target:PushEvent("OpenBuling_cuiqu") end
	end
	local function OnClose(inst, doer)
		local _target = doer or inst
		if _target and _target.PushEvent then _target:PushEvent("CloseBuling_cuiqu") end
	end
	local slotpos = {Vector3(-80,0,0),Vector3(80,0,0)}
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize(2,0.75)
	trans:SetFourFaced()
	inst.AnimState:SetBuild("buling_ronglu")
	inst.AnimState:SetBank("buling_ronglu")
	inst.AnimState:PlayAnimation("idle")
	inst:AddComponent("inspectable")
	inst:AddComponent("beerpower")
	inst.components.beerpower:SetNumber(200)
	inst.displaynamefn = get_name
	inst:AddComponent("container")
	inst.components.container:SetNumSlots(#slotpos)
	inst.components.container.widgetslotpos = slotpos
	inst.components.container.widget = { slotpos = inst.components.container.widgetslotpos, animbank = inst.components.container.widgetanimbank or 'ui_chest_3x3', animbuild = inst.components.container.widgetanimbuild or 'ui_chest_3x3', pos = inst.components.container.widgetpos or Vector3(0,200,0), buttoninfo = inst.components.container.widgetbuttoninfo, side_align_tip = 100 }
    inst.components.container.widgetanimbank = "ui_chest_3x3"
    inst.components.container.widgetanimbuild = "ui_chest_3x3"
    inst.components.container.widgetpos = Vector3(0,200,0)
    inst.components.container.side_align_tip = 100
	inst.components.container.widgetbuttoninfo = widgetbuttoninfo
	inst.components.container.itemtestfn = itemtest
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
	inst.beeritem = "buling_ronglu_item"
	return inst
end
local function radar(inst, doer)
	local inst=commonfn(inst)
	inst:DoTaskInTime(0,function()
		for k=1,7 do
			SpawnPrefab("buling_zhongziding").Transform:SetPosition(inst.Transform:GetWorldPosition())
		end
		SpawnPrefab("compass").Transform:SetPosition(inst.Transform:GetWorldPosition())
		SpawnPrefab("buling_zhongjiqi_item").Transform:SetPosition(inst.Transform:GetWorldPosition())
		inst:Remove()
	end)
	return inst
end
local function buling_solarenergy(inst, doer)
	local function task(inst, doer)
		local pos = Vector3(inst.Transform:GetWorldPosition())
		local ents = TheSim:FindEntities(pos.x,pos.y,pos.z,15)
		local nengliang = -10
		if (TheWorld.state and TheWorld.state.isnight) and (TheWorld.state and TheWorld.state.moonphase or 'new') == "full" then
			nengliang = -8
		end
		if (TheWorld.state and TheWorld.state.isnight) then
			nengliang = 0
		end
		if (TheWorld.state and TheWorld.state.isdusk) then
			nengliang = -5
		end
		if (TheWorld.state and TheWorld.state.isday) then
			nengliang = -10
		end
		for k,v in pairs(ents) do
			if v and v.components.beerpower and 
				v.components.beerpower.PowerMax > 0 and  
				v.components.beerpower.power < v.components.beerpower.PowerMax and
				v:HasTag("zhongjiqi") then
				v.components.beerpower:UpBeer(nengliang)
				break
			end
		end
	end
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    MakeObstaclePhysics(inst, .5)
	inst.task = inst:DoPeriodicTask(5,function()task(inst)end)
    inst:AddComponent("inspectable")
	inst.Transform:SetScale(2, 2, 2)
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
    inst.AnimState:PlayAnimation("buling_solarenergy")
	inst.beeritem = "buling_solarenergy_item"
	inst:AddTag("bp_source")
	return inst
end 
--种子管家
local function buling_seedbox(inst, doer)
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    MakeObstaclePhysics(inst, .5)
    inst:AddComponent("inspectable")
	inst:AddComponent("beerpower")
	inst.components.beerpower:SetNumber(200)
	inst.displaynamefn = get_name
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
    inst.AnimState:PlayAnimation("seedbox")
	inst.Transform:SetScale(2, 2, 2)
	inst.nengliang = 0
	local function turnon(inst, doer)
		inst.components.machine.ison = true
		if inst.components.beerpower.power < 5 then
			inst:DoTaskInTime(0,function()
				inst.components.machine:TurnOff()
			end)
		end
	end
	local function turnoff(inst, doer)
		inst.components.machine.ison = false
	end	
	inst:DoPeriodicTask(5,function()
		if inst.components.machine.ison == true then
			inst.components.beerpower:UpBeer(5)
			local NOTAGS = {"FX", "DECOR", "INLIMBO", "flingomatic_freeze_immune"}
			local x,y,z = inst:GetPosition():Get()
			local ents = TheSim:FindEntities(x,y,z, 15, {}, NOTAGS)
			for k,v in pairs(ents) do
				if v then
					if v.makewitherabletask then
						v.makewitherabletask:Cancel()
						v.makewitherabletask = nil
						v:AddTag("protected")
						if v.components.crop then
							v.components.crop.protected = true
						elseif v.components.pickable then
							v.components.pickable.protected = true
						end
						elseif v.components.crop and v.components.crop.witherable then
						v.components.crop.protected = true
						v:AddTag("protected")
						elseif v.components.pickable and v.components.pickable.witherable then
						v.components.pickable.protected = true
						if v.components.pickable.withered or v.components.pickable.shouldwither then
							if v.components.pickable.cycles_left and v.components.pickable.cycles_left <= 0 then
								v.components.pickable:MakeBarren()
							else
								v.components.pickable:MakeEmpty()
							end
							v.components.pickable.withered = false
							v.components.pickable.shouldwither = false
							v:RemoveTag("withered")
						end
						v:AddTag("protected")
					end
					if  ((TheWorld.state and TheWorld.state.iswinter) and (TheWorld.state or {}):GetCurrentTemperature() <= 0) then
						if v.components.crop then
							v.components.crop.growthpercent = v.components.crop.growthpercent + 4*v.components.crop.rate
						end
						if v.components.grower then
							v.components.grower.cycles_left = v.components.grower.cycles_left + 0.0125
						end
						if v.components.pickable then
							if v.components.pickable.protected_cycles ~= nil then
								v.components.pickable.protected_cycles = v.components.pickable.protected_cycles + 0.0125
							else
								v.components.pickable.protected_cycles = 0.0125
							end
						end
					end
				end
			end
		end
	end)
	local function onsave(inst, data)
		data = data or {}
		data.nengliang = inst.nengliang 
	end
	local function onload(inst, data)
		if data then
			inst.nengliang = data.nengliang
		end
	end
	inst:AddComponent("machine")
    inst.components.machine.turnonfn = turnon
    inst.components.machine.turnofffn = turnoff
	inst.OnSave = onsave
    inst.OnLoad = onload
	inst:ListenForEvent("buling_workstop",turnoff)
	inst.beeritem = "buling_seedbox_item"
	return inst
end 
--机械加工炉
local function buling_weaponchest(inst, doer)
	local widgetbuttoninfo = {
	text = "Do",
	position = Vector3(0, -140, 0),
	fn = function(inst, doer)
		if inst.components.beerpower.power >= 50 then 
			local opener = doer or (inst.components.container and inst.components.container.openers and next(inst.components.container.openers)) or inst.components.container.opener or inst
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
			for k,v in pairs(weaponhechengbiao) do
				if v[1] == peifang then
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
							if item.components.stackable and item.components.stackable.stacksize > 1 then
								item.components.stackable:SetStackSize(item.components.stackable.stacksize - 1)
							else
								item:Remove()
							end
						end
					end
					inst.components.beerpower:UpBeer(50)
				end
			end
		else
			local _target = doer or inst
			_target.components.talker:Say(STRINGS.BULING_BWNG..STRINGS.BULING_BWNG2)
		end
	end}
	local function OnOpen(inst, doer)
		local _target = doer or inst
		if _target and _target.PushEvent then _target:PushEvent("OpenBuling_jixiejiaognglu") end
	end
	local function OnClose(inst, doer)
		local _target = doer or inst
		if _target and _target.PushEvent then _target:PushEvent("CloseBuling_jixiejiaognglu") end
	end
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst:AddComponent("inspectable")
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
	inst.AnimState:PlayAnimation("weaponchest")
	inst:AddComponent("beerpower")
	inst.components.beerpower:SetNumber(500)
	inst.displaynamefn = get_name
	inst:AddComponent("container")
	inst.components.container:SetNumSlots(#slotpos)
	inst.components.container.widgetslotpos = slotpos
	inst.components.container.widget = { slotpos = inst.components.container.widgetslotpos, animbank = inst.components.container.widgetanimbank or 'ui_chest_3x3', animbuild = inst.components.container.widgetanimbuild or 'ui_chest_3x3', pos = inst.components.container.widgetpos or Vector3(0,200,0), buttoninfo = inst.components.container.widgetbuttoninfo, side_align_tip = 100 }
    inst.components.container.widgetanimbank = "ui_chest_3x3"
    inst.components.container.widgetanimbuild = "ui_chest_3x3"
    inst.components.container.widgetpos = Vector3(0,200,0)
    inst.components.container.side_align_tip = 100
	inst.components.container.widgetbuttoninfo = widgetbuttoninfo
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
	--inst.components.container.acceptsstacks = false
	inst.beeritem = "buling_weaponchest_item"
	return inst
end
--电动收割机
local function shouhuo(inst, doer)
	local function shouhuotime(inst, doer)
		if inst.components.beerpower and inst.components.beerpower.power >= 50 then
			local pos = Vector3(inst.Transform:GetWorldPosition())
			local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, 20, nil, { "INLIMBO", "NOCLICK", "DECK" })
			local harvester_user = doer or inst
			local count = 0
			for _, v in ipairs(ents) do
				if v:IsValid() and v ~= inst then
					-- Pickable plants (berries, grass, saplings, etc.)
					if v.components.pickable and v.components.pickable:CanBePicked() and v.prefab ~= "flower" then
						local success, loot = v.components.pickable:Pick(harvester_user)
						count = count + 1
					-- Crops & Farm plants
					elseif v.components.crop and v.components.crop:IsReadyForHarvest() then
						v.components.crop:Harvest(harvester_user)
						count = count + 1
					-- Harvestable structures (Beeboxes, etc.)
					elseif v.components.harvestable and v.components.harvestable:CanBeHarvested() then
						v.components.harvestable:Harvest(harvester_user)
						count = count + 1
					end
				end
			end
			if count > 0 then
				inst.components.beerpower:UpBeer(50)
			end
		end
	end

	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
	inst.entity:AddAnimState()
	MakeObstaclePhysics(inst, .5)
	inst:AddComponent("inspectable")

	inst.AnimState:SetBank("buling_box")
	inst.AnimState:SetBuild("buling_box")
	inst.AnimState:PlayAnimation("shouhuo")

	inst:AddComponent("container")
	inst.components.container:SetNumSlots(#slotpos)
	inst.components.container.widgetslotpos = slotpos
	inst.components.container.widget = { slotpos = slotpos, animbank = 'ui_chest_3x3', animbuild = 'ui_chest_3x3', pos = Vector3(0, 200, 0), side_align_tip = 100 }
	inst.components.container.widgetanimbank = "ui_chest_3x3"
	inst.components.container.widgetanimbuild = "ui_chest_3x3"
	inst.components.container.widgetpos = Vector3(0, 200, 0)
	inst.components.container.side_align_tip = 100
	inst.components.container.onopenfn = OnOpen
	inst.components.container.onclosefn = OnClose

	local function turnon(inst, doer)
		inst.components.machine.ison = true
		shouhuotime(inst, doer)
		inst:DoTaskInTime(0, function()
			inst.components.machine:TurnOff()
		end)
	end

	local function turnoff(inst, doer)
		inst.components.machine.ison = false
		inst.components.machine.caninteractfn = function() return inst.components.beerpower and inst.components.beerpower.power >= 50 end
	end

	inst:AddComponent("machine")
	inst.components.machine.turnonfn = turnon
	inst.components.machine.turnofffn = turnoff
	inst:AddComponent("beerpower")
	inst.components.beerpower:SetNumber(100)
	inst.components.machine.cooldowntime = 0
	inst.displaynamefn = get_name
	inst.beeritem = "buling_cropbox_item"
	return inst
end
--电力
local function commonfn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    MakeObstaclePhysics(inst, .5)
    inst:AddComponent("inspectable")
	inst.AnimState:SetBank("buling_zaxiang")
    inst.AnimState:SetBuild("buling_zaxiang")
	inst:AddComponent("beerpower")
	inst.displaynamefn = get_name
    return inst
end
--炮台
local function paotai(inst, doer)
	local function WeaponDropped(inst, doer)
		inst:Remove()
	end
	local function EquipWeapon(inst, doer)
		local function canattack(inst, doer, target)
			if inst.components.beerpower.power >= 5 then
				return true
			end
		end
		local function onattack(inst, attacker, target)
			if attacker and attacker.SoundEmitter then attacker.SoundEmitter:PlaySound("dontstarve/creatures/eyeballturret/shotexplo") end
			if attacker and attacker.components and attacker.components.beerpower then attacker.components.beerpower:UpBeer(5) end
		end
		if inst.components.inventory and not inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
			local weapon = CreateEntity()
			weapon.entity:AddTransform()
			weapon:AddComponent("weapon")
			weapon.components.weapon:SetDamage(inst.components.combat.defaultdamage)
			weapon.components.weapon:SetRange(inst.components.combat.attackrange, inst.components.combat.attackrange+4)
			weapon.components.weapon:SetProjectile("bishop_charge")
			weapon:AddComponent("inventoryitem")
			weapon.persists = false
			weapon.components.inventoryitem:SetOnDroppedFn(WeaponDropped)
			weapon:AddComponent("equippable")
			weapon.components.weapon:SetOnAttack(onattack)
			weapon.components.weapon.canattackfn = canattack
			inst.components.inventory:Equip(weapon)
		end
	end
	local inst=commonfn(inst)
	inst.Transform:SetScale(2, 2, 2)
	inst.AnimState:PlayAnimation("jianyipaotai")
	local function shouldKeepTarget(inst, doer, target)
		if target and target:IsValid() and
			(target.components.health and not target.components.health:IsDead()) then
			local distsq = target:GetDistanceSqToInst(inst)
			return distsq < 20*20
		else
			return false
		end
	end
	local function retargetfn(inst, doer)
		local notags = {"FX", "NOCLICK","INLIMBO"}
		local newtarget = FindEntity(inst, 20, function(guy)
				return  guy.components.combat and 
						inst.components.combat:CanTarget(guy) and
						(guy.components.combat.target == (doer or inst) or (doer or inst).components.combat.target == guy)
		end, nil, notags)
		return newtarget
	end
	inst.components.beerpower:SetNumber(50)
	inst:AddComponent("inventory")
	inst:AddTag("buling_box")
	inst:AddComponent("combat")
	inst:AddComponent("health")
    inst.components.health:SetMaxHealth(50)
    inst.components.combat:SetRange(15)
    inst.components.combat:SetDefaultDamage(15)
    inst.components.combat:SetAttackPeriod(TUNING.EYETURRET_ATTACK_PERIOD)
    inst.components.combat:SetRetargetFunction(15, retargetfn)
    inst.components.combat:SetKeepTargetFunction(shouldKeepTarget)
	inst:DoTaskInTime(1, EquipWeapon)  
	inst:DoPeriodicTask(1,function()
		local pos = Vector3(inst.Transform:GetWorldPosition())
        local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 15)
        for k,v in pairs(ents) do
            local pt1 = v:GetPosition()
            if v.components.combat and v.components.health and not v.components.health:IsDead() and( v.components.combat.target == inst or v:HasTag("monster") or v.components.combat.target == (doer or inst) or (doer or inst).components.combat.target == v) and inst.components.beerpower.power >= 5 and v~= (doer or inst) and not v:HasTag("buling_box") then
				inst.components.combat:SetTarget(v)
				inst.components.combat:DoAttack()
			end
		end
	
	end)
	inst.beeritem = "buling_paotai_item"
	return inst
end
local function buling_repair_box(inst, doer)
	local function WeaponDropped(inst, doer)
		inst:Remove()
	end
	local function EquipWeapon(inst, doer)
		local function canattack(inst, doer, target)
			if inst.components.beerpower.power >= 50 then
				return true
			end
		end
		local function onattack(inst, attacker, target)
			if attacker and attacker.SoundEmitter then attacker.SoundEmitter:PlaySound("dontstarve/creatures/eyeballturret/shotexplo") end
			if attacker and attacker.components and attacker.components.beerpower then attacker.components.beerpower:UpBeer(50) end
			target.components.health:DoDelta(50)
		end
		if inst.components.inventory and not inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
			local weapon = CreateEntity()
			weapon.entity:AddTransform()
			weapon:AddComponent("weapon")
			weapon.components.weapon:SetDamage(inst.components.combat.defaultdamage)
			weapon.components.weapon:SetRange(inst.components.combat.attackrange, inst.components.combat.attackrange+4)
			weapon.components.weapon:SetProjectile("bishop_charge")
			weapon:AddComponent("inventoryitem")
			weapon.persists = false
			weapon.components.inventoryitem:SetOnDroppedFn(WeaponDropped)
			weapon:AddComponent("equippable")
			weapon.components.weapon:SetOnAttack(onattack)
			weapon.components.weapon.canattackfn = canattack
			inst.components.inventory:Equip(weapon)
		end
	end
	local inst=commonfn(inst)
	inst.Transform:SetScale(2, 2, 2)
	inst.AnimState:SetBank("buling_box_2")
    inst.AnimState:SetBuild("buling_box_2")
	inst.AnimState:PlayAnimation("paotai",true)
	inst.components.beerpower:SetNumber(1000)
	inst:AddComponent("inventory")
	inst:AddTag("buling_box")
	inst:AddComponent("combat")
    inst.components.combat:SetRange(5)
    inst.components.combat:SetDefaultDamage(0)
    inst.components.combat:SetAttackPeriod(TUNING.EYETURRET_ATTACK_PERIOD)
	inst:DoTaskInTime(1, EquipWeapon)  
	inst:DoPeriodicTask(1,function()
		local pos = Vector3(inst.Transform:GetWorldPosition())
        local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 5)
        for k,v in pairs(ents) do
            local pt1 = v:GetPosition()
            if v.components.combat and v.components.health and v.components.health.currenthealth < v.components.health.maxhealth and not v.components.health:IsDead() and inst.components.beerpower.power >= 50 and v:HasTag("buling_carrier") then
				inst.components.combat:SetTarget(v)
				inst.components.combat:DoAttack()
			end
		end
	end)
	inst.beeritem = "buling_repair_box_item"
	return inst
end
--电力中继器
local function zhongjiqi(inst, doer)
	local function task(inst, doer)
		local task = inst:DoPeriodicTask(5,function()
			--print("e")
		if inst.components.beerpower.power >= 5 and inst.components.machine.ison == true then
			local pos = Vector3(inst.Transform:GetWorldPosition())
			local ents = TheSim:FindEntities(pos.x,pos.y,pos.z,15)
				for k,v in pairs(ents) do
					if v and v.components.beerpower and 
						v.components.beerpower.PowerMax > 0 
						and not v:HasTag("buling_lingjian") 
						and v.components.beerpower.power < v.components.beerpower.PowerMax 
						and not v:HasTag("zhongjiqi") then
						v.components.beerpower:UpBeer(-5)
						inst.components.beerpower:UpBeer(5)
					end
				end
				else
				inst.components.machine:TurnOff()
				if inst.task then
					inst.task:Cancel()
					inst.task = nil
				end
			end
		end)
		return task
	end
	local function turnon(inst, doer)
		inst.components.machine.ison = true
		inst.AnimState:PlayAnimation("zhongjiqi_on")
		inst.task = task(inst)
		if inst.components.beerpower.power < 5 then
			inst:DoTaskInTime(0,function()
				inst.components.machine:TurnOff()
				if inst.task then
					--print("bbb1")
					inst.task:Cancel()
					inst.task = nil
				end
			end)
		end
	end
	local function turnoff(inst, doer)
		inst.components.machine.ison = false
		inst.AnimState:PlayAnimation("zhongjiqi_off")
		if inst.task then
			--print("bbb")
			inst.task:Cancel()
			inst.task = nil
		end
	end	
	local inst=commonfn(inst)
	MakeObstaclePhysics(inst, 1)
	inst.Transform:SetScale(2, 2, 2)
	inst.AnimState:PlayAnimation("zhongjiqi_off")
	inst:AddComponent("machine")
    inst.components.machine.turnonfn = turnon
    inst.components.machine.turnofffn = turnoff
	inst.components.beerpower:SetNumber(1000)
	inst.components.machine.caninteractfn = function() return inst.components.beerpower and inst.components.beerpower.power > 5 end
	inst:AddTag("zhongjiqi")
	inst.beeritem = "buling_zhongjiqi_item"
	return inst
end
--生存发电机
local function shengcun(inst, doer)
	local function get_name(inst, doer)
		local name = STRINGS.NAMES[string.upper(inst.prefab)]
		name = name.."\n"..STRINGS.FUEL..":"..inst.components.fueled.currentfuel.."/1000"
	return name
	end
	local function task(inst, doer)
		if inst.components.fueled.currentfuel > 0 then
			inst.components.fueled:DoDelta(-5)
			local pos = Vector3(inst.Transform:GetWorldPosition())
			local ents = TheSim:FindEntities(pos.x,pos.y,pos.z,15)
				for k,v in pairs(ents) do
					if v and v.components.beerpower and 
						v.components.beerpower.PowerMax > 0 and  
						v.components.beerpower.power < v.components.beerpower.PowerMax and
						v:HasTag("zhongjiqi") then
						v.components.beerpower:UpBeer(-5)
						break
					end
				end
				else
				inst.task:Cancel()
				inst.task = nil
			end
	end
	local function ontakefuel(inst, doer)
		inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
		if inst.task == nil then
			inst.task = inst:DoPeriodicTask(5,function()task(inst)end)
		end
	end
	local inst=commonfn(inst)
	inst.Transform:SetScale(2, 2, 2)
	inst.AnimState:PlayAnimation("shengcunfadianji")
	inst.task = inst:DoPeriodicTask(5,function()task(inst)end)
	inst:AddComponent("fueled")
	--inst.components.fueled.fueltype = "HUAXUERANLIAO"
	inst.components.fueled.maxfuel = 1000
	inst.components.fueled.ontakefuelfn = ontakefuel
    inst.components.fueled.accepting = true
	inst.components.fueled:SetDepletedFn(function(inst) 
		if inst.task then
			inst.task:Cancel()
			inst.task = nil
		end
	end)
	inst.displaynamefn = get_name
	inst.beeritem = "buling_shengcun_item"
	inst:AddTag("bp_source")
	return inst
end
--电灯
local function diandeng(inst, doer)
	local function turnon(inst, doer)
		inst.components.machine.ison = true
		inst.Light:Enable(true)
		inst.AnimState:PlayAnimation("diandeng_on")
		inst.components.beerpower:StartPerishing()
		if inst.components.beerpower.power < 2 then
			inst:DoTaskInTime(0,function()
				inst.components.machine:TurnOff()
				inst.Light:Enable(false)
			end)
		end
	end
	local function turnoff(inst, doer)
		inst.components.machine.ison = false
		inst.Light:Enable(false)
		inst.AnimState:PlayAnimation("diandeng_off")
		inst.components.beerpower:StopPerishing()
		inst.components.machine.caninteractfn = function() return  inst.components.beerpower and inst.components.beerpower.power > 2 end
	end
	local inst=commonfn(inst)
	inst.entity:AddLight()
	inst.Transform:SetScale(2, 2, 2)
	inst.AnimState:PlayAnimation("diandeng_off")
    inst.Light:SetColour(180/255, 195/255, 150/255)
	inst.Light:Enable(false)
	inst.Light:SetIntensity(.75)
    inst.Light:SetFalloff( 0.9 )
    inst.Light:SetRadius( 8 )
	inst:AddComponent("machine")
    inst.components.machine.turnonfn = turnon
    inst.components.machine.turnofffn = turnoff
	inst.components.beerpower:SetNumber(50,2)
	inst.components.machine.cooldowntime = 0
	inst.beeritem = "buling_diandeng_item"
	inst:ListenForEvent("buling_brownout",function()
		inst:DoTaskInTime(0,function()
			turnoff(inst)
		end)
	end)
	return inst
end
--太阳能路灯
local function diandeng2(inst, doer)
	local inst=commonfn(inst)
	inst.entity:AddLight()
	--inst.Transform:SetScale(2, 2, 2)
	inst.AnimState:SetBank("buling_box_2")
    inst.AnimState:SetBuild("buling_box_2")
	inst.AnimState:PlayAnimation("diandeng_off")
    inst.Light:SetColour(180/255, 255/255, 150/255)
	inst.Light:Enable(false)
	inst.Light:SetIntensity(.75)
    inst.Light:SetFalloff( 0.9 )
    inst.Light:SetRadius( 15 )
	inst.beeritem = "buling_lamp_item"
	inst:DoTaskInTime(0.1,function()
		if (TheWorld.state and TheWorld.state.isdusk) or (TheWorld.state and TheWorld.state.isnight) then
			inst.Light:Enable(true)
			inst.AnimState:PlayAnimation("diandeng_on")
		end
	end)
	inst:WatchWorldState("isday", function(inst, isday)
		if isday then
			inst.Light:Enable(false)
			inst.AnimState:PlayAnimation("diandeng_off")
		else
			inst.Light:Enable(true)
			inst.AnimState:PlayAnimation("diandeng_on")
		end
	end)
	inst:ListenForEvent("onbuilt", function()
		if (TheWorld.state and TheWorld.state.isdusk) or (TheWorld.state and TheWorld.state.isnight) then
			inst.Light:Enable(true)
			inst.AnimState:PlayAnimation("diandeng_on")
		end
	end)
	return inst
end
local function chongdian(inst, doer)
	local function itemtest(inst, item, slot)
		return item:HasTag("beerpowertool") or item:HasTag("buling_gun_dianchi")
	end
	local slotpos = {Vector3(0,0,0)}
	local widgetbuttoninfo = {
    text = "Charge",
    position = Vector3(0, -140, 0),
    fn = function(inst, doer)
		local item = inst.components.container:GetItemInSlot(1)
		if item and item:HasTag("beerpowertool") and item.components.finiteuses then
			local beer = item.components.finiteuses.total - item.components.finiteuses.current
			if beer > 0 then
				if inst.components.beerpower.power >= beer then
					inst.components.beerpower:UpBeer(beer)
					item.components.finiteuses:Use(-beer)
					item.repair(item,item.buling_name,item.symbol)
					--repair(item,item.buling_name,item.symbol)
				else 
					local bp = inst.components.beerpower.power
					inst.components.beerpower:UpBeer(bp)
					item.components.finiteuses:Use(-bp)
					item.repair(item,item.buling_name,item.symbol)
					--repair(item,item.buling_name,item.symbol)
				end
			end
		end
		if item and item:HasTag("buling_gun_dianchi") and item.components.beerpower then
			local beer = item.components.beerpower.PowerMax - item.components.beerpower.power
			if beer > 0 then
				if inst.components.beerpower.power >= beer then
					inst.components.beerpower:UpBeer(beer)
					item.components.beerpower:UpBeer(-beer)
				else 
					local bp = inst.components.beerpower.power
					inst.components.beerpower:UpBeer(bp)
					item.components.beerpower:UpBeer(-bp)
				end
			end
		end
	end, }
	local inst= commonfn(inst)
	inst.displaynamefn = get_name
	inst.AnimState:PlayAnimation("ai_aff")
	inst.components.beerpower:SetNumber(200)
	inst:AddComponent("container")
    inst.components.container:SetNumSlots(1.1)
	inst.components.container.widgetslotpos = slotpos
	inst.components.container.widget = { slotpos = inst.components.container.widgetslotpos, animbank = inst.components.container.widgetanimbank or 'ui_chest_3x3', animbuild = inst.components.container.widgetanimbuild or 'ui_chest_3x3', pos = inst.components.container.widgetpos or Vector3(0,200,0), buttoninfo = inst.components.container.widgetbuttoninfo, side_align_tip = 100 }
    inst.components.container.widgetanimbank = "ui_chest_3x3"
    inst.components.container.widgetanimbuild = "ui_chest_3x3"
    inst.components.container.widgetpos = Vector3(0,200,0)
    inst.components.container.side_align_tip = 100
	inst.components.container.widgetbuttoninfo = widgetbuttoninfo
	inst.components.container.itemtestfn = itemtest
	inst.components.container.canbeopened = true
	inst.components.container.type = "buling_gun"
	inst.beeritem = "buling_chongdianqi_item"
	return inst
end
local function bulingbox(inst, doer)
	local slotpos = {}
	for y = 4, 0, -1 do
		for x = 0, 4 do
			table.insert(slotpos, Vector3(80*x-80*2, 80*y-80*2,0))
		end
	end
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    MakeObstaclePhysics(inst, .5)
    inst:AddComponent("inspectable")
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
    inst.AnimState:PlayAnimation("chest")
	inst:AddComponent("container")
	inst.components.container:SetNumSlots(#slotpos)
	inst.components.container.widgetslotpos = slotpos
	inst.components.container.widget = { slotpos = inst.components.container.widgetslotpos, animbank = inst.components.container.widgetanimbank or 'ui_chest_3x3', animbuild = inst.components.container.widgetanimbuild or 'ui_chest_3x3', pos = inst.components.container.widgetpos or Vector3(0,200,0), buttoninfo = inst.components.container.widgetbuttoninfo, side_align_tip = 100 }
    inst.components.container.widgetpos = Vector3(-50,100,0)
    inst.components.container.side_align_tip = 100
	inst.components.container.widgetanimbank = "ui_bundle_2x2"
    inst.components.container.widgetanimbuild = "ui_buling_chest_5x5"
	inst.beeritem = "buling_chest_item"
	return inst
end
--化学台
local function bulingchemistrytable(inst, doer)
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    MakeObstaclePhysics(inst, .5)
	inst.Transform:SetScale(1.5, 1.5, 1.5)
    inst:AddComponent("inspectable")
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
    inst.AnimState:PlayAnimation("yanjiuzhuo")
	inst.beeritem = "buling_chemistrytable_item"
	return inst
end
--缝纫机
local function buling_fengrenji(inst, doer)
	local function OnOpen(inst, doer)
		local _target = doer or inst
		if _target and _target.PushEvent then _target:PushEvent("OpenBuling_cloth") end
	end
	local function OnClose(inst, doer)
		local _target = doer or inst
		if _target and _target.PushEvent then _target:PushEvent("CloseBuling_cloth") end
	end
	local widgetbuttoninfo = {
	text = "Do",
	position = Vector3(0, -140, 0),
	fn = function(inst, doer)
		local peifang = ""
		local opener = doer or (inst.components.container and inst.components.container.openers and next(inst.components.container.openers)) or inst.components.container.opener or inst
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
		for k,v in pairs(hechengbiao_clothes) do
			if v[1] == peifang then
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
						if item.components.stackable and item.components.stackable.stacksize > 1 then
							item.components.stackable:SetStackSize(item.components.stackable.stacksize - 1)
						else
							item:Remove()
						end
					end
				end
			end
		end
	--将裤子和衣服缝到一起
		local targetitem = inst.components.container:GetItemInSlot(2)
		local targetitem2 = inst.components.container:GetItemInSlot(8)
		if targetitem and targetitem2 and targetitem:HasTag("buling_clothe") and targetitem2:HasTag("buling_trouser") then
			local clothe = SpawnPrefab("buling_overcoat")
			clothe.bodyanim = targetitem.bodyanim
			if clothe.clthesfn[clothe.bodyanim] then
				clothe.clthesfn[clothe.bodyanim](clothe)
			end
			clothe.leganim = targetitem2.leganim
			clothe.clothetime = targetitem2.clothetime
			clothe.components.fueled:InitializeFuelLevel(clothe.clothetime)
			clothe.components.fueled:DoDelta(-1)
			opener.components.inventory:GiveItem(clothe)
			targetitem:Remove()
			targetitem2:Remove()
		end
	end}
	--local slotpos = {Vector3(0,80,0),Vector3(0,-80,0)}
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    MakeObstaclePhysics(inst, .5)
	--inst.Transform:SetScale(1.5, 1.5, 1.5)
    inst:AddComponent("inspectable")
	inst.AnimState:SetBank("buling_box_2")
    inst.AnimState:SetBuild("buling_box_2")
    inst.AnimState:PlayAnimation("fengrenji")
	inst.beeritem = "buling_fengrenji_item"
	inst:AddComponent("container")
	inst.components.container:SetNumSlots(#slotpos)
	inst.components.container.widgetslotpos = slotpos
	inst.components.container.widget = { slotpos = inst.components.container.widgetslotpos, animbank = inst.components.container.widgetanimbank or 'ui_chest_3x3', animbuild = inst.components.container.widgetanimbuild or 'ui_chest_3x3', pos = inst.components.container.widgetpos or Vector3(0,200,0), buttoninfo = inst.components.container.widgetbuttoninfo, side_align_tip = 100 }
    inst.components.container.widgetpos = Vector3(0,200,0)
    inst.components.container.side_align_tip = 100
	inst.components.container.widgetanimbank = "ui_chest_3x3"
    inst.components.container.widgetanimbuild = "ui_chest_3x3"
	inst.components.container.widgetbuttoninfo = widgetbuttoninfo
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
	--inst.components.container.acceptsstacks = false
	return inst
end
local function planttable(inst, doer)
	local widgetbuttoninfo = {
	text = "Do",
	position = Vector3(0, -140, 0),
	fn = function(inst, doer)
		local peifang = ""
		local opener = doer or (inst.components.container and inst.components.container.openers and next(inst.components.container.openers)) or inst.components.container.opener or inst
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
		for k,v in pairs(seedhechengbiao) do
			if v[1] == peifang then
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
						if item.components.stackable and item.components.stackable.stacksize > 1 then
							item.components.stackable:SetStackSize(item.components.stackable.stacksize - 1)
						else
							item:Remove()
						end
					end
				end
			end
		end
	end}
	local function OnOpen(inst, doer)
		local _target = doer or inst
		if _target and _target.PushEvent then _target:PushEvent("OpenBuling_planttable") end
	end
	local function OnClose(inst, doer)
		local _target = doer or inst
		if _target and _target.PushEvent then _target:PushEvent("CloseBuling_planttable") end
	end
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst:AddComponent("inspectable")
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
	inst.AnimState:PlayAnimation("planttable")
	inst.displaynamefn = get_name
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
	inst.beeritem = "buling_planttable_item"
	return inst
end
--人力发电
local function huosaifadian(inst, doer)
	local function turnon(inst, doer)
		inst.components.machine.ison = true
		inst.AnimState:PlayAnimation("huosaifadian2")
		inst.AnimState:PushAnimation("huosaifadian")
		inst.components.beerpower:StartPerishing()
		local pos = Vector3(inst.Transform:GetWorldPosition())
		local ents = TheSim:FindEntities(pos.x,pos.y,pos.z,15)
			for k,v in pairs(ents) do
				if v and v.components.beerpower and 
					v.components.beerpower.PowerMax > 0 and  
					v.components.beerpower.power < v.components.beerpower.PowerMax and
					v:HasTag("zhongjiqi") then
					v.components.beerpower:UpBeer(-2)
					break
				end
			end
		inst:DoTaskInTime(1,function()
			inst.components.machine:TurnOff()
		end)
	end
	local function turnoff(inst, doer)
		inst.components.machine.ison = false
		inst.AnimState:PlayAnimation("huosaifadian2")
	end
	local inst=commonfn(inst)
	MakeObstaclePhysics(inst, .5)
	--inst.Transform:SetScale(2, 2, 2)
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
	inst.AnimState:PlayAnimation("huosaifadian")
	inst:AddComponent("machine")
    inst.components.machine.turnonfn = turnon
    inst.components.machine.turnofffn = turnoff
	inst.components.machine.cooldowntime = 1
	inst.beeritem = "buling_huosai_item"
	inst:AddTag("bp_source")
	return inst
end
local function wakuang(inst, doer)
	local function chukuang(inst, doer,kuangwu)
		--for k = 1, math.random(1,5) do
			local nug = SpawnPrefab(kuangwu)
			local pt = Vector3(inst.Transform:GetWorldPosition()) + Vector3(0,4.5,0)
                
			nug.Transform:SetPosition(pt:Get())
			local down = TheCamera:GetDownVec()
			local angle = math.atan2(down.z, down.x) + (math.random()*60-30)*DEGREES
			local sp = math.random()*4+2
			nug.Physics:SetVel(sp*math.cos(angle), math.random()*2+8, sp*math.sin(angle))
		--end
	end
	local function task(inst, doer)
		inst.components.workable.workleft = inst.components.workable.workleft - 1
		inst.components.beerpower:UpBeer(75)
		local kuangwuzhi = math.random(1,150)
		local kuangwu = "rocks"
		if kuangwuzhi < 5 then
			kuangwu = "nitre"
		elseif kuangwuzhi > 5 and kuangwuzhi < 10 then
			kuangwu = "flint"
		elseif kuangwuzhi > 10 and kuangwuzhi < 40 then
			kuangwu = "charcoal"
		elseif kuangwuzhi > 40 and kuangwuzhi < 50 then
			kuangwu = "flint"
		elseif kuangwuzhi > 50 and kuangwuzhi < 60 then
			kuangwu = "nitre"
		elseif kuangwuzhi > 60 and kuangwuzhi < 70 then
			kuangwu = "iron"
		elseif kuangwuzhi > 70 and kuangwuzhi < 80 then
			kuangwu = "marble"
		elseif kuangwuzhi > 80 and kuangwuzhi < 90 then
			kuangwu = "goldnugget"
		elseif kuangwuzhi > 90 and kuangwuzhi < 100 then
			kuangwu = "seeds"
		elseif kuangwuzhi > 100 and kuangwuzhi < 110 then
			kuangwu = "tar"
		end
		chukuang(inst,kuangwu)
	end
	local inst=commonfn(inst)
	inst.AnimState:SetBank("wakuangji")
    inst.AnimState:SetBuild("wakuangji")
	inst.AnimState:PlayAnimation("idle",true)
	local function turnon(inst, doer)
		inst.components.machine.ison = true
		inst.AnimState:PlayAnimation("workpre")
		inst.AnimState:PushAnimation("worded",true)
		inst.wakuang = inst:DoTaskInTime(10,function()
			task(inst)
			inst.components.machine:TurnOff()
		end)
	end
	local function turnoff(inst, doer)
		if inst.wakuang then
			inst.wakuang:Cancel()
			inst.wakuang = nil
		end
		inst.components.machine.ison = false
		inst.AnimState:PlayAnimation("workpst")
		inst.AnimState:PushAnimation("idle",true)
	end	
	inst:AddComponent("workable")
	inst.components.workable.savestate = true
	inst.components.workable:SetWorkAction(ACTIONS.BEER)
	inst.components.workable:SetWorkLeft(10)
	inst:AddComponent("trader")
	inst:AddComponent("machine")
    inst.components.machine.turnonfn = turnon
    inst.components.machine.turnofffn = turnoff
	inst.components.machine.cooldowntime = 1
	inst.Transform:SetScale(2, 2, 2)
	inst.beeritem = "buling_wakuang_item"
	
	inst.components.trader:SetAcceptTest(
		function(inst, doer, item)
			if inst.components.workable.workleft > 0 then
				local _target = doer or inst
				_target.components.talker:Say(STRINGS.CAVEBUILD)
			end
			return item.prefab == "buling_cave_tool" and inst.components.workable.workleft <= 0
		end)
	inst.components.trader.onaccept = function(inst, giver, item)
		SpawnPrefab("cloudpuff").Transform:SetPosition(inst.Transform:GetWorldPosition())
		SpawnPrefab("buling_cave_entrance").Transform:SetPosition(inst.Transform:GetWorldPosition())
		inst:Remove()
	end
	return inst
end
--高压电力中继器
local function gaoyazhongjiqi(inst, doer)
	local function task(inst, doer)
		local task = inst:DoPeriodicTask(5,function()
			--print("e")
		if inst.components.beerpower.power >= 25 and inst.components.machine.ison == true then
			local pos = Vector3(inst.Transform:GetWorldPosition())
			local ents = TheSim:FindEntities(pos.x,pos.y,pos.z,15)
				for k,v in pairs(ents) do
					if v and v.components.beerpower and 
						v.components.beerpower.PowerMax > 0 
						and not v:HasTag("buling_lingjian") 
						and v.components.beerpower.power < v.components.beerpower.PowerMax
						and not v:HasTag("zhongjiqi") then
						v.components.beerpower:UpBeer(-25)
						inst.components.beerpower:UpBeer(25)
					end
				end
				else
				inst.components.machine:TurnOff()
				if inst.task then
					inst.task:Cancel()
					inst.task = nil
				end
			end
		end)
		return task
	end
	local function turnon(inst, doer)
		inst.components.machine.ison = true
		inst.AnimState:PlayAnimation("zhongjiqi_on")
		inst.task = task(inst)
		if inst.components.beerpower.power < 25 then
			inst:DoTaskInTime(0,function()
				inst.components.machine:TurnOff()
				if inst.task then
					--print("bbb1")
					inst.task:Cancel()
					inst.task = nil
				end
			end)
		end
	end
	local function turnoff(inst, doer)
		inst.components.machine.ison = false
		inst.AnimState:PlayAnimation("zhongjiqi_off")
		if inst.task then
			--print("bbb")
			inst.task:Cancel()
			inst.task = nil
		end
	end	
	local inst=commonfn(inst)
	MakeObstaclePhysics(inst, 1)
	inst.Transform:SetScale(2, 2, 2)
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
	inst.AnimState:PlayAnimation("zhongjiqi_off")
	inst:AddComponent("machine")
    inst.components.machine.turnonfn = turnon
    inst.components.machine.turnofffn = turnoff
	inst.components.beerpower:SetNumber(2000)
	inst.components.machine.caninteractfn = function() return inst.components.beerpower and inst.components.beerpower.power > 25 end
	inst:AddTag("zhongjiqi")
	inst.beeritem = "buling_zhongjiqi_gaoya_item"
	return inst
end
local function buling_bileizhen(inst, doer)
	local function onlightning(inst, doer, data)
		if data.rod == inst then
			inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
			inst.components.beerpower:UpBeer(-200)
		end
	end
	local function task(inst, doer)
		local task = inst:DoPeriodicTask(5,function()
			--print("e")
		if inst.components.beerpower.power >= 10 then
			inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
			local pos = Vector3(inst.Transform:GetWorldPosition())
			local ents = TheSim:FindEntities(pos.x,pos.y,pos.z,15)
				for k,v in pairs(ents) do
					if v and v.components.beerpower and 
						v.components.beerpower.PowerMax > 0 
						and v.components.beerpower.power < v.components.beerpower.PowerMax
						and v:HasTag("zhongjiqi") then
						v.components.beerpower:UpBeer(-10)
						inst.components.beerpower:UpBeer(10)
					end
				end
			else
				inst.AnimState:SetBloomEffectHandle("")
			end
		end)
		return task
	end
	local inst=commonfn(inst)
	MakeObstaclePhysics(inst, 1)
	inst.Transform:SetScale(2, 2, 2)
	inst.task = task(inst)
	inst:AddTag("lightningrod")
	inst.lightningpriority = 0
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
	inst.AnimState:PlayAnimation("bileizhen")
	inst.components.beerpower:SetNumber(2000)
	inst:AddTag("buling_lingjian")
	inst.beeritem = "buling_bileizhen_item"
	inst:ListenForEvent("lightningstrike", function(inst, data) onlightning(inst, data) end)
	return inst
end
local function ronglufn2()
	local function removesockets(inst, doer)
		if inst.dizuo then
			inst.dizuo:Remove()
		end
	end
	local function itemtest(inst, item, slot)
		if slot == 1 and shaozhibiao[item.prefab] ~= nil  then
			return true
		end
		if slot == 2 then
			return true
		end
		
	end
	local function duidie(inst, doer,itemname)
		local item2 = inst.components.container:GetItemInSlot(2)
		if item2 and item2.prefab == itemname and (item2.components.stackable and not item2.components.stackable:IsFull()) then
			item2.components.stackable:SetStackSize(item2.components.stackable.stacksize+1)
		else
			inst.components.container:GiveItem(SpawnPrefab(itemname), 2)
		end
		inst:DoTaskInTime(0,function()
			local pos = inst:GetPosition()
			local ents = TheSim:FindEntities(pos.x,0, pos.z, 1, nil, {"FX", "DECOR", "INLIMBO"})
			for k,v in pairs(ents) do
				local pt = Vector3(inst.Transform:GetWorldPosition())
				local p_angle = v:GetAngleToPoint(pt:Get())
				if p_angle >= 360 then
					p_angle = p_angle - 360
				end
				if item2 and v.prefab == "buling_jixiebi" and (p_angle-v.angle > -190 and p_angle-v.angle < -170)  then
					v.components.trader:AcceptGift(inst,item2)
					break
				end
			end
		end)
	end
	local function zidongcuiqu(inst, doer)
		local item = inst.components.container:GetItemInSlot(1)
		if item then
			if shaozhibiao[item.prefab] ~= nil then
				if inst.components.beerpower.power >= 10 then
					local replacement = shaozhibiao[item.prefab]
					if replacement then
						inst.components.container:ConsumeByName(item.prefab,1)
						duidie(inst,replacement)
						inst.components.beerpower:UpBeer(10)
						if inst and inst.PushEvent then inst:PushEvent("bulingFinishItemMake") end
					end
				end
			end
		end
	end
	local function OnOpen(inst, doer)
		local _target = doer or inst
		if _target and _target.PushEvent then _target:PushEvent("OpenBuling_cuiqu") end
	end
	local function OnClose(inst, doer)
		local _target = doer or inst
		if _target and _target.PushEvent then _target:PushEvent("CloseBuling_cuiqu") end
	end
	local slotpos = {Vector3(-80,0,0),Vector3(80,0,0)}
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize(2,0.75)
	inst.Transform:SetScale(.4, .4, .4)
	trans:SetFourFaced()
	inst.AnimState:SetBuild("buling_ronglu")
	inst.AnimState:SetBank("buling_ronglu")
	inst.AnimState:PlayAnimation("idle")
	inst:AddComponent("inspectable")
	inst:AddComponent("beerpower")
	inst.components.beerpower:SetNumber(2000)
	inst.displaynamefn = get_name
	inst:AddComponent("container")
	inst.components.container:SetNumSlots(#slotpos)
	inst.components.container.widgetslotpos = slotpos
	inst.components.container.widget = { slotpos = inst.components.container.widgetslotpos, animbank = inst.components.container.widgetanimbank or 'ui_chest_3x3', animbuild = inst.components.container.widgetanimbuild or 'ui_chest_3x3', pos = inst.components.container.widgetpos or Vector3(0,200,0), buttoninfo = inst.components.container.widgetbuttoninfo, side_align_tip = 100 }
    inst.components.container.widgetanimbank = "ui_chest_3x3"
    inst.components.container.widgetanimbuild = "ui_chest_3x3"
    inst.components.container.widgetpos = Vector3(0,200,0)
    inst.components.container.side_align_tip = 100
	inst.components.container.itemtestfn = itemtest
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
	inst.beeritem = "buling_ronglu2_item"
	inst:DoPeriodicTask(5,function()zidongcuiqu(inst)end)
	inst:DoTaskInTime(0,function() 
	inst.dizuo = SpawnPrefab("buling_fx")
	inst.dizuo.AnimState:SetOrientation( ANIM_ORIENTATION.OnGround )
	inst.dizuo.AnimState:SetLayer( LAYER_BACKGROUND )
	inst.dizuo.AnimState:SetSortOrder(2)
	inst.dizuo.AnimState:SetBank("buling_box")
    inst.dizuo.AnimState:SetBuild("buling_box")
    inst.dizuo.AnimState:PlayAnimation("zidonghecheng")
	inst.dizuo.Transform:SetPosition(inst.Transform:GetWorldPosition()) end)
	inst:ListenForEvent("onremove", removesockets)
	inst:ListenForEvent("bulingFinishItemMake",function()
		inst:DoTaskInTime(0,function()
			local tragetitem = inst.components.container:GetItemInSlot(2)
			local pos = inst:GetPosition()
			local ents = TheSim:FindEntities(pos.x,0, pos.z, 1, nil, {"FX", "DECOR", "INLIMBO"})
			for k,v in pairs(ents) do
				local pt = Vector3(inst.Transform:GetWorldPosition())
				local p_angle = v:GetAngleToPoint(pt:Get())
				if p_angle >= 360 then
					p_angle = p_angle - 360
				end
				if tragetitem and v.prefab == "buling_jixiebi" and (p_angle-v.angle > -190 and p_angle-v.angle < -170)  then
					v.components.trader:AcceptGift(inst,tragetitem)
					break
				end
			end
		end)	
	end)
	return inst
end
--未完成
--速冻
local function buling_icechest(inst, doer)
	local function itemtest(inst, item, slot)
		return item.prefab == "ice"
	end
	local slotpos = {Vector3(0,0,0)}
	local function task(inst, doer)
		local task = inst:DoPeriodicTask(30,function()
		if inst.components.beerpower.power >= 10 and inst.components.machine.ison == true and not inst.components.container:IsFull() then
			inst.components.container:GiveItem(SpawnPrefab("ice"), 1)
			inst.components.beerpower:UpBeer(10)
				else
				inst.components.machine:TurnOff()
				if inst.task then
					inst.task:Cancel()
					inst.task = nil
				end
			end
		end)
		return task
	end
	local function turnon(inst, doer)
		inst.components.machine.ison = true
		inst.AnimState:PlayAnimation("zhongjiqi_on")
		inst.task = task(inst)
		if inst.components.beerpower.power < 10 then
			inst:DoTaskInTime(0,function()
				inst.components.machine:TurnOff()
				if inst.task then
					inst.task:Cancel()
					inst.task = nil
				end
			end)
		end
	end
	local function turnoff(inst, doer)
		inst.components.machine.ison = false
		inst.AnimState:PlayAnimation("zhongjiqi_off")
		if inst.task then
			inst.task:Cancel()
			inst.task = nil
		end
	end	
	local inst=commonfn(inst)
	MakeObstaclePhysics(inst, 1)
	inst.Transform:SetScale(2, 2, 2)
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
	inst.AnimState:PlayAnimation("zhongjiqi_off")
	inst:AddComponent("machine")
    inst.components.machine.turnonfn = turnon
    inst.components.machine.turnofffn = turnoff
	inst.components.beerpower:SetNumber(320)
	inst.components.machine.caninteractfn = function() return inst.components.beerpower and inst.components.beerpower.power > 25 end
	inst:AddTag("zhongjiqi")
	inst.beeritem = "buling_zhongjiqi_gaoya_item"
	inst:AddComponent("container")
    inst.components.container.itemtestfn = itemtest
    inst.components.container:SetNumSlots(1.1)
    inst.components.container.widgetslotpos = slotpos
    inst.components.container.widget = { slotpos = inst.components.container.widgetslotpos, animbank = inst.components.container.widgetanimbank or 'ui_chest_3x3', animbuild = inst.components.container.widgetanimbuild or 'ui_chest_3x3', pos = inst.components.container.widgetpos or Vector3(0,200,0), buttoninfo = inst.components.container.widgetbuttoninfo, side_align_tip = 100 }
    inst.components.container.widgetanimbank = "ui_chest_3x3"
    inst.components.container.widgetanimbuild = "ui_chest_3x3"
    inst.components.container.widgetpos = Vector3(0,200,0)
    inst.components.container.side_align_tip = 160
	return inst
end
--捕虫
local function buling_bugchest(inst, doer)
	local function task(inst, doer)
		local task = inst:DoPeriodicTask(30,function()
		local names = {}--蝴蝶，蜜蜂，糖蛞蝓，豆虫，萤火虫
		local name = names[math.random(#names)]
		if inst.components.beerpower.power >= 10 and inst.components.machine.ison == true and not inst.components.container:IsFull() then
			inst.components.container:GiveItem(SpawnPrefab(name))
			inst.components.beerpower:UpBeer(10)
				else
				inst.components.machine:TurnOff()
				if inst.task then
					inst.task:Cancel()
					inst.task = nil
				end
			end
		end)
		return task
	end
	local function turnon(inst, doer)
		inst.components.machine.ison = true
		inst.AnimState:PlayAnimation("zhongjiqi_on")
		inst.task = task(inst)
		if inst.components.beerpower.power < 10 then
			inst:DoTaskInTime(0,function()
				inst.components.machine:TurnOff()
				if inst.task then
					inst.task:Cancel()
					inst.task = nil
				end
			end)
		end
	end
	local function turnoff(inst, doer)
		inst.components.machine.ison = false
		inst.AnimState:PlayAnimation("zhongjiqi_off")
		if inst.task then
			inst.task:Cancel()
			inst.task = nil
		end
	end	
	local inst=commonfn(inst)
	MakeObstaclePhysics(inst, 1)
	inst.Transform:SetScale(2, 2, 2)
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
	inst.AnimState:PlayAnimation("zhongjiqi_off")
	inst:AddComponent("machine")
    inst.components.machine.turnonfn = turnon
    inst.components.machine.turnofffn = turnoff
	inst.components.beerpower:SetNumber(300)
	inst.components.machine.caninteractfn = function() return inst.components.beerpower and inst.components.beerpower.power > 25 end
	inst:AddTag("zhongjiqi")
	inst.beeritem = "buling_zhongjiqi_gaoya_item"
	inst:AddComponent("container")
    inst.components.container:SetNumSlots(#slotpos)
    inst.components.container.widgetslotpos = slotpos
    inst.components.container.widget = { slotpos = inst.components.container.widgetslotpos, animbank = inst.components.container.widgetanimbank or 'ui_chest_3x3', animbuild = inst.components.container.widgetanimbuild or 'ui_chest_3x3', pos = inst.components.container.widgetpos or Vector3(0,200,0), buttoninfo = inst.components.container.widgetbuttoninfo, side_align_tip = 100 }
    inst.components.container.widgetanimbank = "ui_chest_3x3"
    inst.components.container.widgetanimbuild = "ui_chest_3x3"
    inst.components.container.widgetpos = Vector3(0,200,0)
    inst.components.container.side_align_tip = 160
	return inst
end
local function buling_stonechest(inst, doer)
	local slotpos = {Vector3(0,0,0)}
	local function task(inst, doer)
		local task = inst:DoPeriodicTask(60,function()
			local item = inst.components.container:GetItemInSlot(1)
			local names = {"rocks"}
			if inst.components.beerpower.power >= 10 and inst.components.machine.ison == true then
				
				if item then
					if item.prefab == "rocks" and item.components.stackable and not item.components.stackable:IsFull() then
						item.components.stackable:SetStackSize(item.components.stackable.stacksize+1)
					end
					if item:HasTag("buling_modular") then
						if item.prefab == "标准处理器" then
							names = {}--岩石，燧石，硝石，金块
						elseif item.prefab == "迪斯瑞处理器" then
							names = {}--石灰石，沙子，石灰石，黑曜石
						elseif item.prefab == "剋钨处理器" then
							names = {}--铥碎片，噩梦燃料，岩石，蜗牛壳碎片
						elseif item.prefab == "平坦忒模拟器" then
							names = {}--铁，燧石，硝石，骨片
						end
						local name = names[math.random(#names)]
						item.components.container:GiveItem(SpawnPrefab(name),1)
					end
				else
					inst.components.container:GiveItem(SpawnPrefab("rocks"),1)
				end
				
				inst.components.beerpower:UpBeer(10)
			else
				inst.components.machine:TurnOff()
				if inst.task then
					inst.task:Cancel()
					inst.task = nil
				end
			end
		end)
		return task
	end
	local function turnon(inst, doer)
		inst.components.machine.ison = true
		inst.AnimState:PlayAnimation("zhongjiqi_on")
		inst.task = task(inst)
		if inst.components.beerpower.power < 10 then
			inst:DoTaskInTime(0,function()
				inst.components.machine:TurnOff()
				if inst.task then
					inst.task:Cancel()
					inst.task = nil
				end
			end)
		end
	end
	local function turnoff(inst, doer)
		inst.components.machine.ison = false
		inst.AnimState:PlayAnimation("zhongjiqi_off")
		if inst.task then
			inst.task:Cancel()
			inst.task = nil
		end
	end	
	local inst=commonfn(inst)
	MakeObstaclePhysics(inst, 1)
	inst.Transform:SetScale(2, 2, 2)
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
	inst.AnimState:PlayAnimation("zhongjiqi_off")
	inst:AddComponent("machine")
    inst.components.machine.turnonfn = turnon
    inst.components.machine.turnofffn = turnoff
	inst.components.beerpower:SetNumber(300)
	inst.components.machine.caninteractfn = function() return inst.components.beerpower and inst.components.beerpower.power > 25 end
	inst:AddTag("zhongjiqi")
	inst.beeritem = "buling_zhongjiqi_gaoya_item"
	inst:AddComponent("container")
    inst.components.container:SetNumSlots(1.1)
    inst.components.container.widgetslotpos = slotpos
    inst.components.container.widget = { slotpos = inst.components.container.widgetslotpos, animbank = inst.components.container.widgetanimbank or 'ui_chest_3x3', animbuild = inst.components.container.widgetanimbuild or 'ui_chest_3x3', pos = inst.components.container.widgetpos or Vector3(0,200,0), buttoninfo = inst.components.container.widgetbuttoninfo, side_align_tip = 100 }
    inst.components.container.widgetanimbank = "ui_chest_3x3"
    inst.components.container.widgetanimbuild = "ui_chest_3x3"
    inst.components.container.widgetpos = Vector3(0,200,0)
    inst.components.container.side_align_tip = 160
	return inst
end
local function buling_yanjiutai(inst, doer)
	local function itemtest(inst, item, slot)
		return item.prefab == "buling_yanjiudian"
	end
	local slotpos = {Vector3(0,0,0)}
	local inst=commonfn(inst)
	MakeObstaclePhysics(inst, 1)
	--inst.Transform:SetScale(2, 2, 2)
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
	inst.AnimState:PlayAnimation("tongxuntai")
	inst.components.beerpower:SetNumber(300)
	inst.beeritem = "buling_yanjiutai_item"
	inst:AddComponent("container")
    inst.components.container:SetNumSlots(1.1)
    inst.components.container.widgetslotpos = slotpos
    inst.components.container.widget = { slotpos = inst.components.container.widgetslotpos, animbank = inst.components.container.widgetanimbank or 'ui_chest_3x3', animbuild = inst.components.container.widgetanimbuild or 'ui_chest_3x3', pos = inst.components.container.widgetpos or Vector3(0,200,0), buttoninfo = inst.components.container.widgetbuttoninfo, side_align_tip = 100 }
    inst.components.container.widgetanimbank = "ui_chest_3x3"
    inst.components.container.widgetanimbuild = "ui_chest_3x3"
    inst.components.container.widgetpos = Vector3(0,200,0)
    inst.components.container.side_align_tip = 160
	inst.components.container.itemtestfn = itemtest
	inst:DoPeriodicTask(60,function()
		if inst.components.beerpower.power >= 100 then
			local item = inst.components.container:GetItemInSlot(1)
			if item and item.prefab == "buling_yanjiudian" then
				if item.components.stackable.stacksize < item.components.stackable.maxsize then
					item.components.stackable:SetStackSize(item.components.stackable.stacksize+1)
					--item.components.stackable:SetStackSize(item.components.stackable.maxsize)
				end
			else
				inst.components.container:GiveItem(SpawnPrefab("buling_yanjiudian"),1)
			end
		end
	end)
	buling_recipes()
	return inst
end
--通讯台
local function tongxuntai(inst, doer)
	local function turnon(inst, doer)
		local _target = doer or inst
		if _target and _target.PushEvent then _target:PushEvent("Openbuling_communication") end
		inst.components.machine:TurnOff()
	end
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst:AddComponent("inspectable")
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
	inst.AnimState:PlayAnimation("leida")
	inst.Transform:SetScale(2,2,2)
	inst.beeritem = "buling_tongxuntai_item"
	inst:AddComponent("buling_system")
	return inst
end
--粉碎机
local function buling_fensui(inst, doer)
	local widgetbuttoninfo = {
	text = "Remove",
	position = Vector3(0, -140, 0),
	fn = function(inst, doer)
		if inst.components.beerpower.power >= 50 then 
			for k=1,9 do
				local item = inst.components.container:GetItemInSlot(k)
				print(k)
				if item then
					if not item:HasTag("irreplaceable") then
						item:Remove()
					end
				end
			end
		else
			local _target = doer or inst
			_target.components.talker:Say(STRINGS.BULING_BWNG..STRINGS.BULING_BWNG2)
		end
	end}
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst:AddComponent("inspectable")
	inst.AnimState:SetBank("buling_zaxiang")
    inst.AnimState:SetBuild("buling_zaxiang")
	inst.AnimState:PlayAnimation("lingjian_off")
	inst:AddComponent("beerpower")
	inst.components.beerpower:SetNumber(500)
	inst.displaynamefn = get_name
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
	inst.beeritem = "buling_fensui_item"
	return inst
end
return Prefab("buling_manual", buling_manual, assets),--合成台
Prefab("buling_diandeng", diandeng, assets),--电灯
Prefab("buling_lamp", diandeng2, assets),--电灯
Prefab("buling_wakuang", wakuang, assets),--挖矿机
Prefab("buling_huosai", huosaifadian, assets),--人力发电
Prefab("buling_chongdianqi", chongdian, assets),--充电器
Prefab("buling_shengcun", shengcun, assets),--生存发电机
Prefab("buling_zhongjiqi", zhongjiqi, assets),--电力中继器
Prefab("buling_bileizhen", buling_bileizhen, assets),--避雷针发电机
Prefab("buling_zhongjiqi_gaoya", gaoyazhongjiqi, assets),--高压中继器
Prefab("buling_solarenergy", buling_solarenergy, assets),--太阳能发电机
Prefab("buling_ronglu", ronglufn, assets),--萃取机
Prefab("buling_ronglu2", ronglufn2, assets),--萃取机Mk2
Prefab("buling_chemistrytable", bulingchemistrytable, assets),--化学台
Prefab("buling_fensui", buling_fensui, assets),--粉碎机
--Prefab("buling_icechest", buling_icechest, assets),--速冻厂
--Prefab("buling_bugchest", buling_bugchest, assets),--捕虫箱
--Prefab("buling_stonechest", buling_stonechest, assets),--造石机
Prefab("buling_seedbox", buling_seedbox, assets),--作物管家
Prefab("buling_yanjiutai", buling_yanjiutai, assets),--研究台
Prefab("buling_weaponchest", buling_weaponchest, assets),--机械加工炉
Prefab("buling_cropbox", shouhuo, assets),--采集者
Prefab("buling_tongxuntai", tongxuntai, assets),--通讯台
Prefab("buling_radar", radar, assets),--雷达(已移除)
Prefab("buling_fengrenji", buling_fengrenji, assets),--雷达(已移除)
Prefab("buling_repair_box", buling_repair_box, assets),--强化炮塔
Prefab("buling_paotai", paotai, assets),--简易炮台
Prefab("buling_chest", bulingbox, assets),--合金储存箱
Prefab("buling_planttable", planttable, assets),--植物改良桌
MakePlacer("buling_manual_placer", "buling_manual", "buling_manual", "idle"),
MakePlacer("buling_planttable_placer", "buling_box", "buling_box", "planttable"),
MakePlacer("buling_wakuang_placer", "wakuangji", "wakuangji", "idle"),
MakePlacer("buling_chest_placer", "buling_box", "buling_box", "chest"),
MakePlacer("buling_fengrenji_placer", "buling_box_2", "buling_box_2", "fengrenji"),
MakePlacer("buling_ronglu_placer", "buling_ronglu", "buling_ronglu", "idle")