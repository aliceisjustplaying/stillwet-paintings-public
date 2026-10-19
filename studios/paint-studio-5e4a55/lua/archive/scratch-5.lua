-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ engine 8
--@ knife-skim
--@ limbs-join-nearest
--@ blend-feather
--@ brush-skim
--@ blend-at-masks
--@ glaze-film
--@ liquid-film-levels
--@ rag-lift
--@ full-palette-refuses
--@ drain

--@ chunk 1
canvas{aspect=0.8, ground={{apply="knife", pile={{"lead white", 10}, {"yellow ochre", 0.4}, {"raw umber", 0.15}}, texture=0.25, um=120}}, linen={18, 15}, seed=4417, size=480}

--@ chunk 2
rock = pile{{"raw umber",2},{"Prussian blue",0.6},{"bone black",0.5},{"red earth",0.5}, name="rock"}
crevice = pile{{"bone black",1},{"Prussian blue",0.4},{"raw umber",1}, name="crevice"}
woods = pile{{"raw umber",2},{"red earth",1},{"Prussian blue",0.4},{"yellow ochre",0.5}, name="woods_dark"}
fallgray = pile{{"lead white",3},{"cobalt blue",0.3},{"raw umber",0.4},{"yellow ochre",0.15}, name="fallgray"}
fallwhite = pile{{"lead white",8},{"yellow ochre",0.25},{"cobalt blue",0.08}, name="fallwhite"}
glow = pile{{"lead white",5},{"chrome yellow",1.2},{"yellow ochre",0.8}, name="glow"}
lipglass = pile{{"lead white",4},{"chrome yellow",0.5},{"yellow ochre",0.6},{"raw umber",0.2}, name="lipglass"}
-- mimic: rock base, then solid gray curtain over it, blended, on both halves
work(rect(0,0,1000,600), {hand="body", coverage=3, fill=true, length={20,50}, angle=1.45, piles={{rock,1},{woods,0.4},{crevice,0.3}}})
work(rect(80,80,330,420), {hand="body", pile=fallgray, tool={kind="flat", width=12}, coverage=2.5, fill=true, angle=math.pi/2, length={60,120}, clip=true})
work(rect(580,80,330,420), {hand="body", pile=fallgray, tool={kind="flat", width=12}, coverage=2.5, fill=true, angle=math.pi/2, length={60,120}, clip=true})
blend(rect(60,60,370,460):soften(6), {angle=math.pi/2})
blend(rect(560,60,370,460):soften(6), {angle=math.pi/2})
-- A (left): rock over the curtain, dark again
work(rect(70,70,350,440), {hand="body", coverage=3, fill=true, length={20,50}, angle=1.5, piles={{rock,1},{crevice,0.5}}, load=0.9})
-- B (right): dipped rag lift then rock
local r = rag{width=40}
r:dip(0.9)
r:wipe(rect(570,70,350,440), {pressure=0.8, angle=math.pi/2, passes=2, refold=0.5})
work(rect(570,70,350,440), {hand="body", coverage=3, fill=true, length={20,50}, angle=1.5, piles={{rock,1},{crevice,0.5}}, load=0.9})

--@ chunk 3
function falls_strands(o)
  -- o: lipL, lipR, ytop, ybot, spread, nstr, seedoff, litside (x of brightest)
  local fl = brush{kind="flat", width=8, stiffness=0.6}
  -- 1. glassy lip
  local lipm = mask(function(x, y)
    local t = (x - o.lipL) / (o.lipR - o.lipL)
    if t < 0 or t > 1 then return 0 end
    local top = o.ytop + 5 * (2*t - 1)^2
    return (y > top and y < top + 16) and 1 or 0 end):soften(2)
  work(lipm, {hand="body", tool={kind="flat", width=8}, length={10,25}, angle=0.05, coverage=2.5, fill=true, clip=true, piles={{lipglass,1},{glow,0.4}}})
  -- 2. strands
  for i = 1, o.nstr do
    local t = rand(0, 1)
    local x0 = lerp(o.lipL + 4, o.lipR - 4, t)
    local w = rand(4, 13)
    local lit = clamp(1 - math.abs(x0 - o.litx) / (o.lipR - o.lipL), 0, 1)
    local b = clamp(lit * 0.7 + rand(-0.2, 0.4), 0, 1)
    local p = (b > 0.55) and fallwhite or fallgray
    local len = (o.ybot - o.ytop) * rand(0.45, 1.05)
    local drift = (t - 0.5) * o.spread
    local y0 = o.ytop + rand(4, 12)
    local pts = {}
    for k = 0, 6 do
      local f = k / 6
      pts[#pts+1] = {x0 + drift * f * f + rand(-1, 1), y0 + len * f}
    end
    local b2 = brush{kind="flat", width=w, stiffness=0.6}
    b2:reload(p, rand(0.25, 0.45))
    b2:stroke(pts, {pressure={rand(0.4, 0.65), 0.05}, orient="across", ramps={0.02, 0.6}})
  end
end
falls_strands{lipL=100, lipR=390, ytop=95, ybot=480, spread=40, nstr=34, litx=150}

--@ chunk 4
-- A: blend the noodles vertically twice
blend(rect(85,110,320,380):soften(10), {angle=math.pi/2})
blend(rect(85,110,320,380):soften(10), {angle=math.pi/2})
-- B1: fan drags, x 590-690
local fan = brush{kind="fan", width=26, stiffness=0.5}
for i = 1, 16 do
  if i % 3 == 1 then fan:reload(i % 2 == 0 and fallgray or fallwhite, 0.3) end
  local x = rand(600, 680)
  fan:stroke({{x, 100}, {x + rand(-2,2), 250}, {x + rand(-5,5), rand(380,480)}}, {pressure={0.5, 0.1}, orient="across", ramps={0.02, 0.6}})
end
-- B2: thinned white, flat 12, x 700-800, 3 passes
thinwhite = pile{{"lead white",8},{"yellow ochre",0.2},{"cobalt blue",0.1}, thinner=0.5, name="thinwhite"}
local fb = brush{kind="flat", width=12, stiffness=0.5}
for pass = 1, 3 do
  for x = 705, 795, 9 do
    if (x // 9) % 2 == 0 then fb:reload(thinwhite, 0.6) end
    local xs = x + rand(-3, 3)
    fb:stroke({{xs, 100}, {xs + rand(-2,2), 250}, {xs + rand(-4,4), rand(300 + pass*40, 480)}}, {pressure={0.5, 0.2}, orient="across"})
  end
end
-- B3: wiped streaks: white thin film then rag drawn down, x 810-900
work(rect(810, 100, 90, 380), {hand="body", pile=fallgray, tool={kind="flat", width=12}, coverage=1.5, angle=math.pi/2, length={80,160}, clip=true})
local r = rag{width=14}
for i = 1, 6 do
  local x = rand(815, 895)
  r:wipe({{x, 100}, {x + rand(-2,2), 300}, {x + rand(-3,3), 480}}, {pressure={0.4, 0.6}})
end

--@ chunk 5
work(rect(0,620,1000,630), {hand="body", coverage=3, fill=true, length={20,50}, angle=1.45, piles={{rock,1},{woods,0.4},{crevice,0.3}}})
work(rect(100,640,400,560), {hand="body", pile=fallgray, tool={kind="flat", width=12}, coverage=2.5, fill=true, angle=math.pi/2, length={60,120}, clip=true})
work(rect(80,630,440,580), {hand="body", coverage=3, fill=true, length={20,50}, angle=1.5, piles={{rock,1},{crevice,0.5}}, load=0.9})
-- combined falls: lip 160..420 at y 700, drop to 1150
local L, R, Y0, Y1 = 160, 420, 700, 1150
local lipm = mask(function(x, y)
  local t = (x - L) / (R - L)
  if t < 0 or t > 1 then return 0 end
  local top = Y0 + 5 * (2*t - 1)^2
  return (y > top and y < top + 16) and 1 or 0 end):soften(2)
work(lipm, {hand="body", tool={kind="flat", width=8}, length={10,25}, angle=0.05, coverage=2.5, fill=true, clip=true, piles={{lipglass,1},{glow,0.4}}})
-- 1 thin veil
local fb = brush{kind="flat", width=12, stiffness=0.5}
for pass = 1, 3 do
  for x = L, R, 9 do
    if (x // 9) % 2 == 0 then fb:reload(thinwhite, 0.6) end
    local xs = x + rand(-3, 3)
    local t = (xs - L) / (R - L)
    local drift = (t - 0.5) * 50
    fb:stroke({{xs, Y0 + 8}, {xs + drift*0.1, Y0 + 120}, {xs + drift*0.5 + rand(-4,4), Y0 + rand(250, 450)}}, {pressure={0.5, 0.2}, orient="across"})
  end
end
-- 2 fan drags on the lit (left) part and some on right
local fan = brush{kind="fan", width=24, stiffness=0.5}
for i = 1, 22 do
  if i % 3 == 1 then fan:reload(i % 4 == 0 and fallgray or fallwhite, 0.3) end
  local t = math.min(1, math.abs(randn(0.3, 0.3)))
  local x = lerp(L + 8, R - 8, t)
  local drift = (t - 0.5) * 50
  fan:stroke({{x, Y0 + 6}, {x + drift*0.1 + rand(-2,2), Y0 + 140}, {x + drift*0.5 + rand(-5,5), Y0 + rand(220,440)}}, {pressure={0.55, 0.1}, orient="across", ramps={0.02, 0.6}})
end
-- 3 one light vertical blend
blend(rect(L - 25, Y0 + 18, R - L + 50, Y1 - Y0 - 10):soften(15), {angle=math.pi/2})

--@ chunk 6
local L, R, Y0 = 160, 420, 700
local fan = brush{kind="fan", width=20, stiffness=0.5}
for i = 1, 9 do
  if i % 3 == 1 then fan:reload(fallwhite, 0.35) end
  local t = math.min(1, math.abs(randn(0.25, 0.25)))
  local x = lerp(L + 8, R - 8, t)
  local drift = (t - 0.5) * 50
  fan:stroke({{x, Y0 + 10}, {x + drift*0.1 + rand(-2,2), Y0 + 100}, {x + drift*0.4 + rand(-5,5), Y0 + rand(160,300)}}, {pressure={0.4, 0.05}, orient="across", ramps={0.02, 0.7}})
end
local rd = brush{kind="round", width=4, point=0.7}
for i = 1, 7 do
  rd:reload(fallwhite, 0.6)
  local x = lerp(L + 10, R - 10, math.min(1, math.abs(randn(0.3, 0.3))))
  rd:gesture({{x, Y0 + 8, 0.3}, {x + rand(-1,1), Y0 + 40, 0.6}, {x + rand(-2,2), Y0 + rand(90, 160), 0.0}}, {wobble=1})
end
-- soften the lip: drag down out of it
local fl = brush{kind="flat", width=10}
for x = L, R, 12 do
  fl:wipe(0.9)
  fl:stroke({{x, Y0 - 2}, {x, Y0 + 30}}, {pressure=0.3, orient="across"})
end

--@ chunk 7
rocklite = pile{{"lead white",2},{"raw umber",1.5},{"smalt",1},{"red earth",0.3},{"cobalt blue",0.2}, name="rocklite"}
rockwarm = pile{{"lead white",1.5},{"yellow ochre",1},{"red earth",0.8},{"raw umber",1}, name="rockwarm"}
rockmid = pile{{"lead white",1},{"raw umber",2},{"smalt",0.5},{"yellow ochre",0.5},{"bone black",0.2}, name="rockmid"}
-- dry brush planes: flat 14, low load, light pressure, short strokes following plane directions
local fb = brush{kind="flat", width=14, stiffness=0.7}
local planes = {
  {cx=650, cy=700, a=0.25, n=8}, {cx=720, cy=760, a=1.3, n=7}, {cx=800, cy=700, a=-0.3, n=8},
}
for _, pl in ipairs(planes) do
  for i = 1, pl.n do
    fb:reload(rocklite, 0.15)
    local x = pl.cx + rand(-30, 30); local y = pl.cy + rand(-20, 20)
    fb:stroke({{x, y}, {x + 30*math.cos(pl.a), y + 30*math.sin(pl.a)}}, {pressure=0.2, orient="across"})
  end
end
-- same with load .3 pressure .35
for _, pl in ipairs({{cx=650, cy=900, a=0.25, n=8}, {cx=720, cy=960, a=1.3, n=7}, {cx=800, cy=900, a=-0.3, n=8}}) do
  for i = 1, pl.n do
    fb:reload(rockwarm, 0.3)
    local x = pl.cx + rand(-30, 30); local y = pl.cy + rand(-20, 20)
    fb:stroke({{x, y}, {x + 30*math.cos(pl.a), y + 30*math.sin(pl.a)}}, {pressure=0.35, orient="across"})
  end
end
-- knife very light, angle along the plane, low load
local k = knife{width=22}
for i = 1, 6 do
  k:load(rocklite, 0.25)
  local x, y = 880 + rand(-40, 40), 1100 + rand(-50, 50)
  k:lay({{x, y}, {x + 35, y + 10}}, {pressure={0.9, 0.95}})
end
for i = 1, 6 do
  k:load(rockmid, 0.25)
  local x, y = 660 + rand(-40, 40), 1100 + rand(-50, 50)
  k:lay({{x, y}, {x + 10, y + 35}}, {pressure={0.9, 0.95}})
end
