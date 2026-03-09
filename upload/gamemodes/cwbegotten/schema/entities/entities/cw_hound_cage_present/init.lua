--[[
	Begotten III: Jesus Wept
	By: DETrooper, cash wednesday, gabs, alyousha35

	Other credits: kurozael, Alex Grist, Mr. Meow, zigbomb
--]]

include("shared.lua");

AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");

-- Called when the entity initializes.
function ENT:Initialize()
	self:SetModel("models/twistmas/present/type-1/big/present"..math.random(2, 3)..".mdl");
	self:SetAngles(self:GetAngles() + Angle(0, 0, 90))
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)

	local physicsObject = self:GetPhysicsObject();
	
	if (IsValid(physicsObject)) then
		physicsObject:Wake();
		physicsObject:EnableMotion(false);
	end;

	--self:DoSolidCheck();
	self.isplayingsound = self:StartLoopingSound( "fiend/cagehound.wav" )
end;

-- Called when the entity's transmit state should be updated.
function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS;
end;

-- This is to prevent players from being launched into orbit when the entity becomes solid.
function ENT:DoSolidCheck()
	timer.Simple(1, function()
		if IsValid(self) then
			for i, v in ipairs(ents.FindInSphere(self:GetPos(), 32)) do
				if v:IsPlayer() then
					self:DoSolidCheck();
					
					return;
				end
			end

			self:SetCollisionGroup(COLLISION_GROUP_NONE);
		end
	end);
end

function ENT:OnTakeDamage(damageInfo)
	local player = damageInfo:GetAttacker();
	
	self:SetCollisionGroup( 20 )
	local entity = ents.Create("npc_animal_leopard");

	self:EmitSound("fiend/chainsnap.wav")
	self:EmitSound("fiend/presentunwrap.wav")

	if IsValid(entity) then
		entity:Spawn();
		entity:SetHealth(300);
		entity:Activate(); 
		entity:AddEntityRelationship(player, D_LI, 99);
		entity.XPValue = 200;

		local mins = entity:OBBMins() -- Minimum bounds
		local maxs = entity:OBBMaxs() -- Maximum bounds
		local size = maxs - mins   -- The size of the entity's bounding box
		local height = size.z      -- Height of the entity

		entity:SetPos(self:GetPos() + Vector(0, 0, height));
		
		local playerFaith = player:GetFaction();
		entity.summonedFaith = playerFaith;
		
		for _, v in _player.Iterator() do
			if v:GetFaction() == playerFaith then
				entity:AddEntityRelationship(v, D_LI, 99);
			end
		end
		self:Remove()
	end
end

function ENT:OnRemove()
	if self.isplayingsound then
		self:StopLoopingSound(self.isplayingsound)
	end
end

function ENT:Touch(entity)
	if !self.nextbarksound then self.nextbarksound = 0 end
	if self.nextbarksound and self.nextbarksound < CurTime() then return end

end;