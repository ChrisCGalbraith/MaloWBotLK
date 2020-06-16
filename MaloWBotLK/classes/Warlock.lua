function mb_Warlock_OnLoad()
    local _, _, afflictionPoints = GetTalentTabInfo(1)
    local _, _, demonologyPoints = GetTalentTabInfo(2)
    local _, _, destructionPoints = GetTalentTabInfo(3)
    if afflictionPoints > demonologyPoints and afflictionPoints > destructionPoints then
        mb_classSpecificRunFunction = mb_Warlock_AfflictionOnUpdate
    elseif destructionPoints > afflictionPoints and destructionPoints > demonologyPoints then
        mb_sayRaid("Destruction spec is not supported yet")
    else
        mb_sayRaid("Destruction spec is not supported yet")
    end

    mb_registerDesiredBuff(BUFF_KINGS)
    mb_registerDesiredBuff(BUFF_WISDOM)
    mb_registerDesiredBuff(BUFF_SANCTUARY)
    mb_registerDesiredBuff(BUFF_INTELLECT)
    mb_registerDesiredBuff(BUFF_MOTW)
    mb_registerDesiredBuff(BUFF_FORT)
    mb_registerDesiredBuff(BUFF_SPIRIT)
    mb_registerDesiredBuff(BUFF_SHADOW_PROT)
end

-- Checks if the player has any pet active, if they don't then summons Felhunter.
-- Does not differentiate between pets, if you have an Imp summoned, the function will fail.
function mb_Warlock_handlePetSummon(spell)
    if not UnitAffectingCombat("player") and not PetHasActionBar() then
        local _, _, displayName = UnitCastingInfo("player")
        if displayName == spell then
            return false
        end
        CastSpellByName(spell)
        return true
    end
end
