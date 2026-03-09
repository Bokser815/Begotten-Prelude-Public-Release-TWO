--[[ 
    Begotten III: Jesus Wept - Rounds Plugin
    By: DETrooper, cash wednesday, gabs, alyousha35, etc.

    Based on XRP's buff plugin
    Special thanks to Xyz for ruining my life
--]]

PLUGIN:SetGlobalAlias("Rounds");

--Clockwork.kernel:IncludePrefixed("cl_hooks.lua");
--Clockwork.kernel:IncludePrefixed("sv_hooks.lua");
Rounds = Rounds or {}
Rounds.debug = true

Rounds.hazardEffects = {
    WarningAlarm = {
        OnSet = function(self, ent)
            if Rounds.debug then print("[Rounds] WarningAlarm: Stage initiated for entity:", ent) end
            --ent:EmitSound("combine bank alarm")
            --[[if Schema and Schema:EasyText then
                for _, ply in ipairs(player.GetAll()) do
                    --Schema:EasyText(ply, "warning", "WARNING: Faggot inbound!")
                end
            end--]]  --rewrite to use networked var
        end,
        Think = function(self, ent)
        end,
        OnRemove = function(self, ent)
        end,
    },
    DeepRumble = {
        OnSet = function(self, ent)
            if Rounds.debug then print("[Rounds] DeepRumble: Stage initiated for entity:", ent) end
            local rumblePos = ent:GetPos() + Vector(0, 0, -100)
            --sound.Play("rumble_sound.wav", rumblePos, 80, 100)
            util.ScreenShake(ent:GetPos(), 10, 2, 10, 600, true)
        end,
        Think = function(self, ent)
        end,
        OnRemove = function(self, ent)
        end,
    },
    ExplosionFire = {
        OnSet = function(self, ent)
            if Rounds.debug then print("[Rounds] ExplosionFire: Stage initiated for entity:", ent) end
            local explosionCount = 5
            for i = 1, explosionCount do
                local pos = GetValidSpawnPos(ent)
                local flame = ents.Create("cw_flame")
                if IsValid(flame) then
                    flame:SetPos(pos)
                    flame.DamageParent = ent
                    flame.DieTime = CurTime() + Rounds.lifetime
                    flame.ExplodeOnDeath = true
                    flame:Spawn()
                    flame:PhysWake()
                    if Rounds.debug then
                        print("[Rounds] ExplosionFire: Spawned cw_flame at " .. tostring(pos))
                    end
                else
                    if Rounds.debug then
                        print("[Rounds] ExplosionFire: Failed to spawn cw_flame at " .. tostring(pos))
                    end
                end
            end
        end,
        Think = function(self, ent)
        end,
        OnRemove = function(self, ent)
        end,
    },
}

Rounds.rounds = {
    ["Oil Fires"] = {
        stages = {
            { duration = 5, hazard = "WarningAlarm" },
            { duration = 5, hazard = "DeepRumble" },
            { duration = 0, hazard = "ExplosionFire" },  
        },
    },
}

Rounds.currentStageIndex = 1
Rounds.stageSetTime = CurTime()
Rounds.stages = {}
Rounds.entity = nil 

function Rounds:GetEntity()
    return self.entity
end

function Rounds:GetCurrentStage()
    return self.stages[self.currentStageIndex]
end

function Rounds:SetStage(newStageIndex)
    self.currentStageIndex = newStageIndex
    self.stageSetTime = CurTime()
    local stage = self:GetCurrentStage()
    if stage and self.hazardEffects[stage.hazard] and self.hazardEffects[stage.hazard].OnSet then
        self.hazardEffects[stage.hazard].OnSet(self, self:GetEntity())
    end
end

function Rounds:LoadRound(roundName)
    local roundData = self.rounds[roundName]
    if not roundData then return end
    self.stages = roundData.stages
    self:SetStage(1)
end

function Rounds:OnAssigned(ent)
    self.entity = ent
    self.currentStageIndex = 1
    self.stageSetTime = CurTime()
    local stage = self:GetCurrentStage()
    if stage and self.hazardEffects[stage.hazard] and self.hazardEffects[stage.hazard].OnSet then
        self.hazardEffects[stage.hazard].OnSet(self, ent)
    end
end

function Rounds:Think()
    local stage = self:GetCurrentStage()
    if not stage then return end
    if stage.duration > 0 and CurTime() > self.stageSetTime + stage.duration then
        local nextStage = self.currentStageIndex + 1
        if nextStage <= #self.stages then
            self:SetStage(nextStage)
        else
            self:Remove()
            return
        end
    end
    if stage and self.hazardEffects[stage.hazard] and self.hazardEffects[stage.hazard].Think then
        self.hazardEffects[stage.hazard].Think(self, self:GetEntity())
    end
end

function Rounds:OnRemove()
    for i = 1, self.currentStageIndex do
        local stage = self.stages[i]
        if stage and self.hazardEffects[stage.hazard] and self.hazardEffects[stage.hazard].OnRemove then
            self.hazardEffects[stage.hazard].OnRemove(self, self:GetEntity())
        end
    end
end

function Rounds:TimeUntilNextStage()
    local stage = self:GetCurrentStage()
    if stage and stage.duration > 0 then
        return stage.duration - (CurTime() - self.stageSetTime)
    end
    return 0
end
