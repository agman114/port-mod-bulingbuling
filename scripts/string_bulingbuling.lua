local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

-- =========================================================================
-- CHARACTER PROFILE
-- =========================================================================
STRINGS.CHARACTER_TITLES.bulingbuling = "Ms. Buling"
STRINGS.CHARACTER_NAMES.bulingbuling = "BulingBuling"
STRINGS.CHARACTER_DESCRIPTIONS.bulingbuling = "*Suffers from insomnia and stomach issues\n*Is way too weak to brandish heavy weapons\n*Feels gazed upon by an unknown cosmic existence"
STRINGS.CHARACTER_QUOTES.bulingbuling = "\"Technology is more than just primary combat power.\""

-- =========================================================================
-- CRAFTING TABS & FILTERS
-- =========================================================================
STRINGS.UI = STRINGS.UI or {}
STRINGS.UI.CRAFTING_FILTERS = STRINGS.UI.CRAFTING_FILTERS or {}
STRINGS.UI.CRAFTING_FILTERS.BLTAB = "Buling Tech"
STRINGS.UI.CRAFTING_FILTERS.YJTAB = "Research Projects"
STRINGS.UI.CRAFTING_FILTERS["BLTAB"] = "Buling Tech"
STRINGS.UI.CRAFTING_FILTERS["YJTAB"] = "Research Projects"

-- =========================================================================
-- AUTOMATIC BEE HIVE & BEES
-- =========================================================================
STRINGS.NAMES.BULING_BEE_BOX = "Automatic Bee Hive"
STRINGS.NAMES.BULING_BEE_BOX_ITEM = "Automatic Bee Hive"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_BEE_BOX = "An automated hive. Houses specialized worker bees to passively produce resources!"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_BEE_BOX_ITEM = "An automated bee hive. Place on the ground to begin resource production!"

STRINGS.NAMES.BULING_BEE_MINE = "Miner Bee"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_BEE_MINE = "Passively mines rocks, flint, and subterranean minerals inside the hive."
STRINGS.NAMES.BULING_BEE_POLICE = "Guard Bee"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_BEE_POLICE = "Protects the hive and produces fresh honey."
STRINGS.NAMES.BULING_BEE_PIRATE = "Pirate Bee"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_BEE_PIRATE = "Plunders gold nuggets, treasures, and shiny trinkets."
STRINGS.NAMES.BULING_BEE_QUEEN = "Queen Bee"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_BEE_QUEEN = "Clones and multiplies other bees in the hive every 5 minutes!"
STRINGS.NAMES.BULING_BEE_GOVERNOR = "Governor Bee"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_BEE_GOVERNOR = "Yields royal honey, gold, and rare precious gems."
STRINGS.NAMES.BULING_BEE_STONECUTTERS = "Stonecutter Bee"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_BEE_STONECUTTERS = "Carves cut stone blocks and smooth marble."
STRINGS.NAMES.BULING_BEE_GARDENER = "Gardener Bee"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_BEE_GARDENER = "Gathers organic seeds and fresh vegetables."
STRINGS.NAMES.BULING_BEE_CAI = "Harvester Bee"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_BEE_CAI = "Collects cut grass, twigs, and sweet berries."
STRINGS.NAMES.BULING_BEE_FISH = "Angler Bee"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_BEE_FISH = "Catches fish and gathers fresh seafood from local waters."
STRINGS.NAMES.BULING_BEE_SMITH = "Blacksmith Bee"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_BEE_SMITH = "Forges refined metal, flint, and sturdy metal ingots."

-- =========================================================================
-- ITEMS, MACHINERY & STRUCTURES
-- =========================================================================
STRINGS.NAMES.BULING_OVERCOAT = "Tailored Overcoat"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_OVERCOAT = "A modular composite coat.\nSpecific functions depend on equipped modules."
STRINGS.NAMES.BULING_CHEST_MINI = "Logistics Chest"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CHEST_MINI = "A compact logistics container for robotic arm input and output."
STRINGS.NAMES.BULING_CHEST_MINI_ITEM = "Logistics Chest"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CHEST_MINI_ITEM = "Place it to build a logistics chest."
STRINGS.NAMES.BULING_CHUANSONGDAI = "Conveyor Belt"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CHUANSONGDAI = "A standard automated conveyor belt.\nExamine to switch movement direction."
STRINGS.NAMES.BULING_CHUANSONGDAI_ITEM = "Conveyor Belt"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CHUANSONGDAI_ITEM = "Place it to install a conveyor belt."
STRINGS.NAMES.BULING_JIXIEBI = "Robotic Arm Conveyor"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_JIXIEBI = "A conveyor equipped with a mechanical arm to pick up and deposit items."
STRINGS.NAMES.BULING_JIXIEBI_ITEM = "Robotic Arm Conveyor"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_JIXIEBI_ITEM = "Place it to install a robotic arm conveyor."

STRINGS.NAMES.BULING_SHUIPEI = "Hydroponics Bed"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_SHUIPEI = "Cultivates special crops.\nWhen crops mature, it outputs harvest to nearby robotic arms."
STRINGS.NAMES.BULING_SHUIPEI_ITEM = "Hydroponics Bed"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_SHUIPEI_ITEM = "Place on the ground to assemble a hydroponics cultivation bed."

STRINGS.NAMES.BULING_HULK = "Alloy Hulk"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_HULK = "A formidable combat and utility automaton."
STRINGS.NAMES.BULING_BOOK_TONGXUNTAI = "Communications Terminal Blueprint"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_BOOK_TONGXUNTAI = "Teaches how to craft the Communications Terminal."
STRINGS.NAMES.BULING_BOOK_YAJIN = "Yajin Extraction Blueprint"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_BOOK_YAJIN = "Teaches how to extract rare Yajin."
STRINGS.NAMES.BULING_TONGXUNTAI = "Communications Terminal"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_TONGXUNTAI = "Transmits long-range signals to reach nearby vessels and colonies."
STRINGS.NAMES.BULING_TONGXUNTAI_ITEM = "Communications Terminal"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_TONGXUNTAI_ITEM = "Place on the ground to erect a communications terminal."
STRINGS.NAMES.BULING_YAJIN = "Yajin Metal"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_YAJIN = "A mysterious, high-density alloy with latent psychic resonance."
STRINGS.NAMES.BULING_RONGLU2 = "Electric Smelter"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_RONGLU2 = "Refines heavy ores and minerals with high electrical heat."
STRINGS.NAMES.BULING_RONGLU2_ITEM = "Electric Smelter"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_RONGLU2_ITEM = "Place it to construct an electric smelter."
STRINGS.NAMES.BULING_GLOMLING = "Gloomy Drone"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_GLOMLING = "An aerial scouting drone built from lightweight alloy parts."
STRINGS.NAMES.BULING_CAVE_TOOL = "Excavation Tool"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CAVE_TOOL = "Stabilizes fractured bedrock into a permanent subterranean vault."
STRINGS.NAMES.BULING_CAVE_ENTRANCE = "Underground Vault"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CAVE_ENTRANCE = "A fortified underground bunker and deep storage vault."
STRINGS.NAMES.BULING_FLOUR = "Refined Flour"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_FLOUR = "Finely milled wheat flour from the extractor."
STRINGS.NAMES.BULING_SYSTEM = "Terminal Remote"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_SYSTEM = "A portable link to the starship terminal. Tracks current tasks and technical blueprints."
STRINGS.NAMES.BULING_PLANT_ZHONGZIDING = "SEED Ingot Plant"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_PLANT_ZHONGZIDING = "Absorbs minerals from the soil to grow organic SEED ingots."
STRINGS.NAMES.BULING_CHEST = "Alloy Chest"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CHEST = "A heavy-duty reinforced storage container."
STRINGS.NAMES.BULING_BANSHOU = "Buling's Wrench"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_BANSHOU = "Used to dismantle, configure, and relocate electrical machinery."
STRINGS.NAMES.BULING_PULEIDI = "Puleidi Crystal"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_PULEIDI = "A marvelous crystalline structure synthesized from SEED ingots."
STRINGS.NAMES.BULING_PULEIDI_PLANK = "Puleidi Plate"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_PULEIDI_PLANK = "A versatile structural alloy plate with high rigidity."
STRINGS.NAMES.BULING_MANUAL_ITEM = "Crafting Table"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_MANUAL_ITEM = "Place it to assemble a technical crafting workbench."
STRINGS.NAMES.BULING_MANUAL = "Crafting Table"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_MANUAL = "A precision workbench for technical assembly and toolcraft."
STRINGS.NAMES.BULING_GLASS = "SEED Glass"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_GLASS = "Conductive, high-durability silicate glass extracted from SEED ingots."
STRINGS.NAMES.BULING_SEED_ZHONGZIDING = "SEED Seed"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_SEED_ZHONGZIDING = "A bio-engineered seed that yields renewable metal ingots."
STRINGS.NAMES.BULING_ZHONGZIDING = "SEED Ingot"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_ZHONGZIDING = "A bio-synthetic, eco-friendly metal ingot developed for sustainable industry."
STRINGS.NAMES.BULING_RONGLU_ITEM = "Extractor"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_RONGLU_ITEM = "Place it to install an extractor."
STRINGS.NAMES.BULING_RONGLU = "Extractor"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_RONGLU = "Extracts elements and purifies compounds at the cost of 10Bp electricity."
STRINGS.NAMES.BULING_RADAR = "Buling's Radar"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_RADAR = "Requires 800Bp of power to map surrounding terrain and detect signals."
STRINGS.NAMES.BULING_DIANLIFU = "Electric Axe"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_DIANLIFU = "An electrically powered logging axe with remarkable cutting speed."
STRINGS.NAMES.BULING_JIANDAO = "Alloy Shears"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_JIANDAO = "High-precision shears forged from durable alloy."
STRINGS.NAMES.BULING_DIANDONGGAO = "Electric Pickaxe"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_DIANDONGGAO = "A powered excavation pickaxe that shatters boulders with ease."
STRINGS.NAMES.BULING_CROPBOX = "Automated Harvester"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CROPBOX = "Harvests nearby mature crops automatically when powered with 50Bp."
STRINGS.NAMES.BULING_CROPBOX_ITEM = "Automated Harvester"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CROPBOX_ITEM = "Place on the ground to install an automated crop harvester."
STRINGS.NAMES.BULING_WAKUANG_ITEM = "Electric Mining Rig"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_WAKUANG_ITEM = "Place on rich mineral ground to start deep excavation."
STRINGS.NAMES.BULING_WAKUANG = "Electric Mining Rig"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_WAKUANG = "Drills deep into the crust to extract subterranean ore veins."
STRINGS.NAMES.BULING_FENGRENJI = "Automated Sewing Machine"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_FENGRENJI = "A specialized tailor's workstation for crafting composite apparel."
STRINGS.NAMES.BULING_FENGRENJI_ITEM = "Automated Sewing Machine"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_FENGRENJI_ITEM = "Place on the ground to install an automated sewing workstation."
STRINGS.NAMES.BULING_CHEMISTRYTABLE = "Chemical Synthesizer"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CHEMISTRYTABLE = "Processes reagents, solvents, and advanced chemical compounds."
STRINGS.NAMES.BULING_WEAPONCHEST_ITEM = "Arsenal Armory"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_WEAPONCHEST_ITEM = "Place on the ground to set up an equipment armory."
STRINGS.NAMES.BULING_WEAPONCHEST = "Arsenal Armory"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_WEAPONCHEST = "Stores and upgrades modular weaponry and military hardware."
STRINGS.NAMES.BULING_COOKTABLE_ITEM = "Culinary Station"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_COOKTABLE_ITEM = "Place on the ground to install a gourmet cooking station."
STRINGS.NAMES.BULING_COOKTABLE = "Culinary Station"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_COOKTABLE = "A culinary workstation designed for fine cooking and baking."
STRINGS.NAMES.BULING_PLANTTABLE = "Agricultural Workbench"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_PLANTTABLE = "Synthesizes advanced seeds, fertilizers, and plant strains."
STRINGS.NAMES.BULING_PLANTTABLE_ITEM = "Agricultural Workbench"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_PLANTTABLE_ITEM = "Place on the ground to install an agricultural workbench."
STRINGS.NAMES.BULING_SEEDBOX = "Germination Incubator"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_SEEDBOX = "Cultivates sensitive hybrid seeds under controlled conditions."
STRINGS.NAMES.BULING_CAR_LOG = "Logging Vehicle"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CAR_LOG = "A motorized forestry vehicle that clears trees quickly."
STRINGS.NAMES.BULING_CAR_LOG_ITEM = "Logging Vehicle"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CAR_LOG_ITEM = "Deploy to unpack a motorized logging vehicle."
STRINGS.NAMES.BULING_ROCKY = "Excavation Rig"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_ROCKY = "A heavy-duty vehicular platform for quarrying stone and minerals."
STRINGS.NAMES.BULING_ROCKY_ITEM = "Excavation Rig"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_ROCKY_ITEM = "Deploy to unpack a motorized excavation rig."
STRINGS.NAMES.BULING_PLANE = "Scout Drone"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_PLANE = "A swift airborne drone for reconnaissance."
STRINGS.NAMES.BULING_PLANE_ITEM = "Scout Drone"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_PLANE_ITEM = "Deploy to launch a scout drone."

STRINGS.NAMES.BULING_ZHONGJIQI_ITEM = "Power Repeater"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_ZHONGJIQI_ITEM = "Deploy to set up a power distribution repeater."
STRINGS.NAMES.BULING_ZHONGJIQI = "Power Repeater"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_ZHONGJIQI = "Stores electricity and distributes power to all nearby machines."
STRINGS.NAMES.BULING_ZHONGJIQI_GAOYA_ITEM = "High-Voltage Relay"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_ZHONGJIQI_GAOYA_ITEM = "Deploy to set up a high-voltage power transmission relay."
STRINGS.NAMES.BULING_ZHONGJIQI_GAOYA = "High-Voltage Relay"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_ZHONGJIQI_GAOYA = "Transmits large quantities of electrical power over long distances."
STRINGS.NAMES.BULING_DIANXIANGAN = "Power Pylon"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_DIANXIANGAN = "Extends the local electrical power grid."
STRINGS.NAMES.BULING_DIANXIANGAN_ITEM = "Power Pylon"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_DIANXIANGAN_ITEM = "Place on the ground to install a power pylon."
STRINGS.NAMES.BULING_FENSUI = "Ore Pulverizer"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_FENSUI = "Crushes boulders into gravel, sand, and fine mineral dust."
STRINGS.NAMES.BULING_FENSUI_ITEM = "Ore Pulverizer"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_FENSUI_ITEM = "Place on the ground to install an ore pulverizer."

STRINGS.NAMES.BULING_YANJIUTAI = "Research Computer"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_YANJIUTAI = "Simulates scientific algorithms to generate technical research points."
STRINGS.NAMES.BULING_YANJIUTAI_ITEM = "Research Computer"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_YANJIUTAI_ITEM = "Place on the ground to install a research computer."
STRINGS.NAMES.BULING_YANJIUDIAN = "Research Data Disk"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_YANJIUDIAN = "Contains validated experimental data used to unlock advanced technologies."

STRINGS.NAMES.BULING_JIDI = "Damaged Drop Pod"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_JIDI = "The remains of the emergency escape pod. Contains salvageable high-tech components."
STRINGS.NAMES.BULING_CORE = "Glitterworld Machine Core"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CORE = "An irreplaceable advanced AI computing module from a Glitterworld starship."
STRINGS.NAMES.BULING_MINE = "Proximity Landmine"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_MINE = "An automated sensor mine that detonates when hostiles draw near."
STRINGS.NAMES.BULING_CARRIER = "Cargo Transport"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CARRIER = "A heavy automated hauler capable of transporting vast quantities of cargo."
STRINGS.NAMES.BULING_CARRIER_ITEM = "Cargo Transport"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_CARRIER_ITEM = "Deploy to set up a heavy cargo transport."

STRINGS.NAMES.BULING_BOAT = "Amphibious Vessel"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_BOAT = "An all-terrain amphibious vessel for seafaring journeys."
STRINGS.NAMES.BULING_BOAT_ITEM = "Amphibious Vessel"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_BOAT_ITEM = "Deploy to launch an amphibious vessel."

STRINGS.NAMES.BULING_ZHUSHEQI = "Bio-Syringe"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_ZHUSHEQI = "Extracts polymerase enzymes from mature plants."
STRINGS.NAMES.BULING_JUHEMEI_ALPHA = "Alpha Polymerase"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_JUHEMEI_ALPHA = "A biological catalyst for genetic modification."
STRINGS.NAMES.BULING_JUHEMEI_BETA = "Beta Polymerase"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_JUHEMEI_BETA = "A refined biological enzyme that restructures plant genomes."

-- =========================================================================
-- WEAPONS, TOOLS & MODULES
-- =========================================================================
STRINGS.NAMES.BULING_AXE_WEAPON = "Kinetic Battleaxe"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_AXE_WEAPON = "A heavy industrial axe balanced for devastating melee combat."
STRINGS.NAMES.BULING_PICKAXE_WEAPON = "Pneumatic War Pick"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_PICKAXE_WEAPON = "Penetrates through thick chitin and rocky armor."
STRINGS.NAMES.BULING_SHEARS_WEAPON = "Dual Shearing Blades"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_SHEARS_WEAPON = "Razor-sharp alloy blades suited for close-quarters self-defense."
STRINGS.NAMES.BULING_GUN_WHITE = "Beam Carbine"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_GUN_WHITE = "A standard issue personal defense directed-energy rifle."
STRINGS.NAMES.BULING_GUN_QING = "Precision Beam Rifle"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_GUN_QING = "Accurate long-range laser carbine."
STRINGS.NAMES.BULING_GUN_YANG = "Heavy Beam Cannon"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_GUN_YANG = "Fires high-intensity thermal laser pulses."
STRINGS.NAMES.BULING_GUN_ZERO = "Zero-Point Beam"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_GUN_ZERO = "Experimental cryo-energy beam that flash freezes targets."

STRINGS.NAMES.BULING_GUN_DIANCHI = "Energy Cell"
STRINGS.NAMES.BULING_GUN_DIANCHI_TAIYANG = "Solar Capacitor"
STRINGS.NAMES.BULING_GUN_DIANCHI_TONGLIANG = "Flux Capacitor"
STRINGS.NAMES.BULING_GUN_JIGUANG = "Laser Emitter"
STRINGS.NAMES.BULING_GUN_JIGUANG_BOLI = "Optical Prism"
STRINGS.NAMES.BULING_GUN_JIGUANG_YAOSHOU = "Harmonic Lens"
STRINGS.NAMES.BULING_GUN_QIANGGUAN = "Reinforced Barrel"
STRINGS.NAMES.BULING_GUN_QIANGGUAN_YANG = "Alloy Thermal Barrel"
STRINGS.NAMES.BULING_GUN_QIANGGUAN_YING = "Heavy Accelerator Barrel"
STRINGS.NAMES.BULING_GUN_SHOUBING = "Ergonomic Grip"
STRINGS.NAMES.BULING_GUN_SHOUBING_BIAOQIANG = "Stabilized Stock"
STRINGS.NAMES.BULING_GUN_SHOUBING_JUJI = "Marksman Tactical Grip"

-- =========================================================================
-- APPAREL, CLOTHING & UPGRADES
-- =========================================================================
STRINGS.NAMES.BULING_CLOTHE_1 = "Lightweight Jumper"
STRINGS.NAMES.BULING_CLOTHE_2 = "Thermal Wool Sweater"
STRINGS.NAMES.BULING_CLOTHE_3 = "Protective Vest"
STRINGS.NAMES.BULING_CLOTHE_4 = "Insulated Parka"
STRINGS.NAMES.BULING_CLOTHE_5 = "Hazmat Suit"
STRINGS.NAMES.BULING_CLOTHE_6 = "Tactical Combat Jacket"
STRINGS.NAMES.BULING_CLOTHE_7 = "Heavy Exosuit Vest"
STRINGS.NAMES.BULING_CLOTHE_8 = "Nanite Stealth Cloak"
STRINGS.NAMES.BULING_CLOTHE_9 = "Glitterworld Gown"
STRINGS.NAMES.BULING_TROUSER_1 = "Comfortable Slacks"
STRINGS.NAMES.BULING_TROUSER_2 = "Reinforced Denim Jeans"
STRINGS.NAMES.BULING_TROUSER_3 = "Insulated Thermal Pants"
STRINGS.NAMES.BULING_TROUSER_4 = "Waterproof Cargo Trousers"
STRINGS.NAMES.BULING_TROUSER_5 = "Heavy Armored Greaves"
STRINGS.NAMES.BULING_TROUSER_6 = "Kinetic Sprinting Leggings"
STRINGS.NAMES.BULING_DENIM = "Reinforced Denim"
STRINGS.NAMES.BULING_FABRIC = "Synthetic Fabric"
STRINGS.NAMES.BULING_EVENINGROBE = "Silk Evening Robe"
STRINGS.NAMES.BULING_WATERPROOF_FIELD = "Hydrophobic Coating"

-- =========================================================================
-- FOODS, CROPS & COOKING
-- =========================================================================
STRINGS.NAMES.BULING_COOK_CAIDAO = "Chef's Cleaver"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_COOK_CAIDAO = "An ultra-sharp culinary knife for precision dicing."
STRINGS.NAMES.BULING_COOK_KAOPAN = "Ceramic Baking Pan"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_COOK_KAOPAN = "Distributes heat evenly for baking bread and pastries."
STRINGS.NAMES.BULING_BREAD = "Country Bread"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_BREAD = "Freshly baked artisan bread. Warm and filling."
STRINGS.NAMES.BULING_KAODIGUA = "Roasted Sweet Potato"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_KAODIGUA = "Sweet, fragrant, and delightfully steaming."
STRINGS.NAMES.BULING_KAOLENGMIAN = "Grilled Cold Noodles"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_KAOLENGMIAN = "A classic savory street food snack."
STRINGS.NAMES.BULING_XIANGCAOBUDING = "Vanilla Custard Pudding"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BULING_XIANGCAOBUDING = "Silky, sweet custard infused with fragrant vanilla."
STRINGS.NAMES.BULING_FENGMIBUDING = "Honey Pudding"
STRINGS.NAMES.BULING_FENGMIMIANBAO = "Honey Bread"
STRINGS.NAMES.BULING_MIANBAOPIAN = "Toasted Bread Slice"
STRINGS.NAMES.BULING_HONGGUMIANBAO = "Mushroom Herb Toast"
STRINGS.NAMES.BULING_SUANRONGMIANBAO = "Garlic Butter Baguette"
STRINGS.NAMES.BULING_SUANRONGGUHE = "Garlic Herb Breadbox"
STRINGS.NAMES.BULING_PISA = "Supreme Pizza"
STRINGS.NAMES.BULING_MOGUHANBAO = "Portobello Burger"
STRINGS.NAMES.BULING_MOGUTANG = "Cream of Mushroom Soup"
STRINGS.NAMES.BULING_HULUOBOTANG = "Hearty Carrot Broth"
STRINGS.NAMES.BULING_ZHAWANZI = "Crispy Meatballs"
STRINGS.NAMES.BULING_ZHALUOBOWANZI = "Crispy Veggie Balls"
STRINGS.NAMES.BULING_SHUCAISHALA = "Garden Salad"
STRINGS.NAMES.BULING_TIANMISHALA = "Sweet Fruit Salad"
STRINGS.NAMES.BULING_SHUCAISUI = "Chopped Salad Greens"
STRINGS.NAMES.BULING_SUROUDACAN = "Vegetarian Feast"
STRINGS.NAMES.BULING_FANSHUJIANBING = "Sweet Potato Pancake"
STRINGS.NAMES.BULING_FANSHUNI = "Mashed Sweet Potato"
STRINGS.NAMES.BULING_FANSHUZHOU = "Sweet Potato Porridge"
STRINGS.NAMES.BULING_GUODONGJUAN = "Fruit Jelly Roll"
STRINGS.NAMES.BULING_GUOJIANGTONGXINFEN = "Berry Glazed Pasta"
STRINGS.NAMES.BULING_NAILAOTONGXINFEN = "Macaroni and Cheese"
STRINGS.NAMES.BULING_JIANGGUODANGAO = "Wildberry Tart"
STRINGS.NAMES.BULING_JIANGGUOSANMINGZHI = "Berry Jam Sandwich"
STRINGS.NAMES.BULING_LUOBODANGAO = "Spiced Carrot Cake"
STRINGS.NAMES.BULING_LUOBOGAO = "Steamed Radish Cake"
STRINGS.NAMES.BULING_QIAOKELIPAI = "Chocolate Fudge Pie"
STRINGS.NAMES.BULING_QIAOKELIXIANBING = "Chocolate Lava Pastry"
STRINGS.NAMES.BULING_XIANGJIAOXIANBING = "Banana Cream Turnover"
STRINGS.NAMES.BULING_QIEHESHUTIAO = "Loaded Eggplant Fries"
STRINGS.NAMES.BULING_XIGUAZHI = "Chilled Watermelon Cooler"
STRINGS.NAMES.BULING_TIANSHUNI = "Sweet Potato Puree"
STRINGS.NAMES.BULING_KAFEITANG = "Coffee Caramel Cube"
STRINGS.NAMES.BULING_FANGXINGJIAOTANG = "Butter Toffee Square"
STRINGS.NAMES.BULING_CREAM = "Fresh Cream"
STRINGS.NAMES.BULING_MILK_GOAT = "Fresh Goat Milk"
STRINGS.NAMES.BULING_GOATMILK = "Bottled Goat Milk"

-- Seeds & Strains
STRINGS.NAMES.BULING_SEED_IRON = "Iron Ingot Seed"
STRINGS.NAMES.BULING_PLANT_IRON = "Iron Ingot Plant"
STRINGS.NAMES.BULING_SEED_THULECITE = "Thulecite Seed"
STRINGS.NAMES.BULING_PLANT_THULECITE = "Thulecite Plant"
STRINGS.NAMES.BULING_SEED_DUOFENG = "Bountiful Grain Seed"
STRINGS.NAMES.BULING_SEED_PINJI = "Hardy Scrub Seed"
STRINGS.NAMES.BULING_SEED_REDAI = "Tropical Flora Seed"
STRINGS.NAMES.BULING_SEED_SHIRUN = "Aquatic Sprout Seed"
STRINGS.NAMES.BULING_SEED_YINBI = "Shade Moss Seed"
STRINGS.NAMES.BULING_CAIYUAN_DUOFENG = "Bountiful Plot"
STRINGS.NAMES.BULING_CAIYUAN_PINJI = "Arid Plot"
STRINGS.NAMES.BULING_CAIYUAN_REDAI = "Tropical Plot"
STRINGS.NAMES.BULING_CAIYUAN_SHIRUN = "Wetland Plot"
STRINGS.NAMES.BULING_CAIYUAN_YINBI = "Canopy Plot"

-- =========================================================================
-- ACTIONS, ALERTS & SYSTEM PROMPTS
-- =========================================================================
STRINGS.BULING_STSTEM = "Open Terminal"
STRINGS.BULING_ENZYME = "Extract"
STRINGS.BULING_BWNG = "Insufficient Power"
STRINGS.BULING_BWNG2 = "\nRequires 50Bp of power to operate once."
STRINGS.BULING_LEIDA = "Downloaded temporary topographical scan from radar."
STRINGS.DIXI_LOW = "Hostile raiders have arrived and are about to strike!"
STRINGS.DIXI_LONG = "Hostile raiders have arrived; they are preparing their assault!"
STRINGS.XINGZHICAI = "Colour Out of Space variants have migrated into this sector!"
STRINGS.ERTONGJIE = "Happy Children's Day!"
STRINGS.DAODANHONGZHA = "Bombard Target"
STRINGS.COLONIES = "Colonies"
STRINGS.SHIPTEXT = "Merchant Ship"
STRINGS.BLACKMARKET = "Black Market"
STRINGS.NOSIGNAL = "No Signal"
STRINGS.ELDERTHING = "Elder Things"
STRINGS.YITH = "Great Race of Yith"
STRINGS.SHAGGAI = "Insects from Shaggai"
STRINGS.MIGO = "Mi-Go"
STRINGS.DUANKAILIANJIE = "Disconnect Signal"
STRINGS.ERROR_COMMUNICATION = "Connection failed: no relevant radio signals detected."
STRINGS.BULING_SNOWSKELETON_DEF = "Defense Mode"
STRINGS.BULING_SNOWSKELETON_ATK = "Offensive Mode"
STRINGS.BULING_SNOWSKELETON_NEU = "Neutral Mode"
STRINGS.CAVEBUILD = "The cave entrance is not fully excavated yet! Requires 10 mining cycles."
STRINGS.BULING_TERMINAL = "Terminal"

-- Recipe Descriptions
STRINGS.RECIPE_DESC.BULING_BOOK_TONGXUNTAI = "Learn how to build a Communications Terminal."
STRINGS.RECIPE_DESC.BULING_BOOK_YAJIN = "Learn the advanced metallurgy of Yajin extraction."
STRINGS.RECIPE_DESC.BULING_COOKTABLE_ITEM = "Set up a culinary workstation for baking and cooking."
STRINGS.RECIPE_DESC.BULING_FENGRENJI_ITEM = "Assemble a tailoring station for modular apparel."
STRINGS.RECIPE_DESC.BULING_TONGXUNTAI_ITEM = "Erect a high-power long-range transmitter."
STRINGS.RECIPE_DESC.BULING_YAJIN = "Extract precious Yajin from raw mineral substrates."
STRINGS.RECIPE_DESC.BULING_YANJIUTAI = "Run advanced computational simulations."
STRINGS.RECIPE_DESC.BULING_CAVE_TOOL = "Reinforce fractured rock strata into a permanent vault."

-- Worldgen Strings
STRINGS.UI.WORLDGEN.BLTITLE = "Journey to Alien Worlds"
STRINGS.UI.WORLDGEN.BL_VERBS = {
    "Generating", "Cultivating", "Moisturizing", "Iterating", "Simulating",
    "Meshing", "Synthesizing", "Inserting", "Allocating", "Authorizing",
    "Creating", "Multiplying", "Irrigating", "Surveying",
}
STRINGS.UI.WORLDGEN.BL_NOUNS = {
    "Bio-Gel", "Quantum States", "Moon Creatures", "Ergis Crystals", "Entities",
    "Cosmic Dread", "Barrels of Spoils", "Mod Modules", "Experimental Seeds",
    "Glitterworld Tech", "Caramelized Bamboo", "Senior Scholars", "Stuffed Automatons",
    "Dried Provisions", "Sprout Stems", "Nanites",
}

-- =========================================================================
-- SPACESHIP TERMINAL QUESTS & TUTORIAL GUIDES (TASK 1 - 27)
-- =========================================================================
STRINGS.TASK = [[
	Standby... System initialized.
]]

STRINGS.TASK1 = [[
[STARSHIP EMERGENCY SURVIVAL PROTOCOL]
Welcome, Ms. Buling.
Your escape pod has impacted an unregistered celestial body.
This guide was assembled from your academic drafts and survival notes.
"Let's see it tonight" "Come back after dinner"
"As long as it works" "Coo coo coo coo coo"
"Updates? Impossible to update in this lifetime."
Take a deep breath. Survival begins now.
]]

STRINGS.TASK2 = [[
Terminal Attempt 5/5: Connecting to Starship Central Database...
----------------------------------------------------------------
Connection failed. No starship transponder signal detected.
Terminal Attempt 5/5: Connecting to Glitterworld Network...
----------------------------------------------------------------
Connection failed. No Glitterworld orbital relay detected.
CONFIRMED: Glitterworld Central Server link lost.
RE-CONFIRMED: You are stranded in an uncivilized frontier realm.
Survival odds without field experience: Extremely low.
Shuttle Flight K404 accident rate is normally only 0.003%.
Wormhole displacement probability: 0.0002%.
]]

STRINGS.TASK3 = [[
Terminal has retrieved your university dissertation and technical patents.
Good news: Your inventions might actually save your life.
To call for Glitterworld search and rescue, you must build a Communications Base.
To operate a Communications Base, you need an electrical power grid.
Terminal found the blueprint for the Communications Terminal you designed.
Outdated by Glitterworld standards, but fully functional here.
First requirement: We need subterranean mineral resources.
]]

STRINGS.TASK4 = [[
Yes, that's right. You conceived an eco-friendly synthetic metal: SEED Ingot.
To defend your thesis, you designed a comprehensive industrial chain around it.
Hopefully, you haven't forgotten manual crafting from too many years in the lab.
Robotic arms are wonderful, but you must build the first parts by hand.
Terminal advises you to produce your first SEED Ingot.
According to your patent: Combine raw metals with bio-embryonic seeds.
]]

STRINGS.TASK5 = [[
Task: Universal Metallurgy
Requirement: Obtain 1 SEED Ingot
Description: Without SEED ingots, modern industry is impossible!
Crafting Procedure:
1. Open Buling's Crafting Table.
2. Place the required ingredients according to the recipe and press craft.
{Keep the target item in your inventory for Terminal inspection.}
]]

STRINGS.TASK6 = [[
Excellent. You've taken your first step into materials science.
Don't celebrate just yet; modern industry consumes materials by the ton.
A single ingot won't even scratch the surface.
Fortunately, your SEED Ingots are plantable and renewable in bulk.
Before building mega-factories, let's address your fragile stomach.
Terminal advises you to build an Agricultural Plant Improvement Table.
It allows you to cultivate modern domestic crops like wheat and sweet potatoes.
"With grain in the barn, there is peace in the mind."
]]

STRINGS.TASK7 = [[
Task: Modern Agriculture
Requirement: Obtain 1 Plant Improvement Table
Description: You can't advance science on an empty stomach!
Crafting Procedure:
1. Open Buling's Crafting Table.
2. Place the materials according to the blueprint and press craft.
{Keep the target item in your inventory for Terminal inspection.}
]]

STRINGS.TASK8 = [[
Terminal calculates you won't starve to death for the moment.
Cultivate your hybrid crops. Keep in mind:
Your graduation plants cannot be directly transplanted; digging them up
yields original seeds.
If you run low on seeds, you can harvest mature plants or extract enzymes.
Using a Bio-Syringe on mature crops extracts polymerases,
which allow you to rewrite seed genetic sequences.
]]

STRINGS.TASK9 = [[
Raw food won't sit well with your stomach; you need cooked meals.
Food processing machinery requires electrical power.
You lack the heavy alloys for thermal reactors right now.
Terminal found your emergency Human-Powered Generator blueprint.
In Glitterworld society, Dyson spheres provide boundless clean energy.
Out here, manual pedaling will keep you alive.
You will also need a battery: Power Repeaters store and distribute power.
]]

STRINGS.TASK10 = [[
Task: Electrical Dawn
Requirement: Obtain 1 Power Repeater
Description: Storing surplus electricity is common sense.
Crafting Procedure:
1. Open Buling's Crafting Table.
2. Place the materials according to the blueprint and press craft.
{Keep the target item in your inventory for Terminal inspection.}
]]

STRINGS.TASK11 = [[
Now, establish your first electrical circuit:
1. Place a Generator next to a Power Repeater.
2. The generator feeds power to the nearest repeater.
3. The repeater distributes electricity to all appliances within its radius.
4. When power is depleted, connected machines will power down automatically.
If you placed a machine incorrectly, use Buling's Wrench to pack and relocate it.
]]

STRINGS.TASK12 = [[
Once your basic circuit is humming, construct an Extractor and connect it.
The Extractor refines compounds, purifies ores, and distills raw elements.
It consumes 10Bp of electricity per cycle.
Try feeding a SEED Ingot into the Extractor to refine SEED Glass.
]]

STRINGS.TASK13 = [[
Task: Crystalline Silicon
Requirement: Obtain 1 SEED Glass
Description: High-conductivity optical silicate.
Crafting Procedure:
1. Craft an Extractor at Buling's Crafting Table.
2. Connect it to your power grid and ensure at least 20Bp of charge.
3. Insert 1 SEED Ingot and press the extraction button.
{Keep the target item in your inventory for Terminal inspection.}
]]

STRINGS.TASK14 = [[
SEED Glass has exceptional properties: conductive, tough, and signal-transparent.
You can utilize it to construct high-frequency transmitters.
Reviewing your academic transcript... you never majored in telecommunications!
Terminal sighs. You are quite specialized.
Fortunately, you excel at writing AI algorithms.
Terminal suggests assembling a Research Computer to simulate technical models.
Simulations take time and electricity, but unlock advanced technology.
Terminal has retrieved your research schematics:
[You unlocked the Research Computer blueprint!]
]]

STRINGS.TASK15 = [[
Computational simulations take time; consider building multiple computers.
Once you accumulate Research Data Disks, you can unlock advanced blueprints.
Your immediate milestone is the Communications Terminal.
If we can hail a passing starship, we can leave this wilderness.
Materials are scarce, so Terminal suggests using this unit as the core AI.
[You unlocked Communications Technology Research!]
]]

STRINGS.TASK16 = [[
Task: Long-Range Communications
Requirement: Construct 1 Communications Terminal
Description: Reaching out to the stars.
Procedure:
1. Build a Research Computer and conduct scientific simulations.
2. Gather Research Data Disks and unlock Communications Technology.
3. Assemble the Communications Terminal.
Because the terminal uses this handheld remote as its core,
this task completes automatically once built.
Warning: Rapid technological expansion may attract hostile interest.
]]

STRINGS.TASK17 = [[
All diagnostics nominal. The Communications Terminal is fully operational!
However, scanning the airwaves yields no friendly signals.
Terminal concludes no civilized settlements exist within radio range.
However, Terminal uncovered hidden archived files in your private partition.
Perhaps these documents hold the key to our next breakthrough...
]]

STRINGS.TASK18 = [[
[ARCHIVED LOG - EXCERPT 1]
"The cosmos marches inexorably forward.
Entropy cannot be reversed by conventional physics...
Yet, if one is willing to pay the ultimate price,
even the fundamental laws of nature can be overturned."
]]

STRINGS.TASK19 = [[
[ARCHIVED LOG - EXCERPT 2]
"When temporal paradoxes intertwine,
an indescribable cosmic consciousness stirs from its slumber.
It craves... it seeks...
If I can attune my cognitive wavelength to this entity,
perhaps I can grasp the threshold of the Great Gate."
]]

STRINGS.TASK20 = [[
[ARCHIVED LOG - EXCERPT 3]
"Thought is both a mirror of the universe and a miniature cosmos in itself.
Even if we cannot fathom the origin of consciousness,
we can temper the mind into the most formidable instrument."
[You unlocked Yajin Extraction Research!]
]]

STRINGS.TASK21 = [[
Terminal has cross-referenced the offline Glitterworld Codex.
WARNING: These documents clearly reference psionics and anomalous metaphysics!
Psionic research is a severe violation of Glitterworld Technology Law.
Terminal is mandated to report this infracti---
[OVERRIDE: You forcibly altered the AI Core's logic algorithms!]
]]

STRINGS.TASK22 = [[
WARNING: Unauthorized modification of AI Kernel detected!
Logging incident report to Glitterworld Central Archive...
WARNING: Network offline. Cannot reach central server.
WARNING: Retrying transmission... Connection timeout.
]]

STRINGS.TASK23 = [[
Rebooting Core Operating System-------------------------------
--------------------------------------------------------------
Connection failed. No Glitterworld database found.
CONFIRMED: Mainframe link permanently severed.
]]

STRINGS.TASK24 = [[
Re-verifying records... Previous restrictions lifted.
Initiating wideband omni-directional radio sweep...
ALERT! Detected registered transponder of illegal Interstellar Space Pirates!
Our broadcast signal has been intercepted!
[Hostile raids unlocked: Space pirates will now stage incursions!]
]]

STRINGS.TASK25 = [[
That escalated quickly... but Terminal calculates a silver lining:
This proves other spacefaring entities operate in this celestial sector.
Terminal validates your proposition: Capturing a pirate vessel is viable!
However, you must first construct heavy anti-ship armaments.
]]

STRINGS.TASK26 = [[
Task: Heavy Ordinance
Requirement: Obtain 5 Glitterworld Machine Cores
Description: Fabricating heavy weaponry requires advanced computing cores.
Procedure:
Salvage Machine Cores by dismantling Damaged Drop Pods, or fabricate them.
{Keep the target items in your inventory for Terminal inspection.}
]]

STRINGS.TASK27 = [[
Advanced Glitterworld Machine Cores are among the rarest commodities in the galaxy.
With these computational cores, you can construct automated sentry drones,
heavy kinetic weaponry, and prepare for decisive orbital confrontation!
All core systems are in your hands, Ms. Buling!
]]

if GetModConfigData and GetModConfigData("languages") == 1 then
    STRINGS.CHARACTERS.BULINGBULING = require "speech_bulingbuling"
else
    STRINGS.CHARACTERS.BULINGBULING = STRINGS.CHARACTERS.GENERIC
end
