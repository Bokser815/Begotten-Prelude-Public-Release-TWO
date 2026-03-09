-- Possible coordinates of Exit Hell Portals, organized by map.

//! ADD FOR bg_prelude
local ExitHellPortalCoords = {
	["rp_begotten_prelude"] = {
		{position = Vector(0, 0, 0), angle = Angle(0, 0, 0)},
	},
    ["rp_begotten3"] = {
        {position = Vector(-853.325562, -9019.452148, -6366.787598), angle = Angle(5.020322, -52.831074, 0.000000)},
        {position = Vector(-520.833557, -9041.181641, -6332.623535), angle = Angle(13.459517, -134.173889, 0.000000)},
    }
};


-- Called at an interval.

function cwHellGrinder:Think()

    if !self.ExitHellPortalTimer or self.ExitHellPortalTimer < CurTime() then
        self.ExitHellPortalTimer = CurTime() + math.random(25, 45);

        local map = game.GetMap();

        if ExitHellPortalCoords[map] then

            local randomPortal = math.random(1, #ExitHellPortalCoords[map]);
            randomPortal = ExitHellPortalCoords[map][randomPortal];
            self:SpawnExitHellPortal(randomPortal.position, randomPortal.angle);
            
        end;
    end
end;

-- Called at an interval when a player is connected.
function cwHellGrinder:PlayerThink(player, curTime, infoTable, alive, initialized, plyTab)

    if !plyTab.hellCheck or plyTab.hellCheck < curTime then
        local lastZone = player:GetCharacterData("LastZone");

        if lastZone == "hell" and not player.cwObserverMode then
            if !plyTab.corruptionGain or !plyTab.nextCorruptionIncrease then
                plyTab.corruptionGain = 1;
                plyTab.nextCorruptionIncrease = curTime + 60;
            end

            if plyTab.nextCorruptionIncrease < curTime then
                plyTab.corruptionGain = plyTab.corruptionGain + 1;
                plyTab.nextCorruptionIncrease = curTime + 60;
            end

            player:HandleNeed("corruption", math.random((plyTab.corruptionGain * 0.75), (plyTab.corruptionGain * 1.5)));
        else
            if plyTab.corruptionGain or plyTab.nextCorruptionIncrease then
                plyTab.corruptionGain = nil;
                plyTab.nextCorruptionIncrease = nil;
            end
        end

        plyTab.hellCheck = curTime + 6;
    end
end;

-- A function to spawn an Exit Hell Portal. Only used in cwHellGrinder:Think().
function cwHellGrinder:SpawnExitHellPortal(pos, ang)
    local portal = ents.Create("cw_exit_hell_portal");

    portal:SetPos(pos);
    portal:SetAngles(ang);
    portal:Spawn();
    portal:Activate();

    timer.Simple(math.random(20, 35), function()
        if IsValid(portal) then
            portal:Remove();
        end
    end);
end;

function cwHellGrinder:SpawnEnterHellPortal(pos, time)
    local portal = ents.Create("cw_enter_hell_portal");

    portal:SetPos(pos);
    portal:Spawn();
    portal:Activate();

    if not time then
        time = math.random(10, 15);
    end

    timer.Simple(time, function()
        if IsValid(portal) then
            portal:Remove();
        end
    end);
end;