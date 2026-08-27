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


buling_hechenglist_food = Class(Widget, function(self,owner)
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
	self.pagemax = 3
	local _owner = self.owner or ThePlayer
	_owner:ListenForEvent("OpenBuling_food",function()
		self:Open()
	end)
	local _owner = self.owner or ThePlayer
	_owner:ListenForEvent("CloseBuling_food",function()
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
function buling_hechenglist_food:flip()
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
function buling_hechenglist_food:page1()
	--烤盘
	self.item1 = self.image:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
	self.item1:SetPosition(-120, 190, 0)
	self.item1:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_cook_kaopan")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 50,STRINGS.NAMES.BULING_COOK_KAOPAN))
		self.text1:SetPosition(50, 100, 0)
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_COOK_KAOPAN))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "goldnugget.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "goldnugget.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "goldnugget.tex"))
	end)
	--锅
	self.item2 = self.image:AddChild(ImageButton("images/inventoryimages/buling_cook_guo.xml", "buling_cook_guo.tex"))
	self.item2:SetPosition(-40, 190, 0)
	self.item2:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_cook_guo")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_cook_guo.xml", "buling_cook_guo.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 50,STRINGS.NAMES.BULING_COOK_GUO))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_COOK_GUO))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "rocks.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "rocks.tex"))
		self.cailiao7 = self.gezi7:AddChild(ImageButton("images/inventoryimages.xml", "rocks.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages.xml", "rocks.tex"))
		self.cailiao9 = self.gezi9:AddChild(ImageButton("images/inventoryimages.xml", "rocks.tex"))
	end)
	--菜刀
	self.item3 = self.image:AddChild(ImageButton("images/inventoryimages/buling_cook_caidao.xml", "buling_cook_caidao.tex"))
	self.item3:SetPosition(40, 190, 0)
	self.item3:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_cook_caidao")
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
	--面包
	self.item4 = self.image:AddChild(ImageButton("images/inventoryimages/buling_bread.xml", "nil.tex"))--备用
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
	--稀饭
	self.item5 = self.image:AddChild(ImageButton("images/inventoryimages/buling_xifan.xml", "buling_xifan.tex"))
	self.item5:SetPosition(-120, 110, 0)
	self.item5:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_xifan")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_xifan.xml", "buling_xifan.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_XIFAN))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_XIFAN))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_guo.xml", "buling_cook_guo.tex"))
	end)
	--蔬菜碎
	self.item6 = self.image:AddChild(ImageButton("images/inventoryimages/buling_shucaisui.xml", "buling_shucaisui.tex"))
	self.item6:SetPosition(-40, 110, 0)
	self.item6:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_shucaisui")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_shucaisui.xml", "buling_shucaisui.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_SHUCAISUI))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_SHUCAISUI))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "carrot.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/hud.xml", "turnarrow_icon.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_cook_caidao.xml", "buling_cook_caidao.tex"))
	end)
	--[[红菇粥
	self.item6 = self.image:AddChild(ImageButton("images/inventoryimages/buling_hongguzhou.xml", "buling_hongguzhou.tex"))
	self.item6:SetPosition(-40, 110, 0)
	self.item6:SetOnClick(
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
	end)]]
	--奶油慕斯
	self.item7 = self.image:AddChild(ImageButton("images/inventoryimages/buling_cream.xml", "buling_cream.tex"))
	self.item7:SetPosition(40, 110, 0)
	self.item7:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_cream")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_cream.xml", "buling_cream.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_CREAM))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CREAM))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "bird_egg.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/hud.xml", "turnarrow_icon.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_cook_caidao.xml", "buling_cook_caidao.tex"))
	end)
	--[[蓝菇粥
	self.item7 = self.image:AddChild(ImageButton("images/inventoryimages/buling_languzhou.xml", "buling_languzhou.tex"))
	self.item7:SetPosition(40, 110, 0)
	self.item7:SetOnClick(
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
	end)]]
	--面包
	self.item8 = self.image:AddChild(ImageButton("images/inventoryimages/buling_bread.xml", "buling_bread.tex"))
	self.item8:SetPosition(120, 110, 0)
	self.item8:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_bread")
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
	--[[绿菇粥
	self.item8 = self.image:AddChild(ImageButton("images/inventoryimages/buling_lvguzhou.xml", "buling_lvguzhou.tex"))
	self.item8:SetPosition(120, 110, 0)
	self.item8:SetOnClick(
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
	end)]]
	--蘑菇天国
	self.item9 = self.image:AddChild(ImageButton("images/inventoryimages/buling_sangubao.xml", "buling_sangubao.tex"))
	self.item9:SetPosition(-120, 30, 0)
	self.item9:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_sangubao")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_sangubao.xml", "buling_sangubao.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_SANGUBAO))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 20,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_SANGUBAO))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages.xml", "red_cap.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "green_cap.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages.xml", "blue_cap.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_xifan.xml", "buling_xifan.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_guo.xml", "buling_cook_guo.tex"))
	end)
	--菇盒
	self.item10 = self.image:AddChild(ImageButton("images/inventoryimages/buling_suanrongguhe.xml", "buling_suanrongguhe.tex"))
	self.item10:SetPosition(-40, 30, 0)
	self.item10:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_suanrongguhe")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_suanrongguhe.xml", "buling_suanrongguhe.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_SUANRONGGUHE))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 20,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_SUANRONGGUHE))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "red_cap.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "green_cap.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "blue_cap.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
	end)
	--蘑菇汉堡
	self.item11 = self.image:AddChild(ImageButton("images/inventoryimages/buling_moguhanbao.xml", "buling_moguhanbao.tex"))
	self.item11:SetPosition(40, 30, 0)
	self.item11:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_moguhanbao")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_moguhanbao.xml", "buling_moguhanbao.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_MOGUHANBAO))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 20,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_MOGUHANBAO))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages/buling_bread.xml", "buling_bread.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages/buling_bread.xml", "buling_bread.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "red_cap.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "green_cap.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "blue_cap.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_caidao.xml", "buling_cook_caidao.tex"))
	end)
	--蘑菇汤
	self.item12 = self.image:AddChild(ImageButton("images/inventoryimages/buling_mogutang.xml", "buling_mogutang.tex"))
	self.item12:SetPosition(120, 30, 0)
	self.item12:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_mogutang")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_mogutang.xml", "buling_mogutang.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_MOGUTANG))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 20,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_MOGUTANG))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "red_cap.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "green_cap.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "blue_cap.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_guo.xml", "buling_cook_guo.tex"))
	end)
	--萝卜煲
	self.item13 = self.image:AddChild(ImageButton("images/inventoryimages/buling_luobubao.xml", "buling_luobubao.tex"))
	self.item13:SetPosition(-120, -50, 0)
	self.item13:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_luobubao")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_luobubao.xml", "buling_luobubao.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_LUOBUBAO))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_LUOBUBAO))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages.xml", "carrot.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "carrot.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages.xml", "carrot.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_xifan.xml", "buling_xifan.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_guo.xml", "buling_cook_guo.tex"))
	end)
	--萝卜丸子
	self.item14 = self.image:AddChild(ImageButton("images/inventoryimages/buling_zhaluobowanzi.xml", "buling_zhaluobowanzi.tex"))
	self.item14:SetPosition(-40, -50, 0)
	self.item14:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_zhaluobowanzi")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_zhaluobowanzi.xml", "buling_zhaluobowanzi.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_ZHALUOBOWANZI))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_ZHALUOBOWANZI))
		self.text2:SetPosition(80, -50, 0)
		
		
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "carrot.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
	end)
	--胡萝卜汤
	self.item15 = self.image:AddChild(ImageButton("images/inventoryimages/buling_huluobotang.xml", "buling_huluobotang.tex"))
	self.item15:SetPosition(40, -50, 0)
	self.item15:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_huluobotang")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_huluobotang.xml", "buling_huluobotang.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_HULUOBOTANG))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_HULUOBOTANG))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "carrot.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "carrot.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "carrot.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_guo.xml", "buling_cook_guo.tex"))
	end)
	--萝卜蛋糕
	self.item16 = self.image:AddChild(ImageButton("images/inventoryimages/buling_luobodangao.xml", "buling_luobodangao.tex"))
	self.item16:SetPosition(120, -50, 0)
	self.item16:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_luobodangao")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_luobodangao.xml", "buling_luobodangao.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_LUOBODANGAO))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_LUOBODANGAO))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "carrot.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_bread.xml", "buling_bread.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "carrot.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
	end)
	--萝卜糕
	self.item17 = self.image:AddChild(ImageButton("images/inventoryimages/buling_luobogao.xml", "buling_luobogao.tex"))
	self.item17:SetPosition(-120, -130, 0)
	self.item17:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_luobogao")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_luobogao.xml", "buling_luobogao.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_LUOBOGAO))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_LUOBOGAO))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "radish.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "radish.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
	end)
	--浆果慕斯
	self.item18 = self.image:AddChild(ImageButton("images/inventoryimages/buling_jiangguomusi.xml", "buling_jiangguomusi.tex"))
	self.item18:SetPosition(-40, -130, 0)
	self.item18:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_jiangguomusi")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_jiangguomusi.xml", "buling_jiangguomusi.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_JIANGGUOMUSI))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_JIANGGUOMUSI))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_cream.xml", "buling_cream.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "berries.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
	end)
	--浆果蛋糕
	self.item19 = self.image:AddChild(ImageButton("images/inventoryimages/buling_jiangguodangao.xml", "buling_jiangguodangao.tex"))
	self.item19:SetPosition(40, -130, 0)
	self.item19:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_jiangguodangao")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_jiangguodangao.xml", "buling_jiangguodangao.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_JIANGGUODANGAO))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_JIANGGUODANGAO))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages.xml", "berries.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "berries.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages.xml", "berries.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_bread.xml", "buling_bread.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
	end)
	--浆果三明治
	self.item20 = self.image:AddChild(ImageButton("images/inventoryimages/buling_jiangguosanmingzhi.xml", "buling_jiangguosanmingzhi.tex"))
	self.item20:SetPosition(120, -130, 0)
	self.item20:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_jiangguosanmingzhi")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_jiangguosanmingzhi.xml", "buling_jiangguosanmingzhi.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_JIANGGUOSANMINGZHI))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_JIANGGUOSANMINGZHI))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages.xml", "berries.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_bread.xml", "buling_bread.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages.xml", "berries.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "berries.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_bread.xml", "buling_bread.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "berries.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_caidao.xml", "buling_cook_caidao.tex"))
	end)
end
function buling_hechenglist_food:page2()
	--果冻卷
	self.item1 = self.image:AddChild(ImageButton("images/inventoryimages/buling_guodongjuan.xml", "buling_guodongjuan.tex"))
	self.item1:SetPosition(-120, 190, 0)
	self.item1:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_guodongjuan")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_guodongjuan.xml", "buling_guodongjuan.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 50,STRINGS.NAMES.BULING_GUODONGJUAN))
		self.text1:SetPosition(50, 100, 0)
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_GUODONGJUAN))
		self.text2:SetPosition(80, -50, 0)
		
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages.xml", "bird_egg.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_cream.xml", "buling_cream.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages.xml", "bird_egg.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "berries.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "berries.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
	end)
	--果酱通心粉
	self.item2 = self.image:AddChild(ImageButton("images/inventoryimages/buling_guojiangtongxinfen.xml", "buling_guojiangtongxinfen.tex"))
	self.item2:SetPosition(-40, 190, 0)
	self.item2:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_guojiangtongxinfen")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_guojiangtongxinfen.xml", "buling_guojiangtongxinfen.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 50,STRINGS.NAMES.BULING_GUOJIANGTONGXINFEN))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_GUOJIANGTONGXINFEN))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "jammypreserves.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "berries.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_guo.xml", "buling_cook_guo.tex"))
	end)
	--奶酪通心粉
	self.item3 = self.image:AddChild(ImageButton("images/inventoryimages/buling_nailaotongxinfen.xml", "buling_nailaotongxinfen.tex"))
	self.item3:SetPosition(40, 190, 0)
	self.item3:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_nailaotongxinfen")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_nailaotongxinfen.xml", "buling_nailaotongxinfen.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 50,STRINGS.NAMES.BULING_NAILAOTONGXINFEN))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_NAILAOTONGXINFEN))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "goatmilk.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "goatmilk.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_guo.xml", "buling_cook_guo.tex"))
	end)
	--爆浆蛋糕
	self.item4 = self.image:AddChild(ImageButton("images/inventoryimages/buling_baojiangdangao.xml", "buling_baojiangdangao.tex"))
	self.item4:SetPosition(120, 190, 0)
	self.item4:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_baojiangdangao")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_baojiangdangao.xml", "buling_baojiangdangao.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_BAOJIANGDANGAO))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_BAOJIANGDANGAO))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages/buling_shucaisui.xml", "buling_shucaisui.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_bread.xml", "buling_bread.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages/buling_shucaisui.xml", "buling_shucaisui.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
	end)
	--咖啡糖
	self.item5 = self.image:AddChild(ImageButton("images/inventoryimages/buling_kafeitang.xml", "buling_kafeitang.tex"))
	self.item5:SetPosition(-120, 110, 0)
	self.item5:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_kafeitang")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_kafeitang.xml", "buling_kafeitang.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_KAFEITANG))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_KAFEITANG))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages.xml", "coffeebeans.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "coffeebeans.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages.xml", "coffeebeans.tex"))
		self.cailiao4 = self.gezi4:AddChild(ImageButton("images/inventoryimages.xml", "honey.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages.xml", "coffeebeans.tex"))
		self.cailiao6 = self.gezi6:AddChild(ImageButton("images/inventoryimages.xml", "honey.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
	end)
	--奥利奥
	self.item6 = self.image:AddChild(ImageButton("images/inventoryimages/buling_aoliao.xml", "buling_aoliao.tex"))
	self.item6:SetPosition(-40, 110, 0)
	self.item6:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_aoliao")
self:QK()
		self.tubiao = self.image2:AddChild(Image("images/inventoryimages/buling_aoliao.xml", "buling_aoliao.tex"))
		self.tubiao:SetPosition(-100, 100, 0)
		
		self.text1 = self.image2:AddChild(Text(BODYTEXTFONT, 60,STRINGS.NAMES.BULING_AOLIAO))
		self.text1:SetPosition(50, 100, 0)
		
		self.text2 = self.image2:AddChild(Text(BODYTEXTFONT, 30,STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_AOLIAO))
		self.text2:SetPosition(80, -50, 0)
			
		self.cailiao1 = self.gezi1:AddChild(ImageButton("images/inventoryimages.xml", "coffeebeans.tex"))
		self.cailiao2 = self.gezi2:AddChild(ImageButton("images/inventoryimages.xml", "coffeebeans.tex"))
		self.cailiao3 = self.gezi3:AddChild(ImageButton("images/inventoryimages.xml", "coffeebeans.tex"))
		self.cailiao5 = self.gezi5:AddChild(ImageButton("images/inventoryimages/buling_flour.xml", "buling_flour.tex"))
		self.cailiao8 = self.gezi8:AddChild(ImageButton("images/inventoryimages/buling_cook_kaopan.xml", "buling_cook_kaopan.tex"))
	end)
	--宾卡馅饼
	self.item7 = self.image:AddChild(ImageButton("images/inventoryimages/buling_bingkaxianbing.xml", "buling_bingkaxianbing.tex"))
	self.item7:SetPosition(40, 110, 0)
	self.item7:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_bingkaxianbing")
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
	self.item8 = self.image:AddChild(ImageButton("images/inventoryimages/buling_kaolengmian.xml", "buling_kaolengmian.tex"))
	self.item8:SetPosition(120, 110, 0)
	self.item8:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_kaolengmian")
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
	self.item9 = self.image:AddChild(ImageButton("images/inventoryimages/buling_sanmingzhi.xml", "buling_sanmingzhi.tex"))
	self.item9:SetPosition(-120, 30, 0)
	self.item9:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_sanmingzhi")
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
	self.item10 = self.image:AddChild(ImageButton("images/inventoryimages/buling_jianbingguozi.xml", "buling_jianbingguozi.tex"))
	self.item10:SetPosition(-40, 30, 0)
	self.item10:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_jianbingguozi")
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
	self.item11 = self.image:AddChild(ImageButton("images/inventoryimages/buling_qiancengbing.xml", "buling_qiancengbing.tex"))
	self.item11:SetPosition(40, 30, 0)
	self.item11:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_qiancengbing")
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
	self.item12 = self.image:AddChild(ImageButton("images/inventoryimages/buling_xiangcaobuding.xml", "buling_xiangcaobuding.tex"))
	self.item12:SetPosition(120, 30, 0)
	self.item12:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_xiangcaobuding")
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
	self.item13 = self.image:AddChild(ImageButton("images/inventoryimages/buling_tianmishala.xml", "buling_tianmishala.tex"))
	self.item13:SetPosition(-120, -50, 0)
	self.item13:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_tianmishala")
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
	self.item14 = self.image:AddChild(ImageButton("images/inventoryimages/buling_xiangjiaoxianbing.xml", "buling_xiangjiaoxianbing.tex"))
	self.item14:SetPosition(-40, -50, 0)
	self.item14:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_xiangjiaoxianbing")
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
	self.item15 = self.image:AddChild(ImageButton("images/inventoryimages/buling_xiguazhi.xml", "buling_xiguazhi.tex"))
	self.item15:SetPosition(40, -50, 0)
	self.item15:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_xiguazhi")
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
	self.item16 = self.image:AddChild(ImageButton("images/inventoryimages/buling_suroudacan.xml", "buling_suroudacan.tex"))
	self.item16:SetPosition(120, -50, 0)
	self.item16:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_suroudacan")
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
	self.item17 = self.image:AddChild(ImageButton("images/inventoryimages/buling_fangxingjiaotang.xml", "buling_fangxingjiaotang.tex"))
	self.item17:SetPosition(-120, -130, 0)
	self.item17:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_fangxingjiaotang")
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
	self.item18 = self.image:AddChild(ImageButton("images/inventoryimages/buling_kaodigua.xml", "buling_kaodigua.tex"))
	self.item18:SetPosition(-40, -130, 0)
	self.item18:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_kaodigua")
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
	self.item19 = self.image:AddChild(ImageButton("images/inventoryimages/buling_fanshuni.xml", "buling_fanshuni.tex"))
	self.item19:SetPosition(40, -130, 0)
	self.item19:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_fanshuni")
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
	self.item20 = self.image:AddChild(ImageButton("images/inventoryimages/buling_fanshujianbing.xml", "buling_fanshujianbing.tex"))
	self.item20:SetPosition(120, -130, 0)
	self.item20:SetOnClick(
	function ()

		SendModRPCToServer(MOD_RPC["bulingbuling"]["craft_item_free"], "buling_fanshujianbing")
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
function buling_hechenglist_food:page3()
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
function buling_hechenglist_food:Close()
	self.openui = false
	self:Hide()
end
function buling_hechenglist_food:Open()
	self.openui = true
	self:Show()
end

function buling_hechenglist_food:QK()
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
function buling_hechenglist_food:CK()
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
return buling_hechenglist_food