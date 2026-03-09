local map = game.GetMap() == "bg_prelude"

if map then
	cwAntenna.towerPos = Vector(6705.34375, -12330.09375, -709.125); -- @fiercestwarrior CHANGE THIS
end



--[[
function cwAntenna:GetStatus()
	return self.antennaPower;
end
]]--