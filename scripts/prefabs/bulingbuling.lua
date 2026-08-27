local RECIPETABS = (rawget and rawget(_G, 'RECIPETABS')) or (GLOBAL and GLOBAL.RECIPETABS)
local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
	Asset( "ANIM", "anim/bulingbuling.zip" ),
	Asset( "ANIM", "anim/mutsuki_ai.zip" ),
	Asset( "ANIM", "anim/buling_pupil.zip" ),
	Asset( "ANIM", "anim/buling_ken102.zip" ),
	Asset( "ANIM", "anim/buling_hat_ken102.zip" ),
	Asset( "ANIM", "anim/bulingbuling_wine.zip" ),
}

local prefabs = {}

local start_inv = {
	"buling_system",
}

local BULING_MULT_SAME_OLD = {1, 0.75, 0.5, 0.25, 0}

local function dorainsparks(inst, dt)
	dt = dt or 0.1
	if not TheWorld or not TheWorld.state then return end
    if (inst.components.moisture and inst.components.moisture:GetMoisture() > 0) then
    	inst.spark_time = inst.spark_time - dt

    	if inst.spark_time <= 0 then
    		inst.spark_time = 3 + math.random() * 2

    		local pos = Vector3(inst.Transform:GetWorldPosition())
    		local damage = nil
    		if TheWorld.state.israining and inst.components.inventory and inst.components.inventory:GetEquippedMoistureRate(EQUIPSLOTS.HEAD) <= 0 then
	    		local waterproofmult = 1 - inst.components.inventory:GetWaterproofness()
	    		damage = waterproofmult > 0 and math.min(TUNING.WX78_MIN_MOISTURE_DAMAGE or -1, (TUNING.WX78_MAX_MOISTURE_DAMAGE or -2) * waterproofmult) or 0
	    		inst.components.health:DoDelta(damage, false, "rain")
				pos.y = pos.y + 1 + math.random()*1.5
	    	else 
	    		if inst.components.moisture:GetMoisture() >= 0 then 
	    			inst.components.health:DoDelta(TUNING.WX78_MAX_MOISTURE_DAMAGE or -2, false, "water")
	    		else
	    			inst.components.health:DoDelta(TUNING.WX78_MOISTURE_DRYING_DAMAGE or 1, false, "water")
	    		end
				pos.y = pos.y + .25 + math.random()*2
	    	end
    	end
    end
end

local function OnAttack(inst, doer, data)
	local damage = 50
	if data.weapon == nil then
		if data.target and data.target.components.health and inst:HasTag("bulingCQC") then
			if data.target.components.combat and data.target.components.health and not data.target.components.health:IsDead() then
				data.target.components.combat:GetAttacked(inst, damage)
			end
		end
	end
end

local function buling_recipes()
	local Ingredient = rawget(_G, "Ingredient")
	local RECIPETABS = rawget(_G, "RECIPETABS")
	local Recipe = rawget(_G, "Recipe")
	local TECH = rawget(_G, "TECH")
	
	if RECIPETABS and RECIPETABS.BLTAB then
		local buling_manual = Recipe("buling_manual", {Ingredient("log", 4),Ingredient("boards", 1)}, RECIPETABS.BLTAB,TECH.NONE,nil,"buling_manual_placer",2)
		buling_manual.atlas = "images/inventoryimages/buling_manual.xml"
		buling_manual.image = "buling_manual.tex"
		
		local buling_weaponchest = Recipe("buling_weaponchest_item", {Ingredient("buling_zhongziding", 8,"images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"),Ingredient("buling_glass", 4,"images/inventoryimages/buling_glass.xml", "buling_glass.tex"),Ingredient("buling_manual_item", 1,"images/inventoryimages/buling_manual_item.xml", "buling_manual_item.tex")}, RECIPETABS.BLTAB,TECH.NONE,nil)
		buling_weaponchest.atlas = "images/inventoryimages/buling_seedchest.xml"
		buling_weaponchest.image = "buling_seedchest.tex"
		
		local buling_wakuang = Recipe("buling_wakuang_item", {Ingredient("boards", 8),Ingredient("goldenpickaxe", 1),Ingredient("gears", 4)}, RECIPETABS.BLTAB,TECH.NONE,nil)
		buling_wakuang.atlas = "images/inventoryimages/buling_wakuang.xml"
		buling_wakuang.image = "buling_wakuang.tex"
		
		local buling_cave_tool = Recipe("buling_cave_tool", {Ingredient("goldenpickaxe", 4),Ingredient("rocks", 20),Ingredient("log", 10)}, RECIPETABS.BLTAB,TECH.NONE,nil)
		buling_cave_tool.atlas = "images/inventoryimages/buling_cave_tool.xml"
		buling_cave_tool.image = "buling_cave_tool.tex"
		
		local buling_cooktable_item = Recipe("buling_cooktable_item", {Ingredient("boards", 4),Ingredient("rocks", 2),Ingredient("flint", 2)}, RECIPETABS.BLTAB,TECH.NONE,nil)
		buling_cooktable_item.atlas = "images/inventoryimages/buling_cooktable.xml"
		buling_cooktable_item.image = "buling_cooktable.tex"
		
		local buling_fengrenji = Recipe("buling_fengrenji_item", {Ingredient("goldnugget", 8),Ingredient("cutstone", 2),Ingredient("sewing_kit", 1)}, RECIPETABS.BLTAB,TECH.NONE,nil)
		buling_fengrenji.atlas = "images/inventoryimages/buling_fengrenji.xml"
		buling_fengrenji.image = "buling_fengrenji.tex"
	end
end

local function refresh_consumed_foods(inst, doer)
	if not inst.consumed_foods then return end
	local to_remove = {}
	local cur_time = GetTime()
	for k,v in pairs(inst.consumed_foods) do
		if cur_time >= v.time_of_reset then
			table.insert(to_remove, k)
		end
	end

	for k,v in pairs(to_remove) do
		inst.consumed_foods[v] = nil
	end
end

local function OnSave(inst, data)
	local consumed_foods = {}
	if inst.consumed_foods then
		local cur_time = GetTime()
		for k,v in pairs(inst.consumed_foods) do
			consumed_foods[k] = {}
			consumed_foods[k].count = v.count
			consumed_foods[k].time_of_reset = v.time_of_reset - cur_time
		end
	end
	data.consumed_foods = consumed_foods
end

local function OnLoad(inst, data)
	if data and data.consumed_foods then
		inst.consumed_foods = data.consumed_foods
	end
end

local function getmultfn(inst, doer, food, original_value)
	local mult = 1
	if food and food.components.edible then
		if food.components.edible.foodtype == FOODTYPE.VEGGIE or food.components.edible.foodtype == "VEGGIE" then
			mult = 1.25
			if inst.inst and inst.inst.consumed_foods and inst.inst.consumed_foods[food.prefab] then
				local penalty_stage = inst.inst.consumed_foods[food.prefab].count
				penalty_stage = math.clamp(penalty_stage, 1, 5)
				mult = mult * BULING_MULT_SAME_OLD[penalty_stage]
			end
		elseif food.components.edible.foodtype == FOODTYPE.MEAT or food.components.edible.foodtype == "MEAT" then
			mult = 0.1
		end
	end
	return mult
end

local function oneat(inst, doer, food)
	refresh_consumed_foods(inst)
	if food and food.components.edible then
		local foodtype = food.components.edible.foodstate or "TASTY"
		if math.random()< 0.5 then
			foodtype = "TASTY"
		end
		if food.prefab == "taffy" then
			inst.AnimState:OverrideSymbol("arm_lower", "mutsuki_ai", "arm_lower")
			inst.AnimState:OverrideSymbol("torso", "buling_pupil", "torso")
			inst.AnimState:OverrideSymbol("arm_upper", "mutsuki_ai", "arm_upper")
			inst.AnimState:OverrideSymbol("skirt", "buling_pupil", "skirt")
			inst:AddTag("pupil")
		end
		if food.prefab == "monsterlasagna" then
			inst.AnimState:OverrideSymbol("torso", "buling_ken102", "torso")
			inst.AnimState:OverrideSymbol("hair", "buling_ken102", "hair")
			inst.AnimState:OverrideSymbol("face", "buling_ken102", "face")
			inst.AnimState:OverrideSymbol("hair_hat", "buling_ken102", "hair_hat")
			inst.AnimState:OverrideSymbol("headbase", "buling_ken102", "headbase")
			inst.AnimState:OverrideSymbol("headbase_hat", "buling_ken102", "headbase_hat")
			inst:AddTag("ken102")
		end
		if food.prefab == "spicyvegstinger" then
			inst.AnimState:SetBuild("bulingbuling_wine")
		end
		if inst.consumed_foods[food.prefab] then
			local penalty_stage = inst.consumed_foods[food.prefab].count
			penalty_stage = math.clamp(penalty_stage, 1, 5)
			if inst.components.talker then
				inst.components.talker:Say(GetString(inst, "ANNOUNCE_EAT", "SAME_OLD_"..penalty_stage))
			end
			inst.consumed_foods[food.prefab].count = inst.consumed_foods[food.prefab].count + 1
			inst.consumed_foods[food.prefab].time_of_reset = GetTime() + (TUNING.WARLY_SAME_OLD_COOLDOWN or 300)
		elseif food.components.edible.foodtype == FOODTYPE.VEGGIE or food.components.edible.foodtype == "VEGGIE" then
			if inst.components.talker then
				inst.components.talker:Say(GetString(inst, "ANNOUNCE_EAT", string.upper(tostring(foodtype))))
			end
			inst.consumed_foods[food.prefab] = {count = 1, time_of_reset = GetTime() + (TUNING.WARLY_SAME_OLD_COOLDOWN or 300)}
		elseif food.components.edible.foodtype == FOODTYPE.MEAT or food.components.edible.foodtype == "MEAT" then
			if inst.components.talker then
				inst.components.talker:Say(GetString(inst, "ANNOUNCE_EAT", "MEAT"))
			end
		end
	end
end

local function buling_pupil_hat(inst, doer, data)
	if data and data.eslot == EQUIPSLOTS.HEAD then
		if inst:HasTag("pupil") then
			inst:DoTaskInTime(0.1, function()
				inst.AnimState:OverrideSymbol("swap_hat", "mutsuki_ai_hat", "swap_hat")
			end)
		end
		if inst:HasTag("ken102") then
			inst:DoTaskInTime(0.1, function()
				inst.AnimState:OverrideSymbol("swap_hat", "buling_hat_ken102", "swap_hat")
			end)
		end
	end
end

local function OnLongUpdate(inst, doer, dt)
	if inst.consumed_foods then
		for k,v in pairs(inst.consumed_foods) do
			v.time_of_reset = v.time_of_reset - dt
		end
		refresh_consumed_foods(inst)
	end
end

local common_postinit = function(inst, doer)
	inst.spark_time = 3
	inst.consumed_foods = {}
	inst:AddTag("insomniac")
	inst:AddTag("bulingbuling")
	inst.MiniMapEntity:SetIcon("bulingbuling.tex")
end

local master_postinit = function(inst, doer)
	inst.soundsname = "willow"
	
	local RECIPETABS = rawget(_G, "RECIPETABS")
	if not RECIPETABS.BLTAB then
		RECIPETABS['BLTAB'] = {str = 'BLTAB', sort=12, priority = 4, icon = "bulinggongye.tex", icon_atlas = "images/bulinggongye.xml", crafting_station = true, modname = "不灵科技"}
	end
	if not RECIPETABS.YJTAB then
		RECIPETABS['YJTAB'] = {str = 'YJTAB', sort=12, priority = 5, icon = "bulingyanjiu.tex", icon_atlas = "images/bulingyanjiu.xml", crafting_station = true, modname = "研究项目"}
	end
	
	buling_recipes()
	
	inst:AddComponent("buling_task")
	inst:AddComponent("buling_buff")
	inst:AddComponent("teleportonload")
	
	if inst.components.builder then
		inst.components.builder.science_bonus = 2
	end
	
	inst.components.health:SetMaxHealth(75)
	inst.components.hunger:SetMax(100)
	inst.components.sanity:SetMax(300)
	
	if inst.components.eater then
		inst.components.eater:SetOnEatFn(oneat)
		inst.components.eater.stale_hunger = TUNING.WICKERBOTTOM_STALE_FOOD_HUNGER or 1
		inst.components.eater.stale_health = TUNING.WICKERBOTTOM_STALE_FOOD_HEALTH or 1
		inst.components.eater.spoiled_hunger = TUNING.WICKERBOTTOM_SPOILED_FOOD_HUNGER or 1
		inst.components.eater.spoiled_health = TUNING.WICKERBOTTOM_SPOILED_FOOD_HEALTH or 1
		inst.components.eater.getsanitymultfn = getmultfn
		inst.components.eater.gethungermultfn = getmultfn
		inst.components.eater.gethealthmultfn = getmultfn
	end
	
	if inst.components.combat then
		inst.components.combat.damagemultiplier = 0.85
	end
	
	if inst.components.sanity then
		inst.components.sanity.night_drain_mult = 2
		inst.components.sanity.neg_aura_mult = 2
	end
	
	inst:ListenForEvent("onattackother", OnAttack)
	inst:DoPeriodicTask(1/10, function() dorainsparks(inst, 1/10) end)
	inst:ListenForEvent("equip", buling_pupil_hat)
	
	if inst.components.driver then
		local oldOnDismount = inst.components.driver.OnDismount
		local oldOnMount = inst.components.driver.OnMount
		inst.components.driver.OnDismount = function(self, death, pos, boat_to_boat)	
			if inst.components.driver.vehicle and inst.components.driver.vehicle:HasTag("buling_carrier") then
				inst.components.driver.vehicle.bulingdrop(inst.components.driver.vehicle, inst)
				inst.sg:GoToState("jumpoffboatstart", pos)
			elseif oldOnDismount then
				oldOnDismount(self, death, pos, boat_to_boat)
			end
		end
		inst.components.driver.OnMount = function(self, carrier)
			if carrier and carrier:HasTag("buling_carrier") then
			elseif oldOnMount then
				oldOnMount(self, carrier)
			end
		end
	end
	
	inst.OnSave = OnSave
	inst.OnLoad = OnLoad
	inst.OnLongUpdate = OnLongUpdate
end

return MakePlayerCharacter("bulingbuling", prefabs, assets, common_postinit, master_postinit, start_inv)
