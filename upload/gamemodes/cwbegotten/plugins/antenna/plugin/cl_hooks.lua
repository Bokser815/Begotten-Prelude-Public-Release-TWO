local scarySounds = {
    "misc/sight_01.wav",
	"misc/sight_02.wav",
	"misc/sight_03.wav",
	"misc/sight_04.wav",
	"misc/chatter_02.ogg",
	"misc/chatter_03.ogg",
}

function cwAntenna:Think()
    if Clockwork.Client:HasInitialized() then
        local power = Clockwork.Client.antennaPower;
    end
end;

Clockwork.datastream:Hook("SetAntennaTower", function(antennaPower)
	Clockwork.Client.antennaPower = antennaPower;
end);