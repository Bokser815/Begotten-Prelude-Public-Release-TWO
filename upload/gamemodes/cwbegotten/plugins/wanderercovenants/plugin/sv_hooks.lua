netstream.Hook("PlayerCovenantMainButtonsClicked", function(player, data)
    local btnName = data[1]
	local covName = data[2]

	if not player:Alive() or player:IsRagdolled() then 
		Clockwork.player:Notify(player, "You cannot do this action at the moment!")
		return 
	end
	
    if btnName == "Create" then
		local covType = data[3][1]
		local missingItems = {}
		local requiredCatalysts = {
			elysian_catalyst = "Elysian Catalyst",
			light_catalyst = "Light Catalyst",
			belphegor_catalyst = "Belphegor Catalyst"
		}

		if covType then
			for catalystID, catalystName in pairs(requiredCatalysts) do
				if not Clockwork.inventory:HasItemCountByID(player:GetInventory(), catalystID, 1) then
					table.insert(missingItems, catalystName)
				end
			end
			if #missingItems > 0 then
				local itemsReqStr = table.concat(missingItems, ", ")
				Schema:EasyText(player, "chocolate", "You do not have the following items to create a covenant: " .. itemsReqStr)
			else
				cwRituals:PerformRitual(player, "covenant_creation", requiredCatalysts)
			end
		else
			Schema:EasyText(player, "darkgrey", "You didn't select a type!")
		end
	elseif btnName == "Disband" then
		local covName = player:GetCharacterData("wandererCovenantName")
		if covName and cwWandererCovenants.loadedCovenants[covName] then
			local playerData = cwWandererCovenants.loadedCovenants[covName].players[player:GetName()]

			if playerData then
				if playerData.rank == cwWandererCovenants.loadedCovenants[covName].config.leaderRank then
					Clockwork.dermaRequest:RequestConfirmation(player, "Wanderer Covenant Disband", "Are you sure you want to disband " .. covName .. "?", function()
						cwWandererCovenants:DisbandCovenant(player, covName, function()
							cwWandererCovenants:OpenCovenantMainMenu(player)
						end)
					end)
				else
					Schema:EasyText(player, "firebrick", "Only the covenant leader can disband the covenant.")
				end
			else
				Schema:EasyText(player, "firebrick", "You are not a member of this covenant.")
			end
		else
			Schema:EasyText(player, "firebrick", "You are not part of any covenant.")
		end	
	elseif btnName == "Invite" then
		cwRituals:PerformRitual(player, "covenant_invite", {
			[1] = "down_catalyst",
			[2] = "elysian_catalyst",
			[3] = "ice_catalyst"
		});
    elseif btnName == "Ranks" then
		local covName = player:GetCharacterData("wandererCovenantName")
		if covName and cwWandererCovenants.loadedCovenants[covName] then
			local playerName = player:GetName()
			local playerData = cwWandererCovenants.loadedCovenants[covName].players[playerName]
			
			if playerData then
				if playerData.rank == cwWandererCovenants.loadedCovenants[covName].config.leaderRank then
					cwWandererCovenants:OpenCovenantRankMenu(player)
				else
					Schema:EasyText(player, "firebrick", "Only the covenant leader can manage ranks.")
				end
			end
		else
			Schema:EasyText(player, "firebrick", "You are not part of any covenant.")
		end
	elseif btnName == "Beliefs" then
		local covName = player:GetCharacterData("wandererCovenantName")
		if covName and cwWandererCovenants.loadedCovenants[covName] then
			local playerName = player:GetName()
			local playerData = cwWandererCovenants.loadedCovenants[covName].players[playerName]

			if playerData then
				if playerData.rank == cwWandererCovenants.loadedCovenants[covName].config.leaderRank then
					cwWandererCovenants:OpenCovenantBeliefMenu(player)
				else
					Schema:EasyText(player, "firebrick", "Only the covenant leader can manage beliefs.")
				end
			else
				Schema:EasyText(player, "firebrick", "You are not a member of this covenant.")
			end
		else
			Schema:EasyText(player, "firebrick", "You are not part of any covenant.")
		end
	elseif btnName == "Leave" then
		cwWandererCovenants:LeaveCovenant(player, covName, function(val)
            if val then
                Schema:EasyText(player, "olivedrab", "Successfully left " .. covName)
				cwWandererCovenants:OpenCovenantMainMenu(player)
            else
                Schema:EasyText(player, "firebrick", "Error, couldn't leave! " .. covName)
            end
        end)
	end
end)

netstream.Hook("PlayerCovenantKickPlayer", function(player, data)
    local covName = data[1]
    local kicker = Clockwork.player:FindByID(data[2])
    local kickee = Clockwork.player:FindByID(data[3])
    
    local kickeeName = kickee and kickee:GetName() or data[3]

    if covName and kicker then
        cwWandererCovenants:KickFromCovenant(covName, kicker, kickeeName)
    else
        Schema:EasyText(player, "firebrick", "Invalid parameters.")
    end
end)


netstream.Hook("CovenantBeliefTaken", function(player, data)
	local covName = data[1]
	local covBelief = data[2]
	
	cwWandererCovenants:SelectBelief(player, covName, covBelief)
end)

netstream.Hook("PlayerCovenantGetUpdate", function(player, data)
	cwWandererCovenants:OpenCovenantMainMenu(player, data)
end)
netstream.Hook("PlayerCovenantAdjustRank", function(player, data)
    local covName = data[1]
    local adjuster = Clockwork.player:FindByID(data[2])
    local adjustee = Clockwork.player:FindByID(data[3])
    local newRank = data[4]

    -- If adjustee is nil, use adjustee name directly from the data
    local adjusteeName = adjustee and adjustee:GetName() or data[3]

    if covName and adjuster and newRank then
        local covenant = cwWandererCovenants.loadedCovenants[covName]
        
        if covenant then
            local ranks = covenant.config.ranks
            local adjusterName = adjuster:GetName()
            local adjusterData = covenant.players[adjusterName]
            local adjusteeData = covenant.players[adjusteeName]
            
            local adjusterRankIndex = cwWandererCovenants:GetRankIndex(adjusterData.rank, ranks)
            local adjusteeRankIndex = cwWandererCovenants:GetRankIndex(adjusteeData and adjusteeData.rank or nil, ranks)

            if adjusterName ~= adjusteeName then
                if adjusterRankIndex < adjusteeRankIndex then
                    if adjusterData and adjusteeData and 
                       cwWandererCovenants:CheckPermission(adjusterData.rank, "alter", covenant.config) then

                        if adjusterRankIndex < newRank then
                            if cwWandererCovenants:SetPlayerRank(covName, adjuster, adjusteeName, newRank) then
                                Schema:EasyText(adjuster, "olivedrab", "You have successfully changed " .. adjusteeName .. "'s rank to " .. ranks[newRank].name .. ".")
                                Schema:EasyText(adjustee, "olivedrab", "Your rank has been changed to " .. ranks[newRank].name .. " by " .. adjusterName .. ".")
                            else
                                Schema:EasyText(adjuster, "firebrick", "The player you are trying to adjust is not in the covenant.")
                            end
                        else
                            Schema:EasyText(adjuster, "firebrick", "You can't set someone's rank higher than yours!")
                        end
                    else
                        Schema:EasyText(adjuster, "firebrick", "You are not authorized to adjust ranks in this covenant.")
                    end
                else
                    Schema:EasyText(adjuster, "firebrick", "You can't change someone's rank that is higher than you!")
                end
            else
                Schema:EasyText(adjuster, "firebrick", "You can't change your own rank!")
            end
        else
            Schema:EasyText(adjuster, "firebrick", "Covenant not found.")
        end
    else
        Schema:EasyText(player, "firebrick", "Invalid parameters.")
    end
end)


netstream.Hook("PlayerCovenantAcceptInvite", function(player, data)
	local inviter = Clockwork.player:FindByID(data[1])
	local inviterCov = inviter:GetCharacterData("wandererCovenantName") or "N/A"
	if (inviter:IsPlayer() or inviter:IsBot()) and inviter:Alive() and (player:IsPlayer() or player:IsBot()) and player:Alive() and player:GetPos():Distance(inviter:GetPos()) <= 150 then
		if player:GetCharacterData("wandererCovenantName") == nil then
			cwWandererCovenants:StartInviteToCovenant(inviter, inviterCov, player)
		end
	end
end)

netstream.Hook("PlayerCovenantUpdateRanks", function(player, data)
    local covName = data[1]
    local newPermissions = data[2]
    local newStarterRank = data[3]
	
	if cwWandererCovenants.loadedCovenants[covName] then
		local config = cwWandererCovenants.loadedCovenants[covName].config
		local players = cwWandererCovenants.loadedCovenants[covName].players

		if players[player:GetName()] and players[player:GetName()].rank == config.leaderRank then
			local prevLeaderRank = config.leaderRank
			local changedRankNames = {}
			-- Compare newPermissions with the existing ranks in config
			for i, newRankData in ipairs(newPermissions) do
				local prevRankData = config.ranks[i]
				if prevRankData.name ~= newRankData.name then
					changedRankNames[prevRankData.name] = newRankData.name
				end
			end

			-- Update player ranks
			for _, playerData in pairs(players) do
				for oldRank, newRank in pairs(changedRankNames) do
					if playerData.rank == oldRank then
						playerData.rank = newRank
					end
				end
			end

			config.ranks = newPermissions
			config.leaderRank = newPermissions[1].name
			config.startingRank = newStarterRank
		else
			Schema:EasyText(player, "firebrick", "You don't have permissions to edit your covenant's ranks.")
		end
	end
end)

-- Called when a player presses a key.
function cwWandererCovenants:KeyPress(player, key)
	if (key == IN_USE) then
		local invBy = player:GetSharedVar("invitedBy")
		if player:IsPlayer() and invBy then
			local trace = player:GetEyeTrace()
			
			if trace.Entity and trace.Entity:IsValid() then
				local entity = trace.Entity
				
				if entity:IsPlayer() and entity:Alive() and player:GetPos():Distance(entity:GetPos()) <= 150 then
					if (player:GetFaction() == "Children of Satan" and player:GetNetVar("kinisgerOverride") == nil) or player:GetFaction() == "Wanderer" then
						if entity:GetName() == invBy then
							netstream.Start(player, "CoventantAcceptInviteKeyInteraction", true)
						end
					else
						Schema:EasyText(player, "firebrick", "You can't join a covenant!");
					end
				end
			end
		end
	elseif (key == IN_ATTACK) then
		local action = Clockwork.player:GetAction(player);
		
		if action == "creating_covenant" or action == "inviting_covenant" then
			Clockwork.player:SetAction(player, nil);
		end
	end;
end;

-- Called just after data should be saved.
function cwWandererCovenants:SaveDataImminent()
	cwWandererCovenants:SaveCovenants()
end;

-- Called when Clockwork has loaded all of the entities.
function cwWandererCovenants:ClockworkInitPostEntity()
	cwWandererCovenants:LoadCovenants()
end

-- Called when a player is in an covenant action to slow them down
function cwWandererCovenants:ModifyPlayerSpeed(player, infoTable, action)
	if (action == "creating_covenant" or action == "inviting_covenant") then
		infoTable.runSpeed = infoTable.walkSpeed * 0.1;
		infoTable.walkSpeed = infoTable.walkSpeed * 0.1;
	end
end

-- Called when a covenant player dies, setting them to dead + adjusting cov stats. If the leader dies, an heir is selected or the covenant is disbanded
function cwWandererCovenants:PlayerDeath(player, inflictor, attacker, damageInfo)
	if not attacker:IsPlayer() then return end
    local covName = player:GetCharacterData("wandererCovenantName")
	local covAttackerName = attacker:GetCharacterData("wandererCovenantName")
	
	if covAttackerName then
		if cwWandererCovenants.loadedCovenants[covAttackerName] then
			cwWandererCovenants.loadedCovenants[covAttackerName].stats.kills = (cwWandererCovenants.loadedCovenants[covAttackerName].stats.kills or 0) + 1
		end
	end

	-- Increment a death for the killed cov, heir/disband checks
	if covName and cwWandererCovenants.loadedCovenants[covName] then
		local covenData = cwWandererCovenants.loadedCovenants[covName]
		local leaderDead = false
		if covenData.config.leaderRank == covenData.players[player:GetName()].rank then
			leaderDead = true
			covenData.players[player:GetName()].rank = "Past Leader"
		end

		cwWandererCovenants:ComputePlayerDeath(player:GetName(), covName)
		if covenData.stats.totalAlive > 0 and leaderDead then
			local heir = cwWandererCovenants:GetCovenantHeir(covName)
			cwWandererCovenants:PromoteHeirToLeader(heir, covName)
		else
			cwWandererCovenants:DisbandCovenant(player, covName, function()
				covenData.stats.covKills = (covenData.stats.covKills or 0) + 1
			end)
		end

	end
end

-- Called when a covenant player is deleted, setting them to dead + adjusting cov stats. If the leader dies, an heir is selected or the covenant is disbanded
hook.Add("PlayerDeleteCharacter", "PlayerDeleteCharacterCoven", function(player, character)
	local covName = character.data.wandererCovenantName
	if covName and cwWandererCovenants.loadedCovenants[covName] then
		local covenData = cwWandererCovenants.loadedCovenants[covName]
		local leaderDead = false
		if covenData.config.leaderRank == covenData.players[character.name].rank then
			leaderDead = true 
		end

		cwWandererCovenants:ComputePlayerDeath(character.name, covName)
		if covenData.stats.totalAlive > 0 and leaderDead then
			local heir = cwWandererCovenants:GetCovenantHeir(covName)
			cwWandererCovenants:PromoteHeirToLeader(heir, covName)
		else
			cwWandererCovenants:DisbandCovenant(player, covName)
		end
	end
end)


-- Store xp for session, log in / out to store it into table .. AND every 1hr store it, then set back to 0 lol
hook.Add("HandleXP", "HandleXP", function(player, amount, newXP, bIgnoreModifiers)
	local xp = player:GetNetVar("XPGainThisSession") or 0
	player:SetNetVar("XPGainThisSession", xp + newXP)
end)


timer.Create("CovenantXPUpdate", cwWandererCovenants.covenXPUpdateTime, 0, function() -- Gather XP for the covenant every minute
	for _, ply in ipairs(player.GetAll()) do
		local covName = ply:GetCharacterData("wandererCovenantName")
		local xp = ply:GetNetVar("XPGainThisSession") or 0
		if covName and xp > 0 then
			ply:SetNetVar("XPGainThisSession", 0)
			cwWandererCovenants:AddXPCovenant(ply:GetName(), covName, xp)
		end
	end
end)

-- hook PrePlayerCharacterUnloaded,save xp to covenant
function cwWandererCovenants:PrePlayerCharacterUnloaded(player)
    local covName = player:GetCharacterData("wandererCovenantName")
	local xp = player:GetNetVar("XPGainThisSession") or 0
	player:SetNetVar("wandererCovenantName", nil)
	player:SetSharedVar("invitedBy", nil)
    if covName and xp > 0 then
		player:SetNetVar("XPGainThisSession", 0)
		cwWandererCovenants:AddXPCovenant(player:GetName(), covName, xp)
    end
end

-- Set the character back to alive status
hook.Add("OnPlayerUnPermaKilled", "UpdateWandererCovenantOnUnPermaKill", function(player)
    local covName = player:GetCharacterData("wandererCovenantName");
	if covName and cwWandererCovenants.loadedCovenants[covName] then
		if cwWandererCovenants.loadedCovenants[covName].players[player:GetName()] then
			cwWandererCovenants.loadedCovenants[covName].players[player:GetName()].alive = true
			cwWandererCovenants.loadedCovenants[covName].players[player:GetName()].rank = cwWandererCovenants.loadedCovenants[covName].config.ranks[6].name
			cwWandererCovenants.loadedCovenants[covName].stats.deaths = cwWandererCovenants.loadedCovenants[covName].stats.deaths - 1
			cwWandererCovenants.loadedCovenants[covName].stats.totalAlive = cwWandererCovenants.loadedCovenants[covName].stats.totalAlive + 1
		end
	end
end);

-- Called when a player's name has changed.
function cwWandererCovenants:PlayerNameChanged(player, previousName, newName)
	local covName = player:GetCharacterData("wandererCovenantName")
	if covName and cwWandererCovenants.loadedCovenants[covName] then
		cwWandererCovenants.loadedCovenants[covName].players[newName] = table.Copy(cwWandererCovenants.loadedCovenants[covName].players[previousName])
		cwWandererCovenants.loadedCovenants[covName].players[previousName] = nil
	end
end;

-- Called when a player's character has been loaded.
function cwWandererCovenants:PlayerCharacterLoaded(player)
	player:SetNetVar("XPGainThisSession",  0)
	local covName = player:GetCharacterData("wandererCovenantName");
	player:SetSharedVar("invitedBy", nil)
	if covName and cwWandererCovenants.loadedCovenants[covName] then
		player:SetNetVar("wandererCovenantName", covName)
		--player:SetNetVar("wandererCovenantColor", cwWandererCovenants.loadedCovenants[covName].config.overlayColor)
		netstream.Start(player, "CovenantLoaded", cwWandererCovenants.loadedCovenants[covName].config.overlayColor)
	else
		player:SetNetVar("wandererCovenantName", nil)
		player:SetCharacterData("wandererCovenantName", nil)
	end
end
