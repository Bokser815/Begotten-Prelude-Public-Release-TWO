--[[
	Begotten III: Jesus Wept
	By: DETrooper, cash wednesday, gabs, alyousha35

	Other credits: kurozael, Alex Grist, Mr. Meow, zigbomb
--]]

local FACTION = Clockwork.faction:New("Wanderer");
	FACTION.disabled = false; -- For events.
	FACTION.useFullName = false;
	FACTION.material = "begotten/faction/faction_logo_wanderers";
	FACTION.color = Color(160, 100, 15);
	FACTION.description = "The Wanderers are the carrion carcass eaters of the Wasteland. \nThey were the many lowly commoners of the County Districts, barely literate and ill-fed. \nTo survive as a Wanderer, one must be sharp and brutal, and choose their allegiance carefully. \nTheir weapons are their faith and fear, and their strife will be everlasting.";
	FACTION.availablefaiths = {"Faith of the Light", "Faith of the Family", "Faith of the Dark"};
	FACTION.subfactionsToAvailableFaiths = {["Darklander"] = {"Faith of the Dark", "Faith of the Many"}}
	FACTION.imposters = true;
	FACTION.names = "glazic";

	local darklanderModels = {
		male = {
			clothes = "models/begotten/goreicwarfighters/haralderchainmail_male.mdl",
			heads = {
				"male_01",
				"male_03",
				"male_05",
				"male_13",
				"male_16",
				"male_22",
				"male_56",
			},
		},
		female = {
			clothes = "models/begotten/goreicwarfighters/haralderchainmail_female.mdl",
			heads = {
				"female_04",
				"female_32",
			}
		}
	};

	local pilgrimModels = {
		male = {
			clothes = "models/begotten/wanderers/wanderer_male.mdl",
			heads = {
				"male_01",
				"male_02",
				"male_03",
				"male_04",
				"male_05",
				"male_06",
				"male_07",
				"male_08",
				"male_09",
				"male_11",
				"male_12",
				"male_13",
				"male_16",
				"male_22",
				"male_56"
			},
		},
		female = {
			clothes = "models/begotten/wanderers/wanderer_female.mdl",
			heads = {
				"female_01",
				"female_02",
				"female_04",
				"female_05",
				"female_06",
				"female_32",
			},
		}

	}

	FACTION.subfactions = {
		{name = "Pilgrim",
		subtitle = "Serfs of the Districts",
		description = "epic exposition about the pilgrims/southlanders",
		models = pilgrimModels,
		attributes = {{Color(255, 225, 0), "(~) Devout: Can only pick the 'Light' or 'Family' or 'Dark' faiths"},}},

		{name = "Darklander", 
		namesOverride = "darklandic",
		subtitle = "Sinners of the Darklands",
		description = "epic exposition about the darklanders",
		models = darklanderModels,
		attributes = {{Color(255, 225, 0), "(~) Hedonist: Can only pick the 'Dark' or 'Many' faiths"},}},
	};
	
	-- Called when a player is transferred to the faction.
	function FACTION:OnTransferred(player, faction, name)
		if (faction.name == "Goreic Warrior") then
			return false;
		end;
	end;
FACTION_WANDERER = FACTION:Register();
