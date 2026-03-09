--[[
	Begotten III: Jesus Wept
	By: DETrooper, cash wednesday, gabs, alyousha35

	Other credits: kurozael, Alex Grist, Mr. Meow, zigbomb
--]]

include("shared.lua")

local debugEnabled = true

function ENT:HUDPaintTargetID(x, y, alpha)
    local colorTargetID = Clockwork.option:GetColor("target_id")
    local colorWhite = Clockwork.option:GetColor("white")
    
    y = Clockwork.kernel:DrawInfo("Oil Terminal", x, y, colorTargetID, alpha)
    y = Clockwork.kernel:DrawInfo("An automated, industrial terminal. A low mechanical hum can be heard threadbare throughout the scrapyard, all leading here.", x, y, colorWhite, alpha)
    
    if self.debug then
        y = Clockwork.kernel:DrawInfo("DEBUG: Wave " .. self:GetNWInt("wave", 0), x, y, colorWhite, alpha)
    end
end

ENT.baselinePoint = 0

ENT.toggleswitch = false
ENT.toggleswitchr2 = false
ENT.togglebob = false

local light
local angle = 0
local glowMaterial = Material("sprites/glow04_noz");
local entitytarget
local showRetroMessage = false

ENT.speeds = {
    [1] = 0.02,
    [2] = 0.1,
    [3] = 0.25,
}

ENT.speedsbob = {
    [1] = 0.02,
    [2] = 0.1,
    [3] = 0.25,
}

ENT.maxsidetoside = {
    [1] = 0.5,
    [2] = 0.5,
    [3] = 0.5,
}

ENT.maxbob = {
    [1] = 0.5,
    [2] = 0.5,
    [3] = 0.5,
}

function ENT:Draw()
    local wave = self:GetNWInt("wave", 0)
    if (wave == 0) then
        self:DrawModel()
        self.baselinePoint = self:GetPos().z 
    else
        local ang = self:GetAngles()
        local pos = self:GetPos()
        local sidetosidespeed = self.speeds[wave] or self.speeds[3]
        local bobspeed = self.speedsbob[wave] or self.speedsbob[3]
        local maxsidetoside = self.maxsidetoside[wave] or self.maxsidetoside[3]
        local maxbob = self.maxbob[wave] or self.maxbob[3]
        if self.toggleswitch == false then
            ang.p = math.Approach(ang.p, maxsidetoside, sidetosidespeed)
            if ang.p == maxsidetoside then
                self.toggleswitch = true
            end
        else
            ang.p = math.Approach(ang.p, -maxsidetoside, sidetosidespeed)
            if ang.p == -maxsidetoside then
                self.toggleswitch = false
            end
        end

        if self.togglebob == false then
            pos.z = math.Approach(pos.z, self.baselinePoint + maxbob, bobspeed)
            if pos.z == self.baselinePoint + maxbob then
                self.togglebob = true
            end
        else
            pos.z = math.Approach(pos.z, self.baselinePoint - maxbob, bobspeed)
            if pos.z == self.baselinePoint - maxbob then
                self.togglebob = false
            end
        end

        if self.toggleswitchr2 == false then
            ang.r = math.Approach(ang.r, maxsidetoside, sidetosidespeed)
            if ang.r == maxsidetoside then
                self.toggleswitchr2 = true
            end
        else
            ang.r = math.Approach(ang.r, -maxsidetoside, sidetosidespeed)
            if ang.r == -maxsidetoside then
                self.toggleswitchr2 = false
            end
        end
        
        ang.y = ang.y 
        self:SetAngles(ang)
        -- Do not call self:SetPos(pos) here, so the physical position is unaffected.
        self:DrawModel()
    end
end

hook.Add("PostDrawOpaqueRenderables", "OilTerminalRewardHalo", function()

    if entitytarget and showRetroMessage then
        local pos = entitytarget
        --print(pos)
        
        local glowColor = Color(255, 0, 0, 255);
        render.SetColorMaterialIgnoreZ()
        render.SetMaterial(glowMaterial);
        render.DrawSprite(pos, 120, 120, glowColor);
    end

    local haloItems = {}
    for _, ent in ipairs(ents.GetAll()) do
        if ent:GetNWBool("OilTerminalReward", false) then
            table.insert(haloItems, ent)
        end
    end
    if #haloItems > 0 then
        halo.Add(haloItems, Color(255, 100, 0), 5, 5, 1, true, true)
    end
end)

local messagetypes = {
    [1] = [[
    C:\> OIL_TERMINAL_INIT.EXE
    Loading system modules... [OK]
    Initializing corpsing procedures... [OK]
    Fracking [##,### L] in AREA - 181... [OK]
    System Ready.
    ]],
    [2] = [[
    System update: Layer One Fracked... [OK]
    Resetting equipment...
    All processes completed. Awaiting next activation.
    ]],
    [3] = [[
    System update: Layer Two Fracked... [OK]
    Initializing dispersion procedures... [OK]
    Resetting equipment...
    All processes completed. Awaiting next activation.
    ]],
    [4] = [[
    System update: Layer Three Fracked... [OK]
    Resetting equipment...
    All processes completed. Awaiting next activation.
    ]],
    [5] = [[
    System update: Layer Four Fracked... [OK]
    CRITICAL WARNING: Approaching restricted depth...
    CRITICAL WARNING: Cleanser Advisory...
    Resetting equipment...
    All processes completed. Awaiting next activation.
    ]],
    [6] = [[
    System update: Layer Five Fracked... [OK]
    CRITICAL WARNING: Depth Exceeded...
    All processes Canceled.
    ]],
    [900] = [[
    Critical Damage. Terminating sequence...
    System update: Layer Fracked... [X]
    All processes Canceled.
    ]],
}

local currentChar = 1
local displayedText = ""
local typingSpeed = 0.05          -- seconds per character for overall typing
local messageComplete = false
local fadeStartTime = nil
local fadeDelay = 2             -- seconds to wait after message completes before fading
local fadeDuration = 3          
  
local lastTypingUpdate = 0
local lineDelay = 1.5            
local nextCharTime = 0
local message = ""

local finalNumber = ""         
local numberCycleStartTime = nil
local numberUpdateInterval = 2.0  -- seconds per digit revealed

local function GenerateFinalNumber()
    local n = math.random(10000, 29999)
    local s = tostring(n)
    return s:sub(1,2) .. "," .. s:sub(3)
end

local function GetAnimatedNumber()
    if not numberCycleStartTime then
        numberCycleStartTime = CurTime()
    end

    local elapsedTime = CurTime() - numberCycleStartTime
    local fixedDigits = math.floor(elapsedTime / numberUpdateInterval)
    
    local animated = ""
    local digitCount = 0
    for i = 1, #finalNumber do
        local ch = finalNumber:sub(i, i)
        if ch:match("%d") then
            digitCount = digitCount + 1
            if digitCount <= fixedDigits then
                animated = animated .. ch
            else
                animated = animated .. tostring(math.random(0, 9))
            end
        else
            animated = animated .. ch
        end
    end
    return "["..animated.." L]"
end

local function DrawFuzzyText(text, x, y, font, baseColor, fuzzyColor, offset)
    surface.SetFont(font)
    for dx = -offset, offset do
        for dy = -offset, offset do
            if dx ~= 0 or dy ~= 0 then
                surface.SetTextColor(fuzzyColor.r, fuzzyColor.g, fuzzyColor.b, fuzzyColor.a)
                surface.SetTextPos(x + dx, y + dy)
                surface.DrawText(text)
            end
        end
    end
    surface.SetTextColor(baseColor.r, baseColor.g, baseColor.b, baseColor.a)
    surface.SetTextPos(x, y)
    surface.DrawText(text)
end

local function DrawGlitchedWord(text, x, y, baseColor, glitchIntensity)
    DrawFuzzyText(text, x, y, "RetroConsole", baseColor, Color(0, 0, 0, baseColor.a), 1)
    local numFragments = math.ceil(glitchIntensity * 10)
    for i = 1, numFragments do
        local offsetX = math.random(-15, 15)
        local offsetY = math.random(-15, 15)
        local fragment = string.gsub(text, ".", function(c)
            if math.random() < glitchIntensity then
                return string.char(math.random(33, 126))
            else
                return c
            end
        end)
        local glitchColor = Color(
            math.Clamp(baseColor.r + math.random(-50, 50), 0, 255),
            math.Clamp(baseColor.g + math.random(-50, 50), 0, 255),
            math.Clamp(baseColor.b + math.random(-50, 50), 0, 255),
            math.random(100, 200)
        )
        DrawFuzzyText(fragment, x + offsetX, y + offsetY, "RetroConsole", glitchColor, Color(0, 0, 0, glitchColor.a), 1)
    end
end

local function UpdateTyping(usemsg)
    if CurTime() < nextCharTime then return end
    if !usemsg then 
        message = messagetypes[1]
    elseif messagetypes[usemsg] then
        message = messagetypes[usemsg]
    else
        message = messagetypes[2]
    end
    if message and (currentChar <= #message) then
        local nextChar = message:sub(currentChar, currentChar)
        displayedText = string.sub(message, 1, currentChar)
        surface.PlaySound("fiend/computerchirp.wav")
        currentChar = currentChar + 1
        if nextChar == "\n" then
            nextCharTime = CurTime() + lineDelay
        else
            nextCharTime = CurTime()
        end
        if currentChar > #message and not messageComplete then
            messageComplete = true
            fadeStartTime = CurTime()
            if debugEnabled then
                print("[RetroMessage DEBUG] Message complete. Fade will start in " .. fadeDelay .. " seconds.")
            end
        end
    end
end

surface.CreateFont("RetroConsole", {
    font = "Consolas",
    size = 24,
    weight = 500,
    antialias = true,
})

net.Receive("ShowRetroMessage", function()
    entitytarget = Vector(0, 0, 0)
    showRetroMessage = net.ReadBool()
    entitytarget.X = net.ReadDouble()
    entitytarget.Y = net.ReadDouble()
    entitytarget.Z = net.ReadDouble()
    showRetroMessageType = net.ReadFloat()
    print(entitytarget)
    
    if debugEnabled then
        print("[RetroMessage DEBUG] Received net message. showRetroMessage set to: " .. tostring(showRetroMessage))
    end
    if showRetroMessage then
        currentChar = 1
        displayedText = ""
        messageComplete = false
        fadeStartTime = nil
        numberCycleStartTime = CurTime()  -- reset the number animation timer
        finalNumber = GenerateFinalNumber()  -- randomize final number (e.g., "19,998")
        if debugEnabled then
            print("[RetroMessage DEBUG] Final number randomized to: " .. finalNumber)
        end
    end
end)
--
hook.Add("HUDPaint", "RetroCommandLineHUD", function()
    if not LocalPlayer():IsValid() then return end

    local usemsg = showRetroMessageType

    if showRetroMessage then


        if (CurTime() - lastTypingUpdate) > typingSpeed then
            lastTypingUpdate = CurTime()
            UpdateTyping(usemsg)
            
        end

        local alpha = 255
        if messageComplete and fadeStartTime then
            local timeSinceFadeStart = CurTime() - fadeStartTime
            if timeSinceFadeStart > fadeDelay then
                alpha = math.Clamp(255 - ((timeSinceFadeStart - fadeDelay) / fadeDuration * 255), 0, 255)
            end
        end

        if alpha <= 0 then
            showRetroMessage = false
            return
        end

        surface.SetFont("RetroConsole")
        local rawLines = string.Explode("\n", displayedText)
        local lines = {}
        for _, line in ipairs(rawLines) do
            line = string.gsub(line, "%[##,### L%]", GetAnimatedNumber())
            table.insert(lines, line)
        end

        local maxWidth = 0
        local totalHeight = 0
        local extraLineSpacing = 20
        for _, line in ipairs(lines) do
            local w, h = surface.GetTextSize(line)
            if w > maxWidth then maxWidth = w end
            totalHeight = totalHeight + h + extraLineSpacing
        end
        totalHeight = totalHeight - extraLineSpacing

        local padding = 20
        local boxWidth = maxWidth + padding * 2
        local boxHeight = totalHeight + padding * 2
        local boxX = (ScrW() - boxWidth) / 2
        local boxY = (ScrH() - boxHeight) / 2

        --draw.RoundedBox(8, boxX, boxY, boxWidth, boxHeight, Color(0, 0, 0, alpha * 0.8))
        
        local currentY = boxY + padding
        local targetGlitchWord = "corpsing"
        local baseColor = Color(0, 255, 0, alpha)
        for _, line in ipairs(lines) do
            local w, h = surface.GetTextSize(line)
            local textX = boxX + (boxWidth - w) / 2

            local startIndex, endIndex = string.find(line, targetGlitchWord)
            if !startIndex then
                local targetGlitchWord = "Cleanser"
                local startIndex, endIndex = string.find(line, targetGlitchWord)
            end
            if startIndex then
                local beforeText = string.sub(line, 1, startIndex - 1)
                local glitchText = string.sub(line, startIndex, endIndex)
                local afterText = string.sub(line, endIndex + 1)
                
                local beforeWidth = surface.GetTextSize(beforeText)
                local succ1, err1 = pcall(function()
                    DrawFuzzyText(beforeText, textX, currentY, "RetroConsole", baseColor, Color(0, 0, 0, alpha), 1)
                end)
                if !succ1 then
                    print("Shutting down fuzzy text. Major error.")
                end
                
                local glitchX = textX + beforeWidth
                local succ4, err4 = pcall(function()
                    DrawGlitchedWord(glitchText, glitchX, currentY, baseColor, 0.3)
                end)
                if !succ4 then
                    print("Shutting down glitchy text. Major error.")
                end
                
                local glitchWidth = surface.GetTextSize(glitchText)
                local afterX = glitchX + glitchWidth
                local succ2, err2 = pcall(function()
                    DrawFuzzyText(afterText, afterX, currentY, "RetroConsole", baseColor, Color(0, 0, 0, alpha), 1)
                end)
                if !succ2 then
                    print("Shutting down fuzzy text. Major error.")
                end
            else
                local succ3, err3 = pcall(function()
                    DrawFuzzyText(line, textX, currentY, "RetroConsole", baseColor, Color(0, 0, 0, alpha), 1)
                end)
                if !succ3 then
                    print("Shutting down fuzzy text. Major error.")
                end
            end

            currentY = currentY + h + extraLineSpacing
        end

        if math.floor(CurTime() * 2) % 2 == 0 then
            local lastLine = lines[#lines] or ""
            local lw, lh = surface.GetTextSize(lastLine)
            local cursorX = boxX + (boxWidth - maxWidth) / 2 + lw
            local cursorY = currentY - extraLineSpacing - lh
            surface.SetFont("RetroConsole")
            surface.SetTextColor(baseColor)
            surface.SetTextPos(cursorX, cursorY)
            surface.DrawText("|")
        end
    end
end)

Clockwork.chatBox:RegisterClass("machine", "ic", function(info)
    Clockwork.chatBox:Add(info.filtered, nil, Color(183,65,14), info.text)
end)



hook.Add("RenderScreenspaceEffects", "WarningLightFlashing", function()
    if !showRetroMessage then
        if IsValid(light) then light:Remove() end
        return 
    end
    if !IsValid(light) and entitytarget then
        if IsValid(light) then light:Remove() end
        print(entitytarget)
        light = ProjectedTexture()
        light:SetTexture("effects/flashlight001")
        light:SetFarZ(900)
        light:SetNearZ(10)
        light:SetFOV(140)
        light:SetColor(Color(255, 0, 0))
        light:SetBrightness(10)
        light:SetEnableShadows(false)
        local pos = entitytarget
        light:SetPos(pos)
        return
    end
    if !IsValid(light) then return end
    local ply = LocalPlayer()
    if !IsValid(ply) then return end
    if !entitytarget then return end
    
    local pos = entitytarget
    --print(pos)
    local glowColor = Color(255, 0, 0, 255);
    render.SetColorMaterialIgnoreZ()
    render.SetMaterial(glowMaterial);
    render.DrawSprite(pos, 64, 64, glowColor);
    angle = (angle + 180 * FrameTime()) % 360 -- Rotate smoothly
    
    local ang = Angle(0, angle, 0)

    light:SetPos(pos)
    light:SetAngles(ang)
    light:Update()
    
    --local flash = math.sin(CurTime() * 10) > 0 -- Flashing effect
    --light:SetBrightness(flash and 10 or 0)
end)

hook.Add("ShutDown", "WarningLightCleanup", function()
    if IsValid(light) then light:Remove() end
end)