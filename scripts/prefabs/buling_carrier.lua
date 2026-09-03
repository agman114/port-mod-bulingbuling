local function SendBulingRPC(rpc_name, ...)
	local rpc = (TheSim and TheSim.GetModRPC and TheSim:GetModRPC("bulingbuling", rpc_name))
		or (GLOBAL and GLOBAL.GetModRPC and GLOBAL.GetModRPC("bulingbuling", rpc_name))
		or (GLOBAL and GLOBAL.MOD_RPC and GLOBAL.MOD_RPC["bulingbuling"] and GLOBAL.MOD_RPC["bulingbuling"][rpc_name])
	if rpc then
		SendModRPCToServer(rpc, ...)
	end
end

local DoTransform
local OnClose
local carfn_onclose
require "stategraphs/SGbuling_glomling"
require "stategraphs/SGbuling_car"
local assets=
{
	Asset("ANIM", "anim/buling_glomling.zip"),
	Asset("ANIM", "anim/ui_buling_chest_5x5.zip"),
	Asset("ANIM", "anim/buling_car.zip"),
	Asset("ANIM", "anim/buling_deerclops.zip"),
}

local function LaunchProjectile(inst, doer, targetpos)
	local x, y, z = inst.Transform:GetWorldPosition()
	targetpos = targetpos or Vector3(x + 15, 0, z)
	for i = -1, 1 do
		local projectile = SpawnPrefab("buling_missile")
		if projectile then
			local spread_pos = Vector3(targetpos.x + i * 2.5, 0, targetpos.z + (i % 2) * 2.5)
			projectile.Transform:SetPosition(x, 1.8, z)
			if projectile.Launch then
				projectile:Launch(spread_pos, doer or inst)
			end
		end
	end
end

local function upcar(doer,inst)
	if inst and inst:IsValid() then
		if inst.components.combat then
			inst.components.combat:SetTarget(nil)
		end
		if inst.components.locomotor then
			inst.components.locomotor:Stop()
			inst.components.locomotor:ResetPath()
			inst.components.locomotor.wantstomoveforward = false
			inst.components.locomotor.wantstoreachdestination = false
		end
		if inst.Physics then
			inst.Physics:Stop()
			inst.Physics:SetMotorVel(0, 0, 0)
		end
		if inst.sg and inst.sg:HasState("idle") then
			inst.sg:GoToState("idle")
		end
	end
	doer:DoTaskInTime(0.1,function()
		if not doer.components.health:IsDead() and not inst.components.health:IsDead() then
			
			doer.components.temperature:SetTemp(25)
			doer.sg:GoToState("idle")
			--doer:SetStateGraph("SGwilsonboating")
			if not doer.components.driver then
				doer:AddComponent("driver")
			end
			if not doer.components.driver then
				doer:AddComponent("driver")
			end
			doer.components.driver.vehicle = inst
			doer.components.driver.driving = true
			doer:AddTag("buling_driving")
			if TheCamera then
				TheCamera:SetTarget(inst)
				TheCamera:SetHeadingTarget(45)
			end
			--local follower = doer.entity:AddFollower()
			--follower:FollowSymbol(inst.GUID,"body", 0, 0, 0 )
			--ChangeToObstaclePhysics(doer)
			--doer.HUD.controls.status:Hide()
			doer.sg:Stop()
			doer.HUD.controls.crafttabs:Hide()
			local x, y, z = inst.Transform:GetWorldPosition()
			doer.Transform:SetPosition(x, y, z)
			if inst._sync_task then
				inst._sync_task:Cancel()
				inst._sync_task = nil
			end
			inst._sync_task = inst:DoPeriodicTask(0, function()
				if doer and doer:IsValid() and inst and inst:IsValid() and doer.components.driver and doer.components.driver.driving then
					local vx, vy, vz = inst.Transform:GetWorldPosition()
					doer.Transform:SetPosition(vx, vy, vz)
				end
			end)
			doer:Hide()
			
			
			-- Retain player components.combat & locomotor for PlayerController safety
			if doer:IsValid() then
				doer:ClearBufferedAction()
				if doer.components.locomotor then
					doer.components.locomotor:Stop()
					doer.components.locomotor:ResetPath()
				end
				if doer.Physics then
					doer.Physics:Stop()
					doer.Physics:SetActive(false)
					doer.Physics:ClearCollisionMask()
					RemovePhysicsColliders(doer)
				end
			end
			if inst.brain then inst.brain:Stop() end
			if inst.StopBrain then inst:StopBrain() end
			if inst.components.locomotor then
				inst.components.locomotor:Stop()
				inst.components.locomotor:StopMoving()
				inst.components.locomotor:ResetPath()
			end
			if inst.Physics then
				inst.Physics:Stop()
				inst.Physics:SetMotorVel(0, 0, 0)
			end
		end
	end)
end
local function drop(inst, doer, viewer)
	if inst._sync_task then
		inst._sync_task:Cancel()
		inst._sync_task = nil
	end
	if inst.brain then inst.brain:Start() end
	if inst.RestartBrain then inst:RestartBrain() end
	viewer = viewer or doer or (inst.components.drivable and inst.components.drivable.driver)
	if viewer == nil or not viewer:IsValid() then
		return
	end
	
	viewer:Show()
	local pos = Vector3(inst.Transform:GetWorldPosition())
	if inst.locomotor and viewer.components.locomotor == nil then viewer.components.locomotor = inst.locomotor end
	if not viewer.components.combat then viewer:AddComponent("combat") end
	if not viewer.components.locomotor then viewer:AddComponent("locomotor") end
	--viewer.entity:AddFollower():FollowSymbol(viewer.GUID,"body", 0, 0, 0)
	viewer.Transform:SetPosition(pos.x+1,0,pos.z)
	inst.work = nil
	ChangeToCharacterPhysics(viewer)
	viewer.Physics:SetMass(75)
	viewer.HUD.controls.crafttabs:Show()
	-- viewer.entity:SetParent(nil)
	viewer.HUD.controls.status:Show()
	if not viewer.components.driver then
		viewer:AddComponent("driver")
	end
	if viewer.components.driver then
		viewer.components.driver.driving = false
	viewer:RemoveTag("buling_driving")
		viewer.components.driver.vehicle = nil
	end
	if TheCamera and viewer then
		TheCamera:SetTarget(viewer)
	end
	viewer.components.temperature:SetTemp()
	viewer.sg:Start()
	local x,y,z = (doer or inst).Transform:GetWorldPosition()
	local _target = doer or inst
	_target.Transform:SetPosition(x,2,z)
	local _target = doer or inst
	if _target and _target.PushEvent then _target:PushEvent("buling_getoff") end
	ChangeToCharacterPhysics(viewer)
	viewer.Physics:SetMass(75)
	viewer.Physics:SetActive(true)
	local staff = viewer.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
	if staff and staff.prefab == "buling_rocky_staff" then
		staff:Remove()
	end
	viewer:DoTaskInTime(1,function()
		ChangeToCharacterPhysics(viewer)
	viewer.Physics:SetMass(75)
	viewer.Physics:SetActive(true)
	end)
end
local function deathset(inst, doer)
	local _target = doer or inst
	if _target and _target.ListenForEvent then
		_target:ListenForEvent("death", function()
			if _target.components and _target.components.driver and _target.components.driver.vehicle == inst then
				inst.bulingdrop(inst, _target)
			end
		end)
	end
end
local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local sound = inst.entity:AddSoundEmitter()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	inst.entity:AddDynamicShadow()
	inst.entity:AddPhysics()
	anim:SetBloomEffectHandle("shaders/anim.ksh")
	inst.Transform:SetSixFaced(inst)
	ChangeToFlyingCharacterPhysics(inst, 1, .5)
	inst.DynamicShadow:SetSize(.8, .5)
	anim:SetBank("buling_glomling")
	anim:SetBuild("buling_glomling")
	anim:PlayAnimation("idle_loop", true)
	inst.Transform:SetScale(3, 3, 3)
	inst:AddTag("buling_carrier")
	inst:AddTag("boat")
	inst:AddTag("flying")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:SetStateGraph("SGbuling_glomling")

	inst:AddComponent("locomotor")
	inst.components.locomotor:SetSlowMultiplier(0.6)
	inst.components.locomotor.walkspeed = 4
	inst.components.locomotor.runspeed = 5
	if inst.components.locomotor.SetAllowFlyThrough then
		inst.components.locomotor:SetAllowFlyThrough(true)
	end
	inst.components.locomotor.pathcaps = { allowwater = true, hover = true, ignorecrate = true, ignorewalls = true }

	inst:AddComponent("inspectable")
	inst.Transform:SetScale(3, 3, 3)

	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(10000)
	inst.components.health:SetCurrentHealth(10000)
	inst.components.health.indestructible = true

	inst:AddComponent("combat")
	inst.components.combat:SetDefaultDamage(100)

	inst:AddComponent("container")
	inst.components.container:WidgetSetup("buling_chest_5x5")
	inst.components.container.onopenfn = function(inst, doer)
		inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
	end

	inst.bulingdrop = drop
	inst.LaunchProjectile = LaunchProjectile
	inst:AddTag("buling_carrier")
	inst:AddTag("boat")
	inst:AddTag("flying")

	inst.components.combat.canbeattackedfn = function(inst, attacker)
		if not TheWorld.ismastersim then
			SendBulingRPC("do_widget_button2", inst.GUID)
			return
		end
		local can_be_attacked = true
		if attacker == (doer or inst) then
			can_be_attacked = false
		end
		return can_be_attacked
	end

	inst.SoundEmitter:PlaySound("dontstarve/ghost/ghost_howl_LP", "howl")

	inst:AddComponent("drivable")
	inst.components.drivable.sanitydrain = TUNING.ROWBOAT_SANITY_DRAIN
	inst.components.drivable.runspeed = 5
	inst.components.drivable.OnMounted = function(self, doer)
		upcar(doer, inst)
	end
	return inst
end
local function carfn()
	local hechengbiao = {
		["buling_plane"]={
			"gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,",
		},
		["buling_rocky"]={
			"buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,buling_glass,buling_glass,buling_glass,buling_puleidi,buling_puleidi,buling_glass,gears,buling_glass,buling_puleidi,buling_puleidi,buling_glass,buling_glass,buling_glass,buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,",
			"buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,moonglass,moonglass,moonglass,buling_puleidi,buling_puleidi,moonglass,gears,moonglass,buling_puleidi,buling_puleidi,moonglass,moonglass,moonglass,buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,",
		}, 
		["buling_glomling"]={
			"buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,",
			"moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,",
		}, 
	}
	DoTransform = function(inst, doer)
	OnClose = function(inst, doer)
	if inst and inst.SoundEmitter then
		inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")
	end
end
carfn_onclose = OnClose
		print("[BULING CARRIER] OnClose triggered on vehicle inst:", inst, "by doer:", doer)
		local container = inst.components.container
		if container == nil then
			print("[BULING CARRIER] Container component is nil!")
			return
		end

		local peifang = ""
		for i = 1, container:GetNumSlots() do
			local item = container:GetItemInSlot(i)
			if item == nil then
				item = "nil"
			else
				item = item.prefab
			end
			peifang = peifang..item..","
		end

		print("[BULING CARRIER] Current peifang string:", peifang)

		local is_free = BULING_FREE_CRAFT 
			or (doer and doer.components and doer.components.builder and (doer.components.builder.freebuildmode or (doer.components.builder.IsFreeBuildMode and doer.components.builder:IsFreeBuildMode())))

		local matched_target = nil
		for k,recipes in pairs(hechengbiao) do
			for _, rec_str in ipairs(recipes) do
				if rec_str == peifang then
					matched_target = k
					print("[BULING CARRIER] String matched recipe for:", k)
					break
				end
			end
			if matched_target then break end
		end

		-- Smart Count Fallback matching for Airplane, Deerclops, Glommer & Robot
		if matched_target == nil then
			if container:Has("deerclops_eyeball", 9) or container:Has("deerclops_eyeball", 25) then
				matched_target = "buling_deerclops"
				print("[BULING CARRIER] Smart item count matched buling_deerclops!")
			elseif container:Has("gears", 25) or container:Has("gears", 9) then
				matched_target = "buling_plane"
				print("[BULING CARRIER] Smart item count matched buling_plane!")
			elseif container:Has("buling_glass", 25) or container:Has("moonglass", 25) or container:Has("buling_glass", 9) or container:Has("moonglass", 9) then
				matched_target = "buling_glomling"
				print("[BULING CARRIER] Smart item count matched buling_glomling!")
			else
				local has_puleidi = container:Has("buling_puleidi", 1) or container:Has("buling_puleidi_plank", 1)
				local has_glass = container:Has("buling_glass", 1) or container:Has("moonglass", 1)
				local has_gears = container:Has("gears", 1)
				if has_puleidi and has_glass and has_gears then
					matched_target = "buling_rocky"
					print("[BULING CARRIER] Smart item count matched buling_rocky!")
				end
			end
		end

		if matched_target then
			print("[BULING CARRIER] Executing transformation to:", matched_target)
			if inst.bulingdrop then
				inst.bulingdrop(inst, doer or inst)
			end

			if not is_free then
				if matched_target == "buling_plane" then
					container:ConsumeByName("gears", 25)
				elseif matched_target == "buling_glomling" then
					container:ConsumeByName("buling_glass", 25)
				elseif matched_target == "buling_rocky" then
					if not container:ConsumeByName("buling_puleidi", 16) then
						container:ConsumeByName("buling_puleidi_plank", 16)
					end
					if not container:ConsumeByName("buling_glass", 8) then
						container:ConsumeByName("moonglass", 8)
					end
					container:ConsumeByName("gears", 1)
				end
			end

			local x, y, z = inst.Transform:GetWorldPosition()
			container:DropEverything()
			local spawned = SpawnPrefab(matched_target)
			if spawned then
				spawned.Transform:SetPosition(x, y, z)
				print("[BULING CARRIER] Successfully spawned:", matched_target, "at:", x, y, z)
				local smoke = SpawnPrefab("maxwell_smoke")
				if smoke then
					smoke.Transform:SetPosition(x, y, z)
				end
			end
			inst:Remove()
		else
			print("[BULING CARRIER] No recipe match found for peifang string")
		end
	end
	local slotpos = {}
	for y = 4, 0, -1 do
		for x = 0, 4 do
			table.insert(slotpos, Vector3(80*x-80*2, 80*y-80*2,0))
		end
	end
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local sound = inst.entity:AddSoundEmitter()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	inst.entity:AddDynamicShadow()
    inst.entity:AddPhysics()
    inst.Transform:SetFourFaced(inst)
    MakeCharacterPhysics(inst, 1, .5)
    inst.DynamicShadow:SetSize( .8, .5 )
    anim:SetBank("buling_car")
    anim:SetBuild("buling_car")
    anim:PlayAnimation("idle", true)
	inst:AddTag("buling_carrier")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

    inst:AddComponent("locomotor")
    inst.components.locomotor:SetSlowMultiplier( 0.6 )
    inst.components.locomotor.walkspeed = 10
    inst.components.locomotor.runspeed =  10
    inst:AddComponent("inspectable")
	--inst.Transform:SetScale(3, 3, 3)
	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(10000)
	inst.components.health:SetCurrentHealth(10000)
	inst.components.health.indestructible = true
    inst:AddComponent("knownlocations")
    inst:AddComponent("combat")
	inst.components.combat.canbeattackedfn = function (inst,attacker)
		local can_be_attacked = true
		if attacker == (doer or inst) then
			can_be_attacked = false
		end
		return can_be_attacked
	end
	inst:SetStateGraph("SGbuling_car")
	inst.bulingdrop = drop
	inst.LaunchProjectile = LaunchProjectile
	inst:AddTag("buling_carrier")
    ------------------    
    inst.SoundEmitter:PlaySound("dontstarve/ghost/ghost_howl_LP", "howl")
	inst:AddComponent("inspectable")
	deathset(inst)
	inst:AddComponent("drivable")
	inst.components.drivable.sanitydrain = TUNING.ROWBOAT_SANITY_DRAIN
	inst.components.drivable.runspeed = 10
	inst.components.drivable.OnMounted = function(self,doer)
		upcar(doer,inst)
		local _target = doer or inst
		if _target and _target.PushEvent then _target:PushEvent("buling_drive_car") end
	end
	local widgetbuttoninfo = {
		text = "Transform / Превратить",
		position = Vector3(0, -220, 0),
		fn = function(inst, doer)
			if not TheWorld.ismastersim then
				SendBulingRPC("do_widget_button", inst.GUID)
				return
			end
			DoTransform(inst, doer)
		end
	}

	inst:AddComponent("container")
	inst.components.container:SetNumSlots(#slotpos)
	inst.components.container.widgetslotpos = slotpos
	inst.components.container.widgetbuttoninfo = widgetbuttoninfo
	inst.components.container.widget = {
		slotpos = inst.components.container.widgetslotpos,
		animbank = 'ui_chest_3x3',
		animbuild = 'ui_buling_chest_5x5',
		pos = Vector3(0,0,0),
		buttoninfo = widgetbuttoninfo,
		side_align_tip = 100
	}
	inst.components.container.widgetpos = Vector3(0,0,0)
	inst.components.container.side_align_tip = 100
	inst.components.container.widgetanimbank = "ui_chest_3x3"
	inst.components.container.widgetanimbuild = "ui_buling_chest_5x5"
	inst.components.container.onclosefn = OnClose
	inst.beeritem = "buling_car_log_item"
    return inst
end
local function gdfn()
	local function get_name(inst, doer)
		local name = STRINGS.NAMES[string.upper(inst.prefab)]
		return name.."\n [HP:"..inst.components.health.currenthealth.."/"..inst.components.health.maxhealth.."]\n [ATK"..inst.components.combat.defaultdamage.."]"
	end
	local function applyupgrades(inst, doer)
		local health_percent = inst.components.health:GetPercent()
		inst.components.health.maxhealth = math.ceil(2000 + inst.hp_level)
		inst.components.combat.defaultdamage = 100 + inst.atk_level
		inst.components.health:SetPercent(health_percent)
	end
	local function ShouldAcceptItem(inst, doer, item)
		if item.prefab == "buling_zhongziding" then
			return true
		end
		if item.prefab == "buling_glass" and (doer or inst).components.inventory:Has("buling_glass",10) then
			return true
		end
		return false
	end
	local function OnGetItemFromPlayer(inst, doer, giver, item)
		if item.prefab == "buling_zhongziding" then
			inst.hp_level = inst.hp_level + 1
		end
		if item.prefab == "buling_glass" then
			inst.atk_level = inst.atk_level + 1
			giver.components.inventory:ConsumeByName("buling_glass", 9)
		end
		applyupgrades(inst)
	end
	local function onsave(inst, data)
		data = data or {}
		data.hp_level = inst.hp_level
		data.atk_level = inst.atk_level
	end
	local function onpreload(inst, data)
		if data then
			inst.hp_level = data.hp_level
			inst.atk_level = data.atk_level
			applyupgrades(inst)
			if data.hp_level then
				inst.components.health.currenthealth = 2000 + inst.hp_level
			end
			if data.atk_level then
				inst.components.combat.defaultdamage = 100 + inst.atk_level
			end
		end
	end
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	inst.hp_level = 0
	inst.atk_level = 0
	inst.entity:AddDynamicShadow()
	inst.Transform:SetFourFaced(inst)
	MakeCharacterPhysics(inst, 1, .5)
	anim:SetBank("rocky")
	inst.DynamicShadow:SetSize(3, 3)
	anim:SetBuild("buling_rocky")
	anim:PlayAnimation("idle_loop", true)
	inst.Transform:SetScale(3, 3, 3)
	inst:AddTag("buling_carrier")
	inst:AddTag("atk")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("lootdropper")
	inst:AddComponent("locomotor")
    inst.components.locomotor:SetSlowMultiplier( 0.6 )
    inst.components.locomotor.walkspeed = 5
    inst.components.locomotor.runspeed =  5
    inst:AddComponent("combat")
    inst.components.combat:SetAttackPeriod(3)
    inst.components.combat:SetRange(4)
    inst.components.combat:SetDefaultDamage(100)
	inst.components.combat.canbeattackedfn = function (inst,attacker)
		local can_be_attacked = true
		if attacker == (doer or inst) then
			can_be_attacked = false
		end
		return can_be_attacked
	end
	inst.Transform:SetScale(3, 3, 3)
	inst.components.combat:SetAreaDamage(6, 0.8)
	inst.bulingdrop = drop
	inst.LaunchProjectile = LaunchProjectile
	inst:AddTag("buling_carrier")
	inst:AddTag("atk")
	inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst:AddComponent("health")
	inst.components.health:SetMaxHealth(10000)
	inst.components.health:SetCurrentHealth(10000)
	inst.components.health.indestructible = true
	inst:AddComponent("inventory")
    inst.components.inventory.dropondeath = false
	inst:SetStateGraph("SGbuling_rocky")
	deathset(inst)
	inst:AddComponent("inspectable")
	inst:AddComponent("drivable")
	inst.components.drivable.sanitydrain = TUNING.ROWBOAT_SANITY_DRAIN
	inst.components.drivable.runspeed = 10
	inst.components.drivable.OnMounted = function(self,doer)
		upcar(doer,inst)
		local _target = doer or inst
		if _target and _target.PushEvent then _target:PushEvent("buling_drive_rocky") end
		if doer and doer.components and doer.components.inventory then
			local staff = SpawnPrefab("buling_rocky_staff")
			if staff and staff.components and staff.components.weapon and inst.components.combat then
				staff.components.weapon:SetDamage(inst.components.combat.defaultdamage or 100)
			end
			doer.components.inventory:Equip(staff)
		end
	end
	applyupgrades(inst)
	inst.displaynamefn = get_name
	inst:ListenForEvent("onhitother",function() SpawnPrefab("groundpound_fx").Transform:SetPosition(inst.Transform:GetWorldPosition()) end)
	inst.OnSave = onsave
	inst.OnPreLoad = onpreload
	return inst
end
local function dcfn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	inst.entity:AddDynamicShadow()
	inst.Transform:SetFourFaced(inst)
	MakeCharacterPhysics(inst, 1, .5)
	inst.DynamicShadow:SetSize(3, 3 )
	anim:SetBank("deerclops")
	anim:SetBuild("deerclops_build")
	anim:OverrideSymbol("deerclops_body", "buling_deerclops", "deerclops_body")
	anim:OverrideSymbol("beefalo_furpatch", "nil", "deerclops_body")
	anim:OverrideSymbol("deerclops_head", "nil", "deerclops_body")
	inst.Transform:SetScale(1.7, 1.7, 1.7)
	inst:AddTag("buling_carrier")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("lootdropper")
	inst:AddComponent("locomotor")
    inst.components.locomotor:SetSlowMultiplier( 0.6 )
    inst.components.locomotor.walkspeed = 5
    inst.components.locomotor.runspeed =  5
    inst:AddComponent("combat")
    inst.components.combat:SetAttackPeriod(3)
    inst.components.combat:SetRange(4)
    inst.components.combat:SetDefaultDamage(100)
	inst.Transform:SetScale(1.7, 1.7, 1.7)
	inst.components.combat:SetAreaDamage(6, 0.8)
	inst.bulingdrop = drop
	inst.LaunchProjectile = LaunchProjectile
	inst.components.combat.canbeattackedfn = function (inst,attacker)
		local can_be_attacked = true
		if attacker == (doer or inst) then
			can_be_attacked = false
		end
		return can_be_attacked
	end
	inst:AddTag("buling_carrier")
    inst:AddComponent("health")
	inst.components.health:SetMaxHealth(10000)
	inst.components.health:SetCurrentHealth(10000)
	inst.components.health.indestructible = true
	inst:AddComponent("inventory")
    inst.components.inventory.dropondeath = false
	inst:SetStateGraph("SGbuling_deerclops")
	deathset(inst)
	inst:AddComponent("inspectable")
	inst:AddComponent("drivable")
	inst.components.drivable.sanitydrain = TUNING.ROWBOAT_SANITY_DRAIN
	inst.components.drivable.runspeed = 10
	inst.components.drivable.OnMounted = function(self,doer)
		upcar(doer,inst)
		--(doer or inst):PushEvent("buling_drive_rocky")
		--(doer or inst).components.inventory:Equip(SpawnPrefab("buling_rocky_staff"))
	end
	return inst
end

DoTransform = function(inst, doer)
	if inst == nil or not inst:IsValid() or inst._transforming or inst.prefab ~= "buling_car_log" then
		return
	end
	inst._transforming = true
	print("[BULING CARRIER] OnClose triggered on vehicle inst:", inst, "by doer:", doer)
	local container = inst.components.container
	if container == nil then
		print("[BULING CARRIER] Container component is nil!")
		return
	end

	local peifang = ""
	for i = 1, container:GetNumSlots() do
		local item = container:GetItemInSlot(i)
		if item == nil then
			item = "nil"
		else
			item = item.prefab
		end
		peifang = peifang..item..","
	end

	print("[BULING CARRIER] Current peifang string:", peifang)

	local is_free = BULING_FREE_CRAFT 
		or (doer and doer.components and doer.components.builder and (doer.components.builder.freebuildmode or (doer.components.builder.IsFreeBuildMode and doer.components.builder:IsFreeBuildMode())))

	local hechengbiao = {
		["buling_plane"]={
			"gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,gears,",
		},
		["buling_rocky"]={
			"buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,buling_glass,buling_glass,buling_glass,buling_puleidi,buling_puleidi,buling_glass,gears,buling_glass,buling_puleidi,buling_puleidi,buling_glass,buling_glass,buling_glass,buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,",
			"buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,moonglass,moonglass,moonglass,buling_puleidi,buling_puleidi,moonglass,gears,moonglass,buling_puleidi,buling_puleidi,moonglass,moonglass,moonglass,buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,",
		}, 
		["buling_glomling"]={
			"buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,",
			"moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,",
		}, 
		["buling_deerclops"]={
			"deerclops_eyeball,deerclops_eyeball,deerclops_eyeball,deerclops_eyeball,deerclops_eyeball,deerclops_eyeball,deerclops_eyeball,deerclops_eyeball,deerclops_eyeball,",
			"deerclops_eyeball,deerclops_eyeball,deerclops_eyeball,deerclops_eyeball,deerclops_eyeball,deerclops_eyeball,deerclops_eyeball,deerclops_eyeball,deerclops_eyeball,deerclops_eyeball,deerclops_eyeball,deerclops_eyeball,deerclops_eyeball,deerclops_eyeball,deerclops_eyeball,deerclops_eyeball,deerclops_eyeball,deerclops_eyeball,deerclops_eyeball,deerclops_eyeball,deerclops_eyeball,deerclops_eyeball,deerclops_eyeball,deerclops_eyeball,deerclops_eyeball,",
		},
	}

	local matched_target = nil
	for k,recipes in pairs(hechengbiao) do
		for _, rec_str in ipairs(recipes) do
			if rec_str == peifang then
				matched_target = k
				print("[BULING CARRIER] String matched recipe for:", k)
				break
			end
		end
		if matched_target then break end
	end

	if matched_target == nil then
		print("[BULING CARRIER] No exact 5x5 recipe grid match found for container contents.")
		return
	end

	if inst._transforming then
		return
	end

	if matched_target then
		inst._transforming = true
		print("[BULING CARRIER] Executing transformation to:", matched_target)
		if inst.bulingdrop then
			inst.bulingdrop(inst, doer or inst)
		end

		container.canbeopened = false
		if container.RemoveAllItems then
			local items = container:RemoveAllItems()
			for _, item in ipairs(items) do
				if item and item:IsValid() then
					item:Remove()
				end
			end
		end
		for i = 1, container:GetNumSlots() do
			if container.slots and container.slots[i] then
				local item = container.slots[i]
				container.slots[i] = nil
				if item and item:IsValid() then
					item:Remove()
				end
			end
		end

		local x, y, z = inst.Transform:GetWorldPosition()
		local driver = doer or (inst.components.drivable and inst.components.drivable.driver)
		if driver and driver.components and driver.components.driver then
			driver.components.driver:OnDismount(true)
		end
		local spawned = SpawnPrefab(matched_target)
		if spawned then
			spawned.Transform:SetPosition(x, y, z)
			print("[BULING CARRIER] Successfully spawned:", matched_target, "at:", x, y, z)
			local smoke = SpawnPrefab("maxwell_smoke")
			if smoke then
				smoke.Transform:SetPosition(x, y, z)
			end
			if driver and driver:IsValid() and spawned.components and spawned.components.drivable then
				spawned.components.drivable:OnMounted(driver)
			end
		end
		inst:Remove()
	else
		print("[BULING CARRIER] No recipe match found for peifang string")
	end
end
OnClose = function(inst, doer)
	if inst and inst.SoundEmitter then
		inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")
	end
end
carfn_onclose = OnClose

local function planefn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local sound = inst.entity:AddSoundEmitter()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	inst.entity:AddDynamicShadow()
	inst.entity:AddPhysics()
	anim:SetBloomEffectHandle("shaders/anim.ksh")
	inst.Transform:SetFourFaced()
	ChangeToFlyingCharacterPhysics(inst, 1, .5)
	inst.DynamicShadow:SetSize(2.2, 1.2)

	anim:SetBank("buling_plane")
	anim:SetBuild("buling_plane")
	anim:PlayAnimation("idle", true)
	inst.Transform:SetScale(3.2, 3.2, 3.2)
	inst:AddTag("buling_carrier")
	inst:AddTag("flying")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:SetStateGraph("SGbuling_car")
	inst:AddComponent("locomotor")
	inst.components.locomotor:SetSlowMultiplier(0.6)
	inst.components.locomotor.walkspeed = 14
	inst.components.locomotor.runspeed = 16
	if inst.components.locomotor.SetAllowFlyThrough then
		inst.components.locomotor:SetAllowFlyThrough(true)
	end
	inst.components.locomotor.pathcaps = { allowwater = true, hover = true, ignorecrate = true, ignorewalls = true }

	inst:AddComponent("inspectable")
	inst.Transform:SetScale(3.2, 3.2, 3.2)

	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(10000)
	inst.components.health:SetCurrentHealth(10000)
	inst.components.health.indestructible = true

	inst:AddComponent("combat")
	inst.components.combat:SetDefaultDamage(80)

	inst:AddComponent("container")
	inst.components.container:WidgetSetup("buling_chest_5x5")
	-- inst.components.container.onclosefn = nil
	inst.components.container.onopenfn = function(inst, doer)
		inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
	end

	inst.bulingdrop = drop
	inst.LaunchProjectile = LaunchProjectile
	inst:AddTag("buling_carrier")
	inst:AddTag("boat")
	inst:AddTag("flying")

	inst.components.combat.canbeattackedfn = function(inst, attacker)
		if not TheWorld.ismastersim then
			SendBulingRPC("do_widget_button2", inst.GUID)
			return
		end
		local can_be_attacked = true
		if attacker == (doer or inst) then
			can_be_attacked = false
		end
		return can_be_attacked
	end

	inst.SoundEmitter:PlaySound("dontstarve/ghost/ghost_howl_LP", "howl")

	inst:AddComponent("drivable")
	inst.components.drivable.sanitydrain = 0
	inst.components.drivable.runspeed = 14
	inst.components.drivable.OnMounted = function(self, doer)
		upcar(doer, inst)
	end

	return inst
end

return Prefab("buling_glomling", fn, assets),
    Prefab("buling_plane", planefn, assets),
    Prefab("buling_rocky", gdfn, assets),
    Prefab("buling_car_log", carfn, assets),
    Prefab("buling_deerclops", dcfn, assets)
