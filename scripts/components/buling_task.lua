local mixtime = 30
local maxtime = 360
local attack = 4800

local function buling_recipes_yanjiutai()
	local Ingredient = GLOBAL.Ingredient
	local RECIPETABS = GLOBAL.RECIPETABS
	local Recipe = GLOBAL.Recipe
	local TECH = GLOBAL.TECH
	
	if RECIPETABS and RECIPETABS.BLTAB and RECIPETABS.YJTAB then
		local buling_yanjiutai = Recipe("buling_yanjiutai", {Ingredient("buling_zhongziding", 8,"images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"),Ingredient("buling_core", 1,"images/inventoryimages/buling_core.xml", "buling_core.tex"),Ingredient("buling_puleidi_plank", 8,"images/inventoryimages/buling_puleidi_plank.xml", "buling_puleidi_plank.tex")}, RECIPETABS.BLTAB,TECH.NONE,nil,"firesuppressor_placer",2)
		buling_yanjiutai.atlas = "images/inventoryimages/buling_yanjiutai.xml"
		buling_yanjiutai.image = "buling_yanjiutai.tex"
		
		local buling_book_tongxuntai = Recipe("buling_book_tongxuntai", {Ingredient("buling_yanjiudian", 10,"images/inventoryimages/buling_yanjiudian.xml", "buling_yanjiudian.tex")}, RECIPETABS.YJTAB,TECH.NONE,nil)
		buling_book_tongxuntai.atlas = "images/inventoryimages.xml"
		buling_book_tongxuntai.image = "blueprint.tex"
		
		local buling_tongxuntai_item = Recipe("buling_tongxuntai_item", {Ingredient("buling_system", 1,"images/inventoryimages/buling_system.xml", "buling_system.tex"),Ingredient("buling_core", 1,"images/inventoryimages/buling_core.xml", "buling_core.tex"),Ingredient("buling_zhongziding",40,"images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex")}, RECIPETABS.BLTAB,{SCIENCE = 10},nil)
		buling_tongxuntai_item.atlas = "images/inventoryimages/buling_leida.xml"
		buling_tongxuntai_item.image = "buling_leida.tex"
	end
end

local function buling_recipes_yanjiutai2()
	local Ingredient = GLOBAL.Ingredient
	local RECIPETABS = GLOBAL.RECIPETABS
	local Recipe = GLOBAL.Recipe
	local TECH = GLOBAL.TECH
	
	if RECIPETABS and RECIPETABS.BLTAB and RECIPETABS.YJTAB then
		local buling_book_yajin = Recipe("buling_book_yajin", {Ingredient("buling_yanjiudian",40,"images/inventoryimages/buling_yanjiudian.xml", "buling_yanjiudian.tex")}, RECIPETABS.YJTAB,TECH.NONE,nil)
		buling_book_yajin.atlas = "images/inventoryimages.xml"
		buling_book_yajin.image = "blueprint.tex"
		
		local buling_yajin = Recipe("buling_yajin", {Ingredient("flint",40)}, RECIPETABS.BLTAB,{SCIENCE = 10},nil)
		buling_yajin.atlas = "images/inventoryimages/buling_yajin.xml"
		buling_yajin.image = "buling_yajin.tex"
	end
end

local taskitemlist = {
[5] = {"buling_zhongziding",1},
[7] = {"buling_planttable_item",1},
[10] = {"buling_zhongjiqi_item",1},
[13] = {"buling_glass",1},
[16] = {"gugugugu",1},
[25] = {"gugugugu",1},
}

local buling_task = Class(function(self, inst, activcb)
    self.inst = inst
	self.monsterday = 0
    self.tasknum = 1
	self.buling_time = 0
	self.targettime = 0
	self.attacktime = 0
	self.taskdixi = self.inst:DoPeriodicTask(1, function()
		self:robotattack()
	end)
end)

function buling_task:Getitem()
	if taskitemlist[self.tasknum] then
		return taskitemlist[self.tasknum][1]
	else
		return nil
	end
end

function buling_task:Getitemnum()
	if taskitemlist[self.tasknum] then
		return taskitemlist[self.tasknum][2]
	else
		return 0
	end
end

function buling_task:LueranRecipe()
	if self.tasknum == 14 then
		buling_recipes_yanjiutai()
		self.inst:DoTaskInTime(0.1, function()
			if self.inst.components.builder then
				self.inst.components.builder:UnlockRecipe("buling_yanjiutai_item")
				self.inst.components.builder:UnlockRecipe("buling_book_tongxuntai")
			end
		end)
	elseif self.tasknum == 20 then
		buling_recipes_yanjiutai2()
		self.inst:DoTaskInTime(0.1, function()
			if self.inst.components.builder then
				self.inst.components.builder:UnlockRecipe("buling_book_yajin")
			end
		end)
	elseif self.tasknum == 21 then
		if inst and inst.PushEvent then inst:PushEvent("buling_xingzhicai") end
	end
end

function buling_task:RecollectRecipe()
	if self.tasknum >= 14 then
		buling_recipes_yanjiutai()
	end
	if self.tasknum >= 20 then
		buling_recipes_yanjiutai2()
	end
end

function buling_task:nexttask()
	self:LueranRecipe()
	if self:Getitem() == nil then
		self.tasknum = self.tasknum + 1
	end
end

function buling_task:robotattack()
	if self.tasknum >= 24 then
		self.buling_time = self.buling_time + 1 
		self.targettime = self.targettime + 1
		if self.targettime > attack then
			if self.attacktime == 0 then
				self.attacktime = math.random(mixtime, maxtime)
			end
			if not self.inst:HasTag("knowattack") then
				if inst and inst.PushEvent then inst:PushEvent("robotattack") end
				self.inst:AddTag("knowattack")
			end
			if self.targettime > attack + self.attacktime then
				self:dixi()
			end
		end
	end
end

function buling_task:dixi()
	self.targettime = 0
	self.attacktime = 0
	if self.inst:HasTag("knowattack") then
		self.inst:RemoveTag("knowattack")
	end
	
	local cycles = TheWorld and TheWorld.state and TheWorld.state.cycles or 0
	if cycles <= 20 then
		local parachute = SpawnPrefab("buling_parachute")
		if parachute then
			local pt = Vector3(self.inst.Transform:GetWorldPosition())
			parachute.Transform:SetPosition(pt.x + math.random(-4, 4), pt.y, pt.z + math.random(-4, 4))
		end
	else
		local firerain = SpawnPrefab("firerain")
		if firerain then
			local pt = Vector3(self.inst.Transform:GetWorldPosition())
			pt.x = pt.x + math.random(-8, 8)
			pt.z = pt.z + math.random(-8, 8)
			firerain.Transform:SetPosition(pt.x, pt.y, pt.z)
			if firerain.StartStep then
				firerain:StartStep()
			end
			local jidi = SpawnPrefab("buling_jidi")
			if jidi then
				jidi.Transform:SetPosition(pt.x, pt.y, pt.z)
				jidi:Hide()
				jidi:DoTaskInTime(1.9, function()
					jidi:Show()
					local pos = Vector3(jidi.Transform:GetWorldPosition())
					local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, 15)
					for k, v in pairs(ents) do
						if v and v.prefab == "lavapool" then
							v:Remove()
						end
					end
				end)
			end
		end
	end
	self.targettime = 0
end

function buling_task:itemnexttask()
	if self:Getitem() ~= nil then
		if self.inst.components.inventory and self.inst.components.inventory:Has(taskitemlist[self.tasknum][1], taskitemlist[self.tasknum][2]) then
			self.tasknum = self.tasknum + 1
		end
	end
end

function buling_task:zzSave(...)
	local data = {}
	for _, v in ipairs({...}) do
		data[v] = self[v]
	end
	return data
end

function buling_task:zzLoad(data)
	if not data then return end
	for k, v in pairs(data) do
		self[k] = v or 0
	end
	self:RecollectRecipe()
end

function buling_task:OnSave()
	return self:zzSave('tasknum', 'monsterday', 'buling_time', 'targettime', 'attacktime')
end   
      
function buling_task:OnLoad(data)
    self:zzLoad(data)
end

return buling_task
