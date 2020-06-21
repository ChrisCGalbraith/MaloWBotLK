
function mb_Warlock_AfflictionOnUpdate()
    AssistUnit(mb_commanderUnit)

    mb_Warlock_handlePetSummon("Summon Felhunter")

    mb_Warlock_handleFelhunterAutoCasts("Shadow Bite", "Fel Intelligence")

    --mb_Warlock_handleStones("Demonic Spellstone")

    mb_Warlock_handleLifeTap()

    if not UnitBuff("player", "Fel Armor") then
        CastSpellByName("Fel Armor")
        return
    end

    if mb_unitPowerPercentage("player") < 15 then
        CastSpellByName("Life Tap")
        return
    end

    if not mb_hasValidOffensiveTarget() then
        return
    end

   -- if not mb_targetHasMyDebuff("Seed of Corruption") and mb_castSpellOnTarget("Seed of Corruption") then
   --     return
   -- end

    if not mb_targetHasMyDebuff("Corruption") and mb_castSpellOnTarget("Corruption") then
        return
    end

    if UnitBuff("player", "Shadow Trance") and mb_castSpellOnTarget("Shadow Bolt") then
        return
    end

    if not mb_targetHasMyDebuff("Curse of Agony") and mb_castSpellOnTarget("Curse of Agony") then
        return
    end

    if not mb_targetHasMyDebuff("Unstable Affliction") and mb_castSpellOnTarget("Unstable Affliction") then
        return
    end

    if not mb_targetHasMyDebuff("Haunt") and mb_castSpellOnTarget( "Haunt") then
        return
    end

    if mb_unitHealthPercentage("target") < 25 then
        if mb_targetHasMyDebuff("Drain Soul") then
            return
        end
        CastSpellByName("Drain Soul")
        return
    end

    CastSpellByName("Shadow Bolt")
end

function mb_Warlock_handleFelhunterAutoCasts(spell1, spell2)
    local _, autostate = GetSpellAutocast(spell1, "pet")
    local _, autostate2 = GetSpellAutocast(spell2, "pet")
    if autostate == nil then
        TogglePetAutocast(6)
    end
    if autostate2 == nil then
        TogglePetAutocast(4)
    end
end