local r = brush{kind="round", width=2.4, point=0.3}
local fp = {{232,505},{270,501.5},{310,498},{370,492},{420,486},{455,480},{490,472},{520,465},{548,458},{572,452},{592,448}}
local bp = {} for i,p in ipairs(fp) do bp[i] = {p[1], p[2] + 1.1 - i*0.06} end
r:load(bank2, 0.45)
r:stroke({table.unpack(bp, 1, 6)}, {pressure={0.45,0.32}, ramps={0.05,0.1}})
r:load(bank2, 0.35)
r:stroke({table.unpack(bp, 6, 11)}, {pressure={0.32,0.18}, ramps={0.05,0.3}})
local g = brush{kind="round", width=2.2, point=0.3}
local wf = pile{{"lead white", 6}, {"pale smalt", 1.3}, {"cobalt blue", 0.3}, {"raw umber", 0.1}, medium=0.12}
g:load(wf, 0.5)
g:stroke({table.unpack(fp, 1, 5)}, {pressure={0.45,0.35}, ramps={0.02,0.1}})
g:load(wf, 0.4)
g:stroke({table.unpack(fp, 5, 8)}, {pressure={0.32,0.25}, ramps={0.05,0.1}})
g:load(wf, 0.35)
g:stroke({table.unpack(fp, 8, 11)}, {pressure={0.24,0.12}, ramps={0.05,0.4}})
-- ditch line along the far edge of the hay field and its left diagonal
local d = brush{kind="round", width=2.0, point=0.4}
d:load(bank2, 0.5)
d:stroke({{322,523},{420,520},{560,516},{720,512},{880,509},{1010,508}}, {pressure={0.4,0.35}, ramps={0.02,0.02}, shake=0.6})
print(wait(0))
