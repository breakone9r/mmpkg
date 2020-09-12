function mmpkg.isAlive()
  mmpkg.updateMaxStats()
  mmpkg.updateVitals()
  mmpkg.myAffects = mmpkg.myAffects or {}
  mmpkg.myAffects.affects = {}
end
