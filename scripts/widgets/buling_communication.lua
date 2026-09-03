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

local function GetPlayerTaskNum(player)
	player = player or (GLOBAL and GLOBAL.ThePlayer)
	if player and player.components and player.components.buling_task then
		return player.components.buling_task.tasknum or 1
	end
	return (player and player._buling_tasknum) or 1
end

buling_communication = Class(Widget, function(self, owner)
	Widget._ctor(self, "buling")
	self.owner = owner
	local _owner = self.owner or GLOBAL.ThePlayer
	if _owner and _owner.ListenForEvent then
		_owner:ListenForEvent("Openbuling_communication", function()
			self:Open()
		end)
	end
	self.root = self:AddChild(Widget("ROOT"))
	self.root:SetVAnchor(ANCHOR_MIDDLE)
	self.root:SetHAnchor(ANCHOR_MIDDLE)
	self.root:SetPosition(0,0,0)
	self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
	self.image = self:AddChild(Image("images/bulingui/bulingui.xml", "bulingui.tex"))
	self.image:SetPosition(0, 0, 0)
	self.closebutton = self:AddChild(ImageButton("images/bulingui/buling_close.xml", "buling_close.tex"))
	self.closebutton:SetPosition(300, 300, 0)
	self.closebutton:SetOnClick(function()
		if self.textgf then
			self.textgf:Kill()
			self.textgf = nil
		end
		self:Close()
	end)

	-- 1. Кнопка: Терминал связи (Terminal)
	self.nyarlathotep = self:AddChild(ImageButton("images/bulingui/buling_kuangjia.xml", "buling_kuangjia.tex"))
	self.nyarlathotep:SetScale(2,2,2)
	self.nyarlathoteptext = self.nyarlathotep:AddChild(Text(BODYTEXTFONT, 20, STRINGS.BULING_TERMINAL or "Terminal"))
	self.nyarlathotep:SetPosition(-180, 200, 0)
	self.nyarlathotep:SetOnClick(function()
		local num = GetPlayerTaskNum(self.owner)
		if num == 16 then
			if GLOBAL.SendModRPCToServer and GLOBAL.GetModRPC then
				GLOBAL.SendModRPCToServer(GLOBAL.GetModRPC("BulingBuling", "AdvanceTask"))
			end
		end
		if self.textgf then
			self.textgf:Kill()
			self.textgf = nil
		end
		self.textgf = self:AddChild(buling_ui_method(self))
		self.textgf.master = self
		self.textgf:nyarlathotep()
		if num < 16 then
			local task_msg = STRINGS['TASK'..num] or ("Задание #" .. num)
			self.textgf.custom_text = "Связь с базой активна!\nТекущая директива: " .. task_msg .. "\n\n(Передача дальнего сигнала откроется на задании 16+)"
		end
	end)

	-- 2. Кнопка: Торговый корабль (Merchant Ship)
	self.ship = self:AddChild(ImageButton("images/bulingui/buling_kuangjia.xml", "buling_kuangjia.tex"))
	self.ship:SetScale(2,2,2)
	self.shiptext = self.ship:AddChild(Text(BODYTEXTFONT, 25, STRINGS.SHIPTEXT or "Торговый корабль"))
	self.ship:SetPosition(-180, 100, 0)
	self.ship:SetOnClick(function()
		local num = GetPlayerTaskNum(self.owner)
		if self.textgf then
			self.textgf:Kill()
			self.textgf = nil
		end
		self.textgf = self:AddChild(buling_ui_method(self))
		self.textgf.master = self
		if num < 30 then
			self.textgf.custom_text = "[Торговый корабль: Нет сигнала]\nПоиск коммерческих частот...\nВ этом квадранте суда не обнаружены.\n(Требуется задание 30+)"
		else
			self.textgf.custom_text = "[Торговый корабль]\nОрбитальный челнок на связи!\nСледите за входящими поставками."
		end
	end)

	-- 3. Кнопка: Чёрный рынок (Black Market)
	self.blackmarket = self:AddChild(ImageButton("images/bulingui/buling_kuangjia.xml", "buling_kuangjia.tex"))
	self.blackmarket:SetScale(2,2,2)
	self.blackmarkettext = self.blackmarket:AddChild(Text(BODYTEXTFONT, 25, STRINGS.BLACKMARKET or "Чёрный рынок"))
	self.blackmarket:SetPosition(-180, 0, 0)
	self.blackmarket:SetOnClick(function()
		local num = GetPlayerTaskNum(self.owner)
		if self.textgf then
			self.textgf:Kill()
			self.textgf = nil
		end
		self.textgf = self:AddChild(buling_ui_method(self))
		self.textgf.master = self
		if num < 30 then
			self.textgf.custom_text = "[Чёрный рынок: Зашифровано]\nЧастота контрабандистов заблокирована.\n(Требуется задание 30+)"
		else
			self.textgf.custom_text = "[Чёрный рынок]\nЗашифрованный сигнал принят.\nКонтрабандисты ведут слежку за сектором."
		end
	end)

	-- 4. Кнопка: Колонии (Colonies)
	self.colonies = self:AddChild(ImageButton("images/bulingui/buling_kuangjia.xml", "buling_kuangjia.tex"))
	self.colonies:SetScale(2,2,2)
	self.coloniestext = self.colonies:AddChild(Text(BODYTEXTFONT, 25, STRINGS.COLONIES or "Колонии"))
	self.colonies:SetPosition(-180, -100, 0)
	self.colonies:SetOnClick(function()
		local num = GetPlayerTaskNum(self.owner)
		if self.textgf then
			self.textgf:Kill()
			self.textgf = nil
		end
		self.textgf = self:AddChild(buling_ui_method(self))
		self.textgf.master = self
		if num < 30 then
			self.textgf.custom_text = "[Колонии: Нет ответа]\nРадиомаяк колоний не отвечает на запросы.\n(Требуется задание 30+)"
		else
			self.textgf.custom_text = "[Колонии: Связь установлена]\nПолучены телеметрические данные от исследователей."
		end
	end)
end)

function buling_communication:OnUpdate(dt)
	local num = GetPlayerTaskNum(self.owner)
	if num <= 30 then
		if self.coloniestext then self.coloniestext:SetString((STRINGS.COLONIES or "Колонии") .. " (Нет сигнала)") end
		if self.shiptext then self.shiptext:SetString((STRINGS.SHIPTEXT or "Корабль") .. " (Нет сигнала)") end
		if self.blackmarkettext then self.blackmarkettext:SetString((STRINGS.BLACKMARKET or "Рынок") .. " (Нет сигнала)") end
	else
		if self.coloniestext then self.coloniestext:SetString(STRINGS.COLONIES or "Колонии") end
		if self.shiptext then self.shiptext:SetString(STRINGS.SHIPTEXT or "Торговый корабль") end
		if self.blackmarkettext then self.blackmarkettext:SetString(STRINGS.BLACKMARKET or "Чёрный рынок") end
	end
end

function buling_communication:Open()
	self:Show()
	if GLOBAL.SendModRPCToServer and GLOBAL.GetModRPC then
		GLOBAL.SendModRPCToServer(GLOBAL.GetModRPC("BulingBuling", "GetTaskNum"))
	end
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
