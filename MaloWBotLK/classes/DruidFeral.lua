
function mb_Druid_FeralOnUpdate()
    AssistUnit(mb_commanderUnit)

    if mb_DrinkIfGood() then
        return
    end

    if UnitAffectingCombat("player") then
        local nStance = GetShapeshiftForm();
        if nStance ~= 3 then
            CastShapeshiftForm(3)
            return
        end
    end

    if not mb_hasValidOffensiveTarget() then
        return
    end

    if UnitAffectingCombat("player") and UnitPower("player") <= 30 then
        if mb_canCastSpell("Tiger's Fury") then
            CastSpellByName("Tiger's Fury")
            return
        end
    end

    if not mb_targetHasMyDebuff("Rip") and GetComboPoints("player", "target") == 5 then
        CastSpellByName("Rip")
        return
    end

    if not mb_targetHasMyDebuff("Rake") then
        CastSpellByName("Rake")
        return
    end

    if mb_castSpellOnTarget("Mangle (Cat)()") then
       CastSpellByName("Mangle (Cat)()")
        return
    end
end

