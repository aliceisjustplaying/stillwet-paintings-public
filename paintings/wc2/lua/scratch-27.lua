paper{width=1056,height=704,kind="cold-press",seed=3117}


math.randomseed(31)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
-- brick underlayer like painting
local y=404; local i=0
while y<580 do
  i=i+1
  local t=math.min(1,(y-386)/318)
  local w = 8+46*t
  local b = brush{name="mudg"..i, width=w}
  local xa=-20
  while xa < 500 do
    local Ls = 35+math.random()*45
    if math.random() < 0.85 then
      local v=(0.25+1.2*t^1.3)*1.3
      load(b, 0.7+2.6*t, {["burnt-sienna"]=0.02*v, ["french-ultramarine"]=0.018*v, ["raw-umber"]=0.012*v})
      b:stroke({{xa,y},{xa+Ls,y}},{pressure=0.55,duration=0.008})
    else xa=xa+6 end
    xa=xa+Ls
  end
  y = y + w*0.6 + math.random()*3
end
for k=1,10 do wait(1) end
-- contour glaze: curved sweeping strokes
local function contour(name, y0, slope, bow, x1, w, c)
  local b = brush{name=name, width=w}
  local x=-20
  while x < x1 do
    local L=30
    local function yy(xx) local u=(xx+20)/(x1+20); return y0 + slope*u*(x1+20) + bow*math.sin(u*math.pi) end
    load(b, 2.2, {["burnt-sienna"]=0.022*c,["french-ultramarine"]=0.02*c,["raw-umber"]=0.012*c})
    b:stroke({{x,yy(x)},{x+L,yy(x+L)}},{pressure=0.55,duration=0.004})
    x=x+L
  end
end
contour("c1", 420, 0.02, -8, 470, 14, 1.0)
contour("c2", 452, 0.05, -10, 470, 18, 1.0)
contour("c3", 500, 0.03, -14, 480, 22, 1.2)
contour("c4", 540, 0.04, -12, 500, 26, 1.2)
for k=1,8 do wait(1) end print(balance().dry)



math.randomseed(32)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
-- over the right half of the previous trial region (x 260-500) to compare with left
-- sandbar shapes: crisp curved top edge, body fills downward as merged rows
local function bar(name, xa, xb, ytop, depth, c)
  local b = brush{name=name, width=12}
  local function top(x) local u=(x-xa)/(xb-xa); return ytop - 6*math.sin(u*math.pi) + 2*math.sin(x/23) end
  local rows = math.ceil(depth/7)
  for r=0,rows do
    local x=xa+ r*3
    local fade = 1 - r/(rows+1)
    while x < xb - r*4 do
      load(b, 1.2, {["burnt-sienna"]=0.03*c*fade,["french-ultramarine"]=0.028*c*fade,["raw-umber"]=0.015*c*fade})
      b:stroke({{x,top(x)+5+r*7},{x+24,top(x+24)+5+r*7}},{pressure=0.5,duration=0.003})
      x=x+24
    end
  end
end
bar("b1", 30, 230, 455, 30, 1.0)
bar("b2", 120, 470, 520, 36, 1.2)
bar("b3", 280, 480, 430, 20, 0.9)
for k=1,8 do wait(1) end print(balance().dry)
