local success_deco, DecoCreator = pcall(require, "prefabs/deco_util")
if not success_deco or not DecoCreator then
    DecoCreator = {
        GetLights = function(self) return { SMALL = {} } end,
        Create = function(self, name, bank, build, anim, data)
            local function fn()
                local inst = CreateEntity()
                inst.entity:AddTransform()
                inst.entity:AddAnimState()
                inst.AnimState:SetBank(bank)
                inst.AnimState:SetBuild(build)
                inst.AnimState:PlayAnimation(anim, data and data.loopanim or false)
                return inst
            end
            return Prefab(name, fn)
        end
    }
end
local assets ={
	Asset("ANIM", "anim/buling_rocky.zip"),
	Asset("ANIM", "anim/hat_tiexue.zip"),
	Asset("ANIM", "anim/buling_plane.zip"),
	Asset("ANIM", "anim/swap_buling_weapon.zip"),
	Asset("ANIM", "anim/buling_parachute.zip"),
	Asset("ANIM", "anim/buling_saomiaofx.zip"),
	Asset("ANIM", "anim/buling_morph_door.zip"),
	Asset("ANIM", "anim/buling_fuyoudun.zip"),
	Asset("ANIM", "anim/buling_house.zip"),
	Asset("ANIM", "anim/buling_door.zip"),
	
}

local function jidi(inst, doer)
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst:AddComponent("inspectable")
	inst:AddTag("robot")
	inst.AnimState:SetBank("buling_zaxiang")
    inst.AnimState:SetBuild("buling_zaxiang")
	inst:AddTag("buling_yingdi")
	inst.Transform:SetScale(2, 2, 2)
	inst.AnimState:PlayAnimation("jidi")
	inst:AddComponent("inventory")
	inst:AddComponent( "childspawner" )
	inst.components.childspawner:SetRegenPeriod(10)
	inst.components.childspawner:SetSpawnPeriod(10)
	inst.components.childspawner:SetMaxChildren(10)
	inst.components.childspawner:StartSpawning()
	inst.components.childspawner:StartRegen()
	inst.components.childspawner.childname = "buling_player"
	inst.components.inventory.maxslots = 25
	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(2000)
	inst:AddComponent("combat")
	return inst
end
local function jiangluosan(inst, doer)
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    --inst:AddComponent("inspectable")
	inst.AnimState:SetBank("buling_parachute")
    inst.AnimState:SetBuild("buling_parachute")
	--inst.Transform:SetScale(2, 2, 2)
	inst.AnimState:PlayAnimation("idle")
	inst:ListenForEvent("animover", function()
		SpawnPrefab("small_puff").Transform:SetPosition(inst:GetPosition():Get())
		SpawnPrefab("buling_player").Transform:SetPosition(inst.Transform:GetWorldPosition())
		inst:Remove()
	end)
	return inst
end
local function planefn(Sim)
		local function OnThrown(inst, doer, owner, target)
		if target ~= owner then
			owner.SoundEmitter:PlaySound("dontstarve/wilson/boomerang_throw")
		end
		inst.AnimState:PlayAnimation("idle", true)
	end
	local function OnHit(inst, doer, owner, target)
		if target then
			inst.bulingtarget = target
		end
		local impactfx = SpawnPrefab("explode_small")
		if impactfx then
			local follower = impactfx.entity:AddFollower()
			follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, 0, 0 )
			impactfx:FacePoint(inst.Transform:GetWorldPosition())
		end
		inst.Physics:SetMotorVel(8,0,0)
	end
	local function testforplant(inst, doer)
		local x,y,z = inst.Transform:GetWorldPosition()
		local ent = TheSim:FindFirstEntityWithTag("player")
		if ent and ent:GetDistanceSqToInst(inst) < 1 and inst:HasTag("nofire") then
			inst:Remove()
		end
		local target = FindEntity(inst, 1, function(item) 
			return inst.bulingtarget and item == inst.bulingtarget 
		end)
		if target and not inst:HasTag("bulingcd") and target.components.combat and target.components.health and not target.components.health:IsDead() then
			inst.bulingtarget.components.combat:GetAttacked(inst,45)
			inst:AddTag("bulingcd")
			local impactfx = SpawnPrefab("explode_small")
			if impactfx then
				local follower = impactfx.entity:AddFollower()
				follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, 0, 0 )
				impactfx:FacePoint(inst.Transform:GetWorldPosition())
			end 
			inst.task = inst:DoTaskInTime(.5,function() 
				inst:RemoveTag("bulingcd")
			end)
		end
	end
	local inst = CreateEntity()
	local trans = inst .entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)
    inst.Transform:SetFourFaced()
    anim:SetBank("buling_plane")
    anim:SetBuild("buling_plane")
    anim:PlayAnimation("idle")
    anim:SetRayTestOnBB(true);
    inst:AddTag("projectile")
    inst:AddTag("thrown")
	inst.Physics:SetMotorVel(8,0,0)
    inst:AddComponent("inspectable")
	inst:AddComponent("locomotor")
    inst:AddComponent("projectile")
    inst.components.projectile:SetSpeed(10)
    --inst.components.projectile:SetCanCatch(true)
    inst.components.projectile:SetOnThrownFn(OnThrown)
    inst.components.projectile:SetOnHitFn(OnHit)
    --inst.components.projectile:SetOnCaughtFn(OnCaught)
    inst.components.projectile:SetLaunchOffset(Vector3(0, 0.2, 0))
	
	inst:DoPeriodicTask(2,function() 
		inst.Physics:SetMotorVel(8,0,0)
		if inst.bulingtarget and inst.bulingtarget ~= (doer or inst) and inst.bulingtarget:IsValid() then
			local pos = inst.bulingtarget:GetPosition()
			inst:ForceFacePoint(pos.x+math.random(-8,8),pos.y,pos.z+math.random(-8,8))
		else
			inst:AddTag("nofire")
			inst.bulingtarget = (doer or inst)
		end
	end)
	inst:DoPeriodicTask(1,function() 
		inst.Physics:SetMotorVel(8,0,0)
		if inst.bulingtarget and inst.bulingtarget:IsValid()  then 
			local pos = inst.bulingtarget:GetPosition()
			inst:ForceFacePoint(pos.x,pos.y,pos.z)
		end
	end)
	inst:DoTaskInTime(5,function()
		inst:AddTag("nofire")
		inst.bulingtarget = (doer or inst)
	end)
	inst:DoPeriodicTask(0.1,function() testforplant(inst) end)
    return inst
end
local function empfn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	MakeInventoryPhysics(inst)
	inst.persists = false
	inst.AnimState:SetBank("buling_box")
	inst.AnimState:SetBuild("buling_box")
	inst.AnimState:PlayAnimation("emp")
	local function onthrown(inst, doer, thrower, pt, time_to_target)
		inst.Physics:SetFriction(.2)
		inst:FacePoint(pt:Get())
		local shadow = SpawnPrefab("warningshadow")
		shadow.Transform:SetPosition(pt:Get())
		shadow:shrink(time_to_target, 2, 0.5)
		inst.UpdateTask = inst:DoPeriodicTask(FRAMES, function()
		local pos = inst:GetPosition()
			if pos.y <= 0.3 then
				inst:DoTaskInTime(0.1, function()
					local pos = Vector3(inst.Transform:GetWorldPosition())
					local ents = TheSim:FindEntities(pos.x, 0, pos.z, 3, nil, {"FX", "NOCLICK", "DECOR", "INLIMBO"})
					SpawnPrefab("groundpoundring_fx").Transform:SetPosition(inst:GetPosition():Get())
					SpawnPrefab("groundpound_fx").Transform:SetPosition(inst:GetPosition():Get())
					for k,v in pairs(ents) do
						print(k,v)
						if v and v:HasTag("bp_source") and v.beeritem ~= nil then
							if v.components.container then v.components.container:DropEverything() end
							local tornado = SpawnPrefab(v.beeritem)
							tornado.Transform:SetPosition(v.Transform:GetWorldPosition())
							v:Remove()
							SpawnPrefab("lightning_rod_fx").Transform:SetPosition(v:GetPosition():Get())
							SpawnPrefab("statue_transition_2").Transform:SetPosition(v:GetPosition():Get())
							inst:Remove()
						end
						if v.components.beerpower then
							v.components.beerpower.power = 0
							SpawnPrefab("lightning_rod_fx").Transform:SetPosition(v:GetPosition():Get())
							inst:Remove()
						end
					end
				end)
			end
		end)
	end
	inst:AddComponent("throwable")
	inst.components.throwable.onthrown = onthrown
	inst.components.throwable.random_angle = 0
	inst.components.throwable.max_y = 50
	inst:DoTaskInTime(2,function()
		inst:Remove()
	end)
	return inst
end

local function saomiaofx(inst, doer)
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
	inst.AnimState:SetBank("buling_saomiao")
    inst.AnimState:SetBuild("buling_saomiaofx")
	inst.AnimState:PlayAnimation("idle")
	inst.AnimState:SetLayer(LAYER_BACKGROUND)
	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
	inst.AnimState:SetSortOrder(3)
	inst.persists = false
	inst:ListenForEvent("animover", function()
		inst:Remove()
	end)
	return inst
end
local function bulingfx(inst, doer)
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
	inst.persists = false
    --MakeInventoryPhysics(inst)
	return inst
end
local function buling_fuyoudun(inst, doer)
	local function task(inst, doer)
		inst:DoPeriodicTask(0.5,function()
			if inst.atkmode ~= "fangyu" then
				local pos = Vector3(inst.Transform:GetWorldPosition())
				local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 3.5)
				local Istarget = false
				for k,v in pairs(ents) do
					if inst.components.combat:CanTarget(v) and v ~= (doer or inst) then
						if inst.atkmode == "zhongli" and (v == (doer or inst).components.combat.target or (doer or inst) == v.components.combat.target or v == inst.components.combat.target) then
							v.components.combat:GetAttacked((doer or inst),10)
							inst.AnimState:PlayAnimation("atking",true)
							Istarget = true
						elseif inst.atkmode == "jingong" and ((v == (doer or inst).components.combat.target or (doer or inst) == v.components.combat.target or v == inst.components.combat.target) or v:HasTag("monster") or v:HasTag("hostile")) then
							v.components.combat:GetAttacked((doer or inst),10)
							inst.AnimState:PlayAnimation("atking",true)
							Istarget = true
						end
					end
				end
				if Istarget == false then
					inst.AnimState:PushAnimation("atk",true)
				end
			end
		end)
	end
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
	inst.AnimState:SetBank("buling_fuyoudun")
    inst.AnimState:SetBuild("buling_fuyoudun")
	inst.AnimState:PlayAnimation("idle",true)
	inst.persists = false
	inst.atkmode = "fangyu"
	inst:AddComponent("combat")
	local _target = doer or inst
	_target:ListenForEvent("snowskeleton_atkmodeatk", function()
		inst.atkmode = "jingong"
		inst.AnimState:PlayAnimation("atk",true)
		inst.task = task(inst)
		inst.AnimState:SetBank("buling_fuyoudun2")
		--inst.AnimState:SetMultColour(255/255,155/255,155/255,1)
	end)
	local _target = doer or inst
	_target:ListenForEvent("snowskeleton_atkmodeneu", function()
		inst.atkmode = "zhongli"
		inst.AnimState:PlayAnimation("atk",true)
		inst.task = task(inst)
		--inst.AnimState:SetMultColour(1,1,1,1)
		inst.AnimState:SetBank("buling_fuyoudun")
	end)
	local _target = doer or inst
	_target:ListenForEvent("snowskeleton_atkmodedef", function()
		inst.atkmode = "fangyu"
		inst.AnimState:PlayAnimation("idle",true)
		if inst.task then
			inst.task:Cancel()
			inst.task = nil
		end
		--inst.AnimState:SetMultColour(1,1,1,1)
		inst.AnimState:SetBank("buling_fuyoudun")
	end)
	local _target = doer or inst
	_target:ListenForEvent("kamen_rider_off", function()
		inst:Remove()
	end)
	local _target = doer or inst
	_target:ListenForEvent("death", function()
		inst:Remove()
	end)
	return inst
end
local function house(inst, doer)
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
	inst.AnimState:SetBank("buling_house")
    inst.AnimState:SetBuild("buling_house")
	inst.AnimState:PlayAnimation("idle")
	inst.Transform:SetScale(2.5, 2.5, 2.5)
	inst.persists = false
	return inst
end
local function buling_light(inst, doer)
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
	inst.entity:AddLight()
	inst.Light:SetColour(1, 1, 1)
	inst.Light:Enable(true)
	inst.Light:SetIntensity(.75)
    inst.Light:SetFalloff( 0.9 )
    inst.Light:SetRadius( 20 )
	return inst
end
local function window(inst, doer)
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
	inst.AnimState:SetBank("buling_door")
    inst.AnimState:SetBuild("buling_door")
	inst.AnimState:PlayAnimation("buling_airship_window")
	inst.Transform:SetScale(2.8, 2.5, 1.8)
	return inst
end
return Prefab("buling_jidi", jidi, assets),
Prefab("buling_parachute", jiangluosan, assets),
Prefab("buling_player_emp", empfn, assets),
Prefab("buling_saomiaofx", saomiaofx, assets),
Prefab("buling_fx", bulingfx, assets),
Prefab("buling_fuyoudun", buling_fuyoudun, assets),
Prefab("buling_house", house, assets),
Prefab("buling_light_fx", buling_light, assets),
Prefab( "buling_plane", planefn, assets),
Prefab( "buling_airship_window", window, assets),
DecoCreator:Create("buling_accademy_beam",              "buling_door", "buling_door", "buling_airship_deco",  {decal=true, loopanim=true, light=DecoCreator:GetLights().SMALL}),
DecoCreator:Create("buling_accademy_beam2",              "buling_door", "buling_door", "buling_airship_deco2",  {decal=true, loopanim=true, light=DecoCreator:GetLights().SMALL})
