--[[
	Begotten III: Jesus Wept
	By: DETrooper, cash wednesday, gabs, alyousha35

	Other credits: kurozael, Alex Grist, Mr. Meow, zigbomb
--]]

local FACTION = Clockwork.faction:New("Piston's Scrappers");
	FACTION.whitelist = false;
	FACTION.useFullName = false;
	FACTION.disabled = false; -- For events.
	FACTION.hidden = false;
	FACTION.material = "begotten/faction/faction_logo_scrappers";
	FACTION.color = Color(92, 64, 51);
	FACTION.description = "Be slaves do crime";
	FACTION.availablefaiths = {"Faith of the Family", "Faith of the Dark", "Faith of the Light"};
	FACTION.subfactions = {
		-- ask edgy

		--[[{name = "Cavalier", startingRank = 5, whitelist = true, subtitle = "Road Warriors & Conceited Slavers", description = "Scrapper warbands, malleable as they are, have a history of coopting the cultures from the lands that they rove and raid through. Throughout the County Districts, a series of scrapper warbands have picked up the archaic idea of knighthood, as an extension of their prolific use of vehicles. These \"cavaliers\" are a far-cry from the heroic Glazic knights of old, and are no more than professional cutthroats with misplaced pride in their achievements and an extreme proclivity for taking extreme risks searching for fame and glory.", attributes = {{Color(0, 225, 0), "(+) Pattyroller: Increased reward for selling slaves"}, {Color(0, 225, 0), "(+) Deft Driver: Faster entry into vehicles"}, {Color(0, 225, 0), "(+) Starts at Sacrament Level 5"}, {Color(0, 225, 0), "(+) Starts with 'Hauberk' and 'Wrestle and Subdue' belief unlocked"}, {Color(255, 0, 0), "(-) Destructive: Less materials from breaking down scrap equipment"}, {Color(255, 0, 0), "(-) Locked to \"Faith of the Light\" or \"Faith of the Family\" faiths"}}},
		{name = "Fuelsaint", startingRank = 4, whitelist = true, subtitle = "Heresiarchical Zealots of the Engine", description = "Piston's rise to power was precedented by a rise in religious fervor within the Rust Fiends. Despite coming from many faiths, a tangential thread of heresiarchical belief has begun to take root within the Rust Fiends warband, centering around the idea of expressing religious devotion via vehicular manslaughter. These \"fuelsaints\" view their vehicles as mobile sanctums, decorating their vehicles with signs of their patron god, holding onto their deeds with sacrosanct fervor, and religiously consuming fuel and tar-fumes as an ecclesiastical activity.", attributes = {{Color(0, 225, 0), "(+) Tiphereth: Can consume fuel"}, {Color(0, 225, 0), "(+) Starts at Sacrament Level 4"}, {Color(255, 0, 0), "(-) Lamplight: Incurs double corruption on all activities"}}},
		{name = "Truck-Monkey", startingRank = 7, whitelist = true, subtitle = "Malformed, Crafty, Tinkerers & Pyrotechnicians", description = "The slaves of Scrappers are notoriously over-worked and under-fed, with just over 80% dying in their first week of hard labor (by Scribe estimate). However, roughly 10% tend to survive decades, becoming extremely emaciated yet quite dexterous with their hands. This can be explained by the ancient Scrapper art of strapping slaves on a conveyor lane to produce components for their many machines. If the slave fails to do their part in the production line, they are tortured senselessly for hours, even days at a time. Oil soaks into their skin as they tinker with machined components every day, giving them their signature name. Over time, their physique changes as they are deprived of proper food or sleep, becoming husks fueled on stimulants and Anal Slop. At their seventh year of servitude, they appear to hit their peak efficiency, now being able to manipulate delicate components into functional machinery in less-than-half the time of a normal man, moving with truly inhuman speed. The result of such severe conditioning is that of the Blackhand, a weak and timid thing, yet useful and often irreplaceable at this stage of their life.", attributes = {{Color(255, 0, 0), "(+) Handymen: Doubled vehicle repair speed and half cost on item repairs"}, {Color(0, 225, 0), "(+) Starts at Sacrament Level 7"}, {Color(255, 0, 0), "(-) Cannot wield Great Weapons or wear Heavy Armor"}, {Color(255, 0, 0), "(-) Timid: The \"Brutality\" Tree is locked."}}},
		{name = "Scut", whitelist = false, subtitle = "The Broken Many", description = "Sold and paid for. A scut is the shackled property of Piston himself. They serve as an expendable workforce, and are known to steal and massacre to earn their freedom. The only way up from the dregs of scutdom is to acquire both ownership of a vehicle, or sometimes to have found your replacement in the enslaving of another. They are often short lived, and are at the mercy of any true scrapper of Piston's Warband.", attributes = {{Color(255, 0, 0), "(-) Comes from nothing."}}},--]]
	};
	FACTION.singleGender = GENDER_MALE;
	FACTION.characterLimit = 1; -- # of characters of this faction a player can have.
	FACTION.names = "glazic";
	FACTION.imposters = true;
	
	-- Called when a player is transferred to the faction.
	function FACTION:OnTransferred(player, faction, name)
		if (faction.name ~= "Wanderer") then
			return false;
		end;
		
		if (!Clockwork.player:IsWhitelisted(player, faction.name)) then
			Clockwork.player:SetWhitelisted(player, faction.name, true);
		end;
	end;
FACTION_SCRAPPERS = FACTION:Register();
