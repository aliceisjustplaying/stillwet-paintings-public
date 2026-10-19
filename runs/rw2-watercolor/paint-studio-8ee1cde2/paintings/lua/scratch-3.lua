--@ watercolor-engine 2

paper{width=1180,height=700,kind="cold-press",seed=2013}


-- sky trial: pre-wet grid, diagonal blue bands, lift streaks
for gx=0,5 do for gy=0,2 do drop{x=80+gx*110, y=60+gy*95, water=5, radius=75} end end
local s = brush{name="skyA", width=50}
local mix = {["cobalt-blue"]=0.10, ["french-ultramarine"]=0.06, ["burnt-sienna"]=0.012}
local function band(pts, pr)
  local st = s:status()
  local need = 6 - st.water
  if need > 0 then s:load{water=need, pigments={["cobalt-blue"]=0.10*need/6, ["french-ultramarine"]=0.06*need/6, ["burnt-sienna"]=0.012*need/6}} end
  s:stroke(pts, {pressure=pr or 0.5})
end
for i=0,6 do
  local y = 20 + i*40
  local x0 = 40
  for x=x0, 660, 80 do
    band({{x, y + (x-x0)*-0.12}, {x+90, y + (x+90-x0)*-0.12 + 4}}, 0.55)
  end
end
-- lift streaks
local L = brush{name="liftA", width=18}
L:load{water=8}
L:lift({{100,140},{250,120},{420,100}})
L:load{water=8}
L:lift({{300,200},{450,180},{620,170}})
-- second trial: dry paper bands with softened edge
local s2 = brush{name="skyB", width=40}
s2:load{water=10, pigments={["cobalt-blue"]=0.15, ["french-ultramarine"]=0.08, ["burnt-sienna"]=0.015}}
s2:stroke({{720,60},{900,40},{1100,30}}, {pressure=0.6})
s2:stroke({{720,110},{900,95},{1100,90}}, {pressure=0.6})
local wb = brush{name="wetedge", width=30}
wb:load{water=8}
wb:stroke({{720,140},{900,125},{1100,120}}, {pressure=0.5})
-- soil trials
local mixes = {
 {"soilA", {["indian-red"]=0.12, ["burnt-umber"]=0.15, ["french-ultramarine"]=0.03}},
 {"soilB", {["burnt-sienna"]=0.12, ["raw-umber"]=0.12, ["indian-red"]=0.06, ["french-ultramarine"]=0.02}},
 {"pathA", {["burnt-sienna"]=0.08, ["raw-umber"]=0.08, ["indian-red"]=0.04, ["yellow-ochre"]=0.03}},
 {"rockdk", {["sepia"]=0.2, ["french-ultramarine"]=0.12, ["indian-red"]=0.05}},
 {"veg", {["sap-green"]=0.25, ["hookers-green"]=0.12, ["french-ultramarine"]=0.04}},
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
