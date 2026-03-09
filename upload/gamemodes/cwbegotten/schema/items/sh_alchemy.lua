local ITEM = Clockwork.item:New(nil, true);
	ITEM.name = "Empty Vial";
	ITEM.uniqueID = "empty_vial";
	ITEM.model = "models/shells/shell_338mag.mdl";
	ITEM.weight = 0.02;
	ITEM.category = "Alchemy";
	ITEM.description = "A tiny vial made out of a shell casing.";
	ITEM.stackable = true;
	ITEM.iconoverride = "materials/begotten/ui/itemicons/longshot.png";

	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
ITEM:Register();

local ITEM = Clockwork.item:New(nil, true);
	ITEM.name = "Vial of Blood";
	ITEM.uniqueID = "vial_of_blood";
	ITEM.isAlchemyItem = true;
	ITEM.model = "models/shells/shell_338mag.mdl";
	ITEM.weight = 0.2;
	ITEM.category = "Alchemy";
	ITEM.description = "A tiny vial made out of a shell casing. It is filled with blood.";
	ITEM.smell = "copper" -- describe using short sentence. see other items for examples
	ITEM.stackable = true;
	ITEM.explodesWith = {"Dark Fungus"};
	ITEM.customFunctions = {"Smell"};
	ITEM.iconoverride = "materials/begotten/ui/itemicons/longshot.png";

	function ITEM:OnCustomFunction(player, name)
		if (name == "Smell") then
			Schema:EasyText(player, "olivedrab", "As you smell the "..self.name..", the scent of "..self.smell.." fills your nostrils.");
		end;
	end;

	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
ITEM:Register();

local ITEM = Clockwork.item:New(nil, true);
	ITEM.name = "Vial of Tainted Blood";
	ITEM.uniqueID = "vial_of_tainted_blood";
	ITEM.isAlchemyItem = true;
	ITEM.model = "models/shells/shell_338mag.mdl";
	ITEM.weight = 0.2;
	ITEM.category = "Alchemy";
	ITEM.description = "A tiny vial made out of a shell casing. It is filled with a very dark, almost black blood.";
	ITEM.smell = "copper with a hint of smoke" -- describe using short sentence. see other items for examples
	ITEM.stackable = true;
	ITEM.explodesWith = {"Bleached Fungus"};
	ITEM.customFunctions = {"Smell"};
	ITEM.iconoverride = "materials/begotten/ui/itemicons/longshot.png";

	function ITEM:OnCustomFunction(player, name)
		if (name == "Smell") then
			Schema:EasyText(player, "olivedrab", "As you smell the "..self.name..", the scent of "..self.smell.." fills your nostrils.");
		end;
	end;

	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
ITEM:Register();

local ITEM = Clockwork.item:New(nil, true);
	ITEM.name = "Vial of Liquid Gold";
	ITEM.uniqueID = "vial_of_liquid_gold";
	ITEM.isAlchemyItem = false;
	ITEM.isTransmutationCompoundIngredient = true;
	ITEM.model = "models/shells/shell_338mag.mdl";
	ITEM.weight = 0.52;
	ITEM.category = "Alchemy";
	ITEM.description = "A tiny vial made out of a shell casing. It is filled with liquid gold.";
	ITEM.smell = "metal" -- describe using short sentence. see other items for examples
	ITEM.stackable = true;
	ITEM.customFunctions = {"Smell"};
	ITEM.iconoverride = "materials/begotten/ui/itemicons/longshot.png";

	function ITEM:OnCustomFunction(player, name)
		if (name == "Smell") then
			Schema:EasyText(player, "olivedrab", "As you smell the "..self.name..", the scent of "..self.smell.." fills your nostrils.");
		end;
	end;

	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
ITEM:Register();

local ITEM = Clockwork.item:New(nil, true);
	ITEM.name = "Vial of Liquid Steel";
	ITEM.uniqueID = "vial_of_liquid_steel";
	ITEM.isAlchemyItem = false;
	ITEM.isTransmutationCompoundIngredient = true;
	ITEM.model = "models/shells/shell_338mag.mdl";
	ITEM.weight = 0.152;
	ITEM.category = "Alchemy";
	ITEM.description = "A tiny vial made out of a shell casing. It is filled with liquid steel.";
	ITEM.smell = "metal" -- describe using short sentence. see other items for examples
	ITEM.stackable = true;
	ITEM.customFunctions = {"Smell"};
	ITEM.iconoverride = "materials/begotten/ui/itemicons/longshot.png";

	function ITEM:OnCustomFunction(player, name)
		if (name == "Smell") then
			Schema:EasyText(player, "olivedrab", "As you smell the "..self.name..", the scent of "..self.smell.." fills your nostrils.");
		end;
	end;

	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
ITEM:Register();

local ITEM = Clockwork.item:New(nil, true);
	ITEM.name = "Vial of Liquid Fine Steel";
	ITEM.uniqueID = "vial_of_liquid_fine_steel";
	ITEM.isAlchemyItem = false;
	ITEM.isTransmutationCompoundIngredient = true;
	ITEM.model = "models/shells/shell_338mag.mdl";
	ITEM.weight = 0.152;
	ITEM.category = "Alchemy";
	ITEM.description = "A tiny vial made out of a shell casing. It is filled with liquid fine steel.";
	ITEM.smell = "metal" -- describe using short sentence. see other items for examples
	ITEM.stackable = true;
	ITEM.customFunctions = {"Smell"};
	ITEM.iconoverride = "materials/begotten/ui/itemicons/longshot.png";

	function ITEM:OnCustomFunction(player, name)
		if (name == "Smell") then
			Schema:EasyText(player, "olivedrab", "As you smell the "..self.name..", the scent of "..self.smell.." fills your nostrils.");
		end;
	end;

	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
ITEM:Register();

local ITEM = Clockwork.item:New(nil, true);
	ITEM.name = "Vial of Liquid Shagalaxian Steel";
	ITEM.uniqueID = "vial_of_liquid_shagalaxian_steel";
	ITEM.isAlchemyItem = false;
	ITEM.isTransmutationCompoundIngredient = true;
	ITEM.model = "models/shells/shell_338mag.mdl";
	ITEM.weight = 0.152;
	ITEM.category = "Alchemy";
	ITEM.description = "A tiny vial made out of a shell casing. It is filled with liquid Shagalaxian steel.";
	ITEM.smell = "metal" -- describe using short sentence. see other items for examples
	ITEM.stackable = true;
	ITEM.customFunctions = {"Smell"};
	ITEM.iconoverride = "materials/begotten/ui/itemicons/longshot.png";

	function ITEM:OnCustomFunction(player, name)
		if (name == "Smell") then
			Schema:EasyText(player, "olivedrab", "As you smell the "..self.name..", the scent of "..self.smell.." fills your nostrils.");
		end;
	end;

	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
ITEM:Register();

local ITEM = Clockwork.item:New(nil, true);
	ITEM.name = "Vial of Liquid Maximilian Steel";
	ITEM.uniqueID = "vial_of_liquid_maximilian_steel";
	ITEM.isAlchemyItem = false;
	ITEM.isTransmutationCompoundIngredient = true;
	ITEM.model = "models/shells/shell_338mag.mdl";
	ITEM.weight = 0.152;
	ITEM.category = "Alchemy";
	ITEM.description = "A tiny vial made out of a shell casing. It is filled with liquid Maximilian steel.";
	ITEM.smell = "metal" -- describe using short sentence. see other items for examples
	ITEM.stackable = true;
	ITEM.customFunctions = {"Smell"};
	ITEM.iconoverride = "materials/begotten/ui/itemicons/longshot.png";

	function ITEM:OnCustomFunction(player, name)
		if (name == "Smell") then
			Schema:EasyText(player, "olivedrab", "As you smell the "..self.name..", the scent of "..self.smell.." fills your nostrils.");
		end;
	end;

	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
ITEM:Register();

local ITEM = Clockwork.item:New(nil, true);
	ITEM.name = "Green Capsule";
	ITEM.uniqueID = "green_capsule";
	ITEM.isAlchemyItem = true;
	ITEM.isTransmutationCompoundIngredient = false;
	ITEM.model = "models/shells/shell_338mag.mdl";
	ITEM.weight = 0.152;
	ITEM.category = "Alchemy";
	ITEM.description = "A small, pill-like capsule with a green spotty texture.";
	ITEM.smell = "peppermint" -- describe using short sentence. see other items for examples
	ITEM.stackable = true;
	ITEM.customFunctions = {"Smell"};
	ITEM.iconoverride = "materials/begotten/ui/itemicons/longshot.png";

	function ITEM:OnUse(player, itemEntity)
		local brainSize = player:GetCharacterData("brainsize", 0);

		if not brainSize then
			brainSize = 0;
		end;

		if brainSize == 1 then
			player:GiveDisease("brain_bleeding");
		elseif brainSize == 2 then
			player:ScriptedDeath("Died due to their brain crushing itself against their skull.")
			return;
		end

		player:SetCharacterData("brainsize", brainSize + 1);

		player:HandleXP(math.random(300, 666));

		Schema:EasyText(player, "lawngreen", "After swallowing the capsule, you feel more enlightened, as if your brain physically contains more than it had before.")
	end;

	function ITEM:OnCustomFunction(player, name)
		if (name == "Smell") then
			Schema:EasyText(player, "olivedrab", "As you smell the "..self.name..", the scent of "..self.smell.." fills your nostrils.");
		end;
	end;

	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
ITEM:Register();