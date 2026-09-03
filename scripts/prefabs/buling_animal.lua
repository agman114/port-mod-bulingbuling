local assets ={
	Asset("ANIM", "anim/buling_milk_goat_build.zip"),
	Asset("ANIM", "anim/buling_log_beefalo_baby.zip"),
}

--奶羊
local function mikufn(Sim)
	local function setcharged(inst, doer, instant)
	end
	SetSharedLootTable( 'buling_milk_goat',
	{
		{'meat',             1.00},
		{'meat',             1.00},
		{'goatmilk',             1.00},
	})
    local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize(1.75,.75)
    inst.Transform:SetFourFaced()
	MakeCharacterPhysics(inst, 100, 1)
    MakePoisonableCharacter(inst)
    anim:SetBank("lightning_goat")
    anim:SetBuild("buling_milk_goat_build")
    anim:PlayAnimation("idle_loop", true)
    anim:Hide("fx")
    inst:AddTag("lightninggoat")
    inst:AddTag("animal")
    inst:AddTag("lightningrod")
    local light = inst.entity:AddLight()
    inst.Light:Enable(false)
    inst.Light:SetRadius(.85)
    inst.Light:SetFalloff(0.5)
    inst.Light:SetIntensity(.75)
    inst.Light:SetColour(255/255,255/255,236/255)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(350)
    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(TUNING.LIGHTNING_GOAT_DAMAGE)
    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(4)
    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('buling_milk_goat') 
    inst:AddComponent("inspectable")
    inst:AddComponent("knownlocations")
    inst:AddComponent("herdmember")
    inst.components.herdmember:SetHerdPrefab("lightninggoatherd")
    MakeMediumBurnableCharacter(inst, "lightning_goat_body")
    MakeMediumFreezableCharacter(inst, "lightning_goat_body")
    inst.lightningpriority = 10
    inst.setcharged = setcharged
    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = TUNING.LIGHTNING_GOAT_WALK_SPEED
    inst.components.locomotor.runspeed = TUNING.LIGHTNING_GOAT_RUN_SPEED
	inst:AddComponent("harvestable")
    inst.components.harvestable:SetUp("buling_goatmilk", 1,10)
	inst.components.harvestable:StartGrowing()
    inst:SetStateGraph("SGlightninggoat")
    local brain = require("brains/lightninggoatbrain")
    inst:SetBrain(brain)
    return inst
end
--木牛
local function logfn(Sim)
	local function setcharged(inst, doer, instant)
	end
    local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize(1.75,.75)
    inst.Transform:SetSixFaced()
	MakeCharacterPhysics(inst, 100, 1)
    MakePoisonableCharacter(inst)
    anim:SetBank("beefalo")
    anim:SetBuild("buling_log_beefalo_baby")
    anim:PlayAnimation("idle_loop", true)
    anim:Hide("fx")
    inst:AddTag("lightninggoat")
    inst:AddTag("animal")
    inst:AddTag("lightningrod")
    local light = inst.entity:AddLight()
    inst.Light:Enable(false)
    inst.Light:SetRadius(.85)
    inst.Light:SetFalloff(0.5)
    inst.Light:SetIntensity(.75)
    inst.Light:SetColour(255/255,255/255,236/255)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(350)
    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(TUNING.LIGHTNING_GOAT_DAMAGE)
    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(4)
    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('buling_milk_goat') 
    inst:AddComponent("inspectable")
    inst:AddComponent("knownlocations")
    inst:AddComponent("herdmember")
    inst.components.herdmember:SetHerdPrefab("lightninggoatherd")
    MakeMediumBurnableCharacter(inst, "lightning_goat_body")
    MakeMediumFreezableCharacter(inst, "lightning_goat_body")
    inst.lightningpriority = 10
    inst.setcharged = setcharged
    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = 2
    inst.components.locomotor.runspeed = 9
	inst:AddComponent("harvestable")
    inst.components.harvestable:SetUp("buling_goatmilk", 1,10)
	inst.components.harvestable:StartGrowing()
    inst:SetStateGraph("SGBeefalo")
    local brain = require("brains/lightninggoatbrain")
    inst:SetBrain(brain)
    return inst
end
local function logfn(Sim)
	local sounds = 
	{
		walk = "dontstarve/creatures/beefalo_baby/walk",
		grunt = "dontstarve/creatures/beefalo_baby/grunt",
		yell = "dontstarve/creatures/beefalo_baby/yell",
		swish = "dontstarve/creatures/beefalo_baby/tail_swish",
		curious = "dontstarve/creatures/beefalo_baby/curious",
		angry = "dontstarve/creatures/beefalo_baby/angry",
		sleep = "dontstarve/creatures/beefalo_baby/sleep",
	}
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	inst.sounds = sounds
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 2.5, 1.25 )    
    inst.Transform:SetSixFaced()
    inst.Transform:SetScale(0.5, 0.5, 0.5)
    MakePoisonableCharacter(inst)
    MakeCharacterPhysics(inst, 100, .75)    
    inst:AddTag("beefalo")
    inst:AddTag("baby")
    anim:SetBank("beefalo")
    anim:SetBuild("buling_log_beefalo_baby")
    anim:PlayAnimation("idle_loop", true)    
    inst:AddTag("animal")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("eater")
    inst.components.eater:SetVegetarian()    
    inst:AddComponent("combat") 
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.BABYBEEFALO_HEALTH)
    inst:AddComponent("lootdropper")    
    inst:AddComponent("inspectable")
    inst:AddComponent("sleeper")    
    inst:AddComponent("knownlocations")
    inst:AddComponent("herdmember")
    MakeLargeBurnableCharacter(inst, "swap_fire")
    MakeLargeFreezableCharacter(inst, "beefalo_body")
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = 2
    inst.components.locomotor.runspeed = 9
    local brain = require "brains/lightninggoatbrain"
    inst:SetBrain(brain)
    inst:SetStateGraph("SGBeefalo")
	inst.ShouldBeg = function() return true end
    return inst
end
return Prefab("buling_milk_goat", mikufn, assets),
Prefab("buling_log_beefalo_baby", logfn, assets)