AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

function ENT:OnSpawn( PObj )
	// just know this was made with love and care unlike your shitty begotten 3 schema reskin
	self:AddDriverSeat( Vector(144, 25, 39), Angle(0, -90, 5) )
	self:AddPassengerSeat( Vector(103, -35, 44), Angle(0, -90, 5) )
	self:AddPassengerSeat( Vector(103, 35, 44), Angle(0, -90, 5) )
	self:AddPassengerSeat( Vector(103, 20, 44), Angle(0, -90, 5) )
	self:AddPassengerSeat( Vector(50, 35, 44), Angle(0, -90, 5) )
	self:AddPassengerSeat( Vector(50, 20, 44), Angle(0, -90, 5) )
	self:AddPassengerSeat( Vector(5, 35, 44), Angle(0, -90, 5) )
	self:AddPassengerSeat( Vector(5, 20, 44), Angle(0, -90, 5) )
	self:AddPassengerSeat( Vector(-40, 35, 44), Angle(0, -90, 5) )
	self:AddPassengerSeat( Vector(-40, 20, 44), Angle(0, -90, 5) )
	self:AddPassengerSeat( Vector(-80, 35, 44), Angle(0, -90, 5) )
	self:AddPassengerSeat( Vector(-80, 20, 44), Angle(0, -90, 5) )
	self:AddPassengerSeat( Vector(-120, 35, 44), Angle(0, -90, 5) )
	self:AddPassengerSeat( Vector(-120, 20, 44), Angle(0, -90, 5) )
	self:AddPassengerSeat( Vector(-160, 35, 44), Angle(0, -90, 5) )
	self:AddPassengerSeat( Vector(-160, 20, 44), Angle(0, -90, 5) )
	self:AddPassengerSeat( Vector(-160, -35, 44), Angle(0, -90, 5) )
	self:AddPassengerSeat( Vector(-160, -20, 44), Angle(0, -90, 5) )
	self:AddPassengerSeat( Vector(-120, -35, 44), Angle(0, -90, 5) )
	self:AddPassengerSeat( Vector(-80, -35, 44), Angle(0, -90, 5) )
	self:AddPassengerSeat( Vector(50, -35, 44), Angle(0, -90, 5) )

	self:AddEngine( Vector(190, 0, 40) )
	self:AddFuelTank( Vector(-42.36,0,13.8), Angle(0,0,0), 600, LVS.FUELTYPE_PETROL )

	local WheelModel = "models/DiggerCars/stalker/laz_wheelf.mdl"
	local WheelModelR = "models/DiggerCars/stalker/laz_wheelr.mdl"

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
				pos = Vector(100, 44, 20),
				mdl = WheelModel,
				mdl_ang = Angle(0,90,0),
			} ),

			self:AddWheel( {
				pos = Vector(100, -44, 20),
				mdl = WheelModelR,
				mdl_ang = Angle(0,90,0),
			} ),
		},
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
			ForwardAngle = Angle(0,0,0),
			SteerType = LVS.WHEEL_STEER_NONE,
			TorqueFactor = 0.7,
			BrakeFactor = 1,
			UseHandbrake = true,
		},
		Wheels = {
			self:AddWheel( {
				pos = Vector(-79, 44, 20),
				mdl = WheelModel,
				mdl_ang = Angle(0,90,0),
			} ),

			self:AddWheel( {
				pos = Vector(-79, -44, 20),
				mdl = WheelModelR,
				mdl_ang = Angle(0,90,0),
			} ),
		},
		Suspension = {
			Height = 10,
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