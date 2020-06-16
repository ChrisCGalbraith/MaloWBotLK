
function mb_Mage_FireOnUpdate()
    AssistUnit(mb_commanderUnit)

    if not mb_hasValidOffensiveTarget() then
        return
    end

    if UnitBuff("player", "Hot Streak") then
        CastSpellByName("Pyroblast")
        return
    end

    if not UnitDebuff("target", "Improved Scorch") then
        CastSpellByName("Scorch")
        return
    end

    if UnitHealth("target") > UnitHealthMax("player") and UnitDebuff("target", "Improved Scorch") then
        if GetSpellCooldown("Combustion") == 0 then
            CastSpellByName("Combustion")
            return
        end
    end

    CastSpellByName("Fireball")
end