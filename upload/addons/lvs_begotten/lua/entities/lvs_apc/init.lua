AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
--AddCSLuaFile( "sh_turret.lua" )
include("shared.lua")
--include("sh_turret.lua")

--[[
ENT.WaterLevelPreventStart = 1 -- at this water level engine can not start
ENT.WaterLevelAutoStop = 2 -- at this water level (on collision) the engine will stop
ENT.WaterLevelDestroyAI = 2 -- at this water level (on collision) the AI will self destruct
]]

--ENT.PivotSteerEnable = false -- uncomment and set to "true" to enable pivot steering (tank steering on the spot)
--ENT.PivotSteerWheelRPM = 40 -- how fast the wheels rotate during pivot steer

-- use this instead of ENT:Initialize()
function ENT:OnSpawn( PObj )
	--[[ basics ]]
	local driver = self:AddDriverSeat( Vector(-32.5,0,25), Angle(0,0,0) ) -- self:AddDriverSeat( Position,  Angle ) -- add a driver seat (max 1)
	driver.ExitPos = Vector(-85,0,15) -- change exit position
	driver.HidePlayer = true -- should the player in this pod be invisible?

	local Pod1 = self:AddPassengerSeat( Vector(32,5,35), Angle(0,0,0) ) -- add a passenger seat (no limit)
	Pod1.ExitPos = Vector(85,0,15) -- change exit position
	Pod1.HidePlayer = false -- should the player in this pod be invisible?

    local Pod2 = self:AddPassengerSeat( Vector(-32.5,-25,35), Angle(0,0,0) ) -- add a passenger seat (no limit)
	Pod2.ExitPos = Vector(85,0,15) -- change exit position
	Pod2.HidePlayer = false -- should the player in this pod be invisible?

    local Pod3 = self:AddPassengerSeat( Vector(32.5,-25,35), Angle(0,0,0) ) -- add a passenger seat (no limit)
	Pod3.ExitPos = Vector(85,0,15) -- change exit position
	Pod3.HidePlayer = false -- should the player in this pod be invisible?

	self:AddEngine( Vector(0,70,50),Angle(0,90,0) ) -- add a engine. This is used for sounds and effects and is required to get accurate RPM for the gauges.

    local ID = self:LookupAttachment( "main_muzzle" )
	local Muzzle = self:GetAttachment( ID )
	self.SNDTurret = self:AddSoundEmitter( self:WorldToLocal( Muzzle.Pos ), "weapons/heavybolt.wav", "weapons/heavybolt.wav" )
	self.SNDTurret:SetSoundLevel( 95 )
	self.SNDTurret:SetParent( self, ID )

	self:AddFuelTank( Vector(0,0,0), Angle(0,0,0), 600, LVS.FUELTYPE_PETROL )

    self:ManipulateBoneScale( 7, Vector( 0, 0, 0 ) )
    self:ManipulateBoneScale( 9, Vector( 0, 0, 0 ) )
    self:ManipulateBoneScale( 11, Vector( 0, 0, 0 ) )
    self:ManipulateBoneScale( 13, Vector( 0, 0, 0 ) )
    self:ManipulateBoneScale( 15, Vector( 0, 0, 0 ) )
    self:ManipulateBoneScale( 17, Vector( 0, 0, 0 ) )

	local WheelModel = "models/props_phx/wheels/trucktire2.mdl"

	local WheelFrontLeft = self:AddWheel( { mdl_ang = Angle(90,0,0),pos = Vector(25,70,40), mdl = WheelModel } )
	local WheelFrontRight = self:AddWheel( { mdl_ang = Angle(-90,0,0), pos = Vector(-25,70,40), mdl = WheelModel } )

    local WheelMiddleLeft = self:AddWheel( {mdl_ang = Angle(90,0,0), pos = Vector(25,-10,40), mdl = WheelModel} )
	local WheelMiddleRight = self:AddWheel( {mdl_ang = Angle(-90,0,0), pos = Vector(-25,-10,40), mdl = WheelModel} )

	local WheelRearLeft = self:AddWheel( {mdl_ang = Angle(90,0,0), pos = Vector(25,-65,40), mdl = WheelModel} )
	local WheelRearRight = self:AddWheel( {mdl_ang = Angle(-90,0,0), pos = Vector(-25,-65,40), mdl = WheelModel} )

	local SuspensionSettings = {
		Height = 10,
		MaxTravel = 7,
		ControlArmLength = 25,
		SpringConstant = 20000,
		SpringDamping = 1000,
		SpringRelativeDamping = 1000,
	}

	local FrontAxle = self:DefineAxle( {
		Axle = {
			ForwardAngle = Angle(0,90,0),
			SteerType = LVS.WHEEL_STEER_FRONT,
			SteerAngle = 30,
			TorqueFactor = 0.3,
			BrakeFactor = 1,
		},
		Wheels = { WheelFrontLeft, WheelFrontRight },
		Suspension = SuspensionSettings,
	} )

	local RearAxle = self:DefineAxle( {
		Axle = {
			ForwardAngle = Angle(0,90,0),
			SteerType = LVS.WHEEL_STEER_NONE,
			TorqueFactor = 0.7,
			BrakeFactor = 1,
			UseHandbrake = true,
		},
		Wheels = {WheelMiddleLeft,WheelMiddleRight, WheelRearLeft, WheelRearRight },
		Suspension = SuspensionSettings,
	} )

	-- example 2 (rear axle only). If this looks cleaner to you:
	--[[
	local RearAxle = self:DefineAxle( {
		Axle = {
			ForwardAngle = Angle(0,0,0),
			SteerType = LVS.WHEEL_STEER_NONE,
			TorqueFactor = 0.7,
			BrakeFactor = 1,
			UseHandbrake = true,
		},
		Wheels = {
			self:AddWheel( {
				pos = Vector(-60,30,-15),
				mdl = "models/props_vehicles/tire001c_car.mdl",
				mdl_ang = Angle(0,0,0),
			} ),

			self:AddWheel( {
				pos = Vector(-60,-30,-15),
				mdl = "models/props_vehicles/tire001c_car.mdl",
				mdl_ang = Angle(0,0,0),
			} ),
		},
		Suspension = {
			Height = 6,
			MaxTravel = 7,
			ControlArmLength = 25,
			SpringConstant = 20000,
			SpringDamping = 2000,
			SpringRelativeDamping = 2000,
		},
	)
	]]


-- example 3, prop_vehicle_jeep rigged model method using
--[[
	local FrontRadius = 15
	local RearRadius = 15
	local FL, FR, RL, RR, ForwardAngle = self:AddWheelsUsingRig( FrontRadius, RearRadius )

	local FrontAxle = self:DefineAxle( {
		Axle = {
			ForwardAngle = ForwardAngle,
			SteerType = LVS.WHEEL_STEER_FRONT,
			SteerAngle = 30,
			TorqueFactor = 0,
			BrakeFactor = 1,
		},
		Wheels = {FL,FR},
		Suspension = {
			Height = 10,
			MaxTravel = 7,
			ControlArmLength = 25,
			SpringConstant = 20000,
			SpringDamping = 2000,
			SpringRelativeDamping = 2000,
		},
	} )

	local RearAxle = self:DefineAxle( {
		Axle = {
			ForwardAngle = ForwardAngle,
			SteerType = LVS.WHEEL_STEER_NONE,
			TorqueFactor = 1,
			BrakeFactor = 1,
			UseHandbrake = true,
		},
		Wheels = {RL,RR},
		Suspension = {
			Height = 15,
			MaxTravel = 7,
			ControlArmLength = 25,
			SpringConstant = 20000,
			SpringDamping = 2000,
			SpringRelativeDamping = 2000,
		},
	} )
]]

-- example 4, rigged wheels with visible prop wheels:
--[[
	local data = {
		mdl_fr = "models/diggercars/dodge_charger/wh.mdl",
		mdl_ang_fr = Angle(0,0,0),
		mdl_fl = "models/diggercars/dodge_charger/wh.mdl",
		mdl_ang_fl = Angle(0,180,0),
		mdl_rl = "models/diggercars/dodge_charger/wh.mdl",
		mdl_ang_rl = Angle(0,0,0),
		mdl_rr = "models/diggercars/dodge_charger/wh.mdl",
		mdl_ang_rr = Angle(0,180,0),
	}

	local FrontRadius = 15
	local RearRadius = 15
	local FL, FR, RL, RR, ForwardAngle = self:AddWheelsUsingRig( FrontRadius, RearRadius, data )

	local FrontAxle = self:DefineAxle( {
		Axle = {
			ForwardAngle = ForwardAngle,
			SteerType = LVS.WHEEL_STEER_FRONT,
			SteerAngle = 30,
			TorqueFactor = 0,
			BrakeFactor = 1,
		},
		Wheels = {FL,FR},
		Suspension = {
			Height = 10,
			MaxTravel = 7,
			ControlArmLength = 25,
			SpringConstant = 20000,
			SpringDamping = 2000,
			SpringRelativeDamping = 2000,
		},
	} )

	local RearAxle = self:DefineAxle( {
		Axle = {
			ForwardAngle = ForwardAngle,
			SteerType = LVS.WHEEL_STEER_NONE,
			TorqueFactor = 1,
			BrakeFactor = 1,
			UseHandbrake = true,
		},
		Wheels = {RL,RR},
		Suspension = {
			Height = 15,
			MaxTravel = 7,
			ControlArmLength = 25,
			SpringConstant = 20000,
			SpringDamping = 2000,
			SpringRelativeDamping = 2000,
		},
	} )
]]
end

--[[
function ENT:OnSuperCharged( enabled )
	-- called when supercharger is equipped/unequipped
end

function ENT:OnTurboCharged( enabled )
	-- called when turbocharger is equipped/unequipped
end
]]