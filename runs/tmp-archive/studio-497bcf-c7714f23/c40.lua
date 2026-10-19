water2 = pile{{"lead white", 7}, {"pale smalt", 1.0}, {"cobalt blue", 0.25}, {"yellow ochre", 0.15}, medium=0.12}
bank2 = pile{{"green earth", 2}, {"raw umber", 1.4}, {"Prussian blue", 0.15}, {"yellow ochre", 0.8}, {"lead white", 0.6}, medium=0.12}
far_pts = {{158,511.5},{200,508},{250,503.5},{310,498},{370,492},{420,486},{455,480},{490,472},{520,465},{548,458},{572,452},{592,448}}
local r = brush{kind="round", width=3.2, point=0.2}
r:load(bank2, 0.5)
-- dark bank line under the water
local bp = {} for i,p in ipairs(far_pts) do bp[i] = {p[1], p[2] + 1.3 - i*0.08} end
r:stroke({table.unpack(bp, 1, 6)}, {pressure={0.5,0.35}, ramps={0.05,0.1}})
r:load(bank2, 0.4)
r:stroke({table.unpack(bp, 6, 12)}, {pressure={0.35,0.2}, ramps={0.05,0.3}})
local g = brush{kind="round", width=2.6, point=0.3}
g:load(water2, 0.55)
g:stroke({table.unpack(far_pts, 1, 5)}, {pressure={0.55,0.4}, ramps={0.02,0.1}})
g:load(water2, 0.45)
g:stroke({table.unpack(far_pts, 5, 9)}, {pressure={0.38,0.3}, ramps={0.05,0.1}})
g:load(water2, 0.4)
g:stroke({table.unpack(far_pts, 9, 12)}, {pressure={0.28,0.15}, ramps={0.05,0.4}})
print(wait(0))
