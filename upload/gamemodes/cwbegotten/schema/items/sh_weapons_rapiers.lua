local ITEM = Clockwork.item:New("weapon_base");
	ITEM.name = "Elegant Epee";
	ITEM.model = "models/demonssouls/weapons/epee rapier.mdl";
	ITEM.weight = 0.5;
	ITEM.uniqueID = "begotten_rapier_elegantepee";
	ITEM.category = "Melee";
	ITEM.description = "An expertly crafted Maximillian steel blade with an elegant golden hilt. It bears the engravings of a long forgotten Glazic Noble household.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/elegant_epee.png"
	ITEM.meleeWeapon = true;
	ITEM.isAttachment = true;
	ITEM.attachmentBone = "ValveBiped.Bip01_L_Thigh";
	ITEM.attachmentOffsetAngles = Angle(8.95, 4.97, 38.78);
	ITEM.attachmentOffsetVector = Vector(2.12, 4.95, -1.41);
	ITEM.canUseOffhand = true;
	ITEM.canUseShields = true;
	
	ITEM.components = {breakdownType = "meltdown", items = {"fine_steel_chunks", "wood"}}; -- use "breakdown" for other type
	ITEM.itemSpawnerInfo = {category = "Melee", rarity = 900, supercrateOnly = true};
ITEM:Register();

local ITEM = Clockwork.item:New("weapon_base");
	ITEM.name = "Iron Rapier";
	ITEM.model = "models/demonssouls/weapons/rapier.mdl";
	ITEM.weight = 0.4;
	ITEM.uniqueID = "begotten_rapier_ironrapier";
	ITEM.category = "Melee";
	ITEM.description = "A well-crafted and nimble weapon. It is exceptionally light and balanced, with a sharp and deadly point.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/iron_rapier.png"
	ITEM.meleeWeapon = true;
	ITEM.isAttachment = true;
	ITEM.attachmentBone = "ValveBiped.Bip01_L_Thigh";
	ITEM.attachmentOffsetAngles = Angle(0, 0, 16.91);
	ITEM.attachmentOffsetVector = Vector(3.5, 1, 1.68);
	ITEM.canUseOffhand = true;
	ITEM.canUseShields = true;
	
	ITEM.components = {breakdownType = "meltdown", items = {"iron_chunks"}}; -- use "breakdown" for other type
	ITEM.itemSpawnerInfo = {category = "Melee", rarity = 500};
ITEM:Register();

local ITEM = Clockwork.item:New("weapon_base");
	ITEM.name = "Voltrapier";
	ITEM.model = "models/mosi/fallout4/props/weapons/melee/revolutionarysword.mdl";
	ITEM.weight = 0.6;
	ITEM.uniqueID = "begotten_prelude_rapier_voltrapier";
	ITEM.category = "Melee";
	ITEM.description = "A crude rapier wrapped in charged electrical wire. Deadly to those who cower in Glazic steel.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/volt_spear.png"
	ITEM.meleeWeapon = true;
	ITEM.isAttachment = true;
	ITEM.attachmentBone = "ValveBiped.Bip01_L_Thigh";
	ITEM.attachmentOffsetAngles = Angle(279.47, 285.16, 264.32);
	ITEM.attachmentOffsetVector = Vector(2.83, 3.54, -6.36);
	ITEM.skin = 1;
	ITEM.bodygroup1 = 4;
	ITEM.canUseShields = true;
	
	ITEM.components = {breakdownType = "meltdown", items = {"iron_chunks", "iron_chunks", "tech", "tech"}};
	ITEM.requiredbeliefs = {"wriggle_fucking_eel"};
ITEM:Register();