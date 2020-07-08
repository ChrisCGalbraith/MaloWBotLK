function mb_Druid_Feral_OnLoad()

end

function mb_Druid_Feral_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

    local nStance = GetShapeshiftForm();

    if nStance == 1 then
        mb_Druid_Bear_OnUpdate()
        return
    end

    if nStance == 3 then
		mb_EnableIWTDistanceClosing("Claw")
        mb_Druid_Cat_OnUpdate()
        return
    end
end

function mb_Druid_Cat_OnUpdate()

    if not mb_isAutoAttacking then
        InteractUnit("target")
    end

    if UnitAffectingCombat("player") and UnitPower("player") <= 30 then
        if mb_CanCastSpell("Tiger's Fury") then
            CastSpellByName("Tiger's Fury")
            return
        end
    end

	if not UnitBuff("player", "Savage Roar") and GetComboPoints("player", "target") == 5 then
        if mb_CastSpellWithoutTarget("Savage Roar") then
            return
        end
    end

    if mb_GetMyDebuffTimeRemaining("target","Rip") == 0 and GetComboPoints("player", "target") == 5 then
        if mb_CastSpellOnTarget("Rip") then
            return
        end
    end

    if mb_GetMyDebuffTimeRemaining("target","Rake") == 0 then
        if mb_CastSpellOnTarget("Rake") then
            return
        end
    end

    if mb_CastSpellOnTarget("Mangle (Cat)()") then
        return
    end
end

function mb_Druid_Bear_OnUpdate()

    if mb_UnitHealthPercentage("player") < 30 then
        if mb_CastSpellWithoutTarget("Survival Instincts") then
            return
        end
    end

    if mb_UnitHealthPercentage("player") < 60 then
        mb_UseItemCooldowns()
        if mb_CastSpellWithoutTarget("Barkskin") then
            return
        end
    end

    if not mb_isAutoAttacking then
        InteractUnit("target")
    end

    if UnitPower("player") > 60 then
        CastSpellByName("Maul")
    end

    if mb_CastSpellOnTarget("Mangle (Bear)()") then
        return
    end

    if mb_CastSpellOnTarget("Lacerate") then
        return
    end

    if mb_CastSpellOnTarget("Swipe (Bear)()") then
        CastSpellByName("Swipe (Bear)()")
        return
    end
end