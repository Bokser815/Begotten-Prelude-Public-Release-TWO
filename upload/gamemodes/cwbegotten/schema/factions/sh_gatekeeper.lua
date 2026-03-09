--[[
	Begotten III: Jesus Wept
	By: DETrooper, cash wednesday, gabs, alyousha35

	Other credits: kurozael, Alex Grist, Mr. Meow, zigbomb
--]]

local FACTION = Clockwork.faction:New("Gatekeeper");
	FACTION.disabled = false; -- For events.
	FACTION.whitelist = true;
	FACTION.useFullName = false;
	FACTION.material = "begotten/faction/faction_logo_gatekeepers";
	FACTION.color = Color(80, 100, 120);
	FACTION.description = "The Gatekeepers are the front line of defence against the countless unholy horrors that threaten the Glaze. \nTheir ranks swell with conscripted power-hungry commoners and fanatical flagellants. \nThey must serve the Holy Hierarchy diligently and without question, no matter how outrageous their demands may be. \nIll-trained and poorly equipped, these soldiers are expected to lay their lives down to protect the Light. \nAnd so they shall.";
	FACTION.availablefaiths = {"Faith of the Light"};
	FACTION.alliedfactions = {"Holy Hierarchy"};
	FACTION.masterfactions = {"Holy Hierarchy"};
	FACTION.enlist = true;
	FACTION.singleGender = GENDER_MALE;
	FACTION.characterLimit = 1; -- # of characters of this faction a player can have.
	FACTION.ratio = 0.3; -- 0.3 slots per player (9 at 30 players).
	--FACTION.imposters = true; -- Kinisgers should get enlisted through /enlist on Wanderer disguises.
	FACTION.names = "glazic";
	FACTION.subfactions = {
		{name = "Legionary", subtitle = "Legionaries - Soldiers of the Church", description = "The Holy Order of the Gatekeepers has defended the Holy Hierarchy from unholy threats since time immemorial. They have seen many changes over the years and vary considerably in strength, equipment, and number from county district to county district, but nonetheless share a singular goal: to protect the Holy Hierarchy at all costs. Legionaries represent the rank and file of this Holy Order and know only the Glaze. These men are a mix of professional soldiers, conscripted wasteland filth, and religious zealots. They serve as frontline troops and guardsmen in service of the Holy Hierarchy, often taking considerable risks to advance their ministers' goals or to defend them.", attributes = {{Color(0, 225, 0), "(+) Constant Drilling: Starts with +15 maximum stamina"}, {Color(0, 225, 0), "(+) Nourishing Rations: Starts with +25 maximum health"}, {Color(0, 225, 0), "(+) Starts at Sacrament Level 6"}, {Color(0, 225, 0), "(+) Strength in Numbers: +100% faith gain from dealing damage"}, {Color(225, 0, 0), "(-) The 'Voltism' subfaith is locked"}}},
		{name = "Auxiliary", subtitle = "Auxilium - Smiths and Medici", description = "The backbone of the Holy Order and the purveyors of its superior ingenuity, auxiliaries uphold supply, maintain the troops, and act as reservists in combat. As Smiths they arm the ranks with superior weaponry, man the cannons and fortify defensive locations. As Medici they prevent outbreaks in the ranks and mend injuries taken from battle. They are still expected to fight if need be, though are not as often put into harm's way as their legionary kin.", attributes = {{Color(0, 225, 0), "(+) Men of Knowledge: +25% increased faith gain"}, {Color(0, 225, 0), "(+) Starts at Sacrament Level 12"}, {Color(225, 0, 0), "(-) Tier IV of the Prowess belief tree is locked"}, {Color(225, 0, 0), "(-) The 'Voltism' subfaith is locked"}}},
		{name = "Praeventor", startingRank = 12, whitelist = true, subtitle = "Praeventores - Scouts and Assassins", description = "Taking the name of a similar unit from ancient Roman times, the Praeventores serve as a small but elite cadre of scouts, hunters, and assassins for the Holy Order. Recruited from the most loyal and skilled followers of Hard-Glaze, the Praeventores lack any standardized gear to help them blend in whilst performing their duties in the wastes. These duties include: reporting on enemy movements, scavenging valuable artifacts or needed supplies, assassinating enemies of the Holy Hierarchy or sniping targets at long range, bringing in or dispatching the targets of bounties, and gathering information.", attributes = {{Color(0, 225, 0), "(+) Excursionists: -25% stamina drain and +5% sprint speed"}, {Color(0, 225, 0), "(+) Masters of Disguise: Recognising does not reveal your rank"}, {Color(0, 225, 0), "(+) Starts at Sacrament Level 8"}, {Color(225, 0, 0), "(-) The 'Sol Orthodoxy' and 'Voltism' subfaiths are locked"}}},
	};
	FACTION.residualXPZones = { -- Zones that boost residual XP gain for this faction.
		["rp_begotten3"] = {
			{pos1 = Vector(1390, 10153, -938), pos2 = Vector(-2370, 11254, -1690), modifier = 2, nightModifier = 4}, -- Gate
			{pos1 = Vector(9422, 11862, -1210), pos2 = Vector(10055, 10389, -770), modifier = 3, nightModifier = 5}, -- Gorewatch
			{pos1 = Vector(3458, 12655 -814), pos2 = Vector(3335, 12769, -685), modifier = 2, nightModifier = 4}, -- Watchtower
			{pos1 = Vector(2742, 10244, -1194), pos2 = Vector(2913, 10071, -1074), modifier = 2, nightModifier = 4}, -- Watchtower
			{pos1 = Vector(-1963, 10678, -1055), pos2 = Vector(-2144, 10886, -1194), modifier = 2, nightModifier = 4}, -- Watchtower
			{pos1 = Vector(-3468, 12985, -375), pos2 = Vector(-3591, 13103, -241), modifier = 2, nightModifier = 4}, -- Watchtower
		},
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
		
		if (!Clockwork.player:IsWhitelisted(player, "Gatekeeper")) then
			Clockwork.player:SetWhitelisted(player, "Gatekeeper", true);
		end;
	end;
	
	if !Schema.Ranks then
		Schema.Ranks = {};
	end
	
	if !Schema.RankTiers then
		Schema.RankTiers = {};
	end
	
	if !Schema.RanksRestrictedWages then
		Schema.RanksRestrictedWages = {};
	end
	
	if !Schema.RanksToSubfaction then
		Schema.RanksToSubfaction = {};
	end
	
	if !Schema.RanksToCoin then
		Schema.RanksToCoin = {};
	end
	
	Schema.Ranks["Gatekeeper"] = {
		[1] = "Disciple",
		[2] = "Acolyte",
		[3] = "Artificer",
		[4] = "Forgemaster",
		[5] = "Medicus",
		[6] = "Master Medicus",
		[7] = "Emissary",
		[8] = "Vexillifer",
		[9] = "Squire",
		[10] = "High Gatekeeper",
		[11] = "Master-At-Arms",
		[12] = "Scout",
		[13] = "Master Scout",
		[14] = "Acolyte-Evocatus",
	};
	
	Schema.RankTiers["Gatekeeper"] = {
		[1] = {"Disciple"},
		[2] = {"Acolyte", "Acolyte-Evocatus", "Artificer", "Medicus", "Scout"},
		[3] = {"Emissary", "Forgemaster", "Master Medicus", "Master Scout", "Vexillifer", "Squire"},
		[4] = {"High Gatekeeper"},
		[5] = {"Master-At-Arms"},
	};
	
	-- Do not grant wages to these ranks if they are inside the safezone.
	Schema.RanksRestrictedWages["Gatekeeper"] = {1, 2, 12, 13, 14};
	
	Schema.RanksToSubfaction["Gatekeeper"] = {
		["Artificer"] = "Auxiliary",
		["Forgemaster"] = "Auxiliary",
		["Medicus"] = "Auxiliary",
		["Master Medicus"] = "Auxiliary",
		["Scout"] = "Praeventor",
		["Master Scout"] = "Praeventor",
	};
	
	Schema.RanksToCoin["Gatekeeper"] = {
		[1] = 25,
		[2] = 35,
		[3] = 35,
		[4] = 50,
		[5] = 35,
		[6] = 50,
		[7] = 50,
		[8] = 50,
		[9] = 50,
		[10] = 100,
		[11] = 200, 
		[12] = 35,
		[13] = 50,
		[14] = 50,
	};
FACTION_GATEKEEPER = FACTION:Register();