AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

local function dmsg(msg)
	Entity(1):PrintMessage(3, tostring(msg))
end



hook.Add("PlayerSpawnedNPC", "HookAcSoldierUndos", function(ply,ent)
	if !IsValid(ent) then return end
	if ent:GetClass() == "npc_ac_soldier" || ent:GetClass() == "npc_ac_soldier_evil" then
		ent.OwningPlayer = ply

	end
end)



function ENT:Initialize()



	--I'm arbitrarilly keying the classes by models
	local spawn_funcs = {
		--Recon
		["models/namsoldiers/props/m14.mdl"] = function(guy)
			guy.spec = "Recon"
            guy:SetBodygroup(1,1)
            guy:SetBodygroup(2,2)
            guy:SetBodygroup(4,2)
            guy:SetBodygroup(7,1)
            guy:SetBodygroup(8,5)
			guy.default_weapon = "weapon_npc_ac_m14"
		end,

		--Medic 
		["models/namsoldiers/props/canteen.mdl"] = function(guy)
			guy.spec = "Medic"
            guy:SetBodygroup(2,1)
            guy:SetBodygroup(4,2)
            guy:SetBodygroup(5,1)
            guy:SetBodygroup(6,1)
            
            guy:SetSubMaterial(6, "models/namsoldiers/helmet_medic")
            guy:SetSubMaterial(7, "models/namsoldiers/helmet_medic")
            guy:SetSubMaterial(8, "models/namsoldiers/helmet_medic")
			guy:SetKeyValue("spawnflags", 132616) -- Act like a medic.

			guy.default_weapon = "weapon_npc_ac_m16"
		end,

		--Squad Leader
		["models/namsoldiers/props/backpack_radio.mdl"] = function(guy)
			guy.spec = "Squad Leader"
            guy:SetBodygroup(3,2)
            guy:SetBodygroup(7,2)
            guy:SetBodygroup(8,1)
            guy:SetBodygroup(9,1)

			guy.default_weapon = "weapon_npc_ac_m16"
		end,

		--Demolitions
		["models/namsoldiers/props/law_closed.mdl"] = function(guy)
			guy.spec = "Demolitions"
            guy:SetBodygroup(2,1)
            guy:SetBodygroup(3,1)
            guy:SetBodygroup(6,1)
            guy:SetBodygroup(8,4)
            guy:SetBodygroup(11,1)
            guy:SetBodygroup(13,1)

			guy.default_weapon = "weapon_npc_ac_law"
		end,

		--Heavy Weapons
		["models/namsoldiers/props/m60_box.mdl"] = function(guy)
			guy.spec = "Heavy Weapons"
            guy:SetBodygroup(1,1)
            guy:SetBodygroup(3,1)
            guy:SetBodygroup(4,1)
            guy:SetBodygroup(5,1)
            guy:SetBodygroup(6,1)
            guy:SetBodygroup(8,4)
            guy:SetBodygroup(10,1)

			guy.default_weapon = "weapon_npc_ac_m60"
		end,
	}










	local guy = ents.Create(self.ClassToBe)
	guy:SetPos(self:GetPos())
	guy:SetAngles(self:GetAngles())
	guy:SetSpawnEffect(true)
	guy:Spawn()
	guy.IsDropChopperSoldier = true




    guy:SetModel("models/namsoldiers/male_0"..math.random(1,9)..".mdl")

	guy:SetSkin(math.random(0,3))

	if guy:GetModel() == "models/namsoldiers/male_07.mdl" && guy:GetSkin() == 0 then
		guy:SetSkin(1)
	end




    spawn_funcs[self:GetModel()](guy)

	local name

	if self.ClassToBe == "npc_citizen" then
		name = guy.spec.." (Friendly)"
	elseif self.ClassToBe == "npc_combine_s" then
		name = guy.spec.." (Hostile)"
	end

	guy.NPCTable = {}

	guy.NPCTable.Name = name


	local weaponSetting = GetConVar("gmod_npcweapon"):GetString()

	if weaponSetting == "" then
		guy:Give(guy.default_weapon)
	elseif weaponSetting == "none" then
		-- dmsg("Unarmed!")
	else
		guy:Give(weaponSetting)
		-- dmsg(weaponSetting)
	end


	
	--Yucky yucky hack.
	timer.Simple(0, function()
		if !IsValid(self) then return end
		local owner = self.OwningPlayer
		undo.Create(name)
		undo.AddEntity(guy)
		undo.SetPlayer(owner)
		undo.Finish()
		self:Remove()
	
	end)

	

end



