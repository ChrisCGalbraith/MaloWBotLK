
mb_earthBindTime = 0
function mb_Shaman_Restoration_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end

    if mb_Drink() then
        return
    end

    --mb_config.mainTank = "Odia"
    --mb_config.offTank = "Necria"

    if mb_ResurrectRaid("Ancestral Spirit") then
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

    if not mb_UnitHasMyBuff(mb_config.mainTank, "Earth Shield") then
        if mb_CastSpellOnFriendly(mb_config.mainTank, "Earth Shield") then
            return
        end
    end

    if mb_GetMissingHealth(mb_config.mainTank) > mb_GetSpellEffect("Riptide") and not mb_UnitHasMyBuff(mb_config.mainTank, "Riptide") then
        if mb_CastSpellOnFriendly(mb_config.mainTank, "Riptide") then
            return
        end
    end

    if mb_GetMissingHealth(mb_config.offTank) > mb_GetSpellEffect("Riptide") and not mb_UnitHasMyBuff(mb_config.offTank, "Riptide") then
        if mb_CastSpellOnFriendly(mb_config.offTank, "Riptide")then
            return
        end
    end

    if mb_GetMissingHealth(mb_config.mainTank) > mb_GetSpellEffect("Healing Wave") and UnitBuff("player", "Tidal Waves") then
        if mb_CastSpellOnFriendly(mb_config.mainTank, "Healing Wave") then
            return
        end
    end

    if mb_GetMissingHealth(mb_config.mainTank) > mb_GetSpellEffect("Lesser Healing Wave") and UnitBuff("player", "Tidal Waves") then
        if mb_CastSpellOnFriendly(mb_config.mainTank, "Lesser Healing Wave") then
            return
        end
    end

    if mb_CleanseRaid("Cleanse Spirit", "Curse", "Poison", "Disease") then
        return
    end

    if mb_UnitPowerPercentage("Kisaana") < 50 and UnitAffectingCombat("Khalia") then
        CastSpellByName("Mana Tide Totem")
        return
    end

    if mb_GetMissingHealth(mb_config.mainTank) > mb_GetSpellEffect("Lesser Healing Wave") then
        if mb_CastSpellOnFriendly(mb_config.mainTank, "Lesser Healing Wave") then
            return
        end
    end

    if mb_GetMissingHealth(mb_config.offTank) > mb_GetSpellEffect("Lesser Healing Wave") then
        if mb_CastSpellOnFriendly(mb_config.offTank, "Lesser Healing Wave") then
            return
        end
    end

    if mb_Shaman_ChainHealRaid() then
        return
    end
end

function mb_Shaman_HandleFocusHealing()
    local healUnit, missingHealth = mb_GetMostDamagedFriendly("Riptide")
    if missingHealth > mb_GetSpellEffect("Lesser Healing Wave") then
        mb_CastSpellOnFriendly(healUnit, "Lesser Healing Wave")
        return true
    end
    return false
end