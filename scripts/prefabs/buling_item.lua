local function SendBulingRPC(rpc_name, ...)
	local rpc = (TheSim and TheSim.GetModRPC and TheSim:GetModRPC("bulingbuling", rpc_name))
		or (GLOBAL and GLOBAL.GetModRPC and GLOBAL.GetModRPC("bulingbuling", rpc_name))
		or (GLOBAL and GLOBAL.MOD_RPC and GLOBAL.MOD_RPC["bulingbuling"] and GLOBAL.MOD_RPC["bulingbuling"][rpc_name])
	if rpc then
		SendModRPCToServer(rpc, ...)
	end
end

local function candestroy(staff, caster, target)
	if not target then return false end
	if caster and caster.components and caster.components.combat then
		return caster.components.combat:CanTarget(target)
	end
	return true
end

local cooking = require("cooking")
local assets ={
	Asset("ANIM", "anim/buling_yifu/body_willow_dragonfly.zip"),
	Asset("ANIM", "anim/buling_yifu/body_buttons_black_jet.zip"),
	Asset("ANIM", "anim/buling_yifu/body_cableknit_sweater_tan_khaki.zip"),
	Asset("ANIM", "anim/buling_yifu/body_cardigan_black_jet.zip"),
	Asset("ANIM", "anim/buling_yifu/body_dancer_dragon.zip"),
	Asset("ANIM", "anim/buling_yifu/body_expo_letterman_yellow_beige.zip"),
	Asset("ANIM", "anim/buling_yifu/body_expo_sweater_blue_agean.zip"),
	Asset("ANIM", "anim/buling_yifu/body_flannel_blue_snowbird.zip"),
	Asset("ANIM", "anim/buling_yifu/body_jacket_shearling_orange_salmon.zip"),
	Asset("ANIM", "anim/buling_yifu/body_jacket_toggle_navy_phthalo.zip"),
	Asset("ANIM", "anim/buling_yifu/body_outerwear_quilted_red_cardinal.zip"),
	Asset("ANIM", "anim/buling_yifu/body_overalls_blue_denim.zip"),
	Asset("ANIM", "anim/buling_yifu/body_pj_blue_agean.zip"),
	Asset("ANIM", "anim/buling_yifu/body_silk_eveningrobe_red_rump.zip"),
	Asset("ANIM", "anim/buling_yifu/legs_checkered_pleats_blue_cornflower.zip"),
	Asset("ANIM", "anim/buling_yifu/legs_jeans_black_scribble.zip"),
	Asset("ANIM", "anim/buling_yifu/legs_pants_basic_blue_sky.zip"),
	Asset("ANIM", "anim/buling_yifu/legs_pinstripe_pants_black_jet.zip"),
	Asset("ANIM", "anim/buling_yifu/legs_shorts_black_scribble.zip"),
	Asset("ANIM", "anim/buling_yifu/legs_swing_pants_brown_umber.zip"),
	Asset("ANIM", "anim/buling_christmas.zip"),
	Asset("ANIM", "anim/bulingbuling_sikushui.zip"),
	Asset("ANIM", "anim/buling_zhongziding.zip"),
	Asset("ANIM", "anim/buling_zaxiang.zip"),
	Asset("ANIM", "anim/swap_beeraxe.zip"),
	Asset("ANIM", "anim/swap_beerpickaxe.zip"),
	Asset("ANIM", "anim/buling_tool.zip"),
	Asset("ANIM", "anim/swap_buling_shears.zip"),
	Asset("ANIM", "anim/swap_buling_banshou.zip"),
	Asset("ANIM", "anim/buling_banshou.zip"),
	Asset("ANIM", "anim/buling_glass.zip"),
	Asset("ATLAS", "images/inventoryimages/buling_zhongziding.xml"),
	Asset("ANIM", "anim/maichongbug.zip"),
	Asset("ANIM", "anim/mutsuki_ai_hat.zip"),
	--
	Asset("ANIM", "anim/buling_item.zip"),
	Asset("ATLAS", "images/inventoryimages/buling_ronglu.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_ronglu2.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_diandonggao.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_diandongjian.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_dianlifu.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_paotai.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_shengcun.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_zhongjiqi.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_diandeng.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_zhuangzhi.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_kuangjia.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_leida.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_glass.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_shouge.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_seedchest.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_seedbox.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_taiyangneng.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_chongdian.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_banshou.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_weaponbox.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_planttable.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_chest.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_manure.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_wakuang.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_huosai.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_cave_tool.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_puleidi.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_puleidi_plank.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_zhongjiqi_gaoya.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_core.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_bileizhen.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_tiaohe.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_manual_item.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_pilianghecheng_item.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_chest_mini_item.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_chuansongdai_item.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_jixiebi_item.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_shuipei_item.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_zidonghecheng_item.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_waterproof_field.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_car_log.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_infinitebox.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_chipbox.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_conversion.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_rocky_staff.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_juhemei_alpha.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_juhemei_beta.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_zhusheqi.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_yanjiutai.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_yanjiudian.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_yajin.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_gun_qiangguan_ying.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_gun_dianchi_taiyang.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_gun_jiguang_boli.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_gun_shoubing_juji.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_dianxiangan.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_lamp.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_chemistrytable.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_paotai_up.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_fabric.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_fengrenji.xml"),
	Asset("ATLAS", "images/inventoryimages/buling_fensui.xml"),
	
}
--限制种植
local function test_deploy(inst, doer, pt)
    local tiletype = GetGroundTypeAtPosition(pt)
    local ground_OK = tiletype ~= GROUND.ROCKY and tiletype ~= GROUND.ROAD and tiletype ~= GROUND.IMPASSABLE and tiletype ~= GROUND.INTERIOR and
                        tiletype ~= GROUND.UNDERROCK and tiletype ~= GROUND.WOODFLOOR and tiletype ~= GROUND.MAGMAFIELD and 
                        tiletype ~= GROUND.CARPET and tiletype ~= GROUND.CHECKER and 
                        tiletype ~= GROUND.ASH and tiletype ~= GROUND.VOLCANO and tiletype ~= GROUND.VOLCANO_ROCK and tiletype ~= GROUND.BRICK_GLOW and
                        tiletype ~= GROUND.FOUNDATION and tiletype ~= GROUND.COBBLEROAD and 
                        tiletype < GROUND.UNDERGROUND
    
    local ground = TheWorld
    if ground.Map:IsWater(tiletype) then 
		--print("ground_OK没ok")
        ground_OK = false 
    end 
    
    if ground_OK then
		--print("ground_OK了")
        local ents = TheSim:FindEntities(pt.x,pt.y,pt.z, 4, nil, {'NOBLOCK', 'player', 'FX'}) -- or we could include a flag to the search?
        local min_spacing = inst.components.deployable.min_spacing or 2

        for k, v in pairs(ents) do
            if v ~= inst and v:IsValid() and v.entity:IsVisible() and not v.components.placer and v.parent == nil then
                if distsq( Vector3(v.Transform:GetWorldPosition()), pt) < min_spacing*min_spacing then
                    return false
                end
            end
        end
        
        return true

    end
    return false
end
---通用
local function commonfn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst:AddComponent("inspectable")
    return inst
end
local function repair(inst, doer,itemname,Symbol)
	local function onequip(inst, owner, from_inventory)
	local doer = owner
		owner.AnimState:OverrideSymbol("swap_object", itemname, Symbol or itemname)
		owner.AnimState:Show("ARM_carry")
		owner.AnimState:Hide("ARM_normal")
		if inst.components.finiteuses.current<= 0 then
			local hands = (doer or inst).components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
			inst:DoTaskInTime(0.1,function()
				owner.components.inventory:DropItem(hands)
			end)
		end
	end
	local function onunequip(inst, owner)
	local doer = owner
		owner.AnimState:Hide("ARM_carry")
		owner.AnimState:Show("ARM_normal")
	end
	inst:AddComponent("equippable")
	inst.components.equippable:SetOnEquip( onequip )
	inst.components.equippable:SetOnUnequip( onunequip )
	inst.components.finiteuses.OnSave =  function (self)
		return {uses = self.current}
	end
end
-----
local function buling_manure(inst, doer)
	local inst=commonfn(inst)
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
    inst.AnimState:PlayAnimation("buling_manure")
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_manure"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_manure.xml"
	inst:AddComponent("tradable")
	inst:AddComponent("fertilizer")
    inst.components.fertilizer.fertilizervalue = TUNING.POOP_FERTILIZE
    inst.components.fertilizer.soil_cycles = TUNING.POOP_SOILCYCLES
    inst.components.fertilizer.withered_cycles = TUNING.POOP_WITHEREDCYCLES
    inst.components.fertilizer.planthealing = true
	return inst
end
local function buling_manure_4(inst, doer)
	local inst=commonfn(inst)
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_manure"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_manure.xml"
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
    inst.AnimState:PlayAnimation("buling_manure")
	inst.components.inventoryitem:SetOnPickupFn(function()
		inst:DoTaskInTime(0.1,function()
			inst:Remove()
			for k=1,4 do
				local _target = doer or inst
				_target.components.inventory:GiveItem(SpawnPrefab("buling_manure"))
			end
		end)
	end)
	return inst
end
local function buling_glass(inst, doer)
	local inst=commonfn(inst)
	inst.AnimState:SetBank("buling_glass")
    inst.AnimState:SetBuild("buling_glass")
    inst.AnimState:PlayAnimation("f3")
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_glass"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_glass.xml"
	inst:AddComponent("tradable")
	return inst
end
local function buling_fabric(inst, doer)
	local inst=commonfn(inst)
	inst.AnimState:SetBank("buling_item")
    inst.AnimState:SetBuild("buling_item")
    inst.AnimState:PlayAnimation("buling_cloth")
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_fabric"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_fabric.xml"
	inst:AddComponent("tradable")
	return inst
end
local function buling_yajin(inst, doer)
	local inst=commonfn(inst)
	inst.AnimState:SetBank("buling_item")
    inst.AnimState:SetBuild("buling_item")
    inst.AnimState:PlayAnimation("yajin")
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_yajin"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_yajin.xml"
	inst:AddComponent("tradable")
	return inst
end
local function buling_zhusheqi(inst, doer)
	local function onfinished(inst)
		inst:Remove()
	end
	local inst=commonfn(inst)
	inst.AnimState:SetBank("buling_item")
    inst.AnimState:SetBuild("buling_item")
    inst.AnimState:PlayAnimation("zhusheqi")
    inst:AddComponent("buling_getenzyme")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_zhusheqi"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_zhusheqi.xml"
	inst:AddComponent("tradable")
	inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(20)
	inst.components.finiteuses:SetUses(20)
	inst.components.finiteuses:SetOnFinished(onfinished)
	return inst
end
local function buling_puleidi(inst, doer)
	local inst=commonfn(inst)
	inst.entity:AddDynamicShadow()
	inst.DynamicShadow:SetSize( .8, .5 )
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
    inst.AnimState:PlayAnimation("puleidi",true)
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_puleidi"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_puleidi.xml"
	inst:AddComponent("tradable")
	return inst
end
local function buling_puleidi_plank(inst, doer)
	local inst=commonfn(inst)
	inst.entity:AddDynamicShadow()
	inst.DynamicShadow:SetSize( .8, .5 )
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
    inst.AnimState:PlayAnimation("puleidiban")
	inst:AddComponent("stackable")
	--inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_puleidi_plank"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_puleidi_plank.xml"
	inst:AddComponent("tradable")
	return inst
end
local function buling_yanjiudian(inst, doer)
	local inst=commonfn(inst)
	inst.entity:AddDynamicShadow()
	inst.DynamicShadow:SetSize( .8, .5 )
	inst.AnimState:SetBank("buling_item")
    inst.AnimState:SetBuild("buling_item")
    inst.AnimState:PlayAnimation("yanjiu")
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_yanjiudian"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_yanjiudian.xml"
	inst:AddComponent("tradable")
	return inst
end
local function buling_core(inst, doer)
	local inst=commonfn(inst)
	inst.entity:AddDynamicShadow()
	inst.DynamicShadow:SetSize( .8, .5 )
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
    inst.AnimState:PlayAnimation("waike")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_core"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_core.xml"
	inst:AddComponent("tradable")
	return inst
end
local function buling_conversion(inst, doer)
	local inst=commonfn(inst)
	inst.entity:AddDynamicShadow()
	--inst.DynamicShadow:SetSize( .8, .5 )
	inst.AnimState:SetBank("buling_item")
    inst.AnimState:SetBuild("buling_item")
    inst.AnimState:PlayAnimation("buling_conversion")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_conversion"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_conversion.xml"
	inst:AddComponent("tradable")
	return inst
end
local function buling_juhemei_alpha(inst, doer)
	local function generic_perish(inst, doer)
		inst:Remove()
	end
	local inst=commonfn(inst)
	inst.entity:AddDynamicShadow()
	--inst.DynamicShadow:SetSize( .8, .5 )
	inst.AnimState:SetBank("buling_item")
    inst.AnimState:SetBuild("buling_item")
    inst.AnimState:PlayAnimation("buling_juhemei_a")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_juhemei_alpha"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_juhemei_alpha.xml"
	inst:AddComponent("tradable")
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(480)
	inst.components.perishable:StartPerishing()
	inst.components.perishable:SetOnPerishFn(generic_perish)
	inst:AddTag("show_spoilage")
    inst:AddTag("icebox_valid")
	return inst
end
local function buling_juhemei_beta(inst, doer)
	local inst=buling_juhemei_alpha(inst)
	inst.components.inventoryitem.imagename = "buling_juhemei_beta"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_juhemei_beta.xml"
	return inst
end
local function gongzuotaiitemfn(Sim)
	local function ondeploy(inst, pt, deployer)
		SpawnPrefab("buling_manual").Transform:SetPosition(pt.x, pt.y, pt.z)      
	end
    local inst = CreateEntity()
    
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBank("buling_manual")
    inst.AnimState:SetBuild("buling_manual")
    inst.AnimState:PlayAnimation("idle")
	inst.Transform:SetScale(.5, .5, .5)
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "buling_manual"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_manual.xml"
	inst:AddTag("eyeturret")
        inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = ondeploy
    if DEPLOYMODE and DEPLOYMODE.ANY then
        inst.components.deployable:SetDeployMode(DEPLOYMODE.ANY)
    end
    if DEPLOYSPACING and DEPLOYSPACING.LESS then
        inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.LESS)
    end
    return inst
end
--测试
local function huojian()
	local function GetVerb(inst, doer)
		return "Travel Through"
	end
	local BigPopupDialogScreen = require "screens/popupdialog"
	require "prefabutil"
	local function OnActivate_GoTo(inst, doer)
		SetPause(true,"portal")
	
		local function dofight()
			TheFrontEnd:PopScreen()
			SetPause(false)
			local _target = doer or inst
			_target.sg:GoToState("teleportato_teleport")
			local _target = doer or inst
			_target:DoTaskInTime(2, function(p)
				if p and p.components.talker then
					p.components.talker:Say("Space dimension travel is disabled in DST")
				end
			end)
		end
		local function dofight2()
			TheFrontEnd:PopScreen()
			local _target = doer or inst
			_target.sg:GoToState("teleportato_teleport")
			local _target = doer or inst
			_target:DoTaskInTime(2, function(p)
				if p and p.components.talker then
					p.components.talker:Say("Space dimension travel is disabled in DST")
				end
			end)
		end
		local function dofight3()
			TheFrontEnd:PopScreen()
			local _target = doer or inst
			_target.sg:GoToState("teleportato_teleport")
			local _target = doer or inst
			_target:DoTaskInTime(2, function(p)
				if p and p.components.talker then
					p.components.talker:Say("Space dimension travel is disabled in DST")
				end
			end)
		end
		local function dofight4()
			TheFrontEnd:PopScreen()
			local _target = doer or inst
			_target.sg:GoToState("teleportato_teleport")
			local _target = doer or inst
			_target:DoTaskInTime(2, function(p)
				if p and p.components.talker then
					p.components.talker:Say("Space dimension travel is disabled in DST")
				end
			end)
		end
		local function rejectfight()
			TheFrontEnd:PopScreen()
			SetPause(false) 
			inst.components.activatable.inactive = true
		end

		TheFrontEnd:PushScreen(BigPopupDialogScreen("航空火箭","确定要进行太空旅行吗？\n请确保携带了可以返回的物资",
				{{text="风暴", cb = dofight},
				{text="沙漠", cb = dofight2},
				{text="伊甸", cb = dofight3},
				{text="月球", cb = dofight4},
				{text="放弃", cb = rejectfight}} ))
	end
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.Transform:SetScale(3, 3, 2.5)
    MakeInventoryPhysics(inst)
    inst.AnimState:SetBank("trinkets")
    inst.AnimState:SetBuild("trinkets")
	inst.AnimState:PlayAnimation("5")
    inst:AddComponent("inspectable")
	inst:AddComponent("activatable")
    inst.components.activatable.inactive = true
    inst.components.activatable.getverb = GetVerb
	inst.components.activatable.quickaction = true
	inst.components.activatable.OnActivate = OnActivate_GoTo
	return inst
end
local function dianlifu()--电动斧
	local function onfinished(inst)
		if inst.components.equippable then
            local owner = inst.components.equippable and inst.components.equippable.equippedto
		local target = (owner or inst)
		local item = (target.components and target.components.inventory and target.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS))
            if inst == item then
                target.components.inventory:GiveItem(item)
            end
            inst:RemoveComponent("equippable")
        end
	end 
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)
	
    inst.AnimState:SetBank("buling_tool")
    inst.AnimState:SetBuild("buling_tool")
	inst.AnimState:PlayAnimation("fuzi")
	
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_dianlifu"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_dianlifu.xml"
	inst:AddTag("beerpowertool")
    inst.buling_name = "swap_beeraxe"
	inst.symbol = "swap_beeraxe"
	inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(120)
	inst.components.finiteuses:SetUses(1)
	inst.repair = repair
	inst.repair(inst,inst.buling_name,inst.symbol)
	inst.components.finiteuses:SetOnFinished(onfinished)
    
	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(15)
    inst:AddComponent("inspectable")
	inst:AddComponent("tool")
	inst.components.tool:SetAction(ACTIONS.CHOP,3)
	inst.components.finiteuses:SetConsumption(ACTIONS.CHOP, 1)
	
	return inst
end
local function banshou()--扳手
	local function canbanshou(staff, caster, target, pos)
		return target and target.beeritem~= nil
	end
	local function spawnbanshou(staff, target, pos)
		local item = target.beeritem
		local tornado = SpawnPrefab(item)
		tornado.Transform:SetPosition(target.Transform:GetWorldPosition())
		SpawnPrefab("statue_transition").Transform:SetPosition(target:GetPosition():Get())
        SpawnPrefab("statue_transition_2").Transform:SetPosition(target:GetPosition():Get())
		if target.components.container then target.components.container:DropEverything() end
		target:DoTaskInTime(0.1,function() target:Remove() end)
	end
    local function onequip(inst, owner, from_inventory)
	local doer = owner
		owner.AnimState:OverrideSymbol("swap_object", "swap_buling_banshou", "swap_buling_banshou")
		owner.AnimState:Show("ARM_carry")
		owner.AnimState:Hide("ARM_normal")
	end
	local function onunequip(inst, owner)
	local doer = owner
		owner.AnimState:Hide("ARM_carry")
		owner.AnimState:Show("ARM_normal")
	end
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)
	
    inst.AnimState:SetBank("buling_banshou")
    inst.AnimState:SetBuild("buling_banshou")
	inst.AnimState:PlayAnimation("idle")
	
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_banshou"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_banshou.xml"
    inst:AddComponent("equippable")
	inst.components.equippable:SetOnEquip( onequip )
	inst.components.equippable:SetOnUnequip( onunequip )
    inst:AddComponent("inspectable")
	inst:AddComponent("spellcaster")
    inst.components.spellcaster.canuseontargets = true
    inst.components.spellcaster.canusefrominventory = false
if inst.components.spellcaster.SetSpellTestFn then
        inst.components.spellcaster:SetSpellTestFn(candestroy)
    elseif inst.components.spellcaster.SetCanCastFn then
        inst.components.spellcaster:SetCanCastFn(candestroy)
    else
        inst.components.spellcaster.canCastFn = candestroy
    end
    inst.components.spellcaster:SetSpellFn(spawnbanshou)
    inst.components.spellcaster.castingstate = "castspell_tornado"
    inst.components.spellcaster.actiontype = "SCIENCE"
	return inst
end
local function forcefield()--防水立场
    local function onequip(inst, owner, from_inventory)
	local doer = owner
		print("装备力场")
		inst.components.waterproofer:SetEffectiveness(1)
		inst.fx = SpawnPrefab("forcefieldfx")
		inst.fx.entity:SetParent(owner.entity)
		inst.fx.Transform:SetPosition(0, 0.2, 0)
		inst.fx.AnimState:SetMultColour(0/255,0/255,255/255,1)
		local fx_hitanim = function()
			inst.fx.AnimState:PlayAnimation("hit")
			inst.fx.AnimState:PushAnimation("idle_loop")
		end
		owner:AddTag("venting")
		inst.components.beerpower:StartPerishing()
	end
	local function onunequip(inst, owner)
	local doer = owner
		print("脱下力场")
		inst.components.waterproofer:SetEffectiveness(0)
		if inst.fx then
			inst.fx:Remove()
			inst.fx = nil
		end
		local owner = (doer or inst)
		if owner:HasTag("venting") then
			owner:RemoveTag("venting")
		end
		inst.components.beerpower:StopPerishing()
	end
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)
	
    inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
	inst.AnimState:PlayAnimation("buling_waterproof_field")
	inst:AddTag("venting")
	inst:AddTag("buling_gun_dianchi")
	inst:AddTag("buling_lingjian")
	inst:AddTag("fogproof")
	inst:AddComponent("waterproofer")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_waterproof_field"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_waterproof_field.xml"
	inst:AddComponent("beerpower")
	inst.components.beerpower:SetNumber(432,1,1)
    inst:AddComponent("equippable")
	inst.components.equippable:SetOnEquip( onequip )
	inst.components.equippable:SetOnUnequip( onunequip )
	inst.components.equippable.insulated = true
	inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
	inst.components.equippable.dapperness = TUNING.DAPPERNESS_SMALL
    inst:AddComponent("inspectable")
	inst:ListenForEvent("buling_brownout",function()
		inst:DoTaskInTime(0.1,function()
			onunequip(inst)
		end)
	end)
	return inst
end
local function diandonggao()
	local function onfinished(inst)
		if inst.components.equippable then
            local owner = inst.components.equippable and inst.components.equippable.equippedto
		local target = (owner or inst)
		local item = (target.components and target.components.inventory and target.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS))
            if inst == item then
                target.components.inventory:GiveItem(item)
            end
            inst:RemoveComponent("equippable")
        end
	end 
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)
	
    inst.AnimState:SetBank("buling_tool")
    inst.AnimState:SetBuild("buling_tool")
	inst.AnimState:PlayAnimation("gaozi")
	
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_diandonggao"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_diandonggao.xml"
	inst:AddTag("beerpowertool")
    --inst:AddTag("sees_hiddendanger")
	inst.buling_name = "swap_beerpickaxe"
	inst.symbol = "swap_beerpickaxe"
	
	inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(120)
	inst.components.finiteuses:SetUses(1)
	inst.repair = repair
	inst.repair(inst,inst.buling_name,inst.symbol)
	inst.components.finiteuses:SetOnFinished(onfinished)
	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(15)
    inst:AddComponent("inspectable")
	inst:AddComponent("tool")
	inst.components.tool:SetAction(ACTIONS.MINE,1)
	inst.components.finiteuses:SetConsumption(ACTIONS.MINE, 1)
	
	return inst
end
local function jiandao(Sim)
	local function onfinished(inst)
		if inst.components.equippable then
            local owner = inst.components.equippable and inst.components.equippable.equippedto
		local target = (owner or inst)
		local item = (target.components and target.components.inventory and target.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS))
            if inst == item then
                target.components.inventory:GiveItem(item)
            end
            inst:RemoveComponent("equippable")
        end
	end

	local function onequip(inst, owner, from_inventory)
	local doer = owner 
		owner.AnimState:OverrideSymbol("swap_object", "swap_buling_shears", "swap_shears")
		owner.AnimState:Show("ARM_carry")
		owner.AnimState:Hide("ARM_normal")
	end

	local function onunequip(inst, owner)
	local doer = owner
		owner.AnimState:Hide("ARM_carry")
		owner.AnimState:Show("ARM_normal")
	end
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)
    
    anim:SetBank("buling_tool")
    anim:SetBuild("buling_tool")
    anim:PlayAnimation("jiandao")

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(TUNING.SHEARS_DAMAGE)
    inst:AddTag("shears")
	inst:AddTag("beerpowertool")
    ---------------------------------------------------------------
    inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.SHEAR or ACTIONS.DIG, 2)
    ---------------------------------------------------------------
	inst.buling_name = "swap_buling_shears"
	inst.symbol = "swap_shears"
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(120)
    inst.components.finiteuses:SetUses(1)
    inst.repair = repair
	inst.repair(inst,inst.buling_name,inst.symbol)
    inst.components.finiteuses:SetOnFinished( onfinished )
    inst.components.finiteuses:SetConsumption(ACTIONS.SHEAR or ACTIONS.DIG, 1)
    ---------------------------------------------------------------

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
	--[[inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip ) ]]

    inst.components.inventoryitem.imagename = "buling_diandongjian"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_diandongjian.xml"
    return inst
end
local function boxitem(Sim)
	local function ondeploy(inst, pt, deployer)
		inst:Remove()
		SpawnPrefab(inst.boxname).Transform:SetPosition(pt.x, pt.y, pt.z)      
	end
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
    inst.AnimState:PlayAnimation("zhuangzhi")
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "buling_zhuangzhi"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_zhuangzhi.xml"
	inst:AddTag("eyeturret")
	inst:AddComponent("stackable")
        inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = ondeploy
    if DEPLOYMODE and DEPLOYMODE.ANY then
        inst.components.deployable:SetDeployMode(DEPLOYMODE.ANY)
    end
    if DEPLOYSPACING and DEPLOYSPACING.LESS then
        inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.LESS)
    end
	inst.Transform:SetScale(.5, .5, .5)
    return inst
end
local function rongluitemfn(inst, doer)
    local inst = boxitem(inst)
	inst.boxname = "buling_ronglu"
	inst.components.deployable.placer = "buling_ronglu_placer"
	inst.components.inventoryitem.imagename = "buling_ronglu"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_ronglu.xml"
    return inst
end
local function buling_diandengitemfn(inst, doer)
    local inst = boxitem(inst)
	inst.boxname = "buling_diandeng"
	inst.components.inventoryitem.imagename = "buling_diandeng"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_diandeng.xml"
    return inst
end
local function buling_car_logitemfn(inst, doer)
    local inst = boxitem(inst)
	inst.boxname = "buling_car_log"
	inst.AnimState:SetBank("buling_car")
	inst.AnimState:SetBuild("buling_car")
	inst.AnimState:PlayAnimation("idle")
	inst.components.inventoryitem.imagename = "buling_car_log"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_car_log.xml"
    return inst
end
local function buling_shengcun_itemfn(inst, doer)
    local inst = boxitem(inst)
	inst.boxname = "buling_shengcun"
	inst.components.inventoryitem.imagename = "buling_shengcun"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_shengcun.xml"
    return inst
end
local function buling_zhongjiqi_itemfn(inst, doer)
    local inst = boxitem(inst)
	inst.boxname = "buling_zhongjiqi"
	inst.components.inventoryitem.imagename = "buling_zhongjiqi"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_zhongjiqi.xml"
    return inst
end
local function buling_dianxiangan_itemfn(inst, doer)
    local inst = boxitem(inst)
	inst.boxname = "buling_dianxiangan"
	inst.components.inventoryitem.imagename = "buling_dianxiangan"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_dianxiangan.xml"
    return inst
end
local function buling_seedbox_itemfn(inst, doer)
    local inst = boxitem(inst)
	inst.boxname = "buling_seedbox"
	inst.components.inventoryitem.imagename = "buling_seedbox"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_seedbox.xml"
    return inst
end
local function buling_weaponchest_itemfn(inst, doer)
    local inst = boxitem(inst)
	inst.components.inventoryitem.imagename = "buling_seedchest"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_seedchest.xml"
	inst.boxname = "buling_weaponchest"
    return inst
end
local function buling_solarenergy_itemfn(inst, doer)
    local inst = boxitem(inst)
	inst.boxname = "buling_solarenergy"
	inst.components.inventoryitem.imagename = "buling_taiyangneng"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_taiyangneng.xml"
    return inst
end
local function buling_paotai_itemfn(inst, doer)
    local inst = boxitem(inst)
	inst.boxname = "buling_paotai"
	inst.components.inventoryitem.imagename = "buling_paotai"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_paotai.xml"
    return inst
end
local function buling_cropbox_itemfn(inst, doer)
    local inst = boxitem(inst)
	inst.boxname = "buling_cropbox"
	inst.components.inventoryitem.imagename = "buling_shouge"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_shouge.xml"
    return inst
end
local function buling_chongdianqi_itemfn(inst, doer)
    local inst = boxitem(inst)
	inst.boxname = "buling_chongdianqi"
	inst.components.inventoryitem.imagename = "buling_chongdian"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_chongdian.xml"
    return inst
end
local function buling_chest_itemfn(inst, doer)
    local inst = boxitem(inst)
	inst.components.deployable.placer = "buling_chest_placer"
	inst.components.inventoryitem.imagename = "buling_chest"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_chest.xml"
	inst.boxname = "buling_chest"
    return inst
end
local function buling_planttablet_itemfn(inst, doer)
    local inst = boxitem(inst)
	inst.components.deployable.placer = "buling_planttable_placer"
	inst.components.inventoryitem.imagename = "buling_planttable"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_planttable.xml"
	inst.boxname = "buling_planttable"
    return inst
end
local function buling_cooktable_itemfn(inst, doer)
    local inst = boxitem(inst)
	inst.components.deployable.placer = "buling_cooktable_placer"
	inst.components.inventoryitem.imagename = "buling_cooktable"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_cooktable.xml"
	inst.boxname = "buling_cooktable"
    return inst
end
local function buling_huosai_itemfn(inst, doer)
    local inst = boxitem(inst)
	inst.components.inventoryitem.imagename = "buling_huosai"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_huosai.xml"
	inst.boxname = "buling_huosai"
    return inst
end
local function buling_tongxuntai_itemfn(inst, doer)
    local inst = boxitem(inst)
	inst.components.inventoryitem.imagename = "buling_leida"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_leida.xml"
	inst.boxname = "buling_tongxuntai"
    return inst
end
local function buling_wakuang_itemfn(inst, doer)
    local inst = boxitem(inst)
	inst.components.deployable.placer = "buling_wakuang_placer"
	inst.components.deployable.test = test_deploy
	inst.components.inventoryitem.imagename = "buling_wakuang"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_wakuang.xml"
	inst.boxname = "buling_wakuang"
    return inst
end
local function buling_zhongjiqi_gaoya_itemfn(inst, doer)
    local inst = boxitem(inst)
	inst.components.inventoryitem.imagename = "buling_zhongjiqi_gaoya"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_zhongjiqi_gaoya.xml"
	inst.boxname = "buling_zhongjiqi_gaoya"
    return inst
end
local function buling_bileizhen_itemfn(inst, doer)
    local inst = boxitem(inst)
	inst.components.inventoryitem.imagename = "buling_bileizhen"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_bileizhen.xml"
	inst.boxname = "buling_bileizhen"
    return inst
end
local function buling_lamp_itemfn(inst, doer)
    local inst = boxitem(inst)
	inst.components.inventoryitem.imagename = "buling_lamp"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_lamp.xml"
	inst.boxname = "buling_lamp"
    return inst
end
local function buling_fensui_itemfn(inst, doer)
    local inst = boxitem(inst)
	inst.components.inventoryitem.imagename = "buling_fensui"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_fensui.xml"
	inst.boxname = "buling_fensui"
    return inst
end
local function buling_repair_box_itemfn(inst, doer)
    local inst = boxitem(inst)
	inst.components.inventoryitem.imagename = "buling_paotai_up"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_paotai_up.xml"
	inst.boxname = "buling_repair_box"
    return inst
end
local function buling_chemistrytable_itemfn(inst, doer)
    local inst = boxitem(inst)
	inst.components.inventoryitem.imagename = "buling_chemistrytable"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_chemistrytable.xml"
	inst.boxname = "buling_chemistrytable"
    return inst
end

local function buling_fengrenji_itemfn(inst, doer)
    local inst = boxitem(inst)
	inst.components.inventoryitem.imagename = "buling_fengrenji"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_fengrenji.xml"
	inst.boxname = "buling_fengrenji"
	inst.components.deployable.placer = "buling_fengrenji_placer"
    return inst
end
local function buling_infinitebox_itemfn(inst, doer)
    local inst = boxitem(inst)
	inst.components.inventoryitem.imagename = "buling_infinitebox"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_infinitebox.xml"
	inst.boxname = "buling_infinitebox"
    return inst
end
--
local function buling_chuansongdai_itemfn(inst, doer)
	local function quantizeposition(pt)
		local retval = Vector3(math.floor(pt.x)+.5, 0, math.floor(pt.z)+.5)
		return retval
	end 
    local inst = boxitem(inst)
	--inst:AddTag("wallbuilder")
	inst.components.deployable.min_spacing = 0
	inst.components.deployable.deploydistance = 2
	inst.components.deployable.placer = "buling_chuansongdai_placer"
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
	inst.components.inventoryitem.imagename = "buling_chuansongdai_item"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_chuansongdai_item.xml"
	inst.boxname = "buling_chuansongdai"
	inst.components.deployable:SetQuantizeFunction(quantizeposition)
    return inst
end
local function buling_chuansongdai_8(inst, doer)
	local inst=commonfn(inst)
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_chuansongdai_item"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_chuansongdai_item.xml"
	inst.components.inventoryitem:SetOnPickupFn(function()
		inst:DoTaskInTime(0.1,function()
			inst:Remove()
			for k=1,8 do
				local _target = doer or inst
				_target.components.inventory:GiveItem(SpawnPrefab("buling_chuansongdai_item"))
			end
		end)
	end)
	return inst
end
local function buling_jixiebi_itemfn(inst, doer)
	local inst = buling_chuansongdai_itemfn(inst)
	inst.components.inventoryitem.imagename = "buling_jixiebi_item"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_jixiebi_item.xml"
	inst.boxname = "buling_jixiebi"
	return inst
end
local function ronglu2itemfn(inst, doer)
    local inst = buling_chuansongdai_itemfn(inst)
	inst.boxname = "buling_ronglu2"
	inst.components.deployable.placer = "buling_shuipei_placer"
	inst.components.inventoryitem.imagename = "buling_ronglu2"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_ronglu2.xml"
    return inst
end
local function buling_shuipei_itemfn(inst, doer)
	local inst = buling_chuansongdai_itemfn(inst)
	inst.components.deployable.placer = "buling_shuipei_placer"
	inst.components.inventoryitem.imagename = "buling_shuipei_item"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_shuipei_item.xml"
	inst.boxname = "buling_shuipei"
	return inst
end
local function buling_zidonghecheng_itemfn(inst, doer)
	local inst = buling_chuansongdai_itemfn(inst)
	inst.components.inventoryitem.imagename = "buling_zidonghecheng_item"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_zidonghecheng_item.xml"
	inst.components.deployable.placer = "buling_shuipei_placer"
	inst.boxname = "buling_zidonghecheng"
	return inst
end
local function buling_chest_mini_itemfn(inst, doer)
	local inst = buling_chuansongdai_itemfn(inst)
	inst.components.inventoryitem.imagename = "buling_chest_mini_item"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_chest_mini_item.xml"
	inst.components.deployable.placer = "buling_shuipei_placer"
	inst.boxname = "buling_chest_mini"
	return inst
end
local function buling_pilianghecheng_itemfn(inst, doer)
	local inst = boxitem(inst)
	inst.components.inventoryitem.imagename = "buling_pilianghecheng_item"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_pilianghecheng_item.xml"
	inst.boxname = "buling_pilianghecheng"
	return inst
end
local function buling_yanjiutai_itemfn(inst, doer)
	local inst = boxitem(inst)
	inst.components.inventoryitem.imagename = "buling_yanjiutai"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_yanjiutai.xml"
	inst.boxname = "buling_yanjiutai"
	return inst
end
--
local function buling_cook_kaopan(inst, doer)
	local inst=commonfn(inst)
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
    inst.AnimState:PlayAnimation("kaopan")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_cook_kaopan"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_cook_kaopan.xml"
	inst:AddComponent("tradable")
	inst.Transform:SetScale(2, 2, 2)
	inst:AddTag("buling_cook_tool")
	return inst
end
local function buling_cook_caidao(inst, doer)
	local function OnGetItemFromPlayer(inst, doer, giver, item)
		if cooking.ingredients[item.prefab] and (cooking.ingredients[item.prefab].tags.egg or cooking.ingredients[item.prefab].tags.dairy) then
			giver.components.inventory:GiveItem(SpawnPrefab("buling_cream"))
		elseif item.components.edible and item.components.edible.foodtype == "VEGGIE" then
			for k = 1,math.random(1,2) do
				giver.components.inventory:GiveItem(SpawnPrefab("buling_shucaisui"))
			end
		end
	end
	local inst=commonfn(inst)
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
    inst.AnimState:PlayAnimation("caidao")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_cook_caidao"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_cook_caidao.xml"
	inst:AddComponent("tradable")
	inst:AddTag("buling_cook_tool")
	inst.Transform:SetScale(2, 2, 2)
	inst:AddComponent("trader")
	inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader:SetAcceptTest(function(inst, item)
		local canwokr = false
        if item.components.edible then
			if item.components.edible.foodtype == "VEGGIE" then
				canwokr = true
			end
			if cooking.ingredients[item.prefab] and (cooking.ingredients[item.prefab].tags.egg or cooking.ingredients[item.prefab].tags.dairy) then
				canwokr = true
			end
		end
        return canwokr
    end )
	return inst
end
local function buling_cook_guo(inst, doer)
	local inst=commonfn(inst)
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
    inst.AnimState:PlayAnimation("guo")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_cook_guo"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_cook_guo.xml"
	inst:AddComponent("tradable")
	inst:AddTag("buling_cook_tool")
	inst.Transform:SetScale(2, 2, 2)
	return inst
end
local function buling_cook_jiaobanbo(inst, doer)
	local inst=commonfn(inst)
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
    inst.AnimState:PlayAnimation("jiaobanbo")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_cook_jiaobanbo"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_cook_jiaobanbo.xml"
	inst:AddComponent("tradable")
	inst:AddTag("buling_cook_tool")
	inst.Transform:SetScale(2, 2, 2)
	return inst
end
local function buling_cave_build(inst, doer)
	local inst=commonfn(inst)
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
    inst.AnimState:PlayAnimation("zhuangzhi")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_cave_tool"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_cave_tool.xml"
	inst:AddComponent("tradable")
	return inst
end

--枪械部件
local function common_gunfn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst:AddComponent("inspectable")
	inst:AddComponent("inventoryitem")
	inst:AddComponent("tradable")
	inst:AddTag("buling_lingjian")
	inst.AnimState:SetBank("buling_box")
    inst.AnimState:SetBuild("buling_box")
    inst.AnimState:PlayAnimation("qiangxie")
    return inst
end
--手柄
local function buling_gun_shoubing(inst, doer)
	local inst=common_gunfn(inst)
	inst.components.inventoryitem.imagename = "buling_gun_shoubing_nil"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_gun_shoubing_nil.xml"
	inst.range = 15
	inst.cost = 0
	inst:AddTag("buling_gun_shoubing")
	return inst
end
local function buling_gun_shoubing_biaoqiang(inst, doer)
	local inst=buling_gun_shoubing(inst)
	inst.components.inventoryitem.imagename = "buling_gun_shoubing_biaoqiang"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_gun_shoubing_biaoqiang.xml"
	inst.range = 10
	inst.cost = 5
	return inst
end
local function buling_gun_shoubing_juji(inst, doer)
	local inst=buling_gun_shoubing(inst)
	inst.components.inventoryitem.imagename = "buling_gun_shoubing_juji"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_gun_shoubing_juji.xml"
	inst.range = 24
	inst.cost = -5
	return inst
end
--枪管
local function buling_gun_qiangguan(inst, doer)
	local inst=common_gunfn(inst)
	inst.components.inventoryitem.imagename = "buling_gun_qiangguan_nil"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_gun_qiangguan_nil.xml"
	inst:AddTag("buling_gun_qiangguan")
	inst.cost = 10
	inst.buling_damage = 20
	return inst
end
local function buling_gun_qiangguan_ying(inst, doer)
	local inst=common_gunfn(inst)
	inst.components.inventoryitem.imagename = "buling_gun_qiangguan_ying"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_gun_qiangguan_ying.xml"
	inst:AddTag("buling_gun_qiangguan")
	inst.cost = 5
	inst.buling_damage = 10
	return inst
end
local function buling_gun_qiangguan_yang(inst, doer)
	local inst=buling_gun_qiangguan(inst)
	inst.components.inventoryitem.imagename = "buling_gun_qiangguan_yang"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_gun_qiangguan_yang.xml"
	inst.cost = 30
	inst.buling_damage = 49
	return inst
end
--激光引导器
local function buling_gun_jiguang(inst, doer)
	local inst=common_gunfn(inst)
	inst.components.inventoryitem.imagename = "buling_gun_jiguang_nil"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_gun_jiguang_nil.xml"
	inst:AddTag("buling_gun_jiguang")
	return inst
end
local function buling_gun_jiguang_yaoshou(inst, doer)
	local inst=buling_gun_jiguang(inst)
	inst.components.inventoryitem.imagename = "buling_gun_jiguang_yaoshou"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_gun_jiguang_yaoshou.xml"
	inst.gunfn = function(inst,gun,target)
		if not TheWorld.ismastersim then
			SendBulingRPC("do_widget_button", inst.GUID)
			return
		end
		if target.components.health and target.components.health:GetPercent() >= 0.8 then
			local damage = gun.qiangguan.buling_damage
			target.components.combat:GetAttacked(inst,damage*1.25)
		end
	end
	return inst
end
local function buling_gun_jiguang_boli(inst, doer)
	local inst=buling_gun_jiguang(inst)
	inst.components.inventoryitem.imagename = "buling_gun_jiguang_boli"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_gun_jiguang_boli.xml"
	inst.gunfn = function(inst,gun,target)
		local suiji = math.random(1,100)
		if suiji <= 10 and target.components.lootdropper then
			local loots = target.components.lootdropper:GenerateLoot()
			if #loots > 0 then
				target.components.lootdropper:SpawnLootPrefab(loots[math.random(#loots)])
			end
		end
	end
	return inst
end
--电池
local function buling_gun_dianchi(inst, doer)
	local function talkgun(inst, doer)
		local owner = inst.components.inventoryitem and inst.components.inventoryitem.owner
		if owner and owner:HasTag("buling_gun") then
			if owner and owner.PushEvent then owner:PushEvent("notEnergy") end
		end
	end
	local inst=common_gunfn(inst)
	inst.components.inventoryitem.imagename = "buling_gun_dianchi_nil"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_gun_dianchi_nil.xml"
	inst:AddTag("buling_gun_dianchi")
	inst:AddComponent("beerpower")
	inst.components.beerpower:SetNumber(100)
	inst:ListenForEvent("buling_workstop", talkgun)
	return inst
end
local function buling_gun_dianchi_tongliang(inst, doer)
	local inst=buling_gun_dianchi(inst)
	inst.components.inventoryitem.imagename = "buling_gun_dianchi_tongliang"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_gun_dianchi_tongliang.xml"
	inst.components.beerpower:SetNumber(300)
	return inst
end
local function buling_gun_dianchi_taiyang(inst, doer)
	local inst=buling_gun_dianchi(inst)
	inst.components.inventoryitem.imagename = "buling_gun_dianchi_taiyang"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_gun_dianchi_taiyang.xml"
	inst.components.beerpower:SetNumber(200)
	inst:DoPeriodicTask(5,function() 
		if (TheWorld.state and TheWorld.state.isday) and inst.components.beerpower.power < inst.components.beerpower.PowerMax then
			inst.components.beerpower:UpBeer(-5)
		end
	end)
	return inst
end
--
local function buling_chipbox(inst, doer)
	local slotpos = {}
	for y = 4, 0, -1 do
		for x = 0, 4 do
			table.insert(slotpos, Vector3(80*x-80*2, 80*y-80*2,0))
		end
	end
	local widgetbuttoninfo = {
	text = "Close",
	position = Vector3(0, -240, 0),
	fn = function(inst, doer)
		inst.components.container:Close()
	end}
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
	MakeInventoryPhysics(inst)
    inst:AddComponent("inspectable")
	inst.AnimState:SetBank("buling_item")
    inst.AnimState:SetBuild("buling_item")
    inst.AnimState:PlayAnimation("buling_chipbox")
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_chipbox"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_chipbox.xml"
	inst:AddComponent("container")
	inst.components.container:SetNumSlots(#slotpos)
	inst.components.container.widgetslotpos = slotpos
	inst.components.container.widget = { slotpos = inst.components.container.widgetslotpos, animbank = inst.components.container.widgetanimbank or 'ui_chest_3x3', animbuild = inst.components.container.widgetanimbuild or 'ui_chest_3x3', pos = inst.components.container.widgetpos or Vector3(0,200,0), buttoninfo = inst.components.container.widgetbuttoninfo, side_align_tip = 100 }
    inst.components.container.widgetpos = Vector3(-50,200,0)
    inst.components.container.side_align_tip = 100
	inst.components.container.CollectSceneActions = function(self,doer, actions, right)
		return
		--[[local owner = self.inst.components.inventoryitem.owner
		if doer.components.inventory and self.canbeopened and owner and owner.prefab == "buling_infinitebox" then
            table.insert(actions, ACTIONS.RUMMAGE)
        end]]
	end
	inst.components.container.CollectInventoryActions = function(self,doer, actions, right)
		local owner = self.inst.components.inventoryitem.owner
		if doer.components.inventory and self.canbeopened and owner and (owner.prefab == "buling_infinitebox" or owner.prefab == "buling_chipbox" ) then
            table.insert(actions, ACTIONS.RUMMAGE)
        end
	end
	inst.components.container.widgetbuttoninfo = widgetbuttoninfo
	inst.components.container.type = "chipbox"
	return inst
end
--蓝图
local function buling_book_tongxuntai(inst, doer)
	local inst=commonfn(inst) 
	inst.entity:AddDynamicShadow()
	inst.AnimState:SetBank("blueprint")
    inst.AnimState:SetBuild("blueprint")
    inst.AnimState:PlayAnimation("idle")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "blueprint"
    inst.components.inventoryitem.atlasname = "images/inventoryimages.xml"
	inst:AddComponent("tradable")
	inst:AddComponent("teacher")
	inst.recipetouse = "buling_tongxuntai_item"
    --inst.components.teacher.onteach = OnTeach
	inst.components.teacher:SetRecipe(inst.recipetouse)
	return inst
end
local function buling_book_yajin(inst, doer)
	local inst=commonfn(inst) 
	inst.entity:AddDynamicShadow()
	inst.AnimState:SetBank("blueprint")
    inst.AnimState:SetBuild("blueprint")
    inst.AnimState:PlayAnimation("idle")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "blueprint"
    inst.components.inventoryitem.atlasname = "images/inventoryimages.xml"
	inst:AddComponent("tradable")
	inst:AddComponent("teacher")
	inst.recipetouse = "buling_yajin"
    --inst.components.teacher.onteach = OnTeach
	inst.components.teacher:SetRecipe(inst.recipetouse)
	return inst
end
return Prefab("buling_huojian", huojian, assets),--测试用火箭
Prefab("buling_gun_shoubing", buling_gun_shoubing, assets),--手柄原型
Prefab("buling_gun_shoubing_biaoqiang", buling_gun_shoubing_biaoqiang, assets),--标枪手柄
Prefab("buling_gun_shoubing_juji", buling_gun_shoubing_juji, assets),--狙击手柄
Prefab("buling_gun_dianchi", buling_gun_dianchi, assets),--电池原型
Prefab("buling_gun_dianchi_tongliang", buling_gun_dianchi_tongliang, assets),--通量电池
Prefab("buling_gun_dianchi_taiyang", buling_gun_dianchi_taiyang, assets),--太阳能电池
Prefab("buling_gun_qiangguan", buling_gun_qiangguan, assets),--枪管原型
Prefab("buling_gun_qiangguan_ying", buling_gun_qiangguan_ying, assets),--阴极枪管
Prefab("buling_gun_qiangguan_yang", buling_gun_qiangguan_yang, assets),--阳极枪管
Prefab("buling_gun_jiguang", buling_gun_jiguang, assets),--激光引导器原型
Prefab("buling_gun_jiguang_yaoshou", buling_gun_jiguang_yaoshou, assets),--激光引导器-夭寿
Prefab("buling_gun_jiguang_boli", buling_gun_jiguang_boli, assets),--激光引导器-剥离
Prefab("buling_cook_kaopan", buling_cook_kaopan, assets),--烤盘
Prefab("buling_cook_guo", buling_cook_guo, assets),--锅
Prefab("buling_cook_caidao", buling_cook_caidao, assets),--菜刀
Prefab("buling_cave_tool", buling_cave_build, assets),--洞穴挖掘工具
Prefab("buling_cook_jiaobanbo", buling_cook_jiaobanbo, assets),--搅拌钵
Prefab("buling_glass", buling_glass, assets),--不灵玻璃
Prefab("buling_juhemei_alpha", buling_juhemei_alpha, assets),--阿尔法聚合酶
Prefab("buling_juhemei_beta", buling_juhemei_beta, assets),--贝塔聚合酶
Prefab("buling_puleidi", buling_puleidi, assets),--普雷蒂水晶
Prefab("buling_core", buling_core, assets),--高级机器核心
Prefab("buling_puleidi_plank", buling_puleidi_plank, assets),--普雷蒂金属板
Prefab("buling_manure", buling_manure, assets),--不灵肥料
Prefab("buling_wakuang_item", buling_wakuang_itemfn, assets),--挖矿机
Prefab("buling_manure_4", buling_manure_4, assets),--不灵肥料x8
Prefab("buling_manual_item", gongzuotaiitemfn, assets),--不灵工作台-物品
Prefab("buling_jiandao", jiandao, assets),--电动剪刀
Prefab("buling_diandonggao", diandonggao, assets),--电动镐
Prefab("buling_dianlifu", dianlifu, assets),--电动斧
Prefab("buling_banshou", banshou, assets),--扳手
Prefab("buling_fabric", buling_fabric, assets),--纤维布
Prefab("buling_yanjiutai_item", buling_yanjiutai_itemfn, assets),--研究台
Prefab("buling_zhusheqi", buling_zhusheqi, assets),--注射器
Prefab("buling_chipbox", buling_chipbox, assets),--存储芯片
Prefab("buling_yajin", buling_yajin, assets),--铔金
Prefab("buling_yanjiudian", buling_yanjiudian, assets),--研究磁盘
Prefab("buling_book_tongxuntai", buling_book_tongxuntai, assets),--通讯台蓝图
Prefab("buling_book_yajin", buling_book_yajin, assets),--铔金提取蓝图
Prefab("buling_conversion", buling_conversion, assets),--物质转换器
Prefab("buling_waterproof_field", forcefield, assets),--防水立场
Prefab("buling_diandeng_item", buling_diandengitemfn, assets),--不灵电灯-物品  
Prefab("buling_car_log_item", buling_car_logitemfn, assets),--不灵木车-物品  
Prefab("buling_pilianghecheng_item", buling_pilianghecheng_itemfn, assets),--批量合成台
Prefab("buling_huosai_item", buling_huosai_itemfn, assets),--人力发电-物品  
Prefab("buling_chuansongdai_item", buling_chuansongdai_itemfn, assets),--传送带-物品  
Prefab("buling_chuansongdai_8", buling_chuansongdai_8, assets),--传送带-物品  
Prefab("buling_jixiebi_item", buling_jixiebi_itemfn, assets),--机械臂-物品  
Prefab("buling_shuipei_item", buling_shuipei_itemfn, assets),--水培台-物品  
Prefab("buling_lamp_item", buling_lamp_itemfn, assets),--太阳能路灯-物品  
Prefab("buling_chemistrytable_item", buling_chemistrytable_itemfn, assets),--化学台-物品  
Prefab("buling_chest_mini_item", buling_chest_mini_itemfn, assets),--自动化箱子-物品  
Prefab("buling_zidonghecheng_item", buling_zidonghecheng_itemfn, assets),--自动合成台-物品  
Prefab("buling_shengcun_item", buling_shengcun_itemfn, assets),--生存发电机-物品  
Prefab("buling_solarenergy_item", buling_solarenergy_itemfn, assets),--太阳能发电机-物品  
Prefab("buling_zhongjiqi_item", buling_zhongjiqi_itemfn, assets),--电力中继器-物品
Prefab("buling_dianxiangan_item", buling_dianxiangan_itemfn, assets),--电线杆-物品
Prefab("buling_zhongjiqi_gaoya_item", buling_zhongjiqi_gaoya_itemfn, assets),--高压中继器-物品
Prefab("buling_tongxuntai_item", buling_tongxuntai_itemfn, assets),--通讯台-物品
Prefab("buling_bileizhen_item", buling_bileizhen_itemfn, assets),--避雷针发电机-物品
Prefab("buling_seedbox_item", buling_seedbox_itemfn, assets),--种子增值机-物品
Prefab("buling_paotai_item", buling_paotai_itemfn, assets),--不灵炮台-物品
Prefab("buling_infinitebox_item", buling_infinitebox_itemfn, assets),--次元存储装置-物品
Prefab("buling_chongdianqi_item", buling_chongdianqi_itemfn, assets),--充电器-物品
Prefab("buling_cooktable_item", buling_cooktable_itemfn, assets),--料理台-物品
Prefab("buling_fengrenji_item", buling_fengrenji_itemfn, assets),--缝纫机-物品
Prefab("buling_chest_item", buling_chest_itemfn, assets),--不灵箱子-物品
Prefab("buling_repair_box_item", buling_repair_box_itemfn, assets),--载具修理器-物品
Prefab("buling_planttable_item", buling_planttablet_itemfn, assets),--不灵箱子-物品
Prefab("buling_cropbox_item", buling_cropbox_itemfn, assets),--不灵采集者-物品
Prefab("buling_weaponchest_item", buling_weaponchest_itemfn, assets),--武装整备台-物品
Prefab("buling_ronglu2_item", ronglu2itemfn, assets),--不灵萃取器2-物品
Prefab("buling_fensui_item", buling_fensui_itemfn, assets),--粉碎机-物品
Prefab("buling_ronglu_item", rongluitemfn, assets)--不灵萃取器-物品