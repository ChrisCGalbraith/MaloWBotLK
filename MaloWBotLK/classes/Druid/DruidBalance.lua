mb_druid_lastEclipseSolar = false
mb_druid_lastEclipseLunar = false

function mb_Druid_Balance_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end

    if mb_Drink() then
        return
    end

    if not UnitBuff("player", "Moonkin Form") then
        CastSpellByName("Moonkin Form")
        return
    end

    if UnitAffectingCombat("player") and UnitPower("Arethel") < 10000 then
        if mb_CastSpellOnFriendly("Arethel", "Innervate") then
            return
        end
    end

    if mb_CleanseRaid("Remove Curse", "Curse") then
        return
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

    if mb_ShouldUseDpsCooldowns("Wrath") and UnitAffectingCombat("player") then
		mb_UseItemCooldowns()
		if mb_CastSpellWithoutTarget("Starfall") then
			return
		end
    end

    if mb_cleaveMode > 0 and mb_CastSpellWithoutTarget("Starfall") then
        return
    end

    if UnitHealth("target") > 100000 and mb_CanCastSpell("Moonfire") and mb_GetMyDebuffTimeRemaining("target", "Moonfire") == 0 then
        CastSpellByName("Moonfire")
        return
    end

    if UnitHealth("target") > 100000 and mb_CanCastSpell("Insect Swarm") and mb_GetMyDebuffTimeRemaining("target", "Insect Swarm") == 0 then
        CastSpellByName("Insect Swarm")
        return
    end

    if UnitHealth("target") > 100000 and mb_CanCastSpell("Faerie Fire") and mb_GetMyDebuffTimeRemaining("target", "Faerie Fire") == 0 then
        CastSpellByName("Faerie Fire")
        return
    end

    if UnitBuff("player", "Eclipse (Solar)") then
        mb_druid_lastEclipseSolar = true
        mb_druid_lastEclipseLunar = false
    end

    if UnitBuff("player", "Eclipse (Lunar)") then
        mb_druid_lastEclipseLunar = true
        mb_druid_lastEclipseSolar = false
    end

    if mb_Druid_HandleEclipse(mb_druid_lastEclipseSolar, mb_druid_lastEclipseLunar) then
        return
    end

    CastSpellByName("Wrath")
end

function mb_Druid_HandleEclipse(solar, lunar)
    if solar == true and mb_CanCastSpell("Wrath") then
        CastSpellByName("Wrath")
        return true
    end
    if lunar == true and mb_CanCastSpell("Starfire") then
        CastSpellByName("Starfire")
        return true
    end

    return false
end
