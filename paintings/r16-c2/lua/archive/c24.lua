reflM = mask(function(x,y) if y < 402 or y > 520 then return 0 end; return trees:at(x, 804 - y) end) * wClip
reflP = pile{{"raw umber",1},{"bone black",0.35},{"cobalt blue",0.3},{"green earth",0.2},{"lead white",0.9}}
work(reflM, {hand="body", tool="filbert 4", pile=reflP, angle=0, coverage=2.5, length={10,30}, fill=true, clip=wClip, angle_jitter=0.02})
local bm = rect(0,402,1000,100) * wClip
blend(bm, {angle=0})
