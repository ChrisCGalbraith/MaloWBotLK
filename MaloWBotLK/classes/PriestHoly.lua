
function mb_Priest_HolyOnUpdate()
    if mb_DrinkIfGood() then
        return
    end

    if mb_resurrectRaid("Resurrection") then
        return
    end

    AssistUnit(mb_commanderUnit)

    --mb_mainTank = "Ceolmar"
 --   mb_offTank = "Maligna"

    if not UnitBuff("player", "Inner Fire") then
        CastSpellByName("Inner Fire")
        return
    end

    if UnitAffectingCombat(mb_mainTank) and mb_unitHealthPercentage(mb_mainTank) <= 30 then
        if mb_castSpellOnFriendly(mb_mainTank, "Guardian Spirit") then
            return
        end
    end

    if not mb_unitHasDebuffOfType(mb_mainTank, "Weakened Soul") then
        if UnitAffectingCombat(mb_mainTank) then
            if mb_castSpellOnFriendly(mb_mainTank, "Power Word: Shield") then
                return
            end
        end
    end

  --  if mb_unitHealthPercentage(mb_offTank) <= 40 and not mb_unitHasDebuffOfType(mb_offTank, "Weakened Soul") then
   --     if UnitAffectingCombat(mb_offTank) then
   --         if mb_castSpellOnFriendly(mb_offTank, "Power Word: Shield") then
   --             return
  --          end
  --      end
  --  end
    
    if not mb_unitHasMyBuff(mb_mainTank, "Prayer of Mending") and UnitAffectingCombat(mb_mainTank) then
        if mb_castSpellOnFriendly(mb_mainTank, "Prayer of Mending") then
            return
        end
    end

    if not mb_unitHasMyBuff(mb_mainTank, "Renew") and UnitAffectingCombat(mb_mainTank) then
        if mb_castSpellOnFriendly(mb_mainTank, "Renew") then
            return
        end
    end

   -- if not mb_unitHasMyBuff(mb_offTank, "Renew") and UnitAffectingCombat(mb_offTank) then
   --    if mb_castSpellOnFriendly(mb_offTank, "Renew")then
   --         return
   --     end
   -- end

    if mb_unitHealthPercentage(mb_mainTank) < 65 and UnitAffectingCombat(mb_mainTank) then
        if mb_castSpellOnFriendly(mb_mainTank, "Flash Heal") then
            return
        end
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

    if mb_canCastSpell("Renew") then
        local healUnit, missingHealth =  mb_getMostDamagedFriendly("Renew")
        if missingHealth > 5000 and not mb_unitHasMyBuff(healUnit, "Renew") then
            if mb_castSpellOnFriendly(healUnit, "Renew") then
                return
            end
        end
    end
end