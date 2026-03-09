include("shared.lua")
include( "sh_weapons.lua" )
include( "cl_effects.lua" )
include( "cl_hud.lua" )
include( "cl_seatswitcher.lua" )
include( "cl_trailsystem.lua" )
include( "cl_boneposeparemeter.lua" )

local Zoom = 0

local bigTextFont = Clockwork.option:GetFont("menu_text_big");
local tinyTextFont = Clockwork.option:GetFont("menu_text_tiny");

local function RandomizeCase(text)
    local fuckedText = "";

    for i = 1, #text do
        local subText = string.sub(text, i, i);

        fuckedText = fuckedText..(math.random(1,2) == 1 and string.upper(subText) or string.lower(subText));

    end

    return fuckedText

end

local redLow = Color(175,0,0,30);
local redHigh = Color(255,0,0,30);
local redHighBright = Color(255,0,0,255);
local whiteLow = Color(175,175,175);
local whiteHigh = Color(255,255,255);

local alphatable = {
	[1] = 255,
	[3] = 40,
	[4] = 10,
}

local alphatable = {
	[1] = 255,
	[3] = 40,
}

local alphatable2 = {
	[1] = 30,
	[3] = 10,
}

function ENT:HUDPaintTargetID(x, y, alpha)
	local description = self:GetNWString("lvsdesc");
	local spot =LocalPlayer():GetPos()
	local distance = spot:Distance(self:GetPos())
	local newalpha = 0
	local newalpha2 = 0

	--y = Clockwork.kernel:DrawInfo(description, x, y, Clockwork.option:GetColor("white"), alpha);
	if CW_CONVAR_SHOWSTYLIZEDVEHICLENAMES:GetInt() == 1 then
		if distance < 400 then
			for i = 1, math.random(1,5) do
				local rcolor = math.random(1,2)
				local ccolor = nil

				if distance < 200 then
					newalpha = alphatable[1]
					newalpha2 = alphatable2[1]
				elseif distance < 300 then
					newalpha = alphatable[3]
					newalpha2 = alphatable2[3]
				end

				if rcolor == 1 then
					ccolor = redLow
				else
					ccolor = redHigh
				end

				redHighBright.a = newalpha
				redLow.a = newalpha2
				redHigh.a = newalpha2

				surface.DrawRotatedTextCentered(RandomizeCase(description), tinyTextFont, x + math.random(-10,10), y + math.random(-10,10), math.random(-3, 3), ccolor);
				surface.DrawRotatedTextCentered(description, tinyTextFont, x, y, 0, redHighBright);

			end
		end
	else
		if distance < 400 then
			y = Clockwork.kernel:DrawInfo(description, x, y, red and redHigh or whiteHigh, alpha)
		end
	end

end;

function ENT:LVSCalcFov( fov, ply )

	local TargetZoom = ply:lvsKeyDown( "ZOOM" ) and 0 or 1

	Zoom = Zoom + (TargetZoom - Zoom) * RealFrameTime() * 10

	local newfov = fov * Zoom + (self.ZoomFov or 40) * (1 - Zoom)

	return newfov
end

function ENT:LVSCalcView( ply, pos, angles, fov, pod )
	return LVS:CalcView( self, ply, pos, angles, fov, pod )
end

function ENT:PreDraw()
	return true
end

function ENT:PreDrawTranslucent()
	return true
end

function ENT:PostDraw()
end

function ENT:PostDrawTranslucent()
end

function ENT:Draw( flags )
	if self:PreDraw() then
		if self.lvsLegacyDraw then
			self:DrawModel() -- ugly, but required in order to fix old addons. Refract wont work on these.
		else
			self:DrawModel( flags )
		end
	end

	self:PostDraw()
end

function ENT:DrawTranslucent( flags )
	self:DrawTrail()

	if self:PreDrawTranslucent() then
		self:DrawModel( flags )
	else
		self.lvsLegacyDraw = true -- insert puke simley
	end

	self:PostDrawTranslucent()
end

function ENT:Initialize()
	self:OnSpawn()

	if not istable( self.GibModels ) then return end

	for _, modelName in ipairs( self.GibModels ) do
		util.PrecacheModel( modelName )
	end
end

function ENT:OnSpawn()
end

function ENT:OnFrameActive()
end

function ENT:OnFrame()
end

function ENT:OnEngineActiveChanged( Active )
end

function ENT:OnActiveChanged( Active )
end

ENT._oldActive = false
ENT._oldEnActive = false

function ENT:HandleActive()
	local EntTable = self:GetTable()

	local Active = self:GetActive()
	local EngineActive = self:GetEngineActive()
	local ActiveChanged = false

	if EntTable._oldActive ~= Active then
		EntTable._oldActive = Active
		EntTable:OnActiveChanged( Active )
		ActiveChanged = true
	end

	if EntTable._oldEnActive ~= EngineActive then
		EntTable._oldEnActive = EngineActive
		self:OnEngineActiveChanged( EngineActive )
		ActiveChanged = true
	end

	if ActiveChanged then
		if Active or EngineActive then
			self:StartWindSounds()
		else
			self:StopWindSounds()
		end
	end

	if Active or EngineActive then
		self:DoVehicleFX()
	end

	self:FlyByThink()

	return EngineActive
end

function ENT:Think()
	if not self:IsInitialized() then return end
 
	if self:HandleActive() then
		self:OnFrameActive()
	end

	self:HandleTrail()
	self:OnFrame()
end

function ENT:OnRemove()
	self:StopEmitter()
	self:StopWindSounds()
	self:StopFlyBy()
	self:StopDeathSound()

	self:OnRemoved()
end

function ENT:OnRemoved()
end

function ENT:CalcDoppler( Ent )
	if not IsValid( Ent ) then return 1 end

	if Ent:IsPlayer() then
		local ViewEnt = Ent:GetViewEntity()
		local Vehicle = Ent:lvsGetVehicle()

		if IsValid( Vehicle ) then
			if Ent == ViewEnt then
				Ent = Vehicle
			end
		else
			if IsValid( ViewEnt ) then
				Ent = ViewEnt
			end
		end
	end

	local sVel = self:GetVelocity()
	local oVel = Ent:GetVelocity()

	local SubVel = oVel - sVel
	local SubPos = self:GetPos() - Ent:GetPos()

	local DirPos = SubPos:GetNormalized()
	local DirVel = SubVel:GetNormalized()

	local A = math.acos( math.Clamp( DirVel:Dot( DirPos ) ,-1,1) )

	return (1 + math.cos( A ) * SubVel:Length() / 13503.9)
end

function ENT:GetCrosshairFilterEnts()
	if not self:IsInitialized() then return { self } end -- wait for the server to be ready

	if not istable( self.CrosshairFilterEnts ) then
		self.CrosshairFilterEnts = {self}

		-- lets ask the server to build the filter for us because it has access to constraint.GetAllConstrainedEntities() 
		net.Start( "lvs_player_request_filter" )
			net.WriteEntity( self )
		net.SendToServer()
	end

	return self.CrosshairFilterEnts
end

function ENT:FlyByThink()
end

function ENT:StopFlyBy()
end

function ENT:StopDeathSound()
end

function ENT:OnDestroyed()
end

net.Receive( "lvs_vehicle_destroy", function( len )
	local ent = net.ReadEntity()

	if not IsValid( ent ) or not isfunction( ent.OnDestroyed ) then return end

	ent:OnDestroyed()
end )
