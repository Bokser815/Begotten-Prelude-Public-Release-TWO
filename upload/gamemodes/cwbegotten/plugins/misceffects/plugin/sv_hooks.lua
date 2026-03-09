local playerMeta = FindMetaTable("Player")

function playerMeta:WiggleRagdoll(time, interval)
	time = time or 5
	interval = interval or 0.05

	local ragdoll = self:GetRagdollEntity()
	local physObj = ragdoll:GetPhysicsObject()
	if(!IsValid(ragdoll) or !IsValid(physObj)) then return end

	local velocity = physObj:GetVelocity()
	physObj:SetVelocity(velocity + Vector(math.random(-3, 3), math.random(-3, 3), math.random(-3, 3)))

	local entIndex = self:EntIndex()
	timer.Create("WiggleRagdoll"..entIndex, interval, time/interval, function()
		if(!IsValid(ragdoll) or !IsValid(physObj) or IsValid(ragdoll.cwHoldingGrab)) then timer.Remove("WiggleRagdoll"..entIndex) return end

		local velocity = physObj:GetVelocity()
		physObj:SetVelocity(velocity + Vector(math.random(-1, 1) * 150, math.random(-1, 1) * 150, math.random(-1, 1) * 150))

	end)

end

local entityMeta = FindMetaTable("Entity")

local dissolveSounds = {
	"ambient/energy/spark5.wav",
	"ambient/energy/spark6.wav",
	"ambient/energy/zap1.wav",
	"ambient/energy/zap2.wav",
	"ambient/energy/zap3.wav",

}

function entityMeta:Dissolve(dissolveType, magnitude, attacker)
	dissolveType = dissolveType or 0
	magnitude = magnitude or 0

	local dissolver = ents.Create("env_entity_dissolver")

	timer.Simple(5, function()
		if(!IsValid(dissolver)) then return end

		dissolver:Remove()
	
	end)

	local entIndex = self:EntIndex()

	dissolver.Target = "Clockwork.Dissolve."..entIndex
	dissolver:SetKeyValue("dissolvetype", dissolveType)
	dissolver:SetKeyValue("magnitude", magnitude)
	dissolver:SetPos(self:GetPos())
	dissolver:Spawn()

	local name = self:GetName()
	self:SetName(dissolver.Target)

	dissolver:Fire("Dissolve", dissolver.Target, 0)
	dissolver:Fire("Kill", "", 0.1)
	
	timer.Simple(0.1, function()
		self:SetName(name)
	
	end)

	if(dissolveType == 1) then
		self:EmitSound("ambient/energy/whiteflash.wav")
		self:EmitSound("ambient/energy/weld2.wav")

		timer.Create("Dissolving"..entIndex, 0.5, math.random(4,6), function()
			if(!IsValid(self)) then timer.Remove("Dissolving"..entIndex) return end
			
			timer.Adjust("Dissolving"..entIndex, math.Rand(0.2, 0.6))

			self:EmitSound(dissolveSounds[math.random(#dissolveSounds)], _, math.random(90,100))
		
		end)

	end

end