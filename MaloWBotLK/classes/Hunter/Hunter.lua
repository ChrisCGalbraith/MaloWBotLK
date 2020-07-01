function mb_Hunter_OnLoad()
    if mb_GetMySpecName() == "Beast Mastery" then
        mb_classSpecificRunFunction = mb_Hunter_BeastMastery_OnUpdate
        mb_SpecNotSupported("Beast Mastery Hunters are not yet supported")
    elseif mb_GetMySpecName() == "Marksmanship" then
        mb_classSpecificRunFunction = mb_Hunter_Marksmanship_OnUpdate
        mb_SpecNotSupported("Marksmanship Hunters are not yet supported")
    else
        mb_classSpecificRunFunction = mb_Hunter_Survival_OnUpdate
        mb_SpecNotSupported("Survival Hunters are not yet supported")
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