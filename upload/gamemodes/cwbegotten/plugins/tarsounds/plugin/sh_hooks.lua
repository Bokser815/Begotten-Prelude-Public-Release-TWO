--[[
	Begotten III: Jesus Wept
	By: DETrooper, cash wednesday, gabs, alyousha35

	Other credits: kurozael, Alex Grist, Mr. Meow, zigbomb
--]]

-- Called when the foreground HUD should be painted.
-- This function decreases general vehicle damage and allows players to block vehicle damage.

local blocktarfootsteps = {
	["player/footsteps/wade8.wav"] = true,
	["player/footsteps/wade7.wav"] = true,
	["player/footsteps/wade6.wav"] = true,
	["player/footsteps/wade5.wav"] = true,
	["player/footsteps/wade4.wav"] = true,
	["player/footsteps/wade3.wav"] = true,
	["player/footsteps/wade2.wav"] = true,
	["player/footsteps/wade1.wav"] = true,
	["player/footsteps/slosh4.wav"] = true,
	["player/footsteps/slosh3.wav"] = true,
	["player/footsteps/slosh2.wav"] = true,
	["player/footsteps/slosh1.wav"] = true,
}

local boxtopcorner = Vector(-13600, -15300, 2300)
local boxbottomcorner = Vector(16000, 17100, -4090)

local mudsounds = {
	"fiend/mudwade1.wav",
	"fiend/mudwade2.wav",
	"fiend/mudwade3.wav",
}

function cwTarSounds:EntityEmitSound(data)
	if blocktarfootsteps[tostring(data.SoundName)] then
		local pos = data.Pos or data.Entity:GetPos()
		if pos:WithinAABox( boxbottomcorner, boxtopcorner ) then
			data.SoundName = "fiend/mudwade"..math.random(1, 3)..".wav"
			return true
		end
	end

end
