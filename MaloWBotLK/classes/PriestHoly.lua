
function mb_Priest_HolyOnUpdate()
    if mb_resurrectRaid("Resurrection") then
        return
    end

    if not UnitBuff("player", "Inner Fire") then
        CastSpellByName("Inner Fire")
        return
    end

    if UnitAffectingCombat("Malowtank") and mb_unitHealthPercentage("Malowtank") < 20 then
        mb_castSpellOnFriendly("Malowtank", "Guardian Spirit")
        return
    end

    if UnitBuff("player", "Surge of Light") then
        if mb_canCastSpell("Flash Heal") then
            local healUnit, missingHealth =  mb_getMostDamagedFriendly("Flash Heal")
            if missingHealth > 2000 then
                mb_castSpellOnFriendly(healUnit, "Flash Heal")
                return
            end
        end
    end

    if mb_canCastSpell("Circle of Healing") then
        local healUnit, missingHealth =  mb_getMostDamagedFriendly("Circle of Healing")
            if missingHealth > 2000 then
                mb_castSpellOnFriendly(healUnit, "Circle of Healing")
            return
        end
    end

    if not mb_unitHasMyBuff("Malowtank", "Prayer of Mending") and UnitAffectingCombat("Malowtank") then
        mb_castSpellOnFriendly("Malowtank", "Prayer of Mending")
        return
    end
end