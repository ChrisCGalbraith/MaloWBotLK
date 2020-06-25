function mb_Mage_OnLoad()
    local _, _, arcanePoints = GetTalentTabInfo(1)
    local _, _, firePoints = GetTalentTabInfo(2)
    local _, _, frostPoints = GetTalentTabInfo(3)
    if arcanePoints > firePoints and arcanePoints > frostPoints then
        mb_classSpecificRunFunction = mb_Mage_Arcane_OnUpdate
    elseif frostPoints > arcanePoints and frostPoints > firePoints then
        mb_SayRaid("Frost spec is not supported yet")
    else
        mb_classSpecificRunFunction = mb_Mage_Fire_OnUpdate
    end

	if UnitName("player") == "Trudy" then
        mb_RegisterMessageHandler(BUFF_INTELLECT.requestType, mb_Mage_IntellectHandler)
	end

    mb_RegisterDesiredBuff(BUFF_KINGS)
    mb_RegisterDesiredBuff(BUFF_WISDOM)
    mb_RegisterDesiredBuff(BUFF_SANCTUARY)
    mb_RegisterDesiredBuff(BUFF_INTELLECT)
    mb_RegisterDesiredBuff(BUFF_MOTW)
    mb_RegisterDesiredBuff(BUFF_FORT)
    mb_RegisterDesiredBuff(BUFF_SPIRIT)
    mb_RegisterDesiredBuff(BUFF_SHADOW_PROT)
end

function mb_Mage_HandleIntellect(targetPlayerName, greaterSpell)--, singleSpell)
    if not mb_ShouldBuff() then
        return
    end

    if mb_CastSpellWithoutTarget(greaterSpell) then
        return
    end
    --mb_CastSpellWithoutTarget(mb_getUnitForPlayerName(targetPlayerName), singleSpell)
end

function mb_Mage_IntellectHandler(msg, from)
    mb_Mage_HandleIntellect(from, "Arcane Brilliance")--, "Arcane Intellect")
end

function mb_Mage_HandleManaGem(itemName)
    if not mb_GetItemLocation(itemName) then
        CastSpellByName("Conjure Mana Gem")
        return true
    end

    return false
end