
function mb_Druid_RestorationOnUpdate()
    if mb_DrinkIfGood() then
        return
    end

    if mb_resurrectRaid("Revive") then
        return
    end

  --  mb_mainTank = "Ceolmar"
  --  mb_offTank = "Maligna"

    AssistUnit(mb_commanderUnit)

    local nStance = GetShapeshiftForm();
    if nStance ~= 5 then
        CastShapeshiftForm(5)
        return
    end

    if UnitAffectingCombat("player") and UnitPower("player") < 1500 then
        mb_castSpellOnSelf("Innervate")
    end

    if mb_unitHealthPercentage(mb_mainTank) <= 25 then
        if mb_canCastSpell("Nature's Swiftness") then
            CastSpellByName("Nature's Swiftness")
            if mb_castSpellOnFriendly(mb_mainTank, "Healing Touch") then
                return
            end
        end
    end

    if mb_unitHealthPercentage(mb_mainTank) <= 30 and mb_canCastSpell("Swiftmend") and mb_unitHasMyBuff(mb_mainTank, "Rejuvenation")then
        if mb_castSpellOnFriendly(mb_mainTank, "Swiftmend") then
            return
        end
    end

    if mb_unitHealthPercentage(mb_mainTank) <= 80 and not mb_unitHasMyBuff(mb_mainTank, "Regrowth") then
        if mb_castSpellOnFriendly(mb_mainTank, "Regrowth") then
            return
        end
    end

   -- if mb_unitHealthPercentage(mb_offTank) <= 80 and not mb_unitHasMyBuff(mb_offTank, "Regrowth") then
   --     if mb_castSpellOnFriendly(mb_offTank, "Regrowth") then
   --         return
   --     end
   -- end

    if not mb_unitHasMyBuff(mb_mainTank, "Rejuvenation") then
        if mb_castSpellOnFriendly(mb_mainTank, "Rejuvenation") then
            return
        end
    end

   -- if not mb_unitHasMyBuff(mb_offTank, "Rejuvenation") then
   --    if mb_castSpellOnFriendly(mb_offTank, "Rejuvenation") then
   --        return
   --     end
   -- end

    if not mb_unitHasMyBuff(mb_mainTank, "Lifebloom") then
        if mb_castSpellOnFriendly(mb_mainTank, "Lifebloom") then
            return
        end
    end

    if mb_unitHealthPercentage(mb_mainTank) <= 60 and mb_canCastSpell("Swiftmend") and mb_unitHasMyBuff(mb_mainTank, "Rejuvenation")then
        if mb_castSpellOnFriendly(mb_mainTank, "Swiftmend") then
            return
        end
    end

    if mb_unitHealthPercentage(mb_mainTank) <= 80 and mb_canCastSpell("Nourish") then
        if mb_castSpellOnFriendly(mb_mainTank, "Nourish") then
            return
        end
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