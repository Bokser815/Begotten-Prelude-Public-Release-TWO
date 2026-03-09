-- cl_init.lua
include("shared.lua")

ENT.NextBeep = 0

function ENT:Draw()
    local parent = self:GetParent()
    --if parent == LocalPlayer() then return end
    self:DrawModel()
end

function ENT:Think()
    local collared = self:GetParent()
    
    if not (IsValid(collared) and collared == LocalPlayer()) then return end
    
    local applier = self:GetNWEntity("Applier")
    if not IsValid(applier) then return end
    
    local distance = collared:GetPos():Distance(applier:GetPos())
    local distanceThreshold = 300
    local maxDistance = 600        
    
    if distance > distanceThreshold then
        local beepInterval = math.Clamp(1 - ((distance - distanceThreshold) / (maxDistance - distanceThreshold)), 0.1, 1)
        if CurTime() >= self.NextBeep then
            self:EmitSound("buttons/combine_button7.wav", 75, 100, 1, CHAN_AUTO)
            self.NextBeep = CurTime() + beepInterval
        end
    end

    self:NextThink(CurTime() + 0.1)
    return true
end