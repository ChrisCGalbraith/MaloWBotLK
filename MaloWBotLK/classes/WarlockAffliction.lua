
function mb_Warlock_AfflictionOnUpdate()
    AssistUnit(mb_commanderUnit)

    if UnitPower("player") < 1000 then
        CastSpellByName("Life Tap")
    end

    if not UnitBuff("player", "Fel Armor") then
        CastSpellByName("Fel Armor")
        return
    end

    if not mb_hasValidOffensiveTarget() then
        return
    end

    if mb_warlockIsDemo == true then
        mb_demoRotation()
        return
    end

    if mb_unitHealthPercentage("target") < 25 then
        if mb_targetHasMyDebuff("Drain Soul") then
            return
        end

        if not mb_targetHasMyDebuff("Drain Soul")then
            CastSpellByName("Drain Soul")
            return
        end
    end

    if GetUnitName("player") == "Maligna" and mb_canCastSpell("Seed of Corruption") then
         CastSpellByName("Seed of Corruption")
        return
    end

    if mb_canCastSpell("Corruption") and not mb_targetHasMyDebuff("Corruption") then
        CastSpellByName("Corruption")
        return
    end

    if UnitBuff("player", "Shadow Trance") then
        CastSpellByName("Shadow Bolt")
        return
    end

    if mb_canCastSpell("Curse of Agony") and not mb_targetHasMyDebuff("Curse of Agony") then
        CastSpellByName("Curse of Agony")
        return
    end

    if mb_canCastSpell("Unstable Affliction") and not mb_targetHasMyDebuff("Unstable Affliction") then
        CastSpellByName("Unstable Affliction")
        return
    end

    if mb_canCastSpell( "Haunt") and not mb_targetHasMyDebuff("Haunt") then
        CastSpellByName("Haunt")
        return
    end
end