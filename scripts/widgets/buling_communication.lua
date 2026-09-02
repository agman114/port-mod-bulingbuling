local Screen = require "widgets/screen"
local Button = require "widgets/button"
local AnimButton = require "widgets/animbutton"
local ImageButton = require "widgets/imagebutton"
local Image = require "widgets/image"
local Widget = require "widgets/widget"
local Text = require "widgets/text" 
local TextButton = require "widgets/textbutton" 
local buling_ui_method = require "widgets/buling_ui_method" 
require "util"


buling_communication = Class(Widget, function(self,owner)
	Widget._ctor(self, "buling")
    self.owner = owner
	local _owner = self.owner or ThePlayer
	_owner:ListenForEvent("Openbuling_communication",function()
		self:Open()
	end)
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
		if self.textgf then
			self.textgf:Kill()
			self.textgf = nil
		end
		self:Close()
	end)
	--终端
	self.nyarlathotep = self:AddChild(ImageButton("images/bulingui/buling_kuangjia.xml", "buling_kuangjia.tex"))
	self.nyarlathotep:SetScale(2,2,2)
	self.nyarlathoteptext = self.nyarlathotep:AddChild(Text(BODYTEXTFONT, 20, STRINGS.BULING_TERMINAL or "Terminal"))
	self.nyarlathotep:SetPosition(-180,200, 0)
	self.nyarlathotep:SetOnClick(function()
		if (self.owner or ThePlayer).components.buling_task.tasknum == 16 then
			local _owner = self.owner or ThePlayer
			_owner.components.buling_task.tasknum = 17
		end
		if not self.textgf and (self.owner or ThePlayer).components.buling_task.tasknum >= 17 then
			self.textgf = self:AddChild(require("widgets/buling_ui_method")(self))
			self.textgf.master = self
			self.textgf:nyarlathotep()
		end
	end)
	--商船
	self.ship = self:AddChild(ImageButton("images/bulingui/buling_kuangjia.xml", "buling_kuangjia.tex"))
	self.ship:SetScale(2,2,2)
	self.shiptext = self.ship:AddChild(Text(BODYTEXTFONT, 25,STRINGS.SHIPTEXT))
	self.ship:SetPosition(-180,100, 0)
	self.ship:SetOnClick(function()
		if not self.textgf and (self.owner or ThePlayer).components.buling_task.tasknum >= 30 then
			self.textgf = self:AddChild(require("widgets/buling_ui_method")(self))
			self.textgf.master = self
		end
	end)
	--黑市
	self.blackmarket = self:AddChild(ImageButton("images/bulingui/buling_kuangjia.xml", "buling_kuangjia.tex"))
	self.blackmarket:SetScale(2,2,2)
	self.blackmarkettext = self.blackmarket:AddChild(Text(BODYTEXTFONT, 25,STRINGS.BLACKMARKET))
	self.blackmarket:SetPosition(-180,0, 0)
	self.blackmarket:SetOnClick(function()
		if not self.textgf and (self.owner or ThePlayer).components.buling_task.tasknum >= 30 then
			self.textgf = self:AddChild(require("widgets/buling_ui_method")(self))
			self.textgf.master = self
		end
	end)
	--殖民地
	self.colonies = self:AddChild(ImageButton("images/bulingui/buling_kuangjia.xml", "buling_kuangjia.tex"))
	self.colonies:SetScale(2,2,2)
	self.coloniestext = self.colonies:AddChild(Text(BODYTEXTFONT, 25,STRINGS.COLONIES))
	self.colonies:SetPosition(-180,-100, 0)
	self.colonies:SetOnClick(function()
		if not self.textgf and (self.owner or ThePlayer).components.buling_task.tasknum >= 30 then
			self.textgf = self:AddChild(require("widgets/buling_ui_method")(self))
			self.textgf.master = self
		end
	end)
end)
function buling_communication:OnUpdate(dt)
	if (self.owner or ThePlayer).components.buling_task.tasknum <= 30 then
		self.coloniestext:SetString(STRINGS.NOSIGNAL)
		self.shiptext:SetString(STRINGS.NOSIGNAL)
		self.blackmarkettext:SetString(STRINGS.NOSIGNAL)
	elseif (self.owner or ThePlayer).components.buling_task.tasknum > 30 then
		self.coloniestext:SetString(STRINGS.COLONIES)
		self.shiptext:SetString(STRINGS.SHIPTEXT)
		self.blackmarkettext:SetString(STRINGS.BLACKMARKET)
	end
end
function buling_communication:Open()
	self:Show()
end
function buling_communication:Close()
	self:Hide()
end
function buling_communication:OnControl(control, down)
	if not self.focus then return false end
    for k,v in pairs (self.children) do
        if v.focus and v:OnControl(control, down) then return true end
    end 
	if self.gf then
		return true
	end
    return false
end
return buling_communication