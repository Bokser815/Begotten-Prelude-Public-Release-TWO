--[[
	Begotten III: Jesus Wept
--]]

PLUGIN:SetGlobalAlias("cwVehiclespawning");

Clockwork.kernel:IncludePrefixed("cl_hooks.lua");
Clockwork.kernel:IncludePrefixed("sv_plugin.lua");
Clockwork.kernel:IncludePrefixed("sv_hooks.lua");



if SERVER then return end

local PLY = FindMetaTable("Player")
local PLUGIN = PLUGIN



function PLUGIN:Initialize()
	CW_CONVAR_SHOWSTYLIZEDVEHICLENAMES = Clockwork.kernel:CreateClientConVar("stylizedvehiclenamesenable", 1, true, true);
end;

Clockwork.setting:AddCheckBox("Screen effects", "Stylized vehicle names.", "stylizedvehiclenamesenable", "Stylized vehicle names.");



