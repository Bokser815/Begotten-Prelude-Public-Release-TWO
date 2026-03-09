
Clockwork.kernel:IncludePrefixed("shared.lua")
local crops = {"agave", "maize", "wheat", "fungus", "cotton", "tobacco"};

local function ShadowText(text, font, x, y, colortext, colorshadow, dist, xalign, yalign)
    draw.SimpleText(text, font, x + dist, y + dist, colorshadow, xalign, yalign)
    draw.SimpleText(text, font, x, y, colortext, xalign, yalign)
end
surface.CreateFont("farm3D2D", {font = "Arial", size = 72})
surface.CreateFont("farm3D2DMed", {font = "Arial", size = 42})

function ENT:Initialize()
    self.alpha = 0
end

function ENT:Draw()
    local fertilized = self:GetNWBool("fertilized")
    self:DrawModel()

    if LocalPlayer():GetEyeTrace().Entity == self then --Fade in the hud
        if self.alpha < 255 then self.alpha = self.alpha + 2 end
    else                                               --Fade out the hud
        if self.alpha > 0 then self.alpha = self.alpha - 2 end
    end

    if self.alpha == 0 then return end --Don't bother drawing it at all

    local eyeAng = EyeAngles()
    eyeAng.p = 0
    eyeAng.y = eyeAng.y - 90
    eyeAng.r = 90

    local h = 75
    local w = 1000

    cam.Start3D2D(self:GetPos() + Vector(0, 0, 50), eyeAng, 0.05)
        surface.SetDrawColor(0, 0, 0, self.alpha/2)
        surface.DrawRect(-(w + 8)/2, -4, w + 8, h + 8)
        surface.SetDrawColor(66, 134, 244, self.alpha)
        surface.DrawRect(-w/2, 0, w * (self:GetNWInt("water", 0)/maxWater), h)
        -- draw "Fertilized" here if its fertilized
        if fertilized then
            ShadowText("Fertilized", "farm3D2DMed", 0, h/2 + h, Color(255, 255, 255, self.alpha), Color(0, 255, 0, self.alpha), 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

        ShadowText("Water Remaining", "farm3D2D", 0, h/2, Color(255, 255, 255, self.alpha), Color(0, 0, 0, self.alpha), 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    cam.End3D2D()
end

local function CreateMenu(planter, slots)
	if (IsValid(menu)) then
		menu:Remove();
	end;
	local scrW = ScrW();
	local scrH = ScrH();
	local menu = DermaMenu();
	menu:SetMinimumWidth(150);
    local currentSeedAmount = planter:GetNWInt("seedAmount")

    menu:AddOption("Water", function() Clockwork.Client:ConCommand("cw_WaterPlanter") end);
    local plantSubMenu = menu:AddSubMenu("Plant");
    for _,v in pairs(crops) do
        
        if Clockwork.inventory:HasItemByID(Clockwork.inventory:GetClient(), "seed_" .. v) then
            local possibleSeedAmount = math.min(9 - currentSeedAmount, Clockwork.inventory:GetItemCountByID(Clockwork.inventory:GetClient(), "seed_" .. v))
            if possibleSeedAmount > 0 then
                local subMenu = plantSubMenu:AddSubMenu(v:gsub("^%l", string.upper));
                for q=1, possibleSeedAmount do
                    local plantAmtSubMenu = subMenu:AddOption(q, function() Clockwork.Client:ConCommand("cw_AddSeed " .. v ..  " " .. q) end);
                end
            end
        end
    end

    menu:AddOption("Fertilize", function() Clockwork.Client:ConCommand("cw_Fertilize") end);

    local plantSubMenu = menu:AddSubMenu("Remove Crop");
    if slots then
        for _,v in pairs(crops) do
            local cropTotal = 0
            
            for _, slot in pairs(slots) do
                if slot == v then
                    cropTotal = cropTotal + 1
                end
            end

            if cropTotal > 0 then
                local subMenu = plantSubMenu:AddSubMenu(v:gsub("^%l", string.upper));
                for q=1, cropTotal do
                    local plantAmtSubMenu = subMenu:AddOption(q, function() Clockwork.Client:ConCommand("cw_removeSeed " .. v ..  " " .. q) end);
                end
            end
            cropTotal = 0
        end
    end
   
    menu:AddOption("Harvest", function() Clockwork.Client:ConCommand("cw_Harvest") end);
    menu:AddOption("View Info", function() Clockwork.Client:ConCommand("cw_ViewInfo") end);
    --menu:AddOption("Destroy Crops", function() Clockwork.Client:ConCommand("cw_RemoveSeeds") end);
    menu:AddOption("Burn Crops", function() Clockwork.Client:ConCommand("cw_BurnCrops") end);

    
	if Clockwork.Client:IsAdmin() then
        local adminSubMenu = menu:AddSubMenu("(ADMIN) Menu");
        local subMenu = adminSubMenu:AddOption("Max Water", function() Clockwork.Client:ConCommand("cw_AdminWaterPlanter") end);
        local subMenu = adminSubMenu:AddOption("Quick Grow", function() Clockwork.Client:ConCommand("cw_AdminQuickGrow") end);
        local subMenu = adminSubMenu:AddOption("Random Plants", function() Clockwork.Client:ConCommand("cw_AdminRandomPlant") end);
        local subMenu = adminSubMenu:AddOption("Random All", function() Clockwork.Client:ConCommand("cw_AdminRandomAll") end);
        local subMenu = adminSubMenu:AddOption("Infinite Water", function() Clockwork.Client:ConCommand("cw_AdminInfWater") end);
        local subMenu = adminSubMenu:AddSubMenu("Max Plant");
        for _,v in pairs(crops) do
            local possibleSeedAmount = 9 - currentSeedAmount 
            local subsMenu = subMenu:AddOption(v:gsub("^%l", string.upper), function() cwFarming:AddSeed(planter, v, possibleSeedAmount, false, Clockwork.Client) end);
        end
        local subMenu = adminSubMenu:AddOption("Infect Toggle", function() Clockwork.Client:ConCommand("cw_InfectToggle") end);
        
	end
	
	menu:Open();
	menu:SetPos(scrW / 2 - (menu:GetWide() / 2), scrH / 2 - (menu:GetTall() / 2));
end

Clockwork.datastream:Hook("OpenPlanterMenu", function(data)
	CreateMenu(data[1], util.JSONToTable(data[2]))
end);
