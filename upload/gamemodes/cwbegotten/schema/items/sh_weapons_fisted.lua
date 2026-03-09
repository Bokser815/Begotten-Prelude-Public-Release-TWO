local ITEM = Clockwork.item:New("weapon_base");
	ITEM.name = "Caestus";
	ITEM.model = "models/props/begotten/melee/caestus.mdl";
	ITEM.weight = 0.5;
	ITEM.uniqueID = "begotten_fists_caestus";
	ITEM.category = "Melee";
	ITEM.description = "A padded leather battle glove. It can turn your fists into brutal mauls.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/caestus.png"
	ITEM.meleeWeapon = true;
	ITEM.isAttachment = true;
	ITEM.attachmentBone = "ValveBiped.Bip01_R_Thigh";
	ITEM.attachmentOffsetAngles = Angle(309.28, 148.18, 265.52);
	ITEM.attachmentOffsetVector = Vector(-0.71, 3.54, 0);
	ITEM.fireplaceFuel = 60;
	
	ITEM.components = {breakdownType = "breakdown", items = {"leather", "wood"}};
ITEM:Register();

local ITEM = Clockwork.item:New("weapon_base");
	ITEM.name = "Iron Knuckles";
	ITEM.model = "models/mosi/fallout4/props/weapons/melee/knuckles.mdl";
	ITEM.weight = 0.4;
	ITEM.uniqueID = "begotten_fists_ironknuckles";
	ITEM.category = "Melee";
	ITEM.description = "An iron pair of knuckles. An excellent advantage to any fistfight.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/iron_knuckles.png"
	ITEM.meleeWeapon = true;
	ITEM.attributes = {"concealable"};
	
	ITEM.components = {breakdownType = "meltdown", items = {"iron_chunks"}};
	ITEM.itemSpawnerInfo = {category = "Melee", rarity = 250, bNoSupercrate = true};
ITEM:Register();

local ITEM = Clockwork.item:New("weapon_base");
	ITEM.name = "Spiked Knuckles";
	ITEM.model = "models/mosi/fallout4/props/weapons/melee/knuckles.mdl";
	ITEM.bodygroup1 = 2;
	ITEM.weight = 0.4;
	ITEM.uniqueID = "begotten_fists_spikedknuckles";
	ITEM.category = "Melee";
	ITEM.description = "An iron pair of knuckles that has been fitted with spiked prongs. A single punch could take a man's eyes.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/spiked_knuckles.png"
	ITEM.meleeWeapon = true;
	ITEM.attributes = {"concealable"};
	
	ITEM.components = {breakdownType = "meltdown", items = {"iron_chunks"}};
	ITEM.itemSpawnerInfo = {category = "Melee", rarity = 350, bNoSupercrate = true};
ITEM:Register();

local ITEM = Clockwork.item:New("weapon_base");
	ITEM.name = "Sparring Gloves";
	ITEM.model = "models/mosi/fallout4/props/weapons/melee/knuckles.mdl";
	ITEM.weight = 0.3;
	ITEM.uniqueID = "begotten_prelude_fists_boxer";
	ITEM.category = "Melee";
	ITEM.description = "An pair of cushioned gloves which were designed to be non-lethal. You can still deliver a serious knockout with these.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/spiked_knuckles.png"
	ITEM.meleeWeapon = true;
	ITEM.attributes = {"concealable"};
	
	ITEM.components = {breakdownType = "breakdown", items = {"leather", "leather"}};
	ITEM.itemSpawnerInfo = {category = "Melee", rarity = 350, bNoSupercrate = true};
ITEM:Register();

local ITEM = Clockwork.item:New("weapon_base");
	ITEM.name = "Bone Fist";
	ITEM.model = "models/mosi/fallout4/props/weapons/melee/knuckles.mdl";
	ITEM.weight = 0.4;
	ITEM.uniqueID = "begotten_prelude_fists_bonefist";
	ITEM.category = "Melee";
	ITEM.description = "A pair of bones that are bound to the fists. Typically used by hands-on man-eaters.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/spiked_knuckles.png"
	ITEM.meleeWeapon = true;
	ITEM.attributes = {"concealable"};
	
	ITEM.components = {breakdownType = "breakdown", items = {"human_bone", "human_bone"}};
ITEM:Register();

local ITEM = Clockwork.item:New("weapon_base");
	ITEM.name = "Voltfists";
	ITEM.model = "models/mosi/fallout4/props/weapons/melee/knuckles.mdl";
	ITEM.weight = 4;
	ITEM.uniqueID = "begotten_prelude_fists_voltfist";
	ITEM.category = "Melee";
	ITEM.description = "A pair of armored gauntlets with pistons capable of ramming your fists straight through a man's body.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/spiked_knuckles.png"
	ITEM.meleeWeapon = true;
	ITEM.attributes = {"concealable"};
	
	ITEM.components = {breakdownType = "meltdown", items = {"iron_chunks"}};
ITEM:Register();