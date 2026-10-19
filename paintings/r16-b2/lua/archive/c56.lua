GROVEALL = WINFO[1].C + WINFO[2].C + WINFO[3].C + WINFO[4].C
local gb = function(x) return 498 + 1.5*math.sin(x/23) end
local zone = rect(0,480,430,70) * below(gb)
local piles = {M1,M2,M3,M3b}
for i=1,4 do
  work(STRIPS[i] * zone, {hand="body", pile=piles[i], tool="filbert 4", angle=0, angle_jitter=0.04, coverage=3.2, fill=true, clip=true, length={12,35}, pressure={0.45,0.75}, seed=560+i})
end
-- also the far-meadow band between strips' top (495) and the grove bottom
local m0 = rect(0,480,430,20) * below(gb) * above(function(x) return 496 end)
work(m0, {hand="body", pile=M1, tool="filbert 3", angle=0, coverage=3, fill=true, clip=true, length={10,30}, seed=565})
