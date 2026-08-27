require "stategraphs/SGbuling_glomling"
require "stategraphs/SGbuling_car"
local assets=
{
	Asset("ANIM", "anim/buling_glomling.zip"),
	Asset("ANIM", "anim/ui_buling_chest_5x5.zip"),
	Asset("ANIM", "anim/buling_car.zip"),
}

local function LaunchProjectile(inst, doer, targetpos)
	local x, y, z = inst.Transform:GetWorldPosition()
	targetpos = targetpos or Vector3(x + 10, 0, z)
	for i = -1, 1 do
		local projectile = SpawnPrefab("ancient_hulk_mine")
		if projectile then
			projectile.primed = false
			projectile.AnimState:PlayAnimation("spin_loop", true)
			projectile.Transform:SetPosition(x, 1.5, z)
			local spread_pos = Vector3(targetpos.x + i * 2, 0, targetpos.z + (i % 2) * 2)
			if projectile.components.complexprojectile then
				projectile.components.complexprojectile:SetHorizontalSpeed(22)
				projectile.components.complexprojectile:SetGravity(-25)
				projectile.components.complexprojectile:Launch(spread_pos, inst, inst)
			end
			projectile.owner = inst
		end
	end
end

local function upcar(doer,inst)
	doer:DoTaskInTime(0.1,function()
		inst:DoPeriodicTask(0.1,function()
			if (doer or inst).components.combat.target ~= nil then
				inst.target = (doer or inst).components.combat.target
			end
		end)
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
			inst:DoPeriodicTask(0.02, function()
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
				end
			end
			if inst.components.locomotor then inst.components.locomotor:Stop() end
			if inst.Physics then inst.Physics:Stop() end
		end
	end)
end
local function drop(inst, doer, viewer)
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
	viewer.Physics:SetActive(true)
	local staff = viewer.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
	if staff and staff.prefab == "buling_rocky_staff" then
		staff:Remove()
	end
	viewer:DoTaskInTime(1,function()
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
	inst.entity:AddDynamicShadow()
    inst.entity:AddPhysics()
    inst.entity:AddAnimState():SetBloomEffectHandle( "shaders/anim.ksh" )
    inst.Transform:SetSixFaced(inst)
    --MakeCharacterPhysics(inst, 1, .5)
	MakeCharacterPhysics(inst, 10, .5)
    inst.DynamicShadow:SetSize( .8, .5 )
    inst.entity:AddAnimState():SetBank("buling_glomling")
    inst.entity:AddAnimState():SetBuild("buling_glomling")
    inst.entity:AddAnimState():PlayAnimation("idle_loop", true)
    inst:AddComponent("locomotor")
    inst.components.locomotor:SetSlowMultiplier( 0.6 )
    inst.components.locomotor.walkspeed = 4
    inst.components.locomotor.runspeed =  4
    inst:AddComponent("inspectable")
    inst.Transform:SetScale(3, 3, 3)
	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(100)
    inst:AddComponent("knownlocations")
    inst:AddComponent("combat")
	inst:SetStateGraph("SGbuling_glomling")
	inst.bulingdrop = drop
	inst.LaunchProjectile = LaunchProjectile
	inst:AddTag("buling_carrier")
	inst:AddTag("boat")
	inst.components.combat.canbeattackedfn = function(inst,attacker)
		if not TheWorld.ismastersim then
			SendModRPCToServer(MOD_RPC["bulingbuling"]["do_widget_button2"], inst.GUID)
			return
		end
		--print(attacker)
		--print("别打我")
		local can_be_attacked = true
		if attacker == (doer or inst) then
			can_be_attacked = false
		end
		return can_be_attacked
	end
    ------------------    
    inst.SoundEmitter:PlaySound("dontstarve/ghost/ghost_howl_LP", "howl")
	inst:AddComponent("inspectable")
	inst:AddComponent("drivable")
	inst.components.drivable.sanitydrain = TUNING.ROWBOAT_SANITY_DRAIN
	inst.components.drivable.runspeed = 10
	inst.components.drivable.OnMounted = function(self,doer)
		upcar(doer,inst)
	end
    return inst
end
local function carfn()
	local hechengbiao = {
		["buling_rocky"]={
			"buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,buling_glass,buling_glass,buling_glass,buling_puleidi,buling_puleidi,buling_glass,gears,buling_glass,buling_puleidi,buling_puleidi,buling_glass,buling_glass,buling_glass,buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,",
			"buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,moonglass,moonglass,moonglass,buling_puleidi,buling_puleidi,moonglass,gears,moonglass,buling_puleidi,buling_puleidi,moonglass,moonglass,moonglass,buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,buling_puleidi,",
		}, 
		["buling_glomling"]={
			"buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,buling_glass,",
			"moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,moonglass,",
		}, 
	}
	local function OnClose(inst, doer)
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

		-- Smart Count Fallback matching for Mechanical Stone Lobster (buling_rocky)
		if matched_target == nil then
			local has_puleidi = container:Has("buling_puleidi", 16) or container:Has("buling_puleidi_plank", 16)
			local has_glass = container:Has("buling_glass", 8) or container:Has("moonglass", 8)
			local has_gears = container:Has("gears", 1)
			if has_puleidi and has_glass and has_gears then
				matched_target = "buling_rocky"
				print("[BULING CARRIER] Smart item count matched buling_rocky!")
			end
		end

		if matched_target == nil and is_free then
			matched_target = "buling_rocky"
			print("[BULING CARRIER] Free craft mode target fallback to buling_rocky")
		end

		if matched_target then
			print("[BULING CARRIER] Executing transformation to:", matched_target)
			if inst.bulingdrop then
				inst.bulingdrop(inst, doer or inst)
			end

			if not is_free then
				if matched_target == "buling_glomling" then
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
	inst.entity:AddDynamicShadow()
    inst.entity:AddPhysics()
    --inst.entity:AddAnimState():SetBloomEffectHandle( "shaders/anim.ksh" )
    inst.Transform:SetFourFaced(inst)
    MakeCharacterPhysics(inst, 1, .5)
    inst.DynamicShadow:SetSize( .8, .5 )
    inst.entity:AddAnimState():SetBank("buling_car")
    inst.entity:AddAnimState():SetBuild("buling_car")
    inst.entity:AddAnimState():PlayAnimation("idle", true)
    inst:AddComponent("locomotor")
    inst.components.locomotor:SetSlowMultiplier( 0.6 )
    inst.components.locomotor.walkspeed = 10
    inst.components.locomotor.runspeed =  10
    inst:AddComponent("inspectable")
	--inst.Transform:SetScale(3, 3, 3)
	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(100)
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
		text = "Evolve / Улучшить",
		position = Vector3(0, -220, 0),
		fn = function(inst, doer)
			if not TheWorld.ismastersim then
				SendModRPCToServer(MOD_RPC["bulingbuling"]["do_widget_button"], inst.GUID)
				return
			end
			OnClose(inst, doer)
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
	inst.hp_level = 0
	inst.atk_level = 0
	inst.entity:AddDynamicShadow()
	inst.Transform:SetFourFaced(inst)
	MakeCharacterPhysics(inst, 1, .5)
	anim:SetBank("rocky")
	inst.DynamicShadow:SetSize(3, 3 )
	anim:SetBuild("buling_rocky")
	anim:PlayAnimation("idle_loop", true)
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
    inst.components.health:SetMaxHealth(2000)
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
	inst.entity:AddDynamicShadow()
	inst.Transform:SetFourFaced(inst)
	MakeCharacterPhysics(inst, 1, .5)
	inst.DynamicShadow:SetSize(3, 3 )
	anim:SetBank("deerclops")
	anim:SetBuild("deerclops_build")
	inst.AnimState:OverrideSymbol("deerclops_body", "buling_deerclops", "deerclops_body")
	inst.AnimState:OverrideSymbol("beefalo_furpatch", "nil", "deerclops_body")
	inst.AnimState:OverrideSymbol("deerclops_head", "nil", "deerclops_body")
	--anim:PlayAnimation("idle_loop", true)
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
    inst.components.health:SetMaxHealth(2000)
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
return Prefab("buling_glomling", fn, assets),
    Prefab("buling_rocky", gdfn, assets),
    Prefab("buling_car_log", carfn, assets),
    Prefab("buling_deerclops", dcfn, assets)
