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


buling_hechenglist_clothes = Class(Widget, function(self,owner)
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
	_owner:ListenForEvent("OpenBuling_cloth",function()
		self:Open()
	end)
	local _owner = self.owner or ThePlayer
	_owner:ListenForEvent("CloseBuling_cloth",function()
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
function buling_hechenglist_clothes:flip()
	self:CK()
	if self.page == 1 then
		self:page1()
	elseif self.page == 2 then
		self:page2()
	elseif self.page == 3 then
		self:page3()
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
end
function buling_hechenglist_clothes:page1()
	--纤维布
	self.item1 = self.image:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
	self.item1:SetPosition(-120, 190, 0)
	self.item1:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_fabric")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_FABRIC))
		self.text1:SetPosition(50, 100, 0)
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_FABRIC))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages.xml", "cutgrass.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "cutgrass.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "cutgrass.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "cutgrass.tex"))
	end)
	--布
	self.item2 = self.image:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
	self.item2:SetPosition(-40, 190, 0)
	self.item2:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_fabric")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages.xml", "fabric.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 50,STRINGS.NAMES.FABRIC))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.FABRIC))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
	end)
	--化纤
	self.item3 = self.image:AddChild(ImageButton("images/inventoryimages/buling_cook_caidao.xml", "nil.tex"))--未完成
	self.item3:SetPosition(40, 190, 0)
	self.item3:SetOnClick(
	function ()

self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_cook_caidao.xml", "buling_cook_caidao.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 50,STRINGS.NAMES.BULING_COOK_CAIDAO))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_COOK_CAIDAO))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "flint.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "flint.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "twigs.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages.xml", "flint.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages.xml", "flint.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages.xml", "flint.tex"))
	end)
	--超织物
	self.item4 = self.image:AddChild(ImageButton("images/inventoryimages/buling_bread.xml", "nil.tex"))--未完成
	self.item4:SetPosition(120, 190, 0)
	self.item4:SetOnClick(
	function ()

self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_bread.xml", "buling_bread.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_BREAD))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_BREAD))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
	end)
	--缝合
	self.item5 = self.image:AddChild(ImageButton("images/inventoryimages.xml", "sewing_kit.tex"))
	self.item5:SetPosition(-120, 110, 0)
	self.item5:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "sewing_kit")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages.xml", "sewing_kit.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.BULING_CLOTHES))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.BULING_CLOTHES_PEIFANG))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_body_buttons_black_jet.xml", "buling_body_buttons_black_jet.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_legs_swing_pants_brown_umber.xml", "buling_legs_swing_pants_brown_umber.tex"))
	end)
	--黑色体恤
	self.item6 = self.image:AddChild(ImageButton("images/inventoryimages/buling_body_buttons_black_jet.xml", "buling_body_buttons_black_jet.tex"))
	self.item6:SetPosition(-40, 110, 0)
	self.item6:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_body_buttons_black_jet")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_body_buttons_black_jet.xml", "buling_body_buttons_black_jet.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_CLOTHE_1))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CLOTHE_1))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "charcoal.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
	end)
	--棕色毛衣
	self.item7 = self.image:AddChild(ImageButton("images/inventoryimages/buling_body_cableknit_sweater_tan_khaki.xml", "buling_body_cableknit_sweater_tan_khaki.tex"))
	self.item7:SetPosition(40, 110, 0)
	self.item7:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_body_cableknit_sweater_tan_khaki")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_body_cableknit_sweater_tan_khaki.xml", "buling_body_cableknit_sweater_tan_khaki.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_CLOTHE_2))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CLOTHE_2))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "beefalowool.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
	end)
	--绅士礼服
	self.item8 = self.image:AddChild(ImageButton("images/inventoryimages/buling_body_cardigan_black_jet.xml", "buling_body_cardigan_black_jet.tex"))
	self.item8:SetPosition(120, 110, 0)
	self.item8:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_body_cardigan_black_jet")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_body_cardigan_black_jet.xml", "buling_body_cardigan_black_jet.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_CLOTHE_3))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CLOTHE_3))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "petals.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
	end)
	--黄色运动服
	self.item9 = self.image:AddChild(ImageButton("images/inventoryimages/buling_body_expo_letterman_yellow_beige.xml", "buling_body_expo_letterman_yellow_beige.tex"))
	self.item9:SetPosition(-120, 30, 0)
	self.item9:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_body_expo_letterman_yellow_beige")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_body_expo_letterman_yellow_beige.xml", "buling_body_expo_letterman_yellow_beige.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_CLOTHE_4))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CLOTHE_4))
		self.text2:SetPosition(80, -50, 0)
		
		
		
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "goldnugget.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_body_buttons_black_jet.xml", "buling_body_buttons_black_jet.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages.xml", "goldnugget.tex"))
	end)
	--蓝色运动衫
	self.item10 = self.image:AddChild(ImageButton("images/inventoryimages/buling_body_expo_sweater_blue_agean.xml", "buling_body_expo_sweater_blue_agean.tex"))
	self.item10:SetPosition(-40, 30, 0)
	self.item10:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_body_expo_sweater_blue_agean")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_body_expo_sweater_blue_agean.xml", "buling_body_expo_sweater_blue_agean.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_CLOTHE_5))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CLOTHE_5))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "heatrock.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
	end)
	--透气格子衫
	self.item11 = self.image:AddChild(ImageButton("images/inventoryimages/buling_body_flannel_blue_snowbird.xml", "buling_body_flannel_blue_snowbird.tex"))
	self.item11:SetPosition(40, 30, 0)
	self.item11:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_body_flannel_blue_snowbird")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_body_flannel_blue_snowbird.xml", "buling_body_flannel_blue_snowbird.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_CLOTHE_6))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CLOTHE_6))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
	end)
	--橙色大衣
	self.item12 = self.image:AddChild(ImageButton("images/inventoryimages/buling_body_jacket_shearling_orange_salmon.xml", "buling_body_jacket_shearling_orange_salmon.tex"))
	self.item12:SetPosition(120, 30, 0)
	self.item12:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_body_jacket_shearling_orange_salmon")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_body_jacket_shearling_orange_salmon.xml", "buling_body_jacket_shearling_orange_salmon.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_CLOTHE_7))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 20,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CLOTHE_7))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "beefalowool.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_body_cableknit_sweater_tan_khaki.xml", "buling_body_cableknit_sweater_tan_khaki.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages.xml", "beefalowool.tex"))
	end)
	--怪物大衣
	self.item13 = self.image:AddChild(ImageButton("images/inventoryimages/buling_body_jacket_toggle_navy_phthalo.xml", "buling_body_jacket_toggle_navy_phthalo.tex"))
	self.item13:SetPosition(-120, -50, 0)
	self.item13:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_body_jacket_toggle_navy_phthalo")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_body_jacket_toggle_navy_phthalo.xml", "buling_body_jacket_toggle_navy_phthalo.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_CLOTHE_8))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CLOTHE_8))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "monsterlasagna.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "monstermeat.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_body_cardigan_black_jet.xml", "buling_body_cardigan_black_jet.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "monstermeat.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages.xml", "monstermeat.tex"))
	end)
	--太阳能衬衫
	self.item14 = self.image:AddChild(ImageButton("images/inventoryimages/buling_body_pj_blue_agean.xml", "buling_body_pj_blue_agean.tex"))
	self.item14:SetPosition(-40, -50, 0)
	self.item14:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_body_pj_blue_agean")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_body_pj_blue_agean.xml", "buling_body_pj_blue_agean.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_CLOTHE_9))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CLOTHE_9))
		self.text2:SetPosition(80, -50, 0)
		
		
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_taiyangneng.xml", "buling_taiyangneng.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
	end)
	--普通裤子
	self.item15 = self.image:AddChild(ImageButton("images/inventoryimages/buling_legs_pants_basic_blue_sky.xml", "buling_legs_pants_basic_blue_sky.tex"))
	self.item15:SetPosition(40, -50, 0)
	self.item15:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_legs_pants_basic_blue_sky")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_legs_pants_basic_blue_sky.xml", "buling_legs_pants_basic_blue_sky.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_TROUSER_1))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_TROUSER_1))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		--self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
	end)
	--黑色裤袜
	self.item16 = self.image:AddChild(ImageButton("images/inventoryimages/buling_legs_shorts_black_scribble.xml", "buling_legs_shorts_black_scribble.tex"))
	self.item16:SetPosition(120, -50, 0)
	self.item16:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_legs_shorts_black_scribble")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_legs_shorts_black_scribble.xml", "buling_legs_shorts_black_scribble.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_TROUSER_2))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_TROUSER_2))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))	
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
	end)
	--蓝格子裤
	self.item17 = self.image:AddChild(ImageButton("images/inventoryimages/buling_legs_checkered_pleats_blue_cornflower.xml", "buling_legs_checkered_pleats_blue_cornflower.tex"))
	self.item17:SetPosition(-120, -130, 0)
	self.item17:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_legs_checkered_pleats_blue_cornflower")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_legs_checkered_pleats_blue_cornflower.xml", "buling_legs_checkered_pleats_blue_cornflower.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_TROUSER_3))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_TROUSER_3))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
	end)
	--条纹裤子
	self.item18 = self.image:AddChild(ImageButton("images/inventoryimages/buling_legs_pinstripe_pants_black_jet.xml", "buling_legs_pinstripe_pants_black_jet.tex"))
	self.item18:SetPosition(-40, -130, 0)
	self.item18:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_legs_pinstripe_pants_black_jet")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_legs_pinstripe_pants_black_jet.xml", "buling_legs_pinstripe_pants_black_jet.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_TROUSER_4))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_TROUSER_4))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
	end)
	--黑色牛仔裤
	self.item19 = self.image:AddChild(ImageButton("images/inventoryimages/buling_legs_jeans_black_scribble.xml", "buling_legs_jeans_black_scribble.tex"))
	self.item19:SetPosition(40, -130, 0)
	self.item19:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_legs_jeans_black_scribble")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_legs_jeans_black_scribble.xml", "buling_legs_jeans_black_scribble.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_TROUSER_5))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_TROUSER_5))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
	end)
	--结实裤子
	self.item20 = self.image:AddChild(ImageButton("images/inventoryimages/buling_legs_swing_pants_brown_umber.xml", "buling_legs_swing_pants_brown_umber.tex"))
	self.item20:SetPosition(120, -130, 0)
	self.item20:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_legs_swing_pants_brown_umber")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_legs_swing_pants_brown_umber.xml", "buling_legs_swing_pants_brown_umber.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_TROUSER_6))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_TROUSER_6))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_legs_jeans_black_scribble.xml", "buling_legs_jeans_black_scribble.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_fabric.xml", "buling_fabric.tex"))

	end)
end
function buling_hechenglist_clothes:page2()
	--武龙
	self.item1 = self.image:AddChild(ImageButton("images/inventoryimages/buling_body_dancer_dragon.xml", "buling_body_dancer_dragon.tex"))
	self.item1:SetPosition(-120, 190, 0)
	self.item1:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_body_dancer_dragon")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_body_dancer_dragon.xml", "buling_body_dancer_dragon.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 50,STRINGS.NAMES.BULING_DANCER_DRAGON))
		self.text1:SetPosition(50, 100, 0)
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_DANCER_DRAGON))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages.xml", "thulecite_pieces.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages.xml", "thulecite_pieces.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "thulecite_pieces.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_core.xml", "buling_core.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "thulecite_pieces.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages.xml", "thulecite_pieces.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages.xml", "armorruins.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages.xml", "thulecite_pieces.tex"))
	end)
	--鲜红贵族
	self.item2 = self.image:AddChild(ImageButton("images/inventoryimages/buling_body_outerwear_quilted_red_cardinal.xml", "buling_body_outerwear_quilted_red_cardinal.tex"))
	self.item2:SetPosition(-40, 190, 0)
	self.item2:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_body_outerwear_quilted_red_cardinal")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_body_outerwear_quilted_red_cardinal.xml", "buling_body_outerwear_quilted_red_cardinal.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 50,STRINGS.NAMES.BULING_CARDINAL))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 25,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CARDINAL))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_puleidi.xml", "buling_puleidi.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages/buling_puleidi.xml", "buling_puleidi.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "ancient_remnant.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_core.xml", "buling_core.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "ancient_remnant.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages.xml", "ancient_remnant.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages.xml", "ancient_remnant.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages.xml", "ancient_remnant.tex"))
	end)
	--红色睡袍
	self.item3 = self.image:AddChild(ImageButton("images/inventoryimages/buling_body_silk_eveningrobe_red_rump.xml", "buling_body_silk_eveningrobe_red_rump.tex"))
	self.item3:SetPosition(40, 190, 0)
	self.item3:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_body_silk_eveningrobe_red_rump")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_body_silk_eveningrobe_red_rump.xml", "buling_body_silk_eveningrobe_red_rump.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 50,STRINGS.NAMES.BULING_EVENINGROBE))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_EVENINGROBE))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_puleidi.xml", "buling_puleidi.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_puleidi.xml", "buling_puleidi.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_puleidi.xml", "buling_puleidi.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages/buling_puleidi.xml", "buling_puleidi.tex"))
	end)
	--园丁
	self.item4 = self.image:AddChild(ImageButton("images/inventoryimages/buling_body_overalls_blue_denim.xml", "buling_body_overalls_blue_denim.tex"))
	self.item4:SetPosition(120, 190, 0)
	self.item4:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_body_overalls_blue_denim")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_body_overalls_blue_denim.xml", "buling_body_overalls_blue_denim.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_DENIM))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_DENIM))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "pitchfork.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
	end)
	--死库水
	self.item5 = self.image:AddChild(ImageButton("images/inventoryimages/bulingbuling_sikushui.xml", "bulingbuling_sikushui.tex"))
	self.item5:SetPosition(-120, 110, 0)
	self.item5:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "bulingbuling_sikushui")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/bulingbuling_sikushui.xml", "bulingbuling_sikushui.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 50,STRINGS.NAMES.BULINGBULING_SIKUSHUI))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULINGBULING_SIKUSHUI))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages.xml", "ice.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages.xml", "ice.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "tar.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_body_buttons_black_jet.xml", "buling_body_buttons_black_jet.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "tar.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
	end)
	--圣诞套
	self.item6 = self.image:AddChild(ImageButton("images/inventoryimages/buling_christmas.xml", "buling_christmas.tex"))
	self.item6:SetPosition(-40, 110, 0)
	self.item6:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_christmas")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_christmas.xml", "buling_christmas.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_CHRISTMAS))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CHRISTMAS))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_body_jacket_shearling_orange_salmon.xml", "buling_body_jacket_shearling_orange_salmon.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages.xml", "fabric.tex"))
	end)
	--宾卡馅饼
	self.item7 = self.image:AddChild(ImageButton("images/inventoryimages/buling_bingkaxianbing.xml", "nil.tex"))
	self.item7:SetPosition(40, 110, 0)
	self.item7:SetOnClick(
	function ()

self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_bingkaxianbing.xml", "buling_bingkaxianbing.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_BINGKAXIANBING))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_BINGKAXIANBING))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_shucaisui.xml", "buling_shucaisui.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_shucaisui.xml", "buling_shucaisui.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
	end)
	--烤冷面
	self.item8 = self.image:AddChild(ImageButton("images/inventoryimages/buling_kaolengmian.xml", "nil.tex"))
	self.item8:SetPosition(120, 110, 0)
	self.item8:SetOnClick(
	function ()

self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_kaolengmian.xml", "buling_kaolengmian.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_KAOLENGMIAN))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_KAOLENGMIAN))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_shucaisui.xml", "buling_shucaisui.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_shucaisui.xml", "buling_shucaisui.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages/buling_cook_caidao.xml", "buling_cook_caidao.tex"))
	end)
	--仙人掌三明治
	self.item9 = self.image:AddChild(ImageButton("images/inventoryimages/buling_sanmingzhi.xml", "nil.tex"))
	self.item9:SetPosition(-120, 30, 0)
	self.item9:SetOnClick(
	function ()

self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_sanmingzhi.xml", "buling_sanmingzhi.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_SANMINGZHI))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_SANMINGZHI))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_bread.xml", "buling_bread.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "cactus_meat.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_bread.xml", "buling_bread.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "cactus_meat.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_caidao.xml", "buling_cook_caidao.tex"))
	end)
	--煎饼果子
	self.item10 = self.image:AddChild(ImageButton("images/inventoryimages/buling_jianbingguozi.xml", "nil.tex"))
	self.item10:SetPosition(-40, 30, 0)
	self.item10:SetOnClick(
	function ()

self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_jianbingguozi.xml", "buling_jianbingguozi.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_JIANBINGGUOZI))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_JIANBINGGUOZI))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "bird_egg.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_shucaisui.xml", "buling_shucaisui.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_shucaisui.xml", "buling_shucaisui.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages/buling_cook_caidao.xml", "buling_cook_caidao.tex"))
	end)
	--千层饼
	self.item11 = self.image:AddChild(ImageButton("images/inventoryimages/buling_qiancengbing.xml", "nil.tex"))
	self.item11:SetPosition(40, 30, 0)
	self.item11:SetOnClick(
	function ()

self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_qiancengbing.xml", "buling_qiancengbing.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_QIANCENGBING))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_QIANCENGBING))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "plantmeat.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_shucaisui.xml", "buling_shucaisui.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_shucaisui.xml", "buling_shucaisui.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
	end)
	--香草布丁
	self.item12 = self.image:AddChild(ImageButton("images/inventoryimages/buling_xiangcaobuding.xml", "nil.tex"))
	self.item12:SetPosition(120, 30, 0)
	self.item12:SetOnClick(
	function ()

self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_xiangcaobuding.xml", "buling_xiangcaobuding.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_XIANGCAOBUDING))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_XIANGCAOBUDING))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages.xml", "petals.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_cream.xml", "buling_cream.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages.xml", "petals.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "bird_egg.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "bird_egg.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
	end)
	--甜蜜沙拉
	self.item13 = self.image:AddChild(ImageButton("images/inventoryimages/buling_tianmishala.xml", "nil.tex"))
	self.item13:SetPosition(-120, -50, 0)
	self.item13:SetOnClick(
	function ()

self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_tianmishala.xml", "buling_tianmishala.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_TIANMISHALA))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_TIANMISHALA))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "honey.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_shucaisui.xml", "buling_shucaisui.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_shucaisui.xml", "buling_shucaisui.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_shucaisui.xml", "buling_shucaisui.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_caidao.xml", "buling_cook_caidao.tex"))
	end)
	--香蕉馅饼
	self.item14 = self.image:AddChild(ImageButton("images/inventoryimages/buling_xiangjiaoxianbing.xml", "nil.tex"))
	self.item14:SetPosition(-40, -50, 0)
	self.item14:SetOnClick(
	function ()

self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_xiangjiaoxianbing.xml", "buling_xiangjiaoxianbing.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_XIANGJIAOXIANBING))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_XIANGJIAOXIANBING))
		self.text2:SetPosition(80, -50, 0)
		
		
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "cave_banana.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
	end)
	--西瓜汁
	self.item15 = self.image:AddChild(ImageButton("images/inventoryimages/buling_xiguazhi.xml", "nil.tex"))
	self.item15:SetPosition(40, -50, 0)
	self.item15:SetOnClick(
	function ()

self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_xiguazhi.xml", "buling_xiguazhi.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_XIGUAZHI))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 25,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_XIGUAZHI))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "watermelon.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_caidao.xml", "buling_cook_caidao.tex"))
	end)
	--素肉大餐
	self.item16 = self.image:AddChild(ImageButton("images/inventoryimages/buling_suroudacan.xml", "nil.tex"))
	self.item16:SetPosition(120, -50, 0)
	self.item16:SetOnClick(
	function ()

self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_suroudacan.xml", "buling_suroudacan.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_SUROUDACAN))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_SUROUDACAN))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_shucaisui.xml", "buling_shucaisui.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_shucaisui.xml", "buling_shucaisui.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "plantmeat.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_shucaisui.xml", "buling_shucaisui.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
	end)
	--方形焦糖
	self.item17 = self.image:AddChild(ImageButton("images/inventoryimages/buling_fangxingjiaotang.xml", "nil.tex"))
	self.item17:SetPosition(-120, -130, 0)
	self.item17:SetOnClick(
	function ()

self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_fangxingjiaotang.xml", "buling_fangxingjiaotang.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_FANGXINGJIAOTANG))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_FANGXINGJIAOTANG))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "honey.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "honey.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "honey.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
	end)
	--烤地瓜
	self.item18 = self.image:AddChild(ImageButton("images/inventoryimages/buling_kaodigua.xml", "nil.tex"))
	self.item18:SetPosition(-40, -130, 0)
	self.item18:SetOnClick(
	function ()

self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_kaodigua.xml", "buling_kaodigua.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_KAODIGUA))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_KAODIGUA))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "sweet_potato.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
	end)
	--番薯泥
	self.item19 = self.image:AddChild(ImageButton("images/inventoryimages/buling_fanshuni.xml", "nil.tex"))
	self.item19:SetPosition(40, -130, 0)
	self.item19:SetOnClick(
	function ()

self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_fanshuni.xml", "buling_fanshuni.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_FANSHUNI))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_FANSHUNI))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "sweet_potato.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_guo.xml", "buling_cook_guo.tex"))
	end)
	--番薯煎饼
	self.item20 = self.image:AddChild(ImageButton("images/inventoryimages/buling_fanshujianbing.xml", "nil.tex"))
	self.item20:SetPosition(120, -130, 0)
	self.item20:SetOnClick(
	function ()

self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_fanshujianbing.xml", "buling_fanshujianbing.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_FANSHUJIANBING))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_FANSHUJIANBING))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "sweet_potato.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
	end)
end
function buling_hechenglist_clothes:page3()
	--番薯粥
	self.item1 = self.image:AddChild(ImageButton("images/inventoryimages/buling_fanshuzhou.xml", "buling_fanshuzhou.tex"))
	self.item1:SetPosition(-120, 190, 0)
	self.item1:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_fanshuzhou")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_fanshuzhou.xml", "buling_fanshuzhou.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_FANSHUZHOU))
		self.text1:SetPosition(50, 100, 0)
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_FANSHUZHOU))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "sweet_potato.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_xifan.xml", "buling_xifan.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_guo.xml", "buling_cook_guo.tex"))
	end)
	--甜薯泥
	self.item2 = self.image:AddChild(ImageButton("images/inventoryimages/buling_tianshuni.xml", "buling_tianshuni.tex"))
	self.item2:SetPosition(-40, 190, 0)
	self.item2:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_tianshuni")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_tianshuni.xml", "buling_tianshuni.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_TIANSHUNI))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_TIANSHUNI))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "honey.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "sweet_potato.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "honey.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_guo.xml", "buling_cook_guo.tex"))
	end)
	--蜂蜜布丁
	self.item3 = self.image:AddChild(ImageButton("images/inventoryimages/buling_fengmibuding.xml", "buling_fengmibuding.tex"))
	self.item3:SetPosition(40, 190, 0)
	self.item3:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_fengmibuding")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_fengmibuding.xml", "buling_fengmibuding.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_FENGMIBUDING))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_FENGMIBUDING))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages.xml", "honey.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_cream.xml", "buling_cream.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages.xml", "honey.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "bird_egg.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "bird_egg.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
	end)
	--蜂蜜面包
	self.item4 = self.image:AddChild(ImageButton("images/inventoryimages/buling_fengmimianbao.xml", "buling_fengmimianbao.tex"))
	self.item4:SetPosition(120, 190, 0)
	self.item4:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_fengmimianbao")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_fengmimianbao.xml", "buling_fengmimianbao.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_FENGMIMIANBAO))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_FENGMIMIANBAO))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "honey.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_bread.xml", "buling_bread.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "honey.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_caidao.xml", "buling_cook_caidao.tex"))
	end)
	--面包片
	self.item5 = self.image:AddChild(ImageButton("images/inventoryimages/buling_mianbaopian.xml", "buling_mianbaopian.tex"))
	self.item5:SetPosition(-120, 110, 0)
	self.item5:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_mianbaopian")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_mianbaopian.xml", "buling_mianbaopian.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_MIANBAOPIAN))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_MIANBAOPIAN))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "jammypreserves.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_bread.xml", "buling_bread.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_caidao.xml", "buling_cook_caidao.tex"))
	end)
	--披萨
	self.item6 = self.image:AddChild(ImageButton("images/inventoryimages/buling_pisa.xml", "buling_pisa.tex"))
	self.item6:SetPosition(-40, 110, 0)
	self.item6:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_pisa")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_pisa.xml", "buling_pisa.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_PISA))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_PISA))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "dragonfruit.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_shucaisui.xml", "buling_shucaisui.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
	end)
	--巧克力派
	self.item7 = self.image:AddChild(ImageButton("images/inventoryimages/buling_qiaokelipai.xml", "buling_qiaokelipai.tex"))
	self.item7:SetPosition(40, 110, 0)
	self.item7:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_qiaokelipai")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_qiaokelipai.xml", "buling_qiaokelipai.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_QIAOKELIPAI))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_QIAOKELIPAI))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "coffeebeans.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "bird_egg.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_cream.xml", "buling_cream.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "bird_egg.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
	end)
	--巧克力馅饼
	self.item8 = self.image:AddChild(ImageButton("images/inventoryimages/buling_qiaokelixianbing.xml", "buling_qiaokelixianbing.tex"))
	self.item8:SetPosition(120, 110, 0)
	self.item8:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_qiaokelixianbing")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_qiaokelixianbing.xml", "buling_qiaokelixianbing.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_QIAOKELIXIANBING))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_QIAOKELIXIANBING))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "coffeebeans.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "bird_egg.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "bird_egg.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
	end)
	--茄盒薯条
	self.item9 = self.image:AddChild(ImageButton("images/inventoryimages/buling_qieheshutiao.xml", "buling_qieheshutiao.tex"))
	self.item9:SetPosition(-120, 30, 0)
	self.item9:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_qieheshutiao")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_qieheshutiao.xml", "buling_qieheshutiao.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_QIEHESHUTIAO))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_QIEHESHUTIAO))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages.xml", "eggplant.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_shucaisui.xml", "buling_shucaisui.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages.xml", "eggplant.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "sweet_potato.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
	end)
	--蔬菜杂烩
	self.item10 = self.image:AddChild(ImageButton("images/inventoryimages/buling_shucaishala.xml", "buling_shucaishala.tex"))
	self.item10:SetPosition(-40, 30, 0)
	self.item10:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_shucaishala")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_shucaishala.xml", "buling_shucaishala.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_SHUCAISHALA))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_SHUCAISHALA))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_cream.xml", "buling_cream.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_shucaisui.xml", "buling_shucaisui.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages/buling_cream.xml", "buling_cream.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_shucaisui.xml", "buling_shucaisui.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_shucaisui.xml", "buling_shucaisui.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_shucaisui.xml", "buling_shucaisui.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_guo.xml", "buling_cook_guo.tex"))
	end)
	--蔬菜面包
	self.item11 = self.image:AddChild(ImageButton("images/inventoryimages/buling_suanrongmianbao.xml", "buling_suanrongmianbao.tex"))
	self.item11:SetPosition(40, 30, 0)
	self.item11:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_suanrongmianbao")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_suanrongmianbao.xml", "buling_suanrongmianbao.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_SUANRONGMIANBAO))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_SUANRONGMIANBAO))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_shucaisui.xml", "buling_shucaisui.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_bread.xml", "buling_bread.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_caidao.xml", "buling_cook_caidao.tex"))
	end)
	--炸丸子
	self.item12 = self.image:AddChild(ImageButton("images/inventoryimages/buling_zhawanzi.xml", "buling_zhawanzi.tex"))
	self.item12:SetPosition(120, 30, 0)
	self.item12:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_zhawanzi")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_zhawanzi.xml", "buling_zhawanzi.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_ZHAWANZI))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_ZHAWANZI))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_shucaisui.xml", "buling_shucaisui.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages/buling_shucaisui.xml", "buling_shucaisui.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_shucaisui.xml", "buling_shucaisui.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
	end)
	--红菇粥
	self.item13 = self.image:AddChild(ImageButton("images/inventoryimages/buling_hongguzhou.xml", "buling_hongguzhou.tex"))
	self.item13:SetPosition(-120, -50, 0)
	self.item13:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_hongguzhou")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_hongguzhou.xml", "buling_hongguzhou.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_HONGGUZHOU))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_HONGGUZHOU))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "red_cap.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_xifan.xml", "buling_xifan.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_guo.xml", "buling_cook_guo.tex"))
	end)
	--蓝菇粥
	self.item14 = self.image:AddChild(ImageButton("images/inventoryimages/buling_languzhou.xml", "buling_languzhou.tex"))
	self.item14:SetPosition(-40, -50, 0)
	self.item14:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_languzhou")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_languzhou.xml", "buling_languzhou.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_LANGUZHOU))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_LANGUZHOU))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "blue_cap.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_xifan.xml", "buling_xifan.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_guo.xml", "buling_cook_guo.tex"))
	end)
	--绿菇粥
	self.item15 = self.image:AddChild(ImageButton("images/inventoryimages/buling_lvguzhou.xml", "buling_lvguzhou.tex"))
	self.item15:SetPosition(40, -50, 0)
	self.item15:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_lvguzhou")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_lvguzhou.xml", "buling_lvguzhou.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_LVGUZHOU))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_LVGUZHOU))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "green_cap.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_xifan.xml", "buling_xifan.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_guo.xml", "buling_cook_guo.tex"))
	end)
	--烤冷面
	self.item16 = self.image:AddChild(ImageButton("images/inventoryimages/buling_kaolengmian.xml", "nil.tex"))
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
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
	end)
	--三明治
	self.item17 = self.image:AddChild(ImageButton("images/inventoryimages/buling_sanmingzhi.xml", "nil.tex"))
	self.item17:SetPosition(-120, -130, 0)
	self.item17:SetOnClick(
	function ()

self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_sanmingzhi.xml", "buling_sanmingzhi.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_SANMINGZHI))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_SANMINGZHI))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_bread.xml", "buling_bread.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "cactus_meat.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "flowersalad.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "cactus_meat.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_bread.xml", "buling_bread.tex"))
	end)
	--煎饼果子
	self.item18 = self.image:AddChild(ImageButton("images/inventoryimages/buling_jianbingguozi.xml", "nil.tex"))
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
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
	end)
	--千层饼
	self.item19 = self.image:AddChild(ImageButton("images/inventoryimages/buling_qiancengbing.xml", "nil.tex"))
	self.item19:SetPosition(40, -130, 0)
	self.item19:SetOnClick(
	function ()

self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_qiancengbing.xml", "buling_qiancengbing.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_QIANCENGBING))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_QIANCENGBING))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "plantmeat.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "honey.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "plantmeat.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
	end)
	--香草布丁
	self.item20 = self.image:AddChild(ImageButton("images/inventoryimages/buling_xiangcaobuding.xml", "nil.tex"))
	self.item20:SetPosition(120, -130, 0)
	self.item20:SetOnClick(
	function ()

self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_xiangcaobuding.xml", "buling_xiangcaobuding.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_XIANGCAOBUDING))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_XIANGCAOBUDING))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages.xml", "tallbirdegg.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "petals.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages.xml", "goatmilk.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "honey.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_jiaobanbo.xml", "buling_cook_jiaobanbo.tex"))
	end)
end
function buling_hechenglist_clothes:Close()
	self.openui = false
	self:Hide()
end
function buling_hechenglist_clothes:Open()
	self.openui = true
	self:Show()
end

function buling_hechenglist_clothes:QK()
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
function buling_hechenglist_clothes:CK()
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
return buling_hechenglist_clothes