
ENT.Base = "lvs_base_wheeldrive"

ENT.PrintName = "Shitwagon"
ENT.Author = "filter"
ENT.Information = "Luna's Vehicle Script"
ENT.Category = "[LVS] - Prelude"

ENT.VehicleCategory = "Prelude"
ENT.VehicleSubCategory = "Cars"

ENT.Spawnable			= true
ENT.AdminSpawnable		= false

ENT.MDL = "models/DiggerCars/stalker/zaza.mdl"

ENT.AITEAM = 2

ENT.MaxVelocity = 250

ENT.EngineCurve = 0.25
ENT.EngineTorque = 40

-- Begotten
ENT.assignedfueldrain = 1
ENT.weightclass= 1
ENT.trunkWeight = 10
ENT.preferredskin = 1
ENT.SpareMovetype = true

ENT.TransGears = 4
ENT.TransGearsReverse = 1

ENT.HornSound = "lvs/horn2.wav"
ENT.HornPos = Vector(40,0,35)

ENT.MaxHealth = 190

ENT.MaxFuel = 50

ENT.EngineSounds = {
	{
		sound = "simulated_vehicles/stalker/car_traktor_start2.wav",
		Volume = 1,
		Pitch = 105,
		PitchMul = 25,
		SoundLevel = 75,
		SoundType = LVS.SOUNDTYPE_IDLE_ONLY,
	},
	{
		sound = "simulated_vehicles/stalker/uaz_engine2.wav",
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
            {pos = Vector(68, -27.3, 32), colorB = 200, colorA = 150},
        },
        ProjectedTextures = {
            {pos = Vector(68, -27.3, 32), ang = Angle(0,0,0), colorB = 200, colorA = 150, shadows = false, farz = 2000},
        },
    },
    {
        Trigger = "main", 
        Sprites = {
            {pos = Vector(68, -27.3, 32), colorB = 200, colorA = 150},
        },
        ProjectedTextures = {
            {pos = Vector(68, -27.3, 32), ang = Angle(15,0,0), colorB = 200, colorA = 150, shadows = false, farz = 1000},
        },
    },
    {
        Trigger = "main+brake",
        Sprites = {
            {pos = Vector(-67, 26, 30), colorG = 0, colorB = 0, colorA = 150},
            {pos = Vector(-67, -26, 30), colorG = 0, colorB = 0, colorA = 150},
        },
    },
    {
        Trigger = "turnright",
        Sprites = {
            {pos = Vector(-67, -26, 30), colorR = 220, colorG = 120, colorB = 0, colorA = 150},
        },
    },
    {
        Trigger = "turnleft",
        Sprites = {
            {pos = Vector(-67, 26, 30), colorR = 220, colorG = 120, colorB = 0, colorA = 150},
        },
    },
    {
        Trigger = "reverse",
        Sprites = {
            {pos = Vector(-67, 26, 30), colorG = 0, colorB = 0, colorA = 150},
            {pos = Vector(-67, -26, 30), colorG = 0, colorB = 0, colorA = 150},
        },
    },
}

ENT.ExhaustPositions = {
	{
        pos = Vector(-69, -8.6, 14.5),
        ang = Angle(90, 180, 0)
	},
}