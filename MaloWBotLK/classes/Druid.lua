function mb_Druid_OnLoad()
    local _, _, balancePoints = GetTalentTabInfo(1)
    local _, _, feralPoints = GetTalentTabInfo(2)
    local _, _, restorationPoints = GetTalentTabInfo(3)
    if balancePoints > feralPoints and balancePoints > restorationPoints then
        mb_classSpecificRunFunction = mb_Druid_BalanceOnUpdate
    elseif restorationPoints > balancePoints and restorationPoints > feralPoints then
        mb_classSpecificRunFunction = mb_Druid_RestorationOnUpdate
    else
        mb_classSpecificRunFunction = mb_Druid_FeralOnUpdate
    end

   -- if UnitName("player") == "Gwethriel" then
   --     mb_registerMessageHandler(BUFF_MOTW.requestType, mb_Druid_motwHandler)
   --     return
    -- end


    mb_registerDesiredBuff(BUFF_KINGS)
    mb_registerDesiredBuff(BUFF_WISDOM)
    mb_registerDesiredBuff(BUFF_MIGHT)
    mb_registerDesiredBuff(BUFF_SANCTUARY)
    mb_registerDesiredBuff(BUFF_INTELLECT)
    mb_registerDesiredBuff(BUFF_MOTW)
    mb_registerDesiredBuff(BUFF_FORT)
    mb_registerDesiredBuff(BUFF_SPIRIT)
    mb_registerDesiredBuff(BUFF_SHADOW_PROT)
end

function mb_Druid_handleMotw(targetPlayerName, greaterSpell, singleSpell)
    if UnitAffectingCombat("player") then
        return
    end

    if mb_castSpellOnSelf(greaterSpell) then
        CastSpellByName("Gift of the Wild")
        return
    end
    mb_castSpellOnFriendly(mb_getUnitForPlayerName(targetPlayerName), singleSpell)
end

function mb_Druid_motwHandler(msg, from)
    mb_Druid_handleMotw(from, "Gift of the Wild",  "Mark of the Wild")
end
