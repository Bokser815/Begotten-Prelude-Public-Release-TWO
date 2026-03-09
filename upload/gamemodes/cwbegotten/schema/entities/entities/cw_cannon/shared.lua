ENT.PrintName = "Cannon"
ENT.Author = "Ordo Redactus"
ENT.Information = "A cannon"
ENT.Category = "Begotten"

ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.Editable = false
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.SpareMovetype = true

ENT.AutomaticFrameAdvance = true

PrecacheParticleSystem( "explosion_huge_k" )



if (CLIENT) then
    surface.CreateFont("ORArtilleryHUDFont", {
        font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
        extended = false,
        size = 40,
        weight = 500,
        blursize = 0,
        scanlines = 0,
        antialias = true,
        underline = false,
        italic = false,
        strikeout = false,
        symbol = false,
        rotary = false,
        shadow = false,
        additive = false,
        outline = false,
    })
end

hook.Add("CalcMainActivity", "FieldGunSeatAnimOverride", function (ply, vel)
    local seat = ply:GetVehicle()
    local forcedAnimation = ply:GetForcedAnimation();
    
    if (not IsValid(seat) or not IsValid(seat:GetParent()) or seat:GetParent():GetClass() ~= "cw_cannon") then return end

    ply.CalcIdeal = ACT_WALK_RELAXED
    ply.CalcSeqOverride = ply:LookupSequence("walk_all_01")

    return ply.CalcIdeal, ply.CalcSeqOverride
end)

hook.Add("UpdateAnimation", "FieldGunSeatAnimWalk", function ( ply, velocity, maxSeqGroundSpeed )
	local seat = ply:GetVehicle()
    if IsValid(seat) and IsValid(seat:GetParent()) and (seat:GetParent():GetClass() == "cw_cannon") then
        local Fieldcannon = seat:GetParent()
        local HorizontalMovement = Fieldcannon:GetNWFloat("HorizontalMovement", 0)
        local FrontalMovement = Fieldcannon:GetNWFloat("FrontalMovement", 0)
        ply:SetPoseParameter("move_x", FrontalMovement)
		ply:SetPoseParameter("move_y", HorizontalMovement)
	end
end)

hook.Add("CalcView", "FieldGunCameraOverride", function (ply, pos, angles, fov)
    local seat = LocalPlayer():GetVehicle()
    if IsValid(seat) and IsValid(seat:GetParent()) and (seat:GetParent():GetClass() == "cw_cannon") and LocalPlayer():GetViewEntity() == LocalPlayer() then
        local Fieldcannon = seat:GetParent()
        local AimMode1 = ply:GetNWFloat("AimMode", 0 )
        local muzzle = Fieldcannon:GetAttachment(Fieldcannon:LookupAttachment("fieldcannon_muzzle"))

        --[[
        if !ply.checkthirdperson then ply.checkthirdperson = CurTime()+1 end
        if ply.checkthirdperson and ply.checkthirdperson<CurTime() then
            ply.checkthirdperson = CurTime()+1
            local ischeating = seat:GetThirdPersonMode()
            if ischeating = true then
                seat:SetThirdPersonMode(false)
            end
        end
        ]]

        if AimMode1 == 0 then
            local view = {
                origin = muzzle.Pos + muzzle.Ang:Forward()*-50 + muzzle.Ang:Up()*7,
                angles = muzzle.Ang,
                fov = fov,
                drawviewer = true
            }
            return view
       	elseif AimMode1 == 1 then
            local view = {
                origin = ply:GetPos() + Vector(0,0,70),
                angles = angles,
                fov = fov,
                drawviewer = false
            }
            return view
        end


    end
end)