--@ watercolor-engine 2

paper{width=1100,height=650,kind="cold-press",seed=4127}


for y=25,300,80 do for x=30,1100,105 do drop{x=x,y=y,water=13,radius=72} end end
local b = brush{name="sky", width=60}
b:load{water=6, pigments={["cobalt-blue"]=0.06, ["french-ultramarine"]=0.02, ["paynes-gray"]=0.05, ["burnt-sienna"]=0.01}}
b:wash{x=-20,y=-10,width=1140,height=250, grade=0.4, pressure=0.5}
local d = brush{name="streak", width=60}
local function streak(pts, amt)
  d:load{water=4, pigments={["cobalt-blue"]=0.05*amt, ["french-ultramarine"]=0.02*amt, ["paynes-gray"]=0.07*amt}}
  d:stroke(pts, {pressure=0.5, duration=0.2})
end
streak({{-10,25},{150,15},{350,28},{480,12}},1.0)
streak({{-10,105},{120,95},{260,100},{360,90}},0.9)
local h = brush{name="haze", width=60}
h:load{water=6, pigments={["cobalt-blue"]=0.02, ["paynes-gray"]=0.02, ["raw-umber"]=0.012}}
h:wash{x=-20,y=235,width=1140,height=80, pressure=0.5}
wait(0.6)
local C = brush{name="cum", width=16}
local function blob(cx,cy,r,w)
  local pts={}
  for i=0,12 do local a=i/12*2*math.pi*1.3 local rr=r*(0.3+0.7*(i/12)) pts[#pts+1]={cx+rr*math.cos(a), cy+rr*0.7*math.sin(a)} end
  C:load{water=w} C:lift(pts,{duration=0.12})
end
-- base row (flat-ish), then bumps above
for _,p in ipairs({{120,232,10},{165,228,13},{215,226,9},{262,224,15},{318,222,12},{372,224,16},{430,226,10},{478,228,12},{528,234,7}}) do blob(p[1],p[2],p[3],1.0) end
for _,p in ipairs({{148,214,8},{196,206,11},{240,210,7},{290,200,12},{338,190,9},{362,182,13},{400,198,8},{455,210,9},{505,214,6}}) do blob(p[1],p[2],p[3],0.8) end
for _,p in ipairs({{625,238,5},{648,232,6},{705,252,7},{725,246,5},{915,286,9},{960,280,11},{1010,292,10},{1060,302,13},{1095,318,12},{985,300,8}}) do blob(p[1],p[2],p[3],0.9) end
local L = brush{name="lift", width=24}
local function lift(pts, w) L:load{water=w} L:lift(pts, {duration=0.2}) end
lift({{430,122},{520,108},{620,96},{740,84},{860,72},{1000,60}},2.6)
lift({{600,160},{700,150},{820,142},{930,136}},2.2)
lift({{560,48},{680,34},{800,26},{900,24}},2.0)
lift({{180,170},{280,162},{380,158}},1.8)
wait(25) print(balance().dry)



local function ridgefill(br, ridge, bottom, step, load)
  -- ridge: list of {x,y}; fill rows downward from ridge to bottom
  local n = math.floor((bottom - ridge[1][2]) / step)
  for k=0,n do
    local pts={}
    for _,p in ipairs(ridge) do
      local y = p[2] + k*step
      if y < bottom then pts[#pts+1]={p[1], y} else pts[#pts+1]={p[1], bottom} end
    end
    br:load(load)
    br:stroke(pts,{pressure=0.5, duration=0.3})
  end
end
local m = brush{name="mtn", width=16}
local ridge={{370,282},{400,278},{430,272},{455,266},{480,262},{510,257},{535,261},{560,265},{580,258},{605,251},{625,256},{650,263},{680,272},{710,282},{740,290}}
ridgefill(m, ridge, 305, 9, {water=2.5, pigments={["cobalt-blue"]=0.05, ["ultramarine-violet"]=0.02, ["paynes-gray"]=0.05}})
local w = brush{name="soft", width=30}
w:load{water=6}
w:stroke({{360,300},{500,302},{650,300},{760,300}},{pressure=0.5,duration=0.3})
wait(10)
print(balance().dry)



local function ridgefill(br, ridge, bottom, step, load, dur)
  local n = math.floor((bottom - ridge[1][2]) / step)
  for k=0,n do
    local pts={}
    for _,p in ipairs(ridge) do
      local y = math.min(p[2] + k*step, bottom)
      pts[#pts+1]={p[1], y}
    end
    br:load(load)
    br:stroke(pts,{pressure=0.5, duration=dur or 0.2})
  end
end
local m = brush{name="mtn2", width=20}
local ridge={{370,392},{400,388},{430,382},{455,376},{480,372},{510,367},{535,371},{560,375},{580,368},{605,361},{625,366},{650,373},{680,382},{710,392},{740,400}}
ridgefill(m, ridge, 420, 7, {water=2.0, pigments={["paynes-gray"]=0.025, ["french-ultramarine"]=0.012, ["burnt-sienna"]=0.005}})
wait(10)
print(balance().dry)



local function ridgefill(br, ridge, bottom, step, load, dur)
  local miny=1e9 for _,p in ipairs(ridge) do miny=math.min(miny,p[2]) end
  local n = math.ceil((bottom - miny) / step)
  for k=0,n do
    local pts={}
    for _,p in ipairs(ridge) do pts[#pts+1]={p[1], math.min(p[2] + k*step, bottom)} end
    br:load(load)
    br:stroke(pts,{pressure=0.5, duration=dur or 0.2})
  end
end
local m = brush{name="mtn3", width=20}
local ridge={{370,492},{400,488},{430,482},{455,476},{480,472},{510,467},{535,471},{560,475},{580,468},{605,461},{625,466},{650,473},{680,482},{710,492},{740,500}}
ridgefill(m, ridge, 515, 7, {water=2.0, pigments={["paynes-gray"]=0.05, ["french-ultramarine"]=0.03, ["cobalt-blue"]=0.02, ["burnt-sienna"]=0.008}})
wait(10)
print(balance().dry)



local b = brush{name="buff", width=30}
local loads={0.15,0.3,0.6,1.0}
for i,a in ipairs(loads) do
  b:load{water=3, pigments={["buff-titanium"]=a, ["cobalt-blue"]=0.01*a}}
  local x=340+i*90
  b:stroke({{x,450},{x,530}},{pressure=0.5,duration=0.15})
end
wait(10) print(balance().dry)



for x=380,800,100 do drop{x=x,y=480,water=4,radius=50} drop{x=x,y=530,water=4,radius=50} end
local v = brush{name="veil", width=40}
v:load{water=4, pigments={["buff-titanium"]=0.12, ["cobalt-blue"]=0.006, ["paynes-gray"]=0.004}}
v:wash{x=340,y=455,width=480,height=40, pressure=0.5}
local v2 = brush{name="veil2", width=40}
v2:load{water=4, pigments={["buff-titanium"]=0.3, ["cobalt-blue"]=0.012, ["paynes-gray"]=0.008}}
v2:wash{x=340,y=490,width=480,height=50, pressure=0.5}
wait(10) print(balance().dry)
