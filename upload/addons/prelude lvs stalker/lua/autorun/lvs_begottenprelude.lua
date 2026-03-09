local function Initialize()
    if ( !tobool(LVS) ) then
        print("[LVS] - Unable to load Prelude Vehicles, LVS not found.")
        return
    end

    list.Set("ContentCategoryIcons", "[LVS] - Prelude", "icon16/lvs_resistance.png")

    print("[LVS] - Prelude Vehicles loaded.")
end

timer.Simple(5, Initialize)

hook.Add("InitPostEntity", "LVS.Prelude", function()
    Initialize()
end)
