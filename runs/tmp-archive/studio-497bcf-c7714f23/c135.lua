local seam = (elder2 + lowE) * mask(function(x,y) return math.max(0, 1 - math.abs(y - 586)/16) end)
stipple(seam, {pile=eD, width=2.6, coverage=1.6, pressure={0.4,0.7}, clip=(elder2 + lowE), cluster={0.7, 8}, feather=0.6})
stipple(seam * rect(830, 560, 90, 60), {pile=eM, width=2.2, coverage=0.8, pressure={0.4,0.6}, clip=(elder2 + lowE), cluster={0.7, 6}, feather=0.6, drag={3, 2.8}})
-- tall grass rising in front of the bush foot
local up = function(x,y) return -math.pi/2 + 0.3*math.sin(x/21 + y/13) end
local foot = rect(830, 655, 175, 62)
work(foot, {hand="hatch", pile=grM, tool={kind="rigger", width=2.2, point=1}, angle=up, length={20,40}, coverage=0.6, pressure={0.55,0.85}, ramps={0.05,0.75}, clump=0.5})
work(foot, {hand="hatch", pile=grL, tool={kind="rigger", width=1.8, point=1}, angle=up, length={18,36}, coverage=0.25, pressure={0.5,0.8}, ramps={0.05,0.75}, clump=0.5})
print(wait(0))
