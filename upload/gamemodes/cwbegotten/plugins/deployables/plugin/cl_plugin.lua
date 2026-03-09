cwDeployables.deploying = cwDeployables.deploying or nil;

net.Receive("cwStartDeploying", function()
    local ply = net.ReadEntity();
    if not ply:IsValid() then return; end

    cwDeployables.deploying = net.ReadTable();
    cwDeployables:StartPlace(net.ReadString(), net.ReadString());

end);

cwDeployables.validColor = Color(0.98, 0.98, 0.36);
cwDeployables.invalidColor = Color(0.5, 0.5, 0.5);

local function createHolo(entity, model)
    local holo = ClientsideModel(model)
    local holoangles = Angle(0, Clockwork.Client:EyeAngles().y - 180, 0)
    holo:SetRenderMode(RENDERMODE_TRANSCOLOR)
    holo:DrawShadow(false)
    holo:SetColor(cwDeployables.validColor)
    holo:SetNoDraw(true)
    holo.isHolo = true
    holo:Spawn()
    holo:SetAngles(holoangles)
    Clockwork.Client.HoloModel = holo
    Clockwork.Client.HoloModel.Entity = entity
    cwDeployables.targetAngles = 0;
    cwDeployables.offset = 0;
    cwDeployables.deploying.direction = cwDeployables.dir.none;
end

local function removeHolo()
    cwDeployables.deploying = nil;
    cwDeployables.targetAngles = nil;

    if IsValid(Clockwork.Client.HoloModel) then
        Clockwork.Client.HoloModel:Remove()
        Clockwork.Client.HoloModel = nil
    end

    net.Start("cwStopDeploying");
    net.SendToServer();

end

function cwDeployables:SetModel(model)
    if(Clockwork.Client.HoloModel:GetModel() != model) then
        Clockwork.Client.HoloModel:SetModel(model);

    end

end

function cwDeployables:HandleSnap(tr)
    local otherPos = false;

    for _, v in pairs(ents.FindByClass("cw_barricade")) do
        local obbMins = v:OBBMins();
        local obbMaxs = v:OBBMaxs();

        local leftSideOffset = {
            Vector(40, 15, 0),
            Vector(40, 80, 0),

        };

        local offsetMinsL = obbMins + leftSideOffset[1];
        local offsetMaxsL = obbMaxs - leftSideOffset[2];

        local hitLeft = tr.HitPos:WithinAABox(v:LocalToWorld((obbMins + leftSideOffset[1])), v:LocalToWorld((obbMaxs - leftSideOffset[2])));

        local rightSideOffset = {
            Vector(40, -15, 0),
            Vector(40, -80, 0),

        };

        local offsetMinsR = obbMins + rightSideOffset[1];
        local offsetMaxsR = obbMaxs - rightSideOffset[2];

        local hitRight = tr.HitPos:WithinAABox(v:LocalToWorld((obbMins + rightSideOffset[1])), v:LocalToWorld((obbMaxs - rightSideOffset[2])));

        if(hitLeft) then
            self.deploying.direction = self.dir.left;

            self:SetModel(self.deploying.leftModel);

            otherPos = v:LocalToWorld(LerpVector(0.5, offsetMinsL, Vector(offsetMaxsL.x, offsetMaxsL.y, offsetMinsL.z)));
            otherPos.z = v:GetPos().z;

            return otherPos;

        elseif(hitRight) then
            self.deploying.direction = self.dir.right;

            self:SetModel(self.deploying.rightModel);

            otherPos = v:LocalToWorld(LerpVector(0.5, offsetMinsR, Vector(offsetMaxsR.x, offsetMaxsR.y, offsetMinsR.z)));
            otherPos.z = v:GetPos().z;

            return otherPos;

        else
            self.deploying.direction = self.dir.none;

            self:SetModel(self.deploying.model);

        end

    end

end

function cwDeployables:Think()
    if(!IsValid(Clockwork.Client.HoloModel)) then return; end
    if(!self.deploying) then return; end

    local tr = Clockwork.Client:GetEyeTrace();
    local otherPos = false;

    if(self.deploying.leftModel and self.deploying.rightModel) then
        if(self.deploying.dirOverride == self.dir.left) then self:SetModel(self.deploying.leftModel);
        elseif(self.deploying.dirOverride == self.dir.right) then self:SetModel(self.deploying.rightModel);
        else otherPos = self:HandleSnap(tr);
        end

    end

    Clockwork.Client.HoloModel:SetPos(self.deploying.posOverride and self.deploying.posOverride or (otherPos and otherPos or tr.HitPos));
    Clockwork.Client.HoloModel:SetAngles(self.deploying.angleOverride and self.deploying.angleOverride or Angle(0, Clockwork.Client:EyeAngles().y - 180 + self.targetAngles, 0));
    Clockwork.Client.HoloModel:SetColor(((Clockwork.Client.HoloModel:GetPos():DistToSqr(self.deploying.pos) > self.maxDistance) or (IsValid(tr.Entity) and (tr.Entity != game.GetWorld() and tr.Entity:GetClass() != self.deploying.entity))) and self.invalidColor or self.validColor);
    Clockwork.Client.HoloModel:SetMaterial("models/shiny");

end

local scrW, scrH = ScrW(), ScrH();
local textX, textY = scrW*.5, scrH*.8;
local color_white = Color(255,255,255);
local color_black = Color(0,0,0);
local fontHeight = draw.GetFontHeight("schema_IntroTextSmall") + 4;
function cwDeployables:HUDPaint()
    if(!IsValid(Clockwork.Client.HoloModel)) then return; end
    if(!self.deploying) then return; end
    if(self.deploying.building) then return; end

    draw.SimpleTextOutlined((input.LookupBinding("+attack").." / "..input.LookupBinding("+attack2").." - Rotate"), "schema_IntroTextSmall", textX, textY, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black);
    draw.SimpleTextOutlined((string.upper(input.LookupBinding("+use")).." - Deploy"), "schema_IntroTextSmall", textX, textY+fontHeight, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black);
    draw.SimpleTextOutlined((string.upper(input.LookupBinding("+reload")).." - Cancel"), "schema_IntroTextSmall", textX, textY+(fontHeight*2), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black);

end

function cwDeployables:FinishPlace()
    net.Start("cwFinishPlace");
        net.WriteVector(Clockwork.Client.HoloModel:GetPos());
        net.WriteAngle(Angle(0, Clockwork.Client:EyeAngles().y - 180 + self.targetAngles, 0));
        net.WriteUInt(self.deploying.direction, 2);
    net.SendToServer();

end

local zAxis = Vector(0, 0, 1);
local speed = 1;

function cwDeployables:CreateMove(cmd)
    local holo = Clockwork.Client.HoloModel;
    if(!IsValid(holo)) then return; end
    if(!self.deploying) then return; end

    if(self.deploying.building) then
        cmd:ClearMovement();
        cmd:ClearButtons();
        cmd:SetMouseX(0);
        cmd:SetMouseY(0);

        return;
    
    end

    if(input.WasKeyPressed(input.GetKeyCode(input.LookupBinding("+reload")))) then
        removeHolo();
        return;

    end

    if(input.WasKeyPressed(input.GetKeyCode(input.LookupBinding("+use")))) then
        self:FinishPlace();
        --removeHolo();
        return;

    end

    if(cmd:KeyDown(IN_ATTACK)) then
        self.targetAngles = self.targetAngles + speed;

    elseif(cmd:KeyDown(IN_ATTACK2)) then
        self.targetAngles = self.targetAngles - speed;

    end

end

function cwDeployables:ClockworkAdjustMouseSensitivityTable(sensitivity)
    if(self.deploying and self.deploying.building) then sensitivity[1] = 0; end

end

function cwDeployables:StartPlace(entity, model)
    createHolo(entity, model)
    --input.SelectWeapon("begotten_fists")
    --if Clockwork.Client:GetWeaponRaised(LocalPlayer()) then Clockwork.Client:ToggleWeaponRaised() end
end

net.Receive("cwStartingDeployment", function()
    cwDeployables.deploying.building = true;
    cwDeployables.deploying.posOverride = net.ReadVector();
    cwDeployables.deploying.angleOverride = net.ReadAngle();
    cwDeployables.deploying.dirOverride = net.ReadUInt(2);

end);

net.Receive("cwStopDeploying", function()
    removeHolo();

end);

function cwDeployables:PlayerDrawWeaponSelect()
    return !self.deploying;

end

function cwDeployables:PostDrawTranslucentRenderables()
    if(!IsValid(Clockwork.Client.HoloModel)) then return; end

    render.OverrideColorWriteEnable(true, false);

    Clockwork.Client.HoloModel:DrawModel();

    render.OverrideColorWriteEnable(false, false);

    local tr = Clockwork.Client:GetEyeTrace();
    local color = ((Clockwork.Client.HoloModel:GetPos():DistToSqr(self.deploying.pos) > self.maxDistance) or (IsValid(tr.Entity) and (tr.Entity != game.GetWorld() and tr.Entity:GetClass() != self.deploying.entity))) and self.invalidColor or self.validColor;
    render.SetColorModulation(color.r, color.g, color.b);
    render.SetBlend(0.1);
    render.SuppressEngineLighting(true);

    Clockwork.Client.HoloModel:DrawModel();

    render.SetBlend(1);
    render.SuppressEngineLighting(false);

end