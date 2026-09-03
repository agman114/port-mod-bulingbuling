local function candestroy(staff, caster, target)
	if not target then return false end
	if caster and caster.components and caster.components.combat then
		return caster.components.combat:CanTarget(target)
	end
	return true
end

local assets ={
	Asset("ANIM", "anim/swap_snowskeleton.zip"),
	Asset("ANIM", "anim/swap_goldenshadowguard.zip"),
	Asset("ANIM", "anim/redlycoris.zip"),
	Asset("ATLAS", "images/inventoryimages/buling_rider_lock.xml"),
}
local function buling_morph(inst, doer,owner,name)
	owner.AnimState:OverrideSymbol("swap_hat", name, "swap_hat")
	owner.AnimState:Show("HAT")
	owner.AnimState:Show("HAT_HAIR")
	owner.AnimState:Hide("HEAD")
	owner.AnimState:Hide("HAIRFRONT")
	owner.AnimState:SetBuild("living_suit_build")
	owner.AnimState:OverrideSymbol("headbase", "bulingbuling", "headbase")
	owner.AnimState:OverrideSymbol("face", "bulingbuling", "face")
	owner.AnimState:OverrideSymbol("headbase_hat", "bulingbuling", "headbase_hat")
	owner.AnimState:OverrideSymbol("hair_hat", "bulingbuling", "hair_hat")
	owner.AnimState:OverrideSymbol("hair", "bulingbuling", "hair")
	inst:DoTaskInTime(2,function()
		owner:SetStateGraph("SGbuling_kamen_rider")
		if inst.clothing ~= nil then
			inst.clothing(inst,owner)
		end
		inst.components.useableitem.inuse = false
	end)
end

local function comm(inst, doer)
	local function onunequip(inst, owner)
	local doer = owner
		owner.AnimState:SetBuild("bulingbuling")
		owner.AnimState:Show("HEAD")
		owner.AnimState:Show("HAIRFRONT")
		owner.AnimState:Hide("HEAD_HAIR")
		owner.AnimState:Hide("HAT")
		inst:RemoveTag("working")
		owner:RemoveTag("not_hit_stunned")
		owner:RemoveTag("kamen_rider")
		owner:SetStateGraph("SGwilson")
		inst:DoTaskInTime(0.1,function()
			local _target = doer or inst
			_target.sg:GoToState("celebrate")
		end)
		inst.components.useableitem.inuse = false
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

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_diandonggao"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_diandonggao.xml"
    inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
	--inst.components.equippable:SetOnEquip( onequip )
	--inst.components.equippable:SetOnUnequip( onunequip )
    inst:AddComponent("inspectable")
	inst:AddComponent("armor")
    inst.components.armor.dontremove = true
	local function onusebush(inst, doer)
		if (doer or inst):HasTag("kamen_rider") then
			onunequip(inst, (doer or inst))
			local _target = doer or inst
			if _target and _target.PushEvent then _target:PushEvent("kamen_rider_off") end
			inst.components.equippable.un_unequipable = false
		else
			inst.components.equippable.un_unequipable = true
			local _target = doer or inst
			_target:AddTag("not_hit_stunned")
			local _target = doer or inst
			_target:AddTag("kamen_rider")
			local _target = doer or inst
			_target.sg:GoToState("buling_morph")
		end	
	end
	inst.buling_morph = buling_morph
	inst:AddComponent("useableitem")
	--inst.components.useableitem:SetCanInteractFn(canusebush)
	inst.components.useableitem:SetOnUseFn(onusebush)
	inst.buling_name = "swap_snowskeleton"
	return inst
end
local function snowskeleton(inst, doer)
	local function clothing(inst, doer,owner)
		local exoskeleton_sword = SpawnPrefab("buling_exoskeleton_sword")
		exoskeleton_sword.fx = SpawnPrefab("buling_fuyoudun")
		local follower = exoskeleton_sword.fx.entity:AddFollower()
		follower:FollowSymbol( owner.GUID, "body",0, 0, 0)
		owner.components.inventory:Equip(exoskeleton_sword)
	end
	local inst = comm(inst)
	inst.components.armor:InitCondition(450, 0.95)
	inst.buling_morph = buling_morph
	inst.buling_name = "swap_snowskeleton"
	inst.clothing = clothing
	--inst.components.equippable.walkspeedmult = 1.5
	return inst
end
local function goldenshadowguard(inst, doer)
	local inst = comm(inst)
	inst.components.armor:InitCondition(450, 0.95)
	inst.buling_morph = buling_morph
	inst.buling_name = "swap_goldenshadowguard"
	return inst
end
local function redlycoris(inst, doer)
	local inst = comm(inst)
	inst.buling_morph = buling_morph
	inst.buling_name = "redlycoris"
	return inst
end
--
local function exoskeleton_sword()
	local function createlight(staff, target, pos)
		if target then
			pos = Vector3(target.Transform:GetWorldPosition())
		end
		local caster = staff.components.inventoryitem.owner
		caster:ForceFacePoint(pos:Get())
		caster.Physics:SetMotorVelOverride(40,0,0)
		staff.fx.monsterbiao = {}
		staff.fx.bltask = staff.fx:DoPeriodicTask(0.1,function()
			if staff.fx.atkmode ~= "fangyu" then
				local pos = Vector3(staff.fx.Transform:GetWorldPosition())
				local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 3.5)
				local Istarget = false
				for k,v in pairs(ents) do
					if staff.fx.components.combat:CanTarget(v) and v ~= (doer or inst) and not table.contains(staff.fx.monsterbiao, v.GUID) then
						if staff.fx.atkmode == "zhongli" and (v == (doer or inst).components.combat.target or (doer or inst) == v.components.combat.target or v == staff.fx.components.combat.target) then
							v.components.combat:GetAttacked((doer or inst),15)
							staff.fx.AnimState:PlayAnimation("atking",true)
							table.insert(staff.fx.monsterbiao, v.GUID)
						end
						if staff.fx.atkmode == "jingong" and ((v == (doer or inst).components.combat.target or (doer or inst) == v.components.combat.target or v == staff.fx.components.combat.target) or v:HasTag("monster") or v:HasTag("hostile")) then
							v.components.combat:GetAttacked((doer or inst),15)
							staff.fx.AnimState:PlayAnimation("atking",true)
							table.insert(staff.fx.monsterbiao, v.GUID)
						end
					end
				end
			end
		end)
		caster:DoTaskInTime(0.5,function()
			if staff.fx.bltask then
				staff.fx.bltask:Cancel()
				staff.fx.bltask = nil
			end
			caster.Physics:ClearMotorVelOverride()
		end)
	end
	local function canusebush(inst, doer)
		if inst.fx then
			return true
		end
		return false
	end
	local function onusebush(inst, doer)
		if inst.fx.atkmode == "fangyu" then
			local _target = doer or inst
			if _target and _target.PushEvent then _target:PushEvent("snowskeleton_atkmodeneu") end
			inst.components.talker:Say(STRINGS.BULING_SNOWSKELETON_NEU)
		elseif inst.fx.atkmode == "zhongli" then
			local _target = doer or inst
			if _target and _target.PushEvent then _target:PushEvent("snowskeleton_atkmodeatk") end
			inst.components.talker:Say(STRINGS.BULING_SNOWSKELETON_ATK)
		elseif inst.fx.atkmode == "jingong" then
			local _target = doer or inst
			if _target and _target.PushEvent then _target:PushEvent("snowskeleton_atkmodedef") end
			inst.components.talker:Say(STRINGS.BULING_SNOWSKELETON_DEF)
		end
	end
	local function onunequip(inst, owner)
	local doer = owner
		if (doer or inst):HasTag("kamen_rider") then
			inst:DoTaskInTime(0.1,function()
				local exoskeleton_sword = SpawnPrefab("buling_exoskeleton_sword")
				exoskeleton_sword.fx = SpawnPrefab("buling_fuyoudun")
				local follower = exoskeleton_sword.fx.entity:AddFollower()
				follower:FollowSymbol( owner.GUID, "body",0, 0, 0)
				owner.components.inventory:Equip(exoskeleton_sword)
				inst.fx:Remove()
				inst:Remove()
			end)
		end
	end
	local inst = CreateEntity()
	inst.persists = false 
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
	inst.components.inventoryitem.imagename = "buling_rider_lock"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_rider_lock.xml"
    
    inst:AddComponent("equippable")
	inst.components.equippable.un_unequipable = true
	inst.components.equippable:SetOnUnequip( onunequip )
	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(0)
	inst.components.weapon:SetRange(3, 3)
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
	inst:AddComponent("talker")
    inst.components.talker.fontsize = 28
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(.9, .4, .4, 1)
    inst.components.talker.offset = Vector3(0,0,0)
    inst.components.talker.symbol = "swap_object"
	inst:AddComponent("useableitem")
	inst.components.useableitem:SetCanInteractFn(canusebush)
	inst.components.useableitem:SetOnUseFn(onusebush)
	--inst.components.spellcaster.castingstate = "castspell_tornado"
	local _target = doer or inst
	_target:ListenForEvent("kamen_rider_off", function()
		inst:Remove()
		inst.fx:Remove()
	end)
	return inst
end
local function goldenshadowguard_sword()
	local function createlight(staff, target, pos)

	end
	local inst = CreateEntity()
	inst.persists = false 
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
	inst.components.inventoryitem.imagename = "buling_rider_lock"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_rider_lock.xml"
    
    inst:AddComponent("equippable")
	inst.components.equippable.un_unequipable = true
	inst.components.equippable:SetOnUnequip( onunequip )
	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(0)
	inst.components.weapon:SetRange(3, 3)
	inst:AddComponent("spellcaster")
    inst.components.spellcaster:SetSpellFn(createlight)
	inst.components.spellcaster.canuseonpoint = true
	inst.components.spellcaster.canuseontargets = true
    inst.components.spellcaster.canusefrominventory = false
	inst.components.spellcaster.actiontype = "SCIENCE"
	inst:AddComponent("talker")
    inst.components.talker.fontsize = 28
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(.9, .4, .4, 1)
    inst.components.talker.offset = Vector3(0,0,0)
    inst.components.talker.symbol = "swap_object"
	inst:AddComponent("useableitem")
	local _target = doer or inst
	_target:ListenForEvent("kamen_rider_off", function()
		inst:Remove()
	end)
	return inst
end
return Prefab( "buling_snowskeleton", snowskeleton, assets),
Prefab( "buling_exoskeleton_sword", exoskeleton_sword, assets),
Prefab( "buling_goldenshadowguard", goldenshadowguard, assets),
Prefab( "buling_goldenshadowguard_sword", goldenshadowguard_sword, assets),
Prefab( "buling_redlycoris", redlycoris, assets)