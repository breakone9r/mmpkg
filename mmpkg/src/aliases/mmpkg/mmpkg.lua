if (matches[2] == "config") then
    if (matches[3] == "fontsize") then
        cecho("\n<white>Setting fontsize to: "..matches[4].."\n")
        mmpkg.conf.fontsize = tonumber(matches[4])
        setFontSize(tonumber(matches[4]))
        mmpkg.Captures:setFontSize(tonumber(matches[4]))
        table.save(mmpkg.resources .. "/mmpkg.conf",mmpkg.conf)
    elseif (matches[3] == "timestamps") then
        if (mmpkg.conf.timestamps == true) then
            cecho("\n<white>Disabling Timestamps\n")
            mmpkg.conf.timestamps = false
            mmpkg.Captures:disableTimestamp()
            table.save(mmpkg.resources .. "/mmpkg.conf",mmpkg.conf)
        else
            cecho("\n<white>Enabling Timestamps\n")
            mmpkg.conf.timestamps = true
            mmpkg.Captures:enableTimestamp()
            table.save(mmpkg.resources .. "/mmpkg.conf",mmpkg.conf)
        end
    elseif (matches[3] == "tabs") then
        cecho("\n<white:red>Sorry, Disabling/Enabling Tabs is not yet supported.\n")
    elseif (matches[3] == "localonly") then
        if (mmpkg.conf.areaonly == false) then
            cecho("\n<yellow>mapper where <white> now searches only local rooms\n")
            mmpkg.conf.areaonly = true
            table.save(mmpkg.resources .. "/mmpkg.conf",mmpkg.conf)
        else
            cecho("\n<yellow>mapper where <white> now searches all rooms\n")
            mmpkg.conf.areaonly = false
            table.save(mmpkg.resources .. "/mmpkg.conf",mmpkg.conf)
        end
    else
        cecho("\n<white:red>ERROR: You must say what to configure: fontsize, timestamps, tabs, localonly\n")
    end
else
    local TimeStamps = {}
    local LocalOnly = {}
    if mmpkg.conf.timestamps == true then TimeStamps = "On" else TimeStamps = "Off" end
    if mmpkg.conf.areaonly == true then LocalOnly = "mapper where shows only local results" else LocalOnly = "mapper where shows all results" end
    cecho("\n<cyan>mmpkg settings:")
    cecho("\n<green>    LocalOnly  : " .. LocalOnly)
    cecho("\n<green>    Fontsize   : " .. mmpkg.conf.fontsize)
    cecho("\n<green>    Timestamps : " .. TimeStamps)
    cecho("\n<green>    Tabs       : " .. table.concat(mmpkg.conf.tabs," ").."\n")
end