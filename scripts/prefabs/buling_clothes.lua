local assets=
{
	Asset("ATLAS", "images/inventoryimages/buling_body_buttons_black_jet.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_body_cableknit_sweater_tan_khaki.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_body_cardigan_black_jet.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_body_expo_letterman_yellow_beige.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_body_expo_sweater_blue_agean.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_body_flannel_blue_snowbird.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_body_jacket_shearling_orange_salmon.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_body_jacket_toggle_navy_phthalo.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_body_dancer_dragon.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_body_outerwear_quilted_red_cardinal.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_body_overalls_blue_denim.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_body_pj_blue_agean.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_body_silk_eveningrobe_red_rump.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_legs_checkered_pleats_blue_cornflower.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_legs_jeans_black_scribble.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_legs_pants_basic_blue_sky.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_legs_pinstripe_pants_black_jet.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_legs_shorts_black_scribble.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_legs_swing_pants_brown_umber.xml"),
	Asset("ATLAS", "images/inventoryimages/bulingbuling_sikushui.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_christmas.xml"),
}
local clothes = TUNING.SWEATERVEST_PERISHTIME/10
local buling_clothes = {"body_buttons_black_jet","body_cableknit_sweater_tan_khaki","body_cardigan_black_jet","body_expo_letterman_yellow_beige","body_expo_sweater_blue_agean","body_flannel_blue_snowbird","body_jacket_shearling_orange_salmon","body_jacket_toggle_navy_phthalo","body_pj_blue_agean"}
local clthesfn = {
	["body_buttons_black_jet"] = function(inst, doer) --防暑120
		if not inst.components.insulator then inst:AddComponent("insulator") end
		inst.components.insulator:SetInsulation(TUNING.INSULATION_MED)
		inst.components.insulator:SetSummer()
	end,
	["body_cableknit_sweater_tan_khaki"] = function(inst, doer) --保暖120
		if not inst.components.insulator then inst:AddComponent("insulator") end
		inst.components.insulator:SetInsulation(TUNING.INSULATION_MED)
		inst.components.insulator:SetWinter()
	end,
	["body_cardigan_black_jet"] = function(inst, doer) --绅士
		inst.components.equippable.dapperness = TUNING.DAPPERNESS_MED*2
	end,
	["body_expo_letterman_yellow_beige"] = function(inst, doer) --移速
		inst.components.equippable.dapperness = TUNING.DAPPERNESS_MED
		inst.components.equippable.walkspeedmult = TUNING.CANE_SPEED_MULT*2
	end,
	["body_expo_sweater_blue_agean"] = function(inst, doer) --防暑96保暖96
		if not inst.components.insulator then inst:AddComponent("insulator") end
		local function OnSeasonChange(inst, doer, data) 
			inst.components.insulator:SetInsulation(TUNING.INSULATION_MED*0.8)
			inst.components.insulator:SetSummer()
			if (TheWorld.state or {}) and ((TheWorld.state and TheWorld.state.isspring) or (TheWorld.state and TheWorld.state.iswinter)) then
				inst.components.insulator:SetWinter()
			end
		end 
		OnSeasonChange(inst)
		inst:WatchWorldState("season", function() OnSeasonChange(inst) end)
	end,
	["body_flannel_blue_snowbird"] = function(inst, doer) --防风防花粉防毒气
		if not inst.components.windproofer then inst:AddComponent("windproofer") end
		inst.components.windproofer:SetEffectiveness(TUNING.WINDPROOFNESS_ABSOLUTE or 1)
		inst.components.equippable.poisongasblocker = true
		inst:AddTag("has_gasmask")
	end,
	["body_jacket_shearling_orange_salmon"] = function(inst, doer) --保暖240
		inst.components.equippable.dapperness = TUNING.DAPPERNESS_MED
		if not inst.components.insulator then inst:AddComponent("insulator") end
		inst.components.insulator:SetInsulation(TUNING.INSULATION_MED*2)
		inst.components.insulator:SetWinter()
	end,
	["body_jacket_toggle_navy_phthalo"] = function(inst, doer) --保暖120，怪物大衣
		inst:AddTag("has_monster")
		if not inst.components.insulator then inst:AddComponent("insulator") end
		inst.components.insulator:SetInsulation(TUNING.INSULATION_MED)
		inst.components.insulator:SetWinter()
	end,
	["body_pj_blue_agean"] = function(inst, doer)--给身上全部用电器充电，10s10bp
		local beer = -8
		inst:ListenForEvent("equipped",function(inst,data)
			inst.chongdiantask = inst:DoPeriodicTask(10,function()
				if (TheWorld.state and TheWorld.state.isnight) and (TheWorld.state and TheWorld.state.moonphase or 'new') == "full" then
					beer = -6
				end
				if (TheWorld.state and TheWorld.state.isnight) then
					beer = 0
				end
				if (TheWorld.state and TheWorld.state.isdusk) then
					beer = -4
				end
				if (TheWorld.state and TheWorld.state.isday) then
					beer = -8
				end
				if data.owner.components.inventory then
					for k,v in pairs(data.owner.components.inventory.itemslots) do
						if v and v.components.beerpower and v:HasTag("buling_gun_dianchi") then
							v.components.beerpower:UpBeer(beer)
						end
						if v and v.components.finiteuses and v:HasTag("beerpowertool") and v.components.finiteuses.current < v.components.finiteuses.total then
							v.components.finiteuses:Use(beer)
							if v.components.finiteuses.current > v.components.finiteuses.total then
								v.components.finiteuses:SetUses(v.components.finiteuses.total)
							end
						end
					end
				end
			end)
		end)
		inst:ListenForEvent("unequipped",function()
			if inst.chongdiantask then
				inst.chongdiantask:Cancel()
				inst.chongdiantask = nil
			end
		end)
	end,
	["body_silk_eveningrobe_red_rump"] = function(inst, doer)--南柯一梦
		inst:RemoveComponent("fueled")
		inst:AddComponent("inspectable")
		inst:ListenForEvent("equipped", function(inst, data)
			if data and data.owner then
				inst._onplayerdied = function(owner, data)
					if inst:IsValid() and owner:IsValid() then
						inst:Remove()
						if owner.components.health and owner.components.health:IsDead() then
							if owner.ms_respawnfromghost then
								owner:DoTaskInTime(1, function(owner) owner:ms_respawnfromghost() end)
							elseif owner.components.revivablecorpse then
								owner.components.revivablecorpse:Revive()
							end
						end
					end
				end
				inst:ListenForEvent("death", inst._onplayerdied, data.owner)
			end
		end)
		inst:ListenForEvent("unequipped", function(inst, data)
			if data and data.owner and inst._onplayerdied then
				inst:RemoveEventCallback("death", inst._onplayerdied, data.owner)
				inst._onplayerdied = nil
			end
		end)
	end,
	["body_outerwear_quilted_red_cardinal"] = function(inst, doer)--贵族气质
		inst:AddTag("pigroyalty_hat")
	end,
	["body_dancer_dragon"] = function(inst, doer)--电子CQC
		inst:AddTag("bulingCQC_hat")
		local function AllowDodge(inst, doer)
			return ((GetTime() - (inst.last_dodge_time or 0)) > (TUNING.WHEELER_DODGE_COOLDOWN or 2)) and 
					not (inst.components.driver and inst.components.driver:GetIsDriving()) and not (inst.components.rider and inst.components.rider:IsRiding())
		end
		local function BulingCQC(inst, doer, pos, useitem, right)
			if right then
				if AllowDodge(inst) then
					return { ACTIONS.DODGE }
				end
			end
			return {}
		end
		inst:ListenForEvent("equipped",function(inst,data)
			if data.owner and data.owner == (doer or inst) then
				data.owner.last_dodge_time = GetTime()
				data.owner.components.playeractionpicker.pointspecialactionsfn = BulingCQC
			end
		end)
		inst:ListenForEvent("unequipped",function(inst,data)
			if data.owner and data.owner == (doer or inst) then
				data.owner.last_dodge_time = nil
				data.owner.components.playeractionpicker.pointspecialactionsfn = nil
			end
		end)
	end,
	["body_overalls_blue_denim"] = function(inst, doer)--园丁套
	end,
}
local function fn(inst, doer)
	local function onsave(inst, data)
		data = data or {}
		if inst.bodyanim then
			data.bodyanim = inst.bodyanim
		end
		if inst.leganim then
			data.leganim = inst.leganim
		end
		if inst.clothetime then
			data.clothetime = inst.clothetime
		end
	end
	local function onpreload(inst, data)
		if data then
			if data.bodyanim then
				inst.bodyanim = data.bodyanim
			end
			if data.leganim then
				inst.leganim = data.leganim
			end
			if data.clothetime then
				inst.clothetime = data.clothetime
				inst.components.fueled.maxfuel = inst.clothetime
			end
		end
	end
	local function onequip(inst, owner, from_inventory)
	local doer = owner 
		--body
		if inst.components.fueled then
			inst.components.fueled:StartConsuming()
		end
		local bodyanim = inst.bodyanim or "bulingbuling"
		owner.AnimState:OverrideSymbol("torso", bodyanim, "torso") 
		owner.AnimState:OverrideSymbol("arm_upper", bodyanim, "arm_upper")
		owner.AnimState:OverrideSymbol("skirt", bodyanim, "skirt") 
		owner.AnimState:OverrideSymbol("arm_lower", bodyanim, "arm_lower") 
		--leg
		
		local leganim = inst.leganim or "bulingbuling"
		owner.AnimState:OverrideSymbol("leg", leganim, "leg") 
		owner.AnimState:OverrideSymbol("torso_pelvis", leganim, "torso_pelvis")
		--check
		local animname = {"body_buttons_black_jet","body_dancer_dragon","body_flannel_blue_snowbird","body_overalls_blue_denim","body_silk_eveningrobe_red_rump"}
		for k,v in pairs(animname) do
			if v == bodyanim then
				owner.AnimState:OverrideSymbol("arm_lower", "bulingbuling", "arm_lower")  
			end
		end
		if inst:HasTag("gasmask") then
			owner:AddTag("has_gasmask")
		end
		if inst:HasTag("has_monster") then
			owner:AddTag("monster")
		end
		if inst:HasTag("pigroyalty_hat") or inst.bodyanim == "body_outerwear_quilted_red_cardinal" then
			owner:AddTag("pigroyalty")
			if inst.hulk == nil then
				inst.hulk = SpawnPrefab("buling_hulk")
				if inst.hulk then
					inst.hulk.persists = false
					inst.hulk.Transform:SetPosition(owner.Transform:GetWorldPosition())
					if inst.hulk.components.follower and owner.components.leader then
						owner.components.leader:AddFollower(inst.hulk)
					end
				end
			end
		end
		if inst:HasTag("bulingCQC_hat") or inst.bodyanim == "body_dancer_dragon" then
			owner:AddTag("bulingCQC")
		end
	end
	
	local function onunequip(inst, owner)
	local doer = owner 
		if inst.components.fueled then
			inst.components.fueled:StopConsuming()
		end
		local bodyanim = "bulingbuling"
		local leganim = "bulingbuling"
		owner.AnimState:OverrideSymbol("torso", bodyanim, "torso") 
		owner.AnimState:OverrideSymbol("arm_upper", bodyanim, "arm_upper")
		owner.AnimState:OverrideSymbol("skirt", bodyanim, "skirt") 
		owner.AnimState:OverrideSymbol("arm_lower", bodyanim, "arm_lower")
		owner.AnimState:OverrideSymbol("leg", leganim, "leg") 
		owner.AnimState:OverrideSymbol("torso_pelvis", leganim, "torso_pelvis")
		owner.AnimState:OverrideSymbol("arm_lower", "bulingbuling", "arm_lower") 
		if inst:HasTag("gasmask") then
			owner:RemoveTag("has_gasmask")
		end	
		if inst:HasTag("has_monster") then
			owner:RemoveTag("monster")
		end
		if inst:HasTag("pigroyalty_hat") or inst.bodyanim == "body_outerwear_quilted_red_cardinal" then
			owner:RemoveTag("pigroyalty")
			if inst.hulk then
				inst.hulk:Remove()
				inst.hulk = nil
			end
		end
		if inst:HasTag("bulingCQC_hat") then
			owner:RemoveTag("bulingCQC")
		end
	end
	local inst = CreateEntity()
    
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.clthesfn = clthesfn
    inst.AnimState:SetBank("buling_box_2")
    inst.AnimState:SetBuild("buling_box_2")
    inst.AnimState:PlayAnimation("yifu")
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
	--inst.components.inventoryitem.imagename = "buling_yajin"
    --inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_yajin.xml"
    
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
    inst:AddComponent("tradable")
	local function onperish(inst, doer)
		inst:Remove()
	end
	
	inst:DoTaskInTime(0.1,function()
		if inst.bodyanim and inst.clthesfn[inst.bodyanim] then
			inst.clthesfn[inst.bodyanim](inst) 
			inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_"..inst.bodyanim..".xml"
			inst.components.inventoryitem:ChangeImageName("buling_"..inst.bodyanim)
		end
		if inst.clothetime and inst.components.fueled then
			inst.components.fueled.maxfuel = inst.clothetime
		end
	end) 
	inst:AddComponent("fueled")
    inst.components.fueled.fueltype = "USAGE"
    inst.components.fueled:SetDepletedFn(onperish)
	inst.OnSave = onsave
	--inst.OnLoad = onload
	inst.OnLoad = onpreload
	inst.clothetime = clothes
    return inst
end
--body_dancer_dragon 一套 武术服 空手攻击造成40伤害，可以使用滑铲
local function body_dancer_dragonfn(inst, doer)
	local inst = fn(inst)
	inst.OnSave = nil
	inst.OnLoad = nil
	inst.bodyanim = "body_dancer_dragon"
	inst.leganim = "body_dancer_dragon"
	inst.clothetime = clothes * 2
	inst.components.fueled:InitializeFuelLevel(inst.clothetime)
	return inst
end
--body_outerwear_quilted_red_cardinal 一套 红色贵族外套 被猪人视为贵族
local function body_outerwear_quilted_red_cardinal_fn(inst, doer)
	local inst = fn(inst)
	inst.OnSave = nil
	inst.OnLoad = nil
	inst.bodyanim = "body_outerwear_quilted_red_cardinal"
	inst.leganim = "body_outerwear_quilted_red_cardinal"
	inst:AddTag("pigroyalty_hat")
	inst.clothetime = clothes * 2
	inst.components.fueled:InitializeFuelLevel(inst.clothetime)
	return inst
end
--body_overalls_blue_denim 一套 园丁衣服 赋予牧场主效果
local function body_overalls_blue_denim_fn(inst, doer)
	local inst = fn(inst)
	inst.OnSave = nil
	inst.OnLoad = nil
	inst.bodyanim = "body_overalls_blue_denim"
	inst.leganim = "body_overalls_blue_denim"
	inst.clothetime = clothes * 20
	inst.components.fueled:InitializeFuelLevel(inst.clothetime)
	return inst
end
--body_silk_eveningrobe_red_rump 一套 红色睡衣 80%护甲，1350耐久，嗝屁复活
local function body_silk_eveningrobe_red_rump_fn(inst, doer)
	local inst = fn(inst)
	inst.OnSave = nil
	inst.OnLoad = nil
	inst.bodyanim = "body_silk_eveningrobe_red_rump"
	inst.leganim = "bulingbuling"
	inst:AddComponent("armor")
	inst.components.armor:InitCondition(TUNING.ARMORDRAGONFLY, 0.8)
	return inst
end
--buling_christmas 圣诞服 480保暖，发光，回脑
local function buling_christmas_fn()
	local function onperish(inst, doer)
		inst:Remove()
	end
	local function onequip(inst, owner, from_inventory)
	local doer = owner 
		owner.AnimState:OverrideSymbol("swap_body", "buling_christmas", "swap_body")
		inst.components.fueled:StartConsuming()
		inst.Light:Enable(true)
	end

	local function onunequip(inst, owner)
	local doer = owner 
		owner.AnimState:ClearOverrideSymbol("swap_body")
		inst.components.fueled:StopConsuming()
		inst.Light:Enable(false)
	end
    local inst = CreateEntity()
	local light = inst.entity:AddLight()
	light:SetIntensity(.7)
	light:SetFalloff(2)
	light:SetRadius(7)
	light:SetColour(180/255, 195/255, 150/255)
	light:Enable(false)
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("buling_box_2")
    inst.AnimState:SetBuild("buling_box_2")
    MakeInventoryPhysics(inst)
    inst.AnimState:PlayAnimation("yifu")
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "buling_christmas"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_christmas.xml"
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable.dapperness = TUNING.DAPPERNESS_SMALL*4
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
    inst:AddComponent("fueled")
    inst.components.fueled.fueltype = "USAGE"
    inst.clothetime = clothes * 20
	inst.components.fueled:InitializeFuelLevel(inst.clothetime)
    inst.components.fueled:SetDepletedFn(onperish)
    inst:AddComponent("insulator")
	inst.components.insulator:SetInsulation(TUNING.INSULATION_MED*4)
	inst.components.insulator:SetWinter()
	return inst
end
--bulingbuling_sikushui 死库水 240防暑，100%防水，绝缘
local function bulingbuling_sikushui_fn(inst, doer)
	local inst = fn(inst)
	inst.OnSave = nil
	inst.OnLoad = nil
	inst.bodyanim = "bulingbuling_sikushui"
	inst.leganim = "bulingbuling_sikushui"
	inst.clothetime = clothes * 20
	inst.components.fueled:InitializeFuelLevel(inst.clothetime)
	inst.components.inventoryitem.imagename = "bulingbuling_sikushui"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/bulingbuling_sikushui.xml"
	inst:AddComponent("insulator")
	inst.components.insulator:SetInsulation(TUNING.INSULATION_MED*2)
	inst.components.insulator:SetSummer()
	inst:AddComponent("waterproofer")
	inst.components.waterproofer:SetEffectiveness(1)
	inst:AddTag("venting")
	inst:AddTag("fogproof")
	inst.components.equippable.insulated = true
	return inst
end
local buling_trousers = {"legs_pants_basic_blue_sky","legs_shorts_black_scribble","legs_checkered_pleats_blue_cornflower","legs_pinstripe_pants_black_jet","legs_jeans_black_scribble","legs_swing_pants_brown_umber"}
local buling_clothe = {}

function Makeclothe(name,anim)
	local function item_fn()
		local inst = fn()
		inst.OnSave = nil
		inst.OnLoad = nil
		inst.bodyanim = anim
		inst.leganim = "bulingbuling"
		inst.components.inventoryitem.imagename = "buling_"..anim
		inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_"..anim..".xml"
		inst:AddTag("buling_clothe")
		if clthesfn and clthesfn[anim] then
			clthesfn[anim](inst)
		end
		return inst
	end
	return Prefab(name, item_fn, assets)
end
function Maketrousers(name,anim,ctime)
	local function item_fn()
		local inst = fn()
		inst.OnSave = nil
		inst.OnLoad = nil
		inst.bodyanim = "bulingbuling"
		inst.leganim = anim
		inst.clothetime = ctime * 3 * clothes + clothes
		if inst.components.fueled then
			inst.components.fueled:InitializeFuelLevel(inst.clothetime)
		end
		inst.components.inventoryitem.imagename = "buling_"..anim
		inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_"..anim..".xml"
		inst:AddTag("buling_trouser")
		return inst
	end
	return Prefab(name, item_fn, assets)
end
table.insert(buling_clothe,Prefab( "buling_overcoat", fn, assets))
table.insert(buling_clothe,Prefab( "buling_christmas", buling_christmas_fn, assets))
table.insert(buling_clothe,Prefab( "bulingbuling_sikushui", bulingbuling_sikushui_fn, assets))
table.insert(buling_clothe,Prefab( "buling_eveningrobe", body_silk_eveningrobe_red_rump_fn, assets))
table.insert(buling_clothe,Prefab( "buling_denim", body_overalls_blue_denim_fn, assets))
table.insert(buling_clothe,Prefab( "buling_cardinal", body_outerwear_quilted_red_cardinal_fn, assets))
table.insert(buling_clothe,Prefab( "buling_dancer_dragon", body_dancer_dragonfn, assets))
for k = 1,9 do
	table.insert(buling_clothe,Makeclothe("buling_clothe_"..k,buling_clothes[k])) 
end
for k = 1,6 do
	table.insert(buling_clothe,Maketrousers("buling_trouser_"..k,buling_trousers[k],k)) 
end
return unpack(buling_clothe)
