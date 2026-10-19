work(oakM2 * rect(0, 415, 1000, 150), {hand="detail", pile=barkD, coverage=3.5, fill=true, angle=-1.5, length={5,14}})
work(riverB + riverC, {hand="detail", pile=riverWarm, angle=0, coverage=3.5, fill=true, length={6,20}})
local fe = ribbon(farEdgeB, 1.2) + ribbon(farEdgeC, 0.9)
work(fe:roughen(0.4, 3, 81), {hand="detail", pile=reedP, angle=0, coverage=2, fill=true, clip=true, length={4,12}, pressure={0.2,0.5}})
