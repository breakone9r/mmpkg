function mmpkg.updateMaxStats()
  mmpkg.updateCharname()
  if (gmcp.char.maxstats) then
    mmpkg.mymaxhp, mmpkg.mymaxsp, mmpkg.mymaxst = 
    tonumber(gmcp.char.maxstats.maxhp),
    tonumber(gmcp.char.maxstats.maxsp),
    tonumber(gmcp.char.maxstats.maxst)
  end
end
