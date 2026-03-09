if (SERVER) then
	local map = game.GetMap();

	Schema.siegeLadderPositions = {};

	if map == "rp_begotten3" then
		Schema.siegeLadderPositions = {
			-- Tower
			{pos = Vector(4265.21875, 12294.34375, -1583), ang = Angle(-45, 0, 0), boundsA = Vector(3250, 11942, -1092), boundsB = Vector(4690, 12861, -2000)},
			{pos = Vector(3703.65625, 10982.875, -1796.5625), ang = Angle(-56, 0, 0), boundsA = Vector(3250, 11942, -1092), boundsB = Vector(3782, 10180, -2000)},
			{pos = Vector(365.625, 9597.0625, -1645.875), ang = Angle(-61.935, -112.714, -5.279), boundsA = Vector(103, 9311, -1801), boundsB = Vector(1107, 10108, -1234)},
			{pos = Vector(-268.65625, 9617, -1634.53125), ang = Angle(-58.508, -72.021, 2.065), boundsA = Vector(103, 9311, -1801), boundsB = Vector(-818, 10238, -1133)},
			{pos = Vector(-5141.9375, 13244.65625, -1456.78125), ang = Angle(-45.582, -170.986, -0.692), boundsA = Vector(-4533, 13545, -845), boundsB = Vector(-5492, 12580, -1807)},
			
			-- Castle
			{pos = Vector(-11592, -13690, -1680), ang = Angle(-62, 0, 0), boundsA = Vector(-11113, -14113, -1732), boundsB = Vector(-12148, -12889, -1314)},
			{pos = Vector(-11592, -12340, -1680), ang = Angle(-62, 0, 0), boundsA = Vector(-11187, -11653, -1732), boundsB = Vector(-12148, -12889, -1314)},
			
			-- Gorewatch
			{pos = Vector(9731.46875, 12398.34375, -1387.8125), ang = Angle(53.740, -87.638, 0.566), boundsA = Vector(10075, 12370, -1235), boundsB = Vector(9198, 11844, -940)},
			{pos = Vector(9718.8125, 9857.78125, -1286.84375), ang = Angle(61.908, 90.989, 1.417), boundsA = Vector(10053, 9873, -1221), boundsB = Vector(9262, 10410, -952)},
		}
	elseif map == "rp_begotten_redux" then
		Schema.siegeLadderPositions = {
			-- Town
			{pos = Vector(-8332.8125, -8357.53125, 68.03125), ang = Angle(-62.611, 0, 0), boundsA = Vector(-8942, -8678, 53), boundsB = Vector(-8155, -8130, 584)},
			{pos = Vector(-8334.15625, -7899.34375, 52.0625), ang = Angle(-62.425, 0, 0), boundsA = Vector(-8155, -8130, 584), boundsB = Vector(-8942, -7572, 53)},
			
			-- Old Manor Fort
			{pos = Vector(10553.375, 9878.125, 684.65625), ang = Angle(-78.387, -176.287, -3.532), boundsA = Vector(11045, 13394, 680), boundsB = Vector(10130, 11804, 1076)},
			{pos = Vector(10653.15625, 10881.3125, 684.34375), ang = Angle(-58.656, 179.824, 0.786), boundsA = Vector(10130, 11804, 1076), boundsB = Vector(11248, 10366, 630)},
			{pos = Vector(10424.65625, 12854.96875, 674.8125), ang = Angle(-72.065, -173.32, -5.262), boundsA = Vector(11248, 10366, 630), boundsB = Vector(10405, 9455, 1140)},
		}
	elseif map == "rp_scraptown" then
		Schema.siegeLadderPositions = {
			-- Scrap Town Bridge
			{pos = Vector(-505.0625, -3355.15625, 343.90625), ang = Angle(-89.703, 147.766, -147.343), boundsA = Vector(-100, -3260, 325), boundsB = Vector(-1460, -3449, 550)},
			{pos = Vector(-495.78125, -3530.9375, 345.1875), ang = Angle(-89.995, -179, 180), boundsA = Vector(-1460, -3449, 550), boundsB = Vector(-100, -3630, 325)},
			-- Scrap Town Gate
			{pos = Vector(-1861.375, -3282.84375, 186.125), ang = Angle(67.401, 180, 0), boundsA = Vector(-1619, -2970, 113), boundsB = Vector(-2447, -3455, 562)},
			{pos = Vector(-1859.59375, -3643.625, 188.4375), ang = Angle(67.401, 180, 0), boundsA = Vector(-2447, -3455, 562), boundsB = Vector(-1736, -3869, 153)},
		}
	elseif map == "rp_district21" then
		Schema.siegeLadderPositions = {
			-- Hill of Light
			{pos = Vector(-4253.44, 11041.47, 44.88), ang = Angle(45, 179.99, 0), boundsA = Vector(-4698, 11293, 232), boundsB = Vector(-3865, 10651, -35)},
			{pos = Vector(-8154.84, 9666.28, 46.56), ang = Angle(44.99, -0.88, 0), boundsA = Vector(7696, 10106, 480), boundsB = Vector(-8326, 9341, 66)},
			-- Hill of Light Citadel
			{pos = Vector(-7311.12, 11067, 176.69), ang = Angle(-58.67, 0, 0), boundsA = Vector(-7754, 11317, 345), boundsB = Vector(-7136, 10858, 132)},
			{pos = Vector(-7339.94, 11914.5, 156.59), ang = Angle(-55.8, 0, 0), boundsA = Vector(-7216, 11715, 141), boundsB = Vector(-7671, 12004, 289)},
			-- Gorewatch
			{pos = Vector(-8296.06, -8492.81, -319), ang = Angle(45, -179.56, 0), boundsA = Vector(-8756, -8612, 176), boundsB = Vector(-8414, -8168, -150)},
			{pos = Vector(-9182.06, -9113.06, -320.75), ang = Angle(45, 90, 0), boundsA = Vector(-9293, -8649, 176), boundsB = Vector(-8842, -9041, -150)},
			-- Crane
			{pos = Vector(-13654.16, -12306.47, -883.59), ang = Angle(44.99, -88.9, 0), boundsA = Vector(-13461, -12773, -445), boundsB = Vector(-13783, -12079, -873)},
			-- Water Tower
			{pos = Vector(-2745.69, -1459.94, -537.44), ang = Angle(54.55, -88.07, -0.15), boundsA = Vector(-2679, -1879, -225), boundsB = Vector(-3486, -1373, -689)},
		}
	end
end

local ITEM = Clockwork.item:New();
	ITEM.name = "Bear Trap";
	ITEM.uniqueID = "bear_trap";
	ITEM.model = "models/begotten/beartrap/beartrapopen.mdl";
	ITEM.weight = 5;
	ITEM.category = "Tools";
	ITEM.description = "A metal pressure-activated trap with jagged teeth, designed to capture the strongest of prey, be they animal or man.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/bear_trap.png";
	ITEM.useText = "Deploy";
	ITEM.requiredbeliefs = {"ingenious"};
	
	function ITEM:OnUse(player, itemEntity)
		if Schema.towerSafeZoneEnabled and player:InTower() then
			Schema:EasyText(player, "chocolate", "You cannot deploy a bear trap inside a safezone!");
			
			return false;
		end

		local trapEnt = ents.Create("cw_bear_trap");
		
		if IsValid(trapEnt) then
			trapEnt:SetAngles(player:GetAngles());
			trapEnt:SetPos(player:GetPos());
			trapEnt.condition = self:GetCondition() or 100;
			trapEnt.owner = player;
			trapEnt:Spawn();
		end
	end
	
	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
	
	ITEM.components = {breakdownType = "meltdown", items = {"scrap", "scrap", "scrap", "iron_chunks"}};
ITEM:Register();

local ITEM = Clockwork.item:New();
	ITEM.name = "War Hound Cage";
	ITEM.uniqueID = "war_hound_cage";
	ITEM.model = "models/begotten_apocalypse/items/houndcage.mdl";
	ITEM.weight = 10;
	ITEM.category = "Tools";
	ITEM.description = "A steel cage for tamed wolves provided by the Headsman and his slaving ilk. The numerous wolves of the North, believed to be descendants of once-loyal hounds, can still be brought back into the fold and live a loyal life. Snakecatchers and Headsmen often used these hounds to hunt men in the woods, for the mines or for their faith. ";
	ITEM.iconoverride = "begotten_apocalypse/ui/itemicons/houndcage.png";
	--ITEM.useText = "Deploy";
	ITEM.requiredbeliefs = {};
	ITEM.stackable = false;
	ITEM:AddData("wolfskin", 0, true);
	ITEM:AddData("wolfhealth", 300, true);
	
	--[[
	function ITEM:OnUse(player, itemEntity)
	end
	]]
	
	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) 
	end;

	function ITEM:OnEntitySpawned(entity2)
		local entity = ents.Create("cw_hound_cage_next");
		entity:Spawn();
		entity:Activate();
		entity:SetPos(entity2:GetPos());
		entity:SetAngles(entity2:GetAngles());
		if self:GetData("wolfskin") then
			entity:SetSkin(self:GetData("wolfskin"));
		end
		if self:GetData("wolfhealth") then
			entity.setwolfhealth = self:GetData("wolfhealth");
		end

		if entity.isplayingsound then
			entity:StopLoopingSound(entity.isplayingsound)
			entity.isplayingsound = entity:StartLoopingSound( "fiend/cagehound.wav" )
		end
		
		entity2:Remove();
	end;

ITEM:Register();

local ITEM = Clockwork.item:New();
	ITEM.name = "Empty Hound Cage";
	ITEM.uniqueID = "empty_hound_cage";
	ITEM.model = "models/begotten_apocalypse/items/houndcage.mdl";
	ITEM.weight = 5;
	ITEM.category = "Tools";
	ITEM.description = "A steel cage for tamed wolves provided by the Headsman and his slaving ilk. The cage is empty, devoid of a loyal companion. Fetch one, would you?";
	ITEM.iconoverride = "begotten_apocalypse/ui/itemicons/houndcage.png";
	ITEM.useText = "Capture";
	ITEM.requiredbeliefs = {};
	ITEM.stackable = false;
	
	function ITEM:OnUse(player, itemEntity)
		for k, v in pairs (ents.FindInSphere(player:GetPos(), 250)) do
			local ent = v
			if IsValid(ent) and ent:GetClass() == "npc_drg_animals_wolf" and player:GetFaction() == ent.summonedFaith then
				local item = player:GiveItem(Clockwork.item:CreateInstance("war_hound_cage"), true);
				if item then
					item:SetData("wolfskin", ent:GetSkin())
					item:SetData("wolfhealth", ent:Health())
				end
				ent:Remove();
				player:TakeItem(self, true);
				Schema:EasyText(player, "chocolate", "A hound is captured.");
				player:EmitSound("fiend/cageshut.wav")
				return
			end

			
			
		end
		Schema:EasyText(player, "chocolate", "Nothing to catch.");
		return false
	end
	
	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) 
	end;
	
	function ITEM:OnEntitySpawned(entity2)
		for i = 1, 9 do
			entity2:SetSubMaterial(i, "begotten/effects/blureffect")
		end
	end;
	
	ITEM.components = {breakdownType = "meltdown", items = {"scrap", "scrap", "scrap"}};
ITEM:Register();

local ITEM = Clockwork.item:New();
	ITEM.name = "Campfire Kit";
	ITEM.uniqueID = "campfire_kit"
	ITEM.model = "models/mosi/fallout4/props/junk/components/wood.mdl";
	ITEM.weight = 2;
	ITEM.useText = "Deploy";
	ITEM.category = "Other";
	ITEM.useSound = "physics/wood/wood_strain3.wav";
	ITEM.description = "A large kit that is able to deploy a campfire which will last for 10 minutes, though more wood may be added as fuel to extend its lifetime.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/wood.png"
	ITEM.stackable = false;

	-- Called when a player uses the item.
	function ITEM:OnUse(player, itemEntity)
		local tr = player:GetEyeTrace();
		local position = tr.HitPos;
		local valuewater = bit.band(util.PointContents(position), CONTENTS_WATER) == CONTENTS_WATER;
		
		if player:InTower() then
			Schema:EasyText(player, "peru", "You cannot deploy this in the Tower of Light!");
			return false;
		end
		
		if tr.Entity and tr.Entity:GetClass() == "cw_longship" then
			Schema:EasyText(player, "peru", "You cannot deploy this on a longship!");
			return false;
		end
		
		for i, v in ipairs(ents.FindByClass("cw_longship")) do
			if v.playersOnBoard then
				for i2, v2 in ipairs(v.playersOnBoard) do
					if player == v2 then
						Schema:EasyText(player, "peru", "You cannot deploy this while sailing!");
						return false;
					end
				end
			end
		end
		
		if (player:GetPos():DistToSqr(position) <= 36864) and valuewater == false then
			local ent = ents.Create("cw_fireplace")
			ent:SetPos(position)
			ent:Spawn()
		elseif valuewater == true then
			Schema:EasyText(player, "peru", "You cannot deploy this underwater!");
			return false;
		else
			Schema:EasyText(player, "peru", "You cannot deploy this that far away!")
			return false;
		end
	end;

	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
ITEM:Register();

local ITEM = Clockwork.item:New();
	ITEM.name = "Siege Ladder";
	ITEM.uniqueID = "siege_ladder";
	ITEM.model = "models/begotten/misc/siegeladder_compact.mdl";
	ITEM.weight = 9;
	ITEM.category = "Tools";
	ITEM.description = "A long, sturdy siege ladder for the express purpose of scaling the fortifications of the Castle, Gorewatch, or the Tower of Light.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/siege_ladder.png";
	ITEM.useText = "Erect";
	
	function ITEM:OnUse(player, itemEntity)
		local playerPos = player:GetPos();
		
		for i = 1, #Schema.siegeLadderPositions do
			local ladderPos = Schema.siegeLadderPositions[i];
			
			if not ladderPos.occupier then
				if playerPos:WithinAABox(ladderPos.boundsA, ladderPos.boundsB) then
					player.ladderConstructing = {index = i, itemTable = self};
					ladderPos.occupier = "constructing";
					
					Clockwork.chatBox:AddInTargetRadius(player, "me", "begins erecting a siege ladder!", player:GetPos(), config.Get("talk_radius"):Get() * 2);
					
					Clockwork.player:SetAction(player, "building", 30, 3, function()
						if IsValid(player) and player.ladderConstructing and player:HasItemInstance(self) then
							local ladderPos = Schema.siegeLadderPositions[player.ladderConstructing.index];
							local ladderEnt = ents.Create("cw_siege_ladder");
							
							if IsValid(ladderEnt) then
								ladderEnt:SetAngles(ladderPos.ang);
								ladderEnt:SetPos(ladderPos.pos);
								ladderEnt:SetNWEntity("owner", player);
								ladderEnt:Spawn();
								
								ladderEnt.strikesRequired = math.Round(15 * ((self:GetCondition() or 100) / 100));
								ladderPos.occupier = ladderEnt;
								ladderEnt.occupyingPosition = player.ladderConstructing.index;
								
								player:TakeItem(self);
							end

							player.ladderConstructing = nil;
						else
							ladderPos.occupier = nil;
						end
					end);
					
					return false;
				end
			end
		end
		
		local map = game.GetMap();
		
		if map == "rp_district21" then
			Schema:EasyText(player, "chocolate", "You must erect this siege ladder at a valid location outside the walls of the Hill of Light or Gorewatch, or near the Crane or Water Tower!");
		else
			Schema:EasyText(player, "chocolate", "You must erect this siege ladder at a valid location outside the walls of the Castle or the Tower of Light!");
		end
		
		return false;
	end
	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position)
		if player.ladderConstructing then
			if player.ladderConstructing.itemTable == self then
				Clockwork.player:SetAction(player, false);
			end
		end
	end;
	
	ITEM.components = {breakdownType = "breakdown", items = {"wood", "wood", "wood", "wood", "wood", "wood"}};
ITEM:Register();

local ITEM = Clockwork.item:New();
	ITEM.name = "Snow Dog";
	ITEM.model = "models/food/hotdog.mdl";
	ITEM.category = "Other";
	ITEM.weight = 0.3;
	ITEM.description = "A snowdog. You can wear it as a hat..";
	ITEM.uniqueID = "snowdog";
	ITEM.useText = "Wear"
	-- Called when a player drops the item.
	function ITEM:OnUse(player, position)
		Clockwork.player:Notify(player, "You attempt to wear your new snowdog prize hat, but end up eating it instead.");
		player:EmitSound("npc/barnacle/barnacle_digesting1.wav");
		timer.Simple(0.5, function()
			if (player:GetGender() == GENDER_MALE) then
				player:EmitSound("vo/npc/male01/moan0"..math.random(1, 4)..".wav")
			else
				player:EmitSound("vo/npc/female01/moan0"..math.random(1, 4)..".wav")
			end;
		end);
		timer.Create(player:EntIndex().."snowdawg", 3, 2, function()
			if (!IsValid(player)) then
				return;
			end;
		if (player:GetGender() == GENDER_MALE) then
			player:EmitSound("vo/npc/male01/moan0"..math.random(1, 4)..".wav")
		else
			player:EmitSound("vo/npc/female01/moan0"..math.random(1, 4)..".wav")
		end;
		end);
	end;
	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
	
	-- Called when the item entity has spawned.
	function ITEM:OnEntitySpawned(entity)
		entity:SetMaterial("models/props/cs_office/snowmana");
	end;
ITEM:Register();

local ITEM = Clockwork.item:New();
	ITEM.name = "Armor Repair Kit";
	ITEM.uniqueID = "armor_repair_kit";
	ITEM.cost = 50;
	ITEM.model = "models/props/de_prodigy/ammo_can_02.mdl";
	ITEM.weight = 2.5;
	ITEM.category = "Tools";
	ITEM.description = "A collection of tools and materials that can easily be used to repair one's armor.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/repair_kit_armor.png";
	ITEM.conditionReplenishment = 200;
	ITEM.stackable = false;
	
	ITEM.itemSpawnerInfo = {category = "Repair Kits", rarity = 900, bNoSupercrate = true};
	
	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
ITEM:Register();

local ITEM = Clockwork.item:New();
	ITEM.name = "Firearm Repair Kit";
	ITEM.uniqueID = "firearm_repair_kit";
	ITEM.cost = 50;
	ITEM.model = "models/props/de_prodigy/ammo_can_02.mdl";
	ITEM.weight = 2.5;
	ITEM.category = "Tools";
	ITEM.description = "A collection of delicate tools and spare parts that can be used to repair firearms.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/repair_kit_firearms.png";
	ITEM.conditionReplenishment = 200;
	ITEM.stackable = false;
	
	ITEM.itemSpawnerInfo = {category = "Repair Kits", rarity = 900, bNoSupercrate = true};
	
	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
ITEM:Register();

local ITEM = Clockwork.item:New();
	ITEM.name = "Melee Repair Kit";
	ITEM.uniqueID = "weapon_repair_kit";
	ITEM.cost = 50;
	ITEM.model = "models/props/de_prodigy/ammo_can_02.mdl";
	ITEM.weight = 2.5;
	ITEM.category = "Tools";
	ITEM.description = "A collection of tools and materials that can easily be used to repair one's melee weapon or shield.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/repair_kit_melee.png";
	ITEM.conditionReplenishment = 200;
	ITEM.stackable = false;
	
	ITEM.itemSpawnerInfo = {category = "Repair Kits", rarity = 700, bNoSupercrate = true};
	
	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
ITEM:Register();

local ITEM = Clockwork.item:New();
	ITEM.name = "Engraving Tool";
	ITEM.uniqueID = "engraving_tool";
	ITEM.cost = 50;
	ITEM.model = "models/items/weapons/blacksmithhammer/bl_hammer.mdl";
	ITEM.weight = 0.2;
	ITEM.category = "Tools";
	ITEM.description = "A small tool that can be used to etch a name into a weapon or shield.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/engraving_tool.png"
	--ITEM.itemSpawnerInfo = {category = "Junk", rarity = 95};
	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
ITEM:Register();

local ITEM = Clockwork.item:New();
	ITEM.name = "Bomb Collar";
	ITEM.model = "models/gibs/shield_scanner_gib1.mdl";
	ITEM.weight = 2;
	ITEM.uniqueID = "bomb_collar";
	ITEM.description = "A tuned bomb collar. Makes a huge mess if you get too far away from your handler.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/thermal_implant.png";
	ITEM.permanent = true;

	-- Called when a player uses the item.
	function ITEM:OnUse(player, itemEntity)
		if (player.isPlacingBombCollar) then
			Schema:EasyText(player, "peru", "You are already applying a bomb collar!");
			
			return false;
		else
			local trace = player:GetEyeTraceNoCursor();
			local target = Clockwork.entity:GetPlayer(trace.Entity);
			local tieTime = 15;
			
			if player.HasBelief and player:HasBelief("dexterity") then
				tieTime = 10;
			end
			
			if (target) then
				--print("Pass 1")
				if (!target:HasGodMode() and !target.cwObserverMode and !target.possessor) then
					--print("Pass 2")
					if (target:GetNetVar("collared") == 0) then
						--print("Pass 3")
						if (target:GetShootPos():Distance( player:GetShootPos() ) <= 192) then
							--print("Pass 4")
							if (target:GetAimVector():DotProduct( player:GetAimVector() ) > 0 or (target:IsRagdolled() and !trace.Entity.cwIsBelongings)) then
								--print("Pass 5")
								
								if player:GetMoveType() == MOVETYPE_WALK then
									for k, v in pairs(ents.FindInSphere(player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 2)) do
										if v:IsPlayer() then
											Clockwork.chatBox:Add(v, player, "me", "starts placing a bomb collar on "..Clockwork.player:FormatRecognisedText(v, "%s", target)..".");
										end
									end
								end
								Clockwork.player:SetAction(player, "collar", tieTime);
								
								Clockwork.player:EntityConditionTimer(player, target, trace.Entity, tieTime, 192, function()
									if (player:Alive() and !player:IsRagdolled() and target:GetNetVar("collared") == 0 and !target.cwObserverMode and !target.possessor 
									and (target:GetAimVector():DotProduct( player:GetAimVector() ) > 0 or (target:IsRagdolled() and !trace.Entity.cwIsBelongings))) then
										return true;
									end;
								end, function(success)
									if (success) then
										player.isPlacingBombCollar = nil;

										target:SetNetVar("collar_Applier", player)
										Schema:CollarPlayer(target, true, player)
										for k, v in pairs(ents.FindInSphere(player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 2)) do
											if v:IsPlayer() then
												Clockwork.chatBox:Add(v, player, "me", "has placed a bomb collar on "..Clockwork.player:FormatRecognisedText(v, "%s", target)..".");
											end
										end
										
										player:TakeItem(self, true);
									else
										player.isPlacingBombCollar = nil;
									end;
									
									Clockwork.player:SetAction(player, "collar", false);
								end);
							else
								Schema:EasyText(player, "peru", "Invalid target for applying a collar to (must be fallen over or turned around)!");
								
								return false;
							end;
							
							player.isPlacingBombCollar = true;
							
							Clockwork.player:SetMenuOpen(player, false);
							
							return false;
						else
							Schema:EasyText(player, "firebrick", "This character is too far away!");
							
							return false;
						end;
					else
						Schema:EasyText(player, "peru", "This character is already collared!");
						
						return false;
					end;
				else
					if player.cwWakingUp then
						Schema:EasyText(player, "firebrick", "This character is waking up after spawning and cannot currently be collared! Asshole.");
					else
						Schema:EasyText(player, "firebrick", "This character cannot currently be collared!");
					end
					
					return false;
				end
			else
				Schema:EasyText(player, "firebrick", "That is not a valid character!");
				
				return false;
			end;
		end;
	end;
	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position)
		if (player.isPlacingBombCollar) then
			Schema:EasyText(player, "peru", "You are currently collaring a character!");
			
			return false;
		end;
	end;

	ITEM.components = {breakdownType = "meltdown", items = {"tech", "gunpowder"}};
ITEM:Register();

local ITEM = Clockwork.item:New();
	ITEM.name = "Sound-Signal Transciever";
	ITEM.model = "models/props/cs_office/computer_caseb_p7a.mdl";
	ITEM.weight = 0.8;
	ITEM.uniqueID = "lrad";
	ITEM.description = "A device based on an ancient schematic pieced together by intrepid scrapper engineers, with no knowledge of the underlying mechanisms. More enlightened scholars have traced its power to the mighty Saint Hertz, who is the saint of the North Wind.";
	ITEM.useSound = "physics/plastic/plastic_barrel_break1.wav";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/"..ITEM.uniqueID..".png";
	ITEM.stackable = false;
	
	if ITEM.customFunctions then
		table.insert(ITEM.customFunctions, "Set Sound Signal");
		table.insert(ITEM.customFunctions, "Transmit Emancipation Signal");
		table.insert(ITEM.customFunctions, "Transmit Detonation Signal");
	else
		ITEM.customFunctions = {"Set Sound Signal","Transmit Emancipation Signal", "Transmit Detonation Signal"};
	end
	
	if (SERVER) then
		function ITEM:OnCustomFunction(player, name)
			if (name == "Set Sound Signal") then
				netstream.Start(player, "SoundSignalFrq", player:GetCharacterData("soundSignalFrq", ""));
			end;
			if (name == "Transmit Emancipation Signal") then
				local trace = player:GetEyeTraceNoCursor();
				local collared = Clockwork.entity:GetPlayer(trace.Entity);
				if (collared and !collared:HasGodMode() and !collared.cwObserverMode and !collared.possessor and collared:GetNetVar("collared") != 0) then
					if (collared:GetShootPos():Distance( player:GetShootPos() ) <= 192) then
						local collarEnt = collared:GetNWEntity("collarEnt")
						if (IsValid(collarEnt) and (collarEnt.frequency == player:GetCharacterData("soundSignalFrq"))) then
							collarEnt:Remove()

							collared:SetCharacterData("collared", false)
							Schema:CollarPlayer(collared, false)

							player:EmitSound("damnation/apocalypt/speaker"..math.random(1, 5)..".mp3", 100, math.random(80, 120))
							Clockwork.chatBox:AddInTargetRadius(collared, "me", "'s collar clicks and falls harmlessly to the ground.", collared:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 2);
							Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name().." has been emancipated from their collar.")
						else
							Schema:EasyText(player, "peru", "You do not have the correct frequency to emancipate this individual!");
						end
					else
						Schema:EasyText(player, "peru", "This player is too far away to be emancipated!");
					end
				else
					Schema:EasyText(player, "peru", "This player cannot be emancipated!");
				end
			end;
			if (name == "Transmit Detonation Signal") then
				local trace = player:GetEyeTraceNoCursor();
				local collared = Clockwork.entity:GetPlayer(trace.Entity);
				if (collared and !collared:HasGodMode() and !collared.cwObserverMode and !collared.possessor and collared:GetNetVar("collared") != 0) then
					if (collared:GetShootPos():Distance( player:GetShootPos() ) <= (192*92)) then
						local collarEnt = collared:GetNWEntity("collarEnt")
						if (IsValid(collarEnt) and (collarEnt.frequency == player:GetCharacterData("soundSignalFrq"))) then
							collarEnt:Detonate("Remotely detonated collar via transmission", collared)

							collared:SetCharacterData("collared", false)
							Schema:CollarPlayer(collared, false)

							player:EmitSound("damnation/apocalypt/speaker"..math.random(1, 5)..".mp3", 100, math.random(80, 120))
							Clockwork.chatBox:AddInTargetRadius(collared, "me", "'s collar clicks and explodes.", collared:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 2);
							Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name().." has had their collar detonated.")
						else
							Schema:EasyText(player, "peru", "You do not have the correct frequency to emancipate this individual!");
						end
					else
						Schema:EasyText(player, "peru", "This player is too far away to have their collar detonated!");
					end
				else
					Schema:EasyText(player, "peru", "Failed to detect player!");
				end
			end;
		end;
	end;

	function ITEM:OnDrop(player, position)
	end;
	
ITEM:Register();

local ITEM = Clockwork.item:New();
	ITEM.name = "Bindings";
	ITEM.category = "Tools";
	ITEM.cost = 4;
	ITEM.model = "models/begotten/misc/rope.mdl";
	ITEM.weight = 0.2;
	ITEM.access = "v";
	ITEM.useText = "Tie";
	ITEM.description = "A collection of rope that can be fitted around a person's wrists to bind them together.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/bindings.png"
	
	ITEM.stackable = true;
	-- Called when a player uses the item.
	function ITEM:OnUse(player, itemEntity)
		if (player.isTying) then
			Schema:EasyText(player, "peru", "You are already tying a character!");
			
			return false;
		else
			local trace = player:GetEyeTraceNoCursor();
			local target = Clockwork.entity:GetPlayer(trace.Entity);
			local tieTime = 6;
			
			if player.HasBelief and player:HasBelief("dexterity") then
				tieTime = 4;
			end
			
			if (target) then
				if (!target:HasGodMode() and !target.cwObserverMode and !target.possessor) then
					if (target:GetNetVar("tied") == 0) then
						if (target:GetShootPos():Distance( player:GetShootPos() ) <= 192) then
							if (target:GetAimVector():DotProduct( player:GetAimVector() ) > 0 or (target:IsRagdolled() and !trace.Entity.cwIsBelongings)) then
								local faction = player:GetFaction();
								
								if target:InTower() and Schema.towerSafeZoneEnabled and (faction ~= "Gatekeeper" and faction ~= "Holy Hierarchy" and faction ~= "Hillkeeper") then
									if game.GetMap() == "rp_begotten3" then
										Schema:EasyText(player, "peru", "You cannot tie characters in the Tower of Light if you are not of the Holy Hierarchy!");
									else
										Schema:EasyText(player, "peru", "You cannot tie characters in the safezone if you are not of the Holy Hierarchy!");
									end
									
									return false;
								end
								
								if player:GetMoveType() == MOVETYPE_WALK then
									for k, v in pairs(ents.FindInSphere(player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 2)) do
										if v:IsPlayer() then
											Clockwork.chatBox:Add(v, player, "me", "starts tying up "..Clockwork.player:FormatRecognisedText(v, "%s", target)..".");
										end
									end
								end
								Clockwork.player:SetAction(player, "tie", tieTime);
								
								Clockwork.player:EntityConditionTimer(player, target, trace.Entity, tieTime, 192, function()
									if (player:Alive() and !player:IsRagdolled() and target:GetNetVar("tied") == 0 and !target.cwObserverMode and !target.possessor 
									and (target:GetAimVector():DotProduct(player:GetAimVector()) > 0 or (target:IsRagdolled() and !trace.Entity.cwIsBelongings))) then
										return true;
									end;
								end, function(success)
									if (success) then
										player.isTying = nil;
										
										Schema:TiePlayer(target, true, nil);
										
										player:TakeItem(self, true);
									else
										player.isTying = nil;
									end;
									
									Clockwork.player:SetAction(player, "tie", false);
								end);
							else
								Schema:EasyText(player, "peru", "You cannot tie characters that are facing you!");
								
								return false;
							end;
							
							player.isTying = true;
							
							Clockwork.player:SetMenuOpen(player, false);
							
							return false;
						else
							Schema:EasyText(player, "firebrick", "This character is too far away!");
							
							return false;
						end;
					else
						Schema:EasyText(player, "peru", "This character is already tied!");
						
						return false;
					end;
				else
					if player.cwWakingUp then
						Schema:EasyText(player, "firebrick", "This character is waking up after spawning and cannot currently be tied!");
					else
						Schema:EasyText(player, "firebrick", "This character cannot currently be tied!");
					end
					
					return false;
				end
			else
				Schema:EasyText(player, "firebrick", "That is not a valid character!");
				
				return false;
			end;
		end;
	end;
	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position)
		if (player.isTying) then
			Schema:EasyText(player, "peru", "You are currently tying a character!");
			
			return false;
		end;
	end;
	ITEM.itemSpawnerInfo = {category = "Junk", rarity = 200};
ITEM:Register();

local ITEM = Clockwork.item:New();
	ITEM.name = "Refurbished Blood Test Kit";
	ITEM.category = "Tools";
	ITEM.cost = 100;
	ITEM.model = "models/kali/miscstuff/stalker/aid/first aid kit.mdl";
	ITEM.weight = 0.4;
	ITEM.useText = "Test Blood";
	ITEM.description = "An ancient device used to test another person's blood for corruption. This one is worn by age and may even be unreliable.";
	ITEM.stackable = false;
	
	ITEM.iconoverride = "materials/begotten/ui/itemicons/blood_test_kit.png"
	-- Called when a player uses the item.
	function ITEM:OnUse(player, itemEntity)
		if (player.isTying) then
			Schema:EasyText(player, "peru", "You are already testing a character!");
			
			return false;
		else
			local trace = player:GetEyeTraceNoCursor();
			local target = Clockwork.entity:GetPlayer(trace.Entity);
			local testTime = 15;
			
			if (target) then
				if (target:GetShootPos():Distance(player:GetShootPos()) <= 192) then
					if player:GetMoveType() == MOVETYPE_WALK then
						for k, v in pairs(ents.FindInSphere(player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 2)) do
							if v:IsPlayer() then
								Clockwork.chatBox:Add(v, player, "me", "begins a blood test on "..Clockwork.player:FormatRecognisedText(v, "%s", target)..".");
							end
						end
					end
					Clockwork.player:SetAction(player, "bloodTest", testTime);
					
					Clockwork.player:EntityConditionTimer(player, target, trace.Entity, testTime, 192, function()
						if (player:Alive() and !player:IsRagdolled() and player:HasItemInstance(self)) then
							return true;
						end;
					end, function(success)
						if (success) then
							player.isTying = nil;
							
							Schema:BloodTestPlayer(target, true);
							
							if self then
								local condition = self:GetCondition() - 20;
							
								if condition <= 0 then
									player:TakeItem(self, true);
								else
									self:SetCondition(condition);
								end
							end
						else
							player.isTying = nil;
						end;
						
						Clockwork.player:SetAction(player, "bloodTest", false);
					end);
					
					player.isTying = true;
					
					Clockwork.player:SetMenuOpen(player, false);
					
					return false;
				else
					Schema:EasyText(player, "firebrick", "This character is too far away!");
					
					return false;
				end;
			else
				Schema:EasyText(player, "firebrick", "That is not a valid character!");
				
				return false;
			end;
		end;
	end;
	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position)
		if (player.isTying) then
			Schema:EasyText(player, "peru", "You are currently tying a character!");
			
			return false;
		end;
	end;
	--ITEM.itemSpawnerInfo = {category = "Medical", rarity = 500};
ITEM:Register();

local ITEM = Clockwork.item:New();
	ITEM.name = "Advanced Blood Test Kit";
	ITEM.category = "Tools";
	ITEM.cost = 2500;
	ITEM.model = "models/kali/miscstuff/stalker/aid/first aid kit.mdl";
	ITEM.weight = 0.4;
	ITEM.useText = "Test Blood";
	ITEM.description = "An ancient device used to test another person's blood for corruption. This device in particular is an advanced model, designed by Skylight engineers to detect the blood of the infamous Black Hats.";
	ITEM.stackable = false;
	
	ITEM.iconoverride = "materials/begotten/ui/itemicons/blood_test_kit.png"
	-- Called when a player uses the item.
	function ITEM:OnUse(player, itemEntity)
		if (player.isTying) then
			Schema:EasyText(player, "peru", "You are already testing a character!");
			
			return false;
		else
			local trace = player:GetEyeTraceNoCursor();
			local target = Clockwork.entity:GetPlayer(trace.Entity);
			local testTime = 15;
			
			if (target) then
				if (target:GetShootPos():Distance(player:GetShootPos()) <= 192) then
					if player:GetMoveType() == MOVETYPE_WALK then
						for k, v in pairs(ents.FindInSphere(player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 2)) do
							if v:IsPlayer() then
								Clockwork.chatBox:Add(v, player, "me", "begins a blood test on "..Clockwork.player:FormatRecognisedText(v, "%s", target)..".");
							end
						end
					end
					Clockwork.player:SetAction(player, "bloodTest", testTime);
					
					Clockwork.player:EntityConditionTimer(player, target, trace.Entity, testTime, 192, function()
						if (player:Alive() and !player:IsRagdolled() and player:HasItemInstance(self)) then
							return true;
						end;
					end, function(success)
						if (success) then
							player.isTying = nil;
							
							Schema:BloodTestPlayer(target, false, true);
							
							if self then
								local condition = self:GetCondition() - 10;
							
								if condition <= 0 then
									player:TakeItem(self, true);
								else
									self:SetCondition(condition);
								end
							end
						else
							player.isTying = nil;
						end;
						
						Clockwork.player:SetAction(player, "bloodTest", false);
					end);
					
					player.isTying = true;
					
					Clockwork.player:SetMenuOpen(player, false);
					
					return false;
				else
					Schema:EasyText(player, "firebrick", "This character is too far away!");
					
					return false;
				end;
			else
				Schema:EasyText(player, "firebrick", "That is not a valid character!");
				
				return false;
			end;
		end;
	end;
	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position)
		if (player.isTying) then
			Schema:EasyText(player, "peru", "You are currently testing a character!");
			
			return false;
		end;
	end;
ITEM:Register();

local ITEM = Clockwork.item:New();
	ITEM.name = "Blood Test Kit";
	ITEM.category = "Tools";
	ITEM.cost = 1000;
	ITEM.model = "models/kali/miscstuff/stalker/aid/first aid kit.mdl";
	ITEM.weight = 0.4;
	ITEM.useText = "Test Blood";
	ITEM.description = "An ancient device used to test another person's blood for corruption.";
	ITEM.stackable = false;
	
	ITEM.iconoverride = "materials/begotten/ui/itemicons/blood_test_kit.png"
	-- Called when a player uses the item.
	function ITEM:OnUse(player, itemEntity)
		if (player.isTying) then
			Schema:EasyText(player, "peru", "You are already testing a character!");
			
			return false;
		else
			local trace = player:GetEyeTraceNoCursor();
			local target = Clockwork.entity:GetPlayer(trace.Entity);
			local testTime = 15;
			
			if (target) then
				if (target:GetShootPos():Distance(player:GetShootPos()) <= 192) then
					if player:GetMoveType() == MOVETYPE_WALK then
						for k, v in pairs(ents.FindInSphere(player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 2)) do
							if v:IsPlayer() then
								Clockwork.chatBox:Add(v, player, "me", "begins a blood test on "..Clockwork.player:FormatRecognisedText(v, "%s", target)..".");
							end
						end
					end
					Clockwork.player:SetAction(player, "bloodTest", testTime);
					
					Clockwork.player:EntityConditionTimer(player, target, trace.Entity, testTime, 192, function()
						if (player:Alive() and !player:IsRagdolled() and player:HasItemInstance(self)) then
							return true;
						end;
					end, function(success)
						if (success) then
							player.isTying = nil;
							
							Schema:BloodTestPlayer(target, false);
							
							if self then
								local condition = self:GetCondition() - 10;
							
								if condition <= 0 then
									player:TakeItem(self, true);
								else
									self:SetCondition(condition);
								end
							end
						else
							player.isTying = nil;
						end;
						
						Clockwork.player:SetAction(player, "bloodTest", false);
					end);
					
					player.isTying = true;
					
					Clockwork.player:SetMenuOpen(player, false);
					
					return false;
				else
					Schema:EasyText(player, "firebrick", "This character is too far away!");
					
					return false;
				end;
			else
				Schema:EasyText(player, "firebrick", "That is not a valid character!");
				
				return false;
			end;
		end;
	end;
	
	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position)
		if (player.isTying) then
			Schema:EasyText(player, "peru", "You are currently testing a character!");
			
			return false;
		end;
	end;
ITEM:Register();

local ITEM = Clockwork.item:New();
 	ITEM.name = "Small Cavalry Spikes";
 	ITEM.uniqueID = "deployable_smallspikes";
 	ITEM.model = "models/props_junk/wood_crate001a.mdl";
 	ITEM.weight = 5;
 	ITEM.category = "Deployables";
 	ITEM.description = "A box containing a set of sharpened logs, able to stand several blows. You can construct it.";
 	ITEM.useText = "Deploy";
 	ITEM.requiredbeliefs = {"ingenious"};
 	
 	function ITEM:OnUse(player, itemEntity)
 		if Schema.towerSafeZoneEnabled and player:InTower() then
 			Schema:EasyText(player, "chocolate", "You cannot deploy fortifications inside a safezone!");
 			
 			return false;
 		end
 
 		if cwDeployables then cwDeployables:StartDeploy(player, "cw_barricade_cavalryspikes", "models/begotten/battlements/smallstakes.mdl"); end
 
 	end
 	
 	-- Called when a player drops the item.
 	function ITEM:OnDrop(player, position) end;
 	
 	ITEM.components = {breakdownType = "breakdown", items = {"wood", "wood", "wood"}};
 ITEM:Register();
 
 local ITEM = Clockwork.item:New();
 	ITEM.name = "Large Cavalry Spikes";
 	ITEM.uniqueID = "deployable_bigspikes";
 	ITEM.model = "models/props_junk/wood_crate001a.mdl";
 	ITEM.weight = 8;
 	ITEM.category = "Deployables";
 	ITEM.description = "A box containing a large amount of sharpened logs, able to stand several blows. You can construct it.";
 	ITEM.useText = "Deploy";
 	ITEM.requiredbeliefs = {"ingenious"};
 	
 	function ITEM:OnUse(player, itemEntity)
 		if Schema.towerSafeZoneEnabled and player:InTower() then
 			Schema:EasyText(player, "chocolate", "You cannot deploy fortifications inside a safezone!");
 			
 			return false;
 		end
 
 		if cwDeployables then cwDeployables:StartDeploy(player, "cw_barricade_cavalryspikesbig", "models/begotten/battlements/stakes.mdl"); end
 
 	end
 	
 	-- Called when a player drops the item.
 	function ITEM:OnDrop(player, position) end;
 	
 	ITEM.components = {breakdownType = "breakdown", items = {"wood", "wood", "wood", "wood", "wood"}};
 ITEM:Register();
 
 local ITEM = Clockwork.item:New();
 	ITEM.name = "Shitwagon Assembly";
 	ITEM.uniqueID = "shitwagon_assemble";
 	ITEM.model = "models/props_junk/wood_crate001a.mdl";
 	ITEM.weight = 40;
 	ITEM.category = "Deployables";
 	ITEM.description = "A set of parts used to construct a Shitwagon.";
 	ITEM.useText = "Assemble";
 	ITEM.requiredbeliefs = {"mechanic"};
 	
 	function ITEM:OnUse(player, itemEntity)
 
 		if cwDeployables then cwDeployables:StartDeploy(player, "lvs_wheeldrive_bgpr_zaza", "models/diggercars/stalker/zaza.mdl"); end
 
 	end
 	
 	-- Called when a player drops the item.
 	function ITEM:OnDrop(player, position) end;
 	
 	ITEM.components = {breakdownType = "breakdown", items = {"scrap_bricks", "scrap_bricks", "scrap_bricks"}};
 ITEM:Register();
 

local ITEM = Clockwork.item:New();
	ITEM.name = "District One Power Cell";
	ITEM.uniqueID = "power_cell";
	ITEM.cost = 500;
	ITEM.model = "models/mosi/fallout4/props/junk/components/nuclear.mdl";
	ITEM.weight = 1;
	ITEM.category = "Tools";
	ITEM.description = "A nuclear power cell of ancient Glazic manufacture, used to power District One armor.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/power_cell.png"
	ITEM.useText = "Recharge Power Armor";
	ITEM.useSound = "items/battery_pickup.wav";
	
	ITEM.itemSpawnerInfo = {category = "Armor", rarity = 600, supercrateOnly = true};
	
	function ITEM:OnUse(player, itemEntity)
		if player:IsWearingPowerArmor() then
			local currentCharge = player:GetCharacterData("battery", 0);
		
			player:SetCharacterData("battery", math.Clamp(currentCharge + 75, 0, 100));
			player:SetNetVar("battery", math.Round(player:GetCharacterData("battery", 0), 0));
			
			player.nextChargeDepleted = CurTime() + 120;
		else
			Schema:EasyText(player, "chocolate", "You must be inside a suit of power armor in order to recharge it!");
			
			return false;
		end
	end;
	
	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
ITEM:Register();

local ITEM = Clockwork.item:New();
	ITEM.name = "Warhorn";
	ITEM.model = "models/begotten/misc/warhorn.mdl";
	ITEM.weight = 0.3;
	ITEM.category = "Communication"
	ITEM.description = "A stout warhorn that when blown will communicate orders to nearby friendlies.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/warhorn.png"
	ITEM.customFunctions = {"Sound Attack", "Sound Rally", "Sound Rally - Marching Formation", "Sound Rally - Shieldwall", "Sound Retreat"};
	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
	
	if (SERVER) then
		function ITEM:OnCustomFunction(player, name)
			local curTime = CurTime();
		
			if !player.nextWarHorn or player.nextWarHorn <= curTime then
				player.nextWarHorn = curTime + 5;
				
				local faction = player:GetNetVar("kinisgerOverride") or player:GetFaction();
				local playerPos = player:GetPos();
				local radius = Clockwork.config:Get("talk_radius"):Get() * 4;
			
				if faction == "Gatekeeper" or faction == "Hillkeeper" or faction == "Holy Hierarchy" then
					if (name == "Sound Attack") then
						for k, v in pairs(ents.FindInSphere(playerPos, radius)) do
							if v:IsPlayer() then
								local vFaction = v:GetFaction();
								
								if vFaction == "Gatekeeper" or vFaction == "Hillkeeper" or vFaction == "Holy Hierarchy" then
									Clockwork.chatBox:Add(v, nil, "localevent", player:Name().." blows their warhorn, signalling an attack!");
								else
									Clockwork.chatBox:Add(v, nil, "localevent", player:Name().." blows their warhorn, but its signal is unknown to you!");
								end
							end
						end
						
						player:EmitSound("warhorns/warhorn3.mp3", 100, math.random(98, 102));
					elseif (name == "Sound Rally") then
						for k, v in pairs(ents.FindInSphere(playerPos, radius)) do
							if v:IsPlayer() then
								local vFaction = v:GetFaction();
								
								if vFaction == "Gatekeeper" or vFaction == "Hillkeeper" or vFaction == "Holy Hierarchy" then
									Clockwork.chatBox:Add(v, nil, "localevent", player:Name().." blows their warhorn, signalling a rally!");
								else
									Clockwork.chatBox:Add(v, nil, "localevent", player:Name().." blows their warhorn, but its signal is unknown to you!");
								end
							end
						end
						
						player:EmitSound("warhorns/warhorn7.mp3", 100, math.random(98, 102));
					elseif (name == "Sound Rally - Marching Formation") then
						for k, v in pairs(ents.FindInSphere(playerPos, radius)) do
							if v:IsPlayer() then
								local vFaction = v:GetFaction();
								
								if vFaction == "Gatekeeper" or vFaction == "Hillkeeper" or vFaction == "Holy Hierarchy" then
									Clockwork.chatBox:Add(v, nil, "localevent", player:Name().." blows their warhorn, signalling a rally in a marching formation!");
								else
									Clockwork.chatBox:Add(v, nil, "localevent", player:Name().." blows their warhorn, but its signal is unknown to you!");
								end
							end
						end
						
						player:EmitSound("warhorns/warhorn8.mp3", 100, math.random(98, 102));
					elseif (name == "Sound Rally - Shieldwall") then
						for k, v in pairs(ents.FindInSphere(playerPos, radius)) do
							if v:IsPlayer() then
								local vFaction = v:GetFaction();
								
								if vFaction == "Gatekeeper" or vFaction == "Hillkeeper" or vFaction == "Holy Hierarchy" then
									Clockwork.chatBox:Add(v, nil, "localevent", player:Name().." blows their warhorn, signalling a rally in a shieldwall formation!");
								else
									Clockwork.chatBox:Add(v, nil, "localevent", player:Name().." blows their warhorn, but its signal is unknown to you!");
								end
							end
						end
						
						player:EmitSound("warhorns/warhorn4.mp3", 100, math.random(98, 102));
					elseif (name == "Sound Retreat") then
						for k, v in pairs(ents.FindInSphere(playerPos, radius)) do
							if v:IsPlayer() then
								local vFaction = v:GetFaction();
								
								if vFaction == "Gatekeeper" or vFaction == "Hillkeeper" or vFaction == "Holy Hierarchy" then
									Clockwork.chatBox:Add(v, nil, "localevent", player:Name().." blows their warhorn, signalling a retreat!");
								else
									Clockwork.chatBox:Add(v, nil, "localevent", player:Name().." blows their warhorn, but its signal is unknown to you!");
								end
							end
						end
						
						player:EmitSound("warhorns/warhorn6.mp3", 100, math.random(98, 102));
					end;
				elseif faction == "Goreic Warrior" then
					if (name == "Sound Attack") then
						for k, v in pairs(ents.FindInSphere(playerPos, radius)) do
							if v:IsPlayer() then
								local vFaction = v:GetFaction();
								
								if vFaction == faction then
									Clockwork.chatBox:Add(v, nil, "localevent", player:Name().." blows their warhorn, signalling an attack!");
								else
									Clockwork.chatBox:Add(v, nil, "localevent", player:Name().." blows their warhorn, but its signal is unknown to you!");
								end
							end
						end
						
						player:EmitSound("warhorns/gore_warhorn_attack.mp3", 100, math.random(88, 108));
					elseif (name == "Sound Rally") then
						for k, v in pairs(ents.FindInSphere(playerPos, radius)) do
							if v:IsPlayer() then
								local vFaction = v:GetFaction();
								
								if vFaction == faction then
									Clockwork.chatBox:Add(v, nil, "localevent", player:Name().." blows their warhorn, signalling a rally!");
								else
									Clockwork.chatBox:Add(v, nil, "localevent", player:Name().." blows their warhorn, but its signal is unknown to you!");
								end
							end
						end
						
						player:EmitSound("warhorns/gore_warhorn_rally.mp3", 100, math.random(88, 108));
					elseif (name == "Sound Rally - Marching Formation") then
						for k, v in pairs(ents.FindInSphere(playerPos, radius)) do
							if v:IsPlayer() then
								local vFaction = v:GetFaction();
								
								if vFaction == faction then
									Clockwork.chatBox:Add(v, nil, "localevent", player:Name().." blows their warhorn, signalling a rally in a marching formation!");
								else
									Clockwork.chatBox:Add(v, nil, "localevent", player:Name().." blows their warhorn, but its signal is unknown to you!");
								end
							end
						end
						
						player:EmitSound("warhorns/gore_warhorn_formation.mp3", 100, math.random(95, 118));
					elseif (name == "Sound Rally - Shieldwall") then
						for k, v in pairs(ents.FindInSphere(playerPos, radius)) do
							if v:IsPlayer() then
								local vFaction = v:GetFaction();
								
								if vFaction == faction then
									Clockwork.chatBox:Add(v, nil, "localevent", player:Name().." blows their warhorn, signalling a rally in a shieldwall formation!");
								else
									Clockwork.chatBox:Add(v, nil, "localevent", player:Name().." blows their warhorn, but its signal is unknown to you!");
								end
							end
						end
						
						player:EmitSound("warhorns/gore_warhorn_formation.mp3", 100, math.random(77, 86));
					elseif (name == "Sound Retreat") then
						for k, v in pairs(ents.FindInSphere(playerPos, radius)) do
							if v:IsPlayer() then
								local vFaction = v:GetFaction();
								
								if vFaction == faction then
									Clockwork.chatBox:Add(v, nil, "localevent", player:Name().." blows their warhorn, signalling a retreat!");
								else
									Clockwork.chatBox:Add(v, nil, "localevent", player:Name().." blows their warhorn, but its signal is unknown to you!");
								end
							end
						end
						
						player:EmitSound("warhorns/gore_warhorn_retreat.mp3", 100, math.random(88, 108));
					end;
 
				else
					Schema:EasyText(player, "peru", "You are not the correct faction to do this!");
				end
			end
		end;
	end;
ITEM:Register();

local ITEM = Clockwork.item:New();
	ITEM.name = "Death Whistle";
	ITEM.model = "models/begotten/misc/skull.mdl";
	ITEM.weight = 0.2;
	ITEM.category = "Communication"
	ITEM.description = "A human skull that has been grafted with holes to generate a bone-chilling whistle.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/skull.png"
	ITEM.customFunctions = {"Sound Attack", "Sound Rally", "Sound Rally - Marching Formation", "Sound Rally - Shieldwall", "Sound Retreat"};
	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
	
	if (SERVER) then
		function ITEM:OnCustomFunction(player, name)
			local curTime = CurTime();
			
			if !player.nextWarHorn or player.nextWarHorn <= curTime then
				player.nextWarHorn = curTime + 5;
				
				local faction = player:GetFaction();
				local playerPos = player:GetPos();
				local radius = Clockwork.config:Get("talk_radius"):Get() * 4;
				
				if faction == "Children of Satan" then
					if (name == "Sound Attack") then
						for k, v in pairs(ents.FindInSphere(playerPos, radius)) do
							if v:IsPlayer() then
								local vFaction = v:GetFaction();
								if vFaction == "Children of Satan" then
									Clockwork.chatBox:Add(v, nil, "localevent", player:Name().." sounds their death whistle, signalling an attack!");
								else
									Clockwork.chatBox:Add(v, nil, "localevent", player:Name().." sounds a terrifying death whistle!");
								end
							end
						end
						player:EmitSound("warhorns/deathwhistle"..math.random(1,2)..".mp3", 100, math.random(98, 102));
					elseif (name == "Sound Rally") then
						for k, v in pairs(ents.FindInSphere(playerPos, radius)) do
							if v:IsPlayer() then
								local vFaction = v:GetFaction();
								
								if vFaction == "Children of Satan" then
									Clockwork.chatBox:Add(v, nil, "localevent", player:Name().." sounds their death whistle, signalling a rally!");
								else
									Clockwork.chatBox:Add(v, nil, "localevent", player:Name().." sounds a terrifying death whistle!");
								end
							end
						end
						player:EmitSound("warhorns/deathwhistle5.mp3", 100, math.random(98, 102));
					elseif (name == "Sound Rally - Marching Formation") then
						for k, v in pairs(ents.FindInSphere(playerPos, radius)) do
							if v:IsPlayer() then
								local vFaction = v:GetFaction();
								
								if vFaction == "Children of Satan" then
									Clockwork.chatBox:Add(v, nil, "localevent", player:Name().." sounds their death whistle, signalling a rally in a marching formation!");
								else
									Clockwork.chatBox:Add(v, nil, "localevent", player:Name().." sounds a terrifying death whistle!");
								end
							end
						end
						player:EmitSound("warhorns/deathwhistle5.mp3", 100, math.random(98, 102));
					elseif (name == "Sound Rally - Shieldwall") then
						for k, v in pairs(ents.FindInSphere(playerPos, radius)) do
							if v:IsPlayer() then
								local vFaction = v:GetFaction();
								
								if vFaction == "Children of Satan" then
									Clockwork.chatBox:Add(v, nil, "localevent", player:Name().." sounds their death whistle, signalling a rally in a shieldwall formation!");
								else
									Clockwork.chatBox:Add(v, nil, "localevent", player:Name().." sounds a terrifying death whistle!");
								end
							end
						end
						player:EmitSound("warhorns/deathwhistle5.mp3", 100, math.random(98, 102));
					elseif (name == "Sound Retreat") then
						for k, v in pairs(ents.FindInSphere(playerPos, radius)) do
							if v:IsPlayer() then
								local vFaction = v:GetFaction();
								if vFaction == "Children of Satan" then
									Clockwork.chatBox:Add(v, nil, "localevent", player:Name().." sounds their death whistle, signalling a retreat!");
								else
									Clockwork.chatBox:Add(v, nil, "localevent", player:Name().." sounds a terrifying death whistle!");
								end
							end
						end
						player:EmitSound("warhorns/deathwhistle"..math.random(3,4)..".mp3", 100, math.random(98, 102));
					end;
				else
					Schema:EasyText(player, "peru", "You are not the correct faction to do this!");
				end
			end
		end;
	end;
ITEM:Register();

local ITEM = Clockwork.item:New();
	ITEM.name = "Empty Bucket";
	ITEM.uniqueID = "empty_bucket";
	ITEM.model = "models/props_junk/MetalBucket01a.mdl";
	ITEM.weight = 1;
	ITEM.category = "Tools";
	ITEM.description = "An iron bucket devoid of any contents.";
	ITEM.customFunctions = {"Fill"};
	ITEM.iconoverride = "begotten_apocalypse/ui/itemicons/bucket.png"
	--ITEM.itemSpawnerInfo = {category = "Junk", rarity = 95};
	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;

	function ITEM:OnCustomFunction(player, name)
		if (name == "Fill") then
			local lastZone = player:GetCharacterData("LastZone");
			local waterLevel = player:WaterLevel();
			local nearSmithy;
			if (waterLevel and waterLevel > 0) then
				for i = 1, #cwRecipes.smithyLocations do
					if player:GetPos():DistToSqr(cwRecipes.smithyLocations[i]) < (256 * 256) then
						Schema:EasyText(player, "firebrick", "You cannot fill a bucket with this water!");
						return false;
					end
				end

				
				Clockwork.chatBox:AddInTargetRadius(player, "me", "begins filling a bucket with water.", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 2);
				-- input water swish sound

				player:EmitSound("apocalypse/cauldron/fillup.mp3");
				-- start progress bar for begins filling a bucket of water.
				Clockwork.player:SetAction(player, "filling_bucket", 10, 3, function()
					-- input water full sound
					
					if lastZone ~= "gore" and lastZone ~= "hotspring" then
						player:GiveItem(Clockwork.item:CreateInstance("dirty_water_bucket"), true);
					else
						player:GiveItem(Clockwork.item:CreateInstance("purified_water_bucket"), true);
					end

					player:TakeItem(self, true);
				end);
			else
				Schema:EasyText(player, "firebrick", "You must be standing in water to fill this bucket!");
			end;
		end;
	end;
ITEM:Register();

local ITEM = Clockwork.item:New();
	ITEM.name = "Empty Bottle";
	ITEM.uniqueID = "empty_bottle";
	ITEM.model = "models/props_junk/GlassBottle01a.mdl";
	ITEM.weight = 0.1;
	ITEM.category = "Tools";
	ITEM.description = "A glass bottle devoid of any contents.";
	ITEM.customFunctions = {"Fill"};
	ITEM.iconoverride = "materials/begotten/ui/itemicons/cold_pop.png";
	--ITEM.itemSpawnerInfo = {category = "Junk", rarity = 95};
	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;

	function ITEM:OnCustomFunction(player, name)
		if (name == "Fill") then
			local waterLevel = player:WaterLevel();
			local lastZone = player:GetCharacterData("LastZone");
			if waterLevel and waterLevel > 0 then
				for i = 1, #cwRecipes.smithyLocations do
					if player:GetPos():DistToSqr(cwRecipes.smithyLocations[i]) < (256 * 256) then
						Schema:EasyText(player, "firebrick", "You cannot fill a bucket with this water!");
						return false;
					end
				end

				if lastZone ~= "gore" and lastZone ~= "hotspring" then
					Clockwork.chatBox:AddInTargetRadius(player, "me", "begins filling an empty bottle with water, almost spilling the contents multiple times as they struggle to fight off the cold biting their fingers.", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 2);
					-- input water swish sound

					-- start progress bar for begins filling a bucket of water.
					Clockwork.player:SetAction(player, "filling_bottle", 15, 3, function()
						-- input water full sound
						player:GiveItem(Clockwork.item:CreateInstance("dirtywater"), true);
						player:TakeItem(self, true);
					end);
				else
					Clockwork.chatBox:AddInTargetRadius(player, "me", "begins filling an empty bottle with water.", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 2);
					-- input water swish sound

					-- start progress bar for begins filling a bucket of water.
					Clockwork.player:SetAction(player, "filling_bottle", 5, 3, function()
						-- input water full sound
						player:GiveItem(Clockwork.item:CreateInstance("purified_water"), true);
						player:TakeItem(self, true);
					end);
				end
			else
				Schema:EasyText(player, "firebrick", "You must be standing in water to fill this bottle!");
			end;
		end;
	end;
ITEM:Register();

local ITEM = Clockwork.item:New();
ITEM.name = "Barricade";
ITEM.uniqueID = "deployable_barricade";
ITEM.model = "models/props_junk/wood_crate001a.mdl";
ITEM.weight = 10;
ITEM.category = "Deployables";
ITEM.description = "A box containing a set of logs braced with hardened steel reinforcement, able to stand several blows. You can construct it.";
ITEM.useText = "Deploy";
ITEM.requiredbeliefs = {"ingenious"};

function ITEM:OnUse(player, itemEntity)
	if Schema.towerSafeZoneEnabled and player:InTower() then
		Schema:EasyText(player, "chocolate", "You cannot deploy fortifications inside a safezone!");
		
		return false;
	end

	if cwDeployables then cwDeployables:StartDeploy(player, "cw_barricade", "models/begotten/battlements/barricade.mdl", "models/begotten/battlements/barricade_left.mdl", "models/begotten/battlements/barricade_right.mdl"); end

end

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM.components = {breakdownType = "meltdown", items = {"wood", "wood", "wood", "wood", "iron_chunks", "iron_chunks"}};
ITEM:Register();

local ITEM = Clockwork.item:New();
ITEM.name = "Ballista";
ITEM.uniqueID = "deployable_ballista";
ITEM.model = "models/props_junk/wood_crate001a.mdl";
ITEM.weight = 10;
ITEM.category = "Deployables";
ITEM.description = "A box containing an assortment of steel, wood, and iron. You can construct this.";
ITEM.useText = "Deploy";
ITEM.requiredbeliefs = {"ingenious"};

function ITEM:OnUse(player, itemEntity)
	if Schema.towerSafeZoneEnabled and player:InTower() then
		Schema:EasyText(player, "chocolate", "You cannot deploy ballistas inside a safezone!");
		
		return false;
	end

	if cwDeployables then cwDeployables:StartDeploy(player, "cw_ballista", "models/begotten/ballista.mdl"); end

end

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM.components = {breakdownType = "meltdown", items = {"wood", "wood", "wood", "wood", "iron_chunks", "iron_chunks"}};
ITEM:Register();

local ITEM = Clockwork.item:New();
ITEM.name = "Cannon";
ITEM.uniqueID = "deployable_cannon";
ITEM.model = "models/props_junk/wood_crate001a.mdl";
ITEM.weight = 10;
ITEM.category = "Deployables";
ITEM.description = "A box containing an assortment of steel, wood, and iron. A learned man can construct this.";
ITEM.useText = "Deploy";
ITEM.requiredbeliefs = {"artisan"};

function ITEM:OnUse(player, itemEntity)
	if Schema.towerSafeZoneEnabled and player:InTower() then
		Schema:EasyText(player, "chocolate", "You cannot deploy cannons inside a safezone!");
		
		return false;
	end

	if cwDeployables then cwDeployables:StartDeploy(player, "cw_cannon", "models/begotten/cannon_6lb.mdl"); end

end

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM.components = {breakdownType = "meltdown", items = {"wood", "iron_chunks", "iron_chunks", "iron_chunks", "iron_chunks", "iron_chunks"}};
ITEM:Register();

local ITEM = Clockwork.item:New();
ITEM.name = "Lockbox";
ITEM.uniqueID = "deployable_lockbox";
ITEM.model = "models/props_junk/wood_crate001a.mdl";
ITEM.weight = 6;
ITEM.category = "Deployables";
ITEM.description = "A box containing a small lockbox. You can construct this.";
ITEM.useText = "Deploy";
ITEM.requiredbeliefs = {"ingenious"};

function ITEM:OnUse(player, itemEntity)
	if cwDeployables then cwDeployables:StartDeploy(player, "prop_physics", "models/begotten/misc/lockbox.mdl"); end

end

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM.components = {breakdownType = "meltdown", items = {"wood", "wood", "wood", "wood", "iron_chunks", "iron_chunks"}};
ITEM:Register();

local ITEM = Clockwork.item:New();
ITEM.name = "Grigori";
ITEM.uniqueID = "deployable_grigori";
ITEM.model = "models/props_junk/wood_crate001a.mdl";
ITEM.weight = 1;
ITEM.category = "Deployables";
ITEM.description = "Grigori...";
ITEM.useText = "Deploy";
ITEM.requiredbeliefs = {"ingenious"};

function ITEM:OnUse(player, itemEntity)
	if cwDeployables then cwDeployables:StartDeploy(player, "npc_monk", "models/monk.mdl"); end

end

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM.components = {breakdownType = "meltdown", items = {"wood", "wood", "wood", "wood", "iron_chunks", "iron_chunks"}};
ITEM:Register();


local ITEM = Clockwork.item:New();
ITEM.name = "Slave Shackles";
ITEM.uniqueID = "slave_shackles";
ITEM.cost = 45;
ITEM.model = "models/props_c17/TrapPropeller_Lever.mdl";
ITEM.weight = 0.25;
ITEM.category = "Tools";
ITEM.description = "A set of ankle shackles connected by a thick, weighted chain.";
ITEM.iconoverride = "materials/begotten/ui/itemicons/ampoule.png"
ITEM.customFunctions = {"Shackle"}
--ITEM.itemSpawnerInfo = {category = "Junk", rarity = 95};
-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

function ITEM:OnCustomFunction(player, name)
	if name == "Shackle" then
		if player:GetSubfaction() == "Slaver" then
			local target = player:GetEyeTraceNoCursor().Entity;

			if target and target:IsPlayer() and target:Alive() then
				Clockwork.chatBox:AddInTargetRadius(player, "me", "begins shackling the ankles of the poor soul before them.", player:GetPos(), config.Get("talk_radius"):Get() * 2);
				Clockwork.player:SetAction(player, "shackling_slave", 10, 10, function()
					target:GiveDisease("shackled");

					-- insert sound

					player:TakeItem(self);
				end);
			else
				Schema:EasyText(player, "firebrick", "You are not looking at a valid target!");
			end
		else
			Schema:EasyText(player, "firebrick", "You are not a Slaver!");
		end
	end
end
ITEM:Register();

local ITEM = Clockwork.item:New();
ITEM.name = "Slave Shackles Key";
ITEM.uniqueID = "slave_shackles_key";
ITEM.cost = 100;
ITEM.model = "models/props_c17/TrapPropeller_Lever.mdl";
ITEM.weight = 0.1;
ITEM.category = "Tools";
ITEM.description = "A key, clearly purposed to lock or unlock shackles.";
ITEM.iconoverride = "materials/begotten/ui/itemicons/ampoule.png"
ITEM.customFunctions = {"Unlock Shackles"}
--ITEM.itemSpawnerInfo = {category = "Junk", rarity = 95};
-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

function ITEM:OnCustomFunction(player, name)
	if name == "Unlock Shackles" then
		local target = player:GetEyeTraceNoCursor().Entity;

		if target and target:IsPlayer() and target:Alive() then
			if target:HasDisease("shackled") then
				local condition = self:GetCondition();

				if condition > 0 then
					Clockwork.chatBox:AddInTargetRadius(player, "me", "begins shackling the ankles of the poor soul before them.", player:GetPos(), config.Get("talk_radius"):Get() * 2);
					Clockwork.player:SetAction(player, "unshackling_slave", 10, 10, function()
						target:TakeDisease("shackled");
						target:SetCharacterData("slave", nil);

						-- insert sound

						self:SetCondition(condition - math.random(25, 50));

						condition = self:GetCondition();

						if condition < 0 then
							self:SetCondition(0);
						end
						
					end);
				else
					Schema:EasyText(player, "firebrick", "Your key is broken and cannot unlock these shackles!")
				end
			else
				Schema:EasyText(player, "firebrick", "That player is not shackled!");
			end
		else
			Schema:EasyText(player, "firebrick", "You are not looking at a valid target!")
		end
	end
end
ITEM:Register();

-- vehicle shit

local ITEM = Clockwork.item:New();
	ITEM.name = "Fuel Can";
	ITEM.uniqueID = "fuel_can";
	ITEM.cost = 200;
	ITEM.model = "models/props_junk/gascan001a.mdl";
	ITEM.weight = 1;
	ITEM.category = "Tools";
	ITEM.description = "A rare fuel can. It can be used to fuel the engine of any chariot.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/repair_kit.png";
	ITEM.conditionReplenishment = 200;
	ITEM.stackable = false;
	
	ITEM.itemSpawnerInfo = {category = "Repair Kits", rarity = 1500, bNoSupercrate = true};
	if ITEM.customFunctions then
		table.insert(ITEM.customFunctions, "Refill Fuel");
		table.insert(ITEM.customFunctions, "Check Fuel");
	else
		ITEM.customFunctions = {"Refill Fuel","Check Fuel"};
	end
	
	if (SERVER) then
		function ITEM:OnCustomFunction(player, name)
			if (name == "Refill Fuel") then
				eyetraceplayer = player:GetEyeTrace()
				if eyetraceplayer.Hit == true and eyetraceplayer.Entity then
					local ent = eyetraceplayer.Entity
					if player.HasBelief and player:HasBelief("mechanic") then
						if ent.LVS == true and ent:GetPos():Distance(player:GetPos())<100 then
							ent:EmitSound("ambient/machines/squeak_5.wav")
							Clockwork.chatBox:AddInTargetRadius(player, "me", "starts to fuel the "..ent.PrintName..".", player:GetPos(), config.Get("talk_radius"):Get() * 2); -- fix double name
							Clockwork.player:SetAction(player, "repairdeployable", 10, nil, function()
								if IsValid(ent) and IsValid(player) then			
									ent:EmitSound("ambient/machines/squeak_8.wav")
									if self then
										local savedcon = self:GetCondition()
										local maxfuel = ent.MaxFuel or 100
										local currentfuel = ent:GetFuel()
										local canfuel = self:GetCondition()
										local condition = self:GetCondition() - (maxfuel- currentfuel)
										self:SetCondition(condition);
										if condition <= 0 then
											if currentfuel+canfuel > maxfuel then
												ent:SetFuel( maxfuel )
											else
												ent:SetFuel( currentfuel+canfuel )
											end
											player:TakeItem(self, true);
										else
											if currentfuel+canfuel > maxfuel then
												ent:SetFuel( maxfuel )
											else
												ent:SetFuel( currentfuel+canfuel )
											end
											
										end
									end
								end
								
							end);
							
						else
							return false
						end
					else
						Schema:EasyText(player, "chocolate", "You don't know how to do this!");
						return false
					end
				else
					return false
				end
			end;
			if (name == "Check Fuel") then
				eyetraceplayer = player:GetEyeTrace()
				if player.HasBelief and player:HasBelief("mechanic") then
					if eyetraceplayer.Hit == true and eyetraceplayer.Entity then
						local ent = eyetraceplayer.Entity
						local fuel = ent:GetFuel()
						if ent.LVS == true and fuel and ent:GetPos():Distance(player:GetPos())<100 then
							local ratio = fuel/ent.MaxFuel
							if ratio == 1 then
								Schema:EasyText(player, "chocolate", "This chariot is full of fuel!");
							elseif ratio > 0.66 then
								Schema:EasyText(player, "chocolate", "This chariot has a medium amount of fuel!");
							elseif ratio > 0.33 then
								Schema:EasyText(player, "chocolate", "This chariot is low on fuel!");
							else
								Schema:EasyText(player, "chocolate", "This chariot is running very low on fuel!");
							end
						else
							return false
						end
					else
						return false
					end
				else
					Schema:EasyText(player, "chocolate", "You don't know how to do this!");
					return false
				end
			end;
		end;
	end;
	
	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
ITEM:Register();

local ITEM = Clockwork.item:New();
	ITEM.name = "Vehicle Repair Kit";
	ITEM.uniqueID = "vehicle_repair_kit";
	ITEM.cost = 200;
	ITEM.model = "models/props_junk/gascan001a.mdl";
	ITEM.weight = 1;
	ITEM.category = "Tools";
	ITEM.description = "A small repair kit used to repair vehicles.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/repair_kit.png";
	ITEM.conditionReplenishment = 200;
	ITEM.stackable = false;
	
	ITEM.itemSpawnerInfo = {category = "Repair Kits", rarity = 1500, bNoSupercrate = true};
	if ITEM.customFunctions then
		table.insert(ITEM.customFunctions, "Repair Vehicle");
		table.insert(ITEM.customFunctions, "Check Condition");
	else
		ITEM.customFunctions = {"Repair Vehicle","Check Condition"};
	end
	
	if (SERVER) then
		function ITEM:OnCustomFunction(player, name)
			if (name == "Repair Vehicle") then
				eyetraceplayer = player:GetEyeTrace()
				if eyetraceplayer.Hit == true and eyetraceplayer.Entity then
					local ent = eyetraceplayer.Entity
					if player.HasBelief and player:HasBelief("mechanic") then
						if ent.LVS == true and ent:GetPos():Distance(player:GetPos())<100 then
							ent:EmitSound("ambient/machines/squeak_5.wav")
							Clockwork.chatBox:AddInTargetRadius(player, "me", "starts to fix the "..ent.PrintName..".", player:GetPos(), config.Get("talk_radius"):Get() * 2); -- fix double name
							Clockwork.player:SetAction(player, "repairdeployable", 10, nil, function()
								if IsValid(ent) and IsValid(player) then			
									ent:EmitSound("ambient/machines/squeak_8.wav")
									if self then
										local maxfuel = ent:GetMaxHP() or 400 ----------------------------------------------fix
										local currentstatus = ent:GetHP()
										local canfuel = self:GetCondition()
										local condition = self:GetCondition() - (maxfuel- currentstatus)
										self:SetCondition(condition);
										if condition <= 0 then
											if currentstatus+canfuel > maxfuel then
												ent:SetHP( maxfuel )
											else
												ent:SetHP( currentstatus+canfuel )
											end
											player:TakeItem(self, true);
										else
											if currentstatus+canfuel > maxfuel then
												ent:SetHP( maxfuel )
											else
												ent:SetHP( currentstatus+canfuel )
											end
											
										end
									end
								end
								
							end);
							
						else
							return false
						end
					else
						Schema:EasyText(player, "chocolate", "You don't know how to do this!");
						return false
					end
				else
					return false
				end
			end;
			if (name == "Check Condition") then
				eyetraceplayer = player:GetEyeTrace()
				if player.HasBelief and player:HasBelief("mechanic") then
					if eyetraceplayer.Hit == true and eyetraceplayer.Entity then
						local ent = eyetraceplayer.Entity
						local fuel = ent:GetFuel()
						if ent.LVS == true and fuel and ent:GetPos():Distance(player:GetPos())<100 then
							local ratio = fuel/ent.MaxFuel
							if ratio == 1 then
								Schema:EasyText(player, "chocolate", "This chariot is full of fuel!");
							elseif ratio > 0.66 then
								Schema:EasyText(player, "chocolate", "This chariot has a medium amount of fuel!");
							elseif ratio > 0.33 then
								Schema:EasyText(player, "chocolate", "This chariot is low on fuel!");
							else
								Schema:EasyText(player, "chocolate", "This chariot is running very low on fuel!");
							end
						else
							return false
						end
					else
						return false
					end
				else
					Schema:EasyText(player, "chocolate", "You don't know how to do this!");
					return false
				end
			end;
		end;
	end;
	
	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
ITEM:Register();

local ITEM = Clockwork.item:New();
	ITEM.name = "Vehicle Deed";
	ITEM.uniqueID = "vehicle_deed";
	ITEM.cost = 1000;
	ITEM.model = "models/props_clutter/ohgma_infinium.mdl";
	ITEM.weight = 1;
	ITEM.category = "Tools";
	ITEM.description = "The paperwork bound in leather required to purchase a vehicle. A vehicle must then be assigned to the deed.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/ohgma_infinium.png";
	ITEM.stackable = false;
	ITEM:AddData("pulledvehicle", true, true); -- is the vehicle in storage?
	ITEM:AddData("vehicleassigned", "", true); -- keep track of what type of vehicle it is
	ITEM:AddData("vehiclenicename", "", true); -- vehicle name for display
	ITEM:AddData("vehiclefuel", 0, true); -- fuel
	ITEM:AddData("vehiclecondition", 0, true); -- health
	ITEM:AddData("VehicleCode", "", true); -- vehicle identification code
	ITEM:AddData("customName", "", true);
	ITEM:AddData("playernamestring", "", true);

	function ITEM:GetName()
		local customName = self:GetData("customName");
		local playername = self:GetData("playernamestring");

		if playername and playername ~= "" then
			customName = playername.." the "..customName;
		end
		
		if customName and customName ~= "" then
			return customName;
		else
			return self.name;
		end
	end;

	ITEM:AddQueryProxy("name", ITEM.GetName);
	
	if ITEM.customFunctions then
		table.insert(ITEM.customFunctions, "Deploy Vehicle");
		table.insert(ITEM.customFunctions, "Store Vehicle");
		table.insert(ITEM.customFunctions, "Assign Vehicle");
		table.insert(ITEM.customFunctions, "Name Vehicle");
	else
		ITEM.customFunctions = {"Deploy Vehicle","Store Vehicle","Assign Vehicle","Name Vehicle"};
	end
	

	function ITEM:OnCustomFunction(player, name)
		if (SERVER) then
			if !player.lastdeedtime then player.lastdeedtime = 0 end
			if player.lastdeedtime > CurTime() then return end
			player.lastdeedtime = CurTime() + 2
			if (name == "Deploy Vehicle") then
				local vehicle = self:GetData("pulledvehicle")
				if vehicle==false then
					Schema:EasyText(player, "chocolate", "A vehicle has been pulled from storage.");
					
					if self:GetData("vehicleassigned") then
						local nearbyents = ents.FindInSphere(player:GetPos(), 1000)
						for k, v in pairs(nearbyents) do			
							if IsValid(v) and v:GetClass() == "cw_carspawn" then
								self:SetData("pulledvehicle", true)
								local ent = ents.Create(self:GetData("vehicleassigned"))
								--ent:SetPos(player:GetPos())
								ent:SetPos(v:GetPos()+v:GetForward()*100)
								ent:Spawn()
								ent.vehiclecode = self:GetData("VehicleCode")
								ent:SetFuel(self:GetData("vehiclefuel"))
								ent:SetHP(self:GetData("vehiclecondition"))
								Schema:EasyText(player, "chocolate", "The beacon alights and your vehicle appears nearby.");
								local playerstringname = self:GetData("playernamestring")
								if playerstringname and playerstringname:len() > 0 then
									ent:SetNWString("lvsdesc", playerstringname.." the "..self:GetData("vehiclenicename"))
								else
									ent:SetNWString("lvsdesc", "A "..self:GetData("vehiclenicename").."")
								end

								local origin =	ent:GetPos();
								Clockwork.chatBox:AddInTargetRadius(player, "me", "deploys their "..ent.PrintName.." from storage.", player:GetPos(), config.Get("talk_radius"):Get() * 2);
								
								ParticleEffect("teleport_fx", origin, Angle(0,0,0));
								sound.Play("misc/summon.wav", origin, 100, 100);
								util.Decal("PentagramBurn", origin, origin + Vector(0, 0, -256));
								ent.Claimable = true
								return
							end
						end
						Schema:EasyText(player, "chocolate", "There are no vehicle beacons nearby.");
					else
						Schema:EasyText(player, "chocolate", "No vehicle has been assigned to this deed.");
					end
					
				else
					Schema:EasyText(player, "chocolate", "Vehicle is pulled or does not exist.");
				end
			end;
			if (name == "Store Vehicle") then
				eyetraceplayer = player:GetEyeTrace()
				if eyetraceplayer.Hit == true and eyetraceplayer.Entity and eyetraceplayer.Entity.LVS == true then
					local ent = eyetraceplayer.Entity
					if ent:GetPos():Distance(player:GetPos())<200 then
						local nearbyents = ents.FindInSphere(player:GetPos(), 1000)
						for k, v in pairs(nearbyents) do
							if ent and ent.vehiclecode and ent.vehiclecode == self:GetData("VehicleCode") then
								if self:GetData("pulledvehicle") == true then
									if IsValid(v) and v:GetClass() == "cw_carspawn" then
										--self:SetData("customName", ent.PrintName)
										self:SetData("vehicleassigned", ent:GetClass())
										self:SetData("vehiclenicename", ent.PrintName)
										self:SetData("vehiclefuel", ent:GetFuel())
										self:SetData("pulledvehicle", false)
										self:SetData("vehiclecondition", ent:GetHP())
										local origin =	ent:GetPos();
									
										ParticleEffect("teleport_fx", origin, Angle(0,0,0));
										sound.Play("misc/summon.wav", origin, 100, 100);
										util.Decal("PentagramBurn", origin, origin + Vector(0, 0, -256));
										ent:Remove()
										Schema:EasyText(player, "chocolate", "Vehicle has been stored.");
										Clockwork.chatBox:AddInTargetRadius(player, "me", "sends their "..ent.PrintName.." to storage.", player:GetPos(), config.Get("talk_radius"):Get() * 2);
										return
									end
								else
									Schema:EasyText(player, "chocolate", "You have a vehicle stored with this deed already.");
									return
								end
							end
							
						end
						Schema:EasyText(player, "chocolate", "There is no beacon to store your vehicle nearby.");
					else
						Schema:EasyText(player, "chocolate", "The vehicle is too far away.");
					end
						
				else
					Schema:EasyText(player, "chocolate", "You must be looking at a vehicle to store it.");
				end
			end;
			if (name == "Assign Vehicle") then
				if cwBeliefs and !player:HasBelief("scribe") then
					Schema:EasyText(player, "chocolate", "You do not know how to scribe a deed.");
					return
				end
				eyetraceplayer = player:GetEyeTrace()
				if eyetraceplayer.Hit == true and eyetraceplayer.Entity then
					local ent = eyetraceplayer.Entity
					if ent.LVS == true then
						if (!ent.vehiclecode) then
							if ent:GetPos():Distance(player:GetPos())<100 then
								if self:GetData("pulledvehicle") == true then
									if !ent.isclaimable then
										Schema:EasyText(player, "chocolate", "This vehicle is not claimable right now.")
										return
									end
									if (ent.usedtime and ent.usedtime>CurTime()) and (ent.buyer and ent.buyer != player) then
										Schema:EasyText(player, "chocolate", "This vehicle is waiting for someone else.")
										return
									end
									self:SetData("customName", ""..ent.PrintName.." Vehicle Deed")
									self:SetData("vehicleassigned", ent:GetClass())
									self:SetData("vehiclenicename", ent.PrintName)
									local knownvehiclecode = self:GetData("VehicleCode")
									for _, v in ipairs(ents.GetAll()) do
										if IsValid(v) and v.LVS and v.vehiclecode and v.vehiclecode == knownvehiclecode then
											v.vehiclecode = nil
											Schema:EasyText(player, "chocolate", "Unassigned "..v.PrintName.." from your deed.");
										end
									end
									if knownvehiclecode == nil or knownvehiclecode == "" then
										self:SetData("VehicleCode", ""..player:Nick()..""..math.random(1, 1000)..""..ent.PrintName.."")
									end
									ent.vehiclecode = self:GetData("VehicleCode")
									Schema:EasyText(player, "chocolate", "Assigned "..ent.PrintName.." to your deed.");
									Clockwork.chatBox:AddInTargetRadius(player, "me", "scribes a vehicle deed for a "..ent.PrintName..".", player:GetPos(), config.Get("talk_radius"):Get() * 2);
								else
									Schema:EasyText(player, "chocolate", "This deed belongs to a stored vehicle. It must be removed from storage to claim a new one.")
								end
							else
								Schema:EasyText(player, "chocolate", "The vehicle is too far away.")
							end
						else
							Schema:EasyText(player, "chocolate", "This vehicle either belongs to someone else or is not valid for this deed.");
						end
					else
						Schema:EasyText(player, "chocolate", "This thing is not valid for this deed.");
					end
				end
			end;
			if (name == "Name Vehicle") then
				if self:GetData("pulledvehicle") == false then
					if cwBeliefs and !player:HasBelief("literacy") then
						Schema:EasyText(player, "chocolate", "You are not literate!");
					else
						Clockwork.dermaRequest:RequestString(player, "Name Vehicle", "What would you like to name this vehicle?", "", function(result)
							result = tostring(result)
							
							if result and result:len() > 0 then
								self:SetData("playernamestring", result);
							end
							
						end);
					end;
				else
					Schema:EasyText(player, "chocolate", "You can only name a vehicle when one exists in storage!");
				end
			end;
		end
	end;

	function ITEM:GetCustomName()
		local customName = self:GetData("customName");
		local playername = self:GetData("playernamestring");

		if playername and playername ~= "" then
			customName = playername.." the "..customName;
		end
		
		if customName and customName ~= "" then
			return customName;
		else
			return self.name;
		end
	end
	
	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
ITEM:Register();


local ITEM = Clockwork.item:New();
	ITEM.name = "Gravel Grinder Vehicle Scroll";
	ITEM.uniqueID = "vehicle_token_gravelgrinder";
	ITEM.cost = 1000;
	ITEM.model = "models/props_clutter/note01_blood.mdl";
	ITEM.weight = 1;
	ITEM.category = "Tools";
	ITEM.description = "A bloody scroll with a drawing of a vehicle.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/note01_blood.png";
	ITEM.stackable = false;
	ITEM.selfcartype = "lvs_buggy"

	if ITEM.customFunctions then
		table.insert(ITEM.customFunctions, "Crush Scroll");
	else
		ITEM.customFunctions = {"Crush Scroll"};
	end
	
	if (SERVER) then
		function ITEM:OnCustomFunction(player, name)
			if !player.lastfliptime then player.lastfliptime = 0 end
			if player.lastfliptime > CurTime() then return end
			player.lastfliptime = CurTime() + 2
			if (name == "Crush Scroll") then
				local nearbyents = ents.FindInSphere(player:GetPos(), 1000)
				for k, v in pairs(nearbyents) do
					if IsValid(v) and v:GetClass() == "cw_carspawn" then
						player:EmitSound("fiend/coinflip.wav");
						local ent = ents.Create(self.selfcartype)
						ent:SetPos(v:GetPos()+v:GetForward()*100)
						ent:Spawn()
						ent.usedtime = CurTime()+120
						ent.buyer = player
						ent.isclaimable = true
						player:TakeItem(self, true);
						Schema:EasyText(player, "chocolate", "The scroll turns to ash as you close your hand. It is gone by the time your hand opens. A promise has been fulfilled.");
						local origin =	ent:GetPos();
								
						ParticleEffect("teleport_fx", origin, Angle(0,0,0));
						sound.Play("misc/summon.wav", origin, 100, 100);
						util.Decal("PentagramBurn", origin, origin + Vector(0, 0, -256));
						return
					end
				end
				Schema:EasyText(player, "chocolate", "You crush the scroll but nothing happens. It remains.");

				
			end;
		end
	end
	
	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
ITEM:Register();