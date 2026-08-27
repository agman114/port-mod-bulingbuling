local assets ={
	Asset("ATLAS", "images/inventoryimages/buling_system.xml"),
}
local function commonfn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst:AddComponent("inspectable")
	inst.AnimState:SetBank("buling_zaxiang")
    inst.AnimState:SetBuild("buling_zaxiang")
    inst.AnimState:PlayAnimation("yaokongqi")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_system"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_system.xml"
	inst:AddComponent("buling_system")
	inst:AddTag("irreplaceable")
	return inst
end
return Prefab("buling_system", commonfn, assets)