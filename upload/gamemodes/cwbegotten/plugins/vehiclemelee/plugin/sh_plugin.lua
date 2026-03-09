--[[
	Begotten III: Jesus Wept
	By: DETrooper, cash wednesday, gabs, alyousha35

	Other credits: kurozael, Alex Grist, Mr. Meow, zigbomb
--]]

--[[
	You don't have to do this, but I think it's nicer.
	Alternatively, you can simply use the PLUGIN variable.
--]]
PLUGIN:SetGlobalAlias("cwVehicleMelee");

--[[ You don't have to do this either, but I prefer to seperate the functions. --]]
Clockwork.kernel:IncludePrefixed("sv_hooks.lua");

if SERVER then

	function cwVehicleMelee:StartLockpick(player, vehicle)
		local entity = vehicle;

		if (!IsValid(entity) or (vehicle:GetlvsLockedStatus() == false)) then
			return;
		end;

	
		if (!entity.LockpickCooldown or CurTime() > entity.LockpickCooldown) then
			if (!player.LockpickCooldown or CurTime() > player.LockpickCooldown) then
				local lockstrength = entity.locklevel or 3;
	
				if (lockstrength == 4) then
					Schema:EasyText(player, "peru", "You cannot lockpick this lock!");
					return;
				end;
				
				if (!player:HasItemByID("lockpick")) then
					Schema:EasyText(player, "chocolate", "You have no lockpick!");
					return;
				end;
				
				if cwBeliefs and player.HasBelief then
					if (lockstrength == 3) and not player:HasBelief("safecracker") then
						Schema:EasyText(player, "chocolate", "You need the 'Safecracker' belief to pick Tier III locks!");
						return;
					elseif not player:HasBelief("sly_fidget") then
						Schema:EasyText(player, "chocolate", "You need the 'Sly Fidget' belief to pick Tier I and Tier II locks!");
						return;
					end
				end
				
				-- Added this to uncloak people who are cloaked and lockpicking, we can maybe do more with it.
				hook.Run("LockpickingStarted", player, entity);
				
				entity.LockpickingPlayer = player;
				player:Freeze(true);
				player.LockpickContainer = entity;
				player.Lockpicking = true;
				netstream.Start(player, "StartLockpick", {entity = entity, lockTier = lockstrength});
			else
				Schema:EasyText(player, "peru", "You cannot lockpick for another "..math.ceil(player.LockpickCooldown - CurTime()).." seconds!");
			end;
		else
			Schema:EasyText(player, "peru", "You cannot lockpick this container for another "..math.ceil(entity.LockpickCooldown - CurTime()).." seconds!");
		end;
	end;

end

if CLIENT then



	---------------------------------------------------------------------------------------------------[actually important below]

	local function endmenu(ent, player, locked, vehiclecode, setlock, enter, setlockpicking, opentrunk)
		local netvalues = {
			["vehicle"] = ent,
			["player"] = player,
			["locked"] = locked,
			["vehiclecode"] = vehiclecode,
			["enter"] = enter,
			["setlock"] = setlock,
			["setlockpicking"] = setlockpicking,
			["opentrunk"] = opentrunk,
		}
		net.Start("ClientToServerShittyCarsMenu") -- Start the net message
		net.WriteTable(netvalues)
		net.SendToServer() 
	end

	local function CreateMenu(ent, player, locked, vehiclecode, hasitemdeed, haslockpick, hastrunk)
		if (IsValid(menu)) then
			menu:Remove();
		end;
		
		local scrW = ScrW();
		local scrH = ScrH();
		local menu = DermaMenu();
			
		menu:SetMinimumWidth(150);

		local enter = false
		local setlock = nil
		local setlockpicking = false
		
		if hasitemdeed == true then

			if locked == true then
				menu:AddOption("Unlock", function()
					setlock = false
					endmenu(ent, player, locked, vehiclecode, setlock)
				end);
			elseif locked == false then
				menu:AddOption("Lock", function() 
					setlock = true
					endmenu(ent, player, locked, vehiclecode, setlock)
				end);
			end
		else
			if (locked == true) and (haslockpick == true) then
				menu:AddOption("Lock Pick", function() 
					setlockpicking = true
					local enter = false
					endmenu(ent, player, locked, vehiclecode, setlock, enter, setlockpicking)
				end);
			end

		end

		if (locked == false) and hastrunk and (hastrunk == true) then
			menu:AddOption("Open Trunk", function()
				endmenu(ent, player, locked, vehiclecode, setlock, enter, setlockpicking, hastrunk)
			end);
		end

		if IsValid(ent) and IsValid(player) then
			menu:AddOption("Enter", function()
				local enter = true
				endmenu(ent, player, locked, vehiclecode, setlock, enter, trunk)
			end);
		end
		
		menu:Open();
		menu:SetPos(scrW / 2 - (menu:GetWide() / 2), scrH / 2 - (menu:GetTall() / 2));
	end

	net.Receive("ActivateShittyCarsMenu", function()
		cartable = net.ReadTable()
		local ent = cartable["vehicle"]
		local player = cartable["player"]
		local locked = cartable["locked"]
		local vehiclecode = cartable["vehiclecode"]
		local hasitemdeed = cartable["hasitemdeed"]
		local haslockpick = cartable["haslockpick"]
		local hastrunk = cartable["hastrunk"]
		CreateMenu(ent, player, locked, vehiclecode, hasitemdeed, haslockpick, hastrunk)

	end)

	
end