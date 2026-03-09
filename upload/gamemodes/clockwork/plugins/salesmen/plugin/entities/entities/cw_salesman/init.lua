--[[
	BEGOTTEN III: Developed by DETrooper, cash wednesday, gabs & alyousha35
--]]

util.Include("shared.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

-- Called when the entity initializes.
function ENT:Initialize()
	self:DrawShadow(true)
	self:SetSolid(SOLID_BBOX)
	self:PhysicsInit(SOLID_BBOX)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetUseType(SIMPLE_USE)
end

-- A function to setup the salesman.
function ENT:SetupSalesman(name, physDesc, animation, bShowChatBubble)
	self:SetNetworkedString("Name", name)
	self:SetNetworkedString("PhysDesc", physDesc)
	self:SetupAnimation(animation)

	if (bShowChatBubble) then
		self:MakeChatBubble()
	end
end

-- A function to talk to a player.
function ENT:TalkToPlayer(player, text, default)
	--[[local sayString = text.text or default

	if (text.bHideName != true) then
		sayString = self:GetNetworkedString("Name").." says \""..sayString.."\""
	end

	if (!text.text or (text.text and text.text != "")) then
		Schema:EasyText(player, "lightslategrey", sayString)
	end

	if (text.sound and text.sound != "") then
		netstream.Start(player, "SalesmanPlaySound", {text.sound, self})
	end]]--
	
	-- new stuff
	
	local sayString = text.text or default;
	local chatType = "talk";
	local name = self:GetNetworkedString("Name");
	local type = "t"..chatType;

	if sayString and sayString ~= "" then
		--[[if (istable(player)) then
			for k, v in pairs (player) do
				if (IsValid(v) and v:IsPlayer()) then
					local eyeTrace = v:GetEyeTrace();
					local entity = eyeTrace.Entity;
					local bFocused = false
					
					if (IsValid(entity) and entity == self) then
						bFocused = true;
					end;

					Clockwork.chatBox:Add(v, nil, type, sayString, {name = name, focusedOn = bFocused});
				end;
			end;
		else]]if (IsValid(player) and player:IsPlayer()) then
			local eyeTrace = player:GetEyeTrace();
			local entity = eyeTrace.Entity;
			local bFocused = false

			if (IsValid(entity) and entity == self) then
				bFocused = true;
			end
		
			Clockwork.chatBox:Add(player, nil, type, sayString, {name = name, focusedOn = bFocused});
		end;
	end;
	
	if (text.sound and text.sound != "") then
		netstream.Start(player, "SalesmanPlaySound", {text.sound, self})
	end
end

-- Called to setup the animation.
function ENT:SetupAnimation(animation)
	if (animation and animation != -1) then
		self:ResetSequence(animation)
	else
		self:ResetSequence(4)
	end
end

-- Called to make the chat bubble.
function ENT:MakeChatBubble()
	self.cwChatBubble = ents.Create("cw_chatbubble")
	self.cwChatBubble:SetParent(self)
	self.cwChatBubble:SetPos(self:GetPos() + Vector(0, 0, 90))
	self.cwChatBubble:SetNWEntity("salesman", self)
	self.cwChatBubble:Spawn()
end

-- A function to get the chat bubble.
function ENT:GetChatBubble()
	return self.cwChatBubble
end

-- Called when the entity is used.
function ENT:Use(activator, caller)
	if (IsValid(activator) and activator:IsPlayer()) then
		if (activator:GetEyeTraceNoCursor().HitPos:Distance(self:GetPos()) < 196) then
			if (hook.Run("PlayerCanUseSalesman", activator, self) != false) then
				hook.Run("PlayerUseSalesman", activator, self)
			end
		end
	end
end

-- Called when the entity is removed.
function ENT:OnRemove()
	if (IsValid(self.cwChatBubble)) then
		self.cwChatBubble:Remove()
	end
end

function ENT:DamageChatRadius(radius, class, text, dmg)
	for _, v in pairs(ents.FindInSphere(self:GetPos(), radius)) do
		if(!v:IsPlayer() or !v:Alive()) then continue; end

		Clockwork.chatBox:Add(v, nil, class, text, {name = self:GetNetworkedString("Name"), focusedOn = (v == dmg:GetAttacker())});

	end

end

local function IsFemale(self)
	return string.find(self:GetNWString("head"), "female");

end

function ENT:PlayPainSound()
	local model = self:GetNWString("head");
	local isFemale = IsFemale(self);
	local pitch = isFemale and math.random(100, 115) or math.random(95, 110);

	if(self:WaterLevel() >= 3) then return; end
	if(self.nextPainSound and self.nextPainSound > CurTime()) then return; end
	self.nextPainSound = CurTime() + 0.5;

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

ENT.painTolerance = true;
function ENT:OnTakeDamage(dmg)
	self:PlayPainSound();
	self:AddGestureSequence(self:LookupSequence("a_shared_hit_0"..math.random(1, 3)), true);

	if(self.painTolerance) then
		self.painTolerance = false;
		self:DamageChatRadius(math.min(config.Get("talk_radius"):Get(), 80), "ttalk", self.cwTextTab.warn.text, dmg);

		return;

	end

	self:DamageChatRadius(math.min(config.Get("talk_radius"):Get() * 2.5, 80), "tyell", self.cwTextTab.hostile.text, dmg);
	
	local npc = ents.Create("npc_bgt_player");
	npc:SetPos(self:GetPos());
	npc:SetAngles(self:GetAngles());
	npc:Spawn();
	npc:SetNWString("head", self:GetNWString("head"));
	npc:SetNWString("clothes", self:GetModel());
	npc:SetNWString("weaponClass", self.cwWeapon);

	local cwCash = self.cwCash;
	local cwStock = self.cwStock;
	local cwBuyRate = self.cwBuyRate;
	local cwFactions = self.cwFactions;
	local cwSubFactions = self.cwSubFactions;
	local cwBuyTab = self.cwBuyTab;
	local cwSellTab = self.cwSellTab;
	local cwTextTab = self.cwTextTab;
	local cwPriceScale = self.cwPriceScale;
	local cwBuyInShipments = self.cwBuyInShipments;
	local cwAnimation = self.cwAnimation;
	local cwFlags = self.cwFlags;
	local cwBeliefs = self.cwBeliefs;
	local cwWeapon = self.cwWeapon;
	local head = self:GetNWString("head");
	local pos = self:GetPos();
	local model = self:GetModel();
	local ang = self:GetAngles();
	local name = self:GetNetworkedString("Name");
	local physDesc = self:GetNetworkedString("PhysDesc");

	self:Remove();
	
	local respawnTime = 10;

	local entIndex = self:EntIndex();
	timer.Create("RespawnSalesmanCheck.."..entIndex, respawnTime - 1, 0, function()
		if(IsValid(npc)) then
			local newTime = math.min(respawnTime / 3, 180);
			timer.Adjust("RespawnSalesman."..entIndex, newTime);
			timer.Adjust("RespawnSalesmanCheck.."..entIndex, newTime - 1);

			return;

		end

		timer.Remove("RespawnSalesmanCheck.."..entIndex);
	
	end);

	timer.Create("RespawnSalesman."..entIndex, respawnTime, 1, function()
		timer.Remove("RespawnSalesman."..entIndex);

		local salesman = ents.Create("cw_salesman");

		salesman:SetPos(pos);
		salesman:SetModel(model);
		salesman:SetAngles(ang);
		salesman:Spawn();

		if head then
			salesman:SetNWString("head", head);
		end

		salesman.cwCash = cwCash;
		salesman.cwStock = cwStock;
		--salesman.cwClasses = v.classes;
		salesman.cwBuyRate = cwBuyRate;
		salesman.cwFactions = cwFactions;
		salesman.cwSubfactions = cwSubFactions;
		salesman.cwBuyTab = cwBuyTab;
		salesman.cwSellTab = cwSellTab;
		salesman.cwTextTab = cwTextTab;
		salesman.cwPriceScale = cwPriceScale;
		salesman.cwBuyInShipments = cwBuyInShipments;
		salesman.cwAnimation = cwAnimation;
		salesman.cwFlags = cwFlags;
		salesman.cwBeliefs = cwBeliefs;

		salesman.cwWeapon = cwWeapon or "begotten_1h_ironarmingsword";

		salesman:SetupSalesman(name, physDesc, cwAnimation, false);

		Clockwork.entity:MakeSafe(salesman, true, true);
	
	end);

end