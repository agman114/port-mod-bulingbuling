local Screen = require "widgets/screen"
local Button = require "widgets/button"
local AnimButton = require "widgets/animbutton"
local ImageButton = require "widgets/imagebutton"
local Image = require "widgets/image"
local Widget = require "widgets/widget"
local Text = require "widgets/text" 
local TextButton = require "widgets/textbutton" 
require "util"


NilUi = Class(Screen, function(self,owner)
	Widget._ctor(self, "bulingbuling")
    self.owner = owner
	local _owner = self.owner or ThePlayer
	_owner:ListenForEvent("robotattack",function() self:robotalert()  end)
	local _owner = self.owner or ThePlayer
	_owner:ListenForEvent("buling_drive_car",function() self:car_ui()  end)
	local _owner = self.owner or ThePlayer
	_owner:ListenForEvent("buling_drive_rocky",function() self:rocky_ui()  end)
	local _owner = self.owner or ThePlayer
	_owner:ListenForEvent("buling_getoff",function() self:caruiclose()  end)
	local _owner = self.owner or ThePlayer
	_owner:ListenForEvent("buling_xingzhicai",function() self:caruiclose()  end)
	self:Show() 
end)
function NilUi:robotalert()
	self:Show() 
	print("敌人来袭")
	local text  = STRINGS.DIXI_LOW
	if (self.owner or ThePlayer).components.buling_task.attacktime > 180 then
		text = STRINGS.DIXI_LONG
	end
	self.text1 = self:AddChild(Text(BODYTEXTFONT, 40,text))
	self.text1:SetPosition(Vector3(0, 350, 0))
	local _owner = self.owner or ThePlayer
	_owner:DoTaskInTime(10,function()
		self.text1:Kill()
	end)
end
function NilUi:colorsoutofspacealert()
	self:Show() 
	print("星之彩袭击")
	local text  = STRINGS.XINGZHICAI
	self.text1 = self:AddChild(Text(BODYTEXTFONT, 40,text))
	self.text1:SetPosition(Vector3(0, 350, 0))
	local _owner = self.owner or ThePlayer
	_owner:DoTaskInTime(10,function()
		self.text1:Kill()
	end)
end
function NilUi:car_ui()
	self:Show() 
	self.carui = self:AddChild(ImageButton("images/bulingui/buling_car_box.xml", "buling_car_box.tex"))
	self.carui:SetPosition(Vector3(-600, -300, 0))
	self.carui:SetOnClick(
	function ()
		local car = (self.owner or ThePlayer).components.driver.vehicle
		if car and car.components.container then
			if car.components.container.open then
				car.components.container:Close((self.owner or ThePlayer))
			else
				car.components.container:Open((self.owner or ThePlayer))
			end
		end
	end)
end
function NilUi:rocky_ui()
	self:Show() 
	self.carui = self:AddChild(ImageButton("images/bulingui/buling_rocky.xml", "buling_rocky.tex"))
	self.carui:SetPosition(Vector3(-600, -300, 0))
	self.carui:SetOnClick(
	function ()
		local car = (self.owner or ThePlayer).components.driver.vehicle
		if car and car.prefab == "buling_rocky" and not car:HasTag("cding") then
			car:AddTag("cding")
			if car:HasTag("atk") then
				car.sg:GoToState("shield_start")
				ACTIONS.CASTSPELL.distance = 100
				--car:DoTaskInTime(1,function() car:SetStateGraph("SGbuling_rocky_def") end)
				car:RemoveTag("atk")
				car:AddTag("def")
				car:DoTaskInTime(0.1,function() 
					car.components.inventory:Equip(SpawnPrefab("buling_rocky_staff"))
				end) 
			elseif car:HasTag("def") then
				ACTIONS.CASTSPELL.distance = 20
				--car:SetStateGraph("SGbuling_rocky")
				car:DoTaskInTime(0.1,function() car.sg:GoToState("shield_end") end)
				car:RemoveTag("def")
				car:AddTag("atk")
			end
			
			car:DoTaskInTime(2,function() car:RemoveTag("cding") end)
		end
	end)
end
function NilUi:caruiclose()
	if self.carui then
		self.carui:Kill()
	end
end
return NilUi