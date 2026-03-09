PLUGIN:SetGlobalAlias("cwTeleporters");

cwTeleporters.cooldown = 2;
--cwTeleporters.timeBits = 8; -- The amount of bits the teleportation time will use (e.g. 8 = max 255).
--cwTeleporters.fadeSteps = 50; -- May affect server lag. Determines the amount of steps the game will take to fade a player in or out.

cwTeleporters.zones = {
    --[[ Example teleport zone.
    ["layer1_layer2"] = { -- The name of the zone. Shows in debug information.
        enter = { -- An AA box that the player must be inside of to teleport.
            mins = Vector(0, 0, 0),
            maxs = Vector(0, 0, 0),

        },
        exit = { -- A list of points the player may exit to.

        },
        time = 5 -- The total amount of time it takes to teleport (fadeout + fadein).
        exitAngle = angle_zero -- The camera angle that should be set upon teleporting.

    },
    ]]

    ["ashtobridge"] = {
        enter = {
            mins = Vector(-2052, -12576, -653),
            maxs = Vector(-2483 , -12972 , -461),

        },
        exit = {
            --[[Vector(12990, -515, -9549),
            Vector (12883, -520, -9549),
            Vector (12793, -520, -9549),
            Vector (12712, -521, -9549),
            Vector (12713, -613, -9549),
            Vector (12784, -613, -9549),
            Vector (12871, -613, -9549),
            Vector (12962, -613, -9549),]]

            Vector(12974, -4196, -9549),
            Vector(12962, -4257, -9549),
            Vector(12837, -4260, -9549),
            Vector(12720, -4261, -9549),
            Vector(12779, -4170, -9549),
            Vector(12900, -4168, -9549),
            Vector(13006, -4167, -9549),

        },
        exitAngle = Angle(0, -90, 0),
        time = 3,
        
    },


    ["wastestobridge"] = {
        enter = {
            mins = Vector(10910,-15411,4505),
            maxs = Vector(10188,-16256,4999),

        },
        exit = {
            --[[Vector(12974, -4196, -9549),
            Vector(12962, -4257, -9549),
            Vector(12837, -4260, -9549),
            Vector(12720, -4261, -9549),
            Vector(12779, -4170, -9549),
            Vector(12900, -4168, -9549),
            Vector(13006, -4167, -9549),]]

            Vector(12700,-8247,-9549),
            Vector (12824,-8250,-9549),
            Vector (12953,-8279,-9549),
            Vector (12923,-8124,-9549),
            Vector (12817,-8104,-9549),
            Vector (12720,-8079,-9549),
            Vector (12762,-8167,-9549),

        },
        exitAngle = Angle(0, 90, 0),
        time = 3,
        
    },

    ["bridgetoash"] = {
        enter = {
            mins = Vector(13159,-3160,-9638),
            maxs = Vector(12391,-3910,-9146),

        },
        exit = {
            Vector(-2287,-12477,-593),
            Vector(-2392,-12481,-593),
            Vector(-2149,-12477,-593),
            Vector(-2194,-12431,-593),
            Vector(-2284,-12431,-593),
            Vector(-2384,-12432,-593),
            Vector(-2337,-12390,-593),

        },
        exitAngle = Angle(0, 90, 0),
        time = 3,
        
    },

    ["bridgetowastes"] = {
        enter = {
            mins = Vector(12429,-9046,-9698),
            maxs = Vector(13121,-8599,-9241),

        },
        exit = {
            Vector(10629,-14825,4578),
            Vector(10629,-14745,4578),
            Vector(10669,-14785,4578),
            Vector(10589,-14785,4578),
            Vector(10669,-14745,4578),
            Vector(10589,-14745,4578),
            Vector(10729,-14785,4578),

        },
        exitAngle = Angle(0, 90, 0),
        time = 3,
        
    }

};

Clockwork.kernel:IncludePrefixed("sv_hooks.lua");
Clockwork.kernel:IncludePrefixed("cl_hooks.lua");

local COMMAND = Clockwork.command:New("TestTeleporter");
    function COMMAND:OnRun(player, arguments)
        cwTeleporters:BeginTeleport(player, cwTeleporters.zones["layer1_layer2"], CurTime())

    end

COMMAND:Register();

local meta = FindMetaTable("Entity")

function meta:CollisionRulesChanged()
	if(!self.m_OldCollisionGroup) then self.m_OldCollisionGroup = self:GetCollisionGroup(); end
	self:SetCollisionGroup(self.m_OldCollisionGroup == COLLISION_GROUP_DEBRIS and COLLISION_GROUP_WORLD or COLLISION_GROUP_DEBRIS);
	self:SetCollisionGroup(self.m_OldCollisionGroup);
	self.m_OldCollisionGroup = nil;

end

-- Scary code... If you touch it tell dave because this hook is very fragile.
hook.Add("ShouldCollide", "cwTeleporters.ShouldCollide", function(a, b)
    if(a.zoneTeleportingNoCollide or b.zoneTeleportingNoCollide) then return false; end

end);