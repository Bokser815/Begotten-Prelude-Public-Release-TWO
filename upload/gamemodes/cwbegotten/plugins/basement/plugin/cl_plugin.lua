--[[
	BEGOTTEN: Damnation was created by cash wednesday.
--]]

surface.CreateFont("AHintHeader", {
	font		= "Times New Roman",
	size		= Clockwork.kernel:ScaleToWideScreen(24),
	weight		= 700,
	antialiase	= true,
	shadow 		= true
});

surface.CreateFont("AHintSubHeader", {
	font		= "Arial",
	size		= Clockwork.kernel:ScaleToWideScreen(16),
	weight		= 700,
	antialiase	= true,
	shadow 		= true
});

-- A function to print text to the center of the screen.
function cwBasement:PrintCustomHint(text, subText, delay, color)
	local autoBarFont = Clockwork.option:GetFont("hints_text");
	local scrW = ScrW();
	local wrappedTable = {""};
	
	if (!self.hintTexts) then
		self.hintTexts = {};
	end;

	subText = "\""..subText.."\""
	
	Clockwork.kernel:WrapTextSpaced(Clockwork.kernel:ParseData(subText), autoBarFont, scrW * 0.25, wrappedTable);
	
	self.hintTexts[#self.hintTexts + 1] = {
		targetAlpha = 255,
		alpha = 0,
		delay = delay,
		color = color,
		header = text,
		subHeaders = wrappedTable
	};
	
	Clockwork.Client.nextThought = CurTime() + 60;
end;

netstream.Hook("cwCustomHint", function(data)
	local text = data[1] or "Unknown..."
	local subText = data[2] or "...";
	local priority = data[3] or 1;
	
	cwBasement:PrintCustomHint(text, subText, 5, Color(255, 255, 255, 255));
end);
--[[ this is for the tape player and tapes but i have no plans to add that rn
netstream.Hook("DelayThought", function(data)
	local delay = data or 30;
	local curTime = CurTime();

	Clockwork.Client.nextThought = curTime + delay;
	Clockwork.Client.nextInterupt = curTime + delay;
end);
]]--