
function mb_Priest_Holy_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end

    if mb_Drink() then
        return
    end

    if mb_ResurrectRaid("Resurrection") then
        return
    end

   -- mb_config.mainTank = "Ceolmar"
   -- mb_config.offTank = "Maligna"

    if not UnitBuff("player", "Inner Fire") then
        CastSpellByName("Inner Fire")
        return
    end

    if UnitAffectingCombat(mb_config.mainTank) and mb_UnitHealthPercentage(mb_config.mainTank) <= 30 then
        if mb_CastSpellOnFriendly(mb_config.mainTank, "Guardian Spirit") then
            return
        end
    end

    if not mb_UnitHasDebuffOfType(mb_config.mainTank, "Weakened Soul") then
        if UnitAffectingCombat(mb_config.mainTank) then
            if mb_CastSpellOnFriendly(mb_config.mainTank, "Power Word: Shield") then
                return
            end
        end
    end

    if mb_UnitHealthPercentage(mb_config.offTank) <= 40 and not mb_UnitHasDebuffOfType(mb_config.offTank, "Weakened Soul") then
        if UnitAffectingCombat(mb_config.offTank) then
            if mb_CastSpellOnFriendly(mb_config.offTank, "Power Word: Shield") then
                return
            end
        end
    end
    
    if not mb_UnitHasMyBuff(mb_config.mainTank, "Prayer of Mending") and UnitAffectingCombat(mb_config.mainTank) then
        if mb_CastSpellOnFriendly(mb_config.mainTank, "Prayer of Mending") then
            return
        end
    end

    if not mb_UnitHasMyBuff(mb_config.mainTank, "Renew") and UnitAffectingCombat(mb_config.mainTank) then
        if mb_CastSpellOnFriendly(mb_config.mainTank, "Renew") then
            return
        end
    end

   -- if not mb_UnitHasMyBuff(mb_config.offTank, "Renew") and UnitAffectingCombat(mb_config.offTank) then
   --    if mb_CastSpellOnFriendly(mb_config.offTank, "Renew")then
   --         return
   --     end
   -- end

    if mb_UnitHealthPercentage(mb_config.mainTank) < 65 and UnitAffectingCombat(mb_config.mainTank) then
        if mb_CastSpellOnFriendly(mb_config.mainTank, "Flash Heal") then
            return
        end
    end

    if UnitBuff("player", "Surge of Light") then
        if mb_CanCastSpell("Flash Heal") then
            local healUnit, missingHealth =  mb_GetMostDamagedFriendly("Flash Heal")
            if missingHealth > 3500 then
                mb_CastSpellOnFriendly(healUnit, "Flash Heal")
                return
            end
        end
    end

    if mb_CanCastSpell("Circle of Healing") then
        local healUnit, missingHealth =  mb_GetMostDamagedFriendly("Circle of Healing")
        if missingHealth > 3000 then
            mb_CastSpellOnFriendly(healUnit, "Circle of Healing")
            return
        end
    end

    if mb_CanCastSpell("Renew") then
        local healUnit, missingHealth =  mb_GetMostDamagedFriendly("Renew")
        if missingHealth > 5000 and not mb_UnitHasMyBuff(healUnit, "Renew") then
            if mb_CastSpellOnFriendly(healUnit, "Renew") then
                return
            end
        end
    end
end