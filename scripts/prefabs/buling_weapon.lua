local GLOBAL = _G
local assets ={
	Asset("ATLAS", "images/inventoryimages/buling_mine.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_yajinggao.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_yajingfu.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_yajingjian.xml"),
	Asset("ANIM", "anim/swap_buling_acher.zip"),
	--
}
local function repair(inst, doer,itemname,Symbol)
	local function onequip(inst, owner, from_inventory)
	local doer = owner
		owner.AnimState:OverrideSymbol("swap_object", itemname, Symbol or itemname)
		owner.AnimState:Show("ARM_carry")
		owner.AnimState:Hide("ARM_normal")
		if inst.components.finiteuses.current<= 0 then
			local hands = (doer or inst).components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
			inst:DoTaskInTime(0.1,function()
				owner.components.inventory:DropItem(hands)
			end)
		end
		inst.task0 = inst:DoPeriodicTask(0.1,function()
			local lavafx = SpawnPrefab("sparks_fx")
			if inst.buling_spell >= 1 and inst.buling_spell < 5 then
				lavafx = SpawnPrefab("sparks_green_fx")
			elseif inst.buling_spell >= 5 then
				lavafx = SpawnPrefab("sparks_green_fx")
				lavafx.AnimState:SetMultColour(255/255,12/255,12/255,1)
			end
			lavafx.Transform:SetPosition(inst.Transform:GetWorldPosition())
		end)
	end
	local function onunequip(inst, owner)
	local doer = owner
		owner.AnimState:Hide("ARM_carry")
		owner.AnimState:Show("ARM_normal")
		if inst.task0 then
			inst.task0:Cancel()
			inst.task0 = nil
		end
	end
	inst:AddComponent("equippable")
	inst.components.equippable:SetOnEquip( onequip )
	inst.components.equippable:SetOnUnequip( onunequip )
	inst.components.finiteuses.OnSave =  function (self)
		return {uses = self.current}
	end
end
local function DoDamage(inst, doer, rad,damage)
    local pos = inst:GetPosition()
	local ents = TheSim:FindEntities(pos.x,0, pos.z, rad, nil, {"FX", "DECOR", "INLIMBO"})
	for k,v in pairs(ents) do
		if v.components.combat and v.components.health and not v.components.health:IsDead()and  not v:HasTag("player") and not v:HasTag("wall") and v~= inst then
			v.components.combat:GetAttacked((doer or inst), damage)
			--v.components.combat:GetAttacked((doer or inst), 1)
	    end
	end
end
local function SetLightValue(inst, doer, val1, val2, time)
    inst.components.fader:StopAll()
    if val1 and val2 and time then
        inst.Light:Enable(true)
        inst.components.fader:Fade(val1, val2, time, function(v) inst.Light:SetIntensity(v) end)
    else    
        inst.Light:Enable(false)
    end
end
local function onnearmine(inst, doer, ents)   
    local detonate = false
    for i,ent in ipairs(ents)do
        if not ent:HasTag("player") then
            detonate = true
            break
        end
    end
    if inst.primed and detonate then
        inst.SetLightValue(inst, 0,0.75,0.2 )
        inst.AnimState:PlayAnimation("red_loop", true)
        --start beep
        inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/boss/hulk_metal_robot/active_LP","boom_loop")
        inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/boss/hulk_metal_robot/electro")
        inst:DoTaskInTime(0.5,function() 
            --explode, end beep
        inst.SoundEmitter:KillSound("boom_loop")
            local player = GetClosestInstWithTag("player", inst, SHAKE_DIST)
            if player then
                if ShakeAllCameras then ShakeAllCameras(CAMERASHAKE.VERTICAL, 0.5, 0.03, 2, inst, SHAKE_DIST or 40) end
            end
            inst:Hide()
            local ring = SpawnPrefab("laser_ring")
            ring.Transform:SetPosition(inst.Transform:GetWorldPosition())
            inst:DoTaskInTime(0.3,function() DoDamage(inst, 3.5,inst.components.combat.defaultdamage) inst:Remove() end)    
            
            local explosion = SpawnPrefab("laser_explosion")
            explosion.Transform:SetPosition(inst.Transform:GetWorldPosition())
            inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/boss/hulk_metal_robot/smash_3")                          
        end)
    end
end
local function OnHit(inst, doer, dist)    
    inst.AnimState:PlayAnimation("land")
    inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/boss/hulk_metal_robot/ribs/step_wires")
    inst.AnimState:PushAnimation("open")
    inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/boss/hulk_metal_robot/rust")    
    inst:ListenForEvent("animover", function() 
        if inst.AnimState:IsCurrentAnimation("open") then
            inst.primed  = true
            inst.AnimState:PlayAnimation("green_loop",true)
        end
    end)
end
local function minefn(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst, 75, 0.5)

    anim:SetBank("metal_hulk_mine")
    anim:SetBuild("metal_hulk_bomb")
    anim:PlayAnimation("green_loop", true)

    inst:AddTag("ancient_hulk_mine")
    inst:AddTag("nopick")
	inst.Transform:SetScale(.7,.7,.7)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.primed = true
    inst:AddComponent("locomotor")
    inst:AddComponent("complexprojectile")
    inst.components.complexprojectile:SetOnHit(OnHit)
    inst.components.complexprojectile.yOffset = 2.5

    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(40)
    --inst.components.combat.playerdamagepercent = .5

    inst:AddComponent("fader")
    inst.glow = inst.entity:AddLight()    
    inst.glow:SetIntensity(.6)
    inst.glow:SetRadius(2)
    inst.glow:SetFalloff(1)
    inst.glow:SetColour(1, 0.3, 0.3)
    inst.glow:Enable(false)
	inst:AddTag("nopick")
    inst.SetLightValue = SetLightValue
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_mine"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_mine.xml"
    inst:AddComponent("creatureprox")   
    inst.components.creatureprox.period = 0.01
    inst.components.creatureprox:SetDist(2.5,4) 
    inst.components.creatureprox:SetOnPlayerNear(onnearmine)
    inst.components.creatureprox:OnEntityWake()
	inst:AddComponent("inspectable")
    return inst
end
local function gun_weapon()
	local function onequip(inst, owner, from_inventory)
	local doer = owner
		owner.AnimState:OverrideSymbol("swap_object", "swap_buling_acher", "swap_buling_acher")
		owner.AnimState:Show("ARM_carry")
		owner.AnimState:Hide("ARM_normal")
	end
	local function onunequip(inst, owner)
	local doer = owner
		owner.AnimState:Hide("ARM_carry")
		owner.AnimState:Show("ARM_normal")
	end
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
	inst:AddTag("hand_gun")
	inst:AddTag("gun")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_yajinggao"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_yajinggao.xml"
	inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(0)
    inst.components.weapon:SetRange(20, 25)
	inst.components.weapon:SetProjectile("buling_plane")
	inst.persists = false 
	inst:AddComponent("equippable")
	inst.components.equippable:SetOnEquip( onequip )
	inst.components.equippable:SetOnUnequip( onunequip )
	inst.components.equippable.un_unequipable = true
    inst:AddComponent("inspectable")
	return inst
end
local function gun_rocky_weapon()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
	inst:AddTag("fogproof")
	inst:AddTag("venting")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_rocky_staff"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_rocky_staff.xml"
	inst.components.inventoryitem:SetOnDroppedFn(function() inst:Remove() end)
	inst.persists = false 
	inst:AddComponent("equippable")
	inst.components.equippable.un_unequipable = true
	inst.components.equippable.insulated = true
	inst:AddComponent("weapon")
	inst.components.weapon:SetRange(4, 4)
	inst.components.weapon:SetDamage(100)
	inst:AddComponent("waterproofer")
	inst.components.waterproofer:SetEffectiveness(1)
	return inst
end
local function boat_hat()
	local function onequip(inst, owner, from_inventory)
	local doer = owner
		owner.AnimState:OverrideSymbol("swap_hat", "hat_tiexue", "swap_hat")
        owner.AnimState:Show("HAT")
		owner.AnimState:Show("HAT_HAIR")
		owner.AnimState:Hide("HEAD")
		owner.AnimState:Hide("HAIRFRONT")
	end
	local function onunequip(inst, owner)
	local doer = owner
		owner.AnimState:Show("HEAD")
		owner.AnimState:Show("HAIRFRONT")
		owner.AnimState:Hide("HEAD_HAIR")
		owner.AnimState:Hide("HAT")
	end
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_diandonggao"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_diandonggao.xml"
	inst.persists = false 
	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
	inst.components.equippable:SetOnEquip( onequip )
	inst.components.equippable:SetOnUnequip( onunequip )
	inst.components.equippable.un_unequipable = true
    inst:AddComponent("inspectable")
	return inst
end
local function cancreatelight(inst, doer, caster, target, pos)
	local ground = TheWorld
	if target and target.components.combat and target.components.health and not target.components.health:IsDead() and not target:HasTag("player") and not target:HasTag("wall") and not inst:HasTag("cding") and inst.components.finiteuses.current > 0 then
		return true
	elseif ground and pos and not inst:HasTag("cding") then
		local tile = ground.Map:GetTileAtPoint(pos.x, pos.y, pos.z)
		return  tile ~= GROUND.IMPASSIBLE and tile < GROUND.UNDERGROUND
	end
	return false
end
local function onfinished(inst)
	if inst.components.equippable then
		local owner = inst.components.equippable and inst.components.equippable.equippedto
		local target = (owner or inst)
		local item = (target.components and target.components.inventory and target.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS))
        if inst == item then
            target.components.inventory:GiveItem(item)
        end
        inst:RemoveComponent("equippable")
    end
end 
local function attack(inst, doer, attacker, target)
	inst.buling_spell = inst.buling_spell + 1
	if inst.buling_spell > 10 then
		inst.buling_spell = 10
	end
end
local function diandonggao()
	local function createlight(inst, doer, target, pos)
		local caster = (doer or inst)
		if target and target ~= nil then
			pos = Vector3(target.Transform:GetWorldPosition())
		end
		if inst.buling_spell < 1 then
			caster:ForceFacePoint(pos)
			caster.Physics:SetMotorVelOverride(20,0,0)
            caster.components.locomotor:EnableGroundSpeedMultiplier(false)
			inst:AddTag("cding")
			inst.task = inst:DoPeriodicTask(0.1,function()
				local lavafx = SpawnPrefab("laserscorch")
				lavafx.Transform:SetPosition(inst.Transform:GetWorldPosition())
			end)
			inst.components.finiteuses:Use(2)
			inst:DoTaskInTime(0.5,function()
				caster.components.locomotor:EnableGroundSpeedMultiplier(true)
				caster.Physics:ClearMotorVelOverride()
				caster.components.locomotor:Stop()
				if inst.task then
					inst.task:Cancel()
					inst.task = nil
				end
			end)
			inst.buling_spell = 0
		elseif inst.buling_spell >= 1 and inst.buling_spell < 5 then
			local lavafx = SpawnPrefab("explode_large")
			inst.task = inst:DoPeriodicTask(0.1,function()
				local lavafx = SpawnPrefab("sparks_green_fx")
				lavafx.Transform:SetPosition(inst.Transform:GetWorldPosition())
			end)
			DoDamage(inst, 3.5,20*inst.buling_spell)
			lavafx.Transform:SetPosition(caster.Transform:GetWorldPosition())
			caster:ForceFacePoint(pos)
			caster.Physics:SetMotorVelOverride(-20,0,0)
            caster.components.locomotor:EnableGroundSpeedMultiplier(false)
			inst:AddTag("cding")
			inst.components.finiteuses:Use(5)
			inst:DoTaskInTime(0.4,function()
				caster.components.locomotor:EnableGroundSpeedMultiplier(true)
				caster.Physics:ClearMotorVelOverride()
				caster.components.locomotor:Stop()
				if inst.task then
					inst.task:Cancel()
					inst.task = nil
				end
			end)
			inst.buling_spell = 0
		elseif inst.buling_spell >= 5 then
			local lavafx = SpawnPrefab("metal_hulk_ring_fx")
			lavafx.AnimState:SetOrientation( ANIM_ORIENTATION.OnGround )
            lavafx.AnimState:SetLayer( LAYER_BACKGROUND )
            lavafx.AnimState:SetSortOrder( 2 )
			lavafx.Transform:SetPosition(caster.Transform:GetWorldPosition())
			caster:ForceFacePoint(pos)
			caster.Physics:SetMotorVelOverride(-10,5,0)
            caster.components.locomotor:EnableGroundSpeedMultiplier(false)
			inst:AddTag("cding")
			inst:DoTaskInTime(0.5,function()
				caster.components.locomotor:EnableGroundSpeedMultiplier(true)
				caster.Physics:ClearMotorVelOverride()
				caster.components.locomotor:Stop()
				caster.Transform:SetPosition(pos.x, 0, pos.z)
				local lavafx2 = SpawnPrefab("laser_burst_fx")
				lavafx2.AnimState:SetOrientation( ANIM_ORIENTATION.OnGround )
				lavafx2.AnimState:SetLayer( LAYER_BACKGROUND )
				lavafx2.AnimState:SetSortOrder( 2 )
				lavafx2.Transform:SetPosition(inst:GetPosition():Get())
				SpawnPrefab("groundpound_fx").Transform:SetPosition(inst:GetPosition():Get())
				DoDamage(inst, 5,200)
			end)
			inst.buling_spell = 0
			inst.components.finiteuses:Use(50)
		end
		inst:DoTaskInTime(5,function()
			inst:RemoveTag("cding")
		end)
	end
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
	
    inst.AnimState:SetBank("buling_tool")
    inst.AnimState:SetBuild("buling_tool")
	inst.AnimState:PlayAnimation("gaozi")
	inst:AddTag("beerpowertool")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_yajinggao"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_yajinggao.xml"
	inst:AddTag("beerpowertool")
    --inst:AddTag("sees_hiddendanger")
	inst.buling_name = "swap_beerpickaxe"
	inst.symbol = "swap_beerpickaxe"
	inst.buling_spell = 0
	inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(240)
	inst.components.finiteuses:SetUses(1)
	inst.repair = repair
	inst.repair(inst,inst.buling_name,inst.symbol)
	inst.components.finiteuses:SetOnFinished(onfinished)
	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(1)
	inst.components.weapon:SetOnAttack(attack)
    inst:AddComponent("inspectable")
	inst:AddComponent("tool")
	inst.components.tool:SetAction(ACTIONS.MINE,1)
	inst.components.finiteuses:SetConsumption(ACTIONS.MINE, 1)
	inst:AddComponent("spellcaster")
    inst.components.spellcaster:SetSpellFn(createlight)
if inst.components.spellcaster.SetSpellTestFn then
        inst.components.spellcaster:SetSpellTestFn(candestroy)
    elseif inst.components.spellcaster.SetCanCastFn then
        inst.components.spellcaster:SetCanCastFn(candestroy)
    else
        inst.components.spellcaster.canCastFn = candestroy
    end
	inst.components.spellcaster.canuseonpoint = true
	inst.components.spellcaster.canuseontargets = true
    inst.components.spellcaster.canusefrominventory = false
	inst.components.spellcaster.actiontype = "SCIENCE"
	inst.components.spellcaster.castingstate = "castspell_tornado"
	return inst
end
local function dianlifu()
	local function createlight(inst, doer, target, pos)
		local caster = (doer or inst)
		if target and target ~= nil then
			pos = Vector3(target.Transform:GetWorldPosition())
		end
		if inst.buling_spell < 1 then
			local lavafx2 = SpawnPrefab("laser_burst_fx")
			lavafx2.AnimState:OverrideSymbol("scorched_ground1", "nil","nil")
			lavafx2.Transform:SetPosition(inst:GetPosition():Get())
			DoDamage(inst, 5,20)
			inst.components.finiteuses:Use(3)
			inst.buling_spell = 0
		elseif inst.buling_spell >= 1 and inst.buling_spell < 5 then
			local monsterbiao = {}
			caster:ForceFacePoint(pos)
			caster.Physics:SetMotorVelOverride(20,0,0)
			caster.components.locomotor:EnableGroundSpeedMultiplier(false)
			inst.task = inst:DoPeriodicTask(0.1, function()
				SpawnPrefab("dragoon_charge_fx").Transform:SetPosition(inst.Transform:GetWorldPosition())
				local pos = inst:GetPosition()
				local ents = TheSim:FindEntities(pos.x,0, pos.z, 2, nil, {"FX", "DECOR", "INLIMBO"})
				for k,v in pairs(ents) do
					if v.components.combat and v.components.health and not v.components.health:IsDead()and  not v:HasTag("player") and not v:HasTag("wall") and v~= inst then
						if not table.contains(monsterbiao, v.GUID) then
							v.components.combat:GetAttacked((doer or inst), 20)
							table.insert(monsterbiao, v.GUID)
						end
					end
				end
				inst.components.finiteuses:Use(5)
			end)
			inst:DoTaskInTime(0.4,function()
				caster.components.locomotor:EnableGroundSpeedMultiplier(true)
				caster.Physics:ClearMotorVelOverride()
				caster.components.locomotor:Stop()
				if inst.task then
					inst.task:Cancel()
					inst.task = nil
				end
			end)
			inst.buling_spell = inst.buling_spell - 1
			if inst.buling_spell <= 0 then
				inst.buling_spell = 0
			end
		elseif inst.buling_spell >= 5 then
			local monsterbiao = {}
			inst.task = inst:DoPeriodicTask(0.1,function()
				caster:Hide()
				caster.components.locomotor:EnableGroundSpeedMultiplier(false)
				caster.Physics:SetMotorVelOverride(15,0,0)
				SpawnPrefab("shock_machines_fx").Transform:SetPosition(inst.Transform:GetWorldPosition())
				inst:AddTag("cding")
				local face_pt = (TheInput and TheInput:GetWorldPosition()) or (caster and caster:GetPosition())
				if face_pt then caster:ForceFacePoint(face_pt.x, face_pt.y, face_pt.z) end
				local pos = inst:GetPosition()
				local ents = TheSim:FindEntities(pos.x,0, pos.z, 3, nil, {"FX", "DECOR", "INLIMBO"})
				for k,v in pairs(ents) do
					if v.components.combat and v.components.health and not v.components.health:IsDead()and  not v:HasTag("player") and not v:HasTag("wall") and v~= inst then
						if not table.contains(monsterbiao, v.GUID) then
							v.components.combat:GetAttacked((doer or inst), 200)
							SpawnPrefab("feathers_packim").Transform:SetPosition(v.Transform:GetWorldPosition())
							table.insert(monsterbiao, v.GUID)
						end
					end
					if v:HasTag("tree") and v.components.workable and v.components.workable.workleft > 0 and inst.components.finiteuses.current >5 then
						v.components.workable:Destroy((doer or inst))
						inst.SoundEmitter:PlaySound("dontstarve/forest/treeCrumble")
						inst.components.finiteuses:Use(5)
						SpawnPrefab("feathers_packim").Transform:SetPosition(v.Transform:GetWorldPosition())
					end
				end
			end)
			inst:DoTaskInTime(5,function()
				caster.Physics:ClearMotorVelOverride()
				caster.components.locomotor:Stop()
				if inst.task then
					inst.task:Cancel()
					inst.task = nil
				end
				caster:Show()
				inst:RemoveTag("cding")
			end)
			inst.buling_spell = 0
		end
	end
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
	
    inst.AnimState:SetBank("buling_tool")
    inst.AnimState:SetBuild("buling_tool")
	inst.AnimState:PlayAnimation("fuzi")
	inst:AddTag("beerpowertool")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst.buling_spell = 0
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_yajingfu"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_yajingfu.xml"
	inst:AddTag("beerpowertool")
    inst.buling_name = "swap_beeraxe"
	inst.symbol = "swap_beeraxe"
	inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(240)
	inst.components.finiteuses:SetUses(1)
	inst.repair = repair
	inst.repair(inst,inst.buling_name,inst.symbol)
	inst.components.finiteuses:SetOnFinished(onfinished)
    inst:AddComponent("spellcaster")
    inst.components.spellcaster:SetSpellFn(createlight)
if inst.components.spellcaster.SetSpellTestFn then
        inst.components.spellcaster:SetSpellTestFn(candestroy)
    elseif inst.components.spellcaster.SetCanCastFn then
        inst.components.spellcaster:SetCanCastFn(candestroy)
    else
        inst.components.spellcaster.canCastFn = candestroy
    end
	inst.components.spellcaster.canuseonpoint = true
	inst.components.spellcaster.canuseontargets = true
    inst.components.spellcaster.canusefrominventory = false
	inst.components.spellcaster.actiontype = "SCIENCE"
	inst.components.spellcaster.castingstate = "castspell_tornado"
	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(15)
	inst.components.weapon:SetOnAttack(attack)
    inst:AddComponent("inspectable")
	inst:AddComponent("tool")
	inst.components.tool:SetAction(ACTIONS.CHOP,3)
	inst.components.finiteuses:SetConsumption(ACTIONS.CHOP, 1)
	return inst
end
local function jiandao(Sim)
	local function createlight(inst, doer, target, pos)
		local caster = (doer or inst)
		if target and target ~= nil then
			pos = Vector3(target.Transform:GetWorldPosition())
		end
		if inst.buling_spell < 1 then
			local jiandao = SpawnPrefab("buling_jiandao")
			jiandao:RemoveComponent("inspectable")
			jiandao:RemoveComponent("inventoryitem")
			jiandao:RemoveComponent("equippable")
			jiandao.persists = false
			jiandao.Transform:SetPosition(pos.x,pos.y,pos.z)
			SpawnPrefab("groundpound_fx_hulk").Transform:SetPosition(pos.x,pos.y,pos.z)
			DoDamage(inst,4,20)
			inst:DoTaskInTime(0.5,function()
				SpawnPrefab("vortex_cloak_fx").Transform:SetPosition(pos.x,pos.y,pos.z)
				caster.Transform:SetPosition(pos.x,pos.y,pos.z)
				jiandao:Remove()
			end)
			inst.components.finiteuses:Use(5)
			inst.buling_spell = inst.buling_spell + 1
		elseif inst.buling_spell >= 1 and inst.buling_spell < 5 then
			SpawnPrefab("bramblefx").Transform:SetPosition(caster.Transform:GetWorldPosition())
			DoDamage(inst,4,20)
			inst:AddTag("cding")
			inst.components.finiteuses:Use(10)
			for k =1,8 do
				local jiandao = SpawnPrefab("buling_seed_flint")
				jiandao:RemoveComponent("inspectable")
				jiandao:RemoveComponent("inventoryitem")
				jiandao.persists = false
				jiandao.entity:AddAnimState():PlayAnimation("seeds_3")
				jiandao.AnimState:OverrideSymbol("seeds01", "swap_buling_shears", "swap_shears")
				jiandao.AnimState:SetOrientation( ANIM_ORIENTATION.OnGround )
				jiandao.AnimState:SetLayer( LAYER_BACKGROUND )
				jiandao.AnimState:SetSortOrder( 2 )
				local angle = jiandao:GetAngleToPoint(pos:Get())
				angle = angle+45*k
				jiandao.Transform:SetRotation(angle)
				jiandao.Physics:SetMotorVelOverride(20,0,0)
				jiandao.Transform:SetPosition(caster.Transform:GetWorldPosition())
				jiandao.Transform:SetScale(.7, .7, .7)
				jiandao:DoTaskInTime(2,function()
					jiandao:Remove()
				end)
				local monsterbiao = {}
				jiandao:DoPeriodicTask(0.1, function()
					--SpawnPrefab("dragoon_charge_fx").Transform:SetPosition(jiandao.Transform:GetWorldPosition())
					local pos = jiandao:GetPosition()
					local ents = TheSim:FindEntities(pos.x,0, pos.z, 2, nil, {"FX", "DECOR", "INLIMBO"})
					for k,v in pairs(ents) do
						if v and v.components.combat and v.components.health and not v.components.health:IsDead()and  not v:HasTag("player") and not v:HasTag("wall") and v~= inst then
							if not table.contains(monsterbiao, v.GUID) then
								v.components.combat:GetAttacked((doer or inst), 10 * inst.buling_spell+10)
								table.insert(monsterbiao, v.GUID)
							end
						end
					end
				end)
				inst:DoTaskInTime(5,function()
					inst:RemoveTag("cding")
				end)
			end
			inst.buling_spell = 0
			elseif inst.buling_spell >= 5 then
			inst:AddTag("cding")
			caster:ForceFacePoint(pos)
			caster.Physics:SetMotorVelOverride(15,0,0)
			caster.components.locomotor:EnableGroundSpeedMultiplier(false)
			for k =1,12 do
				local jiandao = SpawnPrefab("buling_seed_flint")
				jiandao:RemoveComponent("inspectable")
				jiandao:RemoveComponent("inventoryitem")
				jiandao.persists = false
				jiandao.entity:AddAnimState():PlayAnimation("seeds_3")
				jiandao.AnimState:OverrideSymbol("seeds01", "swap_buling_shears", "swap_shears")
				jiandao.AnimState:SetOrientation( ANIM_ORIENTATION.OnGround )
				jiandao.AnimState:SetLayer( LAYER_BACKGROUND )
				jiandao.AnimState:SetSortOrder( 2 )
				local angle = jiandao:GetAngleToPoint(pos:Get())
				angle = angle+30*k
				jiandao.Transform:SetRotation(angle)
				jiandao.Physics:SetMotorVelOverride(20,0,0)
				jiandao.Transform:SetPosition(pos.x,pos.y,pos.z)
				jiandao.Transform:SetScale(.7, .7, .7)
				jiandao:DoTaskInTime(2,function()
					jiandao.Physics:Stop()
					jiandao.monsterbiao = {}
				end)
				jiandao:DoTaskInTime(3,function()
					jiandao:ForceFacePoint(pos)
					jiandao.Physics:SetMotorVelOverride(25,0,0)
				end)
				jiandao:DoTaskInTime(5,function()
					jiandao:Remove()
				end)
				jiandao.monsterbiao = {}
				jiandao:DoPeriodicTask(0.1, function()
					SpawnPrefab("dragoon_charge_fx").Transform:SetPosition(jiandao.Transform:GetWorldPosition())
					local pos = jiandao:GetPosition()
					local ents = TheSim:FindEntities(pos.x,0, pos.z, 2, nil, {"FX", "DECOR", "INLIMBO"})
					for k,v in pairs(ents) do
						if v and v.components.combat and v.components.health and not v.components.health:IsDead()and  not v:HasTag("player") and not v:HasTag("wall") and v~= inst then
							if not table.contains(jiandao.monsterbiao, v.GUID) then
								v.components.combat:GetAttacked((doer or inst), 50)
								table.insert(jiandao.monsterbiao, v.GUID)
							end
						end
						if v and v.components.shearable and v.components.shearable:IsActionValid((ACTIONS.SHEAR or ACTIONS.DIG)) then
							v.components.shearable:Shear(caster)
						end
						if v and v.components.workable and v.components.workable.action == (ACTIONS.SHEAR or ACTIONS.DIG) and v.components.workable:IsActionValid((ACTIONS.SHEAR or ACTIONS.DIG)) then
							v.components.workable:WorkedBy(caster, 1)
						end
					end
				end)
				inst:DoTaskInTime(5,function()
					inst:RemoveTag("cding")
					inst.components.finiteuses:Use(240)
				end)
			end
			inst:DoTaskInTime(.8,function() 
				caster.components.locomotor:EnableGroundSpeedMultiplier(true)
				caster.Physics:ClearMotorVelOverride()
				caster.components.locomotor:Stop()
			end)
			inst.buling_spell = 0
		end
		--clouds_bombsplash
	end
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    anim:SetBank("buling_tool")
    anim:SetBuild("buling_tool")
    anim:PlayAnimation("jiandao")
    inst:AddTag("shears")
	inst:AddTag("beerpowertool")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(TUNING.SHEARS_DAMAGE)
	inst.components.weapon:SetOnAttack(attack)
    inst:AddTag("shears")
	inst:AddTag("beerpowertool")
    inst:AddComponent("tool")
    inst.components.tool:SetAction((ACTIONS.SHEAR or ACTIONS.DIG) or ACTIONS.DIG, 2)
	inst.buling_name = "swap_buling_shears"
	inst.symbol = "swap_shears"
	inst:AddComponent("spellcaster")
    inst.components.spellcaster:SetSpellFn(createlight)
if inst.components.spellcaster.SetSpellTestFn then
        inst.components.spellcaster:SetSpellTestFn(candestroy)
    elseif inst.components.spellcaster.SetCanCastFn then
        inst.components.spellcaster:SetCanCastFn(candestroy)
    else
        inst.components.spellcaster.canCastFn = candestroy
    end
	inst.components.spellcaster.canuseonpoint = true
	inst.components.spellcaster.canuseontargets = true
    inst.components.spellcaster.canusefrominventory = false
	inst.components.spellcaster.actiontype = "SCIENCE"
	inst.components.spellcaster.castingstate = "castspell_tornado"
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(120)
    inst.components.finiteuses:SetUses(1)
	inst.buling_spell = 0
    inst.repair = repair
	inst.repair(inst,inst.buling_name,inst.symbol)
    inst.components.finiteuses:SetOnFinished( onfinished )
    inst.components.finiteuses:SetConsumption((ACTIONS.SHEAR or ACTIONS.DIG) or ACTIONS.DIG, 1)
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "buling_yajingjian"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_yajingjian.xml"
    return inst
end
return Prefab( "buling_mine", minefn, assets),
Prefab( "buling_boat_hat", boat_hat, assets),
Prefab( "buling_pickaxe_weapon", diandonggao, assets),
Prefab( "buling_shears_weapon", jiandao, assets),
Prefab( "buling_axe_weapon", dianlifu, assets),
Prefab( "buling_rocky_staff", gun_rocky_weapon, assets),
Prefab( "buling_plane_gun", gun_weapon, assets)