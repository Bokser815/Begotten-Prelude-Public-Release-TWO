-- ==========================================
-- Init
-- ==========================================

AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.

include('shared.lua')

util.PrecacheSound( "fiend/cannonmovingsounds.ogg" )

ENT.DeployableAmmoTypes = {
	["ExplosiveBall"] = true,
	["Gunpowder"] = true,
	["CannonBall"] = true,
	["CanShot"] = true,
}
ENT.RoundInfo = {
	["ExplosiveBall"] = {
        ["IsBullet"] = false,
        ["IsExplosive"] = true,
		["UniqueID"] = "explosive_ball",
	},
	["CannonBall"] = {
        ["IsBullet"] = false,
        ["IsExplosive"] = false,
		["UniqueID"] = "cannon_ball",
	},
	["CanShot"] = {
        ["IsBullet"] = true,
        ["IsExplosive"] = false,
		["UniqueID"] = "can_shot",
	},
}
ENT.ActiveRoundType = nil
ENT.IsBGDeployable = true
ENT.IsPowdered = false
ENT.ReloadCooldown = 0
ENT.AdjustTimer = 0
ENT.EjectorTiming = 0
ENT.Readiedround = nil
ENT.FuckingFailedReload = false
ENT.OverPressure = false
ENT.isprimed = false
ENT.health = 1500

function ENT:SpawnFunction(ply, tr, ClassName)
    if not tr.Hit then return end

    local ent = ents.Create(ClassName)
    ent:SetPos(tr.HitPos + tr.HitNormal * 25)
    ent:Spawn()
    ent:Activate()

    return ent
end

function ENT:Initialize()
    if (CLIENT) then return end

    self:SetModel("models/begotten/cannon_6lb.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)

    self:InitGunnerSeat1()
	self:InitGunnerSeat2()
    
    local phys = self:GetPhysicsObject()
    if (phys:IsValid()) then 
        phys:Wake() 
        phys:EnableDrag(true)
        --phys:EnableGravity(false)
        phys:SetDamping(2, 0)
        phys:SetAngleDragCoefficient(0)
    end

    self.Deployed = false

    self.Weapon = self:GetBodygroup(2)

    --self.AimMode = 0
    --self:SetNWFloat("AimMode", AimMode, 0)

    self.Ready = true
    self.ReloadTime = 0
    self.BolterAmmo = 200
    self.CurrentAmmoTypeFieldcannon = 1
    --self:SetNWString("AmmoTypeFieldcannon", self.AmmoTypeFieldcannon[1], 0)

    self.AutocannonAmmo = 6
    --self:SetNWFloat("AutocannonAmmo", self.AutocannonAmmo, 0)

    --self:SetHealth( 500 )
end

function ENT:OnTakeDamage( dmginfo )
	--[[if dmginfo:GetDamage() > 200 then
		self:SetHealth( self:Health() - (dmginfo:GetDamage() - 100 ))
	end]]
	local ent = self
	local dmgamount = dmginfo:GetDamage()
	if dmginfo:GetDamageType() == 64 then
		dmgamount = dmgamount * 10
	end
	ent:EmitSound("physics/wood/wood_plank_break"..math.random(3, 4)..".wav")
	ent.health = ent.health - dmgamount
	if ent.health <= 0 then 
		--local effectdata = EffectData()
			--effectdata:SetOrigin( self:GetPos() )
		--util.Effect( "fieldcannon_explosion_medium", effectdata )
		if dmginfo:GetDamageType() == 64 then
			local Gunner2 = self.GunnerSeat2:GetPassenger(1)
			local Gunner1 = self.GunnerSeat1:GetPassenger(1)
			if IsValid(Gunner2) and Gunner2:Alive() then
				Gunner2:Kill()
			end
			if IsValid(Gunner1) and Gunner1:Alive() then
				Gunner1:Kill()
			end
		end
		ent:Remove()
		ent:EmitSound("physics/wood/wood_crate_break5.wav")
	end
end

function ENT:OnRemove()
	if self.isplayingsound then
		self:StopLoopingSound(self.isplayingsound)
	end
end

function ENT:InitGunnerSeat1()
	local seat = ents.Create("prop_vehicle_prisoner_pod")
	seat:SetModel("models/props_junk/sawblade001a.mdl")
	seat:SetKeyValue("vehiclescript","scripts/vehicles/prisoner_pod.txt")
	seat:SetKeyValue("limitview", 0)
	seat:SetMoveType( MOVETYPE_VPHYSICS )
	seat:Spawn()
	seat:Activate()
	seat:SetPos(self:GetPos())
	seat:SetAngles(self:GetAngles())
	seat:SetParent(self)
	seat:SetLagCompensated( false )
	seat:SetLocalPos(Vector(-72,-23,5))
	seat:SetLocalAngles(Angle(0,0,0))
	seat:DrawShadow(false)
	seat:SetNoDraw(true)
	seat:SetNotSolid(true)
	seat:SetCollisionGroup(COLLISION_GROUP_NONE)
	seat:SetThirdPersonMode(false)
	self.GunnerSeat1 = seat
end

function ENT:InitGunnerSeat2()
	local seat = ents.Create("prop_vehicle_prisoner_pod")
	seat:SetModel("models/props_junk/sawblade001a.mdl")
	seat:SetKeyValue("vehiclescript","scripts/vehicles/prisoner_pod.txt")
	seat:SetKeyValue("limitview", 0)
	seat:SetMoveType( MOVETYPE_VPHYSICS )
	seat:Spawn()
	seat:Activate()
	seat:SetPos(self:GetPos())
	seat:SetAngles(self:GetAngles())
	seat:SetParent(self)
	seat:SetLagCompensated( false )
	seat:SetLocalPos(Vector(-72,23,5))
	seat:SetLocalAngles(Angle(0,0,0))
	seat:DrawShadow(false)
	seat:SetNoDraw(true)
	seat:SetNotSolid(true)
	seat:SetCollisionGroup(COLLISION_GROUP_NONE)
	seat:SetThirdPersonMode(false)
	self.GunnerSeat2 = seat
end

-- ==========================================
-- Stuff
-- ==========================================

function ENT:Use(activator, caller, useType, value)
	local DistanceToSeat1 = (self.GunnerSeat1:GetPos()):Distance(activator:GetPos())
	local DistanceToSeat2 = (self.GunnerSeat2:GetPos()):Distance(activator:GetPos())

	if IsValid(activator) == false or activator:Alive() == false then
		return
	end
	local action = Clockwork.player:GetAction(activator)
	if action == "readypacking" or action == "readyball" or action == "readycan" then
		return
	end

	if DistanceToSeat1 > 100 and DistanceToSeat2 > 100 then
		return
	end

	local tr = util.TraceLine{
		start = self:GetPos(),
		endpos = self:GetPos()+self:GetAngles():Up()*-20,
		filter = self
	}
	if tr.Hit == false then
		if self.AdjustTimer<CurTime() then
			self.AdjustTimer=CurTime()+1
			Clockwork.chatBox:AddInTargetRadius(activator, "me", "tries to flip the cannon.", activator:GetPos(), config.Get("talk_radius"):Get() * 2);
			local phys = self:GetPhysicsObject()
			if phys:IsValid() then
				phys:AddAngleVelocity(-phys:GetAngleVelocity() * 7)
				local ang = phys:GetAngles()
				local angp = math.NormalizeAngle(ang.p)
				local angr = math.NormalizeAngle(ang.r)
				phys:AddAngleVelocity(-Vector(angr, angp, 0) * 7)
				--phys:ApplyForceCenter(Vector(0,0,self:LocalToWorld(self:OBBCenter()).z-100000))
			end
		end
		return
	end

	if DistanceToSeat2 < DistanceToSeat1 then 

    	activator:SetNWFloat("AimMode", 1, 0)
		activator:EnterVehicle(self.GunnerSeat2)
		self.remembertodisarm2 = activator

	elseif DistanceToSeat2 > DistanceToSeat1 then
		
		activator:SetNWFloat("AimMode", 1, 0)
		activator:EnterVehicle(self.GunnerSeat1)
		self.remembertodisarm1 = activator

	end

end

function ENT:HandleMovementAnims( phy )
	local MovementDiff = math.abs(math.abs(self:GetForward():Angle().y)-math.abs((phy:GetVelocity():GetNormalized():Angle().y)))
	local Multiplier = 0
	if MovementDiff <= 30 then Multiplier = 1 elseif MovementDiff >= 150 then Multiplier = -1 end

	self:SetNWFloat("HorizontalMovement", (math.Remap(phy:GetAngleVelocity().r, -4, 4, -1, 1 )))
	self:SetNWFloat("FrontalMovement", (math.Remap(phy:GetVelocity():Length()*Multiplier, -80, 80, -1, 1 )))
	
	self:SetPoseParameter("wheel_left", self:GetPoseParameter("wheel_left")-(math.Remap(phy:GetVelocity():Length()*Multiplier, -60, 60, -1, 1 )))
	self:SetPoseParameter("wheel_right", self:GetPoseParameter("wheel_right")+(math.Remap(phy:GetVelocity():Length()*Multiplier, -60, 60, -1, 1 )))
end


function ENT:Think()
	local phy = self:GetPhysicsObject()
	local Gunner1 = self.GunnerSeat1:GetPassenger(1)
	local Gunner2 = self.GunnerSeat2:GetPassenger(1)
	if IsValid(Gunner1)==false and self.remembertodisarm1 then
		local ply = self.remembertodisarm1
		if IsValid(ply) and ply:Alive() then
			if ply:HasWeapon("begotten_fists") then
				ply:SelectWeapon("begotten_fists")
			end
		end
		self.remembertodisarm1 = nil
	end
	if IsValid(Gunner2)==false and self.remembertodisarm2 then
		local ply = self.remembertodisarm2
		if IsValid(ply) and ply:Alive() then
			if ply:HasWeapon("begotten_fists") then
				ply:SelectWeapon("begotten_fists")
			end
		end
		self.remembertodisarm2 = nil
	end

	self:TryEject( Gunner1, Gunner2, phy )

	self:HandleMovementAnims( phy )

	if !IsValid(Gunner2) then
		if self.isplayingsound then
			self:StopLoopingSound(self.isplayingsound)
		end
	end

	if self.EjectorTiming<CurTime() then
		self.EjectorTiming = CurTime()+0.5
		local tr = util.TraceLine{
			start = self:GetPos(),
			endpos = self:GetPos()+self:GetAngles():Up()*-20,
			filter = self
		}
		if tr.Hit == false then
			if IsValid(Gunner1) then
				Gunner1:ExitVehicle()
				timer.Simple(0.3, function()
					if IsValid(Gunner1) then
						Clockwork.player:SetRagdollState(Gunner1, RAGDOLL_FALLENOVER, 6);
						Clockwork.chatBox:AddInTargetRadius(Gunner1, "me", "trips falling off the cannon like a retard.", Gunner1:GetPos(), config.Get("talk_radius"):Get() * 2);
					end
				end)
			end
			if IsValid(Gunner2) then
				Gunner2:ExitVehicle()
				timer.Simple(0.3, function()
					if IsValid(Gunner2) then
						Clockwork.player:SetRagdollState(Gunner2, RAGDOLL_FALLENOVER, 6);
						Clockwork.chatBox:AddInTargetRadius(Gunner2, "me", "trips falling off the cannon like a retard.", Gunner2:GetPos(), config.Get("talk_radius"):Get() * 2);
					end
				end)
			end
		end
	end
	
	if IsValid(Gunner1) then
		local inputForward1, inputReverse1, inputLeft1, inputRight1, inputReload1, inputDeploy1, inputAttack1, inputCamera1

	        inputForward1 = Gunner1:KeyDown(IN_FORWARD)
	        inputReverse1 = Gunner1:KeyDown(IN_BACK)
	        inputLeft1 = Gunner1:KeyDown(IN_MOVELEFT)
	        inputRight1 = Gunner1:KeyDown(IN_MOVERIGHT)
	        inputReload1 = Gunner1:KeyPressed(IN_RELOAD)
	        inputDeploy1 = Gunner1:KeyPressed(IN_JUMP)
	        inputAttack1 = Gunner1:KeyDown(IN_ATTACK)
	        inputCamera = Gunner1:KeyPressed(IN_ATTACK2)

	    local slopeAdjust = 0
	    if self:GetAngles().x < 0 then
	        slopeAdjust = self:GetAngles().x * -12000
	    end

	    local accForce = 210000 + slopeAdjust
	    local avForce = 3000
		--[[
	    if (inputForward1) then
	        phy:ApplyForceCenter(self:GetForward() * accForce * FrameTime())
	    elseif (inputReverse1) then
	        phy:ApplyForceCenter(self:GetForward() * accForce * -1 * FrameTime())
	    end

	    if (inputLeft1) then
	        phy:AddAngleVelocity(-phy:GetAngleVelocity() + Vector(0, 0, avForce * FrameTime()))
	    elseif (inputRight1) then
	        phy:AddAngleVelocity(-phy:GetAngleVelocity() + Vector(0, 0, -avForce * FrameTime()))
	    else
	    	phy:SetVelocity(phy:GetVelocity() * 0.95)
	    	phy:AddAngleVelocity(-phy:GetAngleVelocity())
	    end
		]]

	    if (inputAttack1) then
	    	self:FireWeapon( Gunner1, phy )
	    end

	    if (inputReload1) then
	    	self:ReloadWeapon( Gunner1, Gunner2 )
	    end

	    if (inputDeploy1) then
			self:ToggleDeployed()
		end

		if (inputCamera) then
			if !Gunner1.AimMode then Gunner1.AimMode = Gunner1:GetNWFloat("AimMode", 0 ) end
			Gunner1.AimMode = Gunner1.AimMode + 1
			if Gunner1.AimMode == 2 then Gunner1.AimMode = 0 end
			Gunner1:SetNWFloat("AimMode", Gunner1.AimMode, 0)
		end

		self:AimWeapon( Gunner1, phy)
	end

	if IsValid(Gunner2) then
		local inputForward2, inputReverse2, inputLeft2, inputRight2, inputDeploy2

	        inputForward2 = Gunner2:KeyDown(IN_FORWARD)
	        inputReverse2 = Gunner2:KeyDown(IN_BACK)
	        inputLeft2 = Gunner2:KeyDown(IN_MOVELEFT)
	        inputRight2 = Gunner2:KeyDown(IN_MOVERIGHT)
	        inputDeploy2 = Gunner2:KeyPressed(IN_JUMP)
			if self.isplayingsound == nil and self:GetVelocity():LengthSqr() > 50 then 
				self.isplayingsound = self:StartLoopingSound( "fiend/cannonmovingsounds.ogg" )
				
			elseif self.isplayingsound!=nil and self:GetVelocity():LengthSqr() <= 50 then
				
				self:StopLoopingSound(self.isplayingsound)
				self.isplayingsound = nil
			end

	    local slopeAdjust = 0
	    if self:GetAngles().x < 0 then
	        slopeAdjust = self:GetAngles().x * -12000
	    end
	    local accForce = 200000 + slopeAdjust
	    local avForce = 2000
		if inputRight2 or inputLeft2 then
			accForce = 170000 + slopeAdjust 
		end
	    if (inputForward2) then
	        phy:ApplyForceCenter(self:GetForward() * accForce * FrameTime())

	    elseif (inputReverse2) then
	        phy:ApplyForceCenter(self:GetForward() * accForce * -1 * FrameTime())
	    end

	    if (inputLeft2) and (inputForward2 or inputReverse2) then
	        phy:AddAngleVelocity(-phy:GetAngleVelocity() + Vector(0, 0, avForce * FrameTime()))
	    elseif (inputRight2) and (inputForward2 or inputReverse2) then
	        phy:AddAngleVelocity(-phy:GetAngleVelocity() + Vector(0, 0, -avForce * FrameTime()))
	    else
	    	phy:SetVelocity(phy:GetVelocity() * 0.95)
	    	phy:AddAngleVelocity(-phy:GetAngleVelocity())
	    end

	    if (inputDeploy2) then
			self:ToggleDeployed()
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:ReloadWeapon( Gunner1 )
	if self.ReloadCooldown>CurTime() then return end

	if self.ActiveRoundType then
		local bottable = self.RoundInfo[self.ActiveRoundType]
		local itemtable = Clockwork.item:CreateInstance(bottable["UniqueID"])
		Gunner1:GiveItem(itemtable, true)
		if self.IsPowdered then
			local itemtable = Clockwork.item:CreateInstance("gunpowder_packing")
			Gunner1:GiveItem(itemtable, true)
			Clockwork.chatBox:AddInTargetRadius(Gunner1, "me", "removes the powder and cannonball.", Gunner1:GetPos(), config.Get("talk_radius"):Get() * 2);
		else
			Clockwork.chatBox:AddInTargetRadius(Gunner1, "me", "removes the cannonball.", Gunner1:GetPos(), config.Get("talk_radius"):Get() * 2);
		end
		if self.OverPressure then
			local itemtable = Clockwork.item:CreateInstance("gunpowder_packing")
			Gunner1:GiveItem(itemtable, true)
		end
		self.FuckingFailedReload = false
		self.OverPressure = false
		self.ActiveRoundType = nil
		self.IsPowdered = nil
		self.isprimed = false
		return
	end
			
	if self.Readiedround and self.IsPowdered==true then
		self.ActiveRoundType = self.Readiedround
		self.Readiedround = nil
		self.isprimed = true
		self:EmitSound(Sound("fiend/cannonprime.wav"))
		Clockwork.chatBox:AddInTargetRadius(Gunner1, "me", "primes the cannon firing mechanism.", Gunner1:GetPos(), config.Get("talk_radius"):Get() * 2); -- fix double name
	end
	self.ReloadCooldown = CurTime()+1
end

function ENT:ToggleDeployed(activator, caller, useType, value)
	local Gunner1 = self.GunnerSeat1:GetPassenger(1)
	local Gunner2 = self.GunnerSeat2:GetPassenger(1)
	if not self.Deployed then
		self:SetSequence(self:LookupSequence("legs_down_deployed"))
		self.Deployed = true
		self:GetPhysicsObject():EnableMotion( false )
		--self:EmitSound("40k_fieldgun_deploy")
		if IsValid(Gunner1) then
			Clockwork.chatBox:AddInTargetRadius(Gunner1, "me", "flips down the brakes on the cannon wheels.", Gunner1:GetPos(), config.Get("talk_radius"):Get() * 2);
		elseif IsValid(Gunner2) then
			Clockwork.chatBox:AddInTargetRadius(Gunner2, "me", "flips down the brakes on the cannon wheels.", Gunner2:GetPos(), config.Get("talk_radius"):Get() * 2);
		end
	elseif self.Deployed then
		self:SetSequence(self:LookupSequence("legs_down_stowed"))
		self.Deployed = false
		self:GetPhysicsObject():EnableMotion( true )
		--self:EmitSound("40k_fieldgun_undeploy")
		
		if IsValid(Gunner1) then
			Clockwork.chatBox:AddInTargetRadius(Gunner1, "me", "undoes the brakes on the cannon wheels.", Gunner1:GetPos(), config.Get("talk_radius"):Get() * 2);
		elseif IsValid(Gunner2) then
			Clockwork.chatBox:AddInTargetRadius(Gunner2, "me", "undoes the brakes on the cannon wheels.", Gunner2:GetPos(), config.Get("talk_radius"):Get() * 2);
		end
	end
end

function ENT:TryEject( Gunner1, Gunner2, phy )
	if phy:GetVelocity():Length() > 400 then
		if IsValid(Gunner1) then
			Gunner1:ExitVehicle()

		end
		if IsValid(Gunner2) then
			Gunner2:ExitVehicle()

		end
	end
end

-- ==========================================
-- Aiming
-- ==========================================

function ENT:AimWeapon( Gunner1, phy )
	local Aimang = self:WorldToLocalAngles( Gunner1:EyeAngles() )
	Aimang:Normalize()
	
	local AimRate = 60
	
	local Angles = Aimang
	
	self.sm_pp_yaw = self.sm_pp_yaw and math.ApproachAngle( self.sm_pp_yaw, Angles.y, AimRate * FrameTime() ) or 0
	self.sm_pp_pitch = self.sm_pp_pitch and math.ApproachAngle( self.sm_pp_pitch, Angles.p, AimRate/2 * FrameTime() ) or 0
	
	local TargetAng = Angle(self.sm_pp_pitch,self.sm_pp_yaw,0)
	TargetAng:Normalize() 

	self:SetPoseParameter("cannon_yaw",  -TargetAng.y )
	self:SetPoseParameter("cannon_pitch", -TargetAng.p - 7 + self:GetAngles().p  )
end

-- ==========================================
-- Weapons
-- ==========================================

function ENT:FireWeapon( Gunner1, phy )
	if self.Weapon == 0 then
		self:FireFieldCannon( Gunner1, phy )
	end
end

function ENT:FireFieldCannon( Gunner1, phy )
	if self.nextcheckcannon and self.nextcheckcannon>CurTime() then
		return 
	end
	self.nextcheckcannon = CurTime()+1
	if !self.IsPowdered or self.isprimed!=true then
		Clockwork.chatBox:AddInTargetRadius(Gunner1, "me", "fails to fire the cannon.", Gunner1:GetPos(), config.Get("talk_radius"):Get() * 2);
		return 
	end
	if self.FuckingFailedReload == true then
		-- hiss boom
		local effectdata = EffectData()
		effectdata:SetOrigin(self.Entity:GetPos())
		util.Effect("HelicopterMegaBomb", effectdata)
		local effect = EffectData();
		local Forward = self:GetForward()
		local Right = self:GetRight()
		effect:SetOrigin(self:GetPos());
		--effect:SetNormal( self:GetNormal());
		effect:SetColor( 3 )
		effect:SetFlags( bit.bor( 0x4, 0x80 ) )
		effect:SetScale( 1 )
		effect:SetMagnitude( 1 )
		util.Effect( "Explosion", effect );
		self.Entity:EmitSound("prelude/warofrightscannon/explo_artillery_03__blast_002_445310754.ogg", 140, 100)
		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos())
		effectdata:SetEntity(self.Entity)
		effectdata:SetScale(0.9)
		effectdata:SetMagnitude(18)
		--util.Effect( "m9k_gdcw_tpaboom", effectdata )
		util.BlastDamage(self.Entity, self, self:GetPos(), 600, 250)
		
		local Gunner2 = self.GunnerSeat2:GetPassenger(1)
		if IsValid(Gunner2) and Gunner2:Alive() then
			Gunner2:Kill()
		end
		if IsValid(Gunner1) and Gunner1:Alive() then
			Clockwork.chatBox:AddInTargetRadius(Gunner1, "me", "is suddenly engulfed flames as the ill loaded cannon detonates.", Gunner1:GetPos(), config.Get("talk_radius"):Get() * 2); -- fix double name
			Gunner1:Kill()
		end

		self:Remove()
		return
	end
	if self.OverPressure == true then
		--boom
		local effectdata = EffectData()
		effectdata:SetOrigin(self.Entity:GetPos())
		util.Effect("HelicopterMegaBomb", effectdata)
		local effect = EffectData();
		local Forward = self:GetForward()
		local Right = self:GetRight()
		effect:SetOrigin(self:GetPos());
		--effect:SetNormal( self:GetNormal());
		effect:SetColor( 3 )
		effect:SetFlags( bit.bor( 0x4, 0x80 ) )
		effect:SetScale( 1 )
		effect:SetMagnitude( 1 )
		util.Effect( "Explosion", effect );
		self.Entity:EmitSound("prelude/warofrightscannon/explo_artillery_03__blast_002_445310754.ogg", 140, 100)
		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos())
		effectdata:SetEntity(self.Entity)
		effectdata:SetScale(0.9)
		effectdata:SetMagnitude(18)
		--util.Effect( "m9k_gdcw_tpaboom", effectdata )
		util.BlastDamage(self.Entity, self, self:GetPos(), 600, 250)
		
		local Gunner2 = self.GunnerSeat2:GetPassenger(1)
		if IsValid(Gunner2) and Gunner2:Alive() then
			Gunner2:Kill()
		end
		if IsValid(Gunner1) and Gunner1:Alive() then
			Clockwork.chatBox:AddInTargetRadius(Gunner1, "me", "is suddenly engulfed flames as the ill loaded cannon detonates.", Gunner1:GetPos(), config.Get("talk_radius"):Get() * 2); -- fix double name
			Gunner1:Kill()
		end

		self:Remove()
		return
	end
	if ( bit.band( util.PointContents( self:GetPos() ), CONTENTS_WATER ) == CONTENTS_WATER ) then
		if IsValid(Gunner1) then
			Schema:EasyText(Gunner1, "chocolate", "The powder has become waterlogged!");
		end
		return 
	end
	local ID = self:LookupAttachment("fieldcannon_muzzle")
	local Attachment = self:GetAttachment( ID )
	--self:EmitSound("prelude/warofrightscannon/weapon_artillery_fire_04_277963186.ogg", 140, 100)
	self:EmitSound("prelude/warofrightscannon/explo_artillery_02__blast_002_352624756.ogg", 140, 100)
	self.isprimed = false
	local effectdata = EffectData()
	effectdata:SetOrigin( Attachment.Pos )
	effectdata:SetAngles( Attachment.Ang )
	effectdata:SetEntity( self )
	effectdata:SetAttachment( ID )
	effectdata:SetScale( 6 )
	--util.Effect( "MuzzleEffect", effectdata, true, true )
	self:GetPhysicsObject():ApplyForceOffset( -Attachment.Ang:Forward() * 50000, Attachment.Pos ) 
	self:AddGestureSequence( self:LookupSequence( "fieldcannon_fire"), 1 )
	util.ScreenShake( self:GetPos(), 1000, 500, 1, 400 )

	local effect = EffectData();
	local Forward = self:GetForward()
	local Right = self:GetRight()
	effect:SetOrigin(Attachment.Pos + (Attachment.Ang:Forward()*2));
	effect:SetNormal( Attachment.Ang:Forward());
	effect:SetColor( 3 )
	effect:SetFlags( bit.bor( 0x4, 0x80 ) )
	effect:SetScale( 1 )
	effect:SetMagnitude( 1 )
	util.Effect( "Explosion", effect );
	util.Effect( "effect_awoi_smoke_pistol", effect );

	if self.ActiveRoundType == "ExplosiveBall" then
		self:FieldCannonFrag( Gunner1, Attachment.Pos, Attachment.Ang )
		
	elseif self.ActiveRoundType == "CannonBall" then
		self:FieldCannonSolid( Gunner1, Attachment.Pos, Attachment.Ang )
	elseif self.ActiveRoundType == "CanShot" then
		self:FieldCannonBuckshot( Gunner1, Attachment.Pos, Attachment.Ang )
	end
	
	self.IsPowdered = false
	self.Readiedround = nil
	self.ActiveRoundType = nil

	self.Ready = false
	self.ReloadTime = CurTime() + 5
	timer.Simple( 5, function()
		if IsValid( self ) then
			self.Ready = true
		end
	end)
end

function ENT:FieldCannonFrag( Gunner1, Pos, Ang )
	local rocket = ents.Create("cw_m202_rocketexplosive")
	if !rocket:IsValid() then return false end
	rocket:SetAngles(Ang+Angle(0,0,0))
	rocket:SetPos(Pos)
	rocket:SetOwner(Gunner1)
	rocket:Spawn()
	rocket:Activate()
	
end

function ENT:FieldCannonSolid( Gunner1, Pos, Ang )
	local rocket = ents.Create("cw_m202_rocketsolid")
	if !rocket:IsValid() then return false end
	rocket:SetAngles(Ang+Angle(0,0,0))
	rocket:SetPos(Pos)
	rocket:SetOwner(Gunner1)
	rocket:Spawn()
	rocket:Activate()
	
end

function ENT:FieldCannonBuckshot( Gunner1, Pos, Ang )
	local bullet = {}
		bullet.Num 			= 24
		bullet.Src 			= Pos
		bullet.Dir 			= Ang:Forward()
		bullet.Spread 		= Vector(0.07,0.07,0.07)
		bullet.Tracer		= 1
		bullet.AmmoType = "SciFiAmmo"
		bullet.TracerName = "moby_tracer"
		bullet.Force		= 1
		bullet.Damage		= 40
		bullet.HullSize		= 1
		bullet.Attacker 	= Gunner1
		bullet.Callback = function(att, tr, dmginfo)--

	end

	self:FireBullets( bullet )
end

