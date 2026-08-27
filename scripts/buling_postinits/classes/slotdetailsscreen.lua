local function fn(inst)
	if not inst then return end
	inst.BuildMenu_pre_mand = inst.BuildMenu	
	inst.BuildMenu = function(self)
		if self.BuildMenu_pre_mand then
			self:BuildMenu_pre_mand()
		end

		local slotnum = self.saveslot
		if not SaveGameIndex or not SaveGameIndex.data or not SaveGameIndex.data.slots or not SaveGameIndex.data.slots[slotnum] then
			return
		end
		
		local mode = SaveGameIndex.data.slots[slotnum].current_mode
		if mode == "stormplanet" and self.text then
			self.text:SetString("风暴行星")
		elseif mode == "desertplanet" and self.text then
			self.text:SetString("热砂行星")
		elseif mode == "edenplanet" and self.text then
			self.text:SetString("伊甸行星")
		elseif mode == "moonplanet" and self.text then
			self.text:SetString("月球")
		end
	end
end

return {fullname = "screens/slotdetailsscreen", fn = fn}