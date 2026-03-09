AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

function ENT:OnSpawn( PObj )
	self:AddDriverSeat( Vector(0, 14.5, 19), Angle(0, -90, 5) )
	self:AddPassengerSeat( Vector(12, -14.5, 26), Angle(0, -90, 5) )
	self:AddPassengerSeat( Vector(-22, -14.5, 26), Angle(0, -90, 5) )
	self:AddPassengerSeat( Vector(-22, 0, 26), Angle(0, -90, 5) )
	self:AddPassengerSeat( Vector(-22, 14.5, 26), Angle(0, -90, 5) )

	self:AddEngine( Vector(60, 0, 40) )
	self:AddFuelTank( Vector(-42.36,0,13.8), Angle(0,0,0), 600, LVS.FUELTYPE_PETROL )

	local WheelModel = "models/DiggerCars/stalker/moskv_wheel.mdl"

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
				pos = Vector(59.4, 29, 17),
				mdl = WheelModel,
				mdl_ang = Angle(0,90,0),
			} ),

			self:AddWheel( {
				pos = Vector(59.4, -29, 17),
				mdl = WheelModel,
				mdl_ang = Angle(0,90,0),
			} ),
		},
		Suspension = {
			Height = 8,
			MaxTravel = 7,
			ControlArmLength = 25,
			SpringConstant = 20000,
			SpringDamping = 2000,
			SpringRelativeDamping = 2000,
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
				pos = Vector(-48.6, 29, 17),
				mdl = WheelModel,
				mdl_ang = Angle(0,90,0),
			} ),

			self:AddWheel( {
				pos = Vector(-48.6, -29, 17),
				mdl = WheelModel,
				mdl_ang = Angle(0,90,0),
			} ),
		},
		Suspension = {
			Height = 8,
			MaxTravel = 7,
			ControlArmLength = 25,
			SpringConstant = 20000,
			SpringDamping = 2000,
			SpringRelativeDamping = 2000,
		},
	} )

	-- trailer hitch
	self:AddTrailerHitch( Vector(-68,0,17), LVS.HITCHTYPE_MALE )
end