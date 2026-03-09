util.AddNetworkString("cw_GetGlobalDeathCount");

cwGlobalDeath.file = {name = "globalDeaths.txt", path = "DATA"};

function cwGlobalDeath:GetFileName()
    return self.file.name;

end

function cwGlobalDeath:GetFilePath()
    return self.file.path;

end

function cwGlobalDeath:GetFileInfo()
    return self.file.name, self.file.path;

end

function cwGlobalDeath:GetTypeCastedFileContent()
    if(!file.Exists(self:GetFileInfo())) then
        print("Couldn't find a Global Death file! Creating...");
        file.Write(self:GetFileName(), "0");

    end

    return tonumber(file.Read(self:GetFileInfo()));

end

function cwGlobalDeath:Write()
    file.Write(self:GetFileName(), self:GetDeathCount());

end

function cwGlobalDeath:Increment(amount)
    self:SetDeathCount(self:GetDeathCount() + amount);

end

function cwGlobalDeath:SendDeathCount(player)
    net.Start("cw_GetGlobalDeathCount");
        net.WriteUInt(self:GetDeathCount(), 32);

    if(IsValid(player)) then
        net.Send(player);

    else
        net.Broadcast();

    end

end

net.Receive("cw_GetGlobalDeathCount", function(_, player)
    cwGlobalDeath:SendDeathCount(player);

end);

function cwGlobalDeath:PlayerDeath(player, inflictor, attacker, damageInfo)
    if(player.opponent) then return; end

    self:Increment(1);
    self:SendDeathCount();
    self:Write();

end

gameevent.Listen("player_activate");
hook.Add("player_activate", "cwGlobalDeath_PlayerActivate", function(data)
    cwGlobalDeath:SendDeathCount(Player(data.userid));

end);

function cwGlobalDeath:SetInitialDeathCount()
    self.deathCount = self.deathCount or self:GetTypeCastedFileContent();

end