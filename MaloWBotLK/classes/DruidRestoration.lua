
function mb_Druid_RestorationOnUpdate()
    if mb_DrinkIfGood() then
        return
    end

    if mb_resurrectRaid("Revive") then
        return
    end

    AssistUnit(mb_commanderUnit)

    if UnitAffectingCombat("player") and UnitPower("player") < 1500 then
        mb_castSpellOnSelf("Innervate")
    end

    if mb_unitHealthPercentage(mb_mainTank) < 50 and mb_canCastSpell("Swiftmend") and mb_unitHasMyBuff(mb_mainTank, "Rejuvenation")then
        mb_castSpellOnFriendly(mb_mainTank, "Swiftmend")
        return
    end

    if UnitBuff("player", "Clearcasting") then
         if mb_castSpellOnFriendly(mb_mainTank, "Lifebloom") then
             return
         end
    end

    if not mb_unitHasMyBuff(mb_mainTank, "Rejuvenation") and UnitAffectingCombat(mb_mainTank) then
        mb_castSpellOnFriendly(mb_mainTank, "Rejuvenation")
        return
    end

    if mb_canCastSpell("Wild Growth") then
        local healUnit, missingHealth =  mb_getMostDamagedFriendly("Wild Growth")
        if missingHealth > 3500 then
            mb_castSpellOnFriendly(healUnit, "Wild Growth")
            return
        end
    end

    if mb_cleanseRaid("Remove Curse", "Curse") then
        return
    end

    if mb_canCastSpell("Rejuvenation") then
        local healUnit, missingHealth =  mb_getMostDamagedFriendly("Rejuvenation")
        if missingHealth > 4000 and not mb_unitHasMyBuff(healUnit, "Rejuvenation") then
            mb_castSpellOnFriendly(healUnit, "Rejuvenation")
            return
        end
    end
end