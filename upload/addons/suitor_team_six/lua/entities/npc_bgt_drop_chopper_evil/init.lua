AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')




function ENT:SetMorality() 
	self.IsEvil = true
end


function ENT:IsEnemy(ent)

	if ent:IsNPC() || ent:IsNextBot() then 

		local enemy_classes = {
			[CLASS_PLAYER] = true,
			[CLASS_PLAYER_ALLY] = true,
			[CLASS_PLAYER_ALLY_VITAL] = true,
			[CLASS_VORTIGAUNT] = true,
			[CLASS_ANTLION] = true,
			[CLASS_HEADCRAB] = true,
			[CLASS_ZOMBIE] = false,
			[CLASS_HUMAN_MILITARY] = true,
			[CLASS_ALIEN_MILITARY] = true,
			[CLASS_ALIEN_MONSTER] = true,
			[CLASS_ALIEN_PREY] = true,
			[CLASS_ALIEN_PREDATOR] = true,
		}

		if ent.IsVJBaseSNPC then
			--Since the evil helicopters are technically combine, we need to ignore VJ combines.
			-- Kill everything else.
			for _,v in pairs(ent.VJ_NPC_Class) do
				if isstring(v) then
					if string.find(string.lower(v), "combine") != nil then
						return false
					end
				end
			end
			return true
		elseif ent.IsDrGNextbot then
			--We'll determine our feelings towards this DRG based on its' feelings towards our crew
			--Check the crew
			for _,v in pairs(self.crew) do
				if v:IsValid() then
					if ent:GetRelationship(v) == D_HT then
						ent:AddEntityRelationship(v, D_LI, 99);
						if IsValid(self.gunner_l) then
							ent:AddEntityRelationship(self.gunner_l, D_LI, 99);
						end
						if IsValid(self.gunner_r) then
							ent:AddEntityRelationship(self.gunner_r, D_LI, 99);
						end
						if IsValid(self.pilot1) then
							ent:AddEntityRelationship(self.pilot1, D_LI, 99);
						end
						if IsValid(self.pilot2) then
							ent:AddEntityRelationship(self.pilot2, D_LI, 99);
						end
						--v:AddEntityRelationship(ent:GetClass(), D_LI, 99);
						--return true
					end
				end
			end
	
			return false
	
		end


		return enemy_classes[ent:Classify()]
	elseif ent:IsPlayer() && !GetConVar("ai_ignoreplayers"):GetBool() then
		return true
	end
end