local _BPM = 85;
local _BPS = 1.41;
local BIG_START = 22.547;
local LOOP_POINT = 364.929;
local line1 = "BEGOTTEN";
local line2 = "PRELUDE";

function cwIntroduction:OnBeat(player)
    if(!player.demiurge) then return; end

    player.demiurge.doEffect2 = true;

    if(player.demiurge.line1 < #line1) then
        player.demiurge.line1 = player.demiurge.line1 + 1;

    elseif(player.demiurge.line2 < #line2+2) then
        player.demiurge.line2 = player.demiurge.line2 + 1;

        if(player.demiurge.line2 == #line2+2) then
            player:ScreenFade(SCREENFADE.IN, color_white, 1, 0);

        end

    end

    timer.Simple(math.random(0.3,0.4), function()
        if(!player.demiurge) then return; end

        player.demiurge.doEffect2 = false;
    
    end);

    --if(math.random(1,2) == 1) then
        player.demiurge.sharpen = true;

        timer.Simple(math.random(0.1, 0.3), function()
            if(!player.demiurge) then return; end

            player.demiurge.sharpen = false;
        
        end);

    --end

    player.demiurge.doEffect = true;
    player.demiurge.effectTarget = table.Random(player.demiurge.cachedPlayers);

    timer.Simple(math.random(0.1,0.2), function()
        if(!player.demiurge) then return; end

        player.demiurge.doEffect = false;
    
    end);

    player.demiurge.colorModify["$pp_colour_mulr"] = math.random(0,50);
    player.demiurge.colorModify["$pp_colour_contrast"] = math.random(1.1,2);

end

function cwIntroduction:OnQuarterBeat(player)
    if(!player.demiurge) then return; end

    if(math.random(1,4) == 1) then
        if(!player.demiurge) then return; end

        player.demiurge.tv = true;

        timer.Simple(math.random(0.25, 0.05), function()
            if(!player.demiurge) then return; end

            player.demiurge.tv = false;
        
        end);

    end

end

function cwIntroduction:OnHalfBeat(player)
    if(!player.demiurge) then return; end
    if !player.demiurgecamerafuck then player.demiurgecamerafuck = 35 end
    --if player.demiurgecamerafuck == 1 then player.demiurgecamerafuck = 35 end
    
    player.demiurge.effect3Var = math.random(-player.demiurgecamerafuck,player.demiurgecamerafuck);
    player.demiurge.doEffect3 = true;

    timer.Simple(math.random(0.2, 0.3), function()
        if(!player.demiurge) then return; end

        player.demiurge.doEffect3 = false;
    
    end);

    --[[if(math.random(1,2) == 1) then
        local ran = math.random(1,10);

        player.demiurge.rand1 = ran;
        player.demiurge.rand2 = ran;

    end]]

    player.demiurgecamerafuck = math.Approach( player.demiurgecamerafuck, 1, 2 )

end

function cwIntroduction:OnTwoBeats(player)
    if(!player.demiurge) then return; end

    if(math.random(1,2) == 2) then return; end

    player.demiurge.doEffect4 = true;

    timer.Simple(math.random(0.3,0.8), function()
        if(!player.demiurge) then return; end

        player.demiurge.doEffect4 = false;
    
    end);

end

function cwIntroduction:OnBigStart(player)
    if(!player.demiurge) then return; end

    player.demiurge.canDoEffects = true;

    self:OnQuarterBeat(player);
    self:OnHalfBeat(player);
    self:OnBeat(player);
    self:OnTwoBeats(player);

    timer.Create("EveryQuarterBeatDemiurge", (15/_BPM), 0, function()
        if(!player.demiurge) then return; end

        self:OnQuarterBeat(player);
    
    end);

    timer.Create("EveryHalfBeatDemiurge", (30/_BPM), 0, function()
        if(!player.demiurge) then return; end

        self:OnHalfBeat(player);
    
    end);

    timer.Create("EveryBeatDemiurge", (60/_BPM), 0, function()
        if(!player.demiurge) then return; end

        self:OnBeat(player);
    
    end);

    timer.Create("EveryTwoBeatsDemiurge", (120/_BPM), 0, function()
        if(!player.demiurge) then return; end
        
        self:OnTwoBeats(player);
    
    end);

end

function cwIntroduction:DoIntro(player)
    player.Pending = nil;
    self:StartDemiurge(player);

    if !Clockwork.quiz:GetCompleted() then
        Clockwork.quiz.completed = true;
    end
end

Clockwork.datastream:Hook("Demiurge", function(skip_enabled)
    cwIntroduction:DoIntro(Clockwork.Client);

end);

function cwIntroduction:InitDemiurge(player)
    player.demiurge = {};
    player.demiurge.nextPlyRefresh = 0;
    player.demiurge.canDoEffects = false;
    player.demiurge.blackAlpha = 255;
    player.demiurge.station = nil;
    player.demiurge.line1 = 0;
    player.demiurge.line2 = 0;
    player.demiurge.rand1 = 1;
    player.demiurge.rand2 = 1;
    player.demiurge.cachedPlayers = {};
    
    player.demiurge.colorModify = {};
    player.demiurge.colorModify["$pp_colour_brightness"] = 0;
    --player.demiurge.colorModify["$pp_colour_colour"] = 1;
    --player.demiurge.colorModify["$pp_colour_contrast"] = 1;
    player.demiurge.colorModify["$pp_colour_mulr"] = 0;
    player.demiurge.colorModify["$pp_colour_mulg"] = 0;
    player.demiurge.colorModify["$pp_colour_mulb"] = 0;

end

function cwIntroduction:StartDemiurge(player)
    if(player.demiurge and IsValid(player.demiurge.station)) then player.demiurge.station:Stop(); end

    timer.Remove("BigStartDemiurge");
    timer.Remove("EveryQuarterBeatDemiurge");
    timer.Remove("EveryHalfBeatDemiurge");
    timer.Remove("EveryBeatDemiurge");
    timer.Remove("EveryTwoBeatsDemiurge");

    player.doneDemiurge = true;
    player.blockEffects = false;

    self:InitDemiurge(player);

    local snd = file.Exists("sound/prelude/demiurge.mp3", "GAME") and "sound/prelude/demiurge.mp3" or "sound/vo/k_lab/kl_fiddlesticks.wav";

    sound.PlayFile(snd, "noplay noblock", function(station, errCode, errStr)
        if(!IsValid(station)) then ErrorNoHalt("[Clockwork] Unable to load Demiurge music! "..errStr.." ["..errCode.."]"); end

        player.demiurge.station = station;
        player.demiurge.station:SetVolume((Clockwork.ConVars.AMBIENTMUSICVOLUME:GetInt() or 100) / 100);
        player.demiurge.station:Play();

        player.demiurge.demiurgeStart = CurTime();
        player.demiurge.doing = true;

        --print(player.demiurge.station);

        timer.Create("BigStartDemiurge", BIG_START, 1, function()
            cwIntroduction:OnBigStart(player);

        end);

    end);

end

function cwIntroduction:StopDemiurge(player)
    if(!player.demiurge or !IsValid(player.demiurge.station)) then return; end

    timer.Remove("BigStartDemiurge");
    timer.Remove("EveryQuarterBeatDemiurge");
    timer.Remove("EveryHalfBeatDemiurge");
    timer.Remove("EveryBeatDemiurge");
    timer.Remove("EveryTwoBeatsDemiurge");
    
    player.demiurge.station:Stop();
    player.demiurge.station = nil;
    player.demiurge.doing = false;
    player.demiurge.canDoEffects = false;

    player.demiurge = nil;
    player.blockEffects = false;

end

function cwIntroduction:GetPlayerCharacterScreenVisible(panel)
	if (Clockwork.Client.Pending or (Clockwork.Client.demiurge and Clockwork.Client.demiurge.line2 < #line2+2)) then return false; end

end

function cwIntroduction:Tick()
    local player = Clockwork.Client;
    local curTime = CurTime();

    if (!Clockwork.kernel:IsChoosingCharacter() and player.demiurge and player.doneDemiurge) then
		player.demiurge.station:Stop();
		player.demiurge = nil;

    elseif(Clockwork.kernel:IsChoosingCharacter() and !player.demiurge and player.doneDemiurge) then
        self:InitDemiurge(player);

        sound.PlayFile("sound/prelude/demiurge.mp3", "noplay noblock", function(station, errCode, errStr)
            if(!IsValid(station)) then ErrorNoHalt("[Clockwork] Unable to load Demiurge music! "..errStr.." ["..errCode.."]"); return; end

            player.demiurge.station = station;
            player.demiurge.station:SetVolume((Clockwork.ConVars.AMBIENTMUSICVOLUME:GetInt() or 100) / 100);
            player.demiurge.station:Play();
            
            self:OnBigStart(player);
            player.demiurge.station:SetTime(BIG_START);
            player.demiurge.line1 = #line1;
            player.demiurge.line2 = #line2+2;

        end);

    end

    if(!player.demiurge) then return; end
    if(!player.demiurge.doing) then return; end
    if(player.demiurge.nextPlyRefresh > curTime) then return; end

    player.demiurge.nextPlyRefresh = curTime + 0.5;

    player.demiurge.cachedPlayers = {};

    for _, v in pairs(ents.FindInSphere(player:GetPos(), 1000)) do
        if(v == player or !v:IsPlayer() or !v:Alive()) then continue; end

        player.demiurge.cachedPlayers[#player.demiurge.cachedPlayers+1] = v;
        
    end

end

local screenwarp = Material("models/props_c17/fisheyelens");
local tv = Material("effects/flicker_256");
local texturize = Material("pp/texturize/plain.png");

surface.CreateFont("demiurgemenuTextBig",
{
	font		= "Immortal",
	size		= ScreenScale(18),
	weight		= 700,
	antialiase	= true,
	additive 	= false,
	extended 	= true
});

local function makeFont(title, font)
    surface.CreateFont(title,
    {
    	font		= font,
    	size		= ScreenScale(55),
    	weight		= 700,
    	antialiase	= true,
    	additive 	= false,
    	extended 	= true
    });

end

makeFont("demiurgemenuTextBigBig1", "Immortal");
makeFont("demiurgemenuTextBigBig2", "Day Roman");
makeFont("demiurgemenuTextBigBig3", "Sell Your Soul");
makeFont("demiurgemenuTextBigBig4", "Subway Haze");
makeFont("demiurgemenuTextBigBig5", "Scrapped To Fuck");
makeFont("demiurgemenuTextBigBig6", "Type-Ra");
makeFont("demiurgemenuTextBigBig7", "Evil Bible");
makeFont("demiurgemenuTextBigBig8", "Dominican");
makeFont("demiurgemenuTextBigBig9", "Alsina");
makeFont("demiurgemenuTextBigBig10", "Acadian Runes");

function cwIntroduction:HUDPaint()
    local width, height = ScrW(), ScrH();

    local player = Clockwork.Client;

    if(!player.demiurge) then return; end
    if(player.blockEffects) then return; end

    if(!player.demiurge.canDoEffects and player.demiurge.demiurgeStart) then
        surface.SetDrawColor(0,0,0,255);
        surface.DrawRect(0,0,width,height);

        local fuck = math.ease.InExpo((CurTime() - player.demiurge.demiurgeStart)/BIG_START);

        local matrix = Matrix();
        matrix:Rotate(Angle(0, math.random(-120,120)*fuck, 0));
        matrix:Translate(Vector(math.random(-100,100)*fuck, math.random(-100,100)*fuck));
        cam.PushModelMatrix(matrix);
            draw.SimpleText("SPACE TO SKIP...", "demiurgemenuTextBig", width/2, height/2, Color(255,0,0,50), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
        cam.PopModelMatrix();

        local matrix = Matrix();
        matrix:Translate(Vector(math.random(-150,150)*fuck, math.random(-150,150)*fuck));
        cam.PushModelMatrix(matrix);
            draw.SimpleText("SPACE TO SKIP...", "demiurgemenuTextBig", width/2, height/2, Color(255,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
        cam.PopModelMatrix();

    end

    --[[draw.SimpleText("CT: "..CurTime(), "DermaDefault", 25, 50);
    draw.SimpleText("CT-DUS: "..(math.Round((CurTime() - player.demiurge.demiurgeStart), 2)), "DermaDefault", 25, 60);
    draw.SimpleText("CB: "..(_BPM/60) * (CurTime() - player.demiurge.demiurgeStart), "DermaDefault", 25, 90);
    draw.SimpleText("%"..math.Round((CurTime() - player.demiurge.demiurgeStart) % (60/_BPM), 1), "DermaDefault", 25, 80);]]

    if Clockwork.Client.SelectedFaction then return; end

    if(player.demiurge.canDoEffects and player.demiurge.tv) then
        surface.SetDrawColor(0,0,0,255);
        surface.SetMaterial(tv);
        surface.SetAlphaMultiplier( 10 )
        surface.DrawTexturedRect(0,0,width,height);
        --DrawBloom( 0.65, 2, 9, 9, 1, 3, 1, 1, 1 )

    end

    if(player.demiurge.canDoEffects and player.demiurge.sharpen) then
        DrawSharpen(math.random(1,10),math.random(1,10));
        --DrawBloom( 0.65, 2, 9, 9, 1, 3, 1, 1, 1 )
        
    end

    if(player.demiurge.canDoEffects and player.demiurge.doEffect4) then
        DrawTexturize(math.random(0,.5), texturize);

    end

    if(player.demiurge.canDoEffects) then
        
        --DrawColorModify(player.demiurge.colorModify);
        

    end

    if(player.demiurge.canDoEffects and player.demiurge.doEffect2) then
       -- DrawMaterialOverlay("models/props_c17/fisheyelens", math.random(-0.06, 0.06));

    end

end

local redpent = Material("begotten/pentagram_red.png");
local flashes = {"KILL","FLESH","DIE","BITCH","WHORE","COLD POP","YUM CHUG","HUNTER","CHANTIAM","POP","FUCK","KILL","KILL","GLAZE","GORE","WAR","VILLAGE","BURN","ROTTING","FLIES","RANCID","POPE","HIERARCHY","DARK","LIGHT","CAGE","TORTURE","DISMEMBER","CUT","MAIM","LORD","CHURCH","TOWER","ITZUTAK","BEGOTTEN","DEATH","HELL","INFERNO","LICK","TWISTED","TWISTED FUCK","CORPSE","FLAME","FORGOTTEN",}
local fonts = {"nov_IntroTextSmallaaaa", "nx_IntroTextSmalls", "nov_IntroTextSmallaaaaa"}

function cwIntroduction:RenderScreenspaceEffects()
    local player = Clockwork.Client;
    local width, height = ScrW(), ScrH();
    local halfWidth, halfHeight = width/2, height/2;

    if(!player.demiurge) then return; end
    if(player.blockEffects) then return; end

    local activePanel = Clockwork.character:GetActivePanel();
    
    if IsValid(activePanel) then return; end

    if(player.demiurge.line2 == #line2+2) then

        surface.SetDrawColor(255,255,255);
        surface.SetMaterial(redpent);
        surface.DrawTexturedRectRotated(halfWidth, (height/3.375), halfHeight, halfHeight, CurTime() % -360);
        
        if (math.random(1, math.random(5, 10)) == 1) then
            for i = 1, math.random(1, 10) do
                local font = table.Random(fonts);
                local text = table.Random(flashes);
                local x = math.random(0, width);
                local y = math.random(0, height);
                local color = Color(math.random(150, 255), 0, 0);
                local outline = Color(0,0,0);
                local rotation = math.random(-5, 5);

                surface.DrawRotatedText(text, font, x, y, rotation, color);

            end
	    end

    end
    
    local matrix = Matrix();
    matrix:Rotate(Angle(0, math.random(-.2,.2), 0));
    matrix:Translate(Vector(math.random(-1,1), math.random(-1,1)));
    cam.PushModelMatrix(matrix);
        draw.SimpleText(string.sub(line1, 1, player.demiurge.line1), "demiurgemenuTextBigBig"..player.demiurge.rand1, (halfWidth)+10, (height/4)+10, Color(0,0,0,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
        draw.SimpleText(string.sub(line1, 1, player.demiurge.line1), "demiurgemenuTextBigBig"..player.demiurge.rand1, (halfWidth), (height/4), Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
    cam.PopModelMatrix();

    local matrix = Matrix();
    matrix:Rotate(Angle(0, math.random(-.2,.2), 0));
    matrix:Translate(Vector(math.random(-1,1), math.random(-1,1)));
    cam.PushModelMatrix(matrix);
        draw.SimpleText(string.sub(line2, 1, player.demiurge.line2), "demiurgemenuTextBigBig"..player.demiurge.rand2, (halfWidth)+10, (height/2.75)+10, Color(0,0,0,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
        draw.SimpleText(string.sub(line2, 1, player.demiurge.line2), "demiurgemenuTextBigBig"..player.demiurge.rand2, (halfWidth), (height/2.75), Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
    cam.PopModelMatrix();

end

function cwIntroduction:StartCommand(player, cmd)
    if(player.demiurge and input.WasKeyPressed(KEY_SPACE) and !player.demiurge.canDoEffects) then
        timer.Remove("BigStartDemiurge");

        self:OnBigStart(player);
        player.demiurge.station:SetTime(BIG_START);
        player.demiurge.line1 = #line1;
        player.demiurge.line2 = #line2+2;

        player:ScreenFade(SCREENFADE.IN, color_white, 1, 0);

    end

end

