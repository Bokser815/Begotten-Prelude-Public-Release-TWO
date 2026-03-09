--[[
	Begotten 3: Jesus Wept
	written by: cash wednesday, DETrooper, gabs and alyousha35.
--]]

local OLDWAYS = cwBeliefs.beliefTrees:New("Old Ways")
	OLDWAYS.name = "Old Ways";
	OLDWAYS.color = Color(163, 153, 143, 255);
	OLDWAYS.order = 7;
	OLDWAYS.size = {w = 771, h = 407};
	OLDWAYS.textures = {"oldways", "faithfamilyarrows"};
	OLDWAYS.headerFontOverride = "nov_IntroTextSmallaaafaa";
	OLDWAYS.tooltip = {
		{"The Old Ways", OLDWAYS.color, "Civ5ToolTip4"},
		{"Faith has dominated the minds of men long enough. Destroy those who cower under it.", Color(163, 153, 143, 255)},
	};
	OLDWAYS.columnPositions = {
		[1] = (OLDWAYS.size.w - 4) * 0.3,
		[2] = (OLDWAYS.size.w - 4) * 0.5,
		[3] = (OLDWAYS.size.w - 4) * 0.7,
	};
	OLDWAYS.rowPositions = {
		[1] = (OLDWAYS.size.h - 4) * 0.3,
		[2] = (OLDWAYS.size.h - 4) * 0.5,
		[3] = (OLDWAYS.size.h - 4) * 0.7,
	};
	
	OLDWAYS.lockedSubfactions = {};
	OLDWAYS.requiredFaiths = {"Old Ways"};
	
	-- First index is column.
	OLDWAYS.beliefs = {
		[1] = {
			["shrewdgrock"] = {
				name = "Path of the Shrewd",
				subfaith = "Path of the Shrewd",
				description = "Selects the 'Grock Ingenuity' as your path. Increased faith gain from crafting and reduced fatigue from crafting by 50%.",
				quote = "In the ashes of the old world, the wisdom of our ancestors becomes our greatest treasure, for in their enduring truths lie the keys to our survival and the path to a new dawn.",
				requirements = {},
				cost = 200,
				row = 1,
			},
			["adroitgrock"] = {
				name = "Adroit Butcher",
				subfaith = "Path of the Shrewd",
				description = "Unlocks unique Grock crafting recipes. Harvesting animals and humans increases sanity.",
				requirements = {"shrewdgrock"},
				cost = 400,
				row = 2,
			},
			["sagegrock"] = {
				name = "Sagely Wisdom",
				subfaith = "Path of the Shrewd",
				description = "Unlocks crafting of unique Grock armors. Chance to not use materials when crafting or smithing.",
				requirements = {"shrewdgrock","adroitgrock"},
				cost = 600,
				row = 3,
			},
		},
		[2] = {
			["bulwarkgrock"] = {
				name = "Path of the Bulwark",
				subfaith = "Path of the Bulwark",
				description = "Grants +15 stability and poise at the cost of 5% movement speed.",
				quote = "In the face of the scarred wasteland, our strength and resilience are the keystones of our return to timeless wisdom. Through trials untold, we honor the enduring traditions of our forebears, crafting a path where survival is not merely a skill but a testament to our combined unyielding will.",
				requirements = {},
				cost = 200,
				row = 1,
			},
			["nomadicgrock"] = {
				name = "Nomadic Bastion",
				subfaith = "Path of the Bulwark",
				description = "Unlocks the ability to wear superheavy Grock armor. Grants 35% bullet resistance.",
				requirements = {"bulwarkgrock"},
				cost = 400,
				row = 2,
			},
			["brutalgrock"] = {
				name = "Ceaseless Defense",
				subfaith = "Path of the Bulwark",
				description = "Completion of the Brutality tree provides you with a cleansing of negative status effects upon a kill.",
				requirements = {"bulwarkgrock","nomadicgrock"},
				cost = 600,
				row = 3,
			},
		},
		[3] = {
			["bludgeongrock"] = {
				name = "Path of the Bludgeon",
				subfaith = "Path of the Bludgeon",
				description = "Gain faith from breaking the bones of other players and deal 5% more damage. This also unlocks warcrying.",
				quote = "In the aftermath of the maelstrom, we rediscover the ancient ways, not as savagery, but as the primal force that sustains us. Amidst the ruins, our strength is our survival, and our violence is the harsh rhythm of a world reborn.",
				requirements = {},
				cost = 200,
				row = 1,
			},
			["regressiongrock"] = {
				name = "Mark of Regression",
				subfaith = "Path of the Bludgeon",
				description = "Gain a 10 % blunt damage increase. Warcry also now slows you by 10 % but doubles armor durability damage to other players.",
				requirements = {"Path of the Bludgeon"},
				cost = 400,
				row = 2,
			},
			["strengthgrock"] = {
				name = "Ancestral Strength",
				subfaith = "Path of the Bludgeon",
				description = "You now have a 20 % higher chance to break enemies bones with blunt weapons.",
				requirements = {"Path of the Bludgeon","Mark of Regression"},
				cost = 600,
				row = 3,
			},
		},
	};
cwBeliefs.beliefTrees:Register(OLDWAYS)