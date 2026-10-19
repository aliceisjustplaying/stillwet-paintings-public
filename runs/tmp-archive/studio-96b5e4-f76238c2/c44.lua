glow = pile{{"lead white",6},{"chrome yellow",0.8},{"vermilion",0.12}, medium=0.15}
glow2 = pile{{"lead white",6},{"chrome yellow",0.5},{"vermilion",0.25},{"yellow ochre",0.1}, medium=0.15}
local sunx, suny = 645, 436
local E = ellipse(sunx, suny, 170, 60) * above(function(x) return 436 end) - treesR:grow(3) - farline:grow(1)
local d = function(x,y) local dx=(x-sunx)/170; local dy=(y-suny)/60; return math.sqrt(dx*dx+dy*dy) end
work(E, {hand="body", pile=glow2, angle=0, coverage=1.6, length={20,60}, tool="filbert 8", load_at=function(x,y) return clamp(0.7*(1-d(x,y)), 0.05, 0.7) end, pressure={0.3,0.6}})
local E2 = ellipse(sunx, suny, 90, 30) * above(function(x) return 437 end) - farline:grow(1)
work(E2, {hand="body", pile=glow, angle=0, coverage=2, length={15,40}, tool="filbert 6", load_at=function(x,y) return clamp(0.8*(1-d(x,y)*1.6), 0.05, 0.8) end, pressure={0.4,0.7}})
local BE = ellipse(sunx, suny, 200, 75):soften(20) * above(function(x) return 437 end) - treesR:grow(4) - farline:grow(1)
blend(BE, {angle=0}); blend(BE, {angle=0.1})
