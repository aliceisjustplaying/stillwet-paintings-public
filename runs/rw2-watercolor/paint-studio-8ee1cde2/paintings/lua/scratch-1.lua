--@ watercolor-engine 2

paper{width=1180,height=700,kind="cold-press",seed=2013}


local mixes = {
 {"sky1", {["cerulean-blue"]=0.6, ["french-ultramarine"]=0.3}},
 {"sky2", {["cobalt-blue"]=0.5, ["french-ultramarine"]=0.2}},
 {"skypale", {["cerulean-blue"]=0.2, ["cobalt-blue"]=0.1}},
 {"haze", {["cobalt-blue"]=0.2, ["paynes-gray"]=0.1, ["quinacridone-rose"]=0.03}},
 {"valley", {["terre-verte"]=0.4, ["cobalt-blue"]=0.15, ["yellow-ochre"]=0.1}},
 {"forest", {["sap-green"]=0.6, ["french-ultramarine"]=0.2, ["yellow-ochre"]=0.2}},
 {"leaf", {["sap-green"]=0.6, ["green-gold"]=0.3}},
 {"leafdk", {["hookers-green"]=0.8, ["sepia"]=0.3}},
 {"soil", {["indian-red"]=0.5, ["burnt-umber"]=0.4}},
 {"soil2", {["burnt-sienna"]=0.6, ["raw-umber"]=0.3, ["indian-red"]=0.2}},
 {"path", {["burnt-sienna"]=0.4, ["yellow-ochre"]=0.2, ["raw-umber"]=0.15}},
 {"rock", {["french-ultramarine"]=0.4, ["burnt-sienna"]=0.3, ["paynes-gray"]=0.1}},
 {"rockdk", {["sepia"]=0.6, ["french-ultramarine"]=0.4, ["paynes-gray"]=0.2}},
 {"shadow", {["indian-red"]=0.4, ["french-ultramarine"]=0.4, ["burnt-umber"]=0.3}},
}
for i, m in ipairs(mixes) do
  local col = (i-1) % 5
  local row = math.floor((i-1)/5)
  local x = 30 + col*225
  local y = 30 + row*220
  local b = brush{name="sw_"..m[1], width=40}
  b:load{water=12, pigments=m[2]}
  b:wash{x=x, y=y, width=180, height=80}
  local b2 = brush{name="sw2_"..m[1], width=40}
  local p = {}
  for k,v in pairs(m[2]) do p[k]=v*3 end
  b2:load{water=12, pigments=p}
  b2:wash{x=x, y=y+100, width=180, height=80}
end
wait(20)
print(balance().dry)
