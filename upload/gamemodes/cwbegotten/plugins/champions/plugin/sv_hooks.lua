function Champions:PostEntityTakeDamage(target, dmginfo)
    local attacker = dmginfo:GetAttacker()
    Champions:CallChampionFunction(target, "onHit", attacker, dmginfo)

    if attacker:GetNWBool("OilTerminalEnemy", false) and attacker:GetNWString("championType", "") ~= "" then
        Champions:CallChampionFunction(attacker, "onAttack", target, dmginfo)
    end
end

