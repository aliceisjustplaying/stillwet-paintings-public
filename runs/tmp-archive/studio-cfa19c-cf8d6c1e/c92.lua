local figs = rect(318,515,40,64)   -- keep the figures clear
local keep = trunk2M:grow(1.5) + figs
local R = riseM - keep
-- texture of grass over the rise: short upright hatching in three greens, lighter on the crest
local gL = pile{{"yellow ochre",3},{"Prussian blue",0.28},{"lead white",1.6},{"chrome yellow",0.35}, medium=0.05}
local gM = pile{{"yellow ochre",2.5},{"Prussian blue",0.5},{"raw umber",0.4},{"lead white",0.7}, medium=0.05}
local gD = pile{{"raw umber",1.2},{"Prussian blue",0.6},{"yellow ochre",1.2},{"green earth",0.6},{"bone black",0.08}, medium=0.05}
local crest = R * mask(function(x,y) local c = riseY(x); return smoothstep(c+45, c+15, y) end)
local slope = R * mask(function(x,y) local c = riseY(x); return smoothstep(c+10, c+40, y) * smoothstep(c+95, c+60, y) end)
local foot = R * mask(function(x,y) local c = riseY(x); return smoothstep(c+55, c+90, y) end)
work(crest, {hand="hatch", pile=gL, tool={kind="round", width=1.6, point=0.6}, angle=-math.pi/2+0.15, length={4,9}, coverage=1.4, pressure={0.3,0.7}, seed=931})
work(slope, {hand="hatch", pile=gM, tool={kind="round", width=2.0, point=0.6}, angle=-math.pi/2+0.2, length={5,12}, coverage=1.3, pressure={0.3,0.7}, seed=932})
work(foot, {hand="hatch", pile=gD, tool={kind="round", width=2.6, point=0.6}, angle=-math.pi/2+0.2, length={8,18}, coverage=1.2, pressure={0.3,0.75}, seed=933})
