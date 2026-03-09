local ITEM = Clockwork.item:New("weapon_base");
	ITEM.name = "Poleaxe";
	ITEM.model = "models/witcher2soldiers/tw2_halberd.mdl";
	ITEM.weight = 3.5;
	ITEM.uniqueID = "begotten_polearm_gatekeeperpoleaxe";
	ITEM.category = "Melee";
	ITEM.description = "A well crafted short steel poleaxe. An excellent equalizer and guardsman weapon, able to keep the peace and stave off tall horrors.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/gatekeeper_poleaxe.png"
	ITEM.meleeWeapon = true;
	ITEM.isAttachment = true;
	ITEM.isPolearm = true;
	ITEM.hasMinimumRange = true;
	ITEM.attachmentBone = "ValveBiped.Bip01_Spine2";
	ITEM.attachmentOffsetAngles = Angle(90, 0, 279.45);
	ITEM.attachmentOffsetVector = Vector(-7.78, 3, -45.97);
	
	ITEM.attributes = {"grounded"};
	ITEM.components = {breakdownType = "meltdown", items = {"fine_steel_chunks", "wood", "wood"}}; -- use "breakdown" for other type
ITEM:Register();

local ITEM = Clockwork.item:New("weapon_base");
	ITEM.name = "Billhook";
	ITEM.model = "models/bill_guisarme.mdl";
	ITEM.weight = 3.5;
	ITEM.uniqueID = "begotten_polearm_billhook";
	ITEM.category = "Melee";
	ITEM.description = "A cheaply made iron polearm that is surprisingly effective in equalizing armored foes. Even a Knight can be made humble by the lowly billman.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/billhook.png"
	ITEM.meleeWeapon = true;
	ITEM.isAttachment = true;
	ITEM.isPolearm = true;
	ITEM.hasMinimumRange = true;
	ITEM.attachmentBone = "ValveBiped.Bip01_Spine2";
	ITEM.attachmentOffsetAngles = Angle(98.45, 0, 279.45);
	ITEM.attachmentOffsetVector = Vector(-0.34, -21.89, -21.22);
	
	ITEM.attributes = {"grounded"};
	ITEM.components = {breakdownType = "meltdown", items = {"iron_chunks", "iron_chunks", "wood", "wood"}}; -- use "breakdown" for other type
ITEM:Register();

local ITEM = Clockwork.item:New("weapon_base");
	ITEM.name = "Lucerne";
	ITEM.model = "models/bec_de_corbin.mdl";
	ITEM.weight = 4;
	ITEM.uniqueID = "begotten_polearm_lucerne";
	ITEM.category = "Melee";
	ITEM.description = "A fine steel weapon that is both practical and elegant in its design. Its ravens beak is excellent at punching holes into metal plate.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/lucerne.png"
	ITEM.meleeWeapon = true;
	ITEM.isAttachment = true;
	ITEM.isPolearm = true;
	ITEM.hasMinimumRange = true;
	ITEM.attachmentBone = "ValveBiped.Bip01_Spine2";
	ITEM.attachmentOffsetAngles = Angle(98.45, 0, 279.45);
	ITEM.attachmentOffsetVector = Vector(4.24, -47.58, -21.22);
	
	ITEM.attributes = {"grounded"};
	ITEM.components = {breakdownType = "meltdown", items = {"fine_steel_chunks", "fine_steel_chunks", "wood", "wood", "leather"}}; -- use "breakdown" for other type
ITEM:Register();

local ITEM = Clockwork.item:New("weapon_base");
	ITEM.name = "Halberd";
	ITEM.model = "models/demonssouls/weapons/halberd.mdl";
	ITEM.weight = 6;
	ITEM.uniqueID = "begotten_polearm_halberd";
	ITEM.category = "Melee";
	ITEM.description = "A long metal polearm. It has a steel chopping edge and a sharp metal spike for penetrating plate. A weapon typically found in the ranks of the lowly Gatekeepers, as it is capable of giving even a common fool a fighting chance against great horrors.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/halberd.png"
	ITEM.meleeWeapon = true;
	ITEM.isAttachment = true;
	ITEM.isPolearm = true;
	ITEM.hasMinimumRange = true;
	ITEM.attachmentBone = "ValveBiped.Bip01_Spine2";
	ITEM.attachmentOffsetAngles = Angle(88.51, 0, 8.95);
	ITEM.attachmentOffsetVector = Vector(0, 3, -17.68);
	
	ITEM.attributes = {"grounded"};
	ITEM.components = {breakdownType = "meltdown", items = {"steel_chunks", "wood", "wood", "wood", "wood"}}; -- use "breakdown" for other type
	ITEM.itemSpawnerInfo = {category = "Melee", rarity = 850, supercrateOnly = true};
ITEM:Register();

local ITEM = Clockwork.item:New("weapon_base");
	ITEM.name = "Scrap Halberd";
	ITEM.model = "models/slop/scraphalberd.mdl";
	ITEM.weight = 4;
	ITEM.uniqueID = "begotten_prelude_2h_great_scraphalberd";
	ITEM.category = "Melee";
	ITEM.description = "A skillfully welded heap of scrap resembling a Glazic Halberd, although with some liberties taken in overall weight and function.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/bgpweap/scraphalberd.png"
	ITEM.meleeWeapon = true;
	ITEM.isAttachment = true;
	ITEM.attachmentBone = "ValveBiped.Bip01_Spine2";
	ITEM.attachmentOffsetAngles = Angle(8.95, 287.05, 90);
	ITEM.attachmentOffsetVector = Vector(-5.66, 2.12, -21.22);
	
	ITEM.attributes = {"grounded"};
	ITEM.components = {breakdownType = "breakdown", items = {"iron_chunks", "scrap"}};
	--ITEM.itemSpawnerInfo = {category = "Melee", rarity = 700};
	ITEM.requiredbeliefs = {"strength"};
ITEM:Register();

local ITEM = Clockwork.item:New("weapon_base");
	ITEM.name = "Pike";
	ITEM.model = "models/props/begotten/melee/pike.mdl";
	ITEM.weight = 6;
	ITEM.uniqueID = "begotten_polearm_pike";
	ITEM.category = "Melee";
	ITEM.description = "A long iron polearm with simple yet effective sharp spike at its end. A weapon known for its impressive reach and penetrating power, best employed in a formation of others like it.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/pike.png"
	ITEM.meleeWeapon = true;
	ITEM.isAttachment = true;
	ITEM.isPolearm = true;
	ITEM.hasMinimumRange = true;
	ITEM.attachmentBone = "ValveBiped.Bip01_Spine2";
	ITEM.attachmentOffsetAngles = Angle(0, 8.95, 180);
	ITEM.attachmentOffsetVector = Vector(0, 3, -7.07);
	
	ITEM.attributes = {"grounded"};
	ITEM.components = {breakdownType = "meltdown", items = {"iron_chunks", "wood", "wood", "wood"}}; -- use "breakdown" for other type
	ITEM.itemSpawnerInfo = {category = "Melee", rarity = 350, supercrateOnly = true};
ITEM:Register();

local ITEM = Clockwork.item:New("weapon_base");
	ITEM.name = "Thunder Spear";
	ITEM.model = "models/weapons/thunderstick/thunderstick.mdl";
	ITEM.weight = 6;
	ITEM.uniqueID = "begotten_polearm_lungemine";
	ITEM.category = "Melee";
	ITEM.description = "A venerated weapon known for its simplicity, and tendency to make martyrs. The antithesis to all vehicles. This weapon can only be used once...";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/bgpweap/thunderstick.png"
	ITEM.meleeWeapon = true;
	ITEM.isAttachment = true;
	ITEM.isLongPolearm = true;
	ITEM.hasMinimumRange = true;
	ITEM.attachmentBone = "ValveBiped.Bip01_Spine2";
	ITEM.attachmentOffsetAngles = Angle(0, 8.95, 180);
	ITEM.attachmentOffsetVector = Vector(0, 3, -7.07);
	
	--ITEM.attributes = {"grounded"};
	ITEM.components = {breakdownType = "meltdown", items = {"iron_chunks", "wood", "wood", "wood"}}; -- use "breakdown" for other type
	ITEM.itemSpawnerInfo = {category = "Melee", rarity = 350, supercrateOnly = true};
ITEM:Register();

local ITEM = Clockwork.item:New("weapon_base");
	ITEM.name = "Polehammer";
	ITEM.model = "models/demonssouls/weapons/mirdan hammer.mdl";
	ITEM.weight = 8;
	ITEM.uniqueID = "begotten_polearm_polehammer";
	ITEM.category = "Melee";
	ITEM.description = "A well crafted Glazic polearm. It features a brutal steel hammerhead and a deadly pike. An excellent equalizer against armored foes.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/polehammer.png"
	ITEM.meleeWeapon = true;
	ITEM.isAttachment = true;
	ITEM.isPolearm = true;
	ITEM.hasMinimumRange = true;
	ITEM.attachmentBone = "ValveBiped.Bip01_Spine2";
	ITEM.attachmentOffsetAngles = Angle(90, 0, 10.94);
	ITEM.attachmentOffsetVector = Vector(0, 3, -1.41);
	
	ITEM.attributes = {"grounded"};
	ITEM.components = {breakdownType = "meltdown", items = {"steel_chunks", "wood", "wood", "wood", "wood"}}; -- use "breakdown" for other type
ITEM:Register();

local ITEM = Clockwork.item:New("weapon_base");
	ITEM.name = "War Spear";
	ITEM.model = "models/witcher2soldiers/tw2_spear.mdl";
	ITEM.weight = 4;
	ITEM.uniqueID = "begotten_polearm_warspear";
	ITEM.category = "Melee";
	ITEM.description = "A braced wooden pole with a Shagalaxian steel spearhead. An impressively long hunting weapon turned into a weapon of war.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/war_spear.png"
	ITEM.meleeWeapon = true;
	ITEM.isAttachment = true;
	ITEM.isPolearm = true;
	ITEM.hasMinimumRange = true;
	ITEM.attachmentBone = "ValveBiped.Bip01_Spine2";
	ITEM.attachmentOffsetAngles = Angle(90, 0, 277.46);
	ITEM.attachmentOffsetVector = Vector(-3.54, 3, -35.36);
	
	ITEM.attributes = {"grounded"};
	ITEM.components = {breakdownType = "meltdown", items = {"fine_steel_chunks", "wood", "wood", "wood"}}; -- use "breakdown" for other type
ITEM:Register();

local ITEM = Clockwork.item:New("weapon_base");
	ITEM.name = "Glazic Banner";
	ITEM.model = "models/begotten/misc/gatekeeper_banner.mdl";
	ITEM.weight = 8.5;
	ITEM.uniqueID = "begotten_polearm_glazicbanner";
	ITEM.category = "Melee";
	ITEM.description = "A flag bearing the insignia of the Holy Order of the Gatekeepers. It serves as an inspiration in battle, and to lose it would be extremely grave indeed.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/gatekeeper_banner.png"
	ITEM.meleeWeapon = true;
	ITEM.isAttachment = true;
	ITEM.isPolearm = true;
	ITEM.hasMinimumRange = true;
	ITEM.attachmentBone = "ValveBiped.Bip01_Spine2";
	ITEM.attachmentOffsetAngles = Angle(114.36, 271.49, 152.15);
	ITEM.attachmentOffsetVector = Vector(-2.83, 6, 53.75);
	
	ITEM.attributes = {"aoebuff"};
	ITEM.components = {breakdownType = "meltdown", items = {"cloth", "cloth", "cloth", "cloth", "cloth", "iron_chunks", "iron_chunks"}};
	ITEM.requireFaith = {"Faith of the Light"};
ITEM:Register();

local ITEM = Clockwork.item:New("weapon_base");
	ITEM.name = "Hewing Spear";
	ITEM.model = "models/weapons/hewingspear/hewingspear.mdl";
	ITEM.weight = 4;
	ITEM.uniqueID = "begotten_prelude_polearm_hewingspear";
	ITEM.category = "Melee";
	ITEM.description = "A spear with an elongated head. The design sacrifices some armor penetration and speed for glaive-like slashing.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/bgpweap/hewingspear.png"
	ITEM.meleeWeapon = true;
	ITEM.isAttachment = true;
	ITEM.isLongPolearm = true;
	ITEM.hasMinimumRange = true;
	ITEM.attachmentBone = "ValveBiped.Bip01_Spine2";
	ITEM.attachmentOffsetAngles = Angle(90, 180, 10.94);
	ITEM.attachmentOffsetVector = Vector(-2.12, 3, -18.39);
	
	ITEM.attributes = {"grounded"};
	ITEM.components = {breakdownType = "meltdown", items = {"fine_steel_chunks", "wood", "wood", "wood"}}; -- use "breakdown" for other type
ITEM:Register();

local ITEM = Clockwork.item:New("weapon_base");
	ITEM.name = "Goedendag";
	ITEM.model = "models/begotten/weapons/goedendag.mdl";
	ITEM.weight = 4;
	ITEM.uniqueID = "begotten_prelude_polearm_goedandag";
	ITEM.category = "Melee";
	ITEM.description = "A plus-sized wooden bat with a metal spike mounted to the end. A union of club and spear, which acts in harmony to beat-down and stab fucklets.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/bgpweap/goedendag.png"
	ITEM.meleeWeapon = true;
	ITEM.isAttachment = true;
	ITEM.isShortPolearm = true;
	ITEM.hasMinimumRange = false;
	ITEM.attachmentBone = "ValveBiped.Bip01_Spine2";
	ITEM.attachmentOffsetAngles = Angle(90, 0, 10.94);
	ITEM.attachmentOffsetVector = Vector(-2.12, 3, -18.39);
	
	ITEM.attributes = {"grounded"};
	ITEM.components = {breakdownType = "meltdown", items = {"iron_chunks", "wood", "wood", "wood"}}; -- use "breakdown" for other type
ITEM:Register();

local ITEM = Clockwork.item:New("weapon_base");
	ITEM.name = "Bludgeoner";
	ITEM.model = "models/weapons/peasantstar/bludgeoner.mdl";
	ITEM.weight = 4;
	ITEM.uniqueID = "begotten_prelude_2h_bludgeoner";
	ITEM.category = "Melee";
	ITEM.description = "An array of jagged spikes sits along the head of this carved wooden haft, with a spearlike head as the centerpiece; Indeed capable of making ugly wounds on any adversary.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/bgpweap/bludgeoner.png"
	ITEM.meleeWeapon = true;
	ITEM.isAttachment = true;
	ITEM.attachmentBone = "ValveBiped.Bip01_Spine2";
	ITEM.attachmentOffsetAngles = Angle(90, 0, 10.94);
	ITEM.attachmentOffsetVector = Vector(-2.12, 3, 10.39);
	
	ITEM.attributes = {"grounded"};
	ITEM.components = {breakdownType = "breakdown", items = {"iron_chunks", "wood", "wood"}};
	--ITEM.itemSpawnerInfo = {category = "Melee", rarity = 700};
	ITEM.requiredbeliefs = {"strength"};
ITEM:Register();

local ITEM = Clockwork.item:New("weapon_base");
	ITEM.name = "Mancatcher";
	ITEM.model = "models/begotten/weapons/mancatcher.mdl";
	ITEM.weight = 4;
	ITEM.uniqueID = "begotten_prelude_polearm_mancatcher";
	ITEM.category = "Melee";
	ITEM.description = "A wooden pole mounted with curved prongs attached to it, for catching unruly dissidents or escapees.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/bgpweap/mancatcher.png"
	ITEM.meleeWeapon = true;
	ITEM.isAttachment = true;
	ITEM.isLongPolearm = true;
	ITEM.hasMinimumRange = true;
	ITEM.attachmentBone = "ValveBiped.Bip01_Spine2";
	ITEM.attachmentOffsetAngles = Angle(90, 0, 10.94);
	ITEM.attachmentOffsetVector = Vector(-2.12, 3, -18.39);
	
	ITEM.attributes = {"subjugator"};
	ITEM.components = {breakdownType = "meltdown", items = {"fine_steel_chunks", "wood", "wood", "wood"}}; -- use "breakdown" for other type
ITEM:Register();

local ITEM = Clockwork.item:New("weapon_base");
	ITEM.name = "Hillkeeper Signum";
	ITEM.model = "models/begotten_apocalypse/items/cla_rome_standard_signum_1.mdl";
	ITEM.weight = 8.5;
	ITEM.uniqueID = "begotten_polearm_hillkeepersignum";
	ITEM.category = "Melee";
	ITEM.description = "A heavy iron and silver standard, bearing an eagle and the majestic name of MAXIMUS upon a plate. It evokes a deep feeling of strength and to lose it would be grave indeed.";
	ITEM.iconoverride = "materials/begotten_apocalypse/ui/itemicons/cla_rome_standard_signum_1.png"
	ITEM.attachmentOffsetAngles = Angle(114.36, 271.49, 152.15);
	ITEM.attachmentOffsetVector = Vector(0, 6, -38.74);
	
	ITEM.attributes = {"aoebuff"};
	ITEM.components = {breakdownType = "meltdown", items = {"cloth", "cloth", "cloth", "cloth", "cloth", "iron_chunks", "iron_chunks"}};
	ITEM.requireFaith = {"Faith of the Light"};
ITEM:Register();