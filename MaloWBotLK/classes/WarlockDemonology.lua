
function mb_Warlock_DemonologyOnUpdate()
    mb_Warlock_HandlePetSummon("Summon Felguard")

    mb_Warlock_HandleFelhunterAutoCasts("Anguish", "Cleave")

    if not mb_Warlock_HandleStones("Grand Spellstone") then
        return
    end

    if UnitExists("playerpet") then
        PetPassiveMode()
    end

    local _, _, text = UnitChannelInfo("player")
    if text == "Channeling" then
        return
    end

    mb_Warlock_HandleLifeTap()

    if not UnitBuff("player", "Fel Armor") then
        CastSpellByName("Fel Armor")
        return
    end

    if mb_UnitPowerPercentage("player") < 15  and mb_UnitHealthPercentage("player") > 30 then
        CastSpellByName("Life Tap")
        return
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

    if UnitExists("playerpet") then
        PetAttack()
    end

    if mb_ShouldUseDpsCooldowns("Shadow Bolt") and UnitAffectingCombat("player") then
        mb_UseItemCooldowns()
    end

    if mb_cleaveMode > 0 and not mb_TargetHasMyDebuff("Seed of Corruption") and mb_CastSpellOnTarget("Seed of Corruption") then
        return
    end

    if not mb_TargetHasMyDebuff("Corruption") and mb_CastSpellOnTarget("Corruption") then
        return
    end

    if mb_UnitHealthPercentage("target") < 35 then
        if not UnitBuff("player", "Decimation") then
            if mb_CastSpellOnTarget("Shadow Bolt") then
                return
            end
        else
            if mb_CastSpellOnTarget("Soul Fire") then
                return
            end
        end
    end

    if not mb_TargetHasMyDebuff("Immolate") and mb_CastSpellOnTarget("Immolate") then
        return
    end

    if UnitBuff("player", "Molten Core") then
        if mb_CastSpellOnTarget("Incinerate") then
            return
        end
    end

    CastSpellByName("Shadow Bolt")
end

