function mb_Mage_ArcaneOnUpdate()
    AssistUnit(mb_commanderUnit)

    if mb_DrinkIfGood() then
        return
    end

    local _, _, text = UnitCastingInfo("player")
    if text == "Channeling" then
        return
    end

    if not UnitBuff("player", "Molten Armor") then
        CastSpellByName("Molten Armor")
        return
    end

    mb_Mage_handleManaGem("Mana Sapphire")

    if not UnitBuff("Kisaana", "Focus Magic") then
        mb_castSpellOnFriendly("Kisaana", "Focus Magic")
    end

    if mb_cleanseRaid("Cleanse Spirit", "Curse", "Poison", "Disease") then
        return
    end

    if not mb_hasValidOffensiveTarget() then
        return
    end

    if mb_unitPowerPercentage("player") < 50 and mb_canCastSpell("Evocation") then
        CastSpellByName("Evocation")
        return
    end

   --if unitPowerPercentage("player") < 70 and mb_UseItem("Mana Sapphire") then
   --     return
  --  end

    if UnitHealth("target") > (UnitHealthMax("player") * 3) and UnitAffectingCombat("player") then
        mb_castSpellOnSelf("Arcane Power")
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
