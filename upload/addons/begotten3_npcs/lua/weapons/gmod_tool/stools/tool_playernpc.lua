TOOL.Category = "Begotten";
TOOL.Name = "Summon NPC";

TOOL.ClientConVar["npc"] = "npc_bgt_another";
TOOL.ClientConVar["summonEffect"] = "1";
TOOL.ClientConVar["spawnKit"] = "base";

function TOOL:RebuildCPanel()
    local panel = controlpanel.Get("tool_playernpc");

    panel:Clear();
    self.BuildCPanel(panel);

end

local convar = "tool_playernpc_";
TOOL.BuildCPanel = function(panel)
    local tool = Clockwork.Client:GetTool("tool_playernpc");

    local scrollPanel = vgui.Create("DScrollPanel");
    scrollPanel:SetTall(392);
    panel.npcEntry = scrollPanel:Add("DIconLayout");
    panel.npcEntry:Dock(FILL);
    panel.npcEntry:SetSpaceX(4);
    panel.npcEntry:SetSpaceY(4);

    for _, v in pairs(scripted_ents.GetList()) do
        local ent = v.t;
        if(ent.Category != "Begotten DRG") then continue; end

        local p = panel.npcEntry:Add("Panel");
        p:SetSize(64, 80);

        local icon = p:Add("ModelImage");
        icon:SetSize(64, 64);
        icon:Dock(TOP);
        icon:SetModel(ent.Models and ent.Models[math.random(#ent.Models)] or "models/error.mdl");

        local text = p:Add("DPanel");
        text:SetSize(64, 16);
        text:Dock(BOTTOM);
        function text:Paint(w, h)
            draw.SimpleTextOutlined(ent.PrintName, "DermaDefault", w*0.5, h*0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black);

        end

        local button = p:Add("DButton");
        button:SetPos(0, 0);
        button:SetSize(64, 80);
        button:SetPaintBackground(false);
        button:SetText("");
        function button:Paint(w, h)
            if(tool:GetClientInfo("npc") != ent.ClassName) then return; end

            surface.SetDrawColor(255, 255, 255);
            surface.DrawOutlinedRect(0, 0, w, h);

        end
        function button:DoClick()
            GetConVar(convar.."npc"):SetString(ent.ClassName);

            if(ent.ClassName != "npc_bgt_player") then
                if(IsValid(panel.listView)) then
                    panel.listView:Remove();
    
                end
    
                return;
            
            end
    
            if(IsValid(panel.listView)) then return; end
    
            local npc = scripted_ents.GetStored(ent.ClassName).t;
            panel.listView = vgui.Create("DListView");
            panel.listView:SetTall(192);
            panel.listView:AddColumn("Name");
            panel.listView:AddColumn("HP");
            panel.listView:AddColumn("Aggro.");
            panel.listView:AddColumn("Ex. Armor");
    
            for i, v in SortedPairs(npc.SpawnKits) do
                local line = panel.listView:AddLine(i, v.hp[1].."-"..v.hp[2], v.aggressiveness[1].."-"..v.aggressiveness[2], v.extraArmor[1].."-"..v.extraArmor[2]);
                function line:OnSelect()
                    GetConVar(convar.."spawnKit"):SetString(i);
    
                end
    
            end

            local savedData = util.JSONToTable(file.Read("b3/playerkits.json", "DATA") or "") or {};
            for i, v in SortedPairs(savedData) do
                local line = panel.listView:AddLine(i, v.hp[1].."-"..v.hp[2], v.aggressiveness[1].."-"..v.aggressiveness[2], v.extraArmor[1].."-"..v.extraArmor[2]);
                function line:OnSelect()
                    GetConVar(convar.."spawnKit"):SetString(i);
    
                end
            
            end
    
            panel:AddItem(panel.listView);

        end

    end

    panel:AddItem(scrollPanel);

    local summonEffect = panel:CheckBox("Should play the summon effect", convar.."summonEffect");
	
end

local function HandleSpawn(self, tr, spawnKit)
    local destination = tr.HitPos;

    if(!self:GetClientBool("summonEffect")) then
        local class = self:GetClientInfo("npc");
        local npc = ents.Create(class);

        if IsValid(npc) then
            npc:SetPos(destination + Vector(0, 0, 16));
            npc:Spawn();
            npc:Activate();

            if(class == "npc_bgt_player") then
                npc:Kit(self:GetClientInfo("spawnKit"));

            end

            if IsValid(player) then
                undo.Create("Summoned "..(npc.PrintName or npc:GetClass()))
                undo.SetPlayer(player)
                undo.AddEntity(npc)
                undo.Finish()
            end
        end

        return;

    end

    local spawnDelay = math.Rand(1, 2);

    sound.Play("begotten/npc/tele2_fadeout2.ogg", destination, 80, math.random(95, 105));

    timer.Simple(spawnDelay, function()
        ParticleEffect("teleport_fx", destination, Angle(0,0,0));
        sound.Play("misc/summon.wav", destination, 100, 100);

        timer.Simple(0.2, function()
            local flash = ents.Create("light_dynamic")
            flash:SetKeyValue("brightness", "2")
            flash:SetKeyValue("distance", "256")
            flash:SetPos(destination + Vector(0, 0, 8));
            flash:Fire("Color", "255 100 0")
            flash:Spawn()
            flash:Activate()
            flash:Fire("TurnOn", "", 0)
            timer.Simple(0.5, function() if IsValid(flash) then flash:Remove() end end)

            util.ScreenShake(destination, 10, 100, 0.4, 1000, true);
        end);

        timer.Simple(0.75, function()
            local class = self:GetClientInfo("npc");
            local npc = ents.Create(class);
        
            if IsValid(npc) then
                npc:SetPos(destination + Vector(0, 0, 16));
                npc:Spawn();
                npc:Activate();

                if(class == "npc_bgt_player") then
                    npc:Kit(self:GetClientInfo("spawnKit"));
                
                end

                util.Decal("PentagramBurn", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal);

                if IsValid(player) then
                    undo.Create("Summoned "..(npc.PrintName or npc:GetClass()))
                    undo.SetPlayer(player)
                    undo.AddEntity(npc)
                    undo.Finish()
                end
            end
        end);
    end);

end

function TOOL:LeftClick(tr)
    if(CLIENT) then return; end

    local player = self:GetOwner();
    local spawnKit = self:GetClientInfo("spawnKit");

    local npc = scripted_ents.GetStored(ent.ClassName).t;
    if(self:GetClientInfo("class") != "npc_bgt_player" and npc.SpawnKits[spawnKit]) then
        

        return false;

    end

    player.wantingSpawnKit = true;

    net.Start("cwSendSpawnKit");
        net.WriteString(spawnKit);
    net.Send(player);

	return false;

end

if(CLIENT) then
    language.Add("tool.tool_playernpc.name", "Summon NPC");
    language.Add("tool.tool_playernpc.desc", "");
    language.Add("tool.tool_playernpc.0", "Change settings in spawn menu");

    controlpanel.Get( "tool_playernpc" ):ClearControls();
    Clockwork.Client:GetTool("tool_playernpc").BuildCPanel(controlpanel.Get("tool_playernpc"));

end