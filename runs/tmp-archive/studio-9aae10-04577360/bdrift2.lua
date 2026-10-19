local band = BOULDER:mask():grow(1) * above(function(x) return 648.5 + math.abs(x-835)*0.1 + 0.8*math.sin(x/6) end) * below(function(x) return 637 + math.abs(x-835)*0.1 end)
work(band, {hand="detail", pile=fgMid, coverage=4, fill=true, angle=0.1, load=1, pressure={0.6,0.9}, tool={kind="round", width=1.3, point=0.5}})
local edge = rect(740, 690, 235, 12)
blend(edge, {angle=math.pi/2})
