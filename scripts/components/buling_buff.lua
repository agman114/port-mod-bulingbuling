local buling_buff = Class(function(self, inst)
    self.inst = inst
	self.interval = 1
	
	self.buff_modifiers_add_timer = {}
	self.buff_modifiers_add = {
		['buling_meiwei'] = function(self) if self.inst.components.sanity then self.inst.components.sanity:DoDelta(.2) end end,
		['buling_kaiwei'] = function(self) if self.inst.components.hunger then self.inst.components.hunger:DoDelta(.2) end end,
		['buling_jiankang'] = function(self) if self.inst.components.health then self.inst.components.health:DoDelta(.2) end end,
		['buling_tishen'] = function(self) if self.inst.components.sanity then self.inst.components.sanity:DoDelta(.5) end end,
		['buling_baofu'] = function(self) if self.inst.components.hunger then self.inst.components.hunger:DoDelta(.5) end end,
		['buling_yangsheng'] = function(self) if self.inst.components.health then self.inst.components.health:DoDelta(.5) end end,
		['buling_chaotishen'] = function(self) if self.inst.components.sanity then self.inst.components.sanity:DoDelta(5) end end,
		['buling_chaobaofu'] = function(self) if self.inst.components.hunger then self.inst.components.hunger:DoDelta(5) end end,
		['buling_chaomeiwei'] = function(self) if self.inst.components.health then self.inst.components.health:DoDelta(4) end end,
		['fulanke'] = function(self)
			if self.inst.components.sanity then self.inst.components.sanity:DoDelta(.2) end
			if self.inst.components.hunger then self.inst.components.hunger:DoDelta(.2) end
			if self.inst.components.health then self.inst.components.health:DoDelta(.2) end
		end,
		['buling_yeshi'] = function(self)
			if self.inst and self.inst.components.playervision then
				if self.buff_modifiers_add_timer['buling_yeshi'] and self.buff_modifiers_add_timer['buling_yeshi'] > 5 then
					self.inst.components.playervision:ForceNightVision(true)
				else
					self.inst.components.playervision:ForceNightVision(false)
				end
			end
		end,
		['buling_xiangjiaowei'] = function(self)
			if self.buff_modifiers_add_timer['buling_xiangjiaowei'] >= 2 and not self.inst:HasTag("monkey") then
				self.inst:AddTag("monkey")
			elseif self.buff_modifiers_add_timer['buling_xiangjiaowei'] < 2 and self.inst:HasTag("monkey") then
				self.inst:RemoveTag("monkey")
			end
		end,
		['buling_huluobosu'] = function(self)
			if self.buff_modifiers_add_timer['buling_huluobosu'] >= 2 and not self.inst:HasTag("bunnyking") then
				self.inst:AddTag("bunnyking")
			elseif self.buff_modifiers_add_timer['buling_huluobosu'] < 2 and self.inst:HasTag("bunnyking") then
				self.inst:RemoveTag("bunnyking")
			end
		end,
		['buling_huangshi'] = function(self)
			if self.buff_modifiers_add_timer['buling_huangshi'] >= 2 and not self.inst:HasTag("pigroyalty") then
				self.inst:AddTag("pigroyalty")
			elseif self.buff_modifiers_add_timer['buling_huangshi'] < 2 and self.inst:HasTag("pigroyalty") then
				self.inst:RemoveTag("pigroyalty")
			end
		end,
		['buling_echou'] = function(self)
			if self.buff_modifiers_add_timer['buling_echou'] >= 2 and not self.inst:HasTag("monster") then
				self.inst:AddTag("monster")
				if self.inst and self.inst.components.leader then
					self.inst.components.leader:RemoveFollowersByTag("pig")
					local x,y,z = self.inst.Transform:GetWorldPosition()
					local range = TUNING.SPIDERHAT_RANGE or 12
					local ents = TheSim:FindEntities(x,y,z, range, {"spider"})
					for k,v in pairs(ents) do
						if (not v.components.health or not v.components.health:IsDead() ) and v.components.follower and not v.components.follower.leader and not self.inst.components.leader:IsFollower(v) and self.inst.components.leader.numfollowers < 10 then
							self.inst.components.leader:AddFollower(v)
						end
					end
				end
			elseif self.buff_modifiers_add_timer['buling_echou'] < 2 and self.inst:HasTag("monster") then
				self.inst:RemoveTag("monster")
				if self.inst.components.leader then
					self.inst.components.leader:RemoveFollowersByTag("pig")
				end
			end
		end,
		['buling_huaxiang'] = function(self)
			if not self.inst.huaxiang then
				self.inst.huaxiang = 0
			else
				self.inst.huaxiang = self.inst.huaxiang + 1
			end
			if self.inst.huaxiang and self.inst.huaxiang >= 20 then
				local butterfly = SpawnPrefab("butterfly")
				if butterfly then
					butterfly.Transform:SetPosition(self.inst.Transform:GetWorldPosition())
				end
			end
		end,
		['buling_guwuxiang'] = function(self)
			if TheWorld and TheWorld.components.birdspawner then
				if self.buff_modifiers_add_timer['buling_guwuxiang'] >= 2 and TheWorld.components.birdspawner.spawntime ~= (TUNING.BIRD_SPAWN_DELAY_FEATHERHAT or 5) then
					TheWorld.components.birdspawner:SetSpawnTimes(TUNING.BIRD_SPAWN_DELAY_FEATHERHAT or 5)
					TheWorld.components.birdspawner:SetMaxBirds(TUNING.BIRD_SPAWN_MAX_FEATHERHAT or 7)
				elseif self.buff_modifiers_add_timer['buling_guwuxiang'] < 2 and TheWorld.components.birdspawner.spawntime ~= (TUNING.BIRD_SPAWN_DELAY or 10) then
					TheWorld.components.birdspawner:SetSpawnTimes(TUNING.BIRD_SPAWN_DELAY or 10)
					TheWorld.components.birdspawner:SetMaxBirds(TUNING.BIRD_SPAWN_MAX or 4)
				end
			end
		end,
		['buling_xinxisu'] = function(self)
			if self.buff_modifiers_add_timer['buling_xinxisu'] >= 2 and not self.inst:HasTag("ant_disguise") then
				self.inst:AddTag("ant_disguise")
			elseif self.buff_modifiers_add_timer['buling_xinxisu'] < 2 and self.inst:HasTag("ant_disguise") then
				self.inst:RemoveTag("ant_disguise")
			end
		end,
	}
	self:Starbuff()
end)

function buling_buff:taskbufffn()
	for k,v in pairs(self.buff_modifiers_add_timer) do
		if self.buff_modifiers_add_timer[k] and self.buff_modifiers_add_timer[k] > 0 then
			self.buff_modifiers_add_timer[k] = self.buff_modifiers_add_timer[k] - self.interval
			if self.buff_modifiers_add[k] ~= nil then self.buff_modifiers_add[k](self) end
		end
	end
end

function buling_buff:Starbuff()
	self.taskbuff = self.inst:DoPeriodicTask(self.interval, function()
		self:taskbufffn()
	end)
end

function buling_buff:Addbulingbuff_Additive(key, timer)
    if timer and key then
        self.buff_modifiers_add_timer[key] = timer
    end
end

function buling_buff:OnSave()
	local data = {}
	data.buff_modifiers_add_timer = self.buff_modifiers_add_timer
	return data
end   
      
function buling_buff:OnLoad(data)
    if data and data.buff_modifiers_add_timer then
    	self.buff_modifiers_add_timer = data.buff_modifiers_add_timer
    end
	self:taskbufffn()
end

return buling_buff