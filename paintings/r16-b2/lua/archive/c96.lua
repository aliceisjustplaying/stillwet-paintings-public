local R = (TOWN2:grow(12) - TOWN2:grow(1.5) - TTREES - MILLB) * rect(320,320,380,122)
for k=1,3 do blend(R, {angle=k*1.1, angle_jitter=0.6, length={4,10}, clip=false, tool={kind="badger", width=5}, seed=960+k}) end
