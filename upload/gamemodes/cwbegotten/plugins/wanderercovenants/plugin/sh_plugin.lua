PLUGIN:SetGlobalAlias("cwWandererCovenants");
Clockwork.kernel:IncludePrefixed("cl_hooks.lua");
Clockwork.kernel:IncludePrefixed("cl_plugin.lua");
Clockwork.kernel:IncludePrefixed("sv_hooks.lua");
Clockwork.kernel:IncludePrefixed("sv_plugin.lua");

if not config then
    include("sh_config.lua")
end


-- DEV/DEBUG COMMANDS --
-- Disband all covenants
local COMMAND = Clockwork.command:New("CovDisbandAll");
COMMAND.tip = "Disband all covenants.";
COMMAND.access = "s"; 

function COMMAND:OnRun(player, arguments)
    local covsDisbanded = cwWandererCovenants:DisbandAllCovenants()
    if covsDisbanded > 0 then
        Schema:EasyText(Schema:GetAdmins(), "olivedrab", player:GetName().." disbanded "..covsDisbanded.." covenants.")
    else
        Schema:EasyText(player, "firebrick", "There are no covenants loaded.")
    end
end

COMMAND:Register()

-- Force a player to join your covenant
local COMMAND = Clockwork.command:New("CovForceJoin")
COMMAND.tip = "Force a player to join your covenant."
COMMAND.text = "<playerName>"
COMMAND.access = "s" 
COMMAND.arguments = 1 

function COMMAND:OnRun(player, arguments)
    local targetPlayerName = arguments[1]
    local targetPlayer = Clockwork.player:FindByID(targetPlayerName)
    
    if not targetPlayer then
        Schema:EasyText(player, "firebrick", "Player not found.")
        return
    end

    local covenName = player:GetCharacterData("wandererCovenantName")
    if not covenName then
        Schema:EasyText(player, "firebrick", "You aren't in a covenant!")
        return
    end

    if cwWandererCovenants.loadedCovenants[covenName] then
        cwWandererCovenants:FinishInviteToCovenant(player, targetPlayer, covenName)
    end

end
COMMAND:Register()

-- Command to set the points of a player in a covenant
local COMMAND = Clockwork.command:New("CovSetPoints")
COMMAND.tip = "Set the points of a covenant."
COMMAND.text = "<covenName> <points>"
COMMAND.access = "s"
COMMAND.arguments = 2

function COMMAND:OnRun(player, arguments)
    local covenName = arguments[1]
    local pointsToSet = tonumber(arguments[2])

    if not pointsToSet then
        Schema:EasyText(player, "firebrick", "Invalid points value.")
        return
    end

    local cov = cwWandererCovenants.loadedCovenants[covenName]

    if not cov then
        Schema:EasyText(player, "firebrick", "Covenant not found.")
        return
    end

    if cwWandererCovenants.loadedCovenants[covenName] then
        cwWandererCovenants.loadedCovenants[covenName].stats.points = pointsToSet
        Schema:EasyText(player, "olivedrab", "Successfully set points for " .. covenName .. " to " .. pointsToSet .. ".")
    else
        Schema:EasyText(player, "firebrick", "Covenant not found.")
    end
end

COMMAND:Register()


-- Force a player to join your covenant can merge this w/ one above w/ check on args > 0 if args==1 then
local COMMAND = Clockwork.command:New("CovForceJoinTwo")
COMMAND.tip = "Force a player to invite someone to their covenant."
COMMAND.text = "<covLeader> <invitedPlayer>"
COMMAND.access = "s" 
COMMAND.arguments = 2 

function COMMAND:OnRun(player, arguments)
    local covLeaderName = arguments[1]
    local invitedPlayerName = arguments[2]
    local covLeader = Clockwork.player:FindByID(covLeaderName)
    local invitedPlayer = Clockwork.player:FindByID(invitedPlayerName)
    
    if not covLeader or not invitedPlayer then
        Schema:EasyText(player, "firebrick", "Players not found.")
        return
    end

    local covenName = covLeader:GetCharacterData("wandererCovenantName")
    local invitedPlayerCovenant = invitedPlayer:GetCharacterData("wandererCovenantName")
    if not covenName then
        Schema:EasyText(player, "firebrick", "Your first target isn't in a covenant!")
        return
    elseif invitedPlayerCovenant then
        Schema:EasyText(player, "firebrick", "Your second target is in a covenant!")
        return
    end

    cwWandererCovenants:FinishInviteToCovenant(covLeader, invitedPlayer, covenName)
end
COMMAND:Register()



-- Oepn Wanderer's Convenants Main Menu, maybe reducunat.. plus wont work w/ how we have setup rebuild(), delete in future
local COMMAND = Clockwork.command:New("CovOpen")
COMMAND.tip = "Opens the WC menu."
COMMAND.flags = CMD_DEFAULT

function COMMAND:OnRun(player, arguments)
    cwWandererCovenants:OpenCovenantMainMenu(player, true)
end
COMMAND:Register()

-- Disband your convenan
local COMMAND = Clockwork.command:New("CovenantsDisband")
COMMAND.tip = "Disbands your covenant.."
COMMAND.flags = CMD_DEFAULT

function COMMAND:OnRun(player, arguments)
    local covenName = player:GetCharacterData("wandererCovenantName")
    if covenName then
        cwWandererCovenants:DisbandCovenant(player, covenName)
    else
        Schema:EasyText(player, "firebrick", "You aren't in a covenant!");
    end
end

-- Get a list of covenants on the server, or if supplied with the name of a covenant then get the table for that covenant
COMMAND:Register()
local COMMAND = Clockwork.command:New("CovView")
COMMAND.tip = "View all the covenants currently on the server or detailed info on a specific covenant."
COMMAND.text = "<CovName>"
COMMAND.access = "s"
COMMAND.optionalArguments = 1;

function COMMAND:OnRun(player, arguments)
    local names = {}
    local covName = arguments[1]


    if covName and cwWandererCovenants.loadedCovenants[covName] then
        Clockwork.player:Notify(player, covName .. ": "..util.TableToJSON(cwWandererCovenants.loadedCovenants[covName]))
    else
        for i, k in pairs(cwWandererCovenants.loadedCovenants) do
            table.insert(names, i)
        end

        Clockwork.player:Notify(player, table.concat(names, ", "));
    end
end

COMMAND:Register()


local COMMAND = Clockwork.command:New("CovForceMake")
COMMAND.tip = "Force a player to make a covenant with your chosen name and type."
COMMAND.text = "<playerName> <covenantName> <covenantType>"
COMMAND.access = "s" 
COMMAND.arguments = 3

function COMMAND:OnRun(player, arguments)
    local tarPlayer, covName, covType =  Clockwork.player:FindByID(arguments[1]), arguments[2], arguments[3]
    if tarPlayer and covName and covType then
        if cwWandererCovenants:CreateCovenant(tarPlayer, covName, covType, Color(0,255,0)) then
            Schema:EasyText(player, "olivedrab", "Forced " .. tarPlayer:GetName() .. " take make a covenant called " .. covName)
        else
            Schema:EasyText(player, "firebrick", "Invalid args.")
        end
    else
        Schema:EasyText(player, "firebrick", "Error, missing an argument!")
    end
end
COMMAND:Register()

local COMMAND = Clockwork.command:New("CovForceInvite")
COMMAND.tip = "Forces a player to invite another player into their covenant"
COMMAND.access = "s" 
COMMAND.text = "<covenLeader> <playerName>"
COMMAND.arguments = 2

function COMMAND:OnRun(player, arguments)
    local covenPlayer, tarPlayer = Clockwork.player:FindByID(arguments[1]), Clockwork.player:FindByID(arguments[2])
    local covenName = covenPlayer:GetCharacterData("wandererCovenantName")
    if covenPlayer and tarPlayer and covenName then
        cwWandererCovenants:OfferInviteToCovenant(covenPlayer, covenName, tarPlayer)
    else
        Schema:EasyText(player, "firebrick", "Error, missing an argument / invalid players!")
    end
end
COMMAND:Register()

local COMMAND = Clockwork.command:New("CovResetPlayer")
COMMAND.tip = "View all the covenants currently on the server"
COMMAND.access = "s" 
COMMAND.text = "<playerName>"
COMMAND.arguments = 1

function COMMAND:OnRun(player, arguments)
    local targetPlayerName = arguments[1]
    local targetPlayer = Clockwork.player:FindByID(targetPlayerName)
    local covName = targetPlayer:GetCharacterData("wandererCovenantName")
    if covName then
        targetPlayer:SetCharacterData("wandererCovenantName", nil)
        targetPlayer:SetNetVar("wandererCovenantName", nil)
        cwWandererCovenants:LeaveCovenant(targetPlayer, covName, function(val)
            if val then
                Schema:EasyText(player, "olivedrab", "Successfully removed " .. targetPlayer:GetName() .. " from " .. covName)
            else
                Schema:EasyText(player, "firebrick", targetPlayer:GetName() .. " isn't in a covenant table!")
            end
        end)
    end
end
COMMAND:Register()


local COMMAND = Clockwork.command:New("CovForceSetRank")
COMMAND.tip = "Force a player to set another player's rank within their covenant."
COMMAND.text = "<covenLeader> <targetPlayer> <newRank>"
COMMAND.access = "s"
COMMAND.arguments = 3

function COMMAND:OnRun(player, arguments)
    local covenLeader = Clockwork.player:FindByID(arguments[1])
    local targetPlayer = Clockwork.player:FindByID(arguments[2])
    local newRank = arguments[3]
    
    if not covenLeader or not targetPlayer then
        Schema:EasyText(player, "firebrick", "Players not found.")
        return
    end
    
    local covenantName = covenLeader:GetCharacterData("wandererCovenantName")
    
    if covenantName then
        cwWandererCovenants:SetPlayerRank(covenantName, covenLeader, targetPlayer:GetName(), newRank)
    else
        Schema:EasyText(player, "firebrick", covenLeader:GetName() .. " is not in a covenant.")
    end
end
COMMAND:Register()


local COMMAND = Clockwork.command:New("CovForceKick")
COMMAND.tip = "Force a player to kick another player from their covenant."
COMMAND.text = "<covenLeader> <targetPlayer>"
COMMAND.access = "s"
COMMAND.arguments = 2

function COMMAND:OnRun(player, arguments)
    local covenLeader = Clockwork.player:FindByID(arguments[1])
    local targetPlayer = Clockwork.player:FindByID(arguments[2])
    
    if not covenLeader or not targetPlayer then
        Schema:EasyText(player, "firebrick", "Players not found.")
        return
    end
    
    local covenantName = covenLeader:GetCharacterData("wandererCovenantName")
    
    if covenantName then
        cwWandererCovenants:KickFromCovenant(covenantName, covenLeader, targetPlayer, function(success)
            if success then
                Schema:EasyText(player, "olivedrab", targetPlayer:GetName() .. " has been kicked from the covenant.")
            else
                Schema:EasyText(player, "firebrick", "Failed to kick the player from the covenant.")
            end
        end)
    else
        Schema:EasyText(player, "firebrick", covenLeader:GetName() .. " is not in a covenant.")
    end
end

COMMAND:Register()

local COMMAND = Clockwork.command:New("CovDisband")
COMMAND.tip = "Disband a specified covenant."
COMMAND.text = "<covenantName>"
COMMAND.access = "s"
COMMAND.arguments = 1

function COMMAND:OnRun(player, arguments)
    local covenantName = arguments[1]
    
    if covenantName and cwWandererCovenants.loadedCovenants[covenantName] then
        local covLeaderName
        for playerName, rankData in pairs(cwWandererCovenants.loadedCovenants[covenantName].players) do
            if rankData.rank == cwWandererCovenants.loadedCovenants[covenantName].config.leaderRank then 
                covLeaderName = playerName
                break
            end
        end

        if covLeaderName then
            local covLeader = Clockwork.player:FindByID(covLeaderName)
            cwWandererCovenants:DisbandCovenant(covLeader, covenantName, function(success)
                if success then
                    Schema:EasyText(player, "olivedrab", "Covenant '" .. covenantName .. "' has been disbanded.")
                else
                    Schema:EasyText(player, "firebrick", "Failed to disband the covenant or it doesn't exist.")
                end
            end)
        end
    else
        Schema:EasyText(player, "red", "Covenant name required.")
    end
end

COMMAND:Register()

local COMMAND = Clockwork.command:New("CovDelete")
COMMAND.tip = "Delete a specified covenant."
COMMAND.text = "<covenantName>"
COMMAND.access = "s"
COMMAND.arguments = 1

function COMMAND:OnRun(player, arguments)
    local covenantName = arguments[1]
    
    if covenantName then
        cwWandererCovenants:DeleteCovenant(covenantName, player, function(success)
            if success then
                Schema:EasyText(player, "olivedrab", "Covenant '" .. covenantName .. "' has been deleted.")
            else
                Schema:EasyText(player, "firebrick", "Failed to deleted the covenant or it doesn't exist.")
            end
        end)
    else
        Schema:EasyText(player, "firebrick", "Covenant name required.")
    end
end
COMMAND:Register()