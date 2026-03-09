ENT.Base = "lvs_base_wheeldrive"


ENT.PrintName = "Sootrat"
ENT.Author = "filter"
ENT.Information = "Luna's Vehicle Script"
ENT.Category = "[LVS] - Prelude"

ENT.Spawnable = true
ENT.AdminSpawnable = false

ENT.VehicleCategory = "Prelude"
ENT.VehicleSubCategory = "Cars"

ENT.SpawnNormalOffset = 0

ENT.MDL = "models/prelude/motorbike_01.mdl"

ENT.AITEAM = 2
ENT.MaxHealth = 400
ENT.MaxVelocity = 2200
ENT.EngineCurve = 0.25
ENT.EngineTorque = 150

ENT.MaxHealth = 150

ENT.MaxFuel = 30

-- Begotten
ENT.assignedfueldrain = 1
ENT.weightclass= 1
--ENT.trunkWeight = 100
ENT.SpareMovetype = true

ENT.TransGears = 4
ENT.TransGearsReverse = 1

ENT.EngineSounds = {
    {
        sound = "vehicles/v8_beta/v8_start_loop1.wav",
        Volume = 1,
        Pitch = 95,
        PitchMul = 25,
        SoundLevel = 75,
        SoundType = LVS.SOUNDTYPE_IDLE_ONLY,
    },
    {
        sound = "vehicles/v8_beta/fourth_cruise_loop2.wav",
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
        pos = Vector(1.99,-8.63,8.95),
        ang = Angle(0,-90,0),
    },
}

ENT.Lights = {
    {
        Trigger = "high",
        Sprites = {
            {pos = Vector(0.18,23.42,38.75), colorB = 200, colorA = 150},
        },
        ProjectedTextures = {
            {pos = Vector(0.18,23.42,38.75), ang =Angle(0,90,0), colorB = 200, colorA = 150, shadows = false, farz = 2000},
        },
    },
    {
        Trigger = "main", 
        Sprites = {
            {pos = Vector(0.18,23.42,38.75), colorB = 200, colorA = 150},
        },
        ProjectedTextures = {
            {pos = Vector(0.18,23.42,38.75), ang =Angle(10,90,0), colorB = 200, colorA = 150, shadows = false, farz = 1000},
        },
    }
}

// taken from one of the armed vehicles
function ENT:OnSetupDataTables()
    self:AddDT("Entity", "DriveWheelFL")
    self:AddDT("Entity", "DriveWheelFR")
    self:AddDT("Entity", "DriveWheelRL")
    self:AddDT("Entity", "DriveWheelRR")
end