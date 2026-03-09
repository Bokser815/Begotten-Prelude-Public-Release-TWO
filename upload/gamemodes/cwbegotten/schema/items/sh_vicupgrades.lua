local ITEM = Clockwork.item:New();
	ITEM.name = "Jury-Rigged Car Bomb";
	ITEM.model = "models/props_junk/PopCan01a.mdl";
	ITEM.weight = 2;
	ITEM.uniqueID = "carbomb_basic";
	ITEM.category = "Vehicle Upgrades";
	ITEM.description = "A jury-rigged vehicular explosive, designed to detonate in a fiery blaze upon ignition of the engine.";
    ITEM.iconoverride = "materials/begotten/ui/itemicons/small_oil.png";
    ITEM.upgradeID = "upgrade_carbomb_simple";
    ITEM.isVehicleUpgrade = true;
    ITEM.applicableComponents = {"Engine"};

    function ITEM:OnDrop(player, position) end;
	
	ITEM.components = {breakdownType = "meltdown", items = {"gunpowder", "gunpowder", "steel_chunks"}};
ITEM:Register();

local ITEM = Clockwork.item:New();
	ITEM.name = "Timed Car Bomb";
	ITEM.model = "models/props_junk/PopCan01a.mdl";
	ITEM.weight = 2;
	ITEM.uniqueID = "carbomb_timed";
	ITEM.category = "Vehicle Upgrades";
	ITEM.description = "A variant fuse explosive that is designed to explode after a short user-entered delay.";
    ITEM.iconoverride = "materials/begotten/ui/itemicons/small_oil.png";
    ITEM.upgradeID = "upgrade_carbomb_timed";
    ITEM.isVehicleUpgrade = true;
    ITEM.applicableComponents = {"Engine"};

    function ITEM:OnDrop(player, position) end;
	
	ITEM.components = {breakdownType = "meltdown", items = {"gunpowder", "gunpowder", "tech", "steel_chunks"}};
ITEM:Register();

local ITEM = Clockwork.item:New();
	ITEM.name = "Scrap Carbomb";
	ITEM.model = "models/props_junk/PopCan01a.mdl";
	ITEM.weight = 2;
	ITEM.uniqueID = "carbomb_scrap";
	ITEM.category = "Vehicle Upgrades";
	ITEM.description = "A devilishly clever device that is designed to mask its presence by only exploding after a certain number of ignitions.";
    ITEM.iconoverride = "materials/begotten/ui/itemicons/small_oil.png";
    ITEM.upgradeID = "upgrade_carbomb_timed";
    ITEM.isVehicleUpgrade = true;
    ITEM.applicableComponents = {"Engine"};

    function ITEM:OnDrop(player, position) end;
	
	ITEM.components = {breakdownType = "meltdown", items = {"gunpowder", "gunpowder", "iron_chunks", "iron_chunks"}};
ITEM:Register();

local ITEM = Clockwork.item:New();
	ITEM.name = "Vehicle Radio";
	ITEM.model = "models/props_junk/PopCan01a.mdl";
	ITEM.weight = 2;
	ITEM.uniqueID = "vicradio";
	ITEM.category = "Vehicle Upgrades";
	ITEM.description = "Allows communication via radio within a vehicle.";
    ITEM.iconoverride = "materials/begotten/ui/itemicons/handheld_radio.png";
    ITEM.upgradeID = "upgrade_radio";
    ITEM.isVehicleUpgrade = true;
    ITEM.applicableComponents = {"Engine"};

    function ITEM:OnDrop(player, position) end;
	
	ITEM.components = {breakdownType = "meltdown", items = {"tech", "steel_chunks"}};
ITEM:Register();


local ITEM = Clockwork.item:New();
	ITEM.name = "Amphibious Crankshaft";
	ITEM.model = "models/props_junk/PopCan01a.mdl";
	ITEM.weight = 2;
	ITEM.uniqueID = "amphibious_crankshaft";
	ITEM.category = "Vehicle Upgrades";
	ITEM.description = "Improves the survivability of engines submerged in water.";
    ITEM.iconoverride = "materials/begotten/ui/itemicons/tech.png";
    ITEM.upgradeID = "upgrade_amphibious";
    ITEM.isVehicleUpgrade = true;
    ITEM.applicableComponents = {"Engine"};

    function ITEM:OnDrop(player, position) end;
	
	ITEM.components = {breakdownType = "meltdown", items = {"tech", "steel_chunks"}};
ITEM:Register();