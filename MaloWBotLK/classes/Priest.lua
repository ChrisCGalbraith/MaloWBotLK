function mb_Priest_OnLoad()
    local _, _, disciplinePoints = GetTalentTabInfo(1)
    local _, _, holyPoints = GetTalentTabInfo(2)
    local _, _, shadowPoints = GetTalentTabInfo(3)
    if disciplinePoints > holyPoints and disciplinePoints > shadowPoints then
        mb_sayRaid("Discipline spec is not supported yet")
    elseif shadowPoints > disciplinePoints and shadowPoints > holyPoints then
        mb_sayRaid("Shadow spec is not supported yet")
    else
        mb_classSpecificRunFunction = mb_Priest_HolyOnUpdate
    end

    mb_registerDesiredBuff(BUFF_KINGS)
    mb_registerDesiredBuff(BUFF_WISDOM)
    mb_registerDesiredBuff(BUFF_SANCTUARY)
    mb_registerDesiredBuff(BUFF_INTELLECT)
    mb_registerDesiredBuff(BUFF_MOTW)
    mb_registerDesiredBuff(BUFF_FORT)
    mb_registerDesiredBuff(BUFF_SPIRIT)
    mb_registerDesiredBuff(BUFF_SHADOW_PROT)

    if UnitName("player") == "Khalia" then
        mb_registerMessageHandler(BUFF_FORT.requestType, mb_Priest_fortHandler)
        mb_registerMessageHandler(BUFF_SPIRIT.requestType, mb_Priest_spiritHandler)
        mb_registerMessageHandler(BUFF_SHADOW_PROT.requestType, mb_Priest_shadowHandler)
    end

end

function mb_Priest_handlePrayer(targetPlayerName, greaterSpell)-- singleSpell)
    if UnitAffectingCombat("player") then
        return
    end

    if mb_buffMode == false then
        return
    end

    if mb_castSpellOnSelf(greaterSpell) then
        CastSpellByName(greaterSpell)
        return true
    end
  --  mb_castSpellOnFriendly(mb_getUnitForPlayerName(targetPlayerName), singleSpell)
end

function mb_Priest_fortHandler(msg, from)
    mb_Priest_handlePrayer(from, "Prayer of Fortitude")-- "Power Word: Fortitude")
end

function mb_Priest_spiritHandler(msg, from)
    mb_Priest_handlePrayer(from, "Prayer of Spirit")-- "Divine Spirit")
end

function mb_Priest_shadowHandler(msg, from)
    mb_Priest_handlePrayer(from, "Prayer of Shadow Protection")-- "Shadow Protection")
end
