
ENT.Base = "lvs_base_wheeldrive"

ENT.PrintName = "Bonegrinder Zil"
ENT.Author = "filter"
ENT.Information = "Luna's Vehicle Script"
ENT.Category = "[LVS] - Prelude"

ENT.VehicleCategory = "Prelude"
ENT.VehicleSubCategory = "Cars"

ENT.Spawnable			= true
ENT.AdminSpawnable		= false

ENT.MDL = "models/diggercars/stalker/zil130.mdl"

ENT.AITEAM = 2

ENT.MaxVelocity = 600

ENT.EngineCurve = 0.25
ENT.EngineTorque = 300

-- Begotten
ENT.assignedfueldrain = 3
ENT.weightclass= 3
ENT.trunkWeight = 600
ENT.SpareMovetype = true
ENT.begottenarmor = {
    [DMG_BULLET] = 0.4,
    [DMG_SLASH] = 0.4,
    [DMG_BLAST] = 0.4,
}

ENT.TransGears = 4
ENT.TransGearsReverse = 1

ENT.HornSound = "lvs/horn2.wav"
ENT.HornPos = Vector(40,0,35)

ENT.MaxHealth = 1000 

ENT.MaxFuel = 600

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
            {pos = Vector(150.26,41.44,51.97), colorB = 200, colorA = 150},
            {pos = Vector(150.26,-41.44,51.97), colorB = 200, colorA = 150},
        },
        ProjectedTextures = {
            {pos = Vector(150.26,41.44,51.97), ang = Angle(0,0,0), colorB = 200, colorA = 150, shadows = false, farz = 2000},
            {pos = Vector(150.26,-41.44,51.97), ang = Angle(0,0,0), colorB = 200, colorA = 150, shadows = false, farz = 2000},
        },
    },
    {
        Trigger = "main", 
        Sprites = {
            {pos = Vector(150.26,41.44,51.97), colorB = 200, colorA = 150},
            {pos = Vector(150.26,-41.44,51.97), colorB = 200, colorA = 150},
        },
        ProjectedTextures = {
            {pos = Vector(150.26,41.44,51.97), ang = Angle(15,0,0), colorB = 200, colorA = 150, shadows = false, farz = 1000},
            {pos = Vector(150.26,-41.44,51.97), ang = Angle(15,0,0), colorB = 200, colorA = 150, shadows = false, farz = 1000},
        },
    },
    {
        Trigger = "main+brake",
        Sprites = {
            {pos = Vector(-106.04,36.88,36.43), colorG = 0, colorB = 0, colorA = 150},
            {pos = Vector(-106.04,-36.88,36.43), colorG = 0, colorB = 0, colorA = 150},
        },
    },
    {
        Trigger = "turnright",
        Sprites = {
            {pos = Vector(-106.04,-36.88,36.43), colorR = 220, colorG = 120, colorB = 0, colorA = 150},
        },
    },
    {
        Trigger = "turnleft",
        Sprites = {
            {pos = Vector(-106.04,36.88,36.43), colorR = 220, colorG = 120, colorB = 0, colorA = 150},
        },
    },
    {
        Trigger = "reverse",
        Sprites = {
            {pos = Vector(-106.04,-36.88,36.43), colorG = 0, colorB = 0, colorA = 150},
            {pos = Vector(-106.04,36.88,36.43), colorG = 0, colorB = 0, colorA = 150},
        },
    },
}

ENT.ExhaustPositions = {
	{
        pos = Vector(-78.2, -12.15, 20),
        ang = Angle(90, 180, 0)
	},
}