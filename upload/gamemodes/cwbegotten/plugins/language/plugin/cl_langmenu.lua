if (IsValid(Clockwork.Client.cwLangMenu)) then
	Clockwork.Client.cwLangMenu:Close()
	Clockwork.Client.cwLangMenu:Remove()
	Clockwork.Client.cwLangMenu = nil;
end

local pentagram = Material("begotten/pentagram.png") -- NEW: Added pentagram texture
local matsafs = Material("begotten/ui/hoss.png")

surface.CreateFont( "lang_radial_large", {
	font = "Immortal",
	extended = false,
	size = Clockwork.kernel:FontScreenScale(12),
	weight = 900,

});

local PANEL = {}

function PANEL:Init()
	self:SetSize(500, 500)
	self:Center()
	self:SetTitle("")
	self:SetDraggable(false)
	self:MakePopup()

	self.Options = {}
	for v, _ in pairs(cwLanguage.validLanguages) do
		table.insert(self.Options, v)
	end
	self.Selected = nil

	self.PentagramRotation = 0

	Clockwork.Client:EmitSound("misc/tele2_fadeout2.wav", 25, 95)
	surface.PlaySound("begotten/ui/buttonclick.wav")

	self:Rebuild()
end


function PANEL:Rebuild()
	self.Paint = function(pnl, w, h)
		surface.SetMaterial(matsafs)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(0, 0, w, h)

		local cx, cy = w / 2, h / 2
		local baseRadius = math.min(w, h) / 2 - 100 

		local totalOptions = #self.Options
		local sectorAngle = 360 / totalOptions

		self.PentagramRotation = (self.PentagramRotation + FrameTime() * 40) % 360

		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(pentagram)
		surface.DrawTexturedRectRotated(cx, cy, 250, 250, self.PentagramRotation)

		local padding = 50
		for i = 1, totalOptions do
			local midAngle = math.rad((i - 1) * sectorAngle) -- radians
			local textRadius = baseRadius --min safe angle 	

			local x = cx + textRadius * math.cos(midAngle)
			local y = cy + textRadius * math.sin(midAngle)

			x = math.Clamp(x, padding, w - padding)
			y = math.Clamp(y, padding, h - padding)

			local color = (self.Selected == i) and Color(200, 100, 100, 255) or Color(100, 100, 100, 255)
			draw.SimpleText(self.Options[i], "lang_radial_large", x, y, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end

	self.Think = function(pnl)
		local mx, my = gui.MousePos()
		local px, py = self:LocalToScreen(0, 0)
		local x = mx - px
		local y = my - py

		local cx, cy = self:GetWide() / 2, self:GetTall() / 2
		local dx = x - cx
		local dy = y - cy

		local distance = math.sqrt(dx^2 + dy^2)	
		local angle = math.deg(math.atan2(dy, dx))
		if angle < 0 then angle = angle + 360 end

		local totalOptions = #self.Options
		local sectorAngle = 360 / totalOptions

		if distance >= 80 and distance <= 280 then
			self.Selected = math.floor(angle / sectorAngle) + 1
		else
			self.Selected = nil
		end
	end

	self.OnMousePressed = function(pnl, key)
		if key == MOUSE_LEFT then
			local lang = self.Options[self.Selected]
			if lang then
				RunConsoleCommand("cwsay", "/lang "..lang)
				self:Close()
				self:Remove()
				Clockwork.Client.cwLangMenu = nil
			end
		end
	end

	self.CreateSectorPoly = function(pnl, cx, cy, radius, startAngle, endAngle, segs)
		local poly = {}
		table.insert(poly, { x = cx, y = cy })  
		local step = (endAngle - startAngle) / segs
		for i = 0, segs do
			local a = math.rad(startAngle + i * step)
			table.insert(poly, { x = cx + radius * math.cos(a), y = cy + radius * math.sin(a) })
		end
		return poly
	end
end

vgui.Register("cwLangMenu", PANEL, "DFrame")

concommand.Add("cw_open_language_menu", function()
	local langMenu = vgui.Create("cwLangMenu")
	Clockwork.Client.cwLangMenu = langMenu
end)