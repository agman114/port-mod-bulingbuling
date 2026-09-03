local assets =
{
}

local function OnBlocked(owner, data)
	owner.SoundEmitter:PlaySound("dontstarve_DLC002/common/armour/obsidian")
	if data then
		if data.attacker and (data.attacker.components.combat == nil or (data.attacker.components.combat.defaultdamage > 0)) then
			if not owner.counterattackfx then
				owner.counterattackfx = SpawnPrefab("onikiri_counterattackfx")
			end
			local pos = Vector3(data.attacker.Transform:GetWorldPosition())
			owner.counterattackfx.Transform:SetPosition(pos.x+(math.random(-5,5)),pos.y,pos.z+(math.random(-5,5)))
			owner.counterattackfx:AtkTarget(data.attacker)
		end
	end
end

local function onequip(inst, owner, from_inventory)
	local doer = owner 
    owner.AnimState:OverrideSymbol("swap_hat", "woodlegs", "swap_hat")
    inst:ListenForEvent("attacked", OnBlocked, owner)
end

local function onunequip(inst, owner)
	local doer = owner 
    owner.AnimState:ClearOverrideSymbol("swap_hat")
    inst:RemoveEventCallback("attacked", OnBlocked, owner)
end

local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
    inst.entity:AddSoundEmitter()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    inst.AnimState:SetBank("armor_obsidian")
    inst.AnimState:SetBuild("armor_obsidian")
    inst.AnimState:PlayAnimation("anim")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    if MakeInventoryFloatable then
        MakeInventoryFloatable(inst, "idle_water", "anim")
        if inst.components.floatable then
            inst.components.floatable:SetOnHitWaterFn(function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/obsidian_wetsizzles")
            end)
        end
    end
    
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "armorobsidian"
    inst.components.inventoryitem.atlasname = "images/inventoryimages.xml"
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
    
    return inst
end
local function onatktarget(inst, doer)
	inst.target.components.combat:GetAttacked((doer or inst), 50)
	stopatk(inst)
end
local function stopatk(inst, doer)
	inst.Physics:Stop()
	inst.Physics:Stop()
	if inst.move then
		inst.move:Cancel()
		inst.move = nil
	end
	if inst.stop then
		inst.stop:Cancel()
		inst.stop = nil
	end
	if inst.updatetask then
		inst.updatetask:Cancel()
		inst.updatetask = nil
	end
	inst:RemoveEventCallback("animover", onatktarget)
	inst:Hide()
end
local function atkdamage(inst, doer)
	if inst.target and inst.target:IsValid() and inst.target.components.health and not inst.target.components.health:IsDead() then
		inst.AnimState:PlayAnimation("lunge_pst")
		inst:ListenForEvent("animover", onatktarget)
	end
end
local function AtkTarget(inst, doer,target)
	inst:Show()
	inst.target = target
	inst.updatetask = inst:DoPeriodicTask(0.5, atkdamage, 1)
	inst.AnimState:PlayAnimation("lunge_pre")
	inst.AnimState:PushAnimation("lunge_lag")
	inst:FacePoint(target.Transform:GetWorldPosition())
	inst.move = inst:DoTaskInTime(0.5,function()
		inst.Physics:SetMotorVel(20,0,0)
	end)
	inst.stop = inst:DoTaskInTime(3,function()
		inst:stopatk()
	end)
end
local function counterattackfxfn(inst, doer)
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

	MakeSpecialGhostPhysics(inst,1,.5)
	inst.Transform:SetFourFaced()
	inst.persists = false
	inst.AnimState:SetBank("wilson")
	inst.AnimState:SetBuild("onikiri")
	inst.AnimState:PlayAnimation("nil")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	inst.Transform:SetFourFaced()
	inst.persists = false
	inst.AnimState:SetBank("wilson")
	inst.AnimState:SetBuild("onikiri")
	inst.AnimState:PlayAnimation("nil")
	inst.AtkTarget = AtkTarget
	inst.stopatk = stopatk
	inst.AnimState:OverrideSymbol("swap_object","onikiri_weapon_default", "swap_object")
	inst:Hide()
	return inst
end
return Prefab( "onikiri_testhat", fn, assets),
Prefab( "onikiri_counterattackfx", counterattackfxfn, assets)

