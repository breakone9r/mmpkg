function mmpkg.updateXP()
  mmpkg.tnlpct = gmcp.char.status.tnlpct
  if (gmcp.char.status.level < 60 and gmcp.char.status.totallevel < 240) then
    setBorderBottom(75)
    GUI.VitalBars:move(x, -50)
    GUI.XPbar:show()
  else
    GUI.VitalBars:move(x, -25)
    GUI.XPbar:hide()
    setBorderBottom(50)
  end
end
