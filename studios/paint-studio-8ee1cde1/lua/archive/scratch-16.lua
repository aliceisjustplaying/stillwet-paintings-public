--@ watercolor-engine 2

paper{width=1100,height=650,kind="cold-press",seed=4127}


-- replicate navy band: same haze wash on yellowgreen underlayer
local g = brush{name="g", width=50}
g:load{water=5, pigments={["sap-green"]=0.09, ["hansa-yellow"]=0.05, ["cobalt-blue"]=0.012}}
g:wash{x=-20,y=100,width=1140,height=200, pressure=0.5}
wait(12)
local h = brush{name="haze2", width=50}
local function row(y, f)
  h:load{water=4, pigments={["paynes-gray"]=0.025*f, ["french-ultramarine"]=0.02*f, ["quinacridone-rose"]=0.01*f, ["cobalt-blue"]=0.01*f}}
  h:wash{x=-20,y=y,width=1140,height=30, pressure=0.5}
end
row(100,0.9) row(125,1.0) row(150,0.9)
wait(15)
-- opaque veil trials as vertical strips
local mixes={
 {["buff-titanium"]=2.0, ["cerulean-blue"]=0.3, ["quinacridone-rose"]=0.02},
 {["buff-titanium"]=3.0, ["cerulean-blue"]=0.5, ["quinacridone-rose"]=0.03},
 {["buff-titanium"]=3.0, ["cerulean-blue"]=0.3, ["naples-yellow"]=1.0},
 {["cerulean-blue"]=1.0, ["buff-titanium"]=1.5, ["paynes-gray"]=0.03},
 {["buff-titanium"]=5.0, ["cerulean-blue"]=0.6, ["cobalt-violet"]=0.2},
 {["sap-green"]=0.15, ["hansa-yellow"]=0.05, ["hookers-green"]=0.1},
}
for i,mm in ipairs(mixes) do
  local b=brush{name="v"..i, width=40}
  local x=100+(i-1)*150
  b:load{water=4, pigments=mm}
  b:stroke({{x,80},{x,240}},{pressure=0.5,duration=0.2})
end
wait(12) print(balance().dry)



local h = brush{name="haze3", width=50}
for _,y in ipairs({340,365,390}) do
h:load{water=4, pigments={["paynes-gray"]=0.05, ["french-ultramarine"]=0.04, ["quinacridone-rose"]=0.02, ["cobalt-blue"]=0.02}}
h:wash{x=-20,y=y,width=1140,height=30, pressure=0.5}
end
wait(15)
local mixes={
 {["buff-titanium"]=5.0, ["cerulean-blue"]=0.5, ["cobalt-violet"]=0.4, ["quinacridone-rose"]=0.03},
 {["buff-titanium"]=5.0, ["cerulean-blue"]=0.7, ["cobalt-violet"]=0.6},
 {["buff-titanium"]=6.0, ["cerulean-blue"]=0.6, ["ultramarine-violet"]=0.2},
 {["buff-titanium"]=4.0, ["cerulean-blue"]=0.4, ["cobalt-violet"]=0.3, ["sap-green"]=0.05},
 {["buff-titanium"]=8.0, ["cerulean-blue"]=0.9, ["cobalt-violet"]=0.7},
 {["buff-titanium"]=3.0, ["cerulean-blue"]=0.3, ["cobalt-violet"]=0.25},
}
for i,mm in ipairs(mixes) do
  local b=brush{name="w"..i, width=40}
  local x=100+(i-1)*150
  b:load{water=4, pigments=mm}
  b:stroke({{x,320},{x,470}},{pressure=0.5,duration=0.2})
end
wait(12) print(balance().dry)



local mixes={
 {["buff-titanium"]=4.0, ["french-ultramarine"]=0.3, ["quinacridone-rose"]=0.05},
 {["buff-titanium"]=4.0, ["cobalt-violet"]=1.0, ["cerulean-blue"]=0.2},
 {["buff-titanium"]=4.0, ["ultramarine-violet"]=0.4},
 {["buff-titanium"]=4.0, ["french-ultramarine"]=0.5, ["quinacridone-rose"]=0.08, ["cerulean-blue"]=0.2},
 {["buff-titanium"]=4.0, ["cobalt-blue"]=0.4, ["cobalt-violet"]=0.4},
 {["buff-titanium"]=4.0, ["french-ultramarine"]=0.2, ["paynes-gray"]=0.1},
}
for i,mm in ipairs(mixes) do
  local b=brush{name="u"..i, width=40}
  local x=170+(i-1)*150
  b:load{water=4, pigments=mm}
  b:stroke({{x,320},{x,470}},{pressure=0.5,duration=0.2})
end
wait(12) print(balance().dry)



local mixes={
 {["buff-titanium"]=3.0, ["cerulean-blue"]=0.15, ["french-ultramarine"]=0.05},
 {["buff-titanium"]=3.0, ["cerulean-blue"]=0.25, ["french-ultramarine"]=0.08, ["quinacridone-rose"]=0.02},
 {["buff-titanium"]=2.0, ["cerulean-blue"]=0.1, ["french-ultramarine"]=0.04, ["quinacridone-rose"]=0.01},
 {["buff-titanium"]=4.0, ["cerulean-blue"]=0.3, ["french-ultramarine"]=0.25, ["quinacridone-rose"]=0.05, ["paynes-gray"]=0.05},
}
for i,mm in ipairs(mixes) do
  local b=brush{name="s"..i, width=40}
  local x=60+(i-1)*260
  b:load{water=4, pigments=mm}
  b:stroke({{x,190},{x+200,190}},{pressure=0.5,duration=0.2})
  b:load{water=4, pigments=mm}
  b:stroke({{x,250},{x+200,250}},{pressure=0.5,duration=0.2})
  b:load{water=4, pigments=mm}
  b:stroke({{x,140},{x+200,140}},{pressure=0.5,duration=0.2})
  b:load{water=4, pigments=mm}
  b:stroke({{x,30},{x+200,30}},{pressure=0.5,duration=0.2})
end
wait(12) print(balance().dry)
