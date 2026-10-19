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
glow = pile{{"lead white",5},{"chrome yellow",1.2},{"yellow ochre",0.8}, name="glow"}
amber = pile{{"yellow ochre",3},{"red earth",1},{"lead white",1}, name="amber"}
deeprust = pile{{"red earth",3},{"raw umber",2},{"yellow ochre",1}, name="deeprust"}
haze = pile{{"lead white",4},{"yellow ochre",1},{"red earth",0.3},{"smalt",0.6}, name="haze"}
leafgold = pile{{"chrome yellow",2},{"yellow ochre",1},{"lead white",0.4}, name="leafgold"}
leafrust = pile{{"red earth",2},{"vermilion",0.6},{"yellow ochre",1.2}, name="leafrust"}
leafdeep = pile{{"red earth",2},{"raw umber",1.5},{"vermilion",0.2},{"Prussian blue",0.1}, name="leafdeep"}
woods = pile{{"raw umber",2},{"red earth",1},{"Prussian blue",0.4},{"yellow ochre",0.5}, name="woods_dark"}
work(rect(0,0,1000,1250), {hand="broad", coverage=3, fill=true, angle=0.3, piles={{glow, function(x,y) return 1 - x/1000 end},{amber, 0.5},{deeprust, function(x,y) return x/1000 end}}})
local n1 = noise{seed=81, period=80, octaves=4, persistence=0.55}
blob = mask(function(x,y) local e = smoothstep(150, 400, x) * (1 - smoothstep(250, 450, y)); return clamp((n1:at01(x,y) + e - 1) * 4, 0, 1) end)
work(blob, {hand="body", tool={kind="filbert", width=10, stiffness=0.5}, length={8,22}, angle=function(x,y) return 1.2*math.sin(x/31 + y/23) end, coverage=2, edge="loose", piles={{leafdeep,0.6},{deeprust,0.6}}})
blend(blob:grow(14):soften(10), {angle=0.7})

--@ chunk 3
-- Trial region: left half x<500 (approach A), right half x>500 (approach B)
local nH = noise{seed=91, period=28, octaves=2}
local edge = blob:grow(14) - blob:shrink(25)
-- A: holes of background color punched in, dabs of leaves
local holes = (blob:grow(10)) * mask(function(x,y) return x < 500 and clamp((nH:at01(x,y) - 0.62) * 6, 0, 1) or 0 end)
work(holes, {hand="body", tool={kind="round", width=7, stiffness=0.5}, length={4,10}, angle=function(x,y) return rand(0,3.14) end, coverage=2,
  piles={{glow, function(x,y) return 1 - x/1000 end},{amber, 0.5},{deeprust, function(x,y) return x/1000 end}}})
-- leaf dabs: short drooping filbert strokes in clumps
local nC = noise{seed=92, period=40, octaves=3}
local clumps = blob:grow(8) * mask(function(x,y) return x < 500 and clamp((nC:at01(x,y) - 0.45) * 4, 0, 1) or 0 end)
work(clumps, {hand="body", tool={kind="filbert", width=6, stiffness=0.5}, length={5,10}, angle=function(x,y) return 1.57 + rand(-0.9,0.9) end, coverage=0.9, pile=leafrust})
local tops = blob:grow(8) * mask(function(x,y) return x < 500 and clamp((nC:at01(x,y+10) - 0.5) * 4, 0, 1) * clamp((nC:at01(x,y) - 0.45)*4,0,1) or 0 end)
work(tops, {hand="body", tool={kind="filbert", width=5, stiffness=0.5}, length={4,8}, angle=function(x,y) return 1.57 + rand(-0.9,0.9) end, coverage=0.7, pile=leafgold})
-- B: fan brush taps, corner loaded
local fan = brush{kind="fan", width=18, stiffness=0.5}
for i = 1, 140 do
  local x, y = rand(500, 1000), rand(0, 460)
  if blob:at(x, y) > 0.3 or (blob:grow(12):at(x,y) > 0.3 and rand() < 0.5) then
    if i % 6 == 1 then fan:reload(rand() < 0.5 and leafrust or leafdeep, 0.5) end
    fan:touch(x, y, {pressure=rand(0.3, 0.6), drag={rand(-3,3), rand(3,8)}, angle=rand(-0.5,0.5), twist=rand(-0.3,0.3)})
  end
end
for i = 1, 120 do
  local x, y = rand(500, 1000), rand(0, 460)
  if blob:at(x, y) > 0.3 and nC:at01(x, y+10) > 0.5 then
    if i % 6 == 1 then fan:reload(leafgold, 0.45) end
    fan:touch(x, y, {pressure=rand(0.25, 0.5), drag={rand(-3,3), rand(2,6)}, angle=rand(-0.5,0.5)})
  end
end

--@ chunk 4
work(rect(0,600,1000,650), {hand="broad", coverage=3, fill=true, angle=0.3, piles={{glow, function(x,y) return 1 - x/1000 end},{amber, 0.5},{deeprust, function(x,y) return x/1000 end}}})
local n1 = noise{seed=81, period=80, octaves=4, persistence=0.55}
blob2 = mask(function(x,y) local e = smoothstep(150, 400, x) * (1 - smoothstep(850, 1050, y)) * smoothstep(620, 700, y); return clamp((n1:at01(x,y) + e - 1) * 4, 0, 1) end)
work(blob2, {hand="body", tool={kind="filbert", width=10, stiffness=0.5}, length={8,22}, angle=function(x,y) return 1.2*math.sin(x/31 + y/23) end, coverage=2, edge="loose", piles={{leafdeep,0.6},{deeprust,0.6}}})
blend(blob2:grow(14):soften(10), {angle=0.7})
local hn = noise{seed=93, period=45, octaves=3}
local LX, LY = 100, 700
function shade(x, y)
  local e = 3
  local dx = (hn(x+e, y) - hn(x-e, y)) / (2*e)
  local dy = (hn(x, y+e) - hn(x, y-e)) / (2*e)
  local lx, ly = LX - x, LY - y - 200
  local l = math.sqrt(lx*lx + ly*ly)
  lx, ly = lx/l, ly/l
  return clamp(0.5 + 25 * (dx*lx + dy*ly) + 0.3*hn(x,y), 0, 1)
end
local cm = blob2:grow(6)
work(cm, {hand="body", tool={kind="filbert", width=9, stiffness=0.5}, length={7,16}, angle=function(x,y) return 1.57 + 0.8*math.sin(x/13 + y/7) end, coverage=1.6, edge="loose",
  piles={{leafdeep, function(x,y) return clamp(1 - shade(x,y)*2.2, 0, 1) end},
         {leafrust, function(x,y) local s = shade(x,y); return math.exp(-((s-0.5)/0.18)^2) end},
         {amber, function(x,y) local s = shade(x,y); return math.exp(-((s-0.7)/0.12)^2) * 0.8 end},
         {leafgold, function(x,y) return clamp((shade(x,y) - 0.72) * 4, 0, 1) end}}})

--@ chunk 5
work(rect(0,0,1000,600), {hand="broad", coverage=3, fill=true, angle=0.3, piles={{glow, function(x,y) return 1 - x/1000 end},{amber, 0.5},{deeprust, function(x,y) return x/1000 end}}})
local n1 = noise{seed=88, period=90, octaves=4, persistence=0.55}
blob3 = mask(function(x,y) local e = smoothstep(150, 400, x) * (1 - smoothstep(380, 520, y)); return clamp((n1:at01(x,y) + e - 1) * 4, 0, 1) end)
work(blob3, {hand="body", tool={kind="filbert", width=10, stiffness=0.5}, length={8,22}, angle=function(x,y) return 1.2*math.sin(x/31 + y/23) end, coverage=2, edge="loose", piles={{leafdeep,0.6},{deeprust,0.6}}})
blend(blob3:grow(14):soften(10), {angle=0.7})
local hn = noise{seed=94, period=110, octaves=3, persistence=0.45}
local LX, LY = 0, 300
function shade2(x, y)
  local e = 4
  local dx = (hn(x+e, y) - hn(x-e, y)) / (2*e)
  local dy = (hn(x, y+e) - hn(x, y-e)) / (2*e)
  local lx, ly = LX - x, LY - y - 250
  local l = math.sqrt(lx*lx + ly*ly)
  lx, ly = lx/l, ly/l
  local near = clamp(1 - (x - 150)/700, 0, 1)
  return clamp(0.35 + 45 * (dx*lx + dy*ly) + 0.25*near + 0.15*hn(x,y), 0, 1)
end
golden = mix{{leafgold, 0.6}, {amber, 0.4}, name="golden"}
local cm = blob3:grow(6)
work(cm, {hand="body", tool={kind="filbert", width=9, stiffness=0.5}, length={7,16}, angle=function(x,y) return 1.57 + 0.8*math.sin(x/13 + y/7) end, coverage=1.3, edge="loose",
  piles={{leafdeep, function(x,y) return clamp(1 - shade2(x,y)*2.5, 0, 1) end},
         {leafrust, function(x,y) local s = shade2(x,y); return math.exp(-((s-0.5)/0.15)^2) end},
         {amber, function(x,y) local s = shade2(x,y); return math.exp(-((s-0.68)/0.1)^2) * 0.8 end},
         {golden, function(x,y) return clamp((shade2(x,y) - 0.72) * 4, 0, 1) end}}})
-- right half: light blend afterwards
blend((blob3:grow(10) * rect(600, 0, 400, 600)):soften(8), {angle=1.2})
