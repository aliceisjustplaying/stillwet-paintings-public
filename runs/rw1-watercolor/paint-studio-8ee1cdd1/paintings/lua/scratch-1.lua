--@ watercolor-engine 2

paper{width=1200,height=710,kind="cold-press",seed=2013}

local mixes = {
 {"sky", {["cerulean-blue"]=1}},
 {"sky2", {["cobalt-blue"]=1}},
 {"cloudgrey", {["french-ultramarine"]=0.5, ["burnt-sienna"]=0.35}},
 {"mtn", {["cobalt-blue"]=0.7, ["quinacridone-rose"]=0.1, ["burnt-sienna"]=0.2}},
 {"forest", {["sap-green"]=0.6, ["french-ultramarine"]=0.3, ["burnt-sienna"]=0.15}},
 {"yg", {["hansa-yellow"]=0.6, ["sap-green"]=0.4}},
 {"red", {["indian-red"]=0.6, ["burnt-sienna"]=0.3, ["french-ultramarine"]=0.1}},
 {"rock", {["sepia"]=0.6, ["french-ultramarine"]=0.4}},
}
local concs = {0.15, 0.5, 1.5}
for i,m in ipairs(mixes) do
  for j,c in ipairs(concs) do
    local b = brush{name="t"..i.."_"..j, width=30}
    local pig = {}
    for k,v in pairs(m[2]) do pig[k]=v*c end
    b:load{water=12, pigments=pig}
    local x0 = 40 + (j-1)*180
    local y = 40 + (i-1)*80
    b:stroke({{x0,y},{x0+140,y}}, {pressure=0.5})
  end
end
wait(10)
print(balance().dry)

local mixes = {
 {"forestA", {["hookers-green"]=0.6, ["french-ultramarine"]=0.25, ["burnt-sienna"]=0.1}},
 {"forestB", {["sap-green"]=0.6, ["phthalo-blue"]=0.08, ["burnt-sienna"]=0.1}},
 {"distgreen", {["sap-green"]=0.4, ["cobalt-blue"]=0.5, ["burnt-sienna"]=0.05}},
 {"yg2", {["sap-green"]=0.6, ["hansa-yellow"]=0.35, ["french-ultramarine"]=0.05}},
 {"red2", {["indian-red"]=0.5, ["burnt-umber"]=0.35, ["french-ultramarine"]=0.1}},
 {"skyg", {["cobalt-blue"]=0.8, ["french-ultramarine"]=0.2, ["burnt-sienna"]=0.1}},
 {"haze", {["cobalt-blue"]=0.5, ["cobalt-violet"]=0.2, ["raw-sienna"]=0.2}},
}
local concs = {0.15, 0.5, 1.5}
for i,m in ipairs(mixes) do
  for j,c in ipairs(concs) do
    local b = brush{name="u"..i.."_"..j, width=30}
    local pig = {}
    for k,v in pairs(m[2]) do pig[k]=v*c end
    b:load{water=12, pigments=pig}
    local x0 = 640 + (j-1)*180
    local y = 40 + (i-1)*80
    b:stroke({{x0,y},{x0+140,y}}, {pressure=0.5})
  end
end
wait(10)
print(balance().dry)