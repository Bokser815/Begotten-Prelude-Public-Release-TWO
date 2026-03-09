local FACTION = Clockwork.faction:New("Holy Hierarchy");
	local ministerModels = {
		male = {
			clothes = "models/begotten/gatekeepers/minister_male.mdl",
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
	};

	FACTION.disabled = false; -- For events.
	FACTION.whitelist = true;
	FACTION.useFullName = false;
	FACTION.material = "begotten/faction/faction_logo_hierarchy";
	FACTION.color = Color(225, 175, 0);
	FACTION.description = "The Holy Hierarchy upholds the ancient superiority of the enlightened few. \nAmongst the dark sea of bastard blood and uncivilized rabble, they are the adjudicators and administrators to enforce Holy Light. \nStill, many are corrupt, seeking self indulgence rather than directing rights. \nAfter all, from their high seats, there are none above them to look down in judgement."
	FACTION.availablefaiths = {"Faith of the Light"};
	FACTION.alliedfactions = {"Gatekeeper"};
	FACTION.enlist = true;
	FACTION.ratio = 0.1; -- 0.1 slots per player (3 at 30 players).
	--FACTION.imposters = true;
	FACTION.names = "glazic";
	FACTION.subfactions = {
		{name = "Ministry", startingRank = 3, whitelist = true, subtitle = "The Ministry - The Privileged Few Overseers of Glazic Supremacy", description = "The Holy Hierarchy is perhaps the only surviving institution of the old world and is the only known church of the Light remaining. Many view the Holy Hierarchy as the direct continuation of the Empire of Light, including the Holy Hierarchy themselves, who push this narrative to solidify their grasp on their subjects. Any who doubt its legitimacy are executed on the spot. Lording over most of the 'civilized' peasantry that wander the wasteland, the Holy Hierarchy strictly enforces its religious codes, which are ever-changing at the whim of the Pope. At the very top of the Hierarchy lies the Pope, supreme in power. He lives in a penthouse at the top of the hotel in absolute luxury in comparison to the shanties that the rabble share. Below him lies the cardinals, who serve as the Pope's council. Lower still are the Bishops, many of whom are now in open rebellion against the new Pope, with some even claiming his title as their own. Lastly, there are the priests, who are barely above commoner status and equal in rank to those in the Knights of Sol or Inquisition. A priest's duties often involve searching ancient texts held within the grand archives for any advantage that could be offered to the Hierarchy over their rivals, or for clues to decipher the ramblings of the machine that so many wanderers speak of.", models = ministerModels},
		{name = "Inquisition", hidden = true, startingRank = 2, whitelist = true, subtitle = "The Second Inquisition - Hunters, Judges, and Executioners", description = "The Holy Order of the Glaze's Inquisitors is an ancient institution, founded by Lord Maximus during his campaigns against the Black Hats and born of a need to destroy infilitrators and weed out heresy. Although disbanded after their task was completed, it would not be long before the Inquisition was re-instated, as enemies of the Glaze only grew in both numbers and ferocity. The coming of the Undergod and subsequent displacement of the Dark Lord from Hell only strengthened the need for the Inquisition, as unknown powers were now openly unleashed upon mankind. The Inquisition is the most important line of defense for the Holy Hierarchy, as they root out the hidden enemies of the Glaze and uphold religious doctrine. Inquisitors strictly abide by their 'Book of Law', which details their methodology and the rules by which all followers of the Glaze must adhere to. The inquisition also holds the unique ability to hold any member of Glazic society accountable to the 'Book of Law', including members of the Holy Hierarchy. Accusations of heresy are not taken lightly however, and being proved wrong after accusing someone in power may have disastrous consequences for the accuser.", attributes = {{Color(0, 225, 0), "(+) Pious: +50% increased faith gain"}, {Color(0, 225, 0), "(+) Starts with +50 maximum health"}}},
		{name = "Shepherds", startingRank = 5, whitelist = true, subtitle = "The Shepherds of Light - The Examplars of Glazic Tradition", description = "A powerful and extremely compotent force of only the most disciplined of the Glaze pulled from a plethora of County Districts. The Shepherds are proud leaders and protectors of Glazic thought. Their status and position as council translates to unprecedented power among Glazic politics. They are also known to be fearless warriors and leaders of men on the battlefield in their stewardship of the Glaze.", attributes = {{Color(0, 225, 0), "(+) Pious: +50% increased faith gain"}, {Color(0, 225, 0), "(+) Starts with +50 maximum health"}}}, 
		{name = "Knights of Sol", hidden = true, startingRank = 1, whitelist = true, subtitle = "The Knights of Sol - The Most Devoted Order of the Glaze", description = "Only a few years ago Skylight fell to Earth in a blazing inferno, the last promise of a future for mankind careening into the ground alongside it. From its innumerable enlightened inhabitants only seventeen emerged: the Glorious Seventeen. Donning glorious white armor and wielding sword glowing bright, the Glorious Seventeen slaughtered every demon that fell upon them. Thousands fell by their blade before the demons retreated into the darkness, and it seemed that humanity would live for at least another day. Although the Glorious Seventeen no longer walk this Earth, their legacy lives on in the newly founded Holy Order of the Knights of Sol. These Knights of Sol consist of the very best of the Holy Hierarchy, unmatched in prowess and seen by many of the faithful as guardian angels incarnate. Knights are given the absolute best equipment available in the royal armories. Despite this, Knights are never seen with muskets or any other sort of firearm, believing them too cowardly for someone of such noble stature. Knights of Sol are also known to keep squires in their service, often recruited from the ranks of the Gatekeepers.", attributes = {{Color(0, 225, 0), "(+) Bullet damage is reduced by 70%"}, {Color(0, 225, 0), "(+) Bulwark +25 stamina and +25 stability"}, {Color(0, 225, 0), "(+) Starts with +75 maximum health"}, {Color(225, 0, 0), "(-) Burdened: Run speed is decreased by 15%"}}, models = ministerModels}
	};
	FACTION.singleGender = GENDER_MALE;
	
	-- Called when a player is transferred to the faction.
	function FACTION:OnTransferred(player, faction, name)
		--if (faction.name != "Wanderer" and faction.name != "Gatekeeper") then
			--return false;
		--end;
		
		--[[if player:GetFaith() ~= "Faith of the Light" or player:GetSubfaith() == "Voltism" then
			return false;
		end]]--
		
		--[[if (!Clockwork.player:IsWhitelisted(player, "Holy Hierarchy")) then
			Clockwork.player:SetWhitelisted(player, "Holy Hierarchy", true);
		end;]]--
	end;
	
	if SERVER then
		function FACTION:CanEnlist(player, target, faction, subfaction)
			if faction == "Holy Hierarchy" then
				local playerSubfaction = player:GetNetVar("kinisgerOverrideSubfaction") or player:GetSubfaction();
				
				if playerSubfaction ~= "Ministry" then
					if subfaction and subfaction.name ~= playerSubfaction then
						return false;
					end
				end
			end
		end
		
		function FACTION:CanPromote(player, target, faction, subfaction)
			if faction == "Holy Hierarchy" then
				local playerSubfaction = player:GetNetVar("kinisgerOverrideSubfaction") or player:GetSubfaction();
				
				if playerSubfaction ~= "Ministry" then
					if subfaction and subfaction.name ~= playerSubfaction then
						return false;
					end
				end
			end
		end
		
		function FACTION:CanDemote(player, target, faction, subfaction)
			if faction == "Holy Hierarchy" then
				local playerSubfaction = player:GetNetVar("kinisgerOverrideSubfaction") or player:GetSubfaction();
				
				if playerSubfaction ~= "Ministry" then
					if subfaction and subfaction.name ~= playerSubfaction then
						return false;
					end
				end
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
	
	Schema.Ranks["Holy Hierarchy"] = {
		[1] = "Sir",
		[2] = "Apprentice",
		[3] = "Vicar",
		[4] = "Justicar",
		[5] = "Inquisitor",
		[6] = "Minister",
		[7] = "Grand Knight",
		[8] = "Ordinator",
		[9] = "Magistrate",
		[10] = "Grand Inquisitor",
		[11] = "Regent",
	};
	
	Schema.RankTiers["Holy Hierarchy"] = {
		[1] = {"Sir", "Apprentice", "Vicar"},
		[2] = {"Justicar", "Inquisitor", "Minister"},
		[3] = {"Grand Knight", "Ordinator", "Magistrate"},
		[4] = {"Grand Inquisitor", "Regent"},
	};
	
	Schema.RanksToSubfaction["Holy Hierarchy"] = {
		["Sir"] = "Knights of Sol",
		["Justicar"] = "Knights of Sol",
		["Grand Knight"] = "Knights of Sol",
		["Apprentice"] = "Inquisition",
		["Inquisitor"] = "Inquisition",
		["Ordinator"] = "Inquisition",
		["Grand Inquisitor"] = "Inquisition",
	};
FACTION_HIERARCHY = FACTION:Register();