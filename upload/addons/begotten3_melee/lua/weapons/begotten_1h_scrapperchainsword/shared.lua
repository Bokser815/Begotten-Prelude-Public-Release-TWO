SWEP.Base = "sword_swepbase"
-- WEAPON TYPE: One Handed

SWEP.PrintName = "Scrapper Chainsword"
SWEP.Category = "(Begotten) One Handed"

SWEP.AdminSpawnable = true
SWEP.Spawnable = true
SWEP.AutoSwitchTo = false
SWEP.Slot = 0
SWEP.Weight = 2
SWEP.UseHands = true

SWEP.HoldType = "wos-begotten_1h"
SWEP.HoldTypeShield = "wos-begotten_1h_shield"

SWEP.ViewModel = "models/v_onehandedbegotten.mdl"
SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false

--Anims
SWEP.BlockAnim = "a_sword_block"
SWEP.CriticalAnim = "a_sword_attack_slash_slow_01"
SWEP.CriticalAnimShield = "a_sword_shield_attack_slash_slow_01"
SWEP.ParryAnim = "a_sword_parry"

SWEP.IronSightsPos = Vector(-7.64, -6.433, -0.96)
SWEP.IronSightsAng = Vector(-2.814, 8.442, -48.543)

--Sounds
SWEP.AttackSoundTable = "ChainswordAttackSoundTable"
SWEP.BlockSoundTable = "ChainswordBlockSoundTable"
SWEP.SoundMaterial = "Metal" -- Metal, Wooden, MetalPierce, Punch, Default

-- Define idle sound path
SWEP.IdleSound = "bgchainswordsfx/sfx_chainsaw_idle_loop_01.ogg"  -- Replace with your sound path

-- Variable to keep track of the sound loop
SWEP.IdleSoundHandle = nil

/*---------------------------------------------------------
	PrimaryAttack
---------------------------------------------------------*/
SWEP.AttackTable = "ChainswordAttackTable"
SWEP.BlockTable = "ChainswordBlockTable"

function SWEP:CriticalAnimation()

	local attacksoundtable = GetSoundTable(self.AttackSoundTable)
	local attacktable = GetTable(self.AttackTable)

	-- Viewmodel attack animation!
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "misscenter1" ) )
	self.Owner:GetViewModel():SetPlaybackRate(0.45)
	
	if (SERVER) then
		timer.Simple( 0.05, function() 
			if self:IsValid() then
				self.Weapon:EmitSound(attacksoundtable["criticalswing"][math.random(1, #attacksoundtable["criticalswing"])])
			end 
		end)
		self.Owner:ViewPunch(Angle(1,4,1))
	end
end

function SWEP:ParryAnimation()
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "misscenter1" ))
end

function SWEP:HandlePrimaryAttack()

	local attacksoundtable = GetSoundTable(self.AttackSoundTable)
	local attacktable = GetTable(self.AttackTable)

	--Attack animation
	if self:GetNW2String("activeShield"):len() > 0 then
		self:TriggerAnim(self.Owner, "a_sword_shield_attack_slash_slow_01");
	else
		self:TriggerAnim(self.Owner, "a_sword_attack_slash_slow_0"..math.random(1,2));
	end

	-- Viewmodel attack animation!
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "misscenter1" ) )
	self.Owner:GetViewModel():SetPlaybackRate(0.45)
	
	self.Weapon:EmitSound(attacksoundtable["primarysound"][math.random(1, #attacksoundtable["primarysound"])])
	self.Owner:ViewPunch(attacktable["punchstrength"])

end

function SWEP:HandleThrustAttack()

	local attacksoundtable = GetSoundTable(self.AttackSoundTable)
	local attacktable = GetTable(self.AttackTable)

	--Attack animation
	if self:GetNW2String("activeShield"):len() > 0 then
		self:TriggerAnim(self.Owner, "a_sword_shield_attack_stab_medium_01");
	else
		self:TriggerAnim(self.Owner, "a_sword_attack_stab_medium_01");
	end

	-- Viewmodel attack animation!
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "thrust1" ) )
	self.Owner:GetViewModel():SetPlaybackRate(0.45)
	
	self.Weapon:EmitSound(attacksoundtable["altsound"][math.random(1, #attacksoundtable["altsound"])])
	self.Owner:ViewPunch(attacktable["punchstrength"])

end

function SWEP:OnDeploy()
	-- Start the idle sound when the weapon is deployed (equipped)
	self:StartIdleSound()

	local attacksoundtable = GetSoundTable(self.AttackSoundTable)
	self.Owner:ViewPunch(Angle(0,1,0))
	if not self.Owner.cwObserverMode then
		self.Weapon:EmitSound(attacksoundtable["drawsound"][math.random(1, #attacksoundtable["drawsound"])])
	end
end

/*---------------------------------------------------------
	Bone Mods
---------------------------------------------------------*/

SWEP.VElements = {
	["v_shishkebab"] = { type = "Model", model = "models/begoyten/weprobs/chainsword/chainsword.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.635, 1.596, 0.557), angle = Angle(88, 265, -180), size = Vector(1, 1, 1), material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["w_shishkebab"] = { type = "Model", model = "models/begoyten/weprobs/chainsword/chainsword.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.596, 0.557, 0), angle = Angle(90, 70, 8.182), size = Vector(1, 1, 1), material = "", skin = 0, bodygroup = {} }
}

function SWEP:StartIdleSound()
    if not self.IdleSoundHandle then
        self.IdleSoundHandle = self:EmitSound(self.IdleSound, 75, 100, 0.5, CHAN_AUTO, 0, 0, true)
        timer.Create("IdleSoundLoop_" .. self:EntIndex(), 5.11, 0, function() 
            if IsValid(self) then
                self:EmitSound(self.IdleSound, 75, 100, 0.5, CHAN_AUTO, 0, 0, true)
            else
                timer.Remove("IdleSoundLoop_" .. self:EntIndex())
            end
        end)
    end
end

function SWEP:StopIdleSound()
    if self.IdleSoundHandle then
        self:StopSound(self.IdleSoundHandle)
        self.IdleSoundHandle = nil
    end
    timer.Remove("IdleSoundLoop_" .. self:EntIndex())
end

function SWEP:OnHolster()
    if self.IdleSoundHandle then
        self:StopSound(self.IdleSoundHandle)
        self.IdleSoundHandle = nil
    end
    self:StopIdleSound()
end

function SWEP:OnRemove()
    if self.IdleSoundHandle then
        self:StopSound(self.IdleSoundHandle)
        self.IdleSoundHandle = nil
    end
    self:StopIdleSound()
end
