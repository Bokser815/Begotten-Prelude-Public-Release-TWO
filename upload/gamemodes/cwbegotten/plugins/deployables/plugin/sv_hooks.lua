util.AddNetworkString("cwStartDeploying");
util.AddNetworkString("cwStopDeploying");
util.AddNetworkString("cwFinishPlace");
util.AddNetworkString("cwStartingDeployment");

function cwDeployables:StartDeploy(player, entity, model, leftModel, rightModel)
    player.deploying = {
        entity = entity,
        model = model,
        pos = player:GetPos(),
        leftModel = leftModel,
        rightModel = rightModel,

    };

    net.Start("cwStartDeploying");
		net.WriteEntity(player);
        net.WriteTable(player.deploying);
		net.WriteString(entity);
		net.WriteString(model);
	net.Send(player);

end

function cwDeployables:StopDeploying(player)
    net.Start("cwStopDeploying");
    net.Send(player);

    player.deploying = nil;

end

function cwDeployables:DeployFail(player, message, giveBack, dbg, entity)
    if(!IsValid(player)) then return; end
    
    Schema:EasyText(player, "peru", message);

    if(dbg) then
        Schema:EasyText(player, "peru", "---DEBUG INFO (SUBMIT TO #bug-reports)---");
        Schema:EasyText(player, "peru", "entity = "..tostring(player.deploying.entity));
        Schema:EasyText(player, "peru", "model = "..tostring(player.deploying.model));
        Schema:EasyText(player, "peru", "pos = "..tostring(player.deploying.pos));

    end

    if(IsValid(entity)) then entity:Remove(); end

    if(giveBack) then return; end

    self:StopDeploying(player);

end

function cwDeployables:FinishPlace(player, pos, angle, dir)
    if(!IsValid(player)) then return; end
    if(!player.deploying) then return; end
    if(player.deploying.building) then return; end

    local deployedEntity = ents.Create(player.deploying.entity);
    if(!IsValid(deployedEntity)) then self:DeployFail(player, "Something went wrong! Contact an admin.", true, true, deployedEntity); return; end
    
    local tr = player:GetEyeTrace();
    local dist = pos:DistToSqr(player.deploying.pos);

    if(dist > self.maxDistance) then self:DeployFail(player, "That position is too far away from where you started your deployment.", true, false, deployedEntity); return; end
    if(IsValid(tr.Entity) and (tr.Entity != game.GetWorld() and tr.Entity:GetClass() != player.deploying.entity)) then self:DeployFail(player, "You cannot place that on non-terrain.", true, false, deployedEntity); return; end

    local consumeTime = 15 * Lerp((dist/self.maxDistance), 0.8, 2);
    if(player:GetCharmEquipped("wrench")) then consumeTime = consumeTime * 0.6; end

	local armsHealth = math.min(Clockwork.limb:GetHealth(player, HITGROUP_LEFTARM, false), Clockwork.limb:GetHealth(player, HITGROUP_RIGHTARM, false));
    consumeTime = consumeTime * Lerp(armsHealth/75, 3, 1);

    local model = (dir == self.dir.left and player.deploying.leftModel or dir == self.dir.right and player.deploying.rightModel or player.deploying.model);

    player.deploying.building = true;
    net.Start("cwStartingDeployment");
        net.WriteVector(pos);
        net.WriteAngle(angle);
        net.WriteUInt(dir, 2);
    net.Send(player);

    player:EmitSound("prelude/hammering_wood.ogg", 90, math.random(90, 110), 2);

    local name = "DeployingSFX"..player:SteamID();
    timer.Create(name, 5, 0, function()
        if(!IsValid(player)) then timer.Remove(name); return; end
        if(!player.deploying) then timer.Remove(name); return; end

        player:EmitSound("prelude/hammering_wood.ogg", 90, math.random(90, 110), 2);
    
    end);

    Clockwork.player:SetAction(player, "building", consumeTime, nil, function()
        if(!IsValid(player)) then return; end

        deployedEntity:SetAngles(angle);
        deployedEntity:SetPos(pos);
        deployedEntity.owner = player;
        deployedEntity:SetModel(model);
        deployedEntity:Spawn();
        deployedEntity:SetModel(model);
        if !deployedEntity.SpareMovetype then
            deployedEntity:SetMoveType(MOVETYPE_NONE);
        end

        self:StopDeploying(player);
        
        player:StopSound("prelude/hammering_wood.ogg");
        deployedEntity:EmitSound("physics/wood/wood_box_impact_hard1.wav");
        timer.Remove(name);

    end);

end

net.Receive("cwStopDeploying", function(_, player)
    if(!IsValid(player)) then return; end
    if(!player.deploying) then return; end

    player.deploying = nil;

end);

net.Receive("cwFinishPlace", function(_, player)
    cwDeployables:FinishPlace(player, net.ReadVector(), net.ReadAngle(), net.ReadUInt(2));

end)