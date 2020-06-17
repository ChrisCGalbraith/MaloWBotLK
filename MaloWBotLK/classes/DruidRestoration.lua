
function mb_Druid_RestorationOnUpdate()
    if mb_resurrectRaid("Revive") then
        return
    end

    AssistUnit(mb_commanderUnit)

    if UnitAffectingCombat("player") and UnitPower("player") < 1500 then
        mb_castSpellOnSelf("Innervate")
    end

    if UnitBuff("player", "Clearcasting") then
         if mb_castSpellOnFriendly("Malowtank", "Lifebloom") then
             return
         end
    end

    if mb_canCastSpell("Wild Growth") then
        local healUnit, missingHealth =  mb_getMostDamagedFriendly("Wild Growth")
        if missingHealth > 2000 then
            mb_castSpellOnFriendly(healUnit, "Wild Growth")
            return
        end
    end

    if mb_canCastSpell("Rejuvenation") then
        local healUnit, missingHealth =  mb_getMostDamagedFriendly("Rejuvenation")
        if missingHealth > 2500 and not mb_unitHasMyBuff(healUnit, "Rejuvenation") then
            mb_castSpellOnFriendly(healUnit, "Rejuvenation")
            return
        end
    end
end