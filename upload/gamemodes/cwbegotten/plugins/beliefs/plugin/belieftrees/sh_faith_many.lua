--[[
	Begotten 3: Jesus Wept
	written by: cash wednesday, DETrooper, gabs and alyousha35.
--]]

local MANY = cwBeliefs.beliefTrees:New("many")
	MANY.name = "Faith of the Many";
	MANY.color = Color(137, 100, 0);
	MANY.order = 7;
	MANY.size = {w = 771, h = 407};
	MANY.textures = {"many", "faithlightarrows"};
	MANY.headerFontOverride = "nov_IntroTextSmallaaafaa";
	MANY.tooltip = {
		{"Faith of the Many", MANY.color, "Civ5ToolTip4"},
		{"Each faith has a unique skill set, unlocking character abilities, rituals, and generally improving stats overall. One may also branch into subfaiths, though openly practicing these subfaiths may see your character deemed a heretic by the relevant religious authorities.", Color(225, 200, 200)},
		{"\n\"The holy city of Glaze in Hell's domain. These are my dual swords to be crossed, indeed over her chest in resolution to a final cause. In a beating heart of shields.\"", Color(128, 90, 90, 240)},
		{"", Color(50, 255, 50)}
	};
	MANY.columnPositions = {
		[1] = (MANY.size.w - 4) * 0.133,
		[2] = (MANY.size.w - 4) * 0.2,
		[3] = (MANY.size.w - 4) * 0.266,
		[4] = (MANY.size.w - 4) * 0.433,
		[5] = (MANY.size.w - 4) * 0.5,
		[6] = (MANY.size.w - 4) * 0.566,
		[7] = (MANY.size.w - 4) * 0.733,
		[8] = (MANY.size.w - 4) * 0.8,
		[9] = (MANY.size.w - 4) * 0.866,
	};
	MANY.rowPositions = {
		[1] = (MANY.size.h - 4) * 0.3,
		[2] = (MANY.size.h - 4) * 0.5,
		[3] = (MANY.size.h - 4) * 0.7,
		[4] = (MANY.size.h - 4) * 0.9,
	};
	
	MANY.lockedSubfactions = {"Clan Grock"};
	MANY.requiredFaiths = {"Faith of the Many"};
	
	-- First index is column.
	MANY.beliefs = {
		[1] = {
			["libertines_ritual1"] = {
				name = "Sound of Gold",
				subfaith = "The Libertines",
				description = "Unlocks Tier I 'Faith of the Many' Rituals. Unlocks the ability to dual-wield one handed weapons.",
				lockedFactions = {"Pope Adyssa's Gatekeepers", "Holy Hierarchy"},
				lockedSubfactions = {"Praeventor"},
				requirements = {"the_libertines"},
				row = 2,
			},
			["libertines_ritual2"] = {
				name = "Rhythm of Body",
				subfaith = "The Libertines",
				description = "Unlocks Tier II 'Faith of the Many' Rituals. Gain double faith gain from damaging and killing those wealthier then you.",
				lockedFactions = {"Pope Adyssa's Gatekeepers", "Holy Hierarchy"},
				lockedSubfactions = {"Praeventor"},
				requirements = {"the_libertines", "libertines_ritual1"},
				row = 3,
			},
			["libertines_ritual3"] = {
				name = "Ample Showing",
				subfaith = "The Libertines",
				description = "Unlocks Tier III 'Faith of the Many' Rituals and unique Libertine Rituals. Gain double faith gain from damaging and killing those of the other gender.",
				lockedFactions = {"Pope Adyssa's Gatekeepers", "Holy Hierarchy"},
				lockedSubfactions = {"Praeventor"},
				requirements = {"the_libertines", "libertines_ritual1", "libertines_ritual2"},
				row = 4,
			},
		},
		[2] = {
			["the_libertines"] = {
				name = "Humor of the Libertines",
				subfaith = "The Libertines",
				description = "Selects 'The Libertines' as your subfaith. Unlocks the ability to pray. Increased residual faith gain scaled by wealth.",
				quote = "The Libertines are the most hedonist, spendthrift, and indulgent of all Darklandic gods. It is said that Glazic life is the way of alms, charity, and obedience to thy ministry, but this is perhaps most contrary in Darklandic sects that preach the totems of the Libertines. Indeed, they live life as debauched and decadent as one could even aspire to be, for a life is wasted if it cannot experience this world's earthly pleasures, is it not? In secret, it is rumored that this sin is the driving force of the Darklandic empire, and without it, it assuredly could not exist. In a Libertine temple, coin is passed as fast as bodies are.",
				lockedFactions = {"Pope Adyssa's Gatekeepers", "Holy Hierarchy"},
				lockedSubfactions = {"Praeventor"},
				row = 1,
			},
		},
		[3] = {
			["libertines_belief1"] = {
				name = "Earthly Desires",
				subfaith = "The Libertines",
				description = "You will now deal 10% more damage with all melee weapons to characters with less coin then you.",
				quote = "The pauper seeks not charity, but to usurp those cap-a-pie in exotic furs.",
				lockedFactions = {"Pope Adyssa's Gatekeepers", "Holy Hierarchy"},
				lockedSubfactions = {"Praeventor"},
				requirements = {"the_libertines"},
				row = 2,
			},
			["libertines_belief2"] = {
				name = "Love thy Brother",
				subfaith = "The Libertines",
				description = "Unlocks the ability to warcry. Slashing and piercing attacks have a chance of inflicting infections on enemies. Diseases will no longer affect you.",
				quote = "\"O ho! Oooo! Such fun! I collect your juices like so and stain my blade with it for your want.\"",
				lockedFactions = {"Pope Adyssa's Gatekeepers", "Holy Hierarchy"},
				lockedSubfactions = {"Praeventor"},
				requirements = {"the_libertines", "libertines_belief1"},
				row = 3,
			},
			["libertines_belief3"] = {
				name = "Sensualist",
				subfaith = "The Libertines",
				description = "Deal 15% more damage to those of the other gender. Upgrades the 'Warcry' ability: all nearby foes will be highlighted in white for 10 seconds and will have higher chances of obtaining injuries and contracting infections from your attacks. Diseases will now double your passive stamina regeneration rate.",
				quote = "Recant those terrible shrieks of the savage. \"AYEAYAYAYAH-YAH!\" How long they hollered for!",
				lockedFactions = {"Pope Adyssa's Gatekeepers", "Holy Hierarchy"},
				lockedSubfactions = {"Praeventor"},
				requirements = {"the_libertines", "libertines_belief1", "libertines_belief2"},
				row = 4,
			},
		},
		[4] = {
			["vultures_ritual1"] = {
				name = "Disembowelment",
				subfaith = "The Vultures",
				description = "Unlocks Tier I 'Faith of the Many' Rituals. Unlocks the ability to commit suicide. Unlocks the ability to dual-wield one-handed weapons.",
				quote = "Self-disembowelment is considered a holy Darklandic rite. For the brave, it presents them a new life, for assuredly the noble will feast upon them.",
				requirements = {"the_vultures"},
				row = 2,
			},
			["vultures_ritual2"] = {
				name = "Sacred Organs",
				subfaith = "The Vultures",
				description = "Unlocks Tier II 'Faith of the Many' Rituals.",
				requirements = {"the_vultures", "vultures_ritual1"},
				row = 3,
			},
			["vultures_ritual3"] = {
				name = "Message of the Haruspex",
				subfaith = "The Vultures",
				description = "Unlocks Tier III 'Faith of the Many' Rituals and unique Vulture Rituals. Unlocks the ability to harvest more meat from corpses.",
				quote = "\"Hark! Thy divining, thy truth is revealed. My sheep holy and its innards crimson.\"",
				requirements = {"the_vultures", "vultures_ritual1", "vultures_ritual2"},
				row = 4,
			},
		},
		[5] = {
			["the_vultures"] = {
				name = "Hunger of the Vultures",
				subfaith = "The Vultures",
				description = "Selects 'The Vultures' as your subfaith. Unlocks the ability to pray. Gain triple faith gain from executing those in critical condition.",
				quote = "The Vultures are the many different Darklandic gods who's expression of worship is the consumption, slaughter, and mutilation of one's fellow man. It is said that truth can be found from another's innards, and such truth is wise. The Vulture signifies culling, death, and the cycle of rebirth, where to consume another is to reincarnate them anew. To this end, the cycle of death and life is a wheel, and their swords must turn it.",
				row = 1,
			},
		},
		[6] = {
			["vultures_belief1"] = {
				name = "Manhunter",
				subfaith = "The Vultures",
				description = "All slashing melee weapons inflict 15% more damage. Human flesh of any variety restores more hunger and thirst.",
				quote = "A valley of blackness where not even Sol's light dare grace it. Heads on sharpened pikes and bodies cut for the butcher.",
				requirements = {"the_vultures"},
				row = 2,
			},
			["vultures_belief2"] = {
				name = "Stripped Flesh",
				subfaith = "The Vultures",
				description = "One fourth of damage dealt will return as health and thirst. Bleeding characters close to you will be highlighted. Sanity now depletes 15% faster.",
				quote = "The cannibals of the Darklands rejoice when blood is spilt. Tales are told of entire rivers flowing with the tasty drink indeed.",
				requirements = {"the_vultures", "vultures_belief1"},
				row = 3,
			},
			["vultures_belief3"] = {
				name = "Pale Faces",
				subfaith = "The Vultures",
				description = "You now deal 2.5% more damage against characters for each bleeding limb they have. Lifeleech will now return one third of damage as health and thirst. Sanity now depletes 25% faster.",
				quote = "\"For it is said the Pale Face strikes fear into all.\"",
				requirements = {"the_vultures", "vultures_belief1", "vultures_belief2"},
				row = 4,
			},
		},
		[7] = {
			["sows_ritual1"] = {
				name = "Feed the Sow",
				subfaith = "The Sows",
				description = "Unlocks Tier I 'Faith of the Many' Rituals.",
				quote = "The hoghand cast the feed into the pens. In time, he grew old, and when he had tumbled into the pens, the herd had picked him clean.",
				lockedFactions = {"Pope Adyssa's Gatekeepers", "Gatekeeper", "Holy Hierarchy"},
				lockedSubfactions = {"Machinist"};
				requirements = {"the_sows"},
				iconOverride = "begotten/ui/belieficons/thepig.png",
				row = 2,
			},
			["sows_ritual2"] = {
				name = "Offspring for Slaughter",
				subfaith = "The Sows",
				description = "Unlocks Tier II 'Faith of the Many' Rituals. Increased faith gain from corpse mutilation.",
				lockedFactions = {"Pope Adyssa's Gatekeepers", "Gatekeeper", "Holy Hierarchy"},
				lockedSubfactions = {"Machinist"};
				requirements = {"the_sows", "sows_ritual1"},
				iconOverride = "begotten/ui/belieficons/offspringforslaughter.png",
				row = 3,
			},
			["sows_ritual3"] = {
				name = "Animal Memory",
				subfaith = "The Sows",
				description = "Unlocks Tier III 'Faith of the Many' Rituals and unique Sows rituals. Unlocks the 'Overfeeding' mechanic where you will be able to eat to 200% hunger and increase health regeneration alongside gaining a point of health per additional percent until hitting 100% hunger, albeit increasing your chance of getting stomach injuries and decreasing your movement speed til the point where you will be unable to sprint, albeit still walk at 200% hunger. Increased faith gain from cooking food and higher faith gain from consuming food.",
				quote = "What the pigs know float in their blood.",
				lockedFactions = {"Pope Adyssa's Gatekeepers", "Gatekeeper", "Holy Hierarchy"},
				lockedSubfactions = {"Machinist"};
				requirements = {"the_sows", "sows_ritual1", "sows_ritual2"},
				iconOverride = "begotten/ui/belieficons/animal_memory.png",
				row = 4,
			},
		},
		[8] = {
			["the_sows"] = {
				name = "Herd of the Sows",
				subfaith = "The Sows",
				description = "Selects 'The Sows' as your subfaith. Unlocks the ability to pray. Gain increased faith gain from eating consumables.",
				quote = "The Sows are those devourers, glutton, and plump of the Darklandic pantheon. More accurately, the Sows represent themselves to their followers as assorted swine and boar, who blesses their worshippers with showers of meal and the belly of a hog. The Sows believe that men are animals at heart, and so they must guide themselves off the Darklandic holy animal: the hog. Indulgence in all sorts of delights and treats is common among the worship of the Sows, as the fat are more likely to nurture offspring whether through mother's milk or offering a pound of flesh to their children. Those entrenched in the piety of the Sow are less man then they are mutant: carnivorous giants who squeal in delight and fervor as they get to take delicious bites of man-flesh.",
				lockedFactions = {"Pope Adyssa's Gatekeepers", "Gatekeeper", "Holy Hierarchy"},
				lockedSubfactions = {"Machinist"};
				row = 1,
			},
		},
		[9] = {
			["sows_belief1"] = {
				name = "Little Piggy",
				subfaith = "The Sows",
				description = "Enemies with 75% hunger or less will take 10% more damage from you. Your fat rolls give you +10 more health. Increases stamina resistance of all two-handed weapons and great weapons by 20%.",
				lockedFactions = {"Pope Adyssa's Gatekeepers", "Gatekeeper", "Holy Hierarchy"},
				lockedSubfactions = {"Machinist"};
				requirements = {"the_sows"},
				iconOverride = "begotten/ui/belieficons/littlepiggy.png",
				row = 2,
			},
			["sows_belief2"] = {
				name = "Mother of All Pigs",
				subfaith = "The Sows",
				description = "Unlocks the ability to warcry to reduce enemy hunger by 15% at the cost of 10% of your own. Your fat rolls give you +20 more health. Increases maximum stability by +25. At this point your height will scale with your sacrament level, with a cap of 15% increased scale at max sacrament.",
				quote = "\"I offer you my pound of flesh! Take a bite!\"",
				lockedFactions = {"Pope Adyssa's Gatekeepers", "Gatekeeper", "Holy Hierarchy"},
				lockedSubfactions = {"Machinist"};
				requirements = {"the_sows", "sows_belief1"},
				iconOverride = "begotten/ui/belieficons/mother_of_all_pigs.png",
				row = 3,
			},
			["sows_belief3"] = {
				name = "Roar of the Boar",
				subfaith = "The Sows",
				description = "Upgrades the Warcry ability: all nearby foes with less then 75% hunger will be highlighted in white for 10 seconds. Alongside that, for thirty seconds any damage you deal is returned to your stability. At this point, your warcry will sound like a boar's. Your fat rolls also cushion your armor, increasing your armor protection values by 15% at the detriment of reducing your sprint speed by 15%. Your hunger and thirst will drain twice as quickly.",
				quote = "\"Squeal like a motherfucking pig!\"",
				lockedFactions = {"Pope Adyssa's Gatekeepers", "Gatekeeper", "Holy Hierarchy"},
				lockedSubfactions = {"Machinist"};
				requirements = {"the_sows", "sows_belief1", "sows_belief2"},
				iconOverride = "begotten/ui/belieficons/roar_of_the_boar.png",
				row = 4,
			},
		},
	};
cwBeliefs.beliefTrees:Register(MANY)
-- todo: change all this shit to it's proper stuff.