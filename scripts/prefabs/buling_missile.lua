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

local function FindNearbyEnemy(x, z, radius, ignore_ent, attacker)
    local ents = TheSim:FindEntities(x, 0, z, radius or 15, {"_combat"}, {"INLIMBO", "FX", "DECOR", "playerghost", "wall"})
    local best = nil
    local best_dsq = math.huge
    for _, e in ipairs(ents) do
        if e:IsValid() and e ~= ignore_ent and e ~= attacker then
            local is_ally = e:HasTag("player") or e:HasTag("companion") or e:HasTag("buling_carrier")
            if not is_ally and e.components.combat and e.components.health and not e.components.health:IsDead() then
                local dsq = e:GetDistanceSqToPoint(x, 0, z)
                if dsq < best_dsq then
                    best_dsq = dsq
                    best = e
                end
            end
        end
    end
    return best
end

local function Launch(inst, target_or_pos, attacker)
    inst.owner = attacker
    local x, y, z = inst.Transform:GetWorldPosition()

    local target_pos = nil
    local target_ent = nil

    if target_or_pos and type(target_or_pos) == "table" and target_or_pos.Transform and target_or_pos:IsValid() then
        target_ent = target_or_pos
        target_pos = target_ent:GetPosition()
    elseif target_or_pos and target_or_pos.x then
        target_pos = target_or_pos
        -- Check if an enemy is near target_pos
        target_ent = FindNearbyEnemy(target_pos.x, target_pos.z, 6, inst, attacker)
    end

    -- If still no enemy target, search around attacker
    if not target_ent and attacker and attacker:IsValid() then
        local ax, ay, az = attacker.Transform:GetWorldPosition()
        target_ent = FindNearbyEnemy(ax, az, 25, inst, attacker)
        if target_ent then
            target_pos = target_ent:GetPosition()
        end
    end

    if not target_pos then
        local rad = (attacker and attacker.Transform:GetRotation() or 0) * DEGREES
        target_pos = Vector3(x + 20 * math.cos(rad), 0, z - 20 * math.sin(rad))
    end

    inst.target_ent = target_ent
    inst.target_pos = target_pos

    -- Face target and move directly FORWARD
    local speed = 26
    inst:ForceFacePoint(target_pos.x, 0, target_pos.z)
    if inst.Physics then
        inst.Physics:SetMotorVel(speed, 0, 0)
    end

    -- Flight task: real-time homing towards enemy
    inst:DoPeriodicTask(0.05, function()
        if not inst:IsValid() or inst._exploded then return end
        local cx, cy, cz = inst.Transform:GetWorldPosition()

        -- Update homing target
        if inst.target_ent and inst.target_ent:IsValid() and not (inst.target_ent.components.health and inst.target_ent.components.health:IsDead()) then
            inst.target_pos = inst.target_ent:GetPosition()
        else
            -- Search for any new enemy along path
            local nearby = FindNearbyEnemy(cx, cz, 8, inst, attacker)
            if nearby then
                inst.target_ent = nearby
                inst.target_pos = nearby:GetPosition()
            end
        end

        local tpos = inst.target_pos
        if tpos then
            inst:ForceFacePoint(tpos.x, 0, tpos.z)
            if inst.Physics then
                inst.Physics:SetMotorVel(speed, 0, 0)
            end

            local dsq = (cx - tpos.x)^2 + (cz - tpos.z)^2
            if dsq <= 4.0 then
                Explode(inst)
                return
            end
        end

        -- Smoke trail
        local puff = SpawnPrefab("splash_clouds_drop") or SpawnPrefab("smoke_puff")
        if puff then
            puff.Transform:SetPosition(cx, cy, cz)
        end
    end)

    inst:DoTaskInTime(4, Explode)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)

    inst.AnimState:SetBank("buling_item")
    inst.AnimState:SetBuild("buling_item")
    inst.AnimState:PlayAnimation("buling_daodan", true)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.Transform:SetScale(1.8, 1.8, 1.8)

    inst:AddTag("projectile")
    inst:AddTag("weapon")
    inst:AddTag("NOCLICK")

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
