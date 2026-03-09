--[[
	Derived code from cash wednesday and DETrooper
--]]

PLUGIN:SetGlobalAlias("cwBasement");

Clockwork.kernel:IncludePrefixed("cl_hooks.lua");
Clockwork.kernel:IncludePrefixed("cl_plugin.lua");
Clockwork.kernel:IncludePrefixed("cl_tables.lua");
Clockwork.kernel:IncludePrefixed("sv_hooks.lua");

local playerMeta = FindMetaTable("Player");

-- A function to get the players first name.
function playerMeta:FirstName()
	local splitName = string.Split(self:Name(), " ");
	
	return splitName[1];
end;

-- A function to get the players last name.
function playerMeta:LastName()
	local splitName = string.Split(self:Name(), " ");
	
	return splitName[#splitName];
end;

-- A function to get if the player is alone.
function playerMeta:IsAlone(radius)
	local playerTable = {};
	
	if (!radius) then
		radius = 1000;
	end;
	
	for k, v in pairs (ents.FindInSphere(self:GetPos(), radius)) do
		if (v:IsPlayer() and v:Alive() and v:HasInitialized() and v.cwObserverMode != true and v != self) then
			if (self:Alive() and self.cwObserverMode != true and self:HasInitialized()) then
				table.insert(playerTable, v);
			end;
		end;
	end;
	
	if (#playerTable > 0) then
		return false;
	end;
	
	return true;
end;

--if (SERVER) then
	cwBasement.customHintTable = {
		--[[[1] = {Vector(2445.5573730469, 7254.4609375, 466.1748046875), Vector(3791.1708984375, 8999.349609375, 215.4458770752), "I should go for a swim..."},
		[2] = {Vector(4212.03125, 2052.0122070313, 1268.94921875), Vector(4562.9091796875, 1792.3168945313, 1146.03125), "It sure is dusty in here..."},
		[3] = {Vector(-254.01272583008, 7516.2104492188, 992.82165527344), Vector(-528.96124267578, 8482.8779296875, 892), "From up here would be quite the fall..."},
		[4] = {Vector(4638.3427734375, 9960.1171875, 343.52801513672), Vector(5479.2993164063, 9398.6962890625, 112.34509277344), "Looks disgusting in here..."},
		[5] = {Vector(-1693.5009765625, 10329.383789063, 710.42724609375), Vector(-3094.5505371094, 8808.986328125, 215.22009277344), "I should go for a swim....."},
		[6] = {Vector(-7015.8159179688, 12134.823242188, 573.42059326172), Vector(-6487.8916015625, 11742.693359375, 408.20550537109), "It's a cave... I hate caves.."},
		[7] = {Vector(-3216.03125, -3586.6748046875, 488.21481323242), Vector(-3549.6574707031, -3710.1110839844, 260.7822265625), "The staircase is collapsed.."},
		[8] = {Vector(-4480.794921875, -7425.4038085938, 321.4299621582), Vector(-3825.9318847656, -6824.2104492188, 146.21156311035), "This house is damaged beyond belief.."},
		[9] = {Vector(-2197.1484375, -3661.96875, 33.944183349609), Vector(-1787.3427734375, -3925.3969726563, 776.87603759766), "I wonder how this building collapsed..."},
		[10] = {Vector(9121.5810546875, -8711.96875, 787.64770507813), Vector(8697.083984375, -8420.8271484375, 630.03125), "God save my soul..."},
		[11] = {Vector(11990.880859375, 7602.03125, 542.26007080078), Vector(11746.600585938, 7696.1455078125, 416.03125), "Aha... A nice cabin in the woods..."}]]--
	};
	
	cwBasement.customHintModels = {
		["models/props/sewer/room_security.mdl"] = {texts = {"Why is there a security room in a sewer?", "Why would a sewer need a security room?", "This doesn't make sense... security in a sewer...?", "Huh... security. Security in a sewer?", "Security... maybe it's safe in there."}, sound = "begotten/ui/quest_completed.mp3"},
		["models/props_c17/metalladder001.mdl"] = {maximumLevel = 1, texts = {"A ladder! Thank god!", "A ladder! Maybe I can finally get out of here!", "Finally, a ladder! Now I can escape!", "A way out! It has to be!"}, sound = "begotten/ui/quest_completed.mp3"},
		["models/props/cs_office/Exit_ceiling.mdl"] = {maximumLevel = 1, texts = {"An exit!? This must be the way out!", "Oh my god, an exit sign!", "Yes!"}, sound = "begotten/lab.mp3"}
	};
	
	cwBasement.customHintEvents = {
		["spawnSewer"] = {
			{"Ow! What the hell!? Where am I?", "Fuck! Did I really just fall into a sewer!?", "Jesus! That hurt!", "No, no, no! I'm gonna be late! This is fucked!", "Fucking really? I'm gonna make sure the city gets sued for this once I'm out of here.", "What!? How did that happen!?", "Ouch, my head! Where am I...?"},
			{"Shit. I've gotta find a way out of here. Maybe I can call for help?", "Will anyone hear me if I call for help?", "No ladder, shit... There's gotta be another way out of here.", "Should I stay here and wait for help?", "Did anyone see me fall in? I hope so..."},
		},
		["secondFloor"] = {
			{"N-no! I'll never f-fucking make it out of here! It goes on forever!", "What!? More sewer!? Oh god! Where is the fucking exit!?", "Fuck fuck fuck! Where's the fucking exit!? I should be out of here by now!", "No! That was supposed to be it! That ladder was my escape!"},
			{"This was supposed to be street level! How is this possible!?", "I swear I didn't fall that far! The street should be right fucking here!", "This doesn't make any sense! This is street level! I fucking know it!"},
		},
		["phoneDied"] = {
			{"No! Fuck! My phone is dead! I won't be able to call for help anymore!", "Oh no, now my phone is dead...", "No, no, no! I knew I should have charged my phone before I left the house!", "Shit... there goes the last of my phone battery."},
		},
		["flashlightDied"] = {
			{"Oh god, not my flashlight... not the darkness...", "No! Come on! Work damn you! Shit... the battery's dead.", "Well, there goes my flashlight I guess...", "Great, the battery died. Now I'm gonna be stuck in the dark."},
		},
	};
--end;

local COMMAND = Clockwork.command:New("SendHint");
COMMAND.tip = "Send a custom hint to a player if they are in the basement.";
COMMAND.text = "<string Target> <string Text>";
COMMAND.access = "a";
COMMAND.arguments = 2;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	
	if (target) then
		local playerName = target:Name();
		local text = table.concat(arguments, " ", 2);
		
		if (SERVER) then
			netstream.Start(target, "cwCustomHint", {target:FirstName().." Thinks...", text});
		end;
	else
		player:Notify(target.." is not a valid target!");
	end;
end;

COMMAND:Register();