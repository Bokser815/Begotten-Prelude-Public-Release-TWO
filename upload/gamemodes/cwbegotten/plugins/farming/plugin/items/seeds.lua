--[[
	Begotten Code
--]]

-- temp seeds to test out farming system
local ITEM = Clockwork.item:New();
	ITEM.name = "Agave Seed";
	ITEM.model = "models/props_junk/garbage_bag001a.mdl";
	ITEM.plural = "Agave Seeds";
	ITEM.useText = "Plant";
	ITEM.weight = 0.25;
	ITEM.description = "A packet of Agave Seeds";
	ITEM.uniqueID = "seed_agave";
	ITEM.stackable = true;

	-- Called when a player uses the item.
	function ITEM:OnUse(player, itemEntity)
		if (player:Alive()) then
			local eyePos = player:EyePos();
			local aimVector = player:GetAimVector();
			
			local trace = {};
				trace.start = eyePos;
				trace.endpos = trace.start + aimVector * 128;
				trace.filter = player;
			local traceLine = util.TraceLine(trace);
			
			local planter = traceLine.Entity;
			
			if (IsValid(planter) and planter:GetClass() == "cw_planter") then
				if not planter:IsFull() then
					planter:PlantSeed("agave", player:HasBelief("gift_great_tree"))
					Schema:EasyText(caller, "green", "You plant an agave seed.");
				else
					Schema:EasyText(player, "firebrick", "The planter is full!");
					return false;
				end
			else
				Schema:EasyText(player, "firebrick", "You must look at a planter to plant your seed!");
				return false;
			end;
		end;
	end;

	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
ITEM:Register();


local ITEM = Clockwork.item:New();
	ITEM.name = "Maize Seed";
	ITEM.model = "models/props_junk/garbage_bag001a.mdl";
	ITEM.plural = "Maize Seeds";
	ITEM.useText = "Plant";
	ITEM.weight = 0.25;
	ITEM.description = "A packet of Maize Seeds";
	ITEM.uniqueID = "seed_maize";
	ITEM.stackable = true;

	-- Called when a player uses the item.
	function ITEM:OnUse(player, itemEntity)
		if (player:Alive()) then
			local eyePos = player:EyePos();
			local aimVector = player:GetAimVector();
			
			local trace = {};
				trace.start = eyePos;
				trace.endpos = trace.start + aimVector * 128;
				trace.filter = player;
			local traceLine = util.TraceLine(trace);
			
			local planter = traceLine.Entity;
			
			if (IsValid(planter) and planter:GetClass() == "cw_planter") then
				if not planter:IsFull() then
					planter:PlantSeed("maize", player:HasBelief("gift_great_tree"))
					Schema:EasyText(caller, "green", "You plant a maize seed.");
				else
					Schema:EasyText(player, "firebrick", "The planter is full!");
					return false;
				end
			else
				Schema:EasyText(player, "firebrick", "You must look at a planter to plant your seed!");
				return false;
			end;
		end;
	end;

	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
ITEM:Register();


local ITEM = Clockwork.item:New();
ITEM.name = "Fungus Spores";
ITEM.model = "models/props_junk/garbage_bag001a.mdl";
ITEM.plural = "Fungus Spore Packets";
ITEM.useText = "Plant";
ITEM.weight = 0.25;
ITEM.description = "A packet of Fungus Spores, they need to be planted indoors.";
ITEM.uniqueID = "seed_fungus";
ITEM.stackable = true;

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
    if (player:Alive()) then
        local eyePos = player:EyePos();
        local aimVector = player:GetAimVector();
        
        local trace = {};
        trace.start = eyePos;
        trace.endpos = trace.start + aimVector * 128;
        trace.filter = player;
        local traceLine = util.TraceLine(trace);
        
        local planter = traceLine.Entity;
        
        if (IsValid(planter) and planter:GetClass() == "cw_planter") then
            if not planter:IsFull() then
                planter:PlantSeed("fungus", player:HasBelief("gift_great_tree"))
                Schema:EasyText(player, "green", "You plant Fungus Spores.");
            else
                Schema:EasyText(player, "firebrick", "The planter is full!");
                return false;
            end
        else
            Schema:EasyText(player, "firebrick", "You must look at a planter to plant your Fungus Spores!");
            return false;
        end;
    end;
end;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;
ITEM:Register();

-- Cotton Seeds
local ITEM = Clockwork.item:New();
ITEM.name = "Cotton Seeds";
ITEM.model = "models/props_junk/garbage_bag001a.mdl";
ITEM.plural = "Cotton Seeds";
ITEM.useText = "Plant";
ITEM.weight = 0.25;
ITEM.description = "A packet of Cotton Seeds";
ITEM.uniqueID = "seed_cotton";
ITEM.stackable = true;

function ITEM:OnUse(player, itemEntity)
    if (player:Alive()) then
        local eyePos = player:EyePos();
        local aimVector = player:GetAimVector();
        
        local trace = {};
        trace.start = eyePos;
        trace.endpos = trace.start + aimVector * 128;
        trace.filter = player;
        local traceLine = util.TraceLine(trace);
        
        local planter = traceLine.Entity;
        
        if (IsValid(planter) and planter:GetClass() == "cw_planter") then
            if not planter:IsFull() then
                planter:PlantSeed("cotton", player:HasBelief("gift_great_tree"))
                Schema:EasyText(player, "green", "You plant Cotton Seeds.");
            else
                Schema:EasyText(player, "firebrick", "The planter is full!");
                return false;
            end
        else
            Schema:EasyText(player, "firebrick", "You must look at a planter to plant your Cotton Seeds!");
            return false;
        end;
    end;
end;

function ITEM:OnDrop(player, position) end;
ITEM:Register();

-- Tobacco Seeds
local ITEM = Clockwork.item:New();
ITEM.name = "Tobacco Seeds";
ITEM.model = "models/props_junk/garbage_bag001a.mdl";
ITEM.plural = "Tobacco Seeds";
ITEM.useText = "Plant";
ITEM.weight = 0.25;
ITEM.description = "A packet of Tobacco Seeds";
ITEM.uniqueID = "seed_tobacco";
ITEM.stackable = true;

function ITEM:OnUse(player, itemEntity)
    if (player:Alive()) then
        local eyePos = player:EyePos();
        local aimVector = player:GetAimVector();
        
        local trace = {};
        trace.start = eyePos;
        trace.endpos = trace.start + aimVector * 128;
        trace.filter = player;
        local traceLine = util.TraceLine(trace);
        
        local planter = traceLine.Entity;
        
        if (IsValid(planter) and planter:GetClass() == "cw_planter") then
            if not planter:IsFull() then
                planter:PlantSeed("tobacco", player:HasBelief("gift_great_tree"))
                Schema:EasyText(player, "green", "You plant Tobacco Seeds.");
            else
                Schema:EasyText(player, "firebrick", "The planter is full!");
                return false;
            end
        else
            Schema:EasyText(player, "firebrick", "You must look at a planter to plant your Tobacco Seeds!");
            return false;
        end;
    end;
end;

function ITEM:OnDrop(player, position) end;
ITEM:Register();
