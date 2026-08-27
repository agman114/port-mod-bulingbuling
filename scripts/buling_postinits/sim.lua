local function fn(inst)
	local world = TheWorld
	if world and "forest" == "stormplanet"then
		--world:AddTag("mandrua")
		if world.components.quaker then
			world:RemoveComponent("quaker")
		end
	end
end

return fn