local EffectsTable = {
	["Red Fungus"] = {
		standalone = 25,
		mixed = 40,
		effect = function(tbl, player, mixed)
			local value = tbl.standalone;

			if(mixed) then
				value = tbl.mixed;
			end

			-- TODO: incremental health increase with value over 8 seconds
			-- doesn't heal injuries. maybe gives back a little blood?
		end
	},
	["Red Fungal Spread"] = {
		effect = function(tbl, player, mixed)
			local gender = "his";

			if(player:GetGender() == GENDER_FEMALE) then
				gender = "her";
			end

			Clockwork.chatBox:AddInTargetRadius(player, "me", "suddenly reaches up to "..gender.." throat as "..gender.." eyes widen!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 2);
			Schema:EasyText(player, "maroon", "My throat is closing up! What the fuck was in that concoction?!");

			player:ScriptedDeath("Asphyxiation via rapid growth of throat tumors.");
		end;
	},
};

--[[ The table below is where all Alchemical Compound recipes are stored.
Ensure the proper formatting for the key is as follows:

	* In alphabetical order of item uniqueID,
	* Includes proper item name followed by a space, a plus sign, and another space,
	* And the final item uniqueID.

compoundGivenToPlayer, if it is not obvious, is the uniqueID of the item you want the player to receieve when they follow that recipe.
]]
local compoundRecipeTable = {
    ["brown_fungus + vial_of_liquid_gold"] = {
		compound = "gold_infused_brown_mush";
	},
	["brown_fungus + vial_of_liquid_steel"] = {
		compound = "steel_infused_brown_mush";
	},
	["brown_fungus + vial_of_liquid_fine_steel"] = {
		compound = "fine_steel_infused_brown_mush";
	},
	["brown_fungus + vial_of_liquid_shagalaxian_steel"] = {
		compound = "shagalaxian_steel_infused_brown_mush";
	},
	["brown_fungus + vial_of_liquid_maximilian_steel"] = {
		compound = "maximilian_steel_infused_brown_mush";
	},
	["red_fungus + red_fungus"] = {
		compound = "red_fungal_spread",
	},
};

local transmutationTable = {
	["gold_infused_brown_mush"] = {metal = "gold_ingot"},
	["steel_infused_brown_mush"] = {metal = "steel_ingot"},
	["fine_steel_infused_brown_mush"] = {metal = "fine_steel_ingot"},
	["shagalaxian_steel_infused_brown_mush"] = {metal = "shagalaxian_steel_ingot"},
	["maximilian_steel_infused_brown_mush"] = {metal = "maximilian_steel_ingot"},
}

local explosiveTable = {
	["vial_of_blood"] = {reactants = {"dark_fungus"}},
	["vial_of_tainted_blood"] = {reactants = {"bleached_fungus"}},
	["dark_fungus"] = {reactants = {"vial_of_blood"}},
	["bleached_fungus"] = {reactants = {"vial_of_tainted_blood"}},
}

function cwAlchemy:ApplyEffects(player, ingredient, mixed)
	if(!istable(ingredient)) then
		local tbl = EffectsTable[ingredient];
		tbl.effect(tbl, player, mixed);

		return

	end

	for _,v in pairs(ingredient) do
		self:ApplyEffects(player, v, mixed);

		if(!player:Alive()) then
			break;

		end

	end

end

function cwAlchemy:GetRecipe(ingredient1, ingredient2)
    local recipe = {};
    table.insert(recipe, ingredient1);
    table.insert(recipe, ingredient2);
    recipe.sort();
    recipe = recipe[1].." + "..recipe[2];
    return recipe;
end;

local wrongRecipeMessages = {
	"No, no, that won't work...",
	"It's highly unlikely this will result in anything.",
	"This wouldn't work, not in a million years.",
	-- TODO: fill with more
}

function cwAlchemy:CraftCompound(player, item1, item2)

	if(!player:HasBelief("alchemist")) then
		Clockwork.player:Notify(player, "You do not have the required belief to do so!");
		return false;
	elseif(!player:HasItemByID(item1) or !player:HasItemByID(item2)) then
		Clockwork.player:Notify(player, "You do not have one or more compound you are trying to use!");
		Clockwork.player:NotifyAdmins("operator", player:Name().." may be trying to exploit the alchemy crafting system, or a bug has occurred. Please investigate.");
		return false;
	end


	local exploded = false;
	local recipe = self:GetRecipe(item1, item2);

	if(!compoundRecipeTable[recipe] and player:HasBelief("mycologist")) then
		Clockwork.chatBox:Add(player, nil, "it", table.random(wrongRecipeMessages));
		return false;
	end

	Clockwork.chatBox:AddInTargetRadius(player, "me", "begins carefully creating a new substance at an alchemical workbench.", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 2);

	Clockwork.player:SetAction(player, "crafting_compound", 7, 3, function()
		player:TakeItemByID(item1);
		player:TakeItemByID(item2);

		if(explosiveTable[item1].reactants) then
			for _,explosiveReactant in pairs(explosiveTable[item1].reactants) do
				if(explosiveReactant == item2) then
					self:Explosion(player);
					exploded = true;
					break;
				end
			end
		end

		if(!exploded) then
			if(!compoundRecipeTable[recipe]) then
				player:GiveItem(Clockwork.item:CreateInstance("grey_mush", true));
			else
				player:GiveItem(Clockwork.item:CreateInstance(compoundRecipeTable[recipe].compound, true))
			end
		end
	end)
end

function cwAlchemy:Disassemble(player, compound, equipment)
	if(!player:HasBelief("wasteless")) then
		Clockwork.player:Notify(player, "You do not have the required belief to perform this action!");
		return false;
	end

	if(!player:HasItem(compound) or !player:HasItem(equipment)) then
		Clockwork.player:Notify(player, "You do not have all of the items you are trying to use disassembly with!");
		Clockwork.player:NotifyAdmins("operator", player:Name().." may be attempting to exploit the Disassembly system, or a bug has occurred. Please investigate.");
		return false;
	end

	if(compound.dis ~= equipment.dis) then
		-- TODO: menu close
		Clockwork.player:Notify(player, "You do not have the required compound to perform Disassembly on "..equipment.name.."!");
		return false;
	else
		Clockwork.chatBox:AddInTargetRadius(player, "me", "begins disassembling a "..equipment.name.." at an alchemical workbench.", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 2);

		local origRecipe = cwRecipes:FindByID(equipment.uniqueID);

		Clockwork.player:SetAction(player, "disassembly", 10, 3, function()
			player:TakeItemByID(compound.uniqueID);
			player:TakeItemByID(equipment.uniqueID);

			local materials = origRecipe.requirements;

			for k,v in pairs(materials) do
				for i = 1, v.amount do
					player:GiveItem(Clockwork.item:CreateInstance(k, true));
				end
			end
		end);

		Clockwork.chatBox:Add(player, nil, "it", "After a few moments, the equipment magically seperates all of the materials that make up itself into seperate piles.")
	end
end;

function cwAlchemy:Transmute(player, compound, metal)
	if(!player:HasBelief("chrysopoeia")) then
		Clockwork.player:Notify(player, "You do not have the proper belief to do this!");
		return false;
	elseif(!player:HasItemByID(compound.uniqueID) or !player:HasItemByID(metal.uniqueID)) then
		Clockwork.player:Notify(player, "You do not have all items you are attempting to transmutate with!");
		Clockwork.player:NotifyAdmins("operator", player:Name().." may be attempting to exploit the Transmutation system, or a bug has occurred. Please investigate.");
		return false;
	end;

	if(!transmutationTable[compound.uniqueID]) then
		Clockwork.player:NotifyAdmins("operator", player:Name().. " has encountered an error with the Transmutation system. Please investigate.");
		return false;
	else
		Clockwork.chatBox:AddInTargetRadius(player, "me", "begins transmuting a "..metal.name..".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 2);

		Clockwork.player:SetAction(player, "transmute", 10, 3, function()
			player:TakeItemByID(compound.uniqueID);
			player:TakeItemByID(metal.uniqueID);

			local transmetal = transmutationTable[compound.uniqueID];
			transmetal = "transmuted_"..transmetal.metal;

			player:GiveItem(Clockwork.item:CreateInstance(transmetal, true));
		end);
	end
end;

function cwAlchemy:MixConcoction(player, compound, concoction)
	-- this is probably inefficient as fuck.
	-- have someone else review this. fucking please.
	if(!player:HasBelief("alchemist")) then
		Clockwork.player:Notify(player, "You do not have the required belief to do so!");
		return false;
	elseif(!player:HasItemByID(compound) or !player:HasItemByID(concoction)) then
		Clockwork.player:Notify(player, "You do not have one or more item you are trying to use!");
		Clockwork.player:NotifyAdmins("operator", player:Name().." may be trying to exploit the alchemical concoction mixing system, or a bug has occurred. Please investigate.");
		return false;
	end

	local compoundsIn = concoction:GetData("ingredients") or {};
	local smellsIn = concoction:GetData("smells") or {};
	local newCompoundMaybe;
	local newCompound;
	local newCompoundSmell;

	-- if compounds already exist in the concoction
	if(compoundsIn) then 
		-- if compound being added is explosive,
		-- run through all explosive reactants and see if they match up with any of the ingredients in the concoction already
		if(explosiveTable[compound.uniqueID]) then
			for k,v in pairs(compoundsIn) do
				for _,v2 in pairs(explosiveTable[compound.uniqueID].reactants) do
					if(v == v2) then
						self:Explode(player);
						return;
					end
				end
			end
		end

		-- check if compound being added would merge with any compounds already in concoction
		for k,v in pairs(compoundsIn) do
			newCompoundMaybe = self:GetRecipe(v, compound.uniqueID);
			if(compoundRecipeTable[newCompoundMaybe]) then
				newCompound = compoundRecipeTable[newCompoundMaybe].compound;
				table.remove(compoundsIn, k);
				break;
			end
		end


		-- if the compound merges with one of the other ingredients
		if(newCompound) then
			-- if the new compound has an explosive reactant, run through all ingredients again.
			if(explosiveTable[newCompound]) then
				for k,v in pairs(compoundsIn) do
					for _, v2 in pairs(explosiveTable[newCompound].reactants) do
						if(v == v2) then
							self:Explode(player);
							return;
						end
					end
				end
			end

			newCompoundSmell = (Clockwork.item:FindByID(newCompound)).smell;
		end
	end

	if(newCompound and newCompoundSmell) then
		table.insert(compoundsIn, newCompound);
		table.insert(smellsIn, newCompoundSmell);
	else
		table.insert(compoundsIn, compound.uniqueID);
		table.insert(smellsIn, compound.smell);
	end
	
	concoction:SetData("ingredients", compoundsIn);
	concoction:SetData("smells", smellsIn);
end;

function cwAlchemy:Explosion(player)
	-- TODO: explodes in their fucking face, doesn't kill them unless marked but gives them glass shard and burn injuries
end;