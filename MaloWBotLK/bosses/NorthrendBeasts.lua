mb_BossModule_NorthrendBeasts_Phase = 1
function mb_BossModule_NorthrendBeasts_PreOnUpdate()

    if mb_IsTank() and UnitName("target") == "Icehowl" then
        mb_BossModule_NorthrendBeasts_Phase = 3
        return mb_BossModule_Icehowl_Tank_OnUpdate()
    end
--[[
    if mb_IsTank() and (UnitName("target") == "Dreadscale" or UnitName("target") == "Acidmaw") then
        mb_BossModule_NorthrendBeasts_Phase = 2
        return mb_BossModule_Dreadscale_Tank_OnUpdate()
    end

    if mb_IsTank() and UnitName("target") == "Gormok the Impaler" then
        return mb_BossModule_Gormok_Tank_OnUpdate()
    end

    if mb_IsCaster() and mb_BossModule_NorthrendBeasts_Phase == 1 then
        return mb_BossModule_Gormok_Caster_OnUpdate()
    end
]]--
    return false
end


--[[
function mb_BossModule_Gormok_Tank_OnUpdate()
    if UnitName("target") ~= "Gormok the Impaler" or mb_BossModule_NorthrendBeasts_Phase ~= 1 then
        return false
    end

    if not UnitIsUnit("player", "targettarget") then
        if not UnitDebuff("player", "Impale") then
            if mb_GetClass("player") == "PALADIN" then
                if mb_CastSpellOnTarget("Hand of Reckoning") then
                    return true
                end
            elseif mb_GetClass("player") == "DRUID" then
                if mb_CastSpellOnTarget("Growl") then
                    return true
                end
            end
        end
    end

    return false
end

function mb_BossModule_Gormok_Caster_OnUpdate()
    if mb_BossModule_NorthrendBeasts_Phase ~= 1 then
        return false
    end
    -- Grab gormok by assist, set focus to watch for staggering stomp
    TargetUnit("Gormok the Impaler")
    if UnitName("target") == "Gormok the Impaler" then
        FocusUnit("target")
    end

    -- Boss spell cast
    local spell, _, _, _, _, endTime = UnitCastingInfo("focus")
    -- Our spell cast
    local myspell, _, _, _, _, myEnd = UnitCastingInfo("player")
    if spell ~= nil and myspell ~= nil then
        if spell == "Staggering Stomp" and myEnd > endTime then
            mb_Say("Enemy cast ends at: " .. myEnd)
            mb_Say("My cast ends at: " .. endTime)
            mb_SayRaid("Stopping Casting!")
            mb_StopCast()
            return true
        end
    end

    if not mb_IsHealer() then
        TargetUnit("Snobold Vassal")
        if UnitName("target") == "Snobold Vassal" and not UnitIsDead("target") then
            return false
        else
            TargetUnit("Gormok the Impaler")
            return false
        end
    end
    TargetUnit("Gormok the Impaler")
    return false
end

function mb_BossModule_Dreadscale_Tank_OnUpdate()
   return false
end
]]--

mb_BossModule_NorthrendBeasts_lastDetectedCrash = 0
mb_BossModule_NorthrendBeasts_isMovingAfterCrash = false
function mb_BossModule_Icehowl_Tank_OnUpdate()
    local timeSinceCrash = mb_time - mb_BossModule_NorthrendBeasts_lastDetectedCrash
    if timeSinceCrash < 6.5 then
        mb_DisableAutomaticMovement()
        mb_BossModule_NorthrendBeasts_isMovingAfterCrash = false
    end
    return false
end

function mb_BossModule_NorthrendBeasts_CombatLogCallback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    if arg6 == "Icehowl" and arg4 == "SPELL_CAST_SUCCESS" and arg12 == "Massive Crash" then
        mb_BossModule_Kelthuzad_lastDetectedCrash = mb_time
        mb_SayRaid("Crash: " .. mb_BossModule_NorthrendBeasts_lastDetectedCrash)
    end
end

function mb_BossModule_NorthrendBeasts_OnLoad()
    mb_BossModule_PreOnUpdate = mb_BossModule_NorthrendBeasts_PreOnUpdate
end

mb_BossModule_RegisterModule("north", mb_BossModule_NorthrendBeasts_OnLoad)