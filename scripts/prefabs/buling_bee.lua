local GLOBAL = _G
local assets = {
	Asset("ANIM", "anim/bee.zip"),
	Asset("ANIM", "anim/bee_box.zip"),
	Asset("ANIM", "anim/ui_buling_chest_5x5.zip"),
}

local function CountBeesInContainer(container, prefab_name)
	local total = 0
	if container and container.slots then
		for k, v in pairs(container.slots) do
			if v and v.prefab == prefab_name then
				local sz = (v.components.stackable and v.components.stackable:StackSize()) or 1
				total = total + sz
			end
		end
	end
	return total
end

local function weighted_random_choice(choices)
	local total = 0
	for k, v in pairs(choices) do
		total = total + v
	end
	local r = math.random() * total
	for k, v in pairs(choices) do
		r = r - v
		if r <= 0 then
			return k
		end
	end
	for k, v in pairs(choices) do
		return k
	end
end

local function commonfn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	inst:AddTag("bulingbug")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("inspectable")
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
	inst:AddComponent("inventoryitem")
	inst:AddComponent("tradable")

	inst.tasknum = 0
	inst.OnSave = function(inst, data)
		data = data or {}
		data.tasknum = inst.tasknum
	end
	inst.OnLoad = function(inst, data)
		if data then
			inst.tasknum = data.tasknum or 0
		end
	end
	return inst
end

local function create_working_bee(build_name, image_name, item_list, req_tasks)
	req_tasks = req_tasks or 5
	local inst = commonfn()
	inst.AnimState:SetBank("buling_bee")
	inst.AnimState:SetBuild(build_name)
	inst.AnimState:PlayAnimation("land_idle", true)

	if TheWorld.ismastersim then
		inst.components.inventoryitem.imagename = "bee"
		inst.components.inventoryitem.atlasname = "images/inventoryimages.xml"
		inst.beeworkfn = function(inst, owner)
			owner = owner or (inst.components.inventoryitem and inst.components.inventoryitem.owner)
			if owner and (owner.prefab == "buling_bee_box" or owner:HasTag("buling_bee_box")) then
				local stacksize = (inst.components.stackable and inst.components.stackable:StackSize()) or 1
				inst.tasknum = inst.tasknum + stacksize
				if inst.tasknum >= req_tasks then
					if owner.components.container and not owner.components.container:IsFull() then
						inst.tasknum = 0
						for i = 1, math.min(stacksize, 5) do
							local prize = weighted_random_choice(item_list)
							if prize then
								local spawned = SpawnPrefab(prize)
								if spawned then
									owner.components.container:GiveItem(spawned)
								end
							end
						end
					end
				end
			end
		end
	end
	return inst
end

local function buling_cai(inst)
	return create_working_bee("buling_bee_cai", "buling_bee_cai", {
		cutgrass = 5,
		twigs = 5,
		berries = 3,
		carrot = 2,
	}, 10)
end

local function buling_pirate(inst)
	return create_working_bee("buling_bee_pirate", "buling_bee_pirate", {
		goldnugget = 5,
		dubloon = 3,
		trinket_1 = 1,
	}, 10)
end

local function buling_gardener(inst)
	return create_working_bee("buling_bee_gardener", "buling_bee_gardener", {
		seeds = 5,
		carrot = 3,
		pumpkin = 2,
		corn = 2,
	}, 10)
end

local function buling_fish(inst)
	return create_working_bee("buling_bee_fish", "buling_bee_fish", {
		fish = 5,
		pondfish = 3,
		eel = 2,
	}, 10)
end

local function buling_police(inst)
	return create_working_bee("buling_bee_police", "buling_bee_police", {
		honey = 5,
		stinger = 3,
		beehat = 1,
	}, 10)
end

local function buling_smith(inst)
	return create_working_bee("buling_bee_smith", "buling_bee_smith", {
		rocks = 4,
		flint = 4,
		honey = 10,
		goldnugget = 2,
	}, 10)
end

local function buling_mine(inst)
	return create_working_bee("buling_bee_mine", "buling_bee_mine", {
		rocks = 4,
		flint = 4,
		nitre = 3,
		marble = 1,
	}, 10)
end

local function buling_queen(inst)
	local inst = commonfn()
	inst.AnimState:SetBank("buling_bee")
	inst.AnimState:SetBuild("buling_bee_queen")
	inst.AnimState:PlayAnimation("land_idle", true)

	if TheWorld.ismastersim then
		inst.components.inventoryitem.imagename = "bee"
		inst.components.inventoryitem.atlasname = "images/inventoryimages.xml"
		inst.beeworkfn = function(inst, owner)
			owner = owner or (inst.components.inventoryitem and inst.components.inventoryitem.owner)
			if owner and (owner.prefab == "buling_bee_box" or owner:HasTag("buling_bee_box")) and owner.components.container and not owner.components.container:IsFull() then
				inst.tasknum = (inst.tasknum or 0) + 1
				if inst.tasknum >= 150 then
					inst.tasknum = 0
					for k, v in pairs(owner.components.container.slots) do
						if v and (v:HasTag("bulingbug") or v.prefab == "bee") and v ~= inst then
							local cur_count = CountBeesInContainer(owner.components.container, v.prefab)
							if cur_count < 5 then
								local new_bee = SpawnPrefab(v.prefab)
								if new_bee then
									owner.components.container:GiveItem(new_bee)
								end
								return
							end
						end
					end
				end
			end
		end
	end
	return inst
end

local function buling_stonecutters(inst)
	return create_working_bee("buling_bee_stonecutters", "buling_bee_stonecutters", {
		cutstone = 4,
		rocks = 5,
		marble = 2,
	}, 10)
end

local function buling_governor(inst)
	return create_working_bee("buling_bee_governor", "buling_bee_governor", {
		goldnugget = 5,
		honey = 5,
		purplegem = 1,
	}, 10)
end

-- ==================== BEE BOX STRUCTURE ====================

local function bee_box_onopen(inst)
	inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
end

local function bee_box_onclose(inst)
	inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")
end

local function buling_bee_box_fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	inst.Transform:SetFourFaced()
	MakeObstaclePhysics(inst, 0.5)

	inst.AnimState:SetBank("bee_box")
	inst.AnimState:SetBuild("bee_box")
	inst.AnimState:PlayAnimation("idle", true)

	inst:AddTag("structure")
	inst:AddTag("buling_bee_box")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("inspectable")
	inst:AddComponent("lootdropper")

	local slotpos = {}
	for y = 2, -2, -1 do
		for x = -2, 2 do
			table.insert(slotpos, Vector3(80 * x, 80 * y, 0))
		end
	end

	inst:AddComponent("container")
	inst.components.container:SetNumSlots(#slotpos)
	inst.components.container.widgetslotpos = slotpos
	inst.components.container.widgetpos = Vector3(0, 200, 0)
	inst.components.container.side_align_tip = 100
	inst.components.container.widgetanimbank = "ui_chest_3x3"
	inst.components.container.widgetanimbuild = "ui_buling_chest_5x5"
	inst.components.container.widget = {
		slotpos = slotpos,
		animbank = "ui_chest_3x3",
		animbuild = "ui_buling_chest_5x5",
		pos = Vector3(0, 200, 0),
		side_align_tip = 100,
		type = "chest",
	}
	inst.components.container.itemtestfn = function(container, item, slot)
		if item and (item:HasTag("bulingbug") or item.prefab == "bee" or item.prefab == "killerbee") then
			local count = CountBeesInContainer(container, item.prefab)
			local item_sz = (item.components.stackable and item.components.stackable:StackSize()) or 1
			if count + item_sz > 5 then
				return false
			end
		end
		return true
	end

	inst.components.container.onopenfn = bee_box_onopen
	inst.components.container.onclosefn = bee_box_onclose

	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(4)
	inst.components.workable:SetOnFinishCallback(function(inst, worker)
		inst.components.lootdropper:DropLoot()
		if inst.components.container then
			inst.components.container:DropEverything()
		end
		inst:Remove()
	end)

	inst:DoPeriodicTask(2, function(inst)
		if inst.components.container then
			-- Enforce max 5 bees of any single type
			local bee_counts = {}
			for k, item in pairs(inst.components.container.slots) do
				if item and item:IsValid() and (item:HasTag("bulingbug") or item.prefab == "bee" or item.prefab == "killerbee") then
					local p_name = item.prefab
					local sz = (item.components.stackable and item.components.stackable:StackSize()) or 1
					bee_counts[p_name] = (bee_counts[p_name] or 0) + sz
					if bee_counts[p_name] > 5 then
						local excess = bee_counts[p_name] - 5
						bee_counts[p_name] = 5
						if item.components.stackable and item.components.stackable:StackSize() > excess then
							local dropped = item.components.stackable:Get(excess)
							if dropped then
								inst.components.container:DropItem(dropped)
							end
						else
							inst.components.container:DropItem(item)
						end
					end
				end
			end

			-- Run bee work logic
			for k, item in pairs(inst.components.container.slots) do
				if item and item:IsValid() then
					if item.beeworkfn then
						item:beeworkfn(inst)
					elseif item.prefab == "bee" or item.prefab == "killerbee" then
						item.tasknum = (item.tasknum or 0) + 1
						if item.tasknum >= 5 then
							item.tasknum = 0
							if not inst.components.container:IsFull() then
								local honey = SpawnPrefab("honey")
								if honey then
									inst.components.container:GiveItem(honey)
								end
							end
						end
					end
				end
			end
		end
	end)

	return inst
end

local function buling_bee_box_item_fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)

	inst.AnimState:SetBank("bee_box")
	inst.AnimState:SetBuild("bee_box")
	inst.AnimState:PlayAnimation("idle")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("inspectable")
	inst:AddComponent("inventoryitem")

	inst:AddComponent("deployable")
	inst.components.deployable.ondeploy = function(inst, pt, deployer)
		local box = SpawnPrefab("buling_bee_box")
		if box then
			box.Transform:SetPosition(pt.x, pt.y, pt.z)
			box.SoundEmitter:PlaySound("dontstarve/common/craftable/bee_box")
			inst:Remove()
		end
	end

	return inst
end

local placer = MakePlacer("buling_bee_box_placer", "bee_box", "bee_box", "idle")

return Prefab("buling_bee_mine", buling_mine, assets),
	Prefab("buling_bee_police", buling_police, assets),
	Prefab("buling_bee_pirate", buling_pirate, assets),
	Prefab("buling_bee_queen", buling_queen, assets),
	Prefab("buling_bee_governor", buling_governor, assets),
	Prefab("buling_bee_stonecutters", buling_stonecutters, assets),
	Prefab("buling_bee_gardener", buling_gardener, assets),
	Prefab("buling_bee_cai", buling_cai, assets),
	Prefab("buling_bee_fish", buling_fish, assets),
	Prefab("buling_bee_smith", buling_smith, assets),
	Prefab("buling_bee_box", buling_bee_box_fn, assets),
	Prefab("buling_bee_box_item", buling_bee_box_item_fn, assets),
	placer