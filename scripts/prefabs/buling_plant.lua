local GLOBAL = _G
local assets =
{
	Asset("ANIM", "anim/buling_wheat.zip"),
	Asset("ANIM", "anim/buling_seed.zip"),
	Asset("ANIM", "anim/buling_caiyuan.zip"),
	Asset("ATLAS", "images/inventoryimages/buling_seed_zhongziding.xml"),
	
	Asset("ATLAS", "images/inventoryimages/buling_seed_flint.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_seed_gold.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_seed_marble.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_seed_nitre.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_seed_obsidian.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_seed_rock.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_seed_wheat.xml"),
	
	Asset("ATLAS", "images/inventoryimages/buling_seed_redai.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_seed_duofeng.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_seed_pinji.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_seed_shirun.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_seed_yinbi.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_seed_thulecite.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_seed_iron.xml"),
}
local function onmatured(inst, doer, grower)
	if inst.buling_shuipei then
		if inst.buling_shuipei and inst.buling_shuipei.PushEvent then inst.buling_shuipei:PushEvent("buling_mature") end
	end
	inst.SoundEmitter:PlaySound("dontstarve/common/farm_harvestable")
	inst.AnimState:OverrideSymbol("swap_grown", inst.bank,inst.build)
end
local function OnLoadPostPass(inst, doer)
    if inst.components.crop and not inst.components.crop.grower then
        inst.components.crop:Resume()
    end
end
local function workcallback(inst, doer, worker, workleft)
	if workleft <= 0 then
		inst.components.lootdropper:SpawnLootPrefab("seeds")
		inst:Remove()
	end
end
local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

    anim:SetBank("plant_normal")
    anim:SetBuild("plant_normal")
    anim:PlayAnimation("grow")
    anim:SetFinalOffset(-1)
	inst:AddTag("buling_plant")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("lootdropper")
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.DIG)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnWorkCallback(workcallback)
    inst:AddComponent("crop")
    inst.components.crop:SetOnMatureFn(onmatured)
    inst.makewitherabletask = inst:DoTaskInTime(TUNING.WITHER_BUFFER_TIME or 10, function(inst) if inst.components.crop and inst.components.crop.MakeWitherable then inst.components.crop:MakeWitherable() end end)
    inst:AddComponent("inspectable")
    MakeSmallPropagator(inst)
    anim:SetFinalOffset(-1)
	inst.time = 1440
	inst:AddTag("buling_plant")
    inst.OnLoadPostPass = OnLoadPostPass   
    inst:DoTaskInTime(0,function() 
        if inst.components.crop and not inst.components.crop.product_prefab then
            if inst.components.crop.task then
                inst.components.crop.task:Cancel()
                inst.components.crop.task = nil
            end
            inst.components.crop:StartGrowing(inst.grower, inst.time, inst)
        end
    end)
	--hook
	inst.components.crop.Harvest = function(self,harvester)
		if self.matured or self.withered then
        local product = nil
        if self.grower and self.grower:HasTag("fire") or self.inst:HasTag("fire") then
            local temp = SpawnPrefab(self.product_prefab)
            if temp.components.cookable and temp.components.cookable.product then
                product = SpawnPrefab(temp.components.cookable.product)
            else
                product = SpawnPrefab("seeds_cooked")
            end
            temp:Remove()
        else
            product = SpawnPrefab(self.product_prefab)
        end

        if product then
            self.inst:ApplyInheritedMoisture(product)
        end
		if harvester.components.inventory then
			harvester.components.inventory:GiveItem(product, nil, Vector3(TheSim:GetScreenPos(self.inst.Transform:GetWorldPosition())))
		else
			product:Remove()
		end
        ProfileStatsAdd("grown_"..product.prefab) 
         
        self.matured = false
        --self.withered = false
        self.inst:RemoveTag("withered")
        self.growthpercent = 0
        self.product_prefab = nil

        if self.grower and self.grower.components.grower then
            self.grower.components.grower:RemoveCrop(self.inst)
            self.grower = nil
        else
            self.inst.components.crop:StartGrowing(inst.grower, inst.time, inst,.25)
        end
		if self.withered == true then
			self.inst:Remove()
		end
        return true
		end
	end
	
    return inst
end
---------plants
local function zhongzidingfn(inst, doer)
	local inst = fn(inst)
	inst.grower = "buling_zhongziding"
	inst.bank = "buling_zhongziding"
	inst.build = "buling_zhongziding_01"
	return inst
end
local function rockfn(inst, doer)
	local inst = fn(inst)
	inst.grower = "rocks"
	inst.bank = "rocks"
	inst.build = "rocks01"
	return inst
end
local function marblefn(inst, doer)
	local inst = fn(inst)
	inst.grower = "marble"
	inst.bank = "marble"
	inst.build = "marble01"
	return inst
end
local function goldfn(inst, doer)
	local inst = fn(inst)
	inst.grower = "gold_dust"
	inst.bank = "gold_dust"
	inst.build = "gold_dust01"
	return inst
end
local function tarpoolfn(inst, doer)
	local inst = fn(inst)
	inst.grower = "tar_pool"
	inst.bank = "gold_nugget"
	inst.build = "nugget"
	return inst
end
local function sandfn(inst, doer)
	local inst = fn(inst)
	inst.grower = "sand"
	inst.bank = "sandhill"
	inst.build = "sand_image"
	return inst
end
local function nitrefn(inst, doer)
	local inst = fn(inst)
	inst.grower = "nitre"
	inst.bank = "nitre"
	inst.build = "nitre01"
	return inst
end
local function obsidianfn(inst, doer)
	local inst = fn(inst)
	inst.grower = "obsidian"
	inst.bank = "obsidian"
	inst.build = "obsidian_image"
	inst.time = 3000
	inst.enzyme = "beta"
	return inst
end
local function thulecitefn(inst, doer)
	local inst = fn(inst)
	inst.grower = "thulecite_pieces"
	inst.bank = "thulecite_pieces"
	inst.build = "thulecite_pieces01"
	inst.time = 3000
	inst.enzyme = "beta"
	return inst
end
local function ironfn(inst, doer)
	local inst = fn(inst)
	inst.grower = "iron"
	inst.bank = "iron_ore"
	inst.build = "ore01"
	inst.time = 3000
	inst.enzyme = "beta"
	return inst
end
local function flintfn(inst, doer)
	local inst = fn(inst)
	inst.grower = "flint"
	inst.bank = "flint"
	inst.build = "flint01"
	return inst
end
local function wheatfn(inst, doer)
	local inst = fn(inst)
	inst.grower = "buling_seed_wheat"
	inst.bank = "buling_wheat"
	inst.build = "buling_wheat"
	return inst
end
local function buling_caiyuan_duofeng(inst, doer)
	local inst = fn(inst)
	inst.grower = "buling_fruit_duofeng"
	inst.bank = "buling_caiyuan"
	inst.build = "buling_caiyuan"
	inst.time = 2880
	return inst
end
local function buling_caiyuan_shirun(inst, doer)
	local inst = fn(inst)
	inst.grower = "buling_fruit_shirun"
	inst.bank = "buling_caiyuan"
	inst.build = "buling_caiyuan_shirun"
	inst.time = 2880
	return inst
end
local function buling_caiyuan_redai(inst, doer)
	local inst = fn(inst)
	inst.grower = "buling_fruit_redai"
	inst.bank = "buling_caiyuan"
	inst.build = "buling_caiyuan_redai"
	inst.time = 2880
	return inst
end
local function buling_caiyuan_yinbi(inst, doer)
	local inst = fn(inst)
	inst.grower = "buling_fruit_yinbi"
	inst.bank = "buling_caiyuan"
	inst.build = "buling_caiyuan_yinbi"
	inst.time = 2880
	return inst
end
local function buling_caiyuan_pinji(inst, doer)
	local inst = fn(inst)
	inst.grower = "buling_fruit_pinji"
	inst.bank = "buling_caiyuan"
	inst.build = "buling_caiyuan_pinji"
	inst.time = 2880
	return inst
end
local function ceshi_foodfn(inst, doer)
	local inst = fn(inst)
	inst.grower = "rocks"
	inst.bank = "buling_caiyuan"
	inst.build = "buling_caiyuan_shirun"
	return inst
end
local function ceshi_foodfn(inst, doer)
	local inst = fn(inst)
	inst.grower = "rocks"
	inst.bank = "buling_caiyuan"
	inst.build = "buling_caiyuan_shirun"
	return inst
end
-------------seaplants
local function wheat_waterfn(inst, doer)
	local inst = fn(inst)
	inst.AnimState:SetBank("hydroponic_fast_farmplot")
    inst.AnimState:SetBuild("hydroponic_fast_farmplot")
	inst.grower = "buling_seed_wheat"
	inst.bank = "buling_wheat"
	inst.build = "buling_wheat"
	return inst
end
local function zhongziding_waterfn(inst, doer)
	local inst = wheat_waterfn(inst)
	inst.grower = "buling_zhongziding"
	inst.bank = "buling_zhongziding"
	inst.build = "buling_zhongziding_01"
	inst.time = 960
	return inst
end
local function rock_waterfn(inst, doer)
	local inst = wheat_waterfn(inst)
	inst.grower = "buling_fruit_rock"
	inst.bank = "rock_magma_gold"
	inst.build = "magma"
	inst.time = 2160
	return inst
end
local function buling_caiyuan_duofeng_water(inst, doer)
	local inst = wheat_waterfn(inst)
	inst.grower = "buling_fruit_duofeng"
	inst.bank = "buling_caiyuan"
	inst.build = "buling_caiyuan"
	inst.time = 2160
	return inst
end
local function buling_caiyuan_shirun_water(inst, doer)
	local inst = wheat_waterfn(inst)
	inst.grower = "buling_fruit_shirun"
	inst.bank = "buling_caiyuan"
	inst.build = "buling_caiyuan_shirun"
	inst.time = 2160
	return inst
end
local function buling_caiyuan_redai_water(inst, doer)
	local inst = wheat_waterfn(inst)
	inst.grower = "buling_fruit_redai"
	inst.bank = "buling_caiyuan"
	inst.build = "buling_caiyuan_redai"
	inst.time = 2160
	return inst
end
local function buling_caiyuan_yinbi_water(inst, doer)
	local inst = wheat_waterfn(inst)
	inst.grower = "buling_fruit_yinbi"
	inst.bank = "buling_caiyuan"
	inst.build = "buling_caiyuan_yinbi"
	inst.time = 2160
	return inst
end
local function buling_caiyuan_pinji_water(inst, doer)
	local inst = wheat_waterfn(inst)
	inst.grower = "buling_fruit_pinji"
	inst.bank = "buling_caiyuan"
	inst.build = "buling_caiyuan_pinji"
	inst.time = 2160
	return inst
end
local function sand_waterfn(inst, doer)
	local inst = wheat_waterfn(inst)
	inst.grower = "sand"
	inst.bank = "sandhill"
	inst.build = "sand_image"
	return inst
end
local function nitre_waterfn(inst, doer)
	local inst = wheat_waterfn(inst)
	inst.grower = "nitre"
	inst.bank = "nitre"
	inst.build = "nitre01"
	return inst
end
local function obsidian_waterfn(inst, doer)
	local inst = wheat_waterfn(inst)
	inst.grower = "obsidian"
	inst.bank = "obsidian"
	inst.build = "obsidian_image"
	return inst
end
local function flint_waterfn(inst, doer)
	local inst = wheat_waterfn(inst)
	inst.grower = "flint"
	inst.bank = "flint"
	inst.build = "flint01"
	return inst
end
-------------seeds
local function seedsfn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("buling_seed")
    inst.AnimState:SetBuild("buling_seed")
	inst.AnimState:PlayAnimation("idle",true)
    inst:AddTag("seed")
	inst:AddTag("buling_seed")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("stackable")
    inst:AddComponent("inspectable")
    inst:AddComponent("deployable")
    inst:AddComponent("inventoryitem")
	inst:AddComponent("tradable")
	inst.components.deployable.placer = "seeds_placer"
    return inst
end
local function zhongzidingseedfn(inst, doer)
	local function OnDeploy (inst, pt, deployer)
		local doer = deployer
		SpawnPrefab("buling_plant_zhongziding").Transform:SetPosition(pt.x, pt.y, pt.z)
		inst.components.stackable:Get():Remove()
	end
    local inst = seedsfn(inst)
	inst.AnimState:SetBank("buling_zhongziding")
    inst.AnimState:SetBuild("buling_zhongziding")
    inst.AnimState:PlayAnimation("anim")
		if not TheWorld.ismastersim then
		return inst
	end
	inst.components.deployable.ondeploy = OnDeploy
	inst.components.inventoryitem.imagename = "buling_zhongziding"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_zhongziding.xml"
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
	inst:AddComponent("tradable")
	inst.buling_plant = "buling_plant_zhongziding"
	return inst
end
local function rockseedfn(inst, doer)
	local function OnDeploy (inst, pt, deployer)
		local doer = deployer
		SpawnPrefab("buling_plant_rock").Transform:SetPosition(pt.x, pt.y, pt.z)
		inst.components.stackable:Get():Remove()
	end
    local inst = seedsfn(inst)
		if not TheWorld.ismastersim then
		return inst
	end
	inst.components.deployable.ondeploy = OnDeploy
	inst.components.inventoryitem.imagename = "buling_seed_rock"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_seed_rock.xml"
	inst.buling_plant = "buling_plant_rock"
	return inst
end
local function flintseedfn(inst, doer)
	local function OnDeploy (inst, pt, deployer)
		local doer = deployer
		SpawnPrefab("buling_plant_flint").Transform:SetPosition(pt.x, pt.y, pt.z)
		inst.components.stackable:Get():Remove()
	end
    local inst = seedsfn(inst)
		if not TheWorld.ismastersim then
		return inst
	end
	inst.components.deployable.ondeploy = OnDeploy
	inst.components.inventoryitem.imagename = "buling_seed_flint"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_seed_flint.xml"
	inst.buling_plant = "buling_plant_flint"
	return inst
end
local function nitreseedfn(inst, doer)
	local function OnDeploy (inst, pt, deployer)
		local doer = deployer
		SpawnPrefab("buling_plant_nitre").Transform:SetPosition(pt.x, pt.y, pt.z)
		inst.components.stackable:Get():Remove()
	end
    local inst = seedsfn(inst)
		if not TheWorld.ismastersim then
		return inst
	end
	inst.components.deployable.ondeploy = OnDeploy
	inst.components.inventoryitem.imagename = "buling_seed_nitre"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_seed_nitre.xml"
	inst.buling_plant = "buling_plant_nitre"
	return inst
end
local function goldseedfn(inst, doer)
	local function OnDeploy (inst, pt, deployer)
		local doer = deployer
		SpawnPrefab("buling_plant_gold").Transform:SetPosition(pt.x, pt.y, pt.z)
		inst.components.stackable:Get():Remove()
	end
    local inst = seedsfn(inst)
		if not TheWorld.ismastersim then
		return inst
	end
	inst.components.deployable.ondeploy = OnDeploy
	inst.components.inventoryitem.imagename = "buling_seed_gold"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_seed_gold.xml"
	inst.buling_plant = "buling_plant_gold"
	return inst
end
local function obsidianseedfn(inst, doer)
	local function OnDeploy (inst, pt, deployer)
		local doer = deployer
		SpawnPrefab("buling_plant_obsidian").Transform:SetPosition(pt.x, pt.y, pt.z)
		inst.components.stackable:Get():Remove()
	end
    local inst = seedsfn(inst)
		if not TheWorld.ismastersim then
		return inst
	end
	inst.components.deployable.ondeploy = OnDeploy
	inst.components.inventoryitem.imagename = "buling_seed_obsidian"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_seed_obsidian.xml"
	inst.buling_plant = "buling_plant_obsidian"
	return inst
end
local function thuleciteseedfn(inst, doer)
	local function OnDeploy (inst, pt, deployer)
		local doer = deployer
		SpawnPrefab("buling_plant_thulecite").Transform:SetPosition(pt.x, pt.y, pt.z)
		inst.components.stackable:Get():Remove()
	end
    local inst = seedsfn(inst)
		if not TheWorld.ismastersim then
		return inst
	end
	inst.components.deployable.ondeploy = OnDeploy
	inst.components.inventoryitem.imagename = "buling_seed_thulecite"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_seed_thulecite.xml"
	inst.buling_plant = "buling_plant_thulecite"
	return inst
end
local function ironseedfn(inst, doer)
	local function OnDeploy (inst, pt, deployer)
		local doer = deployer
		SpawnPrefab("buling_plant_iron").Transform:SetPosition(pt.x, pt.y, pt.z)
		inst.components.stackable:Get():Remove()
	end
    local inst = seedsfn(inst)
		if not TheWorld.ismastersim then
		return inst
	end
	inst.components.deployable.ondeploy = OnDeploy
	inst.components.inventoryitem.imagename = "buling_seed_iron"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_seed_iron.xml"
	inst.buling_plant = "buling_plant_iron"
	return inst
end
local function marbleseedfn(inst, doer)
	local function OnDeploy (inst, pt, deployer)
		local doer = deployer
		SpawnPrefab("buling_plant_marble").Transform:SetPosition(pt.x, pt.y, pt.z)
		inst.components.stackable:Get():Remove()
	end
    local inst = seedsfn(inst)
		if not TheWorld.ismastersim then
		return inst
	end
	inst.components.deployable.ondeploy = OnDeploy
	inst.components.inventoryitem.imagename = "buling_seed_marble"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_seed_marble.xml"
	inst.buling_plant = "buling_plant_marble"
	return inst
end
local function ceshiseedfn(inst, doer)--测试
	local function OnDeploy (inst, pt, deployer)
		local doer = deployer
		SpawnPrefab("buling_plant_rock").Transform:SetPosition(pt.x, pt.y, pt.z)
		inst.components.stackable:Get():Remove()
	end
    local inst = seedsfn(inst)
		if not TheWorld.ismastersim then
		return inst
	end
	inst.components.deployable.ondeploy = OnDeploy
	inst.components.inventoryitem.imagename = "buling_seed_wheat"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_seed_wheat.xml"
	inst.buling_plant = "buling_plant_rock"
	return inst
end
local function wheatseedfn(inst, doer)--小麦
	local function OnDeploy (inst, pt, deployer)
		local doer = deployer
		SpawnPrefab("buling_plant_wheat").Transform:SetPosition(pt.x, pt.y, pt.z)
		inst.components.stackable:Get():Remove()
	end
    local inst = seedsfn(inst)
	inst.AnimState:SetBank("buling_wheat")
    inst.AnimState:SetBuild("buling_wheat")
    inst.AnimState:PlayAnimation("idle")
		if not TheWorld.ismastersim then
		return inst
	end
	inst.components.deployable.ondeploy = OnDeploy
	inst.components.inventoryitem.imagename = "buling_seed_wheat"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_seed_wheat.xml"
	inst:AddComponent("edible")
	inst.components.edible.foodtype = "VEGGIE"
	inst.components.edible.healthvalue = 1
	inst.components.edible.hungervalue = 0
	inst.components.edible.sanityvalue = -1
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_SUPERSLOW)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"
	inst.buling_plant = "buling_plant_wheat"
	return inst
end
local function buling_seed_duofeng(inst, doer)
	local function OnDeploy (inst, pt, deployer)
		local doer = deployer
		SpawnPrefab("buling_caiyuan_duofeng").Transform:SetPosition(pt.x, pt.y, pt.z)
		inst.components.stackable:Get():Remove()
	end
    local inst = seedsfn(inst)
		if not TheWorld.ismastersim then
		return inst
	end
	inst.components.deployable.ondeploy = OnDeploy
	inst.components.inventoryitem.imagename = "buling_seed_duofeng"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_seed_duofeng.xml"
	inst.buling_plant = "buling_caiyuan_duofeng"
	return inst
end
local function buling_seed_redai(inst, doer)
	local function OnDeploy (inst, pt, deployer)
		local doer = deployer
		SpawnPrefab("buling_caiyuan_redai").Transform:SetPosition(pt.x, pt.y, pt.z)
		inst.components.stackable:Get():Remove()
	end
    local inst = seedsfn(inst)
		if not TheWorld.ismastersim then
		return inst
	end
	inst.components.deployable.ondeploy = OnDeploy
	inst.components.inventoryitem.imagename = "buling_seed_redai"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_seed_redai.xml"
	inst.buling_plant = "buling_caiyuan_redai"
	return inst
end
local function buling_seed_shirun(inst, doer)
	local function OnDeploy (inst, pt, deployer)
		local doer = deployer
		SpawnPrefab("buling_caiyuan_shirun").Transform:SetPosition(pt.x, pt.y, pt.z)
		inst.components.stackable:Get():Remove()
	end
    local inst = seedsfn(inst)
		if not TheWorld.ismastersim then
		return inst
	end
	inst.components.deployable.ondeploy = OnDeploy
	inst.components.inventoryitem.imagename = "buling_seed_shirun"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_seed_shirun.xml"
	inst.buling_plant = "buling_caiyuan_shirun"
	return inst
end
local function buling_seed_yinbi(inst, doer)
	local function OnDeploy (inst, pt, deployer)
		local doer = deployer
		SpawnPrefab("buling_caiyuan_yinbi").Transform:SetPosition(pt.x, pt.y, pt.z)
		inst.components.stackable:Get():Remove()
	end
    local inst = seedsfn(inst)
		if not TheWorld.ismastersim then
		return inst
	end
	inst.components.deployable.ondeploy = OnDeploy
	inst.components.inventoryitem.imagename = "buling_seed_yinbi"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_seed_yinbi.xml"
	inst.buling_plant = "buling_caiyuan_yinbi"
	return inst
end
local function buling_seed_pinji(inst, doer)
	local function OnDeploy (inst, pt, deployer)
		local doer = deployer
		SpawnPrefab("buling_caiyuan_pinji").Transform:SetPosition(pt.x, pt.y, pt.z)
		inst.components.stackable:Get():Remove()
	end
    local inst = seedsfn(inst)
		if not TheWorld.ismastersim then
		return inst
	end
	inst.components.deployable.ondeploy = OnDeploy
	inst.components.inventoryitem.imagename = "buling_seed_pinji"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_seed_pinji.xml"
	inst.buling_plant = "buling_caiyuan_pinji"
	return inst
end
--果实
local function buling_redai_4(inst, doer)
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

	inst.AnimState:SetBank("eyeplant_bulb")
    inst.AnimState:SetBuild("eyeplant_bulb")
    inst.AnimState:PlayAnimation("idle")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_seed_redai"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_seed_redai.xml"
	inst.components.inventoryitem:SetOnPickupFn(function()
		inst:DoTaskInTime(0.1,function()
			inst:Remove()
			local items = {"coconut","cave_banana","watermelon","dragonfruit","durian"}
			for k=1,4 do
				local item = items[math.random(#items)] 
				local _target = doer or inst
				_target.components.inventory:GiveItem(SpawnPrefab(item))
			end
		end)
	end)
	return inst
end
local function buling_shirun_4(inst, doer)
	local inst=buling_redai_4(inst)
	inst.components.inventoryitem.imagename = "buling_seed_shirun"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_seed_shirun.xml"
	inst.components.inventoryitem:SetOnPickupFn(function()
		inst:DoTaskInTime(0.1,function()
			inst:Remove()
			local items = {"aloe","asparagus","cutnettle","radish","cutreeds"}
			for k=1,4 do
				local item = items[math.random(#items)] 
				local _target = doer or inst
				_target.components.inventory:GiveItem(SpawnPrefab(item))
			end
		end)
	end)
	return inst
end
local function buling_duofeng_4(inst, doer)
	local inst=buling_redai_4(inst)
	inst.components.inventoryitem.imagename = "buling_seed_duofeng"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_seed_duofeng.xml"
	inst.components.inventoryitem:SetOnPickupFn(function()
		inst:DoTaskInTime(0.1,function()
			inst:Remove()
			local items = {"carrot","pumpkin","eggplant","pomegranate","corn","berries"}
			for k=1,4 do
				local item = items[math.random(#items)] 
				local _target = doer or inst
				_target.components.inventory:GiveItem(SpawnPrefab(item))
			end
		end)
	end)
	return inst
end
local function buling_pinji_4(inst, doer)
	local inst=buling_redai_4(inst)
	inst.components.inventoryitem.imagename = "buling_seed_duofeng"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_seed_duofeng.xml"
	inst.components.inventoryitem:SetOnPickupFn(function()
		inst:DoTaskInTime(0.1,function()
			inst:Remove()
			local items = {"cactus_meat","cactus_flower","tuber_crop","tuber_bloom_crop","sweet_potato"}
			for k=1,4 do
				local item = items[math.random(#items)] 
				local _target = doer or inst
				_target.components.inventory:GiveItem(SpawnPrefab(item))
			end
		end)
	end)
	return inst
end
local function buling_yinbi_4(inst, doer)
	local inst=buling_redai_4(inst)
	inst.components.inventoryitem.imagename = "buling_seed_yinbi"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_seed_yinbi.xml"
	inst.components.inventoryitem:SetOnPickupFn(function()
		inst:DoTaskInTime(0.1,function()
			inst:Remove()
			local items = {"red_cap","green_cap","blue_cap","slugbug","jellybug"}
			for k=1,4 do
				local item = items[math.random(#items)] 
				local _target = doer or inst
				_target.components.inventory:GiveItem(SpawnPrefab(item))
			end
		end)
	end)
	return inst
end
local function buling_rock_4(inst, doer)
	local inst=buling_redai_4(inst)
	inst.components.inventoryitem.imagename = "buling_seed_yinbi"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_seed_yinbi.xml"
	inst.components.inventoryitem:SetOnPickupFn(function()
		inst:DoTaskInTime(0.1,function()
			inst:Remove()
			local items = {"rocks","flint","goldnugget","nitre","obsidian"}
			for k=1,4 do
				local item = items[math.random(#items)] 
				local _target = doer or inst
				_target.components.inventory:GiveItem(SpawnPrefab(item))
			end
		end)
	end)
	return inst
end
return Prefab( "buling_plant_zhongziding", zhongzidingfn, assets),
Prefab( "buling_plant_rock", rockfn, assets),
Prefab( "buling_plant_marble", marblefn, assets),
Prefab( "buling_plant_nitre", nitrefn, assets),
Prefab( "buling_plant_gold", goldfn, assets),
Prefab( "buling_plant_sand", sandfn, assets),
Prefab( "buling_plant_obsidian", obsidianfn, assets),
Prefab( "buling_plant_flint", flintfn, assets),
Prefab( "buling_plant_wheat", wheatfn, assets),
Prefab( "buling_plant_thulecite", thulecitefn, assets),
Prefab( "buling_plant_iron", ironfn, assets),
Prefab( "buling_caiyuan_duofeng", buling_caiyuan_duofeng, assets),
Prefab( "buling_caiyuan_pinji", buling_caiyuan_pinji, assets),
Prefab( "buling_caiyuan_redai", buling_caiyuan_redai, assets),
Prefab( "buling_caiyuan_shirun", buling_caiyuan_shirun, assets),
Prefab( "buling_caiyuan_yinbi", buling_caiyuan_yinbi, assets),
Prefab( "buling_plant_ceshi", ceshi_foodfn, assets),

--seaplants
Prefab( "buling_plant_zhongziding_water", zhongziding_waterfn, assets),
Prefab( "buling_plant_rock_water", rock_waterfn, assets),
Prefab( "buling_caiyuan_duofeng_water", buling_caiyuan_duofeng_water, assets),
Prefab( "buling_caiyuan_pinji_water", buling_caiyuan_pinji_water, assets),
Prefab( "buling_caiyuan_redai_water", buling_caiyuan_redai_water, assets),
Prefab( "buling_caiyuan_shirun_water", buling_caiyuan_shirun_water, assets),
Prefab( "buling_caiyuan_yinbi_water", buling_caiyuan_yinbi_water, assets),
Prefab( "buling_plant_sand_water", sand_waterfn, assets),
Prefab( "buling_plant_obsidian_water", obsidian_waterfn, assets),
Prefab( "buling_plant_flint_water", flint_waterfn, assets),
Prefab( "buling_plant_wheat_water", wheat_waterfn, assets),
--fruititem
Prefab( "buling_fruit_redai", buling_redai_4, assets),
Prefab( "buling_fruit_duofeng", buling_duofeng_4, assets),
Prefab( "buling_fruit_yinbi", buling_yinbi_4, assets),
Prefab( "buling_fruit_shirun", buling_shirun_4, assets),
Prefab( "buling_fruit_pinji", buling_pinji_4, assets),
Prefab( "buling_fruit_rock", buling_rock_4, assets),
--seed
Prefab( "buling_seed_flint", flintseedfn, assets),
Prefab( "buling_seed_wheat", wheatseedfn, assets),
Prefab( "buling_seed_nitre", nitreseedfn, assets),
Prefab( "buling_seed_rock", rockseedfn, assets),
Prefab( "buling_seed_gold", goldseedfn, assets),
Prefab( "buling_seed_obsidian", obsidianseedfn, assets),
Prefab( "buling_seed_marble", marbleseedfn, assets),
Prefab( "buling_seed_pinji", buling_seed_pinji, assets),
Prefab( "buling_seed_yinbi", buling_seed_yinbi, assets),
Prefab( "buling_seed_shirun", buling_seed_shirun, assets),
Prefab( "buling_seed_redai", buling_seed_redai, assets),
Prefab( "buling_seed_duofeng", buling_seed_duofeng, assets),
Prefab( "buling_seed_iron", ironseedfn, assets),
Prefab( "buling_seed_thulecite", thuleciteseedfn, assets),
Prefab( "buling_zhongziding", zhongzidingseedfn, assets)
