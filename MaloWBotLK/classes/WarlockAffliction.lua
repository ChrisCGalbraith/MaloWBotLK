
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

    if not mb_targetHasMyDebuff("Corruption") and mb_castSpellOnTarget("Corruption") then
        return
    end

    if UnitBuff("player", "Shadow Trance") and mb_castSpellOnTarget("Shadow Bolt") then
        return
    end

    if not mb_targetHasMyDebuff("Curse of Agony") and mb_castSpellOnTarget("Curse of Agony") then
        return
    end

    if not mb_targetHasMyDebuff("Unstable Affliction") and mb_castSpellOnTarget("Unstable Affliction") then
        return
    end

    if not mb_targetHasMyDebuff("Haunt") and mb_castSpellOnTarget( "Haunt") then
        return
    end

    if mb_unitHealthPercentage("target") < 25 then
        if mb_targetHasMyDebuff("Drain Soul") then
            return
        end
        CastSpellByName("Drain Soul")
        return
    end
end