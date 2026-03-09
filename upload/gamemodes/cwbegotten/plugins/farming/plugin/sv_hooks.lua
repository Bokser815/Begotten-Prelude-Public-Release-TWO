--[[
	Begotten III: Jesus Wept
--]]

-- Called when Clockwork has loaded all of the entities.
function cwFarming:ClockworkInitPostEntity()
	self:LoadPlanters();
end;

-- Called just after data should be saved.
function cwFarming:PostSaveData()
	if (#player.GetAll() > 0) then
		self:SavePlanters();
	end;
end;

function cwFarming:EntityTakeDamageNew(entity, damageInfo)
	if (entity:GetClass() == "cw_planter") then
		local attacker = damageInfo:GetAttacker();
		local damageType = damageInfo:GetDamageType();
		local damageAmount = damageInfo:GetDamage();

        if attacker:GetClass() == "entityflame" then 
            entity:SetHP(entity.health - damageAmount, attacker);
        elseif attacker:IsPlayer() then
            local weapon = attacker:GetActiveWeapon():GetPrintName();
            if damageAmount >= 15 then
                local damageDealt = math.ceil(damageAmount / 5);
                
                if entity.health then
                    entity:SetHP(entity.health - damageDealt, attacker, weapon);
                else
                    entity.health = entity.health  - damageDealt;
                end
                
                entity:EmitSound("physics/wood/wood_strain"..tostring(math.random(2, 4))..".wav");
            end
        end
	end
end

-- Called when a player presses a key.
function cwFarming:KeyPress(player, key)
	if (key == IN_ATTACK) then
		local action = Clockwork.player:GetAction(player);
		
		if action == "burn_planter" then
			Clockwork.player:SetAction(player, nil);
		end
	end;
end;

function cwFarming:ModifyPlayerSpeed(player, infoTable, action)
	if (action == "burn_planter") then
		infoTable.runSpeed = infoTable.walkSpeed * 0.1;
		infoTable.walkSpeed = infoTable.walkSpeed * 0.1;
	end
end