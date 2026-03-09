Clockwork.kernel:IncludePrefixed("shared.lua")

-- Called when the target ID HUD should be painted.
function ENT:HUDPaintTargetID(x, y, alpha)
	local colorWhite = Clockwork.option:GetColor("white");

	y = Clockwork.kernel:DrawInfo("A rift emanating screams of the damned.", x, y, colorWhite, alpha);
end;

-- Called when the entity should draw.
function ENT:Draw()
	self:DrawModel();
end;