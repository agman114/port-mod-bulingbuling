local function SendBulingRPC(rpc_name, ...)
	local rpc = (TheSim and TheSim.GetModRPC and TheSim:GetModRPC("bulingbuling", rpc_name))
		or (GLOBAL and GLOBAL.GetModRPC and GLOBAL.GetModRPC("bulingbuling", rpc_name))
		or (GLOBAL and GLOBAL.MOD_RPC and GLOBAL.MOD_RPC["bulingbuling"] and GLOBAL.MOD_RPC["bulingbuling"][rpc_name])
	if rpc then
		SendModRPCToServer(rpc, ...)
	end
end

local assets ={
}
local hechengbiao = { 
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
--料理台
["buling_cooktable_item"]={"buling_zhongziding,buling_zhongziding,buling_zhongziding,buling_zhongziding,nil,buling_zhongziding,nil,nil,nil,"},
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
--标准枪管
["buling_gun_qiangguan"]={"buling_zhongziding,buling_zhongziding,buling_zhongziding,nil,nil,nil,buling_zhongziding,buling_zhongziding,buling_zhongziding,"},
--阳极枪管
["buling_gun_qiangguan_yang"]={"buling_glass,nil,nil,buling_puleidi,buling_gun_qiangguan,buling_glass,buling_glass,nil,nil,"},
--制式电池
["buling_gun_dianchi"]={"nil,buling_zhongziding,nil,buling_glass,buling_zhongjiqi_item,buling_glass,nil,buling_zhongziding,nil,"},
--通量电池
["buling_gun_dianchi_tongliang"]={"nil,buling_zhongjiqi_gaoya_item,nil,buling_zhongziding,buling_gun_dianchi,buling_zhongziding,buling_glass,nil,buling_glass,"},
--标准手柄
["buling_gun_shoubing"]={"buling_zhongziding,nil,nil,buling_zhongziding,buling_zhongziding,buling_zhongziding,buling_zhongziding,nil,nil,"},
--标枪手柄
["buling_gun_shoubing_biaoqiang"]={"buling_glass,nil,nil,buling_glass,buling_glass,buling_glass,buling_glass,nil,nil,"},
--激光引导器
["buling_gun_jiguang"]={"buling_glass,nil,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,nil,buling_glass,"},
--格拉斯引导器
["buling_gun_jiguang_yaoshou"]={"buling_puleidi,nil,nil,buling_glass,buling_gun_jiguang,buling_glass,buling_puleidi,nil,nil,"},
--塞德锭
["buling_zhongziding"]={"seeds,nil,seeds,nil,goldnugget,nil,seeds,nil,seeds,"}, 
--肥料
["buling_manure"]={"nil,ash,nil,ash,nitre,ash,nil,ash,nil,"}, 
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
["buling_zhongziding"]={"seeds,nil,seeds,nil,goldnugget,nil,seeds,nil,seeds,"}, 
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
--电线杆
["buling_dianxiangan_item"]={"buling_glass,transistor,buling_glass,buling_glass,transistor,buling_glass,buling_glass,buling_glass,buling_glass,"},
--贝塔聚合酶
["buling_juhemei_beta"]={"buling_juhemei_alpha,buling_juhemei_alpha,buling_juhemei_alpha,buling_juhemei_alpha,buling_juhemei_alpha,buling_juhemei_alpha,buling_juhemei_alpha,buling_juhemei_alpha,buling_juhemei_alpha,"},
--注射器
["buling_zhusheqi"]={"nil,buling_glass,nil,nil,buling_glass,nil,buling_glass,buling_zhongziding,buling_glass,"},
["buling_cook_kaopan"]={"nil,nil,nil,goldnugget,goldnugget,goldnugget,nil,nil,nil,"},
	["buling_cook_guo"]={"nil,nil,nil,rocks,nil,rocks,rocks,rocks,rocks,"},
	["buling_cook_caidao"]={"nil,nil,nil,flint,flint,twigs,flint,flint,flint,"},
	["buling_bread"] = {"nil,nil,nil,nil,buling_flour,nil,nil,buling_cook_kaopan,nil,"},
	["buling_xifan"] = {"nil,nil,nil,nil,buling_flour,nil,nil,buling_cook_guo,nil,"},
	["buling_hongguzhou"] = {"nil,red_cap,nil,nil,buling_xifan,nil,nil,buling_cook_guo,nil,"},
	["buling_languzhou"] = {"nil,blue_cap,nil,nil,buling_xifan,nil,nil,buling_cook_guo,nil,"},
	["buling_lvguzhou"] = {"nil,green_cap,nil,nil,buling_xifan,nil,nil,buling_cook_guo,nil,"},
	["buling_honggumianbao"] = {"nil,red_cap,nil,nil,buling_bread,nil,nil,buling_cook_caidao,nil,"},
	["buling_suanrongguhe"] = {"nil,nil,nil,red_cap,blue_cap,green_cap,nil,buling_cook_kaopan,nil,"},
	["buling_sangubao"] = {"red_cap,blue_cap,green_cap,nil,buling_xifan,nil,nil,buling_cook_guo,nil,"},
	["buling_moguhanbao"] = {"buling_bread,nil,buling_bread,red_cap,blue_cap,green_cap,nil,buling_cook_caidao,nil,"},
	["buling_mogutang"] = {"nil,nil,nil,red_cap,blue_cap,green_cap,nil,buling_cook_guo,nil,"},
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
	["buling_shucaishala"] = {"buling_cream,buling_shucaisui,buling_cream,buling_shucaisui,buling_shucaisui,buling_shucaisui,nil,buling_cook_caidao,nil,"},
	["buling_suanrongmianbao"] = {"nil,buling_shucaisui,nil,nil,buling_bread,nil,nil,buling_cook_caidao,nil,"},
	["buling_zhawanzi"] = {"buling_shucaisui,buling_flour,buling_shucaisui,buling_flour,buling_shucaisui,buling_flour,nil,buling_cook_kaopan,nil,"},
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
local alcohol ={}
local function buling_alcoholtable(inst, doer)
	local widgetbuttoninfo = {
	text = "Do",
	position = Vector3(0, -140, 0),
	fn = function(inst, doer)
		if not TheWorld.ismastersim then
			SendBulingRPC("do_widget_button", inst.GUID)
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
		for k,v in pairs(alcohol) do
			if v[1] == peifang then
				inst.components.container:DestroyContents()
				inst.components.container:GiveItem(SpawnPrefab(k), 5)
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
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, .5)
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
	inst.AnimState:PlayAnimation("planttable")
	inst:AddTag("structure")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

    inst:AddComponent("inspectable")
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
	inst.components.container.acceptsstacks = false
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
	inst.beeritem = "buling_planttable_item"
	return inst
end
local function commonfn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, .5)
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
	inst:AddTag("structure")

	inst:AddComponent("inspectable")
	inst:AddComponent("beerpower")
	inst.displaynamefn = get_name
    return inst
end
local function dianxiangan(inst, doer)
	local function task(inst, doer)
		local task = inst:DoPeriodicTask(1,function()
			--print("e")
		if inst.components.beerpower.power >= 5  then
			local pos = Vector3(inst.Transform:GetWorldPosition())
			local ents = TheSim:FindEntities(pos.x,pos.y,pos.z,15)
				for k,v in pairs(ents) do
					if v and v.components.beerpower and 
						v.components.beerpower.PowerMax > 0 
						and not v:HasTag("buling_lingjian") 
						and v.components.beerpower.power < v.components.beerpower.PowerMax 
						and v:HasTag("zhongjiqi")
						and not (v.prefab == "buling_dianxiangan" and inst.components.beerpower.power - 5 < v.components.beerpower.power)
						and not (v.prefab == "buling_dianxiangan" and v.components.beerpower.power >= inst.components.beerpower.power) then
						local power = 5
						--[[if v.components.beerpower.power < inst.components.beerpower.power and (inst.components.beerpower.power - v.components.beerpower.power) > 10 then
							power = math.floor((inst.components.beerpower.power - v.components.beerpower.power)/2)
						end]]
						v.components.beerpower:UpBeer(-power)
						inst.components.beerpower:UpBeer(power)
					end
				end
			end
		end)
		return task
	end
	local inst=commonfn(inst)
	MakeObstaclePhysics(inst, 1)
	inst.Transform:SetScale(2, 2, 2)
	inst.AnimState:PlayAnimation("paotai",true)
	inst:AddTag("zhongjiqi")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst.components.beerpower:SetNumber(100)
	inst.task = task(inst)
	inst:AddTag("zhongjiqi")
	inst.beeritem = "buling_dianxiangan_item"
	return inst
end
local function Onpick(item)
	if item.buling_chuansongdai then
		item.buling_chuansongdai:Cancel()
		item.buling_chuansongdai = nil
	end
end
local function OnGetItemFromPlayer(inst, doer, giver, item)
	item.Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst:RemoveEventCallback("onpickup", Onpick, item)
	if item.buling_chuansongdai then
		item.buling_chuansongdai:Cancel()
		item.buling_chuansongdai = nil
	end
	item:ListenForEvent("onpickup",Onpick,item)
	item.buling_chuansongdai = item:DoTaskInTime(0.5,function()
		local pos = inst:GetPosition()
		local ents = TheSim:FindEntities(pos.x,0, pos.z, 1, nil, {"FX", "DECOR", "INLIMBO"})
		for k,v in pairs(ents) do
			local pt = Vector3(v.Transform:GetWorldPosition())
			local p_angle = inst:GetAngleToPoint(pt:Get())
			if p_angle <= 0 then
				p_angle = p_angle + 360
			elseif p_angle > 360 then
				p_angle = p_angle - 360
			end
			if p_angle < 45 then p_angle = 0
			elseif p_angle < 145 then p_angle = 90
			elseif p_angle < 225 then p_angle = 180
			elseif p_angle < 360 then p_angle = 270
			end
			if inst.angle == p_angle and v.angle and v~= inst then
				v.components.trader:AcceptGift(inst,item)
				break
			elseif inst.prefab == "buling_jixiebi" and inst.angle == p_angle and v~= inst and v.components.container and not v.components.container:IsFull() then
				v.components.container:GiveItem(item)
			else
				--print(v,p_angle)
			end
		end
	end)
end
local function anglejiaozheng(angle)
	if angle > 360 then
		angle = angle - 360
	elseif angle <= 0 then
		angle = angle + 360
	end
	return angle
end
local function buling_chuansongdai(inst, doer)
	local slotpos = {Vector3(0,0,0)}
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
    inst.AnimState:PlayAnimation("chuansongdai")
	inst.AnimState:SetOrientation( ANIM_ORIENTATION.OnGround )
	inst.AnimState:SetLayer( LAYER_BACKGROUND )
	inst.AnimState:SetSortOrder(2)
	inst:AddTag("structure")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

    inst:AddComponent("inspectable")
	inst.pos = Vector3(inst.Transform:GetWorldPosition())
	inst.angle = anglejiaozheng(inst:GetAngleToPoint(inst.pos:Get()))
	inst.Transform:SetRotation(inst.angle)
	inst.beeritem = "buling_chuansongdai_item"
	inst.components.inspectable.getstatus = function(inst,viewer)
		inst.angle = math.floor(inst.angle + 90)
		inst.angle = anglejiaozheng(inst.angle)
		inst.Transform:SetRotation(inst.angle)
	end
	inst:AddComponent("trader")
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader.deleteitemonaccept = false
	local function onsave(inst, data)
		data = data or {}
		data.angle = inst.angle
	end
	local function onload(inst, data)
		if data.angle then
			inst.angle = data.angle
			inst.Transform:SetRotation(inst.angle)
		end
	end
	inst:DoTaskInTime(0.1,function()
		local pos = inst:GetPosition()
		local ents = TheSim:FindEntities(pos.x,0, pos.z, 1, nil, {"FX", "DECOR", "INLIMBO"})
		for k,v in pairs(ents) do
			if v.components.inventoryitem and 
			v.components.inventoryitem.canbepickedup 
			and v.components.inventoryitem.cangoincontainer and 
			not v.components.inventoryitem:IsHeld() and 
			not v.buling_chuansongdai and
			v.components.tradable  then
				inst.components.trader:AcceptGift(inst,v)
				break
			end
		end
	end)
	inst.OnSave = onsave
	inst.OnLoad = onload
	return inst
end
local function buling_jixiebi(inst, doer)
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
	local function turnon(inst, doer)
		inst.task = inst:DoPeriodicTask(1,function()
			local pos = inst:GetPosition()
			local ents = TheSim:FindEntities(pos.x,0, pos.z, 5, nil, {"FX", "DECOR", "INLIMBO"})
			if inst.components.beerpower.power >= 10 then
				for k,v in pairs(ents) do
					if v.components.inventoryitem and 
					v.components.inventoryitem.canbepickedup 
					and v.components.inventoryitem.cangoincontainer and 
					not v.components.inventoryitem:IsHeld() and 
					not v.buling_chuansongdai and
					v.components.tradable  then
						local pt = Vector3(v.Transform:GetWorldPosition())
						local p_angle = inst:GetAngleToPoint(pt:Get())
						if p_angle < 0 then
							p_angle = p_angle + 360
						elseif p_angle >= 360 then
							p_angle = p_angle - 360
						end
						if math.abs(p_angle - inst.angle) > 90 then
							inst.components.trader:AcceptGift(inst,v)
							inst.components.beerpower.UpBeer(10)
							break
						end
					end
				end
			end
		end)
	end
	local function turnoff(inst, doer)
		if inst.task then
			inst.task:Cancel()
			inst.task = nil
		end
	end
	local inst = buling_chuansongdai(inst)
	inst.AnimState:PlayAnimation("jixiebi")
	if not TheWorld.ismastersim then
		return inst
	end
	inst.beeritem = "buling_jixiebi_item"
	inst:AddComponent("beerpower")
	--inst:AddComponent("machine")
	inst.components.beerpower:SetNumber(200)
    --inst.components.machine.turnonfn = turnon
    --inst.components.machine.turnofffn = turnoff
	inst.displaynamefn = get_name
	return inst
end
local function buling_shuipei(inst, doer)
	local function setshuipei(inst, doer)
		for k,v in pairs(inst.components.objectspawner.objects) do
			print(k,v)
			if v and v:IsValid() then
				--print("这是我的植物")
				v.buling_shuipei = inst
				inst.buling_plants = v
			end
		end
	end
	local function ShouldAcceptItem(inst, doer, item)
		for k,v in pairs(inst.components.objectspawner.objects) do
			print(k,v)
			if v and v:IsValid() then
				return false
			end
		end
		if item:HasTag("buling_seed") and item.buling_plant then
			return true
		end
		return false
	end
	local function OnGetItemFromPlayer(inst, doer, giver, item)
		local pos = inst:GetPosition() 
		local part = inst.components.objectspawner:SpawnObject(item.buling_plant)
		part.Transform:SetPosition(pos.x, 0, pos.z)
		setshuipei(inst)
	end
	local slotpos = {Vector3(0,0,0)}
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
    inst.AnimState:PlayAnimation("shuipei")
	inst.AnimState:SetOrientation( ANIM_ORIENTATION.OnGround )
	inst.AnimState:SetLayer( LAYER_BACKGROUND )
	inst.AnimState:SetSortOrder(2)
	inst:AddTag("structure")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

    inst:AddComponent("inspectable")
	inst:AddComponent("objectspawner")
	inst.beeritem = "buling_shuipei_item"
	inst:AddComponent("trader")
	inst:DoTaskInTime(0,function()
		setshuipei(inst)
	end)
    inst.components.trader.onaccept = OnGetItemFromPlayer
	inst.components.trader:SetAcceptTest(ShouldAcceptItem)
    inst:ListenForEvent("buling_mature",function()
		inst:DoTaskInTime(0,function()
			local pos = inst:GetPosition()
			local ents = TheSim:FindEntities(pos.x,0, pos.z, 1.5, nil, {"FX", "DECOR", "INLIMBO"})
			for k,v in pairs(ents) do
				if v.prefab == "buling_jixiebi" then
					--inst.buling_plants.components.crop:StartGrowing(inst.buling_plants.grower, inst.buling_plants.time, inst.buling_plants,.5)
					inst.buling_plants.components.crop:Harvest(inst)
					local zuowu = SpawnPrefab(inst.buling_plants.grower)
					zuowu.Transform:SetPosition(v.Transform:GetWorldPosition())
					v.components.trader:AcceptGift(inst,zuowu)
					break
				end
			end
		end)	
	end)
	return inst
end
--自动合成台
local function removesockets(inst, doer)
	if inst.dizuo then
		inst.dizuo:Remove()
	end
end
local function buling_zidonghecheng(inst, doer)
	
	local slotpos = {}
	table.insert(slotpos, Vector3(-60,0,0))
	--table.insert(slotpos, Vector3(260,0,0))
	for y = 2, 0, -1 do
		for x = 0, 2 do
			table.insert(slotpos, Vector3(80*x-80+100, 80*y-80*2+80,0))
		end
	end
	local function cailiaoshouji(cailiaobiao)
		local resultStrList = {}
		string.gsub(cailiaobiao,'[^,]+',function (item)
			if item ~= "nil" then
				table.insert(resultStrList,item)
			end
		end)
		local tmp = {}
		for k,v in pairs (resultStrList) do
			tmp[v] = (tmp[v] or 0) +1
		end
		return tmp
	end
	local function panduancailiao(inst, doer,tmp)
		local itemfull = true
		for k,v in pairs (tmp) do 
			if  inst.components.container:Has(k,v) then
			else
				--print("这材料不够")
				itemfull = false
			end
		end
		if itemfull == true then
			return true
		else
			return false
		end
	end
	local function zidonghehceng(inst, doer,cailiaobiao)
		local tmp = cailiaoshouji(cailiaobiao)
		if panduancailiao(inst,tmp) then
			for k,v in pairs (tmp) do
				if k ~= "buling_cook_kaopan" and k~="buling_cook_guo" and k~="buling_cook_caidao" then
					inst.components.container:ConsumeByName(k,v)
				end
			end
			local tragetitem = inst.components.container:GetItemInSlot(1)
			if tragetitem then
				if tragetitem.components.stackable then
					tragetitem.components.stackable:SetStackSize(tragetitem.components.stackable.stacksize+1)
					if tragetitem.prefab == "buling_manure" then
						tragetitem.components.stackable:SetStackSize(tragetitem.components.stackable.stacksize+3)
					end
				else
					inst.components.container:GiveItem(SpawnPrefab(tragetitem.prefab))
				end
			end
			if inst and inst.PushEvent then inst:PushEvent("bulingFinishItemMake") end
		end
	end
	local function yuanbanhecheng(inst, doer,recipe)
		local loot = ""
		for k,v in ipairs(recipe.ingredients) do
			local amt = math.ceil(v.amount)
			for n = 1, amt do
                loot = loot..(v.type)..","
            end
        end
		zidonghehceng(inst,loot)
	end
	local function hehceng(inst, doer)
		if inst.task then
			inst.task:Cancel()
			inst.task = nil
		end
		local canmake = false
		local targetitem = inst.components.container:GetItemInSlot(1)
		if targetitem and inst.components.beerpower.power >= 25 then
			if targetitem.components.stackable and not targetitem.components.stackable:IsFull() then
				canmake = true
			end
		end
		if canmake == true then
			inst.task = inst:DoTaskInTime(2.5,function()
				if targetitem then
					inst.components.beerpower:UpBeer(25)
					local recipe = GetRecipe(targetitem.prefab)
					for k,v in pairs(hechengbiao) do
						if k == targetitem.prefab then
							zidonghehceng(inst,v[1])
							break
						end
					end
					if recipe then
						yuanbanhecheng(inst,recipe)
					end
				else
					if inst.task then
						inst.task:Cancel()
						inst.task = nil
					end
				end
			end)
		end
	end
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, .5)
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
    inst.AnimState:PlayAnimation("hecheng")
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
    inst.components.container.widgetanimbank = "ui_bundle_2x2"
    inst.components.container.widgetanimbuild = "ui_buling_chest_3x5"
    inst.components.container.widgetpos = Vector3(0,200,0)
    inst.components.container.side_align_tip = 100
	inst:AddComponent("beerpower")
	inst.components.beerpower:SetNumber(500)
	inst.Transform:SetScale(.4, .4, .4)
	inst.displaynamefn = get_name
	inst:DoTaskInTime(0,function() 
	inst.dizuo = SpawnPrefab("buling_fx")
	inst.dizuo.AnimState:SetOrientation( ANIM_ORIENTATION.OnGround )
	inst.dizuo.AnimState:SetLayer( LAYER_BACKGROUND )
	inst.dizuo.AnimState:SetSortOrder(2)
	inst.dizuo.AnimState:SetBank("buling_box")
    inst.dizuo.AnimState:SetBuild("buling_box")
    inst.dizuo.AnimState:PlayAnimation("zidonghecheng")
	inst.dizuo.Transform:SetPosition(inst.Transform:GetWorldPosition()) end)
	inst.beeritem = "buling_zidonghecheng_item"
	inst:ListenForEvent("bulingFinishItemMake",hehceng,inst)
	inst:ListenForEvent("itemget",hehceng,inst)
	inst:ListenForEvent("onremove", removesockets)
	inst:ListenForEvent("bulingFinishItemMake",function()
		inst:DoTaskInTime(0,function()
			local tragetitem = inst.components.container:GetItemInSlot(1)
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
local function buling_pilianghecheng(inst, doer)
	local inst = buling_zidonghecheng(inst)
	inst.Transform:SetScale(.4, .4, .4)
	if not TheWorld.ismastersim then
		return inst
	end
	
	inst.beeritem = "buling_zidonghecheng_item"
	
	
	inst:DoTaskInTime(0.1,function()
		inst.components.container:DropEverything()
		SpawnPrefab("buling_manual_item").Transform:SetPosition(inst:GetPosition():Get())
		SpawnPrefab("buling_weaponchest_item").Transform:SetPosition(inst:GetPosition():Get())
		for k=1,5 do
			SpawnPrefab("buling_glass").Transform:SetPosition(inst:GetPosition():Get())
		end
		for k=1,2 do
			SpawnPrefab("gears").Transform:SetPosition(inst:GetPosition():Get())
		end
		inst:Remove()
	end)
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
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, .5)
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
    inst.AnimState:PlayAnimation("chest")
	inst.Transform:SetScale(.4, .4, .4)
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
    inst.components.container.widgetpos = Vector3(-50,100,0)
    inst.components.container.side_align_tip = 100
	inst.components.container.widgetanimbank = "ui_bundle_2x2"
    inst.components.container.widgetanimbuild = "ui_buling_chest_5x5"
	inst.beeritem = "buling_chest_mini_item"
	inst.Transform:SetScale(.4, .4, .4)
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
	return inst
end
local function nuanqifn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, .5)
    inst.Light:Enable(true)
    inst.Light:SetRadius(1.0)
    inst.Light:SetFalloff(.9)
    inst.Light:SetIntensity(0.5)
    inst.Light:SetColour(235 / 255, 121 / 255, 12 / 255)
    inst.AnimState:SetBank("altar_grate")
    inst.AnimState:SetBuild("altar_grate")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetLightOverride(0.4)
    inst:AddTag("structure")
    inst:AddTag("wildfireprotected")
    inst:AddTag("cooker")
    inst:AddTag("HASHEATER")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("cooker")
    inst:AddComponent("lootdropper")
    inst:AddComponent("inspectable")
    --inst.components.inspectable.getstatus = getstatus
    inst:AddComponent("heater")
    inst.components.heater.heat = 115
    --MakeHauntableWork(inst)
    return inst
end
local function buling_infinitebox(inst, doer)
	local function itemtest(inst, item, slot)
		return item.prefab == "buling_chipbox" 
	end
	local function onopen(inst, doer) 
		inst.AnimState:PlayAnimation("infinitebox_open") 
		inst.SoundEmitter:PlaySound("dontstarve/common/craftable/icebox_open")
	end 
	
	local function onclose(inst, doer) 
		inst.AnimState:PlayAnimation("infinitebox_close") 
		inst.SoundEmitter:PlaySound("dontstarve/common/craftable/icebox_close")
	end 
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
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, .5)
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
    inst.AnimState:PlayAnimation("infinitebox_close")
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
    inst.components.container.widgetpos = Vector3(-50,200,0)
    inst.components.container.side_align_tip = 100
	inst.components.container.widgetanimbank = "ui_bundle_2x2"
    inst.components.container.widgetanimbuild = "ui_buling_chest_5x5"
	inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
	inst.components.container.itemtestfn = itemtest
	inst.beeritem = "buling_infinitebox_item"
	inst.components.container.CollectInventoryActions = function(self,doer, actions, right)
		return
	end
	return inst
end
return Prefab("buling_alcoholtable", buling_alcoholtable, assets),
Prefab("buling_jixiebi", buling_jixiebi, assets),
Prefab("buling_zidonghecheng", buling_zidonghecheng, assets),
Prefab("buling_pilianghecheng", buling_pilianghecheng, assets),
Prefab("buling_chuansongdai", buling_chuansongdai, assets),
Prefab("buling_nuanqi", nuanqifn, assets),
Prefab("buling_infinitebox", buling_infinitebox, assets),
Prefab("buling_dianxiangan", dianxiangan, assets),
Prefab("buling_chest_mini", bulingbox, assets),
Prefab("buling_shuipei", buling_shuipei, assets),
MakePlacer("buling_chuansongdai_placer", "buling_box", "buling_box", "chuansongdai",true,false, true,nil, nil, nil, "eight"),
MakePlacer("buling_shuipei_placer", "buling_box", "buling_box", "shuipei",true,false, true,nil, nil, nil, "eight")