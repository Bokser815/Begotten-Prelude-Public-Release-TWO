PLUGIN:SetGlobalAlias("cwFarming");

Clockwork.kernel:IncludePrefixed("sv_plugin.lua");
Clockwork.kernel:IncludePrefixed("sv_hooks.lua");

-- View info on planters in the format of: ID: (x, y, z) | Joe Dirkson | 240 | 80 | 3/9 | 
local COMMAND = Clockwork.command:New("FarmingPlantersInfo")
	COMMAND.tip = "View info on all farming planters."
	COMMAND.access = "s"

	function COMMAND:OnRun(player, arguments)
        local plantersInfo = {}
    
        for _, ent in ipairs(ents.GetAll()) do
            if ent:GetClass() == "cw_planter" then
                local c = 0
                for q,y in pairs(ent.slots) do
                    if y then
                        c = c + 1
                    end
                end

                local planterInfo = {
                    ID = ent:EntIndex(),
                    Position = ent:GetPos(),
                    Health = ent.health or 0,
                    WaterLevel = ent:GetNWInt("water", 0),
                    SeedAmount = c,
                    OriginalPlacer = ent:GetNWString("OwnerName", "Unknown"),
                    Fertilized = ent:GetNWBool("fertilized", false) and "T" or "F",
                    Sunlight = ent:GetNWBool("sunlightPercentage", false) and "T" or "F",
                    Infected = ent.infected and "T" or "F"
                }
    
                table.insert(plantersInfo, planterInfo)
            end
        end
   
        if #plantersInfo > 0 then
            Schema:EasyText(player, "darkgrey", "ID: (x, y, z) | Name | HP | Water | Seeds | Fert | Sunlight | Infected")
            for _, p in pairs(plantersInfo) do
                local positionString = string.format("(%d, %d, %d)", p.Position.x, p.Position.y, p.Position.z)
                local infoString = string.format("%s: %s | %s | %d | %d | %s | %s | %s | %s", p.ID ,positionString, p.OriginalPlacer, p.Health, p.WaterLevel, p.SeedAmount .. "/" .. 9, p.Fertilized, p.Sunlight, p.Infected)

                Schema:EasyText(player, "darkgrey", infoString)
            end
        else
            Schema:EasyText(player, "darkgrey", "No planters are placed on this map.")
        end
	end
COMMAND:Register()

-- Delete a planter by ID and by Context menu
local COMMAND = Clockwork.command:New("FarmingDeletePlanter")
COMMAND.tip = "Delete a farming planter by ID."
COMMAND.text = "<number ID>"
COMMAND.arguments = 1
COMMAND.access = "s"

function COMMAND:OnRun(player, arguments)
    local planterID = tonumber(arguments[1])
    local targetEnt = ents.GetByIndex(planterID)

    if IsValid(targetEnt) and targetEnt:GetClass() == "cw_planter" then
        targetEnt:Remove()
        Clockwork.player:Notify(player, "You have deleted planter with ID " .. planterID .. ".")
        -- alert all admins
    else
        Clockwork.player:Notify(player, "Invalid planter ID.")
    end
end
COMMAND:Register()

-- Delete all planters
local COMMAND = Clockwork.command:New("FarmingDeleteAllPlanters")
COMMAND.tip = "Delete all farming planters."
COMMAND.access = "s"

function COMMAND:OnRun(player, arguments)
    local deletedCount = 0

    for _, ent in ipairs(ents.GetAll()) do
        if ent:GetClass() == "cw_planter" then
            ent:Remove()
            deletedCount = deletedCount + 1
        end
    end

    Clockwork.player:Notify(player, "Deleted " .. deletedCount .. " planters.")
    -- alert all admins
end
COMMAND:Register()