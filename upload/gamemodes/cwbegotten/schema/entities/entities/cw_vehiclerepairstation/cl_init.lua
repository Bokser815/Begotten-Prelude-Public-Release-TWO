-- File: lua/entities/cw_vehiclerepairstation/cl_init.lua

include("shared.lua")

function ENT:HUDPaintTargetID(x, y, alpha)
	local colorTargetID = Clockwork.option:GetColor("target_id")
	local colorWhite = Clockwork.option:GetColor("white")
	
	y = Clockwork.kernel:DrawInfo("Maintenance Station", x, y, colorTargetID, alpha)
	y = Clockwork.kernel:DrawInfo("A station dock, designed to be an all-purpose tool for the management and modification of vehicles.", x, y, colorWhite, alpha);
end;

net.Receive("LVS_Maintenance_OpenUI", function()
    local ent = net.ReadEntity()
    local loaded = net.ReadBool()
    local stationUpgrades = net.ReadTable() or {}
    local success, deedInfo = pcall(net.ReadTable)

    local scrwidth = ScrW()
    local scrheight = ScrH()

    if not success then
        print("[RepairStation UI] No deed info received, defaulting to {}")
        deedInfo = {}
    end
    
    print("[RepairStation UI] Received UI open for entity " .. tostring(ent) .. ". Loaded: " .. tostring(loaded))
    print("[RepairStation UI] Deed Info: " .. util.TableToJSON(deedInfo))
    
    if not IsValid(ent) then return end

    

    local frame = vgui.Create("DFrame")
    frame:SetTitle("Vehicle Maintenance Station")
    frame:SetSize(900, 600)
    frame:Center()
    frame:MakePopup()
    frame:ShowCloseButton(false)

    local framecloser = vgui.Create("DFrame")
    framecloser:SetTitle("")
    framecloser:SetSize(scrwidth, scrheight)
    framecloser:Center()
    framecloser:ShowCloseButton(false)
    framecloser:SetAlpha(0)
    framecloser:SetDraggable(false)
    --framecloser:SetVisible(false)
    --frame:MakePopup()

    local closebutton = vgui.Create("DButton", framecloser)
    closebutton:SetText("")
    closebutton:SetSize(scrwidth, scrheight)
    closebutton:Center()
    closebutton:SetAlpha(0)
    closebutton.DoClick = function()
        framecloser:Close()
        frame:Close()
        surface.PlaySound("begotten/ui/buttonclick.wav")
    end

    

    local propertySheet = vgui.Create("DPropertySheet", frame)
    propertySheet:SetSize(880, 560)
    propertySheet:Center()

    local overviewPanel = vgui.Create("DPanel", propertySheet)
    overviewPanel:SetSize(880, 560)
    overviewPanel.Paint = function(self, w, h) end

    local backgroundPanel = vgui.Create("DPanel", overviewPanel)
    backgroundPanel:SetPos(20, 20)
    backgroundPanel:SetSize(500, 500)
    backgroundPanel.Paint = function(self, w, h)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(Material("begotten/ui/menu/vicbackground.png"))
        surface.DrawTexturedRect(0, 0, w, h)
    end

    local modelPanel = vgui.Create("DModelPanel", overviewPanel)
    modelPanel:SetPos(20, 20)
    modelPanel:SetSize(500, 500)
    
    local mdl = "models/props_vehicles/car001a.mdl"
    if loaded then
        mdl = ent:GetNWString("LoadedModel", mdl)
        print("[RepairStation UI] Overview: Using loaded model: " .. mdl)
    end
    modelPanel:SetModel(mdl)
    
    modelPanel:SetCamPos(Vector(0, 120, 60))
    modelPanel:SetLookAt(Vector(0, 0, 60))
    modelPanel:SetFOV(50)
    
    function modelPanel:LayoutEntity(entity)
        entity:SetAngles(Angle(0, 90, 0))
    end

    function modelPanel:Think()
        if not IsValid(self.Entity) then
            self:SetModel(mdl)
        end
    end


    local overlayPanel = vgui.Create("DPanel", modelPanel)
    overlayPanel:SetSize(modelPanel:GetSize())
    overlayPanel:SetPos(0, 0)
    overlayPanel:SetPaintedManually(true)
    
    function modelPanel:PostDrawModel()
        overlayPanel:PaintManual()
    end
    

    local function CreateMaterialLabel(parent, text, materialPath, font, forcedWidth, forcedHeight)
        local pnl = vgui.Create("DPanel", parent)
        if forcedWidth then pnl:SetWide(forcedWidth) end
        if forcedHeight then pnl:SetTall(forcedHeight) end

        pnl.Paint = function(self, w, h)
            surface.SetDrawColor(255, 255, 255, 255)
            surface.SetMaterial(Material(materialPath))
            surface.DrawTexturedRect(0, 0, w, h)

            draw.SimpleText(
                text,
                font or "DermaDefault",
                w * 0.5, h * 0.5,
                color_white,
                TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER
            )
        end
        return pnl
    end

    local infoPanel = vgui.Create("DPanel", overviewPanel)
    infoPanel:SetPos(540, 20)
    infoPanel:SetSize(320, 150)
    infoPanel.Paint = function(self, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color(30,30,30,220))
    end

    local name   = deedInfo.name       or "Unowned"
    local owner  = deedInfo.owner      or "Unowned"
    local fuel   = deedInfo.fuel       or "N/A"
    local cond   = deedInfo.condition  or "N/A"
    local code   = deedInfo.code       or "N/A"

    local nameRow = CreateMaterialLabel(infoPanel, "Name: " .. name, "begotten/ui/butt24.png", "DermaLarge", infoPanel:GetWide(), 40)
    nameRow:Dock(TOP)
    nameRow:DockMargin(0, 0, 0, 2)

    local row2 = vgui.Create("DPanel", infoPanel)
    row2:Dock(TOP)
    row2:SetTall(54)
    row2.Paint = nil

    local ownerLabel = CreateMaterialLabel(row2, "Owner: " .. owner, "begotten/ui/butt24.png", "DermaDefault")
    ownerLabel:Dock(LEFT)
    ownerLabel:SetWide(infoPanel:GetWide() * 0.5 - 2)
    ownerLabel:DockMargin(0, 0, 2, 0)

    local condLabel = CreateMaterialLabel(row2, "Condition: " .. cond, "begotten/ui/butt24.png", "DermaDefault")
    condLabel:Dock(FILL)

    local row3 = vgui.Create("DPanel", infoPanel)
    row3:Dock(TOP)
    row3:SetTall(54)
    row3.Paint = nil

    local fuelLabel = CreateMaterialLabel(row3, "Fuel: " .. fuel, "begotten/ui/butt24.png", "DermaDefault")
    fuelLabel:Dock(LEFT)
    fuelLabel:SetWide(infoPanel:GetWide() * 0.5 - 2)
    fuelLabel:DockMargin(0, 0, 2, 0)

    local codeLabel = CreateMaterialLabel(row3, "Code: " .. code, "begotten/ui/butt24.png", "DermaDefault")
    codeLabel:Dock(FILL)

    propertySheet:AddSheet("Overview", overviewPanel, "placeholder")

    local compPanel = vgui.Create("DPanel", propertySheet)
    compPanel:SetSize(880, 560)
    compPanel.Paint = function(self, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color(30,30,30,220))
    end

    local titleLabel = vgui.Create("DLabel", compPanel)
    titleLabel:SetPos(20, 20)
    titleLabel:SetSize(400, 30)
    titleLabel:SetText("Components")
    titleLabel:SetFont("DermaLarge")
    titleLabel:SetTextColor(Color(255,255,255))
    titleLabel:SizeToContents()

    local scrollPanel = vgui.Create("DScrollPanel", compPanel)
    scrollPanel:SetPos(20, 60)
    scrollPanel:SetSize(840, 480)

    local list = vgui.Create("DIconLayout", scrollPanel)
    list:Dock(FILL)
    list:SetSpaceY(5)
    list:SetSpaceX(5)

    local whitelist = {
        ["lvs_wheeldrive_fueltank"] = {
            displayName = "Fuel Tank",
            getInfo = function(ent)
                local fuel = ent:GetFuel() or 0
                local fuelPerc = math.Round(fuel * 100)
                local hp = ent:GetHP() or 0
                local maxHP = ent:GetMaxHP() or 100
                local destroyed = ent:GetDestroyed() or false
                return string.format("Fuel: %d%%", fuelPerc), hp, maxHP, destroyed
            end,
        },
        ["lvs_wheeldrive_engine"] = {
            displayName = "Engine",
            getInfo = function(ent)
                local hp = ent:GetHP() or 0
                local maxHP = ent:GetMaxHP() or 100
                local destroyed = ent:GetDestroyed() or false
                local upgrades = "None"
                if ent.GetUpgrades then
                    local ups = ent:GetUpgrades()
                    if ups and #ups > 0 then
                        upgrades = table.concat(ups, ", ")
                    end
                end
                return string.format("Upgrades: %s", upgrades), hp, maxHP, destroyed
            end,
        },
        --[[["lvs_wheeldrive_wheel"] = {
            displayName = "Wheel",
            getInfo = function(ent)
                local hp = ent:GetHP() or 0
                local maxHP = ent:GetMaxHP() or 100
                local destroyed = ent:GetDestroyed() or false
                return string.format("Health: %d/%d", hp, maxHP), hp, maxHP, destroyed
            end,
        },]]--
        
    }

    local function GetPartColor(hp, maxHP, destroyed)
        if destroyed then
            return Color(0,0,0)
        end
        local ratio = hp / maxHP
        if ratio >= 0.75 then
            return Color(0,150,0)
        elseif ratio >= 0.4 then
            return Color(255,165,0)
        else
            return Color(255,0,0)
        end
    end

    local function AddPartPanel(partEntity, infoFunc, displayName)
        if IsValid(partEntity) then
            local infoText, hp, maxHP, destroyed = infoFunc(partEntity)
            local partPanel = vgui.Create("DPanel")
            partPanel:SetSize(400, 50)
            partPanel.Paint = function(self, w, h)
                local col = GetPartColor(hp, maxHP, destroyed)
                draw.RoundedBox(4, 0, 0, w, h, col)
                draw.SimpleText(displayName, "DermaDefault", 10, 5, Color(255,255,255))
                draw.SimpleText(infoText, "DermaDefault", 10, 25, Color(255,255,255))
            end
            list:Add(partPanel)
            print("[RepairStation UI] Added component panel for " .. displayName)
        end
    end

    if loaded then
        local loadedVeh = ent:GetNWEntity("LoadedVehicle")
        local children = loadedVeh:GetChildren() or {}
        --[[for i, child in ipairs(children) do
            print(string.format("Child %d: %s (Class: %s)", i, tostring(child), child:GetClass()))
        end]]--
        if IsValid(loadedVeh) then
            local engine = loadedVeh:GetEngine()
            local fueltank = loadedVeh:GetFuelTank()
            if whitelist["lvs_wheeldrive_engine"] and engine then
                AddPartPanel(engine, whitelist["lvs_wheeldrive_engine"].getInfo, whitelist["lvs_wheeldrive_engine"].displayName)
            end
            if whitelist["lvs_wheeldrive_fueltank"] and fueltank then
                AddPartPanel(fueltank, whitelist["lvs_wheeldrive_fueltank"].getInfo, whitelist["lvs_wheeldrive_fueltank"].displayName)
            end

            --[[
            local wheels = {}
            if loadedVeh.GetWheels and type(loadedVeh.GetWheels) == "function" then
                wheels = loadedVeh:GetWheels() or {}
            elseif loadedVeh._WheelEnts then
                wheels = loadedVeh._WheelEnts or {}
            end

            local wheelCount = 0
            for _, wheel in ipairs(wheels) do
                wheelCount = wheelCount + 1
                local displayName = "Wheel #" .. wheelCount
                if whitelist["lvs_wheeldrive_wheel"] then
                    AddPartPanel(wheel, whitelist["lvs_wheeldrive_wheel"].getInfo, displayName)
                end
            end
            --]]
        else
            print("[RepairStation UI] Loaded vehicle NWEntity is not valid.")
        end
    end

    propertySheet:AddSheet("Components", compPanel, "placeholder")
    ------------------------------
    -- Upgrades Panel --
    ------------------------------

    local upgradesPanel = vgui.Create("DPanel", propertySheet)
    upgradesPanel:SetSize(880, 560)
    upgradesPanel.Paint = function(self, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color(30,30,30,220))
    end

    propertySheet:AddSheet("Upgrades", upgradesPanel, "icon16/wrench.png")

    local upgradesTitle = vgui.Create("DLabel", upgradesPanel)
    upgradesTitle:SetPos(20, 20)
    upgradesTitle:SetSize(400, 30)
    upgradesTitle:SetText("Loaded Upgrades")
    upgradesTitle:SetFont("DermaLarge")
    upgradesTitle:SetTextColor(Color(255,255,255))
    upgradesTitle:SizeToContents()

    local slotSize  = 110  -- Size of each slot (square)
    local margin    = 4   -- Gap between slots
    local firstGridX, firstGridY = 20, 60
    local secondGridX, secondGridY = 20, 290

    local slotPanels = {}

    local function CreateGrid(parent, startX, startY, rows, cols, size, spacing)
        for row = 1, rows do
            for col = 1, cols do
                local xPos = startX + (col - 1) * (size + spacing)
                local yPos = startY + (row - 1) * (size + spacing)

                local slotPanel = vgui.Create("DPanel", parent)
                slotPanel:SetPos(xPos, yPos)
                slotPanel:SetSize(size, size)
                slotPanel.itemData = nil

                slotPanel.Paint = function(self, w, h)
                    draw.RoundedBox(4, 0, 0, w, h, Color(50, 50, 50, 200))

                    if self.itemData then
                        if self.itemData.icon then
                            surface.SetDrawColor(255, 255, 255, 255)
                            surface.SetMaterial(Material(self.itemData.icon))
                            surface.DrawTexturedRect(4, 4, w - 8, w - 8)

                            draw.SimpleText(
                                self.itemData.name or "Unknown",
                                "DermaDefault",
                                w/2, h - 4,
                                Color(255,255,255),
                                TEXT_ALIGN_CENTER,
                                TEXT_ALIGN_BOTTOM
                            )
                        else
                            draw.SimpleText("No Icon", "DermaDefault", w/2, h/2,
                                Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                        end
                    else
                        draw.SimpleText("Empty", "DermaDefault", w/2, h/2,
                            Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    end
                end

                slotPanel.OnMousePressed = function(self, mouseCode)
                    if self.itemData then
                        local menu = DermaMenu()
                        local item = self.itemData

                        if item.applicableComponents and #item.applicableComponents > 0 then
                            for _, compName in ipairs(item.applicableComponents) do
                                menu:AddOption("Apply to " .. compName, function()
                                    net.Start("LVS_Maintenance_PerformAction")
                                    net.WriteEntity(ent)          
                                    net.WriteString("applyUpgrade")  
                                    net.WriteString(item.upgradeID)
                                    net.WriteString(compName)
                                    net.WriteString(item.itemID)       
                                    net.SendToServer()
                                    frame:Close()
                                end)
                            end
                            menu:AddSpacer()
                        end

                        menu:AddOption("Remove from Station", function()
                            net.Start("LVS_Maintenance_PerformAction")
                            net.WriteEntity(ent)
                            net.WriteString("removeUpgrade")
                            net.WriteString(item.itemID)
                            net.WriteString(item.uniqueID)
                            net.SendToServer()
                            frame:Close()
                        end)

                        menu:Open()
                    else
                        local loadedVeh = ent:GetNWEntity("LoadedVehicle")
                        if not IsValid(loadedVeh) then return end

                        local vehicleUpgrades = loadedVeh:GetUpgrades() or {}
                        print("Applied upgrades: " .. util.TableToJSON(vehicleUpgrades))

                        local menu = DermaMenu()

                        if #vehicleUpgrades > 0 then
                            for _, upID in ipairs(vehicleUpgrades) do
                                local upName = cwVehicleUpgrades:ClientGetUpgradeName(upID)
                                print(upName)
                                menu:AddOption("Strip Upgrade: " .. upName, function()
                                    net.Start("LVS_Maintenance_PerformAction")
                                        net.WriteEntity(ent)        
                                        net.WriteString("stripUpgrade")
                                        net.WriteString(upID)       
                                    net.SendToServer()
                                    frame:Close()
                                end)
                            end
                            menu:AddSpacer()
                            menu:AddOption("Strip All Upgrades", function()
                                net.Start("LVS_Maintenance_PerformAction")
                                    net.WriteEntity(ent)
                                    net.WriteString("stripAllUpgrades")
                                net.SendToServer()
                                frame:Close()
                            end)
                            menu:Open()
                        end
                    end
                end

                table.insert(slotPanels, slotPanel)
            end
        end
    end

    CreateGrid(upgradesPanel, firstGridX, firstGridY, 2, 7, slotSize, margin)
    CreateGrid(upgradesPanel, secondGridX, secondGridY, 2, 4, slotSize, margin)

    local function PopulateUpgradesGrid(upgrades)
        for _, slot in ipairs(slotPanels) do
            slot.itemData = nil
        end

        local index = 1
        for _, upgrade in ipairs(upgrades) do
            local slot = slotPanels[index]
            if not slot then
                break
            end
            slot.itemData = upgrade
            index = index + 1
        end
    end

    PopulateUpgradesGrid(stationUpgrades)

    ------------------------------
    -- Bottom-Right: Actions Panel --
    ------------------------------
    local actionsPanel = vgui.Create("DPanel", frame)
    actionsPanel:SetPos(540, 360)
    actionsPanel:SetSize(340, 210)
    actionsPanel.Paint = function(self, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color(60,60,60,0))
    end

    local loadBtn = vgui.Create("DButton", actionsPanel)
    loadBtn:SetSize(150, 40)
    loadBtn:SetPos(20, 20)
    if loaded then
        loadBtn:SetText("Unload Vehicle")
    else
        loadBtn:SetText("Load Nearest Vehicle")
    end
    loadBtn.DoClick = function()
        net.Start("LVS_Maintenance_PerformAction")
        net.WriteEntity(ent)
        if loaded then
            net.WriteString("unload")
            print("[RepairStation UI] Sending 'unload' command.")
        else
            net.WriteString("load")
            print("[RepairStation UI] Sending 'load' command.")
        end
        net.SendToServer()
        frame:Close()
    end

    local fuelBtn = vgui.Create("DButton", actionsPanel)
    fuelBtn:SetSize(150, 40)
    fuelBtn:SetPos(190, 20)
    fuelBtn:SetText("Refuel Vehicle")
    fuelBtn.DoClick = function()
        net.Start("LVS_Maintenance_PerformAction")
        net.WriteEntity(ent)
        net.WriteString("fuel")
        net.SendToServer()
        print("[RepairStation UI] Sending 'fuel' command.")
        frame:Close()
    end

    local repairBtn = vgui.Create("DButton", actionsPanel)
    repairBtn:SetSize(150, 40)
    repairBtn:SetPos(20, 80)
    repairBtn:SetText("Repair Vehicle")
    repairBtn.DoClick = function()
        net.Start("LVS_Maintenance_PerformAction")
        net.WriteEntity(ent)
        net.WriteString("repair")
        net.SendToServer()
        print("[RepairStation UI] Sending 'repair' command.")
        frame:Close()
    end

    local upgradeBtn = vgui.Create("DButton", actionsPanel)
    upgradeBtn:SetSize(150, 40)
    upgradeBtn:SetPos(190, 80)
    upgradeBtn:SetText("Submit Upgrades")
    upgradeBtn.DoClick = function()
        net.Start("LVS_Maintenance_PerformAction")
        net.WriteEntity(ent)
        net.WriteString("giveAllUpgrades")
        net.SendToServer()
        frame:Close()
    end

    local bigclosebutton = vgui.Create("DButton", actionsPanel)
    bigclosebutton:SetText("CLOSE")
    bigclosebutton:SetSize(252, 67)
    bigclosebutton:SetPos(50, 140)
    bigclosebutton:SetTextColor(Color(160, 0, 0))
    bigclosebutton:SetFont("nov_IntroTextSmallfaaaaa")
    
    local width, height = bigclosebutton:GetWide(), bigclosebutton:GetTall()
    local buttonMaterial = Material("begotten/ui/butt24.png")

    bigclosebutton.DoClick = function()
        if (IsValid(frame)) then
            framecloser:Close()
            frame:Close()
        end
        
        surface.PlaySound("begotten/ui/buttonclick.wav")
    end

    bigclosebutton.Paint = function()
        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(buttonMaterial)
        surface.DrawTexturedRect(0, 0, width, height)
    end
end)
