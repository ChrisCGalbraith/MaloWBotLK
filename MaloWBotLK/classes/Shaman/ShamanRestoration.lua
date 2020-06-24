
mb_earthBindTime = 0
    if mb_DrinkIfGood() then
        return
    end

   -- mb_mainTank = "Elerien"
   -- mb_offTank = "Malowtank"

    if mb_resurrectRaid("Ancestral Spirit") then
        return
    end

    if mb_Shaman_ApplyWeaponEnchants("Earthliving Weapon") then
        return
    end

    if not UnitBuff("player", "Water Shield") then
        CastSpellByName("Water Shield")
        return
    end

   -- if mb_canCastSpell("Earthbind Totem") then
   --     if mb_earthBindTime + 45 < mb_time then
  --          if mb_castSpellOnSelf("Earthbind Totem") then
   --             mb_earthBindTime = mb_time
   --             return
   --         end
   --     end
    --end
    AssistUnit(mb_commanderUnit)

    if not mb_unitHasMyBuff(mb_mainTank, "Earth Shield") then
        if mb_castSpellOnFriendly(mb_mainTank, "Earth Shield") then
            return
        end
    end

    if mb_unitHealthPercentage(mb_mainTank) <= 80 and not mb_unitHasMyBuff(mb_mainTank, "Riptide") then
        if mb_castSpellOnFriendly(mb_mainTank, "Riptide") then
            return
        end
    end

    if mb_unitHealthPercentage(mb_offTank) <= 80 and not mb_unitHasMyBuff(mb_offTank, "Riptide") then
        if mb_castSpellOnFriendly(mb_offTank, "Riptide")then
            return
        end
    end

    if mb_unitHealthPercentage(mb_mainTank) < 35 and UnitBuff("player", "Tidal Waves") then
        if mb_castSpellOnFriendly(mb_mainTank, "Healing Wave") then
            return
        end
    end

    if mb_unitHealthPercentage(mb_mainTank) < 80 and UnitBuff("player", "Tidal Waves") then
        if mb_castSpellOnFriendly(mb_mainTank, "Lesser Healing Wave") then
            return
        end
    end

    if mb_cleanseRaid("Cleanse Spirit", "Curse", "Poison", "Disease") then
        return
    end

    if mb_unitPowerPercentage("Khalia") < 50 and UnitAffectingCombat("Khalia") then
        CastSpellByName("Mana Tide Totem")
        return
    end

    if mb_Shaman_ChainHealRaid() then
        return
    end
end

function mb_Shaman_handleFocusHealing()
    local healUnit, missingHealth = mb_getMostDamagedFriendly("Riptide")
    if missingHealth > mb_getSpellEffect("Lesser Healing Wave") then
        mb_castSpellOnFriendly(healUnit, "Lesser Healing Wave")
        return true
    end
    return false
end