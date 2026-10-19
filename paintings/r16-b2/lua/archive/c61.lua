GB = function(x) return 498 + 1.5*math.sin(x/23) end
GROVE = GROVEALL * above(GB)
-- repaint strips below the grove foot where dark hatching spilled
local zone = rect(0,497,440,50) * below(GB)
local piles = {M1,M2,M3,M3b,M4}
for i=1,5 do
  work(STRIPS[i] * zone, {hand="body", pile=piles[i], tool="filbert 4", angle=0, angle_jitter=0.04, coverage=4, fill=true, clip=true, length={12,35}, pressure={0.5,0.8}, seed=610+i})
end
local m0 = rect(0,480,440,20) * below(GB) * above(function(x) return 496 end)
work(m0, {hand="body", pile=M1, tool="filbert 3", angle=0, coverage=4, fill=true, clip=true, length={10,30}, seed=616})
-- break the halo: feathery dark touches in the rim, except on the upper sky-facing edge
local rim = GROVE - GROVE:shrink(5)
local top = GROVE - GROVE:offset(0)  -- placeholder
local upper = GROVE:offset(0)
local sky_edge = mask(function(x,y) return 1 end)
stipple(rim * below(function(x) return 430 end), {pile=gdeep, tool={kind="round", width=1.6, point=0.7}, coverage=1.1, cluster=0.5, drag={2.5, -math.pi/2}, seed=617})
stipple(rim * above(function(x) return 430 end), {pile=gdeep, tool={kind="round", width=1.5, point=0.7}, coverage=0.55, cluster=0.6, drag={2.5, -math.pi/2}, seed=618})
