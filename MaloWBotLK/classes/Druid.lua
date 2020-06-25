function mb_Druid_OnLoad()
    local _, _, balancePoints = GetTalentTabInfo(1)
    local _, _, feralPoints = GetTalentTabInfo(2)
    local _, _, restorationPoints = GetTalentTabInfo(3)
    if balancePoints > feralPoints and balancePoints > restorationPoints then
        mb_classSpecificRunFunction = mb_Druid_Balance_OnUpdate
    elseif restorationPoints > balancePoints and restorationPoints > feralPoints then
        mb_classSpecificRunFunction = mb_Druid_Restoration_OnUpdate
    else
        mb_classSpecificRunFunction = mb_Druid_Feral_OnUpdate
    end

    if UnitName("player") == "Elerien" then
        mb_RegisterMessageHandler(BUFF_MOTW.requestType, mb_Druid_motwHandler)
    end

    if UnitName("player") == "Elerien" then
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

function mb_Druid_MotwHandler(msg, from)
    mb_Druid_HandleMotw(from, "Gift of the Wild")
end

function mb_Druid_TauntHandler(msg, from)
    mb_SayRaid("Im taunting!")
    mb_CastSpellOnTarget("Growl")
end