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
    else
        cecho("\n<white:red>ERROR: You must say what to configure: fontsize, timestamps, tabs\n")
    end
else
    local TimeStamps
    if mmpkg.conf.timestamps == true then TimeStamps = "On" else TimeStamps = "Off" end
    cecho("\n<cyan>mmpkg settings:")
    cecho("\n<green>    Fontsize:     " .. mmpkg.conf.fontsize)
    cecho("\n<green>    Timestamps:   " .. TimeStamps)
    cecho("\n<green>    Enabled Tabs: " .. table.concat(mmpkg.conf.tabs," ").."\n")
end