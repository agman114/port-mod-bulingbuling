local _G = rawget(_G or {}, "GLOBAL") or _G
local rawget = _G.rawget or rawget

if _G.require then
    _G.require("stategraphs/commonstates")
end

local State = rawget(_G, "State")
local EventHandler = rawget(_G, "EventHandler")
local ActionHandler = rawget(_G, "ActionHandler")
local TimeEvent = rawget(_G, "TimeEvent")
local Stategraph = rawget(_G, "Stategraph")
local CommonStates = rawget(_G, "CommonStates")
local CommonHandlers = rawget(_G, "CommonHandlers")

--[[AddStategraphPostInit('wilson', function(sg) 
    sg.events['doattack'] = EventHandler("doattack", function(inst)        
        if not inst.components.health:IsDead() and not inst.sg:HasStateTag("attack") and not inst.sg:HasStateTag("sneeze") then
            local weapon = inst.components.combat and inst.components.combat:GetWeapon()
            if weapon and weapon:HasTag("goggles") then 
                inst.sg:GoToState("goggleattack")                
            elseif weapon and weapon:HasTag("blowdart") then
                inst.sg:GoToState("blowdart")
            elseif weapon and weapon:HasTag("thrown") then
                inst.sg:GoToState("throw")
            elseif weapon and weapon:HasTag("speargun") then 
                inst.sg:GoToState("speargun")
            elseif weapon and weapon:HasTag("blunderbuss") then 
                inst.sg:GoToState("speargun")
			elseif weapon and inst.prefab == "bulingbuling" then
				inst.sg:GoToState("buling_attack")
            else
                inst.sg:GoToState("attack")
            end
        end
    end)
end)]]
--[[AddStategraphActionHandler("wilsonboating", 
	;(ACTIONS.USEDOOR and ActionHandler(ACTIONS.USEDOOR, "usedoor"))
)]]
AddStategraphState("wilson", --玩家sg
	State{
        name = "usedoor",
        tags = {"doing", "canrotate"},
        
        onenter = function(inst)
            inst.sg.statemem.action = inst:GetBufferedAction()
            inst.components.locomotor:Stop()
			if inst.components.driver and inst.components.driver.vehicle then
				inst.boat = inst.components.driver.vehicle:GetSaveRecord()
				inst:PerformBufferedAction()
				inst.sg:GoToState("idle") 
				inst:DoTaskInTime(.1, function()
					if inst.components.driver and inst.components.driver.vehicle then
						inst.components.driver.vehicle:Remove()
					end
				end)
			else
				inst:PerformBufferedAction()
				inst.sg:GoToState("idle")
			end
        end,
    }
)
--[[AddStategraphState("wilson", --玩家sg
State{
        name = "buling_attack",
        tags = {"attack", "notalking", "abouttoattack", "busy"},
        
        onenter = function(inst)

            local weapon = inst.components.combat:GetWeapon()
            if weapon then
                inst.AnimState:PlayAnimation("buling_qiliaozhan")
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
            end
            if inst.components.combat.target then
                inst.components.combat:BattleCry()
                if inst.components.combat.target and inst.components.combat.target:IsValid() then
                    inst:FacePoint(Point(inst.components.combat.target.Transform:GetWorldPosition()))
                end
            end
            inst.sg.statemem.target = inst.components.combat.target
            inst.components.combat:StartAttack()
            inst.components.locomotor:Stop()
            
        end,
        
        timeline=
        {
            TimeEvent(3*FRAMES, function(inst) 
                inst.components.combat:DoAttack(inst.sg.statemem.target) 
                inst.sg:RemoveStateTag("abouttoattack") 

                local weapon = inst.components.combat:GetWeapon()
                if weapon and weapon:HasTag("corkbat") then
                    inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/items/weapon/corkbat_hit")
                end
				local lavafx = SpawnPrefab("buling_fx")
				local tx = {"idle1","idle2","idle3","idle4"}
				local kinds = tx[math.random(#tx)]
				lavafx.AnimState:SetBank("buling_zhanjifx")
				lavafx.AnimState:SetBuild("buling_zhanjifx")
				lavafx.AnimState:PlayAnimation(kinds)
				lavafx.Transform:SetScale(2,2,2)
				lavafx.Transform:SetPosition(inst.Transform:GetWorldPosition())
				lavafx:ListenForEvent("animover", function()
					lavafx:Remove()
				end)
            end),
			TimeEvent(6*FRAMES, function(inst) 
                inst.components.combat:DoAttack(inst.sg.statemem.target) 
                inst.sg:RemoveStateTag("abouttoattack") 

                local weapon = inst.components.combat:GetWeapon()
                if weapon and weapon:HasTag("corkbat") then
                    inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/items/weapon/corkbat_hit")
                end
            end),
            TimeEvent(9*FRAMES, function(inst) 
				inst.sg:RemoveStateTag("busy")
			end),				
            TimeEvent(10*FRAMES, function(inst)
				if not inst.sg.statemem.slow and not inst.sg.statemem.slowweapon then
					inst.sg:RemoveStateTag("attack")
				end
				local lavafx = SpawnPrefab("buling_fx")
				local tx = {"idle1","idle2","idle3","idle4"}
				local kinds = tx[math.random(#tx)]
				lavafx.AnimState:SetBank("buling_zhanjifx")
				lavafx.AnimState:SetBuild("buling_zhanjifx")
				lavafx.AnimState:PlayAnimation(kinds)
				lavafx.Transform:SetScale(2,2,2)
				lavafx.Transform:SetPosition(inst.Transform:GetWorldPosition())
				lavafx:ListenForEvent("animover", function()
					lavafx:Remove()
				end)
            end),

            TimeEvent(14*FRAMES, function(inst)
                if inst.sg.statemem.slowweapon then
                    inst.sg:RemoveStateTag("attack")
                end
            end),

            TimeEvent(15*FRAMES, function(inst)
				if inst.sg.statemem.slow then
					inst.sg:RemoveStateTag("attack")
				end
            end),
            
            
        },
        ontimeout = function(inst)
            inst.sg:RemoveStateTag("attack")
            --inst.sg:AddStateTag("idle")
        end,
        events=
        {
            EventHandler("animqueueover", function(inst)
				if TheInput:IsMouseDown(MOUSEBUTTON_RIGHT) then
					inst.sg:GoToState("buling_attack")
				else
					inst.sg:GoToState("idle")
				end
                
            end ),
        },
    }
)]]
AddStategraphState("wilson", --玩家sg
	State {
        name = "buling_morph",
        tags = {"busy"},
        onenter = function(inst)
			inst.AnimState:AddOverrideBuild("player_living_suit_morph")
			inst.AnimState:OverrideSymbol("SUIT_headbase", "buling_bianshen", "SUIT_headbase")
            inst.components.locomotor:StopMoving()
            inst.AnimState:PlayAnimation("morph_idle")
            inst.AnimState:PushAnimation("morph_complete",false)    
			inst.buling_door = SpawnPrefab("buling_fx")
			inst.buling_door.AnimState:SetBank("buling_morph_door")
			inst.buling_door.AnimState:SetBuild("buling_morph_door")
			inst.buling_door.AnimState:PlayAnimation("idle1",false)
			inst.buling_door.Transform:SetPosition(inst.Transform:GetWorldPosition())
        end,
        
        timeline=
        {
            TimeEvent(0*FRAMES, function(inst) 
                inst.SoundEmitter:PlaySound("dontstarve_DLC003/music/iron_lord")
            end),
            TimeEvent(15*FRAMES, function(inst) 
                inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/crafted/iron_lord/morph")
            end),
            TimeEvent(105*FRAMES, function(inst) 
                if ShakeAllCameras then ShakeAllCameras(CAMERASHAKE.FULL, 0.5, 0.05, 2, inst, 40) end
				local headfur = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
				headfur.buling_morph(headfur,inst,headfur.buling_name)
				inst.AnimState:Hide("beard")
				
            end),
			TimeEvent(117*FRAMES, function(inst) 
                inst.buling_door.AnimState:PlayAnimation("idle2")
				inst.buling_door:DoTaskInTime(1.3,function()
					SpawnPrefab("maxwell_smoke").Transform:SetPosition(inst.buling_door.Transform:GetWorldPosition())
					SpawnPrefab("vortex_cloak_fx").Transform:SetPosition(inst.buling_door.Transform:GetWorldPosition())
					inst.buling_door:Remove()
					inst.buling_door = nil
				end)
            end),
			TimeEvent(125*FRAMES, function(inst) 
				if ShakeAllCameras then ShakeAllCameras(CAMERASHAKE.FULL, 0.5, 0.05, 2, inst, 40) end
                SpawnPrefab("groundpound_fx_hulk").Transform:SetPosition(inst.buling_door.Transform:GetWorldPosition())
            end),
            TimeEvent(152*FRAMES, function(inst) 
                inst.SoundEmitter:PlaySound("dontstarve_DLC003/music/iron_lord_suit", "ironlord_music")
            end),
        },

        
        onexit = function(inst)
			
			--inst:SetStateGraph("SGironlord")
        end,

        events=
        {
            EventHandler("animqueueover", function(inst) 
                inst.sg:GoToState("idle")                                    
            end),
        },         
    }
)