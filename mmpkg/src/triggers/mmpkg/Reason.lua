mmpkg.pagedreason = matches[2]
-- mmpkg.Captures:cecho("All","<red:white>[PAGE] "..mmpkg.pagedby..": "..mmpkg.pagedreason .."\n")
mmpkg.PagesCon = Geyser.UserWindow:new({
    name = "mmpkg.PagesCon",
    titleText = "Pages",
    x = "20%",
    y = "20%",
    width = "30%",
    height = "40%"
})

mmpkg.Pages = Geyser.MiniConsole:new({
    name = "mmpkg.Pages",
    x = 0,
    y = 0,
    autoWrap = true,
    color = "black",
    scrollBar = false,
    fontSize = 10,
    width = -5,
    height = -5
}, mmpkg.PagesCon)
mmpkg.Pages:cecho("<white>" .. getTime(true, "hh:mm:ss") ..
                      " <red:white>[PAGE] " .. mmpkg.pagedby .. ": " ..
                      mmpkg.pagedreason .. "\n")
