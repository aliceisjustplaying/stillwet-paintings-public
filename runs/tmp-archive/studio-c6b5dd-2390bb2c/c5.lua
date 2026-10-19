blend(sky, {angle=0, angle_jitter=0.08})
local seams = rect(0,120,1000,60) + rect(0,245,1000,50) + rect(0,350,1000,45)
blend(seams * sky, {angle=1.5, length={30,70}, clip=false})
blend(sky, {angle=0.02, pressure={0.25,0.4}})
