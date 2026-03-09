local map = game.GetMap() == "bg_prelude"

-- Called when Clockwork has loaded all of the entities.
function cwAntenna:ClockworkInitPostEntity()
	if (!map) then
        return
    end

    for i, ent in ents.Iterator() do
        if (ent:GetName() == "scarytower") then -- get name off gus
            self.antennaButton = ent
        end
    end

    if(!IsValid(self.antennaButton)) then return; end

    if !self.antennaPower then
		self.antennaPower = Clockwork.kernel:RestoreSchemaData("antennaPower")[1] or 0;

        if self.antennaPower == 1 then -- lever should be the right way on the tower
            self.antennaButton:Fire("Press", nil, 0)
        end
	end
end

function cwAntenna:PlayerCharacterInitialized(player)
	Clockwork.datastream:Start(player, "SetAntennaPower", self.antennaPower);
end;

-- Called when data should be saved.
function cwAntenna:SaveData()
    if self.antennaPower then
        Clockwork.kernel:SaveSchemaData("antennaPower", {self.antennaPower});
    end
end

function cwAntenna:Think()
    if (!map) then
		return;
	end;

    local curTime = CurTime();

    if (!self.checkCooldown or self.checkCooldown < curTime) then
        if(!IsValid(self.antennaButton)) then return; end

		self.checkCooldown = curTime + 1;

        if self.antennaButton:GetInternalVariable("m_toggle_state") == 1 then
            self.antennaPower = 1;
        else
            self.antennaPower = 0;
        end
    end
end