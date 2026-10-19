local J = (jugBody + spout):grow(1)
local band = (J:grow(18) - J) * rect(0, 150, 420, 371)
work(band, {hand="body", tool="filbert 8", pile=bgMid, coverage=2.5, angle=1.5708, angle_jitter=0.3, length={20,50}, fill=true, clip=wall - J})
blend(rect(0,0,1000,521) - J - handle:grow(1), {angle=0.3, tool={kind="badger", width=30}})
