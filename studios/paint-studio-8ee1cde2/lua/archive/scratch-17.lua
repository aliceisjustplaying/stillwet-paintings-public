--@ watercolor-engine 2

paper{width=1180,height=700,kind="cold-press",seed=2013}


local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local b = brush{name="soil", width=44}
local mx = {["burnt-umber"]=0.04, ["indian-red"]=0.02, ["sepia"]=0.01, ["french-ultramarine"]=0.01}
for r=0,11 do for x=0,600,28 do local y=10+r*26; top(b, mx, 2.5, 1.4); b:stroke({{x,y},{x+32,y+9}}, {pressure=0.5, duration=0.03}) end end
wait(12)
-- rock A: mid grey body laid as quick overlapping strokes
local R = brush{name="rockbody", width=26}
local rm = {["paynes-gray"]=0.05, ["french-ultramarine"]=0.02, ["burnt-umber"]=0.02, ["buff-titanium"]=0.05}
for y=40,140,18 do top(R, rm, 2.2); R:stroke({{40,y},{100,y-3},{160,y+2}}, {pressure=0.5, duration=0.06}) end
-- rock B: opaque lighter grey
local R2 = brush{name="rockbody2", width=26}
local rm2 = {["buff-titanium"]=0.12, ["paynes-gray"]=0.03, ["french-ultramarine"]=0.01}
for y=40,140,18 do top(R2, rm2, 2.2); R2:stroke({{220,y},{280,y-3},{340,y+2}}, {pressure=0.5, duration=0.06}) end
-- posts: opaque light
local P = brush{name="post", width=8}
local pm = {["buff-titanium"]=0.25, ["naples-yellow"]=0.05}
for i=0,3 do top(P, pm, 1.0, 0.6+i*0.4); P:stroke({{420+i*40,40},{421+i*40,150}}, {pressure=0.5, duration=0.08}) end
wait(10)
-- lit faces on rock A
local L = brush{name="rocklit", width=16}
local lm = {["buff-titanium"]=0.14, ["paynes-gray"]=0.012, ["raw-umber"]=0.01}
for y=40,80,12 do top(L, lm, 1.2); L:stroke({{50,y},{120,y-4}}, {pressure=0.5, duration=0.04}) end
wait(10)



local P = brush{name="post2", width=9}
for i=0,3 do
  P:load{water=0.6, pigments={["buff-titanium"]=0.3+i*0.25, ["naples-yellow"]=0.05}}
  P:stroke({{420+i*40,180},{421+i*40,290}}, {pressure=0.5, duration=0.08})
end
local S = brush{name="postsh", width=4}
for i=0,3 do
  S:load{water=0.3, pigments={["paynes-gray"]=0.04, ["burnt-umber"]=0.03}}
  S:stroke({{425+i*40,182},{426+i*40,290}}, {pressure=0.5, duration=0.08})
end
wait(10)
