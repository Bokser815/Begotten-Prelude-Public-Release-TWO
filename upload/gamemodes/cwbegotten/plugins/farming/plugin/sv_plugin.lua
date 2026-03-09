concommand.Add("cw_AddSeed", function(player, cmd, args)
    if (player:Alive()) then
        local eyePos = player:EyePos();
        local aimVector = player:GetAimVector();
        local seedType = args[1];
        local numSeeds = tonumber(args[2]) or 1;

        local trace = {};
            trace.start = eyePos;
            trace.endpos = trace.start + aimVector * 128;
            trace.filter = player;
        local traceLine = util.TraceLine(trace);
        
        local planter = traceLine.Entity;
        if (IsValid(planter) and planter:GetClass() == "cw_planter") then
            cwFarming:AddSeed(planter, seedType, numSeeds, true, player)
        else
            Schema:EasyText(player, "firebrick", "You must look at a planter to plant your seed!");
            return false;
        end;
    end;
end);

function cwFarming:AddSeed(planter, seedType, numSeeds, removeSeed, player)
    if (IsValid(planter) and planter:GetClass() == "cw_planter") then
        
        if not planter:WillMakeFull(numSeeds) then
            local itemTable =  player:FindItemByID("seed_" .. seedType)
            if (removeSeed and (not itemTable or player:GetItemCountByID("seed_" .. seedType) < numSeeds)) then
                Schema:EasyText(player, "chocolate", "You don't have " .. numSeeds .. " " .. seedType .. " seeds!");
                return;
            else
                
                for i=1, numSeeds do 
                    planter:PlantSeed(seedType, player:HasBelief("gift_great_tree"))
                    if removeSeed then
                        player:TakeItemByID("seed_" .. seedType)
                    end
                end
                Schema:EasyText(player, "green", "You plant " .. numSeeds .. " " .. seedType .. " seeds.");
            end; 
        else
            Schema:EasyText(player, "firebrick", "The planter is full!");
            return false;
        end
    else
        Schema:EasyText(player, "firebrick", "You must look at a planter to plant your seed!");
        return false;
    end
end

concommand.Add("cw_WaterPlanter", function(player, cmd, args)
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
            local itemTable = player:FindItemByID("purified_water_bucket")
            if (!itemTable) then
                Schema:EasyText(player, "chocolate", "You don't have a filled water bucket.");
                return;
            else
                if not planter:IsWatered() then
                    planter:Water()
                    player:GiveItem(Clockwork.item:CreateInstance("empty_bucket"), true);
                    player:TakeItem(itemTable, true);
                    Schema:EasyText(player, "lawngreen", "You pour some water into the planter.");
                else
                    Schema:EasyText(player, "firebrick", "The planter is filled with water!");
                end
            end
        else
            Schema:EasyText(player, "firebrick", "You must look at a planter to water it!");
            return false;
        end;
    end;
end);

concommand.Add("cw_Harvest", function(player, cmd, args)
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
            planter:Harvest(player);
        else
            Schema:EasyText(player, "firebrick", "You must look at a planter to harvest!");
            return false;
        end;
    end;
end);

concommand.Add("cw_InfectToggle", function(player, cmd, args)
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
            if planter.infected then
                planter:RemoveInfection()
            else
                planter:Infect();
            end
        else
            Schema:EasyText(player, "firebrick", "You must look at a planter to toggle its infection!");
            return false;
        end;
    end;
end);


concommand.Add("cw_Fertilize", function(player, cmd, args)
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
            if player:FindItemByID("Fertilizer") then
                if not planter:Fertilized() then
                    planter:Fertilize();
                    Schema:EasyText(player, "green", "You spread some fertilizer into the planter.");
                    player:TakeItemByID("Fertilizer")
                else
                    Schema:EasyText(player, "firebrick", "The planter is already fertilized.");
                    return false;
                end
            else
                Schema:EasyText(player, "firebrick", "You don't have any fertilizer.");
                return false;
            end
        else
            Schema:EasyText(player, "firebrick", "You must look at a planter to fertilize!");
            return false;
        end;
    end;
end);

concommand.Add("cw_ViewInfo", function(player, cmd, args)
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
            planter:ViewInfo(player);
        else
            Schema:EasyText(player, "firebrick", "You must look at a planter to view its info!");
            return false;
        end;
    end;
end);

--[[concommand.Add("cw_RemoveSeeds", function(player, cmd, args)
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
            planter:RemoveSeeds(player);
        else
            Schema:EasyText(player, "firebrick", "You must look at a planter to remove seeds!");
            return false;
        end;
    end;
end);]]--

concommand.Add("cw_RemoveSeed", function(player, cmd, args)
    if (player:Alive()) then
        local eyePos = player:EyePos();
        local aimVector = player:GetAimVector();
        local seedType = args[1];
        local numSeeds = tonumber(args[2]) or 1;

        local trace = {};
            trace.start = eyePos;
            trace.endpos = trace.start + aimVector * 128;
            trace.filter = player;
        local traceLine = util.TraceLine(trace);
        
        local planter = traceLine.Entity;
        if (IsValid(planter) and planter:GetClass() == "cw_planter") then
            planter:RemoveSeed(player, seedType, numSeeds)
        else
            Schema:EasyText(player, "firebrick", "You must look at a planter to remove a crop!");
            return false;
        end;
    end;
end);

concommand.Add("cw_BurnCrops", function(player, cmd, args)
	local trace = player:GetEyeTrace();

	if (trace.Entity) then
		local entity = trace.Entity;
		
		if entity:GetPos():Distance(player:GetPos()) < 256 then
			if (entity:GetClass() == "cw_planter") then
				local activeWeapon = player:GetActiveWeapon();
				
				if IsValid(activeWeapon) and activeWeapon:GetClass() == "cw_lantern" then
					local oil = player:GetSharedVar("oil", 0);
				
					if oil >= 75 then
                        Clockwork.chatBox:AddInTargetRadius(player, "me", "attempts to ignite the planter before them with their lantern!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 2);
                        Clockwork.player:SetAction(player, "burn_planter", 30, 1, function() 
                            if entity:IsValid() then
                                if entity:GetPos():Distance(player:GetPos()) < 256 then
                                    local activeWeapon = player:GetActiveWeapon();
                                    
                                    if IsValid(activeWeapon) and activeWeapon:GetClass() == "cw_lantern" then
                                        if entity.health and entity.health > 0 then
                                            entity:Ignite(600, 0);
                                            
                                            local weaponItemTable = item.GetByWeapon(activeWeapon);
                                            
                                            if weaponItemTable then
                                                weaponItemTable:SetData("oil", math.Clamp(oil - 75, 0, 100));
                                                player:SetSharedVar("oil", math.Round(weaponItemTable:GetData("oil"), 0));
                                            end
                                            
                                            entity:EmitSound("ambient/fire/gascan_ignite1.wav");
                                            
                                            Clockwork.chatBox:AddInTargetRadius(player, "me", "ignites the planter before them with their lantern!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 2);
                                        else
                                            Schema:EasyText(player, "firebrick", "The planter is already destroyed.");
                                        end
                                    else
                                        Schema:EasyText(player, "firebrick", "You must have a lantern equipped to burn the planter.");
                                    end
                                else
                                    Schema:EasyText(player, "firebrick", "You are too far from the planter to burn it.");
                                end
                            else
                                Schema:EasyText(player, "firebrick", "The planter no longer exists.");
                            end
                        end);
					else
                        Schema:EasyText(player, "firebrick", "You need more oil to burn the planter.");
                    end
				else
                    Schema:EasyText(player, "firebrick", "You must have a lantern equipped to burn the planter.");
                end
			else
                Schema:EasyText(player, "firebrick", "You must look at a planter to burn it.");
            end
		else
            Schema:EasyText(player, "firebrick", "You are too far from the planter to burn it.");
        end
	else
        Schema:EasyText(player, "firebrick", "You must look at something to burn.");
    end
end);


concommand.Add("cw_AdminWaterPlanter", function(player, cmd, args)
    if (player:Alive() and player:IsAdmin()) then
        local eyePos = player:EyePos();
        local aimVector = player:GetAimVector();
        
        local trace = {};
            trace.start = eyePos;
            trace.endpos = trace.start + aimVector * 128;
            trace.filter = player;
        local traceLine = util.TraceLine(trace);
        
        local planter = traceLine.Entity;
        if (IsValid(planter) and planter:GetClass() == "cw_planter") then
            planter:WaterFull();
        else
            Schema:EasyText(player, "firebrick", "You must look at a planter to add max water!");
            return false;
        end;
    end;
end);

concommand.Add("cw_AdminQuickGrow", function(player, cmd, args)
    if (player:Alive() and player:IsAdmin()) then
        local eyePos = player:EyePos();
        local aimVector = player:GetAimVector();
        
        local trace = {};
            trace.start = eyePos;
            trace.endpos = trace.start + aimVector * 128;
            trace.filter = player;
        local traceLine = util.TraceLine(trace);
        
        local planter = traceLine.Entity;
        if (IsValid(planter) and planter:GetClass() == "cw_planter") then
            planter:QuickGrow();
        else
            Schema:EasyText(player, "firebrick", "You must look at a planter to quick grow!");
            return false;
        end;
    end;
end);

concommand.Add("cw_AdminRandomPlant", function(player, cmd, args)
    if (player:Alive() and player:IsAdmin()) then
        local eyePos = player:EyePos();
        local aimVector = player:GetAimVector();
        
        local trace = {};
            trace.start = eyePos;
            trace.endpos = trace.start + aimVector * 128;
            trace.filter = player;
        local traceLine = util.TraceLine(trace);
        
        local planter = traceLine.Entity;
        if (IsValid(planter) and planter:GetClass() == "cw_planter") then
            planter:RandomPlant();
        else
            Schema:EasyText(player, "firebrick", "You must look at a planter to randomly plant seeds!");
            return false;
        end;
    end;
end);

concommand.Add("cw_AdminRandomAll", function(player, cmd, args)
    if (player:Alive() and player:IsAdmin()) then
        local eyePos = player:EyePos();
        local aimVector = player:GetAimVector();
        
        local trace = {};
            trace.start = eyePos;
            trace.endpos = trace.start + aimVector * 128;
            trace.filter = player;
        local traceLine = util.TraceLine(trace);
        
        local planter = traceLine.Entity;
        if (IsValid(planter) and planter:GetClass() == "cw_planter") then
            planter:RandomAll();
        else
            Schema:EasyText(player, "firebrick", "You must look at a planter to randomly plant seeds!");
            return false;
        end;
    end;
end);

concommand.Add("cw_AdminInfWater", function(player, cmd, args)
    if (player:Alive() and player:IsAdmin()) then
        local eyePos = player:EyePos();
        local aimVector = player:GetAimVector();
        
        local trace = {};
            trace.start = eyePos;
            trace.endpos = trace.start + aimVector * 128;
            trace.filter = player;
        local traceLine = util.TraceLine(trace);
        
        local planter = traceLine.Entity;
        if (IsValid(planter) and planter:GetClass() == "cw_planter") then
            planter:WaterFull();
            planter:ToggleInfWater();
        else
            Schema:EasyText(player, "firebrick", "You must look at a planter to randomly plant seeds!");
            return false;
        end;
    end;
end);



-- logic for loading/saving planters
if not cwFarming.planters then
    cwFarming.planters = {}
end

function cwFarming:LoadPlanters()
	local planters = Clockwork.kernel:RestoreSchemaData("plugins/farming/"..game.GetMap());
    for k, v in pairs(planters) do
		local planter = ents.Create("cw_planter")
        
		planter:SetPos(v.position)
		planter:SetModel(v.model)
		planter:SetAngles(v.angles)
        planter:SetNWInt("water", v.water)
		planter:Spawn()

        -- go thru slots n spawn the plants
        for k, v in pairs(v.slots) do
            if v then
                planter:PlantSeed(v.seedType, v.fotmMultiplier, v.growth)
            end
        end
	end
end;


function cwFarming:SavePlanters()
    local planters = {}
    for i = #cwFarming.planters, 1, -1 do
        planter = cwFarming.planters[i]
        if planter then
            local physicsObject = planter:GetPhysicsObject()
            local bMoveable = nil
            if IsValid(physicsObject) then
                bMoveable = physicsObject:IsMoveable()
            end

            local slotsData = {}
           
            for _, crop in pairs(planter.slots) do
                local multi = false
                if crop.fotmMultiplier > 1.0 then
                    multi = true
                end
                slotsData[#slotsData + 1] = {
                    seedType = crop.item,
                    growth = crop:GetNWInt("growth", 0),
                    fotmMultiplier = multi
                }
            end

            planters[#planters + 1] = {
                key = Clockwork.entity:QueryProperty(planter, "key"),
                uniqueID = Clockwork.entity:QueryProperty(planter, "uniqueID"),
                position = planter:GetPos(),
                model = planter:GetModel(),
                angles = planter:GetAngles(),
                water = planter:GetNWInt("water", 0),
                isMoveable = bMoveable,
                slots = slotsData
            }
        else
            table.remove(cwFarming.planters,i)
        end
    end

    Clockwork.kernel:SaveSchemaData("plugins/farming/"..game.GetMap(), planters);
end
