local assets ={
	Asset("ANIM", "anim/wx78_bulingbuling.zip"),
	Asset("ANIM", "anim/swap_buling_gun_black.zip"),
	Asset("ANIM", "anim/swap_buling_gun_white.zip"),
	Asset("ANIM", "anim/swap_lightsword_buling.zip"),
	Asset("ANIM", "anim/swap_buling_dragon_weapon.zip"),
	Asset("ANIM", "anim/swap_buling_dragon_weapon_fire.zip"),
	Asset("ANIM", "anim/swap_buling_tigershark_weapon.zip"),
	Asset("ANIM", "anim/buling_diaomin_1.zip"),
	Asset("ANIM", "anim/buling_diaomin_2.zip"),
	Asset("ANIM", "anim/buling_diaomin_3.zip"),
	Asset("ANIM", "anim/buling_diaomin_4.zip"),
	Asset("ANIM", "anim/buling_diaomin_5.zip"),
	Asset("ANIM", "anim/buling_diaomin_6.zip"),
	Asset("ANIM", "anim/buling_diaomin_7.zip"),
	Asset("ANIM", "anim/buling_diaomin_8.zip"),
	Asset("ANIM", "anim/buling_diaomin_9.zip"),
	Asset("ANIM", "anim/buling_diaomin_10.zip"),
}
local function KeepTargetFn(inst, doer, target)
    return inst.components.combat:CanTarget(target)
end
local function empfind(inst, doer)
	local pos = Vector3(inst.Transform:GetWorldPosition())
	local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, 15, nil, {"FX", "NOCLICK", "DECOR", "INLIMBO"})
	SpawnPrefab("buling_saomiaofx").Transform:SetPosition(inst:GetPosition():Get())
	for k,v in pairs(ents) do
		if v:HasTag("bp_source") or v.components.beerpower then
			inst.components.thrower:Throw(v:GetPosition())
		end
	end
end
local function OnWentHome(inst, doer)
		if inst.components.homeseeker and 
		inst.components.homeseeker.home and 
		inst.components.homeseeker.home:IsValid() then
			if inst.components.homeseeker.home.components.inventory then
				inst.components.inventory:TransferInventory(inst.components.homeseeker.home)               
			end
		end
	end
local function moonmonster()
	local function BlowdartDropped(inst, doer)
		inst:Remove()
	end
	
	local function EquipBlowdart(inst, doer)
		if inst.components.inventory and not inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) and inst.job == "gunmen" then
			local blowdart = CreateEntity()
			blowdart.entity:AddTransform()
			blowdart:AddComponent("weapon")
			blowdart:AddTag("sharp")
			blowdart.components.weapon:SetDamage(inst.components.combat.defaultdamage)
			blowdart.components.weapon:SetRange(8)
			blowdart.components.weapon:SetProjectile("blowdart_walrus")
			blowdart:AddComponent("inventoryitem")
			blowdart.persists = false
			blowdart.components.inventoryitem:SetOnDroppedFn(BlowdartDropped)
			blowdart:AddComponent("equippable")
			
			inst.components.inventory:Equip(blowdart)
		end
	end
	local function equipweapon(inst, doer)
		if not inst.job then
			local jobs = {"engineer","gunmen","konoye"}
			inst.job = jobs[math.random(#jobs)]
		end
		if inst.job == "engineer" then
			inst.components.health:SetAbsorptionAmount(0.4)
			inst.items.SWORD = "swap_buling_lightstuff"
			inst.components.combat.defaultdamage = 50
		elseif inst.job == "gunmen" then
			inst.components.health:SetAbsorptionAmount(0.3)
			inst.items.SWORD = "swap_buling_gun_black"
			inst.components.combat.defaultdamage = 34
			inst:DoTaskInTime(1, EquipBlowdart)
		elseif inst.job == "konoye" then
			inst.items.SWORD = "swap_buling_chopper"
			inst.components.combat.defaultdamage = 68
		end
	end
	local function retargetfn(inst, doer)
		if not inst.components.health:IsDead() then
			return FindEntity(inst, TUNING.FROG_TARGET_DIST, function(guy) 
				if guy.components.combat and guy.components.health and not guy.components.health:IsDead() and not guy:HasTag("robot")then
					return guy.components.health ~= nil
				end
			end)
		end
	end
	local function OnAttacked(inst, doer, data)
		inst.components.combat:SetTarget(data.attacker)
		inst.components.combat:ShareTarget(data.attacker, 10, function(dude) return dude:HasTag("buling_player")--[[dude.prefabs == inst.prefabs]] and not dude.components.health:IsDead() end, 30)
	end
	local items ={
		AXE = "swap_axe",
		PICK = "swap_pickaxe",
		SWORD = "swap_nightmaresword",
		HAMMER = "swap_hammer",
		HACK = "swap_machete",
		SHOVEL = "swap_shovel"
	}
	local function EquipItem(inst, doer, item,weapon)
		if item then
			inst.AnimState:OverrideSymbol("swap_object", item, item)
			inst.AnimState:Show("ARM_carry") 
			inst.AnimState:Hide("ARM_normal")
		end
		if weapon then
			inst.AnimState:OverrideSymbol("swap_object", "swap_buling_weapon", item)
		end
	end
	
    local inst = CreateEntity()
	inst.items = items
	inst.entity:AddDynamicShadow()
	inst.equipfn = EquipItem
    EquipItem(inst)
	inst.entity:SetCanSleep(false)
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1.5, .5 )
	local sound = inst.entity:AddSoundEmitter()
	MakeCharacterPhysics(inst, 10, .5)
	inst.DynamicShadow:SetSize(3, 1)
    inst:AddComponent("inspectable")
	inst.AnimState:SetBank("wilson")
    inst.AnimState:SetBuild("wx78_bulingbuling")
	inst:AddTag("buling_player")
	inst.AnimState:PlayAnimation("idle")
	inst.Transform:SetFourFaced(inst)
	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(150)
	inst.components.health:SetAbsorptionAmount(0.5)
	inst:AddComponent("lootdropper")
    inst.components.lootdropper:AddRandomLoot("goldnugget", 1)
    inst.components.lootdropper:AddRandomLoot("obsidian", .5)
    inst.components.lootdropper.numrandomloot = 1
	inst:AddComponent("locomotor")
	inst:AddComponent("eater")
    inst.components.locomotor.walkspeed = 6
	inst.force_onwenthome_message = true
	inst:AddComponent("inventory")
    inst.components.inventory.ignorescangoincontainer = true
    local brain = require "brains/buling_playerbrain"
	inst:SetBrain(brain)
	inst:AddTag("robot")
	inst:AddTag("character")
	inst:AddComponent("knownlocations")
	inst:AddComponent("combat")
    inst.components.combat.defaultdamage = 50
	inst.components.combat:SetAttackPeriod(TUNING.EYETURRET_ATTACK_PERIOD)
	inst:SetStateGraph("SGbuling_player")
	inst.AnimState:Hide("ARM_carry")
    inst.AnimState:Show("ARM_normal")
	inst:ListenForEvent("attacked", OnAttacked)
	inst.components.combat:SetRetargetFunction(3, retargetfn)
	inst:AddComponent("knownlocations")
	inst:AddComponent("follower")
	inst:AddComponent("thrower")
    inst.components.thrower.throwable_prefab = "buling_player_emp"
	inst:ListenForEvent("onwenthome", OnWentHome)
	inst:DoPeriodicTask(45,function()
		if inst.job == "engineer" then 
			empfind(inst)
		end
	end)
	equipweapon(inst)
	local function onsave(inst, data)
		data = data or {}
		if inst.job then
			data.job = inst.job
		end
	end
	local function onload(inst, data)
		if data and data.job then
			inst.job = data.job
			equipweapon(inst)
		end
	end
	inst.OnSave = onsave
    inst.OnLoad = onload
	inst:RemoveTag("player")
    return inst
end
local function playerfn(inst, doer)
	local function retargetfn(inst, doer)
		if not inst.components.health:IsDead() then
			return FindEntity(inst, TUNING.FROG_TARGET_DIST, function(guy) 
				if guy.components.combat and guy.components.health and not guy.components.health:IsDead() and not guy:HasTag("buling_diaomin") and not guy:HasTag("player") and not guy:HasTag("wall") and guy:HasTag("monster") and inst.job and inst.job == "guard" then
					return guy.components.health ~= nil
				end
			end)
		end
	end
	local function OnAttacked(inst, doer, data)
		inst.components.combat:SetTarget(data.attacker)
		inst.components.combat:ShareTarget(data.attacker, 30, function(dude) return dude:HasTag("buling_diaomin")--[[dude.prefabs == inst.prefabs]] and not dude.components.health:IsDead() end, 30)
	end
	local items ={
		AXE = "swap_axe",
		PICK = "swap_pickaxe",
		SWORD = "swap_nightmaresword",
		HAMMER = "swap_hammer",
		HACK = "swap_machete",
		SHOVEL = "swap_shovel"
	}
	local function EquipItem(inst, doer, item,weapon)
		if item then
			inst.AnimState:OverrideSymbol("swap_object", item, item)
			inst.AnimState:Show("ARM_carry") 
			inst.AnimState:Hide("ARM_normal")
		end
	end
	--local brain = require "brains/frogbrain"
	local brain = require "brains/buling_wx78brain"
	--
	local inst = CreateEntity()
	inst.items = items
	inst.entity:AddDynamicShadow()
	inst.equipfn = EquipItem
    EquipItem(inst)
	inst.entity:SetCanSleep(false)
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1.5, .5 )
	local sound = inst.entity:AddSoundEmitter()
	MakeCharacterPhysics(inst, 100, .5)
	inst.DynamicShadow:SetSize(3, 1)
    inst:AddComponent("inspectable")
	inst.AnimState:SetBank("wilson")
	inst:AddTag("buling_diaomin")
	inst.AnimState:PlayAnimation("idle")
	inst.Transform:SetFourFaced(inst)
	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(150)
	inst.components.health:SetAbsorptionAmount(0.5)
	inst:AddComponent("lootdropper")
    inst.components.lootdropper:AddRandomLoot("goldnugget", 1)
    inst.components.lootdropper.numrandomloot = 1
	inst:AddComponent("locomotor")
	inst:AddComponent("eater")
    inst.components.locomotor.walkspeed = 6
	inst.force_onwenthome_message = true
	inst:AddComponent("inventory")
    inst.components.inventory.ignorescangoincontainer = true
	inst:AddTag("character")
	inst:AddComponent("knownlocations")
	inst:AddComponent("combat")
    inst.components.combat.defaultdamage = 50
	inst.components.combat:SetAttackPeriod(TUNING.EYETURRET_ATTACK_PERIOD)
	inst.components.combat:SetKeepTargetFunction(KeepTargetFn)
	inst:SetStateGraph("SGbuling_player")
	inst.AnimState:Hide("ARM_carry")
    inst.AnimState:Show("ARM_normal")
	inst:ListenForEvent("attacked", OnAttacked)
	inst:AddComponent("knownlocations")
	inst:AddComponent("follower")
	inst:ListenForEvent("onwenthome", OnWentHome)
	local function onsave(inst, data)
		data = data or {}
	end
	local function onload(inst, data)
	end
	--
	inst:SetBrain(brain)
	inst.components.combat:SetRetargetFunction(3, retargetfn)
	inst.AnimState:SetBuild("bulingbuling")
	--face
	local anim0 = "buling_diaomin_"..math.random(1,9)
	inst.AnimState:OverrideSymbol("face", "nil", "face")
	inst.AnimState:OverrideSymbol("hair_hat", anim0, "hair")
	inst.AnimState:OverrideSymbol("hair", anim0, "hair")
	inst.AnimState:OverrideSymbol("headbase_hat", anim0, "headbase_hat") 
	--inst.AnimState:OverrideSymbol("headbase", anim0, "headbase") 
	inst.AnimState:OverrideSymbol("headbase", "buling_diaomin_"..math.random(1,10), "headbase") 
	--body
	local bodynames = {"body_buttons_black_jet","body_cableknit_sweater_tan_khaki","body_cardigan_black_jet","body_dancer_dragon","body_expo_letterman_yellow_beige","body_expo_sweater_blue_agean","body_flannel_blue_snowbird","body_jacket_shearling_orange_salmon","body_jacket_toggle_navy_phthalo","body_outerwear_quilted_red_cardinal","body_overalls_blue_denim","body_pj_blue_agean","body_silk_eveningrobe_red_rump"}
	local bodyanim = bodynames[math.random(#bodynames)]
	inst.AnimState:OverrideSymbol("torso", bodyanim, "torso") 
	inst.AnimState:OverrideSymbol("arm_upper", bodyanim, "arm_upper")
	inst.AnimState:OverrideSymbol("skirt", bodyanim, "skirt") 
	inst.AnimState:OverrideSymbol("arm_lower", bodyanim, "arm_lower") 
	--leg
	local legname = {"body_dancer_dragon","body_outerwear_quilted_red_cardinal","body_overalls_blue_denim","legs_checkered_pleats_blue_cornflower","legs_jeans_black_scribble","legs_pants_basic_blue_sky","legs_pinstripe_pants_black_jet","legs_shorts_black_scribble","legs_swing_pants_brown_umber"}
	local leganim = legname[math.random(#legname)]
	inst.AnimState:OverrideSymbol("leg", leganim, "leg") 
	inst.AnimState:OverrideSymbol("torso_pelvis", leganim, "torso_pelvis")
	--check
	local animname = {"body_buttons_black_jet","body_dancer_dragon","body_flannel_blue_snowbird","body_overalls_blue_denim","body_silk_eveningrobe_red_rump"}
	for k,v in pairs(animname) do
		if v == bodyanim then
			inst.AnimState:OverrideSymbol("arm_lower", "bulingbuling", "arm_lower")  
		end
	end
	return inst
end
--dragon girl
local function Retarget(inst, doer)
    local notags = {"FX", "NOCLICK","INLIMBO"}
    local newtarget = FindEntity(inst, 20, function(guy)
            return  guy.components.combat and 
                    inst.components.combat:CanTarget(guy) and
                    ((doer or inst).components.combat.target == guy or guy.components.combat.target == (doer or inst) )
    end, nil, notags)

    return newtarget
end
local function dragon(inst, doer)
	local items ={
		AXE = "swap_axe",
		PICK = "swap_pickaxe",
		SWORD = "swap_buling_dragon_weapon",
		HAMMER = "swap_hammer",
		HACK = "swap_machete",
		SHOVEL = "swap_shovel"
	}
	local inst = playerfn(inst)
	local anim0 = "buling_diaomin_3"
	local bodyanim = "body_willow_dragonfly"
	local leganim = "body_willow_dragonfly"
	inst.AnimState:OverrideSymbol("face", "nil", "face")
	inst.AnimState:OverrideSymbol("hair_hat", anim0, "hair")
	inst.AnimState:OverrideSymbol("hair", anim0, "hair")
	inst.AnimState:OverrideSymbol("headbase_hat", anim0, "headbase_hat") 
	inst.AnimState:OverrideSymbol("headbase", "buling_diaomin_9", "headbase")
	inst.AnimState:OverrideSymbol("torso", bodyanim, "torso") 
	inst.AnimState:OverrideSymbol("hand", bodyanim, "hand") 
	inst.AnimState:OverrideSymbol("arm_upper", bodyanim, "arm_upper")
	inst.AnimState:OverrideSymbol("skirt", bodyanim, "skirt") 
	inst.AnimState:OverrideSymbol("arm_lower", bodyanim, "arm_lower") 
	inst.AnimState:OverrideSymbol("leg", leganim, "leg") 
	inst.AnimState:OverrideSymbol("torso_pelvis", leganim, "torso_pelvis")
	inst.AnimState:OverrideSymbol("foot", leganim, "foot")
	inst.AnimState:OverrideSymbol("arm_lower", "bulingbuling", "arm_lower")
	inst:AddComponent("leader")
	inst.items = items
	--
	inst.components.health:SetMaxHealth(1000)
	inst.components.combat:SetAttackPeriod(1)
	inst.components.combat:SetRetargetFunction(3, Retarget)
	inst.components.follower.leader = (doer or inst)
	local brain = require "brains/buling_abigailbrain"
	inst:SetBrain(brain)
	inst:DoTaskInTime(0.1,function()
		if not inst.follower_dragon then
			inst.follower_dragon =  SpawnPrefab("buling_dragon_follower")
			inst.follower_dragon.components.follower.leader = inst
			inst.follower_dragon.Transform:SetPosition(inst.Transform:GetWorldPosition())
		end
	end)
	local old_attack = inst.sg.sg.states.attack.onenter
	inst.sg.sg.states.attack.onenter = function(inst)
		if inst and inst.PushEvent then inst:PushEvent("buling_attack") end
		old_attack(inst)
		local attackfx = SpawnPrefab("attackfire_fx")
        attackfx.Transform:SetPosition(inst.Transform:GetWorldPosition())
        attackfx.Transform:SetRotation(inst.Transform:GetRotation())
	end
	return inst
end
local function taigershark(inst, doer)
	local items ={
		AXE = "swap_axe",
		PICK = "swap_pickaxe",
		SWORD = "swap_buling_tigershark_weapon",
		HAMMER = "swap_hammer",
		HACK = "swap_machete",
		SHOVEL = "swap_shovel"
	}
	local inst = playerfn(inst)
	local anim0 = "buling_diaomin_4"
	local bodyanim = "body_expo_letterman_yellow_beige"
	local leganim = "legs_pinstripe_pants_black_jet"
	inst.AnimState:OverrideSymbol("face", "nil", "face")
	inst.AnimState:OverrideSymbol("hair_hat", anim0, "hair")
	inst.AnimState:OverrideSymbol("hair", anim0, "hair")
	inst.AnimState:OverrideSymbol("headbase_hat", anim0, "headbase_hat") 
	inst.AnimState:OverrideSymbol("headbase", "buling_diaomin_9", "headbase")
	inst.AnimState:OverrideSymbol("torso", bodyanim, "torso") 
	--inst.AnimState:OverrideSymbol("hand", bodyanim, "hand") 
	inst.AnimState:OverrideSymbol("arm_upper", bodyanim, "arm_upper")
	inst.AnimState:OverrideSymbol("skirt", bodyanim, "skirt") 
	inst.AnimState:OverrideSymbol("arm_lower", bodyanim, "arm_lower") 
	inst.AnimState:OverrideSymbol("leg", leganim, "leg") 
	inst.AnimState:OverrideSymbol("torso_pelvis", leganim, "torso_pelvis")
	--inst.AnimState:OverrideSymbol("foot", leganim, "foot")
	inst.AnimState:OverrideSymbol("arm_lower", "bulingbuling", "arm_lower")
	inst:AddComponent("leader")
	inst.items = items
	--
	inst.components.health:SetMaxHealth(1000)
	inst.components.combat:SetAttackPeriod(0.5)
	inst.components.combat:SetRetargetFunction(3, Retarget)
	inst.components.follower.leader = (doer or inst)
	local brain = require "brains/buling_abigailbrain"
	inst:SetBrain(brain)
	inst.buling_kitten = {}
	inst:DoTaskInTime(0.1,function()
		for k=1,6 do
			if not inst.buling_kitten[k] then
				inst.buling_kitten[k] =  SpawnPrefab("buling_kitten_follower")
				inst.buling_kitten[k].components.follower.leader = inst
				inst.buling_kitten[k].Transform:SetPosition(inst.Transform:GetWorldPosition())
			end
		end
	end)
	return inst
end
local function herald(inst, doer)
	local items ={
		AXE = "swap_axe",
		PICK = "swap_pickaxe",
		SWORD = "swap_buling_tigershark_weapon",
		HAMMER = "swap_hammer",
		HACK = "swap_machete",
		SHOVEL = "swap_shovel"
	}
	local inst = playerfn(inst)
	local anim0 = "buling_diaomin_8"
	local bodyanim = "body_cardigan_black_jet"
	local leganim = "legs_jeans_black_scribble"
	inst.AnimState:OverrideSymbol("face", "nil", "face")
	inst.AnimState:OverrideSymbol("hair_hat", anim0, "hair")
	inst.AnimState:OverrideSymbol("hair", anim0, "hair")
	inst.AnimState:OverrideSymbol("headbase_hat", anim0, "headbase_hat") 
	inst.AnimState:OverrideSymbol("headbase", "buling_diaomin_9", "headbase")
	inst.AnimState:OverrideSymbol("torso", bodyanim, "torso")  
	inst.AnimState:OverrideSymbol("arm_upper", bodyanim, "arm_upper")
	inst.AnimState:OverrideSymbol("skirt", bodyanim, "skirt") 
	inst.AnimState:OverrideSymbol("arm_lower", bodyanim, "arm_lower") 
	inst.AnimState:OverrideSymbol("leg", leganim, "leg") 
	inst.AnimState:OverrideSymbol("torso_pelvis", leganim, "torso_pelvis")
	inst.AnimState:OverrideSymbol("arm_lower", "bulingbuling", "arm_lower")
	inst:AddComponent("leader")
	inst.items = items
	--
	inst.components.health:SetMaxHealth(1000)
	inst.components.combat:SetAttackPeriod(3)
	inst.components.combat:SetRetargetFunction(3, Retarget)
	inst.components.follower.leader = (doer or inst)
	local brain = require "brains/abigailbrain"
	inst:SetBrain(brain)
	inst:DoTaskInTime(0.1,function()
		if not inst.follower_dragon then
			inst.follower_dragon =  SpawnPrefab("buling_herald_follower")
			inst.follower_dragon.components.follower.leader = inst
			inst.follower_dragon.Transform:SetPosition(inst.Transform:GetWorldPosition())
		end
	end)
	return inst
end
return Prefab("buling_player",moonmonster,assets),
Prefab("buling_dragon",dragon,assets),
Prefab("buling_taigershark",taigershark,assets),
Prefab("buling_herald",herald,assets),
Prefab("buling_diaomin",playerfn,assets)