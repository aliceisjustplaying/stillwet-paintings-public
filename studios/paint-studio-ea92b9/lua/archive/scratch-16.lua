-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 6}, {"yellow ochre", 0.35}, {"raw umber", 0.12}}, um=35}}, linen={16, 14}, seed=1774, size=650}

--@ chunk 2
s_grn  = pile{{"lead white",5},{"Naples yellow",1},{"cobalt blue",0.6}, name="s_grn"}
s_glow = pile{{"lead white",5},{"Naples yellow",1.5},{"yellow ochre",0.25},{"vermilion",0.05}, name="s_glow"}
s_low  = pile{{"lead white",4},{"Naples yellow",1.4},{"yellow ochre",0.3},{"vermilion",0.2},{"rose madder",0.1}, name="s_low"}
local function wgt(c, r) return function(x,y) return math.max(0, 1 - math.abs(y-c)/r) end end
local sky = rect(0,200,1000,270)
work(sky, {hand="broad", piles={{s_grn,wgt(325,100)},{s_glow,wgt(400,80)},{s_low,wgt(465,70)}}, angle=0, ruler=true, coverage=2.6, fill=true, clip=sky, seed=1})
blend(sky, {angle=0})
print(wait(6*24*60))
function plens(x0, x1, y, th, seed, skew)
  skew = skew or 0
  local nz = noise{seed=seed, period=40, octaves=2}
  local top, bot = {}, {}
  local n = math.max(10, math.floor((x1-x0)/5))
  for i=0,n do
    local t = i/n
    local x = lerp(x0, x1, t)
    local env = math.sin(math.pi*t)^0.7
    local yy = y + skew*(t-0.5)
    top[#top+1] = {x, yy - th*0.55*env*(0.5+1.0*nz:at01(x, y))}
    bot[#bot+1] = {x, yy + th*0.45*env*(0.8+0.4*nz:at01(x+70, y))}
  end
  local pts = {}
  for i=1,#top do pts[#pts+1] = top[i] end
  for i=#bot,1,-1 do pts[#pts+1] = bot[i] end
  return poly(pts, true)
end
cl_a = pile{{"lead white",3},{"Naples yellow",0.7},{"smalt",0.35},{"rose madder",0.1},{"raw umber",0.2}, name="cl_a"}
cl_b = pile{{"lead white",3},{"Naples yellow",0.9},{"smalt",0.2},{"rose madder",0.12},{"raw umber",0.12},{"vermilion",0.03}, name="cl_b"}
local bars = plens(100, 450, 380, 5, 1, 1) + plens(180, 380, 389, 3, 2, 0)
local fb = brush{kind="flat", width=3}
work(bars, {hand="detail", tool=fb, piles={{cl_a, function(x,y) return 0.7 end},{cl_b, function(x,y) return 0.3 end}}, coverage=3, fill=true, angle=0, seed=3})
blend(bars:grow(2):blur(2), {angle=0})
local bars2 = plens(550, 950, 380, 5, 1, 1) + plens(640, 860, 389, 3, 2, 0)
work(bars2, {hand="detail", tool=fb, piles={{cl_a, function(x,y) return 0.7 end},{cl_b, function(x,y) return 0.3 end}}, coverage=3, fill=true, angle=0, seed=4})

--@ chunk 3
cl_c = pile{{"lead white",2.6},{"Naples yellow",0.6},{"smalt",0.45},{"rose madder",0.12},{"raw umber",0.28}, name="cl_c"}
local fb = brush{kind="flat", width=3}
local bars = plens(560, 990, 300, 9, 11, 2) + plens(600, 700, 297, 4, 12, 0) + plens(800, 940, 302, 5, 13, 1)
  + plens(650, 880, 312, 4, 14, -1) + plens(720, 790, 318.5, 2.5, 15, 0)
  + plens(880, 1004, 288, 3.5, 16, 0)
work(bars, {hand="detail", tool=fb, piles={{cl_c, 0.6},{cl_a, 0.4}}, coverage=3, fill=true, angle=0, seed=21})

--@ chunk 4
hb_main = pile{{"bone black",1},{"raw umber",1.2},{"green earth",0.35},{"Prussian blue",0.05}, medium=0.4, name="hb_main"}
local hp = pile{{"raw umber",1.5},{"bone black",0.8},{"green earth",0.4},{"Prussian blue",0.04}}
local hl = below(function(x) return 470 + 0.05*(x-500) end)
work(hl * rect(0,440,1000,100), {hand="body", pile=hp, coverage=2.4, fill=true, clip=hl * rect(0,440,1000,100), seed=5})
wait(5*24*60)
tuft_p = pile{{"bone black",1},{"raw umber",1.1},{"green earth",0.4},{"yellow ochre",0.1}, medium=0.2, name="tuft_p"}
trg = brush{kind="rigger", width=1.4, point=1}
function tuft(x, y, size, pl)
  local n = math.random(4, 8)
  for i=1,n do
    local a = -math.pi/2 + randn(0, 0.45)
    local L = size * rand(0.4, 1.0)
    local bx = x + rand(-size*0.5, size*0.5)
    local by = y + rand(0.5, 1.5)
    local mx, my = bx + math.cos(a)*L*0.5, by + math.sin(a)*L*0.5
    local bend = randn(0, 0.25)
    local ex, ey = bx + math.cos(a+bend)*L, by + math.sin(a+bend)*L
    if trg:fullness() < 0.4 then trg:reload(pl, 0.7) end
    trg:gesture({{bx, by, 0.45}, {mx, my, 0.35}, {ex, ey, 0.05}}, {wobble=0.05, ramps={0.02, 0.4}})
  end
end
trg:reload(tuft_p, 0.7)
local x = 20
while x < 980 do
  local y = 470 + 0.05*(x-500)
  tuft(x, y, rand(4, 10), tuft_p)
  x = x + rand(8, 40)
end

--@ chunk 5
function tuft2(x, y, size, pl)
  local n = math.random(8, 14)
  for i=1,n do
    local a = -math.pi/2 + randn(0, 0.3)
    local L = size * rand(0.35, 1.0)
    local bx = x + randn(0, size*0.25)
    local by = y + rand(0.8, 1.8)
    local bend = randn(0, 0.2)
    local mx, my = bx + math.cos(a)*L*0.5, by + math.sin(a)*L*0.5
    local ex, ey = bx + math.cos(a+bend)*L, by + math.sin(a+bend)*L
    if trg:fullness() < 0.4 then trg:reload(pl, 0.6) end
    trg:gesture({{bx, by, 0.32}, {mx, my, 0.22}, {ex, ey, 0.03}}, {wobble=0.03, ramps={0.02, 0.5}})
  end
end
function bump(x, y, w, h, pl)
  local m = ellipse(x, y + h*0.2, w/2, h):roughen(0.5, 2, math.random(1,999)) * above(function(xx) return y + 3 end)
  work(m, {hand="detail", tool={kind="round", width=1.4, point=0.5}, pile=pl, coverage=3, fill=true, seed=math.random(1,9999)})
end
local yb = function(x) return 470 + 0.05*(x-500) + 30 end
local x = 30
while x < 980 do
  local r = math.random()
  if r < 0.35 then bump(x, yb(x), rand(6, 16), rand(1.5, 3.5), tuft_p)
  elseif r < 0.7 then tuft2(x, yb(x), rand(3, 7), tuft_p) end
  x = x + rand(10, 35)
end
local hp = pile{{"raw umber",1.5},{"bone black",0.8},{"green earth",0.4},{"Prussian blue",0.04}}

--@ chunk 6
local hp = pile{{"raw umber",1.5},{"bone black",0.8},{"green earth",0.4},{"Prussian blue",0.04}}
local hl = below(function(x) return 330 + 0.04*(x-500) end) * rect(0,300,1000,60)
work(hl, {hand="body", pile=hp, coverage=2.4, fill=true, clip=hl, seed=7})
wait(5*24*60)
local yb = function(x) return 330 + 0.04*(x-500) end
trg:reload(tuft_p, 0.6)
local x = 30
while x < 980 do
  local r = math.random()
  if r < 0.35 then bump(x, yb(x), rand(6, 16), rand(1.5, 3.5), tuft_p)
  elseif r < 0.7 then tuft2(x, yb(x), rand(3, 7), tuft_p) end
  x = x + rand(10, 35)
end

--@ chunk 7
print(wait(30*24*60))
g_near = pile{{"bone black",1.2},{"raw umber",0.9},{"Prussian blue",0.08}, medium=0.7, name="g_near"}
local m = rect(0,450,500,264)
work(m, {hand="glaze", pile=g_near, angle=0.02, coverage=2, fill=true, clip=m, load_at=function(x,y) return clamp((y-560)/130, 0, 1) end, seed=5})
hb_main = pile{{"bone black",1},{"raw umber",1.2},{"green earth",0.35},{"Prussian blue",0.05}, medium=0.4}
d2 = pile{{"lead white",1.4},{"smalt",1.1},{"cobalt blue",0.7},{"raw umber",0.14}}
cool = mix{{hb_main,0.8},{d2,0.2}, name="cool"}
cool_t = pile{{"bone black",1},{"raw umber",1.2},{"green earth",0.35},{"Prussian blue",0.05},{"lead white",0.35},{"smalt",0.3},{"cobalt blue",0.18}, thinner=0.5, name="cool_t"}
local m2 = rect(500,330,500,60)
work(m2, {hand="body", tool="filbert 7", pile=cool_t, angle=0.02, coverage=1.5, clip=m2, load_at=function(x,y) return clamp(1-(y-330)/60,0,1) end, seed=6})
