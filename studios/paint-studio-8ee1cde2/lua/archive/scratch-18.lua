--@ watercolor-engine 2

paper{width=1180,height=700,kind="cold-press",seed=2013}


local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
-- replicate trail: soil base light + buff veil + cover
local b = brush{name="soil", width=44}
local mx = {["burnt-umber"]=0.04, ["indian-red"]=0.02, ["sepia"]=0.01, ["french-ultramarine"]=0.01}
for r=0,11 do for x=0,700,28 do local y=10+r*26; top(b, mx, 2.5, 0.75); b:stroke({{x,y},{x+32,y+9}}, {pressure=0.5, duration=0.03}) end end
wait(12)
local V = brush{name="cov", width=44}
local vm = {["buff-titanium"]=0.065, ["indian-red"]=0.008, ["raw-umber"]=0.006, ["burnt-sienna"]=0.004}
for r=0,11 do for x=0,700,30 do local y=10+r*25; top(V, vm, 3); V:stroke({{x,y},{x+34,y+4}}, {pressure=0.5, duration=0.03}) end end
wait(12)
-- glazes in three columns
local G = {
 {["burnt-umber"]=0.03, ["indian-red"]=0.008, ["sepia"]=0.006, ["french-ultramarine"]=0.004},
 {["burnt-umber"]=0.045, ["indian-red"]=0.012, ["sepia"]=0.008, ["french-ultramarine"]=0.006},
 {["raw-umber"]=0.03, ["burnt-umber"]=0.02, ["indian-red"]=0.01},
}
for i,g in ipairs(G) do
  local x0 = 20 + (i-1)*230
  for gx=0,1 do for gy=0,2 do drop{x=x0+50+gx*90, y=50+gy*90, water=4, radius=60} end end
  local gb = brush{name="gl"..i, width=40}
  for r=0,11 do for x=x0,x0+160,30 do local y=10+r*25; top(gb, g, 3); gb:stroke({{x,y},{x+34,y+3}}, {pressure=0.5, duration=0.03}) end end
end
wait(15)



local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
-- make banded underlayer: two bands with gap timing
local g = brush{name="band", width=40}
local gm = {["burnt-umber"]=0.03, ["raw-umber"]=0.012, ["indian-red"]=0.009, ["sepia"]=0.004, ["french-ultramarine"]=0.003}
for band=0,2 do
  for gx=0,3 do drop{x=60+gx*90, y=400+band*88+44, water=4, radius=58} end
  for r=0,3 do for x=20,360,28 do local y=400+band*88+r*22; top(g, gm, 3); g:stroke({{x,y},{x+32,y+3}}, {pressure=0.5, duration=0.03}) end end
end
wait(12)
-- cover half of it (x 20-200)
for gx=0,1 do for gy=0,2 do drop{x=60+gx*80, y=440+gy*80, water=4, radius=45} end end
local V = brush{name="cov2", width=40}
local vm = {["buff-titanium"]=0.07, ["indian-red"]=0.012, ["burnt-sienna"]=0.006, ["raw-umber"]=0.006}
for r=0,11 do for x=20,180,28 do local y=400+r*22; top(V, vm, 3); V:stroke({{x,y},{x+32,y+3}}, {pressure=0.5, duration=0.03}) end end
wait(15)
