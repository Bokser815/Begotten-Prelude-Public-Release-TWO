SWEP.Base = "sword_swepbase"
-- WEAPON TYPE: Polearm

SWEP.PrintName = "Bludgeoner"
SWEP.Category = "(Begotten) Polearm"

SWEP.AdminSpawnable = true
SWEP.Spawnable = true
SWEP.AutoSwitchTo = false
SWEP.Slot = 0
SWEP.Weight = 2
SWEP.UseHands = true

SWEP.HoldType = "wos-begotten_spear_2h"

SWEP.ViewModel = "models/weapons/cstrike/c_knife_t.mdl"
SWEP.ViewModelFOV = 80
SWEP.ViewModelFlip = false

--Anims
SWEP.BlockAnim = "a_spear_2h_block"
SWEP.CriticalAnim = "a_spear_2h_halberd_attack2"
SWEP.ParryAnim = "a_spear_2h_parry"

SWEP.IronSightsPos = Vector(3.64, -8.04, -6.56)
SWEP.IronSightsAng = Vector(10, 0.703, 50)

--Sounds
SWEP.AttackSoundTable = "MetalSpearAttackSoundTable"
SWEP.BlockSoundTable = "WoodenBlockSoundTable"
SWEP.SoundMaterial = "MetalPierce" -- Metal, Wooden, MetalPierce, Punch, Default

/*---------------------------------------------------------
	PrimaryAttack
---------------------------------------------------------*/
SWEP.AttackTable = "BludgeonerAttackTable"
SWEP.BlockTable = "BludgeonerBlockTable"

-- For polearms only
SWEP.ShortPolearm = false
SWEP.CanSwipeAttack = false

function SWEP:CriticalAnimation() --Thrust critical

	local attacksoundtable = GetSoundTable(self.AttackSoundTable)

	-- Viewmodel attack animation!
	self.Weapon:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
	self.Owner:GetViewModel():SetPlaybackRate(0.5)
	
	if (SERVER) then
	timer.Simple( 0.05, function() if self:IsValid() then
	self.Weapon:EmitSound(attacksoundtable["criticalswing"][math.random(1, #attacksoundtable["criticalswing"])])
	end end)	
	self.Owner:ViewPunch(Angle(1,4,1))
	end
	
end

function SWEP:ParryAnimation()
	local vm = self.Owner:GetViewModel()
    self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK );
end 

function SWEP:HandlePrimaryAttack()

	local attacksoundtable = GetSoundTable(self.AttackSoundTable)
	local attacktable = GetTable(self.AttackTable)

	--Attack animation
	if IsValid(self) then
		self:TriggerAnim(self.Owner, "a_spear_2h_halberd_attack1");
	end
	
	-- Viewmodel attack animation!
	local vm = self.Owner:GetViewModel()
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:GetViewModel():SetPlaybackRate(0.25)
	
	self:EmitSound(attacksoundtable["primarysound"][math.random(1, #attacksoundtable["primarysound"])])
	self.Owner:ViewPunch(attacktable["punchstrength"])

end

function SWEP:HandleThrustAttack()

	local attacksoundtable = GetSoundTable(self.AttackSoundTable)
	local attacktable = GetTable(self.AttackTable)

	--Attack animation
	self:TriggerAnim(self.Owner, "a_spear_2h_attack_medium");

	-- Viewmodel attack animation!
	self.Weapon:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
	self.Owner:GetViewModel():SetPlaybackRate(0.5)
	
	self:EmitSound(attacksoundtable["altsound"][math.random(1, #attacksoundtable["altsound"])])
	self.Owner:ViewPunch(attacktable["punchstrength"])

end

function SWEP:OnDeploy()
	local attacksoundtable = GetSoundTable(self.AttackSoundTable)
	self.Owner:ViewPunch(Angle(0,5,0))
	if !self.Owner.cwObserverMode then self.Weapon:EmitSound(attacksoundtable["drawsound"][math.random(1, #attacksoundtable["drawsound"])]) end;
end

/*---------------------------------------------------------
	Bone Mods
---------------------------------------------------------*/

SWEP.ViewModelBoneMods = {
	["v_weapon.Knife_Handle"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(14.444, 0, 0) },
	["ValveBiped.Bip01_Spine4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, -12.789), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(-0.556, 0, 2.407), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(-2.3, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0.925), angle = Angle(-56.667, 0, 0) }
}

SWEP.VElements = {
	["v_spear_wingedspear"] = { type = "Model", model = "models/weapons/peasantstar/bludgeoner.mdl", bone = "v_weapon.Knife_Handle", rel = "", pos = Vector(0.799, 0.519, 0.832), angle = Angle(288.7, 0, -29.222), size = Vector(0.799, 0.799, 0.799), material = "", skin = 0, bodygroup = {} },
}

SWEP.WElements = {
	["w_spear_wingedspear"] = { type = "Model", model = "models/weapons/peasantstar/bludgeoner.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.596, 0.557, -5.557), angle = Angle(-258.312, 57.272, 31.558), size = Vector(1, 1, 1), material = "", skin = 0, bodygroup = {} }
}