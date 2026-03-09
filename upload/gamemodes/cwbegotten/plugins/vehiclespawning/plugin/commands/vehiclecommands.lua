local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("SetVehicleHealth");
COMMAND.tip = "Sets the health of a vehicle you are looking at.";
COMMAND.text = "<number Amount>";
COMMAND.access = "s";
COMMAND.arguments = 1;
COMMAND.alias = {"SetVHealth", "VHealth"};

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
    local trace = player:GetEyeTraceNoCursor();
    if (trace.Hit) then

        if trace.Entity and IsValid(trace.Entity) and trace.Entity.LVS == true then
            local ent = trace.Entity;
            ent:SetHP(arguments[1]);
            Schema:EasyText(player, "darkgrey", "Vehicle "..ent.PrintName.."'s health has been set to "..ent:GetHP()..".");
        end
    else
        Schema:EasyText(player, "darkgrey", "You are not looking at a valid vehicle.");
    end;
end;

COMMAND:Register();

local COMMAND = Clockwork.command:New("SetVehicleFuel");
COMMAND.tip = "Sets the fuel of a vehicle you are looking at.";
COMMAND.text = "<number Amount>";
COMMAND.access = "s";
COMMAND.arguments = 1;
COMMAND.alias = {"SetVFuel", "VFuel"};

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
    local trace = player:GetEyeTraceNoCursor();
    if (trace.Hit) then
        --
        if trace.Entity and IsValid(trace.Entity) and trace.Entity.LVS == true then
            local ent = trace.Entity;
            ent:SetFuel(arguments[1]);
            Schema:EasyText(player, "darkgrey", "Vehicle "..ent.PrintName.."'s fuel has been set to "..ent:GetFuel()..".");
        end
    else
        Schema:EasyText(player, "darkgrey", "You are not looking at a valid vehicle.");
    end;
end;

COMMAND:Register();

local COMMAND = Clockwork.command:New("SetVehicleClaimable");
COMMAND.tip = "Sets whether or not a vehicle is claimable or not that you are looking at.";
COMMAND.text = "[bool IsClaimable]";
COMMAND.access = "s";
COMMAND.arguments = 1;
COMMAND.alias = {"SetVClaimable", "VClaim"};

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
    local trace = player:GetEyeTraceNoCursor();
    if (trace.Hit) then

        if trace.Entity and IsValid(trace.Entity) and trace.Entity.LVS == true then
            local ent = trace.Entity;
            local bool = tobool(arguments[1])
            ent.Claimable = bool
            Schema:EasyText(player, "darkgrey", "Vehicle "..ent.PrintName.."'s claimability has been set to "..tostring(ent.Claimable)..".");
            if bool == true then
                ent.isclaimable = true;
                ent.vehiclecode = nil;
                ent.buyer = nil;
                ent.usedtime = nil; 
            end
        end
    else
        Schema:EasyText(player, "darkgrey", "You are not looking at a valid vehicle.");
    end;
end;

COMMAND:Register();

if SERVER then
    util.AddNetworkString("Smigglify")

    concommand.Add("smiggle_him", function(ply, cmd, args)
        if ply:IsAdmin() then
            local tr = ply:GetEyeTrace()
            local target = tr.Entity

            if IsValid(target) and target:IsPlayer() then
                net.Start("Smigglify")
                net.Send(target)
                Schema:EasyText("cornflowerblue", "Entity smigglified.")
            else
                Schema:EasyText("grey", "No player found.")
            end           
        end
    end)
end


if CLIENT then
    local modify = {
        ["$pp_colour_addr"]        = 2 * 0.02,
        ["$pp_colour_addg"]        = 1 * 0.02,
        ["$pp_colour_addb"]        = 4 * 0.02,
        ["$pp_colour_brightness"]  = -0.3,
        ["$pp_colour_contrast"]    = 10,
        ["$pp_colour_colour"]      = 5,
        ["$pp_colour_mulr"]        = 0,
        ["$pp_colour_mulg"]        = 0,
        ["$pp_colour_mulb"]        = 0,
    }
    local mat = Material("pp/texturize/rainbow.png")
    local screenheight = ScrH()

    local buffActive = false
    local buffStartTime = nil

    local function BuffPostDrawHUD()
        if not buffActive then return end
        DrawColorModify(modify)
        DrawToyTown(20, screenheight)
        DrawTexturize(1, mat)
    end

    local function BuffHUDPaint()
        if not buffStartTime then return end
        local elapsed = CurTime() - buffStartTime
        if elapsed < 10 then
            local secondsLeft = math.ceil(10 - elapsed)
            draw.SimpleText("GOD IS COMING: " .. secondsLeft, "Immortal", ScrW() / 2, ScrH() / 2, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end

    net.Receive("Smigglify", function(len)
        buffStartTime = CurTime()
        hook.Add("HUDPaint", "BuffHUDPaint", BuffHUDPaint)
        timer.Simple(10, function()
            buffActive = true
            hook.Add("PostDrawHUD", "BuffPostDrawHUD", BuffPostDrawHUD)
            hook.Remove("HUDPaint", "BuffHUDPaint")
        end)
    end)
end