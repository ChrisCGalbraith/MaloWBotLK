function mb_Priest_Holy_OnLoad()
    mb_RegisterExclusiveRequestHandler("healcd", mb_Priest_HealCdAcceptor, mb_Priest_HealCdExecutor)
    mb_RegisterExclusiveRequestHandler("external", mb_Priest_Holy_ExternalRequestAcceptor, mb_Priest_Holy_ExternalRequestExecutor)
end

mb_Priest_roleplayThrottle = 0
mb_Priest_Holy_useCooldownsCommandTime = 0
function mb_Priest_Holy_OnUpdate()
    mb_Priest_HandleRoleplay()
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

    local _, _, text = UnitChannelInfo("player")
    if text == "Divine Hymn" or text == "Hymn of Hope" then
        return
    end

    if not UnitBuff("player", "Inner Fire") then
        CastSpellByName("Inner Fire")
        return
    end

    if mb_UnitPowerPercentage("player") < 50 and UnitAffectingCombat("player") and mb_CanCastSpell("Shadowfiend)") then
        AssistUnit(mb_commanderUnit)
        if mb_CastSpellOnTarget("Shadowfiend") then
            return
        end
    end

    if mb_Priest_Holy_useCooldownsCommandTime + 20 > mb_time then
        mb_UseItemCooldowns()
        if mb_CastSpellWithoutTarget("Divine Hymn") then
            return
        end
    end

    if UnitAffectingCombat(mb_config.mainTank) and mb_UnitHealthPercentage(mb_config.mainTank) <= 30 then
        if mb_CastSpellOnFriendly(mb_config.mainTank, "Guardian Spirit") then
            return
        end
    end

    --  if UnitAffectingCombat(mb_config.mainTank) and mb_GetDebuffTimeRemaining(mb_config.mainTank, "Weakened Soul") == 0 then
    --      if mb_CastSpellOnFriendly(mb_config.mainTank, "Power Word: Shield") then
    --          return
    --      end
    --  end

    --  if UnitAffectingCombat(mb_config.offTank) and mb_GetDebuffTimeRemaining(mb_config.offTank, "Weakened Soul") == 0 then
    --      if mb_CastSpellOnFriendly(mb_config.offTank, "Power Word: Shield") then
    --          return
    --      end
    --  end

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

    if not mb_UnitHasMyBuff(mb_config.offTank, "Renew") and UnitAffectingCombat(mb_config.offTank) then
        if mb_CastSpellOnFriendly(mb_config.offTank, "Renew")then
            return
        end
    end

    if mb_UnitHealthPercentage(mb_config.mainTank) < 65 and UnitAffectingCombat(mb_config.mainTank) then
        if mb_CastSpellOnFriendly(mb_config.mainTank, "Flash Heal") then
            return
        end
    end

    if UnitBuff("player", "Surge of Light") then
        if mb_CanCastSpell("Flash Heal") then
            local healUnit, missingHealth =  mb_GetMostDamagedFriendly("Flash Heal")
            if missingHealth > 4000 then
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


    local healUnit, missingHealth = mb_GetMostDamagedFriendly("Flash Heal")
    if missingHealth > 4000 then
        if mb_CastSpellOnFriendly(healUnit, "Flash Heal") then
            return
        end
    end
end

function mb_Priest_Holy_ExternalRequestAcceptor(message, from)
    if mb_IsUsableSpell("Guardian Spirit") and mb_GetRemainingSpellCooldown("Guardian Spirit") < 1.5 then
        if mb_IsUnitValidFriendlyTarget(from, "Guardian Spirit") then
            return true
        end
    end

    return false
end

function mb_Priest_Holy_ExternalRequestExecutor(message, from)
    if not mb_IsReadyForNewCast() then
        return false
    end

    local targetUnit = mb_GetUnitForPlayerName(from)
    if mb_CastSpellOnFriendly(targetUnit, "Guardian Spirit") then
        mb_SayRaid("Casting Guardian Spirit")
        return true
    end

    return false
end

-- Experimental handling of Roleplay stuff
function mb_Priest_HandleRoleplay()
    if mb_GetNumAlivePartyOrRaidMembers() < 13 then
        if mb_Priest_roleplayThrottle + 5 > mb_time then
            return
        end

        --mb_Say(mb_roleplay.fearfulGossip[math.random(#mb_roleplay.fearfulGossip["First"][1])])
        for _, fearfulGossip in pairs(mb_roleplay) do
            mb_Say(fearfulGossip)
           -- mb_Priest_roleplayThrottle = mb_time
        end
    end
end