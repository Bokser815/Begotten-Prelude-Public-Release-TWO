ENT.Base = "lvs_base_wheeldrive"


ENT.PrintName = "HL2 Buggy Small"
ENT.Author = "filter"
ENT.Information = "Luna's Vehicle Script"
ENT.Category = "[LVS] - Prelude"

ENT.Spawnable = true
ENT.AdminSpawnable = false

ENT.VehicleCategory = "Prelude"
ENT.VehicleSubCategory = "Cars"

ENT.SpawnNormalOffset = 0

ENT.MDL = "models/donald/hl2vehicle/buggy_don_s_01.mdl"

ENT.AITEAM = 2
ENT.MaxHealth = 400
ENT.MaxVelocity = 2200
ENT.EngineCurve = 0.25
ENT.EngineTorque = 150

-- Begotten
ENT.assignedfueldrain = 1
ENT.weightclass= 1
ENT.trunkWeight = 15

ENT.TransGears = 4
ENT.TransGearsReverse = 1

ENT.EngineSounds = {
    {
        sound = "vehicles/v8/v8_start_loop1.wav",
        Volume = 1,
        Pitch = 95,
        PitchMul = 25,
        SoundLevel = 75,
        SoundType = LVS.SOUNDTYPE_IDLE_ONLY,
    },
    {
        sound = "vehicles/v8/v8_firstgear_rev_loop1.wav",
        Volume = 1,
        Pitch = 95,
        PitchMul = 10,
        SoundLevel = 75,
        SoundType = LVS.SOUNDTYPE_NONE,
        UseDoppler = true,
    },
}

ENT.ExhaustPositions = {
    {
        pos = Vector(13.07,-29.74,24.46),
        ang = Angle(0,-90,0),
    },
}

ENT.Lights = {
    {
        Trigger = "high",
        Sprites = {
            {pos = Vector(5.47,65.31,16.65), colorB = 200, colorA = 150},
            {pos = Vector(-5.47,65.31,16.65), colorB = 200, colorA = 150},
        },
        ProjectedTextures = {
            {pos = Vector(5.47,65.31,16.65), ang =Angle(0,90,0), colorB = 200, colorA = 150, shadows = false, farz = 2000},
            {pos = Vector(-5.47,65.31,16.65), ang =Angle(0,90,0), colorB = 200, colorA = 150, shadows = false, farz = 2000},
        },
    },
    {
        Trigger = "main", 
        Sprites = {
            {pos = Vector(5.47,65.31,16.65), colorB = 200, colorA = 150},
            {pos = Vector(-5.47,65.31,16.65), colorB = 200, colorA = 150},
        },
        ProjectedTextures = {
            {pos = Vector(5.47,65.31,16.65), ang =Angle(10,90,0), colorB = 200, colorA = 150, shadows = false, farz = 1000},
            {pos = Vector(-5.47,65.31,16.65), ang =Angle(10,90,0), colorB = 200, colorA = 150, shadows = false, farz = 1000},
        },
    },
    {
        Trigger = "main+brake", 
        Sprites = {
            {pos = Vector(-16.07,-48.33,30.79), colorB = 200, colorA = 150},
        },
    },
    {
        Trigger = "reverse", 
        Sprites = {
            {pos = Vector(-16.07,-48.33,30.79), colorB = 200, colorA = 150},
        },
    },
}

// taken from one of the armed vehicles
function ENT:OnSetupDataTables()
    self:AddDT("Entity", "DriveWheelFL")
    self:AddDT("Entity", "DriveWheelFR")
    self:AddDT("Entity", "DriveWheelRL")
    self:AddDT("Entity", "DriveWheelRR")
end