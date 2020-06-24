function mb_Mage_OnLoad()
    local _, _, arcanePoints = GetTalentTabInfo(1)
    local _, _, firePoints = GetTalentTabInfo(2)
    local _, _, frostPoints = GetTalentTabInfo(3)
    if arcanePoints > firePoints and arcanePoints > frostPoints then
        mb_classSpecificRunFunction = mb_Mage_ArcaneOnUpdate
    elseif frostPoints > arcanePoints and frostPoints > firePoints then
        mb_sayRaid("Frost spec is not supported yet")
    else
        mb_classSpecificRunFunction = mb_Mage_FireOnUpdate
    end

	if UnitName("player") == "Trudy" then
        mb_registerMessageHandler(BUFF_INTELLECT.requestType, mb_Mage_intellectHandler)
	end

    mb_registerDesiredBuff(BUFF_KINGS)
    mb_registerDesiredBuff(BUFF_WISDOM)
    mb_registerDesiredBuff(BUFF_SANCTUARY)
    mb_registerDesiredBuff(BUFF_INTELLECT)
    mb_registerDesiredBuff(BUFF_MOTW)
    mb_registerDesiredBuff(BUFF_FORT)
    mb_registerDesiredBuff(BUFF_SPIRIT)
    mb_registerDesiredBuff(BUFF_SHADOW_PROT)
end

function mb_Mage_handleIntellect(targetPlayerName, greaterSpell)--, singleSpell)
    if UnitAffectingCombat("player") then
        return
    end

    if mb_buffMode == false then
        return
    end

    if mb_castSpellOnSelf(greaterSpell) then
        return
    end
    --mb_castSpellOnFriendly(mb_getUnitForPlayerName(targetPlayerName), singleSpell)
end

function mb_Mage_intellectHandler(msg, from)
    mb_Mage_handleIntellect(from, "Arcane Brilliance")--, "Arcane Intellect")
end

function mb_Mage_handleManaGem(itemName)
    if not mb_GetItemLocation(itemName) then
        CastSpellByName("Conjure Mana Gem")
        return true
    end

    return false
end