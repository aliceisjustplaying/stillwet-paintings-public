--@ watercolor-engine 2

paper{width=1100,height=650,kind="cold-press",seed=4127}


math.randomseed(1)
local covA={["indian-red"]=1.1, ["burnt-umber"]=0.55, ["buff-titanium"]=0.2}
local covB={["burnt-sienna"]=0.5, ["burnt-umber"]=0.4, ["indian-red"]=0.5}
for i=1,80 do local x=math.random()*1100 local y=420+math.random()*220 local b=brush{name="u"..i,width=30} b:load{water=3,pigments=(i%2==0) and covA or covB} b:stroke({{x,y},{x+100,y+8}},{pressure=0.5,duration=0.05}) end
wait(15)
for y=440,640,80 do for x=40,540,100 do drop{x=x,y=y,water=6,radius=60} end end
local w1=brush{name="w1",width=60}
w1:load{water=6,pigments={["burnt-umber"]=0.08,["sepia"]=0.03,["paynes-gray"]=0.015}}
w1:wash{x=0,y=410,width=540,height=240,pressure=0.5}
local w2=brush{name="w2",width=60}
w2:load{water=6,pigments={["burnt-umber"]=0.15,["sepia"]=0.05,["raw-umber"]=0.05}}
w2:wash{x=560,y=410,width=540,height=240,pressure=0.5}
wait(20) print(balance().dry)



math.randomseed(2)
local n=0
local function sp(x,y,s,m,water)
  n=n+1 local b=brush{name="sp"..n, width=s} b:load{water=water,pigments=m}
  b:stroke({{x,y},{x+s*0.9,y+s*0.2}},{pressure=0.5,duration=0.03})
end
local tests={
 {{["sepia"]=0.35, ["paynes-gray"]=0.25},0.25,3},
 {{["sepia"]=1.0, ["paynes-gray"]=0.6},0.3,3},
 {{["sepia"]=1.0, ["paynes-gray"]=0.6},0.6,5},
 {{["lamp-black"]=0.5, ["sepia"]=0.5},0.4,4},
 {{["buff-titanium"]=0.8, ["paynes-gray"]=0.15, ["raw-umber"]=0.1},0.4,5},
 {{["paynes-gray"]=0.5, ["indian-red"]=0.3,["buff-titanium"]=0.5},0.5,6},
}
for i,t in ipairs(tests) do
  for k=1,25 do sp(i*170-120+math.random()*120, 450+math.random()*180, t[3]*(0.7+math.random()*0.8), t[1], t[2]) end
end
wait(10) print(balance().dry)
