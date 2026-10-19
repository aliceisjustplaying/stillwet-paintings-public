local s = openW * rect(0, 600, 1000, 50)
blend(s, {angle=1.5, angle_jitter=0.2, tool="badger 16", length={25,50}, clip=false})
blend(openW * rect(0, 590, 1000, 70), {angle=0, angle_jitter=0.02, tool="badger 24", length={80,200}, pressure={0.3,0.45}})
blend(openW * rect(0, 610, 1000, 30), {angle=1.5, angle_jitter=0.2, tool="badger 12", length={20,40}, pressure={0.25,0.4}, clip=false})
