local FACTION = Clockwork.faction:New("Darklanders");
	local darklandModels = {
		male = {
			clothes = "models/begotten/wanderers/wanderer_male.mdl",
			heads = {
				"male_01",
				"male_03",
				"male_05",
				"male_13"
			},
		},
		female = {
			clothes = "models/begotten/wanderers/wanderer_female.mdl",
			heads = {
				"female_06",
				"female_32",
			}
		}
	};
	FACTION.disabled = false; -- For events.
	FACTION.hidden = false; -- For events.
	FACTION.whitelist = true;
	FACTION.useFullName = false;
	FACTION.material = "begotten/faction/faction_logo_darklanders";
	FACTION.color = Color(160, 80, 30);
	FACTION.description = "Lend me your coin for these furs... these munitions... these arms! \nThe Darklanders are merchants first and foremost, backed by an experienced army of mercenaries. \nThey hail from the Far East, a den of hedonism and debauchery, led by Emperor Varazdat. \nA thousand gods reside in their pantheon, though it is said that all are simply proxies of Satan himself. \nThe Spice Must Flow.";
	FACTION.availablefaiths = {"Faith of the Many", "Faith of the Dark"};
	FACTION.characterLimit = 1; -- # of characters of this faction a player can have.
	FACTION.imposters = false;
	FACTION.names = "darklandic";
	FACTION.alliedfactions = {"Qarin Bloodsworn"};
	FACTION.subfactions = {
		{
			name = "Yihnari",
			subtitle = "Yihnari - Guardsmen of the Spice Empire",
			description = "Warriors selected from slave stock, trained with a spear and shield before the age of six. The Yihnari are the frontline against the many enemies of the Emperor. Their prowess is unquestionable; the only fighting force that had ever stood toe to toe against the Deadlander Nomad Hordes and still stood fighting.",
			attributes = {
				{Color(0, 225, 0), "(+) Making a Killing: Increasing amounts of coin increase health and damage output"},
				{Color(0, 225, 0), "(+) Starts at Sacrament Level 8"},
				{Color(0, 225, 0), "(+) Starts with +25 maximum health"},
				{Color(0, 225, 0), "(+) Starts with +15 maximum poise"},
				{Color(0, 225, 0), "(+) Movement penalty for medium armor is significantly reduced"},
			},
			models = darklandModels
		},
		{
			name = "Nehemian",
			subtitle = "Nehemiani - Gunners of the Dunes",
			description = "Jezail riflemen, renowned for their speed and accuracy. A long time ago, a group of Nomads known as the Nehemiani came forth from the Deadlands. Outcasts among outcasts, they betrayed the rest of their clan in service of the Emperor, who offered them riches beyond their wildest imaginations. They are selected at a young age, each given a rifle in their hands. The last one surviving, covered in black powder, is named Nehemiani. ",
			attributes = {
				{Color(0, 225, 0), "(+) Starts at Sacrament Level 10"},
				{Color(0, 225, 0), "(+) Spice and Shot: +33% increased reload speed"},
				{Color(0, 225, 0), "(+) Trained Gunners: Start with all firearms beliefs"},
				{Color(0, 225, 0), "(+) Fleet Fighter: +25 maximum stamina, +5% sprint speed"},
				{Color(225, 0, 0), "(-) Unable to wield two-handed weapons"},
				{Color(225, 0, 0), "(-) The 'Hauberk' belief is locked"},

			},
			models = darklandModels
		},
		{
			name = "Aswaran",
			subtitle = "Aswaran - Men of Plate and Chain",
			description = "Brutal elites. Rumors say that these fighters were bred from pigs and gladiator slaves. Often with a horrid stench and disgusting mutated faces, the Aswaran are the heavily armored guardsmen of the Far East. They are raised up from slavery to become Cataphracts, and the very few who survive the many trials may be selected to become Royal Guardsmen; the Immortals.",
			attributes = {
				{Color(0, 225, 0), "(+) Starts at Sacrament Level 9"},
			    {Color(0, 225, 0), "(+) Starts with +45 maximum health"},
				{Color(0, 225, 0), "(+) +15% damage protection from Heavy armor"},
				{Color(0, 225, 0), "(+) Able to use heavy equipment without beliefs at 65% effectiveness"},
				{Color(225, 0, 0), "(-) Burdened: Starts with -25 maximum stamina"},

			},
			models = darklandModels
		},
		{
			name = "Immortal",
			hidden = true,
			startingRank = 6,
			subtitle = "Immortals - Bloated Sentinels and Ravagers",
			description = "The Immortals are the most elite and skilled mercenaries of the Nigerii Empire. These warriors are tasked with protecting the most coveted artifacts of the Nigerii Empire and the Emperor himself. It is said that when an Immortal is chosen, they are locked in a cage full of pigs for days on end. What takes place in those chambers no one knows except the Emperor and the Immortals themselves.. But what emerges is something truly horrific.",
			attributes = {
				{Color(0, 225, 0), "(+) Starts at Sacrament Level 35"},
			    {Color(0, 225, 0), "(+) Starts with +75 maximum health"},
				{Color(0, 225, 0), "(+) +20% damage protection from Heavy armor"},
				{Color(0, 225, 0), "(+) Bullet damage reduced by 70%"},
				{Color(0, 225, 0), "(+) Starts with 'Savage' and 'Heart Eater' unlocked"},
				{Color(0, 225, 0), "(+) Starts with 'Hauberk' and 'Strength' unlocked"},
				{Color(225, 0, 0), "(-) Gun related traits locked"},
				{Color(225, 0, 0), "(-) Can only gain sustenance from feeding on human flesh"},
				{Color(225, 0, 0), "(-) Movement speed reduced by 20%"},
                {Color(225, 0, 0), "(-) Sanity loss increased by 30%"},

			},
			models = darklandModels
		}
	}
	
	-- Called when a player is transferred to the faction.
	function FACTION:OnTransferred(player, faction, name)
		if player:GetFaith() ~= "Faith of the Dark" then
			return false;
		end
		
		if (!Clockwork.player:IsWhitelisted(player, faction.name)) then
			Clockwork.player:SetWhitelisted(player, faction.name, true);
		end;
	end;
	
	if !Schema.Ranks then
		Schema.Ranks = {};
	end
	
	if !Schema.RanksToCoin then
		Schema.RanksToCoin = {};
	end
	
	if !Schema.RankTiers then
		Schema.RankTiers = {};
	end
	
	Schema.Ranks["Darklanders"] = {
		[1] = "Fledgling",
		[2] = "Warrior",
		[3] = "Spice Guard",
		[4] = "Janissary",
		[5] = "Framandar",
		[6] = "Immortal",
		[7] = "Sultan",
		[8] = "Cataphract",
	};

	Schema.RankTiers["Darklanders"] = {
		[1] = {"Fledgling"},
		[2] = {"Warrior"},
		[3] = {"Spice Guard", "Janissary", "Immortal", "Cataphract"},
		[4] = {"Framandar", "Sultan"},
	};
FACTION_DARKLANDER = FACTION:Register();
