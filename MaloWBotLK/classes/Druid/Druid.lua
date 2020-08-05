function mb_Druid_OnLoad()
    if mb_GetMySpecName() == "Balance" then
        mb_classSpecificRunFunction = mb_Druid_Balance_OnUpdate
        mb_Druid_Balance_OnLoad()
    elseif mb_GetMySpecName() == "Feral Combat" then
        mb_classSpecificRunFunction = mb_Druid_Feral_OnUpdate
        mb_Druid_Feral_OnLoad()
    else
        mb_classSpecificRunFunction = mb_Druid_Restoration_OnUpdate
        mb_Druid_Restoration_OnLoad()
    end

    if mb_myClassOrderIndex == 1 then
        mb_RegisterMessageHandler(BUFF_MOTW.requestType, mb_Druid_MotwHandler)
        mb_RegisterMessageHandler(BUFF_THORNS.requestType, mb_Druid_ThornsHandler)
    end

    if mb_GetMySpecName() == "Feral Combat" then
        mb_RegisterMessageHandler("taunt", mb_Druid_TauntHandler)
    end

    mb_RegisterDesiredBuff(BUFF_KINGS)
    mb_RegisterDesiredBuff(BUFF_WISDOM)
    mb_RegisterDesiredBuff(BUFF_MIGHT)
    mb_RegisterDesiredBuff(BUFF_SANCTUARY)
    mb_RegisterDesiredBuff(BUFF_INTELLECT)
    mb_RegisterDesiredBuff(BUFF_MOTW)
    mb_RegisterDesiredBuff(BUFF_FORT)
    mb_RegisterDesiredBuff(BUFF_SPIRIT)
    mb_RegisterDesiredBuff(BUFF_SHADOW_PROT)

    mb_CheckReagentAmount("Wild Spineleaf", 100)
end

function mb_Druid_HandleMotw(targetPlayerName, greaterSpell)
    if not mb_ShouldBuff() then
        return
    end

    if mb_CastSpellOnSelf(greaterSpell) then
        CastSpellByName("Gift of the Wild")
        return
    end
    -- mb_castSpellOnFriendly(mb_getUnitForPlayerName(targetPlayerName), singleSpell)
end

function mb_Druid_HandleThorns(targetPlayerName, singleSpell)
    if not mb_ShouldBuff() then
        return
    end

    if mb_CastSpellOnFriendly(mb_GetUnitForPlayerName(targetPlayerName), singleSpell) then
        return
    end
end

function mb_Druid_MotwHandler(msg, from)
    mb_Druid_HandleMotw(from, "Gift of the Wild")
end

function mb_Druid_ThornsHandler(msg, from)
    mb_Druid_HandleThorns(from, "Thorns")
end

function mb_Druid_HandleCombatRess(msg, from)
    mb_Druid_CombatRessHandler(from)
end

function mb_Druid_CombatRessHandler(targetPlayerName)
    if mb_ShouldCombatRess == false then
        return
    end

    if mb_CastSpellOnFriendly(targetPlayerName, "Rebirth") then
        mb_SayRaid("Combat Resurrecting " .. targetPlayerName)
        return
    end
end

function mb_Druid_Innervate(unit)
    if mb_UnitPowerPercentage(unit) < 50 then
        if mb_CastSpellOnFriendly(unit, "Innervate") then
            return true
        end
    end

    return false
end

function mb_Druid_ReadyCheck()
    local ready = true
    if mb_GetBuffTimeRemaining("player", "Omen of Clarity") < 540 then
        CancelUnitBuff("player", "Omen of Clarity")
        ready = false
    end
    return ready
end