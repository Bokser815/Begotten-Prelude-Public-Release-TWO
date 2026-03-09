AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Ballista"
ENT.Author = "Bokser"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Begotten"
ENT.AutomaticFrameAdvance = true
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.Isreloaded = false
ENT.IsBGDeployable = true
ENT.hp = 600
ENT.maxhp = 600
ENT.DeployableAmmoTypes = {
	["BallistaBolt"] = true,
	["PilumBolt"] = true,
	["IronJavBolt"] = true,
	["ScrapJavBolt"] = true,
}
ENT.Readiedround = ""
ENT.BoltInfo = { -- yea fuck you we put the bolts in here so I can test faster
	["BallistaBolt"] = {
		["AttackTable"] = {
			["primarydamage"] = 1000,
			["dmgtype"] = DMG_VEHICLE,
			["armorpiercing"] = 50,
			["poisedamage"] = 100,
			["stabilitydamage"] = 60,
			["takeammo"] = 20,
			["delay"] = 0.5,
			["striketime"] = 0.6,
			["punchstrength"] = Angle(0,4,0),
		},
		["Velocity"] = 13000,
		["Model"] = "models/begotten/ballistabolt.mdl",
		["CustomImpact"] = function(pos,ent)
			if IsValid(ent) and ent:IsPlayer() then
				local target = Clockwork.player:FindByID(ent);
				timer.Simple(0.1, function()
					if (target) then
						if (target:Alive()) then
							return;
						else							
							if (target:GetRagdollEntity()) then
								cwGore:SplatCorpse(target:GetRagdollEntity(), 60);
								
							end;
						end;
					end;
				end)
			end
		end,
		["BodyGroup"] = 1,
		["UniqueID"] = "begotten_javelin_ballistabolt",
		["ConditionLoss"] = 50,
	},
	["PilumBolt"] = {
		["AttackTable"] = {
			["primarydamage"] = 400,
			["dmgtype"] = DMG_VEHICLE,
			["armorpiercing"] = 80,
			["poisedamage"] = 75,
			["stabilitydamage"] = 75,
			["takeammo"] = 20,
			["delay"] = 0.5,
			["striketime"] = 0.6,
			["punchstrength"] = Angle(0,4,0),
		},
		["Velocity"] = 7000,
		["Model"] = "models/props/begotten/melee/heide_lance.mdl",
		["CustomImpact"] = function(pos,ent)

		end,
		["BodyGroup"] = 3,
		["UniqueID"] = "begotten_javelin_pilum",
		["ConditionLoss"] = 100,
		["DamageToBallista"] = 50,
	},
	["IronJavBolt"] = {
		["AttackTable"] = {
			["primarydamage"] = 250,
			["dmgtype"] = DMG_VEHICLE,
			["armorpiercing"] = 50,
			["poisedamage"] = 60,
			["stabilitydamage"] = 60,
			["takeammo"] = 20,
			["delay"] = 0.5,
			["striketime"] = 0.6,
			["punchstrength"] = Angle(0,4,0),
		},
		["Velocity"] = 7000,
		["Model"] = "models/demonssouls/weapons/cut javelin.mdl",
		["CustomImpact"] = function(pos,ent)

		end,
		["BodyGroup"] = 2,
		["UniqueID"] = "begotten_javelin_iron_javelin",
		["ConditionLoss"] = 100,
		["DamageToBallista"] = 50,
	},
	["ScrapJavBolt"] = {
		["AttackTable"] = {
			["primarydamage"] = 125,
			["dmgtype"] = DMG_VEHICLE,
			["armorpiercing"] = 50,
			["poisedamage"] = 60,
			["stabilitydamage"] = 60,
			["takeammo"] = 20,
			["delay"] = 0.5,
			["striketime"] = 0.6,
			["punchstrength"] = Angle(0,4,0),
		},
		["Velocity"] = 6000,
		["Model"] = "models/lostcoast/fisherman/harpoon offset.mdl",
		["CustomImpact"] = function(pos,ent)

		end,
		["BodyGroup"] = 4,
		["UniqueID"] = "begotten_javelin_scrap",
		["ConditionLoss"] = 100,
		["DamageToBallista"] = 50,
	},
}
ENT.ActiveRoundType = nil
ENT.CurrentBoltDurability = 0
ENT.ActiveBoltDurability = 0


hook.Add("CalcViewAdjustTable", "BallistaAim", function(view)
	local ply = LocalPlayer()
	local cross = ply.crossbowisaiming
	if ply and IsValid(cross) then
		if ply.isfuckingaiming and ply.isfuckingaiming == true and ply == cross:GetNWEntity( "mountedplayer", self ) then
			local muzzle = cross:GetAttachment(cross:LookupAttachment("muzzle"))
			view.origin = muzzle.Pos + muzzle.Ang:Forward()*-50 + muzzle.Ang:Up()*5;
			view.angles = muzzle.Ang
			--view.angle = muzzle.Ang
		end
	end
	
	
end)
--
if (SERVER) then

	function ENT:Initialize()
		self:SetModel("models/begotten/ballista.mdl")

		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		local physicsObject = self:GetPhysicsObject()
		self:SetDTInt(0, 150)
		
		if (IsValid(physicsObject)) then
			physicsObject:Wake()
		end
		self:StartMotionController()
	end

	function ENT:OnRemove()
		if (self.Owner and IsValid(self.Owner)) then
			self.Owner:SetForcedAnimation(false)
			self.Owner.Turret = nil
			self.Owner:GetViewModel():SetNoDraw(false)
		end
	end


	function ENT:OnTakeDamage(dmg)
		if !self.damagesoundt then self.damagesoundt = 0 end
		if self.damagesoundt <= CurTime() then
			self.damagesoundt=CurTime()+1
			self:EmitSound("prelude/ballista/balista_damage_0"..math.random(1, 3)..".ogg")
		end
		self.hp = self.hp - dmg:GetDamage()
		if self.hp <= 0 then
			self:EmitSound("physics/wood/wood_plank_break1.wav")
			self:Remove()
			
		end
	end
	

	function ENT:Use(client)
		if (!self.nextUse or self.nextUse < CurTime()) then
			self:OnUse(client)
			self.nextUse = CurTime() + 1
		end
	end

	function ENT:OnUse(client)
		if (self.Owner and IsValid(self.Owner)) then
			if (self.Owner == client) then
				self.Owner:SetForcedAnimation(false)
				self:SetNWEntity("currentTurret", self)
				self:EmitSound(Sound("prelude/ballista/ballista_dismount_0"..math.random(1, 3)..".ogg"))
				self.Owner:GetViewModel():SetNoDraw(false)
				self.Owner.Turret = nil
				self.Owner:SetNWEntity("currentTurret", nil)
				
				self.Owner = nil
				self:SetNWEntity( "mountedplayer", self )
				
			end
		else
			local aimVector = client:GetAimVector()
			local turretForward = self:GetForward()
			local turretDot = turretForward:Dot(aimVector)

			if (turretDot < 0 or math.abs(turretDot) < .2) then
				return
			end

			if (client.Turret and IsValid(client.Turret)) then
				return
			end
			client:SetForcedAnimation("Man_Gun", 0)
			self.savedpositionforplayer = client:GetPos()
			self:ResetSequence("activate")
			--client:SetViewEntity(client)
			--self:EmitSound("fiend/ballistafire.wav")
			self.Owner = client
			self:SetNWEntity( "mountedplayer", client )
			self:EmitSound(Sound("prelude/ballista/ballista_mount_0"..math.random(1, 3)..".ogg"))
			self.Owner:GetViewModel():SetNoDraw(true)
			self.Owner:SetNWEntity("currentTurret", self)
			self:SetNWEntity("currentTurret", self.Owner)
			self.Owner.Turret = self
		end
	end
else
	-- register gun effect
	-- emit :DD

	
	function ENT:Draw()
		self:DrawModel()

		local owner = self:GetNWEntity("currentTurret", nil)
		
	end

end

function ENT:Think()
	local owner = self.Owner
	if IsValid(owner) then
		if !self.Pitch then self.Pitch = 0 end
		if !self.Yaw then self.Yaw = 0 end
		local _, angL = WorldToLocal( Vector( 0, 0, 0 ), owner:EyeAngles(), Vector( 0, 0, 0 ), self:GetAngles() )
		angL = Angle( math.Clamp( angL.Pitch, -35, 50 ), math.Clamp( angL.Yaw, -60, 60 ), 0 )
		local Pit = self.Pitch  
		local Yaw = self.Yaw
		self.Pitch = ( math.Clamp( angL.Pitch - Pit, -3, 3 ) + Pit )
		self.Yaw = ( math.Clamp( angL.Yaw - Yaw, -3, 3 ) + Yaw )
		self:SetPoseParameter( "aim_pitch", math.Round( self.Pitch ) )
		self:SetPoseParameter( "aim_yaw", math.Round( self.Yaw ) )
	end
	if CLIENT then
		local client = LocalPlayer()
		if client == self:GetNWEntity( "mountedplayer", self ) then
			if !client.isfuckingaiming then client.isfuckingaiming = false end
			client.crossbowisaiming = self
			if !client.isfuckingholdswitch then client.isfuckingholdswitch = false end
			if client:GetNWBool("isviewsenttocrossbow",false) == false and client.isfuckingaiming == true and client.isfuckingholdswitch == true then
				client.isfuckingaiming = false
				client.isfuckingholdswitch = false
			end
			if client:GetNWBool("isviewsenttocrossbow",false) == true and client.isfuckingaiming == false then
				client.isfuckingaiming = true
				client.isfuckingholdswitch = true
			end
		end
	end

	if SERVER then
		if self.Owner and IsValid(self.Owner) and self.Owner:Alive() then
			local aimVector = self.Owner:GetAimVector()
			local turretForward = self:GetForward()
			local turretDot = turretForward:Dot(aimVector)

			local ownerpos = self.Owner:GetPos()
			local selfpos = self:GetPos()

			if (ownerpos and ownerpos:Distance(selfpos)>80) or ownerpos != self.savedpositionforplayer then
				self.Owner:GetViewModel():SetNoDraw(false)
				self.Owner.Turret = nil
				self.Owner:SetForcedAnimation(false)
				self.Owner:SetNWEntity("currentTurret", nil)

				self.Owner = nil
				self:SetNWEntity( "mountedplayer", self )
				self:EmitSound(Sound("prelude/ballista/ballista_dismount_0"..math.random(1, 3)..".ogg"))
				self:SetNWEntity("currentTurret", self)

				return
			end

			if self.Owner:GetActiveWeapon():IsValid() then
				self.Owner:GetActiveWeapon():SetNextPrimaryFire(CurTime()+1)
				self.Owner:GetActiveWeapon():SetNextSecondaryFire(CurTime()+1)
			end

			if (self.reload==true and self.nextFire<CurTime()) then
				self.reload = false
				self:SetNWBool( "isloaded", true )
			end

			if (self:GetNWBool( "isloaded", false )==false and !self.reload) then
				if ((!self.nextFire or self.nextFire < CurTime()) and self.Owner:KeyDown(IN_RELOAD)) and self.Isreloaded == true then
					self:ResetSequence("reload")
					self:EmitSound(Sound("fiend/ballistaload.wav"))
					self.nextFire = CurTime() + 6
					self.reload = true
					timer.Simple(5, function()
						if self:IsValid() then
							--self:SetBodyGroups( "111" )
							self.Isreloaded = true
							self.ActiveRoundType = self.Readiedround
							local readytable = self.BoltInfo[self.Readiedround]
							self:SetBodygroup(1,readytable["BodyGroup"])
							self:SetBodygroup(2,0)
							self.Readiedround = ""
							self.Isreloaded = false
							self:EmitSound(Sound("prelude/ballista/ballistabolt_dropincolour_0"..math.random(1, 3)..".ogg"))
							self.ActiveBoltDurability = self.CurrentBoltDurability
						end
						
						
					end)

					return
				end
			elseif (self:GetNWBool( "isloaded", false )==true and !self.reload) and self.nextFire<= CurTime() and self.Owner:KeyDown(IN_RELOAD) then
				local bolttable = self.BoltInfo[self.ActiveRoundType]
				self.nextFire = CurTime() + 1
				self:SetNWBool( "isloaded", false )
				self:SetBodygroup(1,0)
				local itemtable = Clockwork.item:CreateInstance(bolttable["UniqueID"])
				self.Owner:GiveItem(itemtable, true)
				itemtable:TakeCondition(100-self.ActiveBoltDurability);
				Clockwork.chatBox:AddInTargetRadius(self.Owner, "me", "removes the reloaded bolt.", self.Owner:GetPos(), config.Get("talk_radius"):Get() * 2); -- fix double name
			end

			if (self:GetNWBool( "isloaded", false )==true and !self.reload) then
				if ((!self.nextFire or self.nextFire < CurTime()) and self.Owner:KeyDown(IN_ATTACK)) then

					local att = self:GetAttachment( self:LookupAttachment( "muzzle" ) )

					local bolttable = self.BoltInfo[self.ActiveRoundType]
					local determinedboltloss = bolttable["ConditionLoss"]+(100-self.ActiveBoltDurability)
					self.Owner.transfertableready = {
						["AttTable"] = bolttable["AttackTable"],
						["BallType"] = bolttable["UniqueID"],
						["ConditionLoss"] = determinedboltloss,
						["CustomImpEff"] = bolttable["CustomImpact"],
					}
					
					
					local javelin = ents.Create("begotten_javelin_iron_javelin_thrown")
					if !javelin:IsValid() then return false end
					self:SetNWBool( "isloaded", false )
					javelin:SetModel(bolttable["Model"]);
					local rotatedaxis = att.Ang
					javelin:SetAngles(att.Ang)
					javelin.Owner = self.Owner
					javelin:SetPos(att.Pos)
					javelin:SetOwner(self.Owner)
					javelin:Spawn()
					
					javelin:Activate()

					
					
					
					local phys = javelin:GetPhysicsObject()

					phys:SetVelocity(att.Ang:Forward() * bolttable["Velocity"]);
					if bolttable["DamageToBallista"] then
						self.hp = self.hp-bolttable["DamageToBallista"]
						self:EmitSound("prelude/ballista/balista_damage_0"..math.random(1, 3)..".ogg")
						if self.hp <= 0 then
							self:EmitSound("physics/wood/wood_plank_break1.wav")
							self:Remove()
							
						end
					end

					timer.Simple(0.1, function()
						if self:IsValid() then
							--self:SetBodyGroups( "000" )
							self:SetBodygroup(1,0)
						end
					end)

					--[[local e = EffectData()
					e:SetEntity(self)
					e:SetScale(1)
					e:SetOrigin(self:GetPos() + self.curAng:Up()*48 + self.curAng:Forward()*60)
					e:SetNormal(self:GetShootDir())
					util.Effect("DSHK_BURST", e)]]

					--[[local e = EffectData()
					e:SetEntity(self)
					e:SetScale(1)
					e:SetOrigin(self:GetPos() + self.curAng:Up()*53 + self.curAng:Right() * 3 + self.curAng:Forward()*-10)
					e:SetNormal(self:GetShellDir())
					util.Effect("DSHK_SHELL", e)]]
		

					self:EmitSound(Sound("fiend/ballistafire.wav"))
					self:EmitSound(Sound("prelude/ballista/sw_ballistarelease01.ogg"))
					self:ResetSequence("fire")
					self.nextFire = CurTime() + 0.16

					self:SetDTInt(0, math.max(self:GetDTInt(0) - 1, 0))
				end
			end
			if self.Owner:KeyDown(IN_ATTACK2) then
				self.Owner.isviewoffset = true
				self.Owner:SetNWBool("isviewsenttocrossbow",true)
			elseif self.Owner.isviewoffset and self.Owner.isviewoffset == true then
				self.Owner.isviewoffset = false
				self.Owner:SetNWBool("isviewsenttocrossbow",false)
			end
		else--
			if (self.Owner and IsValid(self.Owner)) then
				if self.Owner:GetViewModel() == true then
					self.Owner:GetViewModel():SetNoDraw(false)
				end
				self.Owner:SetForcedAnimation(false)
				self.Owner.Turret = nil
				self.Owner:SetNWEntity("currentTurret", nil)

				self.Owner = nil
				self:SetNWEntity( "mountedplayer", self )
				self:EmitSound(Sound("prelude/ballista/ballista_dismount_0"..math.random(1, 3)..".ogg"))
				self:SetNWEntity("currentTurret", self)
			end
		end

		self:NextThink(CurTime())
		return true
	end
end