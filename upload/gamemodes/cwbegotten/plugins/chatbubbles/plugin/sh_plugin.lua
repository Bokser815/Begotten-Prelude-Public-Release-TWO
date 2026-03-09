if SERVER then return end

local PLY = FindMetaTable("Player")
local PLUGIN = PLUGIN

PLUGIN:SetGlobalAlias("cw3dText");
--
function PLUGIN:Initialize()
	Clockwork.ConVars.SHOW3DTEXT = Clockwork.kernel:CreateClientConVar("chatDisplayEnabled", 1, true, true);
	Clockwork.ConVars.TRANSLATE3DTEXT = Clockwork.kernel:CreateClientConVar("translateEnabled", 1, true, true);
end;

Clockwork.setting:AddCheckBox("Chat Box", "Enable 3D text for chat.", "chatDisplayEnabled", "Toggle 3D text for chat.");
Clockwork.setting:AddCheckBox("Chat Box", "Enable translations for chat.", "translateEnabled", "Toggle translation for chat.");

surface.CreateFont( "GoreChatBig", {
	font = "Acadian Runes", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = true,
	size = 70,
	weight = 600,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = true,
} )

surface.CreateFont( "VoltistChatBig", {
	font = "Electrica Salsa", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = true,
	size = 70,
	weight = 600,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = true,
} )

surface.CreateFont( "ScrapChatBig", {
	font = "Scrapped To Fuck", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = true,
	size = 70,
	weight = 600,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = true,
} )

surface.CreateFont( "PhilimonjioChatBig", {
	font = "ALOT Gutenberg A", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = true,
	size = 70,
	weight = 600,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = true,
} )

surface.CreateFont( "AdyssaChatBig", {
	font = "Immortal", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = true,
	size = 70,
	weight = 600,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = true,
} )

surface.CreateFont( "NormalChatBig", {
	font = "Day Roman", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = true,
	size = 70,
	weight = 600,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = true,
} )

surface.CreateFont( "DarklanderChatBig", {
	font = "Assyam", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = true,
	size = 70,
	weight = 600,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = true,
} )



if ( SERVER ) then
	return
end

local stored = PLUGIN.chatDisplay or {}
PLUGIN.chatDisplay = stored

local goodClasses = {
	"ic",
	"yell",
	"whisper",
	"me",
	"proclaim",
};

local globalchatbubbledump = {}

hook.Add( "ChatBoxAdjustInfo", "chatbubblesthinking", function( info )
	local ply = info.speaker

	if ( IsValid(ply) and Clockwork.ConVars.SHOW3DTEXT:GetInt() == 1) then

		if (ply:GetMoveType() != MOVETYPE_OBSERVER and ply:GetMoveType() != MOVETYPE_NOCLIP and ply:HasInitialized()) then

			if (info.shouldHear) then

				if (info.filter == "ic" and table.HasValue(goodClasses, info.class)) then

					if (Clockwork.ConVars.SHOW3DTEXT:GetInt() == 1) then
						
						local maxLen = 2048
						local text = info.text

						local textLen = string.utf8len(text)
						local duration = math.max(2, math.min(textLen, maxLen) * 0.4)+2
						local bfont = info.font
						if bfont == "Gore" then
							bfont = "GoreChatBig"
						elseif bfont == "Voltism" then
							bfont = "VoltistChatBig"
						elseif bfont == "Scrapper" then
							bfont = "ScrapChatBig"
						elseif bfont == "Philimonjio" then
							bfont = "PhilimonjioChatBig"
						elseif bfont == "Adyssa" then
							bfont = "AdyssaChatBig"
						elseif bfont == "Darklander" then
							bfont = "DarklanderChatBig"
						elseif !bfont or bfont == nil then
							bfont = "NormalChatBig"
						end

						local textcolor = Color(100, 100, 100, 255)
						if info.class == "me" then
							local doesRecognise = Clockwork.player:DoesRecognise(info.speaker);
							if (!doesRecognise) then
								text = "["..string.sub(Clockwork.player:GetPhysDesc(info.speaker), 0, 21).."...]".." "..text
							else
								text = info.name.." "..text
							end
							
							textcolor = Color(164, 85, 0, 255)
						elseif info.class == "yell" then
							textcolor = Color(127, 0, 0, 255)
						elseif info.class == "proclaim" then
							bfont = Clockwork.fonts:GetMultiplied(bfont,2)
						end
						globalchatbubbledump[#globalchatbubbledump+1] = {
							player = ply,
							font = bfont,
							text = textLen > maxLen and utf8.sub(text, 1, 2048).."..." or text,
							color = textcolor,
							fadeTime = duration,
							timesent = CurTime(),
						}
						table.SortByMember( globalchatbubbledump, "timesent", false )
					end
				end
			end
		end
	end
end )

local function WrapString(str,wide,font)
	if font then surface.SetFont(font) end
	local pos,len,tab = 0,#str,{}
	local maxLenSplit = math.ceil(wide/surface.GetTextSize("A"))*1.5
	while pos < len do
		pos = pos + 1
		local size,_ = surface.GetTextSize(string.sub(str,0,pos))
		if size > wide then
			local c
			repeat
				pos = pos - 1
				c = string.sub(str,pos,pos)
			until c == " " or c == "," or c == "." or c == "\n" or pos <= 0
			if pos <= 0 then
				pos = maxLenSplit
			end
			table.insert(tab,string.sub(str,1,pos))
			str = string.sub(str,pos+1,len)
			pos = 0
		end
	end
	table.insert(tab,str)
	return table.concat(tab,"\n")
end

hook.Add("PostDrawTranslucentRenderables","ChatBubblesDraw",function(depth)
	local ply = LocalPlayer()
	local scrW, scrH = ScrW(), ScrH()
	local halfWidth, halfHeight = scrW * 0.5, scrH * 0.5
	
	if ( Clockwork.ConVars.SHOW3DTEXT:GetInt() == 1 ) then
		if globalchatbubbledump then
			local stacksheightplayers = {}
			for k, v in pairs(globalchatbubbledump) do
				local bubbler = v.player
				

				if ( IsValid(bubbler) ) then
					local alpha = 255 * math.min(v.fadeTime, 1)
					local col1, col2 = ColorAlpha(v.color, alpha), Color(0, 0, 0, alpha)
					local pos = bubbler:GetPos()
					if alpha > 0 then
						local font = v.font
						
						
						if v.font == nil or v.text == nil or v.color == nil or v.fadeTime == nil then
							print("broken value deleting")
							stored[v] = nil
						end

						
						surface.SetFont(font)

						local _, fullH = surface.GetTextSize(v.text)
						local offset = 4

						local pow = nil
						if !v.iswrapped then 
							v.iswrapped = true
							v.wrappedtext = WrapString(v.text,2000,font):Trim()
							pow = v.wrappedtext
						else
							pow = v.wrappedtext
						end

						local w, h = surface.GetTextSize(pow)
						if !bubbler.lastchatbubblepos then bubbler.lastchatbubblepos = pos end
						if !bubbler.lastchatbubbleeyepos or bubbler.lastchatbubblepos!=pos then
							bubbler.lastchatbubbleeyepos = bubbler:OBBMaxs().z
						end
						bubbler.lastchatbubblepos = pos
						cam.Start3D2D(bubbler:GetPos()+Vector(0,0,bubbler.lastchatbubbleeyepos),Angle(0,EyeAngles().y-90,90),.10)

						if !stacksheightplayers[bubbler] then stacksheightplayers[bubbler] = 0 end

						draw.DrawText(pow,font,0,-(h+stacksheightplayers[bubbler]+30),Color(col1.r, col1.g, col1.b, alpha),TEXT_ALIGN_CENTER)

						stacksheightplayers[bubbler] = stacksheightplayers[bubbler]+h

						cam.End3D2D()

						v.fadeTime = v.fadeTime - FrameTime()

					else
						table.remove(globalchatbubbledump,k)
						--PrintTable(globalchatbubbledump)
					end
				else
					table.remove(globalchatbubbledump,k)
				end
			end
		end

	end
end)
