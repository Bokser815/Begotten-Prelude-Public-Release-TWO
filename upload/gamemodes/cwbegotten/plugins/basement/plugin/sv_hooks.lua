--[[
	BEGOTTEN: Damnation was created by cash wednesday.
--]]

-- Called just before a player dies.
function cwBasement:DoPlayerDeath(player, attacker, damageInfo)
	if (attacker.noHintsTime) then
		return;
	end;

	if (attacker:IsPlayer() and attacker:GetCharacterData("LastZone") ~= "basement") then return end; -- if they are not in the basement, don't do this shit!!!
	
	if (attacker:IsPlayer() and attacker:Alive()) then
		local curTime = CurTime();
		
		if (!attacker._nextKill or curTime > attacker._nextKill) then
			attacker._nextKill = curTime + 10;
			
			timer.Simple(0.5, function()
				if (IsValid(attacker)) then
					local myThought = table.Random({"Take that you son of a bitch!", "Take that you stupid whore!", "Take this bitch!", "Better you than me..."});
					local attackerName = attacker:Name()
					local name = string.Split(attackerName, " ");
					
					netstream.Start(attacker, "cwCustomHint", {name[1].." Thinks...", myThought});

				end;
			end);
		end;
	end;
end;

-- Called when an NPC is killed.
function cwBasement:OnNPCKilled(npc, attacker, inflictor)
	if (attacker.noHintsTime) then
		return;
	end;
	
	if (attacker:IsPlayer() and attacker:GetCharacterData("LastZone") ~= "basement") then return end; -- if they are not in the basement, don't do this shit!!!
	
	if (attacker:IsPlayer() and attacker:Alive()) then
		local curTime = CurTime();
		
		if (!attacker._nextKill or curTime > attacker._nextKill) then
			attacker._nextKill = curTime + 10;
			
			timer.Simple(1, function()
				if (IsValid(attacker)) then
					local myThought = table.Random({"Take that you son of a bitch!", "Take that you stupid whore!", "Take this bitch!", "Better you than me..."});
					local attackerName = attacker:Name()
					local name = string.Split(attackerName, " ");
					
					netstream.Start(attacker, "cwCustomHint", {name[1].." Thinks...", myThought});
				end;
			end);
		end;
	end;
end;
