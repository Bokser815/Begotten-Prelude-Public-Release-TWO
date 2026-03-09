--[[
	Begotten III: Jesus Wept
--]]

-- Todo: Detect character changing, disconnects, players leaving the dueling arena somehow (maybe teleported by admin by mistake?).

-- Called when Clockwork has loaded all of the entities.
function cwVehiclespawning:ClockworkInitPostEntity()
	if self.spawns then
		for k, v in pairs(self.spawns) do
			local spawnEnt = ents.Create(self.spawns[k]["spawnentity"]);
			
			spawnEnt:SetPos(self.spawns[k]["spawnPosition"]);
			spawnEnt:SetAngles(self.spawns[k]["spawnAngles"]);
			spawnEnt:Spawn();

			spawnEnt:SetMoveType(MOVETYPE_NONE);
		end
	end;
end