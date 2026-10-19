-- roots, darker and fuller
local rootL = poly({{387,490},{386,500},{381,505},{372,509},{364,512},{370,513},{381,511},{390,509.5},{394,500}}, true)
local rootR = poly({{419,490},{421,500},{427,504},{437,507.5},{447,511},{441,512},{430,510},{420,509},{416,500}}, true)
local rootM = poly({{397,509.5},{401,505.5},{408,505},{412,509.5}}, true)
work(rootL + rootR + rootM, {hand="detail", pile=barkK, coverage=4, fill=true, load=1, pressure={0.7,0.95}, tool={kind="round", width=1.6, point=0.5}})
local rootL2 = poly({{842,498},{840,504},{833,507.5},{828,509},{836,509.5},{845,507}}, true)
local rootR2 = poly({{856,498},{859,504},{866,506.5},{872,508},{864,509},{855,507}}, true)
work(rootL2 + rootR2, {hand="detail", pile=barkK, coverage=4, fill=true, load=1, pressure={0.7,0.95}, tool={kind="round", width=1.4, point=0.5}})
-- figure: restate the coat's left edge over the stone's snow
local X, F = 502, 499
local coatL = poly({{X-5.8,F-22},{X-6.4,F-12},{X-7.5,F-3},{X-3,F-3},{X-3,F-22}}, true)
work(coatL, {hand="detail", pile=coatP, coverage=4, fill=true, angle=math.pi/2, load=1, pressure={0.6,0.9}, tool={kind="round", width=1.1, point=0.8}})
-- trail restored through the drift by the oak
local path = {{385,560},{450,527},{497,502}}
local sh, ws = {}, {}
for i,p in ipairs(path) do local s = clamp((p[2]-462)/252, 0.05, 1.2); sh[i] = {p[1] - 3*s, p[2] - 2.5*s}; ws[i] = 9*s + 1 end
local m = ribbon(sh, ws):roughen(1.2, 7, 22) * rect(420, 505, 60, 40)
work(m, {hand="detail", pile=trailK, coverage=2.5, fill=true, angle=-0.5, tool={kind="filbert", width=2.5}, pressure={0.4,0.7}})
