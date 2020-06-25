function mb_Mage_Arcane_OnUpdate()

    if mb_Drink() then
        return
    end

    local _, _, text = UnitChannelInfo("player")
    if text == "Channeling" then
        return
    end

    if not UnitBuff("player", "Molten Armor") then
        CastSpellByName("Molten Armor")
        return
    end

    mb_Mage_HandleManaGem("Mana Sapphire")

    if not UnitBuff("Ceolmar", "Focus Magic") then
        mb_CastSpellOnFriendly("Ceolmar", "Focus Magic")
    end

    if mb_CleanseRaid("Remove Curse", "Curse", "Poison", "Disease") then
        return
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

    if mb_UnitPowerPercentage("player") < 35 and mb_CanCastSpell("Evocation") then
        CastSpellByName("Evocation")
        return
    end

    if mb_UnitPowerPercentage("player") < 75 and UnitAffectingCombat("player") then
        mb_UseItem("Mana Sapphire")
    end

    if UnitHealth("target") > (UnitHealthMax("player") * 50) and UnitAffectingCombat("player") then
        if mb_CanCastSpell("Arcane Power") then
            mb_CastSpellWithoutTarget("Arcane Power")
        end

        if mb_CanCastSpell("Icy Veins") then
            mb_CastSpellWithoutTarget("Icy Veins")
        end

        if mb_CanCastSpell("Mirror Image") then
            mb_CastSpellWithoutTarget("Mirror Image")
            return
        end
    end

    local _, _, _, count = UnitDebuff("player", "Arcane Blast")
    if UnitDebuff("player", "Arcane Blast") ~= nil and UnitAffectingCombat("player") then
        if count >= 3 then
            if UnitBuff("player", "Missile Barrage") then
                CastSpellByName("Arcane Missiles")
                return
            else
                CastSpellByName("Arcane Barrage")
                return
            end
            return
        end
    end

    CastSpellByName("Arcane Blast")
end
