--[[
	Begotten III: Jesus Wept
	By: DETrooper, cash wednesday, gabs, alyousha35

	Other credits: kurozael, Alex Grist, Mr. Meow, zigbomb
--]]

-- Called when the foreground HUD should be painted.
-- This function decreases general vehicle damage and allows players to block vehicle damage.

util.AddNetworkString("ActivateShittyCarsMenu")
util.AddNetworkString("ClientToServerShittyCarsMenu")

net.Receive("ClientToServerShittyCarsMenu", function()
	cartable = net.ReadTable()
	local ent = cartable["vehicle"]
	local player = cartable["player"]
	local locked = cartable["locked"]
	local vehiclecode = cartable["vehiclecode"]
	local setlock = cartable["setlock"]
	local enter = cartable["enter"]
	local setlockpicking = cartable["setlockpicking"]
	local opentrunk = cartable["opentrunk"]
	local distance = player:GetPos():Distance(ent:GetPos())
	local hasitemdeed = false
	if player.lasttimereceivednetmessagevehicle and CurTime() - player.lasttimereceivednetmessagevehicle < 1 then return end
	player.lasttimereceivednetmessagevehicle = CurTime()
	if IsValid(ent) and IsValid(player) and distance < 400 then

		if ent and ent.vehiclecode then
			local itemList = Clockwork.inventory:GetItemsAsList(player:GetInventory());

			for k, v in pairs (itemList) do
				if v.uniqueID == "vehicle_deed" then
					if v:GetData("VehicleCode") == ent.vehiclecode then
						hasitemdeed = true
					end
				end
			end
		end

		local blockageclear = tostring(setlock)

		local blockagecleartrunk = tostring(opentrunk)

		if ent:GetlvsLockedStatus() == false and blockagecleartrunk == "true" then

			if ent.trunkWeight then
				if (!ent.cwInventory) then
					ent.cwInventory = {};
				end;

				if !ent.cwCash then
					ent.cwCash = 0;
				end

				player:EmitSound("physics/body/body_medium_impact_soft"..math.random(1, 7)..".wav");
				
				local weight = ent.trunkWeight
				
				Clockwork.storage:Open(player, {
					name = "Trunk",
					weight = weight,
					entity = ent,
					distance = ent:OBBMaxs():Length(),
					inventory = ent.cwInventory,
					cash = ent.cwCash,
					OnGiveCash = function(player, storageTable, cash)
						ent.cwCash = storageTable.cash;
					end,
					OnTakeCash = function(player, storageTable, cash)
						ent.cwCash = storageTable.cash;
					end
				});

				return
			end

		end

		if hasitemdeed == true then
			
			if blockageclear and blockageclear == "false" then
				ent:SetlvsLockedStatus( false )
				ent:EmitSound( "doors/latchlocked2.wav" )
				return
			end
			if blockageclear and blockageclear == "true" then
				ent:SetlvsLockedStatus( true )
				ent:EmitSound( "doors/latchlocked2.wav" )
				return
			end
		else
			local blockageclearlockpick = tostring(setlockpicking)
			if blockageclearlockpick == "true" then
				if player:HasItemByID("lockpick") then
					cwVehicleMelee:StartLockpick(player, ent)
					return
				end
			end
		end

		

		if enter and enter == true and ent:GetlvsLockedStatus() == false then
			cwVehicleMelee:CustomEnter(player,ent)
		else
			
			ent:EmitSound( "doors/latchlocked2.wav" )
		end
	end
end)

local function GetBlockTable(ent, wep)
	local blockTable;

	if wep:GetNWString("activeOffhand"):len() > 0 then
		local offhandTable = weapons.GetStored(wep:GetNWString("activeOffhand"));
					
		if offhandTable then
			blockTable = GetDualTable(wep.realBlockTable, offhandTable.BlockTable);
		else
			blockTable = GetTable(wep.realBlockTable);
		end
	else
		blockTable = GetTable(wep.realBlockTable);
	end

	return blockTable;

end

local function HandleShieldCondition(ent, wep, dmg)
	if(ent.opponent or !wep) then return; end

	if(ent:HasBelief("ingenuity_finisher")) then return; end

	local shieldItemTable = ent:GetShieldEquipped();
	local weaponItemTable = item.GetByWeapon(wep);
	local shieldEquipped = false;
	local conditionScale = (ent:HasBelief("scour_the_rust") and 100 or 50);
	
	if shieldItemTable and wep:GetNWString("activeShield") == shieldItemTable.uniqueID then
		shieldItemTable:TakeCondition(math.max(dmg / conditionScale, 1));

		return;

	end

	if(!weaponItemTable) then return; end

	weaponItemTable:TakeCondition(math.max(dmg / conditionScale, 1));
			
	local offhand = wep:GetNWString("activeOffhand");
	
	if(offhand:len() <= 0) then return; end

	for k, v in pairs(ent.equipmentSlots) do
		if(!v:IsTheSameAs(weaponItemTable)) then continue; end

		local offhandItemTable = ent.equipmentSlots[k.."Offhand"];
		
		if(!offhandItemTable) then continue; end

		offhandItemTable:TakeCondition(math.max(dmg / conditionScale, 1));

		break;

	end

end

function cwVehicleMelee:BegottenCorpsed(ent)
	if ent.cwInventory and (!table.IsEmpty( ent.cwInventory ) or ent.cwCash > 0) then
		local belongings = ents.Create("cw_belongings");
		local entity = ent
		belongings:SetAngles(Angle(0, 0, -90));
		belongings:SetData(entity.cwInventory, entity.cwCash);
		belongings:SetPos(entity:GetPos() + Vector(0, 0, 32));
		belongings:Spawn();
	end
end

function cwVehicleMelee:CustomEnter(ent,ent2)
	local player = ent
	local vehicle = ent2
	local speed = vehicle:GetVelocity():Length();
	local hasitemdeed = false
	if !player.nextvehicleentertimer then player.nextvehicleentertimer = 0 end
	if CurTime() < player.nextvehicleentertimer then return end
	player.nextvehicleentertimer = CurTime() + 2

	local tr = util.TraceLine{
		start = vehicle:WorldSpaceCenter(),
		endpos = vehicle:WorldSpaceCenter()+vehicle:GetAngles():Up()*-250,
		filter = vehicle
	}
	if tr.Hit == false then
		if !vehicle.AdjustTimer then vehicle.AdjustTimer=0 end
		if vehicle.AdjustTimer<CurTime() then
			if cwBeliefs and !player:HasBelief("strength") then
				Schema:EasyText(player, "chocolate", "Flipping this vehicle requires strength!");
				Clockwork.chatBox:AddInTargetRadius(player, "me", "tries to flip a vehicle but is too weak.", player:GetPos(), config.Get("talk_radius"):Get() * 2);
				return
			end
			vehicle.AdjustTimer=CurTime()+1
			local phys = vehicle:GetPhysicsObject()
			if phys:IsValid() then
				phys:AddAngleVelocity(-phys:GetAngleVelocity() * 7)
				local ang = phys:GetAngles()
				local angp = math.NormalizeAngle(ang.p)
				local angr = math.NormalizeAngle(ang.r)
				phys:AddAngleVelocity(-Vector(angr, angp, 0) * 7)
				Clockwork.chatBox:AddInTargetRadius(player, "me", "tries to flip a vehicle.", player:GetPos(), config.Get("talk_radius"):Get() * 2);
			end
		end
		return
	end

	timer.Simple(0.5, function()		
		if speed > 30 then
			Schema:EasyText(player, "chocolate", "This vehicle is moving too fast.");
			return
		else
			if player:KeyDown(IN_USE) then

				if vehicle and vehicle.vehiclecode then
					local itemList = Clockwork.inventory:GetItemsAsList(player:GetInventory());
	
					for k, v in pairs (itemList) do
						if v.uniqueID == "vehicle_deed" then
							if v:GetData("VehicleCode") == vehicle.vehiclecode then
								hasitemdeed = true
							end
						end
					end
				end

				local hastrunk = false
				if vehicle.trunkWeight then hastrunk = true end

				if !vehicle.vehiclecode then vehicle.vehiclecode = 1 end
				local netvalues = {
					["vehicle"] = vehicle,
					["player"] = player,
					["locked"] = vehicle:GetlvsLockedStatus(),
					["vehiclecode"] = vehicle.vehiclecode,
					["hasitemdeed"] = hasitemdeed or false,
					["haslockpick"] = player:HasItemByID("lockpick"),
					["hastrunk"] = hastrunk
				}
				net.Start("ActivateShittyCarsMenu") -- Start the net message
				net.WriteTable(netvalues)
				net.Send(player) -- Send to the specific player
				return
			end
			if vehicle:GetlvsLockedStatus() == false then
				Clockwork.chatBox:AddInTargetRadius(player, "me", "starts to climb into a vehicle.", player:GetPos(), config.Get("talk_radius"):Get() * 2);
				Clockwork.player:SetAction(player, "entervehicle", 4, nil, function()
					if IsValid(player) and IsValid(vehicle) and player:Alive() and player:GetPos():Distance(vehicle:GetPos()) < 400 then
						vehicle:SucessBegottenEnter(player)
					else
						return
					end
				end);
			else
				ent:EmitSound( "doors/latchlocked2.wav" )
			end
		end
	end)
end

function cwVehicleMelee:CustomDismount(ply,vehicle)
	local speed = vehicle:GetVelocity():Length();
	if speed > 240 then
		timer.Simple(0.5, function()
			if IsValid(ply) then
				Clockwork.player:SetRagdollState(ply, RAGDOLL_FALLENOVER, 6);
				Clockwork.chatBox:AddInTargetRadius(ply, "me", "trips after jumping out of the vehicle at high speeds like a retard.", ply:GetPos(), config.Get("talk_radius"):Get() * 2);
			end
		end)
	end
end

--self:SetlvsLockedStatus( true )

function cwVehicleMelee:CustomCallTouched(ent,ent2)
	--if(!ent:IsPlayer() or !ent:Alive()) then return; end
	if !IsValid(ent) then return end
	if !IsValid(ent2) then return end

	if !ent.nextVehicleDamage then ent.nextVehicleDamage = 0 end
	if ent.nextVehicleDamage and (CurTime() < ent.nextVehicleDamage) then
		return;
	end
	ent.nextVehicleDamage = CurTime() + 2;
	local speed = ent2:GetVelocity():Length();

	if !ent2.weightclass then
		ent2.weightclass = 1;
	end

	--ent2:SetCollisionGroup(COLLISION_GROUP_NPC_SCRIPTED)
	

	if speed < 10 then
		return 
	end

	local driver = ent2:GetDriver();
	
	local dmgInfo = DamageInfo()
	dmgInfo:SetAttacker(ent) -- set to driver
	dmgInfo:SetDamage(speed/6)

	if IsValid(driver) then
		dmgInfo:SetAttacker(driver)
	end
	
	--if(!dmgInfo:GetAttacker():IsVehicle() and !dmgInfo:GetInflictor():IsVehicle()) and dmgInfo:GetInflictor().LVS!=true then return; end

	--dmgInfo:ScaleDamage(0.15);
	

	

	local selfangles = ent2:GetVelocity()

	if !ent:IsPlayer() and !ent:IsNPC() and !ent:IsNextBot() then
		local phys = ent:GetPhysicsObject()
		if !IsValid(phys) then return end 
		local mass = phys:GetMass()
		local force = mass * 1.5
		ent2.nextVehicleDamage = CurTime() + 1
		phys:ApplyForceCenter(selfangles * force, 0, 1)

		
		if ent.DSArmorIgnoreForce then ent.DSArmorIgnoreForce = 0 end
		if ent2.DSArmorIgnoreForce then ent2.DSArmorIgnoreForce = 0 end

		local dmgInfo2 = DamageInfo()
		--dmgInfo2:SetDamage(speed/(4-ent2.weightclass))
		dmgInfo2:SetDamageType(128)
		dmgInfo2:SetAttacker(ent)
		dmgInfo2:SetInflictor(ent)
		--dmgInfo2:SetDamageType( 32 )
		if IsValid(driver) then
			dmgInfo2:SetAttacker(driver)
		end
		if ent.isspiky then
			dmgInfo2:SetDamage((speed*10)/ent2.weightclass)
		else
			dmgInfo2:SetDamage(speed/(4-ent2.weightclass))
		end
		
		--dmgInfo2:SetDamage(speed/(5+ent2.weightclass))
		ent:TakeDamageInfo(dmgInfo2)
		--dmgInfo2:SetDamage(dmgInfo2:GetDamage()/ent2.weightclass)
		ent2:TakeDamageInfo(dmgInfo2)
		ent:EmitSound("physics/metal/metal_box_break2.wav");
		return
	elseif ent:IsNextBot() or ent:IsNPC() then
		local dmgInfo2 = DamageInfo()
		dmgInfo2:SetDamage(speed/(4-ent2.weightclass))
		dmgInfo2:SetDamageType(128)
		dmgInfo2:SetAttacker(ent)
		dmgInfo2:SetInflictor(ent)
		if IsValid(driver) then
			dmgInfo2:SetAttacker(driver)
		end
		ent2:TakeDamageInfo(dmgInfo2)
		dmgInfo2:SetDamage((speed/(5+ent2.weightclass))+25)
		ent:TakeDamageInfo(dmgInfo2)
		ent:EmitSound("physics/metal/metal_box_break2.wav");

		if ent.Category and ent.Category == "Begotten DRG" then
			
			
			local ragdoll = ents.Create("prop_ragdoll")
			ragdoll:SetPos(ent:GetPos()) 
			ragdoll:SetAngles(ent:GetAngles()) 
			ragdoll:SetModel(ent:GetModel())
			ragdoll:Spawn()
			ragdoll:Activate()
			ragdoll.fuckerdowned = true
			ragdoll.enttype = ent:GetClass()
			ragdoll.enthealth = ent:Health()

			ragdoll:EmitSound("Zombie.AttackMiss");

			ent:Remove()

			timer.Simple(2, function()
				if IsValid(ragdoll) and !ragdoll.fuckersuperdead then
					
					local zombieNPC = ents.Create(ragdoll.enttype);
					local pos =  ragdoll:GetPos()
					pos.z = pos.z + (zombieNPC:OBBMaxs().z - zombieNPC:OBBMins().z)
					zombieNPC:SetPos(pos);
					zombieNPC:SetAngles(Angle(0, 0, 0));
					zombieNPC:Spawn();
					zombieNPC:SetHealth(ragdoll.enthealth)
					ragdoll:Remove()
					
				end
			end);
		end
		return
	end

	if (!ent:GetNWBool("Guardening")) then 
		ent:TakeStability(666);
		ent:TakeDamageInfo(dmgInfo)
		ent:SetVelocity(selfangles * 10)
		return; 
	end
	
	local wep = ent:GetActiveWeapon();

	if(!wep or !wep.IsABegottenMelee) then 
		ent:TakeStability(666);
		ent:TakeDamageInfo(dmgInfo)
		ent:SetVelocity(selfangles * 10)
		return; 
	end

	local blockTable = GetBlockTable(ent, wep);

	if istable(blockTable)==false then 
		ent:TakeStability(666);
		ent:TakeDamageInfo(dmgInfo)
		ent:SetVelocity(selfangles * 10)
		return; 
	end

	local blocksoundtable = GetSoundTable(wep.realBlockSoundTable)
	local blockthreshold = (blockTable["blockcone"] or 135) / 2;

	if math.abs(math.AngleDifference(ent:EyeAngles().y, (ent2:GetPos() - ent2:GetPos()):Angle().y)) <= blockthreshold then
		local vehicle = ent2
		local vehiclecha = vehicle:GetPhysicsObject()
		ent:EmitSound(blocksoundtable["blockmetal"][math.random(1, #blocksoundtable["blockmetal"])]);
		local damageamount = dmgInfo:GetDamage()
		HandleShieldCondition(ent, wep, damageamount*30);
		if blockTable["damagereduction"] then
			dmgInfo:ScaleDamage(1-blockTable["damagereduction"]);
		else
			dmgInfo:ScaleDamage(0.2);
			ent:TakeStability(damageamount);
		end
		
		local poisereduction = damageamount-math.Clamp(damageamount*(0.01*blockTable["poiseresistance"]),0,damageamount)

		ent:HandleStamina(-poisereduction);

		if IsValid(vehiclecha) then
			vehiclecha:ApplyForceCenter(ent:GetAimVector() * 1000000*math.Clamp(0.01*blockTable["poiseresistance"], 0, 1))
		end
		local dmgAmount = poisereduction  -- The amount of damage to apply

		

		local dmgInfo2 = DamageInfo()
		dmgInfo2:SetDamage(dmgAmount)
		dmgInfo2:SetDamageType(128)
		dmgInfo2:SetAttacker(ent)
		dmgInfo2:SetInflictor(ent)
		if IsValid(driver) then
			dmgInfo2:SetAttacker(driver)
		end
		vehicle:TakeDamageInfo(dmgInfo2)

		ent:EmitSound("physics/metal/metal_box_break2.wav");
		ent:ViewPunch(Angle(-10,7,6));
		return
	else
	end
	ent:TakeDamageInfo(dmgInfo)
	ent:TakeStability(666);
	ent:SetVelocity(selfangles * 10)
end

function cwVehicleMelee:PreEntityTakeDamage(ent, dmgInfo)
	if(!dmgInfo:GetAttacker():IsVehicle() and !dmgInfo:GetInflictor():IsVehicle()) and dmgInfo:GetInflictor().LVS!=true then return; end
	dmgInfo:ScaleDamage(0);
end

function cwVehicleMelee:EntityTakeDamage(ent, dmgInfo)
	if !IsValid(ent) then return end
	if ent.begottenarmor then
		if ent.begottenarmor[dmgInfo:GetDamageType()] then
			local damagetypereduction = ent.begottenarmor[dmgInfo:GetDamageType()]
			dmgInfo:ScaleDamage(1-damagetypereduction);
		end
	end
	if ent.fuckerdowned and !ent.fuckersuperdead then
		if dmgInfo:GetDamageType() == 1 then return end
		ent.enthealth = ent.enthealth - dmgInfo:GetDamage()
		if dmgInfo:GetAttacker():IsPlayer() then
			if ent.attackers == nil then
				ent.attackers = {}
			end
			ent.attackers[#ent.attackers+1] = dmgInfo:GetAttacker():GetCharacterKey()
		end
		if ent.enthealth <= 0 then
			local zombieNPC = ents.Create(ent.enttype);
			local pos =  ent:GetPos()
			pos.z = pos.z + (zombieNPC:OBBMaxs().z - zombieNPC:OBBMins().z)
			zombieNPC:SetPos(pos);
			zombieNPC:SetAngles(Angle(0, 0, 0));
			zombieNPC:Spawn();
			zombieNPC:SetHealth(ent.enthealth)
			cwZombies:OnNPCKilled(zombieNPC, dmgInfo:GetAttacker(), dmgInfo:GetInflictor(), ent.attackers)
			zombieNPC:Remove()
			if IsValid(ent) then
				local ragdoll = ent
				ent.fuckersuperdead = true
                ParticleEffectAttach("doom_dissolve", PATTACH_POINT_FOLLOW, ragdoll, 0);
				
				timer.Simple(1.6, function() 
					if IsValid(ragdoll) then
						ParticleEffectAttach("doom_dissolve_flameburst", PATTACH_POINT_FOLLOW, ragdoll, 0);
						ragdoll:Fire("fadeandremove", 1);
						ragdoll:EmitSound("begotten/npc/burn.wav");
					end
				end)
            end
		end
	end
end

function cwVehicleMelee:OnEntityCreated(ent)
	if IsValid(ent) and ent.LVS then
		if ent.preferredskin then
			ent:SetSkin( ent.preferredskin )
		end
	end
	timer.Simple(1, function()
		if IsValid(ent) then
			if ent:IsNextBot() then
				for _, v in ipairs(ents.GetAll()) do
					if IsValid(v) and v.LVS then
						ent:AddEntityRelationship( v, D_HT, 99 )
					end
				end
			end
			if ent.LVS then
				
				for _, v in ipairs(ents.GetAll()) do
					if IsValid(v) and v:IsNextBot() then			
						v:AddEntityRelationship( ent, D_HT, 99 )
					end
				end
			end
		end
	end)
end

