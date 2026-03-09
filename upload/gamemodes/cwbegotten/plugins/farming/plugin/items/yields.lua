--[[
	Begotten Code
--]]

-- temp food items to test out farming system
local ITEM = Clockwork.item:New();
	ITEM.name = "Agave";
	ITEM.model = "models/mosi/fnv/props/plants/nevadaagave.mdl";
	ITEM.plural = "Agave";
	ITEM.useText = "Eat";
	ITEM.weight = 0.25;
	ITEM.description = "Some yummy agave!";
	ITEM.uniqueID = "agave";
	ITEM.stackable = true;
    ITEM.needs = {hunger = 5, thirst = 10};

	-- Called when a player uses the item.
	function ITEM:OnUse(player, itemEntity)
        Schema:EasyText(player, "olive", "You chomp down on some agave slices.");
		player:HandleXP(cwBeliefs.xpValues["food"]);
	end;

	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
ITEM:Register();

local ITEM = Clockwork.item:New();
	ITEM.name = "Maize";
	ITEM.model = "models/mosi/fnv/props/maize.mdl";
	ITEM.plural = "Maize";
	ITEM.useText = "Eat";
	ITEM.weight = 0.40;
	ITEM.description = "Plump kernels of maize, offering a satisfying crunch and sweet flavor.";
	ITEM.useSound = "npc/barnacle/barnacle_crunch3.wav";
	ITEM.uniqueID = "maize";
	ITEM.stackable = true;
    ITEM.needs = {hunger = 45, thirst = 5};

	-- Called when a player uses the item.
	function ITEM:OnUse(player, itemEntity)
        Schema:EasyText(player, "olive", "You munch on the golden kernels of maize, savoring their sweet crunch.");
		player:HandleXP(cwBeliefs.xpValues["food"]);
	end;

	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
ITEM:Register();

local ITEM = Clockwork.item:New();
ITEM.name = "Wheat";
ITEM.model = "models/mosi/fnv/props/brocflower.mdl";
ITEM.plural = "Wheat";
ITEM.weight = 0.20;
ITEM.description = "Clusters of golden wheat, promising the aroma of freshly baked bread.";
ITEM.uniqueID = "wheat";
ITEM.stackable = true;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;
ITEM:Register();

-- Fungus
local ITEM = Clockwork.item:New();
ITEM.name = "Fungus";
ITEM.model = "models/mosi/fnv/props/plants/cavefungus.mdl";
ITEM.plural = "Fungi";
ITEM.useText = "Eat";
ITEM.weight = 0.20;
ITEM.description = "Strange fungi with an earthy taste, offering a culinary adventure";
ITEM.useSound = "npc/barnacle/barnacle_crunch3.wav";
ITEM.uniqueID = "fungus";
ITEM.stackable = true;
ITEM.needs = {hunger = 8, thirst = 2};

function ITEM:OnUse(player, itemEntity)
    Schema:EasyText(player, "olive", "You nibble on the strange fungus, its earthy flavor tingling on your tongue.");
    player:HandleXP(cwBeliefs.xpValues["food"]);
end;

function ITEM:OnDrop(player, position) end;
ITEM:Register();

-- Fungus Soup
local ITEM = Clockwork.item:New();
ITEM.name = "Fungus Soup";
ITEM.model = "models/props_clutter/wooden_bowl.mdl";
ITEM.plural = "Fungi";
ITEM.useText = "Eat";
ITEM.weight = 0.5;
ITEM.description = "A steaming bowl of hearty fungus soup, swirling with savory flavors";
ITEM.useSound = "npc/barnacle/barnacle_crunch2.wav";
ITEM.uniqueID = "fungus_soup";
ITEM.stackable = true;
ITEM.needs = {hunger = 65, thirst = 20};

function ITEM:OnUse(player, itemEntity)
    Schema:EasyText(player, "olive", "You spoon up the hearty fungus soup, its savory warmth comforting your senses.");
    player:HandleXP(cwBeliefs.xpValues["food"]);
end;

function ITEM:OnDrop(player, position) end;
ITEM:Register();

-- Cotton
local ITEM = Clockwork.item:New();
ITEM.name = "Cotton";
ITEM.model = "models/props_clutter/coin_bag_mid.mdl"; 
ITEM.plural = "Cotton";
ITEM.useText = "Eat";
ITEM.weight = 0.40;
ITEM.description = "Soft balls of cotton, ready to be spun into cloth.";
ITEM.uniqueID = "cotton";
ITEM.stackable = true;

function ITEM:OnDrop(player, position) end;
ITEM:Register();

-- Tobacco
local ITEM = Clockwork.item:New();
ITEM.name = "Tobacco";
ITEM.model = "models/mosi/fnv/props/coyotetobacco.mdl";
ITEM.plural = "Tobacco Leaves";
ITEM.useText = "Smoke";
ITEM.weight = 0.20;
ITEM.description = "Dried tobacco leaves, exuding a rich and earthy aroma.";
ITEM.uniqueID = "tobacco";
ITEM.stackable = true;


function ITEM:OnDrop(player, position) end;
ITEM:Register();

