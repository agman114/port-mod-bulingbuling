local assets = {
    Asset("ANIM", "anim/buling_item.zip"),
}

local prefabs = {
    "explode_small",
    "groundpoundring_fx",
    "sparks_green_fx",
    "smoke_puff",
    "splash_clouds_drop",
}

local function Explode(inst)
    if inst._exploded then return end
    inst._exploded = true

    local x, y, z = inst.Transform:GetWorldPosition()
    
    -- Visual and sound effects
    local boom = SpawnPrefab("explode_small")
    if boom then
        boom.Transform:SetPosition(x, y, z)
    end
    local ring = SpawnPrefab("groundpoundring_fx")
    if ring then
        ring.Transform:SetPosition(x, y, z)
        ring.Transform:SetScale(0.8, 0.8, 0.8)
    end
    local sparks = SpawnPrefab("sparks_green_fx")
    if sparks then
        sparks.Transform:SetPosition(x, y, z)
    end

    inst.SoundEmitter:PlaySound("dontstarve/common/blackpowder_explo")

    if ShakeAllCameras then
        ShakeAllCameras(CAMERASHAKE.FULL, 0.5, 0.04, 1.2, inst, 40)
    end

    -- Area Damage (radius 4.5)
    local attacker = inst.owner
    local ents = TheSim:FindEntities(x, 0, z, 4.5, nil, {"INLIMBO", "FX", "DECOR", "playerghost"})
    for _, ent in ipairs(ents) do
        if ent ~= inst and ent ~= attacker and ent:IsValid() then
            -- Do not hit player or friendly vehicle
            local is_ally = ent:HasTag("player") or ent:HasTag("companion") or ent:HasTag("buling_carrier")
            if not is_ally and ent.components.combat and ent.components.health and not ent.components.health:IsDead() then
                ent.components.combat:GetAttacked(attacker or inst, 150)
                if ent.components.combat.SuggestTarget and attacker then
                    ent.components.combat:SuggestTarget(attacker)
                end
            elseif ent.components.workable and ent.components.workable:CanBeWorked() then
                ent.components.workable:WorkedBy(attacker or inst, 1)
            end
        end
    end

    inst:Remove()
end

local function Launch(inst, target_or_pos, attacker)
    inst.owner = attacker
    local x, y, z = inst.Transform:GetWorldPosition()

    local target_pos = nil
    local target_ent = nil
    if target_or_pos and type(target_or_pos) == "table" and target_or_pos.Transform then
        target_ent = target_or_pos
        target_pos = target_ent:GetPosition()
    elseif target_or_pos and target_or_pos.x then
        target_pos = target_or_pos
    else
        local rad = (attacker and attacker.Transform:GetRotation() or 0) * DEGREES
        target_pos = Vector3(x + 15 * math.cos(rad), 0, z - 15 * math.sin(rad))
    end

    inst:ForceFacePoint(target_pos.x, 0, target_pos.z)

    local speed = 28
    local dx = target_pos.x - x
    local dz = target_pos.z - z
    local dist = math.sqrt(dx * dx + dz * dz)
    if dist < 0.1 then dist = 0.1 end

    local vx = (dx / dist) * speed
    local vz = (dz / dist) * speed

    if inst.Physics then
        inst.Physics:SetMotorVel(vx, 0, vz)
    end

    -- Trail smoke and distance/collision checking
    inst:DoPeriodicTask(0.08, function()
        if not inst:IsValid() then return end
        local cx, cy, cz = inst.Transform:GetWorldPosition()
        
        -- Homing update if target entity exists
        if target_ent and target_ent:IsValid() then
            local epos = target_ent:GetPosition()
            inst:ForceFacePoint(epos.x, 0, epos.z)
            local tdx = epos.x - cx
            local tdz = epos.z - cz
            local tdist = math.sqrt(tdx * tdx + tdz * tdz)
            if tdist < 1.8 then
                Explode(inst)
                return
            end
            if tdist > 0.1 and inst.Physics then
                inst.Physics:SetMotorVel((tdx / tdist) * speed, 0, (tdz / tdist) * speed)
            end
        else
            local cur_dx = target_pos.x - cx
            local cur_dz = target_pos.z - cz
            if (cur_dx * cur_dx + cur_dz * cur_dz) < 3.0 then
                Explode(inst)
                return
            end
        end

        -- Spawn smoke particles
        local puff = SpawnPrefab("splash_clouds_drop") or SpawnPrefab("smoke_puff")
        if puff then
            puff.Transform:SetPosition(cx, cy, cz)
        end
    end)

    -- Auto-detonate after 4 seconds max
    inst:DoTaskInTime(4, Explode)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    if inst.Physics then
        inst.Physics:ClearCollisionMask()
        inst.Physics:CollidesWith(COLLISION.CHARACTERS)
        inst.Physics:CollidesWith(COLLISION.GIANTS)
    end

    inst.AnimState:SetBank("buling_item")
    inst.AnimState:SetBuild("buling_item")
    inst.AnimState:PlayAnimation("buling_daodan", true)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.Transform:SetScale(1.8, 1.8, 1.8)

    inst:AddTag("projectile")
    inst:AddTag("weapon")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false
    inst.Launch = Launch
    inst.Explode = Explode

    return inst
end

return Prefab("buling_missile", fn, assets, prefabs)
