function mmpkg.updateVitals()
    if not mmpkg.mymaxhp then mmpkg.mymaxhp = 4000 end
    if not mmpkg.mymaxsp then mmpkg.mymaxsp = 4000 end
    if not mmpkg.mymaxst then mmpkg.mymaxst = 4000 end
    if not mmpkg.tnlpct then mmpkg.tnlpct = 100 end
    mmpkg.myhp,mmpkg.mysp,mmpkg.myst = tonumber(gmcp.char.vitals.hp),tonumber(gmcp.char.vitals.sp),tonumber(gmcp.char.vitals.st)
    if (mmpkg.tnlpct < 1) then mmpkg.tnlpct = 0 end
    
    -- This kludge is necessary due to gmcp max stats not updating if you die and get max hp/sp/st while dead.
    if (mmpkg.mymaxhp < mmpkg.myhp) then mmpkg.mymaxhp = mmpkg.myhp end
    if (mmpkg.mymaxsp < mmpkg.mysp) then mmpkg.mymaxsp = mmpkg.mysp end
    if (mymaxst < myst) then mymaxst = myst end
    GUI.Health:setValue(mmpkg.myhp,mmpkg.mymaxhp)
    GUI.Spellpower:setValue(mmpkg.mysp,mmpkg.mymaxsp)
    GUI.Stamina:setValue(mmpkg.myst,mmpkg.mymaxst)
    GUI.XPgauge:setValue(mmpkg.tnlpct,100)
    GUI.Health.front:echo(mmpkg.myhp)
    GUI.Spellpower.front:echo(mmpkg.mysp)
    GUI.Stamina.front:echo([[<span style = "color: black">]] .. mmpkg.myst .. [[</span>]])
    GUI.XPgauge.front:echo(mmpkg.tnlpct .. "%")
end
