--@ watercolor-engine 2

paper{width=1180,height=700,kind="cold-press",seed=2013}


local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
-- underlayer: brown trail cover
local V = brush{name="cov", width=40}
local vm = {["buff-titanium"]=0.07, ["indian-red"]=0.009, ["burnt-umber"]=0.008, ["raw-umber"]=0.008, ["burnt-sienna"]=0.003}
for r=0,5 do for x=20,500,28 do top(V, vm, 2.6, 1.6); V:stroke({{x,20+r*22},{x+32,23+r*22}}, {pressure=0.5, duration=0.03}) end end
wait(12)
local mixes = {
 {["buff-titanium"]=0.10, ["terre-verte"]=0.02, ["cobalt-blue"]=0.015, ["cerulean-blue"]=0.01},
 {["buff-titanium"]=0.14, ["terre-verte"]=0.025, ["cerulean-blue"]=0.025},
 {["cerulean-blue"]=0.04, ["terre-verte"]=0.03, ["buff-titanium"]=0.06},
}
for i,m in ipairs(mixes) do
  local b = brush{name="h"..i, width=24}
  local x0 = 30 + (i-1)*160
  for r=0,4 do for x=x0,x0+110,22 do top(b, m, 1.8); b:stroke({{x,30+r*20},{x+24,32+r*20}}, {pressure=0.5, duration=0.03}) end end
end
-- rock on top of cover
local K = brush{name="rk", width=18}
local km = {["sepia"]=0.12, ["paynes-gray"]=0.09, ["french-ultramarine"]=0.04}
for r=0,4 do top(K, km, 1.5); K:stroke({{520,30+r*14},{580,32+r*14}}, {pressure=0.5, duration=0.03}) end
wait(15)



local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
-- dark finger stroke on cover underlayer (cov at y 20-130 exists). paint dark bars at y 200
local V = brush{name="cov2", width=40}
local vm = {["buff-titanium"]=0.07, ["indian-red"]=0.009, ["burnt-umber"]=0.008, ["raw-umber"]=0.008, ["burnt-sienna"]=0.003}
for r=0,4 do for x=20,500,28 do top(V, vm, 2.6, 1.6); V:stroke({{x,200+r*22},{x+32,203+r*22}}, {pressure=0.5, duration=0.03}) end end
wait(10)
local K = brush{name="rk2", width=16}
local km = {["sepia"]=0.24, ["paynes-gray"]=0.17, ["french-ultramarine"]=0.07}
for i=0,3 do top(K, km, 1.4); K:stroke({{40+i*120,230},{120+i*120,232}}, {pressure=0.5, duration=0.03}) end
wait(10)
local ops = {
 {["buff-titanium"]=0.4, ["indian-red"]=0.05, ["burnt-umber"]=0.04, ["raw-umber"]=0.03},
 {["buff-titanium"]=0.7, ["indian-red"]=0.08, ["burnt-umber"]=0.06, ["raw-umber"]=0.05},
 {["buff-titanium"]=0.5, ["indian-red"]=0.06, ["cadmium-red"]=0.03, ["burnt-umber"]=0.03},
 {["buff-titanium"]=1.0, ["indian-red"]=0.1, ["burnt-umber"]=0.08, ["naples-yellow"]=0.05},
}
for i,m in ipairs(ops) do
  local b = brush{name="op"..i, width=16}
  top(b, m, 1.2)
  b:stroke({{40+(i-1)*120,230},{120+(i-1)*120,232}}, {pressure=0.5, duration=0.03})
end
wait(12)



local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local seed = 77
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local g = brush{name="wg", width=34}
local gm = {["indian-red"]=0.015, ["burnt-umber"]=0.02}
for k=1,60 do
  local x = 20 + rnd()*240; local y = 190 + rnd()*110
  top(g, gm, 2, 0.8)
  local a = (rnd()-0.5)*1.0 + 0.35
  g:stroke({{x,y,0.55},{x+math.cos(a)*30, y+math.sin(a)*24,0.35}}, {duration=0.03})
end
local g2 = brush{name="wg2", width=34}
local gm2 = {["indian-red"]=0.02, ["burnt-sienna"]=0.008, ["burnt-umber"]=0.012}
for k=1,60 do
  local x = 280 + rnd()*240; local y = 190 + rnd()*110
  top(g2, gm2, 2, 0.8)
  local a = (rnd()-0.5)*1.0 + 0.35
  g2:stroke({{x,y,0.55},{x+math.cos(a)*30, y+math.sin(a)*24,0.35}}, {duration=0.03})
end
wait(12)



local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local V = {
 {["buff-titanium"]=0.05, ["french-ultramarine"]=0.008, ["paynes-gray"]=0.004, ["raw-umber"]=0.006},
 {["buff-titanium"]=0.08, ["french-ultramarine"]=0.006, ["raw-umber"]=0.01},
 {["french-ultramarine"]=0.012, ["paynes-gray"]=0.004, ["raw-umber"]=0.01},
 {["buff-titanium"]=0.04, ["cerulean-blue"]=0.012, ["raw-umber"]=0.008},
}
for i,m in ipairs(V) do
  local b = brush{name="vv"..i, width=34}
  local x0 = 20 + (i-1)*130
  for r=0,4 do for x=x0,x0+90,26 do top(b, m, 2.4); b:stroke({{x,190+r*24},{x+28,192+r*24}}, {pressure=0.5, duration=0.03}) end end
end
wait(12)



local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
for gx=0,2 do drop{x=60+gx*90, y=245, water=4, radius=55} end
local g = brush{name="slopeglz", width=44}
local gm = {["burnt-umber"]=0.04, ["sepia"]=0.015, ["french-ultramarine"]=0.012, ["indian-red"]=0.01}
for r=0,6 do for x=20,260,28 do local y=185+r*19+(x-20)*0.15; top(g, gm, 3); g:stroke({{x,y},{x+32,y+5}}, {pressure=0.5, duration=0.03}) end end
local g2 = brush{name="slopeglz2", width=44}
for r=0,6 do for x=280,520,28 do local y=185+r*19+(x-280)*0.15; top(g2, gm, 3, 1.6); g2:stroke({{x,y},{x+32,y+5}}, {pressure=0.5, duration=0.03}) end end
wait(12)
