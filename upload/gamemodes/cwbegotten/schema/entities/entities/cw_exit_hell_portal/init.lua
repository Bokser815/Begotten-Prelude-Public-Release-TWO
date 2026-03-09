
//! ADD FOR bg_prelude
local coordinates = {
    ["rp_begotten3"] = {
            -- mines
            Vector(-2457.815918, -242.342850, -2540.064941),
            -- powerplant
            Vector(7656.471680, -2908.887207, -1078.440063),
    },
    ["rp_begotten_prelude"] = {

    },
}

local spawnpoint;
local map = game.GetMap();

function ENT:Initialize()
	self:SetModel("models/props_c17/canister_propane01a.mdl");
	self:SetMoveType(MOVETYPE_VPHYSICS);
	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetUseType(SIMPLE_USE);
	self:SetSolid(SOLID_VPHYSICS);
	self:SetRenderMode(RENDERMODE_TRANSCOLOR);
	self:DrawShadow(false);
	
	local physicsObject = self:GetPhysicsObject();
	
	if (IsValid(physicsObject)) then
		physicsObject:Wake();
		physicsObject:EnableMotion(false);
	end;

    if coordinates[map] then
        local random = math.random(1, #coordinates[map]);
        spawnpoint = coordinates[map][random];
    end
end;

-- Called when the entity's transmit state should be updated.
function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS;
end;

function ENT:StartTouch(entity)
    if entity:IsPlayer() and entity:Alive() then
        entity:SetCollisionGroup(COLLISION_GROUP_WEAPON);
        entity:SetPos(spawnpoint);

        timer.Simple(2, function()
            if entity:Alive() then
                entity:SetCollisionGroup(COLLISION_GROUP_PLAYER);
            end
        end)
    end
end;