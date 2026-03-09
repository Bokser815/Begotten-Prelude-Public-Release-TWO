include('shared.lua')
 


local function dmsg(msg)
	Entity(1):PrintMessage(3, tostring(msg))
end

local function vecMod(pos, ang, modVector)
   return pos + ang:Forward()*modVector.x + ang:Right()*modVector.y + ang:Up()*modVector.z
end

local function angMod(ang, modAngle)
	local newAng = ang

	newAng:RotateAroundAxis(ang:Forward(), modAngle.x)
	newAng:RotateAroundAxis(ang:Right(), modAngle.y)
	newAng:RotateAroundAxis(ang:Up(), modAngle.z)

	return newAng
end


net.Receive("DChopper_HookM60Render", function()
   local entID = net.ReadInt(16)
   local copterID = net.ReadInt(16)
   

   --In multiplayer, we need to give it a second before we can render the MGs 
   timer.Simple(1, function()
      local ent = Entity(entID)
      local copter = Entity(copterID)

      if !IsValid(ent) || !IsValid(copter) then return end

      -- LocalPlayer():PrintMessage(3, "would hook for "..tostring(ent).." for "..tostring(copter) )

      table.insert(copter.gunners, ent)
   end)
   
end)



net.Receive("DChopper_SoundPitch", function()
   local ent = net.ReadEntity()
   local fast = net.ReadBit()
   
   if ent.destruction.engine then return false end
   if fast == 1 && !ent.soundpitchfast then
      ent.soundpitchfast = true
      ent.sound_close:ChangePitch(122,2)
      ent.sound_mid:ChangePitch(122,2)
      ent.sound_far:ChangePitch(122,2)
   elseif fast == 0 && ent.soundpitchfast then
      ent.soundpitchfast = false
      ent.sound_close:ChangePitch(100,2)
      ent.sound_mid:ChangePitch(100,2)
      ent.sound_far:ChangePitch(100,2)
   end

end)


net.Receive("DChopper_Destruction", function()
   local ent = net.ReadEntity()
   local damage_level = net.ReadInt(8)
   local broken_part = net.ReadString()
   -- LocalPlayer():PrintMessage(3, "MESSAGE RECIEVED "..tostring(ent).." lost it's "..tostring(broken_part)..". Blade damage at "..damage_level )

   ent.damage_level = damage_level

   if broken_part == "tail" then
      ent.destruction.tail = true

   elseif broken_part == "tail_rotor" then
      ent.destruction.tail_rotor = true

   elseif broken_part == "rotor" then
      ent.destruction.rotor = true
      ent.sound_far:Stop()
      ent.sound_mid:Stop()
      ent.sound_close:Stop()
   elseif broken_part == "engine" then
      ent.destruction.engine = true

         if !IsValid(ent) then return end
         ent.sound_close:ChangePitch(0,3)
         ent.sound_mid:ChangePitch(0,3)
         ent.sound_far:ChangePitch(0,3)

   elseif broken_part == "explode" then



      CreateParticleSystem(ent, "explosion_huge_burning_chunks", 4, 0)
      CreateParticleSystem(ent, "explosion_huge_f", 4, 0)
      CreateParticleSystem(ent, "explosion_huge_h", 4, 0)
      CreateParticleSystem(ent, "explosion_huge_j", 4, 0)
      CreateParticleSystem(ent, "explosion_huge_k", 4, 0)
   end

end)


function ENT:Initialize()
   self.gunners = {}
   self.destruction = {}
   self.damage_level = 0

   PrecacheParticleSystem("explosion_huge_burning_chunks")
   PrecacheParticleSystem("explosion_huge_f")
   PrecacheParticleSystem("explosion_huge_h")
   PrecacheParticleSystem("explosion_huge_j")
   PrecacheParticleSystem("explosion_huge_k")



   self.sound_close = CreateSound(self, "uh1d/rotor_close.wav")
	self.sound_close:SetSoundLevel(125)
	self.sound_close:Play()

   self.sound_mid = CreateSound(self, "uh1d/rotor_mid.wav")
	self.sound_mid:SetSoundLevel(125)
	self.sound_mid:Play()

   self.sound_far = CreateSound(self, "uh1d/rotor_far.wav")
   self.sound_far:SetSoundLevel(125)
	self.sound_far:Play()
end

function ENT:Think()
   if self.destruction.rotor then return false end
   self:NextThink(CurTime())
   
   local d = LocalPlayer():GetPos():Distance(self:GetPos())
   
   local closeDistance = 90
   local mediumDistance = 1300
   local farDistance = 2200

   if !self.nextpilotcheck then self.nextpilotcheck = 0 end
   if self.nextpilotcheck<CurTime() and (!self.pilot1 or !self.pilot2) then
      local check1 = self:GetNWEntity("pilot1", nil)
      local check2 = self:GetNWEntity("pilot2", nil)
      
      if IsValid(check1) and !self.pilot1 then
         self.pilot1 = check1
      end
      if IsValid(check2) and !self.pilot2 then
         self.pilot2 = check2
      end
      self.nextpilotcheck = CurTime()+3
   end


   -- Calculate close sound volume
   local closeVolume = 0
   if d < closeDistance then
       closeVolume = 1
   elseif d < mediumDistance then
       closeVolume = 1 - (d - closeDistance) / (mediumDistance - closeDistance)
   end
   self.sound_close:ChangeVolume(math.Clamp(closeVolume, 0, 1))

   -- Calculate medium sound volume
   local mediumVolume = 0
   if d >= closeDistance and d < mediumDistance then
       mediumVolume = (d - closeDistance) / (mediumDistance - closeDistance)
   elseif d < farDistance then
       mediumVolume = 1 - (d - mediumDistance) / (farDistance - mediumDistance)
   end
   self.sound_mid:ChangeVolume(math.Clamp(mediumVolume, 0, 1))

   -- Calculate far sound volume
   local farVolume = 0
   if d >= mediumDistance then
       farVolume = (d - mediumDistance) / (farDistance - mediumDistance)
   end
   self.sound_far:ChangeVolume(math.Clamp(farVolume, 0, 0.67))








   return true
end



local glowMaterial = Material("sprites/glow04_noz");

function ENT:OnRemove()
   self.sound_far:Stop()
   self.sound_mid:Stop()
   self.sound_close:Stop()
end


function ENT:Draw()

   -- Clip the tail for destruction effects


   
   if self.destruction.tail then
      
      
      
      local ClipDepth = 0
      local pos = self:GetPos()+self:GetAngles():Forward()*-132
      local normal = self:GetAngles():Forward()*1
      local distance = normal:Dot(pos)
      
      render.EnableClipping(true)
      
      render.PushCustomClipPlane(normal, distance)
      render.SetShadowsDisabled( true )
      self:DrawModel()

      render.PopCustomClipPlane()	

      render.EnableClipping(false)


   else
      
      self:DrawModel()

   end






   --GUNNER RENDERING

   for i=1,#self.gunners do
      local ent = self.gunners[i]

      local bName
      if IsValid(ent) then
         bName = ent:LookupBone("ValveBiped.Bip01_R_Hand")
      end

      if IsValid(ent) && bName && ent:Health() > 0 then
         
         local bPos, bAng = ent:GetBonePosition(bName)

         render.Model({
            model = "models/weapons/w_shot_enforcer.mdl",
            pos = vecMod(bPos, bAng, Vector(4,0,0)),
            angle = angMod(bAng, Angle(180,12,0))
         })
      else
         table.remove(self.gunners, i)
      end
   end  
   if IsValid(self.pilot1) then
      local ent = self.pilot1

      local bName
      if IsValid(ent) then
         bName = ent:LookupBone("ValveBiped.Bip01_Spine4")
      end
      if IsValid(ent) && bName && ent:Health() > 0 then
         local bPos, bAng = ent:GetBonePosition(bName)

         local glowColor = Color(255, 0, 0, 255);
         render.SetColorMaterialIgnoreZ()
         render.SetMaterial(glowMaterial);
         render.DrawSprite(bPos, 64, 64, glowColor);
      end

   end


   -- BLADE RENDERING
   local rps = self:GetNWInt("HueyRPS")



   local rAngle = self:GetAngles()


   local tAngle = self:GetAngles()
   tAngle:RotateAroundAxis(self:GetAngles():Up(), 180)




   -- At a = curtime we get 1 rotation every 360 seconds






   local a = math.fmod(CurTime(), 360) * (360*rps)

   rAngle:RotateAroundAxis(self:GetAngles():Up(), a)

   --Use this for blade damage factor
   if !self.destruction.engine then
      local damageFactor = self.damage_level
      rAngle:RotateAroundAxis(self:GetAngles():Forward(), math.random(-damageFactor,damageFactor))
   end
   
   tAngle:RotateAroundAxis(self:GetAngles():Right(), -a)

   if !self.destruction.rotor then
      --Main Blade
      render.Model({
         model = "models/sentry/uh-1d_tr.mdl",
         pos = vecMod(self:GetPos(), self:GetAngles(), Vector(-22,0,149)),
         angle = rAngle
      })
   

   end

   if !self.destruction.tail && !self.destruction.rotor && !self.destruction.tail_rotor then

      --Tail Rotor
      render.Model({
         model = "models/sentry/uh-1d_rr.mdl",
         pos = vecMod(self:GetPos(), self:GetAngles(), Vector(-369,17,126.5)),
         angle = tAngle
      })
   end





   
end