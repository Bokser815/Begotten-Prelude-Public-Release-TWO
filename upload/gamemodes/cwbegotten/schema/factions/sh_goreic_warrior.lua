local FACTION = Clockwork.faction:New("Goreic Warrior");
	FACTION.disabled = true; -- For events.
	FACTION.whitelist = true;
	FACTION.useFullName = false;
	FACTION.material = "begotten/faction/faction_logo_gores";
	FACTION.color = Color(100, 100, 100);
	FACTION.description = "The brutal spearfolk clansmen of the North, unmatched in their endurance and strength, have come together for the first time. \nAt the heart of their warcamp lies the Great Tree, that which has been scarred by the Holy Hierarchy and must be restored through bloodshed. \nThe Clans must put aside their differences and launch a godly raid upon the last remaining Glazic Lands, to seek vengeance and glory. \nIf their Great Tree suffers another catastrophe, their connection to the Five Gods will be forever cut and all the world will perish. \nFor that reason they must endure ever harder, for there are many more threats abroad than the shattered Hierarchy."
	FACTION.availablefaiths = {"Faith of the Family"};
	FACTION.subfactionsToAvailableFaiths = {["Clan Reaver"] = {"Faith of the Family", "Faith of the Dark"}};
	FACTION.characterLimit = 1; -- # of characters of this faction a player can have.
	FACTION.ratio = 0.2; -- 0.2 slots per player (6 at 30 players).
	FACTION.imposters = true;
	FACTION.hidden = true;
	FACTION.names = "goreic";
	FACTION.subfactions = {
		{name = "Clan Gore", subtitle = "Followers of the Father - Warriors and Hunters", description = "Clan Gore is currently known as the Crown Clan, a title given to the most powerful of all the Clans. Following the Father, Clan Gore was born by bloodshed and conquest. The previous Crown Clan and followers of the Father, Clan Ghorst, had a war chief who made the mistake of fathering a bastard child and leaving it to the wolves to be devoured. The boy was instead raised by these wolves and took on the name Reaper King Kalkaslash. With an army of skinwalkers and werewolves, Kalkaslash butchered his way into his father's long hall, and shred him into a bloody mess with his claws. From then on he seized his throne, and forced the other Clans to kneel with his newly gained army of warrior men. For the next hundred years to follow, Clan Gore would capture women by the thousands and breed new warriors, for they would birth thousands more ruthless killers to continue the process. The Father is harsh and unforgiving, but with his strength empires will fall.", rivalry = "Clan Grock", attributes = {{Color(0, 225, 0), "(+) Starts with +50 maximum health"}, {Color(0, 225, 0), "(+) Skilled Hunters: Deal 50% more damage to animals"}, {Color(0, 225, 0), "(+) Start at Sacrament Level 8"}}}, 
		{name = "Clan Harald", subtitle = "Followers of the Old Son - Sailors and Explorers", description = "Clan Harald is the second oldest Clan belonging to the Goreic peoples, the oldest being Clan Grock. The salt of the sea runs through the blood of these men, and their home is whatever lies beyond. For the past several hundred years Clan Harald has had no true chieftain, ever since it was cursed by the trickster god of The Sister. Any man who calls themselves the Chieftain of the sea, and therefore head of Clan Harald, shall die by drowning. While there is never a head of Clan Harald, there always exists a council of the most experienced (and stubborn) sailors who oversee business. In these current dark times, the Haralders seek to end their curse and become the new Crown Clan, as they feel they were always meant to be. The Haralder sailors will always be at odds with the followers of The Sister, horrible tricksters who create storms that turn their longships into the burning sea. Unknown to all the other Clans, the followers of the Old Son see their deity as a massive beast who lives in the deepest darkest depths of the ocean, and soon they will wake it and watch their entire world submerge underneath the waters, while they thrive above with their mighty sails.", rivalry = "Clan Reaver", attributes = {{Color(0, 225, 0), "(+) Starts with +45 maximum health"}, {Color(0, 225, 0), "(+) Access to greater Longships"}, {Color(0, 225, 0), "(+) Starts at Sacrament Level 6"}}}, 
		{name = "Clan Reaver", startingRank = 7, subtitle = "Followers of the Sister - Slavers and Merchants", description = "The most wealthy of all Clans, the Reavers are the upholders of Goreic society and economy, but are often looked down on by the others. Seen as weak and as tricksters, they are never trusted by the other Clans, and for good reason. The Goreic people are cursed to live in infertile lands, and for that reason they must survive by the raiding of weaker peoples. Yet the Reavers follow The Sister, and they see it as their right to cause misery to others, even when they have no practical reason for it. Their seat is that of the Hall of Tears, a terrifying place somewhere hidden in the woods, where people are suspended on the brink of death for as long as they provide amusement. Instead of meeting their enemies on an open field like their brutish brothers, the Reavers will cast curses upon their foes or even puppeteer entire factions to do their bidding. Some in the South presume that the followers of the Sister may actually be doing the work of the Dark Prince, though the Reavers might even suggest that both gods are one and the same.", rivalry = "Clan Harald", attributes = {{Color(0, 225, 0), "(+) Starts with +25 maximum health"}, {Color(0, 225, 0), "(+) Gain a passive salary of Coins every hour"}, {Color(0, 225, 0), "(+) Gain double the coin from selling slaves"}, {Color(0, 225, 0), "(+) Can choose the Faith of the Dark as a faith"}, {Color(0, 225, 0), "(+) Starts at Sacrament Level 6"}}}, 
		{name = "Clan Shagalax", subtitle = "Followers of the Young Son - Builders and Blacksmiths", description = "It is said that a Shagalaxian is born with steel skin and molten iron flowing in their blood. Without their metal, the bloodthirsty Gores would be throwing sticks and stones instead of their mighty steel. There was a time long ago when the Shagalaxians were considered the mightiest of all Clans and all tribes united under their banner; when their steam belching tanks threw flames across valleys, turning armies and forests into ash. Pathetic arrows plinked off many plates of steel as their legions of tanks rolled over fields of terrified tribes and towns of the Glaze alike. It was only when the weaklings of Clan Crast foresaw Clan Shagalax's dealings with a mechanical Titan-God that their title of Crown Clan was in need of defiance. So it was that when the Undergod entered this world, the Shagalaxians took advantage and began their invasion of the ever-hated Empire of Light with the combined might of the Gore tribes. However, the Shagalaxians soon learned that the Undergod had no allies, and in their greatest moment of weakness their remnants were conquered by the followers of The Father at the behest of Clan Crast. It was then deemed that only The Father and by proxy Clan Gore may lord over the other Clans. Those Shagalaxians cut off from their brethren during the Undergod's invasion now comprise many of the scrapper warbands that plague the wasteland, but a small number of those still connected to the Great Tree yet remain among the great clans. Many Shagalaxians claim they are loyal to The Young Son, a deity of charity and ingenuity, though in secret it is said that there are those who follow a mechanical titan and wait patiently for the time when their legions of tanks are rebuilt so that they may turn this world into ash once more.", rivalry = "Clan Crast", attributes = {{Color(0, 225, 0), "(+) Starts with +30 maximum health"}, {Color(0, 225, 0), "(+) Starts at Sacrament Level 8, with points placed in \'Ingenuity\'"}, {Color(0, 225, 0), "(+) Can craft and use firearms and crossbows"}}}, 
		{name = "Clan Crast", startingRank = 3, subtitle = "Followers of the Mother - Shamans and Mystics", description = "While all followers of The Family respect The Mother's role and contribution to the rough but fair cycle of nature and death, those actually born under her are looked down upon as weak and pathetic. In those days the followers of The Mother would be thrown off high cliffs to splatter on the rocks below, as they would never grow to be great warriors like the followers of The Father would. Then it was decided by a more benevolent King of the Bark Throne that one in every tenth child born under the sign of The Mother would be permitted to live. As always these lucky children grew up to be queer and disfigured little things, but they did have gifts that made them useful. Some became bards, entertainers: a juggling dwarf or a two-headed giant. Others had The Vision, a way to see into the dark void of fate itself. With a new generation of mystic beings, a new Clan was formed, the first ever to follow The Mother. To this day Clan Crast thrives without bloodshed, as their great blinded seers look into the darkness to warn the others of their perils ahead. When a seer foresaw the killing of the Great Tree at the hands of the Holy Hierarchy's fire-breathing dragons, and no one believed him, the Gores learned to never mistrust the warnings of their Crasters again. The current line of Clan Crast are most in touch with the Blade Druids of old, and seek to use their ancient weapons forged by the Earth itself. A great ritual awaits Clan Crast, to restore their Great Tree, and the other Clans stand by to see this through.", rivalry = "Clan Shagalax", attributes = {{Color(0, 225, 0), "(+) Starts with +25 maximum health"}, {Color(0, 225, 0), "(+) Starts at Sacrament Level 12"}, {Color(0, 225, 0), "(+) Can unlock the ability to Ravenspeak"}, {Color(0, 225, 0), "(+) Can craft and use crossbows"}, {Color(225, 0, 0), "(-) Start with -4 Trait Points"}}}, 
		{name = "Clan Grock", subtitle = "Followers of the Old Ways - Nomads", description = "The first Gore tribe to come settle near the Great Tree. The oldest Clan of all Gores, and those who refused to follow the gods of The Family. While many followers of the Old Ways acknowledge the existence of The Family, they choose to instead go their own way and entrust in themselves to see their own path in life. All Gores believe they are fated to die and whatever they do cannot change that, and so those of the Old Ways agree that they will continue to struggle to survive until that day comes. The average Grock is much taller and stronger than their brothers, with a thick coat of black hair covering their unwashed bodies, giving them a bestial look. Clan Grock will never hold any power as their beliefs encourage a nomadic lifestyle, one free of society, laws and the reliance of other men. The only time they will ever be called in by the others is if their Great Tree is under attack, and then and only then will they charge forth to defend their home lands. Clan Grock is considered a joke to the other Clans, men who would rather lay with beasts than a good woman. The worst of them are Clan Gore, the arrogant Kings of Old who hosted 'Great Hunts' to slaughter as many Grocks as possible for glory and bragging rights. Still, when their great gods fail them, those of the Old Ways will always endure.", rivalry = "Clan Gore", attributes = {{Color(0, 225, 0), "(+) Starts with +175 maximum health"}, {Color(0, 225, 0), "(+) Savage: Warcries instantly restore 25 stamina"}, {Color(0, 225, 0), "(+) Starts at Sacrament Level 8"}, {Color(225, 0, 0), "(-) Cannot wear Medium or Heavy armor"}, {Color(225, 0, 0), "(-) The Subfaith Tree is locked and cannot be progressed"}}}
	};
	FACTION.models = {
		male = {
			clothes = "models/begotten/goreicwarfighters/goretribal_male.mdl",
			heads = {
				"male_90",
				"male_91",
				"male_92",
				"male_93",
				"male_94",
				"male_95",
				"male_96"
			},
		},
	};
	FACTION.singleGender = GENDER_MALE;
	
	if SERVER then
		function FACTION:CanPromote(player, target, faction, subfaction)
			if subfaction == "Clan Grock" then
				return false;
			end
		end
		
		function FACTION:CanDemote(player, target, faction, subfaction)
			if subfaction == "Clan Grock" then
				return false;
			end
		end
	end
	
	if !Schema.Ranks then
		Schema.Ranks = {};
	end
	
	if !Schema.RankTiers then
		Schema.RankTiers = {};
	end

	if !Schema.RanksToSubfaction then
		Schema.RanksToSubfaction = {};
	end
	
	Schema.Ranks["Goreic Warrior"] = {
		[1] = "",
		[2] = "Housecarl",
		[3] = "Soothsayer",
		[4] = "Seer",
		[5] = "Admiral",
		[6] = "Ironborn",
		[7] = "Marauder",
		[8] = "Red Wolf",
		[9] = "Chieftain",
		[10] = "Elder",
		[11] = "Grand Admiral",
		[12] = "King's Chosen",
		[13] = "King",
	};
	
	Schema.RankTiers["Goreic Warrior"] = {
		[1] = {"", "Soothsayer", "Marauder"},
		[2] = {"Housecarl", "Seer", "Admiral", "Ironborn", "Red Wolf"},
		[3] = {"Chieftain", "Elder", "Grand Admiral"},
		[4] = {"King's Chosen"},
		[5] = {"King"},
	};
	
	Schema.RanksToSubfaction["Goreic Warrior"] = {
		["Admiral"] = "Clan Harald",
		["Grand Admiral"] = "Clan Harald",
		["Soothsayer"] = "Clan Crast",
		["Seer"] = "Clan Crast",
		["Elder"] = "Clan Crast",
		["Ironborn"] = "Clan Shagalax",
		["Marauder"] = "Clan Reaver",
		["Red Wolf"] = "Clan Reaver",
	};
FACTION_GOREIC = FACTION:Register();