local function fn(inst)
	if not inst then return end
	inst.MakeSaveTile_pre_buling = inst.MakeSaveTile
	inst.MakeSaveTile = function(self, slotnum)
		local widget = self.MakeSaveTile_pre_buling and self:MakeSaveTile_pre_buling(slotnum)
		if not SaveGameIndex or not SaveGameIndex.data or not SaveGameIndex.data.slots or not SaveGameIndex.data.slots[slotnum] then
			return widget
		end
		
		local mode = SaveGameIndex.data.slots[slotnum].current_mode
		if mode == "stormplanet" and widget and widget.text then
			widget.text:SetString("风暴行星")
		elseif mode == "desertplanet" and widget and widget.text then
			widget.text:SetString("热砂行星")
		elseif mode == "edenplanet" and widget and widget.text then
			widget.text:SetString("伊甸行星")
		elseif mode == "moonplanet" and widget and widget.text then
			widget.text:SetString("月球")
		end
		
		return widget
	end
end

return {fullname = "screens/loadgamescreen", fn = fn}