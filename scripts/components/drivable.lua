local Drivable = Class(function(self, inst)
	self.inst = inst
	self.driver = nil
	self.sanitydrain = 0
	self.runspeed = 10
	self.runanimation = "sail_loop"
	self.prerunanimation = "sail_pre"
	self.postrunanimation = "sail_pst"
	self.overridebuild = nil
	self.flotsambuild = nil
	self.hitfx = nil
	self.maprevealbonus = 0
	self.candrivefn = nil
	self.OnMounted = nil
	self.creaksound = "dontstarve/boating/rowboat_creak"
end)

function Drivable:OnSave()
	return {}
end

function Drivable:OnLoad(data)
end

return Drivable
