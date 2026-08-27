--价格表
local buling_sellitem = {
    turf_rocky = 25,
    turf_savanna = 25,
    turf_grass = 25,
    turf_forest = 25,
    turf_marsh = 25,
    turf_cave = 25,
    turf_fungus = 25,
    turf_fungus_red = 25,
    turf_fungus_green = 25,
    turf_sinkhole = 25,
    turf_underrock = 25,
    turf_mud = 25,
    turf_desertdirt = 25,
    turf_deciduous = 25,
    turf_beach = 25,
    turf_jungle = 25,
    turf_magmafield = 25,
    turf_tidalmarsh = 25,
    turf_meadow = 25,
    turf_volcano = 25,
    turf_ash = 25,
    turf_woodfloor = 25,
    turf_road = 25,
    gunpowder = 456,
    amulet = 747,
    marble = 347,
    gears = 447,
    tentaclespots = 167,
    blueamulet = 834,
    purpleamulet = 1234,
    orangeamulet = 2663,
    greenamulet = 7747,
    yellowamulet = 2521,
    purplegem = 4334,
    bluegem = 3734,
    redgem = 3747,
    orangegem = 5763,
    yellowgem = 5821,
    greengem = 7747,
    icestaff = 1834,
    firestaff = 747,
    telestaff = 1234,
    orangestaff = 2663,
    greenstaff = 7747,
    yellowstaff = 2521,
    beargervest = 4834,
    bearger_fur = 4834,
    eyebrellahat = 1834,
    deerclops_eyeball = 3834,
    tigereye = 3834,
    minotaurhorn = 6834,
    dragon_scales = 4834,
    goose_feather = 347,
    shark_gills = 1347,
    cane = 3847,
    walrus_tusk = 3747,
    walrushat = 3834,
    cookedmandrake = 7747,
    panflute = 7747,
    mandrake = 7747,
    mandrakesoup = 7747,
    krampus_sack = 10000,
    fireflies = 835,
    bioluminescence = 634,
    messagebottle = 1835,
    tallbirdegg = 634,
    tallbirdegg_cracked = 634,
    tallbirdegg_cooked = 134,
    lureplantbulb = 334,
    spidereggsack = 634,
    spiderhat = 367,
    horn = 747,
    beefalohat = 947,
    blubber = 747,
    ox_horn = 547,
    lightninggoathorn = 447,
    pigskin = 2,
    coontail = 323,
    venomgland = 323,
    manrabbit_tail = 46,
    snakeskin = 53,
    cutreeds = 60,
    dug_sapling = 220,
    dug_berrybush = 340,
    dug_berrybush2 = 360,
    dug_grass = 230,
    dug_marsh_bush = 170,
    dug_bambootree = 240,
    dug_bush_vine = 220,
    dug_elephantcactus = 200,
    dug_coffeebush = 300,
    ironwind = 2834,
    turbine_blades = 2834,
    dragoonheart = 452,
    magic_seal = 1834,
    obsidian = 62,
    goldnugget = 23,
    coral = 15,
    rocks = 19,
    flint = 19,
    nitre = 34,
    log = 3,
    pinecone = 3,
    acorn = 53,
    coconut = 43,
    jungletreeseed = 3,
    cutgrass = 17,
    bamboo = 34,
    sand = 13,
    boneshard = 31,
    palmleaf = 13,
    vine = 21,
    twigs = 17,
    dubloon = 107,
    meat = 2,
    nightmarefuel = 45,
    seashell = 32,
    seaweed = 32,
    smallmeat = 22,
    froglegs = 22,
    honey = 13,
    honeycomb = 749,
    stinger = 10,
    butter = 430,
    drumstick = 45,
    batwing = 58,
    plantmeat = 35,
    fish = 25,
    tropical_fish = 25,
    eel = 75,
    cutlichen = 30,
    berries = 15,
    carrot = 15,
    green_cap = 22,
    blue_cap = 18,
    bird_egg = 12,
    houndstooth = 52,
    thulecite = 350,
    livinglog = 139,
    charcoal = 25,
    cactus_meat = 36,
    goatmilk = 134,
    silk = 26,
    seeds = 9,
    poop = 23,
    guano = 43,
    wormlight = 234,
    thulecite_pieces = 200,
    armorwood = 180,
    footballhat = 170,
    glommerfuel = 200,
}

local function OnGetItemFromPlayer(inst, giver, item)
    if not item or not giver then return end
    if item.components and item.components.edible then
        if item.components.edible.foodtype == FOODTYPE.MEAT or item.components.edible.foodtype == "MEAT" or item.components.edible.foodtype == "HORRIBLE" or item.prefab == "carrot" or item.prefab == "carrot_cooked" then
            if inst.components.combat and inst.components.combat.target == giver then
                inst.components.combat:SetTarget(nil)
			elseif giver.components and giver.components.leader and inst.prefab == "bunnyman" and giver:HasTag("bunnyking") then
				if inst.SoundEmitter then
					inst.SoundEmitter:PlaySound("dontstarve/common/makeFriend")
				end
				giver.components.leader:AddFollower(inst)
                if inst.components.follower then
                	inst.components.follower:AddLoyaltyTime(item.components.edible:GetHunger() * (TUNING.PIG_LOYALTY_PER_HUNGER or 10))
                end
			end
        end
        if inst.components.sleeper and inst.components.sleeper:IsAsleep() then
            inst.components.sleeper:WakeUp()
        end
    end
    if item.components and item.components.equippable and item.components.equippable.equipslot == EQUIPSLOTS.HEAD then
        if inst.components.inventory then
	        local current = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
	        if current then
	            inst.components.inventory:DropItem(current)
	        end
	        inst.components.inventory:Equip(item)
	    end
        if inst.AnimState then
        	inst.AnimState:Show("hat")
        end
    end
end

local function ApplyTraderPostInit(inst)
	if not TheWorld or not TheWorld.ismastersim then return end
	if inst.components.trader then
		local old_onaccept = inst.components.trader.onaccept
		inst.components.trader.onaccept = function(inst, giver, item)
			if giver and giver:HasTag("bulingbuling") then
				OnGetItemFromPlayer(inst, giver, item)
			elseif old_onaccept then
				old_onaccept(inst, giver, item)
			end
		end
	end
end

AddPrefabPostInit("pigman", ApplyTraderPostInit)
AddPrefabPostInit("wildbore", ApplyTraderPostInit)
AddPrefabPostInit("bunnyman", ApplyTraderPostInit)