AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

function ENT:OnSpawn( PObj )
	self:AddDriverSeat( Vector(35, 17, 30), Angle(0, -90, 5) )
	self:AddPassengerSeat( Vector(50, -17, 35), Angle(0, -90, 5) )

	self:AddEngine( Vector(84, 0, 28) )
	self:AddFuelTank( Vector(-42.36,0,13.8), Angle(0,0,0), 600, LVS.FUELTYPE_PETROL )

	local WheelModel = "models/DiggerCars/stalker/uaz2_wheel.mdl"

	local FrontAxle = self:DefineAxle( {
		Axle = {
			ForwardAngle = Angle(0,0,0),
			SteerType = LVS.WHEEL_STEER_FRONT,
			SteerAngle = 30,
			TorqueFactor = 0.3,
			BrakeFactor = 1,
		},
		Wheels = {
			self:AddWheel( {
				pos = Vector(50, 33, 13),
				mdl = WheelModel,
				mdl_ang = Angle(0,90,0),
			} ),

			self:AddWheel( {
				pos = Vector(50, -33, 13),
				mdl = WheelModel,
				mdl_ang = Angle(0,90,0),
			} ),
		},
		Suspension = {
			Height = 10,
			MaxTravel = 7,
			ControlArmLength = 25,
			SpringConstant = 30000,
			SpringDamping = 2800,
			SpringRelativeDamping = 2800,
		},
	} )

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
				pos = Vector(-50.5, 33, 13),
				mdl = WheelModel,
				mdl_ang = Angle(0,90,0),
			} ),

			self:AddWheel( {
				pos = Vector(-50.5, -33, 13),
				mdl = WheelModel,
				mdl_ang = Angle(0,90,0),
			} ),
		},
		Suspension = {
			Height = 10,
			MaxTravel = 7,
			ControlArmLength = 25,
			SpringConstant = 30000,
			SpringDamping = 2800,
			SpringRelativeDamping = 2800,
		},
	} )

	-- trailer hitch
	self:AddTrailerHitch( Vector(-68,0,17), LVS.HITCHTYPE_MALE )
end