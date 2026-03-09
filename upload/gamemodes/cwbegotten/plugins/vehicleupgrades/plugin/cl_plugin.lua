if CLIENT then
    -- lazy fix
    cwVehicleUpgrades.ClientUpgrades = {
        ["upgrade_carbomb_simple"] = {
            name = "Simple Car Bomb",
            description = "A simple explosive designed to explode as soon as the car is started.",
        },
        ["upgrade_carbomb_timed"] = {
            name = "Timed Car Bomb",
            description = "Explodes when the timer reaches zero after the engine is started.",
        },
        ["upgrade_carbomb_scrap"] = {
            name = "Timed Car Bomb",
            description = "Explodes when the timer reaches zero after the engine is started.",
        },
        ["upgrade_amphibious"] = {
            name = "Amphibious Crankshaft",
            description = "Allows more water into the engine before causing a shutdown.",
        },
        ["upgrade_radio"] = {
            name = "Vehicle Radio",
            description = "Allows communication via radio within a vehicle.",
        },
    }

    function cwVehicleUpgrades:ClientGetUpgradeName(upgradeID)
        return cwVehicleUpgrades.ClientUpgrades[upgradeID].name
    end


    net.Receive("TimedCarbomb_RequestTime", function()
        local vehicle = net.ReadEntity()
        if not IsValid(vehicle) then return end

        local frame = vgui.Create("DFrame")
        frame:SetTitle("Set Timed Carbomb Timer")
        frame:SetSize(300, 120)
        frame:Center()
        frame:MakePopup()

        local label = vgui.Create("DLabel", frame)
        label:SetText("Enter timer length (seconds):")
        label:SetPos(20, 40)
        label:SizeToContents()

        local textEntry = vgui.Create("DTextEntry", frame)
        textEntry:SetPos(20, 60)
        textEntry:SetSize(260, 20)
        textEntry:SetText("5")

        local submitButton = vgui.Create("DButton", frame)
        submitButton:SetText("Set Timer")
        submitButton:SetPos(20, 90)
        submitButton:SetSize(260, 20)
        submitButton.DoClick = function()
            local timerLength = tonumber(textEntry:GetValue())
            if timerLength and timerLength > 0 then
                net.Start("TimedCarbomb_SetTime")
                    net.WriteEntity(vehicle)
                    net.WriteFloat(timerLength)
                net.SendToServer()
                frame:Close()
            else
                chat.AddText(Color(255, 0, 0), "Enter a valid number greater than 0.")
            end
        end
    end)
end