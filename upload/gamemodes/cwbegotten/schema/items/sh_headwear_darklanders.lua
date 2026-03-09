local ITEM = Clockwork.item:New("bodygroup_base")
	ITEM.name = "Darklander Kipchak"
	ITEM.model = "models/begotten_prelude/items/kipchak.mdl"
	ITEM.iconoverride = "materials/begottenprelude/ui/itemicons/kipchak.png"
	ITEM.weight = 1.5
	ITEM.uniqueID = "kipchak_helmet"
	ITEM.category = "Helms"
	ITEM.bodyGroup = 1
	ITEM.bodyGroupVal = 1
	ITEM.headSuffix = "_darklander";
	ITEM.description = "A design from ancient times brought back alive by the proclamation of a past Emperor, this helmet stands as a symbol of the Darklandic spice empire."
	ITEM.excludeFactions = {"Goreic Warrior"};
	ITEM.useSound = "armor/plate_damage_02.wav";

	ITEM.conditionScale = 0.75 -- item degrades 1.5x faster with damage related condition loss

	ITEM.effectiveLimbs = {
		[HITGROUP_HEAD] = true,
	}

	ITEM.protection = 55
	ITEM.hitParticle = "MetalSpark";
	ITEM.type = "plate";

	ITEM.bluntScale = 0.85; -- reduces blunt damage by 10%
	ITEM.pierceScale = 0.85; -- reduces pierce damage by 10%
	ITEM.slashScale = 0.7; -- reduces slash damage by 25%
	ITEM.bulletScale = 0.85; -- reduces bullet damage by 10%
	ITEM.stabilityScale = 0.70; -- reduces stability damage by 30%
	ITEM.insulation = 30; -- Adds 6% insulation. Helmets account for 20% of total insulation. Body armor covers the other 80%.
	
	ITEM.components = {breakdownType = "meltdown", items = {"iron_chunks"}, xp = 30};
ITEM:Register();

local ITEM = Clockwork.item:New("bodygroup_base")
	ITEM.name = "Darklander Visored Kipchak"
	ITEM.model = "models/begotten_prelude/items/kipchak_mask.mdl"
	ITEM.iconoverride = "materials/begottenprelude/ui/itemicons/kipchak_mask.png"
	ITEM.weight = 1.5
	ITEM.uniqueID = "masked_kipchak_helmet"
	ITEM.category = "Helms"
	ITEM.bodyGroup = 1
	ITEM.bodyGroupVal = 2
	ITEM.headSuffix = "_darklander";
	ITEM.description = "A visored helmet with the image of a Darklandic warrior imposed on the faceplate."
	ITEM.excludeFactions = {"Goreic Warrior"};
	ITEM.useSound = "armor/plate_damage_02.wav";
	ITEM.overlay = "begotten/zomboverlay/gatekeep1";

	ITEM.conditionScale = 0.75 -- item degrades 1.5x faster with damage related condition loss

	ITEM.effectiveLimbs = {
		[HITGROUP_HEAD] = true,
	}

	ITEM.protection = 65
	ITEM.hitParticle = "MetalSpark";
	ITEM.type = "plate";

	ITEM.bluntScale = 0.85; -- reduces blunt damage by 10%
	ITEM.pierceScale = 0.85; -- reduces pierce damage by 10%
	ITEM.slashScale = 0.7; -- reduces slash damage by 25%
	ITEM.bulletScale = 0.85; -- reduces bullet damage by 10%
	ITEM.stabilityScale = 0.60; -- reduces stability damage by 40%
	ITEM.insulation = 30; -- Adds 6% insulation. Helmets account for 20% of total insulation. Body armor covers the other 80%.
	
	ITEM.components = {breakdownType = "meltdown", items = {"fine_steel_chunks"}, xp = 30};
	
ITEM:Register();

local ITEM = Clockwork.item:New("bodygroup_base")
	ITEM.name = "Darklander Turban"
	ITEM.model = "models/begotten_prelude/items/turban.mdl"
	ITEM.iconoverride = "materials/begottenprelude/ui/itemicons/turban.png"
	ITEM.weight = 1.5
	ITEM.uniqueID = "turban"
	ITEM.category = "Helms"
	ITEM.bodyGroup = 1
	ITEM.bodyGroupVal = 3
	ITEM.headSuffix = "_darklander";
	ITEM.description = "Blue silk tied around the head to protect one's face from the elements. It is mildly protective against slashes."
	ITEM.excludeFaction = {"Goreic Warrior"};
	ITEM.useSound = "npc/combine_soldier/zipline_clothing2.wav";

	ITEM.conditionScale = 1.1 -- item degrades 1.5x faster with damage related condition loss
	
	ITEM.effectiveLimbs = {
		[HITGROUP_HEAD] = true,
	}

	ITEM.protection = 20
	ITEM.hitParticle = "GlassImpact";
	ITEM.type = "leather";

	ITEM.bluntScale = 0.65; -- reduces blunt damage by 30%
	ITEM.pierceScale = 0.85; -- reduces pierce damage by 10%
	ITEM.slashScale = 0.85; -- reduces slash damage by 10%
	ITEM.bulletScale = 0.85; -- reduces bullet damage by 10%	
	ITEM.stabilityScale = 0.85; -- reduces stability damage by 15%
	ITEM.insulation = 50; -- Adds 10% insulation. Helmets account for 20% of total insulation. Body armor covers the other 80%.
	
	ITEM.components = {breakdownType = "breakdown", items = {"leather"}, xp = 30};
	
ITEM:Register();

-- deadlanders

local ITEM = Clockwork.item:New("bodygroup_base")
	ITEM.name = "Deadlander Rider Helmet"
	ITEM.model = "models/begotten_prelude/items/khuzait_helmet_k.mdl"
	ITEM.iconoverride = "materials/begottenprelude/ui/itemicons/khuzait_helmet_k.png"
	ITEM.weight = 1.5
	ITEM.uniqueID = "khuzait_helmet_k"
	ITEM.category = "Helms"
	ITEM.bodyGroup = 1
	ITEM.bodyGroupVal = 4
	ITEM.headSuffix = "_darklander";
	ITEM.description = "The men of the Deadlands train since birth on motorcycle, horse, and chariot. This helmet is a feared sight to any foot army."
	ITEM.excludeFactions = {"Goreic Warrior"};
	ITEM.useSound = "armor/plate_damage_02.wav";

	ITEM.conditionScale = 0.75 -- item degrades 1.5x faster with damage related condition loss

	ITEM.effectiveLimbs = {
		[HITGROUP_HEAD] = true,
	}

	ITEM.protection = 55
	ITEM.hitParticle = "MetalSpark";
	ITEM.type = "plate";

	ITEM.bluntScale = 0.85; -- reduces blunt damage by 10%
	ITEM.pierceScale = 0.85; -- reduces pierce damage by 10%
	ITEM.slashScale = 0.7; -- reduces slash damage by 25%
	ITEM.bulletScale = 0.85; -- reduces bullet damage by 10%
	ITEM.stabilityScale = 0.70; -- reduces stability damage by 30%
	ITEM.insulation = 30; -- Adds 6% insulation. Helmets account for 20% of total insulation. Body armor covers the other 80%.

	
	ITEM.components = {breakdownType = "meltdown", items = {"iron_chunks"}, xp = 30};
ITEM:Register();

local ITEM = Clockwork.item:New("bodygroup_base")
	ITEM.name = "Deadlander Khan Helmet"
	ITEM.model = "models/begotten_prelude/items/khuzait_lord_helmet_c.mdl"
	ITEM.iconoverride = "materials/begottenprelude/ui/itemicons/khuzait_lord_helmet_c.png"
	ITEM.weight = 1.5
	ITEM.uniqueID = "khuzait_lord_helmet_c"
	ITEM.category = "Helms"
	ITEM.bodyGroup = 1
	ITEM.bodyGroupVal = 5
	ITEM.headSuffix = "_darklander";
	ITEM.description = "A helmet fit for a Deadlandic lord. It is said that their motorized archers have ended all, from Gatekeeper legions to Darklandic mercenary brigades."
	ITEM.excludeFactions = {"Goreic Warrior"};
	ITEM.useSound = "armor/plate_damage_02.wav";
	ITEM.overlay = "begotten/zomboverlay/gatekeep1";

	ITEM.conditionScale = 0.75 -- item degrades 1.5x faster with damage related condition loss


	ITEM.effectiveLimbs = {
		[HITGROUP_HEAD] = true,
	}

	ITEM.protection = 65
	ITEM.hitParticle = "MetalSpark";
	ITEM.type = "plate";

	ITEM.bluntScale = 0.85; -- reduces blunt damage by 10%
	ITEM.pierceScale = 0.85; -- reduces pierce damage by 10%
	ITEM.slashScale = 0.7; -- reduces slash damage by 25%
	ITEM.bulletScale = 0.85; -- reduces bullet damage by 10%
	ITEM.stabilityScale = 0.60; -- reduces stability damage by 40%
	ITEM.insulation = 30; -- Adds 6% insulation. Helmets account for 20% of total insulation. Body armor covers the other 80%.

	
	ITEM.components = {breakdownType = "meltdown", items = {"fine_steel_chunks"}, xp = 30};
	
ITEM:Register();
