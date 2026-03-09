
//! ADD FOR bg_prelude
local coordinates = {
    ["rp_begotten3"] = {
            -- shrine
            Vector(-2825, -9019, -6515),
            -- manor
            Vector(-821, -9007, -6410),
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

function ENT:Think()
    if !self.scream or !self.scream:IsPlaying() then
        self.scream = CreateSound(self, "warcries/twistedwarcry"..math.random(1, 5)..".mp3")
        self.scream:Play()
        self.scream:ChangeVolume(1, 0)

    else
        self.scream:Play()
        self.scream:ChangeVolume(1, 0)

    end

end