paper{width=1056,height=704,kind="cold-press",seed=3117}


math.randomseed(9)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local gaps = {{60,130,440,16},{200,280,440,16},{340,420,440,16},{60,140,500,25},{200,270,500,25},{340,420,500,25}}
local u = brush{name="under", width=1}
for y,w in pairs({[440]=16,[500]=25}) do
  local b = brush{name="u"..y, width=w}
  local x=-20
  while x<560 do
    local gap=false
    for _,g in ipairs(gaps) do if g[3]==y and x>=g[1]-1 and x<g[2] then gap=true end end
    if not gap then
      load(b,1.5,{["burnt-sienna"]=0.03,["french-ultramarine"]=0.025,["raw-umber"]=0.015})
      b:stroke({{x,y},{x+10,y}},{pressure=0.55,duration=0.004})
    end
    x=x+10
  end
end
for k=1,8 do wait(1) end
-- treatments: A (first column): sky pool tint; B: pool + dark far lip; C: cover with mud
local function pool(g, lip)
  local x0,x1,y,w = g[1],g[2],g[3],g[4]
  local p = brush{name="pool"..x0..y, width=w*0.9}
  local pts={}
  local n=8
  for q=0,n do
    local uu=q/n
    pts[#pts+1]={x0-4+(x1-x0+8)*uu, y+ (uu-0.5)*2, 0.15+0.45*math.sin(uu*math.pi)^0.5}
  end
  load(p, 0.8, {["french-ultramarine"]=0.025,["quinacridone-rose"]=0.01,["raw-sienna"]=0.004})
  p:stroke(pts,{duration=0.03})
  if lip then
    local l = brush{name="lip"..x0..y, width=2}
    local p2={}
    for q=0,n do local uu=q/n; p2[#p2+1]={x0+(x1-x0)*uu, y-w*0.38+ (uu-0.5)*2 + math.sin(uu*7)*0.6, 0.2+0.5*math.sin(uu*math.pi)} end
    load(l, 0.3, {["burnt-umber"]=0.6,["french-ultramarine"]=0.4})
    l:stroke(p2,{duration=0.03})
  end
end
pool(gaps[1], false); pool(gaps[4], false)
pool(gaps[2], true); pool(gaps[5], true)
for _,g in ipairs({gaps[3],gaps[6]}) do
  local c = brush{name="cov"..g[3], width=g[4]}
  load(c, 1.5, {["burnt-sienna"]=0.03,["french-ultramarine"]=0.025,["raw-umber"]=0.015})
  c:stroke({{g[1]-2,g[3]},{g[2]+2,g[3]}},{pressure=0.55,duration=0.01})
end
for k=1,8 do wait(1) end print(balance().dry)
