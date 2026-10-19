local e = rect(440,455,70,56)
for i=1,3 do blend(e, {angle=0, angle_jitter=0.2, length={15,45}, clip=false, tool={kind="badger", width=12}, seed=790+i}) end
