PLUGIN:SetGlobalAlias("cas");

Clockwork.kernel:IncludePrefixed("sv_hooks.lua");

if (SERVER) then
	concommand.Add("forceraise", function(player, cmd, args)
		if (player:IsAdmin()) then
			local target = Clockwork.player:FindByID(args[1])
			
			if (target) then
				target:SetWeaponRaised(true);
			end;
		end;
	end);

	concommand.Add("forcelower", function(player, cmd, args)
		if (player:IsAdmin()) then
			local target = Clockwork.player:FindByID(args[1]);
			
			if (target) then
				target:SetWeaponRaised(false);
			end;
		end;
	end);
end;

local COMMAND = Clockwork.command:New("SpawnESPTrap");
	COMMAND.tip = "Spawn an ESP trap item where you are looking that will alert admins if picked up by a player.";
	COMMAND.access = "s";
	COMMAND.text = "<string uniqueID> [bool Freeze] [int zOffset]"
	COMMAND.arguments = 1;
	COMMAND.optionalArguments = 2;
	
	-- Called when the command has been run.
	function COMMAND:OnRun(player, arguments)
		if (SERVER) then
			if (cas and cas.SpawnTrapItem) then
				cas:SpawnTrapItem(player, player:GetEyeTrace().HitPos, tostring(arguments[1]), tobool(arguments[2]) or false, tonumber(arguments[3]) or 0)
			end;
		end;
	end;
COMMAND:Register();

local COMMAND = Clockwork.command:New("ToggleAFKKicker");
	COMMAND.tip = "Toggle the AFK Kicker.";
	COMMAND.flags = CMD_DEFAULT;
	COMMAND.access = "s";

	-- Called when the command has been run.
	function COMMAND:OnRun(player, arguments)
		if cas.afkKickerEnabled ~= false then
			cas.afkKickerEnabled = false;
			Schema:EasyText(Schema:GetAdmins(), "cornflowerblue", player:Name().." has disabled automatic AFK kicking.");
		else
			cas.afkKickerEnabled = true;
			Schema:EasyText(Schema:GetAdmins(), "cornflowerblue", player:Name().." has enabled automatic AFK kicking.");
			
			local curTime = CurTime();
			local playerCount = _player.GetCount();
			
			if player.lastNotInitialized then
				player.lastNotInitialized = curTime + 360;
			end
		end
	end;
COMMAND:Register();