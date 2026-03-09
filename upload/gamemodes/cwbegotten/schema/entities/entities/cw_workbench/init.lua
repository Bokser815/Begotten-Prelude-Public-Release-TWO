include("shared.lua");

AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");

-- Called when the entity initializes.
function ENT:Initialize()
	self:SetModel("models/props_c17/FurnitureTable002a.mdl");
	self:SetMoveType(MOVETYPE_VPHYSICS);
	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetUseType(SIMPLE_USE);
	self:SetSolid(SOLID_VPHYSICS);

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

function ENT:Use(activator, caller)
	if IsValid(caller) and caller:IsPlayer() then
		local isAlchemist = caller:HasBelief("alchemist");

        if isAlchemist then
            local state = true;
            Clockwork.datastream:Start(caller, "OpenWorkbenchMenu", state);
        else
            Schema:EasyText(caller, "chocolate", "You do not have the 'Alchemist' trait!");
            return false;
        end
	end;
end;