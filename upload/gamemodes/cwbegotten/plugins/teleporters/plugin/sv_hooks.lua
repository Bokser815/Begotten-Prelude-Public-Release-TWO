util.AddNetworkString("cwBeginTeleport");
util.AddNetworkString("cwEndTeleport");

function cwTeleporters:RemoveAllTimers(player)
    local entIndex = player:EntIndex();

    timer.Remove("cwZoneTeleport"..entIndex);
    timer.Remove("cwZoneTeleportFinished"..entIndex);

end

function cwTeleporters:AbortTeleport(player)
    local curTime = CurTime();

    net.Start("cwEndTeleport");
    net.Send(player);

    player:SetSharedVar("zoneTeleporting", false);
    player.nextZoneTeleport = curTime + self.cooldown;
    player.zoneTeleportInvulnerability = 0;

    self:RemoveAllTimers(player);

    player.zoneTeleportingNoCollide = false;
    player:CollisionRulesChanged();

end

function cwTeleporters:BeginTeleport(player, zone, curTime)
    player:SetSharedVar("zoneTeleporting", true);
    player.nextZoneTeleport = curTime + zone.time + self.cooldown;

    player:SetColor(ColorAlpha(player:GetColor(), 0));

    local halfTime = zone.time * 0.5;

    net.Start("cwBeginTeleport");
    net.Send(player);

    player:SetCustomCollisionCheck(true);
    player.zoneTeleportingNoCollide = true;
    player:CollisionRulesChanged();

    local entIndex = player:EntIndex();
    --local fadeDelay = halfTime / self.fadeSteps;
    local teleportTime = curTime + halfTime;

    player:SetSharedVar("zoneTeleportWhichWayToFade", 1);
    player:SetSharedVar("zoneTeleportFadeTime", halfTime);
    player:SetSharedVar("zoneTeleportFade", teleportTime);

    timer.Create("cwZoneTeleport"..entIndex, halfTime, 1, function()
        if(!IsValid(player)) then return; end

        local curTime = CurTime();
        local teleportTime = curTime + halfTime;
        
        player:SetSharedVar("zoneTeleportWhichWayToFade", 2);
        player:SetSharedVar("zoneTeleportFadeTime", halfTime);
        player:SetSharedVar("zoneTeleportFade", teleportTime);
        player:SetSharedVar("zoneTeleportFinishing", true);
        player:SetSharedVar("exitAngles", zone.exitAngle);

        player:SetPos(zone.exit[math.random(#zone.exit)]);

        timer.Create("cwZoneTeleportFinished"..entIndex, halfTime, 1, function()
            if(!IsValid(player)) then return; end

            player:SetSharedVar("exitAngles", nil);
            player:SetSharedVar("zoneTeleportFinishing", false);
            player:SetSharedVar("zoneTeleporting", false);
            player:SetColor(ColorAlpha(player:GetColor(), 255));

            net.Start("cwEndTeleport");
            net.Send(player);

            player:SetCustomCollisionCheck(false);
            player.zoneTeleportingNoCollide = false;
            player:CollisionRulesChanged();
        
        end);

        player.zoneTeleportInvulnerability = curTime + halfTime;
    
    end);

end

function cwTeleporters:PlayerThink(player, curTime)
    if(player:GetSharedVar("zoneTeleporting")) then return; end
    if(player.nextZoneTeleport and player.nextZoneTeleport > curTime) then return; end

    local pos = player:GetPos();

    for i, v in pairs(self.zones) do
        if(!pos:WithinAABox(v.enter.mins, v.enter.maxs)) then continue; end

        self:BeginTeleport(player, v, curTime);

    end

end

function cwTeleporters:PreEntityTakeDamage(player)
    if(!player:IsPlayer()) then return; end

    --[[if(player:GetSharedVar("zoneTeleporting") and player:GetSharedVar("zoneTeleportFinishing")) then
        return true;

    end]]

end

function cwTeleporters:PostEntityTakeDamage(player, _, took)
    if(!player:IsPlayer() or !player:GetSharedVar("zoneTeleporting") or !took) then return; end

    self:AbortTeleport(player);

end