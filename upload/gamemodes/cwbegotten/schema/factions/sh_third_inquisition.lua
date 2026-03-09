--[[
	Begotten III: Jesus Wept
	By: DETrooper, cash wednesday, gabs, alyousha35

	Other credits: kurozael, Alex Grist, Mr. Meow, zigbomb
--]]

local FACTION = Clockwork.faction:New("The Third Inquisition");
	FACTION.whitelist = true;
	FACTION.useFullName = false;
	FACTION.disabled = true; -- For events.
	FACTION.hidden = true;
	FACTION.material = "begotten/faction/faction_logo_gatekeepers_adyssa";
	FACTION.color = Color(225, 175, 0);
	FACTION.description = "From the ashes of the Town of Light comes a third Inquisition, loyal in memoriam to Pope Adyssa. \nTheir goal is to unseat the false pope Aratakrast and put an end to his court's decadence. \nThey seek to civilize the County Districts through holy powder and steel, and thus fight on. \nYet, it is unlikely that this junior insurrection will succeed against the raging inferno of barbarism and apocalypse.";
	FACTION.availablefaiths = {"Faith of the Light"};
	FACTION.singleGender = GENDER_MALE;
	FACTION.characterLimit = 1; -- # of characters of this faction a player can have.
	FACTION.names = "glazic";
	FACTION.imposters = true;
	
	-- Called when a player is transferred to the faction.
	function FACTION:OnTransferred(player, faction, name)
		if (faction.name != "Wanderer" and faction.name != "Holy Hierarchy" and faction.name != "Gatekeeper") then
			return false;
		end;
		
		if player:GetFaith() ~= "Faith of the Light" or player:GetSubfaith() == "Voltism" then
			return false;
		end
		
		if (!Clockwork.player:IsWhitelisted(player, faction.name)) then
			Clockwork.player:SetWhitelisted(player, faction.name, true);
		end;
	end;
FACTION_THIRD_INQUISITION = FACTION:Register();