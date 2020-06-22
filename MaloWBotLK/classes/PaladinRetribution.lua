-- TODO:
-- Weave in Exorcisms when healing is not needed
-- Holy Wrath if fighting undead
-- Lay on Hands on someone really low in the raid
-- Divine Protection pre-taking damage, probably through a "use personals" macro
-- Divine Sacrifice, some sexy rotation or requested 1 by 1?
-- Hammer of Justice targets, both as interrupt and as stun
-- Hand of Freedom when someone or self is slowed
-- Hand of Protection on a friendly who has aggro who shouldn't have aggro
-- Hand of Reckoning if the tank is almost undead, maybe as the prot in waiting, equipping a shield and using SotR and a personal CD
-- Hand of Sacrifice, probably on tank on rotation
-- Hand of Salvation constantly on people with high threat
-- Use Every Man For Himself on loss of control
-- Start using on-use trinkets

function mb_Paladin_Retribution_OnUpdate()
    if mb_IsOnGCD() then
        return
    end

    if mb_ResurrectRaid("Redemption") then
        return
    end

    if UnitAffectingCombat("player") and mb_UnitHealthPercentage("player") < 30 and mb_CastSpellWithoutTarget("Divine Shield") then
        return
    end

    if UnitBuff("player", "The Art of War") and not UnitBuff("player", "Divine Plea") then
        if mb_Paladin_FlashOfLightRaid() then
            return
        end
    end

    if mb_Paladin_CastAura() then
        return
    end

    if mb_Paladin_Retribution_CastSeal() then
        return
    end

    if mb_CleanseRaid("Cleanse", "Magic", "Poison", "Disease") then
        return
    end

    if mb_UnitPowerPercentage("player") < 60 and mb_CastSpellWithoutTarget("Divine Plea") then
        return
    end

    if not UnitAffectingCombat("player") and not UnitBuff("player", "Sacred Shield") and mb_CastSpellOnFriendly("player", "Sacred Shield") then
        return
    end

    AssistUnit(mb_commanderUnit)
    if not mb_HasValidOffensiveTarget() then
        if not UnitBuff("player", "Divine Plea") and mb_UnitPowerPercentage("player") > 30 then
            if mb_Paladin_FlashOfLightRaid() then
                return
            end
        end
        return
    end

    if not mb_isAutoAttacking then
        InteractUnit("target")
    end

    if mb_ShouldUseDpsCooldowns() and mb_IsSpellInRange("Crusader Strike", "target") then
        if mb_CastSpellWithoutTarget("Avenging Wrath") then
            return
        end
    end

    if mb_CastSpellOnTarget("Judgement of Wisdom") then
        return
    end

    if mb_CastSpellOnTarget("Hammer of Wrath") then
        return
    end

    if UnitBuff("player", "The Art of War") and mb_CastSpellOnTarget("Exorcism") then
        return
    end

    if mb_CastSpellOnTarget("Crusader Strike") then
        return
    end

    if mb_IsSpellInRange("Crusader Strike", "target") and mb_CastSpellWithoutTarget("Divine Storm") then
        return
    end

    if mb_IsSpellInRange("Crusader Strike", "target") and mb_UnitPowerPercentage("player") > 20 then
        if mb_CastSpellWithoutTarget("Consecration") then
            return
        end
    end

    if not UnitBuff("player", "Sacred Shield") and mb_CastSpellOnFriendly("player", "Sacred Shield") then
        return
    end

    if mb_UnitPowerPercentage("player") > 30 and not mb_IsSpellInRange("Crusader Strike", "target") then
        if not UnitBuff("player", "Divine Plea") and mb_Paladin_FlashOfLightRaid() then
            return
        end
        if mb_CastSpellOnTarget("Exorcism") then
            return
        end
    end
end

function mb_Paladin_Retribution_CastSeal()
    local spell = "Seal of Vengeance"
    if mb_cleaveMode > 0 then
        spell = "Seal of Command"
    end
    if not UnitBuff("player", spell) then
        CastSpellByName(spell)
        return true
    end
    return false
end

