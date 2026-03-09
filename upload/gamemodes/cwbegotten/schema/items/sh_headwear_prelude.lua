local ITEM = Clockwork.item:New("bodygroup_base")
	ITEM.name = "Scrapper Foreman Helmet"
	ITEM.model = "models/begotten_prelude/items/iconoclast_helmet.mdl"
	ITEM.iconoverride = "materials/begottenprelude/ui/itemicons/iconoclast_helmet.png"
	ITEM.weight = 1.5
	ITEM.category = "Helms"
	ITEM.headReplacement = "models/begotten/heads/iconoclast_helmet.mdl";
	ITEM.description = "A headlamp-affixed helmet and gas mask. Used frequently by Foremen, reigning with fists of iron and enforcing with blades of scrap."
	ITEM.excludeSubfactions = {"Clan Gore", "Clan Harald", "Clan Reaver", "Clan Crast", "Clan Grock"};
	ITEM.useSound = "armor/plate_damage_02.wav";
	ITEM.overlay = "begotten/zomboverlay/voltyellow";
	ITEM.conditionScale = 1 -- item degrades 1x faster with damage related condition loss

	ITEM.effectiveLimbs = {
		[HITGROUP_HEAD] = true,
	}

	ITEM.protection = 50
	ITEM.hitParticle = "MetalSpark";
	ITEM.type = "plate";

	ITEM.bluntScale = 0.85; -- reduces blunt damage by 10%
	ITEM.pierceScale = 0.85; -- reduces pierce damage by 10%
	ITEM.slashScale = 0.7; -- reduces slash damage by 25%
	ITEM.bulletScale = 0.65; -- reduces bullet damage by 30%	
	ITEM.stabilityScale = 0.70; -- reduces stability damage by 30%
	ITEM.insulation = 40; -- Adds 8% insulation. Helmets account for 20% of total insulation. Body armor covers the other 80%.
	
	ITEM.components = {breakdownType = "breakdown", items = {"scrap", "scrap", "scrap", "scrap", "leather", "leather"}};
ITEM:Register();
