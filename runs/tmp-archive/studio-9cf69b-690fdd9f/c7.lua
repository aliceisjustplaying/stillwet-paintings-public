local L = land
work(L * rect(-20,465,1040,70), {hand="body", pile=snowFar, angle=0, coverage=2.5, fill=true, angle_jitter=0.04, pressure={0.5,0.8}, length={40,90}, clip=L})
work(L * rect(-20,530,1040,80), {hand="body", pile=snowMid, angle=0, coverage=2.5, fill=true, angle_jitter=0.05, pressure={0.5,0.8}, length={40,90}})
work(L * rect(-20,600,1040,130), {hand="body", pile=snowNear, angle=0.02, coverage=2.5, fill=true, angle_jitter=0.06, pressure={0.5,0.8}, length={40,100}})
local moundM = L * rect(0,400,640,72)
work(moundM, {hand="body", pile=moundP, angle=0.0, coverage=2.5, fill=true, angle_jitter=0.08, pressure={0.5,0.8}, length={30,70}, clip=L})
