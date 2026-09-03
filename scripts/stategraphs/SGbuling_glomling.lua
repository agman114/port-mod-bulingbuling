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

--感谢班花的sg支援
local events =
{
    --CommonHandlers.OnLocomote(true, false),
    CommonHandlers.OnDeath(),
    CommonHandlers.OnAttack(),
	CommonHandlers.OnAttacked(),
	EventHandler("locomote", function(inst) 
        if not inst.sg:HasStateTag("busy") then
            
            local is_moving = inst.sg:HasStateTag("moving")
            local wants_to_move = inst.components.locomotor:WantsToMoveForward()
            if not inst.sg:HasStateTag("attack") and is_moving ~= wants_to_move then
                if wants_to_move then
                    inst.sg:GoToState("walk_start")
                else
                    inst.sg:GoToState("idle")
                end
            end
        end
    end),
	EventHandler("dismount",
        function(inst)
            if not inst.sg:HasStateTag("dismounting") then
                inst.sg:GoToState("dismount")
            end
        end),
}
local _raw_actionhandlers = {  
(ACTIONS.GOHOME and ActionHandler(ACTIONS.GOHOME, "idle")),
(ACTIONS.DISMOUNT and ActionHandler(ACTIONS.DISMOUNT, "dismount")),
}
local actionhandlers = {}
for _, ah in pairs(_raw_actionhandlers) do if ah and type(ah) == "table" and ah.action then table.insert(actionhandlers, ah) end end
local states =
{
    State{
        name = "idle",
        tags = {"idle", "canrotate"},

        onenter = function(inst)
            if inst.components.locomotor then
                inst.components.locomotor:Stop()
                inst.components.locomotor.wantstomoveforward = false
                inst.components.locomotor.wantstoreachdestination = false
            end
            if inst.Physics then
                inst.Physics:Stop()
                inst.Physics:SetMotorVel(0, 0, 0)
            end
            inst.AnimState:PlayAnimation("idle_loop", true)
        end,
    },
    State{
        name = "attack",
        tags = {"attack", "busy"},

        onenter = function(inst)
            inst.sg.statemem.target = inst.components.combat.target
            inst.components.combat:StartAttack()
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("idle_loop",true)
            if inst.components.combat.target ~= nil and inst.components.combat.target:IsValid() then
                inst:FacePoint(inst.components.combat.target.Transform:GetWorldPosition())
            end
        end,
        timeline =
        {
			TimeEvent(8*FRAMES, function(inst)
            end),
            TimeEvent(10*FRAMES, function(inst)
                inst.sg:RemoveStateTag("abouttoattack")
                inst.components.combat:DoAttack(inst.sg.statemem.target)
            end),
            TimeEvent(20*FRAMES, function(inst) inst.sg:RemoveStateTag("attack") end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },
    State{
        name = "hit",
        onenter = function(inst)
            inst.AnimState:PlayAnimation("idle_loop",true)
            inst.Physics:Stop()            
        end,
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },
	State{
        name = "dismount",
        onenter = function(inst)
            inst.AnimState:PlayAnimation("idle_loop")
            inst.Physics:Stop() 
			local _target = inst or doer
			local pt = (TheInput and TheInput:GetWorldPosition()) or _target:GetPosition()
			if _target.components.driver then _target.components.driver:OnDismount(false, pt) end
        end,
        events=
        {	
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") 
			end ),
        },
    },
    State{
        name = "death",
        tags = {"busy"},

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("idle_loop",true)
            RemovePhysicsColliders(inst)   
			if inst.components.lootdropper then
				inst.components.lootdropper:DropLoot(Vector3(inst.Transform:GetWorldPosition()))  
			end
        end,
        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
					inst:Remove()
                end
            end),
        },
    },
}
CommonStates.AddSimpleWalkStates(states, "idle_loop")
CommonStates.AddSimpleRunStates(states, "idle_loop")

--return StateGraph("fireelemental", states, events, "idle")

return StateGraph("buling_glomling", states, events, "idle",actionhandlers)
