mmpkg.pagedreason = matches[2]
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
mmpkg.Pages:cecho(
  "<black:gray>" ..
  getTime(true, "hh:mm:ss") .. " <black:gray>[PAGE] " .. mmpkg.pagedby .. ": " .. mmpkg.pagedreason .. "\n"
)
