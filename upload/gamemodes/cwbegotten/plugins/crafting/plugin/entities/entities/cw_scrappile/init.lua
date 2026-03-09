--[[
	Begotten III: Jesus Wept
	By: DETrooper, cash wednesday, gabs, alyousha35

	Other credits: kurozael, Alex Grist, Mr. Meow, zigbomb
--]]

Clockwork.kernel:IncludePrefixed("shared.lua");

AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");

local cwRecipes = cwRecipes;

local proptypes = {
	"models/props_debris/concrete_debris128pile001a.mdl",
	"models/props_debris/concrete_debris128pile001b.mdl",
	"models/props_debris/concrete_floorpile01a.mdl",
}

-- Called when the entity initializes.
function ENT:Initialize()
	self:SetModel(table.Random(proptypes));
	self:SetMoveType(MOVETYPE_VPHYSICS);
	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetUseType(SIMPLE_USE);
	self:SetSolid(SOLID_VPHYSICS);
	self.BreakSounds = {"physics/metal/metal_sheet_impact_hard7.wav", "physics/metal/metal_sheet_impact_hard8.wav", "physics/metal/metal_sheet_impact_hard6.wav"};
	self:SetMaterial("models/props/de_nuke/pipeset_metal")
	local physicsObject = self:GetPhysicsObject();
	
	if (IsValid(physicsObject)) then
		physicsObject:Wake();
		physicsObject:EnableMotion(false);
	end;
end;

-- Called when the entity's transmit state should be updated.
function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS;
end;

function ENT:Use(activator, caller)

end;

function ENT:OnTakeDamage(damageInfo)
	local player = damageInfo:GetAttacker();
	
	if IsValid(player) and player:IsPlayer() then
		if damageInfo:IsDamageType(128) and damageInfo:GetDamage() >= 15 then
			local activeWeapon = player:GetActiveWeapon();
			
			self:EmitSound(self.BreakSounds[math.random(1, #self.BreakSounds)]);
			
			if !self.oreLeft then
				self.oreLeft = math.random(cwRecipes.minPileItems, cwRecipes.maxPileItems);
			end
			
			if !self.strikesRequired then
				self.strikesRequired = math.random(5, 10);
			end
			
			self.strikesRequired = self.strikesRequired - 1;
			
			if cwCharacterNeeds and player.HandleNeed then
				player:HandleNeed("thirst", 0.85);
				player:HandleNeed("sleep", 0.35);
			end
			
			if self.strikesRequired <= 0 then
				local entPos = self:GetPos();
				local itemName = "scrap";
				
				if math.random(1, 60) == 1 then
					itemName = "road_tire";

					Clockwork.chatBox:AddInTargetRadius(player, "it", "As you strike the scrap, you unearth a tire.", player:GetPos(), config.Get("talk_radius"):Get() * 2);
				elseif math.random(1, 125) == 1 then
					itemName = "scrap_engine_block";

					Clockwork.chatBox:AddInTargetRadius(player, "it", "As you strike the scrap, you unearth a fucked engine block.", player:GetPos(), config.Get("talk_radius"):Get() * 2);
				elseif math.random(1, 250) == 1 then
					itemName = "tech";
					
					Clockwork.chatBox:AddInTargetRadius(player, "it", "As you strike the scrap, you notice a valuable intact piece of technology.", player:GetPos(), config.Get("talk_radius"):Get() * 2);
				elseif math.random(1, 666) == 1 then
					itemName = "shield3";
					
					Clockwork.chatBox:AddInTargetRadius(player, "it", "As you strike the scrap, a prize is found! A Shield!.", player:GetPos(), config.Get("talk_radius"):Get() * 2);
					
				end
				
				local itemTable = item.CreateInstance(itemName)

				if (itemTable) then
					itemTable:SetCondition(math.random(25, 100), true);
				
					local item = Clockwork.entity:CreateItem(nil, itemTable, Vector(entPos.x, entPos.y, entPos.z + 40));
					
					if IsValid(item) then
						item:Spawn();
						item:EmitSound("physics/metal/metal_sheet_impact_hard2.wav");
						
						Clockwork.entity:Decay(item, 300);
						item.lifeTime = CurTime() + 300; -- so the item save plugin doesn't save it
					end
				end
				
				if cwBeliefs and player.HandleXP then
					local playerFaction = player:GetFaction();
					
					if playerFaction == "Gatekeeper" or playerFaction == "Goreic Warrior" then
						player:HandleXP(15);
					else
						player:HandleXP(10);
					end

					if player:HasDisease("shackled") then
						local scrapperCount = 0;
						for k, v in pairs(ents.FindInSphere(player:GetPos(), 666)) do
							if v:IsPlayer() and v:Alive() and v:GetFaction() == "Piston's Scrappers" then
								scrapperCount = scrapperCount + 1;
							end
						end

						for k,v in pairs(ents.FindInSphere(player:GetPos(), 666)) do
							if scrapperCount > 0 then
								if v:IsPlayer() and v:GetFaction() == "Piston's Scrappers" then
									v:HandleXP(5/scrapperCount);
								end
							end
							
						end
					end
				end
				
				self.oreLeft = self.oreLeft - 1;
				self.strikesRequired = math.random(5, 10);
			end
			
			if !activeWeapon.isPickaxe then
				local weaponItemTable = item.GetByWeapon(activeWeapon);
				
				if weaponItemTable then
					if cwBeliefs then
						if !player:HasBelief("ingenuity_finisher") then
							if player:HasBelief("scour_the_rust") then
								weaponItemTable:TakeCondition(0.25);
							else
								weaponItemTable:TakeCondition(0.6);
							end
						end
					else
						weaponItemTable:TakeCondition(0.6);
					end
				end
			end
			
			if self.oreLeft <= 0 then
				Clockwork.chatBox:AddInTargetRadius(player, "it", "The ore pile is reduced to nothing, its resources fully extracted.", player:GetPos(), config.Get("talk_radius"):Get() * 2);
				
				self:Remove();
			end
		end
	end
end

function ENT:OnRemove()
	local piles = cwRecipes.Piles;
	
	for i = 1, #piles do
		local pileTable = piles[i];
		
		for k, v in pairs(cwRecipes.pileLocations) do
			for j = 1, #v do
				if v[j].occupier == self:EntIndex() then
					v[j].occupier = nil;
					
					table.remove(cwRecipes.Piles, i);
					
					return;
				end
			end
		end
	end
end;