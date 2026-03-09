
Clockwork.kernel:IncludePrefixed("shared.lua")

local function ShadowText(text, font, x, y, colortext, colorshadow, dist, xalign, yalign)
    draw.SimpleText(text, font, x + dist, y + dist, colorshadow, xalign, yalign)
    draw.SimpleText(text, font, x, y, colortext, xalign, yalign)
end
surface.CreateFont("farm3D2DSmall", {font = "Arial", size = 34})

local function firstUpper(str)
    return string.SetChar(str, 1, string.upper(str[1]))
end

function ENT:Initialize()
    self.alpha = 0
end

function ENT:Draw()
    self:DrawModel()

    if LocalPlayer():GetEyeTrace().HitPos:Distance(self:GetPos()) < 10 then --Fade in the hud, using hitpos instead of entity since the entity will be the planter
        if self.alpha < 255 then self.alpha = self.alpha + 2 end
    else --Fade out the hud
        if self.alpha > 0 then self.alpha = self.alpha - 2 end
    end

    if self.alpha == 0 then return end --Don't bother drawing it at all

    local eyeAng = EyeAngles()
    eyeAng.p = 0
    eyeAng.y = eyeAng.y - 90
    eyeAng.r = 90

    local h = 35
    local w = 250

    cam.Start3D2D(self:GetPos() + Vector(0, 0, 10), eyeAng, 0.05)
        surface.SetDrawColor(0, 0, 0, self.alpha/2)
        surface.DrawRect(-(w + 8)/2, -4, w + 8, h + 8)
        surface.SetDrawColor(39, 225, 46, self.alpha/10)
        surface.DrawRect(-w/2, 0, w * (self:GetNWInt("growth", 0)/100), h)

        ShadowText(firstUpper(self:GetNWString("plantName", "plant")), "farm3D2DSmall", 0, h/2, Color(239, 159, 20, self.alpha), Color(16, 50, 15, self.alpha), 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        if self:GetNWBool("idealLight") then 
            ShadowText("G", "farm3D2DSmall", -w/2 + 5, h/2, Color(50, 255, 90, self.alpha), Color(70, 50, 40, self.alpha), 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end
    cam.End3D2D()
end