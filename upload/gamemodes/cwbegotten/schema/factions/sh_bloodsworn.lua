local FACTION = Clockwork.faction:New("Qarin Bloodsworn");

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

	FACTION.disabled = false; -- For events.
	FACTION.whitelist = true;
	FACTION.useFullName = false;
	FACTION.hidden = true;
	FACTION.material = "begotten/faction/faction_logo_darklanders";
	FACTION.color = Color(140, 160, 190);
	FACTION.description = "In ancient Darklandic texts, a Qarin, known as the Everlasting Ally, is an ethereal doppelgänger intricately intertwined with a human’s earthly spirit. \nIt is rumored that Darklander societies have long utilized the presence of these demons to empower their strongest warriors. \nWhen the Undergod began its crusade of Hell, an untold number of Qarin abandoned their master and sought refuge in the mortal plane. \nDarklanders with fleeing Qarin counterparts instantaneously merged with their demonic doppelgängers as the Qarin crossed the spiritual barrier. \nA very lucky few were able to survive the entry of their Qarin, becoming hybrids of man and spirit. The strongest of those survivors are known as the Bloodsworn.";
	FACTION.availablefaiths = {"Faith of the Dark", "Faith of the Many"};
	FACTION.characterLimit = 1; -- # of characters of this faction a player can have.
	FACTION.imposters = false;
	FACTION.names = "darklandic";
	FACTION.alliedfactions = {"Darklanders"};
	FACTION.subfactions = {
		{
			name = "Immortal",
			hidden = true,
			startingRank = 30,
			subtitle = "Immortals - Bloated Sentinels and Ravagers",
			description = "The Immortals are the most elite and skilled mercenaries of the Nigerii Empire. These warriors are tasked with protecting the most coveted artifacts of the Nigerii Empire and the Emperor himself. It is said that when an Immortal is chosen, they are locked in a cage full of pigs for days on end. What takes place in those chambers no one knows except the Emperor and the Immortals themselves.. But what emerges is something truly horrific.",
			attributes = {
				{Color(0, 225, 0), "(+) Starts at Sacrament Level 30"},
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
			models = darklanderModels,
		},
		{
			name = "Hashashin", -- rework this fucking tree
			subtitle = "Hashashin - Unwavering Hitmen",
			description = "The origin of the word ‘assassin’ is a contentious topic, but general consensus among Imperial intellectuals is that it originated in what is now known as the Eastern Spicelands. Surviving historical data indicate that an ancient ruler created a secret order of loyal, unquestioning assassins to enforce his rule, sow fear and discomfort among dissenters, and, chiefly, exact revenge on a large invasion force known as the ‘Crusaders.’ For over a century, the Hashashin Order slew hundreds of powerful individuals, from political opponents to battle-hardened commanders of the enemy. It is not known for certain which of the thousands of Spice Lords founded the new Hashashin Caliphate, nor when the order was re-established. A seasoned scholar of Satanist faith may draw a parallel between the abilities of the Qarin-bound Hashashins and the Black Hats of mutant Kinisger blood, but the only similarity is in their modus operandi. Whereas the Kinisger infiltrators are bastard descendants with impure blood, members of the Hashashin Caliphate are purebred and hand-chosen before being empowered by their Qarin. The Bloodsworn Hashashins of the East Nigerii Empire are just as fierce, loyal, and secretive as their ancient counterparts; unlike the ancients, however, contemporary Hashashins draw upon their Qarin to infiltrate and destroy their enemies with methods never considered possible by the old world.",
			attributes = {
                {Color(0, 225, 0), "(+) Unique rituals to alter appearance"},
                {Color(0, 225, 0), "(+) Right side of 'Litheness' tree unlocked"},
                {Color(0, 225, 0), "(+) 'Satanism', 'Witch', 'Heretic', and 'Sorcerer' beliefs unlocked"},
                {Color(0, 225, 0), "(+) 50% damage increase with daggers"},
                {Color(0, 225, 0), "(+) 5% increase in speed"},
                {Color(0, 225, 0), "(+) 10% chance to dodge sources of damage. Stackable with 'Lucky' and the Ring of Distortion"},
				{Color(0, 225, 0), "(+) Starts at Sacrament Level 11"},
				{Color(225, 0, 0), "(-) The 'Hauberk belief is locked."}
			},
			models = darklanderModels,
		},
		{
			name = "Death Merchant",
			subtitle = "Death Merchants - Slippery Salesmen and Schemers",
			description = "When one is asked to picture a Darklander Spice Merchant, they may envision a cunning, spindly businessman with a pouch of coin over his shoulder. They may envision a drug-addicted schemer using his influence to get another quick hit. They may even envision a mercenary warboss with martial and monetary prowess alike. When the Spice Merchant comes to mind, very few think of the elusive Death Merchants of the Expeditionary Legions. Their numbers are few, and their abilities fewer. When new lands are explored and outside societies contacted, Death Merchants will be sent alongside Darklander footmen to establish trade routes and introduce Spice to the outer lands. The Death Merchants are Bloodsworn themselves, and draw upon their Qarin’s power to teleport themselves out of precarious situations. Because of this ability, Death Merchants are the optimal frontline salesmen for new colonies where the risk of death or theft is high. Their survivability and escape potential often leads Death Merchants to be very aggressive and upfront in their haggling, which results in higher profits when compared to regular Spice Merchants. Death Merchants do not undergo any sort of official combat training and have no Qarin-boosted strength or speed, but their comparably long lifespan in dangerous areas strengthens their resolve and hardens their spirit. Oftentimes, Death Merchants become experienced swordsmen through repeated unfiltered wasteland encounters.",
			attributes = {
			    {Color(0, 225, 0), "(+) Frontline Contigencies: Grants the ability to escape from dangerous situations"},
				{Color(0, 225, 0), "(+) Starts at Sacrament Level 15"},
			},
			models = darklanderModels,
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
	
	if !Schema.RanksOfAuthority then
		Schema.RanksOfAuthority = {};
	end
FACTION_BLOODSWORN = FACTION:Register();
