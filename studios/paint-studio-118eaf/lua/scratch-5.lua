-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"lead white", 10}, {"bone black", 0.2}}, texture=0.3, um=120}, {apply="brush", pile={{"lead white", 6}, {"red earth", 1.2}, {"raw umber", 1}, {"yellow ochre", 0.6}}, texture=0.5, um=40}}, linen={16, 14}, seed=4471, size=900}

--@ chunk 2
sk_apricot = pile{{"lead white", 2}, {"orange chrome", 0.8}, {"vermilion", 0.25}, {"yellow ochre", 0.3}}
sk_rose = pile{{"lead white", 2}, {"vermilion", 0.35}, {"rose madder", 0.3}, {"raw umber", 0.12}, {"Naples yellow", 0.3}}
sk_gold = pile{{"lead white", 3}, {"Naples yellow", 1.5}, {"orange chrome", 0.5}, {"yellow ochre", 0.3}}
work(rect(0,0,500,714), {hand="broad", piles={{sk_rose, function(x,y) return 1 - y/714 end}, {sk_apricot, function(x,y) return y/714 end}}, coverage=2, fill=true, clip=true})
work(rect(500,0,500,714), {hand="broad", pile=sk_gold, coverage=2, fill=true, clip=true})
wait(10*24*60)
print(drying(200,300), drying(700,300))

--@ chunk 3
fl_core = pile{{"lead white", 3}, {"lemon chrome", 0.6}, {"Naples yellow", 0.3}, name="fl_core"}
fl_yel = pile{{"cadmium yellow", 1}, {"lead white", 0.8}, {"lemon chrome", 0.3}, name="fl_yel"}
fl_org = pile{{"orange chrome", 1}, {"cadmium yellow", 0.4}, {"vermilion", 0.15}, name="fl_org"}
fl_red = pile{{"vermilion", 1}, {"orange chrome", 0.5}, name="fl_red"}
function flash(cx, cy, scale, seed)
  math.randomseed(seed or 1)
  local rb = brush{kind="round", width=7*scale, point=0.9, stiffness=0.5, lay=2}
  -- outer orange/red rays, fanning forward (angle 0 = right) wider spread
  local function ray(pile, ang, len, w0, load)
    rb:reload(pile, load or 0.8)
    local ex, ey = cx + math.cos(ang)*len, cy + math.sin(ang)*len
    local mx, my = cx + math.cos(ang)*len*0.45 + rand(-3,3), cy + math.sin(ang)*len*0.45 + rand(-3,3)
    rb:gesture({{cx + math.cos(ang)*4, cy + math.sin(ang)*4, w0}, {mx, my, w0*0.9}, {ex, ey, 0}}, {wobble=1})
  end
  for i = 1, 9 do ray(fl_red, rand(-0.9, 0.9), rand(40, 75)*scale, 0.8) end
  for i = 1, 9 do ray(fl_org, rand(-0.7, 0.7), rand(35, 65)*scale, 0.85) end
  for i = 1, 5 do ray(fl_org, rand(-2.0, 2.0), rand(14, 26)*scale, 0.7) end
  for i = 1, 8 do ray(fl_yel, rand(-0.5, 0.5), rand(25, 45)*scale, 0.9) end
  local cb = brush{kind="round", width=10*scale, stiffness=0.6, lay=4}
  cb:reload(fl_core, 1)
  cb:touch(cx + 6*scale, cy, {pressure=0.9, drag={8*scale, 0}})
  cb:reload(fl_core, 1)
  cb:touch(cx + 10*scale, cy, {pressure=0.7, drag={12*scale, rand(-1,1)}})
end
flash(150, 300, 1.0, 3)
flash(650, 300, 1.0, 4)

--@ chunk 4
fl_glow = pile{{"lead white", 3}, {"lemon chrome", 0.5}, {"Naples yellow", 0.4}, thinner=0.5, name="fl_glow"}
fl_white = pile{{"lead white", 4}, {"lemon chrome", 0.25}, name="fl_white"}
fl_pale = pile{{"lead white", 2}, {"cadmium yellow", 0.6}, {"lemon chrome", 0.3}, name="fl_pale"}
fl_tip = pile{{"lead white", 1}, {"orange chrome", 0.7}, {"cadmium yellow", 0.4}, name="fl_tip"}
function flash2(cx, cy, s, seed)
  math.randomseed(seed or 1)
  -- halo: a soft glow scumbled around the muzzle, elongated forward
  local halo = ellipse(cx + 28*s, cy, 55*s, 34*s):soften(12*s)
  stipple(halo, {pile=fl_glow, width=6*s, coverage=function(x,y) local d = math.sqrt(((x-cx-20*s)/1.6)^2 + (y-cy)^2) return clamp(1.6 - d/(28*s), 0, 1.6) end, feather=1, pressure={0.3,0.6}})
  local rb = brush{kind="round", width=6*s, point=0.9, stiffness=0.5, lay=2}
  local function ray(pile, ang, len, w0, load)
    rb:reload(pile, load or 0.8)
    local ex, ey = cx + math.cos(ang)*len, cy + math.sin(ang)*len
    local mx, my = cx + math.cos(ang)*len*0.4, cy + math.sin(ang)*len*0.4
    rb:gesture({{cx + math.cos(ang)*3, cy + math.sin(ang)*3, w0}, {mx, my, w0*0.85}, {ex, ey, 0}}, {wobble=0.6})
  end
  for i = 1, 4 do ray(fl_tip, rand(-0.5, 0.5), rand(45, 70)*s, 0.5, 0.5) end
  for i = 1, 10 do ray(fl_pale, rand(-0.55, 0.55), rand(30, 60)*s, 0.8) end
  ray(fl_pale, -1.6 + rand(-0.2,0.2), 14*s, 0.6) ray(fl_pale, 1.6 + rand(-0.2,0.2), 14*s, 0.6)
  for i = 1, 6 do ray(fl_white, rand(-0.3, 0.3), rand(25, 42)*s, 0.9) end
  local cb = brush{kind="round", width=11*s, stiffness=0.6, lay=5}
  cb:reload(fl_white, 1)
  cb:touch(cx + 7*s, cy, {pressure=0.95, drag={10*s, 0}})
  cb:reload(fl_white, 1)
  cb:touch(cx + 14*s, cy, {pressure=0.7, drag={14*s, 0}})
end
flash2(150, 500, 1.0, 5)
flash2(650, 500, 1.0, 6)

--@ chunk 5
smoke_p = pile{{"lead white", 2}, {"ultramarine blue", 0.25}, {"raw umber", 0.25}, {"rose madder", 0.12}, thinner=0.55, name="smoke"}
smoke_dk = pile{{"lead white", 1}, {"ultramarine blue", 0.3}, {"raw umber", 0.35}, {"rose madder", 0.1}, thinner=0.55, name="smoke_dk"}
glow2 = pile{{"lead white", 3}, {"lemon chrome", 0.5}, {"Naples yellow", 0.4}, thinner=0.6, name="glow2"}
function smoke_puffs(cx, cy, s, seed)
  math.randomseed(seed)
  local m = nil
  for i = 1, 7 do
    local e = ellipse(cx + rand(-10, 60)*s, cy + rand(-20, 12)*s, rand(14, 26)*s, rand(10, 18)*s)
    m = m and (m + e) or e
  end
  m = m:roughen(4*s, 20*s, seed):soften(5*s)
  work(m, {hand="scumble", pile=smoke_p, tool={kind="filbert", width=8*s, stiffness=0.3}, coverage=1.5, angle=function(x,y) return math.atan(y-cy, x-cx) + 1.57 end, seed=seed})
  local m2 = m * ellipse(cx + 10*s, cy + 14*s, 50*s, 18*s):soften(8*s)
  work(m2, {hand="scumble", pile=smoke_dk, tool={kind="filbert", width=6*s, stiffness=0.3}, coverage=1.0, seed=seed+1})
  blend(m:grow(4*s), {angle=0.3})
  return m
end
local m1 = smoke_puffs(170, 150, 1.2, 7)
local m2 = smoke_puffs(670, 150, 1.2, 8)
-- glow halo trial alone
local h = ellipse(400, 620, 40, 26):soften(14)
work(h, {hand="scumble", pile=glow2, tool={kind="filbert", width=8, stiffness=0.3}, coverage=2, seed=9})
blend(h:grow(10), {angle=0})

--@ chunk 6
smoke_p2 = pile{{"lead white", 1.5}, {"ultramarine blue", 0.3}, {"raw umber", 0.35}, {"rose madder", 0.15}, thinner=0.3, name="smoke2"}
smoke_warm = pile{{"lead white", 1.5}, {"orange chrome", 0.3}, {"raw umber", 0.2}, {"rose madder", 0.1}, thinner=0.3, name="smoke_warm"}
spark_p = pile{{"lead white", 1}, {"cadmium yellow", 0.6}, {"orange chrome", 0.3}, medium=0.4, name="spark"}
function flash3(cx, cy, s, seed)
  math.randomseed(seed or 1)
  -- smoke cloud first, bulging forward and up from the muzzle
  local m = nil
  for i = 1, 9 do
    local t = rand(0, 1)
    local e = ellipse(cx + (10 + 70*t)*s + rand(-8,8)*s, cy - (6 + 30*t)*s + rand(-10,10)*s, (14 + 12*t)*s, (11 + 9*t)*s)
    m = m and (m + e) or e
  end
  m = m:roughen(5*s, 22*s, seed):soften(3*s)
  work(m, {hand="scumble", tool={kind="filbert", width=9*s, stiffness=0.35},
    piles={{smoke_warm, function(x,y) return 1 - smoothstep(20*s, 55*s, math.sqrt((x-cx-15*s)^2 + (y-cy)^2)) end},
           {smoke_p2, function(x,y) return smoothstep(20*s, 55*s, math.sqrt((x-cx-15*s)^2 + (y-cy)^2)) end}},
    coverage=2, angle=function(x,y) return math.atan(y-cy, x-cx) + 1.57 end, seed=seed})
  blend(m:grow(3*s), {angle=-0.4})
  -- rays
  local rb = brush{kind="round", width=6*s, point=0.9, stiffness=0.5, lay=2}
  local function ray(pile, ang, len, w0, load)
    rb:reload(pile, load or 0.8)
    local ex, ey = cx + math.cos(ang)*len, cy + math.sin(ang)*len
    local mx, my = cx + math.cos(ang)*len*0.4, cy + math.sin(ang)*len*0.4
    rb:gesture({{cx + math.cos(ang)*3, cy + math.sin(ang)*3, w0}, {mx, my, w0*0.85}, {ex, ey, 0}}, {wobble=0.6})
  end
  for i = 1, 7 do ray(fl_red, rand(-0.8, 0.8), rand(45, 75)*s, 0.85) end
  for i = 1, 8 do ray(fl_org, rand(-0.6, 0.6), rand(38, 62)*s, 0.85) end
  ray(fl_org, -1.5 + rand(-0.2,0.2), 18*s, 0.7) ray(fl_org, 1.5 + rand(-0.2,0.2), 18*s, 0.7)
  for i = 1, 7 do ray(fl_yel, rand(-0.4, 0.4), rand(28, 46)*s, 0.9) end
  for i = 1, 4 do ray(fl_white, rand(-0.2, 0.2), rand(20, 32)*s, 0.95) end
  local cb = brush{kind="round", width=12*s, stiffness=0.6, lay=5}
  cb:reload(fl_white, 1)
  cb:touch(cx + 8*s, cy, {pressure=0.95, drag={10*s, 0}})
  -- sparks
  local sb = brush{kind="round", width=3, stiffness=0.4}
  sb:reload(spark_p, 0.9)
  sb:spatter{at={cx + 10*s, cy}, toward={70*s, -6*s}, spread=0.5, force=0.8}
  return m
end
flash3(250, 400, 1.0, 11)
flash3(750, 400, 1.0, 12)

--@ chunk 7
sm_out = pile{{"lead white", 1.5}, {"ultramarine blue", 0.25}, {"raw umber", 0.3}, {"rose madder", 0.15}, name="sm_out"}
sm_mid = pile{{"lead white", 1.5}, {"raw umber", 0.15}, {"rose madder", 0.12}, {"orange chrome", 0.25}, {"ultramarine blue", 0.08}, name="sm_mid"}
sm_in = pile{{"lead white", 2}, {"orange chrome", 0.6}, {"cadmium yellow", 0.3}, name="sm_in"}
function smoke_body(cx, cy, s, seed)
  math.randomseed(seed)
  local m = ellipse(cx + 22*s, cy - 2*s, 26*s, 18*s)
  for i = 1, 8 do
    local t = rand(0, 1)
    m = m + ellipse(cx + (20 + 75*t)*s + rand(-8,8)*s, cy - (4 + 34*t)*s + rand(-10,10)*s, (13 + 12*t)*s, (10 + 9*t)*s)
  end
  m = m:roughen(4*s, 18*s, seed):soften(2*s)
  local function d(x, y) return math.sqrt(((x-cx-14*s)/1.3)^2 + (y-cy)^2) end
  work(m, {hand="body", tool={kind="filbert", width=8*s, stiffness=0.35},
    piles={{sm_in,  function(x,y) return 1 - smoothstep(14*s, 34*s, d(x,y)) end},
           {sm_mid, function(x,y) local v = d(x,y) return smoothstep(14*s, 34*s, v) * (1 - smoothstep(40*s, 70*s, v)) end},
           {sm_out, function(x,y) return smoothstep(40*s, 70*s, d(x,y)) end}},
    coverage=2.2, fill=true, angle=function(x,y) return math.atan(y-cy, x-cx) + 1.57 end, curve={0.4, 0.2}, edge="soft", seed=seed})
  blend(m:shrink(2*s), {angle=-0.3})
  return m
end
sm1 = smoke_body(250, 600, 1.0, 21)
sm2 = smoke_body(750, 600, 1.0, 22)
wait(24*60)
print(drying(270, 600), drying(300, 580))

--@ chunk 8
wait(3*24*60)
print(drying(270, 600), drying(300, 580), drying(330,570))
function flame_core(cx, cy, s, seed)
  math.randomseed(seed or 1)
  local rb = brush{kind="round", width=7*s, point=0.85, stiffness=0.5, lay=2.5}
  local function ray(pile, ang, len, w0, load)
    rb:reload(pile, load or 0.8)
    local ex, ey = cx + math.cos(ang)*len, cy + math.sin(ang)*len
    local mx, my = cx + math.cos(ang)*len*0.35 + rand(-2,2)*s, cy + math.sin(ang)*len*0.35 + rand(-2,2)*s
    rb:gesture({{cx + math.cos(ang)*2, cy + math.sin(ang)*2, w0}, {mx, my, w0}, {ex, ey, 0}}, {wobble=1})
  end
  for i = 1, 5 do ray(fl_red, rand(-0.6, 0.6), rand(38, 55)*s, 0.8) end
  for i = 1, 6 do ray(fl_org, rand(-0.45, 0.45), rand(30, 46)*s, 0.9) end
  ray(fl_org, -1.4 + rand(-0.2,0.2), 14*s, 0.7) ray(fl_org, 1.4 + rand(-0.2,0.2), 14*s, 0.7)
  for i = 1, 5 do ray(fl_yel, rand(-0.3, 0.3), rand(22, 34)*s, 0.95) end
  local cb = brush{kind="filbert", width=12*s, stiffness=0.7, lay=6}
  cb:reload(fl_white, 1)
  cb:touch(cx + 9*s, cy, {pressure=0.95, drag={9*s, 0}})
  cb:reload(fl_white, 1)
  cb:touch(cx + 5*s, cy, {pressure=0.8, drag={6*s, 0}})
end
flame_core(250, 600, 1.0, 31)
flame_core(750, 600, 1.0, 32)

--@ chunk 9
fl_white_b = pile{{"lead white", 4}, {"lemon chrome", 0.3}, blot=0.25, name="fl_white_b"}
function flame2(cx, cy, s, seed)
  math.randomseed(seed or 1)
  -- 1. white-hot core: thick, blotted, an elongated blob just ahead of the muzzle
  local cb = brush{kind="filbert", width=10*s, stiffness=0.7, lay=6}
  cb:reload(fl_white_b, 1)
  cb:gesture({{cx + 3*s, cy, 0.7}, {cx + 12*s, cy - 0.5*s, 1.0}, {cx + 24*s, cy - 1*s, 0.6}, {cx + 30*s, cy - 1*s, 0.1}}, {wobble=0.5})
  -- 2. flame tongues from the core's edge outward
  local rb = brush{kind="round", width=6*s, point=0.85, stiffness=0.5, lay=2.5}
  local function tongue(pile, ang, r0, len, w0, bend)
    rb:reload(pile, 0.85)
    local x0, y0 = cx + 12*s + math.cos(ang)*r0, cy + math.sin(ang)*r0
    local a2 = ang + (bend or 0)
    local x1, y1 = x0 + math.cos(ang)*len*0.5, y0 + math.sin(ang)*len*0.5
    local x2, y2 = x1 + math.cos(a2)*len*0.5, y1 + math.sin(a2)*len*0.5
    rb:gesture({{x0, y0, w0}, {x1, y1, w0*0.9}, {x2, y2, 0}}, {wobble=1})
  end
  for i = 1, 6 do local a = rand(-0.9, 0.9) tongue(fl_org, a, 10*s, rand(22, 42)*s, 0.9, rand(-0.3, 0.3)) end
  tongue(fl_org, -1.7, 6*s, 16*s, 0.8, 0.4) tongue(fl_org, 1.7, 6*s, 16*s, 0.8, -0.4)
  for i = 1, 3 do local a = rand(-0.7, 0.7) tongue(fl_red, a, 22*s, rand(16, 26)*s, 0.6, rand(-0.3,0.3)) end
  for i = 1, 5 do local a = rand(-0.5, 0.5) tongue(fl_yel, a, 12*s, rand(16, 30)*s, 0.85, rand(-0.2, 0.2)) end
end
-- fresh smoke for this trial at a new spot, set it first
sm3 = smoke_body(250, 200, 1.3, 41)
wait(4*24*60)
flame2(250, 200, 1.3, 42)

--@ chunk 10
gd_hz = pile{{"raw umber", 1}, {"rose madder", 0.35}, {"ultramarine blue", 0.35}, {"lead white", 0.8}, {"orange chrome", 0.12}, name="gd_hz"}
gd_mid = pile{{"raw umber", 1.5}, {"burnt sienna", 0.5}, {"ultramarine blue", 0.6}, {"rose madder", 0.15}, {"lead white", 0.12}, name="gd_mid"}
gd_near = pile{{"raw umber", 1}, {"bone black", 0.6}, {"ultramarine blue", 0.6}, {"burnt sienna", 0.35}, name="gd_near"}
local band = rect(500, 420, 500, 294)
work(band, {hand="body", tool={kind="flat", width=14, stiffness=0.6},
  piles={{gd_hz, function(x,y) return 1 - smoothstep(440, 520, y) end},
         {gd_mid, function(x,y) return smoothstep(440, 520, y) * (1 - smoothstep(560, 650, y)) end},
         {gd_near, function(x,y) return smoothstep(560, 650, y) end}},
  angle=function(x,y) return 0.06*math.sin(x/70 + y/40) end, length={30, 90},
  scale_at=function(x,y) return 0.5 + 0.9*smoothstep(420, 714, y) end,
  coverage=1.6, fill=true, clip=true, mix_jitter=0.08, seed=1})
