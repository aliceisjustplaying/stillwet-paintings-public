--@ watercolor-engine 2

paper{width=1180,height=700,kind="cold-press",seed=2013}


local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local seed = 31
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
-- underlayer replicating current trail: red-brown + dark glaze, striped
local b = brush{name="soil", width=44}
local mx = {["burnt-umber"]=0.04, ["indian-red"]=0.02, ["sepia"]=0.01, ["french-ultramarine"]=0.01}
for r=0,13 do for x=0,1100,28 do local y=10+r*26; top(b, mx, 2.5, 0.9); b:stroke({{x,y},{x+32,y+9}}, {pressure=0.5, duration=0.03}) end end
wait(10)
local g = brush{name="glz", width=44}
local gm = {["burnt-umber"]=0.04, ["sepia"]=0.015, ["french-ultramarine"]=0.012, ["indian-red"]=0.01}
for band=0,3 do for r=0,3 do for x=0,1100,28 do local y=10+band*76+r*19; top(g, gm, 3, 0.6); g:stroke({{x,y},{x+32,y+5}}, {pressure=0.5, duration=0.03}) end end; wait(3) end
wait(12)
-- opaque random-stroke covers, 4 recipes in columns
local C = {
 {["buff-titanium"]=0.15, ["indian-red"]=0.012, ["raw-umber"]=0.012, ["burnt-umber"]=0.01},
 {["buff-titanium"]=0.25, ["indian-red"]=0.02, ["raw-umber"]=0.02, ["burnt-umber"]=0.015},
 {["buff-titanium"]=0.25, ["indian-red"]=0.015, ["raw-umber"]=0.02, ["french-ultramarine"]=0.008},
 {["buff-titanium"]=0.4, ["indian-red"]=0.03, ["raw-umber"]=0.03, ["burnt-umber"]=0.02},
}
for i,m in ipairs(C) do
  local cb = brush{name="c"..i, width=24}
  local x0 = 20 + (i-1)*270
  for k=1,110 do
    local x = x0 + rnd()*220; local y = 20 + rnd()*300
    top(cb, m, 1.4)
    local a = (rnd()-0.5)*1.4
    cb:stroke({{x,y,0.5},{x+math.cos(a)*22, y+math.sin(a)*14,0.3}}, {duration=0.03})
  end
end
wait(15)
