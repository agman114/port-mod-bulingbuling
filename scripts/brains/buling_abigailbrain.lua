require "behaviours/follow"
require "behaviours/wander"


local AbigailBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local MIN_FOLLOW = 0
local MAX_FOLLOW = 8
local MED_FOLLOW = 4
local MAX_WANDER_DIST = 5
local MAX_CHASE_TIME = 6


local function GetFaceTargetFn(inst)
    return inst.components.follower.leader
end

local function KeepFaceTargetFn(inst, target)
    return inst.components.follower.leader == target
end

function AbigailBrain:OnStart()

    local root = PriorityNode(
    {	
		Follow(self.inst, function() return self.inst.components.follower.leader end, MIN_FOLLOW, MED_FOLLOW, MAX_FOLLOW, true),
		ChaseAndAttack(self.inst, MAX_CHASE_TIME),
		
		--FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn),
        Wander(self.inst, function() return Point(ThePlayer.Transform:GetWorldPosition()) end , MAX_WANDER_DIST)        
    }, .5)
        
    self.bt = BT(self.inst, root)
         
end


return AbigailBrain