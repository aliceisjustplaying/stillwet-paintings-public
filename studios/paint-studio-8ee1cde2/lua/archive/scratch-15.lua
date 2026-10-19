--@ watercolor-engine 2

paper{width=1180,height=700,kind="cold-press",seed=2013}


local seed = 5
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local b = brush{name="soil_base", width=44}
local mx = {["burnt-umber"]=0.04, ["indian-red"]=0.02, ["sepia"]=0.01, ["french-ultramarine"]=0.01}
local n=0
for r=0,11 do for x=0,700,28 do n=n+1
  local y = 10 + r*26 + math.sin(n*1.7)*4
  top(b, mx, 2.5, 1.2); b:stroke({{x,y},{x+32,y+9+math.sin(n)*4}}, {pressure=0.5, duration=0.03})
end end
wait(12)
local v = brush{name="veil", width=40}
local vm = {["french-ultramarine"]=0.013, ["paynes-gray"]=0.005, ["buff-titanium"]=0.03}
for r=0,11 do for x=0,700,28 do top(v, vm, 2.5); local y=10+r*24; v:stroke({{x,y},{x+32,y+6}}, {pressure=0.5, duration=0.03}) end end
wait(12)
local g = brush{name="spots", width=34}
local gm = {["indian-red"]=0.015, ["burnt-umber"]=0.02}
for k=1,170 do
  local x = rnd()*700; local y = 10+rnd()*300
  top(g, gm, 2, 1.1)
  local a = (rnd()-0.5)*1.0 + 0.35
  g:stroke({{x,y,0.55},{x+math.cos(a)*30, y+math.sin(a)*24,0.35}}, {duration=0.03})
end
wait(15)



local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
-- A: neutral brown glaze, prewet, rows (x 0-340)
for gx=0,3 do for gy=0,3 do drop{x=40+gx*95+(gy%2)*40, y=40+gy*85, water=4, radius=72} end end
local a = brush{name="A", width=44}
local am = {["burnt-umber"]=0.02, ["sepia"]=0.006, ["french-ultramarine"]=0.006}
for r=0,11 do for x=0,320,30 do top(a, am, 3); local y=10+r*25; a:stroke({{x,y},{x+34,y+3}}, {pressure=0.5, duration=0.03}) end end
-- B: light opaque veil, prewet, rows (x 360-700)
for gx=0,3 do for gy=0,3 do drop{x=400+gx*95+(gy%2)*40, y=40+gy*85, water=4, radius=72} end end
local b = brush{name="B", width=44}
local bm = {["buff-titanium"]=0.08, ["raw-umber"]=0.008, ["indian-red"]=0.006}
for r=0,11 do for x=360,680,30 do top(b, bm, 3); local y=10+r*25; b:stroke({{x,y},{x+34,y+3}}, {pressure=0.5, duration=0.03}) end end
wait(15)



local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local L = brush{name="rocklight", width=24}
local lm = {["buff-titanium"]=0.09, ["french-ultramarine"]=0.012, ["paynes-gray"]=0.008, ["burnt-umber"]=0.006}
for y=30,130,16 do for x=20,140,22 do top(L, lm, 1.6); L:stroke({{x,y},{x+20,y+5}}, {pressure=0.5, duration=0.03}) end end
local D = brush{name="rockdark", width=24}
local dm = {["paynes-gray"]=0.04, ["sepia"]=0.04, ["french-ultramarine"]=0.02, ["buff-titanium"]=0.02}
for y=30,130,16 do for x=170,290,22 do top(D, dm, 1.6); D:stroke({{x,y},{x+20,y+5}}, {pressure=0.5, duration=0.03}) end end
local S = brush{name="shadow", width=24}
local sm = {["french-ultramarine"]=0.03, ["sepia"]=0.02, ["indian-red"]=0.01}
for y=170,290,16 do for x=20,300,22 do top(S, sm, 1.6); S:stroke({{x,y},{x+20,y+5}}, {pressure=0.5, duration=0.03}) end end
wait(15)
