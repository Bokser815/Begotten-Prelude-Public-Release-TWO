ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName		= "Air Cavalry Soldier Spawner"
ENT.Author			= "MrNiceGuy518"
ENT.Contact			= "mng518workshop@gmail.com"
ENT.Purpose			= "To hack around the NPC list"
ENT.Instructions	= "Spawn this and a soldier will pop out."

ENT.Category = "Air Cavalry"
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.ClassToBe = "npc_citizen"





--The model they spawn as is used as a switch to determine their class
--[[
--Recon
list.Set("NPC", "air_cav_recon_f", {
    Name = "Recon (Friendly)",
    Class = "npc_ac_soldier", 
    Model = "models/namsoldiers/props/m14.mdl",
    Category = "Air Cavalry",
})

--Medic
list.Set("NPC", "air_cav_medic_f", {
    Name = "Medic (Friendly)",
    Class = "npc_ac_soldier", 
    Model = "models/namsoldiers/props/canteen.mdl",
    Category = "Air Cavalry",
})




--SquadLeader
list.Set("NPC", "air_cav_leader_f", {
    Name = "Squad Leader (Friendly)",
    Class = "npc_ac_soldier", 
    Model = "models/namsoldiers/props/backpack_radio.mdl",
    Category = "Air Cavalry",
})

--Demolitions
list.Set("NPC", "air_cav_demo_f", {
    Name = "Demolitions (Friendly)",
    Class = "npc_ac_soldier", 
    Model = "models/namsoldiers/props/law_closed.mdl",
    Category = "Air Cavalry",
})

--HeavyWeapons
list.Set("NPC", "air_cav_heavy_f", {
    Name = "Heavy Weapons (Friendly)",
    Class = "npc_ac_soldier", 
    Model = "models/namsoldiers/props/m60_box.mdl",
    Category = "Air Cavalry",
})
]]