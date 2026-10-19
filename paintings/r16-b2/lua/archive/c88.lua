greyp2 = pile{{"lead white",1.6},{"pale smalt",0.9},{"raw umber",0.9},{"yellow ochre",0.15}, medium=0.2}
greydk = pile{{"lead white",0.8},{"pale smalt",0.8},{"raw umber",1.2},{"bone black",0.1}, medium=0.2}
work(HORSEB, {hand="detail", pile=greyp2, tool={kind="round", width=0.9, point=0.6}, angle=0, angle_jitter=0.3, coverage=5, fill=true, length={2,4}, seed=881})
work(HORSEB * below(function(x) return 567 - 22*0.55 end), {hand="detail", pile=greydk, tool={kind="round", width=0.8, point=0.6}, angle=math.pi/2, coverage=3, fill=true, length={2,4}, seed=882})
-- path smudge
local sm = FPATH * rect(605,540,40,20)
work(sm, {hand="detail", pile=pathp4, tool={kind="round", width=1.2, point=0.6}, angle=-0.7, angle_jitter=0.2, coverage=4, fill=true, length={2,5}, seed=883})
