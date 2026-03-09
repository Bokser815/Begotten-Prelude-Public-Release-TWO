Clockwork.kernel:IncludePrefixed("shared.lua");

AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");

local models = {
    --[[["food_tato"] = "models/a31/fallout4/props/plants/tatoplant01.mdl",
    ["food_mutfruit"] = "models/a31/fallout4/props/plants/mutfruit_plant.mdl",
    ["food_carrot"] = "models/fallout/consumables/carrot.mdl",
    ["food_kiyya"] = "models/props/de_inferno/potted_plant3_p1.mdl",
    ["food_tarberry"] = "models/fallout/consumables/tarberry.mdl",
    ["jalapeno"] = "models/mosi/fnv/props/plants/jalapeno.mdl",
    ["barrelcactus"] = "models/mosi/fnv/props/plants/barrelcactus.mdl",   
    ["honeymesquite"] = "models/mosi/fnv/props/plants/honeymesquite.mdl",
    ["pricklypear"] = "models/mosi/fnv/props/plants/pricklypearcactus.mdl",
    ["banana"] = "models/mosi/fnv/props/plants/bananayucca.mdl",
    ["xanderroot"] = "models/mosi/fnv/props/plants/xanderroot02.mdl",
    ["whitehorsenettle"] = "models/mosi/fnv/props/plants/whitehorsenettle.mdl",
    ["pintopod"] = "models/mosi/fnv/props/plants/pinto.mdl",
    ["food_melon"] = "models/a31/fallout4/props/plants/melon_item.mdl",]]--
    ["agave"] = "models/mosi/fnv/props/plants/nevadaagave.mdl",
    ["maize"] = "models/mosi/fnv/props/plants/maize.mdl",
    ["fungus"] = "models/mosi/fnv/props/plants/cavefungus.mdl",
    ["wheat"] = "models/mosi/fnv/props/plants/brocflower.mdl",
    ["tobacco"] = "models/mosi/fnv/props/plants/coyotetobacco.mdl",
    ["cotton"] = "models/mosi/fnv/props/plants/whitehorsenettle.mdl",
}

local planterHPs = {100}

local zOff = {
    ["food_tarberry"] = 1,
    ["food_kiyya"] = -7,
    ["buffalogoard"] = 1,
    ["food_pumpkin"] = 3,
    ["food_melon"] = -2
}
local fertilizeMaxMultiplier = 1.30
local fertilizeMaxTime = 300
local fotmMultiplier = 1.1
local parasiteSpreadTime = 300
local parasiteSpreadRange = 200

local seedTypes = { -- todo balance these well later
    ["agave"] = { 
        growthMultiplier = 24, 
        waterConsumptionMultiplier = 0.8,
        perc = {35, 55, 70, 90},
        defYieldRate = 30
    },
    ["maize"] = {
        growthMultiplier = 17, 
        waterConsumptionMultiplier = 0.65,
        perc = {35, 50, 62, 80},
        defYieldRate = 53
    },
    ["wheat"] = {
        growthMultiplier = 8, 
        waterConsumptionMultiplier = 0.5,
        perc = {15, 25, 35, 50, 70, 85},
        defYieldRate = 58
    },
    ["fungus"] = {
        growthMultiplier = 27, 
        waterConsumptionMultiplier = 0.35,
        perc = {25, 40, 70, 85, 90},
        defYieldRate = 50
    },
    ["cotton"] = {
        growthMultiplier = 42, 
        waterConsumptionMultiplier = 0.8,
        perc = {58, 65, 85, 95},
        defYieldRate = 35
    },
    ["tobacco"] = {
        growthMultiplier = 54, 
        waterConsumptionMultiplier = 0.9,
        perc = {60, 70, 90, 95},
        defYieldRate = 30
    },
}

-- ideas/todo
--[[
    * planter limit per person?                                                             
    * take time for planting/harvesting?        
]]--
local function CalculateSunlightPercentage(entity)
    local tr = util.TraceLine({
        start = entity:GetPos(),
        endpos = entity:GetPos() + Vector(0, 0, 15000),
        mask = MASK_SOLID_BRUSHONLY
    })
    if tr.HitSky then
        return true
    else
        return false
    end
end

local function CalculateIdealLight(self)
    local light = CalculateSunlightPercentage(self)
    self:SetNWBool("sunlightPercentage", light)
    for _,v in pairs(self.slots) do
        if v.item == "fungus" then
            if not light then
                v:SetNWBool("idealLight", true)
            else
                v:SetNWBool("idealLight", false)
            end
        else
            if light then
                v:SetNWBool("idealLight", true)
            else
                v:SetNWBool("idealLight", false)
            end
        end
    end
end

function ENT:Initialize()
    self:SetModel("models/fallout/plot/planter.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self.health = planterHPs[1]
    self.maxHealth = planterHPs[1]
    self.infWater = false
    self.infected = false
    self.fertilizeMultiplier = 1.0
    self:SetNWBool("fertilized", false)
    self:SetNWInt("seedAmount", 0)
    local phys = self:GetPhysicsObject()
    if (phys:IsValid()) then
        phys:SetMass(1000) --It's like a feather by default
        phys:Wake()
    end
    self.slots = {}
    table.insert(cwFarming.planters, self);

    -- Check every for if theres sunlight
    CalculateIdealLight(self)
    timer.Create(self:EntIndex() .. "sunlightTimer", 30, 0, function()
        if !IsValid(self) then
            timer.Remove(self:EntIndex() .. "sunlightTimer")
            return
        end
        CalculateIdealLight(self)

        -- check infection here too
        local defChanceParasites = 0.001251251251
        if cwWeather and (cwWeather.weather == "bloodstorm" or cwWeather.weather == "acidrain") then
            defChanceParasites = 0.01666666667
        end

        if math.random() <= defChanceParasites then
            if not self.infected then
                self:Infect()
            end
        end
    end)

    timer.Create(self:EntIndex() .. "farmTimer", 0.1, 0, function() --Handles the lowering of the water and the growing of the plants
        if !IsValid(self) then  timer.Remove(self:EntIndex() .. "farmTimer")  return end
        local water = self:GetNWInt("water", 0)
        local sunlight = self:GetNWBool("sunlightPercentage", false)
        if water <= 0 then return end --We're out of water, don't need to do anything

        for k,v in pairs(self.slots) do
            if IsValid(v) then
                if not self.infWater then
                    water = math.max(water - (0.005 * seedTypes[v.item].waterConsumptionMultiplier), 0)
                end

                local sunlightMulti = v.item == "fungus" and (sunlight and 1.0 or 0.0) or 1.0 
                local growth = math.min(v:GetNWInt("growth") + (((0.05 / seedTypes[v.item].growthMultiplier) * self.fertilizeMultiplier * v.fotmMultiplier)) * sunlightMulti, 100)
                v:SetNWInt("growth", growth)
                v:SetModelScale(0.5 * (1 + (growth/100)), 0.1)
            else
                v:Remove()
                self.slots[k] = nil
            end
        end

        self:SetNWInt("water", water)
    end)
end

function ENT:Infect()
    self.infected = true
    if not timer.Exists("infectTimer") then
        self:SetColor(Color(142,132,44))
        timer.Create(self:EntIndex() .. "infectTimer", parasiteSpreadTime, 0, function()
            if not IsValid(self) then return end
            local nearbyPlanters = {}

            for k, v in pairs (ents.FindInSphere(self:GetPos(), parasiteSpreadRange)) do
                if IsValid(v) and v:GetClass() == "cw_planter" and not v.infected then
                    table.insert(nearbyPlanters, v)
                end
                if #nearbyPlanters >= 2 then
                    break
                end
            end

            for _, planter in ipairs(nearbyPlanters) do
                planter:Infect()
            end
        end)
    end
end

function ENT:RemoveInfection()
    self.infected = false
    self:SetColor(Color(255,255,255))
    if timer.Exists("infectTimer") then
        timer.Remove("infectTimer");
    end
end

function ENT:SetHP(newhp, caller, weapon)
    local lowC = Color(81,91,85)
    local highC = Color(255,255,255)
	self.health = newhp;
    perc = newhp / 250;

    local col = Color(
        lowC.r + (highC.r - lowC.r) * ( perc),
        lowC.g + (highC.g - lowC.g) * ( perc),
        lowC.b + (highC.b - lowC.b) * ( perc)
    )
    self:SetColor(col)

	if newhp <= 0 then
		self:EmitSound("physics/wood/wood_crate_break5.wav");
        if caller:GetClass() == "entityflame" then
            for _, v in ipairs(_player.GetAll()) do
                if v:GetPos():Distance(caller:GetPos() ) <= config.Get("talk_radius"):Get() * 3  then
                    Schema:EasyText(v, "peru", "The planter burns to a crisp.")
                end
            end
        else
            Clockwork.chatBox:AddInTargetRadius(caller, "it", caller:GetName() .. " ravishes the planter with their " .. weapon .. ".", caller:GetPos(), config.Get("talk_radius"):Get() * 3);
        end
        
		self:Remove();
	end
end

function ENT:PlantSeed(seedType, greatTreeMulti, growth)
    growth = growth or 0
    if #self.slots >= 9 then return end --Planter is full
    local crop = ents.Create("cw_plant")
    CalculateIdealLight(self)

    --Plant the seed in the first available slot
    local i
    for j = 1,9 do
        if !self.slots[j] then
            self.slots[j] = crop
            i = j
            break
        end
    end

    local line = math.ceil(i/3)
    local yMod = 20  * (i - (3 * line))
    local xMod = 40 * (line - 2)
    local z = 5

    --Change the Z value depending on what row we're on since the height of the dirt changes
    if line == 1 then
        z = 3
    elseif line == 2 then
        z = 7
    end
    z = z + (zOff[seedType] or 0)

    if greatTreeMulti then
        crop.fotmMultiplier = fotmMultiplier
    else
        crop.fotmMultiplier = 1.0
    end

    self:SetNWInt("seedAmount", self:GetNWInt("seedAmount") + 1);
    crop.item   = seedType
    crop:SetNWInt("growth", growth)
    crop:SetNWInt("plantName", seedType)
    crop:SetModel(models[seedType])
    crop:SetModelScale(0.5)
    crop:SetPos(Vector(xMod, yMod + 20, z))
    crop:SetMoveParent(self)
end

function ENT:IsFull()
    if #self.slots >= 9 then
        return true
    end
    return false
end

function ENT:WillMakeFull(reqAmt)
    if self:GetNWInt("seedAmount") + reqAmt > 9 then
        return true
    end
    return false
end

function ENT:GetSeedAmount()
    return #self.slots
end

function ENT:Fertilized()
    if self.fertilizeMultiplier == fertilizeMaxMultiplier then
        return true
    end
    return false
end

function ENT:Fertilize()    
    if self:Fertilized() then -- if already fertilized, do nothing.. or maybe refresh it / add up to a max value. idk
        return
    end
    self.fertilizeMultiplier = fertilizeMaxMultiplier
    self:SetNWBool("fertilized", true)
    
    timer.Create("FarmFertilizerTimer", fertilizeMaxTime, 1, function()
        if IsValid(self) then
            self.fertilizeMultiplier = 1.0
            self:SetNWBool("fertilized", false)
        end
    end)
end

function ENT:Water()
    self:SetNWInt("water", math.min(self:GetNWInt("water", 0) + waterReplenish, maxWater))
end

function ENT:WaterFull()
    self:SetNWInt("water", maxWater)
end

function ENT:QuickGrow()
    for k,v in pairs(self.slots) do
        v:SetNWInt("growth", 100)
        v:SetModelScale(1, 0.1)
    end
end

local function randomSeed()
    local keys = {}
    for key in pairs(seedTypes) do
        table.insert(keys, key)
    end
    return keys[math.random(#keys)]
end

function ENT:ToggleInfWater()
    self.infWater = not self.infWater
 end

function ENT:RandomPlant()
    for i = 1, 9 do
        self:PlantSeed(randomSeed(), false)
    end
end

function ENT:Reset()
    for k,v in pairs(self.slots) do
        v:Remove()
    end
    self:SetNWInt("seedAmount", 0)
    self.slots = {}

    self:SetNWBool("fertilized", false)
    self.fertilizeMultiplier = 1.0
    if timer.Exists("FarmFertilizerTimer") then
        timer.Remove("FarmFertilizerTimer");
    end
end

function ENT:RandomAll()
    self:Reset()

    for i = 1, 9 do
        self:PlantSeed(randomSeed(), false, math.random(0, 100))
    end
    self:SetNWInt("water", math.random(0, maxWater))
    if math.random(0,1) == 0 then
        self:Fertilize();
    end
    if math.random(0,1) == 0 then
        self:Infect();
    end
end

function ENT:IsWatered()
    if self:GetNWInt("water", 0) ~= maxWater then 
        return false
    end
    return true
end

--[[function ENT:StartTouch(ent)
    local class = ent:GetClass()

    if class == "farm_seed" then --Plant the seed
        if #self.slots >= 9 then return end --Planter is full
        self:PlantSeed(ent.type)
        ent:Remove()
    elseif class == "farm_water" then --Water the planter
        local water = self:GetNWInt("water", 0)
        if water == maxWater then return end --It's already fully watered, do nothing

        self:SetNWInt("water", math.min(water + waterReplenish, maxWater))
        ent:Remove()
    end
end]]--

function ENT:Harvest(caller)
    if #self.slots == 0 then
        Schema:EasyText(caller, "firebrick", "There are no crops planted here yet, plant some seeds first.");
        return
    end

    local harvested = 0;
    local collected = 0;
    local fail = 0;
    if not self.infected then
        for k,v in pairs(self.slots) do
            if v:GetNWInt("growth", 0) >= 100 then
                -- Yield check
                local yield = math.random(0,seedTypes[v.item].defYieldRate) -- default 65 for ppl, 5-10 per belief.. maybe charms/farmingtools equipped for bonuses
                local seedChance = 0

                -- Add up yield bonuses
                -- Beliefs
                if cwBeliefs and caller.HasBelief then 
                    if caller:HasBelief("cookist") then
                        yield = yield + 5
                    end

                    if caller:HasBelief("culinarian") then
                        yield = yield + 10
                    end

                    if caller:HasBelief("gift_great_tree") then
                        yield = yield + 10
                        seedChance = seedChance + 5
                    end
                end

                -- Charms
                if caller:GetCharmEquipped("rose_gloves") then
                    yield = yield + 12
                end

                -- Weapons/tools
                local equippedWeapons = caller:GetWeaponsEquipped();
                for _,v in pairs(equippedWeapons) do
                    if v.weaponClass == "begotten_scythe_warscythe" then
                        yield = yield + 10
                    end

                    if v.weaponClass == "begotten_spear_pitchfork" then
                        yield = yield + 5
                    end
                end

                local idx;
                for i,p in pairs(seedTypes[v.item].perc) do  
                    idx = i
                    if yield < p then
                        break
                    end
                end

                -- Spawn antlion underground if marked sometimes
                if 1==1 or caller:HasTrait("marked") and not caller:IsNoClipping() then
                    if 1==1 or math.random(1, 20) == 1 then
                        local thrall = ents.Create("npc_antlion");
                        thrall:SetKeyValue("StartBurrowed", "1")
                        local destination = self:GetPos()
                
                        timer.Simple(0.25, function()
                            if IsValid(thrall) then
                                if thrall.CustomInitialize then
                                    thrall:CustomInitialize();
                                end
                                
                                thrall:SetPos(destination + Vector(0, 0, 16));
                                thrall:Spawn();
                                thrall:Activate();
                                thrall:Fire("Unburrow")
                            end
                        end);

                        if IsValid(thrall) then
                            --caller:SetCollisionGroup(COLLISION_GROUP_WEAPON);
                            Clockwork.chatBox:AddInRadius(nil, "itnofake", "A giant bug suddenly unburrows from the fucking soil!", self:GetPos(), config.Get("talk_radius"):Get() * 2);
                        
                            local entitiesInSphere = ents.FindInSphere(self:GetPos(), 512);
                            
                            for k, v in pairs (entitiesInSphere) do	
                                if (IsValid(v) and v:IsPlayer()) then
                                    if v:HasInitialized() and v:Alive() then
                                        if Clockwork.player:CanSeeEntity(v, self) then
                                            Clockwork.datastream:Start(v, "PlaySound", "begotten/score5.mp3");
                                        end
                                    end
                                end
                            end
                        
                            self:EmitSound("npc/antlion/digup1.wav", 70);
                            self:RemoveSeeds()
                            
                            table.insert(Schema.spawnedNPCS, thrall:EntIndex());
                            return false;
                        end
                    end
                end

                if idx == 1 then
                    Schema:EasyText(caller, "firebrick", "You are unable to yield anything from a " .. v.item);
                    fail = fail + 1
                else
                    local itemClass = v.item

                    for q = 1, idx-1 do
                        caller:GiveItem(Clockwork.item:CreateInstance(itemClass), true);
                    end
                    if math.random(1, 100) < seedChance then -- Rare chance for a seed to drop
                        caller:GiveItem(Clockwork.item:CreateInstance("seed_" .. itemClass), true);
                    end

                    harvested = harvested + 1
                    collected = collected + idx-1
                    
                    caller:HandleXP(cwBeliefs.xpValues["farm"] or 1)
                end
                v:EmitSound("physics/flesh/flesh_squishy_impact_hard1.wav")
                v:Remove()
                self:SetNWInt("seedAmount", self:GetNWInt("seedAmount") - 1)
                self.slots[k] = nil
            end
            
        end
        if harvested > 0 or fail > 0 then
            Schema:EasyText(caller, "green", "You harvested " .. harvested .. " crops (" .. collected .. ") and had " .. fail .. " failures.");
        else
            Schema:EasyText(caller, "firebrick", "The crops aren't ready for harvest yet.");
        end
    else
        self:RemoveSeeds()
        Schema:EasyText(caller, "firebrick", "As you harvest your crops be realize they are infested with parasites!");
    end
end

function ENT:ViewInfo(caller)
    local c = 0
    for q,y in pairs(self.slots) do
        if y then
            c = c + 1
        end
    end

    text = "";
    local fert = self:GetNWBool("fertilized") and "Fertilized" or "Unfertilized"
    local infect = self.infected and ", Infected" or ""
    local health = "Good"
    if (self.health / self.maxHealth) < .20 then
        health = "Awful"
    elseif (self.health / self.maxHealth) < .40 then
        health = "Bad"
    elseif (self.health / self.maxHealth) < .60 then
        health = "Raggy"
    elseif (self.health / self.maxHealth) < .80 then
        health = "Ok"
    end

    Schema:EasyText(caller, "green", math.floor(self:GetNWInt("water", 0)) .. " H2O, " .. c .. " / 9, " .. fert .. infect .. ", " .. health .. " condition");
    for k=1, #self.slots+1 do
        v = self.slots[k]
        if v ~= nil then
            local sunlight
            if self.slots[k].item == "fungus" then
                sunlight = self:GetNWBool("sunlightPercentage", false) and "Bad Light" or "Ideal Light"
            else
                sunlight = self:GetNWBool("sunlightPercentage", false) and "Ideal Light" or "Bad Light"
            end
            text = text .. k .. ". " .. v.item .. ", " .. sunlight .. ", " .. math.floor(v:GetNWInt("growth", 0)) .. "% |\t"
        else
            text = text .. k .. ". Empty, 0% |\t"
        end

        if k % 3 == 0 then
            Schema:EasyText(caller, "green", text)
            text = ""
        end
    end
end

function ENT:RemoveSeeds(caller)
    for k,v in pairs(self.slots) do
        v:EmitSound("physics/flesh/flesh_squishy_impact_hard1.wav") --Remove the crop from the planter and give the caller the yield
        v:Remove()
        self:SetNWInt("seedAmount", self:GetNWInt("seedAmount") - 1)
        self.slots[k] = nil
    end

    if self.infected then
        self:RemoveInfection()
        Schema:EasyText(caller, "firebrick", "You have destroyed all the crops, removing any parasites in the soil as well.");
    else
        Schema:EasyText(caller, "firebrick", "You have destroyed all the crops.");
    end
end

function ENT:RemoveSeed(caller, seedType, amount)
    for k,v in pairs(self.slots) do
        if self.slots[k].item == seedType then
            amount = amount - 1
            v:EmitSound("physics/flesh/flesh_squishy_impact_hard1.wav") --Remove the crop from the planter and give the caller the yield
            v:Remove()
            self:SetNWInt("seedAmount", self:GetNWInt("seedAmount") - 1)
            self.slots[k] = nil

            if amount == 0 then break end
        end
    end

    Schema:EasyText(caller, "firebrick", "You have destroyed the crop.");
end

function ENT:Use(activator, caller)
    if IsValid(caller) and caller:IsPlayer() then
        local serializableSlots = {}
        for k, ent in pairs(self.slots) do
            if IsValid(ent) then
                table.insert(serializableSlots, ent.item)
            end
        end
        Clockwork.datastream:Start(caller, "OpenPlanterMenu", {self, util.TableToJSON(serializableSlots)});
    end
end


function ENT:OnRemove() --Timer cleanup
    --table.remove(cwFarming.planters, self);
    for i, v in ipairs(cwFarming.planters) do
        if v == self then
            table.remove(cwFarming.planters, i)
            break
        end
    end
    if timer.Exists(self:EntIndex() .. "farmTimer") then timer.Remove(self:EntIndex() .. "farmTimer") end
end