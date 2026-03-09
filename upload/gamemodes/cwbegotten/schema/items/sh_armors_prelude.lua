--[[
LIGHT ARMOR MINIMUM VALUES

ITEM.bluntScale = 0.7; -- reduces blunt damage by 25%
ITEM.slashScale = 0.9; -- reduces slash damage by 5%

PROTECTION - 20

MEDIUM ARMOR MINIMUM VALUES

ITEM.bluntScale = 0.85; -- reduces blunt damage by 10%
ITEM.pierceScale = 0.85; -- reduces pierce damage by 10%
ITEM.slashScale = 0.7; -- reduces slash damage by 25%

PROTECTION - 40
FALL DAMAGE - +10%

HEAVY ARMOR MINIMUM VALUES

ITEM.bluntScale = 0.9; -- reduces blunt damage by 5%
ITEM.pierceScale = 0.75; -- reduces pierce damage by 15%
ITEM.slashScale = 0.65; -- reduces slash damage by 30%
ITEM.bulletScale = 0.7; -- reduces bullet damage by 25%

PROTECTION - 60
FALL DAMAGE - +13%

--]]

local ITEM = Clockwork.item:New("clothes_base");
ITEM.name = "Wanderer Jerkin";
ITEM.group = "prelude_wanderers/wandererjerkin";
ITEM.model = "models/begottenprelude/items/wandererjerkin.mdl"
ITEM.iconoverride = "materials/begottenprelude/ui/itemicons/wandererjerkin.png"
ITEM.category = "Armor"
ITEM.conditionScale = 1.1
ITEM.hitParticle = "GlassImpact";
ITEM.protection = 20
ITEM.type = "leather";
ITEM.weight = 1.5;
ITEM.weightclass = "Light";
ITEM.description = "Minimally protective and more suited for county-district farm labor then anything else. However, the last crops have died, and so it finds use as improvised protection.";
ITEM.useSound = "npc/combine_soldier/zipline_clothing2.wav";
ITEM.excludeFactions = {"Goreic Warrior"};

ITEM.effectiveLimbs = {
	[HITGROUP_GENERIC] = true,
	[HITGROUP_CHEST] = true,
	[HITGROUP_STOMACH] = true,
	[HITGROUP_LEFTARM] = true,
	[HITGROUP_RIGHTARM] = true,
	[HITGROUP_LEFTLEG] = true,
	[HITGROUP_RIGHTLEG] = true,
	[HITGROUP_GEAR] = true
}

ITEM.bluntScale = 0.7; -- reduces blunt damage by 25%
ITEM.slashScale = 0.9; -- reduces slash damage by 5%

ITEM.components = {breakdownType = "breakdown", items = {"leather", "cloth", "cloth"}};

-- Called when a replacement is needed for a player.
function ITEM:GetReplacement(player)

end;

ITEM.runSound = {
	"armormovement/body-lobe-1.wav.mp3",
	"armormovement/body-lobe-2.wav.mp3",
	"armormovement/body-lobe-3.wav.mp3",
	"armormovement/body-lobe-4.wav.mp3",
	"armormovement/body-lobe-5.wav.mp3",
};

--[[ITEM.walkSound = {
	"armormovement/body-lobe-b1.wav.mp3",
	"armormovement/body-lobe-b2.wav.mp3",
};]]--

ITEM:Register();

ITEM = Clockwork.item:New("clothes_base");
ITEM.name = "Wanderer Gambeson";
ITEM.group = "prelude_wanderers/wanderergambeson";
ITEM.model = "models/begottenprelude/items/wanderergambeson.mdl"
ITEM.iconoverride = "materials/begottenprelude/ui/itemicons/wanderergambeson.png"
ITEM.category = "Armor"
ITEM.conditionScale = 1.1
ITEM.hitParticle = "GlassImpact";
ITEM.protection = 25
ITEM.type = "leather";
ITEM.weight = 2;
ITEM.weightclass = "Light";
ITEM.description = "A quilted gambeson made of upcycled thin cloth and leather, seen often in the fyrds and peasant militias raised in the defense of a County District.";
ITEM.useSound = "npc/combine_soldier/zipline_clothing2.wav";
ITEM.excludeFactions = {"Goreic Warrior"};

ITEM.effectiveLimbs = {
	[HITGROUP_GENERIC] = true,
	[HITGROUP_CHEST] = true,
	[HITGROUP_STOMACH] = true,
	[HITGROUP_LEFTARM] = true,
	[HITGROUP_RIGHTARM] = true,
	[HITGROUP_LEFTLEG] = true,
	[HITGROUP_RIGHTLEG] = true,
	[HITGROUP_GEAR] = true
}

ITEM.bluntScale = 0.7; -- reduces blunt damage by 25%
ITEM.slashScale = 0.9; -- reduces slash damage by 5%

ITEM.components = {breakdownType = "breakdown", items = {"leather", "cloth", "cloth", "cloth"}};

-- Called when a replacement is needed for a player.
function ITEM:GetReplacement(player)

end;

ITEM.runSound = {
	"armormovement/body-lobe-1.wav.mp3",
	"armormovement/body-lobe-2.wav.mp3",
	"armormovement/body-lobe-3.wav.mp3",
	"armormovement/body-lobe-4.wav.mp3",
	"armormovement/body-lobe-5.wav.mp3",
};

--[[ITEM.walkSound = {
	"armormovement/body-lobe-b1.wav.mp3",
	"armormovement/body-lobe-b2.wav.mp3",
};]]--

ITEM:Register();

ITEM = Clockwork.item:New("clothes_base");
ITEM.name = "Wanderer Tabard";
ITEM.group = "prelude_wanderers/wanderertabard";
ITEM.model = "models/begottenprelude/items/wanderertabard.mdl"
ITEM.iconoverride = "begottenprelude/ui/itemicons/wanderertabard.png"
ITEM.category = "Armor"
ITEM.conditionScale = 0.8
ITEM.hitParticle = "MetalSpark";
ITEM.protection = 35
ITEM.type = "chainmail";
ITEM.weight = 2.5;
ITEM.weightclass = "Light";
ITEM.description = "A torn, rusty sleeveless coat of mail with a colorless tabard alongside spare gambeson and rags, albeit unprotective around the arms. The armor of choice for an agile mercenary.";
ITEM.useSound = "armormovement/body-armor-b4.WAV.mp3";
ITEM.excludeFactions = {"Goreic Warrior"};

ITEM.effectiveLimbs = {
	[HITGROUP_GENERIC] = true,
	[HITGROUP_CHEST] = true,
	[HITGROUP_STOMACH] = true,
	[HITGROUP_LEFTLEG] = true,
	[HITGROUP_RIGHTLEG] = true,
	[HITGROUP_GEAR] = true
}

ITEM.bluntScale = 0.7; -- reduces blunt damage by 25%
ITEM.slashScale = 0.85; -- reduces slash damage by 10%
ITEM.bulletScale = 0.85; -- reduces bullet damage by 10%

ITEM.components = {breakdownType = "breakdown", items = {"iron_chunks", "iron_chunks", "leather", "leather", "cloth", "cloth"}};

-- Called when a replacement is needed for a player.
function ITEM:GetReplacement(player)

end;

ITEM.runSound = {
	"armormovement/body-hauberk-1.wav.mp3",
	"armormovement/body-hauberk-2.wav.mp3",
	"armormovement/body-hauberk-3.wav.mp3",
	"armormovement/body-hauberk-4.wav.mp3",
	"armormovement/body-hauberk-5.wav.mp3",
};

ITEM.walkSound = {
	"armormovement/body-hauberk-b4.wav.mp3",
	"armormovement/body-hauberk-b5.wav.mp3",
};

ITEM:Register();

local ITEM = Clockwork.item:New("clothes_base");
ITEM.name = "Wanderer Coat of Plates";
ITEM.group = "prelude_wanderers/coatofplates";
ITEM.model = "models/begotten_prelude/items/coatofplate.mdl"
ITEM.iconoverride = "materials/begotten_prelude/ui/itemicons/coatofplate.png"
ITEM.category = "Armor"
ITEM.conditionScale = 0.75
ITEM.hitParticle = "MetalSpark";
ITEM.protection = 60
ITEM.type = "chainmail";
ITEM.weight = 6;
ITEM.weightclass = "Medium";
ITEM.description = "A checkered waffenrock concealing a sturdy steel coat of plate, alongside a chainmail hauberk and mittens. Seen commonly among rich retainers of County District lords and mercenary retinues.";
ITEM.useSound = "armormovement/body-armor-b4.WAV.mp3";
ITEM.excludeFactions = {"Goreic Warrior"};

ITEM.effectiveLimbs = {
	[HITGROUP_GENERIC] = true,
	[HITGROUP_CHEST] = true,
	[HITGROUP_STOMACH] = true,
	[HITGROUP_LEFTARM] = true,
	[HITGROUP_RIGHTARM] = true,
	[HITGROUP_LEFTLEG] = true,
	[HITGROUP_RIGHTLEG] = true,
	[HITGROUP_GEAR] = true
}

ITEM.damageTypeScales = {
	[DMG_FALL] = -0.10, -- increases fall damage by 10%
}

ITEM.bluntScale = 0.85; -- reduces blunt damage by 10%
ITEM.pierceScale = 0.8; -- reduces pierce damage by 10%
ITEM.slashScale = 0.65; -- reduces slash damage by 30%
ITEM.bulletScale = 0.8; -- reduces bullet damage by 15%

ITEM.components = {breakdownType = "meltdown", items = {"fine_steel_chunks", "iron_chunks", "iron_chunks", "iron_chunks", "iron_chunks", "iron_chunks", "iron_chunks", "cloth", "cloth"}};

-- Called when a replacement is needed for a player.
function ITEM:GetReplacement(player)

end;

ITEM.runSound = {
	"armormovement/body-hauberk-1.wav.mp3",
	"armormovement/body-hauberk-2.wav.mp3",
	"armormovement/body-hauberk-3.wav.mp3",
	"armormovement/body-hauberk-4.wav.mp3",
	"armormovement/body-hauberk-5.wav.mp3",
};

ITEM.walkSound = {
	"armormovement/body-hauberk-b4.wav.mp3",
	"armormovement/body-hauberk-b5.wav.mp3",
};

ITEM:Register();

local ITEM = Clockwork.item:New("clothes_base");
ITEM.name = "Scrapper Foreman Armor";
ITEM.group = "wanderers/iconoclast";
ITEM.model = "models/begotten_prelude/items/iconoclast_armor.mdl"
ITEM.iconoverride = "materials/begottenprelude/ui/itemicons/iconoclast_armor.png"
ITEM.category = "Armor"
ITEM.conditionScale = 1
ITEM.hitParticle = "GlassImpact";
ITEM.protection = 50
ITEM.type = "leather";
ITEM.weight = 5;
ITEM.weightclass = "Medium";
ITEM.description = "The boiler suit of a Scrapper foreman and depth-diver, most commonly seen condemning underlings to forceful labor within scrap factories.";
ITEM.useSound = "armormovement/body-armor-b4.WAV.mp3";
ITEM.excludeSubfactions = {"Clan Gore", "Clan Harald", "Clan Reaver", "Clan Crast", "Clan Grock"};

ITEM.effectiveLimbs = {
	[HITGROUP_GENERIC] = true,
	[HITGROUP_CHEST] = true,
	[HITGROUP_STOMACH] = true,
	[HITGROUP_LEFTARM] = true,
	[HITGROUP_RIGHTARM] = true,
	[HITGROUP_LEFTLEG] = true,
	[HITGROUP_RIGHTLEG] = true,
	[HITGROUP_GEAR] = true
}

ITEM.damageTypeScales = {
	[DMG_FALL] = -0.10, -- increases fall damage by 10%
}

ITEM.bluntScale = 0.85; -- reduces blunt damage by 10%
ITEM.pierceScale = 0.85; -- reduces pierce damage by 10%
ITEM.slashScale = 0.7; -- reduces slash damage by 25%
ITEM.bulletScale = 0.75; -- reduces bullet damage by 20%
-- ITEM.insulation = 50; -- Adds 16% insulation. Armor only accounts for 80% of total insulation, helmets cover the rest of the 20%.

ITEM.components = {breakdownType = "breakdown", items = {"scrap", "scrap", "scrap", "scrap", "scrap", "leather", "leather", "cloth", "cloth", "cloth"}, xp = 30};

-- Called when a replacement is needed for a player.
function ITEM:GetReplacement(player)

end;

ITEM.runSound = {
	"armormovement/body-lobe-1.wav.mp3",
	"armormovement/body-lobe-2.wav.mp3",
	"armormovement/body-lobe-3.wav.mp3",
	"armormovement/body-lobe-4.wav.mp3",
	"armormovement/body-lobe-5.wav.mp3",
};

--[[ITEM.walkSound = {
	"armormovement/body-lobe-b1.wav.mp3",
	"armormovement/body-lobe-b2.wav.mp3",
};]]--

ITEM:Register();