--[[
	Begotten III: Jesus Wept
	By: DETrooper, cash wednesday, gabs, alyousha35

	Other credits: kurozael, Alex Grist, Mr. Meow, zigbomb
--]]

Clockwork.kernel:IncludePrefixed("shared.lua")

-- Called when the target ID HUD should be painted.
function ENT:HUDPaintTargetID(x, y, alpha)
	local name = self:GetNWString("name");
	
	if !name or name:len() == 0 then
		y = Clockwork.kernel:DrawInfo("A large and formidable Goreic warship.", x, y, Clockwork.option:GetColor("white"), alpha);
	else
		y = Clockwork.kernel:DrawInfo("A large and formidable Goreic warship. The name '"..name.."' is chiselled onto its side in Goreic script.", x, y, Clockwork.option:GetColor("white"), alpha);
	end
end;

ENT.toggleswitch = false
ENT.toggleswitchr2 = false
ENT.togglebob = false
ENT.maxpitch = 4
ENT.maxbob = 1
ENT.maxroll = 1
ENT.pitchspeed = 0.003
ENT.yawspeed = 0.001
ENT.rollspeed = 0.001

function ENT:Draw()
	local ang = self:GetAngles()
	local pos = self:GetPos()
	if self.toggleswitch == false then
		ang.p = math.Approach( ang.p, self.maxpitch , self.pitchspeed )
		if ang.p == self.maxpitch then
			self.toggleswitch = true
		end
	elseif self.toggleswitch == true then
		ang.p = math.Approach( ang.p, -self.maxpitch , self.pitchspeed )
		if ang.p == -self.maxpitch then
			self.toggleswitch = false
		end
	end

	if self.togglebob == false then
		pos.z = math.Approach( pos.z, self.maxbob , self.yawspeed )
		if pos.z == self.maxbob then
			self.togglebob = true
		end
	elseif self.togglebobr == true then
		pos.z = math.Approach( pos.z, -self.maxbob , self.yawspeed )
		if pos.z == -self.maxbobw then
			self.togglebob = false
		end
	end

	if self.toggleswitchr2 == false then
		ang.r = math.Approach( ang.r, self.maxroll , self.rollspeed )
		if ang.r == self.maxroll then
			self.toggleswitchr2 = true
			--[[for i = 1, 10 do
				local vPoint = Vector( self:GetPos()+(self:GetRight()*380)+Vector(math.random(-30, 30), math.random(-30, 30), 30) )
				local effectdata = EffectData()
				effectdata:SetOrigin( vPoint )
				effectdata:SetScale(6)
				util.Effect( "watersplash", effectdata, true )
			end]]
		end
	elseif self.toggleswitchr2 == true then
		ang.r = math.Approach( ang.r, -self.maxroll , self.rollspeed )
		if ang.r == -self.maxroll then
			self.toggleswitchr2 = false
			--[[for i = 1, 10 do
				local vPoint = Vector( self:GetPos()+(self:GetRight()*380)+Vector(math.random(-50, 30), math.random(-50, 30), 30) )
				local effectdata = EffectData()
				effectdata:SetOrigin( vPoint )
				effectdata:SetScale(6)
				util.Effect( "watersplash", effectdata, true )
			end]]
		end
	end

	
	
	ang.y = ang.y 
	--ang.r = ang.r 
	self:SetAngles( ang )
	self:SetPos( pos )
	self:DrawModel()
end
