local seams = rect(0,495,1000,50) + rect(0,585,1000,50)
blend(seams * water, {angle=1.5, length={30,60}, clip=false})
blend(water, {angle=0, pressure={0.25,0.4}})
print(wait(20))
