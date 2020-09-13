if (matches[2] == "config") then
  mmpkg.config.doWindow()
elseif (matches[2] == "pages") then
  if not mmpkg.PagesCon then
    mmpkg.PagesCon = 
    Geyser.UserWindow:new(
      {
        name = "mmpkg.PagesCon",
        titleText = "Pages",
        x = "20%",
        y = "20%",
        width = "50%",
        height = "40%"
      }
    )

    mmpkg.Pages = 
    Geyser.MiniConsole:new(
      {
        name = "mmpkg.Pages",
        x = 0,
        y = 0,
        autoWrap = true,
        color = "gray",
        scrollBar = false,
        fontSize = 10,
        width = -5,
        height = -5
      },
      mmpkg.PagesCon
    )
  else
    mmpkg.PagesCon:show()
  end
elseif (matches[2] == "update") then
  mmpkg.checkupdate(true)
else
  local cmd = matches[2] or ""
  cecho("<red:white>ERROR:<white:black> Unknown command '"..cmd.."'!\n")
  cecho("<yellow>mmpkg pages  :<white>Shows the Pages window.\n")
  cecho("<yellow>mmpkg config :<white>Shows/Sets Various configuration options.\n")
  cecho("<yellow>mmpkg update :<white>Check for, download and install updated mmpkg.\n")
end
