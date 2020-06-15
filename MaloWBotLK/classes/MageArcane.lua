function mb_Mage_ArcaneOnUpdate()
    AssistUnit(mb_commanderUnit)

    if not mb_hasValidOffensiveTarget() then
        return
    end

    local _, _, text = UnitChannelInfo("player")
    if text == "Channeling" then
        return
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
