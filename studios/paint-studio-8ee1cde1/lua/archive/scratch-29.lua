--@ watercolor-engine 2

paper{width=1100,height=650,kind="cold-press",seed=4127}


local mA={["indian-red"]=1.1, ["burnt-umber"]=0.55, ["buff-titanium"]=0.4, ["paynes-gray"]=0.03}
for y=400,640,15 do local b=brush{name="u"..y, width=28} b:load{water=3,pigments=mA} b:stroke({{0,y},{1100,y+5}},{pressure=0.5,duration=0.2}) end
wait(15)
local g3={["raw-umber"]=0.12, ["paynes-gray"]=0.05, ["buff-titanium"]=0.3}
for i=1,6 do local b=brush{name="p"..i, width=30} b:load{water=2.6,pigments=g3} b:stroke({{i*160,450},{i*160+100,455}},{pressure=0.5,duration=0.05})
 local b2=brush{name="q"..i, width=30} b2:load{water=2.6,pigments=g3} b2:stroke({{i*160,560},{i*160+100,565}},{pressure=0.5,duration=0.05}) end
wait(12)
local cov={
 {["indian-red"]=1.1, ["burnt-umber"]=0.55, ["paynes-gray"]=0.03},
 {["indian-red"]=0.8, ["burnt-umber"]=0.6, ["sepia"]=0.1},
 {["indian-red"]=1.5, ["burnt-umber"]=0.7},
 {["burnt-sienna"]=0.5, ["burnt-umber"]=0.4, ["indian-red"]=0.5},
 {["indian-red"]=1.1, ["burnt-umber"]=0.55, ["buff-titanium"]=0.2},
 {["indian-red"]=0.6, ["sepia"]=0.3, ["burnt-umber"]=0.3},
}
for i,m in ipairs(cov) do local b=brush{name="c"..i, width=36} b:load{water=3,pigments=m} b:stroke({{i*160-10,452},{i*160+110,456}},{pressure=0.5,duration=0.05}) end
wait(12) print(balance().dry)
