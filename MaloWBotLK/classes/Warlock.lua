function mb_Warlock_OnLoad()
    local _, _, afflictionPoints = GetTalentTabInfo(1)
    local _, _, demonologyPoints = GetTalentTabInfo(2)
    local _, _, destructionPoints = GetTalentTabInfo(3)
    if afflictionPoints > demonologyPoints and afflictionPoints > destructionPoints then
        mb_classSpecificRunFunction = mb_Warlock_Affliction_OnUpdate
    elseif destructionPoints > afflictionPoints and destructionPoints > demonologyPoints then
        mb_SayRaid("Destruction spec is not supported yet")
    else
        mb_SayRaid("Demonology spec is not supported yet")
    end

    mb_RegisterDesiredBuff(BUFF_KINGS)
    mb_RegisterDesiredBuff(BUFF_WISDOM)
    mb_RegisterDesiredBuff(BUFF_SANCTUARY)
    mb_RegisterDesiredBuff(BUFF_INTELLECT)
    mb_RegisterDesiredBuff(BUFF_MOTW)
    mb_RegisterDesiredBuff(BUFF_FORT)
    mb_RegisterDesiredBuff(BUFF_SPIRIT)
    mb_RegisterDesiredBuff(BUFF_SHADOW_PROT)
end

-- Checks if the player has any pet active, if they don't then summons Felhunter.
-- Does not differentiate between pets, if you have an Imp summoned, the function will fail.
function mb_Warlock_HandlePetSummon(spell)
    if not UnitAffectingCombat("player") and not PetHasActionBar() then
        local _, _, displayName = UnitCastingInfo("player")
        if displayName == spell then
            return false
        end
        CastSpellByName(spell)
        return true
    end
end

-- NEEDS WORKING ON RETURN FUNCTIONS
function mb_Warlock_HandleStones(itemName)
    local hasMainHandEnchant = GetWeaponEnchantInfo()
    if not hasMainHandEnchant then
        if not mb_GetItemLocation(itemName) then
            if itemName == "Demonic Spellstone" then
                CastSpellByName("Create Spellstone")
                return
            end

            if itemName == "Fel Firestone" then
                CastSpellByName("Create Firestone")
                return
            end

            return
        end
        mb_UseItem(itemName)
        PickupInventoryItem(16)
        ReplaceEnchant()
    end
    return false
end

-- Rank 1 Life Tap out of combat to maintain spellpower buff.
function mb_Warlock_HandleLifeTap()
    if not UnitBuff("player", "Life Tap") and not UnitAffectingCombat("player") and mb_UnitPowerPercentage("player") > 95 then
        CastSpellByName("Life Tap(Rank 1)")
        return
    end

    if mb_UnitPowerPercentage("player") < 95 and not UnitAffectingCombat("player") then
        CastSpellByName("Life Tap")
        return
    end
end