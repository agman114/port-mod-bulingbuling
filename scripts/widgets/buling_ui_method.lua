local Screen = require "widgets/screen"
local Button = require "widgets/button"
local AnimButton = require "widgets/animbutton"
local ImageButton = require "widgets/imagebutton"
local Image = require "widgets/image"
local Widget = require "widgets/widget"
local Text = require "widgets/text" 
local TextButton = require "widgets/textbutton" 
require "util"

local function GetPlayerTaskNum(player)
	player = player or (GLOBAL and GLOBAL.ThePlayer)
	if player and player.components and player.components.buling_task then
		return player.components.buling_task.tasknum or 1
	end
	return (player and player._buling_tasknum) or 1
end

local buling_ui_method = Class(Widget, function(self, font, size, text)
	Widget._ctor(self, "buling_ui_method")
	self.root = self:AddChild(Widget("ROOT"))
	self.root:SetVAnchor(ANCHOR_MIDDLE)
	self.root:SetHAnchor(ANCHOR_MIDDLE)
	self.root:SetPosition(0,0,0)
	self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
	self.drawing = self:AddChild(Image())
	self.drawing:SetPosition(-130, -70, 0)
	self.bg = self:AddChild(Image("images/bulingui/buling_text.xml", "buling_text.tex"))
	self.bg:SetPosition(0, -205, 0)

	self.close = self:AddChild(ImageButton("images/bulingui/buling_img_button.xml", "buling_img_button.tex"))
	self.closetxt = self.close:AddChild(Text(BODYTEXTFONT, 18, STRINGS.DUANKAILIANJIE or "Закрыть"))
	self.close:SetPosition(220, -170, 0)
	self.close:SetOnClick(function()
		self:Close()
	end)

	self.txt = self:AddChild(Text(BODYTEXTFONT, 18, ""))
	self.txt:SetPosition(-40, -220, 0)
	self.txt:SetHAlign(ANCHOR_LEFT)

	self.continue = self:AddChild(ImageButton("images/bulingui/buling_img_button.xml", "buling_img_button.tex"))
	self.continuetxt = self.continue:AddChild(Text(BODYTEXTFONT, 25, " 》》》"))
	self.continue:SetPosition(220, -250, 0)
	self.continue:SetOnClick(function()
		if GLOBAL.TheWorld and GLOBAL.TheWorld.ismastersim then
			local player = self.owner or GLOBAL.ThePlayer
			if player and player.components and player.components.buling_task then
				if player.components.buling_task:Getitem() == nil then
					player.components.buling_task:nexttask()
				else
					local req_item = player.components.buling_task:Getitem()
					local req_count = player.components.buling_task:Getitemnum()
					if player.components.inventory and player.components.inventory:Has(req_item, req_count) then
						player.components.buling_task:itemnexttask()
					end
				end
			end
		end
		if GLOBAL.SendModRPCToServer and GLOBAL.GetModRPC then
			GLOBAL.SendModRPCToServer(GLOBAL.GetModRPC("BulingBuling", "AdvanceTask"))
		end
	end)
	self:StartUpdating()
end)

function buling_ui_method:OnUpdate(dt)
	local num = GetPlayerTaskNum(self.owner)
	if self.custom_text then
		self.txt:SetString(self.custom_text)
	else
		self.txt:SetString(STRINGS['TASK'..num] or ("Task #" .. num))
	end
end

function buling_ui_method:nyarlathotep()
	self.chat = "nyarlathotep"
end

function buling_ui_method:Close()
	if self.master then
		self.master.textgf = nil
	end
	self:Kill()
end

return buling_ui_method
