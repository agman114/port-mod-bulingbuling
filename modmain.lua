
local function SendBulingRPC(rpc_name, ...)
	local rpc = (GLOBAL.GetModRPC and GLOBAL.GetModRPC("bulingbuling", rpc_name)) 
		or (GLOBAL.MOD_RPC and GLOBAL.MOD_RPC["bulingbuling"] and GLOBAL.MOD_RPC["bulingbuling"][rpc_name])
	if rpc then
		GLOBAL.SendModRPCToServer(rpc, ...)
	end
end

local env = (GLOBAL.getfenv and GLOBAL.getfenv(1)) or _ENV
if env then
    local env_meta = GLOBAL.getmetatable(env) or {}
    local old_index = env_meta.__index
    env_meta.__index = function(t, k)
        local v = GLOBAL.rawget(GLOBAL, k)
        if v ~= nil then
            return v
        end
        if type(old_index) == "function" then
            return old_index(t, k)
        elseif type(old_index) == "table" then
            return old_index[k]
        end
    end
    GLOBAL.setmetatable(env, env_meta)
end

local require = GLOBAL.require
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local Recipe = GLOBAL.Recipe
local STRINGS = GLOBAL.STRINGS
local ACTIONS = GLOBAL.ACTIONS
if GLOBAL.ACTIONS and GLOBAL.ACTIONS.SHEAR == nil then
	GLOBAL.ACTIONS.SHEAR = GLOBAL.ACTIONS.DIG or GLOBAL.ACTIONS.HACK or GLOBAL.ACTIONS.CHOP
end
local TECH = GLOBAL.TECH
local orig_resolvefilepath = GLOBAL.resolvefilepath
if orig_resolvefilepath then
    GLOBAL.resolvefilepath = function(filepath, ...)
        if type(filepath) == "string" then
            if filepath:find("avatar_bulingbuling") then
                if filepath:sub(-4) == ".xml" then
                    return orig_resolvefilepath("images/saveslot_portraits/bulingbuling.xml", ...)
                elseif filepath:sub(-4) == ".tex" then
                    return orig_resolvefilepath("images/saveslot_portraits/bulingbuling.tex", ...)
                end
            elseif filepath == "images/globalpanels.xml" or filepath == "images/globalpanels2.xml" then
                local res = orig_resolvefilepath(filepath, ...)
                if res then return res end
                return orig_resolvefilepath("images/globalpanels2.xml", ...) or orig_resolvefilepath("images/global_redux.xml", ...) or orig_resolvefilepath("images/hud.xml", ...)
            elseif filepath == "images/inventoryimages_2.xml" then
                local res = orig_resolvefilepath("images/inventoryimages2.xml", ...)
                if res then return res end
                return orig_resolvefilepath("images/inventoryimages.xml", ...)
            end
        end
        return orig_resolvefilepath(filepath, ...)
    end
end

STRINGS.UI = STRINGS.UI or {}
STRINGS.UI.CRAFTING_FILTERS = STRINGS.UI.CRAFTING_FILTERS or {}
STRINGS.UI.CRAFTING_FILTERS.BLTAB = "不灵科技"
STRINGS.UI.CRAFTING_FILTERS.YJTAB = "研究项目"
STRINGS.UI.CRAFTING_FILTERS["BLTAB"] = "不灵科技"
STRINGS.UI.CRAFTING_FILTERS["YJTAB"] = "研究项目"

local orig_Recipe = GLOBAL.Recipe
if orig_Recipe then
    GLOBAL.Recipe = function(name, ingredients, tab, level, min_spacing, placer, min_type, numtogive, builder_tag, atlas, image, ...)
        local rec = orig_Recipe(name, ingredients, tab, level, min_spacing, placer, min_type, numtogive, builder_tag, atlas, image, ...)
        if name then
            local filter_id = (tab and type(tab) == "table" and tab.str) or "BLTAB"
            local fn_add_to_filter = GLOBAL.rawget(GLOBAL, "AddRecipeToFilter")
            if fn_add_to_filter == nil and env then
                fn_add_to_filter = env.AddRecipeToFilter
            end
            if fn_add_to_filter then
                pcall(fn_add_to_filter, name, filter_id)
                pcall(fn_add_to_filter, name, "CHARACTER")
                pcall(fn_add_to_filter, name, "EVERYTHING")
            end
        end
        return rec
    end
end

local default_mod_widget = {
    slotpos = {
        GLOBAL.Vector3(-80, 80, 0), GLOBAL.Vector3(0, 80, 0), GLOBAL.Vector3(80, 80, 0),
        GLOBAL.Vector3(-80, 0, 0),  GLOBAL.Vector3(0, 0, 0),  GLOBAL.Vector3(80, 0, 0),
        GLOBAL.Vector3(-80, -80, 0),GLOBAL.Vector3(0, -80, 0),GLOBAL.Vector3(80, -80, 0),
    },
    animbank = "ui_chest_3x3",
    animbuild = "ui_chest_3x3",
    pos = GLOBAL.Vector3(0, 200, 0),
    side_align_tip = 100,
    type = "chest",
}

local mod_container_prefabs = {
    "buling_car_log", "buling_rocky", "buling_glomling", "buling_plane", "buling_carrier", "buling_chest_5x5",
    "buling_boat",
    "buling_box",
    "buling_box2",
    "buling_bee_box",
    "buling_cave_entrance",
    "buling_carrier",
    "buling_food",
    "buling_gun",
    "buling_item",
    "buling_zaxiang_old",
    "buling_manual",
    "buling_cooktable",
    "buling_cooktable_item",
    "buling_fengrenji",
    "buling_fengrenji_item",
    "buling_weaponchest",
    "buling_weaponchest_item",
    "buling_wakuang",
    "buling_wakuang_item",
    "buling_cave_tool",
    "buling_yanjiutai",
    "buling_tongxuntai",
    "buling_tongxuntai_item",
    "buling_seedchest",
    "buling_seedsbox",
    "buling_shuipei",
    "buling_shuipei_item",
}

local containers = GLOBAL.require("containers")
if containers then
    local orig_widgetsetup = containers.widgetsetup
    containers.widgetsetup = function(container, prefab, data, ...)
        orig_widgetsetup(container, prefab, data, ...)

        if container and container.widget == nil then
            local inst = container.inst
            local p_name = prefab or (inst and inst.prefab)
            local c_comp = (inst and inst.components and inst.components.container) or container
            local slots = (c_comp and c_comp.widgetslotpos) or (container.widgetslotpos) or default_mod_widget.slotpos
            container.widget = {
                slotpos = slots,
                animbank = (c_comp and c_comp.widgetanimbank) or container.widgetanimbank or "ui_chest_3x3",
                animbuild = (c_comp and c_comp.widgetanimbuild) or container.widgetanimbuild or "ui_chest_3x3",
                pos = (c_comp and c_comp.widgetpos) or container.widgetpos or GLOBAL.Vector3(0, 200, 0),
                buttoninfo = (c_comp and c_comp.widgetbuttoninfo) or container.widgetbuttoninfo,
                side_align_tip = 100,
                type = "chest",
            }
            if container.SetNumSlots then
                container:SetNumSlots(#slots)
            end
        end
    end

    if containers.params then
        local params = containers.params

        for _, name in ipairs(mod_container_prefabs) do
            params[name] = params[name] or {
                widget = default_mod_widget,
                acceptsstacks = true,
                type = "chest",
            }
        end

        local function ensure_widget(tbl)
            if type(tbl) == "table" then
                if tbl.widget == nil or type(tbl.widget) ~= "table" then
                    tbl.widget = default_mod_widget
                end
                if tbl.acceptsstacks == nil then
                    tbl.acceptsstacks = true
                end
                if tbl.type == nil then
                    tbl.type = "chest"
                end
                if tbl.itemtestfn == nil then
                    tbl.itemtestfn = function(container, item, slot) return true end
                end
            end
            return tbl
        end

        local meta = GLOBAL.getmetatable(params) or {}
        local old_idx = meta.__index
        meta.__index = function(t, k)
            local res = nil
            if type(old_idx) == "function" then
                res = old_idx(t, k)
            elseif type(old_idx) == "table" then
                res = old_idx[k]
            end
            if res == nil then
                res = { widget = default_mod_widget, acceptsstacks = true, type = "chest" }
                t[k] = res
            end
            return ensure_widget(res)
        end
        GLOBAL.setmetatable(params, meta)

        for k, v in pairs(params) do
            ensure_widget(v)
        end
    end
end

local ContainerReplica = GLOBAL.require("components/container_replica")
if ContainerReplica then
    local orig_Replica_GetWidget = ContainerReplica.GetWidget
    ContainerReplica.GetWidget = function(self, ...)
        local w = orig_Replica_GetWidget and orig_Replica_GetWidget(self, ...)
        if w ~= nil then
            return w
        end
        if self.widget == nil then
            local inst = self.inst
            local p = (inst and inst.prefab) or "chest"
            if containers and containers.widgetsetup then
                containers.widgetsetup(self, p)
            end
            if self.widget == nil then
                local c_comp = inst and inst.components and inst.components.container
                local slots = (c_comp and c_comp.widgetslotpos) or (self.widgetslotpos) or default_mod_widget.slotpos
                self.widget = {
                    slotpos = slots,
                    animbank = (c_comp and c_comp.widgetanimbank) or self.widgetanimbank or "ui_chest_3x3",
                    animbuild = (c_comp and c_comp.widgetanimbuild) or self.widgetanimbuild or "ui_chest_3x3",
                    pos = (c_comp and c_comp.widgetpos) or self.widgetpos or GLOBAL.Vector3(0, 200, 0),
                    buttoninfo = (c_comp and c_comp.widgetbuttoninfo) or self.widgetbuttoninfo,
                    buttoninfo2 = (c_comp and c_comp.widgetbuttoninfo2) or self.widgetbuttoninfo2,
                    side_align_tip = 100,
                    type = "chest",
                }
            end
        end
        return self.widget
    end
end

local prefab_open_events = {
	-- Basic / Manual Crafting Tables
	["buling_manual"] = { open = "OpenBuling_manual", close = "CloseBuling_manual" },
	["bulingbox"] = { open = "OpenBuling_manual", close = "CloseBuling_manual" },
	["buling_pilianghecheng"] = { open = "OpenBuling_manual", close = "CloseBuling_manual" },
	["buling_zidonghecheng"] = { open = "OpenBuling_manual", close = "CloseBuling_manual" },

	-- Food / Cook Tables
	["buling_cooktable"] = { open = "OpenBuling_food", close = "CloseBuling_food" },
	["buling_food"] = { open = "OpenBuling_food", close = "CloseBuling_food" },
	["cooktable"] = { open = "OpenBuling_food", close = "CloseBuling_food" },

	-- Sewing / Clothes / Chemistry Tables
	["buling_fengrenji"] = { open = "OpenBuling_cloth", close = "CloseBuling_cloth" },
	["bulingchemistrytable"] = { open = "OpenBuling_cloth", close = "CloseBuling_cloth" },

	-- Research / Extraction / Furnace Tables
	["buling_yanjiutai"] = { open = "OpenBuling_cuiqu", close = "CloseBuling_cuiqu" },
	["buling_ronglu"] = { open = "OpenBuling_cuiqu", close = "CloseBuling_cuiqu" },
	["buling_ronglu2"] = { open = "OpenBuling_cuiqu", close = "CloseBuling_cuiqu" },

	-- Machinery / Communication / Weapon / Vehicle Tables
	["buling_car_log"] = { open = "OpenBuling_jixiejiaognglu", close = "CloseBuling_jixiejiaognglu" },
	["buling_rocky"] = { open = "OpenBuling_jixiejiaognglu", close = "CloseBuling_jixiejiaognglu" },
	["buling_glomling"] = { open = "OpenBuling_jixiejiaognglu", close = "CloseBuling_jixiejiaognglu" },
	["buling_plane"] = { open = "OpenBuling_jixiejiaognglu", close = "CloseBuling_jixiejiaognglu" },
	["buling_tongxuntai"] = { open = "OpenBuling_jixiejiaognglu", close = "CloseBuling_jixiejiaognglu" },
	["tongxuntai"] = { open = "OpenBuling_jixiejiaognglu", close = "CloseBuling_jixiejiaognglu" },
	["buling_weaponchest"] = { open = "OpenBuling_jixiejiaognglu", close = "CloseBuling_jixiejiaognglu" },
	["buling_fensui"] = { open = "OpenBuling_jixiejiaognglu", close = "CloseBuling_jixiejiaognglu" },

	-- Plant / Hydroponic / Alcohol Tables
	["buling_shuipei"] = { open = "OpenBuling_planttable", close = "CloseBuling_planttable" },
		["buling_planttable"] = { open = "OpenBuling_planttable", close = "CloseBuling_planttable" },
	["buling_seedbox"] = { open = "OpenBuling_planttable", close = "CloseBuling_planttable" },
	["planttable"] = { open = "OpenBuling_planttable", close = "CloseBuling_planttable" },
	["buling_alcoholtable"] = { open = "OpenBuling_planttable", close = "CloseBuling_planttable" },
		["buling_seedbox"] = { open = "OpenBuling_planttable", close = "CloseBuling_planttable" },
}

local ContainerWidget = GLOBAL.require("widgets/containerwidget")
if ContainerWidget then
    local orig_Widget_Open = ContainerWidget.Open
    ContainerWidget.Open = function(self, container, doer, ...)
        if container then
            local c_rep = container.replica and container.replica.container
            if c_rep and c_rep.widget == nil then
                c_rep:GetWidget()
            end
            local prefab = container.prefab or (container.inst and container.inst.prefab)
            if prefab and containers and containers.params then
                local p = containers.params[prefab]
                if p == nil or type(p) ~= "table" or p.widget == nil or type(p.widget) ~= "table" then
                    local c_comp = container.components and container.components.container
                    local slots = (c_comp and c_comp.widgetslotpos) or default_mod_widget.slotpos
                    containers.params[prefab] = {
                        widget = {
                            slotpos = slots,
                            animbank = (c_comp and c_comp.widgetanimbank) or "ui_chest_3x3",
                            animbuild = (c_comp and c_comp.widgetanimbuild) or "ui_chest_3x3",
                            pos = (c_comp and c_comp.widgetpos) or GLOBAL.Vector3(0, 200, 0),
                            buttoninfo = (c_comp and c_comp.widgetbuttoninfo),
                            buttoninfo2 = (c_comp and c_comp.widgetbuttoninfo2),
                            side_align_tip = 100,
                            type = "chest",
                        },
                        acceptsstacks = true,
                        type = "chest",
                    }
                end
            end
                        local ev = prefab and (prefab_open_events[prefab] or (c_comp and c_comp.widgetbuttoninfo and { open = "OpenBuling_manual", close = "CloseBuling_manual" }))
            if ev and GLOBAL.ThePlayer then
                GLOBAL.ThePlayer:PushEvent(ev.open, { container = container })
            end
        end
        return orig_Widget_Open(self, container, doer, ...)
    end

    local orig_Widget_Close = ContainerWidget.Close
    ContainerWidget.Close = function(self, ...)
        if self.container then
            local prefab = self.container.prefab or (self.container.inst and self.container.inst.prefab)
            local ev = prefab and (prefab_open_events[prefab] or { open = "OpenBuling_manual", close = "CloseBuling_manual" })
            if ev and GLOBAL.ThePlayer then
                GLOBAL.ThePlayer:PushEvent(ev.close)
            end
        end
        return orig_Widget_Close(self, ...)
    end
end

AddComponentPostInit("container", function(self, inst)
    local orig_Open = self.Open
    self.Open = function(self, doer, ...)
        if inst and inst.prefab and containers and containers.params then
            local p = containers.params[inst.prefab] or {}
            containers.params[inst.prefab] = p

            local slots = self.widgetslotpos or (p.widget and p.widget.slotpos) or default_mod_widget.slotpos
            if #slots == 0 and self.numslots and self.numslots > 0 then
                for i = 1, self.numslots do
                    table.insert(slots, GLOBAL.Vector3(0, 0, 0))
                end
            end

            local widget_tbl = {
                slotpos = slots,
                animbank = self.widgetanimbank or (p.widget and p.widget.animbank) or "ui_chest_3x3",
                animbuild = self.widgetanimbuild or (p.widget and p.widget.animbuild) or "ui_chest_3x3",
                pos = self.widgetpos or (p.widget and p.widget.pos) or GLOBAL.Vector3(0, 200, 0),
                buttoninfo = self.widgetbuttoninfo or (p.widget and p.widget.buttoninfo),
                side_align_tip = self.side_align_tip or self.widgetsidealigntip or (p.widget and p.widget.side_align_tip) or 100,
                type = self.widgettype or self.type or (p.widget and p.widget.type) or "chest",
            }
            if type(self.widget) == "table" then
                for k, v in pairs(widget_tbl) do
                    self.widget[k] = v
                end
            else
                pcall(function() self.widget = widget_tbl end)
            end
            p.widget = widget_tbl
            p.acceptsstacks = self.acceptsstacks ~= false
            p.type = widget_tbl.type
        end
        return orig_Open(self, doer, ...)
    end
end)

AddClassPostConstruct("widgets/redux/craftingmenu_widget", function(self)
    local orig_MakeFilterButton = self.MakeFilterButton
    if orig_MakeFilterButton then
        self.MakeFilterButton = function(self, filter, ...)
            if filter and filter.str then
                GLOBAL.STRINGS.UI.CRAFTING_FILTERS = GLOBAL.STRINGS.UI.CRAFTING_FILTERS or {}
                GLOBAL.STRINGS.UI.CRAFTING_FILTERS[filter.str] = GLOBAL.STRINGS.UI.CRAFTING_FILTERS[filter.str] or filter.modname or filter.str
            end
            local btn = orig_MakeFilterButton(self, filter, ...)
            if btn and not btn.hovertext then
                btn:SetHoverText(GLOBAL.STRINGS.UI.CRAFTING_FILTERS[filter.str] or filter.str or "")
            end
            return btn
        end
    end
end)







	PrefabFiles = {
	"bulingbuling",
	"buling_box",
	"buling_box2",
	"buling_boat",
	"buling_plant",
	"buling_item",
	"buling_hulk",
	"buling_zaxiang",
	"buling_system",
	"buling_food",
	"buling_weapon",
	"buling_firerain",
	"buling_carrier",
	"buling_build",
	"buling_player",
	"buling_gun",
	"buling_animal",
	"buling_exoskeleton",
	"buling_clothes",
	"buling_herald",
	"buling_test",
	"buling_bee",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/bulingbuling.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/bulingbuling.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/bulingbuling.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/bulingbuling.xml" ),
	
	Asset( "IMAGE", "images/selectscreen_portraits/bulingbuling_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/bulingbuling_silho.xml" ),

    Asset( "IMAGE", "bigportraits/bulingbuling.tex" ),
    Asset( "ATLAS", "bigportraits/bulingbuling.xml" ),
	
	Asset( "IMAGE", "images/map_icons/bulingbuling.tex" ),
	Asset( "ATLAS", "images/map_icons/bulingbuling.xml" ),
	
	Asset( "ATLAS", "images/bulingui/buling_close.xml" ),
	Asset( "ATLAS", "images/bulingui/bulingui.xml" ),
	Asset( "ATLAS", "images/bulingui/bulingui2.xml" ),
	Asset( "ATLAS", "images/bulingui/buling_text.xml" ),
	Asset( "ATLAS", "images/bulingui/buling_kuangjia.xml" ),
	Asset( "ATLAS", "images/bulingui/buling_img_button.xml" ),
	Asset( "ATLAS", "images/bulingui/buling_button.xml" ),
	Asset( "ATLAS", "images/bulingui/turnarrow_icon.xml" ),
	Asset( "ATLAS", "images/bulingui/buling_car_box.xml" ),
	Asset( "ATLAS", "images/bulingui/buling_rocky.xml" ),
	Asset( "ATLAS", "images/bulingui/buling_nyarlathotep.xml" ),
	Asset( "ATLAS", "levels/textures/buling_airship_floor2.xml" ),
	Asset( "ATLAS", "levels/textures/buling_airship_floor.xml" ),
	Asset( "IMAGE", "levels/textures/buling_airship_floor.tex" ),
	Asset( "ATLAS", "levels/textures/interiors/buling_air_wall2.xml" ),
	Asset( "ATLAS", "levels/textures/interiors/buling_airship_wall.xml" ),
	Asset( "IMAGE", "levels/textures/interiors/buling_airship_wall.tex" ),
	Asset( "ATLAS", "images/bulinggongye.xml" ),
	Asset( "ATLAS", "images/bulingyanjiu.xml" ),

	
	Asset("ANIM", "anim/generating_buling.zip"),
	Asset("ANIM", "anim/buling_player_basic.zip"),
	Asset("ANIM", "anim/buling_deerclops.zip"),
	Asset("ANIM", "anim/buling_action_atk.zip"),
	Asset("ANIM", "anim/buling_bianshen.zip"),
}

STRINGS.NAMES.BULINGBULING = "BulingBuling"
AddMinimapAtlas("images/map_icons/bulingbuling.xml")
AddModCharacter("bulingbuling", "FEMALE")

-- Setup Custom Recipe Tabs & DST Crafting Filters
GLOBAL.RECIPETABS['BLTAB'] = {str = 'BLTAB', sort=12, priority = 4, icon = "bulinggongye.tex", icon_atlas = "images/bulinggongye.xml", crafting_station = true, modname = "不灵科技"}
GLOBAL.RECIPETABS['YJTAB'] = {str = 'YJTAB', sort=12, priority = 5, icon = "bulingyanjiu.tex", icon_atlas = "images/bulingyanjiu.xml", crafting_station = true, modname = "研究项目"}

if AddRecipeFilter then
    AddRecipeFilter({
        name = "BLTAB",
        atlas = "images/bulinggongye.xml",
        image = "bulinggongye.tex",
    })
    AddRecipeFilter({
        name = "YJTAB",
        atlas = "images/bulingyanjiu.xml",
        image = "bulingyanjiu.tex",
    })
end

modimport "scripts/string_bulingbuling.lua"
modimport "scripts/hamletislandconnector.lua"
modimport("scripts/buling_gengxin.lua")

-- Pre-declare CommonStates and CommonHandlers in GLOBAL to satisfy strict.lua when require("stategraphs/commonstates") runs
if GLOBAL.rawget(GLOBAL, "CommonStates") == nil then
    GLOBAL.rawset(GLOBAL, "CommonStates", {})
end
if GLOBAL.rawget(GLOBAL, "CommonHandlers") == nil then
    GLOBAL.rawset(GLOBAL, "CommonHandlers", {})
end

-- Custom Stategraphs
modimport("scripts/stategraphs/SGbulingbuling.lua")
modimport("scripts/stategraphs/SGbuling_dragon_follower.lua")
modimport("scripts/stategraphs/SGbuling_shark.lua")
modimport("scripts/stategraphs/SGbuling_hunk.lua")

-- Mod RPC Handlers for DST Client-Server UI Communication
AddModRPCHandler("bulingbuling", "task_next", function(player)
	if player and player.components.buling_task then
		if player.components.buling_task:Getitem() == nil then
			player.components.buling_task:nexttask()
		else
			local item = player.components.buling_task:Getitem()
			local num = player.components.buling_task:Getitemnum()
			if player.components.inventory and player.components.inventory:Has(item, num) then
				player.components.buling_task:itemnexttask()
			end
		end
	end
end)


AddModRPCHandler("bulingbuling", "do_widget_button2", function(player, container_guid)
	print("[BULING DEBUG SERVER] Received do_widget_button2 RPC from player:", player, "guid:", container_guid)
	if container_guid then
		local container = GLOBAL.Ents[container_guid]
		if container and container.components and container.components.container then
			local buttoninfo2 = container.components.container.widgetbuttoninfo2 or (container.components.container.widget and container.components.container.widget.buttoninfo2)
			print("[BULING DEBUG SERVER] Found buttoninfo2:", buttoninfo2)
			if buttoninfo2 and buttoninfo2.fn then
				buttoninfo2.fn(container, player)
			end
		end
	end
end)

AddModRPCHandler("bulingbuling", "do_widget_button", function(player, container_guid)
	print("[BULING DEBUG SERVER] Received do_widget_button RPC from player:", player, "guid:", container_guid)
	if container_guid then
		local container = GLOBAL.Ents[container_guid]
		print("[BULING DEBUG SERVER] Found container entity:", container)
		if container and container.components and container.components.container then
			local buttoninfo = container.components.container.widgetbuttoninfo or (container.components.container.widget and container.components.container.widget.buttoninfo)
			print("[BULING DEBUG SERVER] Found buttoninfo:", buttoninfo)
			if buttoninfo and buttoninfo.fn then
				buttoninfo.fn(container, player)
			end
		end
	end
end)

AddModRPCHandler("bulingbuling", "set_task_num", function(player, num)
	if player and player.components.buling_task and num then
		player.components.buling_task.tasknum = num
	end
end)

-- UI Injection for controls
local uilist = {
	"buling_hechenglist_food",
	"buling_hechenglist_plant",
	"buling_hechenglist",
	"buling_hechenglist_jixie",
	"buling_hechenglist_clothes",
	"buling_system",
	"buling_hechenglist_extraction",
	"bulingnilui",
	"buling_communication",
}

AddClassPostConstruct("widgets/controls", function(self)
	if self.owner and self.containerroot then 
		self.bulinguis = {}
		for _, v in ipairs(uilist) do
			local uiClass = GLOBAL.require("widgets/"..v)
			if uiClass then
				local uiInst = self.containerroot:AddChild(uiClass(self.owner))
				if uiInst then
					uiInst:Hide()
				end
			end
		end
	end
end)

local function Addbeerui(self)
	if self and self.item then
		if self.item.components and self.item.components.beerpower and self.item:HasTag("buling_lingjian") then
			self:SetPercent(self.item.components.beerpower:GetPercent())
		end
		self.inst:ListenForEvent("beerupdate", function(inst, data)
			if data and data.percent then
				self:SetPercent(data.percent)
			end
        end, self.item)
	end
end
AddClassPostConstruct("widgets/itemtile", Addbeerui)

-- Actions
local BULING_STSTEM = GLOBAL.Action({}, 0, false, false, 1)
BULING_STSTEM.id = "BULING_STSTEM"
BULING_STSTEM.str = STRINGS.BULING_STSTEM or "Открыть терминал"
BULING_STSTEM.fn = function(act) 
	if act.doer then 
		if not act.target and act.invobject and (act.invobject.prefab == "buling_system" or act.invobject:HasTag("buling_system_item")) then 
			act.doer:PushEvent("OpenBuling_system")
			if SendModRPCToClient and GetClientModRPC then
				SendModRPCToClient(GetClientModRPC("BulingBuling", "OpenUI"), act.doer.userid, "OpenBuling_system")
			end
		elseif act.target and act.target.prefab == "buling_tongxuntai" then 
			act.doer:PushEvent("Openbuling_communication")
			if SendModRPCToClient and GetClientModRPC then
				SendModRPCToClient(GetClientModRPC("BulingBuling", "OpenUI"), act.doer.userid, "Openbuling_communication")
			end
		elseif act.invobject and act.invobject.prefab == "buling_system2" then 
			act.doer:PushEvent("OpenBuling_system2")
			if SendModRPCToClient and GetClientModRPC then
				SendModRPCToClient(GetClientModRPC("BulingBuling", "OpenUI"), act.doer.userid, "OpenBuling_system2")
			end
		end 
	end
	return true	
end
AddAction(BULING_STSTEM)
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.BULING_STSTEM, "doshortaction"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.BULING_STSTEM, function(inst, action)
	if action.invobject and (action.invobject.prefab == "buling_system" or action.invobject:HasTag("buling_system_item")) then 
		inst:PushEvent("OpenBuling_system")
	elseif action.target and action.target.prefab == "buling_tongxuntai" then 
		inst:PushEvent("Openbuling_communication")
	elseif action.invobject and action.invobject.prefab == "buling_system2" then 
		inst:PushEvent("OpenBuling_system2")
	end
	return "doshortaction"
end))

AddComponentAction("INVENTORY", "inventoryitem", function(inst, doer, actions, right)
	if inst.prefab == "buling_system" or inst:HasTag("buling_system_item") or inst.prefab == "buling_system2" then
		table.insert(actions, ACTIONS.BULING_STSTEM)
	end
end)

AddComponentAction("SCENE", "inspectable", function(inst, doer, actions, right)
	if inst.prefab == "buling_tongxuntai" then
		table.insert(actions, ACTIONS.BULING_STSTEM)
	end
end)

AddClientModRPCHandler("BulingBuling", "OpenUI", function(event_name)
	if GLOBAL.ThePlayer then
		GLOBAL.ThePlayer:PushEvent(event_name)
	end
end)

AddModRPCHandler("BulingBuling", "AdvanceTask", function(player)
	if player and player.components and player.components.buling_task then
		if player.components.buling_task:Getitem() == nil then
			player.components.buling_task:nexttask()
		else
			local req_item = player.components.buling_task:Getitem()
			local req_count = player.components.buling_task:Getitemnum()
			if player.components.inventory and player.components.inventory:Has(req_item, req_count) then
				player.components.buling_task:itemnexttask()
			elseif player.components.talker then
				player.components.talker:Say("Required item: " .. tostring(req_item) .. " x" .. tostring(req_count))
			end
		end
	end
end)

local BULING_ENZYME = GLOBAL.Action({mount_enabled=true})
BULING_ENZYME.id = "BULING_ENZYME"
BULING_ENZYME.str = STRINGS.BULING_ENZYME or "Extract Enzyme"
BULING_ENZYME.fn = function(act) 
	if act.target and act.invobject and act.invobject.components.buling_getenzyme and act.doer then
		if act.invobject.components.finiteuses then
			act.invobject.components.finiteuses:Use(1)
		end
		if act.doer.components.inventory then
			if act.target.enzyme and act.target.enzyme == "beta" then
				act.doer.components.inventory:GiveItem(SpawnPrefab("buling_juhemei_beta"))
			else
				act.doer.components.inventory:GiveItem(SpawnPrefab("buling_juhemei_alpha"))
			end
		end
		return true
	end
    return false
end
AddAction(BULING_ENZYME)
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.BULING_ENZYME, "dolongaction"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.BULING_ENZYME, "dolongaction"))

AddComponentAction("USEITEM", "buling_getenzyme", function(inst, doer, target, actions, right)
	if right and target then
		if (target.components.crop and target.components.crop.matured) 
		   or target:HasTag("buling_plant") 
		   or (target.components.pickable and target.components.pickable:CanBePicked()) then
			table.insert(actions, ACTIONS.BULING_ENZYME)
		end
	end
end)

-- Global Free Crafting Command and RPC Handlers
GLOBAL.BULING_FREE_CRAFT = false

local function DoDirCar(car, angle, is_moving)
	if car and car:IsValid() then
		if is_moving then
			if car.components.locomotor then
				car.components.locomotor:WalkInDirection(angle)
			end
			if car.sg and not car.sg:HasStateTag("moving") and not car.sg:HasStateTag("busy") then
				if car.sg:HasState("run") then
					car.sg:GoToState("run")
				elseif car.sg:HasState("walk") then
					car.sg:GoToState("walk")
				elseif car.sg:HasState("walk_start") then
					car.sg:GoToState("walk_start")
				end
			end
		else
			if car.components.locomotor then
				car.components.locomotor.wantstomoveforward = false
				car.components.locomotor.wantstoreachdestination = false
				car.components.locomotor:Stop()
				car.components.locomotor:StopMoving()
				car.components.locomotor:ResetPath()
			end
			if car.Physics then
				car.Physics:Stop()
				car.Physics:SetMotorVel(0, 0, 0)
			end
			if car.sg and not car.sg:HasStateTag("busy") then
				car.sg:GoToState("idle")
			end
		end
	end
end

AddModRPCHandler("bulingbuling", "dir_car", function(player, car_guid, angle, is_moving)
	if car_guid then
		local car = GLOBAL.Ents[car_guid]
		DoDirCar(car, angle, is_moving)
	end
end)

AddModRPCHandler("bulingbuling", "attack_car", function(player, vehicle_guid, target_guid)
	local inst_caster = (vehicle_guid and GLOBAL.Ents[vehicle_guid]) or player
	if inst_caster and inst_caster:IsValid() then
		if player and player.components.locomotor then
			player.components.locomotor:Stop()
			player.components.locomotor:StopMoving()
		end
		player:ClearBufferedAction()

		local target = (target_guid and GLOBAL.Ents[target_guid]) or (player and player.components.combat and player.components.combat.target)
		local targetpos = nil
		local x, y, z = player.Transform:GetWorldPosition()

		if target and target:IsValid() then
			targetpos = target:GetPosition()
		else
			local rad = (player.Transform:GetRotation() or 0) * GLOBAL.DEGREES
			targetpos = GLOBAL.Vector3(x + 14 * GLOBAL.math.cos(rad), 0, z - 14 * GLOBAL.math.sin(rad))
		end

		if player and player.SoundEmitter then
			player.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/boss/hulk_metal_robot/mine_shot")
		end

		for i = -2, 2 do
			local proj = GLOBAL.SpawnPrefab("ancient_hulk_mine")
			if proj then
				proj.primed = false
				proj.AnimState:PlayAnimation("spin_loop", true)
				proj.Transform:SetPosition(x, 1.8, z)
				local spread_pos = GLOBAL.Vector3(targetpos.x + i * 3, 0, targetpos.z + (i % 2) * 3)
				if proj.components.complexprojectile then
					proj.components.complexprojectile:SetHorizontalSpeed(25)
					proj.components.complexprojectile:SetGravity(-25)
					proj.components.complexprojectile:Launch(spread_pos, player, player)
				end
				proj.owner = player
			end
		end

		if inst_caster ~= player and inst_caster.sg then
			if inst_caster.sg:HasState("mine_shoot") then
				inst_caster.sg:GoToState("mine_shoot")
			elseif inst_caster.sg:HasState("lob") then
				inst_caster.lobtarget = targetpos
				inst_caster.sg:GoToState("lob")
			else
				inst_caster.sg:GoToState("attack")
			end
		end
	end
end)
GLOBAL.BULING_FREE_CRAFT = true
GLOBAL.c_bulingfreecraft = function(enable)
	if enable == nil then
		enable = not GLOBAL.BULING_FREE_CRAFT
	end
	GLOBAL.BULING_FREE_CRAFT = enable
	local status = GLOBAL.BULING_FREE_CRAFT and "ВКЛЮЧЕН" or "ВЫКЛЮЧЕН"
	print("[BULING] Бесплатный крафт: " .. status)
	if GLOBAL.ThePlayer and GLOBAL.ThePlayer.components and GLOBAL.ThePlayer.components.talker then
		GLOBAL.ThePlayer.components.talker:Say("Бесплатный крафт: " .. status)
	end
end
GLOBAL.c_bfree = GLOBAL.c_bulingfreecraft

AddModRPCHandler("bulingbuling", "craft_item_free", function(player, prefab_name)
	local is_free = (GLOBAL.BULING_FREE_CRAFT ~= false)
		or (player and player.components.builder and (player.components.builder.freebuildmode or (player.components.builder.IsFreeBuildMode and player.components.builder:IsFreeBuildMode())))
		or (player and player.replica and player.replica.builder and player.replica.builder.IsFreeBuildMode and player.replica.builder:IsFreeBuildMode())

	print("[BULING FREE CRAFT RPC] Server received craft request for:", prefab_name, "from player:", player, "is_free:", is_free)
	if is_free and prefab_name and prefab_name ~= "nil" and prefab_name ~= "closebutton" and prefab_name ~= "turnarrow_icon" then
		local spawn_name = prefab_name
		if not GLOBAL.Prefabs[spawn_name] and GLOBAL.Prefabs[spawn_name .. "_item"] then
			spawn_name = spawn_name .. "_item"
		end
		local _crafted = GLOBAL.SpawnPrefab(spawn_name)
		if _crafted == nil then
			_crafted = GLOBAL.SpawnPrefab(prefab_name)
		end

		if _crafted then
			if player and player.components.inventory and _crafted.components and _crafted.components.inventoryitem then
				player.components.inventory:GiveItem(_crafted, nil, player:GetPosition())
			else
				_crafted.Transform:SetPosition(player.Transform:GetWorldPosition())
			end
			if player and player.components.talker then
				local item_name = GLOBAL.STRINGS.NAMES[string.upper(spawn_name)] or GLOBAL.STRINGS.NAMES[string.upper(prefab_name)] or prefab_name
				player.components.talker:Say("Бесплатный крафт: " .. tostring(item_name))
			end
		else
			print("[BULING FREE CRAFT RPC] SpawnPrefab failed for:", prefab_name, "spawn_name:", spawn_name)
		end
	end
end)

-- Custom Car Driving Actions and RPCs
local BULING_DRIVE = GLOBAL.Action({ priority = 10, mount_enabled = true })
BULING_DRIVE.id = "BULING_DRIVE"
BULING_DRIVE.str = "Сесть в машину (Drive)"
BULING_DRIVE.fn = function(act)
	if act.target and act.doer and act.target:HasTag("buling_carrier") then
		if act.target.components.drivable and act.target.components.drivable.OnMounted then
			act.target.components.drivable:OnMounted(act.doer)
		end
		return true
	end
end
AddAction(BULING_DRIVE)
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.BULING_DRIVE, "doshortaction"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.BULING_DRIVE, "doshortaction"))

local BULING_DISMOUNT = GLOBAL.Action({ priority = 10, mount_enabled = true })
BULING_DISMOUNT.id = "BULING_DISMOUNT"
BULING_DISMOUNT.str = "Вылезти из машины (Dismount)"
BULING_DISMOUNT.fn = function(act)
	if act.doer and act.doer.components.driver and act.doer.components.driver.vehicle then
		local vehicle = act.doer.components.driver.vehicle
		if vehicle and vehicle.bulingdrop then
			vehicle.bulingdrop(vehicle, act.doer, act.doer)
		end
		return true
	end
end
AddAction(BULING_DISMOUNT)
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.BULING_DISMOUNT, "doshortaction"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.BULING_DISMOUNT, "doshortaction"))

AddComponentAction("SCENE", "drivable", function(inst, doer, actions, right)
	if right and inst and inst:HasTag("buling_carrier") then
		if doer and doer:HasTag("buling_driving") then
			table.insert(actions, GLOBAL.ACTIONS.BULING_DISMOUNT)
		else
			table.insert(actions, GLOBAL.ACTIONS.BULING_DRIVE)
		end
	end
end)

AddComponentAction("SCENE", "trader", function(inst, doer, actions, right)
	if right and inst and inst:HasTag("buling_carrier") then
		if not (doer and doer:HasTag("buling_driving")) then
			table.insert(actions, GLOBAL.ACTIONS.BULING_DRIVE)
		end
	end
end)

AddModRPCHandler("bulingbuling", "drive_car", function(player, car_guid)
	if car_guid then
		local car = GLOBAL.Ents[car_guid]
		if car and car.components.drivable and car.components.drivable.OnMounted then
			car.components.drivable:OnMounted(player)
			if GLOBAL.TheCamera then
				GLOBAL.TheCamera:SetTarget(car)
			end
		end
	end
end)

AddModRPCHandler("bulingbuling", "dismount_car", function(player)
	if player and player.components.driver and player.components.driver.vehicle then
		local vehicle = player.components.driver.vehicle
		if vehicle and vehicle.bulingdrop then
			vehicle.bulingdrop(vehicle, player, player)
			if GLOBAL.TheCamera then
				GLOBAL.TheCamera:SetTarget(player)
			end
		end
	end
end)

-- Mouse Steering and Control for Vehicles
AddModRPCHandler("bulingbuling", "move_car", function(player, car_guid, x, z)
	if car_guid and x and z then
		local car = GLOBAL.Ents[car_guid]
		if car and car.components.locomotor then
			car.components.locomotor:GoToPoint(GLOBAL.Vector3(x, 0, z))
		end
	end
end)

AddClassPostConstruct("components/playercontroller", function(self)
	local oldDoCameraControl = self.DoCameraControl
	self.DoCameraControl = function(self, ...)
		if self.inst and (self.inst:HasTag("buling_driving") or self.inst:HasTag("kamen_rider")) then
			if GLOBAL.TheCamera then
				GLOBAL.TheCamera:SetHeadingTarget(45)
			end
			return
		end
		if oldDoCameraControl then
			return oldDoCameraControl(self, ...)
		end
	end

		local oldOnControl = self.OnControl
	self.OnControl = function(self, control, down, ...)
		if self.inst and (self.inst:HasTag("buling_driving") or self.inst:HasTag("kamen_rider")) then
			if control == GLOBAL.CONTROL_ROTATE_LEFT or control == GLOBAL.CONTROL_ROTATE_RIGHT then
				return true
			end

			-- Dismount on Right Click (CONTROL_SECONDARY) when driving
			if down and control == GLOBAL.CONTROL_SECONDARY and self.inst:HasTag("buling_driving") then
				SendBulingRPC("dismount_car")
				return true
			end

			local atk_target = self:GetAttackTarget() or (self.inst.components.combat and self.inst.components.combat.target)
			local is_f_attack = (control == GLOBAL.CONTROL_ATTACK)
			local is_targeted_click = (control == GLOBAL.CONTROL_PRIMARY) and (atk_target ~= nil and atk_target:IsValid())

			if down and (is_f_attack or is_targeted_click) then
				local driver_comp = self.inst.components.driver
				local vehicle = (driver_comp and driver_comp.vehicle) or self.inst
				local target_guid = atk_target and atk_target:IsValid() and atk_target.GUID or nil

				if not self.inst._last_car_atk_time or (GLOBAL.GetTime() - self.inst._last_car_atk_time) > 0.4 then
					self.inst._last_car_atk_time = GLOBAL.GetTime()
					SendBulingRPC("attack_car", vehicle.GUID, target_guid)
				end
				return true
			end
		end
		if oldOnControl then
			return oldOnControl(self, control, down, ...)
		end
	end

	local last_angle = nil
	local was_moving = false

	self.inst:DoPeriodicTask(0.05, function()
		if not self.inst or (not self.inst:HasTag("buling_driving") and not self.inst:HasTag("kamen_rider") and not self.inst:HasTag("pigroyalty")) then
			if was_moving then
				was_moving = false
				last_angle = nil
			end
			return
		end

		local driver_comp = self.inst.components.driver
		local vehicle = (driver_comp and driver_comp.vehicle) or self.inst
		if not vehicle or not vehicle:IsValid() then return end

		local vx, vy, vz = vehicle.Transform:GetWorldPosition()
		self.inst.Transform:SetPosition(vx, vy, vz)

		local is_w = GLOBAL.TheInput:IsKeyDown(GLOBAL.KEY_W) or GLOBAL.TheInput:IsKeyDown(GLOBAL.KEY_UP)
		local is_s = GLOBAL.TheInput:IsKeyDown(GLOBAL.KEY_S) or GLOBAL.TheInput:IsKeyDown(GLOBAL.KEY_DOWN)
		local is_a = GLOBAL.TheInput:IsKeyDown(GLOBAL.KEY_A) or GLOBAL.TheInput:IsKeyDown(GLOBAL.KEY_LEFT)
		local is_d = GLOBAL.TheInput:IsKeyDown(GLOBAL.KEY_D) or GLOBAL.TheInput:IsKeyDown(GLOBAL.KEY_RIGHT)

		local dir_angle = nil

		if is_w and is_d then
			dir_angle = 45
		elseif is_s and is_d then
			dir_angle = 135
		elseif is_s and is_a then
			dir_angle = 225
		elseif is_w and is_a then
			dir_angle = 315
		elseif is_w then
			dir_angle = 0
		elseif is_s then
			dir_angle = 180
		elseif is_a then
			dir_angle = 270
		elseif is_d then
			dir_angle = 90
		end

		local atk_target = self:GetAttackTarget() or (self.inst.components.combat and self.inst.components.combat.target)
		local is_key_attack = GLOBAL.TheInput:IsKeyDown(GLOBAL.KEY_F) 
			or GLOBAL.TheInput:IsKeyDown(GLOBAL.KEY_CTRL) 
			or GLOBAL.TheInput:IsControlPressed(GLOBAL.CONTROL_ATTACK)
		local is_mouse_attack = (GLOBAL.TheInput:IsMouseDown(GLOBAL.MOUSEBUTTON_LEFT) or GLOBAL.TheInput:IsControlPressed(GLOBAL.CONTROL_PRIMARY)) and (atk_target ~= nil)

		local is_attacking = is_key_attack or is_mouse_attack

		if is_attacking then
			if not self.inst._last_car_atk_time or (GLOBAL.GetTime() - self.inst._last_car_atk_time) > 0.5 then
				self.inst._last_car_atk_time = GLOBAL.GetTime()
				local target_guid = atk_target and atk_target:IsValid() and atk_target.GUID or nil
				if not GLOBAL.TheWorld.ismastersim then
					SendBulingRPC("attack_car", vehicle.GUID, target_guid)
				else
					local x, y, z = vehicle.Transform:GetWorldPosition()
					local rad = (vehicle.Transform:GetRotation() or 0) * GLOBAL.DEGREES
					local targetpos = (atk_target and atk_target:IsValid() and atk_target:GetPosition()) or GLOBAL.Vector3(x + 10 * GLOBAL.math.cos(rad), 0, z - 10 * GLOBAL.math.sin(rad))
					if vehicle.LaunchProjectile then
						pcall(vehicle.LaunchProjectile, vehicle, self.inst, targetpos)
					end
					if vehicle.sg then
						if vehicle.sg:HasState("mine_shoot") then
							vehicle.sg:GoToState("mine_shoot")
						else
							vehicle.sg:GoToState("attack")
						end
					end
				end
			end
		end

		if dir_angle ~= nil then
			local heading = GLOBAL.TheCamera and GLOBAL.TheCamera:GetHeadingTarget() or 0
			local angle = (dir_angle + heading + 90) % 360

			if not self.inst._car_is_moving or last_angle ~= angle then
				self.inst._car_is_moving = true
				last_angle = angle
				if not GLOBAL.TheWorld.ismastersim then
					SendBulingRPC("dir_car", vehicle.GUID, angle, true)
				else
					DoDirCar(vehicle, angle, true)
				end
			end
		else
			if self.inst._car_is_moving or (vehicle.components.locomotor and vehicle.components.locomotor:WantsToMoveForward()) then
				self.inst._car_is_moving = false
				last_angle = nil
				if not GLOBAL.TheWorld.ismastersim then
					SendBulingRPC("dir_car", vehicle.GUID, 0, false)
				else
					DoDirCar(vehicle, 0, false)
				end
			end
		end
	end)
end)