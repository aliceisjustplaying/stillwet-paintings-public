--@ watercolor-engine 2

paper{width=1100,height=660,kind="cold-press",seed=2023}


function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
function rect(name, x0,y0,x1,y1, width, water, mix)
  for x=x0+50,x1-50,80 do for y=y0+50,y1-50,80 do drop{x=x,y=y,water=6,radius=45} end end
  local b = brush{name=name, width=width}
  for y=y0+12,y1-12,20 do
    local x=x0+12
    while x < x1-12 do topup(b,water,mix); b:stroke({{x,y},{math.min(x1-12,x+50),y}},{pressure=0.5,duration=0.02}); x=x+50 end
  end
end
rect("road",20,20,520,300,34,5,{["paynes-gray"]=0.4, ["raw-umber"]=0.22, ["french-ultramarine"]=0.06})
rect("conc",560,20,1080,300,34,5,{["paynes-gray"]=0.1, ["raw-umber"]=0.12, ["yellow-ochre"]=0.03})
rect("beige",20,340,520,640,40,5,{["yellow-ochre"]=0.09, ["raw-umber"]=0.13, ["paynes-gray"]=0.02})
wait(12)
print(balance().dry)
-- glazes: vertical bands
local function band(name, x, y0, y1, width, water, mix)
  local b = brush{name=name, width=width}
  local y=y0
  while y<y1 do topup(b,water,mix); b:stroke({{x,y},{x,math.min(y1,y+40)}},{pressure=0.5,duration=0.02}); y=y+40 end
end
band("g1",80,10,310,30,4,{["buff-titanium"]=0.3})
band("g2",160,10,310,30,4,{["buff-titanium"]=0.8})
band("g3",240,10,310,30,4,{["buff-titanium"]=0.6,["quinacridone-rose"]=0.02})
band("g4",320,10,310,30,4,{["buff-titanium"]=0.5,["cobalt-violet"]=0.1})
band("g5",620,10,310,30,4,{["french-ultramarine"]=0.08,["burnt-sienna"]=0.06})
band("g6",700,10,310,30,4,{["cobalt-violet"]=0.15})
band("g7",780,10,310,30,4,{["buff-titanium"]=0.4,["cobalt-violet"]=0.08})
band("g8",860,10,310,30,4,{["french-ultramarine"]=0.12,["burnt-sienna"]=0.04, ["quinacridone-rose"]=0.02})
band("g9",80,330,650,30,4,{["cobalt-violet"]=0.12})
band("g10",160,330,650,30,4,{["ultramarine-violet"]=0.06,["burnt-sienna"]=0.02})
band("g11",240,330,650,30,4,{["buff-titanium"]=0.4})
band("g12",320,330,650,30,4,{["buff-titanium"]=0.3,["cobalt-violet"]=0.08})
wait(8)
print(balance().dry)
