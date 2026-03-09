PLUGIN:SetGlobalAlias("cwGlobalDeath");

function cwGlobalDeath:SetDeathCount(deathCount)
    self.deathCount = deathCount;

end

function cwGlobalDeath:GetDeathCount()
    return self.deathCount;

end

function cwGlobalDeath:GetStringifiedDeathCount()
    return tostring(self:GetDeathCount());

end

Clockwork.kernel:IncludePrefixed("sv_hooks.lua");
Clockwork.kernel:IncludePrefixed("cl_hooks.lua");

cwGlobalDeath:SetInitialDeathCount();