
function mb_Druid_FeralOnUpdate()
    AssistUnit(mb_commanderUnit)

    if mb_DrinkIfGood() then
        return
    end

    local nStance = GetShapeshiftForm();
    if nStance ~= 1 then
        CastShapeshiftForm(1)
        return
    end

    if not mb_hasValidOffensiveTarget() then
        return
    end

    if nStance == 3 and UnitAffectingCombat("player") and UnitPower("player") <= 30 then
        if mb_canCastSpell("Tiger's Fury") then
            CastSpellByName("Tiger's Fury")
            return
        end
    end

    if nStance == 3 and  not mb_targetHasMyDebuff("Rip") and GetComboPoints("player", "target") == 5 then
        CastSpellByName("Rip")
        return
    end

    if nStance == 3 and not mb_targetHasMyDebuff("Rake") then
        CastSpellByName("Rake")
        return
    end

    if mb_unitHealthPercentage("player") < 30 then
        if mb_castSpellOnSelf("Survival Instincts") then
            return
        end
    end

    if mb_unitHealthPercentage("player") < 60 then
        if mb_castSpellOnSelf("Barkskin") then
            return
        end
    end

    if not mb_isAutoAttacking then
        InteractUnit("target")
    end

    if UnitPower("player") > 60 then
        CastSpellByName("Maul")
    end

    if mb_castSpellOnTarget("Mangle (Bear)()") then
        return
    end

    if mb_castSpellOnTarget("Lacerate") then
        return
    end

    if mb_castSpellOnTarget("Swipe (Bear)()") then
        CastSpellByName("Swipe (Bear)()")
        return
    end

    
end

