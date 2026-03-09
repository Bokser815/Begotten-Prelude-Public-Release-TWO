--[[
	Begotten Code
--]]

local ITEM = Clockwork.item:New();
	ITEM.name = "Medium Planter Kit";
	ITEM.model = "models/props_junk/garbage_bag001a.mdl";
	ITEM.plural = "Medium Planter Kits";
	ITEM.useText = "Build";
	ITEM.weight = 5;
	ITEM.description = "A kit for building a medium planter for growing various crops.";
	ITEM.uniqueID = "medium_planter";
	ITEM.stackable = false;

	-- Called when a player uses the item.
	function ITEM:OnUse(player, itemEntity)
		local trace = player:GetEyeTraceNoCursor();
		
		if (trace.HitPos:Distance( player:GetShootPos() ) <= 192) then
			if Schema.towerSafeZoneEnabled and player:InTower() then
				Schema:EasyText(player, "chocolate", "You cannot place planters inside a safezone!");
				
				return false;
			end
			if cwDeployables then cwDeployables:StartDeploy(player, "cw_planter", "models/fallout/plot/planter.mdl"); end
			-- to do later, pass player name to the cw_planter created
			Clockwork.chatBox:AddInTargetRadius(player, "it", player:GetName() .. " constructs a medium planter.", trace.HitPos, config.Get("talk_radius"):Get() * 3);
		else
			Schema:EasyText(player, "firebrick", "You cannot build a planter that far away!");
			return false;
		end;
	end;

	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
ITEM:Register();

-- light/heavy, perhaps in the future