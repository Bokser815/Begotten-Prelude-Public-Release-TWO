-- Draw text when a character inspects another character if they're in same covenant
hook.Add("DrawTargetPlayerCovenant", "", function(target, alpha, x, y)
    local playerCoven = Clockwork.Client:GetNetVar("wandererCovenantName")
    local targetCoven = target:GetNetVar("wandererCovenantName")
    local covenText

    if playerCoven and playerCoven ~= "" and targetCoven and targetCoven ~= "" then
        local textColor = Color(150, 150, 150, 255)

        if playerCoven == targetCoven then
            covenText = "A fellow member of the " .. targetCoven .. "."
            textColor = Color(0, 255, 0, 255)
        else
            covenText = "A member of the " .. targetCoven .. "."
        end

        if covenText then
            return Clockwork.kernel:DrawInfo(Clockwork.kernel:ParseData(covenText), x, y, textColor, alpha)
        end
    end
end, HOOK_LOW)

-- Retrieve data and update the covenant panel data / open a panel
netstream.Hook("UpdatePlayerConveantsMainDerma", function(data)
    local covName = data["name"]
    local covPlayers = data["players"]
    local covStats = data["stats"]
    local covBeliefs = data["beliefs"]
    local covConfig = data["config"]
    local covTypes = data["types"]
    local openMenu = data["openMenu"]

    if not openMenu then
        cwWandererCovenants:UpdateCovenantPanelData(covPlayers, covName, covStats, covBeliefs, covConfig, covTypes)
    else
        cwWandererCovenants:CreateWandererConveantsPanel(covPlayers, covName, covStats, covBeliefs, covConfig, covTypes)
    end
end)

-- Retrieve data indicating accept invite menu was opened
netstream.Hook("CoventantAcceptInviteKeyInteraction", function(data)
    cwWandererCovenants:CreateWandererInviteAcceptPanel()
end)

-- Retrieve data indicating the rank menu was opened 
netstream.Hook("OpenCovenantRankDerma", function(data)
    local covName = data[1]
    local covConfig = data[2]

    cwWandererCovenants:CreateRankPermissionsPanel(covName, covConfig)
end)

-- Joined a covenant / loaded one, loads color variable locally 
netstream.Hook("CovenantLoaded", function(color)
    cwWandererCovenants.colorOutline = Color(color.r, color.g, color.b)
end)

-- Retrieve data indicating the rank menu was opened 
netstream.Hook("OpenCovenantBeliefDerma", function(data)
    local covName = data[1]
    local covConfig = data[2]
    local covStats = data[3]
    local covBeliefs = data[4]

    cwWandererCovenants:CreateCovBeliefPanel(covName, covConfig, covStats, covBeliefs)
end)

function cwWandererCovenants:GetProgressBarInfoAction(action, percentage)
    if (action == "creating_covenant") then
        return {text = "You set the catalysts down in front of you and close your eyes, thinking of your covenant's future.", percentage = percentage, flash = percentage < 10};
    elseif (action == "inviting_covenant") then
        return {text = "You partake in the covenant initiation ritual.", percentage = percentage, flash = percentage < 10};
    end
end

-- Determine friendlies in duels and prepare to draw outlines on them
function cwWandererCovenants:AddEntityOutlines(outlines)
	local playerCovName = Clockwork.Client:GetNetVar("wandererCovenantName")
	
    local playerCount = _player.GetCount()
    local players = _player.GetAll()
    local localPlayer = Clockwork.Client

    for i = 1, playerCount do
        local v = players[i]
        
        if v ~= localPlayer then
            local vCovName = v:GetNetVar("wandererCovenantName")
            local distance = localPlayer:GetPos():Distance(v:GetPos()) -- Calculate the distance between players
        
            if vCovName and vCovName == playerCovName and distance <= 500 then
                local color = localPlayer:GetNetVar("wandererCovenantColor")
                self:DrawPlayerOutline(v, outlines, self.colorOutline)
            end
        end
    end
end


-- Handles the outline drawing logic
function cwWandererCovenants:DrawPlayerOutline(player, outlines, color)
	local moveType = player:GetMoveType();

	if (moveType == MOVETYPE_WALK or moveType == MOVETYPE_LADDER) then
		outlines:Add(player, color, 2, true);
		
		if IsValid(player.clothesEnt) then
			outlines:Add(player.clothesEnt, color, 2, true);
		end
	elseif player:IsRagdolled() then
		local ragdollEntity = player:GetRagdollEntity();
		
		if IsValid(ragdollEntity) then
			outlines:Add(ragdollEntity, color, 2, true);
			
			if IsValid(ragdollEntity.clothesEnt) then
				outlines:Add(ragdollEntity.clothesEnt, color, 2, true);
			end
		end
	end;
end;
