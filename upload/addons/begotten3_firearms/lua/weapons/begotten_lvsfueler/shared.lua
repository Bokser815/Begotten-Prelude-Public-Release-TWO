SWEP.Category				= "Begotten"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.ViewModel			= "models/weapons/c_repairlvs.mdl"
SWEP.WorldModel			= "models/weapons/w_repairlvs.mdl"
SWEP.UseHands				= true
SWEP.Category				= "Begotten"

SWEP.HoldType				= "slam"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip		= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "pistol"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic		= false
SWEP.Secondary.Ammo		= "pistol"
SWEP.Primary.RPM				= 1		-- This is in Rounds Per Minute
SWEP.Primary.NumShots	= 1		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 1	-- Base damage per bullet
SWEP.Primary.Spread		= .02	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .01 -- Ironsight accuracy, should be the same for shotguns

SWEP.AmmoTypes = {
	["SmeltStick"] = function(SWEP)
		SWEP.Primary.Sound = Sound("others/ubo_4.mp3");
		SWEP.Primary.NumShots = 24;
		SWEP.Primary.Damage = 10;
		SWEP.Primary.Spread = .2;
		SWEP.Primary.IronAccuracy = .2;
		SWEP.Primary.Ammo = "pistol";
		
		return true;
	end,
};

SWEP.MaxRange = 250

function SWEP:SetupDataTables()
	self:NetworkVar( "Float",0, "FlameTime" )
end

function SWEP:GetLVS()
	local ply = self:GetOwner()

	if not IsValid( ply ) then return NULL end

	local ent = ply:GetEyeTrace().Entity

	if not IsValid( ent ) then return NULL end

	if ent.LVS then return ent end

	if not ent.GetBase then return NULL end

	ent = ent:GetBase()

	if IsValid( ent ) and ent.LVS then return ent end

	return NULL
end

function SWEP:FindClosest()
	local lvsEnt = self:GetLVS()

	if not IsValid( lvsEnt ) then return NULL end

	local ply = self:GetOwner()

	if ply:InVehicle() then return end

	local ShootPos = ply:GetShootPos()
	local AimVector = ply:GetAimVector()

	local ClosestDist = self.MaxRange
	local ClosestPiece = NULL

	for _, entity in pairs( lvsEnt:GetChildren() ) do
		if entity:GetClass() ~= "lvs_armor" then continue end

		local boxOrigin = entity:GetPos()
		local boxAngles = entity:GetAngles()
		local boxMins = entity:GetMins()
		local boxMaxs = entity:GetMaxs()

		local HitPos, _, _ = util.IntersectRayWithOBB( ShootPos, AimVector * 1000, boxOrigin, boxAngles, boxMins, boxMaxs )

		if isvector( HitPos ) then
			local Dist = (ShootPos - HitPos):Length()

			if Dist < ClosestDist then
				ClosestDist = Dist
				ClosestPiece = entity
			end
		end
	end

	return ClosestPiece
end

local function IsEngineMode( AimPos, Engine )
	if not IsValid( Engine ) then return false end

	if not isfunction( Engine.GetDoorHandler ) then return (AimPos - Engine:GetPos()):Length() < 25 end

	local DoorHandler = Engine:GetDoorHandler()

	if IsValid( DoorHandler ) then
		if DoorHandler:IsOpen() then
			return (AimPos - Engine:GetPos()):Length() < 50
		end

		return false
	end

	return (AimPos - Engine:GetPos()):Length() < 25
end

if CLIENT then
	SWEP.PrintName		= "Scrap Torch"
	SWEP.Author			= "Blu-x92"

	SWEP.Slot				= 5
	SWEP.SlotPos			= 1

	SWEP.Purpose			= "Repair Broken Armor"
	SWEP.Instructions		= "Primary to Repair\nHold Secondary to switch to Armor Repair Mode"
	SWEP.DrawWeaponInfoBox 	= true

	SWEP.WepSelectIcon 			= surface.GetTextureID( "weapons/lvsrepair" )

	local ColorSelect = Color(0,255,255,50)
	local ColorText = Color(255,255,255,255)

	local function DrawText( pos, text, col )
		cam.Start2D()
			local data2D = pos:ToScreen()

			if not data2D.visible then return end

			local font = "BarTextBegotten"

			local x = data2D.x
			local y = data2D.y

			draw.DrawText( text, font, x + 1, y + 1, Color(179, 46, 49, 255), TEXT_ALIGN_CENTER )
			draw.DrawText( text, font, x + 2, y + 2, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER )
			draw.DrawText( text, font, x, y, Color(179, 46, 49, 255), TEXT_ALIGN_CENTER )
		cam.End2D()
	end

	function SWEP:DrawEffects( weapon, ply )
		local ID = weapon:LookupAttachment( "muzzle" )

		local Muzzle = weapon:GetAttachment( ID )

		if not Muzzle then return end

		local T = CurTime()

		if self:GetFlameTime() < T or (self._NextFX1 or 0) > T then return end

		self._NextFX1 = T + 0.02

		local effectdata = EffectData()
		effectdata:SetOrigin( Muzzle.Pos )
		effectdata:SetAngles( Muzzle.Ang )
		effectdata:SetScale( 0.5 )
		util.Effect( "MuzzleEffect", effectdata, true, true )

		if (self._NextFX2 or 0) > T then return end

		self._NextFX2 = T + 0.06

		local trace = ply:GetEyeTrace()
		local ShootPos = ply:GetShootPos()

		if (ShootPos - trace.HitPos):Length() > self.MaxRange then return end

		local effectdata = EffectData()
			effectdata:SetOrigin( trace.HitPos )
			effectdata:SetNormal( trace.HitNormal * 0.15 )
		util.Effect( "manhacksparks", effectdata, true, true )

		local dlight = DynamicLight( self:EntIndex() )

		if not dlight then return end

		dlight.pos = (trace.HitPos + ShootPos) * 0.5
		dlight.r = 206
		dlight.g = 253
		dlight.b = 255
		dlight.brightness = 3
		dlight.decay = 1000
		dlight.size = 256
		dlight.dietime = CurTime() + 0.1
	end

	function SWEP:PostDrawViewModel( vm, weapon, ply )
		self:DrawEffects( vm, ply )
	end

	function SWEP:DrawWorldModel( flags )
		self:DrawModel( flags )
		self:DrawEffects( self, self:GetOwner() )
	end

	function SWEP:DrawHUD()
		local ply = self:GetOwner()

		if not IsValid( ply ) or not ply:KeyDown( IN_ATTACK2 ) then
			local lvsEnt = self:GetLVS()
			local Pos = ply:GetEyeTrace().HitPos

			if IsValid( lvsEnt ) and (Pos - ply:GetShootPos()):Length() < self.MaxRange and not ply:InVehicle() then
				if isfunction( lvsEnt.GetEngine ) then
					local Engine = lvsEnt:GetEngine()

					local AimPos = ply:GetEyeTrace().HitPos

					local EngineMode = IsEngineMode( AimPos, Engine )

					if IsValid( Engine ) and EngineMode then
						DrawText( AimPos, "Engine\nHealth: "..math.Round(Engine:GetHP()).."/"..Engine:GetMaxHP(), ColorText )
					else
						DrawText( AimPos, "Frame\nHealth: "..math.Round(lvsEnt:GetHP()).."/"..lvsEnt:GetMaxHP(), ColorText )
					end
				else
					DrawText( ply:GetEyeTrace().HitPos, "Frame\nHealth: "..math.Round(lvsEnt:GetHP()).."/"..lvsEnt:GetMaxHP(), ColorText )
				end
			end

			return
		end

		local Target = self:FindClosest()

		if IsValid( Target ) then
			local boxOrigin = Target:GetPos()
			local boxAngles = Target:GetAngles()
			local boxMins = Target:GetMins()
			local boxMaxs = Target:GetMaxs()

			cam.Start3D()
				render.SetColorMaterial()
				render.DrawBox( boxOrigin, boxAngles, boxMins, boxMaxs, ColorSelect )
			cam.End3D()

			DrawText( Target:LocalToWorld( (boxMins + boxMaxs) * 0.5 ), (Target:GetIgnoreForce() / 100).."mm "..Target:GetLabel().."\nHealth: "..math.Round(Target:GetHP()).."/"..Target:GetMaxHP(), ColorText )
		else
			local Pos = ply:GetEyeTrace().HitPos

			if IsValid( self:GetLVS() ) and (Pos - ply:GetShootPos()):Length() < self.MaxRange and not ply:InVehicle() then
				DrawText( Pos, "No Armor", ColorText )
			end
		end
	end
end

function SWEP:Initialize()
	self:SetHoldType( self.HoldType )
end

function SWEP:TakeAmmoBegotten(amount)
	if Clockwork then
		local itemTable = item.GetByWeapon(self);
		
		if itemTable then
			local ammo = itemTable:GetData("Ammo");
			local magazine;

			local amountstick = itemTable:GetData("smeltamount")
			print(#ammo)
			if ammo and #ammo > 0 then
				for i = 1, amount do
					table.remove(ammo, amount - (i - 1));
					if SERVER then
						itemTable:SetData("smeltamount",50)
					end
				end
			else
				ammo = {};
			end
			
			--[[if itemTable.usesMagazine then
				if ammo and #ammo > 0 then
					local round = ammo[1];
					
					if string.find(round, "Magazine") then
						magazine = round;
					end
				end
			end
			
			if ammo and #ammo > amount then
				for i = 1, amount do
					table.remove(ammo, amount - (i - 1));
				end
			else
				ammo = {};
			end
			
			if SERVER then
				if table.IsEmpty(ammo) and magazine then
					if IsValid(self.Owner) and self.Owner:IsPlayer() then
						local magazineItemID = string.gsub(string.lower(magazine), " ", "_");
						local magazineItem = item.CreateInstance(magazineItemID);
						
						if magazineItem and magazineItem.SetAmmoMagazine then
							magazineItem:SetAmmoMagazine(0);
							
							self.Owner:GiveItem(magazineItem);
						end
					end
				end
			end
			
			if itemTable.SetData then
				itemTable:SetData("Ammo", ammo);
				PrintTable(itemTable:GetData("Ammo"))
			end]]
			
			-- Also handle weapon item condition here.
			if itemTable.TakeCondition then
				local conditionLoss = 0.2;
				
				if IsValid(self.Owner) and self.Owner:IsPlayer() then
					if self.Owner.HasBelief then
						if self.Owner:HasBelief("ingenuity_finisher") then
							return;
						elseif self.Owner:HasBelief("scour_the_rust") then
							conditionLoss = conditionLoss / 2;
						end
					end
				end
				
				itemTable:TakeCondition(conditionLoss);
			end
		end
	end
end

function SWEP:CanFireBegotten()
	if Clockwork then
		if Schema and (Schema.towerSafeZoneEnabled) then
			if self.Owner.GetFaction and self.Owner.InTower and self.Owner:InTower() and not self.Owner:IsAdmin() then
				local faction = self.Owner:GetFaction();
			
				if faction ~= "Gatekeeper" and faction ~= "Holy Hierarchy" and faction ~= "Pope Adyssa's Gatekeepers" then
					if SERVER then
						Clockwork.player:Notify(self.Owner, "You cannot attack in this holy place!");
					end
					
					return false;
				end
			end
		end

		if self.Owner:GetNWBool("Cloaked", false) == true then
			return false;
		end
	
		local itemTable = item.GetByWeapon(self);
		
		if itemTable then
			local ammo = itemTable:GetData("Ammo");
			local amount = itemTable:GetData("smeltamount")
			print(amount)
			if (amount and amount > 0) or (ammo and #ammo > 0) then
				if SERVER then
					itemTable:SetData("smeltamount",amount - 1)
				end
				return true;
			else
				return false;
			end
		end
	end
	
	return true;
end

function SWEP:PrimaryAttack()
	if self.Owner:IsPlayer() and self:CanFireBegotten() then
		local T = CurTime()

		self:SetNextPrimaryFire( T + 0.15 )

		self.Weapon:TakeAmmoBegotten(1);

		self:SetFlameTime( T + 0.3 )

		local EngineMode = false
		local ArmorMode = true
		local Target = self:FindClosest()

		local ply = self:GetOwner()

		if IsValid( ply ) and not ply:KeyDown( IN_ATTACK2 ) then
			Target = self:GetLVS()

			if isfunction( Target.GetEngine ) then
				local Engine = Target:GetEngine()

				local AimPos = ply:GetEyeTrace().HitPos

				EngineMode = IsEngineMode( AimPos, Engine )

				if IsValid( Engine ) and EngineMode then
					Target = Engine
				end
			end

			ArmorMode = false
		end

		if not IsValid( Target ) then
			if !IsValid(self) or !IsValid(ply) then return end
			local ent = ply:GetEyeTrace().Entity

			if IsValid( ent ) and (ent:GetPos() - ply:GetShootPos()):Length() < self.MaxRange and ent:GetClass() == "lvs_item_mine" then
				if SERVER then timer.Simple(0, function() if not IsValid( ent ) then return end ent:Detonate() end ) end
			end
			return
		end

		local HP = Target:GetHP()
		local MaxHP = Target:GetMaxHP()

		if IsFirstTimePredicted() then
			local trace = ply:GetEyeTrace()

			if HP ~= MaxHP then
				local effectdata = EffectData()
				effectdata:SetOrigin( trace.HitPos )
				effectdata:SetNormal( trace.HitNormal )
				util.Effect( "stunstickimpact", effectdata, true, true )
			end
		end

		if CLIENT then return end

		Target:SetHP( math.min( HP + 7, MaxHP ) )

		if EngineMode and Target:GetDestroyed() then
			Target:SetDestroyed( false )
		end

		if not ArmorMode then return end

		if Target:GetDestroyed() then Target:SetDestroyed( false ) end

		if HP < MaxHP then return end

		Target:OnRepaired()
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Think()
	local ply = self:GetOwner()

	if not IsValid( ply ) then self:StopSND() return end

	local PlaySound = self:GetFlameTime() >= CurTime() and (ply:GetShootPos() - ply:GetEyeTrace().HitPos):Length() < self.MaxRange

	if PlaySound then
		self:PlaySND()
	else
		self:StopSND()
	end
end

function SWEP:StopSND()
	if CLIENT then return end

	if not self._snd then return end

	self._snd:Stop()
	self._snd = nil
end

function SWEP:PlaySND()
	if CLIENT then return end

	if self._snd then return end

	local ply = self:GetOwner()

	if not IsValid( ply ) then return end

	self._snd = CreateSound( ply, "lvs/weldingtorch_loop.wav" )
	self._snd:PlayEx(1, 70 )
end

function SWEP:OnRemove()
	self:StopSND()
end

function SWEP:OnDrop()
	self:StopSND()
end

function SWEP:Holster( wep )
	self:StopSND()
	return true
end
