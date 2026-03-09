--[[
	Begotten III: Jesus Wept
	By: DETrooper, cash wednesday, gabs, alyousha35

	Other credits: kurozael, Alex Grist, Mr. Meow, zigbomb
--]]

local FACTION = Clockwork.faction:New("Order of Eternal Penance");
	FACTION.whitelist = true;
	FACTION.useFullName = false;
	FACTION.disabled = false; -- For events.
	FACTION.hidden = false;
	FACTION.material = "begotten/faction/faction_logo_gatekeepers_adyssa";
	FACTION.color = Color(225, 175, 0);
	FACTION.description = "The remnants of the Order of Eternal Penance . \nA once expansive and highly elite order of knights dedicated to the sacrifice of the Light. There now exists a brief window for the order to find glory in their final sacrifice. \nFor this world is a rotting prison in which can only be cleansed in the lives of the men of Sol.";
	FACTION.availablefaiths = {"Faith of the Light"};
	FACTION.singleGender = GENDER_MALE;
	FACTION.characterLimit = 1; -- # of characters of this faction a player can have.
	FACTION.names = "glazic";
	--FACTION.imposters = true;
	
	-- Called when a player is transferred to the faction.
	function FACTION:OnTransferred(player, faction, name)
		if (faction.name != "Wanderer" and faction.name != "Holy Hierarchy") then
			return false;
		end;
		
		if (!Clockwork.player:IsWhitelisted(player, faction.name)) then
			Clockwork.player:SetWhitelisted(player, faction.name, true);
		end;
	end;
FACTION_PENANCE = FACTION:Register();