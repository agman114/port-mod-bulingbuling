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

--ban动作
local function BeaverActionButton(inst)
	local action_target = FindEntity(inst, 40, function(guy) return inst.components.combat:CanTarget(guy) end)
	return BufferedAction(inst, action_target, ACTIONS.HACK)
end
local function LeftClickPicker(inst, target_ent, pos)
	if inst.components.combat:CanTarget(target_ent) then
		local staff = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        return inst.components.playeractionpicker:SortActionList({ACTIONS.CASTSPELL}, target_ent, staff)
    end
end
local function RightClickPicker(inst, target_ent, pos)
	return {}
end
local function beaveractionstring(inst, action)
	return STRINGS.DAODANHONGZHA
end
--
local function PlayLobSound(inst, sound)
    inst.SoundEmitter:PlaySoundWithParams(sound, {size=1})
end


local _raw_actionhandlers = {
    (ACTIONS.TAKEITEM and ActionHandler(ACTIONS.TAKEITEM, "rocklick")),
    (ACTIONS.PICKUP and ActionHandler(ACTIONS.PICKUP,"rocklick")),
    (ACTIONS.EAT and ActionHandler(ACTIONS.EAT, "eat")),
	(ACTIONS.DISMOUNT and ActionHandler(ACTIONS.DISMOUNT, "dismount")),
	(ACTIONS.CASTSPELL and ActionHandler(ACTIONS.CASTSPELL, "spell")),
}
local actionhandlers = {}
for _, ah in pairs(_raw_actionhandlers) do if ah and type(ah) == "table" and ah.action then table.insert(actionhandlers, ah) end end

local function onattackfn(inst)
   inst.sg:GoToState("attack")
end
local events =
{
    CommonHandlers.OnLocomote(false, true),
    CommonHandlers.OnFreeze(),
    CommonHandlers.OnAttack(),
    --CommonHandlers.OnAttacked(),
    CommonHandlers.OnDeath(),
    CommonHandlers.OnSleep(),
	EventHandler("doattack", onattackfn),
    EventHandler("gotosleep", function(inst) inst.sg:GoToState("sleep") end),
    EventHandler("entershield", function(inst) inst.sg:GoToState("shield_start") end),
    EventHandler("exitshield", function(inst) inst.sg:GoToState("shield_end") end),
	EventHandler("dismount",
        function(inst)
            if not inst.sg:HasStateTag("dismounting") then
                inst.sg:GoToState("dismount")
            end
        end),
	--[[EventHandler("locomote", function(inst)
        local is_attacking = inst.sg:HasStateTag("attack")
        local is_busy = inst.sg:HasStateTag("busy")
        if is_attacking or is_busy then return end
        local is_moving = inst.sg:HasStateTag("moving")
        local should_move = inst.components.locomotor:WantsToMoveForward()

        if is_moving and not should_move then
            local bufferedaction = inst:GetBufferedAction()
            inst.sg:GoToState("walk_stop")
        elseif (not is_moving and should_move) then
            local bufferedaction = inst:GetBufferedAction()
            inst.sg:GoToState("walk_start")
        end 
    end),]]
}

local states =
{

	State{
		name = "idle_tendril",
		tags = {"idle", "canrotate"},

        onenter = function(inst, playanim)
            inst.Physics:Stop()
            if playanim then
                inst.AnimState:PlayAnimation(playanim)
                inst.AnimState:PushAnimation("idle_tendrils")
            else
                inst.AnimState:PlayAnimation("idle_tendrils")
            end
            
        end,

        timeline = 
        {
            TimeEvent(5*FRAMES, function(inst) PlayLobSound(inst, "dontstarve/creatures/rocklobster/idle") end),        
            TimeEvent(20*FRAMES, function(inst) PlayLobSound(inst, "dontstarve/creatures/rocklobster/idle") end),        
        },

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
	},

    State{
        name = "eat",
        tags = {"idle"},

        onenter = function(inst, playanim)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("idle_tendrils")
            PlayLobSound(inst, "dontstarve/creatures/rocklobster/foley")            
        end,

        timeline = 
        {
            TimeEvent(0*FRAMES, function(inst) PlayLobSound(inst, "dontstarve/creatures/rocklobster/foley") end),        
            TimeEvent(8*FRAMES, function(inst) 
                    inst:PerformBufferedAction() 
                    PlayLobSound(inst, "dontstarve/creatures/rocklobster/idle")
                end),
            TimeEvent(20*FRAMES, function(inst) PlayLobSound(inst, "dontstarve/creatures/rocklobster/foley") end),        
        },

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },



   State{
        name = "dismount",
		tags = {"busy"},
        onenter = function(inst)
            inst.AnimState:PlayAnimation("idle_loop")
            inst.Physics:Stop() 
			local _target = inst or doer
			_target.components.driver:OnDismount(false, Vector3(TheInput:GetWorldPosition():Get()))
        end,
        events=
        {	
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") 
			end ),
        },
    },

    State{
        name = "rocklick",
        tags = {"busy"},
        
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("rocklick_pre")
            inst.AnimState:PushAnimation("rocklick_loop")
            inst.AnimState:PushAnimation("rocklick_pst", false)
        end,

        timeline = 
        {
            TimeEvent(5*FRAMES, function(inst) PlayLobSound(inst, "dontstarve/creatures/rocklobster/foley") end),        
            TimeEvent(10*FRAMES, function(inst) PlayLobSound(inst, "dontstarve/creatures/rocklobster/attack") end),
            TimeEvent(20*FRAMES, function(inst) PlayLobSound(inst, "dontstarve/creatures/rocklobster/foley") end),        
            TimeEvent(25*FRAMES, function(inst) inst:PerformBufferedAction() end ),
            TimeEvent(35*FRAMES, function(inst) PlayLobSound(inst, "dontstarve/creatures/rocklobster/foley") end),        
        },
        
        events=
        {
            EventHandler("animqueueover", function(inst) inst.sg:GoToState("idle") end),
        },
    }, 



    State{
        name = "shield_start",
        tags = {"busy", "hiding"},

        onenter = function(inst)
            inst.AnimState:PlayAnimation("hide")
            PlayLobSound(inst, "dontstarve/creatures/rocklobster/foley")
            PlayLobSound(inst, "dontstarve/creatures/rocklobster/hide")
            inst.Physics:Stop()
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("shield") end ),
        },
    },

    State{
        name = "shield",
        tags = {"busy", "hiding","notalking"},

        onenter = function(inst)
            --If taking fire damage, spawn fire effect. 
            --inst.components.health:SetAbsorbAmount(TUNING.ROCKY_ABSORB)
            inst.AnimState:PlayAnimation("hide_loop")
			inst:AddTag("rocky_shield")
			local _target = inst or doer
			if _target and _target.components and _target.components.playercontroller then _target.components.playercontroller.actionbuttonoverride = BeaverActionButton end
			local _target = inst or doer
			if _target and _target.components and _target.components.playeractionpicker then _target.components.playeractionpicker.leftclickoverride = LeftClickPicker end
			local _target = inst or doer
			if _target and _target.components and _target.components.playeractionpicker then _target.components.playeractionpicker.rightclickoverride = RightClickPicker end
			local _target = inst or doer
			_target.ActionStringOverride = beaveractionstring
            --inst.components.health:StartRegen(TUNING.ROCKY_REGEN_AMOUNT, TUNING.ROCKY_REGEN_PERIOD)
			TheCamera:SetDistance(70)
            inst.sg:SetTimeout(3)
        end,

        onexit = function(inst)
            --inst.components.health:SetAbsorbAmount(0)
           -- inst.components.health:StopRegen()
        end,
        
        ontimeout = function(inst)
            inst.sg:GoToState("shield")            

        end,

        timeline = 
        {
            TimeEvent(20*FRAMES, function(inst) PlayLobSound(inst, "dontstarve/creatures/rocklobster/sleep") end),
        },


    },

    State{
        name = "shield_end",
        tags = {"busy", "hiding"},

        onenter = function(inst)
            inst.AnimState:PlayAnimation("unhide")
			inst:RemoveTag("rocky_shield")
            PlayLobSound(inst, "dontstarve/creatures/rocklobster/foley")
			local _target = inst or doer
			if _target and _target.components and _target.components.playercontroller then _target.components.playercontroller.actionbuttonoverride = nil end
			local _target = inst or doer
			if _target and _target.components and _target.components.playeractionpicker then _target.components.playeractionpicker.leftclickoverride = nil end
			local _target = inst or doer
			if _target and _target.components and _target.components.playeractionpicker then _target.components.playeractionpicker.rightclickoverride = nil end
			local _target = inst or doer
			_target.ActionStringOverride = nil
			TheCamera:SetDefault()
        end,

        timeline = 
        {
            TimeEvent(10*FRAMES, function(inst) PlayLobSound(inst, "dontstarve/creatures/rocklobster/foley") end),        
        },

        events=
        {
            EventHandler("animqueueover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },
	State{
        name = "spell",
        tags = {"doing", "busy", "canrotate", "spell"},

        onenter = function(inst)
            inst.AnimState:PlayAnimation("hit_shield")
        end,

        timeline = 
        {	
            TimeEvent(1*FRAMES, function(inst)
				--[[local staff = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
				if staff and staff.components.spellcaster  then
					staff.components.spellcaster:CastSpell()
				end]]
				--(inst or doer):PerformBufferedAction()
				inst:PerformBufferedAction()
			end),
			TimeEvent(60*FRAMES, function(inst)
				inst.sg:GoToState("shield") 
			 end),
        },

    },
	State{
        name = "attack",
        tags = {"attack", "busy"},
        
        onenter = function(inst, target)
            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end
            inst.components.combat:StartAttack()
            inst.AnimState:PlayAnimation("atk")
            inst.sg.statemem.target = target
        end,
		timeline={
			TimeEvent(0*FRAMES, function(inst) PlayLobSound(inst, "dontstarve/creatures/rocklobster/foley") end),        
			TimeEvent(0*FRAMES, function(inst) PlayLobSound(inst, "dontstarve/creatures/rocklobster/attack") end),
			TimeEvent(5*FRAMES, function(inst) PlayLobSound(inst, "dontstarve/creatures/rocklobster/foley") end),        
			TimeEvent(8*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/rocklobster/clawsnap_small") end),
			TimeEvent(12*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/rocklobster/clawsnap_small") end),
			TimeEvent(13*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/rocklobster/attack_whoosh") end),
			TimeEvent(20*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/rocklobster/clawsnap") end),
			TimeEvent(20*FRAMES, function(inst) inst.components.combat:DoAttack()end),
			TimeEvent(25*FRAMES, function(inst) PlayLobSound(inst, "dontstarve/creatures/rocklobster/foley") end),                
			TimeEvent(30*FRAMES, function(inst) PlayLobSound(inst, "dontstarve/creatures/rocklobster/foley") 
				inst.sg:RemoveStateTag("attack")
				inst.sg:RemoveStateTag("busy")
			end),   
		},
        ontimeout = function(inst)
            inst.sg:RemoveStateTag("attack")
            inst.sg:RemoveStateTag("busy")
            --inst.sg:AddStateTag("idle")
        end,
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },
	State{
        name = "death",  
        tags = {"busy"},
        
        onenter = function(inst)
            inst.AnimState:PlayAnimation(anims and anims.death or "death")
            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end
			inst.Physics:ClearCollisionMask()
            inst.components.lootdropper:DropLoot(Vector3(inst.Transform:GetWorldPosition()))
        end,
		timeline = {
			TimeEvent(0*FRAMES, function(inst) 
				PlayLobSound(inst, "dontstarve/creatures/rocklobster/death") 
				PlayLobSound(inst, "dontstarve/creatures/rocklobster/explode") 
			end),
		}
    }
}

CommonStates.AddWalkStates(states,
{
    starttimeline =  {
        TimeEvent(0*FRAMES, function(inst) PlayLobSound(inst, "dontstarve/creatures/rocklobster/foley") end),
    },
	walktimeline = {
        TimeEvent(1*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/rocklobster/footstep") end),
        TimeEvent(8*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/rocklobster/footstep") end),
        TimeEvent(12*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/rocklobster/footstep") end),
        TimeEvent(15*FRAMES, function(inst) PlayLobSound(inst, "dontstarve/creatures/rocklobster/foley") end),        
        TimeEvent(26*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/rocklobster/footstep") end),
        TimeEvent(30*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/rocklobster/footstep") end),
    },
    endtimeline = {
        TimeEvent(0*FRAMES, function(inst) PlayLobSound(inst, "dontstarve/creatures/rocklobster/foley") end),    
    },
})

CommonStates.AddSleepStates(states,
{
    starttimeline = {
        TimeEvent(0*FRAMES, function(inst) PlayLobSound(inst, "dontstarve/creatures/rocklobster/foley") end),        
    },
    sleeptimeline = {
        TimeEvent(0*FRAMES, function(inst) PlayLobSound(inst, "dontstarve/creatures/rocklobster/sleep") end),
        TimeEvent(20*FRAMES, function(inst) PlayLobSound(inst, "dontstarve/creatures/rocklobster/foley") end),        

    },
    endtimeline ={
        TimeEvent(0*FRAMES, function(inst) PlayLobSound(inst, "dontstarve/creatures/rocklobster/foley") end),        
        },
})


local function hitanim(inst)
    if inst:HasTag("hiding") then
        return "hide_hit"
    else
        return "hit"
    end
end

local combatanims =
{
    hit = hitanim,
}

--[[CommonStates.AddCombatStates(states,
{
    attacktimeline = 
    {            
        TimeEvent(0*FRAMES, function(inst) PlayLobSound(inst, "dontstarve/creatures/rocklobster/foley") end),        
        TimeEvent(0*FRAMES, function(inst) PlayLobSound(inst, "dontstarve/creatures/rocklobster/attack") end),
        TimeEvent(5*FRAMES, function(inst) PlayLobSound(inst, "dontstarve/creatures/rocklobster/foley") end),        
        TimeEvent(8*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/rocklobster/clawsnap_small") end),
        TimeEvent(12*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/rocklobster/clawsnap_small") end),
        TimeEvent(13*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/rocklobster/attack_whoosh") end),
        TimeEvent(20*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/rocklobster/clawsnap") end),
        TimeEvent(20*FRAMES, function(inst) inst.components.combat:DoAttack() end),
        TimeEvent(25*FRAMES, function(inst) PlayLobSound(inst, "dontstarve/creatures/rocklobster/foley") end),                
        TimeEvent(30*FRAMES, function(inst) PlayLobSound(inst, "dontstarve/creatures/rocklobster/foley") end),        
    },
    hittimeline = {
        TimeEvent(0*FRAMES, function(inst) PlayLobSound(inst, "dontstarve/creatures/rocklobster/hurt") end),
        TimeEvent(0*FRAMES, function(inst) PlayLobSound(inst, "dontstarve/creatures/rocklobster/foley") end),        
    },
    deathtimeline = {
        TimeEvent(0*FRAMES, function(inst) 
            PlayLobSound(inst, "dontstarve/creatures/rocklobster/death") 
            PlayLobSound(inst, "dontstarve/creatures/rocklobster/explode") 
        end),

        
    },
}, 
combatanims)]]

CommonStates.AddFrozenStates(states)
CommonStates.AddIdle(states, "idle_tendril", nil ,
{
    TimeEvent(5*FRAMES, function(inst) PlayLobSound(inst, "dontstarve/creatures/rocklobster/foley") end),        
    TimeEvent(30*FRAMES, function(inst) PlayLobSound(inst,"dontstarve/creatures/rocklobster/foley") end),                    
})

for _, st in ipairs(states) do
	if st.name == "idle" then
		local orig_onenter = st.onenter
		st.onenter = function(inst, ...)
			if inst.components.locomotor then
				inst.components.locomotor:Stop()
				inst.components.locomotor.wantstomoveforward = false
				inst.components.locomotor.wantstoreachdestination = false
			end
			if inst.Physics then
				inst.Physics:Stop()
				inst.Physics:SetMotorVel(0, 0, 0)
			end
			if orig_onenter then
				return orig_onenter(inst, ...)
			end
		end
		break
	end
end

return StateGraph("rocky", states, events, "idle", actionhandlers)
