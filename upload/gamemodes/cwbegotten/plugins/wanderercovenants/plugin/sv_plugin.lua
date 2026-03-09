local beliefs = {
    Militant = {
        [1] = {
            {name = "eternal", req = {}}
        },
        [2] = {
            {name = "balance", req = {"eternal"}},
            {name = "keeper", req = {"eternal"}}
        },
        [3] = {
            {name = "ascension", req = {"balance", "keeper"}}
        }
    },

    Mercantile = {
        [1] = {
            {name = "shattered", req = {}},
            {name = "echoes", req = {}}
        },
        [2] = {
            {name = "warden", req = {"shattered"}},
            {name = "shadow", req = {"echoes"}}
        },
        [3] = {
            {name = "threads", req = {"warden", "shadow"}}
        }
    },

    Religious = {
        [1] = {
            {name = "firstborn", req = {}},
            {name = "guardians", req = {}}
        },
        [2] = {
            {name = "heart", req = {"firstborn"}},
            {name = "totality", req = {"guardians"}}
        },
        [3] = {
            {name = "final", req = {"heart"}},
            {name = "next", req = {"totality"}}
        }
    }
}


local rankTable = { -- Default starter ranks
    {name = "Leader", permissions = {kick = true, invite = true, alter = true, heir = false}}, 
    {name = "Heir", permissions = {kick = true, invite = true, alter = true, heir = true}}, 
    {name = "Officer", permissions = {kick = true, invite = true, alter = true, heir = true}}, 
    {name = "Corporal", permissions = {kick = false, invite = true, alter = false, heir = false}}, 
    {name = "Member", permissions = {kick = false, invite = false, alter = false, heir = false}}, 
    {name = "Fresh Meat", permissions = {kick = false, invite = false, alter = false, heir = false}}
}

cwWandererCovenants.covenantBeliefCosts = {2000, 5000, 8500, 15000, 25000, 30000} -- Default belief costs for the 5 possible skills
cwWandererCovenants.reqCatalysts = true -- Boolean if catalysts are required for creating a covenant
cwWandererCovenants.types = {"Tribe", "Clan", "Coven", "Free Company", "Militia", "Heresy"} -- need to rework types in the future...
cwWandererCovenants.covenXPUpdateTime = 60
cwWandererCovenants.covenCreationTime = 2
cwWandererCovenants.covenInviteTime = 10
cwWandererCovenants.inviteTimer = 60

if not cwWandererCovenants.loadedCovenants then
    cwWandererCovenants.loadedCovenants = {}
end
cwWandererCovenants.covenantXPTime = 5

-- Reset a players covenantdata to nil
function cwWandererCovenants:ResetPlayerCovenantData(player)
    if not IsValid(player) then return end
    player:SetCharacterData("wandererCovenantName", nil)
    player:SetNetVar("wandererCovenantName", nil)
end

-- Check if a player is a leader
function cwWandererCovenants:IsLeader(playerName, players, config)
    return players[playerName] and players[playerName].rank == config.leaderRank
end

-- Create a covenant given the creator, name, and type
function cwWandererCovenants:CreateCovenant(covenCreator, covenName, covType, color)
    local nameUnique = true
    if covenCreator:GetCharacterData("wandererCovenantName") ~= nil then return false end
    if #covenName < 1 or #covenName > 15 then return false end
    if not covType then return false end
    for i, k in pairs(cwWandererCovenants.loadedCovenants) do
        if i == covenName then
            nameUnique = false
            break 
        end
    end

    if not nameUnique then 
        return false
    end

    local playerData = {
        [covenCreator:GetName()] = {  -- instead of using name, should use GetCharacterID()
            rank = rankTable[1].name, 
            model = covenCreator:GetModel(), 
            skin = covenCreator:GetSkin(),
            alive = true,
            steamID = covenCreator:SteamID()
        }
    }
    cwWandererCovenants.loadedCovenants[covenName] = {players = playerData, stats = {kills = 0, level = 1, points = 0, xp = 0, deaths = 0, totalAlive = 1}, beliefs = {}, config = {ranks = rankTable, leaderRank = rankTable[1].name, startingRank = rankTable[6].name, type = tonumber(covType), dateFounded = Clockwork.date:GetMonth() .. "/" .. Clockwork.date:GetDay(), overlayColor = color}}
    covenCreator:SetCharacterData("wandererCovenantName", covenName)
    covenCreator:SetNetVar("wandererCovenantName", covenName)
    netstream.Start(covenCreator, "CovenantLoaded", cwWandererCovenants.loadedCovenants[covenName].config.overlayColor)
    
    return true
end

-- Disband all covenants on the server, devdebug
function cwWandererCovenants:DisbandAllCovenants()
    local deleteObj = Clockwork.database:Delete("wanderercovenants")
    deleteObj:Execute()

    local c = 0
    for i, covTable in pairs(cwWandererCovenants.loadedCovenants) do
        c = c + 1
        for x,plyData in pairs(covTable.players) do
            local ply = Clockwork.player:FindByID(x)
            cwWandererCovenants:ResetPlayerCovenantData(ply)
        end
    end
    cwWandererCovenants.loadedCovenants = {}
    return c
end

-- Remove the covenant from the table and set its players data to nil
function cwWandererCovenants:DeleteCovenant(covenName, deleterName, callback)
    local r = false
    if cwWandererCovenants.loadedCovenants[covenName] then
        for k,p in pairs(cwWandererCovenants.loadedCovenants[covenName].players) do
            local ply = Clockwork.player:FindByID(k)
            cwWandererCovenants:ResetPlayerCovenantData(ply)
        end
        cwWandererCovenants.loadedCovenants[covenName] = nil
        r = true
    end
    if callback then
        callback(r)
    end
end

-- Player leave a covenant given their entity and the name of covenant.
function cwWandererCovenants:LeaveCovenant(leaver, covenName, callback)

    if cwWandererCovenants.loadedCovenants[covenName] then
        if cwWandererCovenants:IsLeader(leaver, cwWandererCovenants.loadedCovenants[covenName].players, cwWandererCovenants.loadedCovenants[covenName].config) then
            Schema:EasyText(leaver, "firebrick", "A leader can't leave their covenant.")
        else
            cwWandererCovenants:ResetPlayerCovenantData(leaver)
            cwWandererCovenants.loadedCovenants[covenName].players[leaver:GetName()] = nil

            if not next(cwWandererCovenants.loadedCovenants[covenName].players) then
                cwWandererCovenants:DeleteCovenant(covenName, leaver:GetName(), function(result)
                    if result then
                        Schema:EasyText(leaver, "olivedrab", "The covenant " .. covenName .. " has been disbanded.")
                    end
                end)
            else
                Schema:EasyText(leaver, "firebrick", "You have left "..covenName)
            end
        end
    end
    cwWandererCovenants:OpenCovenantMainMenu(leaver)
end

-- Disband a covenant given the name of the leader and the name
function cwWandererCovenants:DisbandCovenant(covenCreator, covenName, callback)
    local covenCreatorName = covenCreator:GetName()
    if cwWandererCovenants.loadedCovenants[covenName] then
        if cwWandererCovenants.loadedCovenants[covenName].players[covenCreatorName] and cwWandererCovenants:IsLeader(covenCreatorName, cwWandererCovenants.loadedCovenants[covenName].players, cwWandererCovenants.loadedCovenants[covenName].config) then
            cwWandererCovenants:DeleteCovenant(covenName, covenCreator, function()
                if callback then
                    callback(true)
                end
            end)
        end
    end
end

-- Sends data and a command to the client to open the covenant main menu (optional boolean)
function cwWandererCovenants:OpenCovenantMainMenu(player, openMenu)
    openMenu = openMenu or false
    local covenData = {
        name = nil,
        players = {},
        stats = {kills = 0, xp = 0, deaths = 0, totalAlive = 0}, 
        beliefs = {},
        config = {ranks = rankTable, leaderRank = rankTable[1].name, startingRank = rankTable[6].name, type = covType, dateFounded = "N/A"},
        types = cwWandererCovenants.types,
        openMenu = openMenu
    }

    local playerCovenName = player:GetCharacterData("wandererCovenantName")
    if playerCovenName and cwWandererCovenants.loadedCovenants[playerCovenName] then
        covenData.name = playerCovenName
        covenData.players = cwWandererCovenants.loadedCovenants[playerCovenName].players
        covenData.stats = cwWandererCovenants.loadedCovenants[playerCovenName].stats
        covenData.beliefs = cwWandererCovenants.loadedCovenants[playerCovenName].beliefs
        covenData.config = cwWandererCovenants.loadedCovenants[playerCovenName].config
        
        
    end
    netstream.Start(player, "UpdatePlayerConveantsMainDerma", covenData);
end

-- Sends data and a command to the client to open the covenant rank menu
function cwWandererCovenants:OpenCovenantRankMenu(player)
    local playerCovenName = player:GetCharacterData("wandererCovenantName") or nil

    if playerCovenName and cwWandererCovenants.loadedCovenants[playerCovenName] then
        netstream.Start(player, "OpenCovenantRankDerma", {playerCovenName, cwWandererCovenants.loadedCovenants[playerCovenName].config});
    end

end

-- Sends data and a command to the client to open the covenant rank menu
function cwWandererCovenants:OpenCovenantBeliefMenu(player)
    local playerCovenName = player:GetCharacterData("wandererCovenantName") or nil

    if playerCovenName and cwWandererCovenants.loadedCovenants[playerCovenName] then
        netstream.Start(player, "OpenCovenantBeliefDerma", {playerCovenName, cwWandererCovenants.loadedCovenants[playerCovenName].config, cwWandererCovenants.loadedCovenants[playerCovenName].stats, cwWandererCovenants.loadedCovenants[playerCovenName].beliefs});
    end
end


-- Check if player meets the requirements to unlock a belief
local function BeliefRequirementsMet(player, beliefReqs, playerBeliefs)
    for _, req in ipairs(beliefReqs) do
        if not playerBeliefs[req] then
            return false
        end
    end
    return true
end

-- Given a covenant name and belief, check requirements and unlock belief if possible
function cwWandererCovenants:SelectBelief(player, covName, covBelief)
    local covenant = cwWandererCovenants.loadedCovenants[covName]
    if covenant and covenant.players[player:GetName()] and cwWandererCovenants:IsLeader(player:GetName(), covenant.players, covenant.config) then
        local beliefFound = false
        for _, tree in pairs(beliefs) do
            for level, nodes in pairs(tree) do
                for _, belief in ipairs(nodes) do
                    
                    if belief.name == covBelief then
                        beliefFound = true
                        
                        if not  covenant.beliefs[covBelief] then
                            if BeliefRequirementsMet(belief.req, covenant.beliefs) then
                                if covenant.stats.points > 0 then
                                    covenant.beliefs[covBelief] = true
                                    covenant.stats.points = covenant.stats.points - 1

                                    netstream.Start(player, "OpenCovenantBeliefDerma", {covName, covenant.config, covenant.stats, covenant.beliefs})
                                    cwWandererCovenants:OpenCovenantMainMenu(player)
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end


-- Return true if a covenant has a belief unlocked
function cwWandererCovenants:HasBelief(covName, covBelief)
    if covName and cwWandererCovenants.loadedCovenants[covName] and covBelief and cwWandererCovenants.loadedCovenants[covName].beliefs then
        if cwWandererCovenants.loadedCovenants[covName].beliefs[covBelief] then
            return true
        end
    end
    return false
end

-- Offer an invite to a player to join a covenant from another player with invite permissions
function cwWandererCovenants:OfferInviteToCovenant(inviter, covName, invitee)
    if invitee != "N/A" and IsValid(invitee) and (invitee:IsPlayer() or invitee:IsBot()) and 
        inviter != "N/A" and IsValid(inviter) and (inviter:IsPlayer() or inviter:IsBot()) then
            if covName and cwWandererCovenants.loadedCovenants[covName] then
                local inviterData = cwWandererCovenants.loadedCovenants[covName].players[inviter:GetName()]
                invitee:SetSharedVar("invitedBy", inviter:GetName())

                local inviterName = string.match(inviter:GetName(), "^[^ ]+")
                if not Clockwork.player:DoesRecognise(invitee, inviter) then
                    inviterName = "[" .. string.sub(Clockwork.player:GetPhysDesc(inviter), 1, 21) .. "...] "
                end
                
                local pronoun = (inviter:GetGender() == GENDER_MALE) and "his" or "her"
                local inviteeName = string.match(invitee:GetName(), "^[^ ]+")
                if not Clockwork.player:DoesRecognise(inviter, invitee) then
                    inviteeName = "[" .. string.sub(Clockwork.player:GetPhysDesc(invitee), 1, 21) .. "...] "
                end

                Clockwork.chatBox:AddInTargetRadius(inviter, "me", " slices " .. pronoun .. " hand open with a knife and drains " .. pronoun .. " blood into a goblet, beckoning "..inviteeName.." forward.", inviter:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 2);

                timer.Create("CovenantInviteTimer"..invitee:GetName().."|"..inviter:GetName(), cwWandererCovenants.inviteTimer, 1, function()
                    invitee:SetSharedVar("invitedBy", nil)
                    Schema:EasyText(invitee, "firebrick", "Too much time passes and the invitiation ritual is ruined.")
                    Schema:EasyText(inviter, "firebrick", "Too much time passes and the invitiation ritual is ruined.")
                end)
            end
    end
end

function cwWandererCovenants:PlayerHasCharacterInCovenant(player, covName)
    if player:IsBot() then return false end
    for plyName, ply in pairs(cwWandererCovenants.loadedCovenants[covName].players) do
        local playerEnt = Clockwork.player:FindByID(plyName)
        if ply.steamID == player:SteamID() then
            return true
        end
    end
    return false
end

-- Covenant invite intro, begin actions for both players & invite sequence
function cwWandererCovenants:StartInviteToCovenant(inviter, covName, invitee)
    if invitee:GetSharedVar("invitedBy") then
        invitee:SetSharedVar("invitedBy", nil)
        if timer.Exists("CovenantInviteTimer"..invitee:GetName().."|"..inviter:GetName()) then
            timer.Remove("CovenantInviteTimer"..invitee:GetName().."|"..inviter:GetName())
        end
    else
        Schema:EasyText(invitee, "firebrick", "You don't have an invite from " .. inviter:GetName())
        return
    end

    if cwWandererCovenants:PlayerHasCharacterInCovenant(invitee, covName) then
        Schema:EasyText(invitee, "firebrick", "You already have a character in that covenant!")
        return
    end

    if covName and cwWandererCovenants.loadedCovenants[covName] then
        local p1Finish, p2Finish, activatedFinish = false, false, false

        if not cwWandererCovenants.loadedCovenants[covName].players[invitee:GetName()] then
            cwWandererCovenants:EffectsInviteToCovenant(inviter, invitee)
            Clockwork.player:SetAction(inviter, "inviting_covenant", cwWandererCovenants.covenInviteTime, 2, function()
                p1Finish = true
                if not activatedFinish and p1Finish and p2Finish then
                    activatedFinish = true
                    cwWandererCovenants:FinishInviteToCovenant(inviter, invitee, covName, cwWandererCovenants.loadedCovenants[covName].players, cwWandererCovenants.loadedCovenants[covName].stats, cwWandererCovenants.loadedCovenants[covName].config)
                    cwWandererCovenants:OpenCovenantMainMenu(inviter)
                end
            end)
            
            Clockwork.player:SetAction(invitee, "inviting_covenant", cwWandererCovenants.covenInviteTime, 2, function()
                p2Finish = true
                if not activatedFinish and p1Finish and p2Finish then
                    activatedFinish = true
                    cwWandererCovenants:FinishInviteToCovenant(inviter, invitee, covName, cwWandererCovenants.loadedCovenants[covName].players, cwWandererCovenants.loadedCovenants[covName].stats, cwWandererCovenants.loadedCovenants[covName].config)
                    cwWandererCovenants:OpenCovenantMainMenu(inviter)
                end
            end)
        
            Clockwork.chatBox:AddInTargetRadius(invitee, "me", " steps closer to their benefactor and takes the goblet in your hands, drinking it steadily.", invitee:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 2);
        else
            Schema:EasyText(inviter, "firebrick", invitee:GetName() .. " is already in your covenant!")
        end  
    else
        Schema:EasyText(invitee, "firebrick", "That covenant doesn't exist.")
    end

end

-- Covenant invite cosmetic, play sounds, set health
function cwWandererCovenants:EffectsInviteToCovenant(inviter, invitee)
    inviter:SetHealth(math.max(0, inviter:Health() - 5))
    invitee:EmitSound("armor/cloth_damage_01.wav")
    inviter:EmitSound("begotten/items/meat_corpse2.mp3")

    local soundObject = CreateSound(inviter, "pillarsofcreation/pillarsofcreation.wav")
    local maxVolume, initialVolume = 0.5, 0
    local fadeInDuration, fadeOutDuration = 3, 12
    local fadeSteps = 30

    soundObject:Play()
    soundObject:ChangeVolume(0, 0)

    timer.Create("FadeInSound", fadeInDuration / fadeSteps, fadeSteps, function()
        initialVolume = initialVolume + maxVolume / fadeSteps
        soundObject:ChangeVolume(math.min(initialVolume, maxVolume), 0)
    end)

    timer.Simple(fadeInDuration, function()
        timer.Create("FadeOutSound", fadeOutDuration / fadeSteps, fadeSteps, function()
            initialVolume = initialVolume - maxVolume / fadeSteps
            soundObject:ChangeVolume(math.max(initialVolume, 0), 0)
            if initialVolume <= 0 then
                soundObject:Stop() 
                invitee:EmitSound("begotten/items/meat_corpse2.mp3")
                invitee:EmitSound("armor/cloth_damage_01.wav")
            end
        end)
    end)
end

-- Covenant invite finialize, covenant player table is updated
function cwWandererCovenants:FinishInviteToCovenant(inviter, invitee, covName)
    local experience = invitee:GetCharacterData("experience", 0)
    local covenData = cwWandererCovenants.loadedCovenants[covName]

    -- Add corruption to the inviter
    local inviterFaith, inviterSubFaith = inviter:GetFaith(), inviter:GetSubfaith()
    local inviteeFaith, inviteeSubFaith = invitee:GetFaith(), invitee:GetSubfaith()
    local corruption = 0
    if inviterFaith == inviteeFaith and inviterSubFaith == inviteeSubFaith then
        corruption = 20
    elseif inviterFaith == inviteeFaith and inviterSubFaith ~= inviteeSubFaith then
        corruption = 25
    else
        corruption = 40
    end
    inviter:SetNeed("corruption", inviter:GetNeed("corruption") + corruption);
    invitee:SetNeed("corruption", invitee:GetNeed("corruption") + corruption);
   
    -- Adjust stats
    covenData.stats.totalAlive = covenData.stats.totalAlive + 1
    covenData.stats.xp = covenData.stats.xp + experience
    
    -- Add the player
    covenData.players[invitee:GetName()] = {rank = covenData.config["startingRank"], model = invitee:GetModel(), skin = invitee:GetSkin(), alive = true, steamID = invitee:SteamID()}

    invitee:SetCharacterData("wandererCovenantName", covName)
    invitee:SetNetVar("wandererCovenantName", covName)
    netstream.Start(invitee, "CovenantLoaded", covenData.config.overlayColor)
    
    Schema:EasyText(invitee, "olivedrab", "You have joined " .. covName)
    Schema:EasyText(inviter, "olivedrab", invitee:GetName() .. " has joined your covenant.")

    cwWandererCovenants:OpenCovenantMainMenu(inviter)
    cwWandererCovenants:OpenCovenantMainMenu(invitee)
end

function cwWandererCovenants:SaveCovenants(delete)
    Clockwork.kernel:SaveSchemaData("plugins/wanderercovenants", cwWandererCovenants.loadedCovenants);
end

function cwWandererCovenants:LoadCovenants()
    cwWandererCovenants.loadedCovenants = Clockwork.kernel:RestoreSchemaData("plugins/wanderercovenants");
end

-- Function to add XP to a player's covenant
function cwWandererCovenants:AddXPCovenant(player, covName, xpAmount)
    if not player or not covName or not xpAmount or not cwWandererCovenants.loadedCovenants[covName] then
        return
    end

    local newXP =( cwWandererCovenants.loadedCovenants[covName].stats.xp or 0) + xpAmount
    local level = cwWandererCovenants.loadedCovenants[covName].stats.level

    if cwWandererCovenants.covenantBeliefCosts[level] and (newXP >= (cwWandererCovenants.covenantBeliefCosts[level])) then
		cwWandererCovenants:LevelUp(covName);
        cwWandererCovenants.loadedCovenants[covName].stats.xp = newXP - cwWandererCovenants.covenantBeliefCosts[level]
    else
        cwWandererCovenants.loadedCovenants[covName].stats.xp = newXP
	end;
end

function cwWandererCovenants:LevelUp(covName)
    if covName and cwWandererCovenants.loadedCovenants[covName] then
        cwWandererCovenants.loadedCovenants[covName].stats.level = cwWandererCovenants.loadedCovenants[covName].stats.level + 1
        cwWandererCovenants.loadedCovenants[covName].stats.points = cwWandererCovenants.loadedCovenants[covName].stats.points + 1
    end
end

-- Promotes a character to the leader in their covenant
function cwWandererCovenants:PromoteHeirToLeader(playerToPromote, covName)
    if not playerToPromote or not covName then
        return
    end

    if covName and cwWandererCovenants.loadedCovenants[covName] then
        cwWandererCovenants.loadedCovenants[covName].players[playerToPromote].rank = cwWandererCovenants.loadedCovenants[covName].config.leaderRank
    end
end

-- Checks if a rank has a given permission given a covenants config
function cwWandererCovenants:CheckPermission(rank, permission, config)
    local rankIndex = cwWandererCovenants:GetRankIndex(rank, config.ranks)
    if config.ranks[rankIndex].permissions[permission] then
        return true
    else
        return false
    end
end

-- Kicks a character from their covenant
function cwWandererCovenants:KickFromCovenant(covName, kicker, kickeeName, callback)
    if covName and kicker then
        if kicker:GetName() ~= kickeeName then
            if cwWandererCovenants.loadedCovenants[covName] then
                local kickerName = kicker:GetName()
                local kickerData = cwWandererCovenants.loadedCovenants[covName].players[kickerName]
                local kickeeData = cwWandererCovenants.loadedCovenants[covName].players[kickeeName]

                if kickerData and kickeeData then
                    local kickerRankIndex = cwWandererCovenants:GetRankIndex(kickerData.rank, cwWandererCovenants.loadedCovenants[covName].config.ranks)
                    local kickeeRankIndex = cwWandererCovenants:GetRankIndex(kickeeData.rank, cwWandererCovenants.loadedCovenants[covName].config.ranks)

                    if kickerRankIndex < kickeeRankIndex then
                        if cwWandererCovenants:CheckPermission(kickerData.rank, "kick", cwWandererCovenants.loadedCovenants[covName].config) then
                            cwWandererCovenants.loadedCovenants[covName].players[kickeeName] = nil 
                            cwWandererCovenants.loadedCovenants[covName].stats.totalAlive = (cwWandererCovenants.loadedCovenants[covName].stats.totalAlive or 1) - 1

                            local kickee = Clockwork.player:FindByID(kickeeName)
                            if kickee then
                                cwWandererCovenants:ResetPlayerCovenantData(kickee)
                                Schema:EasyText(kickee, "maroon", "You have been kicked from the covenant by " .. kickerName .. ".")
                            end

                            if callback then
                                callback(true)
                            end
                            
                            Schema:EasyText(kicker, "olivedrab", "You have successfully kicked " .. kickeeName .. " from the covenant.")
                            cwWandererCovenants:OpenCovenantMainMenu(kicker)
                        else
                            Schema:EasyText(kicker, "firebrick", "You do not have the necessary permissions to kick players.")
                        end
                    else
                        Schema:EasyText(kicker, "firebrick", "You cannot kick a player with a higher or equal rank.")
                    end
                else
                    Schema:EasyText(kicker, "firebrick", "The player to kick is not in the covenant.")
                end
            else
                Schema:EasyText(kicker, "firebrick", "Covenant not found.")
            end
        else
            Schema:EasyText(kicker, "firebrick", "You can't kick yourself!")
        end
    else
        Schema:EasyText(kicker, "firebrick", "Invalid parameters.")
    end
end


-- Sets a players rank after performing a permission check
function cwWandererCovenants:SetPlayerRank(covName, adjuster, adjusteeName, newRank)
    local players = cwWandererCovenants.loadedCovenants[covName].players
    local config = cwWandererCovenants.loadedCovenants[covName].config
    local newRankName = config.ranks[tonumber(newRank)].name
	local adjusteeData = players[adjusteeName]
    
    if covName and cwWandererCovenants.loadedCovenants[covName] then
        if cwWandererCovenants:CheckPermission(players[adjuster:GetName()].rank, "alter", config) then
            
            local found = false
            for i,q in pairs(config.ranks) do
                if q.name == config.ranks[tonumber(newRank)].name then
                    players[adjusteeName].rank = newRankName
                    cwWandererCovenants:OpenCovenantMainMenu(adjuster)
                    return true
                end
            end
        end
    end
    return false
end

-- Computes the players death for their covenant (alive/death counts)
function cwWandererCovenants:ComputePlayerDeath(character, covenName)
	local covenData = cwWandererCovenants.loadedCovenants[covenName]
	if covenData.players[character] then
		covenData.players[character].alive = false
		covenData.stats.deaths = (covenData.stats.deaths or 0) + 1
		covenData.stats.totalAlive = covenData.stats.totalAlive - 1
	end
end

-- Returns the best candidate available for a covenant's heir
function cwWandererCovenants:GetCovenantHeir(covenName)
	local covenData = cwWandererCovenants.loadedCovenants[covenName]
	local players = covenData.players
	local config = covenData.config
	local highestRankIndexAlive = #config.ranks
	local highestRankPlayers = {}

	for playerName, playerData in pairs(players) do
		if playerData.alive and config.leaderRank ~= playerData.rank then
			for e, q in ipairs(config.ranks) do
				if playerData.rank == q.name then
					if q.permissions.heir and e <= highestRankIndexAlive then
						if e < highestRankIndexAlive then
							highestRankIndexAlive = e
							highestRankPlayers = {playerName}
						elseif e == highestRankIndexAlive then
							table.insert(highestRankPlayers, playerName)
						end
					end
				end
			end
		end
	end

	if #highestRankPlayers == 0 then -- No heirs desiginated, randomly select a player with the highest rank avail
        highestRankIndexAlive = #config.ranks
		for playerName, playerData in pairs(players) do
            local rankIndex = cwWandererCovenants:GetRankIndex(playerData.rank , config.ranks)
            if playerData.alive and config.leaderRank ~= playerData.rank then
                if rankIndex < highestRankIndexAlive then
                    highestRankIndexAlive = rankIndex
                    highestRankPlayers = {playerName}
                elseif rankIndex == highestRankIndexAlive and playerData.rank == config.ranks[highestRankIndexAlive].name then
                    table.insert(highestRankPlayers, playerName)
                end
            end
		end
	end
	return highestRankPlayers[math.random(1, #highestRankPlayers)]
end


function cwWandererCovenants:GetRankIndex(rankName, ranks)
    for i, rank in ipairs(ranks) do
        if rank.name == rankName then
            return i
        end
    end
    return #ranks + 1
end

function cwWandererCovenants:SendCovenantCreatePrompt(player, covType)
	covType = covType or 1
	Clockwork.dermaRequest:RequestString(player, "Wanderer Covenant Name", "What would you like to call your covenant? 1-15 characters", "", function(covName)
		if #covName < 1 or #covName > 15 then
			Schema:EasyText(player, "firebrick", "Too little or many characters, try again.")
		else
			if (player:GetFaction() == "Children of Satan" and player:GetNetVar("kinisgerOverride") == nil) or player:GetFaction() == "Wanderer" then
				if player:GetCharacterData("wandererCovenantName") == nil then 
					Clockwork.dermaRequest:RequestColor(player, "Covenant Overlay Color", "Select a color for your covenant overlay.", "", function(color)
						if cwWandererCovenants:CreateCovenant(player, covName, covType, color) then
							cwWandererCovenants:OpenCovenantMainMenu(player)
							Schema:EasyText(player, "olivedrab", "You created the covenant "..covName);
						else
							Schema:EasyText(player, "firebrick", "You failed in creating the covenant: Only 1-15 characters allowed for the name.");
						end						
					end)
				else
					Schema:EasyText(player, "firebrick", "You are already in a covenant!")
				end
			else
				Schema:EasyText(player, "firebrick", "Only wanderers can create covenants!")
			end
		end
	end)
end

function cwWandererCovenants:CovenantInviteNearbyPlayer(player)
	local covName = player:GetCharacterData("wandererCovenantName")
	local trace = player:GetEyeTrace()
	local nearestPlayer = nil
	local searchRadius = 150

	if trace.Entity and trace.Entity:IsValid() then -- Get person we're looking at
		local entity = trace.Entity
		if entity:IsPlayer() and entity:Alive() and player:GetPos():Distance(entity:GetPos()) <= searchRadius then
			nearestPlayer = entity
		end
	end

	if not nearestPlayer then -- Else get someone nearby
		local closestDistance = searchRadius + 1
		for _, ply in ipairs(_player.GetAll()) do
			if ply ~= player and ply:Alive() then
				local distance = player:GetPos():Distance(ply:GetPos())
				if distance <= searchRadius and distance < closestDistance then
					nearestPlayer = ply
					closestDistance = distance
				end
			end
		end
	end

	if nearestPlayer then
        local covName = player:GetCharacterData("wandererCovenantName")
        if covName and cwWandererCovenants.loadedCovenants[covName] then
            local playerData = cwWandererCovenants.loadedCovenants[covName].players[player:GetName()]
            if playerData then
                if cwWandererCovenants:CheckPermission(playerData.rank, "invite", cwWandererCovenants.loadedCovenants[covName].config) then
                    if not nearestPlayer:GetSharedVar("invitedBy") or not nearestPlayer:GetSharedVar("invitedBy") == player:GetName() then
                        cwWandererCovenants:OfferInviteToCovenant(player, covName, nearestPlayer)
                    else
                        Schema:EasyText(player, "firebrick", "You already invited "..nearestPlayer:GetName())
                    end
                else
                    Schema:EasyText(player, "firebrick", "You don't have permission to invite others to the covenant.")
                end
            else
                Schema:EasyText(player, "firebrick", "You are not a member of this covenant.")
            end
        else
            Schema:EasyText(player, "firebrick", "You are not part of any covenant.")
        end
	else
		Schema:EasyText(player, "firebrick", "There is no one nearby to invite.")
	end
end