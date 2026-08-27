local Screen = require "widgets/screen"
local Button = require "widgets/button"
local AnimButton = require "widgets/animbutton"
local ImageButton = require "widgets/imagebutton"
local Image = require "widgets/image"
local Widget = require "widgets/widget"
local Text = require "widgets/text" 
local TextButton = require "widgets/textbutton" 
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
	--[[self.close = self:AddChild(ImageButton("images/bulingui/buling_img_button.xml", "buling_img_button.tex"))
	self.closetxt = self.close:AddChild(Text(BODYTEXTFONT, 25,"断开连接"))
	self.close:SetPosition(0,150, 0)
	self.close:SetOnClick(function()
		self:Close()
	end)]]
	self.txt = self:AddChild(Text(BODYTEXTFONT, 18,""))
	self.txt:SetPosition(-40, -220, 0)
	self.txt:SetHAlign(ANCHOR_LEFT)
	self.continue = self:AddChild(ImageButton("images/bulingui/buling_img_button.xml", "buling_img_button.tex"))
	self.continuetxt = self.continue:AddChild(Text(BODYTEXTFONT, 25," 》》》"))
	self.continue:SetPosition(220,-250, 0)
	self.continue:SetOnClick(function()
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
function buling_ui_method:OnUpdate(dt)
	local num = (self.owner or ThePlayer).components.buling_task.tasknum 
	if self.chat == "nyarlathotep" then
		self.txt:SetString(STRINGS['TASK'..(self.owner or ThePlayer).components.buling_task.tasknum])
	else
		self.txt:SetString(STRINGS['TASK'..(self.owner or ThePlayer).components.buling_task.tasknum])
	end
end
function buling_ui_method:nyarlathotep()
	self.chat = "nyarlathotep"
	--[[self.name = self:AddChild(Text(BODYTEXTFONT, 20,"Nyarlathotep"))
	self.name:SetPosition(-180, -170, 0)]]
end
function buling_ui_method:Close()
	self.master.textgf = nil
	self:Kill()
end
return buling_ui_method