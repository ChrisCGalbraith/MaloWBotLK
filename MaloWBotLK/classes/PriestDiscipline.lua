-- TO DO --
-- UNIT_AURA
-- UNIT_SPELLCAST_SENT


mb_lastRaptureTime = 0
function mb_Priest_Discipline_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end

    if mb_Drink() then
        return
    end

    if mb_ResurrectRaid("Resurrection") then
        return
    end

    if not UnitBuff("player", "Inner Fire") then
        CastSpellByName("Inner Fire")
        return
    end

    if UnitAffectingCombat(mb_config.mainTank) and mb_GetDebuffTimeRemaining(mb_config.mainTank, "Weakened Soul") == 0 then
        if mb_CastSpellOnFriendly(mb_config.mainTank, "Power Word: Shield") then
            return
        end
    end

    if not mb_UnitHasMyBuff(mb_config.mainTank, "Prayer of Mending") and UnitAffectingCombat(mb_config.mainTank) then
        if mb_CastSpellOnFriendly(mb_config.mainTank, "Prayer of Mending") then
            return
        end
    end

    if mb_UnitHealthPercentage(mb_config.mainTank) < 60 then
        if mb_CastSpellOnFriendly(mb_config.mainTank, "Penance") then
            return
        end
    end

    local unit = mb_GetRaidMemberWithoutDebuff("Weakened Soul")
    if mb_IsUnitValidFriendlyTarget(unit, "Power Word: Shield") then
        if mb_CastSpellOnFriendly(unit, "Power Word: Shield") then
            return
        end
    end

    local healUnit, missingHealth = mb_GetMostDamagedFriendly("Flash Heal")
    if missingHealth > 4000 then
        if mb_CastSpellOnFriendly(healUnit, "Flash Heal") then
            return
        end
    end
end

function mb_Priest_StackRapture()
    if mb_GetDebuffTimeRemaining(mb_config.mainTank, "Weakened Soul") < 1.5 then
        return false
    end

    if mb_lastRaptureTime + 10 < mb_time then
        return false
    end

    local healUnit, missingHealth = mb_GetMostDamagedFriendly("Power Word: Shield")
    if missingHealth >= 0  and not UnitDebuff(healUnit, "Weakened Soul") then
        if mb_CastSpellOnFriendly(healUnit, "Power Word: Shield") then
            return
        end
    end
end

