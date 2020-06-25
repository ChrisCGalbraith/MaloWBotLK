mb_druid_lastEclipseSolar = false
mb_druid_lastEclipseLunar = false


function mb_Druid_Balance_OnUpdate()
    if mb_Drink() then
        return
    end

    if not UnitBuff("player", "Moonkin Form") then
        CastSpellByName("Moonkin Form")
        return
    end

    if UnitAffectingCombat("player") and UnitPower("Khalia") < 5000 then
        if mb_CastSpellOnFriendly("Khalia", "Innervate") then
            return
        end
    end

    if mb_CleanseRaid("Remove Curse", "Curse") then
        return
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

    if mb_CanCastSpell("Moonfire") and not mb_TargetHasMyDebuff("Moonfire") then
        CastSpellByName("Moonfire")
        return
    end

    if mb_CanCastSpell("Insect Swarm") and not mb_TargetHasMyDebuff("Insect Swarm") then
        CastSpellByName("Insect Swarm")
        return
    end

    if mb_CanCastSpell("Faerie Fire") and not mb_TargetHasMyDebuff("Faerie Fire") then
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

function mb_Druid_HandleEclipse(solar, lunar)
    if solar == true and mb_CanCastSpell("Wrath") then
        CastSpellByName("Wrath")
        return
    end
    if lunar == true and mb_CanCastSpell("Starfire") then
        CastSpellByName("Starfire")
        return
    end
end
