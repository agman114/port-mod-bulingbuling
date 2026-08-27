local Driver = Class(function(self, inst)
	self.inst = inst
	self.vehicle = nil
end)

function Driver:OnSave()
	return {}
end

function Driver:OnLoad(data)
end

return Driver
