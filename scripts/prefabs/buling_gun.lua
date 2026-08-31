local assets ={
	Asset("ANIM", "anim/ui_buling_gun.zip"),
	Asset("ATLAS", "images/inventoryimages/buling_gun_zero.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_gun_dianchi_nil.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_gun_dianchi_tongliang.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_gun_qiangguan_nil.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_gun_qiangguan_yang.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_gun_jiguang_nil.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_gun_jiguang_yaoshou.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_gun_shoubing_nil.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_gun_shoubing_biaoqiang.xml"),
	
	Asset("ATLAS", "images/inventoryimages/buling_gun_ying.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_gun_yang.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_gun_qing.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_gun_white.xml"),
	
	
}
local function OnHitMiss(inst, doer, owner, target)
    inst:Remove()
end

local function OnHit(inst, doer, owner, target)
	local attacker = owner or doer or (inst.components.projectile and inst.components.projectile.owner)
	if not inst.gun and attacker and attacker.components.inventory then
		inst.gun = attacker.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
	end
	if inst.gun and inst.gun:HasTag("buling_gun") and inst.gun.components and inst.gun.components.container and inst.gun.components.container:IsFull() then
		local dianchi =  inst.gun.components.container:GetItemInSlot(1)
		inst.qiangguan =  inst.gun.components.container:GetItemInSlot(2)
		local jiguang =  inst.gun.components.container:GetItemInSlot(3)
		local shoubing =  inst.gun.components.container:GetItemInSlot(4)
		local cost = inst.qiangguan.cost - shoubing.cost
		if cost <= 0 then
			cost = 1
		end
		dianchi.components.beerpower:UpBeer(cost)
		--
		if jiguang and jiguang.gunfn then
			jiguang:gunfn(inst,target)
		end
		if target and target.components.combat and target.components.health and not target.components.health:IsDead() then
			if inst.qiangguan:HasTag("chuanjia") then
				target.components.health:DoDelta(inst.qiangguan.buling_damage*-1)
			elseif inst.gun.prefab == "buling_gun_ying" then
				target.components.combat:GetAttacked(inst.gun,inst.qiangguan.buling_damage)
				target.components.combat:SetTarget((doer or inst))
			else
				target.components.combat:GetAttacked((doer or inst),inst.qiangguan.buling_damage)
			end
		end
	end
    inst:Remove()
end
local function zidan()
    local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)
    
    anim:SetBank("projectile")
    anim:SetBuild("staff_projectile")
    
    inst:AddTag("projectile")
    inst:AddComponent("projectile")
    inst.components.projectile:SetSpeed(50)
    inst.components.projectile:SetLaunchOffset(Vector3(2, .5, 0))
    inst.components.projectile:SetOnMissFn(OnHitMiss)
    inst.AnimState:PlayAnimation("fire_spin_loop", true)
	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
    inst.components.projectile:SetOnHitFn(OnHit)
    return inst
end
--
local function buling_hand_gun(inst, anim, doer)
	if type(anim) ~= "string" and type(doer) == "string" then
		anim = doer
	end
	anim = anim or "swap_buling_gun_zero"
	local OnTakeAmmo = nil
	local function onequip(inst, owner, from_inventory)
		local doer = owner
		owner.AnimState:OverrideSymbol("swap_object", "swap_buling_weapon", anim)
		owner.AnimState:Show("ARM_carry")
		owner.AnimState:Hide("ARM_normal")
		if OnTakeAmmo then OnTakeAmmo(inst, owner) end
		inst:DoTaskInTime(0.1,function()
			inst.components.container:Open((doer or inst))
		end)
	end
	local function onunequip(inst, owner)
	local doer = owner
		owner.AnimState:Hide("ARM_carry")
		owner.AnimState:Show("ARM_normal")
		inst:DoTaskInTime(0.1,function()
			inst.components.container:Close((doer or inst))
		end)
	end
	local slotpos = {
		Vector3(-140,37, 0), 
		Vector3(-70, 0, 0), 
		Vector3(0,0, 0),
		Vector3(-140,-32, 0),
	}
	local function itemtest(inst, item, slot)
		if slot == 1 and item:HasTag("buling_gun_dianchi") then
			return true
		end
		if slot == 2 and item:HasTag("buling_gun_qiangguan") then
			return true
		end
		if slot == 3 and item:HasTag("buling_gun_jiguang") then
			return true
		end
		if slot == 4 and item:HasTag("buling_gun_shoubing") then
			return true
		end
		return false
	end
	local function openui(inst, doer)
		inst.components.container:Open((doer or inst))
	end
	OnTakeAmmo = function(inst, doer)
		local item = inst.components.container:GetItemInSlot(4)
		local dianchi = inst.components.container:GetItemInSlot(1)
		if inst.components.container:IsFull() and dianchi.components.beerpower.power > 0 then
			inst.components.weapon:SetRange(item.range,item.range)
			inst.components.weapon:SetProjectile("buling_gun_zidan")
			inst:AddTag("hand_gun")
			inst:AddTag("gun")
		else
			inst.components.weapon:SetRange(nil, nil)
			inst.components.weapon:SetProjectile(nil)
			inst:RemoveTag("hand_gun")
			inst:RemoveTag("gun")
		end
	end
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
	inst.AnimState:PlayAnimation("gun_zero")
    inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)
    inst:AddComponent("inventoryitem")
	inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(1)
    inst.components.weapon:SetRange(nil, nil)
	inst.components.weapon:SetProjectile(nil)
	inst:AddComponent("equippable")
	inst.components.equippable:SetOnEquip( onequip )
	inst.components.equippable:SetOnUnequip( onunequip )
    inst:AddComponent("inspectable")
	inst:AddComponent("container")
    inst.components.container:SetNumSlots(#slotpos)
	inst.components.container.widgetslotpos = slotpos
	inst.components.container.widget = { slotpos = inst.components.container.widgetslotpos, animbank = inst.components.container.widgetanimbank or 'ui_chest_3x3', animbuild = inst.components.container.widgetanimbuild or 'ui_chest_3x3', pos = inst.components.container.widgetpos or Vector3(0,200,0), buttoninfo = inst.components.container.widgetbuttoninfo, side_align_tip = 100 }
    inst.components.container.side_align_tip = 160
	inst.components.container.itemtestfn = itemtest
	inst.components.container.widgetanimbank = "ui_chest_3x3"
    inst.components.container.widgetanimbuild = "ui_buling_gun"
    inst.components.container.widgetpos = Vector3(310,-280,0)
    inst.components.container.type = "gun"
    inst.components.container.canbeopened = false
	
	--inst.components.container.canbeopened = false
	inst:ListenForEvent("itemget", OnTakeAmmo)
	inst:ListenForEvent("itemlose", OnTakeAmmo)
	inst:ListenForEvent("notEnergy", OnTakeAmmo)
	--inst:ListenForEvent("equipped", openui)
	inst:AddTag("buling_gun")
	return inst
end
local function buling_gun_zero(inst, doer)
	local inst=buling_hand_gun(inst,"swap_buling_gun_zero")
	inst.components.inventoryitem.imagename = "buling_gun_zero"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_gun_zero.xml"
	return inst
end
local function buling_gun_qing(inst, doer)
	local inst=buling_hand_gun(inst,"swap_buling_gun_qing")
	inst.components.equippable.walkspeedmult = .4
	inst.components.inventoryitem.imagename = "buling_gun_qing"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_gun_qing.xml"
	inst.AnimState:SetBank("buling_item")
    inst.AnimState:SetBuild("buling_item")
	inst.AnimState:PlayAnimation("buling_gun_qing")
	return inst
end
local function onattack_yang(inst, doer, attacker, target)
	local dianchi = inst.components.container:GetItemInSlot(1)
	if dianchi and dianchi.components.beerpower then
		dianchi.components.beerpower:UpBeer(-5)
	end
end
local function buling_gun_yang(inst, doer)
	local inst=buling_hand_gun(inst,"swap_buling_gun_yang")
	inst.components.inventoryitem.imagename = "buling_gun_yang"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_gun_yang.xml"
	inst.components.weapon:SetOnAttack(onattack_yang)
	inst.AnimState:SetBank("buling_item")
    inst.AnimState:SetBuild("buling_item")
	inst.AnimState:PlayAnimation("buling_gun_yang")
	return inst
end
local function canattack(inst, doer, target)
	local dianchi = inst.components.container:GetItemInSlot(1)
	return inst.components.container:IsFull() and dianchi ~= nil and dianchi.components.beerpower ~= nil and dianchi.components.beerpower.power > 0
end
local function buling_gun_white(inst, doer)
	local inst=buling_hand_gun(inst,"swap_buling_gun_white")
	inst.cding = 0
	inst.components.inventoryitem.imagename = "buling_gun_white"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_gun_white.xml"
	inst.components.weapon.canattackfn = canattack
	inst.AnimState:SetBank("buling_item")
    inst.AnimState:SetBuild("buling_item")
	inst.components.weapon:SetDamage(1)
	inst.AnimState:PlayAnimation("buling_gun_white")
	return inst
end
return Prefab("buling_gun_zidan", zidan, assets),
Prefab("buling_gun_zero", buling_gun_zero, assets),
Prefab("buling_gun_yang", buling_gun_yang, assets),
Prefab("buling_gun_white", buling_gun_white, assets),
Prefab("buling_gun_qing", buling_gun_qing, assets)