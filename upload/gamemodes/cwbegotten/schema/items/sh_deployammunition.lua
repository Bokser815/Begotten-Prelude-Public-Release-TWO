--[[
	local ITEM = Clockwork.item:New();
	ITEM.name = "Ballista Bolt";
	ITEM.uniqueID = "ballista_bolt";
	ITEM.cost = 30;
	ITEM.model = "models/begotten/ballistabolt.mdl";
	ITEM.weight = 0.2;
	ITEM.stackable = true;
	ITEM.description = "A ballista bolt.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/ballistabolt.png"
	
	ITEM.ammoType = "BallistaBolt";

	ITEM.useText = "Ready Bolt";
	
	function ITEM:OnUse(player, itemEntity)
		eyetraceplayer = player:GetEyeTrace()
		if eyetraceplayer.Hit == true and eyetraceplayer.Entity then
			local ent = eyetraceplayer.Entity
			if ent.IsBGDeployable == true and ent.DeployableAmmoTypes and ent.DeployableAmmoTypes[self.ammoType] then
				if ent.Isreloaded == false then
					if ent.Owner != player then
						if ent:GetPos():Distance(player:GetPos())<100 then -- check distance
							
							Clockwork.player:SetAction(player, "readybolt", 2, nil, function()				
								ent.Isreloaded = true
								ent.Readiedround = self.ammoType
								ent:SetBodygroup(2,1)
								
								player:SetForcedAnimation("ThrowItem", 1.2)
								Clockwork.chatBox:AddInTargetRadius(player, "me", "places a bolt next to the ballista.", player:GetPos(), config.Get("talk_radius"):Get() * 2); -- fix double name
							end);
						else
							Schema:EasyText(player, "chocolate", "You need to be closer to reload!");
							return false
						end
					else
						Schema:EasyText(player, "chocolate", "You cannot reload an emplacement while aiming!");
						return false
					end
				else
					Schema:EasyText(player, "chocolate", "This emplacement does not need more ammo!");
					return false
				end
			else
				return false
			end
		else
			return false
		end
	end
	
	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
	
	ITEM.components = {breakdownType = "meltdown", items = {"scrap", "scrap", "scrap", "iron_chunks"}};
ITEM:Register();
]]

local ITEM = Clockwork.item:New();
	ITEM.name = "Explosive Cannon Ball";
	ITEM.uniqueID = "explosive_ball";
	ITEM.cost = 30;
	ITEM.model = "models/spitball_medium.mdl";
	ITEM.weight = 0.2;
	ITEM.stackable = true;
	ITEM.description = "A cannon ball.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/explosivecannon.png"
	ITEM.material = "models/rendertarget"
	
	ITEM.ammoType = "ExplosiveBall";

	ITEM.useText = "Ready Ammo";
	
	function ITEM:OnUse(player, itemEntity)
		eyetraceplayer = player:GetEyeTrace()
		if eyetraceplayer.Hit == true and eyetraceplayer.Entity then
			local ent = eyetraceplayer.Entity
			if ent.IsBGDeployable == true and ent.DeployableAmmoTypes and ent.DeployableAmmoTypes[self.ammoType] then
				if ent.Readiedround==nil and ent.ActiveRoundType==nil then
					if ent.Owner != player then
						local pos = player:EyePos()
						if ent:GetPos():Distance(pos)<200 then -- check distance
							local ID = ent:LookupAttachment("fieldcannon_muzzle")
							local Attachment = ent:GetAttachment( ID )
							local attchpos = Attachment.Pos
							if attchpos:Distance(pos)<50 then
								Clockwork.chatBox:AddInTargetRadius(player, "me", "slots the cannonball into the barrel.", pos, config.Get("talk_radius"):Get() * 2);
								ent:EmitSound(Sound("fiend/cannonballload.wav"))--
								Clockwork.player:SetAction(player, "readyball", 2, nil, function()		
									ent.Isreloaded = true
									ent.Readiedround = self.ammoType
									if ent.IsPowdered != true then
										ent.FuckingFailedReload = true
									end
									player:SetForcedAnimation("ThrowItem", 1.2)
								end);
							else
								Schema:EasyText(player, "chocolate", "You need to be closer to the barrel to reload!");
								return false
							end
						else
							Schema:EasyText(player, "chocolate", "You need to be closer to reload!");
							return false
						end
					else
						Schema:EasyText(player, "chocolate", "You cannot reload an emplacement while aiming!");
						return false
					end
				else
					Schema:EasyText(player, "chocolate", "This emplacement does not need more ammo!");
					return false
				end
			else
				return false
			end
		else
			return false
		end
	end
	
	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
	
	ITEM.components = {breakdownType = "meltdown", items = {"scrap", "scrap", "scrap", "iron_chunks"}};
ITEM:Register();

local ITEM = Clockwork.item:New();
	ITEM.name = "Cannon Ball";
	ITEM.uniqueID = "cannon_ball";
	ITEM.cost = 30;
	ITEM.model = "models/spitball_medium.mdl";
	ITEM.weight = 0.2;
	ITEM.stackable = true;
	ITEM.description = "A cannon ball.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/explosivecannon.png"
	ITEM.material = "models/rendertarget"
	
	ITEM.ammoType = "CannonBall";

	ITEM.useText = "Ready Ammo";
	
	function ITEM:OnUse(player, itemEntity)
		eyetraceplayer = player:GetEyeTrace()
		if eyetraceplayer.Hit == true and eyetraceplayer.Entity then
			local ent = eyetraceplayer.Entity
			if ent.IsBGDeployable == true and ent.DeployableAmmoTypes and ent.DeployableAmmoTypes[self.ammoType] then
				if ent.Readiedround==nil and ent.ActiveRoundType==nil then
					if ent.Owner != player then
						local pos = player:EyePos()
						if ent:GetPos():Distance(pos)<200 then -- check distance
							local ID = ent:LookupAttachment("fieldcannon_muzzle")
							local Attachment = ent:GetAttachment( ID )
							local attchpos = Attachment.Pos
							if attchpos:Distance(pos)<50 then
								Clockwork.chatBox:AddInTargetRadius(player, "me", "slots the cannonball into the barrel.", pos, config.Get("talk_radius"):Get() * 2);
								ent:EmitSound(Sound("fiend/cannonballload.wav"))
								Clockwork.player:SetAction(player, "readyball", 2, nil, function()			
									ent.Isreloaded = true
									ent.Readiedround = self.ammoType
									if ent.IsPowdered != true then
										ent.FuckingFailedReload = true
									end
									player:SetForcedAnimation("ThrowItem", 1.2)
								end);
							else
								Schema:EasyText(player, "chocolate", "You need to be closer to the barrel to reload!");
								return false
							end
						else
							Schema:EasyText(player, "chocolate", "You need to be closer to reload!");
							return false
						end
					else
						Schema:EasyText(player, "chocolate", "You cannot reload an emplacement while aiming!");
						return false
					end
				else
					Schema:EasyText(player, "chocolate", "This emplacement does not need more ammo!");
					return false
				end
			else
				return false
			end
		else
			return false
		end
	end
	
	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
	
	ITEM.components = {breakdownType = "meltdown", items = {"scrap", "scrap", "scrap", "iron_chunks"}};
ITEM:Register();

local ITEM = Clockwork.item:New();
	ITEM.name = "Canister Shot";
	ITEM.uniqueID = "can_shot";
	ITEM.cost = 30;
	ITEM.model = "models/props_junk/PopCan01a.mdl";
	ITEM.weight = 0.2;
	ITEM.stackable = true;
	ITEM.description = "A large bunch of pellets.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/explosivecannon.png"
	ITEM.material = "models/props/de_nuke/pipeset_metal"
	
	ITEM.ammoType = "CanShot";

	ITEM.useText = "Ready Ammo";
	
	function ITEM:OnUse(player, itemEntity)
		eyetraceplayer = player:GetEyeTrace()
		if eyetraceplayer.Hit == true and eyetraceplayer.Entity then
			local ent = eyetraceplayer.Entity
			if ent.IsBGDeployable == true and ent.DeployableAmmoTypes and ent.DeployableAmmoTypes[self.ammoType] then
				if ent.Readiedround==nil and ent.ActiveRoundType==nil then
					if ent.Owner != player then
						local pos = player:EyePos()
						if ent:GetPos():Distance(pos)<200 then -- check distance
							local ID = ent:LookupAttachment("fieldcannon_muzzle")
							local Attachment = ent:GetAttachment( ID )
							local attchpos = Attachment.Pos
							if attchpos:Distance(pos)<50 then
								Clockwork.chatBox:AddInTargetRadius(player, "me", "slots the cannister shot into the barrel.", pos, config.Get("talk_radius"):Get() * 2);
								ent:EmitSound(Sound("fiend/cannonballload.wav"))
								Clockwork.player:SetAction(player, "readycan", 2, nil, function()		
									ent.Isreloaded = true
									ent.Readiedround = self.ammoType
									if ent.IsPowdered != true then
										ent.FuckingFailedReload = true
									end
									player:SetForcedAnimation("ThrowItem", 1.2)
								end);
							else
								Schema:EasyText(player, "chocolate", "You need to be closer to the barrel to reload!");
								return false
							end
						else
							Schema:EasyText(player, "chocolate", "You need to be closer to reload!");
							return false
						end
					else
						Schema:EasyText(player, "chocolate", "You cannot reload an emplacement while aiming!");
						return false
					end
				else
					Schema:EasyText(player, "chocolate", "This emplacement does not need more ammo!");
					return false
				end
			else
				return false
			end
		else
			return false
		end
	end
	
	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
	
	ITEM.components = {breakdownType = "meltdown", items = {"scrap", "scrap", "scrap", "iron_chunks"}};
ITEM:Register();

local ITEM = Clockwork.item:New();
	ITEM.name = "Gunpowder Packing";
	ITEM.uniqueID = "gunpowder_packing";
	ITEM.cost = 30;
	ITEM.model = "models/props_clutter/coin_bag_large.mdl";
	ITEM.weight = 0.2;
	ITEM.stackable = true;
	ITEM.description = "A gunpowder charge used to fire a cannon.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/gunpowderpacking.png"
	
	ITEM.ammoType = "Gunpowder";

	ITEM.useText = "Ready Gunpowder";
	
	function ITEM:OnUse(player, itemEntity)
		eyetraceplayer = player:GetEyeTrace()
		if eyetraceplayer.Hit == true and eyetraceplayer.Entity then
			local ent = eyetraceplayer.Entity
			if ent.IsBGDeployable == true and ent.DeployableAmmoTypes and ent.DeployableAmmoTypes[self.ammoType] then
				if ent.Owner != player then
					if ent.OverPressure==false then
						local pos = player:EyePos()
						if ent:GetPos():Distance(pos)<200 then -- check distance
							local ID = ent:LookupAttachment("fieldcannon_muzzle")
							local Attachment = ent:GetAttachment( ID )
							local attchpos = Attachment.Pos
							if attchpos:Distance(pos)<50 then
								Clockwork.chatBox:AddInTargetRadius(player, "me", "rams gunpowder into the barrel of the cannon.", pos, config.Get("talk_radius"):Get() * 2);
								ent:EmitSound(Sound("fiend/cannonclean.wav"))
								Clockwork.player:SetAction(player, "readypacking", 12, nil, function()
									if ent.IsPowdered == true then
										ent.OverPressure = true
									end		
									ent.IsPowdered = true
									player:SetForcedAnimation("ThrowItem", 1.2)
								end);
							else
								Schema:EasyText(player, "chocolate", "You need to be closer to the barrel to reload!");
								return false
							end
						else
							Schema:EasyText(player, "chocolate", "You need to be closer to reload!");
							return false
						end
					else
						Schema:EasyText(player, "chocolate", "There is not enough room to ram this down!");
						return false
					end
				else
					Schema:EasyText(player, "chocolate", "You cannot reload an emplacement while aiming!");
					return false
				end
			else
				return false
			end
		else
			return false
		end
	end
	
	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
	
	ITEM.components = {breakdownType = "meltdown", items = {"scrap", "scrap", "scrap", "iron_chunks"}};
ITEM:Register();