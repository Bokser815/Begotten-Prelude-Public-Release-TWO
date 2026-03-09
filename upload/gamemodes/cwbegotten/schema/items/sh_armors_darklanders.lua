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
ITEM.name = "Darklander Plated Mail";
ITEM.group = "prelude_darklanders/mordhaueast";
ITEM.model = "models/begotten_prelude/items/mordhaueast.mdl"
ITEM.iconoverride = "materials/begottenprelude/ui/itemicons/mordhaueast.png"
ITEM.category = "Armor"
ITEM.conditionScale = 0.75
ITEM.hitParticle = "MetalSpark";
ITEM.protection = 55
ITEM.type = "chainmail";
ITEM.weight = 5;
ITEM.weightclass = "Medium";
ITEM.description = "Interlinked mail with sets of small metal plates to halt blades, originating from Darklandic forges where the slaves labor til their last breath.";
ITEM.useSound = "armormovement/body-armor-b4.WAV.mp3";
ITEM.excludeFactions = {"Goreic Warrior"};
ITEM.faction = "Darklander";

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
ITEM.bulletScale = 0.85; -- reduces bullet damage by 10%
ITEM.insulation = 65;
ITEM.components = {breakdownType = "meltdown", items = {"iron_chunks", "iron_chunks", "iron_chunks", "iron_chunks", "iron_chunks", "iron_chunks", "iron_chunks"}, xp = 30};

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
ITEM.name = "Darklander Scale Armor";
ITEM.group = "prelude_darklanders/mordhaurus";
ITEM.model = "models/begotten_prelude/items/mordhaurus.mdl"
ITEM.iconoverride = "materials/begottenprelude/ui/itemicons/mordhaurus.png"
ITEM.category = "Armor"
ITEM.conditionScale = 0.75
ITEM.hitParticle = "MetalSpark";
ITEM.protection = 65
ITEM.type = "chainmail";
ITEM.weight = 6;
ITEM.weightclass = "Medium";
ITEM.description = "A set of finely constructed plating, made of partially blackened steel scales binded together alongside a coat of chainmail.";
ITEM.useSound = "armormovement/body-armor-b4.WAV.mp3";
ITEM.excludeFactions = {"Goreic Warrior"};
ITEM.faction = "Darklander";

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
ITEM.insulation = 60;
ITEM.components = {breakdownType = "meltdown", items = {"fine_steel_chunks", "iron_chunks", "iron_chunks", "iron_chunks", "iron_chunks", "iron_chunks", "iron_chunks", "iron_chunks"}, xp = 30};

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


ITEM = Clockwork.item:New("clothes_base");
ITEM.name = "Darklander Paighani Wear";
ITEM.group = "prelude_darklanders/nazir";
ITEM.uniqueID = "paighani_wear"
ITEM.model = "models/begottenprelude/items/nazir.mdl"
ITEM.iconoverride = "begottenprelude/ui/itemicons/nazir.png"
ITEM.category = "Armor"
ITEM.conditionScale = 1.1
ITEM.hitParticle = "GlassImpact";
ITEM.protection = 35
ITEM.type = "leather";
ITEM.weight = 2;
ITEM.weightclass = "Light";
ITEM.description = "Blue and yellow cloths from the Spicelands, worn by its common guards and footmen.";
ITEM.useSound = "npc/combine_soldier/zipline_clothing2.wav";
ITEM.excludeFactions = {"Goreic Warrior"};
ITEM.faction = "Darklander";

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

ITEM.bluntScale = 0.6; -- reduces blunt damage by 35%
ITEM.slashScale = 0.85; -- reduces slash damage by 10%
ITEM.stabilityScale = 0.10; -- reduces stability damage by 10%
ITEM.insulation = 50;
ITEM.components = {breakdownType = "breakdown", items = {"iron_chunks", "leather", "leather", "cloth", "cloth", "cloth"}, xp = 30};

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

local ITEM = Clockwork.item:New("clothes_base");
ITEM.name = "Darklander Elite Cataphract Plate";
ITEM.model = "models/begotten_prelude/items/colovian.mdl"
ITEM.iconoverride = "materials/begottenprelude/ui/itemicons/colovian.png"
ITEM.helmetIconOverride = "materials/begottenprelude/ui/itemicons/colovianprince.png"
ITEM.category = "Armor"
ITEM.concealsFace = true;
ITEM.conditionScale = 0.75
ITEM.hasHelmet = true;
ITEM.hitParticle = "MetalSpark";
ITEM.protection = 80;
ITEM.weight = 8.5;
ITEM.weightclass = "Heavy";
ITEM.type = "plate";
ITEM.description = "A reinforced musculata-adorned set of steel plate covered in elegant cloths, and exotic furs. The choice wear of a Darklander mercenary captain.";
ITEM.useSound = "armormovement/body-armor-b4.WAV.mp3";
ITEM.excludeFactions = {"Goreic Warrior"};
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

ITEM.bluntScale = 0.9; -- reduces blunt damage by 5%
ITEM.pierceScale = 0.8; -- reduces pierce damage by 15%
ITEM.slashScale = 0.65; -- reduces slash damage by 30%
ITEM.bulletScale = 0.7; -- reduces bullet damage by 25%
ITEM.insulation = 75;
ITEM.components = {breakdownType = "meltdown", items = {"steel_chunks", "steel_chunks", "steel_chunks", "steel_chunks", "steel_chunks", "steel_chunks", "cloth", "cloth"}, xp = 30};

-- Called when a replacement is needed for a player.
function ITEM:GetReplacement(player)
	--if (player:GetGender() == GENDER_FEMALE) then
		return "models/begottenprelude/darklanders/colovianprince.mdl";
	--else
		--return "models/begotten/gatekeepers/highgatekeeper02.mdl";
	--end;
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

local ITEM = Clockwork.item:New("clothes_base");
ITEM.name = "Darklander Cataphract Plate";
ITEM.model = "models/begotten_prelude/items/kvetchi.mdl"
ITEM.iconoverride = "materials/begottenprelude/ui/itemicons/kvetchi.png"
ITEM.helmetIconOverride = "materials/begottenprelude/ui/itemicons/kvetchimerc.png"
ITEM.category = "Armor"
ITEM.concealsFace = true;
ITEM.conditionScale = 0.75
ITEM.hasHelmet = true;
ITEM.hitParticle = "MetalSpark";
ITEM.protection = 75;
ITEM.weight = 8;
ITEM.weightclass = "Heavy";
ITEM.type = "plate";
ITEM.description = "A set of steel plate forged with constant tears and bloodletting by Darklandic slaves, said to enhance its protection.";
ITEM.useSound = "armormovement/body-armor-b4.WAV.mp3";
ITEM.excludeFactions = {"Goreic Warrior"};
ITEM.overlay = "begotten/zomboverlay/gatekeep1";
ITEM.insulation = 70;
ITEM.requiredbeliefs = {"hauberk"};

-- specifies which hitgroups will be affected by blunt, slash, pierce and other damage type scaling.
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
	[DMG_FALL] = -0.13, -- increases fall damage by 13%
}

ITEM.bluntScale = 0.9; -- reduces blunt damage by 5%
ITEM.pierceScale = 0.8; -- reduces pierce damage by 15%
ITEM.slashScale = 0.65; -- reduces slash damage by 30%
ITEM.bulletScale = 0.7; -- reduces bullet damage by 25%

ITEM.components = {breakdownType = "meltdown", items = {"steel_chunks", "steel_chunks", "steel_chunks", "iron_chunks", "iron_chunks", "iron_chunks", "cloth", "cloth"}, xp = 30};

-- Called when a replacement is needed for a player.
function ITEM:GetReplacement(player)
	--if (player:GetGender() == GENDER_FEMALE) then
	return "models/begottenprelude/darklanders/kvetchimerc.mdl";
	--else
		--return "models/begotten/gatekeepers/highgatekeeper01.mdl";
	--end;
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

local ITEM = Clockwork.item:New("clothes_base");
ITEM.name = "Yellow Mage Robes";
ITEM.model = "models/begotten_prelude/items/mage.mdl"
ITEM.iconoverride = "materials/begottenprelude/ui/itemicons/mage.png"
ITEM.helmetIconOverride = "materials/begottenprelude/ui/itemicons/mageset.png"
ITEM.category = "Armor"
ITEM.concealsFace = true;
ITEM.conditionScale = 0.75
ITEM.hasHelmet = true;
ITEM.hitParticle = "MetalSpark";
ITEM.type = "plate";
ITEM.description = "The ornate yellow mail and cloth of the Yellow Mages - a heretic order nestled deep within the Nigerii Empire. They inspire entire companies of men to battle.";
ITEM.useSound = "armormovement/body-armor-b4.WAV.mp3";
ITEM.excludeFactions = {"Goreic Warrior"};
ITEM.overlay = "begotten/zomboverlay/gatekeep1";

ITEM.protection = 50
ITEM.type = "leather";
ITEM.weight = 2;
ITEM.weightclass = "Light";

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

ITEM.bluntScale = 0.65; -- reduces blunt damage by 30%
ITEM.pierceScale = 0.9; -- reduces pierce damage by 5%
ITEM.slashScale = 0.9; -- reduces slash damage by 5%
ITEM.bulletScale = 0.65; -- reduces bullet damage by 30%
ITEM.insulation = 65;
ITEM.components = {breakdownType = "breakdown", items = {"fine_steel_chunks", "cloth", "cloth", "cloth", "cloth", "cloth", "cloth"}, xp = 30};

-- Called when a replacement is needed for a player.
function ITEM:GetReplacement(player)
	return "models/begottenprelude/darklanders/mageset.mdl";
end;

ITEM.runSound = {
    "armormovement/body-lobe-1.wav.mp3",
    "armormovement/body-lobe-2.wav.mp3",
    "armormovement/body-lobe-3.wav.mp3",
    "armormovement/body-lobe-4.wav.mp3",
    "armormovement/body-lobe-5.wav.mp3",
};

ITEM:Register();

-- deadlanders

local ITEM = Clockwork.item:New("clothes_base");
ITEM.name = "Deadlander Rider Lamellar";
ITEM.group = "prelude_deadlanders/khuzaitsoldier";
ITEM.model = "models/begotten_prelude/items/khuzaitsoldier.mdl"
ITEM.iconoverride = "materials/begottenprelude/ui/itemicons/khuzaitsoldier.png"
ITEM.category = "Armor"
ITEM.conditionScale = 1.1
ITEM.hitParticle = "GlassImpact";
ITEM.protection = 40
ITEM.type = "leather";
ITEM.weight = 2;
ITEM.weightclass = "Light";
ITEM.description = "The white fur-lined coat and leather lamellar of the Deadlander steppe warriors. Light for speed and mobility as they pursue targets.";
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

ITEM.bluntScale = 0.65; -- reduces blunt damage by 30%
ITEM.pierceScale = 0.9; -- reduces pierce damage by 5%
ITEM.slashScale = 0.9; -- reduces slash damage by 5%
ITEM.insulation = 50;
ITEM.components = {breakdownType = "breakdown", items = {"fine_steel_chunks", "cloth", "cloth", "cloth", "cloth", "cloth", "cloth"}, xp = 30};

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

local ITEM = Clockwork.item:New("clothes_base");
ITEM.name = "Deadlander Khan Lamellar";
ITEM.group = "prelude_deadlanders/khuzaitlord";
ITEM.model = "models/begotten_prelude/items/khuzaitlord.mdl"
ITEM.iconoverride = "materials/begottenprelude/ui/itemicons/khuzaitlord.png"
ITEM.category = "Armor"
ITEM.conditionScale = 0.75
ITEM.hitParticle = "MetalSpark";
ITEM.protection = 65
ITEM.type = "chainmail";
ITEM.weight = 6;
ITEM.weightclass = "Medium";
ITEM.description = "Armor befit for a Khan. This lamellar is used by Deadlandic horde commanders, feared for their tactics just as they are feared for their riding excellence.";
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
ITEM.insulation = 50;
ITEM.components = {breakdownType = "meltdown", items = {"fine_steel_chunks", "iron_chunks", "iron_chunks", "iron_chunks", "iron_chunks", "iron_chunks", "iron_chunks", "iron_chunks"}, xp = 30};

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