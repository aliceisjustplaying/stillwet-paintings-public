--@ watercolor-engine 2

paper{width=1180,height=700,kind="cold-press",seed=2013}


local mixes = {
 {"sky", {["cobalt-blue"]=0.12, ["french-ultramarine"]=0.06, ["paynes-gray"]=0.02}},
 {"skyB", {["french-ultramarine"]=0.1, ["cerulean-blue"]=0.05, ["burnt-sienna"]=0.01}},
 {"cloudgray", {["paynes-gray"]=0.04, ["cobalt-blue"]=0.03, ["quinacridone-rose"]=0.005}},
 {"mtn", {["cobalt-blue"]=0.08, ["paynes-gray"]=0.05, ["terre-verte"]=0.03}},
 {"valley", {["terre-verte"]=0.15, ["cobalt-blue"]=0.05, ["yellow-ochre"]=0.04}},
 {"forest", {["sap-green"]=0.25, ["french-ultramarine"]=0.06, ["yellow-ochre"]=0.08}},
 {"leaf", {["sap-green"]=0.3, ["hookers-green"]=0.1, ["yellow-ochre"]=0.05}},
 {"soil", {["indian-red"]=0.2, ["burnt-umber"]=0.15}},
 {"path", {["burnt-sienna"]=0.15, ["indian-red"]=0.05,["raw-umber"]=0.08}},
 {"rock", {["french-ultramarine"]=0.12, ["burnt-sienna"]=0.1, ["paynes-gray"]=0.04}},
}
for i, m in ipairs(mixes) do
  local col = (i-1) % 5
  local row = math.floor((i-1)/5)
  local x = 30 + col*225
  local y = 30 + row*330
  local b = brush{name="sw_"..m[1], width=40}
  b:load{water=12, pigments=m[2]}
  b:wash{x=x, y=y, width=180, height=80}
  local b2 = brush{name="sw2_"..m[1], width=40}
  local p = {}
  for k,v in pairs(m[2]) do p[k]=v*2.5 end
  b2:load{water=12, pigments=p}
  b2:wash{x=x, y=y+100, width=180, height=80}
end
-- wet-in-wet sky test with drop grid
local w = brush{name="water1", width=60}
for gx=0,2 do for gy=0,1 do drop{x=700+gx*110, y=560+gy*90, water=10, radius=70} end end
local s = brush{name="skywet", width=50}
s:load{water=10, pigments={["cobalt-blue"]=0.15, ["french-ultramarine"]=0.08, ["paynes-gray"]=0.02}}
s:stroke({{650,520},{780,540},{900,530}}, {pressure=0.5})
s:stroke({{940,560},{850,600},{700,620}}, {pressure=0.4})
wait(20)
print(balance().dry)
