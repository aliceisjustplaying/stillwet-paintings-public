--@ watercolor-engine 2

paper{width=1100,height=650,kind="cold-press",seed=4127}


local g = brush{name="g", width=50}
g:load{water=5, pigments={["sap-green"]=0.09, ["hansa-yellow"]=0.05, ["cobalt-blue"]=0.012}}
g:wash{x=-20,y=100,width=1140,height=250, pressure=0.5}
wait(12)
local h = brush{name="haze2", width=50}
local function row(y, f)
  h:load{water=4, pigments={["paynes-gray"]=0.025*f, ["french-ultramarine"]=0.02*f, ["quinacridone-rose"]=0.01*f, ["cobalt-blue"]=0.01*f}}
  h:wash{x=-20,y=y,width=1140,height=30, pressure=0.5}
end
row(160,0.8) row(185,0.9) row(210,0.9) row(235,1.0)
wait(15)
-- veil wash tests: left half wash call, right half overlapping strokes
for x=40,520,80 do drop{x=x,y=150,water=3,radius=30} drop{x=x,y=200,water=3,radius=30} end
local v = brush{name="veil", width=40}
v:load{water=4, pigments={["buff-titanium"]=1.5, ["cerulean-blue"]=0.12, ["french-ultramarine"]=0.1, ["quinacridone-rose"]=0.02, ["paynes-gray"]=0.02}}
v:wash{x=0,y=130,width=540,height=100, pressure=0.5}
local s = brush{name="vs", width=36}
for y=130,230,14 do
  s:load{water=3, pigments={["buff-titanium"]=2.5, ["cerulean-blue"]=0.2, ["french-ultramarine"]=0.17, ["quinacridone-rose"]=0.035, ["paynes-gray"]=0.035}}
  s:stroke({{580,y},{720,y+3},{860,y-2},{1000,y+2},{1100,y}},{pressure=0.5,duration=0.15})
end
wait(15) print(balance().dry)
