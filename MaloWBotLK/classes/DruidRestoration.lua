
function mb_Druid_Restoration_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end

    if mb_Drink() then
        return
    end

    if mb_ResurrectRaid("Revive") then
        return
    end

   -- mb_config.mainTank = "Ceolmar"
  --  mb_config.offTank = "Maligna"

    local nStance = GetShapeshiftForm();
    if nStance ~= 5 then
        CastShapeshiftForm(5)
        return
    end

    if UnitAffectingCombat("player") and UnitPower("player") < 1500 then
        mb_CastSpellWithoutTarget("Innervate")
    end

    if mb_UnitHealthPercentage(mb_config.mainTank) <= 25 then
        if mb_CanCastSpell("Nature's Swiftness") then
            CastSpellByName("Nature's Swiftness")
            if mb_CastSpellOnFriendly(mb_config.mainTank, "Healing Touch") then
                return
            end
        end
    end

    if mb_UnitHealthPercentage(mb_config.mainTank) <= 30 and mb_CanCastSpell("Swiftmend") and mb_UnitHasMyBuff(mb_config.mainTank, "Rejuvenation")then
        if mb_CastSpellOnFriendly(mb_config.mainTank, "Swiftmend") then
            return
        end
    end

    if mb_UnitHealthPercentage(mb_config.mainTank) <= 80 and not mb_UnitHasMyBuff(mb_config.mainTank, "Regrowth") then
        if mb_CastSpellOnFriendly(mb_config.mainTank, "Regrowth") then
            return
        end
    end

   -- if mb_UnitHealthPercentage(mb_config.offTank) <= 80 and not mb_UnitHasMyBuff(mb_config.offTank, "Regrowth") then
   --     if mb_CastSpellOnFriendly(mb_config.offTank, "Regrowth") then
   --         return
   --     end
   -- end

    if not mb_UnitHasMyBuff(mb_config.mainTank, "Rejuvenation") then
        if mb_CastSpellOnFriendly(mb_config.mainTank, "Rejuvenation") then
            return
        end
    end

    if not mb_UnitHasMyBuff(mb_config.offTank, "Rejuvenation") then
       if mb_CastSpellOnFriendly(mb_config.offTank, "Rejuvenation") then
           return
        end
    end

    if not mb_UnitHasMyBuff(mb_config.mainTank, "Lifebloom") then
        if mb_CastSpellOnFriendly(mb_config.mainTank, "Lifebloom") then
            return
        end
    end

    if mb_UnitHealthPercentage(mb_config.mainTank) <= 60 and mb_CanCastSpell("Swiftmend") and mb_UnitHasMyBuff(mb_config.mainTank, "Rejuvenation")then
        if mb_CastSpellOnFriendly(mb_config.mainTank, "Swiftmend") then
            return
        end
    end

    if mb_UnitHealthPercentage(mb_config.mainTank) <= 60 and mb_CanCastSpell("Nourish") then
        if mb_CastSpellOnFriendly(mb_config.mainTank, "Nourish") then
            return
        end
    end

    if mb_CanCastSpell("Wild Growth") then
        local healUnit, missingHealth =  mb_GetMostDamagedFriendly("Wild Growth")
        if missingHealth > 3500 then
            mb_CastSpellOnFriendly(healUnit, "Wild Growth")
            return
        end
    end

    if mb_CleanseRaid("Remove Curse", "Curse") then
        return
    end

    if mb_CanCastSpell("Rejuvenation") then
        local healUnit, missingHealth =  mb_GetMostDamagedFriendly("Rejuvenation")
        if missingHealth > 4000 and not mb_UnitHasMyBuff(healUnit, "Rejuvenation") then
            mb_CastSpellOnFriendly(healUnit, "Rejuvenation")
            return
        end
    end
end