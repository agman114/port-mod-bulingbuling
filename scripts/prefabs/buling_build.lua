local assets = {
	Asset("ANIM", "anim/cave_entrance.zip"),
}
local function onsave(inst, data)
	data = data or {}
    if inst:HasTag("spawned_cave") then
        data.spawned_cave = true
    end
end

local function onload(inst, data)
    if data and data.spawned_cave then
        inst:AddTag("spawned_cave")
    end
end
local function getlocationoutofcenter(dist,hole,random,invert)
    local pos =  (math.random()*((dist/2) - (hole/2))) + hole/2    
    if invert or (random and math.random()<0.5) then
        pos = pos *-1
    end
    return pos
end
local function creatInterior(inst, doer)    
    if not inst:HasTag("spawned_cave") then
        local interior_spawner = TheWorld and TheWorld.components and TheWorld.components.interiorspawner
        if not interior_spawner then return end

        local name = "buling_cave_entrance".. interior_spawner:GetNewID()
        local height = 18
        local width = 26

        local coreID = interior_spawner:GetNewID()

        local core_door_def = {
            my_door_id = name..coreID.."_door",
            target_door_id = name..coreID.."_exit",
            target_interior = coreID,
        }
		local addprops = {}
        interior_spawner:AddDoor(inst, core_door_def)

        local    floortexture = "levels/textures/interiors/batcave_floor.tex"
        local    walltexture =  "levels/textures/interiors/batcave_wall_rock.tex"
        local    minimaptexture = "levels/textures/map_interior/mini_vamp_cave_noise.tex"
		local SHOPSOUND_EXIT = "dontstarve_DLC003/common/objects/store/door_close"
        addprops = {
                    { name = "prop_door", x_offset = -height/2, z_offset = 0, animdata = {bank ="exitrope", build ="cave_exit_rope", anim="idle_loop", background=true}, 
                        my_door_id = core_door_def.target_door_id, target_door_id = core_door_def.my_door_id, addtags={"guard_entrance"}, usesounds={SHOPSOUND_EXIT} },


                   --[[ { name = "deco_accademy_beam",          x_offset = -5,  z_offset = width/2, flip=true },
                    { name = "deco_accademy_beam",          x_offset = -5,  z_offset = -width/2 },
                    { name = "deco_accademy_cornerbeam",    x_offset = 4.7, z_offset = width/2, flip=true },
                    { name = "deco_accademy_cornerbeam",    x_offset = 4.7, z_offset = -width/2 },]]

                    { name = "firepit",          x_offset = -3,  z_offset =  -0 },                    
    
				}                         
                

        interior_spawner:CreateRoom("generic_interior", width, 10, height, name, coreID, addprops, {}, walltexture, floortexture, minimaptexture, nil, nil, true, nil, "batcave","BAT_CAVE","DIRT", nil, nil, true)        
        inst:AddTag("spawned_cave")
    end        
end
local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, .5)

	inst.AnimState:SetBank("cave_entrance")
	inst.AnimState:SetBuild("cave_entrance")
	inst.AnimState:PlayAnimation("idle_open", true)

    inst:AddTag("structure")
    inst:AddTag("shelter")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    -------------------

    if TheWorld and TheWorld.components and TheWorld.components.interiorspawner then
        inst:AddComponent("door")
        inst.components.door.outside = true

        inst.task = inst:DoTaskInTime(0, function() 
             creatInterior(inst)
        end)
    else
        -- DST Bunker & Shelter mode
        inst:AddComponent("sleepingbag")
        inst.components.sleepingbag.health_tick = TUNING.SLEEP_HEALTH_PER_TICK * 2
        inst.components.sleepingbag.sanity_tick = TUNING.SLEEP_SANITY_PER_TICK * 2

        inst:AddComponent("container")
        inst.components.container:WidgetSetup("treasurechest")

        inst:AddComponent("lootdropper")
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
    end

    inst.OnSave = onsave 
    inst.OnLoad = onload

    ---------------------
    inst:AddComponent("inspectable")
	MakeSnowCovered(inst)
    
	return inst
end
local function creatInterior_ship(inst, doer)    
    if not inst:HasTag("spawned_home") then
        local interior_spawner = TheWorld and TheWorld.components and TheWorld.components.interiorspawner
        if not interior_spawner then return end

        local name = "buling_airship_entrance"
        local height = nil
        local width = 15

        local coreID = interior_spawner:GetNewID()--传送室
        local bridgeID = interior_spawner:GetNewID()--主控室
        local saveID = interior_spawner:GetNewID()--存储区
        local liveID = interior_spawner:GetNewID()--维生区
        local fireID = interior_spawner:GetNewID()--火力室
        local powerID = interior_spawner:GetNewID()--动力室
        local industryID = interior_spawner:GetNewID()--工业区

        local core_door_def = {--传送室
            my_door_id = name..coreID,
            target_door_id = name..coreID.."_exit",
            target_interior = coreID,
        }
		local bridge_door_def =--主控室
        {
            my_door_id = name..bridgeID,
            target_door_id = "buling_airship_NORTH",
            target_interior = bridgeID,
        }
		local save_door_def =--存储区
        {
            my_door_id = name..saveID,
            target_door_id = "buling_airship_EAST",
			target_door_id2 = "buling_airship_"..saveID,
            target_interior = saveID,
			 
        }
		local live_door_def =--维生区
        {
            my_door_id = name..liveID,
            target_door_id = "buling_airship_WEST",
			target_door_id2 = "buling_airship_"..liveID,
            target_interior = liveID,    
        }
		local fire_door_def =--火力室
        {
            my_door_id = name..fireID,
            target_door_id = "buling_airship_SOUTH",
            target_interior = fireID,
        }
		local power_door_def =--动力室
        {
            my_door_id = name..powerID,
            target_door_id = "buling_airship_"..powerID,
            target_door_id2 = "buling_airship2_"..powerID,
            target_interior = powerID,
        }
		local industry_door_def =--工业区
        {
            my_door_id = name..industryID,
            target_door_id = "buling_airship_"..industryID,
            target_door_id2 = "buling_airship2_"..industryID,
            target_interior = industryID,
        }
		local addprops = {}
        interior_spawner:AddDoor(inst, core_door_def)

        local    floortexture = resolvefilepath("levels/textures/buling_airship_floor2.tex")
        --local    floortexture = "levels/textures/interiors/floor_cityhall.tex"
        local    walltexture =  resolvefilepath("levels/textures/interiors/buling_air_wall2.tex")
		--local    walltexture =  resolvefilepath("levels/textures/interiors/buling_airship_wall.tex")
        local    minimaptexture = "levels/textures/map_interior/mini_vamp_cave_noise.tex"
		local SHOPSOUND_EXIT = "dontstarve_DLC003/common/objects/store/door_close"
		--创造传送室
        addprops = {
                    { name = "prop_door", x_offset = 0, z_offset = 0, animdata = {bank ="exitrope", build ="cave_exit_rope", anim="nil", background=true}, 
                        my_door_id = core_door_def.target_door_id, target_door_id = core_door_def.my_door_id, addtags={"guard_entrance"}, usesounds={SHOPSOUND_EXIT} },
					--链接主控室
					{ name = "prop_door", x_offset = -5, z_offset = 0, animdata = {bank = "player_house_doors", build = "player_house_doors", anim = "plate_door_close_north", background = true }, 
						my_door_id = bridge_door_def.my_door_id, target_door_id = bridge_door_def.target_door_id, target_interior = bridge_door_def.target_interior, rotation = -90, flip = true, addtags = {"lockable_door","door_north"} },
					--链接存储区
					{ name = "prop_door", x_offset = 0, z_offset = 7.5, animdata = {bank = "player_house_doors", build = "player_house_doors", anim = "plate_door_close_west", background = true }, 
						my_door_id = save_door_def.my_door_id, target_door_id = save_door_def.target_door_id, target_interior = save_door_def.target_interior, rotation = -90, flip = true, addtags = {"lockable_door","door_east"} },
					--链接维生舱
					{ name = "prop_door", x_offset = 0, z_offset = -7.5, animdata = {bank = "player_house_doors", build = "player_house_doors", anim = "plate_door_close_west", background = true }, 
						my_door_id = live_door_def.my_door_id, target_door_id = live_door_def.target_door_id, target_interior = live_door_def.target_interior, rotation = -90, flip = false, addtags = {"lockable_door","door_west"} },
					--链接火力区
					{ name = "prop_door", x_offset = 5, z_offset = 0, animdata = {bank = "player_house_doors", build = "player_house_doors", anim = "plate_door_close_south", background = true }, 
						my_door_id = fire_door_def.my_door_id, target_door_id = fire_door_def.target_door_id, target_interior = fire_door_def.target_interior, rotation = -90, flip = false, addtags = {"lockable_door","door_south"} },
					
					{ name = "buling_accademy_beam",          x_offset = -5,  z_offset = width/2, flip=true },
                    { name = "buling_accademy_beam",          x_offset = -5,  z_offset = -width/2 },
                    { name = "buling_accademy_beam2",    x_offset = 4.7, z_offset = width/2, flip=true },
                    { name = "buling_accademy_beam2",    x_offset = 4.7, z_offset = -width/2 },

                    { name = "buling_light_fx",          x_offset = 0,  z_offset =  0 },                    
    
				}             
		local cityID = nil
        if inst.components.citypossession then
            cityID = inst.components.citypossession.cityID
        end
        interior_spawner:CreateRoom("generic_interior", 15, nil, 10, name, coreID, addprops, {}, walltexture, floortexture, minimaptexture, cityID, nil, true, nil, "batcave","BAT_CAVE","DIRT", nil, nil, true)  	
		--创造主控室
		addprops = {
					{ name = "prop_door", x_offset = 5, z_offset = 0, animdata = {bank = "player_house_doors", build = "player_house_doors", anim = "plate_door_close_south", background = true }, 
						my_door_id = bridge_door_def.target_door_id, target_door_id = bridge_door_def.my_door_id, target_interior = core_door_def.target_interior, rotation = -90, flip = true, addtags = {"lockable_door","door_south"} },
                    { name = "buling_airship_window",          x_offset = -5,  z_offset =  0},       
					{ name = "buling_light_fx",          x_offset = 0,  z_offset =  0 },     
					{ name = "buling_accademy_beam",          x_offset = -5,  z_offset = width/2, flip=true },
                    { name = "buling_accademy_beam",          x_offset = -5,  z_offset = -width/2 },
                    { name = "buling_accademy_beam2",    x_offset = 4.7, z_offset = width/2, flip=true },
                    { name = "buling_accademy_beam2",    x_offset = 4.7, z_offset = -width/2 },
    
				}                         
        interior_spawner:CreateRoom("generic_interior", width, nil, 10, name, bridgeID, addprops, {}, walltexture, floortexture, minimaptexture, nil, nil, true, nil, "batcave","BAT_CAVE","DIRT", nil, nil, true)
        --创造维生舱
		addprops = {
					{ name = "prop_door", x_offset = 0, z_offset = 7.5, animdata = {bank = "player_house_doors", build = "player_house_doors", anim = "plate_door_close_west", background = true }, 
						my_door_id = live_door_def.target_door_id, target_door_id = live_door_def.my_door_id, target_interior = core_door_def.target_interior, rotation = -90, flip = true, addtags = {"lockable_door","door_east"} },
                    { name = "prop_door", x_offset = 5, z_offset = 0, animdata = {bank = "player_house_doors", build = "player_house_doors", anim = "plate_door_close_south", background = true }, 
						my_door_id = live_door_def.target_door_id2, target_door_id = power_door_def.target_door_id2, target_interior = power_door_def.target_interior, rotation = -90, flip = true, addtags = {"lockable_door","door_south"} },
					{ name = "buling_light_fx",          x_offset = 0,  z_offset =  0 },       
                    { name = "livingtree",          x_offset = 0,  z_offset =  0 },       
					
					{ name = "buling_accademy_beam",          x_offset = -5,  z_offset = width/2, flip=true },
                    { name = "buling_accademy_beam",          x_offset = -5,  z_offset = -width/2 },
                    { name = "buling_accademy_beam2",    x_offset = 4.7, z_offset = width/2, flip=true },
                    { name = "buling_accademy_beam2",    x_offset = 4.7, z_offset = -width/2 },
    
				}                         
        interior_spawner:CreateRoom("generic_interior", width, nil, 10, name, liveID, addprops, {}, walltexture, floortexture, minimaptexture, nil, nil, true, nil, "batcave","BAT_CAVE","DIRT", nil, nil, true)
        --创造存储区
		addprops = {
					{ name = "prop_door", x_offset = 0, z_offset = -7.5, animdata = {bank = "player_house_doors", build = "player_house_doors", anim = "plate_door_close_west", background = true }, 
						my_door_id = save_door_def.target_door_id, target_door_id = save_door_def.my_door_id, target_interior = core_door_def.target_interior, rotation = -90, flip = false, addtags = {"lockable_door","door_west"} },
                    { name = "prop_door", x_offset = 5, z_offset = 0, animdata = {bank = "player_house_doors", build = "player_house_doors", anim = "plate_door_close_south", background = true }, 
						my_door_id = save_door_def.target_door_id2, target_door_id = industry_door_def.target_door_id2, target_interior = industry_door_def.target_interior, rotation = -90, flip = false, addtags = {"lockable_door","door_south"} },
					{ name = "buling_light_fx",          x_offset = 0,  z_offset =  0 },       
                    { name = "icebox",          x_offset = 0,  z_offset =  0 },       
					
					{ name = "buling_accademy_beam",          x_offset = -5,  z_offset = width/2, flip=true },
                    { name = "buling_accademy_beam",          x_offset = -5,  z_offset = -width/2 },
                    { name = "buling_accademy_beam2",    x_offset = 4.7, z_offset = width/2, flip=true },
                    { name = "buling_accademy_beam2",    x_offset = 4.7, z_offset = -width/2 },
    
				}                         
        interior_spawner:CreateRoom("generic_interior", width, nil, 10, name, saveID, addprops, {}, walltexture, floortexture, minimaptexture, nil, nil, true, nil, "batcave","BAT_CAVE","DIRT", nil, nil, true)
        --创造火力区
		addprops = {
					{ name = "prop_door", x_offset = -5, z_offset = 0, animdata = {bank = "player_house_doors", build = "player_house_doors", anim = "plate_door_close_north", background = true }, 
						my_door_id = fire_door_def.target_door_id, target_door_id = fire_door_def.my_door_id, target_interior = core_door_def.target_interior, rotation = -90, flip = true, addtags = {"lockable_door","door_north"} },
                    --动力
					{ name = "prop_door", x_offset = 0, z_offset = -7.5, animdata = {bank = "player_house_doors", build = "player_house_doors", anim = "plate_door_close_west", background = true }, 
						my_door_id = power_door_def.my_door_id, target_door_id = power_door_def.target_door_id, target_interior = power_door_def.target_interior, rotation = -90, flip = false, addtags = {"lockable_door","door_west"} },
                    --工业
					{ name = "prop_door", x_offset = 0, z_offset = 7.5, animdata = {bank = "player_house_doors", build = "player_house_doors", anim = "plate_door_close_west", background = true }, 
						my_door_id = industry_door_def.my_door_id, target_door_id = industry_door_def.target_door_id, target_interior = industry_door_def.target_interior, rotation = -90, flip = true, addtags = {"lockable_door","door_east"} },
                    
					{ name = "buling_light_fx",          x_offset = 0,  z_offset =  0 },       
                    { name = "pigtorch",          x_offset = 0,  z_offset =  0 },       
					
					{ name = "buling_accademy_beam",          x_offset = -5,  z_offset = width/2, flip=true },
                    { name = "buling_accademy_beam",          x_offset = -5,  z_offset = -width/2 },
                    { name = "buling_accademy_beam2",    x_offset = 4.7, z_offset = width/2, flip=true },
                    { name = "buling_accademy_beam2",    x_offset = 4.7, z_offset = -width/2 },
    
				}                         
        interior_spawner:CreateRoom("generic_interior", width, nil, 10, name, fireID, addprops, {}, walltexture, floortexture, minimaptexture, nil, nil, true, nil, "batcave","BAT_CAVE","DIRT", nil, nil, true)
        --创造动力室
		addprops = {
					{ name = "prop_door", x_offset = 0, z_offset = 7.5, animdata = {bank = "player_house_doors", build = "player_house_doors", anim = "plate_door_close_west", background = true }, 
						my_door_id = power_door_def.target_door_id, target_door_id = power_door_def.my_door_id, target_interior = fire_door_def.target_interior, rotation = -90, flip = true, addtags = {"lockable_door","door_east"} },
                    { name = "prop_door", x_offset = -5, z_offset = 0, animdata = {bank = "player_house_doors", build = "player_house_doors", anim = "plate_door_close_north", background = true }, 
						my_door_id = power_door_def.target_door_id2, target_door_id = live_door_def.target_door_id2, target_interior = live_door_def.target_interior, rotation = -90, flip = true, addtags = {"lockable_door","door_north"} },
                    { name = "buling_light_fx",          x_offset = 0,  z_offset =  0 },       
                    { name = "ruins_statue_mage",          x_offset = 0,  z_offset =  0 },       
					
					{ name = "buling_accademy_beam",          x_offset = -5,  z_offset = width/2, flip=true },
                    { name = "buling_accademy_beam",          x_offset = -5,  z_offset = -width/2 },
                    { name = "buling_accademy_beam2",    x_offset = 4.7, z_offset = width/2, flip=true },
                    { name = "buling_accademy_beam2",    x_offset = 4.7, z_offset = -width/2 },
    
				}                         
        interior_spawner:CreateRoom("generic_interior", width, nil, 10, name, powerID, addprops, {}, walltexture, floortexture, minimaptexture, nil, nil, true, nil, "batcave","BAT_CAVE","DIRT", nil, nil, true)
        --创造工业区
		addprops = {
					{ name = "prop_door", x_offset = 0, z_offset = -7.5, animdata = {bank = "player_house_doors", build = "player_house_doors", anim = "plate_door_close_west", background = true }, 
						my_door_id = industry_door_def.target_door_id, target_door_id = industry_door_def.my_door_id, target_interior = fire_door_def.target_interior, rotation = -90, flip = false, addtags = {"lockable_door","door_west"} },
                    { name = "prop_door", x_offset = -5, z_offset = 0, animdata = {bank = "player_house_doors", build = "player_house_doors", anim = "plate_door_close_north", background = true }, 
						my_door_id = industry_door_def.target_door_id2, target_door_id = save_door_def.target_door_id2, target_interior = save_door_def.target_interior, rotation = -90, flip = false, addtags = {"lockable_door","door_north"} },
                    { name = "buling_light_fx",          x_offset = 0,  z_offset =  0 },       
                    { name = "researchlab",          x_offset = 0,  z_offset =  0 },       
					
					{ name = "buling_accademy_beam",          x_offset = -5,  z_offset = width/2, flip=true },
                    { name = "buling_accademy_beam",          x_offset = -5,  z_offset = -width/2 },
                    { name = "buling_accademy_beam2",    x_offset = 4.7, z_offset = width/2, flip=true },
                    { name = "buling_accademy_beam2",    x_offset = 4.7, z_offset = -width/2 },
    
				}                         
        interior_spawner:CreateRoom("generic_interior", width, nil, 10, name, industryID, addprops, {}, walltexture, floortexture, minimaptexture, nil, nil, true, nil, "batcave","BAT_CAVE","DIRT", nil, nil, true)
        
		inst:AddTag("spawned_home")
    end        
end
local function shipfn(inst, doer)
	local function onsave(inst, data)
		data = data or {}
		if inst:HasTag("spawned_home") then
			data.spawned_shop = true
		end
	end
	
	local function onload(inst, data)
		if data and data.spawned_shop then
			inst:AddTag("spawned_home")
		end
	end
	local inst = fn(inst)
	if inst.task then
		inst.task:Cancel()
		inst.task = nil
	end
	inst.task = inst:DoTaskInTime(0, function() 
         creatInterior_ship(inst)
    end)
	inst.OnSave = onsave 
    inst.OnLoad = onload
	return inst
end
return Prefab( "buling_cave_entrance", fn, assets),
Prefab( "buling_airship_entrance", shipfn, assets) 