-- init.lua
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.ModelConfig = {
    ["models/player/chell.mdl"] = {
        bone = "ValveBiped.Bip01_Neck1",
        offsetPos = Vector(-4, 0, -5),  -- x, y, z
        offsetAng = Angle(30, 0, 0), -- y, p, w
    },
    ["models/begotten/heads/"] = {
        bone = "ValveBiped.Bip01_Spine",
        offsetPos = Vector(-5, 0, -5),  -- x, y, z
        offsetAng = Angle(30, 0, 0), -- y, p, w
    },



}

function ENT:Initialize()
    print("[DEBUG] Collar Initialize")
    self:SetModel("models/begotten/marvless/slavecollar.mdl")

    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
    
    self.Attached = false
    self.NextBeep = CurTime()
    self.Detonated = false
end

function ENT:GetModelConfig(plyModel)
    plyModel = string.lower(plyModel or "")
    if self.ModelConfig[plyModel] then
        return self.ModelConfig[plyModel]
    end

    for key, config in pairs(self.ModelConfig) do
        if string.find(plyModel, key, 1, true) then
            return config
        end
    end

    return nil
end

function ENT:AttachToPlayer(ply, applier, frequency)
    self.frequency = frequency or tostring(math.random(1,100))
    print(frequency)
    self.Applier = applier
    self:SetNWEntity("Applier", applier)

    if not IsValid(ply) or not ply:IsPlayer() then
        print("[DEBUG] Invalid player passed to AttachToPlayer")
        return 
    end
    
    local plyModel = ply:GetModel() or ""
    local config = self:GetModelConfig(plyModel)

    if config then
        local boneName = config.bone
        local offsetPos = config.offsetPos or Vector(0, 0, 0)
        local offsetAng = config.offsetAng or Angle(0, 0, 0)

        local boneIndex = ply:LookupBone(boneName)
        if boneIndex then
            self:SetParent(ply, boneIndex)
            self:SetLocalPos(offsetPos)
            self:SetLocalAngles(offsetAng)
            print("[DEBUG] Model-specific config found for", plyModel)
            print("[DEBUG] Parenting to bone:", boneName, "with offset:", offsetPos, offsetAng)
        else
            print("[DEBUG] Bone not found in config. Falling back to defaults.")
            self:FallbackAttach(ply)
        end
    else
        print("[DEBUG] No model config found for", plyModel, "falling back.")
        self:FallbackAttach(ply)
    end
end

function ENT:FallbackAttach(ply)
    local boneCandidates = {
        "ValveBiped.Bip01_Neck1",
        "ValveBiped.Bip01_Head1",
        -- more
    }

    local chosenBone
    for _, boneName in ipairs(boneCandidates) do
        local idx = ply:LookupBone(boneName)
        if idx then
            chosenBone = idx
            break
        end
    end

    if chosenBone then
        self:SetParent(ply, chosenBone)
        self:SetLocalPos(Vector(0, 0, 0)) --placeholder
        self:SetLocalAngles(Angle(0, 0, 0))
        print("[DEBUG] Fallback attached to bone index:", chosenBone)
    else
        print("[DEBUG] Could not find any fallback bone. Attachment failed.")
    end
end

function ENT:Detonate(reason, player)
    if self.Detonated then return end
    self.Detonated = true
    print("[DEBUG] Collar detonating due to:", reason)
    
    local pos = self:GetPos()
    local explosion = ents.Create("env_explosion")
    if IsValid(explosion) then
        explosion:SetPos(pos)
        explosion:SetOwner(self.Applier or self)
        explosion:Spawn()
        explosion:SetKeyValue("iMagnitude", "100")
        explosion:Fire("Explode", 0, 0)
    end
    
    player:SetNetVar("attached", 0)
    self:Remove()
end

function ENT:Think()
    if not self.Attached or not IsValid(self:GetParent()) then return end
    
    local collared = self:GetParent()

    if IsValid(self.Applier) then
        local distance = collared:GetPos():Distance(self.Applier:GetPos())
        local maxDistance = 3000
        if distance > maxDistance then
            self:Detonate("Distance exceeded", collared)
        end
    end

    self:NextThink(CurTime() + 0.1)
    return true
end
