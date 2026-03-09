local COMMAND = Clockwork.command:New("ToggleDiscordLogs");
	COMMAND.tip = "Toggle whether or not logs should be taken and sent to the Discord webhook.";
	COMMAND.access = "s";

	-- Called when the command has been run.
	function COMMAND:OnRun(player, arguments)
		cwDiscordLog.shouldLog = !cwDiscordLog.shouldLog;

        file.Write("shouldlog.txt", tostring(cwDiscordLog.shouldLog));

        if(!cwDiscordLog.shouldLog) then
        	function cwDiscordLog:Add() end
        	function cwDiscordLog:Send() end

        	return;

        end

        Schema:EasyText(player, "darkgrey", (cwDiscordLog.shouldLog and "Enabled" or "Disabled").." discord logs.");

	end;
COMMAND:Register();