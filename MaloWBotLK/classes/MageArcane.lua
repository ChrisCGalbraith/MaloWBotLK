function mb_Mage_ArcaneOnUpdate()
    AssistUnit(mb_commanderUnit)

    if not UnitBuff("player", "Molten Armor") then
        CastSpellByName("Molten Armor")
        return
    end

    if not UnitBuff("Kisaana", "Focus Magic") then
        mb_castSpellOnFriendly("Kisaana", "Focus Magic")
    end

    if not mb_hasValidOffensiveTarget() then
        return
    end

    local _, _, text = UnitCastingInfo("player")
    if text == "Channeling" then
        return
    end

    if UnitHealth("target") > (UnitHealthMax("player") * 3) and UnitAffectingCombat("player") then
        mb_castSpellOnSelf("Arcane Power")
    end

    local _, _, _, count = UnitDebuff("player", "Arcane Blast")
    if UnitDebuff("player", "Arcane Blast") ~= nil and UnitAffectingCombat("player") then
        if count >= 3 then
            if UnitBuff("player", "Missile Barrage") then
                CastSpellByName("Arcane Missiles")
            else
                CastSpellByName("Arcane Barrage")
            end
            return
        end
    end

    CastSpellByName("Arcane Blast")
end
