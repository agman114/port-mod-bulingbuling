local GLOBAL = _G
local assets ={
	Asset("ATLAS", "images/inventoryimages/buling_system.xml"),
}
local function commonfn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

	inst.AnimState:SetBank("buling_zaxiang")
    inst.AnimState:SetBuild("buling_zaxiang")
    inst.AnimState:PlayAnimation("yaokongqi")

    inst:AddTag("irreplaceable")
    inst:AddTag("buling_system_item")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "buling_system"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/buling_system.xml"
	inst:AddComponent("buling_system")

	return inst
end
return Prefab("buling_system", commonfn, assets)