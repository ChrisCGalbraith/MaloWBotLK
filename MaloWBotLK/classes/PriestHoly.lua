
function mb_Priest_HolyOnUpdate()
    if mb_DrinkIfGood() then
        return
    end

    if mb_resurrectRaid("Resurrection") then
        return
    end

    AssistUnit(mb_commanderUnit)

    if not UnitBuff("player", "Inner Fire") then
        CastSpellByName("Inner Fire")
        return
    end

    if UnitAffectingCombat(mb_mainTank) and mb_unitHealthPercentage(mb_mainTank) < 20 then
        mb_castSpellOnFriendly(mb_mainTank, "Guardian Spirit")
        return
    end

    if mb_unitHealthPercentage(mb_mainTank) < 40 and UnitAffectingCombat(mb_mainTank) then
        mb_castSpellOnFriendly(mb_mainTank, "Flash Heal")
        return
    end

    if UnitBuff("player", "Surge of Light") then
        if mb_canCastSpell("Flash Heal") then
            local healUnit, missingHealth =  mb_getMostDamagedFriendly("Flash Heal")
            if missingHealth > 3500 then
                mb_castSpellOnFriendly(healUnit, "Flash Heal")
                return
            end
        end
    end

    if mb_canCastSpell("Circle of Healing") then
        local healUnit, missingHealth =  mb_getMostDamagedFriendly("Circle of Healing")
            if missingHealth > 3000 then
                mb_castSpellOnFriendly(healUnit, "Circle of Healing")
                return
            end
    end

    if not mb_unitHasMyBuff(mb_mainTank, "Prayer of Mending") and UnitAffectingCombat(mb_mainTank) then
        mb_castSpellOnFriendly(mb_mainTank, "Prayer of Mending")
        return
    end

    if mb_canCastSpell("Renew") then
        local healUnit, missingHealth =  mb_getMostDamagedFriendly("Renew")
        if missingHealth > 5000 then
            mb_castSpellOnFriendly(healUnit, "Renew")
            return
        end
    end
end