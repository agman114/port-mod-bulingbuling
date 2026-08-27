
local Beerpower = Class(function(self, inst)
	self.inst = inst
	self.power = 0--电力
	self.PowerMax=0--电力上限
	self.rate = 5--耗电速度
	self.work = false
	self.updatetask = nil
	self.workfn = nil
	self.duandianguanji = true
	self.beer = 0 --贝尔值
end)

--数字变动
function Beerpower:UpBeer(number)
	self.power = self.power - number
	if self.power < 0 then 
		self.power = 0
		self.work = false
		if self.inst and self.inst.PushEvent then self.inst:PushEvent("buling_brownout") end
		if self.inst and self.inst.PushEvent then self.inst:PushEvent("buling_workstop") end
		if self.duandianguanji == true then
			self:StopPerishing()
		end
	end
	if self.power > self.PowerMax then
		self.power = self.PowerMax
	end
	if self.inst and self.inst.PushEvent then self.inst:PushEvent("beerupdate", {percent = self:GetPercent()}) end    
end

function Beerpower:Setworkfn(fn)
    self.workfn = fn
end

function Beerpower:SetNumber(PowerMax,rate,power)
    self.PowerMax = PowerMax or 0
	self.rate = rate or 0
	self.power = power or 0
end

--自动消耗
function Beerpower:StartPerishing()
	if self.inst and self.inst.PushEvent then self.inst:PushEvent("buling_workstart") end
	if self.work == false then
		self.work = true
	end
	if self.updatetask then
		self.updatetask:Cancel()
		self.updatetask = nil
	end
    self.updatetask = self.inst:DoPeriodicTask(5, function()
		self:UpBeer(self.rate)
	end)
	if self.power < self.rate and self.duandianguanji == true then
		self:StopPerishing()
	end
end

function Beerpower:StopPerishing()
	if self.inst and self.inst.PushEvent then self.inst:PushEvent("buling_workstop") end
	if self.work == true then
		self.work = false
	end
	if self.updatetask then
		self.updatetask:Cancel()
		self.updatetask = nil
	end
end

function Beerpower:GetPercent()
    if self.PowerMax == 0 then return 0 end
    return self.power / self.PowerMax
end

function Beerpower:zzSave(...)
        local data = {}
        for _, v in ipairs(arg) do
            data[v] = self[v]
        end
        return data
end

function Beerpower:zzLoad(data)
	if not data then return end
	for k, v in pairs(data) do
		self[k] = v or 0
	end
end

function Beerpower:OnSave()
	return self:zzSave('power', 'PowerMax', 'shanbi','beer')
end   
      
function Beerpower:OnLoad(data)
    self:zzLoad(data)
end

return Beerpower