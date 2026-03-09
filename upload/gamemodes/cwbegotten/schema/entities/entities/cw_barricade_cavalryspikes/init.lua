--[[
	Begotten III: Jesus Wept
	By: DETrooper, cash wednesday, gabs, alyousha35

	Other credits: kurozael, Alex Grist, Mr. Meow, zigbomb
--]]

include("shared.lua");

AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");

ENT.isspiky = true

ENT.vehicledamage = 0

-- Called when the entity initializes.
function ENT:Initialize()
	self:SetModel("models/begotten/battlements/smallstakes.mdl");
	self:SetMoveType(MOVETYPE_VPHYSICS);
	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetUseType(SIMPLE_USE);
	self:SetSolid(SOLID_VPHYSICS);
	self.BreakSounds = {"physics/wood/wood_strain2.wav", "physics/wood/wood_strain3.wav", "physics/wood/wood_strain4.wav"};
	
	local physicsObject = self:GetPhysicsObject();
	
	if (IsValid(physicsObject)) then
		physicsObject:Wake();
		physicsObject:EnableMotion(false);
	end;
end;

-- Called when the entity's transmit state should be updated.
function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS;
end;

function ENT:Touch(ent)
	if ent.MasterEntity then
		
		return
	end
	--PrintTable(ent:GetTable())
	if !ent.lasthurtbyspikes then ent.lasthurtbyspikes = CurTime()+1; end
	if ent.lasthurtbyspikes > CurTime() then return; end
	ent.lasthurtbyspikes = CurTime()+1;
	local spikesspot = self:GetAttachment(self:LookupAttachment("tips")).Pos
	if (spikesspot:Distance(ent:EyePos()) > 70) and !ent.LVS then return end
	-- Push the entity away
	local direction = (ent:GetPos() - self:GetPos()):GetNormalized() -- Direction away from the entity
	local pushVelocity = direction * 900
	local speed = ent:GetVelocity():Length();
	local dmgInfo2 = DamageInfo()
	dmgInfo2:SetDamageType(4)
	dmgInfo2:SetInflictor(self)
	dmgInfo2:SetAttacker(self)
	ent:EmitSound("physics/wood/wood_box_impact_hard"..math.random(4,6)..".wav");
	if ent.LVS and ent.LVS == true then
		--dmgInfo2:SetDamage(speed/(ent.weightclass))
		dmgInfo2:SetDamage(0)
	else
		dmgInfo2:SetDamage(speed/7)
	end
	ent:TakeDamageInfo(dmgInfo2)

	pushVelocity.Z = 0
	-- Apply velocity to the player
	if ent:OnGround() then
		ent:SetVelocity(pushVelocity)
	end
end

function ENT:OnTakeDamage(damageInfo)
	local player = damageInfo:GetAttacker();
	if IsValid(player) and damageInfo:GetDamageType() == 128 then
		self.vehicledamage = self.vehicledamage + damageInfo:GetDamage();
		if self.vehicledamage >= 500 then
			Clockwork.chatBox:AddInTargetRadius(player, "it", "The barricade finally gives way and breaks into several pieces!", player:GetPos(), config.Get("talk_radius"):Get() * 2);
			self:EmitSound("physics/wood/wood_plank_break3.wav");
			self:Remove();
		end
	end
	
	if IsValid(player) and player:IsPlayer() then
		if !self.strikesRequired then
			self.strikesRequired = 30;
		end
		
		if damageInfo:GetDamage() >= 15 then
			self:EmitSound(self.BreakSounds[math.random(1, #self.BreakSounds)]);
			
			self.strikesRequired = self.strikesRequired - 1;
			
			if self.strikesRequired <= 0 then
				Clockwork.chatBox:AddInTargetRadius(player, "it", "The barricade finally gives way and breaks into several pieces!", player:GetPos(), config.Get("talk_radius"):Get() * 2);
				self:EmitSound("physics/wood/wood_plank_break3.wav");
				self:Remove();
			end
		end
	end
end

function ENT:OnRemove()

end