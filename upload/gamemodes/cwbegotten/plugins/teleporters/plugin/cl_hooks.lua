Clockwork.ConVars.cwDebugTeleporters = Clockwork.ConVars.cwDebugTeleporters or Clockwork.kernel:CreateClientConVar("cwDebugTeleporters", 0, true, true);
Clockwork.setting:AddCheckBox("Zones", "Show teleporter debug information.", "cwDebugTeleporters", "Click to enable debug information about teleporter zones.", function()
    return Clockwork.player:IsAdmin(Clockwork.Client);
end);

net.Receive("cwBeginTeleport", function()
    Clockwork.Client:SetCustomCollisionCheck(true);
    Clockwork.Client.zoneTeleportingNoCollide = true;
    Clockwork.Client:CollisionRulesChanged();

end);

net.Receive("cwEndTeleport", function()
    Clockwork.Client:SetCustomCollisionCheck(false);
    Clockwork.Client.zoneTeleportingNoCollide = false;
    Clockwork.Client:CollisionRulesChanged();

end);

function cwTeleporters:PrePlayerDraw(player)
    --if(player:GetSharedVar("zoneTeleporting")) then return true; end

end

function cwTeleporters:FuckingModel(player)
    local clothes = player:GetClothesEquipped();
	local model;

	if clothes and clothes.group then
		if clothes.genderless then
			model = "models/begotten/"..clothes.group..".mdl";
		else
			model = "models/begotten/"..clothes.group.."_"..string.lower(player:GetGender())..".mdl"
		end
	elseif(!clothes) then
		local faction = player:GetFaction();
		
		if faction then
			if faction == "Children of Satan" then
				faction = player:GetNetVar("kinisgerOverride") or faction;
			end
			
			local factionTable = Clockwork.faction:FindByID(faction);
			
			if factionTable then
				local subfaction = player:GetNetVar("subfaction");
				
				if faction == "Children of Satan" then
					subfaction = player:GetNetVar("kinisgerOverrideSubfaction") or subfaction;
				end

				if subfaction and factionTable.subfactions then
					for i, v in ipairs(factionTable.subfactions) do
						if v.name == subfaction and v.models then
							model = v.models[string.lower(player:GetGender())].clothes;
						
							break;
						end
					end
				end
				
				if !model then
					model = factionTable.models[string.lower(player:GetGender())].clothes;
				end
			end
		end
	end

    return model;

end

cwTeleporters.players = --[[cwTeleporters.players or ]]{};

CreateMaterial( "colortexshp", "VertexLitGeneric", {
    ["$basetexture"] = "color/white",
    ["$model"] = 1,
    ["$translucent"] = 1,
    ["$vertexalpha"] = 1,
    ["$vertexcolor"] = 1
} )

function cwTeleporters:CreateMaterial(v)
    local material = Material(v);
    
    CreateMaterial(v.."__teleporter", material:GetShader(), {
        ["$basetexture"] = material:GetString("$basetexture"),
        ["$bumpmap"] = material:GetString("$bumpmap"),
        ["$ssbump"] = material:GetString("$ssbump"),
        ["$selfillum"] = material:GetString("$selfillum"),
        ["$lightwarptexture"] = material:GetString("$lightwarptexture"),
        ["$halflambert"] = material:GetString("$halflambert"),
        ["$ambientocclusion"] = material:GetString("$ambientocclusion"),
        ["$rimlight"] = material:GetString("$rimlight"),
        ["$receiveflashlight"] = material:GetString("$receiveflashlight"),
        ["$lightmap"] = material:GetString("$lightmap"),
        ["$reflectivity"] = material:GetString("$reflectivity"),
        ["$phong"] = material:GetString("$phong"),
        ["$envmap"] = material:GetString("$envmap"),
        ["$envmapmask"] = material:GetString("$envmapmask"),
        ["$ignorez"] = material:GetString("$ignorez"),
        ["$softwareskin"] = material:GetString("$softwareskin"),
        ["$treesway"] = material:GetString("$treesway"),
        ["$nofog"] = material:GetString("$nofog"),
        ["$basetexturetransform"] = material:GetString("$basetexturetransform"),
        ["$frame"] = material:GetString("$frame"),
        ["$basetexture2"] = material:GetString("$basetexture2"),
        ["$basetexturetransform2"] = material:GetString("$basetexturetransform2"),
        ["$frame2"] = material:GetString("$frame2"),
        ["$surfaceprop"] = material:GetString("$surfaceprop"),
        ["$decal"] = material:GetString("$decal"),
        ["$decalscale"] = material:GetString("$decalscale"),
        ["$modelmaterial"] = material:GetString("$modelmaterial"),
        ["$decalfadeduration"] = material:GetString("$decalfadeduration"),
        ["$decalfadetime"] = material:GetString("$decalfadetime"),
        ["$decalsecondpass"] = material:GetString("$decalsecondpass"),
        ["$fogscale"] = material:GetString("$fogscale"),
        ["$splatter"] = material:GetString("$splatter"),
        ["$detail"] = material:GetString("$detail"),
        ["$detailtexturetransform"] = material:GetString("$detailtexturetransform"),
        ["$detailscale"] = material:GetString("$detailscale"),
        ["$detailblendfactor"] = material:GetString("$detailblendfactor"),
        ["$detailblendmode"] = material:GetString("$detailblendmode"),
        ["$detailtint"] = material:GetString("$detailtint"),
        ["$detailframe"] = material:GetString("$detailframe"),
        ["$detail_alpha_mask_base_texture"] = material:GetString("$detail_alpha_mask_base_texture"),
        ["$detail2"] = material:GetString("$detail2"),
        ["$detailscale2"] = material:GetString("$detailscale2"),
        ["$detailblendfactor2"] = material:GetString("$detailblendfactor2"),
        ["$detailframe2"] = material:GetString("$detailframe2"),
        ["$detailtine2"] = material:GetString("$detailtine2"),
        ["$blendmodulatetexture"] = material:GetString("$blendmodulatetexture"),
        ["$nocull"] = material:GetString("$nocull"),
        ["$iris"] = material:GetString("$iris"),
        ["$irisframe"] = material:GetString("$irisframe"),
        ["$corneatexture"] = material:GetString("$corneatexture"),
        ["$corneabumpstrength"] = material:GetString("$corneabumpstrength"),
        ["$parallaxstrength"] = material:GetString("$parallaxstrength"),
        ["$dilation"] = material:GetString("$dilation"),
        ["$model"] = 1,
        --[[["$translucent"] = 1,
        ["$vertexalpha"] = 1,
        ["$vertexcolor"] = 1]]
    });

end

function cwTeleporters:DrawPlayers()
    for _, player in _player.Iterator() do
        local entIndex = player:EntIndex()

        if(!player:GetSharedVar("zoneTeleporting")) then
            if(self.players[entIndex]) then
                self.players[entIndex].head:Remove();
                self.players[entIndex].clothes:Remove();
                --for _, v in pairs(self.players[entIndex].attachments) do v:Remove(); end
                self.players[entIndex] = nil;

            end
            
            continue;
        
        end

        if(!self.players[entIndex]) then
            self.players[entIndex] = {};
            self.players[entIndex].head = ClientsideModel(player:GetModel());
            self.players[entIndex].clothes = ClientsideModel(self:FuckingModel(player) or "models/error.mdl");

            for i, v in pairs(self.players[entIndex].head:GetMaterials()) do
                if(string.find(v, "eyeball")) then continue; end

                self:CreateMaterial(v);

                self.players[entIndex].head:SetSubMaterial(i-1, "!"..v.."__teleporter");
                
            end

            for i, v in pairs(self.players[entIndex].clothes:GetMaterials()) do
                self:CreateMaterial(v);

                self.players[entIndex].clothes:SetSubMaterial(i-1, "!"..v.."__teleporter");
                
            end

            --self.players[entIndex].attachments = {};

        end

        self.players[entIndex].head:SetParent(player);
		self.players[entIndex].head:AddEffects(EF_BONEMERGE);
		self.players[entIndex].head:SetColor(ColorAlpha(player:GetColor(), 255));
        self.players[entIndex].head:SetBodygroup(0, player:GetBodygroup(0));
		self.players[entIndex].head:SetNoDraw(true);
        self.players[entIndex].head:SetRenderMode(RENDERMODE_TRANSCOLOR);

        self.players[entIndex].clothes:SetParent(player);
		self.players[entIndex].clothes:AddEffects(EF_BONEMERGE);
		self.players[entIndex].clothes:SetColor(ColorAlpha(player:GetColor(), 255));
		self.players[entIndex].clothes:SetNoDraw(true);
        self.players[entIndex].clothes:SetRenderMode(RENDERMODE_TRANSCOLOR);
        --self.players[entIndex].clothes:SetMaterial("!colortexshp")

        local out = player:GetSharedVar("zoneTeleportWhichWayToFade") == 1;
        local alpha = Lerp((player:GetSharedVar("zoneTeleportFade") - CurTime()) / player:GetSharedVar("zoneTeleportFadeTime"), out and 0 or 1, out and 1 or 0);

        if(alpha == 0) then return; end

        render.OverrideColorWriteEnable(true, false);
        render.OverrideAlphaWriteEnable(true, false);

        if(self.players[entIndex].head:GetModel() != "models/error.mdl") then self.players[entIndex].head:DrawModel(STUDIO_TWOPASS); end
        if(self.players[entIndex].clothes:GetModel() != "models/error.mdl") then self.players[entIndex].clothes:DrawModel(STUDIO_TWOPASS); end

        render.OverrideColorWriteEnable(false, false);
        render.OverrideAlphaWriteEnable(false, false);
        --render.OverrideBlend(true, BLEND_ONE, BLEND_ONE, BLENDFUNC_ADD, BLEND_ONE, BLEND_ONE, BLENDFUNC_ADD);

        --print(alpha)

        render.SetBlend(alpha);
        --render.SuppressEngineLighting(true);

        if(self.players[entIndex].head:GetModel() != "models/error.mdl") then self.players[entIndex].head:DrawModel(STUDIO_TWOPASS); end
        if(self.players[entIndex].clothes:GetModel() != "models/error.mdl") then self.players[entIndex].clothes:DrawModel(STUDIO_TWOPASS); end

        render.SetBlend(1);
        --render.OverrideBlend(false);
        --render.SuppressEngineLighting(false);
        
    end

end

cwTeleporters.zoneColor = Color(26, 26, 194);

function cwTeleporters:PostDrawTranslucentRenderables()
    self:DrawPlayers();

    if(!Clockwork.ConVars.cwDebugTeleporters:GetBool()) then return; end
    if(!Clockwork.player:IsAdmin(Clockwork.Client)) then return; end

    for i, v in pairs(self.zones) do
        local center = (v.enter.mins + v.enter.maxs) * 0.5;
        render.DrawWireframeBox(center, angle_zero, v.enter.mins - center, v.enter.maxs - center, self.zoneColor, true);
        
        local pos = center:ToScreen();
        cam.Start2D();
            draw.SimpleTextOutlined(i, "DermaDefault", pos.x, pos.y, self.zoneColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black);

        cam.End2D();

    end

end

function cwTeleporters:DrawOverlay()
    local player = Clockwork.Client;
    if(!IsValid(player)) then return; end
    if(!player:GetSharedVar("zoneTeleporting")) then return; end

    local out = player:GetSharedVar("zoneTeleportWhichWayToFade") == 1;
    local alpha = Lerp((player:GetSharedVar("zoneTeleportFade") - CurTime()) / player:GetSharedVar("zoneTeleportFadeTime"), out and 255 or 0, out and 0 or 255);

    surface.SetDrawColor(0, 0, 0, alpha);
    surface.DrawRect(0, 0, ScrW(), ScrH());

end

cwTeleporters.savedMoves = {};

function cwTeleporters:CreateMove(cmd)
    local player = Clockwork.Client;
    if(!IsValid(player)) then return; end

    local isEmpty = table.IsEmpty(self.savedMoves)

    local finishing = player:GetSharedVar("zoneTeleportFinishing");
    if(!player:GetSharedVar("zoneTeleporting") and !finishing) then
        if(!isEmpty) then table.Empty(self.savedMoves); end

        return;

    end

    if(isEmpty) then
        self.savedMoves.forward = cmd:GetForwardMove();
        self.savedMoves.side = cmd:GetSideMove();
        self.savedMoves.camAngle = cmd:GetViewAngles();

    end

    cmd:SetMouseX(0);
    cmd:SetMouseY(0);
    cmd:SetForwardMove(finishing and 100 or self.savedMoves.forward);
    cmd:SetSideMove(finishing and 0 or self.savedMoves.side);
    cmd:SetViewAngles(player:GetSharedVar("exitAngles") or self.savedMoves.camAngle);

end