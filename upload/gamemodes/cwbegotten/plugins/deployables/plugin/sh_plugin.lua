PLUGIN:SetGlobalAlias("cwDeployables");

cwDeployables.maxDistance = 200*200;
cwDeployables.dir = {
    none = 0,
    left = 1,
    right = 2,

};

Clockwork.kernel:IncludePrefixed("cl_plugin.lua");
Clockwork.kernel:IncludePrefixed("sv_hooks.lua");