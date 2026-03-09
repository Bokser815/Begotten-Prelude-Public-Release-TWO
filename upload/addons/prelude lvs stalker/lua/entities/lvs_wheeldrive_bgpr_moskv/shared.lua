
ENT.Base = "lvs_base_wheeldrive"

ENT.PrintName = "Bloodslicker Moskvitch"
ENT.Author = "filter"
ENT.Information = "Luna's Vehicle Script"
ENT.Category = "[LVS] - Prelude"

ENT.VehicleCategory = "Prelude"
ENT.VehicleSubCategory = "Cars"

ENT.Spawnable			= true
ENT.AdminSpawnable		= false

ENT.MDL = "models/DiggerCars/stalker/moskv.mdl"

ENT.AITEAM = 2

ENT.MaxVelocity = 400

-- Begotten
ENT.assignedfueldrain = 1
ENT.weightclass= 1
ENT.trunkWeight = 40
ENT.preferredskin = 1
ENT.SpareMovetype = true
ENT.begottenarmor = {
    [DMG_BULLET] = 0.1,
    [DMG_SLASH] = 0.1,
}

ENT.EngineCurve = 0.25
ENT.EngineTorque = 110

ENT.TransGears = 4
ENT.TransGearsReverse = 1

ENT.HornSound = "lvs/horn2.wav"
ENT.HornPos = Vector(40,0,35)

ENT.MaxHealth = 300
ENT.MaxFuel = 80

ENT.EngineSounds = {
	{
		sound = "simulated_vehicles/stalker/car2_start.wav",
		Volume = 1,
		Pitch = 105,
		PitchMul = 25,
		SoundLevel = 75,
		SoundType = LVS.SOUNDTYPE_IDLE_ONLY,
	},
	{
		sound = "simulated_vehicles/stalker/car2.wav",
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
            {pos = Vector(88, -24.7, 33.33), colorB = 200, colorA = 150},
            {pos = Vector(88, 24.7, 33.33), colorB = 200, colorA = 150},
        },
        ProjectedTextures = {
            {pos = Vector(88, 24.7, 33.33), ang = Angle(0,0,0), colorB = 200, colorA = 150, shadows = false, farz = 2000},
            {pos = Vector(88, -24.7, 33.33), ang = Angle(0,0,0), colorB = 200, colorA = 150, shadows = false, farz = 2000},
        },
    },
    {
        Trigger = "main", 
        Sprites = {
            {pos = Vector(88, 24.7, 33.33), colorB = 200, colorA = 150},
            {pos = Vector(88, -24.7, 33.33), colorB = 200, colorA = 150},
        },
        ProjectedTextures = {
            {pos = Vector(88, 24.7, 33.33), ang = Angle(15,0,0), colorB = 200, colorA = 150, shadows = false, farz = 1000},
            {pos = Vector(88, -24.7, 33.33), ang = Angle(15,0,0), colorB = 200, colorA = 150, shadows = false, farz = 1000},
        },
    },
    {
        Trigger = "main+brake",
        Sprites = {
            {pos = Vector(-91.88, 20.76, 37.8), colorG = 0, colorB = 0, colorA = 150},
            {pos = Vector(-91.88, -20.76, 37.8), colorG = 0, colorB = 0, colorA = 150},
        },
    },
    {
        Trigger = "turnright",
        Sprites = {
            {pos = Vector(-91.88, -20.76, 37.8), colorR = 220, colorG = 120, colorB = 0, colorA = 150},
        },
    },
    {
        Trigger = "turnleft",
        Sprites = {
            {pos = Vector(-91.88, 20.76, 37.8), colorR = 220, colorG = 120, colorB = 0, colorA = 150},
        },
    },
    {
        Trigger = "reverse",
        Sprites = {
            {pos = Vector(-91.88, -20.76, 37.8), colorG = 0, colorB = 0, colorA = 150},
            {pos = Vector(-91.88, 20.76, 37.8), colorG = 0, colorB = 0, colorA = 150},
        },
    },
}

ENT.ExhaustPositions = {
	{
        pos = Vector(-78.2, -12.15, 20),
        ang = Angle(90, 180, 0)
	},
}