function mb_Priest_OnLoad()
    local _, _, disciplinePoints = GetTalentTabInfo(1)
    local _, _, holyPoints = GetTalentTabInfo(2)
    local _, _, shadowPoints = GetTalentTabInfo(3)
    if disciplinePoints > holyPoints and disciplinePoints > shadowPoints then
        mb_classSpecificRunFunction = mb_Priest_Discipline_OnUpdate
        mb_Priest_Discipline_OnLoad()
    elseif shadowPoints > disciplinePoints and shadowPoints > holyPoints then
        mb_SayRaid("Shadow spec is not supported yet")
    else
        mb_classSpecificRunFunction = mb_Priest_Holy_OnUpdate
        mb_Priest_Holy_OnLoad()
    end

    mb_RegisterDesiredBuff(BUFF_KINGS)
    mb_RegisterDesiredBuff(BUFF_WISDOM)
    mb_RegisterDesiredBuff(BUFF_SANCTUARY)
    mb_RegisterDesiredBuff(BUFF_INTELLECT)
    mb_RegisterDesiredBuff(BUFF_MOTW)
    mb_RegisterDesiredBuff(BUFF_FORT)
    mb_RegisterDesiredBuff(BUFF_SPIRIT)
    mb_RegisterDesiredBuff(BUFF_SHADOW_PROT)

    if UnitName("player") == "Khalia" then
        mb_RegisterMessageHandler(BUFF_FORT.requestType, mb_Priest_FortHandler)
        mb_RegisterMessageHandler(BUFF_SPIRIT.requestType, mb_Priest_SpiritHandler)
        mb_RegisterMessageHandler(BUFF_SHADOW_PROT.requestType, mb_Priest_ShadowHandler)
    end

end

function mb_Priest_HandlePrayer(targetPlayerName, greaterSpell)-- singleSpell)
    if not mb_ShouldBuff() then
        return
    end

    if mb_CastSpellWithoutTarget(greaterSpell) then
        return
    end
  --  mb_CastSpellWithoutTarget(mb_getUnitForPlayerName(targetPlayerName), singleSpell)
end

function mb_Priest_FortHandler(msg, from)
    mb_Priest_HandlePrayer(from, "Prayer of Fortitude")-- "Power Word: Fortitude")
end

function mb_Priest_SpiritHandler(msg, from)
    mb_Priest_HandlePrayer(from, "Prayer of Spirit")-- "Divine Spirit")
end

function mb_Priest_ShadowHandler(msg, from)
    mb_Priest_HandlePrayer(from, "Prayer of Shadow Protection")-- "Shadow Protection")
end

function mb_Priest_HealCdAcceptor(message, from)
    if not mb_CanCastSpell("Divine Hymn") then
        return false
    end
    if mb_UnitPowerPercentage("player") < 15 then
        return false
    end
    return true
end

function mb_Priest_HealCdExecutor(message, from)
    mb_SayRaid("Using Divine Hymn!")
    mb_SayRaid("Do not falter my brave Heroes! Let my music heal your Hearts!")
    mb_Priest_Holy_useCooldownsCommandTime = mb_time
    return true
end
