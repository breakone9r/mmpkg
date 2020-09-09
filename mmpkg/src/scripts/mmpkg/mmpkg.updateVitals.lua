function mmpkg.updateVitals()
  if not mmpkg.mymaxhp then
    mmpkg.mymaxhp = 4000
  end
  if not mmpkg.mymaxsp then
    mmpkg.mymaxsp = 4000
  end
  if not mmpkg.mymaxst then
    mmpkg.mymaxst = 4000
  end
  if not mmpkg.tnlpct then
    mmpkg.tnlpct = 100
  end
  mmpkg.myhp, mmpkg.mysp, mmpkg.myst =
    tonumber(gmcp.char.vitals.hp),
    tonumber(gmcp.char.vitals.sp),
    tonumber(gmcp.char.vitals.st)
  if (mmpkg.tnlpct < 1) then
    mmpkg.tnlpct = 0
  end

  -- This kludge is necessary due to gmcp max stats not updating if you die and get max hp/sp/st while dead.
  if (mmpkg.mymaxhp < mmpkg.myhp) then
    mmpkg.mymaxhp = mmpkg.myhp
  end
  if (mmpkg.mymaxsp < mmpkg.mysp) then
    mmpkg.mymaxsp = mmpkg.mysp
  end
  if (mmpkg.mymaxst < mmpkg.myst) then
    mmpkg.mymaxst = mmpkg.myst
  end
  GUI.Health:update(mmpkg.myhp / mmpkg.mymaxhp)
  GUI.HPLabel:echo("<center>" .. mmpkg.myhp .. "/" .. mmpkg.mymaxhp .. "hp</center>")
  GUI.Spellpower:update(mmpkg.mysp / mmpkg.mymaxsp)
  GUI.SPLabel:echo("<center>" .. mmpkg.mysp .. "/" .. mmpkg.mymaxsp .. "sp</center>")
  GUI.Stamina:update(mmpkg.myst / mmpkg.mymaxst)
  GUI.STLabel:echo("<center>" .. mmpkg.myst .. "/" .. mmpkg.mymaxst .. "st</center>")
  GUI.XPgauge:update(mmpkg.tnlpct/100)
  GUI.XPLabel:echo("<center>Exp: " .. mmpkg.tnlpct .. "%</center>")
end
