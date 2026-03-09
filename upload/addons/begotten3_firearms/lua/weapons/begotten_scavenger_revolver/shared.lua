
SWEP.Gun = ("begotten_scavenger_revolver") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "Begotten"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.PrintName				= "Scavenger Revolver"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 2				-- Slot in the weapon selection menu
SWEP.SlotPos				= 28			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- Set false if you want no crosshair from hip
SWEP.Weight				= 30			-- Rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.BoltAction				= true		-- Is this a bolt action rifle?
SWEP.HoldType 				= "pistol"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= false
SWEP.ViewModel = "models/weapons/darky_m/rust/c_revolver.mdl" 
SWEP.WorldModel = "models/weapons/darky_m/rust/w_revolver.mdl"
SWEP.ShowWorldModel			= true
SWEP.Base 					= "begotten_firearm_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.UseHands			= true

SWEP.Secondary.IronFOV			= 55		-- How much you 'zoom' in. Less is more! 


SWEP.Primary.Sound			= Sound("musket/musket1.wav")		-- script that calls the primary fire sound
SWEP.Primary.RPM				= 200		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 6		-- Size of a clip
SWEP.Primary.DefaultClip			= 0	-- Bullets you start with
SWEP.Primary.KickUp				= 2				-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= .6			-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= .5		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "pistol"	-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets


SWEP.data 				= {}
SWEP.data.ironsights		= 1

SWEP.Primary.NumShots	= 1		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 35	-- Base damage per bullet
SWEP.Primary.Spread		= .05	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .015 -- Ironsight accuracy, should be the same for shotguns

-- enter iron sight info and bone mod info below

SWEP.IronSightsPos = Vector(-3.32, 0, 0.839)
SWEP.IronSightsAng = Vector(1.129, 0.035, 0)
SWEP.SightsPos = Vector(-3.32, 0, 0.839)
SWEP.SightsAng = Vector(1.129, 0.035, 0)
SWEP.RunSightsPos = Vector(0, -18.894, -6.83)
SWEP.RunSightsAng = Vector(70, 1.406, 0.703)

SWEP.AmmoTypes = {
	["Pop-a-Shot"] = function(SWEP)
		SWEP.Primary.Sound = Sound("musket/musket1.wav");
		SWEP.Primary.NumShots = 1;
		SWEP.Primary.Damage = 35;
		SWEP.Primary.Spread = .1;
		SWEP.Primary.IronAccuracy = .05;
		SWEP.Primary.Ammo = "pistol";
		
		if SWEP.Owner and SWEP.Owner:IsPlayer() then
			if SWEP.Owner:GetVelocity() == Vector(0, 0, 0) then
				if SWEP.Owner.HasBelief and SWEP.Owner:HasBelief("marksman") then
					if SWEP.Owner:Crouching() then
						SWEP.Primary.Spread = .025;
						SWEP.Primary.IronAccuracy = .0075;
					else
						SWEP.Primary.Spread = .03;
						SWEP.Primary.IronAccuracy = .01;
					end
				else
					if SWEP.Owner:Crouching() then
						SWEP.Primary.Spread = .05;
						SWEP.Primary.IronAccuracy = .0225;
					else
						SWEP.Primary.Spread = .055;
						SWEP.Primary.IronAccuracy = .025;
					end
				end
			end
		end
		
		return true;
	end,
	["Scrapshot"] = function(SWEP) -- Single chambered round.
		SWEP.Primary.Sound = Sound("weapons_moth/p90-1.wav");
		SWEP.Primary.NumShots = 1;
		SWEP.Primary.Damage = 30;
		SWEP.Primary.Spread = .2;
		SWEP.Primary.IronAccuracy = .15;
		
		if SWEP.Owner and SWEP.Owner:IsPlayer() then
			if SWEP.Owner:GetVelocity() == Vector(0, 0, 0) then
				if SWEP.Owner.HasBelief and SWEP.Owner:HasBelief("marksman") then
					if SWEP.Owner:Crouching() then
						SWEP.Primary.Spread = .05;
						SWEP.Primary.IronAccuracy = .03;
					else
						SWEP.Primary.Spread = .075;
						SWEP.Primary.IronAccuracy = .065;
					end
				else
					if SWEP.Owner:Crouching() then
						SWEP.Primary.Spread = .085;
						SWEP.Primary.IronAccuracy = .07;
					else
						SWEP.Primary.Spread = .1;
						SWEP.Primary.IronAccuracy = .085;

					end
				end
			end
		end
		
		return true;
	end,
};

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "Cocked")

	self:SetCocked(false)
end

function SWEP:PrimaryAttack()
	local curTime = CurTime()
	
	if not IsValid(self) or not IsValid(self.Weapon) or not IsValid(self.Owner) then 
		return
	end
	
	if IsFirstTimePredicted() then
		if not self:GetCocked() then
			self:Cock()
			return
		end

		if self.Owner:IsPlayer() and self:CanFireBegotten() then
			if self:GetCocked() and not self.Owner:KeyDown(IN_SPEED) and not self.Owner:KeyDown(IN_RELOAD) then
				if not self:AdjustFireBegotten() then
					return
				end
				
				self:ShootBulletInformation()
				self.Weapon:TakeAmmoBegotten(1)
				self.Weapon:EmitSound(self.Primary.Sound)

				local effect = EffectData()
				local Forward = self.Owner:GetForward()
				local Right = self.Owner:GetRight()
					
				effect:SetOrigin(self.Owner:GetShootPos() + (Forward * 65) + (Right * 5))
				effect:SetNormal(self.Owner:GetAimVector())
				util.Effect("effect_awoi_smoke_pistol", effect)

				self.Owner:SetAnimation(PLAYER_ATTACK1)
				self.Owner:MuzzleFlash()
				self.Weapon:SetNextPrimaryFire(curTime + 0.75)

				self:SetCocked(false)
				timer.Simple( .2, function() self.Owner:EmitSound("scraprevolver/reichsrevolver_fullcock.wav") end )

				if SERVER then
					self.Owner.cloakCooldown = CurTime() + 30
				end
			end
		else
			self.Owner:EmitSound("vj_weapons/dryfire_revolver.wav")
		end
	end
end

function SWEP:Cock()
	if Clockwork and SERVER then
		self.Owner:EmitSound("scraprevolver/paterson_empty.wav")
		Clockwork.player:SetAction(self.Owner, "cocking", 0.5, nil, function()
			self.Owner:EmitSound("scraprevolver/paterson_cock.wav")
			self:SetCocked(true)
		end)
	end
end
