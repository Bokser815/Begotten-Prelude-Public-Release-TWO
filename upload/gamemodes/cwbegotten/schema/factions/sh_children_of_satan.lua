local FACTION = Clockwork.faction:New("Children of Satan");
	FACTION.disabled = true; -- For events.
	FACTION.whitelist = true;
	FACTION.useFullName = false;
	FACTION.hidden = true;
	FACTION.material = "begotten/faction/faction_logo_satanists";
	FACTION.color = Color(125, 10, 10);
	FACTION.description = "Those selected to join the Children of Satan are exceptional individuals, be they particularly twisted and cunning, or perhaps born with the blood of ancient royalty. \nFor this reason the Children are few in number compared to the other powers, but they make up for this with their unmatched skill and grace. \nThe average Child of Satan is centuries old, obsessed with higher forbidden knowledge and glorious works of art and passion, yet they still have very much to learn. \nFearing what becomes of their corrupted souls if they are to meet an unforseen fate before reaching Demonhood, a Child of Satan will rarely risk their life for a prize not satisfactory. \nThey are the unseen puppet masters; the Glaze and the Gore must be kept in the balance, for Satan desires more subjects in his war against the Undergod, and extinction will only result in His victory.";
	FACTION.availablefaiths = {"Faith of the Dark"};
	FACTION.characterLimit = 1; -- # of characters of this faction a player can have.
	FACTION.ratio = 0.18; -- 0.18 slots per player (5.4 at 30 players).
	FACTION.names = "glazic";
	FACTION.subfactions = {
		{name = "Varazdat", subtitle = "House Varazdat - Master Swordsmen and Drinkers of Blood", description = "The Eastern Nigerii Empire is aptly known as the Land of a Thousand Princes for its infamous lust-crazed Emperors. Several of these Emperors held tremendous orgies in their palace grounds that led to many bastard children. Due to unclear laws of succession, this led to an unending stretch of wars hosted in the Far East for a throne soaked in blood. Among the thousands of claimants to the throne was the Varazdat child, one who had very little royal blood in him, but all the ambition in the world. While the other pretenders were propped up by wealthy spice merchants and noblemen, Varazdat was a gutter rat who began his climb by pickpocketing and throat slicing. He kidnapped other claimants and prepared their bodies into fine feasts, their tender meat spiced and roasted to perfection. For each would-be Prince he killed and cannibalized, he absorbed their power and birthright. At the end of his road he was positively bloated, his belly full of royalty, and his claim to the throne backed by millions of mercenaries. The Varazdat reign did not last very long, as most go, but it opened the way for future Emperors to seek powers from the Dark. Today those who share the blood of House Varazdat are feared as particularly ruthless schemers, and child-eaters.", attributes = {{Color(0, 225, 0), "(+) Bloodlust: +10% sprint speed when above 95% health"}, {Color(0, 225, 0), "(+) Lifeleech: 50% damage dealt returned as health."}, {Color(0, 225, 0), "(+) Eastern Warriors: Starts with +25 maximum health and +15 maximum stamina"}, {Color(0, 225, 0), "(+) Starts with the 'Savage' and 'Heart Eater' beliefs unlocked"}, {Color(0, 225, 0), "(+) Starts at Sacrament Level 5"}, {Color(225, 0, 0), "(-) Can only gain sustenance from feeding on human flesh"}, {Color(225, 0, 0), "(-) Crazed Cannibals: Sanity loss is increased by 50%"}}},
		{name = "Rekh-khet-sa", subtitle = "House Rekh-khet-sa - Immortal Sorcerers of the Darkness", description = "The formation of the House of Rekh-khet-sa dates back to long before recorded history within \'Egypt\', a forgotten land. Ancient Egyptians were tainted by Lucifer to use dark magics in their horrific pursuits of absolute immortality in the name of their Pharaoh. Although all of their original members are deceased, their greed for attaining immortality still persists to this very day, with their ancient texts being the basis for the Rekh-khet-sa\'s modern day reformation. Many members of the House Rekh-khet-sa pursue the so-called Ancient One's quest for immortality, imbued with visions from the Dark Prince, and obsessed with collecting artifacts to help achieve their goals, with some being successful and being able to perform such magics as reversing age. Because of this, many older members of Rekh-khet-sa tend to be wiser than the other houses, able to gain a wealth of experience. Though each member of this bloodline may be hundreds of years old, they live eternally in darkness. When the light of Sol shines upon them, they shrivel up, their perfect skin rotting away, revealing the cost of eternal life.", attributes = {{Color(0, 225, 0), "(+) Ancient Sorcerers: Gain no corruption or sanity loss"}, {Color(0, 225, 0), "(+) Can craft 'Hellforged Steel' without the 'Sorcerer' belief"}, {Color(0, 225, 0), "(+) Infinite level cap & +25% increased faith gain"}, {Color(0, 225, 0), "(+) Starts at Sacrament Level 16, with 'Primevalism' unlocked"}, {Color(225, 0, 0), "(-) Sustain periodic damage if outside during daytime"}}},
		{name = "Philimaxio", subtitle = "House Philimaxio - Black Knights Sworn to the Dark Prince", description = "When the Undergod swept over the lands of Sol to bring ruination and purification, almost all the central Districts fell immediately. The White Sentinels of District Seventeen begged to differ. Their stronghold was ravaged time and time again by the hordes of the unliving thralls, and each time they fell onto the blades of the Sentinels. They were no mere guardsmen, but renowned nobles of the iron-fisted Philimaxio family. In the Holy Hierarchy, very few noble houses would ever stoop so low as to bear arms directly. The Philimaxios were martialists, stout and hardy, always ready for the time in which a great foe would rise against them. Indeed they held their District Seventeen until there was no longer any reason to do so, as the Empire of Light shattered around them and they were stranded. Realizing their predicament, the Philimaxios found themselves surrounded by dark temptations. The Dark Prince whispered in their ears, wearing down on their spiritual resolve until they found themselves turning against the Light. The White Sentinels turned crimson as they slaughtered every serf, noble, and citizen alike within District Seventeen. The Philimaxios were one of the first to join the Children of Satan, seeking out the haunted manor where they would become unholy guardsmen of a Satanic Dreadlord. Quiet, strong, dutiful and unmoving, the sons of the Philimaxio Bloodline will hold back all who dare threaten the followers of Darkness.", attributes = {{Color(0, 225, 0), "(+) Armored Wall: Heavy armor is 15% more protective"}, {Color(0, 225, 0), "(+) Armor condition deterioration is halved"}, {Color(0, 225, 0), "(+) Bullet damage is reduced by 70%"}, {Color(0, 225, 0), "(+) Warrior Nobles: +50% maximum health and +25 maximum stability"}, {Color(0, 225, 0), "(+) Starts at Sacrament Level 6"}, {Color(225, 0, 0), "(-) Burdened: Run speed is decreased by 15%"}}},
		{name = "Kinisger", subtitle = "House Kinisger - Mutant Masters of Infiltration and Assassination", description = "Chaos, deception, and trickery. House Kinisger has existed since the The First Inquisition. When deception was high within the Empire of Light, Lord Maximus stepped forth and revealed the existence of the Black-Hats; black blooded mutants taking on the appearance of men of Faith who had infiltrated society to spread chaos. The Inquisition was then called to bring an end to the Black-Hats, with some having to use witchery to disguise their black blood to crimson red, and when the Inquisition had begun executing anyone they were mildly suspicious of they had to take to more extreme measures. This was the beginning of their pact, as they had used dark rituals to disguise their flesh into different appearances. Practically any Black-Hat who did not use this method was executed in the First Inquisition. Thus, the descendants of House Kinisger are all Black-Hats who still remain true to the Dark. Their members to this day have become experienced in the art of infiltrating society and have become excellent spies and ritual masters. Before turning to the Dark, the mutant amish of House Kinisger were the equivalent of cockroaches - willing to do anything to merely stay alive amongst men who sought their demise. They used their flesh sorcery to hide in plain sight, to live amongst the enemy. Now they have awoken to their true purpose, to sow chaos and doubt, to always seek to topple any great threat from within.", attributes = {{Color(0, 225, 0), "(+) Faceless: Unique Rituals to alter appearance or cloak"}, {Color(0, 225, 0), "(+) Assassin: Deal 25% more damage with daggers"}, {Color(0, 225, 0), "(+) Immune to blood tests (excluding false positives)"}, {Color(0, 225, 0), "(+) Starts at Sacrament Level 6"}, {Color(225, 0, 0), "(-) Mutant Blood: Start with -3 Trait Points"}}}
	};
	--FACTION.singleGender = GENDER_MALE;
	
	-- Called when a player is transferred to the faction.
	function FACTION:OnTransferred(player, faction, name)
		if player:GetFaith() ~= "Faith of the Dark" then
			return false;
		end
		
		if (!Clockwork.player:IsWhitelisted(player, "Children of Satan")) then
			Clockwork.player:SetWhitelisted(player, "Children of Satan", true);
		end;
	end;
	
	if !Schema.Ranks then
		Schema.Ranks = {};
	end
	
	if !Schema.RankTiers then
		Schema.RankTiers = {};
	end

	if !Schema.RanksToSubfaction then
		Schema.RanksToSubfaction = {};
	end
	
	Schema.Ranks["Children of Satan"] = {
		[1] = "",
		[2] = "Dark Justicar",
		[3] = "Hierophant",
		[4] = "Sultan",
		[5] = "Black Finger",
		[6] = "Immortal",
		[7] = "Dreadlord",
		[8] = "Hell Baron",
		[9] = "Caretaker",
	};
	
	Schema.RankTiers["Children of Satan"] = {
		[1] = {""},
		[2] = {"Dark Justicar", "Hierophant", "Sultan", "Black Finger", "Immortal"},
		[3] = {"Dreadlord"},
		[4] = {"Hell Baron", "Caretaker"},
	};
	
	Schema.RanksToSubfaction["Children of Satan"] = {
		["Dark Justicar"] = "Philimaxio",
		["Hierophant"] = "Rekh-khet-sa",
		["Sultan"] = "Varazdat",
		["Black Finger"] = "Kinisger",
	};
FACTION_SATANIST = FACTION:Register();