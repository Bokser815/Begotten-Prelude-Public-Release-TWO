--[[
	BEGOTTEN: Damnation was created by cash wednesday.
--]]

-- Called when the foreground HUD should be painted.
function cwBasement:HUDPaintForeground()
	
	if (Clockwork.Client:Alive() and Clockwork.Client:HasInitialized()) then
		local colorWhite = Clockwork.option:GetColor("white");
		local frameTime = FrameTime();
		local curTime = CurTime();
		local scrW = ScrW();
		local scrH = ScrH();

		if (!self.hintTexts) then 
			return;
		end;
		
		if (table.Count(self.hintTexts) > 1) then
			table.remove(self.hintTexts, 1);
		end;
		
		local hintText = self.hintTexts[1];
		
		if (!hintText) then
			return;
		end;

		if (!hintText.fadeBack or curTime >= hintText.fadeBack) then
			hintText.alpha = math.Approach(hintText.alpha, hintText.targetAlpha, frameTime * 64);
		end;
		
		if (!hintText.delay) then
			hintText.delay = 5;
		end;
		
		if (!hintText.sideFade) then
			hintText.sideFade = 0;
		end;
		
		if (!hintText.color) then
			hintText.color = Color(255, 255, 255, 200);
		end;
		
		if (hintText.targetAlpha == 0 and hintText.alpha == 0) then
			table.remove(self.hintTexts, 1);
			
			return;
		elseif (hintText.targetAlpha == 255 and hintText.alpha == 255 and !hintText.fadeBack) then
			hintText.targetAlpha = 0;
			hintText.fadeBack = curTime + hintText.delay;
		end;

		local textFont = "AHintHeader";
		local subTextFont = "AHintSubHeader";
		
		local user = hintText.subHeaders[1];
		
		if (string.len(user) <= 12) then
			user = string.rep(user, 2);
		end;
		
		local textWidth, textHeight = Clockwork.kernel:GetCachedTextSize(textFont, hintText.header)
		local textWidthSub, textHeightSub = Clockwork.kernel:GetCachedTextSize(subTextFont, user);
		
		local messages = 0;
		
		local subX = scrW - ((scrW * 0.075) + (textWidthSub / 1.2));
		local subY = scrH - (scrH * 0.03 + (textHeightSub + 60));
		local headerX = scrW - ((scrW * 0.075) + (textWidthSub * 0.85));
		local headerY = scrH - (scrH * 0.03 + (textHeightSub + 60)) - (textHeight + 12);
		
		draw.RoundedBox(0, ((headerX - hintText.sideFade) - textWidthSub * 0.5) - 64, headerY - 16, textWidthSub + 144, 256, Color(0, 0, 30, math.Clamp(hintText.alpha, 0, 35)));
		
		for k, v in pairs (hintText.subHeaders) do
			Clockwork.kernel:OverrideMainFont(subTextFont);
				Clockwork.kernel:DrawInfo(v, subX - hintText.sideFade, subY + ((textHeightSub + 4) * messages), Color(255, 255, 255), hintText.alpha);
			Clockwork.kernel:OverrideMainFont(false);
			
			messages = messages + 1;
		end;
		
		Clockwork.kernel:OverrideMainFont(textFont);
			Clockwork.kernel:DrawInfo(hintText.header, headerX - hintText.sideFade, headerY, Color(255, 255, 255), hintText.alpha);
		Clockwork.kernel:OverrideMainFont(false);
		
		hintText.sideFade = math.Approach(hintText.sideFade, 0, frameTime * 48);
	end;
end;

-- Called every frame.
function cwBasement:Think()

	if (Clockwork.Client:Alive() and Clockwork.Client:HasInitialized() and Clockwork.Client:GetZone() ~= "basement") then return end; -- if they are not in the basement, don't do this shit!!!
	
	local position = Clockwork.Client:GetPos();
	local curTime = CurTime();
	
	if (Clockwork.Client:Alive() and Clockwork.Client:HasInitialized() and Clockwork.Client.cwObserverMode != true) then
		if (!Clockwork.Client.nextInterupt or curTime > Clockwork.Client.nextInterupt) then
			Clockwork.Client.nextInterupt = curTime + 8;
			
			if (Clockwork.Client.noThinks) then
				return;
			end;
			
			local myThought = nil;

			for k, v in pairs (ents.FindInSphere(Clockwork.Client:GetPos(), 1000)) do
				local class = v:GetClass();
				
				if (table.HasValue(cwZombies.zombieNPCS, class)) then
					myThought = table.Random(self.scaredEnemy["default"]);
				
					if (class == "npc_sewer_chainsawer") then
						if (math.random(1, 3) == 3) then
							myThought = table.Random(self.scaredEnemy["chainsawer"]);
						end;
					end;
				end;
			end;

			for k, v in pairs (ents.FindInSphere(Clockwork.Client:GetPos(), 500)) do
				local class = v:GetClass();
				
				if (table.HasValue(cwZombies.zombieNPCS, class)) then
					myThought = table.Random(self.beingChased);
				end;
			end;
			
			if (myThought != nil) then
				if (Clockwork.Client.lastMyThought) then
					if (type(Clockwork.Client.lastMyThought) == "string" and myThought == Clockwork.Client.lastMyThought) then
						Clockwork.Client.nextInterupt = curTime + 0.5;
						
						return;
					end;
				end;
				
				local name = Clockwork.Client:Name();
				
				cwBasement:PrintCustomHint(string.Split(name, " ")[1].." thinks...", myThought, 5, Color(255, 255, 255, 255));
			end;
		end;

		if (!Clockwork.Client.nextThought) then
			Clockwork.Client.nextThought = curTime + 180;
		elseif (Clockwork.Client.nextThought < curTime) then
			if (Clockwork.Client.noThinks) then
				return;
			end;
			
			local validThoughts = {};
			
			for k, v in pairs (self.defaultThoughts) do
				table.insert(validThoughts, v);
			end;

			if (math.random(1, 10) == 10) then
				if (Clockwork.Client:IsAlone()) then
					for k, v in pairs (self.aloneThoughts) do
						table.insert(validThoughts, v);
					end;
				end;
			end;
			
			local myThought = table.Random(validThoughts);
			
			local inventoryWeight = Clockwork.inventory:CalculateWeight(Clockwork.inventory:GetClient());
			local maximumWeight = Clockwork.player:GetMaxWeight();
			
			local maxHealth = Clockwork.Client:GetMaxHealth();
			local health = Clockwork.Client:Health();
			local maxSanity = 100;
			local sanity = Clockwork.Client:GetSharedVar("sanity");

			for k, v in pairs (ents.FindInSphere(position, 250)) do
				local class = v:GetClass();
				local model = v:GetModel();
				
				if (math.random(1, 4) == 4) then
					if (class == "prop_physics") then
						if (Clockwork.entity:CanSeeEntity(Clockwork.Client, v)) then
							if (string.lower(model) == string.lower("models/props_c17/FurnitureDresser001a.mdl")) then
								myThought = table.Random(self.propDescriptions["wardrobe"]);
							elseif (string.lower(model) == string.lower("models/props_junk/TrashDumpster01a.mdl")) then
								myThought = table.Random(self.propDescriptions["dumpster"]);
							elseif (string.find(string.lower(model), "wood_crate")) then
								myThought = table.Random(self.propDescriptions["crate"]);
							elseif (string.find(string.lower(model), "chair")) then
								myThought = table.Random(self.propDescriptions["chair"]);
							elseif (string.lower(model) == "models/props_wasteland/controlroom_filecabinet002a.mdl") then
								myThought = table.Random(self.propDescriptions["cabinet"]);
							elseif (string.find(model, "models/props_wasteland/controlroom_storagecloset001")) then
								myThought = table.Random(self.propDescriptions["closet"]);
							elseif (string.lower(model) == "models/props_lab/cactus.mdl" and math.random(1, 3) == 3) then
								myThought = "Cactus.";
							end;
						end;
					end;
				end;

				if (math.random(1, 4) == 4) then
					if (class == "cw_item") then
						local canSeeEntity = Clockwork.entity:CanSeeEntity(Clockwork.Client, v);
						
						if (canSeeEntity) then
							local itemTable = v:GetItemTable();
							local itemName = itemTable("name");
							local itemWeight = itemTable("weight");
							local itemCategory = itemTable("category");
							
							if (!string.find(string.lower(itemCategory), "quest") or string.find(string.lower(itemCategory), "story")) then
								if (itemName) then
									local itemName = string.lower(itemName);
									
									if (itemWeight) then
										if (itemWeight <= 5) then
											if (itemCategory != "Junk") then
												if ((itemWeight + inventoryWeight) < maximumWeight) then
													myThought = table.Random({"I see a "..itemName.."..", "I should pick up that "..itemName.."..", "That "..itemName.." may be useful..", "Maybe I should take that "..itemName.."...", "That "..itemName.." could come in handy later..."});
												else
													myThought = table.Random({"I could take that "..itemName..", but it might just weigh me down even more than I already am...", "That "..itemName.."....might fit in my pack...", "I might have to make room if I want to take that "..itemName.."..", "If only I could carry that "..itemName.." without weighing myself down more..."});
												end;
												
												if (itemCategory == "Consumables") then
													myThought = table.Random({"That "..itemName.." looks so..delicious...", "I could gobble up that "..itemName.." in a heart beat!", "That "..itemName.." looks very apetizing right now..."});
												end;
											end;
										else
											myThought = table.Random({"That "..itemName.." looks really heavy...", "I might not have any room for that "..itemName..".. It seems heavy..", "That "..itemName.." looks huge! I wonder if it would fit in my pack."});
										end;
									end;
									
									if (itemCategory and string.lower(itemCategory) == "medical") then
										if (health < 50) then
											local savingGraces = {
												"bandage",
												"gauze",
												"medkit",
												"laudenum"
											};
											
											if (table.HasValue(string.lower(itemName), savingGraces)) then
												myThought = itemName.."!";
											end;
										end;
									end;
								end;
							end;
						end;
					end;
				end;

				if (math.random(1, 4) == 4) then
					local isPlayer = v:IsPlayer();
					local moveType = v:GetMoveType();
					
					if (isPlayer and moveType == MOVETYPE_WALK) then
						if (v != Clockwork.Client) then
							local canSeePlayer = Clockwork.entity:CanSeePlayer(Clockwork.Client, v);
							
							if (canSeePlayer) then
								local playerGender = Clockwork.Client:GetGender();
								local targetGender = v:GetGender()
								local gender = "He";
								local thirdPerson = "He";
								
								if (targetGender == GENDER_FEMALE) then
									gender = "She";
									thirdPerson = "She";
								end;
								
								local doesRecognise = Clockwork.player:DoesRecognise(Clockwork.Client, v);
								local playerName = v:Name();
								local name = gender;
								
								if (doesRecognise) then
									name = string.Split(playerName, " ")[1];
								else
									name = gender;
								end;
							end;
						end;
					end;
				end;
				
				--[[local isOnFire = v:IsOnFire();

				if (isOnFire) then
					if (class == "prop_physics") then
						myThought = table.Random(self.fireDescriptions);
						
						if (model == "models/props_junk/rock001a.mdl") then
							if (math.random(1, 3) == 3) then
								myThought = table.Random({"Strange...I don't remember lighting that fireplace..", "I wonder who lit that fireplace...", "Who lit that fireplace...?", "Weird...Did somebody else light that fireplace..?"});
							else
								myThought = table.Random({"Ah. I can already feel my mind mending itself back together in the presence of this fireplace...", "This fireplace feels like..it's calming my soul and mind.."});
							end;
						end;
					end;
				end;]]--
				
				if math.random(1, 2) == 1 then
					if class == "env_fire" then
						if v:GetPos():Distance(position) > 125 then
							myThought = table.Random({"I wonder who lit that fire barrel...?", "A lit fire barrel... it almost seems too good to be true.", "I can warm up at that fire barrel..."});
						else
							myThought = table.Random({"This warmth is nice...", "This fire barrel feels like it's calming my soul and mind...", "If only this fire barrel didn't smell so bad...", "It's nice and warm here..."});
						end;
					end
				end
			end;

			if (math.random(1, 3) == 3) then
				if (inventoryWeight > (maximumWeight * 2)) then
					if (math.random(1, 2) == 2) then
						myThought = table.Random({"This pack is heavy... I should probably ditch some stuff I don't need...", "My back is going to break under the weight of this backpack!..", "If only I had one more bag to carry all this weight...", "I feel like I'm going to collapse, this pack is too heavy!..", "Damn...this....backpack....."});
					end;
				elseif (inventoryWeight > maximumWeight) then
					if (math.random(1, 2) == 2) then
						myThought = table.Random({"This pack is getting kind of heavy.. I should ditch some stuff I don't need before it becomes a problem..", "I should start thinking about getting rid of some of this stuff..."});
					end;
				elseif (inventoryWeight < maximumWeight * 0.25) then
					if (math.random(1, 2) == 2) then
						myThought = table.Random({"I'm travelling rather light..maybe there are some useful supplies around..", "This pack feels as light as a feather..I should probably change that..", "I need to find some supplies, my pack is super light..", "If I don't find any supplies soon, I doubt I ever will..", "Am I getting stronger, or is this backpack just super light?..."})
					end;
				end;
			end;

			local waterLevel = Clockwork.Client:WaterLevel();
			
			if (waterLevel >= 3) then
				myThought = table.Random(self.waterDescriptions);
			end;
			
			if (math.random(1, 2) == 1) then
				if (sanity < (maxSanity * 0.5)) then
					myThought = table.Random(self.mediumSanity);
				end;
			
				if (health < (maxHealth * 0.45)) then
					myThought = table.Random(self.mediumHealth);
				end;
			end;

			if (math.random(1, 6) <= 3) then
				if (sanity < (maxSanity * 0.2)) then
					myThought = table.Random(self.lowSanity);
				end;
				
				if (health < (maxHealth * 0.15)) then
					myThought = table.Random(self.criticalCondition);
				end;
			end;
			
			local clientAction = Clockwork.player:GetAction(Clockwork.Client)

			if (clientAction == "die") then
				myThought = table.Random(self.deathThoughts);
			end;

			if (Clockwork.Client.lastMyThought) then
				if (type(Clockwork.Client.lastMyThought) == "table" and Clockwork.Client.lastMyThought == myThought) then
					Clockwork.Client.nextThought = curTime + 1;
					
					return;
				end;
			end;

			self:PrintCustomHint(Clockwork.Client:FirstName().." thinks...", myThought, 5, Color(255, 255, 255, 255));
			
			Clockwork.Client.nextThought = nil;
			Clockwork.Client.lastMyThought = myThought;
		end;
	end;
end;