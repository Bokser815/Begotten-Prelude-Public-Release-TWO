TOOL.Category = "Begotten";
TOOL.Name = "Playerkit Creator";

function TOOL:RebuildCPanel()
    local panel = controlpanel.Get("tool_playercreator");

    panel:Clear();
    self.BuildCPanel(panel);

end

local function Complain(text)
    Clockwork.kernel:AddCinematicText(text, Color(255, 255, 255, 255), 32, 6, Clockwork.option:GetFont("menu_text_tiny"), true);

end

local function TextPrompt(panel, prompt, key)
    local subPanel = panel:Add("Panel");
    subPanel:SetTall(20);
    subPanel:Dock(TOP);
    subPanel:DockPadding(4, 0, 4, 4);

    local label = subPanel:Add("DLabel");
    label:SetWide(192);
    label:SetText(prompt);
    label:Dock(LEFT);

    subPanel.entry = subPanel:Add("DTextEntry");
    subPanel.entry:SetWide(164);
    subPanel.entry:Dock(RIGHT);

    return subPanel;

end

local function MinMaxPrompt(panel, prompt, key)
    local subPanel = panel:Add("Panel");
    subPanel:SetTall(20);
    subPanel:Dock(TOP);
    subPanel:DockPadding(4, 0, 4, 4);

    local label = subPanel:Add("DLabel");
    label:SetWide(192);
    label:SetText(prompt);
    label:Dock(LEFT);

    subPanel.entryMax = subPanel:Add("DTextEntry");
    subPanel.entryMax:SetWide(74);
    subPanel.entryMax:Dock(RIGHT);

    local label = subPanel:Add("DLabel");
    label:SetWide(16);
    label:SetText("  -");
    label:Dock(RIGHT);

    subPanel.entryMin = subPanel:Add("DTextEntry");
    subPanel.entryMin:SetWide(74);
    subPanel.entryMin:Dock(RIGHT);

    subPanel.table = {};

    return subPanel;

end

local function ListPrompt(panel, prompt, key, needsModel, placeholder)
    local subPanel = panel:Add("DPanel");
    subPanel:SetTall(316);
    subPanel:Dock(TOP);
    subPanel:DockPadding(4, 0, 4, 0);
    function subPanel:Paint(w, h)
        surface.SetDrawColor(15,15,15);
        --surface.DrawRect(0,0,w,h);

    end

    local label = subPanel:Add("DPanel");
    label:SetWide(192);
    label:SetText(prompt);
    label:Dock(TOP);
    function label:Paint(w, h)
        draw.SimpleText(prompt, "DermaDefault", w * 0.5, h * 0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);

    end
    label:SetTooltip("Click on an entry to remove it.");

    local subSubPanel = subPanel:Add("DPanel");
    subSubPanel:SetTall(key == "drops" and 40 or 20);
    subSubPanel:Dock(TOP);

    if(key == "drops") then
        local holder = subSubPanel:Add("DPanel");
        holder:SetWide(186);
        holder:Dock(LEFT);

        local top = holder:Add("Panel");
        top:Dock(TOP)
        top:SetTall(20);

        local bottom = holder:Add("Panel");
        bottom:Dock(BOTTOM)
        bottom:SetTall(20);

        subPanel.entry = top:Add("DTextEntry");
        subPanel.entry:Dock(LEFT);
        subPanel.entry:SetWide(93);
        subPanel.entry:SetPlaceholderText("Unique ID");
        subPanel.entry:SetTooltip("Right click item and click 'Copy entity name to clipboard'.");

        local perc = top:Add("DLabel");
        perc:Dock(RIGHT);
        perc:SetWide(16);
        perc:SetText(" %");

        subPanel.chance = top:Add("DTextEntry");
        subPanel.chance:Dock(RIGHT);
        subPanel.chance:SetWide(77);
        subPanel.chance:SetPlaceholderText("Drop Chance");
        subPanel.chance:SetNumeric(true);
        subPanel.chance:SetTooltip("The percentage chance for this item to drop out of 100.");

        subPanel.amountMin = bottom:Add("DTextEntry");
        subPanel.amountMin:Dock(LEFT);
        subPanel.amountMin:SetWide(93);
        subPanel.amountMin:SetNumeric(true);
        subPanel.amountMin:SetPlaceholderText("Min. Amount");

        subPanel.amountMax = bottom:Add("DTextEntry");
        subPanel.amountMax:Dock(RIGHT);
        subPanel.amountMax:SetWide(93);
        subPanel.amountMax:SetNumeric(true);
        subPanel.amountMax:SetPlaceholderText("Max. Amount");

    else
        subPanel.entry = subSubPanel:Add("DTextEntry");
        subPanel.entry:SetWide(186);
        subPanel.entry:Dock(LEFT);
        subPanel.entry:SetPlaceholderText(placeholder or "models/error.mdl");

    end

    local add = subSubPanel:Add("DButton");
    add:SetWide(74);
    add:Dock(RIGHT);
    add:SetText("Add");
    function add:DoClick()
        if(key == "drops") then
            local entry = subPanel.entry:GetText();
            local chance = subPanel.chance:GetText();
            local amountMin = subPanel.amountMin:GetText();
            local amountMax = subPanel.amountMax:GetText();
            
            if(#entry <= 0) then Complain("Item text cannot be empty!"); return; end

            local item = Clockwork.item:FindByID(entry);
            if(!item or item.uniqueID != entry) then Complain("Item cannot be found!"); return; end
            if(#chance <= 0) then Complain("Drop Chance text cannot be empty!"); return; end
            if(#amountMin <= 0) then Complain("Min. Amount text cannot be empty!"); return; end
            if(#amountMax <= 0) then Complain("Max. Amount text cannot be empty!"); return; end

            local line = subPanel.listView:AddLine(item.uniqueID, amountMin.." - "..amountMax, chance.."%");
            line.entry = {
                id = item.uniqueID,
                amount = {tonumber(amountMin), tonumber(amountMax)},
                chance = math.Round(100/tonumber(chance)),

            };
            function line:OnSelect()
                subPanel.listView:RemoveLine(self:GetID());

            end

        else
            local text = subPanel.entry:GetText();
            if(#text <= 0) then Complain("Entry text cannot be empty!") return; end
            if(needsModel and !string.find(text, ".mdl")) then Complain("The model name is missing '.mdl'!"); return; end

            local line = subPanel.listView:AddLine(text);
            function line:OnSelect()
                subPanel.listView:RemoveLine(self:GetID());

            end

        end

    end

    local guard = subPanel:Add("Panel");
    guard:SetTall(8);
    guard:Dock(TOP);

    subPanel.listView = subPanel:Add("DListView");
    subPanel.listView:SetTall(256);
    subPanel.listView:Dock(TOP);
    if(key == "drops") then
        subPanel.listView:AddColumn("Item");
        subPanel.listView:AddColumn("Amount");
        subPanel.listView:AddColumn("Chance");

    else
        subPanel.listView:AddColumn("");

    end

    return subPanel;

end

local function AddGuard(panel, dock)
    local subPanel = panel:Add("Panel");
    subPanel:SetWide(4);
    subPanel:Dock(dock);

    return subPanel;

end

TOOL.spawnKit = {};

local convar = "tool_playercreator";
TOOL.BuildCPanel = function(panel)
    local tool = Clockwork.Client:GetTool("tool_playercreator");

    local npc = scripted_ents.GetStored("npc_bgt_player").t;
    panel.listView = vgui.Create("DListView");
    panel.listView:SetTall(192);
    panel.listView:AddColumn("Name");
    panel.listView:AddColumn("HP");
    panel.listView:AddColumn("Aggro.");
    panel.listView:AddColumn("Ex. Armor");
    
    for i, v in SortedPairs(npc.SpawnKits) do
        local line = panel.listView:AddLine(i, v.hp[1].."-"..v.hp[2], v.aggressiveness[1].."-"..v.aggressiveness[2], v.extraArmor[1].."-"..v.extraArmor[2]);
        line.spawnKit = v;
        line.spawnKitName = i;
        line.isBase = true;
       
    end

    local savedData = util.JSONToTable(file.Read("b3/playerkits.json", "DATA") or "") or {};
    for i, v in SortedPairs(savedData) do
        local line = panel.listView:AddLine(i, v.hp[1].."-"..v.hp[2], v.aggressiveness[1].."-"..v.aggressiveness[2], v.extraArmor[1].."-"..v.extraArmor[2]);
        line.spawnKit = v;
        line.spawnKitName = i;
        line.isBase = false;
       
    end
    
    panel:AddItem(panel.listView);

    panel.listButtons = vgui.Create("Panel");
    panel.listButtons:SetTall(32);
    panel.listButtons:DockPadding(4, 0, 4, 8);

    local buttonWidth = 64;

    panel.listButtons.select = panel.listButtons:Add("DButton");
    panel.listButtons.select:SetWide(buttonWidth);
    panel.listButtons.select:Dock(LEFT);
    panel.listButtons.select:SetText("Copy");
    panel.listButtons.select:SetTooltip("Copy the selected spawn kit to the prompts.");
    function panel.listButtons.select:DoClick()
        local _, line = panel.listView:GetSelectedLine();
        if(!line) then Complain("You have not selected a spawn kit!") return; end
        if(!line.spawnKit) then Complain("Could not find a valid spawn kit!"); return; end

        panel.kitEntries.name.entry:SetText(line.spawnKitName);

        panel.kitEntries.hp.entryMin:SetText(line.spawnKit.hp[1]);
        panel.kitEntries.hp.entryMax:SetText(line.spawnKit.hp[2]);

        panel.kitEntries.aggressiveness.entryMin:SetText(line.spawnKit.aggressiveness[1]);
        panel.kitEntries.aggressiveness.entryMax:SetText(line.spawnKit.aggressiveness[2]);

        panel.kitEntries.extraArmor.entryMin:SetText(line.spawnKit.extraArmor[1]);
        panel.kitEntries.extraArmor.entryMax:SetText(line.spawnKit.extraArmor[2]);

        panel.kitEntries.head.listView:Clear();
        for _, v in pairs(line.spawnKit.head) do
            local line = panel.kitEntries.head.listView:AddLine(v);
            function line:OnSelect()
                panel.kitEntries.head.listView:RemoveLine(self:GetID());
    
            end

        end

        panel.kitEntries.clothes.listView:Clear();
        for _, v in pairs(line.spawnKit.clothes) do
            local line = panel.kitEntries.clothes.listView:AddLine(v);
            function line:OnSelect()
                panel.kitEntries.clothes.listView:RemoveLine(self:GetID());
    
            end

        end

        panel.kitEntries.armor.listView:Clear();
        for _, v in pairs(line.spawnKit.armor) do
            local line = panel.kitEntries.armor.listView:AddLine(v);
            function line:OnSelect()
                panel.kitEntries.armor.listView:RemoveLine(self:GetID());
    
            end

        end

        panel.kitEntries.weapon.listView:Clear();
        for _, v in pairs(line.spawnKit.weapon) do
            local line = panel.kitEntries.weapon.listView:AddLine(v);
            function line:OnSelect()
                panel.kitEntries.weapon.listView:RemoveLine(self:GetID());
    
            end

        end

        panel.kitEntries.drops.listView:Clear();
        for _, v in pairs(line.spawnKit.drops) do
            local line = panel.kitEntries.drops.listView:AddLine(v.id, v.amount[1].." - "..v.amount[2], math.floor(100/v.chance).."%");
            line.entry = v;
            function line:OnSelect()
                panel.kitEntries.drops.listView:RemoveLine(self:GetID());
    
            end

        end

    end

    AddGuard(panel.listButtons, LEFT);

    panel.listButtons.save = panel.listButtons:Add("DButton");
    panel.listButtons.save:SetText("");
    panel.listButtons.save:SetWide(panel.listButtons.save:GetTall());
    panel.listButtons.save:Dock(RIGHT);
    panel.listButtons.save:SetTooltip("Save a spawn kit shared to you through text.");
    panel.listButtons.save.image = Material("icon16/disk.png");
    function panel.listButtons.save:PaintOver(w, h)
        surface.SetMaterial(self.image);
        surface.SetDrawColor(255, 255, 255);
        surface.DrawTexturedRect(4, 4, w-8, h-8);

    end
    function panel.listButtons.save:DoClick()
        Derma_StringRequest("BEGOTTEN", "Insert the JSON string to save.", "", function(text)
            local savedData = util.JSONToTable(text or "") or {};
            if(!savedData or !istable(savedData) or table.Count(savedData) <= 0) then Complain("Invalid spawn kit! (Unknown Error)"); return; end
            if(!savedData.name) then Complain("Invalid spawn kit! (No Name!)"); return; end
            if(!savedData.hp) then Complain("Invalid spawn kit! (No HP!)"); return; end
            if(!savedData.aggressiveness) then Complain("Invalid spawn kit! (No Agressiveness!)"); return; end
            if(!savedData.extraArmor) then Complain("Invalid spawn kit! (No Extra Armor!)"); return; end
            if(!savedData.head) then Complain("Invalid spawn kit! (No Head!)"); return; end
            if(!savedData.clothes) then Complain("Invalid spawn kit! (No Clothes!)"); return; end
            if(!savedData.helm) then Complain("Invalid spawn kit! (No Helms!)"); return; end
            if(!savedData.armor) then Complain("Invalid spawn kit! (No Armor!)"); return; end
            if(!savedData.weapon) then Complain("Invalid spawn kit! (No Weapons!)"); return; end

            local line = panel.listView:AddLine(savedData.name, savedData.hp[1].."-"..savedData.hp[2], savedData.aggressiveness[1].."-"..savedData.aggressiveness[2], savedData.extraArmor[1].."-"..savedData.extraArmor[2]);
            line.spawnKit = savedData;
            line.spawnKitName = savedData.name;
            line.isBase = false;

            local data = util.JSONToTable(file.Read("b3/playerkits.json", "DATA") or "") or {};
            data[savedData.name] = line.spawnKit;
            file.Write("b3/playerkits.json", util.TableToJSON(data));
        
        end);

    end

    AddGuard(panel.listButtons, RIGHT);

    panel.listButtons.share = panel.listButtons:Add("DButton");
    panel.listButtons.share:SetText("");
    panel.listButtons.share:SetWide(panel.listButtons.share:GetTall());
    panel.listButtons.share:Dock(RIGHT);
    panel.listButtons.share:SetTooltip("Copy the selected spawn kit as text to share.");
    panel.listButtons.share.image = Material("icon16/group.png");
    function panel.listButtons.share:PaintOver(w, h)
        surface.SetMaterial(self.image);
        surface.SetDrawColor(255, 255, 255);
        surface.DrawTexturedRect(4, 4, w-8, h-8);

    end
    function panel.listButtons.share:DoClick()
        local _, line = panel.listView:GetSelectedLine();
        if(!line) then Complain("You have not selected a spawn kit!") return; end
        if(!line.spawnKit) then Complain("Could not find a valid spawn kit!"); return; end

        line.spawnKit.name = line.spawnKitName;

        SetClipboardText(util.TableToJSON(line.spawnKit));
        Complain("Copied spawn kit to clipboard!");

    end

    AddGuard(panel.listButtons, RIGHT);

    panel.listButtons.remove = panel.listButtons:Add("DButton");
    panel.listButtons.remove:SetWide(buttonWidth);
    panel.listButtons.remove:Dock(RIGHT);
    panel.listButtons.remove:SetText("Remove");
    panel.listButtons.remove:SetTooltip("Remove the selected spawn kit from your local registry.");
    function panel.listButtons.remove:DoClick()
        local i, line = panel.listView:GetSelectedLine();
        if(!line) then Complain("You have not selected a spawn kit!") return; end
        if(!line.spawnKit) then Complain("Could not find a valid spawn kit!"); return; end
        if(line.isBase) then Complain("This spawn kit is considered default and cannot be removed!"); return; end

        panel.listView:RemoveLine(i);

        local savedData = util.JSONToTable(file.Read("b3/playerkits.json", "DATA") or "") or {};
        savedData[line.spawnKitName] = nil;
        file.Write("b3/playerkits.json", util.TableToJSON(savedData));

    end

    AddGuard(panel.listButtons, RIGHT);

    panel.listButtons.add = panel.listButtons:Add("DButton");
    panel.listButtons.add:SetWide(buttonWidth);
    panel.listButtons.add:Dock(FILL);
    panel.listButtons.add:SetText("Add");
    panel.listButtons.add:SetTooltip("Save the prompt entries as a spawn kit to your local registry.");
    function panel.listButtons.add:DoClick()
        local name = panel.kitEntries.name.entry:GetText();
        if(#name <= 0) then Complain("Name text cannot be empty!"); return; end

        for _, v in pairs(panel.listView:GetLines()) do
            if(v.spawnKitName == name) then Complain("A spawn kit with this name already exists!"); return; end

        end

        local hpMin = panel.kitEntries.hp.entryMin:GetText();
        local hpMax = panel.kitEntries.hp.entryMax:GetText();
        if(#hpMin <= 0 or #hpMax <= 0) then Complain("HP text cannot be empty!"); return; end

        tool.spawnKit.hp = {tonumber(hpMin), tonumber(hpMax)};

        local aggroMin = panel.kitEntries.aggressiveness.entryMin:GetText();
        local aggroMax = panel.kitEntries.aggressiveness.entryMax:GetText();
        if(#aggroMin <= 0 or #aggroMax <= 0) then Complain("Aggressiveness text cannot be empty!"); return; end

        tool.spawnKit.aggressiveness = {tonumber(aggroMin), tonumber(aggroMax)};

        local extraArmorMin = panel.kitEntries.extraArmor.entryMin:GetText();
        local extraArmorMax = panel.kitEntries.extraArmor.entryMax:GetText();
        if(#extraArmorMin <= 0 or #extraArmorMax <= 0) then Complain("Extra armor text cannot be empty!"); return; end

        tool.spawnKit.extraArmor = {tonumber(extraArmorMin), tonumber(extraArmorMax)};

        local heads = panel.kitEntries.head.listView:GetLines();
        PrintTable(heads);
        if(#heads <= 0) then Complain("Heads cannot be empty! Use 'glaze' or 'gore' for default heads."); return; end

        tool.spawnKit.head = {};
        for _, v in pairs(heads) do
            table.insert(tool.spawnKit.head, v:GetValue(1));

        end

        local clothes = panel.kitEntries.clothes.listView:GetLines();
        tool.spawnKit.clothes = {};
        if(#clothes <= 0) then
            table.insert(tool.spawnKit.clothes, nil);

        else
            for _, v in pairs(clothes) do
                table.insert(tool.spawnKit.clothes, v:GetValue(1));

            end

        end

        local armor = panel.kitEntries.armor.listView:GetLines();
        tool.spawnKit.armor = {};
        if(#armor <= 0) then
            table.insert(tool.spawnKit.armor, nil);
            
        else
            for _, v in pairs(armor) do
                table.insert(tool.spawnKit.armor, v:GetValue(1));

            end

        end

        local weapon = panel.kitEntries.weapon.listView:GetLines();
        tool.spawnKit.weapon = {};
        if(#weapon <= 0) then
            table.insert(tool.spawnKit.weapon, nil);
            
        else
            for _, v in pairs(weapon) do
                table.insert(tool.spawnKit.weapon, v:GetValue(1));

            end

        end

        local drops = panel.kitEntries.drops.listView:GetLines();
        if(#drops <= 0) then Complain("Heads cannot be empty! Use 'glaze' or 'gore' for default heads."); return; end
        tool.spawnKit.drops = {};

        for _, v in pairs(drops) do
            table.insert(tool.spawnKit.drops, v.entry);

        end

        local line = panel.listView:AddLine(name, tool.spawnKit.hp[1].."-"..tool.spawnKit.hp[2], tool.spawnKit.aggressiveness[1].."-"..tool.spawnKit.aggressiveness[2], tool.spawnKit.extraArmor[1].."-"..tool.spawnKit.extraArmor[2]);
        line.spawnKit = table.Copy(tool.spawnKit);
        line.spawnKitName = name;
        line.isBase = false;

        tool.spawnKit = {};

        local savedData = util.JSONToTable(file.Read("b3/playerkits.json", "DATA") or "") or {};
        savedData[name] = line.spawnKit;
        file.Write("b3/playerkits.json", util.TableToJSON(savedData));

    end
    
    panel:AddItem(panel.listButtons);

    panel.kitEntries = vgui.Create("Panel");
    panel.kitEntries:SetTall(2000);
    panel.listButtons:DockPadding(4, 0, 4, 8);

    panel.kitEntries.name = TextPrompt(panel.kitEntries, "Name", "name");
    panel.kitEntries.hp = MinMaxPrompt(panel.kitEntries, "HP", "hp");
    panel.kitEntries.aggressiveness = MinMaxPrompt(panel.kitEntries, "Aggressiveness", "aggressiveness");
    panel.kitEntries.extraArmor = MinMaxPrompt(panel.kitEntries, "Extra Armor", "extraArmor");
    
    panel.kitEntries.head = ListPrompt(panel.kitEntries, "Heads", "head", true);
    panel.kitEntries.clothes = ListPrompt(panel.kitEntries, "Clothes", "clothes", true);
    panel.kitEntries.helm = ListPrompt(panel.kitEntries, "Helms", "helm", false, "gatekeeper_helmet");
    panel.kitEntries.armor = ListPrompt(panel.kitEntries, "Armor", "armor", false, "gatekeeper_plate");
    panel.kitEntries.weapon = ListPrompt(panel.kitEntries, "Weapons", "weapon", false, "begotten_1h_glazicus");
    panel.kitEntries.drops = ListPrompt(panel.kitEntries, "Drops", "drops");

    panel:AddItem(panel.kitEntries);
	
end

function TOOL:LeftClick(tr)
	return false;

end

if(CLIENT) then
    language.Add("tool.tool_playercreator.name", "");
    language.Add("tool.tool_playercreator.desc", "");
    language.Add("tool.tool_playercreator.0", "");

    controlpanel.Get( "tool_playercreator" ):ClearControls();
    Clockwork.Client:GetTool("tool_playercreator").BuildCPanel(controlpanel.Get("tool_playercreator"));

end