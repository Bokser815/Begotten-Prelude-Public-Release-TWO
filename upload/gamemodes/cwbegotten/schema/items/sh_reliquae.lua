--[[
	Begotten III: Jesus Wept
	By: DETrooper, cash wednesday, gabs, alyousha35

	Other credits: kurozael, Alex Grist, Mr. Meow, zigbomb
--]]

-- For expensive supercrate/event items.

local ITEM = Clockwork.item:New();
	ITEM.name = "Sound-Signal Transciever";
	ITEM.model = "models/props/cs_office/computer_caseb_p7a.mdl";
	ITEM.weight = 0.8;
	ITEM.uniqueID = "lrad";
    ITEM.category = "Reliquae";
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

local ITEM = Clockwork.item:New("enchanted_base");
	ITEM.name = "Ansible";
	ITEM.model = "models/gibs/shield_scanner_gib1.mdl";
	ITEM.weight = 0.8;
	ITEM.uniqueID = "ansible_new";
    ITEM.category = "Reliquae";
	ITEM.description = "A peculiar chrome device, still shiny from centuries of being buried underground. It spirals upwards into a fine black tip, lightly flashing red.";
	ITEM.iconoverride = "materials/begotten/ui/itemicons/thermal_implant.png";
	ITEM.charmEffects = "- Allows you to eavesdrop on conversations. Very noticeable.";
	ITEM.requiredSubfaiths = {"Voltism"};
	ITEM.permanent = true;
	
	function ITEM:OnPlayerUnequipped(player, extraData)
		if player:GetSubfaith() == "Voltism" and extraData != "force_unequip" then
			Schema:EasyText(player, "peru", "This implant is fused into your occipital lobe and cannot be unequipped!");
			return false;
		end
		
		if Clockwork.equipment:UnequipItem(player, self) then
			local useSound = self.useSound;
			
			if !player:IsNoClipping() and (!player.GetCharmEquipped or !player:GetCharmEquipped("urn_silence")) then
				if (useSound) then
					if (type(useSound) == "table") then
						player:EmitSound(useSound[math.random(1, #useSound)]);
					else
						player:EmitSound(useSound);
					end;
				elseif (useSound != false) then
					player:EmitSound("begotten/items/first_aid.wav");
				end;
			end
            player:SetNWBool("ansibleIn", false)
		end
	end

    function ITEM:OnUse(player, itemEntity)
        if self:HasPlayerEquipped(player) then
            if not player.spawning then
                Schema:EasyText(player, "peru", "You already have a charm of this type equipped!")
            end
            return false
        end
    
        if self.requiredSubfaiths and not table.HasValue(self.requiredSubfaiths, player:GetSubfaith()) then
            if not player.spawning then
                Schema:EasyText(player, "chocolate", "You are not of the correct subfaith to wear this!")
            end
            return false
        end
    
        if player:Alive() then
            local clothesItem = player:GetClothesEquipped()
    
            for i, v in ipairs(self.slots) do
                if not player.equipmentSlots[v] then
                    Clockwork.equipment:EquipItem(player, self, v)
                    player:SetNWBool("ansibleIn", true) -- note to self: not fucking working
                    Clockwork.chatBox:AddInTargetRadius(
                        player, 
                        "me", 
                        "smashes the pointy end of the ansible into his skull!", 
                        player:GetPos(), 
                        Clockwork.config:Get("talk_radius"):Get() * 1.5
                    )
                    return true
                end
            end
    
            if not player.spawning then
                Schema:EasyText(player, "peru", "You do not have an open slot to equip this charm in!")
            end
            return false
        else
            if not player.spawning then
                Schema:EasyText(player, "peru", "You cannot do this action at this moment.")
            end
        end
    
        return false
    end

	ITEM.attributes = {"not_unequippable"};
	ITEM.components = {breakdownType = "meltdown", items = {"tech", "tech"}};
ITEM:Register();