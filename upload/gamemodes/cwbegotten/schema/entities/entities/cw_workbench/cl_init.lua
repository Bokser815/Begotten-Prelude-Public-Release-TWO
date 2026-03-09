include("shared.lua");

-- Called when the target ID HUD should be painted.
function ENT:HUDPaintTargetID(x, y, alpha)
	local colorTargetID = Clockwork.option:GetColor("target_id")
	local colorWhite = Clockwork.option:GetColor("white")
	
	y = Clockwork.kernel:DrawInfo("Alchemical Workbench", x, y, colorTargetID, alpha)
	y = Clockwork.kernel:DrawInfo("A wooden workbench partially covered in broken glass and stains of spilled liquids.", x, y, colorWhite, alpha);
end;

local function CreateMenu(state)
	if (IsValid(menu)) then
		menu:Remove();
	end;


    -- open alchemy workbench vgui here
end

Clockwork.datastream:Hook("OpenWorkbenchMenu", function(state)
	CreateMenu(state);
end);