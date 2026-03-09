util.AddNetworkString("TimedCarbomb_RequestTime")
util.AddNetworkString("TimedCarbomb_SetTime")

--[[ Register a new upgrade.
    upgradeID (string): A unique identifier for the upgrade.
    data (table): Data table with fields:
    name         - Display name.
    description  - A short description.
    allowedComponents - Does nothing because I'm a faggot
    uniqueItemID - [IMPORTANT] Used to reference back to the Clockwork item. Use the upgrade item's uniqueID
    apply        - Function(vehicle, applier) to apply the upgrade
    remove       - Function(vehicle, applier) to remove the upgrade.
--]]

--[[cwVehicleUpgrades:RegisterUpgrade("hyperborean_booster", {
    name = "Hyperborean Booster",
    description = "Increases engine performance by boosting torque.",
    allowedComponents = {"Engine"},
    apply = function(vehicle)
        if vehicle and vehicle:GetEngine() then
            vehicle:GetEngine():ApplyUpgrade("turbo_booster")
            vehicle.EngineTorque = (vehicle.EngineTorque or 0) + 100000000000000000000000
            print("[VehicleUpgrades] Applied Turbo Booster to vehicle " .. tostring(vehicle))
        end
    end,
    remove = function(vehicle)
        if vehicle and vehicle:GetEngine() then
            vehicle:GetEngine():RemoveUpgrade("turbo_booster")
            vehicle.EngineTorque = (vehicle.EngineTorque or 0) - 100000000000000000000000   
            print("[VehicleUpgrades] Removed Turbo Booster from vehicle " .. tostring(vehicle))
        end
    end,
})]]--


cwVehicleUpgrades:RegisterUpgrade("upgrade_carbomb_simple", {
    name = "Simple Car Bomb",
    description = "A simple explosive designed to explode as soon as the car is started.",
    allowedComponents = {"Engine"},
    itemUniqueID = "carbomb_basic",
    apply = function(vehicle, applier)
        if vehicle and vehicle.StartEngine then
            local originalStartEngine = vehicle.StartEngine
            
            vehicle.StartEngine = function(self, ...)
                originalStartEngine(self, ...)
                if self:GetEngineActive() then
                    local pos = self:GetPos() or self:GetPos()
                    util.BlastDamage(self, self, pos, 300, 100)
                    
                    local effectData = EffectData()
                    effectData:SetOrigin(pos)
                    util.Effect("Explosion", effectData)

                    self:SetDestroyed(true)
                    
                    print("[VehicleUpgrades] Carbomb explosion triggered on vehicle " .. tostring(self))
                end
            end
            
            vehicle._CarbombOriginalStartEngine = originalStartEngine
            
            print("[VehicleUpgrades] Carbomb upgrade applied to vehicle " .. tostring(vehicle))
        end
    end,
    remove = function(vehicle)
        if vehicle and vehicle._CarbombOriginalStartEngine then
            vehicle.StartEngine = vehicle._CarbombOriginalStartEngine
            vehicle._CarbombOriginalStartEngine = nil
            print("[VehicleUpgrades] Carbomb upgrade removed from vehicle " .. tostring(eng))
        end
    end,
})

cwVehicleUpgrades:RegisterUpgrade("upgrade_carbomb_timed", {
    name = "Timed Car Bomb",
    description = "Explodes when the timer reaches zero after the engine is started.",
    allowedComponents = {"Engine"},
    itemUniqueID = "carbomb_timed",
    apply = function(vehicle, applier)
        if not IsValid(applier) and vehicle.GetDriver then
            applier = vehicle:GetDriver()
        end
        if vehicle and vehicle.StartEngine then
            local originalStartEngine = vehicle.StartEngine
             
            vehicle.StartEngine = function(self, ...)
                originalStartEngine(self, ...)
                if self:GetEngineActive() then
                    local timerLength = self._CarbombTimerLength or 5
                    vehicle:EmitSound("ui/buttonclick.wav")
                    timer.Simple(timerLength, function()
                        if IsValid(self) and self:GetEngineActive() then
                            local pos = self:GetPos() or self:GetPos()
                            util.BlastDamage(self, self, pos, 300, 100)
                            
                            local effectData = EffectData()
                            effectData:SetOrigin(pos)
                            util.Effect("Explosion", effectData)
                            
                            self:SetDestroyed(true)
                        end
                    end)
                end
            end
            
            vehicle._CarbombOriginalStartEngine = originalStartEngine

            if IsValid(applier) then
                net.Start("TimedCarbomb_RequestTime")
                net.WriteEntity(vehicle)
                net.Send(applier)
            end
        end
    end,
    remove = function(vehicle)
        if vehicle and vehicle._CarbombOriginalStartEngine then
            vehicle.StartEngine = vehicle._CarbombOriginalStartEngine
            vehicle._CarbombOriginalStartEngine = nil
        end
    end,
})

net.Receive("TimedCarbomb_SetTime", function(len, ply)
    local vehicle = net.ReadEntity()
    local timerLength = net.ReadFloat()
    if IsValid(vehicle) then
        vehicle._CarbombTimerLength = timerLength
        print("[VehicleUpgrades] Timer length for timed carbomb set to " .. timerLength .. " seconds on vehicle " .. tostring(vehicle))
    end
end)

cwVehicleUpgrades:RegisterUpgrade("upgrade_amphibious", {
    name = "Amphibious Crankshaft",
    description = "Allows more water into the engine before causing a shutdown.",
    allowedComponents = {"Engine"},
    itemUniqueID = "amphibious_crankshaft",
    apply = function(vehicle, applier)
        if vehicle and vehicle.IsEngineStartAllowed then
            local originalIsEngineStartAllowed = vehicle.IsEngineStartAllowed
            
            vehicle.IsEngineStartAllowed = function(self, ...)
                if hook.Run( "LVS.IsEngineStartAllowed", self ) == false then return false end

                if self:WaterLevel() > (self.WaterLevelPreventStart)+1 then return false end

                return true
            end
            
            vehicle._OriginalIsEngineStartAllowed = originalIsEngineStartAllowed
        end
    end,
    remove = function(vehicle)
        if vehicle and vehicle._OriginalIsEngineStartAllowed then
            vehicle.IsEngineStartAllowed = vehicle._OriginalIsEngineStartAllowed
            vehicle._OriginalIsEngineStartAllowed = nil
        end
    end,
})

cwVehicleUpgrades:RegisterUpgrade("upgrade_radio", {
    name = "Vehicle Radio",
    description = "Allows communication via radio within a vehicle.",
    allowedComponents = {"Engine"},
    itemUniqueID = "vicradio",
    apply = function(vehicle)
        local radio = ents.Create("cw_radio")
        if not IsValid(radio) then return end
        
        radio:SetPos(vehicle:GetPos())
        radio:SetAngles(vehicle:GetAngles())
        radio:Spawn()
        radio:Activate()
        
        radio:SetParent(vehicle)
        radio:SetRenderMode(RENDERMODE_TRANSALPHA)
        radio:SetColor(Color(255, 255, 255, 0))
        
        vehicle.Radio = radio
    end,
    remove = function(vehicle)
        if vehicle.Radio and IsValid(vehicle.Radio) then
            vehicle.Radio:Remove()
            vehicle.Radio = nil
        end
    end,
})

print("[VehicleUpgrades] Server side plugin loaded.")