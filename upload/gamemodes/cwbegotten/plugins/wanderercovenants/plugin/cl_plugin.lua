local wanderCovMainFrame = {};
local PANEL = {};
local menu;

local topBackground = Material("begotten/ui/oilcanvas.png")
local gradientDown = surface.GetTextureID("gui/gradient_down")
local topFrame = Material("begotten/ui/panelframe.png")
local bottomBackground = Material("begotten/ui/collapsible3-1-10.png")
local bottomFrame = Material("begotten/ui/panelframe88.png")
local buttonMaterial = Material("begotten/ui/butt24.png")
local buttonMaterialTwo = Material("begotten/ui/buttonrecolored.png")

cwWandererCovenants.covenantBeliefCosts = {2000, 5000, 8500, 15000, 25000, 30000}


local BeliefsTable = {
    eternal = {
        niceName = "Eternal Flame",
        desc = "Increased fire resistance"
    },
    balance = {
        niceName = "Sacred Balance",
        desc = "Boosts harmony and order"
    },
    keeper = {
        niceName = "Void Keeper",
        desc = "Control over void energies"
    },
    shattered = {
        niceName = "Shattered Veil",
        desc = "Unveils hidden dimensions"
    },
    echoes = {
        niceName = "Echoes Infinity",
        desc = "Hears whispers of the past"
    },
    warden = {
        niceName = "Mystery Warden",
        desc = "Guard secrets from enemies"
    },
    shadow = {
        niceName = "Truth Shadow",
        desc = "Enhances stealth and secrecy"
    },
    firstborn = {
        niceName = "Firstborn",
        desc = "Ancient wisdom and power"
    },
    guardians = {
        niceName = "Forgotten Guardians",
        desc = "Defensive power and vigilance"
    },
    heart = {
        niceName = "Heart Stone",
        desc = "Unyielding strength and resilience"
    },
    next = {
        niceName = "Next Awakening",
        desc = "Future foresight and awakening"
    },
    totality = {
        niceName = "Echoes of Totality",
        desc = "It is here."
    },
    threads = {
        niceName = "Unravel the Threads",
        desc = "Threads come undone.."
    },
    final = {
        niceName = "Final Awakening",
        desc = "The final one."
    },
    ascension = {
        niceName = "Primordial Ascension",
        desc = "Ascend!!"
    }
}

UglyNamesTable = {
    ["The Eternal Flame"] = "eternal",
    ["The Sacred Balance"] = "balance",
    ["Keeper of the Void"] = "keeper",
    ["The Shattered Veil"] = "shattered",
    ["Echoes of Infinity"] = "echoes",
    ["Warden of Mysteries"] = "warden",
    ["Shadow of Truth"] = "shadow",
    ["The Firstborn"] = "firstborn",
    ["Forgotten Guardians"] = "guardians",
    ["Heart of Stone"] = "heart",
    ["The Next Awakening"] = "next",
    ["The Final Awakening"] = "final",
    ["Unravel the Threads"] = "threads",
    ["Echoes of Totality"] = "totality",
    ["Primordial Ascension"] = "ascension"
}


local beliefs = {
    Militant = {
        name = "Militant",
        color = Color(255,0,0),
        nodes = {
            [1] = {
                {name = "The Eternal Flame", description = "A belief rooted in the endless cycle of creation and destruction.", quote = "\"From ashes we rise, and to ashes we shall return.\"", req = {}, align = 1, icon = "begotten/ui/belieficons/primeval.png"}
            },
            [2] = {
                {name = "The Sacred Balance", description = "Harmony between light and dark, order and chaos.", quote = "\"In balance, we find the truth.\"", req = {"eternal"}, align = 0, icon = "begotten/ui/belieficons/primeval.png"},
                {name = "Keeper of the Void", description = "The void is neither good nor evil, but a force to be revered.", quote = "\"The void takes, and the void gives.\"", req = {"eternal"}, align = 0, icon = "begotten/ui/belieficons/primeval.png"}
            },
            [3] = {
                {name = "Primordial Ascension", description = "The oldest forces shape the future of all life.", quote = "\"To ascend is to return to our origin.\"", req = {"balance", "keeper"}, align = 1, icon = "begotten/ui/belieficons/primeval.png"}
            }
        }
    },
    
    Mercantile = {
        name = "Mercantile",
        color = Color(0,255,81),
        nodes = {
            [1] = {
                {name = "The Shattered Veil", description = "Reality is fragile, and beyond it lies the unknown.", quote = "\"Break the veil and embrace the infinite.\"", req = {}, align = 0, icon = "begotten/ui/belieficons/primeval.png"},
                {name = "Echoes of Infinity", description = "Whispers from the unknown guide those who listen.", quote = "\"In silence, the echoes speak.\"", req = {}, align = 0, icon = "begotten/ui/belieficons/primeval.png"}
            },
            [2] = {
                {name = "Warden of Mysteries", description = "A keeper of secrets that should never be revealed.", quote = "\"The greatest power lies in what is hidden.\"", req = {"shattered"}, align = 0, icon = "begotten/ui/belieficons/primeval.png"},
                {name = "Shadow of Truth", description = "Truth exists in the shadows, known to few.", quote = "\"In shadows, the light of truth is hidden.\"", req = {"echoes"}, align = 0, icon = "begotten/ui/belieficons/primeval.png"}
            },
            [3] = {
                {name = "Unravel the Threads", description = "To unravel the fabric of reality is to reshape destiny.", quote = "\"Pull the thread, and the world unravels.\"", req = {"warden", "shadow"}, align = 1, icon = "begotten/ui/belieficons/primeval.png"}
            }
        }
    },
    
    Religious = {
        name = "Religious",
        color = Color(246,255,0),
        nodes = {
            [1] = {
                {name = "The Firstborn", description = "The oldest beings carry the wisdom of the ages.", quote = "\"To hear the Firstborn is to listen to time itself.\"", req = {}, align = 0, icon = "begotten/ui/belieficons/primeval.png"},
                {name = "Forgotten Guardians", description = "The protectors of a forgotten age still watch over us.", quote = "\"The forgotten are not gone. They wait.\"", req = {}, align = 0, icon = "begotten/ui/belieficons/primeval.png"}
            },
            [2] = {
                {name = "Heart of Stone", description = "A belief in enduring strength, immovable like the mountains.", quote = "\"What is strong never crumbles, only shapes the world around it.\"", req = {"firstborn"}, align = 0, icon = "begotten/ui/belieficons/primeval.png"},
                {name = "Echoes of Totality", description = "Every action reverberates across time and space.", quote = "\"The totality of your existence lasts beyond death.\"", req = {"guardians"}, align = 0, icon = "begotten/ui/belieficons/primeval.png"}
            },
            [3] = {
                {name = "The Final Awakening", description = "When all things end, the ancients shall rise once more.", quote = "\"The end is merely the beginning for those who remember.\"", req = {"heart"}, align = 0, icon = "begotten/ui/belieficons/primeval.png"},
                {name = "The Next Awakening", description = "When all things end, the ancients shall rise once more.", quote = "\"The end is merely the beginning for those who remember.\"", req = {"totality"}, align = 0, icon = "begotten/ui/belieficons/primeval.png"}
            }
        }
    }
}

-- Custom fonts
surface.CreateFont("DermaHeader", {
    font    = "Roboto",
    size    = 40,
    weight  = 700,
    extended = true,
    antialias = true,
})

surface.CreateFont("DermaSubheader", {
    font    = "Roboto",
    size    = 28,
    weight  = 300,
    extended = true,
    antialias = true,
})

surface.CreateFont("DermaBody", {
    font    = "Roboto",
    size    = 28,
    weight  = 400,
    extended = true,
    antialias = true,
})

surface.CreateFont("DermaBodySmall", {
    font    = "Roboto",
    size    = 16,
    weight  = 200,
    extended = true,
    antialias = true,
})

surface.CreateFont("DermaSmall", {
    font    = "Roboto",
    size    = 20,
    weight  = 300,
    extended = true,
    antialias = true,
})

 surface.CreateFont("DermaMedium", {
    font    = "Roboto",
    size    = 24,
    weight  = 300,
    extended = true,
    antialias = true,
})

surface.CreateFont("DermaTiny", {
    font    = "Roboto",
    size    = 15,
    weight  = 300,
    extended = true,
    antialias = true,
})

local DARK_RED = Color(161, 26, 26, 98)
local WHITE = Color(255, 255, 255)
local VLIGHT_GRAY = Color(200, 200, 200)
local BRIGHT_RED = Color(207, 22, 22, 117)
local HardLocked = Color(100, 100, 100, 150)
local Locked = Color(160, 100, 100, 235)
local Unlockable = Color(160, 120, 90, 230)
local Unlocked = Color(180, 175, 150, 250)


-- ROMAN NUMERAL SHIT MOVE TO ANOTHER FILE LATER
local map = { 
    I = 1,
    V = 5,
    X = 10,
    L = 50,
    C = 100, 
    D = 500, 
    M = 1000,
}
local numbers = { 1, 5, 10, 50, 100, 500, 1000 }
local chars = { "I", "V", "X", "L", "C", "D", "M" }

local RomanNumerals = { }

function RomanNumerals.ToRomanNumerals(s)
    --s = tostring(s)
    s = tonumber(s)
    if not s or s ~= s then error"Unable to convert to number" end
    if s == math.huge then error"Unable to convert infinity" end
    s = math.floor(s)
    if s <= 0 then return s end
	local ret = ""
        for i = #numbers, 1, -1 do
        local num = numbers[i]
        while s - num >= 0 and s > 0 do
            ret = ret .. chars[i]
            s = s - num
        end
        --for j = i - 1, 1, -1 do
        for j = 1, i - 1 do
            local n2 = numbers[j]
            if s - (num - n2) >= 0 and s < num and s > 0 and num - n2 ~= n2 then
                ret = ret .. chars[j] .. chars[i]
                s = s - (num - n2)
                break
            end
        end
    end
    return ret
end

function RomanNumerals.ToNumber(s)
    s = s:upper()
    local ret = 0
    local i = 1
    while i <= s:len() do
    --for i = 1, s:len() do
        local c = s:sub(i, i)
        if c ~= " " then -- allow spaces
            local m = map[c] or error("Unknown Roman Numeral '" .. c .. "'")
            
            local next = s:sub(i + 1, i + 1)
            local nextm = map[next]
            
            if next and nextm then
                if nextm > m then 
                -- if string[i] < string[i + 1] then result += string[i + 1] - string[i]
                -- This is used instead of programming in IV = 4, IX = 9, etc, because it is
                -- more flexible and possibly more efficient
                    ret = ret + (nextm - m)
                    i = i + 1
                else
                    ret = ret + m
                end
            else
                ret = ret + m
            end
        end
        i = i + 1
    end
    return ret
end


-- Helper function for sorting players given their rank
local function SortPlayersByRank(players, rankConfig)
    local rankPriority = {}
    for i, rank in ipairs(rankConfig) do
        rankPriority[rank.name] = i
    end

    table.sort(players, function(a, b)
        return (rankPriority[a.rank] or #rankConfig + 1) < (rankPriority[b.rank] or #rankConfig + 1)
    end)
end

-- Request covenant data
function cwWandererCovenants:AskForCovenantData()
    netstream.Start("PlayerCovenantGetUpdate", false)
end

-- Old way of opening the covenant panel, remove in future
function cwWandererCovenants:CreateWandererConveantsPanel(covPlayers, covName, covStats, covBeliefs, covConfig, covTypes)
    local covName = covName or "No Party"
    if IsValid(wanderCovMainFrame) then
        wanderCovMainFrame:Close()
    end

    wanderCovMainFrame = vgui.Create("DFrame")
    wanderCovMainFrame:SetSize(800, 500)
    wanderCovMainFrame:SetTitle("Covenant - " .. covName)
    wanderCovMainFrame:Center()
    wanderCovMainFrame:MakePopup()

    -- Create a top panel to contain left and right panels
    local topPanel = vgui.Create("DPanel", wanderCovMainFrame)
    topPanel:Dock(TOP)
    topPanel:SetTall(170)

    -- Create the left panel
    local leftPanel = vgui.Create("DPanel", topPanel)
    leftPanel:Dock(LEFT)
    leftPanel:SetWide(300)

    -- Create the left panel
    local topCenterPanel = vgui.Create("DPanel", topPanel)
    topCenterPanel:Dock(FILL)

    -- Create a panel for the labels
    local infoPanel = vgui.Create("DPanel", topCenterPanel)
    infoPanel:Dock(FILL)
    infoPanel:DockMargin(10,10,10,10)

    -- Create the Header label
    local headerLabel = vgui.Create("DLabel", infoPanel)
    headerLabel:SetText(covName)
    headerLabel:SetFont("DermaHeader")
    headerLabel:SetTextColor(Color(255, 255, 255))
    headerLabel:SetPos(0, 0)
    headerLabel:SizeToContents()

    -- Create the Date Founded label
    local dateLabel = vgui.Create("DLabel", infoPanel)
    dateLabel:SetText("Founded on 8/9")
    dateLabel:SetFont("DermaBody")
    dateLabel:SetTextColor(Color(200, 200, 200)) 
    dateLabel:SetPos(0, 30)
    dateLabel:SizeToContents()

    -- Create the Type label
    local typeLabel = vgui.Create("DLabel", infoPanel)
    typeLabel:SetText("Type: Caravan")
    typeLabel:SetFont("DermaBody")
    typeLabel:SetTextColor(Color(200, 200, 200))
    typeLabel:SetPos(0, 50)
    typeLabel:SizeToContents()

    -- Optional: Create a small footer label
    local footerLabel = vgui.Create("DLabel", infoPanel)
    footerLabel:SetText("Additional Info")
    footerLabel:SetFont("DermaSmall")
    footerLabel:SetTextColor(Color(150, 150, 150)) 
    footerLabel:SetPos(10, 160)
    footerLabel:SetContentAlignment(5)
    footerLabel:SizeToContents()

    -- Create the leader panel and center it within the left panel
    local leaderPanel = vgui.Create("DPanel", leftPanel)
    leaderPanel:SetSize(150, 150)
    leaderPanel:SetPos(10,10)
    leaderPanel.Paint = function(self, w, h)
        surface.SetMaterial(topFrame)
        surface.DrawTexturedRect(0,0,w,h)
    end

    -- Create the leader panel and center it within the left panel
    local buttonPanel = vgui.Create("DPanel", leftPanel)
    buttonPanel:SetSize(125, 150)
    buttonPanel:SetPos(165, 10)

    -- Create a container for buttons
    local buttonContainer = vgui.Create("DPanel", buttonPanel)
    buttonContainer:Dock(FILL)
    buttonContainer:DockMargin(5, 5, 5, 5)

    local buttons = {"Create", "Type", "Invite", "Disband", "Beliefs", "Ranks", "Leave"}
    local amtBtns, startPos = 2, 1
    if covPlayers and next(covPlayers) then startPos = 3; amtBtns = 6 end
    local isLeader = false

    for n,q in pairs(covPlayers) do
        if n == Clockwork.Client:GetName() then
            if q.rank == covConfig.leaderRank then
                isLeader = true
            end
        end
    end
    
    local dropdown
    for i = startPos, amtBtns do
        if not isLeader and i==6 then i=7 end
        if buttons[i] == "Type" then
            dropdown = vgui.Create("DComboBox", buttonContainer)
            dropdown:Dock(TOP)
            dropdown:DockMargin(5, 5, 5, 5)
            dropdown:SetTall(25)
            dropdown:SetSortItems(false)
            dropdown:SetValue("Select Type")
            dropdown:SetVisible(true)
            
            for _, option in ipairs(covTypes) do
                dropdown:AddChoice(option)
            end
            
            dropdown.OnSelect = function(panel, index, value)
                dropdown:SetValue(value)
            end
            
        else
            local button = vgui.Create("DButton", buttonContainer)
            button:Dock(TOP)
            button:SetTall(25) 
            button:SetText(buttons[i])
            button:DockMargin(5, 5, 5, 5)

            button.DoClick = function(b)
                local buttonName = b:GetText()
                local args = {}
                if b:GetText() == "Invite" then
                elseif b:GetText() == "Create" then
                    if dropdown and dropdown:GetSelectedID() then
                        table.insert(args, dropdown:GetSelectedID())
                    end
                end
                netstream.Start("PlayerCovenantMainButtonsClicked", {b:GetText(), covName, args})
            end
        end
    end

    -- Create the leader portrait panel
    local leaderPortrait = vgui.Create("DPanel", leaderPanel)
    leaderPortrait:Dock(TOP)
    leaderPortrait:SetTall(110)

    local spawnIcon
    leaderPortrait.Paint = function(self, w, h)
        surface.SetMaterial(topFrame)
        surface.DrawTexturedRect(0, 0, w, h)

        render.ClearStencil()
        render.SetStencilEnable(true)
        render.SetStencilWriteMask(1)
        render.SetStencilTestMask(1)
        render.SetStencilReferenceValue(1)
        
        render.SetStencilFailOperation(STENCILOPERATION_KEEP)
        render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
        render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
        render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)

        draw.NoTexture()
        surface.SetDrawColor(153, 23, 23, 100)
        draw.Circle(w / 2, h / 2, 50, 100) -- Center at (w/2, h/2) with radius 50

        render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)

        if spawnIcon then
            spawnIcon:SetPaintedManually(false) 
            spawnIcon:PaintManual()
            spawnIcon:SetPaintedManually(true)
        end

        render.SetStencilEnable(false)
    end

    -- Find leader and create the leader's spawn icon
    local leader, leaderName = nil, "Unknown"
    for k, val in pairs(covPlayers) do
        if covConfig.leaderRank == val.rank then
            leader = val
            leaderName = k
            break
        end
    end

    local spawnIconSize = 125
    spawnIcon = vgui.Create("SpawnIcon", leaderPortrait)
    spawnIcon:SetSize(spawnIconSize, spawnIconSize)

    local panelWidth, panelHeight = leaderPortrait:GetSize()
    local xPos = (panelWidth - 15 ) / 2
    local yPos = (panelHeight - spawnIconSize + 15) / 2

    spawnIcon:SetPos(xPos, yPos)
    if leader then
        spawnIcon:SetModel(leader.model, leader.skin or 0)
    else
        spawnIcon:SetModel(Clockwork.Client:GetModel(), 0)
    end

    spawnIcon:SetTooltip(nil)
    spawnIcon.OnCursorEntered = function() end
    spawnIcon.OnCursorExited = function() end
    spawnIcon.OnMousePressed = function(self, mousecode)
    end
    spawnIcon.OnMouseReleased = function(self, mousecode)
    end
    spawnIcon:SetPaintedManually(true)

    function draw.Circle(x, y, radius, seg)
        local cir = {}

        table.insert(cir, {x = x, y = y})
        for i = 0, seg do
            local a = math.rad((i / seg) * -360)
            table.insert(cir, {x = x + math.sin(a) * radius, y = y + math.cos(a) * radius})
        end

        surface.DrawPoly(cir)
    end

    
    -- Create the leader label panel
    local leaderLabelContainer = vgui.Create("DPanel", leaderPanel)
    leaderLabelContainer:Dock(FILL)
    leaderLabelContainer.Paint = function(self, w, h)
        surface.SetMaterial(buttonMaterial)
        surface.DrawTexturedRect(0,0,w,h)
    end

    local leaderLabel = vgui.Create("DLabel", leaderLabelContainer)
    leaderLabel:SetText(leaderName)
    leaderLabel:SetFont("DermaMedium")
    leaderLabel:SetColor(WHITE)
    leaderLabel:DockMargin(10, 10, 10, 10)
    leaderLabel:Dock(FILL)
    leaderLabel:SetContentAlignment(5)

    -- Create the right panel
    local rightPanel = vgui.Create("DPanel", topPanel)
    rightPanel:Dock(RIGHT)
    rightPanel:SetWide(300)

    -- Create the DListView inside the right panel
    local listView = vgui.Create("DListView", rightPanel)
    listView:Dock(FILL)
    listView:DockMargin(10,10,10,0)
    listView:SetMultiSelect(false) 
    listView.Paint = function(self, w, h)
        surface.SetDrawColor(58, 50, 50, 0) 
        surface.DrawRect(0, 0, w, h)
    end
    listView:AddColumn("Effect Name"):SetWidth(40) 
    listView:AddColumn("Description"):SetWidth(180)

    for _, effect in ipairs(covBeliefs) do
        listView:AddLine(effect[1], effect[2])
    end
    if #covBeliefs == 0 then
        listView:AddLine("", "No benefits active.")
    end

    for _, line in pairs(listView:GetLines()) do
        for _, label in pairs(line.Columns) do
            label:SetTextColor(Color(218, 215, 215))
            label:SetFont("DermaSmall")
            
        end
    end

    -- Create the center panel
    local centerPanel = vgui.Create("DPanel", wanderCovMainFrame)
    centerPanel:Dock(TOP)
    centerPanel:SetSize(50,110)

    -- Create the groupStatsPanel
    local groupStatsPanel = vgui.Create("DPanel", centerPanel)
    groupStatsPanel:SetPos(300 - 100, 0)
    groupStatsPanel:SetSize(400, 110)
    groupStatsPanel.Paint = function(self, w, h)
        surface.SetMaterial(buttonMaterial)
        surface.SetDrawColor(255, 255, 255)
        surface.DrawTexturedRect(0,0,w,h)
    end

    -- Create the groupStatsLabelContainer
    local groupStatsLabelContainer = vgui.Create("DPanel", groupStatsPanel)
    groupStatsLabelContainer:Dock(TOP)
    groupStatsLabelContainer:SetTall(30)
    groupStatsLabelContainer.Paint = function(self, w, h)
        surface.SetMaterial(buttonMaterial)
        surface.DrawTexturedRect(0,0,w,h)
    end

    -- Create the groupStatsLabel
    local groupStatsLabel = vgui.Create("DLabel", groupStatsPanel)
    groupStatsLabel:SetText("Statistics")
    groupStatsLabel:SetFont("DermaLarge")
    groupStatsLabel:SetTextColor(WHITE)
    groupStatsLabel:SizeToContents()

    -- Calculate the position
    local panelWidth = groupStatsPanel:GetWide()
    local labelWidth = groupStatsLabel:GetWide()
    local offset = 400 / 2

    -- Position the label
    groupStatsLabel:SetPos((offset - labelWidth/2), 2)
    groupStatsLabel:SetContentAlignment(5)


    -- Create the groupStatsContainer
    local groupStatsContainer = vgui.Create("DPanel", groupStatsPanel)
    groupStatsContainer:Dock(FILL)
    groupStatsContainer.Paint = function(self, w, h)
        surface.DrawRect(0, 0, w, h)
    end
        
    -- Create topStats inside groupStatsContainer
    local topStats = vgui.Create("DPanel", groupStatsContainer)
    topStats:Dock(TOP)
    topStats:SetTall(45)
    topStats.Paint = function(self, w, h)
        surface.SetMaterial(buttonMaterial)
        surface.DrawTexturedRect(0,0,w,h)
    end

    -- Create botStats inside groupStatsContainer
    local topLeftStats = vgui.Create("DPanel", topStats)
    topLeftStats:Dock(LEFT)
    topLeftStats:SetWide(200)
    topLeftStats.Paint = function(self, w, h)
        surface.SetMaterial(buttonMaterial)
        surface.DrawTexturedRect(0,0,w,h)
    end

    -- Add a dummy stat label to topLeftStats
    local killsLabel = vgui.Create("DLabel", topLeftStats)
    killsLabel:SetText("Total Kills: " .. covStats.kills)
    killsLabel:SetTextColor(Color(218, 215, 215))
    killsLabel:SetFont("DermaLarge")
    killsLabel:SizeToContents()
    killsLabel:SetPos(10, 7)

    -- Create botStats inside groupStatsContainer
    local topRightStats = vgui.Create("DPanel", topStats)
    topRightStats:Dock(RIGHT)
    topRightStats:SetWide(200)
    topRightStats.Paint = function(self, w, h)
        surface.SetMaterial(buttonMaterial)
        surface.DrawTexturedRect(0,0,w,h)
    end


     -- Add a dummy stat label to topRightStats
     local killsLabel = vgui.Create("DLabel", topRightStats)
     killsLabel:SetText("Total XP: " .. covStats.xp)
     killsLabel:SetTextColor(Color(218, 215, 215))
     killsLabel:SetFont("DermaLarge")
     killsLabel:SizeToContents()
     killsLabel:SetPos(10, 7)

     -- Create botStats inside groupStatsContainer
    local botStats = vgui.Create("DPanel", groupStatsContainer)
    botStats:Dock(BOTTOM)
    botStats:SetTall(45)
    

    -- Create botStats inside groupStatsContainer
    local botLeftStats = vgui.Create("DPanel", botStats)
    botLeftStats:Dock(LEFT)
    botLeftStats:SetWide(200)
    botLeftStats.Paint = function(self, w, h)
        surface.SetMaterial(buttonMaterial)
        surface.DrawTexturedRect(0,0,w,h)
    end


     -- Add a dummy stat label to botLeftStats
     local killsLabel = vgui.Create("DLabel", botLeftStats)
     killsLabel:SetText("Total Deaths: " .. covStats.deaths)
     killsLabel:SetTextColor(Color(218, 215, 215))
     killsLabel:SetFont("DermaLarge")
     killsLabel:SizeToContents()
     killsLabel:SetPos(10, 7)


    -- Create botStats inside groupStatsContainer
    local botRightStats = vgui.Create("DPanel", botStats)
    botRightStats:Dock(RIGHT)
    botRightStats:SetWide(200)
    botRightStats.Paint = function(self, w, h)
        surface.SetMaterial(buttonMaterial)
        surface.DrawTexturedRect(0,0,w,h)
    end

    -- Add a dummy stat label to botLeftStats
    local killsLabel = vgui.Create("DLabel", botRightStats)
    killsLabel:SetText("Live Members: " .. covStats.totalAlive)
    killsLabel:SetFont("DermaLarge")
    killsLabel:SetTextColor(Color(218, 215, 215))
    killsLabel:SizeToContents()
    killsLabel:SetPos(10, 7)

    -- Create the bottom panel
    local bottomPanel = vgui.Create("DPanel", wanderCovMainFrame)
    bottomPanel:Dock(BOTTOM)
    bottomPanel:SetTall(180)
    bottomPanel.Paint = function(self, w, h)
        surface.SetMaterial(bottomBackground)
        surface.DrawTexturedRect(0, 0, w+10, h+10)

        surface.SetMaterial(topBackground)
        surface.DrawTexturedRect(5,5, w-10, h-10)
    end

    -- Create the label at the top center of the bottom panel
    local titleLabel = vgui.Create("DLabel", bottomPanel)
    titleLabel:SetText("Players")
    titleLabel:SetFont("DermaLarge")
    titleLabel:SetTextColor(Color(255, 255, 255))
    titleLabel:SizeToContents() 

    -- Position the label
    function bottomPanel:PerformLayout()
        local panelWidth = self:GetWide()
        local labelWidth = titleLabel:GetWide()
        titleLabel:SetPos((panelWidth - labelWidth) / 2, 2)
    end

    -- Create the scroll panel and attach it to the bottom panel
    local scrollPanel = vgui.Create("DScrollPanel", bottomPanel)
    scrollPanel:Dock(FILL)
    scrollPanel:DockMargin(5, 32, 5, 5)

    -- Create the panel that will contain the player icons
    local playersPanel = vgui.Create("DPanel", scrollPanel)
    playersPanel:Dock(TOP)
    playersPanel:SetTall(155) 
    playersPanel:SetWide(1000)

    -- Set up horizontal layout for the player icons
    local x, y = 5,5
    local iconSize = 72
    local margin = 5
    SortPlayersByRank(covPlayers, covConfig.ranks)
    table.insert(covPlayers, covPlayers[1])
         surface.CreateFont("DermaTiny", {
            font    = "Roboto",
            size    = 15,
            weight  = 300,
            extended = true,
            antialias = true,
        })
    if next(covPlayers) then
        for i, playerData in pairs(covPlayers) do
            local textColor = Color(255,255,255)
            if playerData.model then 
                local playerPanel = vgui.Create("DPanel", playersPanel)
                playerPanel:SetSize(iconSize, iconSize)
                playerPanel:SetPos(x, y)
                playerPanel.Paint = function(self, w, h)
                    surface.SetDrawColor(161, 26, 26, 98)
                    surface.DrawRect(0, 0, w, h)
                end

                local spawnIcon = vgui.Create("cwSpawnIcon", playerPanel)
                spawnIcon:SetModel(playerData.model, playerData.skin or 0) 
                spawnIcon:SetSize(iconSize - 20, iconSize - 20)
                spawnIcon:SetPos(10, 8)

                if playerData.alive == nil or not playerData.alive then
                    spawnIcon.PaintOver = function(self, w, h)
                        draw.SimpleText("X", "DermaLarge", w / 2, h / 2, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    end
                    textColor = Color(255,0,0,255)
                end
                

           
                local nameLabel = vgui.Create("DLabel", playerPanel)
                nameLabel:SetText(i or "Unknown")
                nameLabel:SetFont("DermaTiny")
                nameLabel:Dock(BOTTOM)
                nameLabel:SetContentAlignment(5)
                nameLabel:SetTextColor(textColor)
                nameLabel:SizeToContents()

                function spawnIcon.DoClick(b)
                    local menu = DermaMenu()
                    
                    -- Add a custom panel to display character's name
                    local namePanel = vgui.Create("DPanel", menu)
                    namePanel:SetSize(125, 22)
                    namePanel.Paint = function(self, w, h)
                        derma.SkinHook("Paint", "MenuOption", self, w, h)
                    end

                    local nameLabelMenu = vgui.Create("DLabel", namePanel)
                    nameLabelMenu:SetText(i or "Unknown") 
                    nameLabelMenu:SetFont("DermaDefault")
                    nameLabelMenu:SizeToContents()
                    nameLabelMenu:SetPos((namePanel:GetWide() - nameLabelMenu:GetWide()) / 2, (namePanel:GetTall() - nameLabelMenu:GetTall()) / 2)
                    menu:AddPanel(namePanel)

                    local rankPanel = vgui.Create("DPanel", menu)
                    rankPanel:SetSize(125, 22)
                    rankPanel.Paint = function(self, w, h)
                        derma.SkinHook("Paint", "MenuOption", self, w, h)
                    end

                    local rankLabelMenu = vgui.Create("DLabel", rankPanel)
                    rankLabelMenu:SetText(playerData.rank or "Unknown Rank") 
                    rankLabelMenu:SetFont("DermaDefault")
                    rankLabelMenu:SizeToContents()
                    rankLabelMenu:SetPos((rankPanel:GetWide() - rankLabelMenu:GetWide()) / 2, (rankPanel:GetTall() - rankLabelMenu:GetTall()) / 2)
                    menu:AddPanel(rankPanel)
                    menu:AddOption("Kick", function()
                        netstream.Start("PlayerCovenantKickPlayer", {covName, Clockwork.Client:GetName(), i})
                    end)
                    
                    local submenu = menu:AddSubMenu("Adjust Rank", function()
                    end)
                
                    for q, rank in pairs(covConfig.ranks) do
                        submenu:AddOption(rank.name, function()
                            netstream.Start("PlayerCovenantAdjustRank", {covName, Clockwork.Client:GetName(), i, q})
                        end)
                    end
                    
                    local x, y = gui.MousePos()
                    menu:Open()
                    menu:SetPos(x, y)
                end

                spawnIcon.OnCursorEntered = function()
                    playerPanel.Paint = function(self, w, h)
                        surface.SetDrawColor(207, 22, 22, 117)
                        surface.DrawRect(0, 0, w, h)
                    end
                end

                spawnIcon.OnCursorExited = function()
                    playerPanel.Paint = function(self, w, h)
                        surface.SetDrawColor(161, 26, 26, 98)
                        surface.DrawRect(0, 0, w, h)
                    end
                end

                x = x + iconSize + margin
                if x > playersPanel:GetWide() - iconSize then
                    x = 0
                    y = y + iconSize + margin
                end
            end
        end
    end
end


-- Store covenant data stream
function cwWandererCovenants:UpdateCovenantPanelData(covPlayers, covName, covStats, covBeliefs, covConfig, covTypes)
    cwWandererCovenants.activePanel.serverData = {}
    cwWandererCovenants.activePanel.serverData = {covPlayers = covPlayers, covName = covName, covStats = covStats, covBeliefs = covBeliefs, covConfig = covConfig, covTypes = covTypes}

    if IsValid(cwWandererCovenants.activePanel) and cwWandererCovenants.activePanel:IsVisible() then
        cwWandererCovenants.activePanel:Rebuild()
    end
end

-- Add a command that'll send datastream to the server w/ who invited the player when they accept an invite
concommand.Add("cw_AcceptCovenantInvite", function(player, cmd, args)
    if (player:Alive()) then
        local invBy = player:GetSharedVar("invitedBy")
        netstream.Start("PlayerCovenantAcceptInvite", {invBy})
    end;
end);

-- New way of build covenant panel
function PANEL:Init()
    cwWandererCovenants.activePanel = self
    if not self.serverData then
        self.serverData = {}
    end
    cwWandererCovenants:AskForCovenantData()
    
    self:SetSize(800, 500)
    self:Center()
end

function PANEL:Rebuild()
    if IsValid(self) then
        self:Clear()
    end
    cwWandererCovenants.activePanel = self
    local covName = covName or "No Party"

    local covPlayers = cwWandererCovenants.activePanel.serverData.covPlayers
    local covName = cwWandererCovenants.activePanel.serverData.covName or "N/A"
    local covStats = cwWandererCovenants.activePanel.serverData.covStats
    local covBeliefs = cwWandererCovenants.activePanel.serverData.covBeliefs
    local covConfig = cwWandererCovenants.activePanel.serverData.covConfig
    local covTypes = cwWandererCovenants.activePanel.serverData.covTypes
    

    self.topPanel = vgui.Create("DPanel", self)
    self.topPanel:Dock(TOP)
    self.topPanel:SetTall(170)
    self.topPanel:DockMargin(0, 25, 0, 0)

    -- Create the left panel
    self.leftPanel = vgui.Create("DPanel", self.topPanel)
    self.leftPanel:Dock(LEFT)
    self.leftPanel:SetWide(300)

    self.topCenterPanel = vgui.Create("DPanel", self.topPanel)
    self.topCenterPanel:Dock(FILL)

    self.infoPanel = vgui.Create("DPanel", self.topCenterPanel)
    self.infoPanel:Dock(FILL)
    self.infoPanel:DockMargin(10,10,10,10)

    -- Create the Header label
    self.headerLabel = vgui.Create("DLabel", self.infoPanel)
    self.headerLabel:SetText(covName)
    self.headerLabel:SetFont("DermaHeader")
    self.headerLabel:SetTextColor(WHITE)
    self.headerLabel:SetPos(0, 0)
    self.headerLabel:SizeToContents()

    local founded, type
    if covConfig and covConfig.dateFounded and covConfig.type then
        founded = covConfig.dateFounded
        type = covTypes[covConfig.type]
    else
        founded = "N/A"
        type = "N/A"
    end

    -- Create the Date Founded label
    self.levelLabel = vgui.Create("DLabel", self.infoPanel)
    self.levelLabel:SetText("Level:  " .. (covStats.level or 1))
    self.levelLabel:SetFont("DermaMedium")
    self.levelLabel:SetTextColor(VLIGHT_GRAY) 
    self.levelLabel:SetPos(0, 30)
    self.levelLabel:SizeToContents()

    -- Create the Date Founded label
    self.dateLabel = vgui.Create("DLabel", self.infoPanel)
    self.dateLabel:SetText("Founded:  " .. founded)
    self.dateLabel:SetFont("DermaMedium")
    self.dateLabel:SetTextColor(VLIGHT_GRAY) 
    self.dateLabel:SetPos(0, 50)
    self.dateLabel:SizeToContents()

    -- Create the Type label
    self.typeLabel = vgui.Create("DLabel", self.infoPanel)
    self.typeLabel:SetText("Type: " .. type)
    self.typeLabel:SetFont("DermaMedium")
    self.typeLabel:SetTextColor(VLIGHT_GRAY) 
    self.typeLabel:SetPos(0, 70)
    self.typeLabel:SizeToContents()

    -- Create the leader panel and center it within the left panel
    self.leaderPanel = vgui.Create("DPanel", self.leftPanel)
    self.leaderPanel:SetSize(150, 150)
    self.leaderPanel:SetPos(10,10)
    

    -- Create the leader panel and center it within the left panel
    self.buttonPanel = vgui.Create("DPanel", self.leftPanel)
    self.buttonPanel:SetSize(125, 150)
    self.buttonPanel:SetPos(165, 10)

    -- Create a container for buttons
    self.buttonContainer = vgui.Create("DPanel", self.buttonPanel)
    self.buttonContainer:Dock(FILL)
    self.buttonContainer:DockMargin(5, 5, 5, 5)

    -- Create 4 buttons based on covenant state and dock them vertically
    local buttons = {"Create", "Type", "Invite", "Disband", "Beliefs", "Ranks", "Leave"}
    local amtBtns, startPos = 2, 1
    if covPlayers and next(covPlayers) then startPos = 3; amtBtns = 6 end
    local isLeader = false

    if covPlayers and covConfig then
        for n,q in pairs(covPlayers) do
            if n == Clockwork.Client:GetName() then
                if q.rank == covConfig.leaderRank then
                    isLeader = true
                end
            end
        end
    end
    
    for i = startPos, amtBtns do
        if not isLeader and i==6 then i=7 end

        if buttons[i] == "Type" then
            self.dropdown = vgui.Create("DComboBox", self.buttonContainer)
            self.dropdown:Dock(TOP)
            self.dropdown:DockMargin(5, 5, 5, 5)
            self.dropdown:SetTall(25)
            self.dropdown:SetSortItems(false)
            self.dropdown:SetValue("Select Type")
            self.dropdown:SetVisible(true)
            
            if covTypes then
                for _, option in ipairs(covTypes) do
                    self.dropdown:AddChoice(option)
                end
            end
            
            self.dropdown.OnSelect = function(panel, index, value)
                self.dropdown:SetValue(value)
            end
            
        else
            self.button = vgui.Create("DButton", self.buttonContainer)
            self.button:Dock(TOP)
            self.button:SetTall(25)
            self.button:SetText(buttons[i])
            self.button:DockMargin(5, 5, 5, 5)

            self.button.DoClick = function(b)
                local buttonName = b:GetText()
                local args = {}
                if b:GetText() == "Invite" then
                elseif b:GetText() == "Create" then
                    if self.dropdown and self.dropdown:GetSelectedID() then
                        table.insert(args, self.dropdown:GetSelectedID())
                    end
                end
                netstream.Start("PlayerCovenantMainButtonsClicked", {b:GetText(), covName, args})
            end
        end
    end



    -- Create the leader portrait panel
    self.leaderPortrait = vgui.Create("DPanel", self.leaderPanel)
    self.leaderPortrait:Dock(TOP)
    self.leaderPortrait:SetTall(110)


    local spawnIcon
    self.leaderPortrait.Paint = function(self, w, h) -- Find a way to use a texture circle instead in the future..
        surface.SetMaterial(topFrame)
        surface.DrawTexturedRect(0, 0, w, h)

        render.ClearStencil()
        render.SetStencilEnable(true)
        render.SetStencilWriteMask(1)
        render.SetStencilTestMask(1)
        render.SetStencilReferenceValue(1)
        
        render.SetStencilFailOperation(STENCILOPERATION_KEEP)
        render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
        render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
        render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)

        draw.NoTexture()
        surface.SetDrawColor(DARK_RED)
        draw.Circle(w / 2, h / 2, 50, 100) 
        
        

        render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)

        if spawnIcon then
            spawnIcon:SetPaintedManually(false)  
            spawnIcon:PaintManual()            
            spawnIcon:SetPaintedManually(true)
        end

        render.SetStencilEnable(false)
    end

    local leader, leaderName = nil, "Unknown"
    if covPlayers and covConfig then
        for k, val in pairs(covPlayers) do
            if covConfig.leaderRank == val.rank then
                leader = val
                leaderName = k
                break
            end
        end
    end

    local spawnIconSize = 125
    spawnIcon = vgui.Create("SpawnIcon", self.leaderPortrait)
    spawnIcon:SetSize(spawnIconSize, spawnIconSize) 
    local panelWidth, panelHeight = self.leaderPortrait:GetSize()
    local xPos = (panelWidth - 15 ) / 2
    local yPos = (panelHeight - spawnIconSize + 15) / 2

    spawnIcon:SetPos(xPos, yPos)

    if leader then
        spawnIcon:SetModel(leader.model, leader.skin or 0)
    else
        spawnIcon:SetModel(Clockwork.Client:GetModel(), 0)
    end

    spawnIcon:SetTooltip(nil)
    spawnIcon.OnCursorEntered = function() end
    spawnIcon.OnCursorExited = function() end
    spawnIcon.OnMousePressed = function(self, mousecode)
    end
    spawnIcon.OnMouseReleased = function(self, mousecode)
    end

    spawnIcon:SetPaintedManually(true)
    function draw.Circle(x, y, radius, seg)
        local cir = {}
        table.insert(cir, {x = x, y = y})
        for i = 0, seg do
            local a = math.rad((i / seg) * -360)
            table.insert(cir, {x = x + math.sin(a) * radius, y = y + math.cos(a) * radius})
        end
        surface.DrawPoly(cir)
    end

    
    -- Create the leader label panel
    self.leaderLabelContainer = vgui.Create("DPanel", self.leaderPanel)
    self.leaderLabelContainer:Dock(FILL)
    self.leaderLabelContainer.Paint = function(self, w, h)
        surface.SetMaterial(buttonMaterial)
        surface.DrawTexturedRect(0,0,w,h)
    end
   
    self.leaderLabel = vgui.Create("DLabel", self.leaderLabelContainer)
    self.leaderLabel:SetText(leaderName)
    self.leaderLabel:SetFont("DermaMedium")
    self.leaderLabel:SetColor(WHITE)
    self.leaderLabel:DockMargin(10, 10, 10, 10)
    self.leaderLabel:Dock(FILL)
    self.leaderLabel:SetContentAlignment(5)

    -- Create the right panel
    self.rightPanel = vgui.Create("DPanel", self.topPanel)
    self.rightPanel:Dock(RIGHT)
    self.rightPanel:SetWide(280)

    -- Create the DListView inside the right panel
    self.listView = vgui.Create("DListView", self.rightPanel)
    self.listView:Dock(FILL)
    self.listView:DockMargin(10,10,10,0)
    self.listView:SetMultiSelect(false)

    -- Set up the paint function to use the texture
    self.listView.Paint = function(self, w, h)
        surface.SetDrawColor(58, 50, 50, 0) 
        surface.DrawRect(0, 0, w, h)
    end

    -- Add columns to the DListView
    self.listView:AddColumn("Name"):SetWidth(40)
    self.listView:AddColumn("Description"):SetWidth(180)
    
    if covBeliefs then
        for eName, effect in pairs(covBeliefs) do
            self.listView:AddLine(BeliefsTable[eName].niceName, BeliefsTable[eName].desc) 
        end
    end

    for _, line in pairs(self.listView:GetLines()) do
        for _, label in pairs(line.Columns) do
          label:SetTextColor(VLIGHT_GRAY)
          label:SetFont("DermaSmall")
        end
      end

    -- Create the center panel
    self.centerPanel = vgui.Create("DPanel", self)
    self.centerPanel:Dock(TOP)
    self.centerPanel:SetSize(50,110)

    -- Create the groupStatsPanel
    self.groupStatsPanel = vgui.Create("DPanel", self.centerPanel)
    self.groupStatsPanel:SetPos(300 - 100, 0)
    self.groupStatsPanel:SetSize(400, 110)
    self.groupStatsPanel.Paint = function(self, w, h)
        surface.SetMaterial(buttonMaterial)
        surface.SetDrawColor(WHITE)
        surface.DrawTexturedRect(0,0,w,h)
    end

    -- Create the groupStatsLabelContainer
    self.groupStatsLabelContainer = vgui.Create("DPanel", self.groupStatsPanel)
    self.groupStatsLabelContainer:Dock(TOP)
    self.groupStatsLabelContainer:SetTall(30)
    self.groupStatsLabelContainer.Paint = function(self, w, h)
        surface.SetMaterial(buttonMaterial)
        surface.DrawTexturedRect(0,0,w,h)
    end

    -- Create the groupStatsLabel
    self.groupStatsLabel = vgui.Create("DLabel", self.groupStatsPanel)
    self.groupStatsLabel:SetText("Statistics")
    self.groupStatsLabel:SetFont("DermaLarge")
    self.groupStatsLabel:SetTextColor(WHITE)
    self.groupStatsLabel:SizeToContents() 

    -- Calculate the position
    local panelWidth = self.groupStatsPanel:GetWide()
    local labelWidth = self.groupStatsLabel:GetWide()
    local offset = 400 / 2

    -- Position the label
    self.groupStatsLabel:SetPos((offset - labelWidth/2), 2)
    self.groupStatsLabel:SetContentAlignment(5)


    -- Create the groupStatsContainer
    self.groupStatsContainer = vgui.Create("DPanel", self.groupStatsPanel)
    self.groupStatsContainer:Dock(FILL)
    self.groupStatsContainer.Paint = function(self, w, h)
        surface.DrawRect(0, 0, w, h)
    end
        
    -- Create topStats inside groupStatsContainer
    self.topStats = vgui.Create("DPanel", self.groupStatsContainer)
    self.topStats:Dock(TOP)
    self.topStats:SetTall(45)
    self.topStats.Paint = function(self, w, h)
        surface.SetMaterial(buttonMaterial)
        surface.DrawTexturedRect(0,0,w,h)
    end

    -- Create botStats inside groupStatsContainer
    self.topLeftStats = vgui.Create("DPanel", self.topStats)
    self.topLeftStats:Dock(LEFT)
    self.topLeftStats:SetWide(200)
    self.topLeftStats.Paint = function(self, w, h)
        surface.SetMaterial(buttonMaterial)
        surface.DrawTexturedRect(0,0,w,h)
    end

    -- Add a dummy stat label to topLeftStats
    self.killsLabel = vgui.Create("DLabel", self.topLeftStats)
    self.killsLabel:SetText("Total Kills: " .. covStats.kills or "0")
    self.killsLabel:SetTextColor(VLIGHT_GRAY)
    self.killsLabel:SetFont("DermaLarge")
    self.killsLabel:SizeToContents()
    self.killsLabel:SetPos(10, 7)

    -- Create botStats inside groupStatsContainer
    self.topRightStats = vgui.Create("DPanel", self.topStats)
    self.topRightStats:Dock(RIGHT)
    self.topRightStats:SetWide(200)
    self.topRightStats.Paint = function(self, w, h)
        surface.SetMaterial(buttonMaterial)
        surface.DrawTexturedRect(0,0,w,h)
    end


     -- Add a dummy stat label to topRightStats
     self.killsLabel = vgui.Create("DLabel", self.topRightStats)
     self.killsLabel:SetText("Total XP: " .. covStats.xp or "0")
     self.killsLabel:SetTextColor(VLIGHT_GRAY)
     self.killsLabel:SetFont("DermaLarge")
     self.killsLabel:SizeToContents()
     self.killsLabel:SetPos(10, 7)

     -- Create botStats inside groupStatsContainer
    self.botStats = vgui.Create("DPanel", self.groupStatsContainer)
    self.botStats:Dock(BOTTOM)
    self.botStats:SetTall(45)
    

    -- Create botStats inside groupStatsContainer
    self.botLeftStats = vgui.Create("DPanel", self.botStats)
    self.botLeftStats:Dock(LEFT)
    self.botLeftStats:SetWide(200)
    self.botLeftStats.Paint = function(self, w, h)
        surface.SetMaterial(buttonMaterial)
        surface.DrawTexturedRect(0,0,w,h)
    end


     -- Add a dummy stat label to botLeftStats
     self.killsLabel = vgui.Create("DLabel", self.botLeftStats)
     self.killsLabel:SetText("Total Deaths: " .. covStats.deaths or "0")
     self.killsLabel:SetTextColor(Color(218, 215, 215))
     self.killsLabel:SetFont("DermaLarge")
     self.killsLabel:SizeToContents()
     self.killsLabel:SetPos(10, 7)


    -- Create botStats inside groupStatsContainer
    self.botRightStats = vgui.Create("DPanel", self.botStats)
    self.botRightStats:Dock(RIGHT)
    self.botRightStats:SetWide(200)
    self.botRightStats.Paint = function(self, w, h)
        surface.SetMaterial(buttonMaterial)
        surface.DrawTexturedRect(0,0,w,h)
    end

    -- Add a dummy stat label to botLeftStats
    self.killsLabel = vgui.Create("DLabel", self.botRightStats)
    self.killsLabel:SetText("Live Members: " .. covStats.totalAlive or "0")
    self.killsLabel:SetFont("DermaLarge")
    self.killsLabel:SetTextColor(VLIGHT_GRAY)
    self.killsLabel:SizeToContents()
    self.killsLabel:SetPos(10, 7) 

    -- Create the bottom panel
    self.bottomPanel = vgui.Create("DPanel", self)
    self.bottomPanel:Dock(BOTTOM)
    self.bottomPanel:SetTall(180)
    self.bottomPanel.Paint = function(self, w, h)
        surface.SetMaterial(bottomBackground)
        surface.DrawTexturedRect(0, 0, w+10, h+10)

        surface.SetMaterial(topBackground)
        surface.DrawTexturedRect(5,5, w-10, h-10)
    end

    -- Create the label at the top center of the bottom panel
    titleLabel = vgui.Create("DLabel", self.bottomPanel)
    titleLabel:SetText("Players")
    titleLabel:SetFont("DermaLarge")
    titleLabel:SetTextColor(WHITE)
    titleLabel:SizeToContents() 

    -- Position the label
    function self.bottomPanel:PerformLayout()
        local panelWidth = self:GetWide()
        local labelWidth = titleLabel:GetWide()
        titleLabel:SetPos((panelWidth - labelWidth) / 2, 2)
    end

    -- Create the scroll panel and attach it to the bottom panel
    self.scrollPanel = vgui.Create("DScrollPanel", self.bottomPanel)
    self.scrollPanel:Dock(FILL)
    self.scrollPanel:DockMargin(5, 32, 5, 5)

    -- Create the panel that will contain the player icons
    self.playersPanel = vgui.Create("DPanel", self.scrollPanel)
    self.playersPanel:Dock(TOP)
    self.playersPanel:SetTall(155)
    self.playersPanel:SetWide(1000)

    -- Set up horizontal layout for the player icons
    
    if covPlayers and covConfig then
        local x, y = 5,5
        local iconSize = 72
        local margin = 5
        SortPlayersByRank(covPlayers, covConfig.ranks)
        table.insert(covPlayers, covPlayers[1])
            
        if next(covPlayers) then
            for i, playerData in pairs(covPlayers) do
            --for i=1, 30 do -- playerData = covPlayers[1]
                --for i, playerData in ipairs(covPlayers) do
                local textColor = WHITE
                if playerData.model then
                    self.playerPanel = vgui.Create("DPanel", self.playersPanel)
                    self.playerPanel:SetSize(iconSize, iconSize)
                    self.playerPanel:SetPos(x, y)
                    self.playerPanel.Paint = function(self, w, h)
                        surface.SetDrawColor(DARK_RED)
                        surface.DrawRect(0, 0, w, h)
                    end

                    local spawnIcon = vgui.Create("cwSpawnIcon", self.playerPanel)
                    spawnIcon:SetModel(playerData.model, playerData.skin or 0) 
                    spawnIcon:SetSize(iconSize - 20, iconSize - 20)
                    spawnIcon:SetPos(10, 8)

                    if playerData.alive == nil or not playerData.alive then
                        spawnIcon.PaintOver = function(self, w, h)
                            draw.SimpleText("X", "DermaLarge", w / 2, h / 2, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                        end
                        textColor = Color(255,0,0,255)
                    end
                    
                    local nameLabel = vgui.Create("DLabel", self.playerPanel)
                    nameLabel:SetText(i or "Unknown")
                    nameLabel:SetFont("DermaTiny")
                    nameLabel:Dock(BOTTOM)
                    nameLabel:SetContentAlignment(5)
                    nameLabel:SetTextColor(textColor)
                    nameLabel:SizeToContents()

                    function spawnIcon.DoClick(b)
                        local menu = DermaMenu()
                        
                        local namePanel = vgui.Create("DPanel", menu)
                        namePanel:SetSize(125, 22)
                        namePanel.Paint = function(self, w, h)
                            derma.SkinHook("Paint", "MenuOption", self, w, h)
                        end

                        local nameLabelMenu = vgui.Create("DLabel", namePanel)
                        nameLabelMenu:SetText(i or "Unknown")
                        nameLabelMenu:SetFont("DermaDefault")
                        nameLabelMenu:SizeToContents()
                        nameLabelMenu:SetPos((namePanel:GetWide() - nameLabelMenu:GetWide()) / 2, (namePanel:GetTall() - nameLabelMenu:GetTall()) / 2)
                        menu:AddPanel(namePanel)

                        local rankPanel = vgui.Create("DPanel", menu)
                        rankPanel:SetSize(125, 22)
                        rankPanel.Paint = function(self, w, h)
                            derma.SkinHook("Paint", "MenuOption", self, w, h)
                        end
                        local rankLabelMenu = vgui.Create("DLabel", rankPanel)
                        rankLabelMenu:SetText(playerData.rank or "Unknown Rank")
                        rankLabelMenu:SetFont("DermaDefault")
                        rankLabelMenu:SizeToContents()
                        rankLabelMenu:SetPos((rankPanel:GetWide() - rankLabelMenu:GetWide()) / 2, (rankPanel:GetTall() - rankLabelMenu:GetTall()) / 2)
                        menu:AddPanel(rankPanel)

                        menu:AddOption("Kick", function()
                            netstream.Start("PlayerCovenantKickPlayer", {covName, Clockwork.Client:GetName(), i})
                        end)
                        
                        local submenu = menu:AddSubMenu("Adjust Rank", function()
                        end)
                        if covConfig.ranks then
                            for q, rank in pairs(covConfig.ranks) do
                                submenu:AddOption(rank.name, function()
                                    netstream.Start("PlayerCovenantAdjustRank", {covName, Clockwork.Client:GetName(), i, q})
                                end)
                            end
                        end
                        
                        local x, y = gui.MousePos()
                        menu:Open()
                        menu:SetPos(x, y)
                    end
                    
                    spawnIcon.OnCursorEntered = function()
                        self.playerPanel.Paint = function(self, w, h)
                            surface.SetDrawColor(BRIGHT_RED)
                            surface.DrawRect(0, 0, w, h)
                        end
                    end

                    spawnIcon.OnCursorExited = function()
                        self.playerPanel.Paint = function(self, w, h)
                            surface.SetDrawColor(DARK_RED)
                            surface.DrawRect(0, 0, w, h)
                        end
                    end

                    x = x + iconSize + margin
                    if x > self.playersPanel:GetWide() - iconSize then
                        x = 0
                        y = y + iconSize + margin
                    end
                end
            end
        end
    end
end

-- Called when the menu is opened.
function PANEL:OnMenuOpened()
	if (Clockwork.menu:IsPanelActive(self)) then
        --self:GetData()
        cwWandererCovenants:AskForCovenantData()
		self:Rebuild();
	end;
end;

-- Called when the panel is selected.
function PANEL:OnSelected() 
    --self:GetData()
    cwWandererCovenants:AskForCovenantData()
    self:Rebuild(); 
end;

-- Called when the layout should be performed.
function PANEL:PerformLayout(w, h)
	
end;

-- Called when the panel is painted.
function PANEL:Paint(w, h)
	derma.SkinHook("Paint", "Frame", self, w, h);
	
	return true;
end;

-- Called each frame.
function PANEL:Think()
	self:InvalidateLayout(true);
end;

vgui.Register("cwCovenantsMain", PANEL, "EditablePanel");

-- Opens a panel that allows the user to accept an invite
function cwWandererCovenants:CreateWandererInviteAcceptPanel()
    if (IsValid(cwWandererCovenants.invitePanel)) then
		cwWandererCovenants.invitePanel:Remove();
	end;
	cwWandererCovenants.invitePanel = DermaMenu();
	cwWandererCovenants.invitePanel:SetMinimumWidth(150);
    cwWandererCovenants.invitePanel:AddOption("Accept", function() Clockwork.Client:ConCommand("cw_AcceptCovenantInvite") end);
	cwWandererCovenants.invitePanel:Open();
	cwWandererCovenants.invitePanel:SetPos(ScrW() / 2 - (cwWandererCovenants.invitePanel:GetWide() / 2), ScrH() / 2 - (cwWandererCovenants.invitePanel:GetTall() / 2));
end

-- Creates the rank permissions panel given a covenant name & its config
function cwWandererCovenants:CreateRankPermissionsPanel(covName, covConfig)
    if (IsValid(cwWandererCovenants.rankPanel)) then
		cwWandererCovenants.rankPanel:Remove();
    elseif (IsValid(cwWandererCovenants.beliefPanel)) then
		cwWandererCovenants.beliefPanel:Remove();
	end;
    cwWandererCovenants.rankPanel = vgui.Create("DFrame")
    local ranks = covConfig.ranks
    cwWandererCovenants.rankPanel:SetTitle("Rank Permissions")
    cwWandererCovenants.rankPanel:SetSize(350, 275)
    local panelX, panelY = cwWandererCovenants.activePanel:GetPos() 
    local bottomLeftX = panelX
    local bottomLeftY = panelY + cwWandererCovenants.activePanel:GetTall() 

    cwWandererCovenants.rankPanel:SetPos(bottomLeftX, bottomLeftY)
    cwWandererCovenants.rankPanel:MakePopup()

    -- Panel Labels
    local labels = {"Name", "Kick", "Invite", "Alter Rank", "Starter", "Heir"}
    local labelNice = {"name", "kick", "invite", "alter", "starter", "heir"}
    local labelWidth = {75, 50, 50, 50, 50, 50} -- Widths for each label and column
    local elementWidths = {75, 20, 20, 20, 20, 20} -- Actual width of the text box and checkboxes
    local startingRank = covConfig.startingRank

    -- Create labels above each column
    for i, label in ipairs(labels) do
        local lbl = vgui.Create("DLabel", cwWandererCovenants.rankPanel)
        lbl:SetText(label)
        lbl:SizeToContents()

        local lblWidth = lbl:GetWide()
        local columnStart = (i - 1) * labelWidth[i] + 10
        local elementWidth = elementWidths[i]
        local xPos = columnStart + (elementWidth / 2) - (lblWidth / 2)
        if i ~= 1 then xPos = xPos + 50 end
        
        lbl:SetPos(xPos, 30)
        lbl:SetTextColor(WHITE)
    end

    -- Create 6 rows of inputs
    local checkBoxes = {}
    local nameBoxes = {}
    for row = 1, 6 do
        local yPos = 50 + (row - 1) * 30 
        local nameBox = vgui.Create("DTextEntry", cwWandererCovenants.rankPanel)
        nameBox:SetSize(elementWidths[1], 20)
        nameBox:SetPos(10, yPos)
        nameBox:SetText(ranks[row].name)

        table.insert(nameBoxes, nameBox)

        -- Create the checkboxes for "K", "I", "A", "S", "H" columns
        local checkBoxesRow = {}
        for col = 2, 6 do
            local checkBox = vgui.Create("DCheckBox", cwWandererCovenants.rankPanel)
            local xPos = (col - 1) * labelWidth[col] + 10
            if i ~= 1 then xPos = xPos + 50 end
            checkBox:SetSize(elementWidths[col], 20)
            checkBox:SetPos(xPos, yPos)
            checkBox:SetValue(ranks[row].permissions[labelNice[col]])
            
            if col == 5 then 
                checkBox.OnChange = function(self, value)
                    if value then
                        for _, otherRow in ipairs(checkBoxes) do
                            if otherRow[4] ~= self then
                                otherRow[4]:SetValue(false)
                            end
                        end
                    end
                end
            end
            
            if row == 1 and (col == 6 or col == 5) then
                checkBox:SetEnabled(false)
            end

            table.insert(checkBoxesRow, checkBox)
        end
        table.insert(checkBoxes, checkBoxesRow)
    end

    -- Set the starting rank's checkbox to true
    for q, e in ipairs(ranks) do
        if e.name == startingRank then
            checkBoxes[q][4]:SetValue(true)
            break
        end
    end

    local buttonContainer = vgui.Create("DPanel", cwWandererCovenants.rankPanel)
    buttonContainer:Dock(BOTTOM)
    buttonContainer:SetTall(40)

    local backButton = vgui.Create("DButton", buttonContainer)
    backButton:SetText("Back")
    backButton:Dock(LEFT)
    backButton:SetWide(100)
    backButton:DockMargin(5, 5, 5, 5)

    local okButton = vgui.Create("DButton", buttonContainer)
    okButton:SetText("Apply")
    okButton:Dock(RIGHT)
    okButton:SetWide(100)
    okButton:DockMargin(5, 5, 5, 5)
    
    local newStarterRank 
    okButton.DoClick = function(b)
        local newRanks = {}
        
        for y, row in ipairs(checkBoxes) do
            local newRanksRow = {
                name = ranks[y].name, 
                permissions = {
                    kick = false, 
                    invite = false, 
                    alter = false, 
                    heir = false
                }
            }

            for x, column in ipairs(row) do
                local permission = labelNice[x+1]
                
                -- Only update relevant permissions
                if permission == "kick" or permission == "invite" or permission == "alter" or permission == "heir" then
                    newRanksRow.permissions[permission] = column:GetChecked()
                elseif permission == "starter" then
                    if column:GetChecked() then
                        newStarterRank = ranks[y].name
                    end
                end
            end
            
            table.insert(newRanks, newRanksRow)
        end
        if newStarterRank == nil then
            newStarterRank = ranks[6].name
            checkBoxes[6][4]:SetValue(true)
        end
        for q,v in ipairs(nameBoxes) do
            newRanks[q].name = v:GetText()
        end

        netstream.Start("PlayerCovenantUpdateRanks", {covName, newRanks, newStarterRank})
    end
    
    backButton.DoClick = function()
        cwWandererCovenants.rankPanel:Close()
    end
end

-- Create a color picker panel
function cwWandererCovenants:CreateColorPickerPanel()
    -- Create a frame to hold the color picker
    cwWandererCovenants.colorPickerFrame = vgui.Create("DFrame")
    cwWandererCovenants.colorPickerFrame:SetTitle("Color Picker")
    cwWandererCovenants.colorPickerFrame:SetSize(275, 300)
    cwWandererCovenants.colorPickerFrame:MakePopup()

    local panelX, panelY = cwWandererCovenants.activePanel:GetPos() 
    local bottomLeftX = panelX
    local bottomLeftY = panelY + cwWandererCovenants.activePanel:GetTall() 

    cwWandererCovenants.colorPickerFrame:SetPos(bottomLeftX, bottomLeftY)

    -- Create the DColorMixer inside the frame
    local colorMixer = vgui.Create("DColorMixer", cwWandererCovenants.colorPickerFrame)
    colorMixer:SetPos(10, 30)
    colorMixer:SetSize(250, 175)
    colorMixer:SetPalette(false) 
    colorMixer:SetAlphaBar(false) 
    colorMixer:SetWangs(false) 

    -- Create another button to send the selected color to the server
    local sendColorButton = vgui.Create("DButton", cwWandererCovenants.colorPickerFrame)
    sendColorButton:SetText("Choose Color")
    sendColorButton:SetSize(200, 30)
    sendColorButton:CenterHorizontal()
    sendColorButton:SetPos(sendColorButton:GetX(), 220)
    
    sendColorButton.DoClick = function()
        local color = colorMixer:GetColor()
        local colorTable = {r = color.r, g = color.g, b = color.b}
        netstream.Start("CoventantCreateSelectedColor", colorTable)
        cwWandererCovenants.colorPickerFrame:Close()
    end
end

-- Belief tree helper funcs
local function DrawTreeBackground(width, height, panel)
	if (!panel.alpha) then
		panel.alpha = 255;
	end;
	
	if (panel.alpha != 255) then
		panel.alpha = math.Approach(panel.alpha, 255, FrameTime() * 512);
	end;
	
	--local material = "begotten/ui/bgttex3xl.png";
	
    local material = "begotten/ui/menu/brutality.png";

	surface.SetDrawColor(255, 255, 255, panel.alpha);
	surface.SetMaterial(Material(material));
	surface.DrawTexturedRect(0, 0, width, height);
end;

local function AddIcon(iconData, points, parent, x, y, covenName, covBeliefs)
    local selectedBad = Color(255, 50, 50, 255);
    local selectedGood = Color(50, 255, 50, 255);
    local selectedNeutral = Color(200, 200, 200, 255);

    if not iconData or type(iconData) ~= "table" then
        return
    end
    local icon = vgui.Create("DImageButton", parent)
    icon:SetPos(x,y)
    icon:SetSize(50, 50)
    
    if iconData.icon then
        icon:SetImage(iconData.icon)
    else
        icon:SetImage("begotten/ui/penor.png")
    end

    local requirementsNiceNames = {}
    for q, r in ipairs(iconData.req) do
        if BeliefsTable[tostring(r)] and not covBeliefs[tostring(r)] then
            table.insert(requirementsNiceNames, BeliefsTable[tostring(r)].niceName)
        end
    end

    local tooltip = function(frame)
        frame:AddText(iconData.name, Color(100,100,100), "Civ5ToolTip4");
        frame:AddText(iconData.description.."\n", Color(225, 200, 200));
        
        if iconData.quote then
            frame:AddText(iconData.quote.."\n", Color(128, 90, 90, 240));
        end

        if requirementsNiceNames and #requirementsNiceNames > 0 then
            local requirementString = "Requirements: "..table.concat(requirementsNiceNames, ", ");
            
            frame:AddText(requirementString, Color(225, 200, 200));
        end
    end

    icon.DoClick = function(i)
       if #requirementsNiceNames == 0 and points > 0 then
            netstream.Start("CovenantBeliefTaken", {covenName, UglyNamesTable[iconData.name]})
       end
    end

    if covBeliefs[UglyNamesTable[iconData.name]] then
        icon:SetColor(Unlocked)
    elseif points > 0 and #requirementsNiceNames == 0 then
        icon:SetColor(Unlockable)
    else
        icon:SetColor(Locked)
    end


    if tooltip then
        if isfunction(tooltip) then
            Clockwork.kernel:CreateDermaToolTip(icon);
            icon:SetToolTipCallback(tooltip)
        end
    end
    
    return icon
end

local function BuildTree(tree, points, parent, x, y, covenName, covBeliefs)
    local treePanel = vgui.Create("DPanel", parent)
    local treeW, treeH = 250, 400
    treePanel:SetSize(treeW, treeH)
    treePanel:SetPos(x, y)
    local iconPositions = {}

    treePanel.Paint = function(self, w, h)
        DrawTreeBackground(treeW, treeH, self)
        surface.SetDrawColor(255, 255, 255, 255)
        
        for rowIdx, row in ipairs(iconPositions) do
            if rowIdx > 1 then
                local previousRow = iconPositions[rowIdx - 1]
                local numParents = #previousRow
                local numChildren = #row
                
                if numChildren == 1 then
                    local childPos = row[1]
                    for _, parentPos in ipairs(previousRow) do
                        surface.DrawLine(parentPos.x + 25, parentPos.y + 50, childPos.x + 25, childPos.y)
                    end
                else
                    for colIdx, childPos in ipairs(row) do
                        local parentPos = previousRow[colIdx] or previousRow[1]
                        surface.DrawLine(parentPos.x + 25, parentPos.y + 50, childPos.x + 25, childPos.y)
                    end
                end
            end
        end
    end
    
    -- Add shadow label at the top of the treePanel
    local shadowLabel = vgui.Create("DLabel", treePanel)
    shadowLabel:SetFont("DermaLarge") -- Use a larger font for better visibility
    shadowLabel:SetText(tree.name)
    shadowLabel:SetColor(Color(0, 0, 0, 200)) -- Darker shadow color (black with more opacity)
    shadowLabel:SizeToContents()
    shadowLabel:SetPos((treeW - shadowLabel:GetWide()) / 2 + 3, 13) -- Position with a slight offset for the shadow

    -- Add the main label on top of the shadow label
    local label = vgui.Create("DLabel", treePanel)
    label:SetFont("DermaLarge") -- Same larger font
    label:SetText(tree.name)
    label:SetColor(tree.color) -- Bright red text color for visibility
    label:SizeToContents()
    label:SetPos((treeW - label:GetWide()) / 2, 10) -- Position exactly on top of the shadow


    local iconX, iconY = 0, 120
    for rowIdx, row in ipairs(tree.nodes) do
        iconX = 50
        iconPositions[rowIdx] = {}
        for colIdx, belief in ipairs(row) do
            if #row == 1 and belief.align == 1 then
                iconX = iconX + 50
            end

            local icon = AddIcon(belief, points, treePanel, iconX, iconY, covenName, covBeliefs)
            table.insert(iconPositions[rowIdx], {x = iconX, y = iconY})

            iconX = iconX + 100
        end
        iconY = iconY + 80
    end
end


-- Create the belief panel
function cwWandererCovenants:CreateCovBeliefPanel(covName, covConfig, covStats, covBeliefs)
    if IsValid(cwWandererCovenants.beliefPanel) then
        cwWandererCovenants.beliefPanel:Close()
    elseif (IsValid(cwWandererCovenants.rankPanel)) then
        cwWandererCovenants.rankPanel:Remove();
    end

    cwWandererCovenants.beliefPanel = vgui.Create("DFrame")
    local ranks = covConfig.ranks
    local level = covStats.level or 1
    local points = covStats.points or 0
    local xp = covStats.xp or 0
    cwWandererCovenants.beliefPanel:SetTitle("Covenant Beliefs")
    local width, height = 730, 520
    local x, y = 0, 0
    cwWandererCovenants.beliefPanel:SetSize(width, height)

    local panelX, panelY = cwWandererCovenants.activePanel:GetPos() 
    local bottomLeftX = panelX
    local bottomLeftY = panelY + cwWandererCovenants.activePanel:GetTall() 

    cwWandererCovenants.beliefPanel:SetPos(bottomLeftX, bottomLeftY)
    cwWandererCovenants.beliefPanel:MakePopup()

    cwWandererCovenants.beliefPanel.Paint = function(self, w, h)
        surface.SetDrawColor(255, 255, 255, 200)
        surface.SetMaterial(topBackground)
        surface.DrawTexturedRect(x + 4, y + 4, width - 8, (height - 96) - 8)

        surface.SetDrawColor(255, 255, 255, 200)
        surface.SetMaterial(bottomBackground)
        surface.DrawTexturedRect(x, height - 88, width, 88)

        draw.RoundedBox(0, 0, 0, width, height, Color(0, 0, 0, 200))

        surface.SetDrawColor(255, 255, 255, 200)
        surface.SetMaterial(topFrame)
        surface.DrawTexturedRect(x, y, width, height - 96)

        surface.SetDrawColor(255, 255, 255, 200)
        surface.SetMaterial(bottomFrame)
        surface.DrawTexturedRect(x, height - 88, width, 88)

        if (!self.barValuesSet) then
    
            self.barX = 14
            self.barY = height - 70
            
            self.barWidth = 370;
            
            self.barValuesSet = true
        end

        draw.RoundedBox(4, self.barX, self.barY, self.barWidth , 32, Color(30, 30, 30))
        surface.SetDrawColor(15, 5, 0, 200)
        surface.SetTexture(gradientDown)
        surface.DrawTexturedRect(self.barX + 2, self.barY + 2, 508, 28)

        draw.RoundedBox(4, (self.barX) + 4, (self.barY) + 4, self.barWidth - 8, 24, Color(140, 0, 0))
        surface.SetDrawColor(75, 0, 0, 255)
        surface.SetTexture(gradientDown)
        surface.DrawTexturedRect((self.barX) + 4, (self.barY) + 4, self.barWidth - 8, 24)
       
        self.levelNumeral = RomanNumerals.ToRomanNumerals(level)
        draw.SimpleText("COVENANT LEVEL: "..self.levelNumeral, "Civ5Tooltip1", self.barX + 8, self.barY + 4, Color(200, 0, 0))
        draw.SimpleText("COVENANT LEVEL: "..self.levelNumeral, "Civ5Tooltip1", self.barX + 10, self.barY + 6, Color(0, 0, 0, 150))
        
        if self.player == Clockwork.Client then
            if (points <= 0) then
                draw.SimpleText("YOU HAVE NO EPIPHANIES!", "Civ5Tooltip1", (self.barX) + 6, ((self.barY) + 4) + 1 + 32, Color(200, 0, 0))
                draw.SimpleText("YOU HAVE NO EPIPHANIES!", "Civ5Tooltip1", (self.barX) + 4, ((self.barY) + 4) - 1 + 32, Color(0, 0, 0, 150))
            else
                local epiphany = "EPIPHANY"
                
                if (points > 1) then
                    epiphany = "EPIPHANIES"
                end

                draw.SimpleText("YOU HAVE "..points.." "..epiphany.." TO INVEST!", "Civ5ToolTi3", (self.barX) + 6, ((self.barY) + 4) + 1 + 32, Color(200, 0, 0))
                draw.SimpleText("YOU HAVE "..points.." "..epiphany.." TO INVEST!", "Civ5ToolTi3", (self.barX) + 4, ((self.barY) + 4) - 1 + 32, Color(0, 0, 0, 150))
            end
        else
            if (points <= 0) then
                draw.SimpleText("THEY HAVE NO EPIPHANIES!", "Civ5Tooltip1", (self.barX) + 6, ((self.barY) + 4) + 1 + 32, Color(200, 0, 0))
                draw.SimpleText("THEY HAVE NO EPIPHANIES!", "Civ5Tooltip1", (self.barX) + 4, ((self.barY) + 4) - 1 + 32, Color(0, 0, 0, 150))
            else
                local epiphany = "EPIPHANY"
                
                if (points > 1) then
                    epiphany = "EPIPHANIES"
                end

                draw.SimpleText("THEY HAVE "..points.." "..epiphany.." TO INVEST!", "Civ5ToolTi3", (self.barX) + 6, ((self.barY) + 4) + 1 + 32, Color(200, 0, 0))
                draw.SimpleText("THEY HAVE "..points.." "..epiphany.." TO INVEST!", "Civ5ToolTi3", (self.barX) + 4, ((self.barY) + 4) - 1 + 32, Color(0, 0, 0, 150))
            end
        end
        
        self.sacramentCost = cwBeliefs.sacramentCosts[level + 1] or 666;

        draw.SimpleText("Faith Required For Next Epiphany: "..cwWandererCovenants.covenantBeliefCosts[level] - xp, "Civ5Tooltip1", (self.barX) + 4 + 16 + self.barWidth, ((self.barY) + 4 + 32), Color(200, 0, 0, 255))
		draw.SimpleText("Faith Required For Next Epiphany: "..cwWandererCovenants.covenantBeliefCosts[level] - xp, "Civ5Tooltip1", (self.barX) + 6 + 16 + self.barWidth, ((self.barY) + 6 + 32), Color(0, 0, 0, 127))


        draw.SimpleText("Faith Concentrated: "..math.floor(xp), "Civ5Tooltip1",(self.barX) + 4 + 16 + self.barWidth, ((self.barY) + 3), Color(200, 0, 0, 255))
        draw.SimpleText("Faith Concentrated: "..math.floor(xp), "Civ5Tooltip1", (self.barX) + 6 + 16 + self.barWidth, ((self.barY) + 5), Color(0, 0, 0, 127))
    
    end
    
    BuildTree(beliefs.Militant, points, cwWandererCovenants.beliefPanel, 0, 20, covName, covBeliefs)
    BuildTree(beliefs.Mercantile, points, cwWandererCovenants.beliefPanel, 240, 20, covName, covBeliefs)
    BuildTree(beliefs.Religious, points, cwWandererCovenants.beliefPanel, 480, 20, covName, covBeliefs)
end