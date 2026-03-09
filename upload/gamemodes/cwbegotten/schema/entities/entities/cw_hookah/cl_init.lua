include("shared.lua");

-- Called when the target ID HUD should be painted.
function ENT:HUDPaintTargetID(x, y, alpha)
	local colorTargetID = Clockwork.option:GetColor("target_id")
	local colorWhite = Clockwork.option:GetColor("white")
	
	y = Clockwork.kernel:DrawInfo("Communal Hookah", x, y, colorTargetID, alpha)
	y = Clockwork.kernel:DrawInfo("A hookah, its design hailing from the Darklands.", x, y, colorWhite, alpha);
end;

local function CreateMenu(state)
	--why
	--[[
	if (IsValid(menu)) then
		menu:Remove();
	end;]]
	
	local scrW = ScrW();
	local scrH = ScrH();
	local menu = DermaMenu();
		
	menu:SetMinimumWidth(150);
	
	if state ~= "Gore" then
		menu:AddOption("Purchase A Puff", function() Clockwork.kernel:RunCommand("HookahPuff") end);
		menu:AddOption("Purchase A Wicked Puff", function() Clockwork.kernel:RunCommand("HookahPuff", "true") end);
	end

	if Clockwork.Client:IsAdmin() and !Clockwork.Client:GetSharedVar("ritalin", false) then
		local subMenu = menu:AddSubMenu("(ADMIN) Coin Collected");
		
		subMenu:AddOption("Check", function() Clockwork.Client:ConCommand("cw_HookahCoin") end);
		subMenu:AddOption("Collect", function()
			Derma_StringRequest("Hookah", "How much coin would you collect from the Communal Hookah?", nil, function(text)
				Clockwork.kernel:RunCommand("HookahCollect", text);
			end)
		end);
	end
	
	menu:Open();
	menu:SetPos(scrW / 2 - (menu:GetWide() / 2), scrH / 2 - (menu:GetTall() / 2));
end

Clockwork.datastream:Hook("OpenHookahMenu", function(state)
	CreateMenu(state);
end);
