function cwGlobalDeath:RequestDeathCount()
    net.Start("cw_GetGlobalDeathCount");
    net.SendToServer();

end

function cwGlobalDeath:SetInitialDeathCount()
    self.deathCount = self.deathCount or 0;

    self:RequestDeathCount();

end

net.Receive("cw_GetGlobalDeathCount", function()
    cwGlobalDeath:SetDeathCount(net.ReadUInt(32));

end);

local bigTextFont = Clockwork.option:GetFont("menu_text_big");
local tinyTextFont = Clockwork.option:GetFont("menu_text_tiny");
local corpsedTexts = {"GRAPED", "GLAZED", "GORED", "THRALLED", "CLEANSED", "POPPED", "MUGGED", "FUCKED", "CORPSED", "CORPSED", "CORPSED", "CORPSED", "SLAIN", "KILLED", "SLAUGHTERED", "EXECUTED", "FELLED", "MURDERED", "BUTCHERED", "CUT DOWN", "MASSACRED", "ASSASSINATED", "DESTROYED", "GUTTED", "RAZED", "OBLITERATED", "ERADICATED", "ANNIHILATED", "CRUCIFIED", "SACRIFICED", "WASTED", "EXTERMINATED",};

local function RandomizeCase(text)
    local fuckedText = "";

    for i = 1, #text do
        local subText = string.sub(text, i, i);

        fuckedText = fuckedText..(math.random(1,2) == 1 and string.upper(subText) or string.lower(subText));

    end

    return fuckedText

end

local redLow = Color(175,0,0);
local redHigh = Color(255,0,0);
local whiteLow = Color(175,175,175);
local whiteHigh = Color(255,255,255);

function cwGlobalDeath:PostCharacterMenuPaint(panel)
    if(IsValid(Clockwork.character.activePanel)) then return; end

    local curTime = CurTime();
    local x = panel:GetWide()*.5;
    local y = (panel:GetTall()*.5)+295;

    if(!panel.currentCorpsedText) then panel.currentCorpsedText = "CORPSED"; end
    --if(!panel.requestedDC) then self:RequestDeathCount(); panel.requestedDC = true; end

    if(!panel.nextCorpsedRefresh or panel.nextCorpsedRefresh <= curTime) then
        panel.currentCorpsedText = table.Random(corpsedTexts);
        panel.nextCorpsedRefresh = curTime + math.random(0.3,1);

    end

    local text = (self:GetDeathCount().." "..panel.currentCorpsedText);
    local red = math.random(1,2) == 1;

    for i = 1, math.random(1,5) do
        surface.DrawRotatedTextCentered(RandomizeCase(text), bigTextFont, x + math.random(-50,50), y + math.random(-50,50), math.random(-6, 6), red and redLow or whiteLow);

    end

    draw.SimpleText(text, bigTextFont, x + math.random(-2,2), y + math.random(-2,2), red and redHigh or whiteHigh, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);

end