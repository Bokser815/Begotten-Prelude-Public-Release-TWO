include("shared.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

Clockwork.plugin:Include("champions")

util.AddNetworkString("ShowRetroMessage")

--bokser makes these ugly not me
ENT.isonline            = false
ENT.spawningmonsters    = false
ENT.confirmtimer        = 0
ENT.wavetimer           = 0
ENT.currentWave         = 0
ENT.usepauser           = 0
ENT.spawnedsofar        = 0
ENT.waittospawnnext     = 0
ENT.waveComplete        = false
ENT.debug               = true -- prints
ENT.removethrallcount   = 0
ENT.maxthralltofail     = 6

ENT.arenaRadius         = 7000
--[[ENT.combatMusicTracks   = {
    "begotten3soundtrack/combatgoeric/hb-bridgecombatthird.mp3",
    "ambience/outskirtscombat/defenders_of_light.mp3",
    "ambience/outskirtscombat/northern_horde.mp3",
}]]--
ENT.basePlayers         = 2      

ENT.wavelength = {
    [1] = 20,
    [2] = 10,
    [3] = 15,  
    [4] = 10,
    [5] = 10, 
}
ENT.wavespawns = {
    [1] = 3,
    [2] = 5,
    [3] = 7,
    [4] = 9,
    [5] = 12,
}
ENT.waveslist = {
    ["wave1"] = { "npc_bgt_another" },
    ["wave2"] = { "npc_bgt_another", "npc_bgt_shambler" },
    ["wave3"] = { "npc_bgt_shambler", "npc_bgt_brute" },
    ["wave4"] = { "npc_bgt_brute", "npc_bgt_eddie" },
    ["wave5"] = { "npc_bgt_suitor", "npc_bgt_grunt" },
}
ENT.prizes = {
    [1] = { "fuel_can" },
    [2] = { "fuel_can" },
    [3] = { "fuel_can" },
    [4] = { "fuel_can" },
    [5] = { "fuel_can" },
}
ENT.wavefuelquality = {
    [1] = 20,
    [2] = 40,
    [3] = 60,
    [4] = 80,
    [5] = 100,
}
ENT.bossWave            = 3
ENT.globalChampionChance = 0.2

ENT.drillingsitestofix = {}

local function PlaySpawnEffects(origin, effectType)
    if effectType == "boss" then
        ParticleEffect("boss_spawn_fx", origin, Angle(0, 0, 0), nil)
        sound.Play("custom/boss_spawn.wav", origin, 100, 100)
        print("[OilTerminal DEBUG] PlaySpawnEffects: Boss effect at " .. tostring(origin))
    else
        ParticleEffect("teleport_fx", origin, Angle(0, 0, 0), nil)
        sound.Play("misc/summon.wav", origin, 100, 100)
        print("[OilTerminal DEBUG] PlaySpawnEffects: Standard effect at " .. tostring(origin))
    end
end

local function GetValidSpawnPos(ent)
    local basePos = ent:GetPos()
    local offset = Vector(math.random(-ent.arenaRadius, ent.arenaRadius)/5,math.random(-ent.arenaRadius, ent.arenaRadius)/5,0)
    local candidatePos = basePos + offset

    local traceData = {
        start = candidatePos,
        endpos = candidatePos - Vector(0, 0, 4000),
        filter = ent,
        mask = MASK_ALL
    }
    local traceResult = util.TraceLine(traceData)
    
    if traceResult.Hit then
        local validPos = traceResult.HitPos + traceResult.HitNormal * 10
        candidatePos = validPos
    end

    return candidatePos
end

local function SpawnHazard()
    local hazardPos = GetValidSpawnPos(self)
    local hazard = ents.Create("env_fire")
    if not IsValid(hazard) then 
        if self.debug then print("[OilTerminal DEBUG] SpawnHazard: Failed to create hazard entity.") end
        return 
    end
    hazard:SetPos(hazardPos)
    hazard:Spawn()
    hazard:Activate()
    sound.Play("ambient/fire/ignite.wav", hazardPos, 90, 100)
    if self.debug then
        print("[OilTerminal DEBUG] SpawnHazard: Hazard spawned at " .. tostring(hazardPos))
    end
    timer.Simple(5, function()
        if IsValid(hazard) then
            hazard:Remove()
            if self.debug then
                print("[OilTerminal DEBUG] SpawnHazard: Hazard removed after timer.")
            end
        end
    end)
end

function ENT:Initialize()
    self:SetModel("models/cire992/props/labtech10.mdl")
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetMaterial("models/props/de_nuke/pipeset_metal")
    
    local physObj = self:GetPhysicsObject()
    if IsValid(physObj) then
        physObj:Wake()
        if self.debug then
            print("[OilTerminal DEBUG] Initialize: Physics object valid and awakened.")
        end
    else
        if self.debug then
            print("[OilTerminal DEBUG] Initialize: Physics object invalid!")
        end
    end
    for k, v in pairs(ents.FindInSphere(self:GetPos(), 7000)) do
        local zDifference = math.abs(self:GetPos().z - v:GetPos().z)
        if v:GetClass() == "prop_dynamic" and (zDifference < 600) and (!v.notoilfieldactivated or v.notoilfieldactivated == false) then
            v:SetCycle(0) -- Freezes the animation at the beginning
            v:SetPlaybackRate(0)
        end
    end
end

function ENT:MachineText(user, message)
    util.ScreenShake(self:GetPos(), 15, 2, 4, 600, true)
    Clockwork.chatBox:SetMultiplier(1.5)
    Clockwork.chatBox:Add(user, nil, "machine", message)
    if self.debug then
        print("[OilTerminal DEBUG] MachineText: '" .. message .. "' sent to " .. (IsValid(user) and user:Name() or "nil"))
    end
end



function ENT:DispensePrize(prize)
    local currentPrizeList = self.prizes[self.currentWave]
    if not currentPrizeList then 
        if self.debug then print("[OilTerminal DEBUG] DispensePrize: No prize list for wave " .. tostring(self.currentWave)) end
        return 
    end
    self:EmitSound("fiend/prizeyay.wav")
    local itemName = prize or table.Random(currentPrizeList)
    local itemTable = item.CreateInstance(itemName)
    if itemTable then
        itemTable:SetCondition(self.wavefuelquality[self.currentWave])
        local spawnPos = (self:GetPos() + Vector(0, 0, 40)) + self:GetForward() * 30
        local rewardItem = Clockwork.entity:CreateItem(nil, itemTable, spawnPos)
        if IsValid(rewardItem) then
            rewardItem:Spawn()
            --rewardItem:EmitSound("garrysmod/save_load1.wav")
            rewardItem:SetNWBool("OilTerminalReward", true)
            --PlaySpawnEffects(spawnPos)
            
            local phys = rewardItem:GetPhysicsObject()
            if IsValid(phys) then
                phys:ApplyForceCenter(self:GetAngles():Forward() * 600)
                phys:ApplyForceCenter(self:GetAngles():Up() * 200)
                phys:AddAngleVelocity(Vector(600, math.random(-1200, 1200), 0))
                if self.debug then
                    print("[OilTerminal DEBUG] DispensePrize: Physics applied to reward item.")
                end
            end
            Clockwork.entity:Decay(rewardItem, 300)
            rewardItem.lifeTime = CurTime() + 300
            if self.debug then
                print("[OilTerminal DEBUG] DispensePrize: Prize item spawned at " .. tostring(spawnPos))
            end
        end
    else
        if self.debug then
            print("[OilTerminal DEBUG] DispensePrize: Failed to create item instance for " .. tostring(itemName))
        end
    end
end

function ENT:StartWave()
    self.waveComplete = false
    self.spawningmonsters = true
    self.currentWave = self.currentWave + 1
    self:SetNWInt("wave", self.currentWave)
    
    if not self.wavelength[self.currentWave] then
        if self.debug then print("[OilTerminal DEBUG] StartWave: Invalid wave index: " .. self.currentWave) end
        self:TerminateChallenge()
        return
    end
    
    if self.currentWave == 1 then
            
        local playersInArena = {}
        for _, ply in ipairs(ents.FindInSphere(self:GetPos(), self.arenaRadius)) do
            if IsValid(ply) and ply:IsPlayer() then
                playersInArena[#playersInArena + 1] = ply
            end
        end
        if #playersInArena>0 then
            local nextpump
            for k, v in pairs(ents.FindInSphere(self:GetPos(), 9000)) do
                local zDifference = math.abs(self:GetPos().z - v:GetPos().z)
                
                if v:GetClass() == "prop_dynamic" and !self.drillingsitestofix[tostring(v)] and (zDifference < 600) and (!v.notoilfieldactivated or v.notoilfieldactivated == false) then
                    print(v:GetPos())
                    nextpump = v
                    v:EmitSound("fiend/drillingstartalarm.wav", 140, 100,1 )
                    v:EmitSound("fiend/drillstartuplocation.wav", 140, 100, 1)
                    util.ScreenShake(v:GetPos(), 30, 2, 6, 1000, true)
                    v:EmitSound("fiend/thrallemerge" .. math.random(1, 3) .. ".wav")
                    v:SetCycle(1) -- Freezes the animation at the beginning
                    v:SetPlaybackRate(1)
                    self.drillingsitestofix[tostring(v)] = true
                    break
                end
            end
            local mins, maxs = nextpump:GetCollisionBounds()
            local height = maxs.z - mins.z
            local pos = nextpump:GetPos()+ Vector(0, 0, height*0.6)
            local nextvector = pos
            net.Start("ShowRetroMessage")
            net.WriteBool(true)
            net.WriteDouble(nextvector.X)
            net.WriteDouble(nextvector.Y)
            net.WriteDouble(nextvector.Z)
            net.WriteFloat(self.currentWave)
            net.Send(playersInArena)
        end
    end

    self.wavetimer = CurTime() + self.wavelength[self.currentWave]
    self.spawnedsofar = 0
    self.activeEnemies = 0
    self.terminalNPCs = {}

    if self.loopingsound then
        self:StopLoopingSound(self.loopingsound)
    end

    if self.currentWave > 3 then
        self.loopingsound = self:StartLoopingSound("fiend/drillingloopfastest.wav")
        self:EmitSound("fiend/compfinalwave.wav")
    else
        self.loopingsound = self:StartLoopingSound("fiend/drillingloopfast.wav")
        if self.currentWave > 1 then
            self:EmitSound("fiend/compwaveonedone.wav")
        end
    end

    if not self.machineSound then
        self.machineSound = CreateSound(self, "ambient/energy/spark6.wav")
        self.machineSound:Play()
        if self.debug then
            print("[OilTerminal DEBUG] StartWave: Machine sound started.")
        end
    end

    local playersInArena = 0
    for _, ply in ipairs(ents.FindInSphere(self:GetPos(), self.arenaRadius)) do
        if ply:IsPlayer() then
            playersInArena = playersInArena + 1
        end
    end
    self.difficultyFactor = 1 + ((playersInArena - self.basePlayers) * 0.25)
    if self.difficultyFactor < 1 then self.difficultyFactor = 1 end
    if self.debug then
        print("[OilTerminal DEBUG] StartWave: Wave " .. self.currentWave .. " starting with " .. playersInArena .. " players. Difficulty factor: " .. self.difficultyFactor)
    end

    if self.currentWave == self.bossWave then
        local bossSpawnPos = GetValidSpawnPos(self)
        local bossNPC = ents.Create("npc_drg_animals_wolf")
        if IsValid(bossNPC) then
            bossNPC:SetPos(bossSpawnPos)
            bossNPC:SetAngles(Angle(0, math.random(0, 360), 0))
            bossNPC:Spawn()
            bossNPC:SetNWBool("OilTerminalEnemy", true)
            bossNPC.IsOilTerminalNPC = true
            local baseHealth = bossNPC:GetMaxHealth() or 100
            local newHealth = baseHealth * self.difficultyFactor * 2
            bossNPC:SetMaxHealth(newHealth)
            bossNPC:SetHealth(newHealth)
            bossNPC.damage = (bossNPC.damage or 10) * 1.5
            bossNPC:SetModelScale(2, 0)
            bossNPC.championType = "Boss"
            bossNPC:SetColor(Color(255, 0, 0))
            bossNPC.bossSound = CreateSound(bossNPC, "custom/boss_move.wav")
            bossNPC.bossSound:Play()
            table.insert(self.terminalNPCs, bossNPC)
            self.activeEnemies = self.activeEnemies + 1
            PlaySpawnEffects(bossSpawnPos, "boss")
            if self.debug then
                print("[OilTerminal DEBUG] StartWave: Boss NPC spawned at " .. tostring(bossSpawnPos))
            end
        else
            if self.debug then print("[OilTerminal DEBUG] StartWave: Failed to spawn boss NPC.") end
        end
    end
end



function ENT:CreateWaveEnemy()
    local pos = GetValidSpawnPos(self)
    if !self.waveslist or !self.waveslist["wave" .. self.currentWave] then 
        if self.debug then
            print("[OilTerminal DEBUG] Turbo fucked incident no tables.")
        end
        return 
    end
    local npcType = table.Random(self.waveslist["wave" .. self.currentWave])
    if self.debug then
        print("[OilTerminal DEBUG] CreateWaveEnemy: Attempting to spawn NPC of type " .. tostring(npcType))
    end
    local npcEntity = ents.Create(npcType)
    if not IsValid(npcEntity) then 
        if self.debug then print("[OilTerminal DEBUG] CreateWaveEnemy: NPC entity invalid!") end
        return 
    end

    npcEntity:SetPos(pos)
    npcEntity:SetAngles(Angle(0, math.random(0, 360), 0))
    npcEntity:Spawn()
    npcEntity:SetNWBool("OilTerminalEnemy", true)
    npcEntity.IsOilTerminalNPC = true
    self:EmitSound("fiend/metalstrain" .. math.random(1, 3) .. ".wav")
    npcEntity:EmitSound("fiend/thrallemerge" .. math.random(1, 3) .. ".wav")

    local baseHealth = npcEntity:GetMaxHealth() or 100
    local newHealth = baseHealth * self.difficultyFactor
    npcEntity:SetMaxHealth(newHealth)
    npcEntity:SetHealth(newHealth)
    npcEntity.lifetimespawn = CurTime()
    if math.random() < self.globalChampionChance then
        if Champions and Champions.MakeChampion then
            Champions:MakeChampion(npcEntity)
            if self.debug then print("[OilTerminal DEBUG] CreateWaveEnemy: NPC promoted to Champion!") end
        else
            if self.debug then print("[OilTerminal DEBUG] CreateWaveEnemy: Champions module not found!") end
        end
    end

    PlaySpawnEffects(pos)
    util.ScreenShake(pos, 10, 2, 3, 600, true)
    npcEntity:EmitSound("fiend/thrallemerge" .. math.random(1, 3) .. ".wav")

    self.activeEnemies = (self.activeEnemies or 0) + 1
    self.terminalNPCs = self.terminalNPCs or {}
    table.insert(self.terminalNPCs, npcEntity)
    self.spawnedsofar = self.spawnedsofar + 1

    if self.debug then
        print("[OilTerminal DEBUG] CreateWaveEnemy: Spawned enemy. Total spawned in wave: " .. self.spawnedsofar)
    end

    if math.random() < 0.1 then
        if self.debug then print("[OilTerminal DEBUG] CreateWaveEnemy: Spawning environmental hazard.") end
        --SpawnHazard()
    end
end

function ENT:CheckEnemies()
    if not self.terminalNPCs then return end
    for i = #self.terminalNPCs, 1, -1 do
        local npc = self.terminalNPCs[i]
        local pos = self:GetPos()--
        if IsValid(npc) then
            if npc:GetPos():Distance(pos) > self.arenaRadius or ((npc:GetPos().Z < pos.Z - 300) or (npc:GetPos().Z > pos.Z + 300)) or (npc.lifetimespawn and npc.lifetimespawn + 180 < CurTime()) then
                self:CreateWaveEnemy()
                PlaySpawnEffects(npc:GetPos())
                npc:Remove()
                if self.debug then
                    print("[OilTerminal DEBUG] Reset broken enemy." .. self.activeEnemies)
                end
                --[[
                self.removethrallcount = self.removethrallcount + 1
                if self.removethrallcount and self.removethrallcount > self.maxthralltofail then
                    self:TerminateChallenge()
                end
                ]]
            end
        end
        if not IsValid(npc) then
            table.remove(self.terminalNPCs, i)
            self.activeEnemies = self.activeEnemies - 1
            if self.debug then
                print("[OilTerminal DEBUG] CheckEnemies: Enemy removed. Active enemies: " .. self.activeEnemies)
            end
            if self.activeEnemies <= 0 and self.spawningmonsters then
                self:CompleteWave()
            end
        end
    end
end

function ENT:CompleteWave()
    --self:EmitSound("garrysmod/content_downloaded.wav")
    self:EmitSound("fiend/compwaveonedone.wav")
    local prizewavely = "tech"
    self:DispensePrize()
    timer.Simple(0.5, function()
        self:DispensePrize(prizewavely)
    end)
    if self.loopingsound then
        self:StopLoopingSound(self.loopingsound)
    end
    self.spawningmonsters = false
    self.waveComplete = true
    if self.debug then
        print("[OilTerminal DEBUG] CompleteWave: Wave " .. self.currentWave .. " completed.")
    end
    local playersInArena = {}
    for _, ply in ipairs(ents.FindInSphere(self:GetPos(), self.arenaRadius)) do
        if IsValid(ply) and ply:IsPlayer() then
            playersInArena[#playersInArena + 1] = ply
        end
    end
    if #playersInArena>0 then
        local nextpump
        for k, v in pairs(ents.FindInSphere(self:GetPos(), 9000)) do
            local zDifference = math.abs(self:GetPos().z - v:GetPos().z)
            
            if v:GetClass() == "prop_dynamic" and !self.drillingsitestofix[tostring(v)] and (zDifference < 600) and (!v.notoilfieldactivated or v.notoilfieldactivated == false) then
                nextpump = v
                v:EmitSound("fiend/drillingstartalarm.wav", 140, 100,1 )
                v:EmitSound("fiend/drillstartuplocation.wav", 140, 100, 1)
                util.ScreenShake(v:GetPos(), 30, 2, 6, 1000, true)
                v:EmitSound("fiend/thrallemerge" .. math.random(1, 3) .. ".wav")
                v:SetCycle(1) -- Freezes the animation at the beginning
                v:SetPlaybackRate(1)
                self.drillingsitestofix[tostring(v)] = true
                break
            end
        end
        local mins, maxs = nextpump:GetCollisionBounds()
        local height = maxs.z - mins.z
        local pos = nextpump:GetPos()+ Vector(0, 0, height*0.6)
        local nextvector = pos
        net.Start("ShowRetroMessage")
        net.WriteBool(true)
        net.WriteDouble(nextvector.X)
        net.WriteDouble(nextvector.Y)
        net.WriteDouble(nextvector.Z)
        net.WriteFloat(self.currentWave+1)
        net.Send(playersInArena)
    end
end

function ENT:TerminateChallenge()
    self.currentWave = 0
    self.spawnedsofar = 0
    self:SetNWInt("wave", self.currentWave)
    self.spawningmonsters = false
    self.isonline = false
    if self.loopingsound then
        self:StopLoopingSound(self.loopingsound)
    end

    for k, v in pairs(ents.FindInSphere(self:GetPos(), 7000)) do
        local zDifference = math.abs(self:GetPos().z - v:GetPos().z)
        if v:GetClass() == "prop_dynamic" and (zDifference < 600) and (!v.notoilfieldactivated or v.notoilfieldactivated == false) then
            v:SetCycle(0) -- Freezes the animation at the beginning
            v:SetPlaybackRate(0)
        end
    end

    local playersInArena = {}
    for _, ply in ipairs(ents.FindInSphere(self:GetPos(), self.arenaRadius)) do
        if IsValid(ply) and ply:IsPlayer() then
            playersInArena[#playersInArena + 1] = ply
        end
    end

    if self.removethrallcount and self.removethrallcount >= self.maxthralltofail and #playersInArena>0 then
        util.AddNetworkString("ShowRetroMessage")
        net.Start("ShowRetroMessage")
        net.WriteBool(true)
        net.WriteFloat(900)
        net.Send(playersInArena)
    end

    self:DispensePrize()
    --self:EmitSound("garrysmod/balloon_pop_cute.wav")
    --self:EmitSound("fiend/prizeyay.wav");
    self:EmitSound("fiend/comperror.wav")
    if self.debug then
        print("[OilTerminal DEBUG] TerminateChallenge: Terminal shut down mid-wave.")
    end
    self.removethrallcount = 0
end

function ENT:UpdatePlayerFlags()
    local inSphere = ents.FindInSphere(self:GetPos(), self.arenaRadius)
    local playersInSphere = {}
    local playercount = 0
    for _, ent in ipairs(inSphere) do
        if IsValid(ent) and ent:IsPlayer() and ent:Alive() then
            playercount = playercount + 1
        end
    end
    self.playercount = playercount
end

function ENT:Think()
    if not self.thinktimer then self.thinktimer = 0 end
    if self.thinktimer > CurTime() then return end
    self.thinktimer = CurTime() + 1

    self:UpdatePlayerFlags()
    if !self.difficultyFactor then self.difficultyFactor = 1 end
    if self.spawningmonsters then
        if self.wavetimer < CurTime() then
            if self.spawnedsofar < (self.wavespawns[self.currentWave] * self.difficultyFactor) and self.waittospawnnext < CurTime() then
                self.waittospawnnext = CurTime() + ((self.wavelength[self.currentWave] / self.wavespawns[self.currentWave]) - 1)
                self:CreateWaveEnemy()
                if self.debug then
                    print("[OilTerminal DEBUG] Think: Spawned enemy in wave " .. self.currentWave)
                end
            end
        end
    end

    self:CheckEnemies()
end

function ENT:Use(Activator, Caller, UseType, Integer)
    if not IsValid(Activator) or not Activator:IsPlayer() or not Activator:Alive() then return end
    if self.usepauser > CurTime() then return end
    self.usepauser = CurTime() + 1

    if self.spawningmonsters then
        if self.confirmtimer > CurTime() then
            self:TerminateChallenge()
            if self.debug then
                print("[OilTerminal DEBUG] Use: Confirmed shutdown. Terminating challenge.")
            end
            return
        else
            Schema:EasyText(Activator, "chocolate", "Confirm shutdown of terminal?")
            --self:EmitSound("garrysmod/balloon_pop_cute.wav")
            self:EmitSound("fiend/compconfirm.wav")
            self.confirmtimer = CurTime() + 10
            if self.debug then
                print("[OilTerminal DEBUG] Use: Prompting shutdown confirmation.")
            end
            return
        end
    end

    if self.isonline then
        if not self.waveComplete then
            Schema:EasyText(Activator, "chocolate", "Terminal already active. Confirm operation?")
            --self:EmitSound("garrysmod/balloon_pop_cute.wav")
            self:EmitSound("fiend/compconfirm.wav")
            self.isconfirmed = CurTime() + 10
            if self.debug then
                print("[OilTerminal DEBUG] Use: Terminal active, awaiting confirmation.")
            end
            return
        else
            self:StartWave()
            if self.debug then
                print("[OilTerminal DEBUG] Use: Starting new wave as terminal is online and previous wave is complete.")
            end
            return
        end
    end

    if Activator:HasItemByID("tech") then
        Activator:TakeItem(Activator:FindItemByID("tech"))
        self.isonline = true
        self.spawnedsofar = 0
        Schema:EasyText(Activator, "chocolate", "Oil terminal activated. Initiating sequence...")
        --self:EmitSound("garrysmod/ui_click.wav")
        self:EmitSound("fiend/componline.wav")
        if self.debug then
            print("[OilTerminal DEBUG] Use: Tech used, terminal activated by " .. Activator:Name())
        end
        self:StartWave()
    else
        Schema:EasyText(Activator, "chocolate", "You do not have the required tech to repair this terminal!")
        if self.debug then
            print("[OilTerminal DEBUG] Use: Tech item missing for " .. Activator:Name())
        end
    end
end

function ENT:OnRemove()
    if self.loopingsound then
        self:StopLoopingSound(self.loopingsound)
        for k, v in pairs(ents.FindInSphere(self:GetPos(), 7000)) do
            local zDifference = math.abs(self:GetPos().z - v:GetPos().z)
            if v:GetClass() == "prop_dynamic" and (zDifference < 600) and (!v.notoilfieldactivated or v.notoilfieldactivated == false) then
                v:SetCycle(0) -- Freezes the animation at the beginning
                v:SetPlaybackRate(0)
            end
        end
        if self.debug then
            print("[OilTerminal DEBUG] OnRemove: Looping sound stopped.")
        end
    end
end
