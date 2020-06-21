
    if mb_DrinkIfGood() then
        return
    end

    if mb_resurrectRaid("Ancestral Spirit") then
        return
    end

    if mb_Shaman_ApplyWeaponEnchants("Earthliving Weapon") then
        return
    end

    if not UnitBuff("player", "Water Shield") then
        CastSpellByName("Water Shield")
        return
    end

    AssistUnit(mb_commanderUnit)

    if not mb_unitHasMyBuff(mb_mainTank, "Earth Shield") then
        mb_castSpellOnFriendly(mb_mainTank, "Earth Shield")
        return
    end

    if mb_unitHealthPercentage(mb_mainTank) < 35 and UnitAffectingCombat(mb_mainTank) then
        mb_castSpellOnFriendly(mb_mainTank, "Lesser Healing Wave")
        return
    end

    if mb_unitHealthPercentage(mb_mainTank) < 50 and UnitBuff("player", "Tidal Waves") then
        mb_castSpellOnFriendly(mb_mainTank, "Lesser Healing Wave")
        return
    end

    if mb_cleanseRaid("Cleanse Spirit", "Curse", "Poison", "Disease") then
        return
    end

    if mb_unitPowerPercentage("Khalia") < 50 and UnitAffectingCombat("Khalia") then
        CastSpellByName("Mana Tide Totem")
        return
    end

    if mb_unitHealthPercentage(mb_mainTank) <= 65 then
        mb_castSpellOnFriendly(mb_mainTank, "Riptide")
        return
    end

    if mb_Shaman_ChainHealRaid() then
        return
    end
end

