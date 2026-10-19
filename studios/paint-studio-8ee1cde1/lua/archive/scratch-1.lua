--@ watercolor-engine 2

paper{width=1100,height=650,kind="cold-press",seed=4127}


local mixes = {
 {"sky", {["cobalt-blue"]=0.3, ["paynes-gray"]=0.05}},
 {"sky2", {["cerulean-blue"]=0.3, ["neutral-tint"]=0.05}},
 {"mtn", {["french-ultramarine"]=0.3, ["paynes-gray"]=0.15, ["burnt-sienna"]=0.05}},
 {"forest", {["hookers-green"]=0.8, ["paynes-gray"]=0.2}},
 {"grass", {["sap-green"]=0.6, ["hansa-yellow"]=0.3}},
 {"plain", {["sap-green"]=0.2, ["yellow-ochre"]=0.2, ["cobalt-blue"]=0.05}},
 {"scree", {["indian-red"]=0.6, ["burnt-umber"]=0.3}},
 {"scree2", {["burnt-sienna"]=0.5, ["quinacridone-rose"]=0.1, ["burnt-umber"]=0.2}},
}
for i,m in ipairs(mixes) do
  local b = brush{name="t"..i, width=30}
  for k=1,3 do
    local y = 40 + (i-1)*70
    local x0 = 40 + (k-1)*300
    local pig = {}
    for p,a in pairs(m[2]) do pig[p]=a*k end
    b:load{water=8, pigments=pig}
    b:stroke({{x0,y},{x0+240,y}}, {pressure=0.5})
    wait(0.3)
  end
end
wait(10)
print(balance().dry)
