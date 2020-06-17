
    if mb_resurrectRaid("Ancestral Spirit") then
        return
    end

    AssistUnit(mb_commanderUnit)

    if mb_Shaman_ApplyWeaponEnchants("Earthliving Weapon") then
        return
    end

    if not UnitBuff("player", "Water Shield") then
        CastSpellByName("Water Shield")
        return
    end

    if UnitPower("Khalia") < 1000 and UnitAffectingCombat("Khalia")then
        CastSpellByName("Mana Tide Totem")
        return
    end

    if mb_unitHealthPercentage("Malowtank") <= 50 then
        mb_castSpellOnFriendly("Malowtank", "Riptide")
        return
    end

    if mb_Shaman_ChainHealRaid() then
        return
    end

    if not mb_unitHasMyBuff("Malowtank", "Earth Shield") then
        mb_castSpellOnFriendly("Malowtank", "Earth Shield")
        return
    end
end