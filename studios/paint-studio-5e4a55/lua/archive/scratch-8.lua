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
amber = pile{{"yellow ochre",3},{"red earth",1},{"lead white",1}, name="amber"}
deeprust = pile{{"red earth",3},{"raw umber",2},{"yellow ochre",1}, name="deeprust"}
haze = pile{{"lead white",4},{"yellow ochre",1},{"red earth",0.3},{"smalt",0.6}, name="haze"}
glow = pile{{"lead white",5},{"chrome yellow",1.2},{"yellow ochre",0.8}, name="glow"}
leafgold = pile{{"chrome yellow",2},{"yellow ochre",1.5},{"lead white",0.4}, name="leafgold"}
leafrust = pile{{"red earth",2},{"vermilion",0.6},{"yellow ochre",1.2}, name="leafrust"}
woods = pile{{"raw umber",2},{"red earth",1},{"Prussian blue",0.4},{"yellow ochre",0.5}, name="woods_dark"}
brushdark = pile{{"raw umber",2},{"red earth",1.5},{"Prussian blue",0.3},{"yellow ochre",0.4}, name="brushdark"}
work(rect(0,0,1000,600), {hand="broad", coverage=3, fill=true, angle=0.3, piles={{haze, 1},{amber, 0.6}}})
local n1 = noise{seed=81, period=80, octaves=4}
blob = mask(function(x,y) local e = (1 - smoothstep(250, 420, y)); return clamp((n1:at01(x,y) + e - 1) * 4, 0, 1) end)
work(blob, {hand="body", tool={kind="filbert", width=9}, length={7,16}, coverage=2, edge="loose", angle=function(x,y) return 1.57 + 0.8*math.sin(x/13+y/7) end,
  piles={{deeprust, 1}, {amber, function(x,y) return n1:at01(x+50,y) end}, {brushdark, function(x,y) return clamp(y/400, 0, 1) end}}})
blend(blob:grow(14):soften(10), {angle=0.9})
blend(blob:grow(14):soften(10), {angle=2.3})
wait(20*60)
print(drying(300, 150))

--@ chunk 3
-- A (x<330): filbert 5 short drooping strokes, lay 3
local fA = brush{kind="filbert", width=5, stiffness=0.5, lay=3}
for i = 1, 160 do
  local x, y = rand(20, 320), rand(20, 400)
  if blob:at(x, y) > 0.2 then
    if i % 8 == 1 then fA:reload((y < 200) and leafgold or leafrust, 0.7) end
    local a = 1.57 + rand(-0.8, 0.8)
    fA:stroke({{x, y}, {x + 6*math.cos(a), y + 6*math.sin(a)}}, {pressure=rand(0.3, 0.6)})
  end
end
-- B (330-660): round 5 touches with drag, lay 3
local rB = brush{kind="round", width=6, stiffness=0.5, lay=3}
for i = 1, 160 do
  local x, y = rand(340, 650), rand(20, 400)
  if blob:at(x, y) > 0.2 then
    if i % 8 == 1 then rB:reload((y < 200) and leafgold or leafrust, 0.7) end
    rB:touch(x, y, {pressure=rand(0.3, 0.6), drag={rand(-2,2), rand(2,5)}, twist=rand(-0.5,0.5)})
  end
end
-- C (>660): stipple w7 with dips, lay default
local mC = blob * rect(670, 0, 330, 420) * mask(function(x,y) return y < 200 and 1 or 0.4 end)
stipple(mC, {pile=leafgold, width=7, coverage=0.5, cluster={0.6, 15}, feather=0.5, drag={3, 1.3}, pressure={0.3, 0.6}, dips={10, 0.8, 0.5}})
stipple(blob * rect(670, 150, 330, 270), {pile=leafrust, width=7, coverage=0.4, cluster={0.6, 15}, feather=0.5, drag={3, 1.3}, pressure={0.3, 0.6}, dips={10, 0.8, 0.5}})

--@ chunk 4
work(rect(0,450,1000,600), {hand="broad", coverage=3, fill=true, angle=0.3, piles={{haze, 1},{amber, 0.6}}})
local n1 = noise{seed=82, period=80, octaves=4}
blob2 = mask(function(x,y) local e = smoothstep(450, 520, y) * (1 - smoothstep(800, 950, y)); return clamp((n1:at01(x,y) + e - 1) * 4, 0, 1) end)
work(blob2, {hand="body", tool={kind="filbert", width=9}, length={7,16}, coverage=2, edge="loose", angle=function(x,y) return 1.57 + 0.8*math.sin(x/13+y/7) end,
  piles={{deeprust, 1}, {amber, function(x,y) return n1:at01(x+50,y) end}, {brushdark, function(x,y) return clamp((y-500)/400, 0, 1) end}}})
blend(blob2:grow(14):soften(10), {angle=0.9})
wait(20*60)
-- clumps: list of centers, each clump: dark underside crescent, lit top crescent
local fb = brush{kind="filbert", width=12, stiffness=0.5, lay=2}
local fs = brush{kind="filbert", width=7, stiffness=0.5, lay=2}
local clumps = {}
for i = 1, 26 do
  local x, y = rand(30, 970), rand(520, 880)
  if blob2:at(x, y) > 0.5 then clumps[#clumps+1] = {x, y, rand(22, 40)} end
end
for _, c in ipairs(clumps) do
  local cx, cy, r = c[1], c[2], c[3]
  -- shadow underside
  fb:reload(brushdark, 0.5)
  for k = 1, 3 do
    local a0 = rand(0.3, 0.6)
    local pts = {}
    for j = 0, 4 do local a = a0 + (math.pi - 2*a0) * j/4; pts[#pts+1] = {cx + r*0.8*math.cos(a), cy + r*0.55*math.sin(a) + rand(-2,2)} end
    fb:stroke(pts, {pressure=rand(0.4, 0.6)})
  end
  -- lit top
  fs:reload(c[2] < 700 and leafgold or amber, 0.6)
  for k = 1, 4 do
    local a0 = rand(-2.8, -2.2)
    local pts = {}
    for j = 0, 3 do local a = a0 + rand(1.2, 1.8) * j/3; pts[#pts+1] = {cx + r*0.7*math.cos(a) + rand(-3,3), cy + r*0.5*math.sin(a) + rand(-2,2)} end
    fs:stroke(pts, {pressure=rand(0.3, 0.6)})
  end
  -- mid rust
  fs:reload(leafrust, 0.5)
  for k = 1, 3 do
    local x, y = cx + rand(-r*0.5, r*0.5), cy + rand(-r*0.2, r*0.3)
    fs:stroke({{x, y}, {x + rand(-6,6), y + rand(3,8)}}, {pressure=rand(0.3, 0.5)})
  end
end

--@ chunk 5
rock = pile{{"raw umber",2},{"Prussian blue",0.6},{"bone black",0.5},{"red earth",0.5}, name="rock"}
lent = pile{{"bone black",1},{"raw umber",1.2}, name="lenticel"}
rockgray = mix{{rock, 0.5}, {haze, 0.5}, name="rockgray"}
rockhi = pile{{"lead white",3},{"yellow ochre",1},{"red earth",0.3},{"raw umber",0.6},{"smalt",0.3}, name="rockhi"}
mossdark = pile{{"green earth",2},{"raw umber",1},{"Prussian blue",0.2},{"yellow ochre",1}, name="mossdark"}
work(rect(0,950,1000,300), {hand="body", coverage=3, fill=true, length={20,50}, angle=1.45, piles={{rock,1},{woods,0.4},{lent,0.3}}})
-- knife highlights: short angled pulls defining block tops, low load, firm pressure
local k = knife{width=26}
local blocks = {{60,990},{150,1000},{250,985},{340,1010},{120,1080},{230,1090},{330,1070},{80,1160},{200,1170},{320,1150}}
for i, b in ipairs(blocks) do
  k:load(i % 3 == 0 and rockgray or rockhi, 0.3)
  -- top plane: a short near-horizontal pull, then down the lit side
  k:lay({{b[1], b[2]}, {b[1] + 45, b[2] - 4}}, {pressure={0.75, 0.9}, angle=math.pi/2 - 0.3})
  k:load(rockgray, 0.25)
  k:lay({{b[1] + 2, b[2] + 4}, {b[1] - 3, b[2] + 40}}, {pressure={0.8, 0.95}, angle=0.2})
end
-- right half: same with load .5 and pressure .5
for i, b in ipairs(blocks) do
  local bx = b[1] + 500
  k:load(i % 3 == 0 and rockgray or rockhi, 0.5)
  k:lay({{bx, b[2]}, {bx + 45, b[2] - 4}}, {pressure={0.5, 0.6}, angle=math.pi/2 - 0.3})
  k:load(rockgray, 0.4)
  k:lay({{bx + 2, b[2] + 4}, {bx - 3, b[2] + 40}}, {pressure={0.55, 0.7}, angle=0.2})
end
