local buling_getenzyme = Class(function(self, inst)
    self.inst = inst
end)


function buling_getenzyme:OnRead(reader)
    if self.onread then
        return self.onread(self.inst, reader)
    end

    return true
end
function buling_getenzyme:CollectUseActions(doer, target, actions)
    if target.components.crop and target.components.crop.matured and target:HasTag("buling_plant") then
        table.insert(actions, ACTIONS.BULING_ENZYME)
    end
end

return buling_getenzyme