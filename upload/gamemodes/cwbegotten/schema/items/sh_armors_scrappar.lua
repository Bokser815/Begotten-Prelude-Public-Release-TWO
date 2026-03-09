--[[
- LIGHT ARMOR MINIMUM VALUES

PROTECTION - 25

ITEM.bluntScale = 0.85; -- reduces blunt damage by 15%
ITEM.pierceScale = 0.95; -- reduces pierce damage by 5%
ITEM.slashScale = 0.90; -- reduces slash damage by 10%
ITEM.stabilityScale = 0.90; -- reduces stability damage by 10%

- MEDIUM ARMOR MINIMUM VALUES

PROTECTION - 40
FALL DAMAGE - +10%

ITEM.bluntScale = 0.85; -- reduces blunt damage by 15%
ITEM.pierceScale = 0.85; -- reduces pierce damage by 15%
ITEM.slashScale = 0.70; -- reduces slash damage by 30%
ITEM.stabilityScale = 0.80; -- reduces stability damage by 20%

- HEAVY ARMOR MINIMUM VALUES

PROTECTION - 65
FALL DAMAGE - +15%

ITEM.bluntScale = 0.85; -- reduces blunt damage by 15%
ITEM.pierceScale = 0.70; -- reduces pierce damage by 30%
ITEM.slashScale = 0.60; -- reduces slash damage by 40%
ITEM.bulletScale = 0.75; -- reduces bullet damage by 25%
ITEM.stabilityScale = 0.70; -- reduces stability damage by 30%

--]]

local ITEM = Clockwork.item:New("clothes_base");
ITEM.name = "Scrapper Ragsuit";
ITEM.model = "models/begottenprelude/items/scrapperharnessworld.mdl"
ITEM.iconoverride = "materials/begotten/ui/itemicons/scrapperharnessworld.png"
ITEM.helmetIconOverride = "materials/begotten/ui/itemicons/head/scrapperharnessworld.png"
ITEM.category = "Armor"
ITEM.concealsFace = true;
ITEM.conditionScale = 1.1
ITEM.hasHelmet = true;
ITEM.hitParticle = "GlassImpact";
ITEM.protection = 35
ITEM.type = "leather";
ITEM.weight = 2;
ITEM.weightclass = "Light";
ITEM.description = "A suit of tightly-wrapped cloth, plastic, leather, and whatever else a Scrapper can get their hands on. Without it, Ashland storms will gradually scour a Scrapper's skin.";
ITEM.useSound = "npc/combine_soldier/zipline_clothing2.wav";
ITEM.faction = "Piston's Scrappers";

ITEM.effectiveLimbs = {
	[HITGROUP_GENERIC] = true,
	[HITGROUP_HEAD] = true,
	[HITGROUP_CHEST] = true,
	[HITGROUP_STOMACH] = true,
	[HITGROUP_LEFTARM] = true,
	[HITGROUP_RIGHTARM] = true,
	[HITGROUP_LEFTLEG] = true,
	[HITGROUP_RIGHTLEG] = true,
	[HITGROUP_GEAR] = true
}

ITEM.bluntScale = 0.85; -- reduces blunt damage by 15%
ITEM.pierceScale = 0.95; -- reduces pierce damage by 5%
ITEM.slashScale = 0.90; -- reduces slash damage by 10%
ITEM.stabilityScale = 0.90; -- reduces stability damage by 10%
ITEM.bulletScale = 0.90; -- reduces bullet damage by 10%
ITEM.insulation = 30;

ITEM.components = {breakdownType = "breakdown", items = {"iron_chunks", "leather", "leather", "cloth", "cloth"}};

-- Called when a replacement is needed for a player.
function ITEM:GetReplacement(player)
	return "models/begottenprelude/wanderers/scrapperharness_male.mdl";
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

local ITEM = Clockwork.item:New("clothes_base");
ITEM.name = "Scrapper Slicksuit";
ITEM.model = "models/begottenprelude/items/scrapperskink.mdl"
ITEM.iconoverride = "materials/begotten/ui/itemicons/scrapperskink.png"
ITEM.helmetIconOverride = "materials/begotten/ui/itemicons/head/scrapperskink.png"
ITEM.category = "Armor"
ITEM.concealsFace = true;
ITEM.conditionScale = 1.3
ITEM.hasHelmet = true;
ITEM.hitParticle = "GlassImpact";
ITEM.protection = 30
ITEM.type = "leather";
ITEM.weight = 3;
ITEM.weightclass = "Light";
ITEM.description = "A Scrapper Ragsuit soaked in oil, and wrapped in even more cloth. While a bit heavier, it seems to withstand the Ashland conditions significantly longer.";
ITEM.useSound = "npc/combine_soldier/zipline_clothing2.wav";
ITEM.faction = "Piston's Scrappers";

ITEM.effectiveLimbs = {
	[HITGROUP_GENERIC] = true,
	[HITGROUP_HEAD] = true,
	[HITGROUP_CHEST] = true,
	[HITGROUP_STOMACH] = true,
	[HITGROUP_LEFTARM] = true,
	[HITGROUP_RIGHTARM] = true,
	[HITGROUP_LEFTLEG] = true,
	[HITGROUP_RIGHTLEG] = true,
	[HITGROUP_GEAR] = true
}

ITEM.bluntScale = 0.85; -- reduces blunt damage by 15%
ITEM.pierceScale = 0.95; -- reduces pierce damage by 5%
ITEM.slashScale = 0.90; -- reduces slash damage by 10%
ITEM.stabilityScale = 0.90; -- reduces stability damage by 10%
ITEM.bulletScale = 0.90; -- reduces bullet damage by 10%
ITEM.insulation = 30;

ITEM.components = {breakdownType = "breakdown", items = {"iron_chunks", "leather", "leather", "cloth", "cloth"}};

-- Called when a replacement is needed for a player.
function ITEM:GetReplacement(player)
	return "models/begottenprelude/wanderers/scrapperskink_male.mdl";
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


local ITEM = Clockwork.item:New("clothes_base");
ITEM.name = "Scrapper Spikeplate";
ITEM.model = "models/begottenprelude/items/scrapperspiked.mdl"
ITEM.iconoverride = "materials/begotten/ui/itemicons/scrapper_spikeplate.png"
ITEM.helmetIconOverride = "materials/begotten/ui/itemicons/head/scrapperspiked.png"
ITEM.category = "Armor"
ITEM.concealsFace = true;
ITEM.conditionScale = 0.75
ITEM.hasHelmet = true;
ITEM.hitParticle = "MetalSpark";
ITEM.protection = 50
ITEM.type = "plate";
ITEM.weight = 5;
ITEM.weightclass = "Medium";
ITEM.description = "A Scrapper Ragsuit with some spiked protrusions atop crude plating.";
ITEM.useSound = "armormovement/body-armor-b4.WAV.mp3";
ITEM.faction = "Piston's Scrappers";

ITEM.effectiveLimbs = {
	[HITGROUP_GENERIC] = true,
	[HITGROUP_CHEST] = true,
	[HITGROUP_HEAD] = true,
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

ITEM.bluntScale = 0.85; -- reduces blunt damage by 15%
ITEM.pierceScale = 0.85; -- reduces pierce damage by 15%
ITEM.slashScale = 0.70; -- reduces slash damage by 30%
ITEM.stabilityScale = 0.80; -- reduces stability damage by 20%
ITEM.bulletScale = 0.85; -- reduces bullet damage by 15%
ITEM.insulation = 35;

ITEM.components = {breakdownType = "meltdown", items = {"iron_chunks", "iron_chunks", "iron_chunks", "iron_chunks", "iron_chunks", "iron_chunks", "iron_chunks"}};

-- Called when a replacement is needed for a player.
function ITEM:GetReplacement(player)
	return "models/begottenprelude/wanderers/scrapperspiked_male.mdl";
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
ITEM.name = "Scrapper Glazeplate";
ITEM.model = "models/begottenprelude/items/scrapperlightworld.mdl"
ITEM.iconoverride = "materials/begotten/ui/itemicons/scrapperlightworld.png"
ITEM.helmetIconOverride = "materials/begotten/ui/itemicons/head/scrapperlightworld.png"
ITEM.category = "Armor"
ITEM.concealsFace = true;
ITEM.conditionScale = 0.75
ITEM.hasHelmet = true;
ITEM.hitParticle = "MetalSpark";
ITEM.protection = 65
ITEM.type = "chainmail";
ITEM.weight = 5;
ITEM.weightclass = "Medium";
ITEM.description = "A Scrapper Ragsuit armored in the image of the Gatekeeper. Whether this is a purely utilitarian choice, or to honor the Glaze, one cannot be certain.";
ITEM.useSound = "armormovement/body-armor-b4.WAV.mp3";
ITEM.faction = "Piston's Scrappers";
ITEM.overlay = "begotten/zomboverlay/gatekeep1";

ITEM.effectiveLimbs = {
	[HITGROUP_GENERIC] = true,
	[HITGROUP_CHEST] = true,
	[HITGROUP_HEAD] = true,
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

ITEM.bluntScale = 0.85; -- reduces blunt damage by 15%
ITEM.pierceScale = 0.85; -- reduces pierce damage by 15%
ITEM.slashScale = 0.70; -- reduces slash damage by 30%
ITEM.stabilityScale = 0.80; -- reduces stability damage by 20%
ITEM.bulletScale = 0.85; -- reduces bullet damage by 15%
ITEM.insulation = 35;

ITEM.components = {breakdownType = "meltdown", items = {"iron_chunks", "iron_chunks", "iron_chunks", "iron_chunks", "iron_chunks", "iron_chunks", "iron_chunks"}};

-- Called when a replacement is needed for a player.
function ITEM:GetReplacement(player)
	return "models/begottenprelude/wanderers/scrapperlightarmor.mdl";
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
ITEM.name = "Scrapper Darkplate";
ITEM.model = "models/begottenprelude/items/scrapperdarkworld.mdl"
ITEM.iconoverride = "materials/begotten/ui/itemicons/scrapperdarkworld.png"
ITEM.helmetIconOverride = "materials/begotten/ui/itemicons/head/scrapperdarkworld.png"
ITEM.category = "Armor"
ITEM.concealsFace = true;
ITEM.conditionScale = 0.75
ITEM.hasHelmet = true;
ITEM.hitParticle = "MetalSpark";
ITEM.protection = 70
ITEM.type = "chainmail";
ITEM.weight = 5;
ITEM.weightclass = "Medium";
ITEM.description = "A Scrapper Ragsuit utilizing discarded unholy steel and spiked plate. This armor is proof that even those with the Dark God's boon can be felled by Scrapper ingenuity.";
ITEM.useSound = "armormovement/body-armor-b4.WAV.mp3";
ITEM.faction = "Piston's Scrappers";
ITEM.overlay = "begotten/zomboverlay/gatekeep1";

ITEM.effectiveLimbs = {
	[HITGROUP_GENERIC] = true,
	[HITGROUP_CHEST] = true,
	[HITGROUP_HEAD] = true,
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

ITEM.bluntScale = 0.85; -- reduces blunt damage by 15%
ITEM.pierceScale = 0.85; -- reduces pierce damage by 15%
ITEM.slashScale = 0.70; -- reduces slash damage by 30%
ITEM.stabilityScale = 0.80; -- reduces stability damage by 20%
ITEM.bulletScale = 0.85; -- reduces bullet damage by 15%
ITEM.insulation = 35;

ITEM.components = {breakdownType = "meltdown", items = {"gold_ingot", "gold_ingot", "fine_steel_chunks", "iron_chunks", "iron_chunks", "iron_chunks", "iron_chunks"}};

-- Called when a replacement is needed for a player.
function ITEM:GetReplacement(player)
	return "models/begottenprelude/wanderers/scrapperdarkarmor.mdl";
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
ITEM.name = "Scrapper Bossplate";
ITEM.model = "models/begottenprelude/items/scrapperbossworld.mdl"
ITEM.iconoverride = "materials/begotten/ui/itemicons/scrapperbossworld.png"
ITEM.helmetIconOverride = "materials/begotten/ui/itemicons/head/scrapperbossworld.png"
ITEM.category = "Armor"
ITEM.conditionScale = 0.75
ITEM.concealsFace = true;
ITEM.hasHelmet = true;
ITEM.hitParticle = "MetalSpark";
ITEM.protection = 80;
ITEM.weight = 8;
ITEM.weightclass = "Heavy";
ITEM.type = "plate";
ITEM.description = "An unmistakeable set of Scrapper Bossplate. Merely the sight of the Bossplate can turn a battle, simply because most Scrappers fear their Boss more than their foe.";
ITEM.useSound = "armormovement/body-armor-b4.WAV.mp3";
ITEM.faction = "Piston's Scrappers";
ITEM.overlay = "begotten/zomboverlay/gatekeep1";

ITEM.requiredbeliefs = {"hauberk"};

ITEM.effectiveLimbs = {
	[HITGROUP_GENERIC] = true,
	[HITGROUP_HEAD] = true,
	[HITGROUP_CHEST] = true,
	[HITGROUP_STOMACH] = true,
	[HITGROUP_LEFTARM] = true,
	[HITGROUP_RIGHTARM] = true,
	[HITGROUP_LEFTLEG] = true,
	[HITGROUP_RIGHTLEG] = true,
	[HITGROUP_GEAR] = true
}

ITEM.damageTypeScales = {
	[DMG_FALL] = -0.15, -- increases fall damage by 15%
}

ITEM.bluntScale = 0.85; -- reduces blunt damage by 15%
ITEM.pierceScale = 0.70; -- reduces pierce damage by 30%
ITEM.slashScale = 0.60; -- reduces slash damage by 40%
ITEM.bulletScale = 0.75; -- reduces bullet damage by 25%
ITEM.stabilityScale = 0.70; -- reduces stability damage by 30%
ITEM.insulation = 50;

ITEM.components = {breakdownType = "meltdown", items = {"steel_chunks", "steel_chunks", "steel_chunks", "steel_chunks", "leather", "cloth", "cloth"}};

-- Called when a replacement is needed for a player.
function ITEM:GetReplacement(player)
	return "models/begottenprelude/wanderers/scrapperbossarmor.mdl";
end;

ITEM.runSound = {
	"armormovement/body-armor-1.WAV.mp3",
	"armormovement/body-armor-2.WAV.mp3",
	"armormovement/body-armor-3.WAV.mp3",
	"armormovement/body-armor-4.WAV.mp3",
	"armormovement/body-armor-5.WAV.mp3",
	"armormovement/body-armor-6.WAV.mp3",
};

ITEM.walkSound = {
	"armormovement/body-armor-b4.WAV.mp3",
	"armormovement/body-armor-b5.WAV.mp3",
};

ITEM:Register();
