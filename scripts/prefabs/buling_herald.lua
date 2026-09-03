local assets ={}
local function KeepTargetFn(inst, doer, target)
    return inst.components.combat:CanTarget(target)
end
local function Retarget(inst, doer)
    local notags = {"FX", "NOCLICK","INLIMBO"}
    local newtarget = FindEntity(inst, 20, function(guy)
	local master = inst.components.follower.leader
            return  guy.components.combat and master and 
                    inst.components.combat:CanTarget(guy) and
                    (master.components.combat.target == guy or guy.components.combat.target == master )
    end, nil, notags)

    return newtarget
end
local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    local physics = inst.entity:AddPhysics()
	local sound = inst.entity:AddSoundEmitter()
    inst.Transform:SetFourFaced()
	MakeGhostPhysics(inst, 1, 0.5)
    RemovePhysicsColliders(inst)
    
    local light = inst.entity:AddLight()
    inst.Light:Enable(false)
    inst.Light:SetRadius(2)
    inst.Light:SetFalloff(0.5)
    inst.Light:SetIntensity(.75)
    inst.Light:SetColour(235/255,121/255,12/255)
    anim:SetBank("dragonfly")
	inst.Transform:SetScale(1.3,1.3,1.3)
	MakeLargePropagator(inst)
    inst.components.propagator.decayrate = 0
    anim:SetBuild("dragonfly_build")
    anim:PlayAnimation("idle",true)
    anim:SetMultColour(1, 1, 1, 0.5)
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = 8
    inst:SetStateGraph("SGbuling_dragon_follower")
	inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/dragonfly/fly", "flying")

    local brain = require "brains/buling_hulk_task"
    inst:SetBrain(brain)
	
    inst.sg.sg.states.attack.onenter = function(inst)
		inst.AnimState:SetDeltaTimeMultiplier(2)
		inst.components.combat:StartAttack()
        inst.AnimState:PlayAnimation("atk")
	end
	inst.sg.sg.states.attack.onexit = function(inst)
		inst.AnimState:SetDeltaTimeMultiplier(1)
	end
    inst.persists = false
	inst:AddComponent("follower")
    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(50)
    inst.components.combat:SetAttackPeriod(TUNING.CRAWLINGHORROR_ATTACK_PERIOD)
    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('shadow_creature')
	inst:DoTaskInTime(1,function()
		local master = inst.components.follower.leader
		if master then
			master:ListenForEvent("buling_attack", function()
				if master.components.combat.target then
					inst:FacePoint(Point(master.components.combat.target.Transform:GetWorldPosition()))
				end
				inst.sg:GoToState("attack")
			end)
		end
	end)
	inst:DoPeriodicTask(1,function()
		if not inst.components.follower.leader then
			inst:Remove()
		end
	end)
    return inst
end
local function fn2(Sim)
    
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
    local shadow = inst.entity:AddDynamicShadow()
    --local s  = 1.25
    --inst.Transform:SetScale(s,s,s)
	trans:SetSixFaced()
    MakeGhostPhysics(inst, 1, 0.5)
    RemovePhysicsColliders(inst)
    anim:SetBank("ancient_spirit")
    anim:SetBuild("ancient_spirit")
    anim:PlayAnimation("idle", true)
	anim:SetMultColour(1, 1, 1, 0.5)
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = 8
    inst.components.locomotor.runspeed = 8
	inst:AddComponent("follower")
    inst:SetStateGraph("SGancientherald")
	local brain = require "brains/buling_hulk_task"
    inst:SetBrain(brain)
    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(TUNING.ANCIENT_HERALD_DAMAGE)
    inst.summon_time = GetTime()
    inst.taunt_time = GetTime()
	inst.persists = false
	inst:DoPeriodicTask(1,function()
		if not inst.components.follower.leader then
			inst:Remove()
		end
	end)
    return inst
end
local function kittenfn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    local physics = inst.entity:AddPhysics()
	local sound = inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	local shadow = inst.entity:AddDynamicShadow()
    MakeGhostPhysics(inst, 1, 0.5)
	inst.Transform:SetScale(0.3,0.3,0.3)
	shadow:SetSize( 1, 1.5 )
    trans:SetFourFaced()
    anim:SetBank("sharkitten")
    anim:SetBuild("sharkitten_build")
    anim:PlayAnimation("idle")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    MakePoisonableCharacter(inst)
    MakeSmallBurnable(inst)
    MakeSmallPropagator(inst)
    inst:AddComponent("inspectable")
    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = 15
    inst.components.locomotor.runspeed = 15
    inst:AddComponent("combat")
    inst.components.combat:SetRetargetFunction(2, Retarget)
    inst.components.combat:SetKeepTargetFunction(KeepTargetFn)
    inst:AddComponent("sleeper")
    inst:AddComponent("follower")
    --inst:AddComponent("health")
	inst:AddTag("notarger")
    local brain = require "brains/buling_hulk_task"
    inst:SetBrain(brain)
	inst.persists = false
    inst:SetStateGraph("SGbuling_shark")
	inst:DoPeriodicTask(1,function()
		if not inst.components.follower.leader then
			inst:Remove()
		end
	end)
    return inst
end
return Prefab("buling_dragon_follower", fn, assets),
Prefab("buling_kitten_follower", kittenfn, assets),
Prefab("buling_herald_follower", fn2, assets)