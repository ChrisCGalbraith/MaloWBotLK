mb_druid_lastEclipseSolar = false
mb_druid_lastEclipseLunar = false


function mb_Druid_BalanceOnUpdate()
    AssistUnit(mb_commanderUnit)

    if mb_DrinkIfGood() then
        return
    end

    if not mb_hasValidOffensiveTarget() then
        return
    end

    if not UnitBuff("player", "Moonkin Form") then
        CastSpellByName("Moonkin Form")
        return
    end

    if UnitAffectingCombat("player") and UnitPower("Khalia") < 1500 then
        if mb_castSpellOnFriendly("Khalia", "Innervate") then
            return
        end
    end

    if mb_cleanseRaid("Remove Curse", "Curse") then
        return
    end

    if mb_canCastSpell("Moonfire") and not mb_targetHasMyDebuff("Moonfire") then
        CastSpellByName("Moonfire")
        return
    end

    if mb_canCastSpell("Insect Swarm") and not mb_targetHasMyDebuff("Insect Swarm") then
        CastSpellByName("Insect Swarm")
        return
    end

    if mb_canCastSpell("Faerie Fire") and not mb_targetHasMyDebuff("Faerie Fire") then
        CastSpellByName("Faerie Fire")
        return
    end

    if UnitBuff("player", "Eclipse (Solar)") then
        mb_druid_lastEclipseSolar = true
        mb_druid_lastEclipseSolar = false
        CastSpellByName("Wrath")
        return
    end

    if UnitBuff("player", "Eclipse (Lunar)") then
        mb_druid_lastEclipseLunar = true
        mb_druid_lastEclipseSolar = false
        CastSpellByName("Starfire")
        return
    end

    CastSpellByName("Wrath")
end

function mb_Druid_handleEclipse(solar, lunar)
    if solar == true and mb_canCastSpell("Wrath") then
        CastSpellByName("Wrath")
        return
    end
    if lunar == true and mb_canCastSpell("Starfire") then
        CastSpellByName("Starfire")
        return
    end
    return
end
