cas.peak = math.Round(game.MaxPlayers() * 0.8);

function cas:PlayerThink(player, curTime, infoTable, alive, initialized, plyTab)
	if (!plyTab.nextAFKTimer or plyTab.nextAFKTimer < curTime) then
		plyTab.nextAFKTimer = curTime + 5;
		
		if self.afkKickerEnabled ~= false then
			local playerCount = _player.GetCount();
			
			if (playerCount < self.peak) then
				return;
			end;
			
			if (player:IsAdmin() or player:IsBot() or player:IsUserGroup("operator")) then
				return;
			end;
			
			if (!initialized) then
				if (!plyTab.lastNotInitialized) then
					plyTab.lastNotInitialized = curTime + 360; -- give them 6 minutes
				elseif (plyTab.lastNotInitialized < curTime) then
					Clockwork.kernel:PrintLog(LOGTYPE_MINOR, "Kicking "..player:Name().." for being AFK in the character menu.");
					player:Kick("You were kicked for being AFK for more than 6 minutes in the character menu.");
				end;
			else
				if (plyTab.lastNotInitialized) then
					plyTab.lastNotInitialized = nil;
				end;
				
				local eyeAngles = player:EyeAngles();

				if (!plyTab.lastAngles) then
					plyTab.lastAngles = eyeAngles.pitch;
				end;
				
				if (plyTab.lastAngles != eyeAngles.pitch) then
					plyTab.lastAFK = curTime + 900;
					plyTab.lastAngles = eyeAngles.pitch;
				elseif (plyTab.lastAFK and plyTab.lastAFK <= curTime) then
					Clockwork.kernel:PrintLog(LOGTYPE_MINOR, "Kicking "..player:Name().." for being AFK.");
					player:Kick("You were kicked for being afk for more than 15 minutes.")
				end;
			end;
		end;
	end;
end;


-- A function to create an ESP trap item.
function cas:CreateTrapItem(player, item, position, bFreeze, Callback)
	if (!IsValid(player) or !player:IsPlayer() or !item or !position or !istable(item) or !isvector(position)) then
		return;
	end;

	if (item) then
		local itemTable = Clockwork.item:CreateInstance(item("uniqueID"));
		local itemEntity = Clockwork.entity:CreateItem(nil, itemTable, position);

		if (IsValid(itemEntity)) then
			itemEntity:SetPos(position);
			itemEntity:SetAngles(Angle(0, 0, 0));
			itemEntity.IsTrapItem = true;
			itemEntity:SetCollisionGroup(COLLISION_GROUP_WORLD);
			
			if (Callback and isfunction(Callback)) then
				itemEntity.PickupTrapCallback = Callback;
			end;

			Clockwork.kernel:PrintLog(LOGTYPE_MAJOR, player:Name().." created a trap '"..itemTable("name").."' item. Anyone who picks this up will notify all staff, and potentially expose ESP usage!");
			
			undo.Create("trap item");
			undo.AddEntity(itemEntity);
			undo.SetPlayer(player);
			undo.AddFunction(function(undoTable, itemTable) 
				Clockwork.kernel:PrintLog(LOGTYPE_MAJOR, undoTable.Owner:GetName().." deleted a trap '"..itemTable("name").."' item.");
			end, itemEntity:GetItemTable());
			undo.Finish();

			if (IsValid(itemEntity) and bFreeze) then
				local physObject = itemEntity:GetPhysicsObject();
				
				if (IsValid(physObject)) then
					physObject:EnableMotion(false)
				end;
			end;
			
			return itemEntity;
		end;
	else
		Schema:EasyText(player, "grey", "The item name specified is not valid!")
	end;
end;

-- A function to spawn a trap item.
function cas:SpawnTrapItem(player, position, uniqueID, bFreeze, zOffset)
	if (position) then
		local item = Clockwork.item:FindByID(uniqueID or "crossbow");
		local zOffset = zOffset or 0;
		
		if (item) then
			self:CreateTrapItem(player, item, position + Vector(0, 0, zOffset), bFreeze, function(player, item)

			end);
		end;
	end;
end;

-- Called when a player picks an item up.
function cas:PlayerPickupItem(player, itemTable, itemEntity, bQuickUse)
	if (itemEntity.IsTrapItem) then
		local uniqueID = itemTable("uniqueID");
		local steamID = player:SteamID();
		
		if (player:HasItemByID(uniqueID)) then
			player:TakeItem(player:FindItemByID(uniqueID));
		end;
		
		if (player:IsAdmin()) then
			return;
		end;

		if (itemEntity.PickupTrapCallback) then
			if (IsValid(player) and IsValid(itemEntity)) then
				itemEntity.PickupTrapCallback(player, itemEntity);
			end;
		end;

		if cwSanity and player:Sanity() <= 50 then
			Clockwork.kernel:PrintLog(LOGTYPE_CRITICAL, "["..player:SteamName().."] "..player:Name().." ("..steamID.." / "..self:StripPort(player:IPAddress())..") has picked up an ESP trap item! However, they are below 50 sanity so it may have been talking to them.");
			Schema:EasyText(GetAdmins(), "icon16/bomb.png", "tomato", "["..player:SteamName().."] "..player:Name().." ("..steamID.." / "..self:StripPort(player:IPAddress())..") has picked up an ESP trap item! However, they are below 50 sanity so it may have been talking to them.");
		else
			Clockwork.kernel:PrintLog(LOGTYPE_CRITICAL, "["..player:SteamName().."] "..player:Name().." ("..steamID.." / "..self:StripPort(player:IPAddress())..") has picked up an ESP trap item!");
			Schema:EasyText(GetAdmins(), "icon16/bomb.png", "tomato", "["..player:SteamName().."] "..player:Name().." ("..steamID.." / "..self:StripPort(player:IPAddress())..") has picked up an ESP trap item!");
		end
	end;
end;

-- A function to strip the port of an IP address.
function cas:StripPort(ipAddress)
	if (!ipAddress or !isstring(ipAddress)) then
		return;
	end;
	
	return string.Explode(":", ipAddress)[1];
end;

function cas:GetStaff()
	local staff = {};
	for _, v in _player.Iterator() do
		if (v:IsAdmin() or v:IsUserGroup("operator")) then
			staff[#staff + 1] = v;
		end;
	end;
	return staff
end;

-- A function to alert all currently online staff members.
function cas:NotifyStaff(text, noStaffCallback, color, icon)
	if (!text or !isstring(text)) then
		return;
	end;
	
	local staff = self:GetStaff();
	local color = color or "cornflowerblue";
	
	if (#staff > 0) then
		Schema:EasyText(staff, icon, color, text)
	else
		if (noStaffCallback) then
			noStaffCallback();
		end;
	end;
end;
