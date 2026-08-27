local require = GLOBAL.require
require("map/level")

local AddTaskToLevel = GLOBAL.rawget(GLOBAL, "AddTaskToLevel")

-- Register BulingBuling custom tasks into standard DST levels for seamless worldgen compatibility
local tasks = {
	"buling_Island2",
	"buling_Island3",
	"buling_Island4",
	"buling_Island5",
	"buling_Island6",
	"buling_Desert",
	"buling_civilization",
	"buling_moon",
}

if AddTaskToLevel ~= nil then
	for _, taskname in ipairs(tasks) do
		AddTaskToLevel("SURVIVAL", taskname)
		AddTaskToLevel("FOREST", taskname)
	end
	AddTaskToLevel("CAVE", "WorldTask")
	AddTaskToLevel("CAVE", "WorldTask2")
end
