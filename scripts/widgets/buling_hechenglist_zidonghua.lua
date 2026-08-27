local Widget = require "widgets/screen"
local Button = require "widgets/button"
local AnimButton = require "widgets/animbutton"
local ImageButton = require "widgets/imagebutton"
local Image = require "widgets/image"
local Widget = require "widgets/widget"
local Text = require "widgets/text" 
local TextButton = require "widgets/textbutton" 
local UIAnim = require "widgets/uianim"
require "util"

buling_hechenglist = Class(Widget, function(self,owner)
	Widget._ctor(self, "yanjiu")
    self.owner = owner
	self.cailiaobuzu = 0
	self.IsUIShow =false
    -- SetPause disabled in DST
    self.root = self:AddChild(Widget("ROOT"))
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetPosition(0,0,0)
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
	self.page = 1
	self.pagemax = 2
	local _owner = self.owner or ThePlayer
	_owner:ListenForEvent("OpenBuling_jixiejiaognglu",function()
		self:Open()
	end)
	local _owner = self.owner or ThePlayer
	_owner:ListenForEvent("CloseBuling_jixiejiaognglu",function()
		self:Close()
	end)
	--背景
	self.image = self:AddChild(Image("images/globalpanels2.xml", "panel_skinny.tex"))
	--self.image:SetPosition(650, 365, 0)
	self.image:SetPosition(-350, 0, 0)
	self.image2 = self:AddChild(Image("images/globalpanels2.xml", "presetbox.tex"))
	self.image2:SetPosition(350, 0, 0)
	--格子
	self.gezi5 = self.image2:AddChild(Image("images/hud.xml", "inv_slot.tex"))
	self.gezi5:SetPosition(-100, -65, 0)
	self.gezi5:SetScale(0.7, 0.7, 0)
	
	self.gezi1 = self.gezi5:AddChild(Image("images/hud.xml", "inv_slot.tex"))
	self.gezi1:SetPosition(-70, 70, 0)
	--self.gezi1:SetScale(0.7, 0.7, 0)
	
	self.gezi2 = self.gezi5:AddChild(Image("images/hud.xml", "inv_slot.tex"))
	self.gezi2:SetPosition(0, 70, 0)
	--self.gezi2:SetScale(0.7, 0.7, 0)
	
	self.gezi3 = self.gezi5:AddChild(Image("images/hud.xml", "inv_slot.tex"))
	self.gezi3:SetPosition(70, 70, 0)
	--self.gezi3:SetScale(0.7, 0.7, 0)
	
	self.gezi4 = self.gezi5:AddChild(Image("images/hud.xml", "inv_slot.tex"))
	self.gezi4:SetPosition(-70, 0, 0)
	--self.gezi4:SetScale(0.7, 0.7, 0)
	
	self.gezi6 = self.gezi5:AddChild(Image("images/hud.xml", "inv_slot.tex"))
	self.gezi6:SetPosition(70, 0, 0)
	--self.gezi6:SetScale(0.7, 0.7, 0)
	
	self.gezi7 = self.gezi5:AddChild(Image("images/hud.xml", "inv_slot.tex"))
	self.gezi7:SetPosition(-70, -70, 0)
	--self.gezi7:SetScale(0.7, 0.7, 0)
	
	self.gezi8 = self.gezi5:AddChild(Image("images/hud.xml", "inv_slot.tex"))
	self.gezi8:SetPosition(0, -70, 0)
	--self.gezi8:SetScale(0.7, 0.7, 0)
	
	self.gezi9 = self.gezi5:AddChild(Image("images/hud.xml", "inv_slot.tex"))
	self.gezi9:SetPosition(70, -70, 0)
	--self.gezi9:SetScale(0.7, 0.7, 0)
	--关闭
	self.closebutton = self:AddChild(ImageButton())
	--self.closebutton:SetText(STRINGS.DAIMIAO_CLOSE)
	self.closebutton:SetPosition(860, 150, 0)
	self.closebutton:SetOnClick(
	function ()

		self:Close()
	end)
	--翻页
	
	self.jiantou1 = self.image:AddChild(ImageButton("images/bulingui/turnarrow_icon.xml", "turnarrow_icon.tex"))--上一页
	self.jiantou1:SetPosition(-120, -200, 0)
	self.jiantou1:SetOnClick(
	function ()

self.page = self.page - 1
		if self.page < 1 then self.page = 1 end
		self:flip()
	end)
	self.jiantou2 = self.image:AddChild(ImageButton("images/hud.xml", "turnarrow_icon.tex"))--下一页
	self.jiantou2:SetPosition(120, -200, 0)
	self.jiantou2:SetOnClick(
	function ()

self.page = self.page + 1
		if self.page > self.pagemax then self.page = self.pagemax end
		self:flip()
	end)
	self:flip()
end)
function buling_hechenglist:flip()
	self:CK()
	if self.page == 1 then
		self:page1()
	elseif self.page == 2 then
		self:page2()
	end
	if self.page == 1 then
		self.jiantou1:Disable()
		else
		self.jiantou1:Enable()
	end
	if self.page == self.pagemax then
		self.jiantou2:Disable()
		else
		self.jiantou2:Enable()
	end
	self:yajin()
end
function buling_hechenglist:yajin()--机械台专有！前期隐藏铔金物品配方！！！！！！！！！！！！
	if self.page == 1 and (self.owner or ThePlayer).components.buling_task and (self.owner or ThePlayer).components.buling_task.tasknum < 20 then
		self.item11:Hide()
		self.item12:Hide()
		self.item13:Hide()
	elseif self.page == 1 and (self.owner or ThePlayer).components.buling_task and (self.owner or ThePlayer).components.buling_task.tasknum >= 20 then
		self.item11:Show()
		self.item12:Show()
		self.item13:Show()
	end
end
function buling_hechenglist:page1()
	--普雷蒂水晶
	self.item1 = self.image:AddChild(ImageButton("images/inventoryimages/buling_puleidi.xml", "buling_puleidi.tex"))
	self.item1:SetPosition(-120, 190, 0)
	self.item1:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_puleidi")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_puleidi.xml", "buling_puleidi.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 50,STRINGS.NAMES.BULING_PULEIDI))
		self.text1:SetPosition(50, 100, 0)
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_PULEIDI))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
	end)
	--普雷蒂金属板
	self.item2 = self.image:AddChild(ImageButton("images/inventoryimages/buling_puleidi_plank.xml", "buling_puleidi_plank.tex"))
	self.item2:SetPosition(-40, 190, 0)
	self.item2:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_puleidi_plank")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_puleidi_plank.xml", "buling_puleidi_plank.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 50,STRINGS.NAMES.BULING_PULEIDI_PLANK))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_PULEIDI_PLANK))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_puleidi.xml", "buling_puleidi.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_puleidi.xml", "buling_puleidi.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_puleidi.xml", "buling_puleidi.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
	end)
	--高压中继器
	self.item3 = self.image:AddChild(ImageButton("images/inventoryimages/buling_zhongjiqi_gaoya.xml", "buling_zhongjiqi_gaoya.tex"))
	self.item3:SetPosition(40, 190, 0)
	self.item3:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_zhongjiqi_gaoya")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_zhongjiqi_gaoya.xml", "buling_zhongjiqi_gaoya.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 50,STRINGS.NAMES.BULING_ZHONGJIQI_GAOYA))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 25,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_ZHONGJIQI_GAOYA))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_puleidi.xml", "buling_puleidi.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_puleidi.xml", "buling_puleidi.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_zhongjiqi.xml", "buling_zhongjiqi.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_puleidi.xml", "buling_puleidi.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
	end)
	--高级机器核心
	self.item4 = self.image:AddChild(ImageButton("images/inventoryimages/buling_core.xml", "buling_core.tex"))
	self.item4:SetPosition(120, 190, 0)
	self.item4:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_core")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_core.xml", "buling_core.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 50,STRINGS.NAMES.BULING_CORE))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CORE))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_puleidi_plank.xml", "buling_puleidi_plank.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_puleidi_plank.xml", "buling_puleidi_plank.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages/buling_puleidi_plank.xml", "buling_puleidi_plank.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_puleidi_plank.xml", "buling_puleidi_plank.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_puleidi.xml", "buling_puleidi.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_puleidi_plank.xml", "buling_puleidi_plank.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_puleidi_plank.xml", "buling_puleidi_plank.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_puleidi_plank.xml", "buling_puleidi_plank.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages/buling_puleidi_plank.xml", "buling_puleidi_plank.tex"))
	end)
	--避雷针控制模块
	self.item5 = self.image:AddChild(ImageButton("images/inventoryimages/buling_bileizhen.xml", "buling_bileizhen.tex"))
	self.item5:SetPosition(-120, 110, 0)
	self.item5:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_bileizhen")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_bileizhen.xml", "buling_bileizhen.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 40,STRINGS.NAMES.BULING_BILEIZHEN))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_BILEIZHEN))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_zhongjiqi_gaoya.xml", "buling_zhongjiqi_gaoya.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
	end)
	--防水力场
	self.item6 = self.image:AddChild(ImageButton("images/inventoryimages/buling_waterproof_field.xml", "buling_waterproof_field.tex"))
	self.item6:SetPosition(-40, 110, 0)
	self.item6:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_waterproof_field")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_waterproof_field.xml", "buling_waterproof_field.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_WATERPROOF_FIELD))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_WATERPROOF_FIELD))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_diandeng.xml", "buling_diandeng.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages/buling_bileizhen.xml", "buling_bileizhen.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_zhongjiqi.xml", "buling_zhongjiqi.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
	end)
	--木制车车
	self.item7 = self.image:AddChild(ImageButton("images/inventoryimages/buling_car_log.xml", "buling_car_log.tex"))
	self.item7:SetPosition(40, 110, 0)
	self.item7:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_car_log")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_car_log.xml", "buling_car_log.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_CAR_LOG))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CAR_LOG))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages.xml", "boards.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "boards.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages.xml", "boards.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "transistor.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_chest.xml", "buling_chest.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_core.xml", "buling_core.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages.xml", "gears.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages.xml", "boards.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages.xml", "gears.tex"))
	end)
	--物质转换器
	self.item8 = self.image:AddChild(ImageButton("images/inventoryimages/buling_conversion.xml", "buling_conversion.tex"))
	self.item8:SetPosition(120, 110, 0)
	self.item8:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_conversion")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_conversion.xml", "buling_conversion.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 50,STRINGS.NAMES.BULING_CONVERSION))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CONVERSION))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_puleidi_plank.xml", "buling_puleidi_plank.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_puleidi_plank.xml", "buling_puleidi_plank.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_core.xml", "buling_core.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_puleidi_plank.xml", "buling_puleidi_plank.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_puleidi_plank.xml", "buling_puleidi_plank.tex"))
	end)
	--次元存储箱
	self.item9 = self.image:AddChild(ImageButton("images/inventoryimages/buling_infinitebox.xml", "buling_infinitebox.tex"))--未完成
	self.item9:SetPosition(-120, 30, 0)
	self.item9:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_infinitebox")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_infinitebox.xml", "buling_infinitebox.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 50,STRINGS.NAMES.BULING_INFINITEBOX))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 20,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_INFINITEBOX))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_puleidi_plank.xml", "buling_puleidi_plank.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_puleidi_plank.xml", "buling_puleidi_plank.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages/buling_puleidi_plank.xml", "buling_puleidi_plank.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_puleidi_plank.xml", "buling_puleidi_plank.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_conversion.xml", "buling_conversion.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_puleidi_plank.xml", "buling_puleidi_plank.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_puleidi_plank.xml", "buling_puleidi_plank.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_puleidi_plank.xml", "buling_puleidi_plank.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages/buling_puleidi_plank.xml", "buling_puleidi_plank.tex"))
	end)
	--存储芯片
	self.item10 = self.image:AddChild(ImageButton("images/inventoryimages/buling_chipbox.xml", "buling_chipbox.tex"))
	self.item10:SetPosition(-40, 30, 0)
	self.item10:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_chipbox")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_chipbox.xml", "buling_chipbox.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_CHIPBOX))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 20,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CHIPBOX))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_puleidi_plank.xml", "buling_puleidi_plank.tex"))
	end)
	--铔金镐
	self.item11 = self.image:AddChild(ImageButton("images/inventoryimages/buling_yajinggao.xml", "buling_yajinggao.tex"))
	self.item11:SetPosition(40, 30, 0)
	self.item11:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_yajinggao")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_yajinggao.xml", "buling_yajinggao.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_PICKAXE_WEAPON))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 25,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_PICKAXE_WEAPON))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_yajin.xml", "buling_yajin.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_yajin.xml", "buling_yajin.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_diandonggao.xml", "buling_diandonggao.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_yajin.xml", "buling_yajin.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_yajin.xml", "buling_yajin.tex"))
	end)
	--铔金斧
	self.item12 = self.image:AddChild(ImageButton("images/inventoryimages/buling_yajingfu.xml", "buling_yajingfu.tex"))
	self.item12:SetPosition(120, 30, 0)
	self.item12:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_yajingfu")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_yajingfu.xml", "buling_yajingfu.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_AXE_WEAPON))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 25,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_AXE_WEAPON))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_yajin.xml", "buling_yajin.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_yajin.xml", "buling_yajin.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_dianlifu.xml", "buling_dianlifu.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_yajin.xml", "buling_yajin.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_yajin.xml", "buling_yajin.tex"))
	end)
	--铔金剪刀
	self.item13 = self.image:AddChild(ImageButton("images/inventoryimages/buling_yajingjian.xml", "buling_yajingjian.tex"))
	self.item13:SetPosition(-120, -50, 0)
	self.item13:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_yajingjian")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_yajingjian.xml", "buling_yajingjian.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_SHEARS_WEAPON))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 25,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_SHEARS_WEAPON))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_yajin.xml", "buling_yajin.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_yajin.xml", "buling_yajin.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_diandongjian.xml", "buling_diandongjian.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_yajin.xml", "buling_yajin.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_yajin.xml", "buling_yajin.tex"))
	end)
	--速冻厂
	self.item14 = self.image:AddChild(ImageButton("images/inventoryimages/buling_bingkaxianbing.xml", "nil.tex"))--未完成
	self.item14:SetPosition(-40, -50, 0)
	self.item14:SetOnClick(
	function ()

self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_bingkaxianbing.xml", "buling_bingkaxianbing.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_BINGKAXIANBING))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_BINGKAXIANBING))
		self.text2:SetPosition(80, -50, 0)
		
		
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "ratatouille.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kao.xml", "buling_cook_kao.tex"))
	end)
	--昆虫捕捉箱
	self.item15 = self.image:AddChild(ImageButton("images/inventoryimages/buling_kaodigua.xml", "nil.tex"))--未完成
	self.item15:SetPosition(40, -50, 0)
	self.item15:SetOnClick(
	function ()

self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_kaodigua.xml", "buling_kaodigua.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_KAODIGUA))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 25,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_KAODIGUA))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "sweet_potato.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_guo.xml", "buling_cook_guo.tex"))
	end)
	--天琴座治疗器-山寨
	self.item16 = self.image:AddChild(ImageButton("images/inventoryimages/buling_kaolengmian.xml", "nil.tex"))--未完成
	self.item16:SetPosition(120, -50, 0)
	self.item16:SetOnClick(
	function ()

self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_kaolengmian.xml", "buling_kaolengmian.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_KAOLENGMIAN))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_KAOLENGMIAN))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "bird_egg.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kao.xml", "buling_cook_kao.tex"))
	end)
	--标准处理器(生成巨人国矿物)
	self.item17 = self.image:AddChild(ImageButton("images/inventoryimages/buling_sanmingzhi.xml", "nil.tex"))--未完成
	self.item17:SetPosition(-120, -130, 0)
	self.item17:SetOnClick(
	function ()

self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_sanmingzhi.xml", "buling_sanmingzhi.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_SANMINGZHI))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 25,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_SANMINGZHI))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_bread.xml", "buling_bread.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "cactus_meat.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "flowersalad.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "cactus_meat.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_bread.xml", "buling_bread.tex"))
	end)
	--迪斯瑞处理器(生成海难矿物)
	self.item18 = self.image:AddChild(ImageButton("images/inventoryimages/buling_jianbingguozi.xml", "nil.tex"))--未完成
	self.item18:SetPosition(-40, -130, 0)
	self.item18:SetOnClick(
	function ()

self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_jianbingguozi.xml", "buling_jianbingguozi.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_JIANBINGGUOZI))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_JIANBINGGUOZI))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages.xml", "bird_egg.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "plantmeat.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages.xml", "bird_egg.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kao.xml", "buling_cook_kao.tex"))
	end)
	--剋钨处理器(生成洞穴矿物)
	self.item19 = self.image:AddChild(ImageButton("images/inventoryimages/buling_qiancengbing.xml", "nil.tex"))--未完成
	self.item19:SetPosition(40, -130, 0)
	self.item19:SetOnClick(
	function ()

self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_qiancengbing.xml", "buling_qiancengbing.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_QIANCENGBING))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 25,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_QIANCENGBING))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "plantmeat.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "honey.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "plantmeat.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kao.xml", "buling_cook_kao.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
	end)
	--平坦忒模拟器(生成hm矿物)
	self.item20 = self.image:AddChild(ImageButton("images/inventoryimages/buling_xiangcaobuding.xml", "nil.tex"))--未完成
	self.item20:SetPosition(120, -130, 0)
	self.item20:SetOnClick(
	function ()

self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_xiangcaobuding.xml", "buling_xiangcaobuding.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_XIANGCAOBUDING))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 25,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_XIANGCAOBUDING))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages.xml", "tallbirdegg.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "petals.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages.xml", "goatmilk.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "honey.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_zheng.xml", "buling_cook_zheng.tex"))
	end)
end
function buling_hechenglist:page2()
	--手枪原型
	self.item1 = self.image:AddChild(ImageButton("images/inventoryimages/buling_gun_zero.xml", "buling_gun_zero.tex"))
	self.item1:SetPosition(-120, 190, 0)
	self.item1:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_gun_zero")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_gun_zero.xml", "buling_gun_zero.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 50,STRINGS.NAMES.BULING_GUN_ZERO))
		self.text1:SetPosition(50, 100, 0)
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 25,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_GUN_ZERO))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "gears.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
	end)
	--格林冲锋枪
	self.item2 = self.image:AddChild(ImageButton("images/inventoryimages/buling_gun_white.xml", "buling_gun_white.tex"))
	self.item2:SetPosition(-40, 190, 0)
	self.item2:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_gun_white")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_gun_white.xml", "buling_gun_white.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 50,STRINGS.NAMES.BULING_GUN_WHITE))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 25,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_GUN_WHITE))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_puleidi.xml", "buling_puleidi.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_puleidi.xml", "buling_puleidi.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages/buling_puleidi.xml", "buling_puleidi.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_puleidi.xml", "buling_puleidi.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_core.xml", "buling_core.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_puleidi.xml", "buling_puleidi.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
	end)
	--脉冲手枪
	self.item3 = self.image:AddChild(ImageButton("images/inventoryimages/buling_gun_yang.xml", "buling_gun_yang.tex"))
	self.item3:SetPosition(40, 190, 0)
	self.item3:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_gun_yang")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_gun_yang.xml", "buling_gun_yang.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 50,STRINGS.NAMES.BULING_GUN_YANG))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 25,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_GUN_YANG))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_gun_zero.xml", "buling_gun_zero.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_bileizhen.xml", "buling_bileizhen.tex"))
	end)
	--轻型手枪
	self.item4 = self.image:AddChild(ImageButton("images/inventoryimages/buling_gun_qing.xml", "buling_gun_qing.tex"))
	self.item4:SetPosition(120, 190, 0)
	self.item4:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_gun_qing")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_gun_qing.xml", "buling_gun_qing.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 50,STRINGS.NAMES.BULING_GUN_QING))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 25,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_GUN_QING))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_gun_zero.xml", "buling_gun_zero.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages.xml", "cane.tex"))
	end)
	--枪管
	self.item5 = self.image:AddChild(ImageButton("images/inventoryimages/buling_gun_qiangguan_nil.xml", "buling_gun_qiangguan_nil.tex"))
	self.item5:SetPosition(-120, 110, 0)
	self.item5:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_gun_qiangguan_nil")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_gun_qiangguan_nil.xml", "buling_gun_qiangguan_nil.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_GUN_QIANGGUAN))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_GUN_QIANGGUAN))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))

		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
	end)
	--电池
	self.item6 = self.image:AddChild(ImageButton("images/inventoryimages/buling_gun_dianchi_nil.xml", "buling_gun_dianchi_nil.tex"))
	self.item6:SetPosition(-40, 110, 0)
	self.item6:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_gun_dianchi_nil")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_gun_dianchi_nil.xml", "buling_gun_dianchi_nil.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_GUN_DIANCHI))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_GUN_DIANCHI))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_zhongjiqi.xml", "buling_zhongjiqi.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
	end)
	--手柄
	self.item7 = self.image:AddChild(ImageButton("images/inventoryimages/buling_gun_shoubing_nil.xml", "buling_gun_shoubing_nil.tex"))
	self.item7:SetPosition(40, 110, 0)
	self.item7:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_gun_shoubing_nil")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_gun_shoubing_nil.xml", "buling_gun_shoubing_nil.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_GUN_SHOUBING))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_GUN_SHOUBING))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
	end)
	--激光引导器
	self.item8 = self.image:AddChild(ImageButton("images/inventoryimages/buling_gun_jiguang_nil.xml", "buling_gun_jiguang_nil.tex"))
	self.item8:SetPosition(120, 110, 0)
	self.item8:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_gun_jiguang_nil")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_gun_jiguang_nil.xml", "buling_gun_jiguang_nil.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_GUN_JIGUANG))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_GUN_JIGUANG))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
	end)
	--阳极枪管
	self.item9 = self.image:AddChild(ImageButton("images/inventoryimages/buling_gun_qiangguan_yang.xml", "buling_gun_qiangguan_yang.tex"))
	self.item9:SetPosition(-120, 30, 0)
	self.item9:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_gun_qiangguan_yang")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_gun_qiangguan_yang.xml", "buling_gun_qiangguan_yang.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_GUN_QIANGGUAN_YANG))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_GUN_QIANGGUAN_YANG))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_puleidi.xml", "buling_puleidi.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_gun_qiangguan_nil.xml", "buling_gun_qiangguan_nil.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
	end)
	--通量电池
	self.item10 = self.image:AddChild(ImageButton("images/inventoryimages/buling_gun_dianchi_tongliang.xml", "buling_gun_dianchi_tongliang.tex"))
	self.item10:SetPosition(-40, 30, 0)
	self.item10:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_gun_dianchi_tongliang")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_gun_dianchi_tongliang.xml", "buling_gun_dianchi_tongliang.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_GUN_DIANCHI_TONGLIANG))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_GUN_DIANCHI_TONGLIANG))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_zhongjiqi_gaoya.xml", "buling_zhongjiqi_gaoya.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_gun_dianchi_nil.xml", "buling_gun_dianchi_nil.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
	end)
	--RO-16标枪手柄
	self.item11 = self.image:AddChild(ImageButton("images/inventoryimages/buling_gun_shoubing_biaoqiang.xml", "buling_gun_shoubing_biaoqiang.tex"))
	self.item11:SetPosition(40, 30, 0)
	self.item11:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_gun_shoubing_biaoqiang")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_gun_shoubing_biaoqiang.xml", "buling_gun_shoubing_biaoqiang.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 45,STRINGS.NAMES.BULING_GUN_SHOUBING_BIAOQIANG))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_GUN_SHOUBING_BIAOQIANG))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
	end)
	--格拉斯引导器
	self.item12 = self.image:AddChild(ImageButton("images/inventoryimages/buling_gun_jiguang_yaoshou.xml", "buling_gun_jiguang_yaoshou.tex"))
	self.item12:SetPosition(120, 30, 0)
	self.item12:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_gun_jiguang_yaoshou")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_gun_jiguang_yaoshou.xml", "buling_gun_jiguang_yaoshou.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 45,STRINGS.NAMES.BULING_GUN_JIGUANG_YAOSHOU))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 25,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_GUN_JIGUANG_YAOSHOU))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_puleidi.xml", "buling_puleidi.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_gun_jiguang_nil.xml", "buling_gun_jiguang_nil.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_puleidi.xml", "buling_puleidi.tex"))
	end)
	--阴极枪管
	self.item13 = self.image:AddChild(ImageButton("images/inventoryimages/buling_gun_qiangguan_ying.xml", "buling_gun_qiangguan_ying.tex"))
	self.item13:SetPosition(-120, -50, 0)
	self.item13:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_gun_qiangguan_ying")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_gun_qiangguan_ying.xml", "buling_gun_qiangguan_ying.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_GUN_QIANGGUAN_YING))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_GUN_QIANGGUAN_YING))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_gun_qiangguan_nil.xml", "buling_gun_qiangguan_nil.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
	end)
	--太阳能电池
	self.item14 = self.image:AddChild(ImageButton("images/inventoryimages/buling_gun_dianchi_taiyang.xml", "buling_gun_dianchi_taiyang.tex"))
	self.item14:SetPosition(-40, -50, 0)
	self.item14:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_gun_dianchi_taiyang")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_gun_dianchi_taiyang.xml", "buling_gun_dianchi_taiyang.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_GUN_DIANCHI_TAIYANG))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_GUN_DIANCHI_TAIYANG))
		self.text2:SetPosition(80, -50, 0)
		
		
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_taiyangneng.xml", "buling_taiyangneng.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_gun_dianchi_nil.xml", "buling_gun_dianchi_nil.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
	end)
	--狙击手柄
	self.item15 = self.image:AddChild(ImageButton("images/inventoryimages/buling_gun_shoubing_juji.xml", "buling_gun_shoubing_juji.tex"))
	self.item15:SetPosition(40, -50, 0)
	self.item15:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_gun_shoubing_juji")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_gun_shoubing_juji.xml", "buling_gun_shoubing_juji.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 45,STRINGS.NAMES.BULING_GUN_SHOUBING_JUJI))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_GUN_SHOUBING_JUJI))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
	end)
	--剥离引导器
	self.item16 = self.image:AddChild(ImageButton("images/inventoryimages/buling_gun_jiguang_boli.xml", "buling_gun_jiguang_boli.tex"))
	self.item16:SetPosition(120, -50, 0)
	self.item16:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_gun_jiguang_boli")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_gun_jiguang_boli.xml", "buling_gun_jiguang_boli.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 45,STRINGS.NAMES.BULING_GUN_JIGUANG_BOLI))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_GUN_JIGUANG_BOLI))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_puleidi.xml", "buling_puleidi.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_gun_jiguang_nil.xml", "buling_gun_jiguang_nil.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_puleidi.xml", "buling_puleidi.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_glass.xml", "buling_glass.tex"))
	end)
	--三明治
	self.item17 = self.image:AddChild(ImageButton("images/inventoryimages/buling_sanmingzhi.xml", "nil.tex"))--未完成
	self.item17:SetPosition(-120, -130, 0)
	self.item17:SetOnClick(
	function ()

self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_sanmingzhi.xml", "buling_sanmingzhi.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_SANMINGZHI))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 25,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_SANMINGZHI))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_bread.xml", "buling_bread.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "cactus_meat.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "flowersalad.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "cactus_meat.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_bread.xml", "buling_bread.tex"))
	end)
	--煎饼果子
	self.item18 = self.image:AddChild(ImageButton("images/inventoryimages/buling_jianbingguozi.xml", "nil.tex"))--未完成
	self.item18:SetPosition(-40, -130, 0)
	self.item18:SetOnClick(
	function ()

self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_jianbingguozi.xml", "buling_jianbingguozi.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_JIANBINGGUOZI))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_JIANBINGGUOZI))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages.xml", "bird_egg.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "plantmeat.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages.xml", "bird_egg.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kao.xml", "buling_cook_kao.tex"))
	end)
	--千层饼
	self.item19 = self.image:AddChild(ImageButton("images/inventoryimages/buling_qiancengbing.xml", "nil.tex"))--未完成
	self.item19:SetPosition(40, -130, 0)
	self.item19:SetOnClick(
	function ()

self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_qiancengbing.xml", "buling_qiancengbing.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_QIANCENGBING))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 25,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_QIANCENGBING))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "plantmeat.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "honey.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "plantmeat.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kao.xml", "buling_cook_kao.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
	end)
	--地雷
	self.item20 = self.image:AddChild(ImageButton("images/inventoryimages/buling_mine.xml", "nil.tex"))--未完成
	self.item20:SetPosition(120, -130, 0)
	self.item20:SetOnClick(
	function ()

self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_mine.xml", "buling_mine.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_MINE))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 20,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_MINE))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "nitre.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "gears.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_zhongziding.xml", "buling_zhongziding.tex"))
	end)
end
function buling_hechenglist:Close()
	--if self.openui == true then
		self.openui = false
		self:Hide()
	--end
end
function buling_hechenglist:Open()
	--if self.openui == false then
		print("不灵打开ui")
		self.openui = true
		self:Show()
		self:yajin()
	--end
end

function buling_hechenglist:QK()
	if self.tubiao then self.tubiao:Kill() end
	if self.text1 then self.text1:Kill() end
	if self.text2 then self.text2:Kill() end
	if self.cailiao1 then self.cailiao1:Kill() end
	if self.cailiao2 then self.cailiao2:Kill() end
	if self.cailiao3 then self.cailiao3:Kill() end
	if self.cailiao4 then self.cailiao4:Kill() end
	if self.cailiao5 then self.cailiao5:Kill() end
	if self.cailiao6 then self.cailiao6:Kill() end
	if self.cailiao7 then self.cailiao7:Kill() end
	if self.cailiao8 then self.cailiao8:Kill() end
	if self.cailiao9 then self.cailiao9:Kill() end
end
function buling_hechenglist:CK()
	if self.item1 then self.item1:Kill() end
	if self.item2 then self.item2:Kill() end
	if self.item3 then self.item3:Kill() end
	if self.item4 then self.item4:Kill() end
	if self.item5 then self.item5:Kill() end
	if self.item6 then self.item6:Kill() end
	if self.item7 then self.item7:Kill() end
	if self.item8 then self.item8:Kill() end
	if self.item9 then self.item9:Kill() end
	if self.item10 then self.item10:Kill() end
	if self.item11 then self.item11:Kill() end
	if self.item12 then self.item12:Kill() end
	if self.item13 then self.item13:Kill() end
	if self.item14 then self.item14:Kill() end
	if self.item15 then self.item15:Kill() end
	if self.item16 then self.item16:Kill() end
	if self.item17 then self.item17:Kill() end
	if self.item18 then self.item18:Kill() end
	if self.item19 then self.item19:Kill() end
	if self.item20 then self.item20:Kill() end

end
return buling_hechenglist