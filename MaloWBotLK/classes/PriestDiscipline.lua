-- TO DO --
-- UNIT_AURA
-- UNIT_SPELLCAST_SENT


mb_lastRaptureTime = 0
function mb_Priest_Discipline_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end

    if mb_Drink() then
        return
    end

    if mb_ResurrectRaid("Resurrection") then
        return
    end

    if not UnitBuff("player", "Inner Fire") then
        CastSpellByName("Inner Fire")
        return
    end

end

function mb_Priest_GetRaptureTime()
    local time = mb_time
end