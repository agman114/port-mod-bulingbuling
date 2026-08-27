local Screen = require "widgets/screen"
local Button = require "widgets/button"
local AnimButton = require "widgets/animbutton"
local ImageButton = require "widgets/imagebutton"
local Image = require "widgets/image"
local Widget = require "widgets/widget"
local Text = require "widgets/text" 
local TextButton = require "widgets/textbutton" 
require "util"


buling_system = Class(Widget, function(self,owner)
	Widget._ctor(self, "yanjiu")
    self.owner = owner
	local _owner = self.owner or ThePlayer
	_owner:ListenForEvent("OpenBuling_system",function()
		self:Open()
	end)
	self.IsUIShow =false
    -- SetPause disabled in DST
    self.root = self:AddChild(Widget("ROOT"))
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetPosition(0,0,0)
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
	self.image = self:AddChild(Image("images/bulingui/bulingui.xml", "bulingui.tex"))
	self.image:SetPosition(0, 0, 0)
	self.closebutton = self:AddChild(ImageButton("images/bulingui/buling_close.xml", "buling_close.tex"))
	self.closebutton:SetPosition(300, 300, 0)
	self.closebutton:SetOnClick(
	function ()
		self:Close()
	end)
	self.txt = self:AddChild(Text(BODYTEXTFONT, 25,STRINGS['TASK'..(self.owner or ThePlayer).components.buling_task.tasknum]))
	self.txt:SetPosition(0, 0, 0)
	self.bulingbutton = self:AddChild(ImageButton("images/bulingui/buling_button.xml", "buling_button.tex"))
	self.bulingbutton:SetPosition(20, -220, 0)
	self.bulingbutton:SetOnClick(
	function ()
		if (self.owner or ThePlayer).components.buling_task:Getitem() == nil then
			local _owner = self.owner or ThePlayer
			_owner.components.buling_task:nexttask()
		else
			if (self.owner or ThePlayer).components.inventory:Has((self.owner or ThePlayer).components.buling_task:Getitem(),(self.owner or ThePlayer).components.buling_task:Getitemnum()) then
				local _owner = self.owner or ThePlayer
				_owner.components.buling_task:itemnexttask()
			end
		end
	end)
	self:StartUpdating()
end)
function buling_system:OnUpdate(dt)
	self.txt:SetString(STRINGS['TASK'..(self.owner or ThePlayer).components.buling_task.tasknum])
end
function buling_system:Open()
	self:Show()
end
function buling_system:Close()
	self:Hide()
end
return buling_system