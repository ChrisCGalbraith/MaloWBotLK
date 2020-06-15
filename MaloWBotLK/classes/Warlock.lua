function mb_Warlock_OnLoad()
    local _, _, afflictionPoints = GetTalentTabInfo(1)
    local _, _, demonologyPoints = GetTalentTabInfo(2)
    local _, _, destructionPoints = GetTalentTabInfo(3)
    if afflictionPoints > demonologyPoints and afflictionPoints > destructionPoints then
        mb_classSpecificRunFunction = mb_Warlock_AfflictionOnUpdate
    elseif destructionPoints > afflictionPoints and destructionPoints > demonologyPoints then
        mb_sayRaid("Destruction spec is not supported yet")
    else
        mb_classSpecificRunFunction = mb_Warlock_DemonologyOnUpdate
    end

    mb_registerDesiredBuff(BUFF_KINGS)
    mb_registerDesiredBuff(BUFF_WISDOM)
    mb_registerDesiredBuff(BUFF_SANC)
    mb_registerDesiredBuff(BUFF_INTELLECT)
    mb_registerDesiredBuff(BUFF_MOTW)
    mb_registerDesiredBuff(BUFF_FORT)
    mb_registerDesiredBuff(BUFF_SPIRIT)
    mb_registerDesiredBuff(BUFF_SHADOW_PROT)
end
