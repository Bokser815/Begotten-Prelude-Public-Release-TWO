
ENT.Base = "lvs_base_wheeldrive"

ENT.PrintName = "Gorehauler LAZ"
ENT.Author = "filter"
ENT.Information = "Luna's Vehicle Script"
ENT.Category = "[LVS] - Prelude"

ENT.VehicleCategory = "Prelude"
ENT.VehicleSubCategory = "Cars"

ENT.Spawnable			= true
ENT.AdminSpawnable		= false

ENT.MDL = "models/DiggerCars/stalker/laz.mdl"

ENT.AITEAM = 2

-- Begotten
ENT.assignedfueldrain = 3
ENT.weightclass= 3
ENT.trunkWeight = 400
ENT.preferredskin = 4
ENT.SpareMovetype = true
ENT.begottenarmor = {
    [DMG_BULLET] = 0.2,
    [DMG_SLASH] = 0.2,
}

ENT.MaxVelocity = 400

ENT.EngineCurve = 0.25
ENT.EngineTorque = 150

ENT.TransGears = 4
ENT.TransGearsReverse = 1

ENT.MaxHealth = 800

ENT.MaxFuel = 500

ENT.HornSound = "lvs/horn2.wav"
ENT.HornPos = Vector(40,0,35)

ENT.EngineSounds = {
	{
		sound = "simulated_vehicles/stalker/apc_start2.wav",
		Volume = 1,
		Pitch = 105,
		PitchMul = 25,
		SoundLevel = 75,
		SoundType = LVS.SOUNDTYPE_IDLE_ONLY,
	},
	{
		sound = "simulated_vehicles/stalker/apc_run2.wav",
		Volume = 2,
		Pitch = 80,
		PitchMul = 100,
		SoundLevel = 75,
		UseDoppler = true,
	},
}

ENT.Lights = {
    {
        Trigger = "high", 
        Sprites = {
            {pos = Vector(192, 34, 40), colorB = 200, colorA = 150},
            {pos = Vector(192, -34, 40), colorB = 200, colorA = 150},
        },
        ProjectedTextures = {
            {pos = Vector(192, 34, 40), ang = Angle(0,0,0), colorB = 200, colorA = 150, shadows = false, farz = 2000},
            {pos = Vector(192, -34, 40), ang = Angle(0,0,0), colorB = 200, colorA = 150, shadows = false, farz = 2000},
        },
    },
    {
        Trigger = "main", 
        Sprites = {
            {pos = Vector(192, 34, 40), colorB = 200, colorA = 150},
            {pos = Vector(192, -34, 40), colorB = 200, colorA = 150},
        },
        ProjectedTextures = {
            {pos = Vector(192, 34, 40), ang = Angle(15,0,0), colorB = 200, colorA = 150, shadows = false, farz = 1000},
            {pos = Vector(192, -34, 40), ang = Angle(15,0,0), colorB = 200, colorA = 150, shadows = false, farz = 1000},
        },
    },
}

ENT.ExhaustPositions = {
	{
        pos = Vector(-190, 36.8, 26),
        ang = Angle(90, 180, 0)
	},
}