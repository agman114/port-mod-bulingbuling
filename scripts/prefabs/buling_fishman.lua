require "brains/mermbrain"
require "stategraphs/SGmerm"

local assets=
{
	Asset("SOUND", "sound/merm.fsb"),
}

local prefabs =
{
    "fish_raw_small",
    "tropical_fish",
    "froglegs",
    "fish"
}

local reg_loot = 
{
    "fish",
    "froglegs",
}

local sw_loot =
{
    "tropical_fish",
    --"froglegs"
}



local MAX_TARGET_SHARES = 5
local SHARE_TARGET_DIST = 40

local function ShouldSleep(inst, doer)
    return (TheWorld.state and TheWorld.state.isday)
           and not (inst.components.combat and inst.components.combat.target)
           and not (inst.components.homeseeker and inst.components.homeseeker:HasHome() )
           and not (inst.components.burnable and inst.components.burnable:IsBurning() )
           and not (inst.components.freezable and inst.components.freezable:IsFrozen() )
end

local function ShouldWake(inst, doer)
    return not (TheWorld.state and TheWorld.state.isday)
           or (inst.components.combat and inst.components.combat.target)
           or (inst.components.homeseeker and inst.components.homeseeker:HasHome() )
           or (inst.components.burnable and inst.components.burnable:IsBurning() )
           or (inst.components.freezable and inst.components.freezable:IsFrozen() )
end

local function RetargetFn(inst, doer)
    local defenseTarget = inst
    local home = inst.components.homeseeker and inst.components.homeseeker.home
    if home and inst:GetDistanceSqToInst(home) < TUNING.MERM_DEFEND_DIST*TUNING.MERM_DEFEND_DIST then
        defenseTarget = home
    end
    local dist = TUNING.MERM_TARGET_DIST
    if (TheWorld.state or {}) and ((TheWorld.state and TheWorld.state.isspring) or (TheWorld.state or {}):IsGreenSeason()) then
        dist = dist * TUNING.SPRING_COMBAT_MOD
    end
    local invader = FindEntity(defenseTarget or inst, dist, function(guy)
        return guy:HasTag("character") and not guy:HasTag("merm")
    end)
    return invader
end

local function KeepTargetFn(inst, doer, target)
    local home = inst.components.homeseeker and inst.components.homeseeker.home
    if home then
        return home:GetDistanceSqToInst(target) < TUNING.MERM_DEFEND_DIST*TUNING.MERM_DEFEND_DIST
               and home:GetDistanceSqToInst(inst) < TUNING.MERM_DEFEND_DIST*TUNING.MERM_DEFEND_DIST
    end
    return inst.components.combat:CanTarget(target)     
end

local function OnAttacked(inst, doer, data)
    local attacker = data and data.attacker
    if attacker and inst.components.combat:CanTarget(attacker) then
        inst.components.combat:SetTarget(attacker)
        local targetshares = MAX_TARGET_SHARES
        if inst.components.homeseeker and inst.components.homeseeker.home then
            local home = inst.components.homeseeker.home
            if home and home.components.childspawner and inst:GetDistanceSqToInst(home) <= SHARE_TARGET_DIST*SHARE_TARGET_DIST then
                targetshares = targetshares - home.components.childspawner.childreninside
                home.components.childspawner:ReleaseAllChildren(attacker)
            end
            inst.components.combat:ShareTarget(attacker, SHARE_TARGET_DIST, function(dude)
                return dude.components.homeseeker
                       and dude.components.homeseeker.home
                       and dude.components.homeseeker.home == home
            end, targetshares)
        end
    end
end

local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1.5, .75 )
    inst.Transform:SetFourFaced()

    MakeCharacterPhysics(inst, 50, .5)

    anim:SetBank("pigman")
    anim:SetBuild("merm_fisherman_build")
    anim:Hide("hat")

    inst:AddTag("character")
    inst:AddTag("merm")
    inst:AddTag("mermfighter")
    inst:AddTag("wet")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

    inst:AddComponent("locomotor")
    inst.components.locomotor.runspeed = TUNING.MERM_RUN_SPEED
    inst.components.locomotor.walkspeed = TUNING.MERM_WALK_SPEED
    
    inst:SetStateGraph("SGmerm")

    local brain = require "brains/mermbrain"
    inst:SetBrain(brain)
    
    inst:AddComponent("eater")
    inst.components.eater:SetVegetarian()
    
    inst:AddComponent("sleeper")
    inst.components.sleeper:SetWakeTest(ShouldWake)
    inst.components.sleeper:SetSleepTest(ShouldSleep)

    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "pig_torso"
    inst.components.combat:SetAttackPeriod(TUNING.MERM_ATTACK_PERIOD)
    inst.components.combat:SetRetargetFunction(1, RetargetFn)
    inst.components.combat:SetKeepTargetFunction(KeepTargetFn)
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(500)
    inst.components.combat:SetDefaultDamage(34)
    inst.components.combat:SetAttackPeriod(TUNING.MERM_ATTACK_PERIOD)

    inst:AddComponent("lootdropper")

    inst.components.lootdropper:SetLoot(reg_loot)
	inst.AnimState:OverrideSymbol("fish01", "swap_axe", "swap_axe")
    inst.AnimState:SetMultColour(0,0.2,1,1)
    inst:AddComponent("inventory")
    
    inst:AddComponent("inspectable")
    inst:AddComponent("knownlocations")
    
    MakeMediumBurnableCharacter(inst, "pig_torso")
    MakeMediumFreezableCharacter(inst, "pig_torso")

    inst:ListenForEvent("attacked", OnAttacked)
    
    return inst
end

return Prefab("buling_fishman", fn, assets, prefabs) 
