local r = brush{kind="round", width=2.4, point=0.3}
local fp = {{226,505.5},{262,501.5},{305,497.5},{350,493},{392,488.5},{428,484},{458,479},{488,472.5},{515,466},{540,459.5},{562,454},{580,450},{596,447}}
local bp = {} for i,p in ipairs(fp) do bp[i] = {p[1], p[2] + 1.2 - i*0.06} end
r:load(bank2, 0.5)
r:stroke({table.unpack(bp, 1, 7)}, {pressure={0.5,0.35}, ramps={0.02,0.1}})
r:load(bank2, 0.4)
r:stroke({table.unpack(bp, 7, 13)}, {pressure={0.35,0.15}, ramps={0.05,0.3}})
local g = brush{kind="round", width=2.2, point=0.3}
local wf = pile{{"lead white", 5}, {"pale smalt", 1.6}, {"cobalt blue", 0.35}, {"raw umber", 0.12}, medium=0.12}
g:load(wf, 0.55)
g:stroke({table.unpack(fp, 1, 5)}, {pressure={0.55,0.42}, ramps={0.0,0.1}})
g:load(wf, 0.45)
g:stroke({table.unpack(fp, 5, 9)}, {pressure={0.4,0.3}, ramps={0.05,0.1}})
g:load(wf, 0.4)
g:stroke({table.unpack(fp, 9, 13)}, {pressure={0.28,0.12}, ramps={0.05,0.4}})
print(wait(0))
