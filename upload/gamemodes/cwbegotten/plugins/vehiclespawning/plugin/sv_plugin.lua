--[[
	Begotten III: Jesus Wept
--]]

local map = game.GetMap();

if map == "bg_prelude" then
	if !cwVehiclespawning.spawns then
		cwVehiclespawning.spawns = {
			["spawnone"] = {
				["spawnPosition"] = Vector(-8609,11556,-600),
				["spawnAngles"] = Angle(0, -27, 0),
				["spawnentity"] = "cw_carspawn",
			},
			["spawntwo"] = {
				["spawnPosition"] = Vector(-8129,11900,-596),
				["spawnAngles"] = Angle(0, -79, 0),
				["spawnentity"] = "cw_carspawn",
			},
			["spawnthree"] = {
				["spawnPosition"] = Vector(12054,10705,-1874),
				["spawnAngles"] = Angle(0, -44, 0),
				["spawnentity"] = "cw_oilfieldterminal",
			},
			["spawnfour"] = {
				["spawnPosition"] = Vector(-7980,11828,-593),
				["spawnAngles"] = Angle(0, -118, 0),
				["spawnentity"] = "cw_vehiclerepairstation",
			},
			["spawnfive"] = {
				["spawnPosition"] = Vector(-8827,11158,-595),
				["spawnAngles"] = Angle(0, 31, 0),
				["spawnentity"] = "cw_vehiclerepairstation",
			},
		};
	end
end
