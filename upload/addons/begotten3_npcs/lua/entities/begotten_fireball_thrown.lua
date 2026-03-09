ENT.Type 			= "anim"
ENT.PrintName		= "Fireball"
ENT.Author			= ""
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions		= ""
ENT.Spawnable			= false
ENT.AdminOnly = true 
ENT.DoNotDuplicate = true 
ENT.DisableDuplicator = true
ENT.noHandsPickup = true;

--For flinching only 

if SERVER then
	util.AddNetworkString( "BegottenAnim4" )
end;

if CLIENT then
	net.Receive( "BegottenAnim4", function()
		 local target = net.ReadEntity()
		 if target:IsValid() and target:Alive() then
		 local anim = net.ReadString()
		 local lookup = target:LookupSequence(anim)
		 target:AddVCDSequenceToGestureSlot( GESTURE_SLOT_FLINCH, lookup, 0, 1 );
	end end )
end;

function ENT:TriggerAnim4(target, anim) -- The two arguments for this function are "target" and "anim". Target is the entity we want to call the animation on, and anim being the animation itself.
	if SERVER then
		if (!target or !IsValid(target)) then
			target = self.Owner; -- Redundancy check to make sure that we don't get any errors incase "target" isn't valid.
		end;
		
		net.Start( "BegottenAnim4", true )
		net.WriteEntity( target ); -- Before, the argument here was just "self.Owner" which was always going to return the player holding the weapon, making them flinch instead of whatever "target" is.
		net.WriteString( anim );
		net.Broadcast();
	end;
end;

--For flinching only

if SERVER then
	AddCSLuaFile();

	function ENT:Initialize()
		self:SetModel("models/hunter/blocks/cube025x025x025.mdl");

		self:SetCollisionGroup(COLLISION_GROUP_WEAPON);
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		local phys = self:GetPhysicsObject()
		--self.NextThink = CurTime() +  1

		self.collided = {};

		if (phys:IsValid()) then
			phys:Wake();
			phys:SetMass(0);
			phys:EnableGravity(false);
			phys:SetInertia(vector_origin);
		end
		
		self.cachedStartPos = self:GetPos();
		self.InFlight = true;

		self.FireballDamage = 60;

		ParticleEffectAttach("bg_necromancer_fireball", PATTACH_POINT_FOLLOW, self, 0);
		self:EmitSound("vj_fire/fireball_throw.wav");
		self:EmitSound("ambient/fire/firebig.wav");

		--self:SetUseType(SIMPLE_USE)
		self.CanTool = false

	end

	function ENT:Think()
		if(!IsValid(self)) then return end

		local curTime = CurTime();

		if(!self.nextCheck or self.nextCheck < curTime) then
			self.nextCheck = curTime + 0.02;
			self:TestCollisions();

		end
		
		self.lifetime = self.lifetime or curTime + 3;

		if curTime > self.lifetime then
			self:Remove();
		end
		
		if self.InFlight and self:GetAngles().pitch <= 55 then
			self:GetPhysicsObject():AddAngleVelocity(Vector(0, 10, 0));
			
		end
	end

	function ENT:Disable()
		self.PhysicsCollide = function() end
		self.lifetime = CurTime() + 30;
		self.InFlight = false;
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON);
	end

	function ENT:TestCollisions()
		for _, v in pairs(ents.FindInSphere(self:GetPos(), 65)) do
			if(self.collided[v]) then continue; end

			self.collided[v] = true;

			self:Collided(v);

		end

	end

	function ENT:OnRemove()
		self:StopSound("ambient/fire/firebig.wav");

	end

	function ENT:PhysicsCollide(data)
		if(data.HitEntity == game.GetWorld()) then
			self:EmitSound("vj_acid/alien_acid.wav");
			self:Remove();
		
		end 

	end

	function ENT:Collided(ent)
		if(!ent:IsValid() and !ent:IsWorld()) then return; end
		if(!ent.Health) then return; end
		if(self.Owner and ent == self.Owner) then return; end

		if ent:GetClass() == "prop_ragdoll" then
			local ragdollPlayer = Clockwork.entity:GetPlayer(ent);
			
			if IsValid(ragdollPlayer) then
				ent = ragdollPlayer;
			end
		end
		
		local enemywep;

		if ent:IsValid() and ent:IsPlayer() then
			enemywep = ent:GetActiveWeapon();
        end
		
		local damage = self.FireballDamage;
		local damagetype = DMG_BURN;
		
		if(ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer() and !ent.iFrames) then
			if(ent:GetNWBool("Guardening") and enemywep and enemywep:GetNWString("activeShield"):len() > 0) then
				local shieldItem = ent:GetShieldEquipped();

				if(shieldItem and !ent.opponent) then
					self.itemTable:TakeCondition(100);
				end
			end
			
			if ent:IsPlayer() then
				self:TriggerAnim4(ent, "a_shared_hit_0"..math.random(1, 3));

			end
			
			if self.parried then
				if cwBeliefs and self.Owner.HasBelief and self.Owner:HasBelief("repulsive_riposte") then
					damage = damage * 3.5;
				else
					damage = damage * 3;
				end
			end
			
			local blockTable;
			local shield_reduction = 1;
			
			if(IsValid(enemywep)) then
				blockTable = GetTable(enemywep:GetNWString("activeShield"));
			end
			
			if blockTable then
				shield_reduction = blockTable.damagereduction or 1;
			end
			
			local d = DamageInfo();
			d:SetDamage(damage * shield_reduction);
			d:SetAttacker(self.Owner);
			d:SetDamageType(damagetype);
			d:SetInflictor(self);

			ent:TakeDamageInfo(d);

			ent:Ignite(5);
			
			--self:Disable();
		
		elseif ent.iFrames then
			ent:EmitSound("meleesounds/comboattack3.wav.mp3", 75, math.random( 90, 110 ));
			
			return;

		elseif(ent:IsWorld()) then
			self:Remove();

		end
	end
end

if CLIENT then
	function ENT:Draw()
		--self:DrawModel()
	end
end