stub = pile{{"yellow ochre", 1.6}, {"raw umber", 0.7}, {"lead white", 1.4}, {"green earth", 0.6}, medium=0.08}
stubL = pile{{"lead white", 3}, {"yellow ochre", 1.6}, {"chrome yellow", 0.15}, medium=0.08}
local hay = fieldB - river2:grow(1.5) - fore_m - figs:grow(1) - elder2:grow(1)
local hc
for i, h in ipairs(haycocks) do local e = ellipse(h.x + h.w*0.1, h.y - h.h*0.4, h.w*0.8, h.h*0.75) hc = hc and (hc + e) or e end
hay = hay - hc - load_m:grow(3) - rect(500, 490, 100, 46)
work(hay, {hand="hatch", pile=stub, tool={kind="round", width=1.0, point=0.9}, angle=function(x,y) return -0.02 + rand(-0.05,0.05) end, length={3,9}, coverage=0.25, pressure={0.3,0.5}, ramps={0.3,0.3}, clip=hay})
work(hay, {hand="hatch", pile=stubL, tool={kind="round", width=1.0, point=0.9}, angle=-0.02, length={4,10}, coverage=0.15, pressure={0.3,0.5}, ramps={0.3,0.3}, clip=hay})
print(wait(0))
