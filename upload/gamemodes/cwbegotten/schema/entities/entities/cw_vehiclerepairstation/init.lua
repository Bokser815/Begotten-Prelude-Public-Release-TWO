-- File: lua/entities/cw_vehiclerepairstation/init.lua

AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

---------------------------
-- Global Vehicles Table --
---------------------------
if not CW_RepairStationVehicles then
    CW_RepairStationVehicles = {}
end

hook.Add("OnEntityCreated", "cw_vehicleRepairStation_OnEntityCreated", function(ent)
    timer.Simple(0, function()
        if IsValid(ent) then
            local tab = ent:GetTable()
            if tab and tab.Base == "lvs_base_wheeldrive" then
                print("[RepairStation] OnEntityCreated: Adding vehicle " .. tostring(ent))
                table.insert(CW_RepairStationVehicles, ent)
            end
        end
    end)
end)

hook.Add("EntityRemoved", "cw_vehicleRepairStation_EntityRemoved", function(ent)
    for k, v in pairs(CW_RepairStationVehicles) do
        if v == ent then
            print("[RepairStation] EntityRemoved: Removing vehicle " .. tostring(ent))
            table.remove(CW_RepairStationVehicles, k)
            break
        end
    end
end)

---------------------
-- Entity Behavior --
---------------------
function ENT:Initialize()
    print("[RepairStation] Initializing entity " .. tostring(self))
    self:SetModel("models/props_c17/substation_transformer01b.mdl") -- Station model (placeholder) 
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    
    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:Wake()
        print("[RepairStation] Physics object woken up.")
    else
        print("[RepairStation] No valid physics object found!")
    end

    self.FuelAmount = 1000
    
    self.LoadedVehicle = nil
    self:SetNWBool("Loaded", false)
    self:SetNWString("LoadedModel", "models/props_c17/substation_transformer01b.mdl")
    self:SetNWEntity("LoadedVehicle", nil)
    self.vicUpgrades = {}
end

function ENT:AcceptInput(inputName, activator, caller, data)
    if inputName == "Use" and IsValid(caller) and caller:IsPlayer() then
        self.UsageCooldown = self.UsageCooldown or {}
        local nextAllowed = self.UsageCooldown[caller] or 0
        if CurTime() < nextAllowed then return end
        self.UsageCooldown[caller] = CurTime() + 1

        print("[RepairStation] Entity used by " .. tostring(caller))
        self:OpenMaintenanceUI(caller)
    end
end

function ENT:BuildDeedInfo(vehicle, ply)
    local deedInfo = {}
    if not IsValid(vehicle) then
        deedInfo.name = "Unowned"
        deedInfo.owner = "Unowned"
        deedInfo.fuel = 0
        deedInfo.condition = 0
        deedInfo.code = "N/A"
        return deedInfo
    end

     -- Retrieve deed items using the player's inventory helper.
    local deeds = ply:GetItemsByID("vehicle_deed")
    print("[RepairStation] BuildDeedInfo: Found deed items: " .. util.TableToJSON(deeds or {}))
    
    local matchingDeed = nil
    for key, item in pairs(deeds or {}) do
        local vc = item:GetData("VehicleCode")
        print(string.format("[RepairStation] BuildDeedInfo: Item key %s VehicleCode: %s", tostring(key), tostring(vc)))
        if vc == vehicle.vehiclecode then
            matchingDeed = item
            print("[RepairStation] BuildDeedInfo: Found matching deed with key " .. tostring(key))
            break
        end
    end

    if matchingDeed then
        deedInfo.name = matchingDeed:GetData("vehicleassigned", vehicle:GetClass())
        deedInfo.owner = matchingDeed:GetData("customName", "Unnamed Vehicle")
        deedInfo.fuel = matchingDeed:GetData("vehiclefuel", vehicle:GetFuel() or 0)
        deedInfo.condition = matchingDeed:GetData("vehiclecondition", vehicle:GetHP() or 0)
        deedInfo.code = matchingDeed:GetData("VehicleCode", "N/A")
        print("[RepairStation] BuildDeedInfo: Found matching deed: " .. util.TableToJSON(deedInfo))
    else
        deedInfo.name = vehicle:GetClass();
        deedInfo.owner = "Unowned"
        deedInfo.fuel = vehicle:GetFuel() or 0
        deedInfo.condition = vehicle:GetHP() or 0
        deedInfo.code = "N/A"
        print("[RepairStation] BuildDeedInfo: No matching deed found. Using defaults.")
    end

    return deedInfo
end

function ENT:OpenMaintenanceUI(ply)
    print("[RepairStation] Opening maintenance UI for " .. tostring(ply))
    local deedInfo = {}
    if IsValid(self.LoadedVehicle) then
        deedInfo = self:BuildDeedInfo(self.LoadedVehicle, ply)
    end

    net.Start("LVS_Maintenance_OpenUI")
        print("EVIL NONT ERROR")
        net.WriteEntity(self)
        net.WriteBool(self:GetNWBool("Loaded", false))
        net.WriteTable(self.vicUpgrades or {})
        net.WriteTable(deedInfo)  
    net.Send(ply)
end

local function isValidVehicle(vehicle)
    if not IsValid(vehicle) then return false end
    local tab = vehicle:GetTable()
    local valid = tab and tab.Base == "lvs_base_wheeldrive"
    if valid then
        print("[RepairStation] isValidVehicle: " .. tostring(vehicle) .. " is valid.")
    end
    return valid
end

local function findLVSVehicles()
    local vehiclesSet = {}
    local unionVehicles = {}

    local lvsVehicles = LVS:GetVehicles() or {}
    for _, veh in ipairs(lvsVehicles) do
        if isValidVehicle(veh) then
            vehiclesSet[veh] = true
        end
    end

    for _, veh in ipairs(CW_RepairStationVehicles or {}) do
        if isValidVehicle(veh) then
            vehiclesSet[veh] = true
        end
    end

    for veh, _ in pairs(vehiclesSet) do
        table.insert(unionVehicles, veh)
    end

    print("[RepairStation] findLVSVehicles (hybrid): Found " .. #unionVehicles .. " vehicles.")
    return unionVehicles
end

function ENT:LoadVehicle()
    print("[RepairStation] LoadVehicle called")
    local vehicles = findLVSVehicles()
    
    local nearestVehicle = nil
    local minDistance = math.huge
    local pos = self:GetPos()

    for _, veh in ipairs(vehicles) do
        local distance = veh:GetPos():Distance(pos)
        print("[RepairStation] Vehicle " .. tostring(veh) .. " is " .. distance .. " units away.")
        if distance < minDistance then
            minDistance = distance
            nearestVehicle = veh
        end
    end

    if not IsValid(nearestVehicle) then 
        print("[RepairStation] LoadVehicle: No valid vehicle found.")
        return 
    end

    print("[RepairStation] Nearest vehicle: " .. tostring(nearestVehicle) .. " at distance " .. minDistance)
    
    if not nearestVehicle.OriginalPos then
        nearestVehicle.OriginalPos = nearestVehicle:GetPos()
        nearestVehicle.OriginalAng = nearestVehicle:GetAngles()
        print("[RepairStation] Storing original position: " .. tostring(nearestVehicle.OriginalPos))
    end
    
    local phys = nearestVehicle:GetPhysicsObject()
    if IsValid(phys) then
        phys:EnableMotion(false)
        print("[RepairStation] Vehicle physics frozen.")
    else
        print("[RepairStation] Vehicle physics object not valid.")
    end

    local offset = self:GetForward() * 150
    local targetPos = pos + offset
    nearestVehicle:SetPos(targetPos)
    nearestVehicle:SetAngles(self:GetAngles())
    print("[RepairStation] Vehicle moved to: " .. tostring(targetPos))

    self.LoadedVehicle = nearestVehicle
    self:SetNWBool("Loaded", true)
    self:SetNWString("LoadedModel", nearestVehicle:GetModel() or "models/props_c17/substation_transformer01b.mdl")
    self:SetNWEntity("LoadedVehicle", nearestVehicle) 
end

function ENT:UnloadVehicle()
    print("[RepairStation] UnloadVehicle called")
    if not IsValid(self.LoadedVehicle) then
        print("[RepairStation] No vehicle is currently loaded.")
        return
    end

    local veh = self.LoadedVehicle

    if veh.OriginalPos and veh.OriginalAng then
        veh:SetPos(veh.OriginalPos)
        veh:SetAngles(veh.OriginalAng)
        print("[RepairStation] Vehicle restored to original position: " .. tostring(veh.OriginalPos))
        veh.OriginalPos = nil
        veh.OriginalAng = nil
    else
        print("[RepairStation] No original position stored for the vehicle.")
    end

    local phys = veh:GetPhysicsObject()
    if IsValid(phys) then
        phys:EnableMotion(true)
        print("[RepairStation] Vehicle physics unfrozen.")
    else
        print("[RepairStation] Vehicle physics object not valid during unload.")
    end

    self.LoadedVehicle = nil
    self:SetNWBool("Loaded", false)
    self:SetNWString("LoadedModel", "models/props_c17/substation_transformer01b.mdl")
    self:SetNWEntity("LoadedVehicle", nil) 
end

function ENT:StartRefuelProcess(vehicle)
    if not IsValid(vehicle) then return end

    local refuelTimerName = "RefuelProcess_" .. vehicle:EntIndex()

    local pos1 = self:OBBCenter()
    local pos2 = vehicle:OBBCenter()  
    local worldPos1 = self:LocalToWorld(pos1)
    local worldPos2 = vehicle:LocalToWorld(pos2)
    local distance = worldPos1:Distance(worldPos2)
    local rope = constraint.Rope(
        self,                           
        vehicle,                   
        0,                          
        0,                          
        pos1,                       
        pos2,                       
        distance,                   
        100,                       
        0,                          
        2,                          
        "cable/cable2",             
        false,                      
        color_white                
    );
    self.RefuelRope = rope

    -- sounds need to be audacity'd to 44.1 kHz to work

    --self:EmitSound("vehicle_fuel_car_from_gaspump_start_0"..math.random(1,3)..".wav", 75, 100)

    --self.RefuelSound = CreateSound(self, "vehicle_fuel_car_from_gaspump_loop_0"..math.random(1,3)..".wav")
    --self.RefuelSound:PlayEx(1, 100)

    timer.Create(refuelTimerName, 0.5, 0, function()
        if not IsValid(vehicle) then 
            timer.Remove(refuelTimerName)
            return 
        end

        local currentFuel = vehicle:GetFuel()
        local maxFuel = vehicle.MaxFuel or 100

        if currentFuel < maxFuel then
            local newFuel = math.min(currentFuel + (maxFuel * 0.025), maxFuel)
            vehicle:SetFuel(newFuel)
            print("[RepairStation] Refuel: Vehicle fuel increased to " .. math.Round((newFuel / maxFuel) * 100) .. "%")
        else
            timer.Remove(refuelTimerName)
            if IsValid(self.RefuelRope) then
                self.RefuelRope:Remove()
                self.RefuelRope = nil
            end
            if self.RefuelSound then
                self.RefuelSound:Stop()
                self.RefuelSound = nil
            end
            print("[RepairStation] Refuel: Vehicle fully refueled. Stopping refuel process.")
        end
    end)
end


function ENT:FuelVehicle(vehicle)
    if not isValidVehicle(vehicle) then return end
    self:StartRefuelProcess(vehicle)
end

function ENT:GiveAllUpgrades(ply)
    local player = Clockwork.entity:GetPlayer(ply)
    local inventory = player:GetInventory()
    PrintTable(inventory)

    for _, itemInstances in pairs(inventory) do
        for key, itemVar in pairs(itemInstances) do
            print(tostring(itemVar))
            if itemVar and itemVar.isVehicleUpgrade then
                if #self.vicUpgrades >= 22 then
                    print("[RepairStation] Station is full, cannot accept more upgrades!")
                    break
                end

                local upgradeData = {
                    itemID = tostring(itemVar),       
                    upgradeID = itemVar.upgradeID,      
                    uniqueID = itemVar.uniqueID,       
                    name = itemVar.name or "Unknown Upgrade",
                    icon = itemVar.iconoverride or "materials/icons/default.png",
                    applicableComponents = itemVar.applicableComponents or { "Engine", "Fuel Tank" }
                }
                
                table.insert(self.vicUpgrades, upgradeData)
                print("[RepairStation] Accepted upgrade item: " .. (upgradeData.name or "???"))
                
                player:TakeItem(itemVar, true)
            end
        end
    end
end

function ENT:UpgradeVehicle(vehicle, upgradeID, component, applier)
    if not isValidVehicle(vehicle) then return end
    local upgrade = cwVehicleUpgrades:GetUpgrade(upgradeID)
    if upgrade and upgrade.apply then
        if component == "Engine" then
            vehicle:AddUpgrade(upgradeID, applier)
        end
    else
        print("[RepairStation] UpgradeVehicle: Upgrade '" .. upgradeID .. "' not found or has no apply function.")
    end
end


function ENT:StartRepairProcess(vehicle)
    if not IsValid(vehicle) then return end

    local repairTimerName = "RepairProcess_" .. vehicle:EntIndex()
    timer.Create(repairTimerName, 0.8, 0, function()
        if not IsValid(vehicle) then 
            timer.Remove(repairTimerName)
            return 
        end

        local allRepaired = true

        if vehicle:GetHP() <= 0 then
            vehicle.Destroyed = false
            vehicle:SetHP(7)
            print("[RepairStation] Reviving vehicle with 7 HP.")
            allRepaired = false
        end

        local currentHP = vehicle:GetHP() or 0
        local maxHP = vehicle:GetMaxHP() or 100
        if currentHP < maxHP then
            vehicle.Destroyed = false
            vehicle:SetHP(math.min(currentHP + 7, maxHP))
            allRepaired = false
            print("[RepairStation] Vehicle repair: Vehicle HP increased to " .. vehicle:GetHP())
        end

        if vehicle.Damage then
            for part, damage in pairs(vehicle.Damage) do
                if damage > 0 then
                    local newDamage = math.max(0, damage - 7)
                    vehicle.Damage[part] = newDamage
                    allRepaired = false
                    print(string.format("[RepairStation] Vehicle repair: Repaired part '%s' damage: %d -> %d", tostring(part), damage, newDamage))
                end
            end
        end

        for _, child in ipairs(vehicle:GetChildren() or {}) do
            if child.GetHP and child.GetMaxHP then
                local childHP = child:GetHP() or 0
                local childMax = child:GetMaxHP() or 100
                if childHP < childMax then
                    child.Destroyed = false
                    child:SetHP(math.min(childHP + 7, childMax))
                    allRepaired = false
                    print("[RepairStation] Vehicle repair: Repaired " .. child:GetClass() .. " to " .. child:GetHP() .. "/" .. childMax)
                end
            end
        end

        if allRepaired then
            print("[RepairStation] Vehicle fully repaired. Stopping repair timer.")
            timer.Remove(repairTimerName)
        end
    end)
end

function ENT:StartRepairEffects(vehicle)
    if not IsValid(vehicle) then return end

    local effectDuration = math.Rand(2, 4)
    local effectTimerName = "RepairEffects_" .. vehicle:EntIndex()
    local startTime = CurTime()

    timer.Create(effectTimerName, 0.15, 0, function()
        if not IsValid(vehicle) then 
            timer.Remove(effectTimerName)
            return 
        end

        if CurTime() - startTime > effectDuration then
            timer.Remove(effectTimerName)
            return
        end

        local mins, maxs = vehicle:OBBMins(), vehicle:OBBMaxs()
        local randomLocal = Vector(
            math.Rand(mins.x, maxs.x),
            math.Rand(mins.y, maxs.y),
            math.Rand(mins.z, maxs.z)
        )
        local randomPos = vehicle:LocalToWorld(randomLocal)
        
        local effectdata = EffectData()
        effectdata:SetOrigin(randomPos)
        util.Effect("stunstickimpact", effectdata, true, true)
    end)

    vehicle:EmitSound("lvs/weldingtorch_loop.wav", 75, 70)
    
    timer.Simple(effectDuration, function()
        if IsValid(vehicle) then
            vehicle:StopSound("lvs/weldingtorch_loop.wav")
        end
    end)
end


function ENT:RepairVehicle(vehicle, ply)
    if not isValidVehicle(vehicle) then return end
    print("[RepairStation] Starting gradual repair process for vehicle " .. tostring(vehicle))
    vehicle.Destroyed = false

    self:StartRepairProcess(vehicle)
    self:StartRepairEffects(vehicle)
end


----------------------
-- Net Message Setup --
----------------------
util.AddNetworkString("LVS_Maintenance_OpenUI")
util.AddNetworkString("LVS_Maintenance_PerformAction")
util.AddNetworkString("LVS_Maintenance_UpdateUpgrades")

net.Receive("LVS_Maintenance_PerformAction", function(len, ply)
    local ent = net.ReadEntity()
    local action = net.ReadString()
    print("[RepairStation] Net message received from " .. tostring(ply) .. ". Action: " .. action)
    
    if not IsValid(ent) then
        print("[RepairStation] Net handler: The entity is not valid!")
        return
    end

    print("[RepairStation] Net handler: Entity class is " .. ent:GetClass())
    
    if ent:GetClass() ~= "cw_vehiclerepairstation" then
        print("[RepairStation] Net handler: Entity class mismatch. Expected 'cw_vehiclerepairstation'.")
        return
    end

    if action == "load" then
        if IsValid(ent.LoadedVehicle) then
            print("[RepairStation] Net handler: A vehicle is already loaded.")
        else
            ent:LoadVehicle()
        end
        return
    elseif action == "unload" then
        ent:UnloadVehicle()
        return
    end

    local vehicles = findLVSVehicles()
    local nearestVehicle = nil
    local minDistance = math.huge
    local pos = ent:GetPos()
    for _, veh in ipairs(vehicles) do
        local distance = veh:GetPos():Distance(pos)
        if distance < minDistance then
            minDistance = distance
            nearestVehicle = veh
        end
    end
    if not IsValid(nearestVehicle) and action ~= "giveAllUpgrades" then 
        print("[RepairStation] Net handler: No valid vehicle found for action '" .. action .. "'.")
        return
    end

    if action == "fuel" then
        ent:FuelVehicle(nearestVehicle)
    elseif action == "applyUpgrade" then
        if !IsValid(ent.LoadedVehicle) then
            print("[RepairStation] Vehicle Upgrades: No vehicle is loaded.")
        else
            local upgradeID = net.ReadString()
            local compname = net.ReadString()
            local itemid = net.ReadString()
            for i, up in ipairs(ent.vicUpgrades or {}) do
                if up.itemID == itemid then
                    table.remove(ent.vicUpgrades, i)
                    removed = true
                    print("[RepairStation] Removed applied upgrade from station: " .. upgradeID)
                    break
                end
            end

            ent:UpgradeVehicle(ent.LoadedVehicle, upgradeID, compname, ply)
        end
    elseif action == "removeUpgrade" then
        local itemid = net.ReadString()
        local uniqueID = net.ReadString()

        local player = Clockwork.entity:GetPlayer(ply)
        local removedItem = Clockwork.item:CreateInstance(uniqueID)
        for i, up in ipairs(ent.vicUpgrades or {}) do
            if up.itemID == itemid then
                table.remove(ent.vicUpgrades, i)
                removed = true
                print("[RepairStation] Removed upgrade item with ID: " .. uniqueID)
                break
            end
        end
        player:GiveItem(removedItem, true)
    elseif action == "stripUpgrade" then
        local BupgradeID = net.ReadString()
        print(BupgradeID)
        ent.LoadedVehicle:RemoveUpgrade(BupgradeID)
        if #ent.vicUpgrades < 22 then
            local upData = cwVehicleUpgrades:GetUpgrade(BupgradeID)
            if upData then
                local BitemTable = Clockwork.item:FindByID(upData.itemUniqueID)
                local upgradeData = {
                    itemID = tostring(BitemTable),  
                    upgradeID = BitemTable.upgradeID,      
                    uniqueID = BitemTable.uniqueID,       
                    name = BitemTable.name or "Unknown Upgrade",
                    icon = BitemTable.iconoverride or "materials/icons/default.png",
                    applicableComponents = BitemTable.applicableComponents or { "Engine", "Fuel Tank" }
                }
                table.insert(ent.vicUpgrades, upgradeData)
            end
        end
    elseif action == "stripAllUpgrades" then
        local applied = ent.LoadedVehicle:GetUpgrades() or {}
        for _, upID in ipairs(applied) do
            ent.LoadedVehicle:RemoveUpgrade(upID)
            if #ent.vicUpgrades < 22 then
                local upData = cwVehicleUpgrades:GetUpgrade(upID)
                if upData then
                    local BitemTable = Clockwork.item:FindByID(upData.itemUniqueID)
                    local upgradeData = {
                        itemID = tostring(BitemTable),       
                        upgradeID = BitemTable.upgradeID,      
                        uniqueID = BitemTable.uniqueID,       
                        name = BitemTable.name or "Unknown Upgrade",
                        icon = BitemTable.iconoverride or "materials/icons/default.png",
                        applicableComponents = BitemTable.applicableComponents or { "Engine", "Fuel Tank" }
                    }
                    table.insert(ent.vicUpgrades, upgradeData)
                end
            end
        end
    elseif action == "repair" then
        ent:RepairVehicle(nearestVehicle)
    elseif action == "giveAllUpgrades" then
        ent:GiveAllUpgrades(ply)    
        return
    end
end)
