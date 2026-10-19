paper{width=1056,height=704,kind="cold-press",seed=3117}


math.randomseed(8)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local u = brush{name="under", width=40}
for y=420,600,22 do
  local x=-20
  while x<560 do
    local L=35+math.random()*45
    if math.random()<0.85 then
      load(u,2.4,{["burnt-sienna"]=0.02,["french-ultramarine"]=0.02,["raw-umber"]=0.012})
      u:stroke({{x,y},{x+L,y}},{pressure=0.55,duration=0.008})
    end
    x=x+L
  end
end
for k=1,8 do wait(1) end
-- dry-brush streak trials at various widths/concentration
local rows = {
 {460, 8, 0.3, 0.8},{490, 8, 0.5, 0.8},{520,12,0.3,0.8},{550,12,0.5,1.5},{580,6,0.4,1.5}
}
for i,r in ipairs(rows) do
  local b = brush{name="db"..i, width=r[2]}
  b:load{water=2, pigments={["burnt-umber"]=r[4]*0.5*2,["french-ultramarine"]=r[4]*0.35*2,["burnt-sienna"]=r[4]*0.15*2}}
  b:stroke({{20,r[1]},{150,r[1]+1},{280,r[1]-1}},{pressure=r[3],dry=true,duration=0.1})
end
-- same but wet thin streak
for i,r in ipairs(rows) do
  local b = brush{name="wb"..i, width=r[2]*0.4}
  load(b, 0.3, {["burnt-umber"]=r[4]*0.25,["french-ultramarine"]=r[4]*0.2,["burnt-sienna"]=r[4]*0.08})
  b:stroke({{320,r[1]},{420,r[1]+1},{540,r[1]-1}},{pressure=r[3],duration=0.1})
end
for k=1,8 do wait(1) end print(balance().dry)



-- replay mud pass 2 random sequence to recover gap rectangles
math.randomseed(31)
local K = {{386,450,250},{392,470,190},{402,520,70},{418,478,46},{445,468,40},{490,560,55},{560,700,85},{630,785,128},{710,790,195}}
local function chan(y)
  if y<=K[1][1] then return K[1][2],K[1][3] end
  for i=1,#K-1 do
    if y<=K[i+1][1] then
      local u=(y-K[i][1])/(K[i+1][1]-K[i][1]); u=u*u*(3-2*u)
      return K[i][2]+(K[i+1][2]-K[i][2])*u, K[i][3]+(K[i+1][3]-K[i][3])*u
    end
  end
  return K[#K][2],K[#K][3]
end
local gaps={}
local y=404; local i=0
while y<720 do
  i=i+1
  local t=math.min(1,(y-386)/318)
  local w = 8+46*t
  local cx,hw = chan(y)
  local segs = {{-20, cx-hw-w*0.5-6},{cx+hw+w*0.5+6, 1076}}
  for _,sg in ipairs(segs) do
    local xa=sg[1]
    while xa < sg[2]-1 do
      local Ls = math.min(35+math.random()*45, sg[2]-xa)
      if math.random() < 0.88 then
        local a=math.random(); local b=math.random()
      else
        gaps[#gaps+1]={xa, xa+6+Ls, y, w}
        xa = xa + 6
      end
      xa = xa+Ls
    end
  end
  y = y + w*0.6 + math.random()*3
end
for _,g in ipairs(gaps) do print(string.format("%.0f %.0f %.0f %.0f", g[1],g[2],g[3],g[4])) end
