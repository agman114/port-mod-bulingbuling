local GLOBAL = _G
local Screen = require "widgets/screen"
local Button = require "widgets/button"
local AnimButton = require "widgets/animbutton"
local ImageButton = require "widgets/imagebutton"
local Image = require "widgets/image"
local Widget = require "widgets/widget"
local Text = require "widgets/text" 
local TextButton = require "widgets/textbutton" 
require "util"


buling_system = Class(Widget, function(self, owner)
	Widget._ctor(self, "buling_system")
    self.owner = owner
	local _owner = self.owner or GLOBAL.ThePlayer
	if _owner then
		_owner:ListenForEvent("OpenBuling_system", function()
			self:Open()
		end)
	end
	self.IsUIShow = false

    self.root = self:AddChild(Widget("ROOT"))
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetPosition(0, 0, 0)
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)

	self.image = self.root:AddChild(Image("images/bulingui/bulingui.xml", "bulingui.tex"))
	self.image:SetPosition(0, 0, 0)

	self.closebutton = self.root:AddChild(ImageButton("images/bulingui/buling_close.xml", "buling_close.tex"))
	self.closebutton:SetPosition(300, 300, 0)
	self.closebutton:SetOnClick(function()
		self:Close()
	end)

	self.txt = self.root:AddChild(Text(BODYTEXTFONT, 22, ""))
	self.txt:SetPosition(0, 20, 0)
	self.txt:SetRegionSize(550, 400)
	self.txt:EnableWordWrap(true)

	self.bulingbutton = self.root:AddChild(ImageButton("images/bulingui/buling_button.xml", "buling_button.tex"))
	self.bulingbutton:SetPosition(20, -220, 0)
	self.bulingbutton:SetOnClick(function()
		local player = self.owner or GLOBAL.ThePlayer
		if player and player.components and player.components.buling_task then
			if player.components.buling_task:Getitem() == nil then
				player.components.buling_task:nexttask()
			else
				local req_item = player.components.buling_task:Getitem()
				local req_count = player.components.buling_task:Getitemnum()
				if player.components.inventory and player.components.inventory:Has(req_item, req_count) then
					player.components.buling_task:itemnexttask()
				elseif player.components.talker then
					player.components.talker:Say("Требуется: " .. tostring(req_item) .. " x" .. tostring(req_count))
				end
			end
		end
		if GLOBAL.SendModRPCToServer and GLOBAL.GetModRPC then
			GLOBAL.SendModRPCToServer(GLOBAL.GetModRPC("BulingBuling", "AdvanceTask"))
		end
		self:UpdateText()
	end)

	self:UpdateText()
	self:StartUpdating()
end)

function buling_system:UpdateText()
	local player = self.owner or GLOBAL.ThePlayer
	local tasknum = 1
	if player and player.components and player.components.buling_task then
		tasknum = player.components.buling_task.tasknum or 1
	end
	local str = STRINGS['TASK'..tasknum]
	if not str or str == "" then
		str = "Все текущие задачи терминала выполнены!"
	end
	if self.txt and self.last_str ~= str then
		self.last_str = str
		self.txt:SetString(str)
	end
end

function buling_system:OnUpdate(dt)
	if self.IsUIShow then
		self:UpdateText()
	end
end

function buling_system:Open()
	self.IsUIShow = true
	self:Show()
	self:UpdateText()
end

function buling_system:Close()
	self.IsUIShow = false
	self:Hide()
end

return buling_system