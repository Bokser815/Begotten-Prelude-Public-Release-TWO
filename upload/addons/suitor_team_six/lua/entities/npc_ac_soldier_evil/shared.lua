ENT.Type = "anim"
ENT.Base = "npc_ac_soldier"
 
ENT.PrintName		= "Evil Air Cavalry Soldier Spawner"
ENT.Author			= "MrNiceGuy518"
ENT.Contact			= "mng518workshop@gmail.com"
ENT.Purpose			= "To hack around the NPC list"
ENT.Instructions	= "Spawn this and a soldier will pop out."

ENT.Category = "Air Cavalry"
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.ClassToBe = "npc_combine_s"





--The model they spawn as is used as a switch to determine their class
--[[
--Recon
list.Set("NPC", "air_cav_recon_h", {
    Name = "Recon (Hostile)",
    Class = "npc_ac_soldier_evil", 
    Model = "models/namsoldiers/props/m14.mdl",
    Category = "Air Cavalry",
})

--Medic
list.Set("NPC", "air_cav_medic_h", {
    Name = "Medic (Hostile)",
    Class = "npc_ac_soldier_evil", 
    Model = "models/namsoldiers/props/canteen.mdl",
    Category = "Air Cavalry",
})




--SquadLeader
list.Set("NPC", "air_cav_leader_h", {
    Name = "Squad Leader (Hostile)",
    Class = "npc_ac_soldier_evil", 
    Model = "models/namsoldiers/props/backpack_radio.mdl",
    Category = "Air Cavalry",
})

--Demolitions
list.Set("NPC", "air_cav_demo_h", {
    Name = "Demolitions (Hostile)",
    Class = "npc_ac_soldier_evil", 
    Model = "models/namsoldiers/props/law_closed.mdl",
    Category = "Air Cavalry",
})

--HeavyWeapons
list.Set("NPC", "air_cav_heavy_h", {
    Name = "Heavy Weapons (Hostile)",
    Class = "npc_ac_soldier_evil", 
    Model = "models/namsoldiers/props/m60_box.mdl",
    Category = "Air Cavalry",
})
]]