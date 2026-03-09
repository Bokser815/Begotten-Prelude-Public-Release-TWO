function Champions:PostDrawTranslucentRenderables()
    local npcs = ents.FindByClass("npc_bgt_another")
    for _, npc in ipairs(npcs) do
        Champions:CallChampionFunction(npc, "onThink")
    end
end