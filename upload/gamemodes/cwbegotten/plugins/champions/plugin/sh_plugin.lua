--[[ 
    Begotten III: Jesus Wept - Champions Plugin
    By: DETrooper, cash wednesday, gabs, alyousha35, etc.
--]]

PLUGIN:SetGlobalAlias("Champions");

-- Include client and server hook files.
Clockwork.kernel:IncludePrefixed("cl_hooks.lua");
Clockwork.kernel:IncludePrefixed("sv_hooks.lua");

-- Champion variant definitions.
Champions.championVariants = {
    Black = {
        chance = 0.5,
        effect = "explodeOnDeath",
        mat = "models/flesh",
        color = Color(0, 0, 0),
        onSpawn = function(npc)
            if not IsValid(npc) then return end
            local scaleBones = {
                "ValveBiped.Bip01_Spine1",
                "ValveBiped.Bip01_Spine",
            }
            for k, v in ipairs(scaleBones) do
                local boneIndex = npc:LookupBone(v)
                if boneIndex then
                    local currentScale = npc:GetManipulateBoneScale(boneIndex) or Vector(1,1,1)
                    local newScale = currentScale + Vector(2, 2, 1.7)
                    npc:ManipulateBoneScale(boneIndex, newScale)
                    npc:ManipulateBoneJiggle(boneIndex,1)
                end
            end
        end,
        onHit = function(npc, attacker, dmgInfo)
            if not IsValid(npc) or not IsValid(attacker) then return end
            if not dmgInfo then return end
        
            if bit.band(dmgInfo:GetDamageType(), DMG_BULLET) == 0 then return end
            
            dmgInfo:SetDamage(dmgInfo:GetDamage() * 3)
        end,
        champDeath = function(npc)
            if not IsValid(npc) then return end
            local pos = npc:GetPos()
            local explosion = ents.Create("env_explosion");
            local launchRadius = 196
            local forceMagnitude = 1000
            timer.Simple(0.1, function()
                for _, ply in ipairs(ents.FindInSphere(pos, launchRadius)) do
                    if ply:IsPlayer() then
                        Clockwork.player:SetRagdollState(ply, RAGDOLL_FALLENOVER, 3)
                        local ragdoll = ply:GetRagdollEntity()
                        if not IsValid(ragdoll) then 
                            return 
                        end

                        local diff = ragdoll:GetPos() - pos
                        local direction
                        if diff:Length() < 1 then
                            direction = Vector(0, 0, 1)
                        else
                            direction = diff:GetNormalized()
                        end

                        for i = 0, ragdoll:GetPhysicsObjectCount() - 1 do
                            local physObj = ragdoll:GetPhysicsObjectNum(i)
                            if IsValid(physObj) then
                                local appliedForce = direction * forceMagnitude * physObj:GetMass()
                                physObj:ApplyForceCenter(appliedForce)
                            end
                        end
                    end
                end
                explosion:SetPos(pos);
                explosion:SetKeyValue("iMagnitude", "100");
                explosion:Spawn();
                explosion:Activate();
                explosion:Fire("Explode", "", 0);
            end)
        end,
    },
    White = {
        chance = 0.4,
        effect = "fadeInOut",
        color = Color(255, 255, 255),
        onThink = function(npc)
            if not IsValid(npc) then return end
            if npc:GetRenderMode() ~= RENDERMODE_TRANSALPHA then
                npc:SetRenderMode(RENDERMODE_TRANSALPHA)
            end
            local period = 10
            local t = RealTime() % period
            local newAlpha
            if t <= 4 then
                newAlpha = 255 - (t / 4) * 255
            elseif t <= 5 then
                newAlpha = 0
            else
                newAlpha = ((t - 5) / 4) * 255
            end
            newAlpha = math.Round(newAlpha)
            local baseColor = npc:GetColor()
            npc:SetColor(Color(baseColor.r, baseColor.g, baseColor.b, newAlpha))
        end,
    },
    Fire = {
        chance = 0.6,
        effect = "igniteOnAttack",
        color = Color(255, 255, 255),
        mat = "models/wp_sword_of_fire/wp_sword_of_fire_lame",
        onSpawn = function(npc)
            if not IsValid(npc) then return end
        
            local headBone = npc:LookupBone("ValveBiped.Bip01_Head1")
            if headBone then
                ParticleEffectAttach("env_embers_small", PATTACH_POINT_FOLLOW, npc, headBone)
            end

        end,
        onAttack = function(champion, target, dmgInfo)
            if not IsValid(target) or not dmgInfo then return end
            target:Ignite(5, 0)
        end,
    },
    Ice = {
        chance = 0.3,  
        effect = "freezeOnHit",
        mat = "models/elemental/frozen", 
        color = Color(200,220,255), 
        onSpawn = function(npc)
            if not IsValid(npc) then return end

            local freezeBones = {
                "ValveBiped.Bip01_Head1",
                "ValveBiped.Bip01_L_Clavicle",
                "ValveBiped.Bip01_R_Clavicle",
                "ValveBiped.Bip01_L_Foot",
                "ValveBiped.Bip01_R_Foot"
            }
            
            npc.FreezeEffects = {}
            -- didn't really work how I wanted but I like the effect so what the hell
            for _, boneName in ipairs(freezeBones) do
                local boneIndex = npc:LookupBone(boneName)
                if boneIndex then
                    ParticleEffectAttach("ice_freezing", PATTACH_POINT_FOLLOW, npc, boneIndex)
                    table.insert(npc.FreezeEffects, boneIndex)
                end
            end
        end,
        
        onHit = function(npc, attacker, dmgInfo)
            if not IsValid(npc) or not dmgInfo then return end
        
            if npc.FreezeEffects and #npc.FreezeEffects > 0 then
                local randomIndex = math.random(1, #npc.FreezeEffects)
                local boneIndex = table.remove(npc.FreezeEffects, randomIndex)
                local pos = npc:GetBonePosition(boneIndex)
                
                local ed = EffectData()
                ed:SetOrigin(pos)
                ed:SetScale(1)
                ed:SetMagnitude(1)
                util.Effect("GlassImpact", ed, true, true)
                npc:EmitSound("elemental/freeze_shatter.wav")
            end
        end,
        onAttack = function(npc, target, dmgInfo)
            if not IsValid(target) or not dmgInfo then return end
        
            if target:IsPlayer() then
                target:SetNetVar("runningDisabled", true)
                target:AddFreeze(80, npc) 
                timer.Simple(5, function()
                    if IsValid(target) then
                        target:TakeFreeze(100)  
                        target:SetNetVar("runningDisabled", false)
                    end
                end)
            end
        
            dmgInfo:SetDamage(dmgInfo:GetDamage() - 10)
        end,
    },
    Rust = {
        chance = 0.2,
        effect = "reflectBullets",
        mat = "models/props_pipes/GutterMetal01a",
        onHit = function(npc, attacker, dmgInfo)
            if not IsValid(npc) or not IsValid(attacker) then return end
            if not dmgInfo then return end
        
            if bit.band(dmgInfo:GetDamageType(), DMG_BULLET) == 0 then return end
            
            dmgInfo:SetDamage(dmgInfo:GetDamage() * 0.25)

            local storeDamage = dmgInfo:GetDamage()
            local storeAmmoType = dmgInfo:GetAmmoType()

            -- this timer is keeping the codebase together
            timer.Simple(0, function()
                local origin = npc:GetPos()
                local reflectRadius = 300
                local validTargets = {}

                for _, ent in ipairs(ents.FindInSphere(origin, reflectRadius)) do
                    if (ent:IsPlayer() or ent:IsNPC()) and ent ~= attacker and ent ~= npc then
                        table.insert(validTargets, ent)
                    end
                end
                if #validTargets == 0 then return end

                local newTarget = table.Random(validTargets)
                if not IsValid(newTarget) then return end

                local damage = storeDamage
                local ammoType = storeAmmoType
                
                local bullet = {}
                bullet.Num = 1
                bullet.Src = npc:GetPos()
                bullet.Dir = (newTarget:GetPos() - npc:GetPos()):GetNormalized()
                bullet.Spread = Vector(0.01, 0.01, 0)
                bullet.Tracer = 1
                bullet.TracerName = "Tracer"
                bullet.Force = damage * 0.25
                bullet.Damage = damage
                bullet.Attacker = npc
                bullet.Callback = function(attacker, tracedata, dmginfo2)
                    dmginfo2:SetInflictor(npc)
                end
            
                if ammoType == "buckshot" then
                    bullet.AmmoType = "Buckshot"
                else
                    bullet.AmmoType = "SMG1"
                end

                npc:FireBullets(bullet)
            end)
            npc:EmitSound("vj_impact_metal/metalhit"..math.random(1,5)..".wav")
        end,
    }, 
}

-- Conversion functions.
function Champions:MakeChampion(npcEntity)
    local championKey = self:SelectChampionVariant()
    local champData = self.championVariants[championKey]
    if champData then
        npcEntity:SetNWString("championType", championKey)
        if champData.mat then
            npcEntity:SetMaterial(champData.mat)
        end
        if champData.color then
            npcEntity:SetColor(champData.color)
        end
        if champData.onSpawn then
            champData.onSpawn(npcEntity)
        end
    end

    --precautionary function stubbing because this metatable shit is headache inducing
    if not npcEntity.SetLastEnemy then
        function npcEntity:SetLastEnemy(enemy)
            self.LastEnemy = enemy
        end
    end
    if not npcEntity.UpdateEnemyMemory then
        function npcEntity:UpdateEnemyMemory(enemy, memory)
            self.LastEnemyMemory = memory or enemy
        end
    end

    Champions:MergeMetatable(npcEntity)

    -- also precautionary because the onRemove wasn't firing fast enough 
    npcEntity:CallOnRemove("ChampionDeath", function(ent)
        local champType = ent:GetNWString("championType", "")
        if champType ~= "" then
            local champData = Champions.championVariants[champType]
            if champData and champData.champDeath then
                champData.champDeath(ent)
            end
        end
    end)
end
local champChance = 108

function Champions:MakeChampionSpecific(npcEntity, championKey)
    local champData = self.championVariants[championKey]
    if champData then
        npcEntity:SetNWString("championType", championKey)
        if champData.mat then
            npcEntity:SetMaterial(champData.mat)
        end
        if champData.color then
            npcEntity:SetColor(champData.color)
        end
        if champData.onSpawn then
            champData.onSpawn(npcEntity)
        end
    else
        print("[Champions] Invalid championKey: " .. tostring(championKey))
    end

    if not npcEntity.SetLastEnemy then
        function npcEntity:SetLastEnemy(enemy)
            self.LastEnemy = enemy
        end
    end
    if not npcEntity.UpdateEnemyMemory then
        function npcEntity:UpdateEnemyMemory(enemy, memory)
            self.LastEnemyMemory = memory or enemy
        end
    end

    Champions:MergeMetatable(npcEntity)
    
    npcEntity:CallOnRemove("ChampionDeath", function(ent)
        local champType = ent:GetNWString("championType", "")
        if champType ~= "" then
            local champData = Champions.championVariants[champType]
            if champData and champData.champDeath then
                champData.champDeath(ent)
            end
        end
    end)
end

local varSel = 117
function Champions:SelectChampionVariant()
    local totalChance = 0
    for key, variant in pairs(self.championVariants) do
        totalChance = totalChance + variant.chance
    end
    local rand = math.random() * totalChance
    local running = 0
    for key, variant in pairs(self.championVariants) do
        running = running + variant.chance
        if rand <= running then
            return key
        end
    end
    return nil -- Should not happen if chances are set correctly.
end

/*-----------------------------------------------------------------------
   This section is dedicated to the suicidal task of attempting 
   to call empty functions on merged entity metatables.


   - [[STUB]]: Code that is messing with metatables and causes certain
   - methods to return nil. All it's doing is providing a nil return
   - reflecting the function's original parameters to quickly handle
   - the nil function for champion enemies.

   - [[OVERRIDE]]: Champions that directly override a method defined in
   - a champion's code need to have their champion code called first
   - before calling the original method stored in the entity's file.
-----------------------------------------------------------------------*/

-- attempt at thinning redundancy with a call to champ tables + nw check
function Champions:CallChampionFunction(ent, funcName, ...)
    local champType = ent:GetNWString("championType", "")
    local isOilEnemy = ent:GetNWBool("OilTerminalEnemy", false)
    if isOilEnemy and champType ~= "" then
        local champData = self.championVariants[champType]
        if champData and champData[funcName] then
            champData[funcName](ent, ...)
        end
    end
end

local override = 101
local ChampionOverrides = {
    SetLastEnemy = function(self, enemy) --[[STUB]]--
        self.LastEnemy = enemy
    end,

    UpdateEnemyMemory = function(self, enemy, memory) --[[STUB]]--
        self.LastEnemyMemory = memory or enemy
    end,

    OnRemove = function(self) --[[OVERRIDE]]--
        Champions:CallChampionFunction(self, "champDeath")
        if self.__OriginalOnRemove then
            self.__OriginalOnRemove(self)
        end
    end,
}

--turns out there's a really good reason this is hard to do in base gmod
--[[local function dummy(...)
    return nil
end]]--

local thir = 13
function Champions:Simpobf(str)
    local hse = 0
    for i = 1, #str do
        hse = (hse + str:byte(i)) % 1000000000
    end
    return tostring(hse)
end

--packages expected values
function Champions:getExpected()
    local parts = {thinkTime, renderTime, entdmg, champChance, champ, merge}
    return table.concat(parts)
end


function Champions:MergeMetatable(npcEntity)
    local merge = 10
    if not IsValid(npcEntity) then return end

    local originalMeta = debug.getmetatable(npcEntity)
    if not originalMeta then
        print("[Champions] Warning: NPC has no original metatable")
        return
    end

    if npcEntity.__MergedChampionMeta then return end
    npcEntity.__MergedChampionMeta = true

    npcEntity.__OriginalOnRemove = originalMeta.OnRemove or function() end

    local mergedMeta = {}
    mergedMeta.__index = function(t, k)
        -- First, check champion-specific overrides.
        local override = ChampionOverrides[k]
        if override ~= nil then
            return override
        end

        -- Next, check the original metatable's __index.
        local origIndex = originalMeta.__index
        if type(origIndex) == "function" then
            local val = origIndex(t, k)
            if val ~= nil then
                return val
            end
        elseif type(origIndex) == "table" then
            local val = origIndex[k]
            if val ~= nil then
                return val
            end
        end

        -- Also check the original metatable directly (if it's a table).
        if type(originalMeta) == "table" then
            local val = originalMeta[k]
            if val ~= nil then
                return val
            end
        end

        return nil
    end

    mergedMeta.__newindex = function(t, k, v)
        local origNewIndex = originalMeta.__newindex
        if type(origNewIndex) == "function" then
            origNewIndex(t, k, v)
        else
            rawset(t, k, v)
        end
    end

    debug.setmetatable(npcEntity, mergedMeta)
    print("[Champions] Merged metatable applied for NPC:", npcEntity)
end


