function mmpkg.isDead()
    mmpkg.isWalking = false
    mmpkg.myAffects = mmpkg.myAffects or {}
    mmpkg.myAffects.affects = {}
    mmpkg.updateMaxStats()
    mmpkg.updateVitals()
end
