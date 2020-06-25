
function mb_Druid_Feral_OnUpdate()
    local nStance = GetShapeshiftForm();
    if nStance ~= 3 then
        CastShapeshiftForm(3)
        return
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

    if nStance == 3 and UnitAffectingCombat("player") and UnitPower("player") <= 30 then
        if mb_CanCastSpell("Tiger's Fury") then
            CastSpellByName("Tiger's Fury")
            return
        end
    end

    if nStance == 3 and  not mb_TargetHasMyDebuff("Rip") and GetComboPoints("player", "target") == 5 then
        if mb_CastSpellOnTarget("Rip") then
            return
        end
    end

    if nStance == 3 and not mb_TargetHasMyDebuff("Rake") then
        if mb_CastSpellOnTarget("Rake") then
            return
        end
    end

    if nStance == 3 and mb_CastSpellOnTarget("Mangle (Cat)()") then
        return
    end

    if mb_UnitHealthPercentage("player") < 30 then
        if mb_CastSpellWithoutTarget("Survival Instincts") then
            return
        end
    end

    if mb_UnitHealthPercentage("player") < 60 then
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

