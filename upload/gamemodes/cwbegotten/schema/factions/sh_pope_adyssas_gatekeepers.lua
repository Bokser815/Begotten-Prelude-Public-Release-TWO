--[[
	Begotten III: Jesus Wept
	By: DETrooper, cash wednesday, gabs, alyousha35

	Other credits: kurozael, Alex Grist, Mr. Meow, zigbomb
--]]

local FACTION = Clockwork.faction:New("Pope Adyssa's Gatekeepers");
	FACTION.hidden = true;
	FACTION.disabled = true; -- For events.
	FACTION.whitelist = true;
	FACTION.useFullName = false;
	FACTION.material = "begotten/faction/faction_logo_gatekeepers_adyssa";
	FACTION.color = Color(20, 20, 20);
	FACTION.description = "The Gatekeepers are the front line of defence against the countless unholy horrors that threaten the Glaze. \nTheir ranks swell with conscripted power-hungry commoners and fanatical flagellants. \nThey must serve the Holy Hierarchy diligently and without question, no matter how outrageous their demands may be. \nIll-trained and poorly equipped, these soldiers are expected to lay their lives down to protect the Light. \nAnd so they shall.";
	FACTION.availablefaiths = {"Faith of the Light"};
	FACTION.singleGender = GENDER_MALE;
	FACTION.characterLimit = 1; -- # of characters of this faction a player can have.
	FACTION.ratio = 0.3; -- 0.3 slots per player (9 at 30 players).
	--FACTION.imposters = true;
	
	if !Schema.Ranks then
		Schema.Ranks = {};
	end
	
	if !Schema.RankTiers then
		Schema.RankTiers = {};
	end
	
	if !Schema.RanksToSubfaction then
		Schema.RanksToSubfaction = {};
	end
	
	if !Schema.RanksToCoin then
		Schema.RanksToCoin = {};
	end
	
	Schema.Ranks["Pope Adyssa's Gatekeepers"] = {
		[1] = "DISCIPLE",
		[2] = "ACOLYTE",
		[3] = "EMISSARY",
		[4] = "HIGH-EMISSARY",
		[5] = "MASTER-AT-ARMS",
	};
	
	Schema.RankTiers["Pope Adyssa's Gatekeepers"] = {
		[1] = {"DISCIPLE"},
		[2] = {"ACOLYTE"},
		[3] = {"EMISSARY"},
		[4] = {"HIGH-EMISSARY"},
		[5] = {"MASTER-AT-ARMS"},
	};

	Schema.RanksToCoin["Pope Adyssa's Gatekeepers"] = {
		[1] = 25,
		[2] = 35,
		[3] = 50,
		[4] = 100,
		[5] = 200, 
	};
	
	-- Called when a player is transferred to the faction.
	function FACTION:OnTransferred(player, faction, name)
		if (faction.name != "Wanderer" and faction.name != "Holy Hierarchy") then
			if player:GetSubfaction() ~= "Kinisger" then
				return false;
			end
		end;
		
		-- It is the IC responsibility of Gatekeepers to bloodtest recruits.
		--[[if player:GetFaith() ~= "Faith of the Light" or player:GetSubfaith() == "Voltism" then
			return false;
		end]]--
		
		if (!Clockwork.player:IsWhitelisted(player, faction.name)) then
			Clockwork.player:SetWhitelisted(player, faction.name, true);
		end;
	end;
	
	-- Called when a player's name should be assigned for the faction.
	function FACTION:GetNameCharCreation(name, rank, rankOverride)
		if !rank then
			return "GATEKEEPER-DISCIPLE."..name;
		end

		if rankOverride then
			return "GATEKEEPER-"..rankOverride.."."..name;
		end

		return "GATEKEEPER-"..Schema.Ranks["Pope Adyssa's Gatekeepers"][rank or 1].."."..name;
	end;
	
	-- Called when a player's name should be assigned for the faction.
	function FACTION:GetName(player, bNew)
		if bNew or !player:GetCharacterData("rank") then
			return Clockwork.kernel:ZeroNumberToDigits(math.random(1, 99999), 5);
		end
	
		local name = player:Name();
		local rankOverride = player:GetCharacterData("rankOverride");
		
		if !tonumber(name) then
			Clockwork.player:SetName(player, Clockwork.kernel:ZeroNumberToDigits(math.random(1, 99999), 5));
			name = player:Name();
		end

		if rankOverride then
			return "GATEKEEPER-"..rankOverride.."."..name;
		end
		
		local rank = math.Clamp(player:GetCharacterData("rank", 1), 1, #Schema.Ranks["Pope Adyssa's Gatekeepers"]);

		if (rank and isnumber(rank) and Schema.Ranks["Pope Adyssa's Gatekeepers"][rank]) then
			return "GATEKEEPER-"..Schema.Ranks["Pope Adyssa's Gatekeepers"][rank].."."..name;
		end;
	end;
FACTION_GATEKEEPER_ADYSSA = FACTION:Register();