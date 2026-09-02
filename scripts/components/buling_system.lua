local buling_system = Class(function(self, inst)
    self.inst = inst
end)


function buling_system:OnRead(reader)
    if self.onread then
        return self.onread(self.inst, reader)
    end

    return true
end

function buling_system:CollectSceneActions(doer, actions)
    table.insert(actions, ACTIONS.BULING_STSTEM)
end

function buling_system:CollectInventoryActions(doer, actions)
    table.insert(actions, ACTIONS.BULING_STSTEM)
end

return buling_system