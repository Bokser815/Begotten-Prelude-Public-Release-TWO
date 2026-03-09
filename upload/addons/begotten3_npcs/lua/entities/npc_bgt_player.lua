if not DrGBase then return end -- return if DrGBase isn't installed

game.AddParticles("particles/doom_fx.pcf")
PrecacheParticleSystem("doom_dissolve");
PrecacheParticleSystem("doom_dissolve_flameburst");

local weaponTypes = {
	["wos-begotten_1h"] = {
		idle = "a_sword_unholstered_idle",
		walk = "a_sword_unholstered_walk",
		run = "a_sword_unholstered_run",
		attack = "a_sword_attack_slash@#",
		altAttack = "a_sword_attack_stab_medium_01",

	},

	["wos-begotten_spear_1h"] = {
		idle = "a_spear_2h_unholstered_idle",
		walk = "a_spear_2h_unholstered_walk",
		run = "a_spear_2h_unholstered_run",
		attack = "a_spear_2h_attack_medium",
		poleAttack = "a_spear_2h_halberd_attack1_fast",

	},

	["wos-begotten_spear_2h"] = {
		idle = "a_spear_2h_unholstered_idle",
		walk = "a_spear_2h_unholstered_walk",
		run = "a_spear_2h_unholstered_run",
		attack = "a_spear_2h_attack_medium",
		poleAttack = "a_spear_2h_halberd_attack1_fast",

	},

	["wos-begotten_2h_great"] = {
		idle = "a_heavy_great_unholstered_idle",
		walk = "a_heavy_great_unholstered_walk",
		run = "a_heavy_great_unholstered_run",
		attack = "a_heavy_great_attack_slash_01",

	},

	["wos-begotten_2h"] = {
		idle = "a_heavy_2h_unholstered_idle",
		walk = "a_heavy_2h_unholstered_walk",
		run = "a_heavy_2h_unholstered_run",
		attack = "a_heavy_2h_attack_slash_01",
		altAttack = "a_heavy_2h_attack_stab_01",

	},

	["wos-begotten_1h_shield"] = {
		idle = "a_sword_shield_unholstered_idle",
		walk = "a_sword_shield_unholstered_walk",
		run = "a_sword_shield_unholstered_run",
		attack = "a_sword_shield_attack_slash_slow_01",
		altAttack = "a_sword_shield_attack_stab_medium_01",

	},

	["wos-begotten_fists"] = {
		idle = "a_fists_unholstered_idle",
		walk = "a_fists_unholstered_walk",
		run = "a_fists_unholstered_run",
		attack = "a_fists_attack#",

	},

	--[[["wos-begotten_2h"] = {
		idle = "_unholstered_idle",
		walk = "_unholstered_walk",
		run = "_unholstered_run",
		attack = "_attack_slash_01",

	},]]

};

local specialWeaponAttacks = {
	["begotten_rapier"] = {
		{"a_sword_attack_stab_fast_01"},

	},

	["begotten_dagger"] = {
		{"a_sword_attack_stab_dagger"},

	},

	["begotten_2h_quarterstaff"] = {
		{"a_spear_2h_halberd_attack1_fast"},

	},

	["begotten_polearm_billhook"] = {
		{"a_spear_2h_halberd_attack@"},
		{"a_spear_2h_attack_medium", true},

	},

	["begotten_polearm_gatekeeperpoleaxe"] = {
		{"a_spear_2h_halberd_attack1@"},
		{"a_spear_2h_attack_medium", true},

	},

	["begotten_polearm_lucerne"] = {
		{"a_spear_2h_halberd_attack"},
		{"a_spear_2h_attack_medium", true},

	},

	["begotten_polearm_warspear"] = {
		{"a_spear_2h_attack_slow"},
		{"a_spear_2h_halberd_attack2", true},

	},

	["begotten_polearm_"] = {
		{"a_spear_2h_halberd_attack1@"},
		{"a_spear_2h_attack_medium", true},

	},

};

local animationVariants = {
	["a_sword_attack_slash_slow_0"] = {1, 2},
	["a_sword_attack_slash_fast_0"] = {1, 2},
	["a_fists_attack"] = {1, 2},

};

local strikeTimes = {
	["begotten_1h"] = {
		[0.35] = "_slow_0",
		[0.3] = "_fast_0",

	},

	["begotten_sacrificial_hellfiresword"] = {
		[0.35] = "_slow_0",
		[0.3] = "_fast_0",

	},

	["begotten_polearm"] = {
		[0.55] = "",
		[0.45] = "_fast",

	},

};

function ENT:GetAttackAnim()
	local anim = self.AttackAnimation;
	local isAltAttack = false;

	if(self.parrySuccess) then
		return self.CriticalAnimation;

	elseif(self.WeaponAnimTable.altAttack and math.random(0, 1) == 1) then
		seq = self:LookupSequence(self.WeaponAnimTable.altAttack);
		isAltAttack = true;

	end

	for i, v in pairs(specialWeaponAttacks) do
		if(!string.find(self:GetNWString("weaponClass"), i)) then continue; end

		local result = v[math.random(#v)];
		anim = result[1];
		isAltAttack = result[2] or false;

		print(anim, isAltAttack)

		break;

	end

	local char = string.find(anim, "@");
	if(char) then
		local strikeTime = self.MeleeAttackStrikeTime;
		local replacement = "";

		for i, v in pairs(strikeTimes) do
			if(!string.find(self:GetNWString("weaponClass"), i)) then continue end;

			for ii, vv in pairs(v) do
				if(strikeTime >= ii) then
					replacement = vv;
					break;
	
				end
	
			end

			break;

		end

		anim = string.SetChar(anim, char, replacement);

	end

	print(anim)

	local char = string.find(anim, "#");
	if(char) then
		local replacement = "";
		local without = string.SetChar(anim, char, replacement);

		if(animationVariants[without]) then replacement = math.random(animationVariants[without][1], animationVariants[without][2]); end

		anim = string.SetChar(anim, char, replacement);

	end

	print(anim)

	return anim, isAltAttack;

end

ENT.Base = "drgbase_nextbot" -- DO NOT TOUCH (obviously)
-- Misc --
ENT.PrintName = "Player"
ENT.Category = "Begotten DRG"
ENT.Models = {"models/begotten/satanists/wraitharmor.mdl"}
ENT.BloodColor = DONT_BLEED
ENT.RagdollOnDeath = true;
-- Sounds --
ENT.OnDamageSounds = {};
ENT.OnDeathSounds = {};
ENT.PainSounds = {};
-- Stats --
ENT.SpawnHealth = 2
ENT.SpotDuration = 20
-- AI --
ENT.RangeAttackRange = 0
ENT.MeleeAttackRange = 80
ENT.ReachEnemyRange = 60
ENT.AvoidEnemyRange = 0
ENT.HearingCoefficient = 0.5
ENT.SightFOV = 300
ENT.SightRange = 1024
ENT.XPValue = 15;
-- Relationships --
ENT.Factions = {}
-- Movements/animations --
ENT.UseWalkframes = true
ENT.RunAnimation = ACT_RUN
ENT.RunSpeed = (config.GetVal("run_speed") or 0);
ENT.WalkSpeed = config.GetVal("walk_speed");
ENT.JumpAnimation = "releasecrab"
ENT.RunAnimRate = 0
-- Climbing --
ENT.ClimbLedges = true
ENT.ClimbProps = true
ENT.ClimbLedgesMaxHeight = 300
ENT.ClimbLadders = true
ENT.ClimbSpeed = 100
ENT.ClimbUpAnimation = "run_all_grenade"--ACT_ZOMBIE_CLIMB_UP --pull_grenade
ENT.ClimbOffset = Vector(-14, 0, 0)

ENT.ArmorMaterial = "cloth";
ENT.ArmorPiercing = 0;

ENT.Damage = 40;
-- Detection --
ENT.EyeBone = "ValveBiped.Bip01_Spine4"
ENT.EyeOffset = Vector(7.5, 0, 5)
-- Possession --
ENT.PossessionEnabled = true
ENT.PossessionMovement = POSSESSION_MOVE_8DIR
ENT.PossessionViews = {
	{
		offset = Vector(0, 30, 20),
		distance = 100
	},
	{
		offset = Vector(7.5, 0, 0),
		distance = 0,
		eyepos = true
	}
}

function ENT:PossessionBlock(keyDown)
	self.shouldBlock = keyDown;
	if(self.shouldBlock and !self.isBlocking and !self.isAttacking) then
		self.isBlocking = true;

		self.blockLayer = self:AddGestureSequence(self:LookupSequence(self.BlockAnimation), false);
		self:EmitSound(self.MeleeBlockSoundTable["guardsound"][math.random(#self.MeleeBlockSoundTable["guardsound"])], 95, math.random(90, 100), 2);

	elseif(!self.shouldBlock and self.isBlocking) then
		self.isBlocking = false;
		self:RemoveAllGestures();
		self.nextMeleeAttack = CurTime() + math.Rand(Lerp(self:GetNWInt("Aggressiveness")/50, 0.8, 0.15), Lerp(self:GetNWInt("Aggressiveness")/50, 2, 0.5));
		
	end

end

ENT.PossessionBinds = {
	[IN_ATTACK] = {{
		coroutine = true,
		onkeydown = function(self)
			self:OnMeleeAttack();

		end,

	}},

	[IN_ATTACK2] = {{
		coroutine = true,
		onkeydown = function(self)
			self:PossessionBlock(true);

		end,
		onkeyup = function(self)
			self:PossessionBlock(false);

		end,

	}},

	[IN_RELOAD] = {{
		coroutine = true,
		onkeydown = function(self)
			self.doParry = true;
			if(self.doParry and !self.isBlocking and !self.isAttacking and !self.parrying) then
				self.doParry = false;
				self.parrying = true;
	
				self:EmitSound(self.MeleeParrySounds[math.random(#self.MeleeParrySounds)])

				if(self.attackLayer) then self:RemoveAllGestures(); self:EmitSound("begotten/feint.mp3"); self.attackLayer = false; end

				self:AddGestureSequence(self:LookupSequence(self.ParryAnimation), true);
	
				timer.Simple(self.MeleeParryWindow + 0.25, function()
					if(!IsValid(self)) then return; end
	
					self.parrying = false;
				
				end)
	
			end

		end,

	}},

}

-- Player --

ENT.BGTWeapon = "begotten_2h_great_bellhammer";

local validCombos = {
	["&"] = true,
	["+"] = true,
	["="] = true,
	["]"] = true,
	[")"] = true,
	["$"] = true,
	["#"] = true,
	["@"] = true,
	["!"] = true,

};

ENT.SpawnKits = {
	["skeletoncos"] = {
		hp = {200, 300},
		extraArmor = {0, 0},
		aggressiveness = {35, 50},
		head = {"models/begotten/thralls/skelly03.mdl"},
		clothes = {nil},
		helm = {
			"none",
			
		},
		armor = {
			"none",
			"hellplate_armor",
			"heavy_hellplate_armor",

		},
		weapon = {
			"begotten_sacrificial_unholysigilsword_fire",
			"begotten_sacrificial_unholysigilsword_ice",
			"begotten_sacrificial_hellfiresword",
			"begotten_polearm_billhook",
			"begotten_polearm_gatekeeperpoleaxe",

		},
		drops = {

		},

	},

	["skeletonglaze"] = {
		hp = {200, 275},
		extraArmor = {0, 0},
		aggressiveness = {35, 50},
		head = {"models/begotten/thralls/skelly03.mdl"},
		clothes = {nil},
		helm = {
			"none",
			
		},
		armor = {
			"none",
			"gatekeeper_plate",
			"fine_gatekeeper_plate",
			"ornate_gatekeeper_plate",

		},
		weapon = {
			"begotten_1h_glazicus",
			"begotten_sacrificial_enchantedlongsword_ice",
			"begotten_2h_exileknightsword",
			"begotten_2h_great_bellhammer",
			"begotten_polearm_billhook",
			"begotten_polearm_gatekeeperpoleaxe",

		},
		drops = {

		},

	},

	["base"] = {
		hp = {100, 100},
		extraArmor = {0, 0},
		aggressiveness = {35, 50},
		head = {"glaze"},
		clothes = {"models/begotten/wanderers/wanderer_male.mdl"},
		helm = {
			"none",
			"&wanderer_crude_plate_helm",
			"old_soldier_helm",
			"hood",
			"hood_mask",
			"skintape_mask",
			"inquisitor_hat_1",
			"scrap_helmet",
			"wanderer_cap",
			"spangenhelm",
			
		},
		armor = {
			"none",
			"wanderer_mail",
			"&wanderer_crude_plate",
			"padded_coat",
			"old_soldier_cuirass",
			"light_brigandine_armor",
			"brigandine_armor",
			"scrapper_grunt_plate",
			"scrapper_machinist_plate",
			"wanderer_oppressor_armor",
			"twisted_fuck_armor",

		},
		weapon = {
			"begotten_1h_glazicus",
			"begotten_spear_ironspear",
			"begotten_2h_quarterstaff",
			"begotten_1h_scrapblade",
			"begotten_spear_scrapspear",
			"begotten_spear_ironshortspear",
			"begotten_1h_scrapaxe",
			"begotten_1h_scimitar",
			"begotten_1h_tireiron",
			"begotten_1h_pipemace",
			"begotten_1h_pipe",
			"begotten_1h_morningstar",
			"begotten_1h_machete",
			"begotten_1h_ironshortsword",
			"begotten_1h_ironarmingsword",
			"begotten_1h_brokensword",
			"begotten_1h_bladedboard",
			"begotten_1h_board",
			"begotten_1h_spikedboard",
			"begotten_1h_battleaxe",
			"begotten_1h_bladedbat",
			"begotten_1h_spikedbat",
			"begotten_1h_bat",
			"begotten_polearm_billhook",
			"begotten_rapier_ironrapier",
			"begotten_scythe_warscythe",
			"begotten_spear_harpoon",
			"begotten_spear_pitchfork",
			"begotten_2h_great_club",
			"begotten_2h_great_sledge",
			"begotten_2h_great_heavybattleaxe",
			"begotten_2h_great_scraphammer",
			"begotten_2h_great_warclub",
			"begotten_2h_great_eveningstar",
			"begotten_fists_caestus",
			"begotten_fists_ironknuckles",
			"begotten_fists_spikedknuckles",
			"begotten_dagger_quickshank",
			"begotten_dagger_irondagger",
			"begotten_dagger_knightsbane",
			"begotten_dagger_parryingdagger",

		},
		drops = {
			{
				id = "neatmeat",
				amount = {1, 5},
				chance = 1,
			},

		},

	},

	["sol"] = {
		hp = {250, 350},
		extraArmor = {60, 100},
		aggressiveness = {50, 50},
		head = {"glaze"},
		clothes = {"models/begotten/wanderers/wanderer_male.mdl"},
		helm = {
			"none",
			"helm_of_repentance",
			"helm_of_atonement",

		},
		armor = {
			"orthodoxist_monk_robes",
			"orthodoxist_battle_monk_robes",

		},
		weapon = {
			"begotten_2h_great_bellhammer",

		},
		drops = {

		},

	},

	["satanist"] = {
		hp = {250, 350},
		extraArmor = {60, 100},
		aggressiveness = {40, 50},
		head = {"glaze"},
		clothes = {"models/begotten/wanderers/wanderer_male.mdl"},
		helm = {
			"none",
			"&hellplate_helmet",

		},
		armor = {
			"wraith_armor",
			"dread_armor",
			"hellspike_armor",
			"&hellplate_armor",
			"&heavy_hellplate_armor",

		},
		weapon = {
			"begotten_sacrificial_unholysigilsword_fire",
			"begotten_sacrificial_unholysigilsword_ice",
			--"begotten_sacrificial_hellfiresword",
		
		},
		drops = {
			{
				id = "gauze",
				amount = {1, 3},
				chance = 3,
			},
			{
				id = "crafted_bandage",
				amount = {1, 3},
				chance = 1,
			},
			{
				id = "evil_eye",
				amount = {1, 1},
				chance = 5,
			},
			{
				id = "abandoned_doll",
				amount = {1, 1},
				chance = 5,
			},
			{
				id = "ring_pugilist",
				amount = {1, 1},
				chance = 5,
			},
			{
				id = "ring_pummeler",
				amount = {1, 1},
				chance = 5,
			},
			{
				id = "spine_soldier",
				amount = {1, 1},
				chance = 5,
			},
			{
				id = "skull_demon",
				amount = {1, 1},
				chance = 5,
			},
			{
				id = "ring_penetration",
				amount = {1, 1},
				chance = 5,
			},
			{
				id = "bindings",
				amount = {1, 1},
				chance = 3,
			},
			
		},

	},

};

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS;

end

function ENT:OnRemove()
	if(SERVER) then return; end

	if IsValid(self.headEntity) then
		self.headEntity:Remove();
		self.headEntity = nil;
	end

	if IsValid(self.realHeadEntity) then
		self.realHeadEntity:Remove();
		self.realHeadEntity = nil;
	end

	for i, v in pairs(self.weaponEntities) do
		v:Remove()

	end

end

function ENT:GetBoneOrientation( basetab, tab, ent, bone_override )
	local bone, pos, ang
	
	if (tab.rel and tab.rel != "") then
		local v = basetab[tab.rel]
		
		if (!v) then return end

		pos, ang = self:GetBoneOrientation( basetab, v, ent )
		
		if (!pos) then return end
		
		pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
		ang:RotateAroundAxis(ang:Up(), v.angle.y)
		ang:RotateAroundAxis(ang:Right(), v.angle.p)
		ang:RotateAroundAxis(ang:Forward(), v.angle.r)
	else
		bone = ent:LookupBone(bone_override or tab.bone)

		if (!bone) then return end

		--if basetab == self.WElements then
			local m = ent:GetBoneMatrix(bone)
			
			if (m) then
				pos, ang = m:GetTranslation(), m:GetAngles();
			end
		--end

		if !pos and !ang then
			pos = ent:GetPos();
			ang = ent:GetAngles();
		end
		
	end
	
	return pos, ang, bone;
end

local didManip = false

if(CLIENT) then
	function ENT:Draw()
		--[[local attacktable = GetTable(weapons.GetStored(self:GetNWString("weaponClass")).AttackTable);
		local pos = self:GetBonePosition(self:LookupBone("ValveBiped.Bip01_Spine1"));
		local aimVector = self:GetForward();
		local meleeArc = attacktable["meleearc"] or 25;
		local meleeRange = (attacktable["meleerange"] or 1) / 10;

		local enemy = (IsValid(self:GetEnemy()) and self:GetEnemy() or Clockwork.Client)
		local sex = (self:GetPos() - enemy:GetPos()):Angle();
		sex:RotateAroundAxis(sex:Up(), -90);
		sex = sex:Right();

		local tr = util.TraceLine({
			start = pos,
			endpos = pos + (sex * meleeRange),
			mask = MASK_SOLID,
			filter = self,

		});
		
		render.DrawLine(pos, tr.HitPos, IsValid(tr.Entity) and tr.Entity:IsPlayer() and Color(0,255,0) or Color(255,0,0), false)]]

		local head = self:GetNWString("clothes");
		if head and head:len() > 0 then
			if !IsValid(self.headEntity) then
				local headEntity = ClientsideModel(head, RENDERGROUP_BOTH);

				if IsValid(headEntity) then
					headEntity:SetParent(self);
					headEntity:AddEffects(EF_BONEMERGE);
					headEntity:SetColor(self:GetColor());
					headEntity:SetNoDraw(self:GetNoDraw());
				
					self.headEntity = headEntity;
				end
			elseif self.headEntity:GetModel() ~= head then
				if IsValid(self.headEntity) then
					self.headEntity:Remove();
					self.headEntity = nil;
				end
			elseif IsValid(self.headEntity) then
				self.headEntity:SetParent(self);
				self.headEntity:AddEffects(EF_BONEMERGE);
				self.headEntity:SetColor(self:GetColor());
				self.headEntity:SetNoDraw(self:GetNoDraw());
			
			end
		elseif IsValid(self.headEntity) then
			self.headEntity:Remove();
			self.headEntity = nil;
		end

		local head = self:GetNWString("head");
		if head and head:len() > 0 then
			if !IsValid(self.realHeadEntity) then
				local headEntity = ClientsideModel(head, RENDERGROUP_BOTH);

				if IsValid(headEntity) then
					headEntity:SetParent(self);
					headEntity:AddEffects(EF_BONEMERGE);
					headEntity:SetColor(self:GetColor());
					headEntity:SetNoDraw(self:GetNoDraw());
					headEntity:SetBodygroup(self:GetNWInt("bodyGroup", 0), self:GetNWInt("bodyGroupVal", 0));
				
					self.realHeadEntity = headEntity;
				end
			elseif self.realHeadEntity:GetModel() ~= head then
				if IsValid(self.realHeadEntity) then
					self.realHeadEntity:Remove();
					self.realHeadEntity = nil;
				end
			elseif IsValid(self.realHeadEntity) then
				self.realHeadEntity:SetParent(self);
				self.realHeadEntity:AddEffects(EF_BONEMERGE);
				self.realHeadEntity:SetColor(self:GetColor());
				self.realHeadEntity:SetNoDraw(self:GetNoDraw());
				self.realHeadEntity:SetBodygroup(self:GetNWInt("bodyGroup", 0), self:GetNWInt("bodyGroupVal", 0));
			
			end
		elseif IsValid(self.realHeadEntity) then
			self.realHeadEntity:Remove();
			self.realHeadEntity = nil;
		end

		--if(!head or head:len() <= 0) then self:DrawModel() end

		if(!self.weaponEntities) then self.weaponEntities = {}; end

		local weapon = self:GetNWString("weaponClass");
		local tbl = weapons.GetStored(weapon);

		--[[if(weapon and tbl and weapon:len() > 0) then
			for i, v in pairs(tbl.WElements) do
				if(!IsValid(self.weaponEntities[i])) then
					local weaponEntity = ClientsideModel(v.model, RENDERGROUP_BOTH);
	
					if(IsValid(weaponEntity)) then
						local pos, ang, bone = self:GetBoneOrientation(tbl.WElements, v, self, (v.bone and nil or "ValveBiped.Bip01_R_Hand"));

						weaponEntity:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z);
						ang:RotateAroundAxis(ang:Up(), v.angle.y);
						ang:RotateAroundAxis(ang:Right(), v.angle.p);
						ang:RotateAroundAxis(ang:Forward(), v.angle.r);
						weaponEntity:SetAngles(ang);

						weaponEntity:FollowBone(self, bone);
	
						self.weaponEntities[i] = weaponEntity;
	
					end
	
				elseif(self.weaponEntities[i]:GetModel() != v.model) then
					if(IsValid(self.weaponEntities[i])) then
						self.weaponEntities[i]:Remove();
						self.weaponEntities[i] = nil;
	
					end
	
				else
					local pos, ang, bone = self:GetBoneOrientation(tbl.WElements, v, self, (v.bone and nil or "ValveBiped.Bip01_R_Hand"));

					self.weaponEntities[i]:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z);
					ang:RotateAroundAxis(ang:Up(), v.angle.y);
					ang:RotateAroundAxis(ang:Right(), v.angle.p);
					ang:RotateAroundAxis(ang:Forward(), v.angle.r);
					self.weaponEntities[i]:SetAngles(ang);

					self.weaponEntities[i]:FollowBone(self, bone);

				end

			end

		else
			for i, v in pairs(self.weaponEntities) do
				v:Remove()
				self.weaponEntites[i] = nil;

			end

		end]]

	end
	
end

if SERVER then
	local function IsFemale(self)
		return string.find(self:GetModel(), "female");

	end

	local skeletonSounds = {
		"npc/stalker/stalker_pain1.wav",
		"npc/stalker/stalker_pain2.wav",
		"npc/stalker/stalker_pain3.wav",

	};

	function ENT:PlayPainSound()
		local model = self:GetNWString("head", "");
		local isFemale = IsFemale(self);
		local pitch = isFemale and math.random(100, 115) or math.random(95, 110);

		if(self:WaterLevel() >= 3) then return; end
		if(self.nextPainSound and self.nextPainSound > CurTime()) then return; end
		self.nextPainSound = CurTime() + 0.5;

		if(string.find(model, "skelly")) then
			self:EmitSound(skeletonSounds[math.random(#skeletonSounds)], 90, math.random(90, 100));
			self.nextPainSound = CurTime() + 0.5;
			return;

		end

		if(string.find(model, "voltist")) then
			self:EmitSound(voltistSounds["pain"][math.random(1, #voltistSounds["pain"])], 90, 150);
			self.nextPainSound = CurTime() + 0.5;
			return;
		end
	
		if(string.find(model, "male_9")) then
			if(!isFemale) then
				self:EmitSound("voice/man1/man1_pain0"..math.random(1, 6)..".wav", 90, pitch);
				
			else
				self:EmitSound("voice/female2/female2_pain0"..math.random(1, 6)..".wav", 90, pitch);
				
			end

		elseif(!isFemale) then
			self:EmitSound("voice/man3/man3_pain0"..math.random(1, 6)..".wav", 90, pitch);

		else
			self:EmitSound("voice/female2/female2_pain0"..math.random(1, 6)..".wav", 90, pitch);

		end

	end

	function ENT:OnFatalDamage()
		self:SetModel(self:GetNWString("head"));

	end

	function ENT:OnTookDamage(dmg)
		local damage = dmg:GetDamage();

		if(self.isBlocking and !dmg:IsDamageType(DMG_BURN)) then
			self:EmitSound(self.MeleeBlockSoundTable["blocksound"][math.random(#self.MeleeBlockSoundTable["blocksound"])])

			if(damage < 10) then return; end

		end

		self:PlayPainSound();

	end

	function ENT:OnParried()
		self.nextMeleeAttack = CurTime() + 2;

		if(math.random(1, Lerp(self:GetNWInt("Aggressiveness")/50, 20, 1)) == 1) then
			self.parryNext = true;
			return;

		end

		self.rollIn = CurTime() + math.Rand(0.4, 0.9);
		self.shouldRoll = true;

	end

	local possibleWeapons = {
		"begotten_1h_glazicus",
		"begotten_spear_ironspear",
		"begotten_2h_quarterstaff",
		"begotten_2h_great_bellhammer",
		"begotten_sacrificial_unholysigilsword_fire",
		"begotten_sacrificial_unholysigilsword_ice",

	};

	local glazeHeads = {
		"male_01",
		"male_02",
		"male_03",
		"male_04",
		"male_05",
		"male_06",
		"male_07",
		"male_08",
		"male_09",
		"male_11",
		"male_12",
		"male_13",
		"male_16",
		"male_22",
		"male_56",
		
	};

	local goreHeads = {
		"male_90",
		"male_91",
		"male_92",
		"male_93",
		"male_94",
		"male_95",
		"male_96",

	};

	function ENT:GetPairedHelm(char)
		for _, v in pairs(self.SpawnKit.helm) do
			if(string.sub(v, 1, 1) != char) then continue; end

			return string.sub(v, 2, #v);

		end

	end

	function ENT:HandleHelm()
		print("HandleHelm: ", self.EquippedHelm)
		if(self.EquippedHelm == "none") then return "_glaze"; end

		local item = Clockwork.item:FindByID(self.EquippedHelm);

		print(self.EquippedHelm)
		print(item.name)

		self:SetNWInt("bodyGroup", item.bodyGroup);
		self:SetNWInt("bodyGroupVal", item.bodyGroupVal);

		local skipHead = false;

		if(item.headReplacement) then
			self:SetNWString("head", item.headReplacement);
			skipHead = true;

		end

		return item.headSuffix or "_glaze", skipHead;

	end

	function ENT:HandleHead(skipHead, pairedHelm)
		if(skipHead) then return; end

		self.EquippedHelm = (#pairedHelm > 0) and pairedHelm or self.SpawnKit.helm[math.random(#self.SpawnKit.helm)];
		if(validCombos[string.sub(self.EquippedHelm, 1, 1)]) then
			self.EquippedHelm = string.sub(self.EquippedHelm, 2, #self.EquippedHelm);

		end

		local suffix, skipHead = self:HandleHelm();
		if(skipHead) then return; end

		if(self.SpawnKit.head[1] == "glaze") then
			self:SetNWString("head", "models/begotten/heads/"..glazeHeads[math.random(#glazeHeads)]..suffix..".mdl");

		elseif(self.SpawnKit.head[1] == "gore") then
			self:SetNWString("head", "models/begotten/heads/"..goreHeads[math.random(#goreHeads)]..suffix..".mdl");

		else
			self:SetNWString("head", self.SpawnKit.head[math.random(#self.SpawnKit.head)]);

		end

	end

	function ENT:Kit(spawnKit)
		self.SpawnKit = istable(spawnKit) and spawnKit or self.SpawnKits[spawnKit];

		local skipHead = false;
		local pairedHelm = "";

		self.EquippedArmor = self.SpawnKit.armor[math.random(#self.SpawnKit.armor)];
		if(self.EquippedArmor != "none") then
			local char = string.sub(self.EquippedArmor, 1, 1);
			if(validCombos[char]) then
				pairedHelm = self:GetPairedHelm(char);
				self.EquippedArmor = string.sub(self.EquippedArmor, 2, #self.EquippedArmor);

			end

			local item = Clockwork.item:FindByID(self.EquippedArmor);

			print(self.EquippedArmor)
			print(item.name)

			local replacement = item.GetReplacement and item:GetReplacement() or nil;

			if(isstring(replacement)) then
				skipHead = true;

			end

			self:SetNWString("clothes", isstring(replacement) and replacement or "models/begotten/"..item.group.."_male.mdl");

		else
			self:SetNWString("clothes", self.SpawnKit.clothes[math.random(#self.SpawnKit.clothes)]);

		end

		self:HandleHead(skipHead, pairedHelm);
		
		local wep = self.SpawnKit.weapon[math.random(#self.SpawnKit.weapon)]
		self:SetNWString("weaponClass", wep);

		local item = Clockwork.item:FindByID(wep);

		self:SetNWInt("Aggressiveness", math.random(self.SpawnKit.aggressiveness[1], self.SpawnKit.aggressiveness[2]));

		local hp = math.random(self.SpawnKit.hp[1], self.SpawnKit.hp[2])
		self:SetMaxHealth(hp);
		self:SetHealth(hp);

		local armor = math.random(self.SpawnKit.extraArmor[1], self.SpawnKit.extraArmor[2])
		self.Armor = armor;

	end

	-- Init/Think --
	function ENT:CustomInitialize()
		self:SetDefaultRelationship(D_HT);

		self:SetModel("models/begotten/satanists/wraitharmor.mdl");

		self:Kit(table.KeyFromValue(self.SpawnKits, table.Random(self.SpawnKits)));
		
	end

	local ROLL_RIGHT = 0
	local ROLL_LEFT = 1
	local ROLL_BACK = 2

	local rollAnims = {
		[ROLL_RIGHT] = "begotten_flip_right",
		[ROLL_LEFT] = "begotten_flip_left",
		[ROLL_BACK] = "begotten_flip_back",

	};

	function ENT:RollCallback(cycle)
		if(cycle > 0.7) then return; end

		if(self.rollDir == ROLL_RIGHT) then self:MoveRight();
		elseif(self.rollDir == ROLL_LEFT) then self:MoveLeft();
		elseif(self.rollDir == ROLL_BACK) then self:MoveBackward();
		end

	end

	function ENT:Roll(direction)
		self.isAttacking = false;
		if(self.attackLayer) then self:RemoveAllGestures(); self:EmitSound("begotten/feint.mp3"); self.attackLayer = false; end
		self:EmitSound("wos/roll/dive.wav");

		timer.Simple(0.7, function()
			if(!IsValid(self)) then return; end

			self:EmitSound("wos/roll/land.wav");
		
		end);

		self.rollDir = direction;
		self.oldDesiredSpeed = self:GetDesiredSpeed();
		self.rolling = true;
		self:SetDesiredSpeed(120);
		self:PlaySequenceAndWait(rollAnims[direction], 0.8, self.RollCallback);
		self.rolling = false;
		self:SetDesiredSpeed(self.oldDesiredSpeed);
		
	end

	function ENT:TriggerAnim4(target, anim) -- The two arguments for this function are "target" and "anim". Target is the entity we want to call the animation on, and anim being the animation itself.
		if SERVER then
			if (!target or !IsValid(target)) then
				return;
			end;
			
			net.Start( "BegottenAnim4", true )
			net.WriteEntity( target );
			net.WriteString( anim );
			net.Broadcast();
			
		end
	end

	function ENT:HandleHit(hit, src, swingType, hitIndex)
		local distance;
		local attacktable = self.MeleeAttackTable;
		local attacksoundtable = self.MeleeAttackSoundTable;
		local blockTable = GetTable(self:GetNWString("activeShield"));
		local hit_reduction = 1;
		local shield_reduction = 1;
		local weaponClass = self:GetNWString("weaponClass");
		local bTake;
		local enemywep;
		local weapon = self:GetWeapon();

		if (hit:IsWorld()) then
			for k, v in pairs (ents.FindInSphere(src, 32)) do
				if (v:GetClass() == "prop_ragdoll") and Clockwork.entity:IsPlayerRagdoll(v) then
					hit = Clockwork.entity:GetPlayer(v);
					break;
				end;
			end;
		elseif hit:GetClass() == "prop_ragdoll" and Clockwork.entity:IsPlayerRagdoll(hit) then
			hit = Clockwork.entity:GetPlayer(hit);
		end

		if hit:IsValid() and hit:IsPlayer() then
			enemywep = hit:GetActiveWeapon();
		end

		if blockTable then
			shield_reduction = blockTable.damagereduction or 1;
		end

		local damage = (attacktable["primarydamage"]);
		local damagetype = (attacktable["dmgtype"]);
		local stabilitydamage = (attacktable["stabilitydamage"]);

		if swingType == "thrust_swing" and attacktable["altattackstabilitydamagemodifier"] then
			stabilitydamage = stabilitydamage * attacktable["altattackstabilitydamagemodifier"];
		end

		if swingType == "parry_swing" then
			if (IsValid(hit) and IsValid(self)) then
				local d = DamageInfo()

				d:SetDamage(damage * shield_reduction * 3 * hit_reduction);
				
				d:SetAttacker(self)
				d:SetDamageType(damagetype)
				d:SetDamagePosition(src)
				d:SetInflictor(weapon);
			
				if (hit:IsPlayer()) then
					d:SetDamageForce(self:GetForward() * 5000);

					if (hit:IsRagdolled()) then
						if weapon.isDagger then -- Daggers deal more damage against fallen opponents
							d:SetDamage(d:GetDamage() * 2)
							
							if hit:GetNetVar("ActName") == "unragdoll" then
								Clockwork.player:ExtendAction(hit, 0.3);
							end
						end
					end
				end
				
				hit:TakeDamageInfo(d)

				if (hit:IsNPC() or hit:IsNextBot()) then
					local trace = self:GetEyeTrace();
					
					-- Fire attack type
					if (hit:IsValid()) and attacktable["attacktype"] == "fire_swing" then
						if offhandWeapon then
							hit:Ignite(weapon.IgniteTime * 2);
						else
							hit:Ignite(weapon.IgniteTime * 3);
						end
					end
					
					-- Ice attack type
					if (hit:IsValid()) and attacktable["attacktype"] == "ice_swing" and hit.AddFreeze then
						if offhandWeapon then
							hit:AddFreeze((weapon.FreezeDamage * 0.6) * (hit:WaterLevel() + 1), self);
						else
							hit:AddFreeze(weapon.FreezeDamage * (hit:WaterLevel() + 1), self);
						end
					end
				end

				if hit:IsPlayer() and !hit:IsRagdolled() and hit:GetNWBool("Deflect") != true and hit:GetNWBool("Parry") != true and !hit.iFrames then
					self:TriggerAnim4(hit, "a_shared_hit_0"..math.random(1, 3));
					
				end
				
				if hit:IsPlayer() and !hit:GetNWBool("Guardening") and !hit:GetNWBool("Parry") and !hit.iFrames then
					hit:TakeStability((stabilitydamage * 3) * shield_reduction * hit_reduction)		

					-- Fire attack type
					if (hit:IsValid()) and attacktable["attacktype"] == "fire_swing" then
						if offhandWeapon then
							hit:Ignite(weapon.IgniteTime * 2);
						else
							hit:Ignite(weapon.IgniteTime * 3);
						end
					end
					
					-- Ice attack type
					if (hit:IsValid()) and attacktable["attacktype"] == "ice_swing" and hit.AddFreeze then
						if offhandWeapon then
							hit:AddFreeze((weapon.FreezeDamage * 0.6) * (hit:WaterLevel() + 1), self);
						else
							hit:AddFreeze(weapon.FreezeDamage * (hit:WaterLevel() + 1), self);
						end
					end
				end
			end
		elseif swingType == "thrust_swing" then
			if hit:IsValid() and hit:IsPlayer() then
				enemywep = hit:GetActiveWeapon()
			end

			if self:IsValid() then
				-- Spear Damage System (Messy)					
				local distance = (self:GetPos():Distance(hit:GetPos()));
				
				damagetype = 16;
				
				-- Blunt swipe or piercing thrust?
				if weapon.CanSwipeAttack == true then
					damagetype = 128
					
					if hit:IsValid() then
						if (hit:IsNPC() or hit:IsNextBot()) or (hit:IsPlayer() and !hit:GetNWBool("Parry") and !hit:GetNWBool("Deflect")) and !hit.iFrames then
							-- KNOCKBACK
							local knockback = self:GetAngles():Forward() * 550;
							knockback.z = 0
							
							timer.Simple(0.1, function()
								if IsValid(hit) then
									hit:SetVelocity(knockback);
								end
							end);
							
							if hit:IsPlayer() then
								hit:TakeStability((stabilitydamage) * shield_reduction * hit_reduction);
							end
						end
					end
				else
					if (IsValid(self)) then
						if string.find(weaponClass, "begotten_polearm_") then
							local max_dist = 75;
							
							if distance >= 0 and distance <= max_dist and hit:IsValid() then
								if (hit:IsNPC() or hit:IsNextBot()) or (hit:IsPlayer() and !hit:GetNWBool("Guardening") and !hit:GetNWBool("Parry") and !hit:GetNWBool("Deflect")) and !hit.iFrames then
									damage = (attacktable["primarydamage"]) * 0.05
									damagetype = 128
									
									-- KNOCKBACK
									local knockback = self:GetAngles():Forward() * 700;
									knockback.z = 0
									
									-- timers are shit but whatever
									timer.Simple(0.1, function()
										if IsValid(hit) then
											hit:SetVelocity(knockback);
										end
									end);
									
									if hit:IsPlayer() then
										hit:TakeStability(5)
									end
								end
							elseif distance > max_dist and hit:IsValid() then
								if (hit:IsNPC() or hit:IsNextBot()) or hit:IsPlayer() then
									damage = (attacktable["primarydamage"])
									damagetype = 16
									
									--[[if hit:IsValid() and hit:IsPlayer() and !hit:GetNWBool("Guardening") and !hit:GetNWBool("Parry") and !hit:GetNWBool("Deflect") and !hit.iFrames then
										hit:TakeStability((stabilitydamage))		
									end]]--
								end
							end
						else
							-- Non-polearm thrust
							--[[if hit:IsValid() and hit:IsPlayer() and !hit:GetNWBool("Guardening") and !hit:GetNWBool("Parry") and !hit:GetNWBool("Deflect") and !hit.iFrames then
								hit:TakeStability((stabilitydamage))			
							end]]--
							
							--[[if (hit:IsNPC() or hit:IsNextBot()) or (hit:IsPlayer() and !hit:GetNWBool("Guardening") and !hit:GetNWBool("Parry") and !hit:GetNWBool("Deflect")) and !hit.iFrames then
								hit:EmitSound(attacksoundtable["althitbody"][math.random(1, #attacksoundtable["althitbody"])])
							end]]--
							
							if attacktable["altdamagetype"] == 16 then
								if hit:IsValid() then
									if (hit:IsNPC() or hit:IsNextBot()) or hit:IsPlayer() then
										-- counter damage
										local targetVelocity = hit:GetVelocity();
										
										if math.abs(targetVelocity.x) > 150 or math.abs(targetVelocity.y) > 150 then
											local entEyeAngles = hit:EyeAngles();
											
											if math.abs(math.AngleDifference(entEyeAngles.y, (self:GetPos() - hit:GetPos()):Angle().y)) <= 90 then
												damage = damage + (damage * 0.5);
											end
										end
									end
								end
							end
						end
					end
				end
				
				-- Spear Damage System (Messy)	
				if (IsValid(hit) and self:IsValid()) then
					local d = DamageInfo()
					d:SetDamage( damage * shield_reduction * (attacktable["altattackdamagemodifier"] or 1) * hit_reduction)
					d:SetAttacker( self )
					d:SetDamageType( damagetype )
					d:SetDamagePosition(src)
					d:SetInflictor(weapon);
				
					if (hit:IsPlayer()) then
						d:SetDamageForce(self:GetForward() * 5000);
						
						if (hit:IsRagdolled()) then
							if self.isDagger then -- Daggers deal more damage against fallen opponents
								d:SetDamage(d:GetDamage() * 2)
								
								if hit:GetNetVar("ActName") == "unragdoll" then
									Clockwork.player:ExtendAction(hit, 0.3);
								end
							end
						end
					end
					
					hit:TakeDamageInfo(d)
					
					if (hit:IsNPC() or hit:IsNextBot()) then
						-- Fire attack type
						if attacktable["attacktype"] == "fire_swing" then
							if offhandWeapon then
								hit:Ignite(weapon.IgniteTime * 2);
							else
								hit:Ignite(weapon.IgniteTime * 3);
							end
						end
						
						-- Ice attack type
						if attacktable["attacktype"] == "ice_swing" and hit.AddFreeze then
							if offhandWeapon then
								hit:AddFreeze((weapon.FreezeDamage * 0.6) * (hit:WaterLevel() + 1), self);
							else
								hit:AddFreeze(weapon.FreezeDamage * (hit:WaterLevel() + 1), self);
							end
						end
					else
						if hit:IsPlayer() and !hit:GetNWBool("Guardening") == true and !hit:GetNWBool("Parry") == true and !hit.iFrames then
							-- Fire attack type
							if attacktable["attacktype"] == "fire_swing" then
								if offhandWeapon then
									hit:Ignite(weapon.IgniteTime * 2);
								else
									hit:Ignite(weapon.IgniteTime * 3);
								end
							end
							
							-- Ice attack type
							if attacktable["attacktype"] == "ice_swing" and hit.AddFreeze then
								if offhandWeapon then
									hit:AddFreeze((weapon.FreezeDamage * 0.6) * (hit:WaterLevel() + 1), self);
								else
									hit:AddFreeze(weapon.FreezeDamage * (hit:WaterLevel() + 1), self);
								end
							end
							
							if weapon.CanSwipeAttack == true then
								hit:TakeStability(15)		
							end
						end
					end

					if hit:IsPlayer() and !hit:IsRagdolled() and hit:GetNWBool("Deflect") != true and hit:GetNWBool("Parry") != true and !hit.iFrames then
						self:TriggerAnim4(hit, "a_shared_hit_0"..math.random(1, 3)); 
					end
				end
			end
		elseif swingType == "polearm_swing" then
			if (!hit.nexthit or CurTime() > hit.nexthit) then 
				hit.nexthit = CurTime() + 1
			end

			if hit:IsValid() and hit:IsPlayer() then
				enemywep = hit:GetActiveWeapon()
			end

			if self:IsValid() then
				-- Polearm Damage System
				local distance = self:GetPos():Distance(hit:GetPos());
				local poledamage = (attacktable["primarydamage"])
				local poletype = (attacktable["dmgtype"])
				
				if weapon.ShortPolearm != true then
					if distance >= 0 and distance <= 35 and hit:IsValid() then
						if (hit:IsNPC() or hit:IsNextBot()) or hit:IsPlayer() then
							--print "Tier 0"
							poledamage = (attacktable["primarydamage"]) * 0.01
							poletype = 128
							if hit:IsValid() and hit:IsPlayer() and !hit:GetNWBool("Guardening") == true and hit:GetNWBool("Parry") != true and !hit.iFrames then
								hit:TakeStability(5)
								--hit:EmitSound( "physics/body/body_medium_impact_hard"..math.random(2,6)..".wav" ) 
								
								-- KNOCKBACK
								local knockback = self:GetAngles():Forward() * 750;
								knockback.z = 0
								
								timer.Simple(0.1, function()
									if IsValid(hit) then
										hit:SetVelocity(knockback);
									end
								end);
							end
							if (hit:IsNPC() or hit:IsNextBot()) then
								--hit:EmitSound( "physics/body/body_medium_impact_hard"..math.random(2,6)..".wav" ) 
							end
						end
					
					elseif distance > 35 and distance <= 55 and hit:IsValid() then
						if (hit:IsNPC() or hit:IsNextBot()) or hit:IsPlayer() then
							--print "Tier 1"
							poledamage = (attacktable["primarydamage"]) * 0.05
							poletype = 128
							if hit:IsValid() and hit:IsPlayer() and !hit:GetNWBool("Guardening") == true and hit:GetNWBool("Parry") != true and !hit.iFrames then
								hit:TakeStability(10)
								--hit:EmitSound( "physics/body/body_medium_impact_hard"..math.random(2,6)..".wav" ) 
								
								-- KNOCKBACK
								local knockback = self:GetAngles():Forward() * 700;
								knockback.z = 0
								
								timer.Simple(0.1, function()
									if IsValid(hit) then
										hit:SetVelocity(knockback);
									end
								end);
							end
							if (hit:IsNPC() or hit:IsNextBot()) then
								--hit:EmitSound( "physics/body/body_medium_impact_hard"..math.random(2,6)..".wav" ) 
							end
						end
					
					elseif distance > 55 and distance <= 65 and hit:IsValid() then
						if (hit:IsNPC() or hit:IsNextBot()) or hit:IsPlayer() then
							--print "Tier 2"
							poledamage = (attacktable["primarydamage"]) * 0.08
							poletype = 128
							if hit:IsValid() and hit:IsPlayer() and !hit:GetNWBool("Guardening") == true and hit:GetNWBool("Parry") != true and !hit.iFrames then
								hit:TakeStability(15)
								--hit:EmitSound( "physics/body/body_medium_impact_hard"..math.random(2,6)..".wav" ) 
								
								-- KNOCKBACK
								local knockback = self:GetAngles():Forward() * 650;
								knockback.z = 0
								
								timer.Simple(0.1, function()
									if IsValid(hit) then
										hit:SetVelocity(knockback);
									end
								end);
							end
							if (hit:IsNPC() or hit:IsNextBot()) then
								--hit:EmitSound( "physics/body/body_medium_impact_hard"..math.random(2,6)..".wav" ) 
							end
						end
					
					elseif distance > 65 and distance <= 75 and hit:IsValid() then
						if (hit:IsNPC() or hit:IsNextBot()) or hit:IsPlayer() then
							--print "Tier 3"
							poledamage = (attacktable["primarydamage"]) * 0.1
							poletype = 128
							if hit:IsValid() and hit:IsPlayer() and !hit:GetNWBool("Guardening") == true and hit:GetNWBool("Parry") != true and !hit.iFrames then
								hit:TakeStability(20)
								--hit:EmitSound( "physics/body/body_medium_impact_hard"..math.random(2,6)..".wav" ) 
								
								-- KNOCKBACK
								local knockback = self:GetAngles():Forward() * 600;
								knockback.z = 0
								
								timer.Simple(0.1, function()
									if IsValid(hit) then
										hit:SetVelocity(knockback);
									end
								end);
							end
							if (hit:IsNPC() or hit:IsNextBot()) then
								--hit:EmitSound( "physics/body/body_medium_impact_hard"..math.random(2,6)..".wav" ) 
							end
						end
					
					elseif distance > 75 and distance <= 85 and hit:IsValid() then
						if (hit:IsNPC() or hit:IsNextBot()) or hit:IsPlayer() then
							--print "Tier 4"
							poledamage = (attacktable["primarydamage"]) * 0.7
							
							-- counter damage
							local targetVelocity = hit:GetVelocity();
							
							if math.abs(targetVelocity.x) > 150 or math.abs(targetVelocity.y) > 150 then
								local entEyeAngles = hit:EyeAngles();
							
								if math.abs(math.AngleDifference(entEyeAngles.y, (self:GetPos() - hit:GetPos()):Angle().y)) <= 90 then
									poledamage = poledamage + (poledamage * 0.6);
								end
							end
							
							poletype = (attacktable["dmgtype"])
							if hit:IsValid() and hit:IsPlayer() and !hit:GetNWBool("Guardening") == true and hit:GetNWBool("Parry") != true and !hit.iFrames then
								hit:TakeStability((stabilitydamage * 0.7))			
								--hit:EmitSound(attacksoundtable["hitbody"][math.random(1, #attacksoundtable["hitbody"])])
							end
							if (hit:IsNPC() or hit:IsNextBot()) then
								--hit:EmitSound(attacksoundtable["hitbody"][math.random(1, #attacksoundtable["hitbody"])])
							end
						end
					
					elseif distance > 85 and distance <= 95 and hit:IsValid() then
						if (hit:IsNPC() or hit:IsNextBot()) or hit:IsPlayer() then
							--print "Tier 5"
							poledamage = (attacktable["primarydamage"]) * 0.8
							
							-- counter damage
							local targetVelocity = hit:GetVelocity();
							
							if math.abs(targetVelocity.x) > 150 or math.abs(targetVelocity.y) > 150 then
								local entEyeAngles = hit:EyeAngles();
							
								if math.abs(math.AngleDifference(entEyeAngles.y, (self:GetPos() - hit:GetPos()):Angle().y)) <= 90 then
									poledamage = poledamage + (poledamage * 0.5);
								end
							end
							
							poletype = (attacktable["dmgtype"])
							if hit:IsValid() and hit:IsPlayer() and !hit:GetNWBool("Guardening") == true and hit:GetNWBool("Parry") != true and !hit.iFrames then
								hit:TakeStability((stabilitydamage * 0.8))			
								--hit:EmitSound(attacksoundtable["hitbody"][math.random(1, #attacksoundtable["hitbody"])])
							end
							if (hit:IsNPC() or hit:IsNextBot()) then
								--hit:EmitSound(attacksoundtable["hitbody"][math.random(1, #attacksoundtable["hitbody"])])
							end
						end
					
					elseif distance > 95 and distance <= 105 and hit:IsValid() then
						if (hit:IsNPC() or hit:IsNextBot()) or hit:IsPlayer() then
							--print "Tier 6"
							poledamage = (attacktable["primarydamage"]) * 1
							
							-- counter damage
							local targetVelocity = hit:GetVelocity();
							
							if math.abs(targetVelocity.x) > 150 or math.abs(targetVelocity.y) > 150 then
								local entEyeAngles = hit:EyeAngles();
							
								if math.abs(math.AngleDifference(entEyeAngles.y, (self:GetPos() - hit:GetPos()):Angle().y)) <= 90 then
									poledamage = poledamage + (poledamage * 0.5);
								end
							end
							
							poletype = (attacktable["dmgtype"])
							if hit:IsValid() and hit:IsPlayer() and !hit:GetNWBool("Guardening") == true and hit:GetNWBool("Parry") != true and !hit.iFrames then
								hit:TakeStability((stabilitydamage * 1))			
								hit:EmitSound(attacksoundtable["hitbody"][math.random(1, #attacksoundtable["hitbody"])])
							end
							if (hit:IsNPC() or hit:IsNextBot()) then
								--hit:EmitSound(attacksoundtable["hitbody"][math.random(1, #attacksoundtable["hitbody"])])
							end
						end
					
					elseif distance > 105 and distance <= 115 and hit:IsValid() then
						if (hit:IsNPC() or hit:IsNextBot()) or hit:IsPlayer() then
							--print "Tier 7"
							poledamage = (attacktable["primarydamage"]) * 1.1
							
							-- counter damage
							local targetVelocity = hit:GetVelocity();
							
							if math.abs(targetVelocity.x) > 150 or math.abs(targetVelocity.y) > 150 then
								local entEyeAngles = hit:EyeAngles();
							
								if math.abs(math.AngleDifference(entEyeAngles.y, (self:GetPos() - hit:GetPos()):Angle().y)) <= 90 then
									poledamage = poledamage + (poledamage * 0.5);
								end
							end
							
							poletype = (attacktable["dmgtype"])
							if hit:IsValid() and hit:IsPlayer() and !hit:GetNWBool("Guardening") == true and hit:GetNWBool("Parry") != true and !hit.iFrames then
								hit:TakeStability((stabilitydamage * 1.1))			
								--hit:EmitSound(attacksoundtable["hitbody"][math.random(1, #attacksoundtable["hitbody"])])
							end
							if (hit:IsNPC() or hit:IsNextBot()) then
								--hit:EmitSound(attacksoundtable["hitbody"][math.random(1, #attacksoundtable["hitbody"])])
							end
						end
					
					elseif distance > 115 and distance <= 125 and hit:IsValid() then
						if (hit:IsNPC() or hit:IsNextBot()) or hit:IsPlayer() then
							--print "Tier 8"
							poledamage = (attacktable["primarydamage"]) * 1.3
							
							-- counter damage
							local targetVelocity = hit:GetVelocity();
							
							if math.abs(targetVelocity.x) > 150 or math.abs(targetVelocity.y) > 150 then
								local entEyeAngles = hit:EyeAngles();
							
								if math.abs(math.AngleDifference(entEyeAngles.y, (self:GetPos() - hit:GetPos()):Angle().y)) <= 90 then
									poledamage = poledamage + (poledamage * 0.6);
								end
							end
							
							poletype = (attacktable["dmgtype"])
							if hit:IsValid() and hit:IsPlayer() and !hit:GetNWBool("Guardening") == true and hit:GetNWBool("Parry") != true and !hit.iFrames then
								hit:TakeStability((stabilitydamage * 1.3))			
								--hit:EmitSound(attacksoundtable["hitbody"][math.random(1, #attacksoundtable["hitbody"])])
							end
							if (hit:IsNPC() or hit:IsNextBot()) then
								--hit:EmitSound(attacksoundtable["hitbody"][math.random(1, #attacksoundtable["hitbody"])])
							end
						end
					
					elseif distance > 125 and distance <= 135 and hit:IsValid() then
						if (hit:IsNPC() or hit:IsNextBot()) or hit:IsPlayer() then
							--print "Tier 9"
							poledamage = (attacktable["primarydamage"]) * 1.6
							
							-- counter damage
							local targetVelocity = hit:GetVelocity();
							
							if math.abs(targetVelocity.x) > 150 or math.abs(targetVelocity.y) > 150 then
								local entEyeAngles = hit:EyeAngles();
								
								if math.abs(math.AngleDifference(entEyeAngles.y, (self:GetPos() - hit:GetPos()):Angle().y)) <= 90 then
									poledamage = poledamage + (poledamage * 0.6);
								end
							end
							
							poletype = (attacktable["dmgtype"])
							if hit:IsValid() and hit:IsPlayer() and !hit:GetNWBool("Guardening") == true and hit:GetNWBool("Parry") != true and !hit.iFrames then
								hit:TakeStability((stabilitydamage * 1.6))			
								--hit:EmitSound(attacksoundtable["hitbody"][math.random(1, #attacksoundtable["hitbody"])])
							end
							if (hit:IsNPC() or hit:IsNextBot()) then
								--hit:EmitSound(attacksoundtable["hitbody"][math.random(1, #attacksoundtable["hitbody"])])
							end
						end
					
					elseif distance > 135 and hit:IsValid() then
						if (hit:IsNPC() or hit:IsNextBot()) or hit:IsPlayer() then
							--print "Tier 10"
							poledamage = (attacktable["primarydamage"]) * 1.7
							
							-- counter damage
							local targetVelocity = hit:GetVelocity();
							
							if math.abs(targetVelocity.x) > 150 or math.abs(targetVelocity.y) > 150 then
								local entEyeAngles = hit:EyeAngles();
							
								if math.abs(math.AngleDifference(entEyeAngles.y, (self:GetPos() - hit:GetPos()):Angle().y)) <= 90 then
									poledamage = poledamage + (poledamage * 0.6);
								end
							end
							
							poletype = (attacktable["dmgtype"])
							if hit:IsValid() and hit:IsPlayer() and !hit:GetNWBool("Guardening") == true and hit:GetNWBool("Parry") != true and !hit.iFrames then
								hit:TakeStability((stabilitydamage * 1.7))			
								--hit:EmitSound(attacksoundtable["hitbody"][math.random(1, #attacksoundtable["hitbody"])])
							end
							if (hit:IsNPC() or hit:IsNextBot()) then
								--hit:EmitSound(attacksoundtable["hitbody"][math.random(1, #attacksoundtable["hitbody"])])
							end
						end
					end
				else
					if distance >= 0 and distance <= 70 and hit:IsValid() then
						if (hit:IsNPC() or hit:IsNextBot()) or hit:IsPlayer() then
							--print "Tier 1 (Small Polearm)"
							poledamage = (attacktable["primarydamage"]) * 0.1
							poletype = 128
							if hit:IsValid() and hit:IsPlayer() and !hit:GetNWBool("Guardening") == true and hit:GetNWBool("Parry") != true and !hit.iFrames then
								hit:TakeStability(15)

								-- KNOCKBACK
								local knockback = self:GetAngles():Forward() * 650;
								knockback.z = 0
								
								timer.Simple(0.1, function()
									if IsValid(hit) then
										hit:SetVelocity(knockback);
									end
								end);
								
								--hit:EmitSound( "physics/body/body_medium_impact_hard"..math.random(2,6)..".wav" ) 
							end
							if (hit:IsNPC() or hit:IsNextBot()) then
								--hit:EmitSound(attacksoundtable["hitbody"][math.random(1, #attacksoundtable["hitbody"])])
							end
						end
						
					elseif distance > 70 and distance <= 85 and hit:IsValid() then
						if (hit:IsNPC() or hit:IsNextBot()) or hit:IsPlayer() then
							--print "Tier 2 (Small Polearm)"
							poledamage = (attacktable["primarydamage"]) * 1
							
							-- counter damage
							local targetVelocity = hit:GetVelocity();
							
							if math.abs(targetVelocity.x) > 150 or math.abs(targetVelocity.y) > 150 then
								local entEyeAngles = hit:EyeAngles();
							
								if math.abs(math.AngleDifference(entEyeAngles.y, (self:GetPos() - hit:GetPos()):Angle().y)) <= 90 then
									poledamage = poledamage + (poledamage * 0.5);
								end
							end
							
							poletype = (attacktable["dmgtype"])
							if hit:IsValid() and hit:IsPlayer() and !hit:GetNWBool("Guardening") == true and hit:GetNWBool("Parry") != true and !hit.iFrames then
								hit:TakeStability((stabilitydamage * 1))			
								--hit:EmitSound(attacksoundtable["hitbody"][math.random(1, #attacksoundtable["hitbody"])])
							end
							if (hit:IsNPC() or hit:IsNextBot()) then
								--hit:EmitSound(attacksoundtable["hitbody"][math.random(1, #attacksoundtable["hitbody"])])
							end
						end
						
					elseif distance > 85 and hit:IsValid() then
						if (hit:IsNPC() or hit:IsNextBot()) or hit:IsPlayer() then
							--print "Tier 3 (Small Polearm)"
							poledamage = (attacktable["primarydamage"]) * 1.5
							
							-- counter damage
							local targetVelocity = hit:GetVelocity();
							
							if math.abs(targetVelocity.x) > 150 or math.abs(targetVelocity.y) > 150 then
								local entEyeAngles = hit:EyeAngles();
							
								if math.abs(math.AngleDifference(entEyeAngles.y, (self:GetPos() - hit:GetPos()):Angle().y)) <= 90 then
									poledamage = poledamage + (poledamage * 0.5);
								end
							end
							
							poletype = (attacktable["dmgtype"])
							if hit:IsValid() and hit:IsPlayer() and !hit:GetNWBool("Guardening") == true and hit:GetNWBool("Parry") != true and !hit.iFrames then
								hit:TakeStability((stabilitydamage * 1.5))			
								--hit:EmitSound(attacksoundtable["hitbody"][math.random(1, #attacksoundtable["hitbody"])])
							end
							if (hit:IsNPC() or hit:IsNextBot()) then
								--hit:EmitSound(attacksoundtable["hitbody"][math.random(1, #attacksoundtable["hitbody"])])
							end
						end
					end
				end
			
				-- Polearm Damage System
				if (IsValid(hit) and self:IsValid()) then
					local d = DamageInfo()
					d:SetDamage( poledamage * shield_reduction * hit_reduction)
					d:SetAttacker( self )
					d:SetDamageType( damagetype )
					d:SetDamagePosition(src)
					d:SetInflictor(weapon);
				
					if (hit:IsPlayer()) then
						d:SetDamageForce(self:GetForward() * 5000);
				
						if (hit:IsRagdolled()) then
							if self.isDagger then -- Daggers deal more damage against fallen opponents
								d:SetDamage(d:GetDamage() * 2)

								if hit:GetNetVar("ActName") == "unragdoll" then
									Clockwork.player:ExtendAction(hit, 0.3);
								end
							end
						end
					end
					
					hit:TakeDamageInfo(d)

					if (hit:IsNPC() or hit:IsNextBot()) then
						-- Fire attack type
						if attacktable["attacktype"] == "fire_swing" then
							if offhandWeapon then
								hit:Ignite(weapon.IgniteTime * 2);
							else
								hit:Ignite(weapon.IgniteTime * 3);
							end
						end
						
						-- Ice attack type
						if attacktable["attacktype"] == "ice_swing" and hit.AddFreeze then
							if offhandWeapon then
								hit:AddFreeze((weapon.FreezeDamage * 0.6) * (hit:WaterLevel() + 1), self);
							else
								hit:AddFreeze(weapon.FreezeDamage * (hit:WaterLevel() + 1), self);
							end
						end
					else
						if hit:IsPlayer() and !hit:GetNWBool("Guardening") == true and !hit:GetNWBool("Parry") == true and !hit.iFrames then
							-- Fire attack type
							if attacktable["attacktype"] == "fire_swing" then
								if offhandWeapon then
									hit:Ignite(weapon.IgniteTime * 2);
								else
									hit:Ignite(weapon.IgniteTime * 3);
								end
							end
							
							-- Ice attack type
							if attacktable["attacktype"] == "ice_swing" and hit.AddFreeze then
								if offhandWeapon then
									hit:AddFreeze((weapon.FreezeDamage * 0.6) * (hit:WaterLevel() + 1), self);
								else
									hit:AddFreeze(weapon.FreezeDamage * (hit:WaterLevel() + 1), self);
								end
							end
							
							if weapon.CanSwipeAttack == true then
								hit:TakeStability(15)		
							end
						end
					end

					if hit:IsPlayer() and !hit:IsRagdolled() and hit:GetNWBool("Deflect") != true and hit:GetNWBool("Parry") != true and !hit.iFrames then
						self:TriggerAnim4(hit, "a_shared_hit_0"..math.random(1, 3)); 
					end
				end
			end
		else -- reg_swing and others
			if hit:IsValid() and hit:IsPlayer() then
				enemywep = hit:GetActiveWeapon()
			end

			if self:IsValid() then				
				-- Spear Damage System (Messy)					
				local distance = (self:GetPos():Distance(hit:GetPos()))

				if (IsValid(self)) then
					if string.find(weaponClass, "begotten_spear_") then
						if distance >= 0 and distance <= 64 and hit:IsValid() then
							damage = (attacktable["primarydamage"]) * 0.05
							damagetype = 128
							
							if (hit:IsNPC() or hit:IsNextBot()) or (hit:IsPlayer() and !hit:GetNWBool("Guardening") and !hit:GetNWBool("Parry") and !hit:GetNWBool("Deflect")) and !hit.iFrames then
								--print "Spear Shaft Hit"
								
								-- KNOCKBACK
								local knockback = self:GetAngles():Forward() * 650;
								knockback.z = 0

								timer.Simple(0.1, function()
									if IsValid(hit) then
										hit:SetVelocity(knockback);
									end
								end);
								
								if hit:IsPlayer() then
									hit:TakeStability(15)
								end
							end
					
						elseif distance >= 65 and hit:IsValid() then
							damage = (attacktable["primarydamage"])
							damagetype = (attacktable["dmgtype"])
							
							if (hit:IsNPC() or hit:IsNextBot()) or (hit:IsPlayer() and !hit:GetNWBool("Guardening") and !hit:GetNWBool("Parry") and !hit:GetNWBool("Deflect")) and !hit.iFrames then
								-- counter damage
								local targetVelocity = hit:GetVelocity();
								
								if math.abs(targetVelocity.x) > 150 or math.abs(targetVelocity.y) > 150 then
									local entEyeAngles = hit:EyeAngles();
								
									if math.abs(math.AngleDifference(entEyeAngles.y, (self:GetPos() - hit:GetPos()):Angle().y)) <= 90 then
										damage = damage + (damage * 0.6);
									end
								end
								
								if hit:IsPlayer() then
									hit:TakeStability((stabilitydamage * shield_reduction * hit_reduction));
								end
							end
						end
					else
						-- Bellhammer special
						if weapon.IsBellHammer == true and ((hit:IsNPC() or hit:IsNextBot()) or (hit:IsPlayer() and !hit:GetNWBool("Guardening") and !hit:GetNWBool("Parry") and !hit:GetNWBool("Deflect"))) and !hit.iFrames then
							timer.Simple(0.2, function() 
								if hit:IsValid() and (hit:IsNPC() or hit:IsNextBot()) or hit:IsPlayer() then
									hit:EmitSound("meleesounds/bell.mp3")
								end 
							end);
							
							if hit:IsPlayer() then
								hit:Disorient(5);
							end
						end
					end
				end
			
				-- Spear Damage System (Messy)
				print("aa")
				if (IsValid(hit) and self:IsValid()) then
					print("aaaa")
					local d = DamageInfo()
					d:SetDamage( damage * shield_reduction * hit_reduction)
					d:SetAttacker( self )
					d:SetDamageType( damagetype )
					d:SetDamagePosition(src)
					d:SetInflictor(weapon);
				
					if (hit:IsPlayer()) then
						d:SetDamageForce(self:GetForward() * 5000);
						
						if (hit:IsRagdolled()) then
							if self.isDagger then -- Daggers deal more damage against fallen opponents
								d:SetDamage(d:GetDamage() * 2)

								if hit:GetNetVar("ActName") == "unragdoll" then
									Clockwork.player:ExtendAction(hit, 0.3);
								end
							end
						end
					end
					
					hit:TakeDamageInfo(d)

					if (hit:IsNPC() or hit:IsNextBot()) then
						-- Fire attack type
						if attacktable["attacktype"] == "fire_swing" then
							if offhandWeapon then
								hit:Ignite(weapon.IgniteTime * 2);
							else
								hit:Ignite(weapon.IgniteTime * 3);
							end
						end
						
						-- Ice attack type
						if attacktable["attacktype"] == "ice_swing" and hit.AddFreeze then
							if offhandWeapon then
								hit:AddFreeze((weapon.FreezeDamage * 0.6) * (hit:WaterLevel() + 1), self);
							else
								hit:AddFreeze(weapon.FreezeDamage * (hit:WaterLevel() + 1), self);
							end
						end
					else
						if hit:IsPlayer() and !hit:GetNWBool("Guardening") == true and !hit:GetNWBool("Parry") == true and !hit.iFrames then
							-- Fire attack type
							if attacktable["attacktype"] == "fire_swing" then
								if offhandWeapon then
									hit:Ignite(weapon.IgniteTime * 2);
								else
									hit:Ignite(weapon.IgniteTime * 3);
								end
							end
							
							-- Ice attack type
							if attacktable["attacktype"] == "ice_swing" and hit.AddFreeze then
								if offhandWeapon then
									hit:AddFreeze((weapon.FreezeDamage * 0.6) * (hit:WaterLevel() + 1), self);
								else
									hit:AddFreeze(weapon.FreezeDamage * (hit:WaterLevel() + 1), self);
								end
							end
							
							if weapon.CanSwipeAttack == true then
								hit:TakeStability(15)		
							end
						end
					end

					if hit:IsPlayer() and !hit:IsRagdolled() and hit:GetNWBool("Deflect") != true and hit:GetNWBool("Parry") != true and !hit.iFrames then
						self:TriggerAnim4(hit, "a_shared_hit_0"..math.random(1, 3)); 
					end
				end
			end
		end

	end

	function ENT:HandleAttack(swingType)
		local curTime = CurTime();
		local attacktable = self.MeleeAttackTable;
		local pos = self:GetBonePosition(self:LookupBone("ValveBiped.Bip01_Spine1"));
		local aimVector = self:GetForward();
		local meleeArc = attacktable["meleearc"] or 25;
		local meleeRange = (attacktable["meleerange"] or 1) / 10;
		local hitsAllowed = self.WeaponTable.MultiHit or 1;
		local hitEntities = {};

		if(self.parrySuccess and IsValid(self.parryTarget) and self.parryTarget:IsPlayer()) then
			local parryTargetWeapon = self.parryTarget:GetActiveWeapon();
			
			if IsValid(parryTargetWeapon) and self.parryTarget:IsWeaponRaised(parryTargetWeapon) then
				parryTargetWeapon:SetNextPrimaryFire(0);
				parryTargetWeapon:SetNextSecondaryFire(0);
			end
			
			self.parryTarget.blockStaminaRegen = math.min(self.parryTarget.blockStaminaRegen, curTime + 0.5);

		end

		if !self.parrySuccess and (swingType == "thrust_swing") then
			meleeArc = attacktable["altmeleearc"] or attacktable["meleearc"] or 25;
		
			if attacktable.canaltattack then
				if attacktable.altmeleerange then
					meleeRange = attacktable.altmeleerange / 10;
				--[[else
					if self.CanSwipeAttack then
						meleeRange = meleeRange * 0.8
					else
						meleeRange = meleeRange * 1.2
					end]]--
				end
			end
		end

		local enemy = (IsValid(self:GetEnemy()) and self:GetEnemy() or Clockwork.Client)
		if(enemy:IsPlayer()) then
			local ragdoll = enemy:GetRagdollEntity();
			if(IsValid(ragdoll)) then enemy = ragdoll; end

		end

		local sex = (self:GetPos() - enemy:GetPos()):Angle();
		sex:RotateAroundAxis(sex:Up(), -90);
		aimVector = sex:Right();

		local tr = util.TraceLine({
			start = pos,
			endpos = pos + (aimVector * meleeRange),
			mask = MASK_SOLID,
			filter = self,

		});

		if tr.Hit then
			if IsValid(tr.Entity) then
				if tr.Entity:IsPlayer() or tr.Entity:IsNPC() or tr.Entity:IsNextBot() or Clockwork.entity:IsPlayerRagdoll(tr.Entity) then
					table.insert(hitEntities, tr.Entity);
				else
					hitsAllowed = 0;
				end
				
				if self.parrySuccess and tr.Entity:GetNWBool("Parried") and self.parryTarget == tr.Entity then
					self:HandleHit(tr.Entity, tr.HitPos, "parry_swing");
				else
					self:HandleHit(tr.Entity, tr.HitPos, swingType);
				end
			end
		end

		if !tr.Hit or #hitEntities < hitsAllowed then
			for i = 1, meleeArc - 1 do
				local newAimVector = Vector(aimVector);
			
				if (i % 2 == 0) then
					-- If even go left.
					newAimVector:Rotate(Angle(0, math.Round(i / 2), 0));
				else
					-- If odd go right.
					newAimVector:Rotate(Angle(0, -math.Round(i / 2), 0));
				end

				local tr2 = util.TraceLine({
					start = pos,
					endpos = pos + (newAimVector * meleeRange),
					mask = MASK_SOLID,
					filter = self,

				});
				
				if tr2.Hit then
					if IsValid(tr2.Entity) and !table.HasValue(hitEntities, tr2.Entity) then
						if tr2.Entity:IsPlayer() or tr2.Entity:IsNPC() or tr2.Entity:IsNextBot() or Clockwork.entity:IsPlayerRagdoll(tr2.Entity) then
							table.insert(hitEntities, tr2.Entity);
							
							if self.parrySuccess and tr2.Entity:GetNWBool("Parried") and self.parryTarget == tr2.Entity then
								self:HandleHit(tr2.Entity, tr2.HitPos, "parry_swing", #hitEntities);
							else
								self:HandleHit(tr2.Entity, tr2.HitPos, swingType, #hitEntities);
							end
						end
					end
				
					if #hitEntities >= hitsAllowed then
						break;
					end
				end
			end
		end

	end

	local NaN = 0/0;

	-- AI --
	function ENT:OnMeleeAttack(enemy)
		if(self.shouldBlock or self.parrying or self.rolling) then return; end
		if !self.nextMeleeAttack or self.nextMeleeAttack < CurTime() then
			self.isAttacking = true;

			local maxDelay = Lerp(self:GetNWInt("Aggressiveness")/50, 2, 1);
			self.nextMeleeAttack = CurTime() + math.Rand(self.MeleeAttackDelay, self.MeleeAttackDelay + maxDelay);

			local weaponClass = self:GetNWString("weaponClass");
			local seq, isAltAttack = self:GetAttackAnim();
			seq = self:LookupSequence(seq);

			local soundTable = self.parrySuccess and self.MeleeCriticalSounds or self.MeleeAttackSounds;
			self:EmitSound(soundTable[math.random(#soundTable)]);
			self.attackLayer = self:AddGestureSequence(seq, true);

			local timerTime = self.MeleeAttackStrikeTime + 0.1;

			if(math.random(1, Lerp(self:GetNWInt("Aggressiveness")/50, 10, 1)) == 3) then
				timer.Create("NPCPlayerFeint."..self:EntIndex(), math.max(0.1, timerTime - math.Rand(0.15, 0.3)), 1, function()
					if(self.attackLayer) then self:RemoveAllGestures(); self.attackLayer = false; end
					self.isAttacking = false;
					self:EmitSound("begotten/feint.mp3");

					timer.Adjust("NPCPlayer.ParrySuccess."..self:EntIndex(), 2.5);
				
				end);

			else
				timer.Create("NPCPlayerAttack."..self:EntIndex(), self.MeleeAttackStrikeTime + 0.1, 1, function()
					if(!IsValid(self)) then return; end
					if(!self.isAttacking) then return; end

					self:HandleAttack(isAltAttack and "thrust_swing" or self.MeleeAttackTable["attacktype"]);

					--[[self:Attack({
						damage = (self.MeleeAttackDamage == NaN and 10 or self.MeleeAttackDamage) * (self.parrySuccess and 3 or 1),
						type = DMG_SLASH,
						viewpunch = Angle(20, math.random(-10, 10), 0),
						--inflictor = self:GetWeapon(class),
					}, function(self, hit)
					end)]]

					self.parrySuccess = false;
				
				end);

				timer.Simple(self.MeleeAttackDelay, function()
					if(!IsValid(self)) then return; end

					self.isAttacking = false;
				
				end);

			end

			--self:PlaySequenceAndMove(self.AttackAnimation, 1, self.FaceEnemy)
		end

	end

	function ENT:OnReachedPatrol()
		self:Wait(math.random(3, 7))
	end

	function ENT:ShouldIgnore(ent)
		if ent:IsPlayer() and (ent.possessor or ent.victim) then
			return true;

		end
		
	end

	function ENT:WhilePatrolling()
		self:OnIdle()

	end
	
	function ENT:OnIdle()
		local curTime = CurTime();
		
		if (!self.nextId or self.nextId < curTime) then
			self.nextId = curTime + 10
			self:AddPatrolPos(self:RandomPos(250))

		end

	end
	-- Damage --
	function ENT:OnDeath(dmg, delay, hitgroup)
		--cwZombies:OnNPCKilled(self, attacker, inflictor, attackers);
	end

	local function PlayDeathSound(self)
		if(self:WaterLevel() >= 3) then return; end

		local model = self:GetModel();
		local isFemale = IsFemale(self);
		local pitch = isFemale and math.random(100, 115) or math.random(95, 110);

		if(string.find(model, "voltist")) then
			self:EmitSound(voltistSounds["death"][math.random(1, #voltistSounds["death"])], 90, 150);
			self.nextPainSound = CurTime() + 0.5;
			return;
		end
	
		if(string.find(model, "male_9")) then
			if(!isFemale) then
				self:EmitSound("voice/man1/man1_death0"..math.random(1, 9)..".wav", 90, pitch);
				
			else
				self:EmitSound("voice/female2/female2_death0"..math.random(1, 9)..".wav", 90, pitch);
				
			end

		elseif(!isFemale) then
			self:EmitSound("voice/man3/man3_death0"..math.random(1, 9)..".wav", 90, pitch);

		else
			self:EmitSound("voice/female2/female2_death0"..math.random(1, 9)..".wav", 90, pitch);

		end

	end

	function ENT:OnRagdoll(dmg, oldSelf)
		PlayDeathSound(self);
		oldSelf:SetModel(oldSelf:GetNWString("head"));
		oldSelf:Remove();

		local wepString = oldSelf:GetNWString("weaponClass");
		if(!wepString) then return; end

		local wep = item.CreateInstance(wepString);
		local ent = Clockwork.entity:CreateItem(nil, wep, self:GetBonePosition(self:LookupBone("ValveBiped.Bip01_R_Hand")));

		local newRagdoll = ents.Create("prop_ragdoll");
		newRagdoll:SetModel(self:GetModel());
		newRagdoll:SetNWString("clothes", oldSelf:GetNWString("clothes"));
		newRagdoll:SetNWString("name", "Corpse");
		newRagdoll:SetNWEntity("Player", game.GetWorld());
		newRagdoll.cwInventory = {};

		if(oldSelf.SpawnKit) then
			if(oldSelf.EquippedArmor != "none") then
				Clockwork.inventory:AddInstance(newRagdoll.cwInventory, item.CreateInstance(oldSelf.EquippedArmor));

			end

			if(oldSelf.EquippedHelm != "none") then
				Clockwork.inventory:AddInstance(newRagdoll.cwInventory, item.CreateInstance(oldSelf.EquippedHelm));

			end

			for _, v in pairs(oldSelf.SpawnKit.drops) do
				if(math.random(1, v.chance) != 1) then continue; end

				for i = 1, math.random(v.amount[1], v.amount[2]) do
					Clockwork.inventory:AddInstance(newRagdoll.cwInventory, item.CreateInstance(v.id));

				end

			end

		end

		newRagdoll.cwCash = math.random(10,200);
		newRagdoll:SetPos(self:GetPos());
		newRagdoll:SetAngles(self:GetAngles());
		newRagdoll:Spawn();

		newRagdoll:DropToFloor();

		self:Remove();
		
		return true;
		
	end
	function ENT:Makeup()
	end
	ENT.ModelScale = 1
	ENT.pitch = 100

	ENT.doRun = false;
	function ENT:ShouldRunEnemy()
		local curTime = CurTime();

		if(self:GetPos():DistToSqr(self:GetEnemy():GetPos()) > self.MeleeAttackRange * self.MeleeAttackRange) then self.doRun = true; end

		return self.doRun;

	end

	function ENT:ShouldRun()
		if self:HasEnemy() then return self:ShouldRunEnemy() end
		local patrol = self:GetPatrol()
		return IsValid(patrol) and patrol:ShouldRun(self)
	end

	function ENT:HandleCWWeapon()
		local wepString = self:GetNWString("weaponClass");

		if(!wepString) then return; end

		local wep = weapons.GetStored(wepString);
		self.WeaponTable = wep;

		local tbl = weaponTypes[wep.HoldType];
		if(!tbl) then return; end

		self.WeaponAnimTable = tbl;
		self.RunAnimation = tbl.run;
		self.WalkAnimation = tbl.walk;
		self.IdleAnimation = tbl.idle;
		self.AttackAnimation = wep.PrimarySwingAnim or tbl.attack;
		self.ParryAnimation = wep.ParryAnim;
		self.CriticalAnimation = wep.CriticalAnim;
		self.BlockAnimation = wep.BlockAnim;

		tbl = GetTable(wep.AttackTable);
		if(!tbl) then return; end

		self.MeleeAttackRange = ((tbl["meleerange"] or 1) / 10);
		self.ReachEnemyRange = ((tbl["meleerange"] or 1) / 10) - 50;
		self.ArmorPiercing = tbl["armorpiercing"];
		self.StabilityDamage = tbl["stabilitydamage"];
		self.MeleeAttackDelay = tbl["delay"];
		self.MeleeAttackDamage = tbl["primarydamage"] or 10;
		self.MeleeAttackStrikeTime = tbl["striketime"];
		self.MeleeAttackDmgType = tbl["dmgtype"];
		self.MeleeAttackTable = tbl;

		tbl = GetTable(wep.BlockTable);
		if(!tbl) then return; end

		self.BlockEffect = tbl["blockeffect"];
		self.MeleeParryWindow = tbl["parrydifficulty"];
		self.MeleeBlockTable = tbl;

		tbl = GetSoundTable(wep.AttackSoundTable);
		if(!tbl) then return; end

		self.MeleeAttackSoundTable = tbl;
		self.MeleeAttackSounds = tbl["primarysound"];
		self.MeleeParrySounds = tbl["parryswing"];
		self.MeleeCriticalSounds = tbl["criticalswing"];

		if(!self:HasWeapon()) then
			self:EmitSound(tbl["drawsound"][math.random(#tbl["drawsound"])]);
			self:GiveWeapon(wepString);
			
		end

		tbl = GetSoundTable(wep.BlockSoundTable);
		if(!tbl) then return; end

		self.MeleeBlockSoundTable = tbl;

	end

	function ENT:CustomThink()
		if (!self.lastStuck and self:IsStuck()) then
			self.lastStuck = CurTime() + 2;
			self:Jump(50);
		end;

		self:HandleCWWeapon();

	end
	-- Animations/Sounds --
	function ENT:OnNewEnemy()
	end

	local BLOCK_LAYER = 62;

	function ENT:HandleBlocking()
		if(self:IsPossessed()) then return; end
		if(!self.shouldBlock) then self.shouldBlock = false; end
		if(!self.nextEnemyBlock or self.nextEnemyBlock < CurTime()) then
			self.shouldBlock = !self.shouldBlock;
			self.nextEnemyBlock = CurTime() + (self.shouldBlock and math.Rand(Lerp(self:GetNWInt("Aggressiveness")/50, 2, 0.3), Lerp(self:GetNWInt("Aggressiveness")/50, 6, 1)) or math.Rand(1, 4));

		end

		if(self.shouldBlock and !self.isBlocking and !self.isAttacking) then
			self.isBlocking = true;

			self.blockLayer = self:AddGestureSequence(self:LookupSequence(self.BlockAnimation), false);
			self:EmitSound(self.MeleeBlockSoundTable["guardsound"][math.random(#self.MeleeBlockSoundTable["guardsound"])], 95, math.random(90, 100), 2);

		elseif(!self.shouldBlock and self.isBlocking) then
			self.isBlocking = false;
			self:RemoveAllGestures();
			self.nextMeleeAttack = CurTime() + math.Rand(Lerp(self:GetNWInt("Aggressiveness")/50, 0.8, 0.15), Lerp(self:GetNWInt("Aggressiveness")/50, 2, 0.5));
			
		end

	end

	ENT.idleDirection = 0
	function ENT:OnIdleEnemy()
		if(self.doParry and !self.isBlocking and !self.parrying) then
			self.isAttacking = false;
			self.doParry = false;
			self.parrying = true;
			self.nextCanParry = CurTime() + 2;

			self:EmitSound(self.MeleeParrySounds[math.random(#self.MeleeParrySounds)])

			if(self.attackLayer) then self:RemoveAllGestures(); self:EmitSound("begotten/feint.mp3"); self.attackLayer = false; end
			self:AddGestureSequence(self:LookupSequence(self.ParryAnimation), true);

			timer.Simple(self.MeleeParryWindow + 0.25, function()
				if(!IsValid(self)) then return; end

				self.parrying = false;
			
			end)

		end

		if(self.rollIn and self.rollIn < CurTime() and !self.isBlocking) then
			self.rollIn = nil;
			self:Roll(math.random(0, 2));

			return;

		end

		if(!self.nextEnemyIdle or self.nextEnemyIdle < CurTime()) then
			self.nextEnemyIdle = CurTime() + math.Rand(Lerp(self:GetNWInt("Aggressiveness")/50, 2, 0.3), Lerp(self:GetNWInt("Aggressiveness")/50, 3, 0.8));

			local oldDir = self.idleDirection
			while(self.idleDirection == oldDir) do
				self.idleDirection = math.random(1, 3);

			end
			
		end

		self:HandleBlocking();

		self.doRun = false;
		
		if(self.idleDirection == 0) then self:MoveRight();
		elseif(self.idleDirection == 1) then self:MoveLeft();
		end

		self:FaceEnemy();

	end
	function ENT:OnLandedOnGround()
	end

	function ENT:OnAnimEvent()
	end
end
-- DO NOT TOUCH --
AddCSLuaFile()
DrGBase.AddNextbot(ENT)

--[[if(IsValid(____TESTMODEL)) then ____TESTMODEL:Remove(); end

____TESTMODEL = vgui.Create("DFrame");
____TESTMODEL:SetPos(100, 300)
____TESTMODEL:SetSize( 500, 500)

____TESTMODEL.modelPanel = ____TESTMODEL:Add("DAdjustableModelPanel");
____TESTMODEL.modelPanel:Dock(FILL);
____TESTMODEL.modelPanel:SetModel(Clockwork.Client:GetModel())
local ent = ____TESTMODEL.modelPanel:GetEntity()
local pos = ent:GetPos()
local campos = pos + Vector( -100, 0, 40 )
____TESTMODEL.modelPanel:SetCamPos( campos )
____TESTMODEL.modelPanel:SetFOV( 45 )
ent:ResetSequence(ent:LookupSequence("a_heavy_great_unholstered_idle"))

____TESTMODEL:MakePopup();

Clockwork.Client:EmitSound("hl1/fvox/bell.wav", 70, 80, 0.3)]]

if(SERVER) then
	hook.Add("PreEntityTakeDamage", "NPCPlayer.TakeDamage", function(self, damageInfo)
		if(!IsValid(self) or self:IsPlayer() or self:GetClass() != "npc_bgt_player") then return; end
		local attacker = damageInfo:GetAttacker();
		local damage = damageInfo:GetDamage();

		if(self.rolling) then
			self:EmitSound("meleesounds/comboattack3.wav.mp3", 75, math.random( 90, 110 ));
			damageInfo:SetDamage(0);

			return true;

		end

		if(self.parrying and IsValid(attacker)) then
			damageInfo:SetDamage(0);
			attacker:SetNWBool("Parried", true);
			self:EmitSound("meleesounds/DS2Parry.mp3");
			self.NextMeleeAttack = CurTime() + math.random(Lerp(self:GetNWInt("Aggressiveness")/50, 0.7, 0.7), Lerp(self:GetNWInt("Aggressiveness")/50, 0.7, 2));
			self.parrySuccess = true;
			self.parryTarget = attacker;
			self.nextCanParry = 0;

			if(attacker:IsPlayer()) then netstream.Start(attacker, "Stunned", (attacker:HasBelief("encore") and 0.5 or 1)); end

			timer.Create("NPCPlayer.ParrySuccess."..self:EntIndex(), 2.5, 1, function()
				if(!IsValid(self)) then return; end

				self.parrySuccess = false;
				self.parryTarget = nil;
			
			end);
			
			timer.Simple(2.5, function()
				if(!IsValid(attacker)) then return; end

				attacker:SetNWBool("Parried", false);
				if(attacker:IsPlayer()) then hook.Run("RunModifyPlayerSpeed", attacker, attacker.cwInfoTable, true); end
			
			end)

			return true;

		end

		if(self.isBlocking and !damageInfo:IsDamageType(DMG_BURN)) then damageInfo:ScaleDamage(0.35); end

	end)

	hook.Add("EntityTakeDamageArmor", "NPCPlayer.TakeDamageArmor", function(self, damageInfo)
		if(!IsValid(self) or self:IsPlayer() or self:GetClass() != "npc_bgt_player") then return; end

		if damageInfo:IsDamageType(DMG_BLAST) then
			return;
		end

		local attacker = damageInfo:GetAttacker();
		local originalDamage = damageInfo:GetDamage();

		local armorItem = Clockwork.item:FindByID(self.EquippedArmor);
		print(self.EquippedArmor)
		if(!armorItem or table.IsEmpty(armorItem)) then return; end

		print("Checking Armor Item: "..armorItem.uniqueID);
		print("Armor Item Hit!");

		local damageTypeScales = armorItem.damageTypeScales;
		local pierceScale = armorItem.pierceScale;
		local bluntScale = armorItem.bluntScale;
		local slashScale = armorItem.slashScale;
		local armorPiercing = 0;
		local damage = damageInfo:GetDamage();
		local inflictor = damageInfo:GetInflictor();
		print("Damage: "..tostring(damage));
		
		if armorItem.attributes and table.HasValue(armorItem.attributes, "deathknell") then
			-- Bellhammer radius disorient
			for k, v in pairs(ents.FindInSphere(self:GetPos(), 200)) do
				if v:IsPlayer() then
					v:Disorient(1)
				end
			end
			
			self:EmitSound("meleesounds/bell.mp3");
		end
		
		if attacker:IsPlayer() and IsValid(inflictor) and (inflictor.isJavelin or inflictor:IsWeapon()) then
			local attackTable;

			if inflictor.AttackTable then
				attackTable = GetTable(inflictor.AttackTable);
			end
			
			--print("Attack table found for weapon!");
			if attackTable then
				if attacker:GetNWBool("ThrustStance") and (!IsValid(inflictor) or (IsValid(inflictor) and !inflictor.isJavelin)) then
					armorPiercing = attackTable["altarmorpiercing"] or 0;
					--print("Thrust stance.");
				else
					armorPiercing = attackTable["armorpiercing"] or 0;
					--print("Not thrust stance.");
				end
				
				if attacker:GetCharmEquipped("ring_penetration") then
					armorPiercing = armorPiercing + 10;
				end
				
				if (inflictor.Base == "sword_swepbase" or inflictor.isJavelin) and attacker:HasBelief("the_light") then
					armorPiercing = armorPiercing + (armorPiercing * 0.15);
				end
				
				if attacker:HasBelief("billman") then
					if (inflictor.Category and (string.find(inflictor.Category, "Polearm") or string.find(inflictor.Category, "Spear") or string.find(inflictor.Category, "Rapier"))) or inflictor.isJavelin then
						armorPiercing = armorPiercing + (armorPiercing * 0.2);
					end
				end
				
				armorPiercing = math.Round(armorPiercing * 0.75); -- Scales all AP. Set this to lower to make armor more effective, or higher to make it less effective.
				
				print("AP Value: "..tostring(armorPiercing));
				
				if inflictor.Base == "sword_swepbase" then
					local activeWeaponItemTable = item.GetByWeapon(inflictor);
					
					if activeWeaponItemTable then
						local activeWeaponCondition = activeWeaponItemTable:GetCondition() or 100;
						
						if damageType == DMG_CLUB then
							armorPiercing = math.Round(armorPiercing * Lerp(activeWeaponCondition / 100, 0.7, 1));
						else
							armorPiercing = math.Round(armorPiercing * Lerp(activeWeaponCondition / 100, 0.5, 1));
						end
					end
				end
			end;
		else
			armorPiercing = inflictor.ArmorPiercing or attacker.ArmorPiercing or 40;
		end;
		
		--print("Armor piercing: "..tostring(armorPiercing));
		
		local protection = armorItem.protection;
		
		-- Make sure protection does not exceed maximum value of 95.
		protection = math.min(math.Round(protection), 95);
		
		--print("Armor protection value: "..tostring(protection));
		local effectiveness;
		
		if damageType == DMG_BULLET or damageType == DMG_BUCKSHOT then
			effectiveness = damage;
		else
			effectiveness = math.Clamp(damage / (protection / armorPiercing), 0, damage);
		end
		
		damageInfo:SetDamage(effectiveness);
		--print("Setting damage from effectiveness to: "..tostring(damageInfo:GetDamage()));
		
		if (damageTypeScales and !table.IsEmpty(damageTypeScales)) then
			for k, v in pairs (damageTypeScales) do
				if (k == DMG_CLUB or k == DMG_SLASH or k == DMG_VEHICLE) then
					damageTypeScales[k] = nil;
				end;
			end;
			
			if (damageTypeScales[damageType] and isnumber(damageTypeScales[damageType])) then
				damageInfo:ScaleDamage(damageTypeScales[damageType])
				--print("Scaling damage by type "..damageType..": "..tostring(damageTypeScales[damageType]));
			end;
		end;
		
		if (armorItem.bluntScale and damageType == DMG_CLUB) then
			local dmgScale = 1 - ((1 - armorItem.bluntScale) * (condition / 100));
			
			damageInfo:ScaleDamage(dmgScale);
			--print("Scaling blunt damage: "..tostring(dmgScale));
		elseif (armorItem.slashScale and damageType == DMG_SLASH) then
			local dmgScale = 1 - ((1 - armorItem.slashScale) * (condition / 100));
			
			damageInfo:ScaleDamage(dmgScale);
			--print("Scaling slash damage: "..tostring(dmgScale));
		elseif (armorItem.pierceScale and (damageType == DMG_VEHICLE)) then
			local dmgScale = 1 - ((1 - armorItem.pierceScale) * (condition / 100));
		
			damageInfo:ScaleDamage(dmgScale);
			--print("Scaling pierce damage: "..tostring(dmgScale));
		elseif (armorItem.bulletScale and (damageType == DMG_BULLET or damageType == DMG_BUCKSHOT)) then
			if attacker:IsPlayer() then
				local activeWeapon = attacker:GetActiveWeapon();

				if (IsValid(activeWeapon) and !activeWeapon.IgnoresBulletResistance) then
					local dmgScale = 1 - ((1 - armorItem.bulletScale) * (condition / 100));
			
					damageInfo:ScaleDamage(dmgScale);
					--print("Scaling pierce damage: "..tostring(dmgScale));
				end
			else
				local dmgScale = 1 - ((1 - armorItem.bulletScale) * (condition / 100));
		
				damageInfo:ScaleDamage(dmgScale);
				--print("Scaling pierce damage: "..tostring(dmgScale));
			end
		end;
		
		print("Final armor damage: "..tostring(damageInfo:GetDamage()));
	
	end);

	hook.Add("FuckMyLife", "NPCPlayer.Damages", function(player, damageInfo)
		local self = damageInfo:GetAttacker();
		local damage = damageInfo:GetDamage();
		if(!IsValid(self) or self:IsPlayer() or self:GetClass() != "npc_bgt_player") then return; end
		if(damage <= 0) then return; end

		--player:TakeStability(self.StabilityDamage);

		--local weapon = self:GetNWString("weaponClass");

		--if(weapon == "begotten_2h_great_bellhammer") then
		--	player:Disorient(5);
		--	player:EmitSound("meleesounds/bell.mp3");

		--end

		--local wep = weapons.GetStored(weapon);
		--if(!wep) then return; end

		--if(wep.IgniteTime) then player:Ignite(wep.IgniteTime); end
		--if(wep.FreezeTime) then player:AddFreeze(wep.FreezeDamage * (player:WaterLevel() + 1)); end
	
	end);

	util.AddNetworkString("cwSendSpawnKit");

	net.Receive("cwSendSpawnKit", function(_, player)
		if(!player.wantingSpawnKit) then return; end


	
	end);

else
	net.Receive("cwSendSpawnKit", function()
		
	
	end);

	--hook.Remove("HUDPaint", "NPCPlayer.ESP")
	--[[hook.Add("HUDPaint", "NPCPlayer.ESP", function()
		if(Clockwork.ConVars.ZOMBIEESP:GetInt() == 0) then return; end
		if(!hook.Run("PlayerCanSeeAdminESP") and (!input.IsKeyDown(KEY_C) or Clockwork.ConVars.PEEK_ESP:GetInt() == 0)) then return; end		

		for _, v in pairs(ents.FindByClass("npc_bgt_player")) do
			local pos = v:GetBonePosition(2):ToScreen();

			draw.SimpleTextOutlined("Player", "TargetIDSmall", pos.x, pos.y, Clockwork.option:GetColor("information"), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black);
			draw.SimpleTextOutlined(v:Health().." / "..v:GetMaxHealth(), "TargetIDSmall", pos.x, pos.y + 15, Clockwork.option:GetColor("information"), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black);
			draw.SimpleTextOutlined("Aggressiveness: "..v:GetNWInt("Aggressiveness", 0).." / 50", "TargetIDSmall", pos.x, pos.y + 30, Clockwork.option:GetColor("information"), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black);

		end
	
	end);]]
	
end