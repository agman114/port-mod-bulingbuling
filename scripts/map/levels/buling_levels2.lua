local require = GLOBAL.require
require("map/level")

local AddTaskToLevel = GLOBAL.rawget(GLOBAL, "AddTaskToLevel")

-- Register additional desert tasks into standard DST levels
local extra_tasks = {
	"buling_Desert",
	"buling_Desert2",
	"buling_Desert3",
}

if AddTaskToLevel ~= nil then
	for _, taskname in ipairs(extra_tasks) do
		AddTaskToLevel("SURVIVAL", taskname)
		AddTaskToLevel("FOREST", taskname)
	end
end
