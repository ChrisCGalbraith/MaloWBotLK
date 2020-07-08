function mb_Mage_Arcane_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end

    local _, _, _, count = UnitDebuff("player", "Arcane Blast")

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

    if mb_Mage_HandleManaGem("Mana Sapphire") then
        return
    end

    if not UnitBuff("Ceolmar", "Focus Magic") then
        if mb_CastSpellOnFriendly("Ceolmar", "Focus Magic") then
            return
        end
    end

    if mb_CleanseRaid("Remove Curse", "Curse") then
        return
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

    if mb_UnitPowerPercentage("player") < 35 and mb_CanCastSpell("Evocation") then
        if count ~= nil then
            mb_Mage_DischargeBlastStacks()
            return
        end
        CastSpellByName("Evocation")
        return
    end

    if mb_UnitPowerPercentage("player") < 65 and UnitAffectingCombat("player") then
        mb_UseItem("Mana Sapphire")
    end

--	if mb_cleaveMode > 0 and mb_CastSpellWithoutTarget("Arcane Explosion") then
 --       return
 --   end

    if mb_ShouldUseDpsCooldowns("Arcane Blast") and UnitAffectingCombat("player") then
        mb_UseItemCooldowns()
        if mb_CastSpellWithoutTarget("Mirror Image") then
            return
        end

        if mb_CastSpellWithoutTarget("Icy Veins") then
            mb_SendExclusiveRequest("power_infusion", "")
        end
        mb_CastSpellWithoutTarget("Arcane Power")
    end

    if UnitDebuff("player", "Arcane Blast") ~= nil and UnitAffectingCombat("player") then
        if mb_UnitPowerPercentage("player") > 10 then
            if count > 3 then
                mb_Mage_DischargeBlastStacks()
                return
            end

        elseif mb_UnitPowerPercentage("player") <= 10 then
            if count >= 2 then
                mb_Mage_DischargeBlastStacks()
                return
            end
        end
    end

    if mb_IsMoving() and mb_CastSpellOnTarget("Arcane Barrage") then
        return
    end

    if mb_CastSpellOnTarget("Arcane Blast") then
        return
    end
end


function mb_Mage_DischargeBlastStacks()
    if UnitBuff("player", "Missile Barrage") then
        if mb_CastSpellOnTarget("Arcane Missiles") then
            return
        end

    elseif mb_CastSpellOnTarget("Arcane Barrage") then
        return
    end
end