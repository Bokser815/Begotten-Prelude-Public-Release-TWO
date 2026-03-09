PLUGIN:SetGlobalAlias("cwVehicleUpgrades");

Clockwork.kernel:IncludePrefixed("sv_plugin.lua");
Clockwork.kernel:IncludePrefixed("cl_plugin.lua");

cwVehicleUpgrades.Upgrades = cwVehicleUpgrades.Upgrades or {}

function cwVehicleUpgrades:RegisterUpgrade(upgradeID, data)
    if not upgradeID or not data then
        ErrorNoHalt("[VehicleUpgrades] Error: UpgradeID and data are required.\n")
        return
    end
    cwVehicleUpgrades.Upgrades[upgradeID] = data
    print("[VehicleUpgrades] Registered upgrade: " .. upgradeID)
end

function cwVehicleUpgrades:GetUpgrade(upgradeID)
    return cwVehicleUpgrades.Upgrades[upgradeID]
end

function cwVehicleUpgrades:GetUpgradeName(upgradeID)
    local upgrade = cwVehicleUpgrades.Upgrades[upgradeID]
    if upgrade then
        return upgrade.name
    end
end

function cwVehicleUpgrades:GetAllUpgrades()
    local upgrades = {}
    for k, v in pairs(cwVehicleUpgrades.Upgrades) do
        if type(k) == "string" and type(v) == "table" then
            upgrades[k] = v
        end
    end
    return upgrades
end

local COMMAND = Clockwork.command:New("ToggleVehicleRadio");
COMMAND.tip = "Toggle your vehicle's radio on or off.";
COMMAND.text = "";
COMMAND.arguments = 0;

function COMMAND:OnRun(player, arguments)
    local vehicle = player:lvsGetVehicle();
    if not IsValid(vehicle) then
        Schema:EasyText(player, "red", "You are not in a valid vehicle!");
        return;
    end;
    if not vehicle.Radio or not IsValid(vehicle.Radio) then
        Schema:EasyText(player, "red", "Your vehicle does not have a radio installed!");
        return;
    end;
    if vehicle.Radio and !vehicle:GetEngineActive() then
        Schema:EasyText(player, "red", "Your vehicle's engine is not started!");
        return;
    end;

    local currentState = vehicle.Radio:GetDTBool(0);
    local newState = not currentState;
    vehicle.Radio:SetDTBool(0, newState);
end;

COMMAND:Register();

local COMMAND = Clockwork.command:New("SetVehicleFrequency");
    COMMAND.tip = "Set your vehicle's radio frequency.";
    COMMAND.text = "<string Frequency>";
    COMMAND.arguments = 1;

    function COMMAND:OnRun(player, arguments)
        local frequency = arguments[1];
        local vehicle = player:lvsGetVehicle();
        if not IsValid(vehicle) then
            Schema:EasyText(player, "red", "You are not in a valid vehicle!");
            return;
        end;
        if not vehicle.Radio or not IsValid(vehicle.Radio) then
            Schema:EasyText(player, "red", "Your vehicle does not have a radio installed!");
            return;
        end;

        vehicle.Radio:SetNetworkedString("frequency", frequency);
        Schema:EasyText(player, "green", "Radio frequency set to: " .. frequency);
    end;
COMMAND:Register();