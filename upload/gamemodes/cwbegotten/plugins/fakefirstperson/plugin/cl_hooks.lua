
cwFakeFirstPerson.enabled = false;
cwFakeFirstPerson.zerovector = Vector(0,0,0);
cwFakeFirstPerson.onevector = Vector(1,1,1);

Clockwork.ConVars._FFP = Clockwork.ConVars._FFP or Clockwork.kernel:CreateClientConVar("cwFakeFirstPerson", 0, true, true);

local basementCoords = {
    mins = Vector(976.96875, 7055.5751953125, -8956.1552734375),
    maxs = Vector(-4184.8891601563, 11187.530273438, -7573.791015625),

};

function cwFakeFirstPerson:IsInBasement()
    return Clockwork.Client:GetPos():WithinAABox(basementCoords.mins, basementCoords.maxs);

end

function cwFakeFirstPerson:CalcViewAdjustTable(view)
    if(Clockwork.Client.demiurge) then return; end
    if(!self:IsInBasement()) then return; end

    view.drawviewer = true;

    local player = Clockwork.Client;

    local headBone = player:LookupBone("ValveBiped.Bip01_Head1");
    local neckBone = player:LookupBone("ValveBiped.Bip01_Neck1");

    if(headBone) then player:ManipulateBoneScale(headBone, self.zerovector); end
    if(neckBone) then player:ManipulateBoneScale(neckBone, self.zerovector); end

    local up, forward, right = 5, 0, 0;
    view.origin = player:GetAttachment(player:LookupAttachment("eyes")).Pos + (player:GetForward() * forward) + (player:GetUp() * up) + (player:GetRight() * right);

end

function cwFakeFirstPerson:PreDrawViewModel()
    if(self.enabled and self:IsInBasement()) then return true; end

end

function cwFakeFirstPerson:HUDPaint()
    local width, height = ScrW(), ScrH();

    if(Clockwork.Client.demiurge) then return; end
    if(!self:IsInBasement()) then return; end
    if(true) then return; end

    surface.SetDrawColor(255,255,255);

    local pos = Clockwork.Client:GetEyeTrace().HitPos:ToScreen();

    surface.DrawRect(pos.x-2,pos.y-2,4,4);

end

//Clockwork.setting:AddCheckBox("Screen Effects", "Enable immersive first person camera.", "cwFakeFirstPerson", "Click to enable the immersive fake first person camera.");