--@ watercolor-engine 2

paper{width=1180,height=700,kind="cold-press",seed=2013}


for gx=0,5 do for gy=0,3 do drop{x=60+gx*110, y=40+gy*90, water=8, radius=80} end end
local s = brush{name="skyW", width=100}
local function ld(target, f)
  local st = s:status()
  local need = target - st.water
  if need > 0 then s:load{water=need, pigments={["cobalt-blue"]=0.016*need*f, ["french-ultramarine"]=0.009*need*f, ["burnt-sienna"]=0.002*need*f}} end
end
for i=0,5 do
  ld(30, 1.0 - i*0.12)
  local y = 20 + i*50
  s:stroke({{20,y},{340,y-20},{660,y-40}}, {pressure=0.5, duration=0.2})
end
-- lift streaks while wet
local L = brush{name="liftA", width=24}
L:load{water=6}
L:lift({{100,170},{300,140},{520,110}}, {duration=0.3})
L:load{water=6}
L:lift({{200,250},{420,220},{640,200}}, {duration=0.3})
wait(2)
print(balance().max_surface_water)
-- soil
local mixes = {
 {"soilC", {["indian-red"]=0.12, ["burnt-umber"]=0.2, ["french-ultramarine"]=0.05}},
 {"soilD", {["burnt-sienna"]=0.1, ["burnt-umber"]=0.12, ["indian-red"]=0.06, ["french-ultramarine"]=0.04}},
 {"pathB", {["burnt-sienna"]=0.08, ["raw-umber"]=0.1, ["indian-red"]=0.05, ["french-ultramarine"]=0.02}},
 {"gray", {["french-ultramarine"]=0.08, ["burnt-umber"]=0.08, ["paynes-gray"]=0.03}},
 {"vegB", {["sap-green"]=0.2, ["hookers-green"]=0.1, ["french-ultramarine"]=0.04, ["burnt-umber"]=0.03}},
}
for i, m in ipairs(mixes) do
  local x = 30 + (i-1)*225
  local b = brush{name="sw_"..m[1], width=40}
  b:load{water=12, pigments=m[2]}
  b:wash{x=x, y=420, width=180, height=80}
  local b2 = brush{name="sw2_"..m[1], width=40}
  local p = {}
  for k,v in pairs(m[2]) do p[k]=v*2.5 end
  b2:load{water=12, pigments=p}
  b2:wash{x=x, y=560, width=180, height=80}
end
wait(30)
print(balance().dry)
