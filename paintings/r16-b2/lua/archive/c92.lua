for k=1,4 do blend(TOWN2, {angle=(k%2==0) and 0 or math.pi/2, angle_jitter=0.1, length={6,18}, tool={kind="badger", width=6}, seed=920+k}) end
